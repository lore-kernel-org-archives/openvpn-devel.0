From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:13 +0100
Message-Id: <1454874438-5081-6-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 05/10] Move packet_id into crypto_options
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

Decouples struct key_state and struct crypto_options. No longer updating
self-referential pointers!

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c     | 45 ++++++++++++++++++++++++---------------------
 src/openvpn/crypto.h     | 10 ++++------
 src/openvpn/init.c       | 11 +++++------
 src/openvpn/openvpn.h    |  2 --
 src/openvpn/packet_id.h  |  6 ++++++
 src/openvpn/ssl.c        | 38 +++++++++++++-------------------------
 src/openvpn/ssl_common.h |  2 --
 7 files changed, 52 insertions(+), 62 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9679fd0..db52182 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -85,8 +85,7 @@ memcmp_constant_time (const void *a, const void *b, size_t size) {
 
 void
 openvpn_encrypt (struct buffer *buf, struct buffer work,
-		 const struct crypto_options *opt,
-		 const struct frame* frame)
+		 struct crypto_options *opt, const struct frame* frame)
 {
   struct gc_arena gc;
   gc_init (&gc);
@@ -111,11 +110,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      if (opt->flags & CO_USE_IV)
 		prng_bytes (iv_buf, iv_size);
 
-	      /* Put packet ID in plaintext buffer or IV, depending on cipher mode */
-	      if (opt->packet_id)
+	      /* Put packet ID in plaintext buffer */
+	      if (packet_id_initialized(&opt->packet_id))
 		{
 		  struct packet_id_net pin;
-		  packet_id_alloc_outgoing (&opt->packet_id->send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
+		  packet_id_alloc_outgoing (&opt->packet_id.send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
 		  ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 		}
 	    }
@@ -124,10 +123,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      struct packet_id_net pin;
 	      struct buffer b;
 
-	      ASSERT (opt->flags & CO_USE_IV);    /* IV and packet-ID required */
-	      ASSERT (opt->packet_id); /*  for this mode. */
+	      /* IV and packet-ID required for this mode. */
+	      ASSERT (opt->flags & CO_USE_IV);
+	      ASSERT (packet_id_initialized(&opt->packet_id));
 
-	      packet_id_alloc_outgoing (&opt->packet_id->send, &pin, true);
+	      packet_id_alloc_outgoing (&opt->packet_id.send, &pin, true);
 	      memset (iv_buf, 0, iv_size);
 	      buf_set_write (&b, iv_buf, iv_size);
 	      ASSERT (packet_id_write (&pin, &b, true, false));
@@ -189,10 +189,10 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	}
       else				/* No Encryption */
 	{
-	  if (opt->packet_id)
+	  if (packet_id_initialized(&opt->packet_id))
 	    {
 	      struct packet_id_net pin;
-	      packet_id_alloc_outgoing (&opt->packet_id->send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
+	      packet_id_alloc_outgoing (&opt->packet_id.send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
 	      ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 	    }
 	  work = *buf;
@@ -233,8 +233,7 @@ err:
  */
 bool
 openvpn_decrypt (struct buffer *buf, struct buffer work,
-		 const struct crypto_options *opt,
-		 const struct frame* frame)
+		 struct crypto_options *opt, const struct frame* frame)
 {
   static const char error_prefix[] = "Authenticate/Decrypt packet error";
   struct gc_arena gc;
@@ -246,6 +245,9 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
       struct packet_id_net pin;
       bool have_pin = false;
 
+      dmsg (D_PACKET_CONTENT, "DECRYPT FROM: %s",
+	  format_hex (BPTR (buf), BLEN (buf), 80, &gc));
+
       /* Verify the HMAC */
       if (ctx->hmac)
 	{
@@ -325,7 +327,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	  {
 	    if (cipher_kt_mode_cbc(cipher_kt))
 	      {
-		if (opt->packet_id)
+		if (packet_id_initialized(&opt->packet_id))
 		  {
 		    if (!packet_id_read (&pin, &work, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM)))
 		      CRYPT_ERROR ("error reading CBC packet-id");
@@ -336,8 +338,9 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	      {
 		struct buffer b;
 
-		ASSERT (opt->flags & CO_USE_IV);    /* IV and packet-ID required */
-		ASSERT (opt->packet_id); /*  for this mode. */
+		/* IV and packet-ID required for this mode. */
+		ASSERT (opt->flags & CO_USE_IV);
+		ASSERT (packet_id_initialized(&opt->packet_id));
 
 		buf_set_read (&b, iv_buf, iv_size);
 		if (!packet_id_read (&pin, &b, true))
@@ -353,7 +356,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
       else
 	{
 	  work = *buf;
-	  if (opt->packet_id)
+	  if (packet_id_initialized(&opt->packet_id))
 	    {
 	      if (!packet_id_read (&pin, &work, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM)))
 		CRYPT_ERROR ("error reading packet-id");
@@ -363,12 +366,12 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
       
       if (have_pin)
 	{
-	  packet_id_reap_test (&opt->packet_id->rec);
-	  if (packet_id_test (&opt->packet_id->rec, &pin))
+	  packet_id_reap_test (&opt->packet_id.rec);
+	  if (packet_id_test (&opt->packet_id.rec, &pin))
 	    {
-	      packet_id_add (&opt->packet_id->rec, &pin);
+	      packet_id_add (&opt->packet_id.rec, &pin);
 	      if (opt->pid_persist && (opt->flags & CO_PACKET_ID_LONG_FORM))
-		packet_id_persist_save_obj (opt->pid_persist, opt->packet_id);
+		packet_id_persist_save_obj (opt->pid_persist, &opt->packet_id);
 	    }
 	  else
 	    {
@@ -688,7 +691,7 @@ key2_print (const struct key2* k,
 }
 
 void
-test_crypto (const struct crypto_options *co, struct frame* frame)
+test_crypto (struct crypto_options *co, struct frame* frame)
 {
   int i, j;
   struct gc_arena gc = gc_new ();
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1f84284..aac50c4 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -211,7 +211,7 @@ struct crypto_options
                                 /**< OpenSSL cipher and HMAC contexts for
                                  *   both sending and receiving
                                  *   directions. */
-  struct packet_id *packet_id;  /**< Current packet ID state for both
+  struct packet_id packet_id;   /**< Current packet ID state for both
                                  *   sending and receiving directions. */
   struct packet_id_persist *pid_persist;
                                 /**< Persistent packet ID state for
@@ -311,8 +311,7 @@ void free_key_ctx_bi (struct key_ctx_bi *ctx);
  *     error occurred.
  */
 void openvpn_encrypt (struct buffer *buf, struct buffer work,
-		      const struct crypto_options *opt,
-		      const struct frame* frame);
+		      struct crypto_options *opt, const struct frame* frame);
 
 
 /**
@@ -347,8 +346,7 @@ void openvpn_encrypt (struct buffer *buf, struct buffer work,
  *     an error occurred.
  */
 bool openvpn_decrypt (struct buffer *buf, struct buffer work,
-		      const struct crypto_options *opt,
-		      const struct frame* frame);
+		      struct crypto_options *opt, const struct frame* frame);
 
 /** @} name Functions for performing security operations on data channel packets */
 
@@ -397,7 +395,7 @@ void prng_bytes (uint8_t *output, int len);
 
 void prng_uninit ();
 
-void test_crypto (const struct crypto_options *co, struct frame* f);
+void test_crypto (struct crypto_options *co, struct frame* f);
 
 
 /* key direction functions */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dcc3ccb..cb73a3d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2076,16 +2076,15 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
   /* Initialize packet ID tracking */
   if (options->replay)
     {
-      packet_id_init (&c->c2.packet_id,
+      packet_id_init (&c->c2.crypto_options.packet_id,
 		      link_socket_proto_connection_oriented (options->ce.proto),
 		      options->replay_window,
 		      options->replay_time,
 		      "STATIC", 0);
-      c->c2.crypto_options.packet_id = &c->c2.packet_id;
       c->c2.crypto_options.pid_persist = &c->c1.pid_persist;
       c->c2.crypto_options.flags |= CO_PACKET_ID_LONG_FORM;
       packet_id_persist_load_obj (&c->c1.pid_persist,
-				  c->c2.crypto_options.packet_id);
+				  &c->c2.crypto_options.packet_id);
     }
 
   if (!key_ctx_bi_defined (&c->c1.ks.static_key))
@@ -3007,7 +3006,7 @@ static void
 do_close_packet_id (struct context *c)
 {
 #ifdef ENABLE_CRYPTO
-  packet_id_free (&c->c2.packet_id);
+  packet_id_free (&c->c2.crypto_options.packet_id);
   packet_id_persist_save (&c->c1.pid_persist);
   if (!(c->sig->signal_received == SIGUSR1))
     packet_id_persist_close (&c->c1.pid_persist);
@@ -3923,13 +3922,13 @@ test_crypto_thread (void *arg)
   test_crypto (&c->c2.crypto_options, &c->c2.frame);
 
   key_schedule_free (&c->c1.ks, true);
-  packet_id_free (&c->c2.packet_id);
+  packet_id_free (&c->c2.crypto_options.packet_id);
 
   context_gc_free (c);
   return NULL;
 }
 
-#endif
+#endif /* ENABLE_CRYPTO */
 
 bool
 do_test_crypto (const struct options *o)
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 71adf48..3281fd7 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -361,8 +361,6 @@ struct context_2
                                  *   Channel Crypto module\endlink to
                                  *   process data channel packet. */
 
-  /* used to keep track of data channel packet sequence numbers */
-  struct packet_id packet_id;
   struct event_timeout packet_id_persist_interval;
 
 #endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 3ddaab6..5eb501d 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -258,6 +258,12 @@ bool packet_id_write (const struct packet_id_net *pin, struct buffer *buf, bool
  * Inline functions.
  */
 
+/** Is this struct packet_id initialized? */
+static inline bool packet_id_initialized (const struct packet_id *pid)
+{
+  return pid->rec.initialized;
+}
+
 /* are we in enabled state? */
 static inline bool
 packet_id_persist_enabled (const struct packet_id_persist *p)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e3a745d..7f99ee9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -780,13 +780,13 @@ key_state_init (struct tls_session *session, struct key_state *ks)
   reliable_set_timeout (ks->send_reliable, session->opt->packet_timeout);
 
   /* init packet ID tracker */
-  packet_id_init (&ks->packet_id,
-		  session->opt->tcp_mode,
-		  session->opt->replay_window,
-		  session->opt->replay_time,
-		  "SSL", ks->key_id);
+  if (session->opt->replay)
+    {
+      packet_id_init (&ks->crypto_options.packet_id, session->opt->tcp_mode,
+	  session->opt->replay_window, session->opt->replay_time, "SSL",
+	  ks->key_id);
+    }
 
-  ks->crypto_options.packet_id = session->opt->replay ? &ks->packet_id : NULL;
   ks->crypto_options.pid_persist = NULL;
   ks->crypto_options.flags = session->opt->crypto_flags;
   ks->crypto_options.flags &= session->opt->crypto_flags_and;
@@ -842,7 +842,7 @@ key_state_free (struct key_state *ks, bool clear)
   if (ks->key_src)
     free (ks->key_src);
 
-  packet_id_free (&ks->packet_id);
+  packet_id_free (&ks->crypto_options.packet_id);
 
 #ifdef PLUGIN_DEF_AUTH
   key_state_rm_auth_control_file (ks);
@@ -857,13 +857,6 @@ key_state_free (struct key_state *ks, bool clear)
 /** @} addtogroup control_processor */
 
 
-/*
- * Must be called if we move a tls_session in memory.
- */
-static inline void tls_session_set_self_referential_pointers (struct tls_session* session) {
-  session->tls_auth.packet_id = &session->tls_auth_pid;
-}
-
 /**
  * Returns whether or not the server should check for username/password
  *
@@ -936,18 +929,15 @@ tls_session_init (struct tls_multi *multi, struct tls_session *session)
   /* Initialize control channel authentication parameters */
   session->tls_auth = session->opt->tls_auth;
 
-  /* Set session internal pointers (also called if session object is moved in memory) */
-  tls_session_set_self_referential_pointers (session);
-
   /* initialize packet ID replay window for --tls-auth */
-  packet_id_init (session->tls_auth.packet_id,
+  packet_id_init (&session->tls_auth.packet_id,
 		  session->opt->tcp_mode,
 		  session->opt->replay_window,
 		  session->opt->replay_time,
 		  "TLS_AUTH", session->key_id);
 
   /* load most recent packet-id to replay protect on --tls-auth */
-  packet_id_persist_load_obj (session->tls_auth.pid_persist, session->tls_auth.packet_id);
+  packet_id_persist_load_obj (session->tls_auth.pid_persist, &session->tls_auth.packet_id);
 
   key_state_init (session, &session->key[KS_PRIMARY]);
 
@@ -974,8 +964,8 @@ tls_session_free (struct tls_session *session, bool clear)
 {
   int i;
 
-  if (session->tls_auth.packet_id)
-    packet_id_free (session->tls_auth.packet_id);
+  if (packet_id_initialized(&session->tls_auth.packet_id))
+    packet_id_free (&session->tls_auth.packet_id);
 
   for (i = 0; i < KS_SIZE; ++i)
     key_state_free (&session->key[i], false);
@@ -1006,7 +996,6 @@ move_session (struct tls_multi* multi, int dest, int src, bool reinit_src)
   ASSERT (dest >= 0 && dest < TM_SIZE);
   tls_session_free (&multi->session[dest], false);
   multi->session[dest] = multi->session[src];
-  tls_session_set_self_referential_pointers (&multi->session[dest]);
 
   if (reinit_src)
     tls_session_init (multi, &multi->session[src]);
@@ -1274,7 +1263,7 @@ write_control_auth (struct tls_session *session,
  */
 static bool
 read_control_auth (struct buffer *buf,
-		   const struct crypto_options *co,
+		   struct crypto_options *co,
 		   const struct link_socket_actual *from)
 {
   struct gc_arena gc = gc_new ();
@@ -1702,7 +1691,6 @@ key_state_soft_reset (struct tls_session *session)
   ks->must_die = now + session->opt->transition_window; /* remaining lifetime of old key */
   key_state_free (ks_lame, false);
   *ks_lame = *ks;
-  ks_lame->crypto_options.packet_id = &ks_lame->packet_id;
 
   key_state_init (session, ks);
   ks->session_id_remote = ks_lame->session_id_remote;
@@ -2257,7 +2245,7 @@ tls_process (struct tls_multi *multi,
 	   && ks->n_bytes >= session->opt->renegotiate_bytes)
        || (session->opt->renegotiate_packets
 	   && ks->n_packets >= session->opt->renegotiate_packets)
-       || (packet_id_close_to_wrapping (&ks->packet_id.send))))
+       || (packet_id_close_to_wrapping (&ks->crypto_options.packet_id.send))))
     {
       msg (D_TLS_DEBUG_LOW,
            "TLS: soft reset sec=%d bytes=" counter_format "/%d pkts=" counter_format "/%d",
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index b40aec2..eaf4a91 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -160,7 +160,6 @@ struct key_state
   int initial_opcode;		/* our initial P_ opcode */
   struct session_id session_id_remote;   /* peer's random session ID */
   struct link_socket_actual remote_addr; /* peer's IP addr */
-  struct packet_id packet_id;	       /* for data channel, to prevent replay attacks */
 
   struct crypto_options crypto_options;/* data channel crypto options */
 
@@ -366,7 +365,6 @@ struct tls_session
 
   /* authenticate control packets */
   struct crypto_options tls_auth;
-  struct packet_id tls_auth_pid;
 
   int initial_opcode;		/* our initial P_ opcode */
   struct session_id session_id;	/* our random session ID */
-- 
2.5.0


