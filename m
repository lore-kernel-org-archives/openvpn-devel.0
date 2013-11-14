Message-ID: <5284F32D.3000206@...1085...>
Date: Thu, 14 Nov 2013 09:58:37 -0600
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010104020403010805030307"
Subject: [Openvpn-devel] [PATCH] Require a 1.2.x PolarSSL version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010104020403010805030307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When used with PolarSSL, OpenVPN requires a library version 1.2.x (and
not later.)

The attached patch fixes bug#343.

- --
Josh Cepek

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJShPMtAAoJENcx2Xpgb9RjfvkL/0R/n9dbIE59ox8M7TH6dsIZ
yG8Sd0syIjZANwqti1WSwYjKI3cTnngTQH0piFaxPm37p+fj2ZudkggXnlzRvdBN
GXdE3c1PDo13rGVKLopTUZ1pmX4zVHvCRkhhQaI6d6MFDqWauBUawIIEEmyen/xx
jhgYJIzLYYaMN5Aent/yxScPleuze1d9b3cxoKsLNHLqcpj7WaN08YHW5It8KYWG
2AFFfrfvnpqSxO2ksP4AK/N2BRsAHOhmj1VCr5nQm59RrNB7PV5+aMBai3Rk8aMH
xfkjSML6Y/vJ9vn/NZ2ohFKoobK7MpLnmHbp5VMfzUSiu3ew46euXyRorJRS4FQW
xq3i73DbDiRJziJNvKsbT9qSEfqTcQY/7XhLwVdFPuZmL7bcTICeClz4TCqV9BrB
8kIIrGE9Q6cuM553/mWy/7SmnFDmaYSi3Tpeg18gXUB9TvH9eTpbgwr0cNwNAl/P
S/N/pgU5owhhi59saD7Ao6tMD+nHTtiS2QMgnZF10A==
=wH4G
-----END PGP SIGNATURE-----

--------------010104020403010805030307
Content-Type: text/x-diff; name="0001-Require-a-1.2.x-PolarSSL-version.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Require-a-1.2.x-PolarSSL-version.patch"

From 7ab2fcdbf75f37e86ba6f9d23bedf0d33547c59f Mon Sep 17 00:00:00 2001
From: Josh Cepek <josh.cepek@...1085...>
Date: Thu, 14 Nov 2013 12:02:59 -0600
Subject: [PATCH] Require a 1.2.x PolarSSL version

Upstream policy on PolarSSL API compatibility does not guarantee
stability between point-releases. For OpenVPN, we must verify a 1.2.x
version with the current codebase.

This fixes bug#343.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5fad0af..b181f6d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -814,13 +814,13 @@ if test "${with_crypto_library}" = "polarssl" ; then
 #include <polarssl/version.h>
 			]],
 			[[
-#if POLARSSL_VERSION_NUMBER < 0x01020A00
+#if POLARSSL_VERSION_NUMBER < 0x01020A00 || POLARSSL_VERSION_NUMBER >= 0x01030000
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([PolarSSL 1.2.10 or newer required])]
+		[AC_MSG_ERROR([PolarSSL 1.2.x required and must be 1.2.10 or later])]
 	)
 
 	polarssl_with_pkcs11="no"
-- 
1.8.1.5


--------------010104020403010805030307
Content-Type: application/pgp-signature;
	name="0001-Require-a-1.2.x-PolarSSL-version.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-Require-a-1.2.x-PolarSSL-version.patch.sig"

iQGcBAABAgAGBQJShPI3AAoJENcx2Xpgb9RjYv0L/RNRqNNTqhv+XPFAVpeeq8ITCJvS/Af2
jh02SGPEhWVlVxhZAwGmaQXy570JOjxuRn89V6tvSWlugO6R1ultGbO6T1n1h9wQBfjpbGD0
R2sBwc1KzqDJhKArEOj/Nef3EgdBVz6afQE40tECYHLr3912pB692zV94VaJQTJtVnosg/+D
bJWe/Y3X8AeYPRkdJ6f+GkodOqPqQWVg0nfJIcfL20XAd7kGRWwb9wSiX8aOASXn81l9ID39
edCp8owit2ykMyYWuLTKWZGq0xfKJiqS5OuQ5nnYaPRFbwA5l7qFb2uQZhKYuS8YVhWKHhLF
uZZkqLNraeylJV98J3OjrFCJxoB0oOn3BvO8Km85Xc5GmPS5D1a2INhsEcblH3pStSKMmJrQ
sTljLX/Foo/l1NYP4tMwhCeuBHxLBP9rsh61CdKr4iRVwiaTHMKynxASDBGGDhoXvFlnlReV
ESyAOhbbO8DIF1O/hssrNNda8mgKvEE8BUv77NAQeF0Fo6crDw==
--------------010104020403010805030307--

