From: Gert Doering <gert@...1296...>
Date: Wed,  9 Sep 2020 17:37:25 +0200
Message-Id: <20200909153725.1158-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix TUNSETGROUP compatibility with very old
 Linux systems.
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

Our code works on "very old Linux" (Fedora-1), but needs a #define
for TUNSETGROUP to compile.  Everything else is there.

While at it, fix TUNSETGROUP error message.

Reported-By: noloader on Trac
Trac: #1152

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 923131ad..651cb871 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1993,6 +1993,11 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 
+/* TUNSETGROUP appeared in 2.6.23 */
+#ifndef TUNSETGROUP
+# define TUNSETGROUP   _IOW('T', 206, int)
+#endif
+
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node,
        int persist_mode, const char *username, const char *groupname,
@@ -2032,7 +2037,7 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
         }
         else if (ioctl(tt->fd, TUNSETGROUP, platform_state_group.gr->gr_gid) < 0)
         {
-            msg(M_ERR, "Cannot ioctl TUNSETOWNER(%s) %s", groupname, dev);
+            msg(M_ERR, "Cannot ioctl TUNSETGROUP(%s) %s", groupname, dev);
         }
     }
     close_tun(tt, ctx);
-- 
2.26.2


