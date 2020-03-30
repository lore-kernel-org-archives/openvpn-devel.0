From: Paolo Cerrito <wardragon78@...277...>
Date: Mon, 30 Mar 2020 14:57:20 +0200
Message-Id: <20200330125719.766763-1-wardragon78@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] [PATCH v5] Insert client connection data
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

1) so remote was set to the maxlenght of ipv6 address defined into
arpa/inet.h  + 1 for string terminator

2) I refactored the call to get_env to take first ipv6 address, then
   only if it is NULL, i make a call for ipv4
---
 src/plugins/auth-pam/auth-pam.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index ae0d495a..cd91a33c 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -48,7 +48,7 @@
 #include <signal.h>
 #include <syslog.h>
 #include "utils.h"
-
+#include <arpa/inet.h>
 #include <openvpn-plugin.h>
 
 #define DEBUG(verb) ((verb) >= 4)
@@ -115,7 +115,7 @@ struct user_pass {
     char password[128];
     char common_name[128];
     char response[128];
-    char remote[46]; //46 as ipv6 form n:n:n:n:n:n:d.d.d.d and + terminator \0
+    char remote[INET6_ADDRSTRLEN+1]; //INET6_ADDRSTRLEN  is the lenght of ipv6 + terminator \0
 
     const struct name_value_list *name_value_list;
 };
@@ -518,12 +518,14 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
         const char *username = get_env("username", envp);
         const char *password = get_env("password", envp);
         const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
+
         const char *remote = get_env("untrusted_ip6", envp);
        
 	if (remote == NULL){ 
-		remote = get_env("untrusted_ip", envp); //try to take ipv4 if not set ipv6
+		remote = get_env("untrusted_ip", envp); //if Null, try to take ipv4 if not set ipv6
 	}
 
+
         if (username && strlen(username) > 0 && password)
         {
             if (send_control(context->foreground_fd, COMMAND_VERIFY) == -1
-- 
2.26.0


