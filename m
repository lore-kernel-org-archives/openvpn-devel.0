From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:00 +0200
Message-ID: <1308909312-17824-8-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 16/28] Refactored crypto initialisation
	functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 crypto.c         |  138 +--------------------------------------------
 crypto.h         |   22 -------
 crypto_backend.h |   23 ++++++++
 crypto_openssl.c |  164 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 init.c           |    4 +-
 ssl.c            |    4 +-
 6 files changed, 193 insertions(+), 162 deletions(-)

diff --git a/crypto.c b/crypto.c
index bdb3b1d..ff34d5f 100644
--- a/crypto.c
+++ b/crypto.c
@@ -1452,104 +1452,6 @@ key_len_err:
 }
 
 /*
- * Enable crypto acceleration, if available
- */
-
-static bool engine_initialized = false; /* GLOBAL */
-
-#if CRYPTO_ENGINE
-
-static ENGINE *engine_persist = NULL;   /* GLOBAL */
-
-/* Try to load an engine in a shareable library */
-static ENGINE *
-try_load_engine (const char *engine)
-{
-  ENGINE *e = ENGINE_by_id ("dynamic");
-  if (e)
-    {
-      if (!ENGINE_ctrl_cmd_string (e, "SO_PATH", engine, 0)
-	  || !ENGINE_ctrl_cmd_string (e, "LOAD", NULL, 0))
-	{
-	  ENGINE_free (e);
-	  e = NULL;
-	}
-    }
-  return e;
-}
-
-static ENGINE *
-setup_engine (const char *engine)
-{
-  ENGINE *e = NULL;
-
-  ENGINE_load_builtin_engines ();
-
-  if (engine)
-    {
-      if (strcmp (engine, "auto") == 0)
-	{
-	  msg (M_INFO, "Initializing OpenSSL auto engine support");
-	  ENGINE_register_all_complete ();
-	  return NULL;
-	}
-      if ((e = ENGINE_by_id (engine)) == NULL
-	 && (e = try_load_engine (engine)) == NULL)
-	{
-	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
-	}
-
-      if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
-	{
-	  msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on engine '%s'",
-	       engine);
-	}
-
-      msg (M_INFO, "Initializing OpenSSL support for engine '%s'",
-	   ENGINE_get_id (e));
-    }
-  return e;
-}
-#endif
-
-void
-init_crypto_lib_engine (const char *engine_name)
-{
-  if (!engine_initialized)
-    {
-#if CRYPTO_ENGINE
-      ASSERT (engine_name);
-      ASSERT (!engine_persist);
-      engine_persist = setup_engine (engine_name);
-#else
-      msg (M_WARN, "Note: OpenSSL hardware crypto engine functionality is not available");
-#endif
-      engine_initialized = true;
-    }
-}
-
-/*
- * This routine should have additional OpenSSL crypto library initialisations
- * used by both crypto and ssl components of OpenVPN.
- */
-void init_crypto_lib ()
-{
-}
-
-void uninit_crypto_lib ()
-{
-#if CRYPTO_ENGINE
-  if (engine_initialized)
-    {
-      ENGINE_cleanup ();
-      engine_persist = NULL;
-      engine_initialized = false;
-    }
-#endif
-  prng_uninit ();
-}
-
-/*
  * Random number functions, used in cases where we want
  * reasonably strong cryptographic random number generation
  * without depleting our entropy pool.  Used for random
@@ -1642,42 +1544,6 @@ md5sum (uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc)
   return format_hex (digest, MD5_DIGEST_LENGTH, n_print_chars, gc);
 }
 
-/*
- * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
- * OpenSSL to use our private malloc/realloc/free functions so that
- * we can dispatch them to dmalloc.
- */
-
-#ifdef DMALLOC
-
-static void *
-crypto_malloc (size_t size, const char *file, int line)
-{
-  return dmalloc_malloc(file, line, size, DMALLOC_FUNC_MALLOC, 0, 0);
-}
-
-static void *
-crypto_realloc (void *ptr, size_t size, const char *file, int line)
-{
-  return dmalloc_realloc(file, line, ptr, size, DMALLOC_FUNC_REALLOC, 0);
-}
-
-static void
-crypto_free (void *ptr)
-{
-  dmalloc_free (__FILE__, __LINE__, ptr, DMALLOC_FUNC_FREE);
-}
-
-void
-openssl_dmalloc_init (void)
-{
-   CRYPTO_set_mem_ex_functions (crypto_malloc,
-				crypto_realloc,
-				crypto_free);
-}
-
-#endif /* DMALLOC */
-
 #ifndef USE_SSL
 
 void
