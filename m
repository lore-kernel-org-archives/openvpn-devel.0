From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 16 Jul 2025 17:18:57 +0200
Message-Id: <20250716151857.385959-1-frank@...2641...>
In-Reply-To: <gerrit.1752674908000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
References: <gerrit.1752674908000.I317be5253d6563906dd3826421dc81f737beba76@...2715...>
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1088
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/configure.ac b/configure.ac
index 8fc48ba..66cb79b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -798,14 +798,6 @@
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
@@ -1014,13 +1006,12 @@
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
@@ -1359,7 +1350,12 @@
 
 AM_CONDITIONAL([HAVE_SOFTHSM2], [false])
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

