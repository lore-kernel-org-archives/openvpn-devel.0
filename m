From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:11 +0100
Message-Id: <1454874438-5081-4-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 03/10] Move crypto_options into key_state
	and stop using context in SSL-mode.
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

Moving crypto_options into key_state enables us to stop using the global
context for each packet encrypt/decrypt operation. Decoupling the crypto
from the global context removes the need to copy the relevant parts of
crypto_options for each processed packet, but instead enables us to just
pass along a pointer to the related crypto_options.

This paves the way for an efficient GCM cipher mode implementation, but is
probably fruitful too for threading and/or cipher negotiation.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/forward.c    | 18 ++++++++++++++----
 src/openvpn/init.c       | 21 +++++++++++++--------
 src/openvpn/ssl.c        | 36 +++++++++++++++---------------------
 src/openvpn/ssl.h        | 15 +++++++--------
 src/openvpn/ssl_common.h |  2 ++
 5 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 36a99e6..75cd21d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -432,6 +432,7 @@ encrypt_sign (struct context *c, bool comp_frag)
 {
   struct context_buffers *b = c->c2.buffers;
   const uint8_t *orig_buf = c->c2.buf.data;
+  struct crypto_options *co = NULL;
 
 #if P2MP_SERVER
   /*
@@ -462,14 +463,18 @@ encrypt_sign (struct context *c, bool comp_frag)
    */
   if (c->c2.tls_multi)
     {
-      tls_pre_encrypt (c->c2.tls_multi, &c->c2.buf, &c->c2.crypto_options);
+      tls_pre_encrypt (c->c2.tls_multi, &c->c2.buf, &co);
+    }
+  else
+    {
+      co = &c->c2.crypto_options;
     }
 
   /*
    * Encrypt the packet and write an optional
    * HMAC signature.
    */
-  openvpn_encrypt (&c->c2.buf, b->encrypt_buf, &c->c2.crypto_options, &c->c2.frame);
+  openvpn_encrypt (&c->c2.buf, b->encrypt_buf, co, &c->c2.frame);
 #endif
   /*
    * Get the address we will be sending the packet to.
@@ -774,6 +779,7 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
    */
   if (c->c2.buf.len > 0)
     {
+      struct crypto_options *co = NULL;
       if (!link_socket_verify_incoming_addr (&c->c2.buf, lsi, &c->c2.from))
 	link_socket_bad_incoming_addr (&c->c2.buf, lsi, &c->c2.from);
 
@@ -790,7 +796,7 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
 	   * will load crypto_options with the correct encryption key
 	   * and return false.
 	   */
-	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &c->c2.crypto_options, floated))
+	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &co, floated))
 	    {
 	      interval_action (&c->c2.tmp_int);
 
@@ -799,6 +805,10 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
 		event_timeout_reset (&c->c2.ping_rec_interval);
 	    }
 	}
+      else
+	{
+	  co = &c->c2.crypto_options;
+	}
 #if P2MP_SERVER
       /*
        * Drop non-TLS packet if client-connect script/plugin has not
@@ -809,7 +819,7 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
 #endif
 
       /* authenticate and decrypt the incoming packet */
-      decrypt_status = openvpn_decrypt (&c->c2.buf, c->c2.buffers->decrypt_buf, &c->c2.crypto_options, &c->c2.frame);
+      decrypt_status = openvpn_decrypt (&c->c2.buf, c->c2.buffers->decrypt_buf, co, &c->c2.frame);
 
       if (!decrypt_status && link_socket_connection_oriented (c->c2.link_socket))
 	{
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7e6e448..8fc5c5d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2048,14 +2048,6 @@ init_crypto_pre (struct context *c, const unsigned int flags)
 	packet_id_persist_load (&c->c1.pid_persist, c->options.packet_id_file);
     }
 
