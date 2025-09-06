From: Matthias Andree <matthias.andree@...68...>
Date: Sat,  6 Sep 2025 15:54:13 +0200
Message-ID: <20250906135413.166789-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco_freebsd: replace assert() by if...return
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

The assert() check might be optimized away in Release builds,
and killing the process through abort() when input formats are
bad when we already have an error message in place does not seem right.

Suggested by: Ralf Lici <ralf@...2726...>

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 src/openvpn/dco_freebsd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 931f9f68..a756dcca 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -100,7 +100,10 @@ nvlist_to_sockaddr(const nvlist_t *nvl, struct sockadd=
r_storage *ss)
=20
             in->sin_len =3D sizeof(*in);
             data =3D nvlist_get_binary(nvl, "address", &len);
-            assert(len =3D=3D sizeof(in->sin_addr));
+            if (len !=3D sizeof(in->sin_addr))
+            {
+                return (false);
+            }
             memcpy(&in->sin_addr, data, sizeof(in->sin_addr));
             in->sin_port =3D nvlist_get_number(nvl, "port");
             break;
@@ -114,7 +117,10 @@ nvlist_to_sockaddr(const nvlist_t *nvl, struct sockadd=
r_storage *ss)
=20
             in6->sin6_len =3D sizeof(*in6);
             data =3D nvlist_get_binary(nvl, "address", &len);
-            assert(len =3D=3D sizeof(in6->sin6_addr));
+            if (len !=3D sizeof(in6->sin6_addr))
+            {
+                return (false);
+            }
             memcpy(&in6->sin6_addr, data, sizeof(in6->sin6_addr));
             in6->sin6_port =3D nvlist_get_number(nvl, "port");
=20
--=20
2.51.0


