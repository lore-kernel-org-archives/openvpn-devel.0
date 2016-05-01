From: Steffan Karger <steffan@...1856...>
Date: Sun,  1 May 2016 20:23:06 +0200
Message-Id: <1462126986-2686-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] configure.ac: link to all mbed TLS libs
	during library detection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

When for some reason the dependencies of the compiled mbed TLS libaries
(libmbedtls, libmbedcrypto and libmbedx509) are not correct, the configure
script will fail to link against libmbedcrypto and/or libmbedx509.  This
is reported to happen after using 'make install' to install mbedtls.

This patch makes sure the configure tests link to all three.  The build
process itself already did.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 3b8bf96..f1dc8af 100644
--- a/configure.ac
+++ b/configure.ac
@@ -843,7 +843,8 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 	saved_LIBS="${LIBS}"
 
 	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
-	# if the user did not explicitly specify flags, try to autodetect
+		# if the user did not explicitly specify flags, try to autodetect
+		LIBS="${LIBS} -lmbedtls -lmbedcrypto -lmbedx509"
 		AC_CHECK_LIB(
 			[mbedtls],
 			[mbedtls_ssl_init],
-- 
2.7.4


