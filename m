From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Aug 2012 10:38:18 +0200
Message-ID: <1345106302-22850-4-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
References: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/7] remove API for crypto engine
	initialization
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

Since the crypto library and the crypto engine initialization are now
happening at the same time, there's no apparent need for two distinct
APIs the init them anymore.

The crypto engine is now initialized within the crypto library init
function, which makes to code look a bit cleaner.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/crypto.c          |    4 ++--
 src/openvpn/crypto.h          |    2 +-
 src/openvpn/crypto_backend.h  |    7 +------
 src/openvpn/crypto_openssl.c  |    7 +++++--
 src/openvpn/crypto_polarssl.c |   18 ++++--------------
 src/openvpn/openvpn.c         |    4 +---
 src/openvpn/ssl.c             |    5 ++---
 src/openvpn/ssl.h             |    2 +-
 8 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 2f67e5e..b95865e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1376,9 +1376,9 @@ get_random()
 #ifndef ENABLE_SSL
 
 void
-init_ssl_lib (void)
+init_ssl_lib (const char *engine_name)
 {
-  crypto_init_lib ();
+  crypto_init_lib (engine_name);
 }
 
 void
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3b4b88e..cd08cf3 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -358,7 +358,7 @@ void get_tls_handshake_key (const struct key_type *key_type,
 
 #else
 
-void init_ssl_lib (void);
+void init_ssl_lib (const char *engine_name);
 void free_ssl_lib (void);
 
 #endif /* ENABLE_SSL */
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 1eac611..9727a92 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -43,17 +43,12 @@
  * This routine should have additional OpenSSL crypto library initialisations
  * used by both crypto and ssl components of OpenVPN.
  */
-void crypto_init_lib (void);
+void crypto_init_lib (const char *engine_name);
 
 void crypto_uninit_lib (void);
 
 void crypto_clear_error (void);
 
-/*
- * Initialise the given named crypto engine.
- */
-void crypto_init_lib_engine (const char *engine_name);
-
 #ifdef DMALLOC
 /*
  * OpenSSL memory debugging.  If dmalloc debugging is enabled, tell
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5342502..a7ee168 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -169,7 +169,7 @@ setup_engine (const char *engine)
 
 #endif /* HAVE_OPENSSL_ENGINE */
 
-void
+static void
 crypto_init_lib_engine (const char *engine_name)
 {
 #if HAVE_OPENSSL_ENGINE
@@ -192,8 +192,11 @@ crypto_init_lib_engine (const char *engine_name)
  */
 
 void
-crypto_init_lib (void)
+crypto_init_lib (const char *engine_name)
 {
+  if (engine_name)
+    crypto_init_lib_engine (engine_name);
+
 #ifndef USE_SSL
 #ifndef ENABLE_SMALL
   ERR_load_crypto_strings ();
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 3978a3c..b7f13e3 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -54,26 +54,16 @@
 
 /*
  *
- * Hardware engine support. Allows loading/unloading of engines.
- *
- */
-
-void
-crypto_init_lib_engine (const char *engine_name)
-{
-  msg (M_WARN, "Note: PolarSSL hardware crypto engine functionality is not "
-      "available");
-}
-
-/*
- *
  * Functions related to the core crypto library
  *
  */
 
 void
-crypto_init_lib (void)
+crypto_init_lib (const char *engine_name)
 {
+  if (engine_name)
+    msg (M_WARN, "Note: PolarSSL hardware crypto engine functionality is not "
+        "available");
 }
 
 void
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 170abe1..65f43c3 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -192,9 +192,7 @@ openvpn_main (int argc, char *argv[])
           crypto_init_dmalloc ();
 #endif
           /* initialize crypto and ssl/tls libraries */
-          if (c.options.engine)
-            crypto_init_lib_engine (c.options.engine);
-          init_ssl_lib ();
+          init_ssl_lib (c.options.engine);
 
           /*
            * init PRNG used for IV generation
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 19512c0..e9a7d0a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -153,11 +153,10 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
 }
 
 void
-init_ssl_lib ()
+init_ssl_lib (const char *engine_name)
 {
+  crypto_init_lib (engine_name);
   tls_init_lib ();
-
-  crypto_init_lib ();
 }
 
 void
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cd7cae2..daa654c 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -144,7 +144,7 @@ struct tls_auth_standalone
 /*
  * Prepare the SSL library for use
  */
-void init_ssl_lib (void);
+void init_ssl_lib (const char *engine_name);
 
 /*
  * Free any internal state that the SSL library might have
-- 
1.7.9.5


