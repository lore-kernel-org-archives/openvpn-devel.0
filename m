From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:15 -0500
Message-Id: <20211214165928.30676-6-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 05/18] Initialize the xkey provider and
 use it in SSL context
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

- Add function to check when external key is in use

- Load xkey provider into a custom library context when required

- Use the custom libctx in SSL CTX when external key is in use

As no keys are yet loaded through the provider,
no functionality gets delegated to it as yet.

v2 changes: Provider loading is reworked to activate only when external
            keys are in use
            This was 2/9 in v1

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/openssl_compat.h |  8 ++++
 src/openvpn/options.c        | 16 +++++++
 src/openvpn/options.h        |  2 +
 src/openvpn/ssl.c            |  5 ++
 src/openvpn/ssl.h            |  6 +++
 src/openvpn/ssl_mbedtls.c    |  6 +++
 src/openvpn/ssl_openssl.c    | 93 +++++++++++++++++++++++++++++++++++-
 src/openvpn/xkey_common.h    |  1 -
 8 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index dcc210c7..5c9da9eb 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -760,6 +760,14 @@ int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
 #define EVP_CIPHER_get0_name EVP_CIPHER_name
 #define EVP_CIPHER_CTX_get_mode EVP_CIPHER_CTX_mode
 
+/** Reduce SSL_CTX_new_ex() to SSL_CTX_new() for OpenSSL < 3 */
+#define SSL_CTX_new_ex(libctx, propq, method)                \
+        SSL_CTX_new((method))
+
+/* Some safe typedefs to avoid too many ifdefs */
+typedef void OSSL_LIB_CTX;
+typedef void OSSL_PROVIDER;
+
 /* Mimics the functions but only when the default context without
  * options is chosen */
 static inline const EVP_CIPHER *
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b840b767..fb427410 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5337,6 +5337,22 @@ show_compression_warning(struct compress_options *info)
 }
 #endif
 
+bool key_is_external(const struct options *options)
+{
+    bool ret = false;
+#ifdef ENABLE_MANAGEMENT
+    ret = ret || (options->management_flags & MF_EXTERNAL_KEY);
+#endif
+#ifdef ENABLE_PKCS11
+    ret = ret || (options->pkcs11_providers[0] != NULL);
+#endif
+#ifdef ENABLE_CRYPTOAPI
+    ret = ret || options->cryptoapi_cert;
+#endif
+
+    return ret;
+}
+
 static void
 add_option(struct options *options,
            char *p[],
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d4f41cd7..8dc06343 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -862,4 +862,6 @@ void options_string_import(struct options *options,
                            unsigned int *option_types_found,
                            struct env_set *es);
 
+bool key_is_external(const struct options *options);
+
 #endif /* ifndef OPTIONS_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 05096ee0..0c4e3234 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -603,6 +603,11 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool in_ch
 
     tls_clear_error();
 
+    if (key_is_external(options))
+    {
+        load_xkey_provider();
+    }
+
     if (options->tls_server)
     {
         tls_ctx_server_new(new_ctx);
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index b14453fe..784ddd32 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -627,4 +627,10 @@ show_available_tls_ciphers(const char *cipher_list,
 bool
 tls_session_generate_data_channel_keys(struct tls_session *session);
 
+/**
+ * Load ovpn.xkey provider used for external key signing
+ */
+void
+load_xkey_provider(void);
+
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 94605801..15cd8b16 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1550,4 +1550,10 @@ get_ssl_library_version(void)
     return mbedtls_version;
 }
 
+void
+load_xkey_provider(void)
+{
+    return; /* no external key provider in mbedTLS build */
+}
+
 #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 724664bb..bdaa7a2b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -45,6 +45,7 @@
 #include "ssl_common.h"
 #include "base64.h"
 #include "openssl_compat.h"
+#include "xkey_common.h"
 
 #ifdef ENABLE_CRYPTOAPI
 #include "cryptoapi.h"
@@ -69,6 +70,10 @@
 #include <openssl/applink.c>
 #endif
 
+static OSSL_LIB_CTX *tls_libctx;
+
+static void unload_xkey_provider(void);
+
 /*
  * Allocate space in SSL objects in which to store a struct tls_session
  * pointer back to parent.
@@ -113,7 +118,7 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
 
-    ctx->ctx = SSL_CTX_new(SSLv23_server_method());
+    ctx->ctx = SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_server_method());
 
     if (ctx->ctx == NULL)
     {
@@ -131,7 +136,7 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
 
-    ctx->ctx = SSL_CTX_new(SSLv23_client_method());
+    ctx->ctx = SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());
 
     if (ctx->ctx == NULL)
     {
@@ -150,6 +155,7 @@ tls_ctx_free(struct tls_root_ctx *ctx)
     ASSERT(NULL != ctx);
     SSL_CTX_free(ctx->ctx);
     ctx->ctx = NULL;
+    unload_xkey_provider(); /* in case it is loaded */
 }
 
 bool
@@ -2284,4 +2290,87 @@ get_ssl_library_version(void)
     return OpenSSL_version(OPENSSL_VERSION);
 }
 
