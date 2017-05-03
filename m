Message-ID: <1493853048.30207.1.camel@...2264...>
From: Hristo Venev <hristo@...2264...>
Date: Thu, 04 May 2017 00:10:48 +0100
In-Reply-To: <1492699272.18647.3.camel@...2264...>
References: <1492699272.18647.3.camel@...2264...>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9pVAz2H4AkRFweVcW260"
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix extract_x509_field_ssl for external
	objects, v2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-9pVAz2H4AkRFweVcW260
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Only fields known to OpenSSL have a NID. OBJ_txt2obj allows specifying
fields by numeric OID.

Signed-off-by: Hristo Venev <hristo@...2264...>
---
 src/openvpn/ssl_verify_openssl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 87f71f21..b6867c65 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -191,16 +191,24 @@ extract_x509_field_ssl(X509_NAME *x509, const char *f=
ield_name, char *out,
     X509_NAME_ENTRY *x509ne =3D 0;
     ASN1_STRING *asn1 =3D 0;
     unsigned char *buf =3D NULL;
-    int nid =3D OBJ_txt2nid(field_name);
+    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
+
+    if (field_name_obj =3D=3D NULL)
+    {
+        msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name);
+        return FAILURE;
+    }
=20
     ASSERT(size > 0);
     *out =3D '\0';
     do
     {
         lastpos =3D tmp;
-        tmp =3D X509_NAME_get_index_by_NID(x509, nid, lastpos);
+        tmp =3D X509_NAME_get_index_by_OBJ(x509, field_name_obj, lastpos);
     } while (tmp > -1);
=20
+    ASN1_OBJECT_free(field_name_obj);
+
     /* Nothing found */
     if (lastpos =3D=3D -1)
     {
--=20
2.12.2=

--=-9pVAz2H4AkRFweVcW260
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEETdMrh1lhmLmNEKGzzwXo0E3DKboFAlkKY3gACgkQzwXo0E3D
Kbohlw/7BFwpyNbFYxtN0ijTSfDIXy2yHzC1378MnHHURa/ox7dNaofd0H+6vwmN
H2RrlKjH/FhyLlb2Qs2ebvR94N72ULNsIQgTtWz1j9W3g+gJqM5PjB5Jdm7pc7TL
pTH/7coQaQHiQcJctYk4PrTNOa/g3jy04DuyLp1iwk5gWQT8roqD57VKpEU+BTNX
kbnZIAbdcEr7LWrFBmgKjSdncOZue8Jrl+73E9OsApwjqLcTsvQofQ/IWNdua7Mo
iAq5sfcMb05ymx8acMrqC7p6rKXPLVzK7D4G7w3Tg96BWmz3KsNyuKP8s/sUvWsz
1Z9RFAEwZqMQb8DWnF2hi6fObZzcnZFPmK9pkQmkeLsncFPjQC+TQpK3Aydv8YW5
UXY7/VnDYRNAfzbHrofrHSQyNk/90fgDzQpcK67OykNlwl1X+BcXfJM/VnhCWar4
l3DnP9ksAIjadsu+iE45i075dXgQc25nu2lB6+PUUERKkyMjcunTuXKwiLICBHze
/ptYQdgnOXMl5VVVGUyfGdnEI1oqk2Dl5Fr3q962fcitEkVz6B/okSlSs18q16Ov
KbfWENrnmqIn0DjK0NXdIyv/XGYEdpvVAo/KfJdhDG16N3XhIdWQ3M+P3NdHFetD
V2jHFrFbjTEGpF1pzsBXdSXX7MeOl/4/gdIooESfVPIWLg+P7+0=
=Trq/
-----END PGP SIGNATURE-----

--=-9pVAz2H4AkRFweVcW260--


