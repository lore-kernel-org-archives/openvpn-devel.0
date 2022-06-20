From: Paolo Cerrito <wardragon78@...277...>
Date: Mon, 20 Jun 2022 14:21:27 +0200
Message-Id: <20220620122126.2676755-1-wardragon78@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Insert client connection data into PAM
 environment, upgraded
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
Cc: paolo <paolo.cerrito@...2517...>

From: paolo <paolo.cerrito@...2517...>

---
 src/plugins/auth-pam/auth-pam.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 70339445..c2e66e5c 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -49,7 +49,7 @@
 #include <syslog.h>
 #include <limits.h>
 #include "utils.h"
-
+#include <arpa/inet.h>
 #include <openvpn-plugin.h>
 
 #define DEBUG(verb) ((verb) >= 4)
@@ -121,6 +121,7 @@ struct user_pass {
     char password[128];
     char common_name[128];
     char response[128];
+    char remote[INET6_ADDRSTRLEN];
 
     const struct name_value_list *name_value_list;
 };
@@ -529,6 +530,11 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
         const char *username = get_env("username", envp);
         const char *password = get_env("password", envp);
         const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
+        const char *remote = get_env("untrusted_ip6", envp);
+
+        if (remote == NULL){
+                remote = get_env("untrusted_ip", envp); //if Null, try to take ipv4 if not set ipv6
+        }
 
         /* should we do deferred auth?
          *  yes, if there is "auth_control_file" and "deferred_auth_pam" env
@@ -554,7 +560,8 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
                 || send_string(context->foreground_fd, username) == -1
                 || send_string(context->foreground_fd, password) == -1
                 || send_string(context->foreground_fd, common_name) == -1
-                || send_string(context->foreground_fd, auth_control_file) == -1)
+                || send_string(context->foreground_fd, auth_control_file) == -1
+                || send_string(context->foreground_fd, remote) == -1)
             {
                 plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error sending auth info to background process");
             }
@@ -789,8 +796,16 @@ pam_auth(const char *service, const struct user_pass *up)
     status = pam_start(service, name_value_list_provided ? NULL : up->username, &conv, &pamh);
     if (status == PAM_SUCCESS)
     {
+        /* Set PAM_RHOST environment variable */
+        if (*(up->remote))
+        {
+            status = pam_set_item(pamh, PAM_RHOST, up->remote);
+        }
         /* Call PAM to verify username/password */
-        status = pam_authenticate(pamh, 0);
+        if (status == PAM_SUCCESS)
+        {
+            status = pam_authenticate(pamh, 0);
+        }
         if (status == PAM_SUCCESS)
         {
             status = pam_acct_mgmt(pamh, 0);
@@ -956,7 +971,8 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 if (recv_string(fd, up.username, sizeof(up.username)) == -1
                     || recv_string(fd, up.password, sizeof(up.password)) == -1
                     || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1
-                    || recv_string(fd, ac_file_name, sizeof(ac_file_name)) == -1)
+                    || recv_string(fd, ac_file_name, sizeof(ac_file_name)) == -1
+                    || recv_string(fd, up.remote, sizeof(up.remote)) == -1)
                 {
                     plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel: code=%d, exiting",
                                command);
@@ -970,6 +986,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                                up.username, up.password);
 #else
                     plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: USER: %s", up.username);
+                    plugin_log(PLOG_NOTE, MODULE, "BACKGROUND: REMOTE: %s", up.remote);
 #endif
                 }
 
-- 
2.36.1


