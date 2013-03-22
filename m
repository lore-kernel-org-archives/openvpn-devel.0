From: <steffan.karger@...1435...>
Date: Fri, 22 Mar 2013 09:54:25 +0100
Message-ID: <1363942465-3251-7-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
References: <1363942465-3251-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/6] Fixed autoconf script to properly
	detect missing pkcs11 with polarssl.
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

From: Steffan Karger <steffan.karger@...1435...>

When polarssl is compiled without pkcs11 support, or a required
pkcs11-helper library is missing, configure will now issue an error.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac |   54 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index 785fc4e..7b35e50 100644
--- a/configure.ac
+++ b/configure.ac
@@ -726,6 +726,13 @@ case "${with_mem_check}" in
 esac
 
 PKG_CHECK_MODULES(
+	[PKCS11_HELPER],
+	[libpkcs11-helper-1 >= 1.02],
+	[have_pkcs11_helper="yes"],
+	[]
+)
+
+PKG_CHECK_MODULES(
 	[OPENSSL_CRYPTO],
 	[libcrypto >= 0.9.6],
 	[have_openssl_crypto="yes"],
@@ -789,9 +796,11 @@ if test -z "${POLARSSL_LIBS}"; then
 				[polarssl],
 				[aes_crypt_cbc],
 				,
-				[have_polarssl_crypto="no"]
+				[have_polarssl_crypto="no"],
+				[${PKCS11_HELPER_LIBS}]
 			)
-		]
+		],
+		[${PKCS11_HELPER_LIBS}]
 	)
 fi
 
@@ -806,14 +815,44 @@ if test "${with_crypto_library}" = "polarssl" ; then
 			]],
 			[[
 #if POLARSSL_VERSION_NUMBER < 0x01020500
-#error invalid version PolarSSL-1.2.5 or newer required
+#error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([invalid polarssl version])]
+		[AC_MSG_ERROR([PolarSSL 1.2.5 or newer required])]
 	)
+
+	polarssl_with_pkcs11="no"
+	AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM(
+			[[
+#include <polarssl/config.h>
+			]],
+			[[
+#ifndef POLARSSL_PKCS11_C
+#error pkcs11 wrapper missing
+#endif
+			]]
+		)],
+		polarssl_with_pkcs11="yes")
 	CFLAGS="${old_CFLAGS}"
+
+	AC_MSG_CHECKING([polarssl pkcs11 support])
+	if test "${enable_pkcs11}" = "yes"; then
+		if test "${polarssl_with_pkcs11}" = "yes"; then
+			AC_MSG_RESULT([ok])
+		else
+			AC_MSG_ERROR([polarssl has no pkcs11 wrapper compiled in])
+		fi
+	else
+		if test "${polarssl_with_pkcs11}" != "yes"; then
+			AC_MSG_RESULT([ok])
+		else
+			AC_MSG_ERROR([PolarSSL compiled with PKCS11, while OpenVPN is not])
+		fi
+	fi
+
 fi
 
 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
@@ -856,13 +895,6 @@ if test "${have_lzo}" = "yes"; then
 	CFLAGS="${saved_CFLAGS}"
 fi
 
-PKG_CHECK_MODULES(
-	[PKCS11_HELPER],
-	[libpkcs11-helper-1 >= 1.02],
-	[have_pkcs11_helper="yes"],
-	[]
-)
-
 AC_MSG_CHECKING([git checkout])
 GIT_CHECKOUT="no"
 if test -n "${GIT}" -a -d "${srcdir}/.git"; then
-- 
1.7.9.5


