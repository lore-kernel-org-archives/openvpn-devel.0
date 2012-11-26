From: Joachim Schipper <joachim.schipper@...1435...>
Date: Mon, 26 Nov 2012 15:32:21 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901323D0B186@...1436...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix typo in ./configure message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 configure.ac |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index d3d974d..2f780b7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -934,7 +934,7 @@ if test "${enable_ssl}" =3D "yes"; then
 fi
=20
 if test "${enable_crypto}" =3D "yes"; then
-	test "${have_crypto_crypto}" !=3D "yes" && AC_MSG_ERROR([${with_crypto_li=
brary} crytpo is required but missing])
+	test "${have_crypto_crypto}" !=3D "yes" && AC_MSG_ERROR([${with_crypto_li=
brary} crypto is required but missing])
 	OPTIONAL_CRYPTO_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CRYPTO_CFLAG=
S}"
 	OPTIONAL_CRYPTO_LIBS=3D"${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_CRYPTO_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
--=20
1.7.9.5


