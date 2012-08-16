From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 16 Aug 2012 10:38:17 +0200
Message-ID: <1345106302-22850-3-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
References: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/7] init crypto engine before SSL library
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

Since GOST in OpenSSL is implemented in an engine, the engine must
be loaded before the SSL library is initialized for the algorithms
to become available for SSL/TLS.

This delays the initialization of the ssl lib until after the options
are parsed, so a possibly configured engine can be loaded before.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/init.c    |   65 +++++++++++++++++--------------------------------
 src/openvpn/init.h    |    1 +
 src/openvpn/openvpn.c |   22 +++++++++++++++++
 3 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 270ee6a..564621d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -589,10 +589,6 @@ init_static (void)
 {
   /* configure_path (); */
 
-#if defined(ENABLE_CRYPTO) && defined(DMALLOC)
-  crypto_init_dmalloc();
-#endif
-
   init_random_seed ();		/* init random() function, only used as
 				   source for weak random numbers */
   error_reset ();		/* initialize error.c */
@@ -612,15 +608,6 @@ init_static (void)
 
   update_time ();
 
-#ifdef ENABLE_CRYPTO
-  init_ssl_lib ();
-
-  /* init PRNG used for IV generation */
-  /* When forking, copy this to more places in the code to avoid fork
-     random-state predictability */
-  prng_init (NULL, 0);
-#endif
-
 #ifdef PID_TEST
   packet_id_interactive_test ();	/* test the sequence number code */
   return false;
@@ -699,29 +686,6 @@ init_static (void)
   }
 #endif
 
-#ifdef PRNG_TEST
-  {
-    struct gc_arena gc = gc_new ();
-    uint8_t rndbuf[8];
-    int i;
-    prng_init ("sha1", 16);
-    /*prng_init (NULL, 0);*/
-    const int factor = 1;
-    for (i = 0; i < factor * 8; ++i)
-      {
-#if 1
-	prng_bytes (rndbuf, sizeof (rndbuf));
-#else
-	ASSERT(rand_bytes (rndbuf, sizeof (rndbuf)));
-#endif
-	printf ("[%d] %s\n", i, format_hex (rndbuf, sizeof (rndbuf), 0, &gc));
-      }
-    gc_free (&gc);
-    prng_uninit ();
-    return false;
-  }
-#endif
-
 #ifdef BUFFER_LIST_AGGREGATE_TEST
   /* test buffer_list_aggregate function */
   {
@@ -798,10 +762,6 @@ init_static (void)
 void
 uninit_static (void)
 {
-#ifdef ENABLE_CRYPTO
-  free_ssl_lib ();
-#endif
-
 #ifdef ENABLE_PKCS11
   pkcs11_terminate ();
 #endif
@@ -1942,9 +1902,6 @@ key_schedule_free (struct key_schedule *ks, bool free_ssl_ctx)
 static void
 init_crypto_pre (struct context *c, const unsigned int flags)
 {
-  if (c->options.engine)
-    crypto_init_lib_engine (c->options.engine);
-
   if (flags & CF_LOAD_PERSISTED_PACKET_ID)
     {
       /* load a persisted packet-id for cross-session replay-protection */
@@ -3715,6 +3672,28 @@ test_crypto_thread (void *arg)
 #endif
 
 bool
+do_test_prng ()
+{
+#ifdef PRNG_TEST
+  struct gc_arena gc = gc_new ();
+  uint8_t rndbuf[8];
+  int i;
+  prng_init ("sha1", 16);
+  const int factor = 1;
+  for (i = 0; i < factor * 8; ++i)
+    {
+      prng_bytes (rndbuf, sizeof (rndbuf));
+      printf ("[%d] %s\n", i, format_hex (rndbuf, sizeof (rndbuf), 0, &gc));
+    }
+  gc_free (&gc);
+  prng_uninit ();
+  return true;
+#else
+  return false;
+#endif
+}
+
+bool
 do_test_crypto (const struct options *o)
 {
 #ifdef ENABLE_CRYPTO
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 5a1d1dc..ed95f85 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -70,6 +70,7 @@ void do_route (const struct options *options,
 
 void close_instance (struct context *c);
 
+bool do_test_prng ();
 bool do_test_crypto (const struct options *o);
 
 void context_gc_free (struct context *c);
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 104c9e9..170abe1 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -187,6 +187,25 @@ openvpn_main (int argc, char *argv[])
 	  /* parse command line options, and read configuration file */
 	  parse_argv (&c.options, argc, argv, M_USAGE, OPT_P_DEFAULT, NULL, c.es);
 
+#ifdef ENABLE_CRYPTO
+#ifdef DMALLOC
+          crypto_init_dmalloc ();
+#endif
+          /* initialize crypto and ssl/tls libraries */
+          if (c.options.engine)
+            crypto_init_lib_engine (c.options.engine);
+          init_ssl_lib ();
+
+          /*
+           * init PRNG used for IV generation
+           * when forking, copy this to more places in the code to avoid fork
+           * random-state predictability
+           */
+          prng_init (NULL, 0);
+          if (do_test_prng ())
+            break;
+#endif
+
 #ifdef ENABLE_PLUGIN
 	  /* plugins may contribute options configuration */
 	  init_verb_mute (&c, IVM_LEVEL_1);
@@ -269,6 +288,9 @@ openvpn_main (int argc, char *argv[])
 	    }
 	  while (c.sig->signal_received == SIGUSR1);
 
+#ifdef ENABLE_CRYPTO
+          free_ssl_lib ();
+#endif
 	  uninit_options (&c.options);
 	  gc_reset (&c.gc);
 	}
-- 
1.7.9.5


