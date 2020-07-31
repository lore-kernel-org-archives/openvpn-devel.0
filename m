From: Arne Schwabe <arne@...1227...>
Date: Fri, 31 Jul 2020 12:06:29 +0200
Message-Id: <20200731100629.24611-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Skip existing interfaces on opening the
 first available utun on macOS
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

This avoids the error messages trying to open already used utuns.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tun.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index cc7b65cf..b9e444b6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3023,6 +3023,13 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
     {
         for (utunnum = 0; utunnum<255; utunnum++)
         {
+            char ifname[20];
+            /* if the interface exists silently skip it */
+            ASSERT(snprintf(ifname, sizeof(ifname), "utun%d", utunnum));
+            if (if_nametoindex(ifname))
+            {
+                continue;
+            }
             fd = utun_open_helper(ctlInfo, utunnum);
             /* Break if the fd is valid,
              * or if early initialization failed (-2) */
-- 
2.26.2


