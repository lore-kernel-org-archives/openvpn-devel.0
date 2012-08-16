From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Aug 2012 10:38:19 +0200
Message-ID: <1345106302-22850-5-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
References: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/7] support crypto engine options
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

OpenVPN supports using OpenSSL engines by loading them with the
--engine configuration option. Some of those engines require
configuration options themself.

This patch extends the --engine option so that engine-options can be
specified as well.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 doc/openvpn.8                 |   11 ++++++-----
 src/openvpn/crypto.c          |    4 ++--
 src/openvpn/crypto.h          |    2 +-
 src/openvpn/crypto_backend.h  |   17 ++++++++++++++++-
 src/openvpn/crypto_openssl.c  |   33 +++++++++++++++++++++------------
 src/openvpn/crypto_polarssl.c |    4 ++--
 src/openvpn/options.c         |   32 +++++++++++++++++++++++++++-----
 src/openvpn/options.h         |    3 ++-
 src/openvpn/ssl.c             |    4 ++--
 src/openvpn/ssl.h             |    2 +-
 10 files changed, 80 insertions(+), 32 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 56be29e..d967ebd 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3704,13 +3704,14 @@ to disable the PRNG and use the OpenSSL RAND_bytes function
 instead for all of OpenVPN's pseudo-random number needs.
 .\"*********************************************************
 .TP
-.B \-\-engine [engine-name]
-Enable OpenSSL hardware-based crypto engine functionality.
-
+.B \-\-engine [engine-name [engine-option ...]]
+Enable OpenSSL crypto engine functionality.
 If
 .B engine-name
-is specified,
-use a specific crypto engine.  Use the
+is specified, use a specific crypto engine.
+.B engine-options
+must be given as name=value pairs.
+Use the
 .B \-\-show-engines
 standalone option to list the crypto engines which are
 supported by OpenSSL.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index b95865e..7fdbb95 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1376,9 +1376,9 @@ get_random()
 #ifndef ENABLE_SSL
 
 void
-init_ssl_lib (const char *engine_name)
+init_ssl_lib (const struct crypto_engine *engine)
 {
-  crypto_init_lib (engine_name);
+  crypto_init_lib (engine);
 }
 
 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index cd08cf3..5c34597 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -358,7 +358,7 @@ void get_tls_handshake_key (const struct key_type *key_type,
 
 #else
 
-void init_ssl_lib (const char *engine_name);
+void init_ssl_lib (const struct crypto_engine *engine);
 void free_ssl_lib (void);
 
 #endif /* ENABLE_SSL */
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 9727a92..4b68687 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -40,10 +40,25 @@
 
 
 /*
+ * Structures for crypto library engine configuration.
+ */
+struct crypto_engine_option
+{
+  struct crypto_engine_option *next;
+  const char *name;
+  const char *value;
+};
+struct crypto_engine
+{
+  const char *name;
+  struct crypto_engine_option *options;
+};
+
+/*
  * This routine should have additional OpenSSL crypto library initialisations
  * used by both crypto and ssl components of OpenVPN.
  */
-void crypto_init_lib (const char *engine_name);
+void crypto_init_lib (const struct crypto_engine *engine);
 
 void crypto_uninit_lib (void);
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a7ee168..deaf0ca 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -135,7 +135,7 @@ try_load_engine (const char *engine)
 }
 
 static ENGINE *
-setup_engine (const char *engine)
+setup_engine (const struct crypto_engine *engine)
 {
   ENGINE *e = NULL;
 
@@ -143,24 +143,33 @@ setup_engine (const char *engine)
 
   if (engine)
     {
-      if (strcmp (engine, "auto") == 0)
+      struct crypto_engine_option *o;
+      
+      if (strcmp (engine->name, "auto") == 0)
 	{
 	  msg (M_INFO, "Initializing OpenSSL auto engine support");
 	  ENGINE_register_all_complete ();
 	  return NULL;
 	}
-      if ((e = ENGINE_by_id (engine)) == NULL
-	 && (e = try_load_engine (engine)) == NULL)
+      if ((e = ENGINE_by_id (engine->name)) == NULL
+	 && (e = try_load_engine (engine->name)) == NULL)
 	{
-	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine);
+	  msg (M_FATAL, "OpenSSL error: cannot load engine '%s'", engine->name);
 	}
 
       if (!ENGINE_set_default (e, ENGINE_METHOD_ALL))
 	{
 	  msg (M_FATAL, "OpenSSL error: ENGINE_set_default failed on engine '%s'",
-	       engine);
+	       engine->name);
 	}
 
