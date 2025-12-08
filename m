From: Gert Doering <gert@...1296...>
Date: Mon,  8 Dec 2025 20:42:37 +0100
Message-ID: <20251208194242.17520-1-gert@...1296...>
In-Reply-To: <gerrit.1765213173000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
References: <gerrit.1765213173000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] configure.ac: Remove use of
 PKCS11_HELPER_LIBS in mbedTLS checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

This code was copied over and over since many years,
since commit 9a3f670248d6f519a399e65a7232e2196b5115db
("Fixed autoconf script to properly detect missing pkcs11
with polarssl"). It is unclear what exact purpose it
served back then but probably it is obsolete. It is
definitely wrong since it means that you get
PKCS11_HELPER_LIBS even if you do not specify
--enable-pkcs11.

Change-Id: I317be5253d6563906dd3826421dc81f737beba76
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20250716151857.385959-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32187.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1423
(cherry picked from commit ed690d1d58792f70b86b75b00c09df2ad96babca)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1423
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index 307329d..e77fd47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -801,14 +801,6 @@
 		;;
 esac
 
-PKG_CHECK_MODULES(
-	[PKCS11_HELPER],
-	[libpkcs11-helper-1 >= 1.11],
-	[have_pkcs11_helper="yes"],
-	[]
-)
-
-
 if test "$enable_dco" != "no"; then
 	enable_dco_arg="$enable_dco"
 	if test "${enable_iproute2}" = "yes"; then
@@ -1022,13 +1014,12 @@
 				[mbedtls_ssl_init],
 				[MBEDTLS_LIBS="-lmbedtls -lmbedx509 -lmbedcrypto"],
 				[AC_MSG_ERROR([Could not find mbed TLS.])],
-				[${PKCS11_HELPER_LIBS}]
 			)
 		fi
 	fi
 
-	CFLAGS="${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"
-	LIBS="${MBEDTLS_LIBS} ${PKCS11_HELPER_LIBS} ${LIBS}"
+	CFLAGS="${MBEDTLS_CFLAGS} ${CFLAGS}"
+	LIBS="${MBEDTLS_LIBS} ${LIBS}"
 
 	AC_MSG_CHECKING([mbedtls version])
 	AC_COMPILE_IFELSE(
@@ -1399,7 +1390,12 @@
 fi
 
 if test "${enable_pkcs11}" = "yes"; then
-	test "${have_pkcs11_helper}" != "yes" && AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])
+	PKG_CHECK_MODULES(
+		[PKCS11_HELPER],
+		[libpkcs11-helper-1 >= 1.11],
+		[have_pkcs11_helper="yes"],
+		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])]
+	)
 	OPTIONAL_PKCS11_HELPER_CFLAGS="${PKCS11_HELPER_CFLAGS}"
 	OPTIONAL_PKCS11_HELPER_LIBS="${PKCS11_HELPER_LIBS}"
 	AC_DEFINE([ENABLE_PKCS11], [1], [Enable PKCS11])

