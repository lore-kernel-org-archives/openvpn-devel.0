From: Gert Doering <gert@...1296...>
Date: Fri, 25 Jul 2025 14:44:09 +0200
Message-ID: <20250725124415.20645-1-gert@...1296...>
In-Reply-To: <gerrit.1753437961000.Id61df43bd79fc794a55e107daa0218c8441c2b2c@...2715...>
References: <gerrit.1753437961000.Id61df43bd79fc794a55e107daa0218c8441c2b2c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] plugins: Clean up -Wconversion warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Most of the are actually the same ones copied to every
single plugin.

Some drive-by fixes of other warnings and some
conversion cleanups that had no warnings because
they were suppressed by casts.

Change-Id: Id61df43bd79fc794a55e107daa0218c8441c2b2c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1111
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index 18c2c6f..5194270 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -86,9 +86,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -309,7 +308,7 @@
 
     /* do mighty complicated work that will really take time here... */
     plugin_log(PLOG_NOTE, MODULE, "in async/deferred handler, sleep(%d)", seconds);
-    sleep(seconds);
+    sleep((unsigned int)seconds);
 
     /* write config options to openvpn */
     int ret = write_cc_options_file(name, envp);
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index 38db07f..c458346 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -124,9 +124,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -170,7 +169,7 @@
 
 /* Require a minimum OpenVPN Plugin API */
 OPENVPN_EXPORT int
-openvpn_plugin_min_version_required_v1()
+openvpn_plugin_min_version_required_v1(void)
 {
     return OPENVPN_PLUGIN_VERSION_MIN;
 }
@@ -349,9 +348,9 @@
      */
 
     /* do mighty complicated work that will really take time here... */
-    plog(context, PLOG_NOTE, "in async/deferred handler, usleep(%d)",
-         context->test_deferred_auth*1000);
-    usleep(context->test_deferred_auth*1000);
+    useconds_t wait_time = (useconds_t)context->test_deferred_auth*1000;
+    plog(context, PLOG_NOTE, "in async/deferred handler, usleep(%u)", wait_time);
+    usleep(wait_time);
 
     /* now signal success state to openvpn */
     int fd = open(auth_control_file, O_WRONLY);
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index cc256dd..f1f8868 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -69,9 +69,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 82595cf..b304f16 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -52,9 +52,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index c90cc3d..a024027 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -55,9 +55,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index 6855966..e1cc791 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -59,9 +59,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -175,7 +174,7 @@
 
     /* test the BASE64 encode function */
     char *buf = NULL;
-    int r = ovpn_base64_encode(clcert_cn, strlen(clcert_cn), &buf);
+    int r = ovpn_base64_encode(clcert_cn, (int)strlen(clcert_cn), &buf);
     ovpn_log(PLOG_NOTE, PLUGIN_NAME, "BASE64 encoded '%s' (return value %i):  '%s'",
              clcert_cn, r, buf);
 
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c
index e17f3fa..2c096e2 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -54,9 +54,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 8692806..7264f95 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -165,31 +165,30 @@
     }
 }
 
-static int
-recv_string(int fd, char *buffer, int len)
+static ssize_t
+recv_string(int fd, char *buffer, size_t len)
 {
     if (len > 0)
     {
-        ssize_t size;
         memset(buffer, 0, len);
-        size = read(fd, buffer, len);
+        ssize_t size = read(fd, buffer, len);
         buffer[len-1] = 0;
         if (size >= 1)
         {
-            return (int)size;
+            return size;
         }
     }
     return -1;
 }
 
-static int
+static ssize_t
 send_string(int fd, const char *string)
 {
-    const int len = strlen(string) + 1;
+    const size_t len = strlen(string) + 1;
     const ssize_t size = write(fd, string, len);
     if (size == len)
     {
-        return (int) size;
+        return size;
     }
     else
     {
@@ -645,27 +644,26 @@
  * PAM conversation function
  */
 static int
-my_conv(int n, const struct pam_message **msg_array,
+my_conv(int num_msg, const struct pam_message **msg_array,
         struct pam_response **response_array, void *appdata_ptr)
 {
     const struct user_pass *up = ( const struct user_pass *) appdata_ptr;
     struct pam_response *aresp;
-    int i;
     int ret = PAM_SUCCESS;
 
     *response_array = NULL;
 
-    if (n <= 0 || n > PAM_MAX_NUM_MSG)
+    if (num_msg <= 0 || num_msg > PAM_MAX_NUM_MSG)
     {
         return (PAM_CONV_ERR);
     }
-    if ((aresp = calloc(n, sizeof *aresp)) == NULL)
+    if ((aresp = calloc((size_t)num_msg, sizeof *aresp)) == NULL)
     {
         return (PAM_BUF_ERR);
     }
 
     /* loop through each PAM-module query */
-    for (i = 0; i < n; ++i)
+    for (int i = 0; i < num_msg; ++i)
     {
         const struct pam_message *msg = msg_array[i];
         aresp[i].resp_retcode = 0;
@@ -683,9 +681,9 @@
         {
             /* use name/value list match method */
             const struct name_value_list *list = up->name_value_list;
-            int j;
 
             /* loop through name/value pairs */
+            int j; /* checked after loop */
             for (j = 0; j < list->len; ++j)
             {
                 const char *match_name = list->data[j].name;
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index a6ccfbf..ab5e17e 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -79,7 +79,7 @@
 
     while (scratch)
     {
-        strncat(temp, searching, scratch-searching);
+        strncat(temp, searching, (size_t)(scratch-searching));
         strcat(temp, replacewith);
 
         searching = scratch+strlen(searchfor);
@@ -93,9 +93,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index 253adcd..2c0faf4 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -88,9 +88,8 @@
 {
     if (envp)
     {
-        int i;
-        const int namelen = strlen(name);
-        for (i = 0; envp[i]; ++i)
+        const size_t namelen = strlen(name);
+        for (int i = 0; envp[i]; ++i)
         {
             if (!strncmp(envp[i], name, namelen))
             {
@@ -108,10 +107,10 @@
 /*
  * Return the length of a string array
  */
-static int
+static size_t
 string_array_len(const char *array[])
 {
-    int i = 0;
+    size_t i = 0;
     if (array)
     {
         while (array[i])
@@ -141,14 +140,14 @@
     }
 }
 
-static int
+static ssize_t
 send_control(int fd, int code)
 {
     unsigned char c = (unsigned char) code;
     const ssize_t size = write(fd, &c, sizeof(c));
     if (size == sizeof(c))
     {
-        return (int) size;
+        return size;
     }
     else
     {
@@ -281,7 +280,6 @@
 openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *envp[])
 {
     struct down_root_context *context;
-    int i = 0;
 
     /*
      * Allocate our context
@@ -320,7 +318,7 @@
     }
 
     /* Ignore argv[0], as it contains just the plug-in file name */
-    for (i = 1; i < string_array_len(argv); i++)
+    for (int i = 1; i < string_array_len(argv); i++)
     {
         context->command[i-1] = (char *) argv[i];
     }

