From: Paolo Cerrito <wardragon78@...277...>
Date: Thu, 26 Mar 2020 09:50:45 +0100
Message-Id: <20200326085045.46465-1-wardragon78@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] PATCH V3 - changed remote lenght and
 refactored get_env
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

---
 .gitignore                      | 1 +
 src/plugins/auth-pam/auth-pam.c | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0d68ec4b..3977882f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,3 +72,4 @@ nbproject
 test-driver
 compile
 stamp-h2
+outgoing/*
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 9d8dfb95..b55a2ecd 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -115,7 +115,7 @@ struct user_pass {
     char password[128];
     char common_name[128];
     char response[128];
-    char remote[128];
+    char remote[51]; //51 as ipv6 form n:n:n:n:n:n:d.d.d.d/mask and terminator+1
 
     const struct name_value_list *name_value_list;
 };
@@ -518,7 +518,11 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
         const char *username = get_env("username", envp);
         const char *password = get_env("password", envp);
         const char *common_name = get_env("common_name", envp) ? get_env("common_name", envp) : "";
-        const char *remote = get_env("untrusted_ip", envp) ? get_env("untrusted_ip", envp) : get_env("untrusted_ip6", envp);
+        const char *remote = get_env("untrusted_ip6", envp);
+       
+	if (remote == NULL){ 
+		remote = get_env("untrusted_ip", envp); //try to take ipv4 if not set ipv6
+	}
 
         if (username && strlen(username) > 0 && password)
         {
-- 
2.26.0


