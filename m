From: Matthias Andree <matthias.andree@...68...>
Date: Fri, 17 Jul 2020 19:09:48 +0200
Message-Id: <20200717170948.227787-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix stack buffer overruns in NEXTADDR()
 macro:
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
Cc: Matthias Andree <matthias.andree@...68...>

copy first, then round up the length when adding padding
to the advance.

Found by: GCC 9.3.0 (FreeBSD)

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 src/openvpn/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index b57da5dd..7f760e9d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3436,7 +3436,7 @@ struct rtmsg {
 #else  /* if defined(TARGET_SOLARIS) */
 #define NEXTADDR(w, u) \
     if (rtm_addrs & (w)) { \
-        l =3D ROUNDUP( ((struct sockaddr *)&(u))->sa_len); memmove(cp, &(u=
), l); cp +=3D l; \
+        l =3D ((struct sockaddr *)&(u))->sa_len; memmove(cp, &(u), l); cp =
+=3D ROUNDUP(l); \
     }

 #define ADVANCE(x, n) (x +=3D ROUNDUP((n)->sa_len))
@@ -3727,6 +3727,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_in=
fo *rgi6,
         msg(M_WARN, "GDG6: socket #1 failed");
         goto done;
     }
+    errno =3D 0;
     if (write(sockfd, (char *)&m_rtmsg, l) < 0)
     {
         msg(M_WARN, "GDG6: problem writing to routing socket");
--
2.25.4


