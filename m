From: Steffan Karger <steffan@...1856...>
Date: Thu, 20 Jul 2017 21:17:02 +0200
Message-Id: <1500578222-21689-1-git-send-email-steffan@...1856...>
In-Reply-To: <1500566435-29920-1-git-send-email-steffan.karger@...1435...>
References: <1500566435-29920-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH] fixup: also change missed openvpn_sleep()
 occurrences
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

45b2af9c missed some openvpn_sleep() occurrences in platform-specific code
in tun.c - fix that.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/tun.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 68fb488..3639718 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1862,7 +1862,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     if (oldtunfd >=0 && android_method == ANDROID_OPEN_AFTER_CLOSE)
     {
         close(oldtunfd);
-        openvpn_sleep(2);
+        management_sleep(2);
     }
 
     if (oldtunfd >=0  && android_method == ANDROID_KEEP_OLD_TUN)
@@ -4999,7 +4999,7 @@ netsh_command(const struct argv *a, int n, int msglevel)
     for (i = 0; i < n; ++i)
     {
         bool status;
-        openvpn_sleep(1);
+        management_sleep(1);
         netcmd_semaphore_lock();
         argv_msg_prefix(M_INFO, a, "NETSH");
         status = openvpn_execve_check(a, NULL, 0, "ERROR: netsh command failed");
@@ -5008,7 +5008,7 @@ netsh_command(const struct argv *a, int n, int msglevel)
         {
             return;
         }
-        openvpn_sleep(4);
+        management_sleep(4);
     }
     msg(msglevel, "NETSH: command failed");
 }
@@ -5991,7 +5991,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         if (s > 0)
         {
             msg(M_INFO, "Sleeping for %d seconds...", s);
-            openvpn_sleep(s);
+            management_sleep(s);
         }
     }
 
-- 
2.7.4


