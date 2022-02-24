From: Saifur Rahman Mohsin <mohsin92@...1835...>
Date: Thu, 24 Feb 2022 22:53:30 +0530
Message-Id: <20220224172330.43451-1-mohsin92@...1835...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ignore deprecation warning for daemon on
 macOS
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

Follow up to a480eaa (does the same for auth-pam.c).

Signed-off-by: Saifur Rahman Mohsin<mohsin92@...1835...>
---
 src/plugins/auth-pam/auth-pam.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 3be647e9..33492e9c 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -214,10 +214,17 @@ daemonize(const char *envp[])
         {
             fd = dup(2);
         }
+#if defined(__APPLE__) && defined(__clang__)
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wdeprecated-declarations"
+#endif
         if (daemon(0, 0) < 0)
         {
             plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "daemonization failed");
         }
+#if defined(__APPLE__) && defined(__clang__)
+#pragma clang diagnostic pop
+#endif
         else if (fd >= 3)
         {
             dup2(fd, 2);
-- 
2.32.0 (Apple Git-132)


