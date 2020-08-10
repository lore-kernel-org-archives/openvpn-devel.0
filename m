From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:37:04 +0200
Message-Id: <20200810143707.5834-15-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 14/17] Skip existing interfaces on
 opening the first available utun on macOS
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
 src/openvpn/tun.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index cc7b65cf..30454454 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3021,8 +3021,15 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
     /* try to open first available utun device if no specific utun is requested */
     if (utunnum == -1)
     {
-        for (utunnum = 0; utunnum<255; utunnum++)
+        for (utunnum = 0; utunnum < 255; utunnum++)
         {
+            char ifname[20];
+            /* if the interface exists silently skip it */
+            ASSERT(snprintf(ifname, sizeof(ifname), "utun%d", utunnum) > 0);
+            if (if_nametoindex(ifname))
+            {
+                continue;
+            }
             fd = utun_open_helper(ctlInfo, utunnum);
             /* Break if the fd is valid,
              * or if early initialization failed (-2) */
-- 
2.26.2


