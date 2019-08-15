From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Aug 2019 14:10:52 +0200
Message-Id: <20190815121053.18433-1-arne@...1227...>
In-Reply-To: <20190812134513.20758-1-arne@...1227...>
References: <20190812134513.20758-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 1/2] Fix check if iface name is set
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

Clang/Android complained

 warning: address of array 'rgi6->iface' will always evaluate to 'true' [-Wpointer-bool-conversion]
          if (rgi6->iface)

iface is a char[16]; So its pointer is always true.

we do a CLEAR(rgi6) always before setting this struct and strcpy the
name into iface. So using strlen instead of checking for the pointer
should be the right fix.

Patch V2: use if(strlen > 0) instead of if(strlen)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3035fa89..1b5eacea 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3350,7 +3350,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
             rgi6->flags |= RGI_ADDR_DEFINED;
         }
 
-        if (rgi6->iface)
+        if (strlen(rgi6->iface) > 0)
         {
             rgi6->flags |= RGI_IFACE_DEFINED;
         }
-- 
2.22.0


