From: wardragon78@...277...
Date: Fri, 25 Oct 2019 13:06:31 +0200
Message-Id: <20191025110631.15540-1-wardragon78@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] [PATCH v2] Insert client connection data
 into PAM environment
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
Cc: paolo.cerrito@...2517..., lorenzo.catucci@...2517..., Paolo Cerrito <wardragon78@...277...>

From: Paolo Cerrito <wardragon78@...277...>

Without this patch, the PAM environment lacks any information about the remote client address.

syslog output for auth and authpriv facilities changes
from:
   Oct 25 11:52:02 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
                   logname=root uid=0 euid=0 tty= ruser= rhost=
   Oct 25 11:52:33 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
                   logname=root uid=0 euid=0 tty= ruser= rhost=  user=****
to:
   Oct 25 10:56:11 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
                   logname=root uid=0 euid=0 tty= ruser= rhost=198.51.100.10
   Oct 25 10:57:02 openvpndev openvpn: pam_unix(openvpn:auth): authentication failure;
                   logname=root uid=0 euid=0 tty= ruser= rhost=198.51.100.10 user=****

Furthermore, the presence of the remote client address in PAM
environment, enables usage of pam modules like pam_recent
[https://github.com/az143/pam_recent].

Signed-off-by: Paolo Cerrito <wardragon78@...277...>
---
 src/plugins/auth-pam/auth-pam.c | 39 ++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 88b53204..f7b39e36 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -115,6 +115,7 @@ struct user_pass {
     char password[128];
     char common_name[128];
     char response[128];
+    char remote[40];
 
     const struct name_value_list *name_value_list;
 };
@@ -517,13 +518,15 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
         const char *username = get_env("username", envp);
         const char *password = get_env("password", envp);
         const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
+        const char *remote = get_env("untrusted_ip6", envp) ? get_env("untrusted_ip6", envp) : get_env("untrusted_ip", envp);
 
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
@@ -848,12 +860,27 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
 
                 if (DEBUG(verb))
                 {
+			if (up.remote)
+			{
 #if 0
-                    fprintf(stderr, "AUTH-PAM: BACKGROUND: USER/PASS: %s/%s\n",
-                            up.username, up.password);
+				fprintf(stderr, "AUTH-PAM: BACKGROUND: USER/PASS/REMOTE: %s/%s/%s\n",
+					up.username, up.password, up.remote);
 #else
-                    fprintf(stderr, "AUTH-PAM: BACKGROUND: USER: %s\n", up.username);
+				fprintf(stderr, "AUTH-PAM: BACKGROUND: USER/REMOTE: %s/%s\n",
+					up.username,  up.remote);
 #endif
+			}
+			else
+			{
+#if 0
+				fprintf(stderr, "AUTH-PAM: BACKGROUND: USER/PASS: %s/%s\n",
+					up.username, up.password);
+#else
+				fprintf(stderr, "AUTH-PAM: BACKGROUND: USER: %s/\n",
+					up.username);
+#endif
+
+			}
                 }
 
                 /* If password is of the form SCRV1:base64:base64 split it up */
-- 
2.23.0


