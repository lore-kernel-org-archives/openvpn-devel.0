From: Steffan Karger <steffan@...1856...>
Date: Sat, 30 Dec 2017 12:02:39 +0100
Message-Id: <20171230110239.12382-1-steffan@...1856...>
In-Reply-To: <20171130085330.mftz2f3vnx53vrz6@...2352...>
References: <20171130085330.mftz2f3vnx53vrz6@...2352...>
Subject: [Openvpn-devel] [PATCH 1/3 v2] Fix --tls-version-min and
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
v2: fix define name, obey system lib default minimum version

Note: this patch does not cherry-pick to release/2.4 nicely.  Once the one
for master has been accepted, I'll send a backport for release/2.4.

 src/openvpn/openssl_compat.h | 63 ++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    | 86 +++++++++++++++++++++++++-------------------
 2 files changed, 113 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 70b19aea..2a6c98d9 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -647,4 +647,67 @@ EC_GROUP_order_bits(const EC_GROUP *group)
 #define RSA_F_RSA_OSSL_PRIVATE_ENCRYPT       RSA_F_RSA_EAY_PRIVATE_ENCRYPT
 #endif
 
+#ifndef SSL_CTX_get_min_proto_version
+/** Dummy SSL_CTX_get_min_proto_version for OpenSSL < 1.1 (not really needed) */
+static inline int
+SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
+{
+    return 0;
+}
+#endif /* SSL_CTX_get_min_proto_version */
+
+#ifndef SSL_CTX_set_min_proto_version
+/** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
+static inline void
+SSL_CTX_set_min_proto_version(SSL_CTX *ctx, long tls_ver_min)
+{
+    long sslopt = SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3; /* Never do < TLS 1.0 */
+
+    if (tls_ver_min > TLS1_VERSION)
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
+    if (tls_ver_max < TLS1_VERSION)
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
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 34c31b9d..9d5cd5ec 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -206,15 +206,56 @@ info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int where, int ret)
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
+    int tls_ver_min = openssl_tls_version(
+        (ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERSION_MIN_MASK);
+    int tls_ver_max = openssl_tls_version(
+        (ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERSION_MAX_MASK);
+
+    if (!tls_ver_min)
+    {
+        /* Enforce at least TLS 1.0 */
+        int cur_min = SSL_CTX_get_min_proto_version(ctx->ctx);
+        tls_ver_min = cur_min < TLS1_VERSION ? TLS_VER_1_0 : cur_min;
+    }
+    SSL_CTX_set_min_proto_version(ctx->ctx, tls_ver_min);
+
+    if (tls_ver_max)
+    {
+        SSL_CTX_set_max_proto_version(ctx->ctx, tls_ver_max);
+    }
+}
+
 void
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
@@ -223,42 +264,15 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
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


