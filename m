From: David Korczynski <david@...2627...>
Date: Wed, 14 Jul 2021 17:25:33 +0100
Message-Id: <20210714162533.10098-1-david@...2627...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix leaks in route.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: David Korczynski <david@...2627...>
---
 src/openvpn/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 56fa7717..e429e8c0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1584,6 +1584,7 @@ add_route(struct route_ipv4 *r,

     if (!(r->flags & RT_DEFINED))
     {
+        argv_free(&argv);
         return;
     }

@@ -1891,6 +1892,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tu=
ntap *tt,

     if (!(r6->flags & RT_DEFINED) )
     {
+        argv_free(&argv);
         return;
     }

--
2.17.1

ADA Logics Ltd is registered in England. No: 11624074.
Registered office: 266 Banbury Road, Post Box 292,
OX2 7DL, Oxford, Oxfordshire , United Kingdom

