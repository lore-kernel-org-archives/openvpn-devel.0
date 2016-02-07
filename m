From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:16 +0100
Message-Id: <1454874438-5081-9-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 08/10] Add AEAD cipher support (GCM)
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

Add Authenticated Encryption with Additional Data (AEAD) support for
ciphers, which obviates the need for a separate HMAC step.  The MAC is
integrated into the cipher and the MAC tag is prepended to the payload.

This patch is inspired by the patch originally submitted by Kenny Root
on the openvpn-devel mailinglist, but does a number things differently:
 * Don't support XTS (makes no sense for VPN)
 * Don't support CCM (needs extra code to make it actually work)
 * Don't force the user to specify "auth none" (that would break
   tls-auth)
 * Add support for PolarSSL (and change internal API for this)
 * Update openvpn frame size ('link mtu') calculation for AEAD modes
 * Use the HMAC key as an implicit part of the IV to save 8 bytes per
   data channel network packet.
 * Also authenticate the opcode/peer-id as AD in P_DATA_V2 packets.

By using the negotiated HMAC key as an implicit part of the IV for
AEAD-mode ciphers in TLS mode, we can save (at least) 8 bytes on each
packet sent.  This is particularly interesting for connections which
transfer many small packets, such as remote desktop or voip connections.

The current AEAD-mode ciphers (for now GCM) are based on CTR-mode cipher
operation, which requires the IV to be unique (but does not require
unpredictability).

IV uniqueness is guaranteed by using a combination of at least 64-bits
of the HMAC key (unique per TLS session), and a 32-bit packet counter.
The last 32-bit word of the 128-bit cipher block is not part of the IV,
but is used as a block counter.

AEAD cipher mode is not available for static key mode, since IV
uniqueness is harder the guarantee over sessions, and I believe
supporting AEAD in static key mode too is not worth the extra
complexity.  Modern setups should simply use TLS mode.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac                  |  30 +++-
 src/openvpn/crypto.c          | 353 +++++++++++++++++++++++++++++++++++++++---
 src/openvpn/crypto.h          |  65 ++++++--
 src/openvpn/crypto_backend.h  |  69 +++++++++
 src/openvpn/crypto_openssl.c  |  85 +++++++++-
 src/openvpn/crypto_openssl.h  |   7 +
 src/openvpn/crypto_polarssl.c | 105 +++++++++++--
 src/openvpn/crypto_polarssl.h |   3 +
 src/openvpn/forward.c         |  49 +++---
 src/openvpn/ssl.c             | 102 +++++++++---
 src/openvpn/ssl.h             |  42 ++++-
 11 files changed, 810 insertions(+), 100 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7ff2435..3609207 100644
--- a/configure.ac
+++ b/configure.ac
@@ -93,6 +93,13 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
+	[aead-modes],
+	[AS_HELP_STRING([--disable-aead-modes], [disable AEAD crypto modes @<:@default=yes@:>@])],
+	,
+	[enable_aead_modes="yes"]
+)
+
+AC_ARG_ENABLE(
 	[x509-alt-username],
 	[AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username-field feature @<:@default=no@:>@])],
 	,
@@ -821,6 +828,13 @@ if test "${with_crypto_library}" = "openssl"; then
 		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
 	fi
 
+	have_crypto_aead_modes="yes"
+	AC_CHECK_FUNCS(
+		[EVP_aes_256_gcm],
+		,
+		[have_crypto_aead_modes="no"; break]
+	)
+
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 
@@ -897,9 +911,19 @@ elif test "${with_crypto_library}" = "polarssl"; then
 			AC_MSG_ERROR([PolarSSL compiled with PKCS11, while OpenVPN is not])
 		fi
 	fi
+
+	have_crypto_aead_modes="yes"
+	AC_CHECK_FUNCS(
+		[ \
+			cipher_write_tag \
+			cipher_check_tag \
+		],
+		,
+		[have_crypto_aead_modes="no"; break]
+	)
+
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
-
 	have_crypto="yes"
 	AC_DEFINE([ENABLE_CRYPTO_POLARSSL], [1], [Use PolarSSL library])
 	CRYPTO_CFLAGS="${POLARSSL_CFLAGS}"
@@ -1054,6 +1078,10 @@ test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHEC
 if test "${enable_crypto}" = "yes"; then
 	test "${have_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crypto is required but missing])
 	test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
+	if test "${enable_aead_modes}" = "yes"; then
+		test "${have_crypto_aead_modes}" = "yes" && AC_DEFINE([HAVE_AEAD_CIPHER_MODES], [1], [Use crypto library])
+		test "${have_crypto_aead_modes}" != "yes" && AC_MSG_ERROR([AEAD modes required but missing])
+	fi
 	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
 	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9c0c353..21790a2 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -83,9 +83,101 @@ memcmp_constant_time (const void *a, const void *b, size_t size) {
   return ret;
 }
 