+      for (o = engine->options; o; o = o->next)
+        {
+          if (!ENGINE_ctrl_cmd_string (e, o->name, o->value, 0))
+            msg (M_FATAL, "OpenSSL error: ENGINE_ctrl_cmd_string failed on engine '%s'",
+                engine->name);
+        }
+
       msg (M_INFO, "Initializing OpenSSL support for engine '%s'",
 	   ENGINE_get_id (e));
     }
@@ -170,14 +179,14 @@ setup_engine (const char *engine)
 #endif /* HAVE_OPENSSL_ENGINE */
 
 static void
-crypto_init_lib_engine (const char *engine_name)
+crypto_init_lib_engine (const struct crypto_engine *engine)
 {
 #if HAVE_OPENSSL_ENGINE
   if (!engine_initialized)
     {
-      ASSERT (engine_name);
+      ASSERT (engine->name);
       ASSERT (!engine_persist);
-      engine_persist = setup_engine (engine_name);
+      engine_persist = setup_engine (engine);
       engine_initialized = true;
     }
 #else
@@ -192,10 +201,10 @@ crypto_init_lib_engine (const char *engine_name)
  */
 
 void
-crypto_init_lib (const char *engine_name)
+crypto_init_lib (const struct crypto_engine *engine)
 {
-  if (engine_name)
-    crypto_init_lib_engine (engine_name);
+  if (engine)
+    crypto_init_lib_engine (engine);
 
 #ifndef USE_SSL
 #ifndef ENABLE_SMALL
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index b7f13e3..6b1193a 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -59,9 +59,9 @@
  */
 
 void
-crypto_init_lib (const char *engine_name)
+crypto_init_lib (const struct crypto_engine *engine)
 {
-  if (engine_name)
+  if (engine)
     msg (M_WARN, "Note: PolarSSL hardware crypto engine functionality is not "
         "available");
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 19690e1..b78ff15 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -531,7 +531,7 @@ static const char usage_message[] =
   "                  If unspecified, defaults to cipher-specific default.\n"
 #endif
 #ifndef ENABLE_CRYPTO_POLARSSL
-  "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
+  "--engine [name [opts]] : Enable OpenSSL crypto engine functionality.\n"
 #endif
   "--no-replay     : Disable replay protection.\n"
   "--mute-replay-warnings : Silence the output of replay warnings to log file.\n"
@@ -6287,12 +6287,34 @@ add_option (struct options *options,
   else if (streq (p[0], "engine"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      ALLOC_OBJ_CLEAR_GC (options->engine, struct crypto_engine, &options->gc);
+      
       if (p[1])
-	{
-	  options->engine = p[1];
-	}
+        {
+          int i;
+
+          options->engine->name = p[1];
+
+          for (i = 2; p[i]; i++)
+            {
+              struct crypto_engine_option *next_option;
+              char *eq = strchr (p[i], '=');
+              if (eq == NULL)
+                {
+                  msg (msglevel, "Bad option for engine %s: %s", p[1], p[i]);
+                  goto err;
+                }
+              *eq = '\0';
+
+              next_option = options->engine->options;
+              ALLOC_OBJ_GC (options->engine->options, struct crypto_engine_option, &options->gc);
+              options->engine->options->next = next_option;
+              options->engine->options->name = p[i];
+              options->engine->options->value = eq + 1;
+            }
+        }
       else
-	options->engine = "auto";
+        options->engine->name = "auto";
     }  
 #endif /* ENABLE_CRYPTO_POLARSSL */
 #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 306520b..36eab25 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -42,6 +42,7 @@
 #include "lzo.h"
 #include "pushlist.h"
 #include "clinat.h"
+#include "crypto.h"
 
 /*
  * Maximum number of parameters associated with an option,
@@ -481,7 +482,7 @@ struct options
   int keysize;
   const char *prng_hash;
   int prng_nonce_secret_len;
-  const char *engine;
+  struct crypto_engine *engine;
   bool replay;
   bool mute_replay_warnings;
   int replay_window;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e9a7d0a..a1a0628 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -153,9 +153,9 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
 }
 
 void
-init_ssl_lib (const char *engine_name)
+init_ssl_lib (const struct crypto_engine *engine)
 {
-  crypto_init_lib (engine_name);
+  crypto_init_lib (engine);
   tls_init_lib ();
 }
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index daa654c..001e4fd 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -144,7 +144,7 @@ struct tls_auth_standalone
 /*
  * Prepare the SSL library for use
  */
-void init_ssl_lib (const char *engine_name);
+void init_ssl_lib (const struct crypto_engine *engine);
 
 /*
  * Free any internal state that the SSL library might have
-- 
1.7.9.5


