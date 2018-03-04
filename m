From: selva.nair@...277...
Date: Sun,  4 Mar 2018 12:44:02 -0500
Message-Id: <1520185442-22901-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Do not assume that
 SSL_CTX_get/set_min/max_proto_version are macros
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

From: Selva Nair <selva.nair@...277...>

Openssl docs do not explicitly state these to be macros although they
are currently defined as such. Use AC_CHECK_DECLS to test for these so that
both function and macro forms could be detected.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Though not meant as a fixup for libressl, as a side effect
this also makes 2.4.5 build with newer libressl versions.
(built on freebsd 11 using libressl 2.6.4 while testing patch 238)
Notes: (i) libressl defines only the set functions and neither
are macros. So get functions will get used from the compat layer.

 configure.ac                 | 12 ++++++++++++
 src/openvpn/openssl_compat.h |  8 ++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 626b4dd..2a8e87f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -948,6 +948,18 @@ if test "${with_crypto_library}" = "openssl"; then
 			EC_GROUP_order_bits
 		]
 	)
+	AC_CHECK_DECLS(
+		[
+			SSL_CTX_get_min_proto_version,
+			SSL_CTX_get_max_proto_version,
+			SSL_CTX_set_min_proto_version,
+			SSL_CTX_set_max_proto_version,
+		],
+		,
+		,
+		[[#include <openssl/ssl.h>]]
+
+	)
 
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index d375fab..340d452 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -661,7 +661,7 @@ EC_GROUP_order_bits(const EC_GROUP *group)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif
 
-#ifndef SSL_CTX_get_min_proto_version
+#if !HAVE_DECL_SSL_CTX_GET_MIN_PROTO_VERSION
 /** Return the min SSL protocol version currently enabled in the context.
  *  If no valid version >= TLS1.0 is found, return 0. */
 static inline int
@@ -684,7 +684,7 @@ SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
 }
 #endif /* SSL_CTX_get_min_proto_version */
 
-#ifndef SSL_CTX_get_max_proto_version
+#if !HAVE_DECL_SSL_CTX_GET_MAX_PROTO_VERSION
 /** Return the max SSL protocol version currently enabled in the context.
  *  If no valid version >= TLS1.0 is found, return 0. */
 static inline int
@@ -707,7 +707,7 @@ SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
 }
 #endif /* SSL_CTX_get_max_proto_version */
 
-#ifndef SSL_CTX_set_min_proto_version
+#if !HAVE_DECL_SSL_CTX_SET_MIN_PROTO_VERSION
 /** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
 static inline int
 SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
@@ -736,7 +736,7 @@ SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
 }
 #endif /* SSL_CTX_set_min_proto_version */
 
-#ifndef SSL_CTX_set_max_proto_version
+#if !HAVE_DECL_SSL_CTX_SET_MAX_PROTO_VERSION
 /** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
 static inline int
 SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
-- 
2.1.4


