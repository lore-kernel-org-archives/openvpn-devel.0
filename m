From: Heiko Hund <heiko@...2662...>
Date: Thu,  6 Jul 2023 19:19:22 +0200
Message-Id: <20230706171922.752429-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] work around false positive warning with
 mingw 12
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

When cross compiling for Windows with Ubuntu 23.04 mingw complains about

  route.c:344:26: warning: ‘special.S_un.S_addr’ may be used uninitialized

which is wrong technically. However the workaround isn't really
intrusive and while there are other warnings caused by libtool, the
cmake mingw build completes with -Werror now.

Change-Id: I8a0f59707570722eab41af2db76980ced04e6d54
Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0d04a5a3..0b369da4 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -319,7 +319,7 @@ init_route(struct route_ipv4 *r,
     const in_addr_t default_netmask = IPV4_NETMASK_HOST;
     bool status;
     int ret;
-    struct in_addr special;
+    struct in_addr special = {0};
 
     CLEAR(*r);
     r->option = ro;
-- 
2.39.2


