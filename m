From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:12 +0100
Message-Id: <1454874438-5081-5-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 04/10] Move key_ctx_bi into crypto_options
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

The encrypt and decrypt routines use struct crypto_options as their main
information source.  A struct crypto_options would have a pointer to a
struct key_ctx_bi, which had to be updated at the correct moments to keep
them correct.  Instead of doing this administration, just put the struct
key_ctx_bi inside crypto_options.  Makes the code a little simpler too.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c     |  8 ++++----
 src/openvpn/crypto.h     |  2 +-
 src/openvpn/init.c       |  4 ++--
 src/openvpn/ssl.c        | 32 ++++++++++++++------------------
 src/openvpn/ssl.h        |  1 -
 src/openvpn/ssl_common.h |  2 --
 6 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 806a995..9679fd0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -91,9 +91,9 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
   struct gc_arena gc;
   gc_init (&gc);
 
-  if (buf->len > 0 && opt->key_ctx_bi)
+  if (buf->len > 0 && opt)
     {
-      struct key_ctx *ctx = &opt->key_ctx_bi->encrypt;
+      const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
 
       /* Do Encrypt from buf -> work */
       if (ctx->cipher)
@@ -240,9 +240,9 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
   struct gc_arena gc;
   gc_init (&gc);
 
-  if (buf->len > 0 && opt->key_ctx_bi)
+  if (buf->len > 0 && opt)
     {
-      struct key_ctx *ctx = &opt->key_ctx_bi->decrypt;
+      const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
       struct packet_id_net pin;
       bool have_pin = false;
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index b32a900..1f84284 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -207,7 +207,7 @@ struct key_ctx_bi
  */
 struct crypto_options
 {
-  struct key_ctx_bi *key_ctx_bi;
+  struct key_ctx_bi key_ctx_bi;
                                 /**< OpenSSL cipher and HMAC contexts for
                                  *   both sending and receiving
                                  *   directions. */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8fc5c5d..dcc3ccb 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2134,7 +2134,7 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
     }
 
   /* Get key schedule */
-  c->c2.crypto_options.key_ctx_bi = &c->c1.ks.static_key;
+  c->c2.crypto_options.key_ctx_bi = c->c1.ks.static_key;
 
   /* Compute MTU parameters */
   crypto_adjust_frame_parameters (&c->c2.frame,
@@ -2388,7 +2388,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
     {
-      to.tls_auth_key = c->c1.ks.tls_auth_key;
+      to.tls_auth.key_ctx_bi = c->c1.ks.tls_auth_key;
       to.tls_auth.pid_persist = &c->c1.pid_persist;
       to.tls_auth.flags |= CO_PACKET_ID_LONG_FORM;
       crypto_adjust_frame_parameters (&to.frame,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 6aa9284..e3a745d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -786,7 +786,6 @@ key_state_init (struct tls_session *session, struct key_state *ks)
 		  session->opt->replay_time,
 		  "SSL", ks->key_id);
 
-  ks->crypto_options.key_ctx_bi = &ks->key;
   ks->crypto_options.packet_id = session->opt->replay ? &ks->packet_id : NULL;
   ks->crypto_options.pid_persist = NULL;
   ks->crypto_options.flags = session->opt->crypto_flags;
@@ -819,7 +818,7 @@ key_state_free (struct key_state *ks, bool clear)
 
   key_state_ssl_free(&ks->ks_ssl);
 
-  free_key_ctx_bi (&ks->key);
+  free_key_ctx_bi (&ks->crypto_options.key_ctx_bi);
   free_buf (&ks->plaintext_read_buf);
   free_buf (&ks->plaintext_write_buf);
   free_buf (&ks->ack_write_buf);
@@ -1072,9 +1071,6 @@ tls_multi_init (struct tls_options *tls_options)
   /* get command line derived options */
   ret->opt = *tls_options;
 
-  /* set up pointer to HMAC object for TLS packet authentication */
-  ret->opt.tls_auth.key_ctx_bi = &ret->opt.tls_auth_key;
-
   /* set up list of keys to be scanned by data channel encrypt and decrypt routines */
   ASSERT (SIZE (ret->key_scan) == 3);
   ret->key_scan[0] = &ret->session[TM_ACTIVE].key[KS_PRIMARY];
@@ -1113,8 +1109,7 @@ tls_auth_standalone_init (struct tls_options *tls_options,
   ALLOC_OBJ_CLEAR_GC (tas, struct tls_auth_standalone, gc);
 
   /* set up pointer to HMAC object for TLS packet authentication */
-  tas->tls_auth_key = tls_options->tls_auth_key;
-  tas->tls_auth_options.key_ctx_bi = &tas->tls_auth_key;
+  tas->tls_auth_options.key_ctx_bi = tls_options->tls_auth.key_ctx_bi;
   tas->tls_auth_options.flags |= CO_PACKET_ID_LONG_FORM;
 
   /* get initial frame parms, still need to finalize */
@@ -1197,11 +1192,11 @@ tls_multi_free (struct tls_multi *multi, bool clear)
 static bool
 swap_hmac (struct buffer *buf, const struct crypto_options *co, bool incoming)
 {
-  struct key_ctx *ctx;
+  const struct key_ctx *ctx;
 
   ASSERT (co);
 
-  ctx = (incoming ? &co->key_ctx_bi->decrypt : &co->key_ctx_bi->encrypt);
+  ctx = (incoming ? &co->key_ctx_bi.decrypt : &co->key_ctx_bi.encrypt);
   ASSERT (ctx->hmac);
 
   {
@@ -1265,7 +1260,7 @@ write_control_auth (struct tls_session *session,
   ASSERT (session_id_write_prepend (&session->session_id, buf));
   ASSERT (header = buf_prepend (buf, 1));
   *header = ks->key_id | (opcode << P_OPCODE_SHIFT);
-  if (session->tls_auth.key_ctx_bi->encrypt.hmac)
+  if (session->tls_auth.key_ctx_bi.encrypt.hmac)
     {
       /* no encryption, only write hmac */
       openvpn_encrypt (buf, null, &session->tls_auth, NULL);
@@ -1284,7 +1279,7 @@ read_control_auth (struct buffer *buf,
 {
   struct gc_arena gc = gc_new ();
 
-  if (co->key_ctx_bi->decrypt.hmac)
+  if (co->key_ctx_bi.decrypt.hmac)
     {
       struct buffer null = clear_buf ();
 
@@ -1707,7 +1702,6 @@ key_state_soft_reset (struct tls_session *session)
   ks->must_die = now + session->opt->transition_window; /* remaining lifetime of old key */
   key_state_free (ks_lame, false);
   *ks_lame = *ks;
-  ks_lame->crypto_options.key_ctx_bi = &ks_lame->key;
   ks_lame->crypto_options.packet_id = &ks_lame->packet_id;
 
   key_state_init (session, ks);
@@ -1806,8 +1800,9 @@ key_method_1_write (struct buffer *buf, struct tls_session *session)
       return false;
     }
 
-  init_key_ctx (&ks->key.encrypt, &key, &session->opt->key_type,
-		OPENVPN_OP_ENCRYPT, "Data Channel Encrypt");
+  init_key_ctx (&ks->crypto_options.key_ctx_bi.encrypt, &key,
+		&session->opt->key_type, OPENVPN_OP_ENCRYPT,
+		"Data Channel Encrypt");
   CLEAR (key);
 
   /* send local options string */
@@ -1969,7 +1964,7 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
     {
       if (ks->authenticated)
 	{
-	  if (!generate_key_expansion (&ks->key,
+	  if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
 				       &session->opt->key_type,
 				       ks->key_src,
 				       &ks->session_id_remote,
@@ -2040,8 +2035,9 @@ key_method_1_read (struct buffer *buf, struct tls_session *session)
 
   buf_clear (buf);
 
-  init_key_ctx (&ks->key.decrypt, &key, &session->opt->key_type,
-		OPENVPN_OP_DECRYPT, "Data Channel Decrypt");
+  init_key_ctx (&ks->crypto_options.key_ctx_bi.decrypt, &key,
+		&session->opt->key_type, OPENVPN_OP_DECRYPT,
+		"Data Channel Decrypt");
   CLEAR (key);
   ks->authenticated = true;
   return true;
@@ -2189,7 +2185,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
    */
   if (!session->opt->server)
     {
-      if (!generate_key_expansion (&ks->key,
+      if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
 				   &session->opt->key_type,
 				   ks->key_src,
 				   &session->session_id,
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index e9d0f28..20991cc 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -136,7 +136,6 @@
  */
 struct tls_auth_standalone
 {
-  struct key_ctx_bi tls_auth_key;
   struct crypto_options tls_auth_options;
   struct frame frame;
 };
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 00d2ce8..b40aec2 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -163,7 +163,6 @@ struct key_state
   struct packet_id packet_id;	       /* for data channel, to prevent replay attacks */
 
   struct crypto_options crypto_options;/* data channel crypto options */
-  struct key_ctx_bi key;	       /* data channel keys for encrypt/decrypt/hmac */
 
   struct key_source2 *key_src;         /* source entropy for key expansion */
 
@@ -270,7 +269,6 @@ struct tls_options
 
   /* packet authentication for TLS handshake */
   struct crypto_options tls_auth;
-  struct key_ctx_bi tls_auth_key;
 
   /* frame parameters for TLS control channel */
   struct frame frame;
-- 
2.5.0


