From: David Korczynski <david@...2627...>
Date: Wed, 14 Jul 2021 14:46:42 +0100
Message-Id: <20210714134642.12964-1-david@...2627...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Avoid leak in add_route.
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
 src/openvpn/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3b2af8b4..e429e8c0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1584,6 +1584,7 @@ add_route(struct route_ipv4 *r,

     if (!(r->flags & RT_DEFINED))
     {
+        argv_free(&argv);
         return;
     }

--
2.17.1

ADA Logics Ltd is registered in England. No: 11624074.
Registered office: 266 Banbury Road, Post Box 292,
OX2 7DL, Oxford, Oxfordshire , United Kingdom

