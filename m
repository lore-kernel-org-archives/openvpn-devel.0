From: selva.nair@...277...
Date: Fri,  5 May 2017 14:24:02 -0400
Message-Id: <1494008642-7239-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1494008642-7239-1-git-send-email-selva.nair@...277...>
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Parse static challenge response in
	auth-pam plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

If static challenge is in use, the password passed to the plugin by openvpn
is of the form "SCRV1:base64-pass:base64-response". Parse this string to
separate it into password and response and use them to respond to queries
in the pam conversation function.

On the plugin parameters line the substitution keyword for the static
challenge response is "OTP". For example, for pam config named "test" that
prompts for "user", "password" and "pin", use

plugin openvpn-auth-pam.so "test user USERNAME password PASSWORD pin OTP"

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/plugins/auth-pam/Makefile.am     |  3 ++
 src/plugins/auth-pam/README.auth-pam | 15 +++++---
 src/plugins/auth-pam/auth-pam.c      | 75 ++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/src/plugins/auth-pam/Makefile.am b/src/plugins/auth-pam/Makefile.am
index e6dc27e..8563fd4 100644
--- a/src/plugins/auth-pam/Makefile.am
+++ b/src/plugins/auth-pam/Makefile.am
@@ -9,6 +9,8 @@ MAINTAINERCLEANFILES = \
 
 AM_CFLAGS = \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src/openvpn \
+	-I$(top_srcdir)/src/compat \
 	$(PLUGIN_AUTH_PAM_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
@@ -21,6 +23,7 @@ openvpn_plugin_auth_pam_la_SOURCES = \
 	utils.c \
 	auth-pam.c \
 	pamdl.c  pamdl.h \
+	$(top_srcdir)/src/openvpn/base64.c $(top_srcdir)/src/openvpn/base64.h \
 	auth-pam.exports
 openvpn_plugin_auth_pam_la_LIBADD = \
 	$(PLUGIN_AUTH_PAM_LIBS)
diff --git a/src/plugins/auth-pam/README.auth-pam b/src/plugins/auth-pam/README.auth-pam
index e123690..9081565 100644
--- a/src/plugins/auth-pam/README.auth-pam
+++ b/src/plugins/auth-pam/README.auth-pam
@@ -36,19 +36,20 @@ pairs to answer PAM module queries.
 
 For example:
 
-  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD"
+  plugin openvpn-auth-pam.so "login login USERNAME password PASSWORD pin OTP"
 
 tells auth-pam to (a) use the "login" PAM module, (b) answer a
-"login" query with the username given by the OpenVPN client, and
-(c) answer a "password" query with the password given by the
-OpenVPN client.  This provides flexibility in dealing with the different
+"login" query with the username given by the OpenVPN client,
+(c) answer a "password" query with the password, and (d) answer a
+"pin" query with the OTP given by the OpenVPN client.
+This provides flexibility in dealing with different
 types of query strings which different PAM modules might generate.
 For example, suppose you were using a PAM module called
 "test" which queried for "name" rather than "login":
 
   plugin openvpn-auth-pam.so "test name USERNAME password PASSWORD"
 
-While "USERNAME" "COMMONNAME" and "PASSWORD" are special strings which substitute
+While "USERNAME" "COMMONNAME" "PASSWORD" and "OTP" are special strings which substitute
 to client-supplied values, it is also possible to name literal values
 to use as PAM module query responses.  For example, suppose that the
 login module queried for a third parameter, "domain" which
@@ -61,6 +62,10 @@ the operation of this plugin:
 
   client-cert-not-required
   username-as-common-name
+  static-challenge
+
+Use of --static challenege is required to pass a pin (represented by "OTP" in
+parameter substituion) or a second password.
 
 Run OpenVPN with --verb 7 or higher to get debugging output from
 this plugin, including the list of queries presented by the
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 10622fd..f037eef 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -48,6 +48,7 @@
 #include <signal.h>
 #include <syslog.h>
 #include "utils.h"
+#include <base64.h>
 
 #include <openvpn-plugin.h>
 
@@ -85,6 +86,7 @@ struct auth_pam_context
  *  "USERNAME" -- substitute client-supplied username
  *  "PASSWORD" -- substitute client-specified password
  *  "COMMONNAME" -- substitute client certificate common name
+ *  "OTP" -- substitute static challenege response if available
  */
 
 #define N_NAME_VALUE 16
@@ -109,6 +111,7 @@ struct user_pass {
     char username[128];
     char password[128];
     char common_name[128];
+    char response[128];
 
     const struct name_value_list *name_value_list;
 };
@@ -274,6 +277,69 @@ name_value_match(const char *query, const char *match)
     return strncasecmp(match, query, strlen(match)) == 0;
 }
 
