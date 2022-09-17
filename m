From: Antonio Quartulli <a@...2181...>
Date: Sat, 17 Sep 2022 14:58:11 +0200
Message-Id: <20220917125811.13549-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] solaris/open_tun: prevent crash when dev is
 empty string
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
Cc: Antonio Quartulli <a@...2181...>

This was originally reported on GH, but never dealt with.
Make sure 'ptr' is always initialized to prevent derefence of null
pointer in case of empty dev string.

While at it, change the if condition to use ptr instead of dev, since
dev is not used anymore in the logic.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/tun.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a17ff50f..44fad06d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2379,10 +2379,11 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         msg(M_ERR, "Can't open %s", dev_node);
     }
 
+    ptr = dev;
+
     /* get unit number */
-    if (*dev)
+    if (*ptr)
     {
-        ptr = dev;
         while (*ptr && !isdigit((int) *ptr))
         {
             ptr++;
-- 
2.35.1


