From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  8 Sep 2022 18:14:35 +0200
Message-Id: <20220908161435.327109-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Change command help to match man page and
 implementation
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

From: Arne Schwabe <arne@...1227...>

Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

patch got lost back in 2017
still included in Debian package
original mail: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13821.html

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a296086d..bb5cd875 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -208,7 +208,7 @@ static const char usage_message[] =
     "                  is established.  Multiple routes can be specified.\n"
     "                  netmask default: 255.255.255.255\n"
     "                  gateway default: taken from --route-gateway or --ifconfig\n"
-    "                  Specify default by leaving blank or setting to \"nil\".\n"
+    "                  Specify default by leaving blank or setting to \"default\".\n"
     "--route-ipv6 network/bits [gateway] [metric] :\n"
     "                  Add IPv6 route to routing table after connection\n"
     "                  is established.  Multiple routes can be specified.\n"
-- 
2.25.1


