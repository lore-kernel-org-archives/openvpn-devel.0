From: Steffan Karger <steffan@...1856...>
Date: Mon, 18 Jan 2016 21:49:40 +0100
Message-Id: <1453150181-21453-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] configure.ac: fix polarssl autodetection
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

A missing , in the previous configure.ac patch caused the autodetection to
fail.  While fixing that, I noticed I can simplify the check by using the
documented ${ac_cv_search_function} cache variable instead of the nested
AC_SEARCH_LIBS.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 73dd032..7ff2435 100644
--- a/configure.ac
+++ b/configure.ac
@@ -832,30 +832,28 @@ elif test "${with_crypto_library}" = "polarssl"; then
 	AC_ARG_VAR([POLARSSL_CFLAGS], [C compiler flags for polarssl])
 	AC_ARG_VAR([POLARSSL_LIBS], [linker flags for polarssl])
 
+	saved_CFLAGS="${CFLAGS}"
+	saved_LIBS="${LIBS}"
+
 	if test -z "${POLARSSL_CFLAGS}" -a -z "${POLARSSL_LIBS}"; then
         # if the user did not explicitly specify flags, try to autodetect
 		AC_SEARCH_LIBS(
 			[ssl_init],
-			[mbedtls],
-			[POLARSSL_LIBS=-lmbedtls]
+			[mbedtls polarssl],
 			[
-				AC_SEARCH_LIBS(
-					[ssl_init],
-					[polarssl],
-					[POLARSSL_LIBS=-lpolarssl]
-					[],
-					[${PKCS11_HELPER_LIBS}]
-				)
+				if test "${ac_cv_search_ssl_init}" != "none required"; then
+					POLARSSL_LIBS=${ac_cv_search_ssl_init}
+				fi
 			],
+			[AC_MSG_ERROR([Could not find PolarSSL/mbed TLS.])],
 			[${PKCS11_HELPER_LIBS}]
 		)
 	fi
 
-	AC_MSG_CHECKING([polarssl version])
-	saved_CFLAGS="${CFLAGS}"
-	saved_LIBS="${LIBS}"
 	CFLAGS="${POLARSSL_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"
 	LIBS="${POLARSSL_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}"
+
+	AC_MSG_CHECKING([polarssl version])
 	AC_COMPILE_IFELSE(
 		[AC_LANG_PROGRAM(
 			[[
-- 
2.5.0