-void
-openvpn_encrypt (struct buffer *buf, struct buffer work,
-		 struct crypto_options *opt, const struct frame* frame)
+static void
+openvpn_encrypt_aead (struct buffer *buf, struct buffer work,
+	 struct crypto_options *opt) {
+  struct gc_arena gc;
+  int outlen = 0;
+  const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
+  uint8_t iv[OPENVPN_MAX_IV_LENGTH];
+  uint8_t *mac_out = NULL;
+  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
+  const int mac_len = cipher_kt_tag_size (cipher_kt);
+
+  /* IV, packet-ID and implicit IV required for this mode. */
+  ASSERT (ctx->cipher);
+  ASSERT (cipher_kt_mode_aead (cipher_kt));
+  ASSERT (opt->flags & CO_USE_IV);
+  ASSERT (packet_id_initialized(&opt->packet_id));
+
+  gc_init (&gc);
+
+  /* Prepare IV */
+  {
+    struct buffer iv_buffer;
+    struct packet_id_net pin;
+    const int iv_len = cipher_ctx_iv_length (ctx->cipher);
+
+    ASSERT (iv_len >= 12 && iv_len <= OPENVPN_MAX_IV_LENGTH);
+
+    memset(iv, 0, sizeof(iv));
+    buf_set_write (&iv_buffer, iv, iv_len);
+
+    /* IV starts with packet id to make the IV unique for packet */
+    packet_id_alloc_outgoing (&opt->packet_id.send, &pin, false);
+    ASSERT (packet_id_write (&pin, &iv_buffer, false, false));
+
+    /* Remainder of IV consists of implicit part (unique per session) */
+    ASSERT (buf_write (&iv_buffer, ctx->implicit_iv, ctx->implicit_iv_len));
+    ASSERT (iv_buffer.len == iv_len);
+
+    /* Write explicit part of IV to work buffer */
+    ASSERT (buf_write(&work, iv, iv_len - ctx->implicit_iv_len));
+    dmsg (D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex (iv, iv_len, 0, &gc));
+  }
+
+  /* Reserve space for authentication tag */
+  mac_out = buf_write_alloc (&work, mac_len);
+  ASSERT (mac_out);
+
+  dmsg (D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex (BPTR (buf), BLEN (buf), 80, &gc));
+
+  /* cipher_ctx was already initialized with key & keylen */
+  ASSERT (cipher_ctx_reset(ctx->cipher, iv));
+
+  /* Buffer overflow check */
+  if (!buf_safe (&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    {
+      msg (D_CRYPT_ERRORS,
+	  "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d",
+	  buf->capacity, buf->offset, buf->len, work.capacity, work.offset,
+	  work.len);
+      goto err;
+    }
+
+  /* For AEAD ciphers, authenticate Additional Data, including opcode */
+  ASSERT (cipher_ctx_update_ad (ctx->cipher, BPTR (&work), BLEN (&work) - mac_len));
+  dmsg (D_PACKET_CONTENT, "ENCRYPT AD: %s",
+      format_hex (BPTR (&work), BLEN (&work) - mac_len, 0, &gc));
+
+  /* Encrypt packet ID, payload */
+  ASSERT (cipher_ctx_update (ctx->cipher, BEND (&work), &outlen, BPTR (buf), BLEN (buf)));
+  ASSERT (buf_inc_len (&work, outlen));
+
+  /* Flush the encryption buffer */
+  ASSERT (cipher_ctx_final (ctx->cipher, BEND (&work), &outlen));
+  ASSERT (buf_inc_len (&work, outlen));
+
+  /* Write authentication tag */
+  ASSERT (cipher_ctx_get_tag (ctx->cipher, mac_out, mac_len));
+
+  dmsg (D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex (BPTR (buf), BLEN (buf), 80, &gc));
+
+  *buf = work;
+
+cleanup:
+  gc_free (&gc);
+  return;
+
+err:
+  crypto_clear_error();
+  buf->len = 0;
+  goto cleanup;
+}
+
+static void
+openvpn_encrypt_v1 (struct buffer *buf, struct buffer work,
+		 struct crypto_options *opt)
 {
   struct gc_arena gc;
   gc_init (&gc);
@@ -104,9 +196,6 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
 	  int outlen;
 
-	  /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-	  ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
-
 	  /* Reserve space for HMAC */
 	  if (ctx->hmac)
 	    {
@@ -232,6 +321,22 @@ err:
   return;
 }
 
+void
+openvpn_encrypt (struct buffer *buf, struct buffer work,
+		 struct crypto_options *opt)
+{
+  if (buf->len > 0 && opt)
+    {
+      const cipher_kt_t *cipher_kt =
+	  cipher_ctx_get_cipher_kt(opt->key_ctx_bi.encrypt.cipher);
+
+      if (cipher_kt_mode_aead (cipher_kt))
+	openvpn_encrypt_aead(buf, work, opt);
+      else
+	openvpn_encrypt_v1(buf, work, opt);
+    }
+}
+
 /**
  * Check packet ID for replay, and perform replay administration.
  *
@@ -275,8 +380,146 @@ static bool crypto_check_replay(struct crypto_options *opt,
  * On success, buf is set to point to plaintext, true
  * is returned.
  */
-bool
-openvpn_decrypt (struct buffer *buf, struct buffer work,
+static bool
+openvpn_decrypt_aead (struct buffer *buf, struct buffer work,
+    struct crypto_options *opt, const struct frame* frame,
+    const uint8_t *ad_start)
+{
+  static const char error_prefix[] = "AEAD Decrypt error";
+  const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
+  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
+  uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
+  const uint8_t *tag_ptr = NULL; /* tag of AEAD ciphertext */
+  int tag_size = 0;
+  int outlen;
+  struct gc_arena gc;
+
+  gc_init (&gc);
+
+  ASSERT (opt);
+  ASSERT (buf->len > 0);
+  ASSERT (ctx->cipher);
+  ASSERT (cipher_kt_mode_aead (cipher_kt));
+
+  dmsg (D_PACKET_CONTENT, "DECRYPT FROM: %s",
+      format_hex (BPTR (buf), BLEN (buf), 80, &gc));
+
+  ASSERT (ad_start >= buf->data && ad_start <= BPTR (buf));
+
+  ASSERT (buf_init (&work, FRAME_HEADROOM_ADJ (frame, FRAME_HEADROOM_MARKER_DECRYPT)));
+
+  /* IV and Packet ID required for this mode */
+  ASSERT (packet_id_initialized (&opt->packet_id));
+  ASSERT (opt->flags & CO_USE_IV);
+
+  /* Combine IV from explicit part from packet and implicit part from context */
+  {
+    const int iv_len = cipher_ctx_iv_length (ctx->cipher);
+    const size_t packet_iv_len = iv_len - ctx->implicit_iv_len;
+
+    ASSERT (ctx->implicit_iv_len <= iv_len);
+    if (buf->len + ctx->implicit_iv_len < iv_len)
+      CRYPT_ERROR ("missing IV info");
+
+    buf_read (buf, iv, packet_iv_len);
+    memcpy (iv + packet_iv_len, ctx->implicit_iv, ctx->implicit_iv_len);
+
+    dmsg (D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex (iv, iv_len, 0, &gc));
+  }
+
+  /* keep the tag value to feed in later */
+  tag_size = cipher_kt_tag_size(cipher_kt);
+  if (buf->len < tag_size)
+    {
+      CRYPT_ERROR ("missing tag");
+    }
+  tag_ptr = BPTR(buf);
+  ASSERT (buf_advance (buf, tag_size));
+  dmsg (D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex (tag_ptr, tag_size, 0, &gc));
+
+  if (buf->len < 1)
+    {
+      CRYPT_ERROR ("missing payload");
+    }
+
+  dmsg (D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex (BPTR(buf), BLEN(buf), 0, &gc));
+
+  /* ctx->cipher was already initialized with key & keylen */
+  if (!cipher_ctx_reset (ctx->cipher, iv))
+    {
+      CRYPT_ERROR ("cipher init failed");
+    }
+
+  /* Buffer overflow check (should never fail) */
+  if (!buf_safe (&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    {
+      CRYPT_ERROR ("potential buffer overflow");
+    }
+
+  {
+    /* feed in tag and the authenticated data */
+    const int ad_size = BPTR (buf) - ad_start - tag_size;
+    /* set_tag() call required for older OpenSSL versions only */
+    ASSERT (cipher_ctx_set_tag (ctx->cipher, tag_ptr, tag_size));
+    ASSERT (cipher_ctx_update_ad (ctx->cipher, ad_start, ad_size));
+    dmsg (D_PACKET_CONTENT, "DECRYPT AD: %s",
+	format_hex (BPTR (buf) - ad_size - tag_size, ad_size, 0, &gc));
+  }
+
+  /* Decrypt and authenticate packet */
+  if (!cipher_ctx_update (ctx->cipher, BPTR (&work), &outlen, BPTR (buf),
+      BLEN (buf)))
+    {
+      CRYPT_ERROR ("cipher update failed");
+    }
+  ASSERT (buf_inc_len (&work, outlen));
+  if (!cipher_ctx_final_check_tag (ctx->cipher, BPTR (&work) + outlen,
+      &outlen, tag_ptr, tag_size))
+    {
+      CRYPT_ERROR ("cipher final failed");
+    }
+  ASSERT (buf_inc_len (&work, outlen));
+
+  dmsg (D_PACKET_CONTENT, "DECRYPT TO: %s",
+       format_hex (BPTR (&work), BLEN (&work), 80, &gc));
+
+  {
+    struct buffer b;
+    struct packet_id_net pin;
+
+    buf_set_read (&b, iv, packet_id_size (false));
+    if (!packet_id_read (&pin, &b, false))
+      {
+	CRYPT_ERROR ("error reading packet-id");
+      }
+    if (!crypto_check_replay (opt, &pin, error_prefix, &gc))
+      {
+	goto error_exit;
+      }
+  }
+
+  *buf = work;
+
+  gc_free (&gc);
+  return true;
+
+ error_exit:
+  crypto_clear_error();
+  buf->len = 0;
+  gc_free (&gc);
+  return false;
+}
+
+/*
+ * If (opt->flags & CO_USE_IV) is not NULL, we will read an IV from the packet.
+ *
+ * Set buf->len to 0 and return false on decrypt error.
+ *
+ * On success, buf is set to point to plaintext, true
+ * is returned.
+ */
+static bool
+openvpn_decrypt_v1 (struct buffer *buf, struct buffer work,
 		 struct crypto_options *opt, const struct frame* frame)
 {
   static const char error_prefix[] = "Authenticate/Decrypt packet error";
@@ -425,6 +668,33 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
   return false;
 }
 
+
+bool
+openvpn_decrypt (struct buffer *buf, struct buffer work,
+		 struct crypto_options *opt, const struct frame* frame,
+		 const uint8_t *ad_start)
+{
+  bool ret = false;
+
+  if (buf->len > 0 && opt)
+    {
+      const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
+      if (cipher_kt_mode_aead (cipher_ctx_get_cipher_kt (ctx->cipher)))
+	{
+	  ret = openvpn_decrypt_aead (buf, work, opt, frame, ad_start);
+	}
+      else
+	{
+	  ret = openvpn_decrypt_v1 (buf, work, opt, frame);
+	}
+    }
+  else
+    {
+      ret = true;
+    }
+  return ret;
+}
+
 /*
  * How many bytes will we add to frame buffer for a given
  * set of crypto options?
@@ -447,6 +717,9 @@ crypto_adjust_frame_parameters(struct frame *frame,
       if (use_iv)
 	crypto_overhead += cipher_kt_iv_size (kt->cipher);
 
+      if (cipher_kt_mode_aead (kt->cipher))
+	crypto_overhead += cipher_kt_tag_size (kt->cipher);
+
       /* extra block required by cipher_ctx_update() */
       crypto_overhead += cipher_kt_block_size (kt->cipher);
     }
@@ -466,8 +739,10 @@ void
 init_key_type (struct key_type *kt, const char *ciphername,
 	       bool ciphername_defined, const char *authname,
 	       bool authname_defined, int keysize,
-	       bool cfb_ofb_allowed, bool warn)
+	       bool tls_mode, bool warn)
 {
+  bool aead_cipher = false;
+
   CLEAR (*kt);
   if (ciphername && ciphername_defined)
     {
@@ -477,14 +752,14 @@ init_key_type (struct key_type *kt, const char *ciphername,
 	kt->cipher_length = keysize;
 
       /* check legal cipher mode */
-      {
-	if (!(cipher_kt_mode_cbc(kt->cipher)
+      aead_cipher = cipher_kt_mode_aead(kt->cipher);
+      if (!(cipher_kt_mode_cbc(kt->cipher)
+	    || (tls_mode && aead_cipher)
 #ifdef ENABLE_OFB_CFB_MODE
-	      || (cfb_ofb_allowed && cipher_kt_mode_ofb_cfb(kt->cipher))
+	    || (tls_mode && cipher_kt_mode_ofb_cfb(kt->cipher))
 #endif
-	      ))
-	  msg (M_FATAL, "Cipher '%s' mode not supported", ciphername);
-      }
+	    ))
+	msg (M_FATAL, "Cipher '%s' mode not supported", ciphername);
     }
   else
     {
@@ -493,10 +768,12 @@ init_key_type (struct key_type *kt, const char *ciphername,
     }
   if (authname && authname_defined)
     {
-      kt->digest = md_kt_get (authname);
-      kt->hmac_length = md_kt_size (kt->digest);
+      if (!aead_cipher) { /* Ignore auth for AEAD ciphers */
+	kt->digest = md_kt_get (authname);
+	kt->hmac_length = md_kt_size (kt->digest);
+      }
     }
-  else
+  else if (!aead_cipher)
     {
       if (warn)
 	msg (M_WARN, "******* WARNING *******: null MAC specified, no authentication will be used");
@@ -566,6 +843,7 @@ free_key_ctx (struct key_ctx *ctx)
       free(ctx->hmac);
       ctx->hmac = NULL;
     }
+  ctx->implicit_iv_len = 0;
 }
 
 void
@@ -575,7 +853,6 @@ free_key_ctx_bi (struct key_ctx_bi *ctx)
   free_key_ctx(&ctx->decrypt);
 }
 
-
 static bool
 key_is_zero (struct key *key, const struct key_type *kt)
 {
@@ -655,8 +932,10 @@ check_replay_iv_consistency (const struct key_type *kt, bool packet_id, bool use
 {
   ASSERT(kt);
 
-  if (cipher_kt_mode_ofb_cfb(kt->cipher) && !(packet_id && use_iv))
-    msg (M_FATAL, "--no-replay or --no-iv cannot be used with a CFB or OFB mode cipher");
+  if (!(packet_id && use_iv) && (cipher_kt_mode_ofb_cfb(kt->cipher) ||
+      cipher_kt_mode_aead(kt->cipher)))
+    msg (M_FATAL, "--no-replay or --no-iv cannot be used with a CFB, OFB or "
+	"AEAD mode cipher");
 }
 
 /*
@@ -735,6 +1014,31 @@ test_crypto (struct crypto_options *co, struct frame* frame)
   /* init work */
   ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
 
+#ifdef HAVE_AEAD_CIPHER_MODES
+  /* init implicit IV */
+  {
+    const cipher_kt_t *cipher =
+	cipher_ctx_get_cipher_kt(co->key_ctx_bi.encrypt.cipher);
+
+    if (cipher_kt_mode_aead(cipher))
+      {
+	size_t impl_iv_len = cipher_kt_iv_size(cipher) - sizeof(packet_id_type);
+	ASSERT (cipher_kt_iv_size(cipher) <= OPENVPN_MAX_IV_LENGTH);
+	ASSERT (cipher_kt_iv_size(cipher) >=
+	    (sizeof(packet_id_type) + OPENVPN_AEAD_MIN_IMPL_IV_LEN));
+
+	/* Generate dummy implicit IV */
+	ASSERT (rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
+	    OPENVPN_MAX_IV_LENGTH));
+	co->key_ctx_bi.encrypt.implicit_iv_len = impl_iv_len;
+
+	memcpy(co->key_ctx_bi.decrypt.implicit_iv,
+	    co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
+	co->key_ctx_bi.decrypt.implicit_iv_len = impl_iv_len;
+      }
+  }
+#endif
+
   msg (M_INFO, "Entering " PACKAGE_NAME " crypto self-test mode.");
   for (i = 1; i <= TUN_MTU_SIZE (frame); ++i)
     {
@@ -754,11 +1058,14 @@ test_crypto (struct crypto_options *co, struct frame* frame)
       buf = work;
       memcpy (buf_write_alloc (&buf, BLEN (&src)), BPTR (&src), BLEN (&src));
 
+      /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
+      ASSERT (buf_init (&encrypt_workspace, FRAME_HEADROOM (frame)));
+
       /* encrypt */
-      openvpn_encrypt (&buf, encrypt_workspace, co, frame);
+      openvpn_encrypt (&buf, encrypt_workspace, co);
 
       /* decrypt */
-      openvpn_decrypt (&buf, decrypt_workspace, co, frame);
+      openvpn_decrypt (&buf, decrypt_workspace, co, frame, BPTR (&buf));
 
       /* compare */
       if (buf.len != src.len)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index aac50c4..1ba873d 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -86,6 +86,30 @@
  * <tt>   [ HMAC ] [ - IV - ] [ * packet payload * ] </tt>
  *
  * @par
+ * <b>GCM data channel crypto format</b> \n
+ * GCM modes are only supported in TLS mode.  In these modes, the IV consists of
+ * the 32-bit packet counter followed by data from the HMAC key.  The HMAC key
+ * can be used as IV, since in GCM and CCM modes the HMAC key is not used for
+ * the HMAC.  The packet counter may not roll over within a single TLS sessions.
+ * This results in a unique IV for each packet, as required by GCM.
+ *
+ * @par
+ * The HMAC key data is pre-shared during the connection setup, and thus can be
+ * omitted in on-the-wire packets, saving 8 bytes per packet (for GCM and CCM).
+ *
+ * @par
+ * In GCM mode, P_DATA_V2 headers (the opcode and peer-id) are also
+ * authenticated as Additional Data.
+ *
+ * @par
+ * <i>GCM IV format:</i> \n
+ * <tt>   [ - packet ID - ] [ - HMAC key data - ] </tt>\n
+ * <i>P_DATA_V1 GCM data channel crypto format:</i> \n
+ * <tt>   [ opcode ] [ - packet ID - ] [ TAG ] [ * packet payload * ] </tt>
+ * <i>P_DATA_V2 GCM data channel crypto format:</i> \n
+ * <tt>   [ - opcode/peer-id - ] [ - packet ID - ] [ TAG ] [ * packet payload * ] </tt>
+ *
+ * @par
  * <b>No-crypto data channel format</b> \n
  * In no-crypto mode (\c \-\-cipher \c none is specified), both TLS-mode and
  * static key mode are supported. No encryption will be performed on the packet,
@@ -138,13 +162,16 @@ struct key
 
 
 /**
- * Container for one set of OpenSSL cipher and/or HMAC contexts.
+ * Container for one set of cipher and/or HMAC contexts.
  * @ingroup control_processor
  */
 struct key_ctx
 {
   cipher_ctx_t *cipher;      	/**< Generic cipher %context. */
-  hmac_ctx_t *hmac;               /**< Generic HMAC %context. */
+  hmac_ctx_t *hmac;             /**< Generic HMAC %context. */
+  uint8_t implicit_iv[OPENVPN_MAX_IV_LENGTH];
+				/**< The implicit part of the IV */
+  size_t implicit_iv_len;       /**< The length of implicit_iv */
 };
 
 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
@@ -195,10 +222,10 @@ struct key_direction_state
  */
 struct key_ctx_bi
 {
-  struct key_ctx encrypt;       /**< OpenSSL cipher and/or HMAC contexts
-                                 *   for sending direction. */
-  struct key_ctx decrypt;       /**< OpenSSL cipher and/or HMAC contexts
-                                 *   for receiving direction. */
+  struct key_ctx encrypt;       /**< Cipher and/or HMAC contexts for sending
+				 *   direction. */
+  struct key_ctx decrypt;       /**< cipher and/or HMAC contexts for
+                                 *   receiving direction. */
 };
 
 /**
@@ -238,6 +265,9 @@ struct crypto_options
                                  *   security operation functions. */
 };
 
+/** Minimal implicit IV length for AEAD mode ciphers (in bytes) */
+#define OPENVPN_AEAD_MIN_IMPL_IV_LEN 8
+
 #define RKF_MUST_SUCCEED (1<<0)
 #define RKF_INLINE       (1<<1)
 void read_key_file (struct key2 *key2, const char *file, const unsigned int flags);
@@ -278,6 +308,17 @@ void free_key_ctx (struct key_ctx *ctx);
 
 void free_key_ctx_bi (struct key_ctx_bi *ctx);
 
+/**
+ * Set an implicit IV for a key context.
+ *
+ * @param ctx	The key context to update
+ * @param iv	The implicit IV to load into ctx
+ * @param len	The length (in bytes) of iv
+ */
+bool key_ctx_set_implicit_iv (struct key_ctx *ctx, const uint8_t *iv,
+    size_t len);
+
+
 
 /**************************************************************************/
 /** @name Functions for performing security operations on data channel packets
@@ -301,17 +342,16 @@ void free_key_ctx_bi (struct key_ctx_bi *ctx);
  *
  * @param buf          - The %buffer containing the packet on which to
  *                       perform security operations.
- * @param work         - A working %buffer.
+ * @param work         - An initialized working %buffer.
  * @param opt          - The security parameter state for this VPN tunnel.
- * @param frame        - The packet geometry parameters for this VPN
- *                       tunnel.
+ *
  * @return This function returns void.\n On return, the \a buf argument
  *     will point to the resulting %buffer.  This %buffer will either
  *     contain the processed packet ready for sending, or be empty if an
  *     error occurred.
  */
 void openvpn_encrypt (struct buffer *buf, struct buffer work,
-		      struct crypto_options *opt, const struct frame* frame);
+		      struct crypto_options *opt);
 
 
 /**
@@ -337,6 +377,8 @@ void openvpn_encrypt (struct buffer *buf, struct buffer work,
  * @param opt          - The security parameter state for this VPN tunnel.
  * @param frame        - The packet geometry parameters for this VPN
  *                       tunnel.
+ * @param ad_start     - A pointer into buf, indicating from where to start
+ *                       authenticating additional data (AEAD mode only).
  *
  * @return
  * @li True, if the packet was authenticated and decrypted successfully.
@@ -346,7 +388,8 @@ void openvpn_encrypt (struct buffer *buf, struct buffer work,
  *     an error occurred.
  */
 bool openvpn_decrypt (struct buffer *buf, struct buffer work,
-		      struct crypto_options *opt, const struct frame* frame);
+		      struct crypto_options *opt, const struct frame* frame,
+		      const uint8_t *ad_start);
 
 /** @} name Functions for performing security operations on data channel packets */
 
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 1c23436..3e030d1 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -38,6 +38,8 @@
 #endif
 #include "basic.h"
 
+/* TLS uses a tag of 128 bytes, let's do the same for OpenVPN */
+#define OPENVPN_AEAD_TAG_LENGTH 16
 
 /*
  * This routine should have additional OpenSSL crypto library initialisations
@@ -221,6 +223,16 @@ int cipher_kt_iv_size (const cipher_kt_t *cipher_kt);
 int cipher_kt_block_size (const cipher_kt_t *cipher_kt);
 
 /**
+ * Returns the MAC tag size of the cipher, in bytes.
+ *
+ * @param ctx		Static cipher parameters.
+ *
+ * @return		Tag size in bytes, or 0 if the tag size could not be
+ * 			determined.
+ */
+int cipher_kt_tag_size (const cipher_kt_t *cipher_kt);
+
+/**
  * Returns the mode that the cipher runs in.
  *
  * @param cipher_kt	Static cipher parameters. May not be NULL.
@@ -248,6 +260,15 @@ bool cipher_kt_mode_cbc(const cipher_kt_t *cipher);
  */
 bool cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher);
 
+/**
+ * Check if the supplied cipher is a supported AEAD mode cipher.
+ *
+ * @param cipher	Static cipher parameters.
+ *
+ * @return		true iff the cipher is a AEAD mode cipher.
+ */
+bool cipher_kt_mode_aead(const cipher_kt_t *cipher);
+
 
 /**
  *
@@ -287,6 +308,15 @@ void cipher_ctx_cleanup (cipher_ctx_t *ctx);
 int cipher_ctx_iv_length (const cipher_ctx_t *ctx);
 
 /**
+ * Gets the computed message authenticated code (MAC) tag for this cipher.
+ *
+ * @param ctx		The cipher's context
+ * @param tag		The buffer to write computed tag in.
+ * @param tag_size	The tag buffer size, in bytes.
+ */
+int cipher_ctx_get_tag (cipher_ctx_t *ctx, uint8_t* tag, int tag_len);
+
+/**
  * Returns the block size of the cipher, in bytes.
  *
  * @param ctx	 	The cipher's context
@@ -327,6 +357,18 @@ const cipher_kt_t *cipher_ctx_get_cipher_kt (const cipher_ctx_t *ctx);
 int cipher_ctx_reset (cipher_ctx_t *ctx, uint8_t *iv_buf);
 
 /**
+ * Updates the given cipher context, providing additional data (AD) for
+ * authenticated encryption with additional data (AEAD) cipher modes.
+ *
+ * @param ctx 		Cipher's context. May not be NULL.
+ * @param src		Source buffer
+ * @param src_len	Length of the source buffer, in bytes
+ *
+ * @return 		\c 0 on failure, \c 1 on success.
+ */
+int cipher_ctx_update_ad (cipher_ctx_t *ctx, const uint8_t *src, int src_len);
+
+/**
  * Updates the given cipher context, encrypting data in the source buffer, and
  * placing any complete blocks in the destination buffer.
  *
@@ -358,6 +400,33 @@ int cipher_ctx_update (cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
  */
 int cipher_ctx_final (cipher_ctx_t *ctx, uint8_t *dst, int *dst_len);
 
+/**
+ * Like \c cipher_ctx_final, but check the computed authentication tag against
+ * the supplied (expected) tag. This function reports failure when the tags
+ * don't match.
+ *
+ * @param ctx           Cipher's context. May not be NULL.
+ * @param dst           Destination buffer.
+ * @param dst_len       Length of the destination buffer, in bytes.
+ * @param tag           The expected authentication tag.
+ * @param tag_len       The length of tag, in bytes.
+ *
+ * @return              \c 0 on failure, \c 1 on success.
+ */
+int cipher_ctx_final_check_tag (cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,
+    const uint8_t *tag, size_t tag_len);
+
+/**
+ * Load the tag to verify into the cipher context, if the crypto library
+ * requires that (i.e. do so for OpenSSL, but no-op for PolarSSL).
+ *
+ * @param ctx           Cipher's context. May not be NULL.
+ * @param tag           The expected authentication tag.
+ * @param tag_len       The length of tag, in bytes.
+ */
+int cipher_ctx_set_tag (cipher_ctx_t *ctx, const uint8_t *tag, size_t tag_len);
+
+
 /*
  *
  * Generic message digest information functions
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 7dabe5d..6fdff4f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -258,12 +258,12 @@ show_available_ciphers ()
   int nid;
 
 #ifndef ENABLE_SMALL
-  printf ("The following ciphers and cipher modes are available\n"
-	  "for use with " PACKAGE_NAME ".  Each cipher shown below may be\n"
-	  "used as a parameter to the --cipher option.  The default\n"
-	  "key size is shown as well as whether or not it can be\n"
-          "changed with the --keysize directive.  Using a CBC mode\n"
-	  "is recommended. In static key mode only CBC mode is allowed.\n\n");
+  printf ("The following ciphers and cipher modes are available for use\n"
+	  "with " PACKAGE_NAME ".  Each cipher shown below may be use as a\n"
+	  "parameter to the --cipher option.  The default key size is\n"
+	  "shown as well as whether or not it can be changed with the\n"
+          "--keysize directive.  Using a CBC or GCM mode is recommended.\n"
+	  "In static key mode only CBC mode is allowed.\n\n");
 #endif
 
   for (nid = 0; nid < 10000; ++nid)	/* is there a better way to get the size of the nid list? */
@@ -275,13 +275,16 @@ show_available_ciphers ()
 #ifdef ENABLE_OFB_CFB_MODE
 	      || cipher_kt_mode_ofb_cfb(cipher)
 #endif
+#ifdef HAVE_AEAD_CIPHER_MODES
+	      || cipher_kt_mode_aead(cipher)
+#endif
 	      )
 	    {
 	      const char *var_key_size =
 		  (EVP_CIPHER_flags (cipher) & EVP_CIPH_VARIABLE_LENGTH) ?
 		       "variable" : "fixed";
-	      const char *ssl_only = cipher_kt_mode_ofb_cfb(cipher) ?
-		  " (TLS client/server mode)" : "";
+	      const char *ssl_only = cipher_kt_mode_cbc(cipher) ?
+		  "" : " (TLS client/server mode)";
 
 	      printf ("%s %d bit default key (%s)%s\n", OBJ_nid2sn (nid),
 		      EVP_CIPHER_key_length (cipher) * 8, var_key_size,
@@ -500,6 +503,15 @@ cipher_kt_block_size (const EVP_CIPHER *cipher_kt)
 }
 
 int
+cipher_kt_tag_size (const EVP_CIPHER *cipher_kt)
+{
+  if (cipher_kt_mode_aead(cipher_kt))
+    return OPENVPN_AEAD_TAG_LENGTH;
+  else
+    return 0;
+}
+
+int
 cipher_kt_mode (const EVP_CIPHER *cipher_kt)
 {
   ASSERT(NULL != cipher_kt);
@@ -529,6 +541,16 @@ cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
     ;
 }
 
+bool
+cipher_kt_mode_aead(const cipher_kt_t *cipher)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_GCM);
+#else
+  return false;
+#endif
+}
+
 /*
  *
  * Generic cipher context functions
@@ -570,6 +592,15 @@ cipher_ctx_iv_length (const EVP_CIPHER_CTX *ctx)
   return EVP_CIPHER_CTX_iv_length (ctx);
 }
 
+int cipher_ctx_get_tag (EVP_CIPHER_CTX *ctx, uint8_t *tag_buf, int tag_size)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  return EVP_CIPHER_CTX_ctrl (ctx, EVP_CTRL_GCM_GET_TAG, tag_size, tag_buf);
+#else
+  ASSERT (0);
+#endif
+}
+
 int
 cipher_ctx_block_size(const EVP_CIPHER_CTX *ctx)
 {
@@ -596,6 +627,19 @@ cipher_ctx_reset (EVP_CIPHER_CTX *ctx, uint8_t *iv_buf)
 }
 
 int
+cipher_ctx_update_ad (EVP_CIPHER_CTX *ctx, const uint8_t *src, int src_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  int len;
+  if (!EVP_CipherUpdate (ctx, NULL, &len, src, src_len))
+    crypto_msg(M_FATAL, "%s: EVP_CipherUpdate() failed", __func__);
+  return 1;
+#else
+  ASSERT (0);
+#endif
+}
+
+int
 cipher_ctx_update (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
     uint8_t *src, int src_len)
 {
@@ -610,6 +654,31 @@ cipher_ctx_final (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len)
   return EVP_CipherFinal (ctx, dst, dst_len);
 }
 
+int
+cipher_ctx_final_check_tag (EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len,
+    const uint8_t *tag, size_t tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (!cipher_ctx_set_tag (ctx, tag, tag_len))
+    return 0;
+
+  return cipher_ctx_final (ctx, dst, dst_len);
+#else
+  ASSERT (0);
+#endif
+}
+
+int
+cipher_ctx_set_tag (EVP_CIPHER_CTX *ctx, const uint8_t *tag, size_t tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  /* Setting a tag does not change the tag, so casting away const... */
+  return EVP_CIPHER_CTX_ctrl (ctx, EVP_CTRL_GCM_SET_TAG, tag_len,
+      (uint8_t *) tag);
+#else
+  ASSERT (0);
+#endif
+}
 
 void
 cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 42c7e9a..f157041 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -61,6 +61,13 @@ typedef HMAC_CTX hmac_ctx_t;
 /** Cipher is in CFB mode */
 #define OPENVPN_MODE_CFB 	EVP_CIPH_CFB_MODE
 
+#ifdef HAVE_AEAD_CIPHER_MODES
+
+/** Cipher is in GCM mode */
+#define OPENVPN_MODE_GCM 	EVP_CIPH_GCM_MODE
+
+#endif /* HAVE_AEAD_CIPHER_MODES */
+
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT 	1
 
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 0e4c088..ade92e2 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -174,21 +174,28 @@ show_available_ciphers ()
   const int *ciphers = cipher_list();
 
 #ifndef ENABLE_SMALL
-  printf ("The following ciphers and cipher modes are available\n"
-	  "for use with " PACKAGE_NAME ".  Each cipher shown below may be\n"
-	  "used as a parameter to the --cipher option.  The default\n"
-	  "key size is shown as well as whether or not it can be\n"
-          "changed with the --keysize directive.  Using a CBC mode\n"
-	  "is recommended.\n\n");
+  printf ("The following ciphers and cipher modes are available for use\n"
+	  "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
+	  "parameter to the --cipher option.  Using a CBC or GCM mode is\n"
+	  "recommended.  In static key mode only CBC mode is allowed.\n\n");
 #endif
 
   while (*ciphers != 0)
     {
-      const cipher_info_t *info = cipher_info_from_type(*ciphers);
+      const cipher_kt_t *info = cipher_info_from_type(*ciphers);
 
-      if (info && info->mode == POLARSSL_MODE_CBC)
-	printf ("%s %d bit default key\n",
-		cipher_kt_name(info), cipher_kt_key_size(info) * 8);
+      if (info && (cipher_kt_mode_cbc(info)
+#ifdef HAVE_AEAD_CIPHER_MODES
+          || cipher_kt_mode_aead(info)
+#endif
+          ))
+	{
+	  const char *ssl_only = cipher_kt_mode_cbc(info) ?
+	      "" : " (TLS client/server mode)";
+
+	  printf ("%s %d bit default key%s\n",
+	      cipher_kt_name(info), cipher_kt_key_size(info) * 8, ssl_only);
+	}
 
       ciphers++;
     }
@@ -436,6 +443,16 @@ cipher_kt_block_size (const cipher_info_t *cipher_kt)
 }
 
 int
