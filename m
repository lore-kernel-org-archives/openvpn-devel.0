From: Gert Doering <gert@...1296...>
Date: Sat, 20 Jun 2020 16:39:40 +0200
Message-Id: <20200620143940.11704-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Convert plugin/auth-pam.c from stderr
 logging to plugin_log().
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

More recent OpenVPN APIs pass a function pointer for a logging function
(plugin_log()) to plugins.  Using this will make the plugin logs appear
wherever openvpn logs to - file, syslog, stderr.

This patch converts plugin/auth-pam.c "fairly mechanically" to use this
new API.  Real errors are logged with PLOG_ERR or PLOG_ERR|PLOG_ERRNO,
while debug info is logged with PLOG_NOTE (subject to the already-existing
debug level handling inside plugin/auth-pam, via "setenv verb <n>").

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/plugins/auth-pam/auth-pam.c | 62 +++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 88b53204..9a11876d 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -64,9 +64,13 @@
 #define RESPONSE_VERIFY_FAILED    13
 
 /* Pointers to functions exported from openvpn */
+static plugin_log_t plugin_log = NULL;
 static plugin_secure_memzero_t plugin_secure_memzero = NULL;
 static plugin_base64_decode_t plugin_base64_decode = NULL;
 
+/* module name for plugin_log() */
+static char * MODULE = "AUTH-PAM";
+
 /*
  * Plugin state, used by foreground
  */
@@ -211,7 +215,7 @@ daemonize(const char *envp[])
         }
         if (daemon(0, 0) < 0)
         {
-            fprintf(stderr, "AUTH-PAM: daemonization failed\n");
+            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "daemonization failed");
         }
         else if (fd >= 3)
         {
@@ -297,7 +301,7 @@ split_scrv1_password(struct user_pass *up)
     char *tmp = strdup(up->password);
     if (!tmp)
     {
-        fprintf(stderr, "AUTH-PAM: out of memory parsing static challenge password\n");
+        plugin_log(PLOG_ERR, MODULE, "out of memory parsing static challenge password");
         goto out;
     }
 
@@ -319,7 +323,7 @@ split_scrv1_password(struct user_pass *up)
             up->response[n] = '\0';
             if (DEBUG(up->verb))
             {
-                fprintf(stderr, "AUTH-PAM: BACKGROUND: parsed static challenge password\n");
+                plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: parsed static challenge password");
             }
             goto out;
         }
@@ -330,7 +334,7 @@ split_scrv1_password(struct user_pass *up)
     plugin_secure_memzero(up->response, sizeof(up->response));
     strcpy(up->password, tmp); /* tmp is guaranteed to fit in up->password */
 
-    fprintf(stderr, "AUTH-PAM: base64 decode error while parsing static challenge password\n");
+    plugin_log(PLOG_ERR, MODULE, "base64 decode error while parsing static challenge password");
 
 out:
     if (tmp)
@@ -379,6 +383,7 @@ openvpn_plugin_open_v3(const int v3structver,
     ret->type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY);
 
     /* Save global pointers to functions exported from openvpn */
+    plugin_log = args->callbacks->plugin_log;
     plugin_secure_memzero = args->callbacks->plugin_secure_memzero;
     plugin_base64_decode = args->callbacks->plugin_base64_decode;
 