+
+/** Some helper routines for provider load/unload */
+#ifdef HAVE_XKEY_PROVIDER
+static int
+provider_load(OSSL_PROVIDER *prov, void *dest_libctx)
+{
+    const char *name = OSSL_PROVIDER_get0_name(prov);
+    OSSL_PROVIDER_load(dest_libctx, name);
+    return 1;
+}
+
+static int
+provider_unload(OSSL_PROVIDER *prov, void *unused)
+{
+    (void) unused;
+    OSSL_PROVIDER_unload(prov);
+    return 1;
+}
+#endif /* HAVE_XKEY_PROVIDER */
+
+/**
+ * Setup ovpn.xey provider for signing with external keys.
+ * It is loaded into a custom library context so as not to pollute
+ * the default context. Alternatively we could override any
+ * system-wide property query set on the default context. But we
+ * want to avoid that.
+ */
+void
+load_xkey_provider(void)
+{
+#ifdef HAVE_XKEY_PROVIDER
+
+    /* Make a new library context for use in TLS context */
+    if (!tls_libctx)
+    {
+        tls_libctx = OSSL_LIB_CTX_new();
+        check_malloc_return(tls_libctx);
+
+        /* Load all providers in default LIBCTX into this libctx.
+         * OpenSSL has a child libctx functionality to automate this,
+         * but currently that is usable only from within providers.
+         * So we do something close to it manually here.
+         */
+        OSSL_PROVIDER_do_all(NULL, provider_load, tls_libctx);
+    }
+
+    if (!OSSL_PROVIDER_available(tls_libctx, "ovpn.xkey"))
+    {
+        OSSL_PROVIDER_add_builtin(tls_libctx, "ovpn.xkey", xkey_provider_init);
+        if (!OSSL_PROVIDER_load(tls_libctx, "ovpn.xkey"))
+        {
+            msg(M_NONFATAL, "ERROR: failed loading external key provider: "
+                            "Signing with external keys will not work.");
+        }
+    }
+
+    /* We only implement minimal functionality in ovpn.xkey, so we do not want
+     * methods in xkey to be picked unless absolutely required (i.e, when the key
+     * is external). Ensure this by setting a default propquery for the custom
+     * libctx that unprefers, but does not forbid, ovpn.xkey. See also man page
+     * of "property" in OpenSSL 3.0.
+     */
+    EVP_set_default_properties(tls_libctx, "?provider!=ovpn.xkey");
+
+#endif /* HAVE_XKEY_PROVIDER */
+}
+
+/**
+ * Undo steps in load_xkey_provider
+ */
+static void
+unload_xkey_provider(void)
+{
+#ifdef HAVE_XKEY_PROVIDER
+    if (tls_libctx)
+    {
+        OSSL_PROVIDER_do_all(tls_libctx, provider_unload, NULL);
+        OSSL_LIB_CTX_free(tls_libctx);
+    }
+#endif /* HAVE_XKEY_PROVIDER */
+    tls_libctx = NULL;
+}
+
 #endif /* defined(ENABLE_CRYPTO_OPENSSL) */
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index db58d077..f46bacd2 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -28,7 +28,6 @@
 #include <openssl/opensslv.h>
 #if OPENSSL_VERSION_NUMBER >= 0x30000010L && !defined(DISABLE_XKEY_PROVIDER)
 #define HAVE_XKEY_PROVIDER 1
-
 #include <openssl/provider.h>
 #include <openssl/core_dispatch.h>
 
-- 
2.30.2