-  /* Initialize crypto options */
-
-  if (c->options.use_iv)
-    c->c2.crypto_options.flags |= CO_USE_IV;
-
-  if (c->options.mute_replay_warnings)
-    c->c2.crypto_options.flags |= CO_MUTE_REPLAY_WARNINGS;
-
 #ifdef ENABLE_PREDICTION_RESISTANCE
   if (c->options.use_prediction_resistance)
     rand_ctx_enable_prediction_resistance();
@@ -2074,6 +2066,13 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
 
   init_crypto_pre (c, flags);
 
+  /* Initialize flags */
+  if (c->options.use_iv)
+    c->c2.crypto_options.flags |= CO_USE_IV;
+
+  if (c->options.mute_replay_warnings)
+    c->c2.crypto_options.flags |= CO_MUTE_REPLAY_WARNINGS;
+
   /* Initialize packet ID tracking */
   if (options->replay)
     {
@@ -2277,6 +2276,12 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   /* Set all command-line TLS-related options */
   CLEAR (to);
 
+  if (options->use_iv)
+    to.crypto_flags |= CO_USE_IV;
+
+  if (options->mute_replay_warnings)
+    to.crypto_flags |= CO_MUTE_REPLAY_WARNINGS;
+
   to.crypto_flags_and = ~(CO_PACKET_ID_LONG_FORM);
   if (packet_id_long_form)
     to.crypto_flags_or = CO_PACKET_ID_LONG_FORM;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d39f131..6aa9284 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -786,6 +786,13 @@ key_state_init (struct tls_session *session, struct key_state *ks)
 		  session->opt->replay_time,
 		  "SSL", ks->key_id);
 
+  ks->crypto_options.key_ctx_bi = &ks->key;
+  ks->crypto_options.packet_id = session->opt->replay ? &ks->packet_id : NULL;
+  ks->crypto_options.pid_persist = NULL;
+  ks->crypto_options.flags = session->opt->crypto_flags;
+  ks->crypto_options.flags &= session->opt->crypto_flags_and;
+  ks->crypto_options.flags |= session->opt->crypto_flags_or;
+
 #ifdef MANAGEMENT_DEF_AUTH
   ks->mda_key_id = session->opt->mda_context->mda_key_id_counter++;
 #endif
@@ -1700,6 +1707,8 @@ key_state_soft_reset (struct tls_session *session)
   ks->must_die = now + session->opt->transition_window; /* remaining lifetime of old key */
   key_state_free (ks_lame, false);
   *ks_lame = *ks;
+  ks_lame->crypto_options.key_ctx_bi = &ks_lame->key;
+  ks_lame->crypto_options.packet_id = &ks_lame->packet_id;
 
   key_state_init (session, ks);
   ks->session_id_remote = ks_lame->session_id_remote;