@@ -1685,13 +1551,13 @@ init_ssl_lib (void)
 {
   ERR_load_crypto_strings ();
   OpenSSL_add_all_algorithms ();
-  init_crypto_lib ();
+  crypto_init_lib ();
 }
 
 void
 free_ssl_lib (void)
 {
-  uninit_crypto_lib ();
+  crypto_uninit_lib ();
   EVP_cleanup ();
   ERR_free_strings ();
 }
diff --git a/crypto.h b/crypto.h
index abb2e4c..7fa7418 100644
--- a/crypto.h
+++ b/crypto.h
@@ -34,15 +34,6 @@
 
 #define ALLOW_NON_CBC_CIPHERS
 
-/*
- * Does our OpenSSL library support crypto hardware acceleration?
- */
-#if defined(HAVE_OPENSSL_ENGINE_H) && defined(HAVE_ENGINE_LOAD_BUILTIN_ENGINES) && defined(HAVE_ENGINE_REGISTER_ALL_COMPLETE) && defined(HAVE_ENGINE_CLEANUP)
-#define CRYPTO_ENGINE 1
-#else
-#define CRYPTO_ENGINE 0
-#endif
-
 #include <openssl/objects.h>
 #include <openssl/rand.h>
 #include <openssl/evp.h>
@@ -55,10 +46,6 @@
 #include <openssl/sha.h>
 #include <openssl/err.h>
 
-#if CRYPTO_ENGINE
-#include <openssl/engine.h>
-#endif
-
 #if SSLEAY_VERSION_NUMBER >= 0x00907000L
 #include <openssl/des_old.h>
 #endif
@@ -434,12 +421,6 @@ void test_crypto (const struct crypto_options *co, struct frame* f);
 
 const char *md5sum(uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc);
 
-void init_crypto_lib_engine (const char *engine_name);
-
-void init_crypto_lib (void);
-
-void uninit_crypto_lib (void);
-
 /* key direction functions */
 
 void key_direction_state_init (struct key_direction_state *kds, int key_direction);
@@ -458,9 +439,6 @@ void key2_print (const struct key2* k,
 		 const char* prefix0,
 		 const char* prefix1);
 
-/* memory debugging */
-void openssl_dmalloc_init (void);
-
 #ifdef USE_SSL
 
 #define GHK_INLINE  (1<<0)
diff --git a/crypto_backend.h b/crypto_backend.h
index 50eef7b..1b85dec 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -38,8 +38,31 @@
 
 #include "basic.h"
 
+
+/*
+ * This routine should have additional OpenSSL crypto library initialisations
+ * used by both crypto and ssl components of OpenVPN.
+ */
+void crypto_init_lib (void);
+
+void crypto_uninit_lib (void);
+
 void crypto_clear_error (void);
 
+/*
+ * Initialise the given named crypto engine.
+ */
+void crypto_init_lib_engine (const char *engine_name);
+
+#ifdef DMALLOC
+/*
+ * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
+ * OpenSSL to use our private malloc/realloc/free functions so that
+ * we can dispatch them to dmalloc.
+ */
+void crypto_init_dmalloc (void);
+#endif /* DMALLOC */
+
 void show_available_ciphers (void);
 
 void show_available_digests (void);
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 8e228ee..199a209 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -84,14 +84,178 @@ cipher_ok (const char* name)
 
 #if SSLEAY_VERSION_NUMBER < 0x0090581f
 
