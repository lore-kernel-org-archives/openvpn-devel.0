From: Steffan Karger <steffan@...1856...>
Date: Wed,  8 Jun 2016 14:20:41 +0200
Message-Id: <1465388443-15484-4-git-send-email-steffan@...1856...>
In-Reply-To: <1465388443-15484-1-git-send-email-steffan@...1856...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/5] Add client-side support for cipher
	negotiation
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

Based on the 'IV_NCP=2' mechanism described in
http://permalink.gmane.org/gmane.network.openvpn.devel/9385.

This is the first patch of a set that adds support for cipher negatiation.
Follow-up patches will add ways to restrict or disable the mechanism, and
add server-side support.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c         | 18 +++++++++---
 src/openvpn/crypto.h         |  4 +++
 src/openvpn/crypto_backend.h |  6 ++++
 src/openvpn/init.c           | 51 +++++++++++++++++++++++----------
 src/openvpn/init.h           |  3 +-
 src/openvpn/misc.h           |  7 +++++
 src/openvpn/mtu.c            |  2 --
 src/openvpn/multi.c          |  2 +-
 src/openvpn/route.c          |  4 +--
 src/openvpn/ssl.c            | 67 +++++++++++++++++++++++++++++++++++++++-----
 src/openvpn/ssl.h            | 14 +++++++++
 src/openvpn/ssl_common.h     | 16 +++++++++--
 12 files changed, 159 insertions(+), 35 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5c392aa..e43c30b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -709,10 +709,6 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
   return ret;
 }
 
-/*
- * How many bytes will we add to frame buffer for a given
- * set of crypto options?
- */
 void
 crypto_adjust_frame_parameters(struct frame *frame,
 			       const struct key_type* kt,
@@ -746,6 +742,14 @@ crypto_adjust_frame_parameters(struct frame *frame,
       __func__, crypto_overhead);
 }
 
+size_t
+crypto_max_overhead(void)
+{
+  return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH +
+      OPENVPN_MAX_CIPHER_BLOCK_SIZE +
+      MAX(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+}
+
 /*
  * Build a struct key_type.
  */
@@ -774,6 +778,9 @@ init_key_type (struct key_type *kt, const char *ciphername,
 #endif
 	    ))
 	msg (M_FATAL, "Cipher '%s' mode not supported", ciphername);
+
+      if (OPENVPN_MAX_CIPHER_BLOCK_SIZE < cipher_kt_block_size(kt->cipher))
+	msg (M_FATAL, "Cipher '%s' not allowed: block size too big.", ciphername);
     }
   else
     {
@@ -785,6 +792,9 @@ init_key_type (struct key_type *kt, const char *ciphername,
       if (!aead_cipher) { /* Ignore auth for AEAD ciphers */
 	kt->digest = md_kt_get (authname);
 	kt->hmac_length = md_kt_size (kt->digest);
+
+	if (OPENVPN_MAX_HMAC_SIZE < kt->hmac_length)
+	  msg (M_FATAL, "HMAC '%s' not allowed: digest size too big.", authname);
       }
     }
   else if (!aead_cipher)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 63d7040..de433ae 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -226,6 +226,7 @@ struct key_ctx_bi
 				 *   direction. */
   struct key_ctx decrypt;       /**< cipher and/or HMAC contexts for
                                  *   receiving direction. */
+  bool initialized;
 };
 
 /**
@@ -385,6 +386,7 @@ bool openvpn_decrypt (struct buffer *buf, struct buffer work,
 
 /** @} name Functions for performing security operations on data channel packets */
 
+/** Calculate crypto overhead and adjust frame to account for that */
 void crypto_adjust_frame_parameters(struct frame *frame,
 				    const struct key_type* kt,
 				    bool cipher_defined,
@@ -392,6 +394,8 @@ void crypto_adjust_frame_parameters(struct frame *frame,
 				    bool packet_id,
 				    bool packet_id_long_form);
 
+/** Return the worst-case OpenVPN crypto overhead (in bytes) */
+size_t crypto_max_overhead(void);
 
 /* Minimum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MIN 16
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 3893f14..a699673 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -41,6 +41,12 @@
 /* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
 #define OPENVPN_AEAD_TAG_LENGTH 16
 
+/* Maximum cipher block size (bytes) */
+#define OPENVPN_MAX_CIPHER_BLOCK_SIZE 32
+
+/* Maximum HMAC digest size (bytes) */
+#define OPENVPN_MAX_HMAC_SIZE 	64
+
 /** Struct used in cipher name translation table */
 typedef struct {
   const char *openvpn_name;	/**< Cipher name used by OpenVPN */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 50cbf90..5eded09 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1819,6 +1819,7 @@ pull_permission_mask (const struct context *c)
     | OPT_P_SHAPER
     | OPT_P_TIMER
     | OPT_P_COMP
+    | OPT_P_CRYPTO
     | OPT_P_PERSIST
     | OPT_P_MESSAGES
     | OPT_P_EXPLICIT_NOTIFY
@@ -1922,6 +1923,13 @@ do_deferred_options (struct context *c, const unsigned int found)
                        " MTU problems", TUN_MTU_SIZE(&c->c2.frame) );
 	}
     }
