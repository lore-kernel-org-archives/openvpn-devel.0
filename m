From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 May 2022 14:14:24 +0200
Message-Id: <20220512121429.2096164-3-arne@...1227...>
In-Reply-To: <20220512121429.2096164-1-arne@...1227...>
References: <20220512121429.2096164-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/7] Allow loading of non default providers
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

This allows OpenVPN to load non-default providers. This is mainly
useful for loading the legacy provider with --providers legacy default

Cherry-pick of 08081aa0a153 to release/2.5. Changes.rst has been adjust to
better fit the changes in 2.5.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                          | 14 +++++++++++++
 doc/man-sections/generic-options.rst | 12 +++++++++++
 src/openvpn/crypto_backend.h         | 15 ++++++++++++++
 src/openvpn/crypto_mbedtls.c         | 13 ++++++++++++
 src/openvpn/crypto_mbedtls.h         |  3 +++
 src/openvpn/crypto_openssl.c         | 31 ++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.h         | 11 ++++++++++
 src/openvpn/openvpn.c                | 15 +++++++++++++-
 src/openvpn/options.c                |  8 +++++++
 src/openvpn/options.h                |  9 ++++++++
 10 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 45d2c3f39..884c122a9 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -14,6 +14,20 @@ New features
 
 - upgrade pkcs11-helper to release 1.28.4
 
+- Limited OpenSSL 3.0 support
+    OpenSSL 3.0 support has been added. OpenSSL 3.0 support in 2.5 relies
+    on the compatiblity layer and full OpenSSL 3.0 support is coming with
+    OpenVPN 2.6. Only features that impact usage directly have been
+    backported:
+
+    ``--tls-cert-profile insecure``  has been added to allow selecting the
+    lowest  OpenSSL security level (not recommended, use only if you must).
+
+    OpenSSL 3.0 no longer supports the Blowfish (and other deprecated)
+    algorithm by default and the new option ``--providers`` allows loading
+    the legacy provider to renable these algorithms.
+
+
 Bugfixes
 --------
 - CVE-2022-0547
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index d5f08839b..18085f9bd 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -252,6 +252,18 @@ which mode OpenVPN is configured as.
   This option solves the problem by persisting keys across :code:`SIGUSR1`
   resets, so they don't need to be re-read.
 
+--providers providers
+  Load the list of (OpenSSL) providers. This is mainly useful for using an
+  external provider for key management like tpm2-openssl or to load the
+  legacy provider with
+
+  ::
+
+      --providers legacy default
+
+  Behaviour of changing this option between SIGHUP might not be well behaving.
+  If you need to change/add/remove this option, fully restart OpenVPN.
+
 --remap-usr1 signal
   Control whether internally or externally generated :code:`SIGUSR1` signals
   are remapped to :code:`SIGHUP` (restart without persisting state) or
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index b5a122eee..a9bb38ed2 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -78,6 +78,21 @@ void crypto_clear_error(void);
  */
 void crypto_init_lib_engine(const char *engine_name);
 
+
+/**
+ * Load the given (OpenSSL) providers
+ * @param provider name of providers to load
+ * @return reference to the loaded provider
+ */
+provider_t *crypto_load_provider(const char *provider);
+
+/**
+ * Unloads the given (OpenSSL) provider
+ * @param provname  name of the provider to unload
+ * @param provider  pointer to the provider to unload
+ */
+void crypto_unload_provider(const char *provname, provider_t *provider);
+
 #ifdef DMALLOC
 /*
  * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 1da99d147..000815209 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -69,6 +69,19 @@ crypto_init_lib_engine(const char *engine_name)
         "available");
 }
 
+provider_t *crypto_load_provider(const char *provider)
+{
+    if (provider)
+    {
+        msg(M_WARN, "Note: mbed TLS provider functionality is not available");
+    }
+    return NULL;
+}
+
+void crypto_unload_provider(const char *provname, provider_t *provider)
+{
+}
+
 /*
  *
  * Functions related to the core crypto library
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 816e1397a..14614a12d 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -48,6 +48,9 @@ typedef mbedtls_md_context_t md_ctx_t;
 /** Generic HMAC %context. */
 typedef mbedtls_md_context_t hmac_ctx_t;
 
+/* Use a dummy type for the provider */
+typedef void provider_t;
+
 /** Maximum length of an IV */
 #define OPENVPN_MAX_IV_LENGTH   MBEDTLS_MAX_IV_LENGTH
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0908e9aa1..beeaee4b7 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -51,6 +51,10 @@
 #include <openssl/rand.h>
 #include <openssl/ssl.h>
 
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+#include <openssl/provider.h>
+#endif
+
 #if defined(_WIN32) && defined(OPENSSL_NO_EC)
 #error Windows build with OPENSSL_NO_EC: disabling EC key is not supported.
 #endif
