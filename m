From: Steffan Karger <steffan@...1856...>
Date: Sat, 24 Feb 2018 18:04:49 +0100
Message-Id: <20180224170449.25194-1-steffan@...1856...>
In-Reply-To: <CAKuzo_hkSd8PJsfNJ9pTNqdh8mOcaoxr-+kx_d7EayPE6+3w0w@...278...>
References: <CAKuzo_hkSd8PJsfNJ9pTNqdh8mOcaoxr-+kx_d7EayPE6+3w0w@...278...>
Subject: [Openvpn-devel] [PATCH] Warn if tls-version-max < tls-version-min
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

This adds warnings for when a user or our code tries to set a maximum
TLS version that's smaller then the current configured minimum TLS
version.

(And fixes some related whitespace now I touch it anyway.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/cryptoapi.c      | 12 +++++++++---
 src/openvpn/openssl_compat.h | 22 ++++++++++++++++++----
 src/openvpn/options.c        | 12 ++++++++++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 1097286c..28f217f4 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -610,12 +610,18 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     if ((!max_version || max_version > TLS1_1_VERSION)
         && cd->key_spec != CERT_NCRYPT_KEY_SPEC)
     {
-        msg(M_WARN,"WARNING: cryptoapicert: private key is in a legacy store."
+        msg(M_WARN, "WARNING: cryptoapicert: private key is in a legacy store."
             " Restricting TLS version to 1.1");
+        if (SSL_CTX_get_min_proto_version(ssl_ctx) > TLS1_1_VERSION)
+        {
+            msg(M_NONFATAL,
+                "ERROR: cryptoapicert: min TLS version larger than 1.1."
+                " Try config option --tls-version-min 1.1");
+            goto err;
+        }
         if (!SSL_CTX_set_max_proto_version(ssl_ctx, TLS1_1_VERSION))
         {
-            msg(M_NONFATAL,"ERROR: cryptoapicert: unable to set max TLS version"
-                " to 1.1. Try config option --tls-version-min 1.1");
+            msg(M_NONFATAL, "ERROR: cryptoapicert: set max TLS version failed");
             goto err;
         }
     }
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8ef86649..d375fabd 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -662,10 +662,24 @@ EC_GROUP_order_bits(const EC_GROUP *group)
 #endif
 
 #ifndef SSL_CTX_get_min_proto_version
-/** Dummy SSL_CTX_get_min_proto_version for OpenSSL < 1.1 (not really needed) */
+/** Return the min SSL protocol version currently enabled in the context.
+ *  If no valid version >= TLS1.0 is found, return 0. */
 static inline int
 SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
 {
+    long sslopt = SSL_CTX_get_options(ctx);
+    if (!(sslopt & SSL_OP_NO_TLSv1))
+    {
+        return TLS1_VERSION;
+    }
+    if (!(sslopt & SSL_OP_NO_TLSv1_1))
+    {
+        return TLS1_1_VERSION;
+    }
+    if (!(sslopt & SSL_OP_NO_TLSv1_2))
+    {
+        return TLS1_2_VERSION;
+    }
     return 0;
 }
 #endif /* SSL_CTX_get_min_proto_version */
@@ -679,15 +693,15 @@ SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
     long sslopt = SSL_CTX_get_options(ctx);
     if (!(sslopt & SSL_OP_NO_TLSv1_2))
     {
-	return TLS1_2_VERSION;
+        return TLS1_2_VERSION;
     }
     if (!(sslopt & SSL_OP_NO_TLSv1_1))
     {
-	return TLS1_1_VERSION;
+        return TLS1_1_VERSION;
     }
     if (!(sslopt & SSL_OP_NO_TLSv1))
     {
-	return TLS1_VERSION;
+        return TLS1_VERSION;
     }
     return 0;
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 95fb4de3..41a42cf2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2522,6 +2522,18 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
             "in the configuration file, which is the recommended approach.");
     }
 
+    const int tls_version_max =
+        (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
+        & SSLF_TLS_VERSION_MAX_MASK;
+    const int tls_version_min =
+        (options->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
+        & SSLF_TLS_VERSION_MIN_MASK;
+
+    if (tls_version_max > 0 && tls_version_max < tls_version_min)
+    {
+        msg(M_USAGE, "--tls-version-min bigger than --tls-version-max");
+    }
+
     if (options->tls_server || options->tls_client)
     {
 #ifdef ENABLE_PKCS11
-- 
2.14.1