+cipher_kt_tag_size (const cipher_info_t *cipher_kt)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (cipher_kt && cipher_kt_mode_aead(cipher_kt))
+    return OPENVPN_AEAD_TAG_LENGTH;
+#endif
+  return 0;
+}
+
+int
 cipher_kt_mode (const cipher_info_t *cipher_kt)
 {
   ASSERT(NULL != cipher_kt);
@@ -455,6 +472,12 @@ cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
 	  cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
 }
 
+bool
+cipher_kt_mode_aead(const cipher_kt_t *cipher)
+{
+  return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_GCM;
+}
+
 
 /*
  *
@@ -491,6 +514,21 @@ int cipher_ctx_iv_length (const cipher_context_t *ctx)
   return cipher_get_iv_size(ctx);
 }
 
+int cipher_ctx_get_tag (cipher_ctx_t *ctx, uint8_t* tag, int tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (tag_len > SIZE_MAX)
+    return 0;
+
+  if (!polar_ok (cipher_write_tag (ctx, (unsigned char *) tag, tag_len)))
+    return 0;
+
+  return 1;
+#else
+  ASSERT(0);
+#endif /* HAVE_AEAD_CIPHER_MODES */
+}
+
 int cipher_ctx_block_size(const cipher_context_t *ctx)
 {
   return cipher_get_block_size(ctx);
@@ -520,6 +558,21 @@ int cipher_ctx_reset (cipher_context_t *ctx, uint8_t *iv_buf)
   return 1;
 }
 