+#endif /* SSLEAY_VERSION_NUMBER < 0x0090581f */
+
+/*
+ *
+ * OpenSSL engine support. Allows loading/unloading of engines.
+ *
+ */
+
+#if defined(HAVE_OPENSSL_ENGINE_H) && defined(HAVE_ENGINE_LOAD_BUILTIN_ENGINES) && defined(HAVE_ENGINE_REGISTER_ALL_COMPLETE) && defined(HAVE_ENGINE_CLEANUP)
+#define CRYPTO_ENGINE 1
+#else
+#define CRYPTO_ENGINE 0
+#endif
+
+#if CRYPTO_ENGINE
+#include <openssl/engine.h>
+
+static bool engine_initialized = false; /* GLOBAL */
+
+static ENGINE *engine_persist = NULL;   /* GLOBAL */
+
+/* Try to load an engine in a shareable library */
+static ENGINE *
+try_load_engine (const char *engine)
+{
+  ENGINE *e = ENGINE_by_id ("dynamic");
+  if (e)
+    {
+      if (!ENGINE_ctrl_cmd_string (e, "SO_PATH", engine, 0)
+	  || !ENGINE_ctrl_cmd_string (e, "LOAD", NULL, 0))
+	{
+	  ENGINE_free (e);
+	  e = NULL;
+	}
+    }
+  return e;
+}
+
+static ENGINE *
+setup_engine (const char *engine)
+{
+  ENGINE *e = NULL;
+
+  ENGINE_load_builtin_engines ();
+
+  if (engine)
+    {
+      if (strcmp (engine, "auto") == 0)
+	{
+	  msg (M_INFO, "Initializing OpenSSL auto engine support");
+	  ENGINE_register_all_complete ();
+	  return NULL;
+	}
+      if ((e = ENGINE_by_id (engine)) == NULL
+	 && (e = try_load_engine (engine)) == NULL)
+	{
+	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
+	}
+
+      if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
+	{
+	  msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on engine '%s'",
+	       engine);
+	}
+
+      msg (M_INFO, "Initializing OpenSSL support for engine '%s'",
+	   ENGINE_get_id (e));
+    }
+  return e;
+}
+
+#endif /* CRYPTO_ENGINE */
+
+void
+crypto_init_lib_engine (const char *engine_name)
+{
+#if CRYPTO_ENGINE
+  if (!engine_initialized)
+    {
+      ASSERT (engine_name);
+      ASSERT (!engine_persist);
+      engine_persist = setup_engine (engine_name);
+      engine_initialized = true;
+    }
+#else
+  msg (M_WARN, "Note: OpenSSL hardware crypto engine functionality is not available");
+#endif
+}
+
+/*
+ *
+ * Functions related to the core crypto library
+ *
+ */
+
+void
+crypto_init_lib (void)
+{
+  /*
+   * If you build the OpenSSL library and OpenVPN with
+   * CRYPTO_MDEBUG, you will get a listing of OpenSSL
+   * memory leaks on program termination.
+   */
+#ifdef CRYPTO_MDEBUG
+  CRYPTO_mem_ctrl(CRYPTO_MEM_CHECK_ON);
+#endif
+}
+
+void
+crypto_uninit_lib (void)
+{
+#ifdef CRYPTO_MDEBUG
+  FILE* fp = fopen ("sdlog", "w");
+  ASSERT (fp);
+  CRYPTO_mem_leaks_fp (fp);
+  fclose (fp);
+#endif
+
+#if CRYPTO_ENGINE
+  if (engine_initialized)
+    {
+      ENGINE_cleanup ();
+      engine_persist = NULL;
+      engine_initialized = false;
+    }
 #endif
 
+  prng_uninit ();
+}
+
 void
 crypto_clear_error (void)
 {
   ERR_clear_error ();
 }
 
+/*
+ *
+ * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
+ * OpenSSL to use our private malloc/realloc/free functions so that
+ * we can dispatch them to dmalloc.
+ *
+ */
+
+#ifdef DMALLOC
+static void *
+crypto_malloc (size_t size, const char *file, int line)
+{
+  return dmalloc_malloc(file, line, size, DMALLOC_FUNC_MALLOC, 0, 0);
+}
+
+static void *
+crypto_realloc (void *ptr, size_t size, const char *file, int line)
+{
+  return dmalloc_realloc(file, line, ptr, size, DMALLOC_FUNC_REALLOC, 0);
+}
+
+static void
+crypto_free (void *ptr)
+{
+  dmalloc_free (__FILE__, __LINE__, ptr, DMALLOC_FUNC_FREE);
+}
+
+void
+crypto_init_dmalloc (void)
+{
+  CRYPTO_set_mem_ex_functions (crypto_malloc,
+				crypto_realloc,
+				crypto_free);
+}
+#endif /* DMALLOC */
+
 void
 show_available_ciphers ()
 {
diff --git a/init.c b/init.c
index 972b093..25d9fd9 100644
--- a/init.c
+++ b/init.c
@@ -530,7 +530,7 @@ init_static (void)
   /* configure_path (); */
 
 #if defined(USE_CRYPTO) && defined(DMALLOC)
-  openssl_dmalloc_init ();
+  crypto_init_dmalloc();
 #endif
 
   init_random_seed ();		/* init random() function, only used as
@@ -1863,7 +1863,7 @@ static void
 init_crypto_pre (struct context *c, const unsigned int flags)
 {
   if (c->options.engine)
-    init_crypto_lib_engine (c->options.engine);
+    crypto_init_lib_engine (c->options.engine);
 
   if (flags & CF_LOAD_PERSISTED_PACKET_ID)
     {
diff --git a/ssl.c b/ssl.c
index d0fd77b..4effb49 100644
--- a/ssl.c
+++ b/ssl.c
@@ -225,7 +225,7 @@ init_ssl_lib ()
   SSL_load_error_strings ();
   OpenSSL_add_all_algorithms ();
 
-  init_crypto_lib();
+  crypto_init_lib();
 
   /*
    * If you build the OpenSSL library and OpenVPN with
@@ -249,7 +249,7 @@ free_ssl_lib ()
   fclose (fp);
 #endif
 
-  uninit_crypto_lib ();
+  crypto_uninit_lib ();
   EVP_cleanup ();
   ERR_free_strings ();
 }
-- 
1.7.4.1