+/*
+ * Split and decode up->password in the form SCRV1:base64_pass:base64_response
+ * into pass and response and save in up->password and up->response.
+ * If the password is not in the expected format, input is not changed.
+ */
+static void
+split_scrv1_password(struct user_pass *up)
+{
+    const int skip = sizeof("SCRV1") - 1;
+    if (strncmp(up->password, "SCRV1:", skip) != 0)
+    {
+        return;
+    }
+
+    char *tmp = strdup(up->password);
+    if (!tmp)
+    {
+        fprintf(stderr, "AUTH-PAM: out of memory parsing static challenge password\n");
+        goto ret;
+    }
+
+    char *pass = tmp + skip;
+    char *resp = strchr(pass, ':');
+    if (!resp) /* string not in SCRV1:xx:yy format */
+    {
+        goto ret;
+    }
+    *resp++ = '\0';
+
+    int n = openvpn_base64_decode(pass, up->password, sizeof(up->password)-1);
+    if (n > 0)
+    {
+        up->password[n] = '\0';
+        n = openvpn_base64_decode(resp, up->response, sizeof(up->response)-1);
+        if (n > 0)
+        {
+            up->response[n] = '\0';
+        }
+    }
+    else
+    {
+        /* decode error: reinstate original value of up->password and return */
+        secure_memzero(up->password, sizeof(up->password));
+        secure_memzero(up->response, sizeof(up->response));
+        strcpy(up->password, tmp); /* tmp is guaranteed to fit in up->password */
+
+        fprintf(stderr, "AUTH-PAM: base64 decode error while parsing static challenge password\n");
+        goto ret;
+    }
+
+    if (DEBUG(up->verb))
+    {
+        fprintf(stderr, "AUTH-PAM: BACKGROUND: parsed static challenge password\n");
+    }
+
+ret:
+    if (tmp)
+    {
+        secure_memzero(tmp, strlen(tmp));
+        free(tmp);
+    }
+}
+
 OPENVPN_EXPORT openvpn_plugin_handle_t
 openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *envp[])
 {
@@ -581,6 +647,10 @@ my_conv(int n, const struct pam_message **msg_array,
                     {
                         aresp[i].resp = searchandreplace(match_value, "COMMONNAME", up->common_name);
                     }
+                    else if (strstr(match_value, "OTP"))
+                    {
+                        aresp[i].resp = searchandreplace(match_value, "OTP", up->response);
+                    }
                     else
                     {
                         aresp[i].resp = strdup(match_value);
@@ -769,6 +839,9 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
 #endif
                 }
 
+                /* If password is of the form SCRV1:base64:base64 split it up */
+                split_scrv1_password(&up);
+
                 if (pam_auth(service, &up)) /* Succeeded */
                 {
                     if (send_control(fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
@@ -800,9 +873,11 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 goto done;
         }
         secure_memzero(up.password, sizeof(up.password));
+        secure_memzero(up.response, sizeof(up.response));
     }
 done:
     secure_memzero(up.password, sizeof(up.password));
+    secure_memzero(up.response, sizeof(up.response));
 
 #ifdef USE_PAM_DLOPEN
     dlclose_pam();
-- 
2.1.4


