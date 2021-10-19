From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:19 +0200
Message-Id: <20211019182332.613155-15-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 12/20] [OSSL 3.0] Allow loading of non
 default providers
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
useful for loading the legacy provider with --provider legacy:default

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/generic-options.rst | 10 ++++++++++
 src/openvpn/crypto_backend.h         |  7 +++++++
 src/openvpn/crypto_mbedtls.c         |  8 ++++++++
 src/openvpn/crypto_openssl.c         | 29 ++++++++++++++++++++++++++++
 src/openvpn/openvpn.c                |  4 ++++
 src/openvpn/options.c                |  4 ++++
 src/openvpn/options.h                |  1 +
 7 files changed, 63 insertions(+)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index e6c1fe455..f5b8a9135 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -280,6 +280,16 @@ which mode OpenVPN is configured as.
   This option solves the problem by persisting keys across :code:`SIGUSR1`
   resets, so they don't need to be re-read.
 
+--provider providers
+  Load the : separated list of (OpenSSL) providers. This is mainly useful for
+  using an external provider for key management like tpm2-openssl or to load
+  the legacy provider with
+
+  ::
+
+      --provider "legacy:default"
+
+
 --remap-usr1 signal
   Control whether internally or externally generated :code:`SIGUSR1` signals
   are remapped to :code:`SIGHUP` (restart without persisting state) or
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index cc897acf4..fa265e6c2 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -78,6 +78,13 @@ void crypto_clear_error(void);
  */
 void crypto_init_lib_engine(const char *engine_name);
 
+
+/**
+ * Load the given (OpenSSL) providers
+ * @param providers list of providers to load, seperated by :
+ */
+void crypto_init_lib_provider(const char *providers);
+
 #ifdef DMALLOC
 /*
  * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2f7f00d19..e6ed1ae99 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -70,6 +70,14 @@ crypto_init_lib_engine(const char *engine_name)
         "available");
 }
 
+void crypto_init_lib_provider(const char *providers)
+{
+    if (providers)
+    {
+        msg(M_WARN, "Note: mbed TLS provider functionality is not available");
+    }
+}
+
 /*
  *
  * Functions related to the core crypto library
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 407ea4a7c..1900ccc1b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -54,6 +54,9 @@
 #if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
 #include <openssl/kdf.h>
 #endif
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+#include <openssl/provider.h>
+#endif
 
 /*
  * Check for key size creepage.
@@ -145,6 +148,32 @@ crypto_init_lib_engine(const char *engine_name)
 #endif
 }
 
+void
+crypto_init_lib_provider(const char *providers)
+{
+    if (!providers)
+    {
+        return;
+    }
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    struct gc_arena gc = gc_new();
+    char *tmp_providers = string_alloc(providers, &gc);
+
+    const char *provname;
+    while ((provname = strsep(&tmp_providers, ":")))
+    {
+        /* Load providers into the default (NULL) library context */
+        OSSL_PROVIDER* provider = OSSL_PROVIDER_load(NULL, provname);
+        if (!provider)
+        {
+            crypto_msg(M_FATAL, "failed to load provider '%s'", provname);
+        }
+    }
+#else  /* OPENSSL_VERSION_NUMBER >= 0x30000000L */
+    msg(M_WARN, "Note: OpenSSL hardware crypto engine functionality is not available");
+#endif
+}
+
 /*
  *
  * Functions related to the core crypto library
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index f8e94509f..3c9bcf885 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -112,6 +112,10 @@ void init_early(struct context *c)
     /* init verbosity and mute levels */
     init_verb_mute(c, IVM_LEVEL_1);
 
+    /* Initialise OpenVPN provider, this needs to be intialised this
+    * early since option post processing and also openssl info
+    * printing depends on it */
+    crypto_init_lib_provider((*c).options.providers);
 }
 
 static void uninit_early(struct context *c)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ed2dcd53d..ab7b00783 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8178,6 +8178,10 @@ add_option(struct options *options,
             options->engine = "auto";
         }
     }
+    else if (streq(p[0], "provider") && p[1] && !p[2])
+    {
+        options->providers = p[1];
+    }
 #endif /* ENABLE_CRYPTO_MBEDTLS */
 #ifdef ENABLE_PREDICTION_RESISTANCE
     else if (streq(p[0], "use-prediction-resistance") && !p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 98c21a2a8..6759f1950 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -521,6 +521,7 @@ struct options
     const char *prng_hash;
     int prng_nonce_secret_len;
     const char *engine;
+    const char *providers;
     bool replay;
     bool mute_replay_warnings;
     int replay_window;
-- 
2.33.0