@@ -145,6 +149,33 @@ crypto_init_lib_engine(const char *engine_name)
 #endif
 }
 
+provider_t *
+crypto_load_provider(const char *provider)
+{
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    /* Load providers into the default (NULL) library context */
+    OSSL_PROVIDER *prov = OSSL_PROVIDER_load(NULL, provider);
+    if (!prov)
+    {
+        crypto_msg(M_FATAL, "failed to load provider '%s'", provider);
+    }
+    return prov;
+#else  /* OPENSSL_VERSION_NUMBER >= 0x30000000L */
+    msg(M_WARN, "Note: OpenSSL provider functionality is not available");
+    return NULL;
+#endif
+}
+
+void crypto_unload_provider(const char *provname, provider_t *provider)
+{
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    if (!OSSL_PROVIDER_unload(provider))
+    {
+        crypto_msg(M_FATAL, "failed to unload provider '%s'", provname);
+    }
+#endif
+}
+
 /*
  *
  * Functions related to the core crypto library
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index ecc66fbfd..9bb58adae 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -33,6 +33,10 @@
 #include <openssl/hmac.h>
 #include <openssl/md5.h>
 #include <openssl/sha.h>
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+#include <openssl/provider.h>
+#endif
+
 
 /** Generic cipher key type %context. */
 typedef EVP_CIPHER cipher_kt_t;
@@ -49,6 +53,13 @@ typedef EVP_MD_CTX md_ctx_t;
 /** Generic HMAC %context. */
 typedef HMAC_CTX hmac_ctx_t;
 
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+/* Use a dummy type for the provider */
+typedef void provider_t;
+#else
+typedef OSSL_PROVIDER provider_t;
+#endif
+
 /** Maximum length of an IV */
 #define OPENVPN_MAX_IV_LENGTH   EVP_MAX_IV_LENGTH
 
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index e03d25450..1cd8f1b30 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -112,14 +112,27 @@ void init_early(struct context *c)
     /* init verbosity and mute levels */
     init_verb_mute(c, IVM_LEVEL_1);
 
+    /* Initialise OpenSSL provider, this needs to be initialised this
+    * early since option post-processing and also openssl info
+    * printing depends on it */
+    for (int j=1; j < MAX_PARMS && c->options.providers.names[j]; j++)
+    {
+        c->options.providers.providers[j] =
+            crypto_load_provider(c->options.providers.names[j]);
+    }
 }
 
 static void uninit_early(struct context *c)
 {
     net_ctx_free(&c->net_ctx);
+    for (int j=1; j < MAX_PARMS && c->options.providers.providers[j]; j++)
+    {
+        crypto_unload_provider(c->options.providers.names[j],
+                               c->options.providers.providers[j]);
+    }
+    net_ctx_free(&c->net_ctx);
 }
 
-
 /**************************************************************************/
 /**
  * OpenVPN's main init-run-cleanup loop.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e0b273bdd..f6ef02ae8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -602,6 +602,7 @@ static const char usage_message[] =
     "                : Use --show-tls to see a list of supported TLS ciphers (suites).\n"
     "--tls-cert-profile p : Set the allowed certificate crypto algorithm profile\n"
     "                  (default=legacy).\n"
+    "--providers l   : A list l of OpenSSL providers to load.\n"
     "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
     "                  if no ACK from remote within n seconds (default=%d).\n"
     "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and recvd.\n"
@@ -8129,6 +8130,13 @@ add_option(struct options *options,
         options->keysize = keysize;
     }
 #endif
+    else if (streq(p[0], "providers") && p[1])
+    {
+        for (size_t j = 1; j < MAX_PARMS && p[j] != NULL;j++)
+        {
+            options->providers.names[j] = p[j];
+        }
+    }
 #ifdef ENABLE_PREDICTION_RESISTANCE
     else if (streq(p[0], "use-prediction-resistance") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 251660fdc..372209042 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -176,6 +176,14 @@ struct remote_list
     struct remote_entry *array[CONNECTION_LIST_SIZE];
 };
 
+struct provider_list
+{
+    /* Names of the providers */
+    const char *names[MAX_PARMS];
+    /* Pointers to the loaded providers to unload them */
+    provider_t *providers[MAX_PARMS];
+};
+
 enum vlan_acceptable_frames
 {
     VLAN_ONLY_TAGGED,
@@ -519,6 +527,7 @@ struct options
     const char *prng_hash;
     int prng_nonce_secret_len;
     const char *engine;
+    struct provider_list providers;
     bool replay;
     bool mute_replay_warnings;
     int replay_window;
-- 
2.32.0 (Apple Git-132)


