From: Arne Schwabe <arne@...1227...>
Date: Fri, 12 Nov 2021 14:02:31 +0100
Message-Id: <20211112130231.3799480-1-arne@...1227...>
In-Reply-To: <20210520151148.2565578-7-arne@...1227...>
References: <20210520151148.2565578-7-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] [OSSL 3.0] Allow loading of non default
 providers
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

Patch v4: use spaces to seperate providers, unload providers.
Patch v5: General cleanup, rename option to --providers, add
          option to usage() and add an entry to Changes.rst
Patch v6: allow --providers also to be used (and be ignored) with mbed TLS

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                          |  7 +++++++
 doc/man-sections/generic-options.rst | 12 +++++++++++
 src/openvpn/crypto_backend.h         | 15 ++++++++++++++
 src/openvpn/crypto_mbedtls.c         | 13 ++++++++++++
 src/openvpn/crypto_mbedtls.h         |  3 +++
 src/openvpn/crypto_openssl.c         | 30 ++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.h         |  9 +++++++++
 src/openvpn/openvpn.c                | 13 ++++++++++++
 src/openvpn/options.c                |  8 ++++++++
 src/openvpn/options.h                |  9 +++++++++
 10 files changed, 119 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 6f04e59ac..7cceffcdb 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -50,6 +50,13 @@ Compatibility mode (``--compat-mode``)
     with older peers. The options ``--compat-mode`` allows UIs to provide users
     with an easy way to still connect to older servers.
 
+OpenSSL 3.0 support
+    OpenSSL 3.0 has been added. Most of OpenSSL 3.0 changes are not user visible but
+    improve general compatibility with OpenSSL 3.0. ``--tls-cert-profile insecure``
+    has been added to allow selecting the lowest OpenSSL security level (not
+    recommended, use only if you must). OpenSSL 3.0 no longer supports the Blowfish
+    (and other deprecated) algorithm by default and the new option ``--providers``
+    allows loading the legacy provider to renable these algorithms.
 
 Deprecated features
 -------------------
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index e6c1fe455..a8f049f20 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -280,6 +280,18 @@ which mode OpenVPN is configured as.
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
index 5aab3e1b7..c16837619 100644
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
+void crypto_unload_provider(const char* provname, provider_t *provider);
+
 #ifdef DMALLOC
 /*
  * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 08b9e004f..39dbf38a5 100644
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
+void crypto_unload_provider(const char* provname, provider_t *provider)
+{
+}
+
 /*
  *
  * Functions related to the core crypto library
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 019de01d1..758ab1b40 100644
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
index cc1d62210..c9731adb3 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -54,6 +54,9 @@
 #if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
 #include <openssl/kdf.h>
 #endif
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+#include <openssl/provider.h>
+#endif
 
 #if defined(_WIN32) && defined(OPENSSL_NO_EC)
 #error Windows build with OPENSSL_NO_EC: disabling EC key is not supported.
@@ -149,6 +152,33 @@ crypto_init_lib_engine(const char *engine_name)
 #endif
 }
 
+provider_t *
+crypto_load_provider(const char *provider)
+{
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    /* Load providers into the default (NULL) library context */
+    OSSL_PROVIDER* prov = OSSL_PROVIDER_load(NULL, provider);
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
+void crypto_unload_provider(const char* provname, provider_t *provider)
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
index e540a76b9..446f08508 100644
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
@@ -49,12 +53,17 @@ typedef EVP_MD_CTX md_ctx_t;
 /** Generic HMAC %context. */
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
 typedef HMAC_CTX hmac_ctx_t;
+
+/* Use a dummy type for the provider */
+typedef void provider_t;
 #else
 typedef struct {
     OSSL_PARAM params[3];
     uint8_t key[EVP_MAX_KEY_LENGTH];
     EVP_MAC_CTX *ctx;
 } hmac_ctx_t;
+
+typedef OSSL_PROVIDER provider_t;
 #endif
 
 /** Maximum length of an IV */
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index da06f59c2..a18a4dd43 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -112,10 +112,23 @@ void init_early(struct context *c)
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
+    for (int j=1; j < MAX_PARMS && c->options.providers.providers[j]; j++)
+    {
+        crypto_unload_provider(c->options.providers.names[j],
+                               c->options.providers.providers[j]);
+    }
     net_ctx_free(&c->net_ctx);
 }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b5d65d293..310e169aa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -581,6 +581,7 @@ static const char usage_message[] =
     "                : Use --show-tls to see a list of supported TLS ciphers (suites).\n"
     "--tls-cert-profile p : Set the allowed certificate crypto algorithm profile\n"
     "                  (default=legacy).\n"
+    "--providers l   : A list l of OpenSSL providers to load.\n"
     "--tls-timeout n : Packet retransmit timeout on TLS control channel\n"
     "                  if no ACK from remote within n seconds (default=%d).\n"
     "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and recvd.\n"
@@ -8158,6 +8159,13 @@ add_option(struct options *options,
         }
     }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
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
index 20b34ed4e..d4f41cd71 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -179,6 +179,14 @@ struct remote_list
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
     const char *ncp_ciphers;
     const char *authname;
     const char *engine;
+    struct provider_list providers;
     bool replay;
     bool mute_replay_warnings;
     int replay_window;
-- 
2.33.0


