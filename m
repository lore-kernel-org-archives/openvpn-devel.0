From: Steffan Karger <steffan@...1856...>
Date: Tue, 28 Jun 2016 23:33:55 +0200
Message-Id: <1467149635-9726-1-git-send-email-steffan@...1856...>
In-Reply-To: <20160623183246.GN79504@...1296...>
References: <20160623183246.GN79504@...1296...>
Subject: [Openvpn-devel] [PATCH 3/5 v4] Add client-side support for cipher
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

This is the first patch of a set that adds support for cipher negotiation.
Follow-up patches will add ways to restrict or disable the mechanism, and
add server-side support.

v2:
 * Account for crypto overhead through struct frame.  This is less
   transparant, but the code has been built to work this way.  The
   previous approach didn't work with TCP mode (or --port-share).
 * Calculate the link-mtu sent in the options string based on the crypto
   parameters specified in the config file (prevents link-mtu warnings in
   older peers when connecting).

v3:
 * Use existing max_int() function, instead of new MAX() macro.
 * Fix typo in comment.
 * Do not regenerate keys if the server sends a second push msg
 * Only push IV_NCP if we're pull-client (and thus can do NCP)

v4:
 * Fix rebase errors (OPT_P_NCP sneaked in, but is not introduced till 4/5,
   and tls_peer_info_ncp_ver() is not needed until 5/5).
 * Don't remove comment about key_id increment behaviour in init.c (but
   still add the extra comments in the .h files).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c         | 19 ++++++++++---
 src/openvpn/crypto.h         |  4 +++
 src/openvpn/crypto_backend.h |  6 ++++
 src/openvpn/init.c           | 34 +++++++++++++++++++----
 src/openvpn/mtu.c            |  2 --
 src/openvpn/options.c        | 35 +++++++++++++++++++++--
 src/openvpn/ssl.c            | 66 ++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/ssl.h            | 14 ++++++++++
 src/openvpn/ssl_common.h     | 16 +++++++++--
 9 files changed, 177 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5c392aa..f9cf62a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -35,6 +35,7 @@
 
 #include "crypto.h"
 #include "error.h"
+#include "integer.h"
 #include "misc.h"
 
 #include "memdbg.h"
@@ -709,10 +710,6 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
   return ret;
 }
 
-/*
- * How many bytes will we add to frame buffer for a given
- * set of crypto options?
- */
 void
 crypto_adjust_frame_parameters(struct frame *frame,
 			       const struct key_type* kt,
@@ -746,6 +743,14 @@ crypto_adjust_frame_parameters(struct frame *frame,
       __func__, crypto_overhead);
 }
 
+size_t
+crypto_max_overhead(void)
+{
+  return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH +
+      OPENVPN_MAX_CIPHER_BLOCK_SIZE +
+      max_int (OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+}
+
 /*
  * Build a struct key_type.
  */
@@ -774,6 +779,9 @@ init_key_type (struct key_type *kt, const char *ciphername,
 #endif
 	    ))
 	msg (M_FATAL, "Cipher '%s' mode not supported", ciphername);
+
+      if (OPENVPN_MAX_CIPHER_BLOCK_SIZE < cipher_kt_block_size(kt->cipher))
+	msg (M_FATAL, "Cipher '%s' not allowed: block size too big.", ciphername);
     }
   else
     {
@@ -785,6 +793,9 @@ init_key_type (struct key_type *kt, const char *ciphername,
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
index 50cbf90..2f4c631 100644
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
@@ -1922,6 +1923,19 @@ do_deferred_options (struct context *c, const unsigned int found)
                        " MTU problems", TUN_MTU_SIZE(&c->c2.frame) );
 	}
     }
+
+  /* process (potentially pushed) crypto options */
+  if (c->options.pull)
+    {
+      struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+      if (found & OPT_P_CRYPTO)
+	msg (D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
+      /* Do not regenerate keys if server sends an extra push request */
+      if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
+	{
+	  tls_session_update_crypto_params(session, &c->options, &c->c2.frame);
+	}
+    }
 #endif
 }
 
@@ -2027,6 +2041,7 @@ frame_finalize_options (struct context *c, const struct options *o)
 			    |FRAME_HEADROOM_MARKER_READ_STREAM);
     }
   
+  frame_add_to_extra_buffer (&c->c2.frame, PAYLOAD_ALIGN);
   frame_finalize (&c->c2.frame,
 		  o->ce.link_mtu_defined,
 		  o->ce.link_mtu,
@@ -2282,12 +2297,18 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
   packet_id_long_form = cipher_kt_mode_ofb_cfb (c->c1.ks.key_type.cipher);
 
-  /* Compute MTU parameters */
-  crypto_adjust_frame_parameters (&c->c2.frame,
-				  &c->c1.ks.key_type,
-				  options->ciphername_defined,
-				  options->use_iv,
-				  options->replay, packet_id_long_form);
+  /* Compute MTU parameters (postpone if we pull options) */
+  if (c->options.pull)
+    {
+      /* Account for worst-case crypto overhead before allocating buffers */
+      frame_add_to_extra_frame (&c->c2.frame, crypto_max_overhead());
+    }
+  else
+    {
+      crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
+	  options->ciphername_defined, options->use_iv, options->replay,
+	  packet_id_long_form);
+    }
   tls_adjust_frame_parameters (&c->c2.frame);
 
   /* Set all command-line TLS-related options */