+
+  /* process (potenitally pushed) crypto options */
+  if (c->options.pull)
+    {
+      tls_session_update_crypto_params(&c->c2.tls_multi->session[TM_ACTIVE],
+          &c->options, &c->c2.frame);
+    }
 #endif
 }
 
@@ -2027,6 +2035,7 @@ frame_finalize_options (struct context *c, const struct options *o)
 			    |FRAME_HEADROOM_MARKER_READ_STREAM);
     }
   
+  frame_add_to_extra_buffer (&c->c2.frame, PAYLOAD_ALIGN);
   frame_finalize (&c->c2.frame,
 		  o->ce.link_mtu_defined,
 		  o->ce.link_mtu,
@@ -2282,12 +2291,13 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
   packet_id_long_form = cipher_kt_mode_ofb_cfb (c->c1.ks.key_type.cipher);
 
-  /* Compute MTU parameters */
-  crypto_adjust_frame_parameters (&c->c2.frame,
-				  &c->c1.ks.key_type,
-				  options->ciphername_defined,
-				  options->use_iv,
-				  options->replay, packet_id_long_form);
+  /* Compute MTU parameters (postpone if we pull options) */
+  if (!c->options.pull)
+    {
+      crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
+	  options->ciphername_defined, options->use_iv, options->replay,
+	  packet_id_long_form);
+    }
   tls_adjust_frame_parameters (&c->c2.frame);
 
   /* Set all command-line TLS-related options */
@@ -2318,6 +2328,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.renegotiate_packets = options->renegotiate_packets;
   to.renegotiate_seconds = options->renegotiate_seconds;
   to.single_session = options->single_session;
+  to.pull = options->pull;
 #ifdef ENABLE_PUSH_PEER_INFO
   if (options->push_peer_info)		/* all there is */
     to.push_peer_info_detail = 2;
@@ -2686,25 +2697,26 @@ do_init_frame_tls (struct context *c)
 }
 
 struct context_buffers *
