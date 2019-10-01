From: Paolo Cerrito <wardragon78@...277...>
Date: Tue,  1 Oct 2019 14:06:52 +0200
Message-Id: <20191001120652.31898-1-wardragon78@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Insert client connection data into PAM
 environment
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
 src/plugins/auth-pam/auth-pam.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 88b53204..9d8dfb95 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -115,6 +115,7 @@ struct user_pass {
     char password[128];
     char common_name[128];
     char response[128];
+    char remote[128];
 
     const struct name_value_list *name_value_list;
 };
@@ -517,13 +518,15 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
         const char *username = get_env("username", envp);
         const char *password = get_env("password", envp);
         const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
+        const char *remote = get_env("untrusted_ip", envp) ? get_env("untrusted_ip", envp) : get_env("untrusted_ip6", envp);
 
         if (username && strlen(username) > 0 && password)
         {
             if (send_control(context->foreground_fd, COMMAND_VERIFY) == -1
                 || send_string(context->foreground_fd, username) == -1
                 || send_string(context->foreground_fd, password) == -1
-                || send_string(context->foreground_fd, common_name) == -1)
+                || send_string(context->foreground_fd, common_name) == -1
+                || send_string(context->foreground_fd, remote) == -1)
             {
                 fprintf(stderr, "AUTH-PAM: Error sending auth info to background process\n");
             }
@@ -750,8 +753,16 @@ pam_auth(const char *service, const struct user_pass *up)
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
@@ -839,7 +850,8 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
             case COMMAND_VERIFY:
                 if (recv_string(fd, up.username, sizeof(up.username)) == -1
                     || recv_string(fd, up.password, sizeof(up.password)) == -1
-                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1)
+                    || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1
+                    || recv_string(fd, up.remote, sizeof(up.remote)) == -1)
                 {
                     fprintf(stderr, "AUTH-PAM: BACKGROUND: read error on command channel: code=%d, exiting\n",
                             command);
@@ -853,6 +865,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                             up.username, up.password);
 #else
                     fprintf(stderr, "AUTH-PAM: BACKGROUND: USER: %s\n", up.username);
+                    fprintf(stderr, "AUTH-PAM: BACKGROUND: REMOTE: %s\n", up.remote);
 #endif
                 }
 
-- 
2.23.0