@@ -2318,6 +2339,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.renegotiate_packets = options->renegotiate_packets;
   to.renegotiate_seconds = options->renegotiate_seconds;
   to.single_session = options->single_session;
+  to.pull = options->pull;
 #ifdef ENABLE_PUSH_PEER_INFO
   if (options->push_peer_info)		/* all there is */
     to.push_peer_info_detail = 2;
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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 23f407c..a595dff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2974,6 +2974,38 @@ pre_pull_restore (struct options *o, struct gc_arena *gc)
 
 #ifdef ENABLE_OCC
 
+/**
+ * Calculate the link-mtu to advertise to our peer.  The actual value is not
+ * relevant, because we will possibly perform data channel cipher negotiation
+ * after this, but older clients will log warnings if we do not supply them the
+ * value they expect.  This assumes that the traditional cipher/auth directives
+ * in the config match the config of the peer.
+ */
+static size_t
+calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
+{
+  size_t link_mtu = EXPANDED_SIZE (frame);
+#ifdef ENABLE_CRYPTO
+  if (o->pull || o->mode == MODE_SERVER)
+    {
+      struct frame fake_frame = *frame;
+      struct key_type fake_kt;
+      init_key_type (&fake_kt, o->ciphername, o->ciphername_defined,
+	  o->authname, o->authname_defined, o->keysize, true, false);
+      frame_add_to_extra_frame (&fake_frame, -(crypto_max_overhead()));
+      crypto_adjust_frame_parameters (&fake_frame, &fake_kt,
+	  o->ciphername_defined, o->use_iv, o->replay,
+	  cipher_kt_mode_ofb_cfb (fake_kt.cipher));
+      frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
+            o->ce.tun_mtu_defined, o->ce.tun_mtu);
+      msg (D_MTU_DEBUG, "%s: link-mtu %zu -> %d", __func__, link_mtu,
+	  EXPANDED_SIZE (&fake_frame));
+      link_mtu = EXPANDED_SIZE (&fake_frame);
+    }
+#endif
+  return link_mtu;
+}
+
 /*
  * Build an options string to represent data channel encryption options.
  * This string must match exactly between peers.  The keysize is checked
@@ -3018,7 +3050,6 @@ pre_pull_restore (struct options *o, struct gc_arena *gc)
  * --tls-server [matched with --tls-client on
  *               the other end of the connection]
  */
-
 char *
 options_string (const struct options *o,
 		const struct frame *frame,
@@ -3036,7 +3067,7 @@ options_string (const struct options *o,
    */
 
   buf_printf (&out, ",dev-type %s", dev_type_string (o->dev, o->dev_type));
-  buf_printf (&out, ",link-mtu %d", EXPANDED_SIZE (frame));
+  buf_printf (&out, ",link-mtu %zu", calc_options_string_link_mtu(o, frame));
   buf_printf (&out, ",tun-mtu %d", PAYLOAD_SIZE (frame));
   buf_printf (&out, ",proto %s",  proto_remote (o->ce.proto, remote));
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4291314..fafa4ad 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1613,6 +1613,7 @@ generate_key_expansion (struct key_ctx_bi *key,
   key_ctx_update_implicit_iv (&key->decrypt, key2.keys[1-(int)server].hmac,
       MAX_HMAC_KEY_LENGTH);
 
+  key->initialized = true;
   ret = true;
 
  exit:
@@ -1639,6 +1640,50 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
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
+  /* Update frame parameters: undo worst-case overhead, add actual overhead */
+  frame_add_to_extra_frame (frame, -(crypto_max_overhead()));
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
@@ -1885,6 +1930,10 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       /* support for P_DATA_V2 */
       buf_printf(&out, "IV_PROTO=2\n");
 
+      /* support for Negotiable Crypto Paramters */
+      if (session->opt->pull)
+	buf_printf(&out, "IV_NCP=2\n");
+
       /* push compression status */
 #ifdef USE_COMP
       comp_generate_peer_info_string(&session->opt->comp_options, &out);
@@ -2209,9 +2258,11 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
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
@@ -2223,7 +2274,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 	  msg (D_TLS_ERRORS, "TLS Error: client generate_key_expansion failed");
 	  goto error;
 	}
-		      
+
       CLEAR (*ks->key_src);
     }
 
@@ -2889,6 +2940,14 @@ tls_pre_decrypt (struct tls_multi *multi,
 #endif
 		  && (floated || link_socket_actual_match (from, &ks->remote_addr)))
 		{
+		  if (!ks->crypto_options.key_ctx_bi.initialized)
+		    {
+		      msg (D_TLS_DEBUG_LOW,
+			  "Key %s [%d] not initialized (yet), dropping packet.",
+			  print_link_socket_actual (from, &gc), key_id);
+		      goto error_lite;
+		    }
+
 		  /* return appropriate data channel decrypt key in opt */
 		  *opt = &ks->crypto_options;
 		  if (op == P_DATA_V2)
@@ -3426,6 +3485,7 @@ tls_pre_encrypt (struct tls_multi *multi,
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


