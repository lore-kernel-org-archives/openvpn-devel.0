From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  6 Sep 2024 18:05:10 +0200
Message-Id: <20240906160510.76387-1-frank@...2641...>
In-Reply-To: <gerrit.1719507190000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
References: <gerrit.1719507190000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] configure: Try to use pkg-config to
 detect mbedTLS
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
Cc: Yuriy Darnobyt <yura.uddr@...277...>

mbedTLS does not seem to have pkg-config support on e.g.
Debian/Ubuntu, so we definitely need to keep the
fallback check as well.

Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/671
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/configure.ac b/configure.ac
index 9ce826c..2d74021 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1000,14 +1000,21 @@
 
 	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
 		# if the user did not explicitly specify flags, try to autodetect
-		LIBS="${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"
-		AC_CHECK_LIB(
-			[mbedtls],
-			[mbedtls_ssl_init],
-			[MBEDTLS_LIBS="-lmbedtls -lmbedx509 -lmbedcrypto"],
-			[AC_MSG_ERROR([Could not find mbed TLS.])],
-			[${PKCS11_HELPER_LIBS}]
+		PKG_CHECK_MODULES([MBEDTLS],
+			[mbedtls >= 2.0.0 mbedx509 >= 2.0.0 mbedcrypto >= 2.0.0],
+			[have_mbedtls="yes"],
+			[LIBS="${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"]
 		)
+		# mbedtls might not have pkgconfig integration, so try manually
+                if test "${have_mbedtls}" != "yes"; then
+			AC_CHECK_LIB(
+				[mbedtls],
+				[mbedtls_ssl_init],
+				[MBEDTLS_LIBS="-lmbedtls -lmbedx509 -lmbedcrypto"],
+				[AC_MSG_ERROR([Could not find mbed TLS.])],
+				[${PKCS11_HELPER_LIBS}]
+			)
+		fi
 	fi
 
 	CFLAGS="${MBEDTLS_CFLAGS} ${PKCS11_HELPER_CFLAGS} ${CFLAGS}"