-init_context_buffers (const struct frame *frame)
+init_context_buffers (const struct frame *frame, size_t extra_bytes)
 {
   struct context_buffers *b;
+  const size_t buf_size = BUF_SIZE (frame) + extra_bytes;
 
   ALLOC_OBJ_CLEAR (b, struct context_buffers);
 
-  b->read_link_buf = alloc_buf (BUF_SIZE (frame));
-  b->read_tun_buf = alloc_buf (BUF_SIZE (frame));
+  b->read_link_buf = alloc_buf (buf_size);
+  b->read_tun_buf = alloc_buf (buf_size);
 
-  b->aux_buf = alloc_buf (BUF_SIZE (frame));
+  b->aux_buf = alloc_buf (buf_size);
 
 #ifdef ENABLE_CRYPTO
-  b->encrypt_buf = alloc_buf (BUF_SIZE (frame));
-  b->decrypt_buf = alloc_buf (BUF_SIZE (frame));
+  b->encrypt_buf = alloc_buf (buf_size);
+  b->decrypt_buf = alloc_buf (buf_size);
 #endif
 
 #ifdef USE_COMP
-  b->compress_buf = alloc_buf (BUF_SIZE (frame));
-  b->decompress_buf = alloc_buf (BUF_SIZE (frame));
+  b->compress_buf = alloc_buf (buf_size);
+  b->decompress_buf = alloc_buf (buf_size);
 #endif
 
   return b;
@@ -2740,7 +2752,16 @@ free_context_buffers (struct context_buffers *b)
 static void
 do_init_buffers (struct context *c)
 {
-  c->c2.buffers = init_context_buffers (&c->c2.frame);
+  size_t extra_bytes = 0;
+#ifdef ENABLE_CRYPTO
+  if (c->options.pull)
+    {
+      /* If we use --pull, we don't know the crypto overhead yet. */
+      msg (M_WARN, "*** Account for max crypto overhead ***");
+      extra_bytes = crypto_max_overhead();
+    }
+#endif
+  c->c2.buffers = init_context_buffers (&c->c2.frame, extra_bytes);
   c->c2.buffers_owned = true;
 }
 
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index a819bd2..73bcb74 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -106,7 +106,8 @@ void inherit_context_top (struct context *dest,
 
 void close_context (struct context *c, int sig, unsigned int flags);
 
-struct context_buffers *init_context_buffers (const struct frame *frame);
+struct context_buffers *init_context_buffers (const struct frame *frame,
+					      size_t extra_bytes);
 
 void free_context_buffers (struct context_buffers *b);
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 65a6e55..82d1d48 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -102,6 +102,13 @@ openvpn_run_script (const struct argv *a, const struct env_set *es, const unsign
   return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
 }
 
+#ifndef MIN
+#define MIN(a,b) ((a) < (b) ? (a) : (b))
+#endif
+
+#ifndef MAX
+#define MAX(a,b) ((a) > (b) ? (a) : (b))
+#endif
 
 #ifdef HAVE_STRERROR
 /* a thread-safe version of strerror */
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 24531c9..64d1cf3 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -78,8 +78,6 @@ frame_finalize (struct frame *frame,
     }
 
   frame->link_mtu_dynamic = frame->link_mtu;
-
-  frame->extra_buffer += PAYLOAD_ALIGN;
 }
 
 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ba7f2c0..117f768 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2862,7 +2862,7 @@ void
 multi_top_init (struct multi_context *m, const struct context *top)
 {
   inherit_context_top (&m->top, top);
-  m->top.c2.buffers = init_context_buffers (&top->c2.frame);
+  m->top.c2.buffers = init_context_buffers (&top->c2.frame, 0);
 }
 
 void
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a90195f..578a708 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3265,8 +3265,6 @@ struct rtmsg {
 #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
 #endif
 
-#define max(a,b) ((a) > (b) ? (a) : (b))
-
 void
 get_default_gateway (struct route_gateway_info *rgi)
 {
@@ -3433,7 +3431,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 #if defined(TARGET_SOLARIS)
 	  const size_t len = sizeof(ifr->ifr_name) + sizeof(ifr->ifr_addr);
 #else
-	  const size_t len = sizeof(ifr->ifr_name) + max(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
+	  const size_t len = sizeof(ifr->ifr_name) + MAX(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
 #endif
 
 	  if (!ifr->ifr_addr.sa_family)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4291314..8a87db2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -767,10 +767,6 @@ key_state_init (struct tls_session *session, struct key_state *ks)
   ks->state = S_INITIAL;
   ks->key_id = session->key_id;
 
-  /*
-   * key_id increments to KEY_ID_MASK then recycles back to 1.
-   * This way you know that if key_id is 0, it is the first key.
-   */
   ++session->key_id;
   session->key_id &= P_KEY_ID_MASK;
   if (!session->key_id)
@@ -1613,6 +1609,7 @@ generate_key_expansion (struct key_ctx_bi *key,
   key_ctx_update_implicit_iv (&key->decrypt, key2.keys[1-(int)server].hmac,
       MAX_HMAC_KEY_LENGTH);
 
+  key->initialized = true;
   ret = true;
 
  exit:
@@ -1639,6 +1636,48 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
     }
 }
 
+bool
+tls_session_update_crypto_params(struct tls_session *session,
+    const struct options *options, struct frame *frame)
+{
+  bool ret = false;
+  struct key_state *ks = &session->key[KS_PRIMARY];	/* primary key */
+
+  ASSERT (!session->opt->server);
+  ASSERT (ks->authenticated);
+
+  init_key_type (&session->opt->key_type, options->ciphername,
+    options->ciphername_defined, options->authname, options->authname_defined,
+    options->keysize, true, true);
+
+  bool packet_id_long_form = cipher_kt_mode_ofb_cfb (session->opt->key_type.cipher);
+  session->opt->crypto_flags_and &= ~(CO_PACKET_ID_LONG_FORM);
+  if (packet_id_long_form)
+    session->opt->crypto_flags_and = CO_PACKET_ID_LONG_FORM;
+
+  crypto_adjust_frame_parameters (frame, &session->opt->key_type,
+      options->ciphername_defined, options->use_iv, options->replay,
+      packet_id_long_form);
+  frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
+      options->ce.tun_mtu_defined, options->ce.tun_mtu);
+  frame_print (frame, D_MTU_INFO, "Data Channel MTU parms");
+
+  if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
+			       &session->opt->key_type,
+			       ks->key_src,
+			       &session->session_id,
+			       &ks->session_id_remote,
+			       false))
+    {
+      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+      goto cleanup;
+    }
+  ret = true;
+cleanup:
+  CLEAR (*ks->key_src);
+  return ret;
+}
+
 static bool
 random_bytes_to_buf (struct buffer *buf,
 		     uint8_t *out,
@@ -1885,6 +1924,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       /* support for P_DATA_V2 */
       buf_printf(&out, "IV_PROTO=2\n");
 
+      /* support for Negotiable Crypto Paramters */
+      buf_printf(&out, "IV_NCP=2\n");
+
       /* push compression status */
 #ifdef USE_COMP
       comp_generate_peer_info_string(&session->opt->comp_options, &out);
@@ -2209,9 +2251,11 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
     }
 
   /*
-   * Generate tunnel keys if client
+   * Generate tunnel keys if we're a client.
+   * If --pull is enabled, the first key generation is postponed until after the
+   * pull/push, so we can process pushed cipher directives.
    */
-  if (!session->opt->server)
+  if (!session->opt->server && (!session->opt->pull || ks->key_id > 0))
     {
       if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
 				   &session->opt->key_type,
@@ -2223,7 +2267,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 	  msg (D_TLS_ERRORS, "TLS Error: client generate_key_expansion failed");
 	  goto error;
 	}
-		      
+
       CLEAR (*ks->key_src);
     }
 
