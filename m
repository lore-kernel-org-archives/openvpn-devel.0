References: <20181007150413.1455-1-a@...2181...>
 <20200422092607.16050-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b79cb4c4-b846-d07e-52ff-db9f3b2773ba@...1227...>
Date: Mon, 27 Apr 2020 03:57:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200422092607.16050-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0nSfmXqGGYuIZrnn3VHBEsDZzSWxU6WD9"
Subject: Re: [Openvpn-devel] [PATCH v9] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0nSfmXqGGYuIZrnn3VHBEsDZzSWxU6WD9
Content-Type: multipart/mixed; boundary="SSXheI3EGq4ctIcD1ExOL2rSxqehWBP2V"

--SSXheI3EGq4ctIcD1ExOL2rSxqehWBP2V
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.04.20 um 11:26 schrieb Antonio Quartulli:
> Carrying around the INLINE_TAG is not really efficient,
> because it requires a strcmp() to be performed every
> time we want to understand if the data is stored inline
> or not.
>=20
> Convert all the *_inline attributes to bool to make the
> logic easier and checks more efficient.
>=20

Look through it. It is only a minor improvement but Antonio has been
persistent enough and spend enough time to make 9 versions of this so I
took the time to look through it:

Acked-By: Arne Schwabe <arne@...2555...>

The patch is not uncrustify clean at the moment. So uncrustify should be
run on commit or we need a v10 of this patch.

The patch does not apply cleanly anymore: The test_tls_crypt.c part
should be now.

--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -549,8 +549,7 @@ test_tls_crypt_v2_write_client_key_file(void **state) {
     expect_string(__wrap_buffer_read_from_file, filename, filename);
     will_return(__wrap_buffer_read_from_file, test_client_key);

-    tls_crypt_v2_write_client_key_file(filename, NULL, INLINE_FILE_TAG,
-                                      test_server_key);
+  tls_crypt_v2_write_client_key_file(filename, NULL, test_server_key,
true);
 }

 static void
@@ -567,8 +566,7 @@
test_tls_crypt_v2_write_client_key_file_metadata(void **state) {
     expect_string(__wrap_buffer_read_from_file, filename, filename);
     will_return(__wrap_buffer_read_from_file, test_client_key_metadata);

-    tls_crypt_v2_write_client_key_file(filename, b64metadata,
INLINE_FILE_TAG,
-                                       test_server_key);
+    tls_crypt_v2_write_client_key_file(filename, NULL, test_server_key,
true);
 }




--SSXheI3EGq4ctIcD1ExOL2rSxqehWBP2V--

--0nSfmXqGGYuIZrnn3VHBEsDZzSWxU6WD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6mPCEACgkQFRhsZwKx
RFRmDQ//cVPcdct8VTZl2ToHAoTp90BjrnX/y8E4UkdtI6EVJPkgF9MttpGT7uB7
1UA5q7zZZd4nz4zpB5Fklamqdv7KdNlNPO8osZmvggSBMgietg4rDslNAWU9DkzA
KXOBcEXs3lKh6kvAsTdQuDEX4Qi7BMvBMexWM33QblfX6bOOfBN2vi/cR1FrZD99
YL+enW6R99VUP1JDv+jg5jafN41aeNuI2CmZPBtaDWojT3aPX0jTHR6n4COcV0ZL
R6+1Psw5/18Hyct1KZt6u6NhlvoMnzIiTQBRI+8JKjV+ITKOqNxVxEr3aloEVcMJ
AveQTg+/VOSTb2N/DP3N+o8eabid3ProcF/PwnYwH/tKiHrPFCGqVi7lHHxJRW85
DHyOMSWRbppqclcSU4NZTsPmUQbVTac7NwfrJrl36cc0FE0bDGgNWUeoy1a9mnoJ
j6E+8C2X75TMKGp/dKU41RjPzDci9GpN/my84uLJLzHQFD+Sttu6QhBBDEZX0Kxg
4FUFnbb/IZyVtGNA78F49cIUk4IdJU1V9FpaoDHc79QB7Qmi5raJJqOlPbYwEcq3
oUy9OA83trunyuKCysnPadAdv10u4LEEcWuRgiq71/vBU4HwizKOOyalgt57a2S2
aNFbAchgAODz1I336WJPZDWV209gYS3AzzU8kDhL8OQxYWpq+GQ=
=ZYn/
-----END PGP SIGNATURE-----

--0nSfmXqGGYuIZrnn3VHBEsDZzSWxU6WD9--