+int cipher_ctx_update_ad (cipher_ctx_t *ctx, const uint8_t *src, int src_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (src_len > SIZE_MAX)
+    return 0;
+
+  if (!polar_ok (cipher_update_ad (ctx, src, src_len)))
+    return 0;
+
+  return 1;
+#else
+  ASSERT(0);
+#endif /* HAVE_AEAD_CIPHER_MODES */
+}
+
 int cipher_ctx_update (cipher_context_t *ctx, uint8_t *dst, int *dst_len,
     uint8_t *src, int src_len)
 {
@@ -545,6 +598,38 @@ int cipher_ctx_final (cipher_context_t *ctx, uint8_t *dst, int *dst_len)
   return 1;
 }
 
+int cipher_ctx_final_check_tag (cipher_context_t *ctx, uint8_t *dst, int *dst_len,
+    const uint8_t *tag, size_t tag_len)
+{
+#ifdef HAVE_AEAD_CIPHER_MODES
+  if (POLARSSL_DECRYPT != ctx->operation)
+    return 0;
+
+  if (tag_len > SIZE_MAX)
+    return 0;
+
+  if (!cipher_ctx_final (ctx, dst, dst_len))
+    {
+      msg (D_CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
+      return 0;
+    }
+
+  if (!polar_ok (cipher_check_tag (ctx, (const unsigned char *) tag, tag_len)))
+    return 0;
+
+  return 1;
+#else
+  ASSERT(0);
+#endif /* HAVE_AEAD_CIPHER_MODES */
+}
+
+int
+cipher_ctx_set_tag (cipher_context_t *ctx, const uint8_t *tag, size_t tag_len)
+{
+  /* PolarSSL does not require this, just check the tag after decrypting */
+  return 1;
+}
+
 void
 cipher_des_encrypt_ecb (const unsigned char key[DES_KEY_LENGTH],
     unsigned char *src,
diff --git a/src/openvpn/crypto_polarssl.h b/src/openvpn/crypto_polarssl.h
index 94306ed..7be0862 100644
--- a/src/openvpn/crypto_polarssl.h
+++ b/src/openvpn/crypto_polarssl.h
@@ -61,6 +61,9 @@ typedef md_context_t hmac_ctx_t;
 /** Cipher is in CFB mode */
 #define OPENVPN_MODE_CFB 	POLARSSL_MODE_CFB
 
+/** Cipher is in GCM mode */
+#define OPENVPN_MODE_GCM	POLARSSL_MODE_GCM
+
 /** Cipher should encrypt */
 #define OPENVPN_OP_ENCRYPT 	POLARSSL_ENCRYPT
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 75cd21d..4a91f92 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -457,43 +457,41 @@ encrypt_sign (struct context *c, bool comp_frag)
     }
 
 #ifdef ENABLE_CRYPTO
-  /*
-   * If TLS mode, get the key we will use to encrypt
-   * the packet.
-   */
+  /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
+  ASSERT (buf_init (&b->encrypt_buf, FRAME_HEADROOM (&c->c2.frame)));
+
   if (c->c2.tls_multi)
     {
+      /* Get the key we will use to encrypt the packet. */
       tls_pre_encrypt (c->c2.tls_multi, &c->c2.buf, &co);
+      /* If using P_DATA_V2, prepend the 1-byte opcode and 3-byte peer-id to the
+       * packet before openvpn_encrypt(), so we can authenticate the opcode too.
+       */
+      if (c->c2.buf.len > 0 && !c->c2.tls_multi->opt.server && c->c2.tls_multi->use_peer_id)
+	tls_prepend_opcode_v2 (c->c2.tls_multi, &b->encrypt_buf);
     }
   else
     {
       co = &c->c2.crypto_options;
     }
 
-  /*
-   * Encrypt the packet and write an optional
-   * HMAC signature.
-   */
-  openvpn_encrypt (&c->c2.buf, b->encrypt_buf, co, &c->c2.frame);
+  /* Encrypt and authenticate the packet */
+  openvpn_encrypt (&c->c2.buf, b->encrypt_buf, co);
+
+  /* Do packet administration */
+  if (c->c2.tls_multi)
+    {
+      if (c->c2.buf.len > 0 && (c->c2.tls_multi->opt.server || !c->c2.tls_multi->use_peer_id))
+        tls_prepend_opcode_v1(c->c2.tls_multi, &c->c2.buf);
+      tls_post_encrypt (c->c2.tls_multi, &c->c2.buf);
+    }
 #endif
+
   /*
    * Get the address we will be sending the packet to.
    */
   link_socket_get_outgoing_addr (&c->c2.buf, get_link_socket_info (c),
 				 &c->c2.to_link_addr);
-#ifdef ENABLE_CRYPTO
-  /*
-   * In TLS mode, prepend the appropriate one-byte opcode
-   * to the packet which identifies it as a data channel
-   * packet and gives the low-permutation version of
-   * the key-id to the recipient so it knows which
-   * decrypt key to use.
-   */
-  if (c->c2.tls_multi)
-    {
-      tls_post_encrypt (c->c2.tls_multi, &c->c2.buf);
-    }
-#endif
 
   /* if null encryption, copy result to read_tun_buf */
   buffer_turnover (orig_buf, &c->c2.to_link, &c->c2.buf, &b->read_tun_buf);
@@ -780,6 +778,7 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
   if (c->c2.buf.len > 0)
     {
       struct crypto_options *co = NULL;
+      const uint8_t *ad_start = NULL;
       if (!link_socket_verify_incoming_addr (&c->c2.buf, lsi, &c->c2.from))
 	link_socket_bad_incoming_addr (&c->c2.buf, lsi, &c->c2.from);
 
@@ -796,7 +795,8 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
 	   * will load crypto_options with the correct encryption key
 	   * and return false.
 	   */
-	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &co, floated))
+	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &co,
+	      floated, &ad_start))
 	    {
 	      interval_action (&c->c2.tmp_int);
 
@@ -819,7 +819,8 @@ process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bo
 #endif
 
       /* authenticate and decrypt the incoming packet */
-      decrypt_status = openvpn_decrypt (&c->c2.buf, c->c2.buffers->decrypt_buf, co, &c->c2.frame);
+      decrypt_status = openvpn_decrypt (&c->c2.buf, c->c2.buffers->decrypt_buf,
+	  co, &c->c2.frame, ad_start);
 
       if (!decrypt_status && link_socket_connection_oriented (c->c2.link_socket))
 	{
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7f99ee9..7156030 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -250,6 +250,20 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     {NULL, NULL}
 };
 
+/**
+ * Update the implicit IV for a key_ctx_bi based on TLS session ids and cipher
+ * used.
+ *
+ * Note that the implicit IV is based on the HMAC key, but only in AEAD modes
+ * where the HMAC key is not used for an actual HMAC.
+ *
+ * @param ctx			Encrypt/decrypt key context
+ * @param key			HMAC key, used to calculate implicit IV
+ * @param key_len		HMAC key length
+ */
+static void
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len);
+
 const tls_cipher_name_pair *
 tls_get_cipher_name_pair (const char * cipher_name, size_t len) {
   const tls_cipher_name_pair * pair = tls_cipher_name_translation_table;
@@ -1252,7 +1266,7 @@ write_control_auth (struct tls_session *session,
   if (session->tls_auth.key_ctx_bi.encrypt.hmac)
     {
       /* no encryption, only write hmac */
-      openvpn_encrypt (buf, null, &session->tls_auth, NULL);
+      openvpn_encrypt (buf, null, &session->tls_auth);
       ASSERT (swap_hmac (buf, &session->tls_auth, false));
     }
   *to_link_addr = &ks->remote_addr;
@@ -1284,7 +1298,7 @@ read_control_auth (struct buffer *buf,
 
       /* authenticate only (no decrypt) and remove the hmac record
          from the head of the buffer */
-      openvpn_decrypt (buf, null, co, NULL);
+      openvpn_decrypt (buf, null, co, NULL, BPTR (buf));
       if (!buf->len)
 	{
 	  msg (D_TLS_ERRORS,
@@ -1438,7 +1452,7 @@ tls1_P_hash(const md_kt_t *md_kt,
  * (2) The pre-master secret is generated by the client.
  */
 static void
-tls1_PRF(uint8_t *label,
+tls1_PRF(const uint8_t *label,
 	 int label_len,
 	 const uint8_t *sec,
 	 int slen,
@@ -1590,6 +1604,12 @@ generate_key_expansion (struct key_ctx_bi *key,
 		OPENVPN_OP_DECRYPT,
 		"Data Channel Decrypt");
 
+  /* Initialize implicit IVs */
+  key_ctx_update_implicit_iv (&key->encrypt, key2.keys[(int)server].hmac,
+      MAX_HMAC_KEY_LENGTH);
+  key_ctx_update_implicit_iv (&key->decrypt, key2.keys[1-(int)server].hmac,
+      MAX_HMAC_KEY_LENGTH);
+
   ret = true;
 
  exit:
@@ -1599,6 +1619,24 @@ generate_key_expansion (struct key_ctx_bi *key,
   return ret;
 }
 
+static void
+key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
+  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
+
+  /* Only use implicit IV in AEAD cipher mode, where HMAC key is not used */
+  if (cipher_kt_mode_aead (cipher_kt))
+    {
+      size_t impl_iv_len = 0;
+      ASSERT (cipher_kt_iv_size (cipher_kt) >=
+	  (sizeof (packet_id_type) + OPENVPN_AEAD_MIN_IMPL_IV_LEN));
+      impl_iv_len = cipher_kt_iv_size (cipher_kt) - sizeof (packet_id_type);
+      ASSERT (impl_iv_len <= OPENVPN_MAX_IV_LENGTH);
+      ASSERT (impl_iv_len <= key_len);
+      memcpy (ctx->implicit_iv, key, impl_iv_len);
+      ctx->implicit_iv_len = impl_iv_len;
+    }
+}
+
 static bool
 random_bytes_to_buf (struct buffer *buf,
 		     uint8_t *out,
@@ -2802,7 +2840,8 @@ tls_pre_decrypt (struct tls_multi *multi,
 		 const struct link_socket_actual *from,
 		 struct buffer *buf,
 		 struct crypto_options **opt,
-		 bool floated)
+		 bool floated,
+		 const uint8_t **ad_start)
 {
   struct gc_arena gc = gc_new ();
   bool ret = false;
@@ -2850,9 +2889,17 @@ tls_pre_decrypt (struct tls_multi *multi,
 		{
 		  /* return appropriate data channel decrypt key in opt */
 		  *opt = &ks->crypto_options;
-		  ASSERT (buf_advance (buf, 1));
 		  if (op == P_DATA_V2)
 		    {
+		      *ad_start = BPTR(buf);
+		    }
+		  ASSERT (buf_advance (buf, 1));
+		  if (op == P_DATA_V1)
+		    {
+		      *ad_start = BPTR(buf);
+		    }
+		  else if (op == P_DATA_V2)
+		    {
 		      if (buf->len < 4)
 			{
 			  msg (D_TLS_ERRORS, "Protocol error: received P_DATA_V2 from %s but length is < 4",
@@ -3412,30 +3459,45 @@ tls_pre_encrypt (struct tls_multi *multi,
   *opt = NULL;
 }
 
-/* Prepend the appropriate opcode to encrypted buffer prior to TCP/UDP send */
 void
-tls_post_encrypt (struct tls_multi *multi, struct buffer *buf)
+tls_prepend_opcode_v1 (const struct tls_multi *multi, struct buffer *buf)
 {
-  struct key_state *ks;
-  uint8_t *op;
+  struct key_state *ks = multi->save_ks;
+  uint8_t op;
+
+  msg (D_TLS_DEBUG, __func__);
+
+  ASSERT (ks);
+
+  op = (P_DATA_V1 << P_OPCODE_SHIFT) | ks->key_id;
+  ASSERT (buf_write_prepend (buf, &op, 1));
+}
+
+void
+tls_prepend_opcode_v2 (const struct tls_multi *multi, struct buffer *buf)
+{
+  struct key_state *ks = multi->save_ks;
   uint32_t peer;
 
-  ks = multi->save_ks;
+  msg (D_TLS_DEBUG, __func__);
+
+  ASSERT (ks);
+
+  peer = htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
+      | (multi->peer_id & 0xFFFFFF));
+  ASSERT (buf_write_prepend (buf, &peer, 4));
+}
+
+void
+tls_post_encrypt (struct tls_multi *multi, struct buffer *buf)
+{
+  struct key_state *ks = multi->save_ks;
   multi->save_ks = NULL;
+
   if (buf->len > 0)
     {
       ASSERT (ks);
 
-      if (!multi->opt.server && multi->use_peer_id)
-	{
-	  peer = htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0xFFFFFF));
-	  ASSERT (buf_write_prepend (buf, &peer, 4));
-	}
-      else
-	{
-	  ASSERT (op = buf_prepend (buf, 1));
-	  *op = (P_DATA_V1 << P_OPCODE_SHIFT) | ks->key_id;
-	}
       ++ks->n_packets;
       ks->n_bytes += buf->len;
     }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 20991cc..d9ff8d0 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -294,6 +294,8 @@ int tls_multi_process (struct tls_multi *multi,
  * @param buf - A buffer structure containing the incoming packet.
  * @param opt - Returns a crypto options structure with the appropriate security
  *     parameters to handle the packet if it is a data channel packet.
+ * @param ad_start - Returns a pointer to the start of the authenticated data of
+ *     of this packet
  *
  * @return
  * @li True if the packet is a control channel packet that has been
@@ -305,7 +307,8 @@ bool tls_pre_decrypt (struct tls_multi *multi,
 		      const struct link_socket_actual *from,
 		      struct buffer *buf,
 		      struct crypto_options **opt,
-		      bool floated);
+		      bool floated,
+		      const uint8_t **ad_start);
 
 
 /**************************************************************************/
@@ -366,8 +369,41 @@ void tls_pre_encrypt (struct tls_multi *multi,
 
 
 /**
- * Prepend the one-byte OpenVPN header to the packet, and perform some
- * accounting for the key state used.
+ * Prepend a one-byte OpenVPN data channel P_DATA_V1 opcode to the packet.
+ *
+ * The opcode identifies the packet as a V1 data channel packet and gives the
+ * low-permutation version of the key-id to the recipient, so it knows which
+ * decrypt key to use.
+ *
+ * @param multi - The TLS state for this packet's destination VPN tunnel.
+ * @param buf - The buffer to write the header to.
+ *
+ * @ingroup data_crypto
+ */
+void
+tls_prepend_opcode_v1 (const struct tls_multi *multi, struct buffer *buf);
+
+/**
+ * Prepend an OpenVPN data channel P_DATA_V2 header to the packet.  The
+ * P_DATA_V2 header consists of a 1-byte opcode, followed by a 3-byte peer-id.
+ *
+ * The opcode identifies the packet as a V2 data channel packet and gives the
+ * low-permutation version of the key-id to the recipient, so it knows which
+ * decrypt key to use.
+ *
+ * The peer-id is sent by clients to servers to help the server determine to
+ * select the decrypt key when the client is roaming between addresses/ports.
+ *
+ * @param multi - The TLS state for this packet's destination VPN tunnel.
+ * @param buf - The buffer to write the header to.
+ *
+ * @ingroup data_crypto
+ */
+void
+tls_prepend_opcode_v2 (const struct tls_multi *multi, struct buffer *buf);
+
+/**
+ * Perform some accounting for the key state used.
  * @ingroup data_crypto
  *
  * @param multi - The TLS state for this packet's destination VPN tunnel.
-- 
2.5.0