@@ -2889,6 +2933,14 @@ tls_pre_decrypt (struct tls_multi *multi,
 #endif
 		  && (floated || link_socket_actual_match (from, &ks->remote_addr)))
 		{
+		  if (!ks->crypto_options.key_ctx_bi.initialized)
+		    {
+		      msg (D_TLS_DEBUG_LOW,
+			  "Key %s [%d] not initialized (yet), dropping packet.",
+			  print_link_socket_actual (from, &gc), key_id);
+		      goto error;
+		    }
+
 		  /* return appropriate data channel decrypt key in opt */
 		  *opt = &ks->crypto_options;
 		  if (op == P_DATA_V2)
@@ -3426,6 +3478,7 @@ tls_pre_encrypt (struct tls_multi *multi,
 	  struct key_state *ks = multi->key_scan[i];
 	  if (ks->state >= S_ACTIVE
 	      && ks->authenticated
+	      && ks->crypto_options.key_ctx_bi.initialized
 #ifdef ENABLE_DEF_AUTH
 	      && !ks->auth_deferred
 #endif
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index d9ff8d0..416f426 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -475,6 +475,20 @@ bool tls_rec_payload (struct tls_multi *multi,
 void tls_update_remote_addr (struct tls_multi *multi,
 			     const struct link_socket_actual *addr);
 
+/**
+ * Update TLS session crypto parameters (cipher and auth) and derive data
+ * channel keys based on the supplied options.
+ *
+ * @param session	The TLS session to update.
+ * @param options	The options to use when updating session.
+ * @param frame		The frame options for this session (frame overhead is
+ * 			adjusted based on the selected cipher/auth).
+ *
+ * @return true if updating succeeded, false otherwise.
+ */
+bool tls_session_update_crypto_params(struct tls_session *session,
+    const struct options *options, struct frame *frame);
+
 #ifdef MANAGEMENT_DEF_AUTH
 static inline char *
 tls_get_peer_info(const struct tls_multi *multi)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index a0df0ff..9183dab 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -149,7 +149,12 @@ struct key_source2 {
 struct key_state
 {
   int state;
-  int key_id;			/* inherited from struct tls_session below */
+
+  /**
+   * Key id for this key_state,  inherited from struct tls_session.
+   * @see tls_session::key_id.
+   */
+  int key_id;
 
   struct key_state_ssl ks_ssl;	/* contains SSL object and BIOs for the control channel */
 
@@ -231,6 +236,7 @@ struct tls_options
 #ifdef ENABLE_OCC
   bool disable_occ;
 #endif
+  bool pull;
 #ifdef ENABLE_PUSH_PEER_INFO
   int push_peer_info_detail;
 #endif
@@ -367,7 +373,13 @@ struct tls_session
 
   int initial_opcode;		/* our initial P_ opcode */
   struct session_id session_id;	/* our random session ID */
-  int key_id;			/* increments with each soft reset (for key renegotiation) */
+
+  /**
+   * The current active key id, used to keep track of renegotiations.
+   * key_id increments with each soft reset to KEY_ID_MASK then recycles back
+   * to 1.  This way you know that if key_id is 0, it is the first key.
+   */
+  int key_id;
 
   int limit_next;               /* used for traffic shaping on the control channel */
 
-- 
2.7.4


