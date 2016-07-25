From: Steffan Karger <steffan@...1856...>
Date: Mon, 25 Jul 2016 22:06:59 +0200
Message-Id: <1469477219-13937-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix "--cipher none --cipher" crash
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

As reported in trac #699, OpenVPN crashes when an "--cipher none" option
is followed by "--cipher" (without arguments).  Fix this by removing the
redudant ciphername_defined and authname_defined members of struct options.
That not only fixes the issue, but also cleans up the code a bit.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c  | 11 ++++-------
 src/openvpn/crypto.h  | 16 +++++++++++++---
 src/openvpn/init.c    | 19 +++++++------------
 src/openvpn/options.c | 26 ++++++++------------------
 src/openvpn/options.h |  2 --
 src/openvpn/ssl.c     |  6 ++----
 6 files changed, 34 insertions(+), 46 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index f9cf62a..d94896c 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -713,7 +713,6 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 void
 crypto_adjust_frame_parameters(struct frame *frame,
 			       const struct key_type* kt,
-			       bool cipher_defined,
 			       bool use_iv,
 			       bool packet_id,
 			       bool packet_id_long_form)
@@ -723,7 +722,7 @@ crypto_adjust_frame_parameters(struct frame *frame,
   if (packet_id)
     crypto_overhead += packet_id_size (packet_id_long_form);
 
-  if (cipher_defined)
+  if (kt->cipher)
     {
       if (use_iv)
 	crypto_overhead += cipher_kt_iv_size (kt->cipher);
@@ -756,14 +755,12 @@ crypto_max_overhead(void)
  */
 void
 init_key_type (struct key_type *kt, const char *ciphername,
-	       bool ciphername_defined, const char *authname,
-	       bool authname_defined, int keysize,
-	       bool tls_mode, bool warn)
+	       const char *authname, int keysize, bool tls_mode, bool warn)
 {
   bool aead_cipher = false;
 
   CLEAR (*kt);
-  if (ciphername && ciphername_defined)
+  if (ciphername)
     {
       kt->cipher = cipher_kt_get (translate_cipher_name_from_openvpn(ciphername));
       kt->cipher_length = cipher_kt_key_size (kt->cipher);
@@ -788,7 +785,7 @@ init_key_type (struct key_type *kt, const char *ciphername,
       if (warn)
 	msg (M_WARN, "******* WARNING *******: null cipher specified, no encryption will be used");
     }
-  if (authname && authname_defined)
+  if (authname)
     {
       if (!aead_cipher) { /* Ignore auth for AEAD ciphers */
 	kt->digest = md_kt_get (authname);
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index de433ae..3b6bb98 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -296,9 +296,20 @@ bool write_key (const struct key *key, const struct key_type *kt,
 
 int read_key (struct key *key, const struct key_type *kt, struct buffer *buf);
 
+/**
+ * Initialize a key_type structure with.
+ *
+ * @param kt          The struct key_type to initialize
+ * @param ciphername  The name of the cipher to use
+ * @param authname    The name of the HMAC digest to use
+ * @param keysize     The length of the cipher key to use, in bytes.  Only valid
+ *                    for ciphers that support variable length keys.
+ * @param tls_mode    Specifies wether we are running in TLS mode, which allows
+ *                    more ciphers than static key mode.
+ * @param warn        Print warnings when null cipher / auth is used.
+ */
 void init_key_type (struct key_type *kt, const char *ciphername,
-    bool ciphername_defined, const char *authname, bool authname_defined,
-    int keysize, bool tls_mode, bool warn);
+    const char *authname, int keysize, bool tls_mode, bool warn);
 
 /*
  * Key context functions
@@ -389,7 +400,6 @@ bool openvpn_decrypt (struct buffer *buf, struct buffer work,
 /** Calculate crypto overhead and adjust frame to account for that */
 void crypto_adjust_frame_parameters(struct frame *frame,
 				    const struct key_type* kt,
-				    bool cipher_defined,
 				    bool use_iv,
 				    bool packet_id,
 				    bool packet_id_long_form);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3f97794..5685b69 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2149,10 +2149,8 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
       struct key_direction_state kds;
 
       /* Get cipher & hash algorithms */
-      init_key_type (&c->c1.ks.key_type, options->ciphername,
-		     options->ciphername_defined, options->authname,
-		     options->authname_defined, options->keysize,
-		     options->test_crypto, true);
+      init_key_type (&c->c1.ks.key_type, options->ciphername, options->authname,
+		     options->keysize, options->test_crypto, true);
 
       /* Read cipher and hmac keys from shared secret file */
       {
@@ -2194,7 +2192,6 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
   /* Compute MTU parameters */
   crypto_adjust_frame_parameters (&c->c2.frame,
 				  &c->c1.ks.key_type,
-				  options->ciphername_defined,
 				  options->use_iv, options->replay, true);
 
   /* Sanity check on IV, sequence number, and cipher mode options */
@@ -2242,9 +2239,8 @@ do_init_crypto_tls_c1 (struct context *c)
 	}
 
       /* Get cipher & hash algorithms */
-      init_key_type (&c->c1.ks.key_type, options->ciphername,
-		     options->ciphername_defined, options->authname,
-		     options->authname_defined, options->keysize, true, true);
+      init_key_type (&c->c1.ks.key_type, options->ciphername, options->authname,
+		     options->keysize, true, true);
 
       /* Initialize PRNG with config-specified digest */
       prng_init (options->prng_hash, options->prng_nonce_secret_len);
@@ -2263,7 +2259,7 @@ do_init_crypto_tls_c1 (struct context *c)
 
 	  /* Initialize key_type for tls-auth with auth only */
 	  CLEAR (c->c1.ks.tls_auth_key_type);
-	  if (options->authname && options->authname_defined)
+	  if (options->authname)
 	    {
 	      c->c1.ks.tls_auth_key_type.digest = md_kt_get (options->authname);
 	      c->c1.ks.tls_auth_key_type.hmac_length =
@@ -2332,8 +2328,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   else
     {
       crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
-	  options->ciphername_defined, options->use_iv, options->replay,
-	  packet_id_long_form);
+	  options->use_iv, options->replay, packet_id_long_form);
     }
   tls_adjust_frame_parameters (&c->c2.frame);
 
@@ -2461,7 +2456,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
       to.tls_auth.flags |= CO_PACKET_ID_LONG_FORM;
       crypto_adjust_frame_parameters (&to.frame,
 				      &c->c1.ks.tls_auth_key_type,
-				      false, false, true, true);
+				      false, true, true);
     }
 
   /* If we are running over TCP, allow for
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 79dcb79..88be4e4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -830,7 +830,6 @@ init_options (struct options *o, const bool init_gc)
 #endif
 #ifdef ENABLE_CRYPTO
   o->ciphername = "BF-CBC";
-  o->ciphername_defined = true;
 #ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=2 requires GCM support */
   o->ncp_enabled = true;
 #else
@@ -838,7 +837,6 @@ init_options (struct options *o, const bool init_gc)
 #endif
   o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
   o->authname = "SHA1";
-  o->authname_defined = true;
   o->prng_hash = "SHA1";
   o->prng_nonce_secret_len = 16;
   o->replay = true;
@@ -1618,9 +1616,7 @@ show_settings (const struct options *o)
 #ifdef ENABLE_CRYPTO
   SHOW_STR (shared_secret_file);
   SHOW_INT (key_direction);
-  SHOW_BOOL (ciphername_defined);
   SHOW_STR (ciphername);
-  SHOW_BOOL (authname_defined);
   SHOW_STR (authname);
   SHOW_STR (prng_hash);
   SHOW_INT (prng_nonce_secret_len);
@@ -2989,12 +2985,11 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     {
       struct frame fake_frame = *frame;
       struct key_type fake_kt;
-      init_key_type (&fake_kt, o->ciphername, o->ciphername_defined,
-	  o->authname, o->authname_defined, o->keysize, true, false);
+      init_key_type (&fake_kt, o->ciphername, o->authname, o->keysize, true,
+	  false);
       frame_add_to_extra_frame (&fake_frame, -(crypto_max_overhead()));
-      crypto_adjust_frame_parameters (&fake_frame, &fake_kt,
-	  o->ciphername_defined, o->use_iv, o->replay,
-	  cipher_kt_mode_ofb_cfb (fake_kt.cipher));
+      crypto_adjust_frame_parameters (&fake_frame, &fake_kt, o->use_iv,
+	  o->replay, cipher_kt_mode_ofb_cfb (fake_kt.cipher));
       frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
             o->ce.tun_mtu_defined, o->ce.tun_mtu);
       msg (D_MTU_DEBUG, "%s: link-mtu %zu -> %d", __func__, link_mtu,
@@ -3135,9 +3130,8 @@ options_string (const struct options *o,
 		+ (TLS_SERVER == true)
 		<= 1);
 
-	init_key_type (&kt, o->ciphername, o->ciphername_defined,
-		       o->authname, o->authname_defined,
-		       o->keysize, true, false);
+	init_key_type (&kt, o->ciphername, o->authname, o->keysize, true,
+	    false);
 
 	buf_printf (&out, ",cipher %s",
 	    translate_cipher_name_to_openvpn(cipher_kt_name (kt.cipher)));
@@ -6635,34 +6629,30 @@ add_option (struct options *options,
   else if (streq (p[0], "auth") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->authname_defined = true;
       options->authname = p[1];
       if (streq (options->authname, "none"))
 	{
-	  options->authname_defined = false;
 	  options->authname = NULL;
 	}
     }
   else if (streq (p[0], "auth") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->authname_defined = true;
+      msg (M_WARN, "WARNING: Using --auth without alg is deprecated.");
     }
   else if (streq (p[0], "cipher") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_NCP);
-      options->ciphername_defined = true;
       options->ciphername = p[1];
       if (streq (options->ciphername, "none"))
 	{
-	  options->ciphername_defined = false;
 	  options->ciphername = NULL;
 	}
     }
   else if (streq (p[0], "cipher") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->ciphername_defined = true;
+      msg (M_WARN, "WARNING: Using --cipher without alg is deprecated.");
     }
   else if (streq (p[0], "ncp-ciphers") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d644b7..9b7b57c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -469,11 +469,9 @@ struct options
   const char *shared_secret_file;
   const char *shared_secret_file_inline;
   int key_direction;
-  bool ciphername_defined;
   const char *ciphername;
   bool ncp_enabled;
   const char *ncp_ciphers;
-  bool authname_defined;
   const char *authname;
   int keysize;
   const char *prng_hash;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 72001a3..a220b79 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1678,8 +1678,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     }
 
   init_key_type (&session->opt->key_type, options->ciphername,
-    options->ciphername_defined, options->authname, options->authname_defined,
-    options->keysize, true, true);
+      options->authname, options->keysize, true, true);
 
   bool packet_id_long_form = cipher_kt_mode_ofb_cfb (session->opt->key_type.cipher);
   session->opt->crypto_flags_and &= ~(CO_PACKET_ID_LONG_FORM);
@@ -1689,8 +1688,7 @@ tls_session_update_crypto_params(struct tls_session *session,
   /* Update frame parameters: undo worst-case overhead, add actual overhead */
   frame_add_to_extra_frame (frame, -(crypto_max_overhead()));
   crypto_adjust_frame_parameters (frame, &session->opt->key_type,
-      options->ciphername_defined, options->use_iv, options->replay,
-      packet_id_long_form);
+      options->use_iv, options->replay, packet_id_long_form);
   frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
       options->ce.tun_mtu_defined, options->ce.tun_mtu);
   frame_print (frame, D_MTU_INFO, "Data Channel MTU parms");
-- 
2.7.4


