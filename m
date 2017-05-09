From: selva.nair@...277...
Date: Tue,  9 May 2017 10:52:37 -0400
Message-Id: <1494341557-11721-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1494008642-7239-1-git-send-email-selva.nair@...277...>
References: <1494008642-7239-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2 v2] In auth-pam plugin clear the
	password after use
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

v2: Change the plugin open to use v3 API so that
  openvpn_secure_memzero() exported from OpenVPN can be used.

Note: context is cast as (openvpn_plugin_handle_t *) for consistency
with the current plugin header. If/when the header is fixed, change
this cast as well.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/plugins/auth-pam/auth-pam.c       | 31 ++++++++++++++++++++++++++-----
 src/plugins/auth-pam/auth-pam.exports |  2 +-
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index d3e2c89..f3566c7 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -63,6 +63,9 @@
 #define RESPONSE_VERIFY_SUCCEEDED 12
 #define RESPONSE_VERIFY_FAILED    13
 
+/* Pointers to functions exported from openvpn */
+static plugin_secure_memzero_t plugin_secure_memzero = NULL;
+
 /*
  * Plugin state, used by foreground
  */
@@ -274,8 +277,10 @@ name_value_match(const char *query, const char *match)
     return strncasecmp(match, query, strlen(match)) == 0;
 }
 
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *envp[])
+OPENVPN_EXPORT int
+openvpn_plugin_open_v3(const int v3structver,
+                       struct openvpn_plugin_args_open_in const *args,
+                       struct openvpn_plugin_args_open_return *ret)
 {
     pid_t pid;
     int fd[2];
@@ -285,6 +290,16 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
 
     const int base_parms = 2;
 
+    const char **argv = args->argv;
+    const char **envp = args->envp;
+
+    /* Check API compatibility */
+    if (v3structver != OPENVPN_PLUGINv3_STRUCTVER)
+    {
+        fprintf(stderr, "AUTH-PAM: This plugin is incompatible with the running version of OpenVPN\n");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
     /*
      * Allocate our context
      */
@@ -298,7 +313,10 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
     /*
      * Intercept the --auth-user-pass-verify callback.
      */
-    *type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY);
+    ret->type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY);
+
+    /* Save global pointers to functions exported from openvpn */
+    plugin_secure_memzero = args->callbacks->plugin_secure_memzero;
 
     /*
      * Make sure we have two string arguments: the first is the .so name,
@@ -386,7 +404,8 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
         if (status == RESPONSE_INIT_SUCCEEDED)
         {
             context->foreground_fd = fd[0];
-            return (openvpn_plugin_handle_t) context;
+            ret->handle = (openvpn_plugin_handle_t *) context;
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;
         }
     }
     else
@@ -420,7 +439,7 @@ error:
     {
         free(context);
     }
-    return NULL;
+    return OPENVPN_PLUGIN_FUNC_ERROR;
 }
 
 OPENVPN_EXPORT int
@@ -785,6 +804,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                         goto done;
                     }
                 }
+                plugin_secure_memzero(up.password, sizeof(up.password));
                 break;
 
             case COMMAND_EXIT:
@@ -802,6 +822,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
     }
 done:
 
+    plugin_secure_memzero(up.password, sizeof(up.password));
 #ifdef USE_PAM_DLOPEN
     dlclose_pam();
 #endif
diff --git a/src/plugins/auth-pam/auth-pam.exports b/src/plugins/auth-pam/auth-pam.exports
index b07937c..597e33f 100644
--- a/src/plugins/auth-pam/auth-pam.exports
+++ b/src/plugins/auth-pam/auth-pam.exports
@@ -1,4 +1,4 @@
-openvpn_plugin_open_v1
+openvpn_plugin_open_v3
 openvpn_plugin_func_v1
 openvpn_plugin_close_v1
 openvpn_plugin_abort_v1
-- 
2.1.4