@@ -2808,7 +2817,7 @@ bool
 tls_pre_decrypt (struct tls_multi *multi,
 		 const struct link_socket_actual *from,
 		 struct buffer *buf,
-		 struct crypto_options *opt,
+		 struct crypto_options **opt,
 		 bool floated)
 {
   struct gc_arena gc = gc_new ();
@@ -2856,12 +2865,7 @@ tls_pre_decrypt (struct tls_multi *multi,
 		  && (floated || link_socket_actual_match (from, &ks->remote_addr)))
 		{
 		  /* return appropriate data channel decrypt key in opt */
-		  opt->key_ctx_bi = &ks->key;
-		  opt->packet_id = multi->opt.replay ? &ks->packet_id : NULL;
-		  opt->pid_persist = NULL;
-		  opt->flags &= multi->opt.crypto_flags_and;
-		  opt->flags |= multi->opt.crypto_flags_or;
-
+		  *opt = &ks->crypto_options;
 		  ASSERT (buf_advance (buf, 1));
 		  if (op == P_DATA_V2)
 		    {
@@ -3251,10 +3255,7 @@ tls_pre_decrypt (struct tls_multi *multi,
 
  done:
   buf->len = 0;
-  opt->key_ctx_bi = NULL;
-  opt->packet_id = NULL;
-  opt->pid_persist = NULL;
-  opt->flags &= multi->opt.crypto_flags_and;
+  *opt = NULL;
   gc_free (&gc);
   return ret;
 
@@ -3380,7 +3381,7 @@ tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
 /* Choose the key with which to encrypt a data packet */
 void
 tls_pre_encrypt (struct tls_multi *multi,
-		 struct buffer *buf, struct crypto_options *opt)
+		 struct buffer *buf, struct crypto_options **opt)
 {
   multi->save_ks = NULL;
   if (buf->len > 0)
@@ -3409,11 +3410,7 @@ tls_pre_encrypt (struct tls_multi *multi,
 
       if (ks_select)
 	{
-	  opt->key_ctx_bi = &ks_select->key;
-	  opt->packet_id = multi->opt.replay ? &ks_select->packet_id : NULL;
-	  opt->pid_persist = NULL;
-	  opt->flags &= multi->opt.crypto_flags_and;
-	  opt->flags |= multi->opt.crypto_flags_or;
+	  *opt = &ks_select->crypto_options;
 	  multi->save_ks = ks_select;
 	  dmsg (D_TLS_KEYSELECT, "TLS: tls_pre_encrypt: key_id=%d", ks_select->key_id);
 	  return;
@@ -3428,10 +3425,7 @@ tls_pre_encrypt (struct tls_multi *multi,
     }
 
   buf->len = 0;
-  opt->key_ctx_bi = NULL;
-  opt->packet_id = NULL;
-  opt->pid_persist = NULL;
-  opt->flags &= multi->opt.crypto_flags_and;
+  *opt = NULL;
 }
 
 /* Prepend the appropriate opcode to encrypted buffer prior to TCP/UDP send */
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 797c3e5..e9d0f28 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -293,9 +293,8 @@ int tls_multi_process (struct tls_multi *multi,
  *     of this packet.
  * @param from - The source address of the packet.
  * @param buf - A buffer structure containing the incoming packet.
- * @param opt - A crypto options structure that will be loaded with the
- *     appropriate security parameters to handle the packet if it is a
- *     data channel packet.
+ * @param opt - Returns a crypto options structure with the appropriate security
+ *     parameters to handle the packet if it is a data channel packet.
  *
  * @return
  * @li True if the packet is a control channel packet that has been
@@ -306,7 +305,7 @@ int tls_multi_process (struct tls_multi *multi,
 bool tls_pre_decrypt (struct tls_multi *multi,
 		      const struct link_socket_actual *from,
 		      struct buffer *buf,
-		      struct crypto_options *opt,
+		      struct crypto_options **opt,
 		      bool floated);
 
 
@@ -356,15 +355,15 @@ bool tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
  * @ingroup data_crypto
  *
  * If no appropriate security parameters can be found, or if some other
- * error occurs, then the buffer is set to empty.
+ * error occurs, then the buffer is set to empty, and the parameters to a NULL
+ * pointer.
  *
  * @param multi - The TLS state for this packet's destination VPN tunnel.
  * @param buf - The buffer containing the outgoing packet.
- * @param opt - The crypto options structure into which the appropriate
- *     security parameters should be loaded.
+ * @param opt - Returns a crypto options structure with the security parameters.
  */
 void tls_pre_encrypt (struct tls_multi *multi,
-		      struct buffer *buf, struct crypto_options *opt);
+		      struct buffer *buf, struct crypto_options **opt);
 
 
 /**
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e2b0ebf..00d2ce8 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -162,6 +162,7 @@ struct key_state
   struct link_socket_actual remote_addr; /* peer's IP addr */
   struct packet_id packet_id;	       /* for data channel, to prevent replay attacks */
 
+  struct crypto_options crypto_options;/* data channel crypto options */
   struct key_ctx_bi key;	       /* data channel keys for encrypt/decrypt/hmac */
 
   struct key_source2 *key_src;         /* source entropy for key expansion */
@@ -259,6 +260,7 @@ struct tls_options
   bool pass_config_info;
 
   /* struct crypto_option flags */
+  unsigned int crypto_flags;
   unsigned int crypto_flags_and;
   unsigned int crypto_flags_or;
 
-- 
2.5.0


