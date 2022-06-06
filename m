From: Paolo Cerrito <wardragon78@...277...>
Date: Mon,  6 Jun 2022 12:31:43 +0200
Message-Id: <20220606103144.1988077-1-wardragon78@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Single patch:
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

1) changed lenght of remote to 46

2) refactored call to get_env
---
 src/plugins/auth-pam/auth-pam.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 9d8dfb95..c03e178b 100644
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
-    char remote[128];
+    char remote[INET6_ADDRSTRLEN];
 
     const struct name_value_list *name_value_list;
 };
@@ -518,7 +518,11 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
         const char *username = get_env("username", envp);
         const char *password = get_env("password", envp);
         const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
-        const char *remote = get_env("untrusted_ip", envp) ? get_env("untrusted_ip", envp) : get_env("untrusted_ip6", envp);
+        const char *remote = get_env("untrusted_ip6", envp);
+        
+        if (remote == NULL){ 
+                remote = get_env("untrusted_ip", envp); //if Null, try to take ipv4 if not set ipv6
+        }
 
         if (username && strlen(username) > 0 && password)
         {
-- 
2.36.1


