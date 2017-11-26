From: Steffan Karger <steffan@...1856...>
Date: Sun, 26 Nov 2017 15:15:53 +0100
Message-Id: <20171126141555.25930-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/3] Fix --tls-version-min and
 --tls-version-max for OpenSSL 1.1+
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

As described in <80e6b449-c536-dc87-7215-3693872bce5a@...376...> on
the openvpn-devel mailing list, --tls-version-min no longer works with
OpenSSL 1.1.  Kurt Roeckx posted in a debian bug report:

"This is marked as important because if you switch to openssl 1.1.0
the defaults minimum version in Debian is currently TLS 1.2 and
you can't override it with the options that you're currently using
(and are deprecated)."

This patch is loosely based on the original patch by Kurt, but solves the
issue by adding functions to openssl-compat.h, like we also did for all
other openssl 1.1. breakage.  This results in not having to add more ifdefs
in ssl_openssl.c and thus cleaner code.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/openssl_compat.h | 65 ++++++++++++++++++++++++++++++++++++
 src/openvpn/options.c        |  1 +
 src/openvpn/ssl_openssl.c    | 79 ++++++++++++++++++++++++--------------------
 3 files changed, 109 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 70b19aea..c9b6a179 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -647,4 +647,69 @@ EC_GROUP_order_bits(const EC_GROUP *group)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif
 
+/* TLS Version defines are new in OpenSSL 1.1 */
+#ifndef TLS1_0_VERSION
+#define TLS1_0_VERSION 0x0301
+#endif
+#ifndef TLS1_1_VERSION
+#define TLS1_1_VERSION 0x0302
+#endif
+#ifndef TLS1_2_VERSION
+#define TLS1_2_VERSION 0x0303
+#endif
+
+#ifndef SSL_CTX_set_min_proto_version
+/** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
+static inline void
+SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
+{
+    long sslopt = SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never do < TLS 1.0 */
+
+    if (tls_ver_min > TLS1_0_VERSION)
+    {
+        sslopt |= SSL_OP_NO_TLSv1;
+    }
+#ifdef SSL_OP_NO_TLSv1_1
+    if (tls_ver_min > TLS1_1_VERSION)
+    {
+        sslopt |= SSL_OP_NO_TLSv1_1;
+    }
+#endif
+#ifdef SSL_OP_NO_TLSv1_2
+    if (tls_ver_min > TLS1_2_VERSION)
+    {
+        sslopt |= SSL_OP_NO_TLSv1_2;
+    }
+#endif
+    SSL_CTX_set_options(ctx, sslopt);
+}
+#endif /* SSL_CTX_set_min_proto_version */
+
+#ifndef SSL_CTX_set_max_proto_version
+/** Mimics SSL_CTX_set_max_proto_version for OpenSSL < 1.1 */
+static inline void
+SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
+{
+    long sslopt = 0;
+
+    if (tls_ver_max < TLS1_0_VERSION)
+    {
+        sslopt |= SSL_OP_NO_TLSv1;
+    }
+#ifdef SSL_OP_NO_TLSv1_1
+    if (tls_ver_max < TLS1_1_VERSION)
+    {
+        sslopt |= SSL_OP_NO_TLSv1_1;
+    }
+#endif
+#ifdef SSL_OP_NO_TLSv1_2
+    if (tls_ver_max < TLS1_2_VERSION)
+    {
+        sslopt |= SSL_OP_NO_TLSv1_2;
+    }
+#endif
+    SSL_CTX_set_options(ctx, sslopt);
+}
+#endif /* SSL_CTX_set_max_proto_version */
+
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8e5cdf7f..81646336 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -870,6 +870,7 @@ init_options(struct options *o, const bool init_gc)
 #ifdef ENABLE_PREDICTION_RESISTANCE
     o->use_prediction_resistance = false;
 #endif
+    o->ssl_flags = (TLS_VER_1_0 << SSLF_TLS_VERSION_MIN_SHIFT);
     o->key_method = 2;
     o->tls_timeout = 2;
     o->renegotiate_bytes = -1;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b782946e..b645b469 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -206,15 +206,49 @@ info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int where, int ret)
 int
 tls_version_max(void)
 {
-#if defined(SSL_OP_NO_TLSv1_2)
+#if defined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
     return TLS_VER_1_2;
-#elif defined(SSL_OP_NO_TLSv1_1)
+#elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
     return TLS_VER_1_1;
 #else
     return TLS_VER_1_0;
 #endif
 }
 
+/** Convert internal version number to openssl version number */
+static int
+openssl_tls_version(int ver)
+{
+    if (ver == TLS_VER_1_0)
+    {
+        return TLS1_VERSION;
+    }
+    else if (ver == TLS_VER_1_1)
+    {
+        return TLS1_1_VERSION;
+    }
+    else if (ver == TLS_VER_1_2)
+    {
+        return TLS1_2_VERSION;
+    }
+    return 0;
+}
+
+static void
+tls_ctx_set_tls_versions(struct tls_root_ctx *ctx, unsigned int ssl_flags)
+{
+    const int tls_ver_min =
+        (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
+    const int tls_ver_max =
+        (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
+
+    SSL_CTX_set_min_proto_version(ctx->ctx, openssl_tls_version(tls_ver_min));
+    if (tls_ver_max != TLS_VER_UNSPEC)
+    {
+        SSL_CTX_set_max_proto_version(ctx->ctx, openssl_tls_version(tls_ver_max));
+    }
+}
+
 void
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
@@ -223,42 +257,15 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
     /* default certificate verification flags */
     int flags = SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
 
-    /* process SSL options including minimum TLS version we will accept from peer */
-    {
-        long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET | SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3;
-        int tls_ver_max = TLS_VER_UNSPEC;
-        const int tls_ver_min =
-            (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK;
-
-        tls_ver_max =
-            (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK;
-        if (tls_ver_max <= TLS_VER_UNSPEC)
-        {
-            tls_ver_max = tls_version_max();
-        }
-
-        if (tls_ver_min > TLS_VER_1_0 || tls_ver_max < TLS_VER_1_0)
-        {
-            sslopt |= SSL_OP_NO_TLSv1;
-        }
-#ifdef SSL_OP_NO_TLSv1_1
-        if (tls_ver_min > TLS_VER_1_1 || tls_ver_max < TLS_VER_1_1)
-        {
-            sslopt |= SSL_OP_NO_TLSv1_1;
-        }
-#endif
-#ifdef SSL_OP_NO_TLSv1_2
-        if (tls_ver_min > TLS_VER_1_2 || tls_ver_max < TLS_VER_1_2)
-        {
-            sslopt |= SSL_OP_NO_TLSv1_2;
-        }
-#endif
+    /* process SSL options */
+    long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
-        sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
+    sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif
-        sslopt |= SSL_OP_NO_COMPRESSION;
-        SSL_CTX_set_options(ctx->ctx, sslopt);
-    }
+    sslopt |= SSL_OP_NO_COMPRESSION;
+    SSL_CTX_set_options(ctx->ctx, sslopt);
+
+    tls_ctx_set_tls_versions(ctx, ssl_flags);
 
 #ifdef SSL_MODE_RELEASE_BUFFERS
     SSL_CTX_set_mode(ctx->ctx, SSL_MODE_RELEASE_BUFFERS);
-- 
2.14.1


