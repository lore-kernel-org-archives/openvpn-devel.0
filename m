Message-ID: <1492699272.18647.3.camel@...2264...>
From: Hristo Venev <hristo@...2264...>
Date: Thu, 20 Apr 2017 15:41:12 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-lvLOuv/xiNCoJNGRBNe9"
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
	objects
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-lvLOuv/xiNCoJNGRBNe9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Only fields known to OpenSSL have a NID. OBJ_txt2obj allows specifying
a numeric OID.

Signed-off-by: Hristo Venev <hristo@...2264...>
---
 src/openvpn/ssl_verify_openssl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 87f71f21..114cf39c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -191,16 +191,23 @@ extract_x509_field_ssl(X509_NAME *x509, const char *f=
ield_name, char *out,
     X509_NAME_ENTRY *x509ne =3D 0;
     ASN1_STRING *asn1 =3D 0;
     unsigned char *buf =3D NULL;
-    int nid =3D OBJ_txt2nid(field_name);
+    ASN1_OBJECT *obj =3D OBJ_txt2obj(field_name, 0);
+
+    if (obj =3D=3D NULL)
+    {
+        crypto_msg(M_FATAL, "Cannot get ASN1_OBJECT for %s", field_name);
+    }
=20
     ASSERT(size > 0);
     *out =3D '\0';
     do
     {
         lastpos =3D tmp;
-        tmp =3D X509_NAME_get_index_by_NID(x509, nid, lastpos);
+        tmp =3D X509_NAME_get_index_by_OBJ(x509, obj, lastpos);
     } while (tmp > -1);
=20
+    ASN1_OBJECT_free(obj);
+
     /* Nothing found */
     if (lastpos =3D=3D -1)
     {
--=20
2.12.2=

--=-lvLOuv/xiNCoJNGRBNe9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETdMrh1lhmLmNEKGzzwXo0E3DKboFAlj4yIgACgkQzwXo0E3D
KbqrAw/+JQBA8nzFNVMmXYMUiA1wJlRqa+9ft24we/te0zhYW81/kAdB7Sz/qn8f
RBMW8WbhuqcMNaRkH0LrtoHr8BGheXWGanCfThV8L8XUSRMxJpWOgAeYydTToPR8
pIc69RIdp1ryUO9PBWcD0ghLmoPCCS+/tidCj10Y5ge+E7XHSP5Lw74jn9LTqglh
HVDSIjSoDz6jFDiI7L+NyLdhnXomBuW1POrQwKE3EH+KtQsbIjuVop/TUAFG5RHj
pL3QwAjOmrHVJh5QIYnvHefUy24m/BK6b4gXjlG6WvO+daGfGcxIU4443F6bmNk/
9sCewhp3RfuKPXHnfZQCPjE+szWlwxrD9aWN7YpOx40RWJauoMQfw1y+YlR+NsK4
bjRo/2ykaX7M0Eqp1MMGw1VcwxwqDrTA4Ci2eq8bBwmZIOxkOn8NNUh7JFIQnwFU
WZq0ao8Py/9MMx8Ahgn6VrRguYabgdCt82RPTNc6/lsmrVm/H77s6FQY5DVu4Szc
iLcnvggBnPAgOO8HnEn8GXxBlUb/FeqdBEUEj4g9YJbUS8PWyJYfYWmsBIF9y92a
V2kKEQ0RMFu/UL8EBfmelHqN8qpAVc5BpCQExGffO22IV/s6YTHyC08juIUxWp2s
RGBoWCN+uTLmIzTjRLhaYlveb/Hb5CmPqZKrYW1i3fzfDqxZobQ=
=uBkw
-----END PGP SIGNATURE-----

--=-lvLOuv/xiNCoJNGRBNe9--


