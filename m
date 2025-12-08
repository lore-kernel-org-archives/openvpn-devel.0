From: Gert Doering <gert@...1296...>
Date: Mon,  8 Dec 2025 20:41:46 +0100
Message-ID: <20251208194151.17419-1-gert@...1296...>
In-Reply-To: <gerrit.1765213173000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
References: <gerrit.1765213173000.I5d0da76018e874cda5dbab9202a2b817ad5e4692@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] configure: Try to use pkg-config to
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

From: Frank Lichtenheld <frank@...2641...>

mbedTLS does not seem to have pkg-config support on e.g.
Debian/Ubuntu, so we definitely need to keep the
fallback check as well.

Change-Id: I5d0da76018e874cda5dbab9202a2b817ad5e4692
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20240906160510.76387-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29090.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1422
(cherry picked from commit c829f57096cb6951aa4698eff388aeebf9310334)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1422
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index bf252c9..307329d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1010,14 +1010,21 @@
 
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