@@ -388,7 +393,7 @@ openvpn_plugin_open_v3(const int v3structver,
      */
     if (string_array_len(argv) < base_parms)
     {
-        fprintf(stderr, "AUTH-PAM: need PAM service parameter\n");
+        plugin_log(PLOG_ERR, MODULE, "need PAM service parameter");
         goto error;
     }
 
@@ -404,7 +409,7 @@ openvpn_plugin_open_v3(const int v3structver,
 
         if ((nv_len & 1) == 1 || (nv_len / 2) > N_NAME_VALUE)
         {
-            fprintf(stderr, "AUTH-PAM: bad name/value list length\n");
+            plugin_log(PLOG_ERR, MODULE, "bad name/value list length");
             goto error;
         }
 
@@ -434,7 +439,7 @@ openvpn_plugin_open_v3(const int v3structver,
      */
     if (socketpair(PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
     {
-        fprintf(stderr, "AUTH-PAM: socketpair call failed\n");
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "socketpair call failed");
         goto error;
     }
 
@@ -460,7 +465,7 @@ openvpn_plugin_open_v3(const int v3structver,
         /* don't let future subprocesses inherit child socket */
         if (fcntl(fd[0], F_SETFD, FD_CLOEXEC) < 0)
         {
-            fprintf(stderr, "AUTH-PAM: Set FD_CLOEXEC flag on socket file descriptor failed\n");
+            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Set FD_CLOEXEC flag on socket file descriptor failed");
         }
 
         /* wait for background child process to initialize */
@@ -469,6 +474,7 @@ openvpn_plugin_open_v3(const int v3structver,
         {
             context->foreground_fd = fd[0];
             ret->handle = (openvpn_plugin_handle_t *) context;
+            plugin_log( PLOG_NOTE, MODULE, "initialization succeeded (fg)" );
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
         }
     }
@@ -525,7 +531,7 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
                 || send_string(context->foreground_fd, password) == -1
                 || send_string(context->foreground_fd, common_name) == -1)
             {
-                fprintf(stderr, "AUTH-PAM: Error sending auth info to background process\n");
+                plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error sending auth info to background process");
             }
             else
             {
@@ -536,7 +542,7 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
                 }
                 if (status == -1)
                 {
-                    fprintf(stderr, "AUTH-PAM: Error receiving auth confirmation from background process\n");
+                    plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error receiving auth confirmation from background process");
                 }
             }
         }
@@ -551,7 +557,7 @@ openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
 
     if (DEBUG(context->verb))
     {
-        fprintf(stderr, "AUTH-PAM: close\n");
+        plugin_log(PLOG_NOTE, MODULE, "close");
     }
 
     if (context->foreground_fd >= 0)
@@ -559,7 +565,7 @@ openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
         /* tell background process to exit */
         if (send_control(context->foreground_fd, COMMAND_EXIT) == -1)
         {
-            fprintf(stderr, "AUTH-PAM: Error signaling background process to exit\n");
+            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error signaling background process to exit");
         }
 
         /* wait for background process to exit */
@@ -621,7 +627,7 @@ my_conv(int n, const struct pam_message **msg_array,
 
         if (DEBUG(up->verb))
         {
-            fprintf(stderr, "AUTH-PAM: BACKGROUND: my_conv[%d] query='%s' style=%d\n",
+            plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: my_conv[%d] query='%s' style=%d",
                     i,
                     msg->msg ? msg->msg : "NULL",
                     msg->msg_style);
@@ -646,7 +652,7 @@ my_conv(int n, const struct pam_message **msg_array,
 
                     if (DEBUG(up->verb))
                     {
-                        fprintf(stderr, "AUTH-PAM: BACKGROUND: name match found, query/match-string ['%s', '%s'] = '%s'\n",
+                        plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: name match found, query/match-string ['%s', '%s'] = '%s'",
                                 msg->msg,
                                 match_name,
                                 match_value);
@@ -764,7 +770,7 @@ pam_auth(const char *service, const struct user_pass *up)
         /* Output error message if failed */
         if (!ret)
         {
-            fprintf(stderr, "AUTH-PAM: BACKGROUND: user '%s' failed to authenticate: %s\n",
+            plugin_log(PLOG_ERR, MODULE, "BACKGROUND: user '%s' failed to authenticate: %s",
                     up->username,
                     pam_strerror(pamh, status));
         }
@@ -793,7 +799,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
      */
     if (DEBUG(verb))
     {
-        fprintf(stderr, "AUTH-PAM: BACKGROUND: INIT service='%s'\n", service);
+        plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: INIT service='%s'", service);
     }
 
 #ifdef USE_PAM_DLOPEN
@@ -802,7 +808,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
      */
     if (!dlopen_pam(pam_so))
     {
-        fprintf(stderr, "AUTH-PAM: BACKGROUND: could not load PAM lib %s: %s\n", pam_so, dlerror());
+        plugin_log(PLOG_ERR, MODULE, "BACKGROUND: could not load PAM lib %s: %s", pam_so, dlerror());
         send_control(fd, RESPONSE_INIT_FAILED);
         goto done;
     }
@@ -813,10 +819,12 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
      */
     if (send_control(fd, RESPONSE_INIT_SUCCEEDED) == -1)
     {
-        fprintf(stderr, "AUTH-PAM: BACKGROUND: write error on response socket [1]\n");
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [1]");
         goto done;
     }
 
+    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: initialization succeeded");
+
     /*
      * Event loop
      */
@@ -831,7 +839,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
 
         if (DEBUG(verb))
         {
-            fprintf(stderr, "AUTH-PAM: BACKGROUND: received command code: %d\n", command);
+            plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: received command code: %d", command);
         }
 
         switch (command)
@@ -841,7 +849,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                     || recv_string(fd, up.password, sizeof(up.password)) == -1
                     || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1)
                 {
-                    fprintf(stderr, "AUTH-PAM: BACKGROUND: read error on command channel: code=%d, exiting\n",
+                    plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel: code=%d, exiting",
                             command);
                     goto done;
                 }
@@ -849,10 +857,10 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 if (DEBUG(verb))
                 {
 #if 0
-                    fprintf(stderr, "AUTH-PAM: BACKGROUND: USER/PASS: %s/%s\n",
+                    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: USER/PASS: %s/%s",
                             up.username, up.password);
 #else
-                    fprintf(stderr, "AUTH-PAM: BACKGROUND: USER: %s\n", up.username);
+                    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: USER: %s", up.username);
 #endif
                 }
 
@@ -863,7 +871,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 {
                     if (send_control(fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
                     {
-                        fprintf(stderr, "AUTH-PAM: BACKGROUND: write error on response socket [2]\n");
+                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [2]");
                         goto done;
                     }
                 }
@@ -871,7 +879,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 {
                     if (send_control(fd, RESPONSE_VERIFY_FAILED) == -1)
                     {
-                        fprintf(stderr, "AUTH-PAM: BACKGROUND: write error on response socket [3]\n");
+                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [3]");
                         goto done;
                     }
                 }
@@ -882,11 +890,11 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 goto done;
 
             case -1:
-                fprintf(stderr, "AUTH-PAM: BACKGROUND: read error on command channel\n");
+                plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel");
                 goto done;
 
             default:
-                fprintf(stderr, "AUTH-PAM: BACKGROUND: unknown command code: code=%d, exiting\n",
+                plugin_log(PLOG_ERR, MODULE, "BACKGROUND: unknown command code: code=%d, exiting",
                         command);
                 goto done;
         }
@@ -900,7 +908,7 @@ done:
 #endif
     if (DEBUG(verb))
     {
-        fprintf(stderr, "AUTH-PAM: BACKGROUND: EXIT\n");
+        plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: EXIT");
     }
 
     return;
-- 
2.26.2


