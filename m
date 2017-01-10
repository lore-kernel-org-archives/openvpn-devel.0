From: Steffan Karger <steffan@...1856...>
Date: Tue, 10 Jan 2017 22:01:38 +0100
Message-Id: <1484082098-29664-1-git-send-email-steffan@...1856...>
In-Reply-To: <1482524693-5611-1-git-send-email-steffan@...1856...>
References: <1482524693-5611-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (master)] reformatting: fix style in
	crypto*.{c, h}
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

Now that we have touched each and every file anyway, I decided to go over
the code I regularly work with and reformat it some more by hand.  This is
how for I got today, and is a large enough patch I think.

This commit is mostly just reordering and changing whitespace, with one
exception: it removes the #if 0 around some debugging code in
read_key_file(), and now always print the debugging if D_SHOW_KEYS is
enabled.

This patch is best reviewed with something like
'git diff --ignore-space-change'.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.
v3: be more uncrustify-config compatible:
    * align function paramters with (
    * indent with 4 spaces after wrap (instead of 8)
v4: rebase on master (the --no-iv removal patch caused conflicts)

 src/openvpn/crypto.c         | 442 +++++++++++++++++++++++--------------------
 src/openvpn/crypto.h         |  47 +++--
 src/openvpn/crypto_mbedtls.c |  54 +++---
 src/openvpn/crypto_mbedtls.h |   4 +-
 src/openvpn/crypto_openssl.c |  38 ++--
 src/openvpn/cryptoapi.c      | 128 +++++++++----
 6 files changed, 407 insertions(+), 306 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 87002f5..944f4c5 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -82,37 +82,37 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
     gc_init(&gc);
 
     /* Prepare IV */
-    {
-        struct buffer iv_buffer;
-        struct packet_id_net pin;
-        uint8_t iv[OPENVPN_MAX_IV_LENGTH] = {0};
-        const int iv_len = cipher_ctx_iv_length(ctx->cipher);
+    struct buffer iv_buffer;
+    struct packet_id_net pin;
+    uint8_t iv[OPENVPN_MAX_IV_LENGTH] = {0};
+    const int iv_len = cipher_ctx_iv_length(ctx->cipher);
 
-        ASSERT(iv_len >= OPENVPN_AEAD_MIN_IV_LEN && iv_len <= OPENVPN_MAX_IV_LENGTH);
+    ASSERT(iv_len >= OPENVPN_AEAD_MIN_IV_LEN
+           && iv_len <= OPENVPN_MAX_IV_LENGTH);
 
-        buf_set_write(&iv_buffer, iv, iv_len);
+    buf_set_write(&iv_buffer, iv, iv_len);
 
-        /* IV starts with packet id to make the IV unique for packet */
-        packet_id_alloc_outgoing(&opt->packet_id.send, &pin, false);
-        ASSERT(packet_id_write(&pin, &iv_buffer, false, false));
+    /* IV starts with packet id to make the IV unique for packet */
+    packet_id_alloc_outgoing(&opt->packet_id.send, &pin, false);
+    ASSERT(packet_id_write(&pin, &iv_buffer, false, false));
 
-        /* Remainder of IV consists of implicit part (unique per session) */
-        ASSERT(buf_write(&iv_buffer, ctx->implicit_iv, ctx->implicit_iv_len));
-        ASSERT(iv_buffer.len == iv_len);
+    /* Remainder of IV consists of implicit part (unique per session) */
+    ASSERT(buf_write(&iv_buffer, ctx->implicit_iv, ctx->implicit_iv_len));
+    ASSERT(iv_buffer.len == iv_len);
 
-        /* Write explicit part of IV to work buffer */
-        ASSERT(buf_write(&work, iv, iv_len - ctx->implicit_iv_len));
-        dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv, iv_len, 0, &gc));
+    /* Write explicit part of IV to work buffer */
+    ASSERT(buf_write(&work, iv, iv_len - ctx->implicit_iv_len));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv, iv_len, 0, &gc));
 
-        /* Init cipher_ctx with IV.  key & keylen are already initialized */
-        ASSERT(cipher_ctx_reset(ctx->cipher, iv));
-    }
+    /* Init cipher_ctx with IV.  key & keylen are already initialized */
+    ASSERT(cipher_ctx_reset(ctx->cipher, iv));
 
     /* Reserve space for authentication tag */
     mac_out = buf_write_alloc(&work, mac_len);
     ASSERT(mac_out);
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s",
+         format_hex(BPTR(buf), BLEN(buf), 80, &gc));
 
     /* Buffer overflow check */
     if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
@@ -125,12 +125,14 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
     }
 
     /* For AEAD ciphers, authenticate Additional Data, including opcode */
-    ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work) - mac_len));
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work),
+                                BLEN(&work) - mac_len));
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
          format_hex(BPTR(&work), BLEN(&work) - mac_len, 0, &gc));
 
     /* Encrypt packet ID, payload */
-    ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
+    ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf),
+                             BLEN(buf)));
     ASSERT(buf_inc_len(&work, outlen));
 
     /* Flush the encryption buffer */
@@ -142,7 +144,8 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
 
     *buf = work;
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s",
+         format_hex(BPTR(buf), BLEN(buf), 80, &gc));
 
     gc_free(&gc);
     return;
@@ -175,7 +178,8 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
         {
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = {0};
             const int iv_size = cipher_ctx_iv_length(ctx->cipher);
-            const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
+            const cipher_kt_t *cipher_kt =
+                cipher_ctx_get_cipher_kt(ctx->cipher);
             int outlen;
 
             /* Reserve space for HMAC */
@@ -195,8 +199,14 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
                 if (packet_id_initialized(&opt->packet_id))
                 {
                     struct packet_id_net pin;
-                    packet_id_alloc_outgoing(&opt->packet_id.send, &pin, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM));
-                    ASSERT(packet_id_write(&pin, buf, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM), true));
+                    packet_id_alloc_outgoing(&opt->packet_id.send, &pin,
+                                             BOOL_CAST(opt->flags
+                                                       & CO_PACKET_ID_LONG_FORM)
+                                             );
+                    ASSERT(packet_id_write(&pin, buf,
+                                           BOOL_CAST(opt->flags
+                                                     & CO_PACKET_ID_LONG_FORM),
+                                           true));
                 }
             }
             else if (cipher_kt_mode_ofb_cfb(cipher_kt))
@@ -218,7 +228,8 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
 
             /* set the IV pseudo-randomly */
             ASSERT(buf_write(&work, iv_buf, iv_size));
-            dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
+            dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s",
+                 format_hex(iv_buf, iv_size, 0, &gc));
 
             dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s",
                  format_hex(BPTR(buf), BLEN(buf), 80, &gc));
@@ -229,19 +240,17 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
             /* Buffer overflow check */
             if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
             {
-                msg(D_CRYPT_ERRORS, "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d cbs=%d",
-                    buf->capacity,
-                    buf->offset,
-                    buf->len,
-                    work.capacity,
-                    work.offset,
-                    work.len,
+                msg(D_CRYPT_ERRORS,
+                    "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d cbs=%d",
+                    buf->capacity, buf->offset, buf->len,
+                    work.capacity, work.offset, work.len,
                     cipher_ctx_block_size(ctx->cipher));
                 goto err;
             }
 
             /* Encrypt packet ID, payload */
-            ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
+            ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen,
+                                     BPTR(buf), BLEN(buf)));
             ASSERT(buf_inc_len(&work, outlen));
 
             /* Flush the encryption buffer */
@@ -257,8 +266,13 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer work,
             if (packet_id_initialized(&opt->packet_id))
             {
                 struct packet_id_net pin;
-                packet_id_alloc_outgoing(&opt->packet_id.send, &pin, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM));
-                ASSERT(packet_id_write(&pin, buf, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM), true));
+                packet_id_alloc_outgoing(&opt->packet_id.send, &pin,
+                                         BOOL_CAST(opt->flags
+                                                   & CO_PACKET_ID_LONG_FORM));
+                ASSERT(packet_id_write(&pin, buf,
+                                       BOOL_CAST(opt->flags
+                                                 & CO_PACKET_ID_LONG_FORM),
+                                       true));
             }
             if (ctx->hmac)
             {
@@ -333,15 +347,12 @@ crypto_check_replay(struct crypto_options *opt,
         }
         ret = true;
     }
-    else
+    else if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
     {
-        if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
-        {
-            msg(D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -- "
-                "see the man page entry for --no-replay and --replay-window for "
-                "more info or silence this warning with --mute-replay-warnings",
-                error_prefix, packet_id_net_print(pin, true, gc));
-        }
+        msg(D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -- "
+            "see the man page entry for --no-replay and --replay-window for "
+            "more info or silence this warning with --mute-replay-warnings",
+            error_prefix, packet_id_net_print(pin, true, gc));
     }
     return ret;
 }
@@ -361,12 +372,8 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
 {
 #ifdef HAVE_AEAD_CIPHER_MODES
     static const char error_prefix[] = "AEAD Decrypt error";
-    struct packet_id_net pin = { 0 };
     const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
     const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
-    uint8_t *tag_ptr = NULL;
-    int tag_size = 0;
-    int outlen;
     struct gc_arena gc;
 
     gc_init(&gc);
@@ -382,53 +389,55 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
 
     ASSERT(ad_start >= buf->data && ad_start <= BPTR(buf));
 
-    ASSERT(buf_init(&work, FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT)));
+    ASSERT(buf_init(&work,
+                    FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT)));
 
     /* IV and Packet ID required for this mode */
     ASSERT(packet_id_initialized(&opt->packet_id));
 
-    /* Combine IV from explicit part from packet and implicit part from context */
-    {
-        uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
-        const int iv_len = cipher_ctx_iv_length(ctx->cipher);
-        const size_t packet_iv_len = iv_len - ctx->implicit_iv_len;
+    /* Combine IV from explicit part from packet and implicit part from ctx */
+    uint8_t iv[OPENVPN_MAX_IV_LENGTH] = { 0 };
+    const int iv_len = cipher_ctx_iv_length(ctx->cipher);
+    const size_t packet_iv_len = iv_len - ctx->implicit_iv_len;
 
-        ASSERT(ctx->implicit_iv_len <= iv_len);
-        if (buf->len + ctx->implicit_iv_len < iv_len)
-        {
-            CRYPT_ERROR("missing IV info");
-        }
+    ASSERT(ctx->implicit_iv_len <= iv_len);
+    if (buf->len + ctx->implicit_iv_len < iv_len)
+    {
+        CRYPT_ERROR("missing IV info");
+    }
 
-        memcpy(iv, BPTR(buf), packet_iv_len);
-        memcpy(iv + packet_iv_len, ctx->implicit_iv, ctx->implicit_iv_len);
+    memcpy(iv, BPTR(buf), packet_iv_len);
+    memcpy(iv + packet_iv_len, ctx->implicit_iv, ctx->implicit_iv_len);
 
-        dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex(iv, iv_len, 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex(iv, iv_len, 0, &gc));
 
-        /* Load IV, ctx->cipher was already initialized with key & keylen */
-        if (!cipher_ctx_reset(ctx->cipher, iv))
-        {
-            CRYPT_ERROR("cipher init failed");
-        }
+    /* Load IV, ctx->cipher was already initialized with key & keylen */
+    if (!cipher_ctx_reset(ctx->cipher, iv))
+    {
+        CRYPT_ERROR("cipher init failed");
     }
 
     /* Read packet ID from packet */
+    struct packet_id_net pin = { 0 };
     if (!packet_id_read(&pin, buf, false))
     {
         CRYPT_ERROR("error reading packet-id");
     }
 
     /* keep the tag value to feed in later */
-    tag_size = cipher_kt_tag_size(cipher_kt);
+    const int tag_size = cipher_kt_tag_size(cipher_kt);
     if (buf->len < tag_size)
     {
         CRYPT_ERROR("missing tag");
     }
-    tag_ptr = BPTR(buf);
+    uint8_t *tag_ptr = BPTR(buf);
     ASSERT(buf_advance(buf, tag_size));
-    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s",
+         format_hex(tag_ptr, tag_size, 0, &gc));
 #if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L
     /* OpenSSL <= 1.0.1c bug requires set tag before processing ciphertext */
-    if (!EVP_CIPHER_CTX_ctrl(ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size, tag_ptr))
+    if (!EVP_CIPHER_CTX_ctrl(ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size,
+                             tag_ptr))
     {
         CRYPT_ERROR("setting tag failed");
     }
@@ -439,7 +448,8 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
         CRYPT_ERROR("missing payload");
     }
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s",
+         format_hex(BPTR(buf), BLEN(buf), 0, &gc));
 
     /* Buffer overflow check (should never fail) */
     if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
@@ -456,6 +466,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     }
 
     /* Decrypt and authenticate packet */
+    int outlen;
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
                            BLEN(buf)))
     {
@@ -521,8 +532,9 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
         /* Verify the HMAC */
         if (ctx->hmac)
         {
+            /* HMAC of ciphertext computed locally */
+            uint8_t local_hmac[MAX_HMAC_KEY_LENGTH];
             int hmac_len;
-            uint8_t local_hmac[MAX_HMAC_KEY_LENGTH]; /* HMAC of ciphertext computed locally */
 
             hmac_ctx_reset(ctx->hmac);
 
@@ -535,7 +547,8 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
                 CRYPT_ERROR("missing authentication info");
             }
 
-            hmac_ctx_update(ctx->hmac, BPTR(buf) + hmac_len, BLEN(buf) - hmac_len);
+            hmac_ctx_update(ctx->hmac, BPTR(buf) + hmac_len,
+                            BLEN(buf) - hmac_len);
             hmac_ctx_final(ctx->hmac, local_hmac);
 
             /* Compare locally computed HMAC with packet HMAC */
@@ -552,12 +565,15 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
         if (ctx->cipher)
         {
             const int iv_size = cipher_ctx_iv_length(ctx->cipher);
-            const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
+            const cipher_kt_t *cipher_kt =
+                cipher_ctx_get_cipher_kt(ctx->cipher);
             uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = { 0 };
             int outlen;
 
-            /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
-            ASSERT(buf_init(&work, FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT)));
+            /* initialize work buffer with sufficient prepend capacity */
+            const int work_headroom =
+                FRAME_HEADROOM_ADJ(frame, FRAME_HEADROOM_MARKER_DECRYPT);
+            ASSERT(buf_init(&work, work_headroom));
 
             /* read the IV from the packet */
             if (buf->len < iv_size)
@@ -566,7 +582,8 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             }
             memcpy(iv_buf, BPTR(buf), iv_size);
             ASSERT(buf_advance(buf, iv_size));
-            dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
+            dmsg(D_PACKET_CONTENT, "DECRYPT IV: %s",
+                 format_hex(iv_buf, iv_size, 0, &gc));
 
             if (buf->len < 1)
             {
@@ -586,7 +603,8 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             }
 
             /* Decrypt packet ID, payload */
-            if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf), BLEN(buf)))
+            if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
+                                   BLEN(buf)))
             {
                 CRYPT_ERROR("cipher update failed");
             }
@@ -602,37 +620,37 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s",
                  format_hex(BPTR(&work), BLEN(&work), 80, &gc));
 
-            /* Get packet ID from plaintext buffer or IV, depending on cipher mode */
+            /* Get packet ID from plaintext buffer or IV */
+            if (cipher_kt_mode_cbc(cipher_kt))
             {
-                if (cipher_kt_mode_cbc(cipher_kt))
+                if (packet_id_initialized(&opt->packet_id))
                 {
-                    if (packet_id_initialized(&opt->packet_id))
+                    if (!packet_id_read(&pin, &work,
+                                        BOOL_CAST(opt->flags
+                                                  & CO_PACKET_ID_LONG_FORM)))
                     {
-                        if (!packet_id_read(&pin, &work, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM)))
-                        {
-                            CRYPT_ERROR("error reading CBC packet-id");
-                        }
-                        have_pin = true;
+                        CRYPT_ERROR("error reading CBC packet-id");
                     }
+                    have_pin = true;
                 }
-                else if (cipher_kt_mode_ofb_cfb(cipher_kt))
-                {
-                    struct buffer b;
+            }
+            else if (cipher_kt_mode_ofb_cfb(cipher_kt))
+            {
+                struct buffer b;
 
-                    /* packet-ID required for this mode. */
-                    ASSERT(packet_id_initialized(&opt->packet_id));
+                /* packet-ID required for this mode. */
+                ASSERT(packet_id_initialized(&opt->packet_id));
 
-                    buf_set_read(&b, iv_buf, iv_size);
-                    if (!packet_id_read(&pin, &b, true))
-                    {
-                        CRYPT_ERROR("error reading CFB/OFB packet-id");
-                    }
-                    have_pin = true;
-                }
-                else /* We only support CBC, CFB, or OFB modes right now */
+                buf_set_read(&b, iv_buf, iv_size);
+                if (!packet_id_read(&pin, &b, true))
                 {
-                    ASSERT(0);
+                    CRYPT_ERROR("error reading CFB/OFB packet-id");
                 }
+                have_pin = true;
+            }
+            else /* We only support CBC, CFB, or OFB modes right now */
+            {
+                ASSERT(0);
             }
         }
         else
@@ -640,7 +658,9 @@ openvpn_decrypt_v1(struct buffer *buf, struct buffer work,
             work = *buf;
             if (packet_id_initialized(&opt->packet_id))
             {
-                if (!packet_id_read(&pin, &work, BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM)))
+                if (!packet_id_read(&pin, &work,
+                                    BOOL_CAST(opt->flags
+                                              & CO_PACKET_ID_LONG_FORM)))
                 {
                     CRYPT_ERROR("error reading packet-id");
                 }
@@ -730,8 +750,8 @@ size_t
 crypto_max_overhead(void)
 {
     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH
-           +OPENVPN_MAX_CIPHER_BLOCK_SIZE
-           +max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+           + OPENVPN_MAX_CIPHER_BLOCK_SIZE
+           + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
 /*
@@ -749,7 +769,8 @@ init_key_type(struct key_type *kt, const char *ciphername,
     CLEAR(*kt);
     if (strcmp(ciphername, "none") != 0)
     {
-        kt->cipher = cipher_kt_get(translate_cipher_name_from_openvpn(ciphername));
+        kt->cipher = cipher_kt_get(translate_cipher_name_from_openvpn(
+                                       ciphername));
         if (!kt->cipher)
         {
             msg(M_FATAL, "Cipher %s not supported", ciphername);
@@ -775,14 +796,16 @@ init_key_type(struct key_type *kt, const char *ciphername,
 
         if (OPENVPN_MAX_CIPHER_BLOCK_SIZE < cipher_kt_block_size(kt->cipher))
         {
-            msg(M_FATAL, "Cipher '%s' not allowed: block size too big.", ciphername);
+            msg(M_FATAL, "Cipher '%s' not allowed: block size too big.",
+                ciphername);
         }
     }
     else
     {
         if (warn)
         {
-            msg(M_WARN, "******* WARNING *******: null cipher specified, no encryption will be used");
+            msg(M_WARN,
+                "******* WARNING *******: null cipher specified, no encryption will be used");
         }
     }
     if (strcmp(authname, "none") != 0)
@@ -794,7 +817,8 @@ init_key_type(struct key_type *kt, const char *ciphername,
 
             if (OPENVPN_MAX_HMAC_SIZE < kt->hmac_length)
             {
-                msg(M_FATAL, "HMAC '%s' not allowed: digest size too big.", authname);
+                msg(M_FATAL, "HMAC '%s' not allowed: digest size too big.",
+                    authname);
             }
         }
     }
@@ -802,16 +826,16 @@ init_key_type(struct key_type *kt, const char *ciphername,
     {
         if (warn)
         {
-            msg(M_WARN, "******* WARNING *******: null MAC specified, no authentication will be used");
+            msg(M_WARN,
+                "******* WARNING *******: null MAC specified, no authentication will be used");
         }
     }
 }
 
 /* given a key and key_type, build a key_ctx */
 void
-init_key_ctx(struct key_ctx *ctx, struct key *key,
-             const struct key_type *kt, int enc,
-             const char *prefix)
+init_key_ctx(struct key_ctx *ctx, struct key *key, const struct key_type *kt,
+             int enc, const char *prefix)
 {
     struct gc_arena gc = gc_new();
     CLEAR(*ctx);
@@ -825,7 +849,7 @@ init_key_ctx(struct key_ctx *ctx, struct key *key,
         msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
             prefix,
             translate_cipher_name_to_openvpn(cipher_kt_name(kt->cipher)),
-            kt->cipher_length *8);
+            kt->cipher_length * 8);
 
         dmsg(D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
              format_hex(key->cipher, kt->cipher_length, 0, &gc));
@@ -853,9 +877,7 @@ init_key_ctx(struct key_ctx *ctx, struct key *key,
              format_hex(key->hmac, kt->hmac_length, 0, &gc));
 
         dmsg(D_CRYPTO_DEBUG, "%s: HMAC size=%d block_size=%d",
-             prefix,
-             md_kt_size(kt->digest),
-             hmac_ctx_size(ctx->hmac));
+             prefix, md_kt_size(kt->digest), hmac_ctx_size(ctx->hmac));
 
     }
     gc_free(&gc);
@@ -891,10 +913,12 @@ key_is_zero(struct key *key, const struct key_type *kt)
 {
     int i;
     for (i = 0; i < kt->cipher_length; ++i)
+    {
         if (key->cipher[i])
         {
             return false;
         }
+    }
     msg(D_CRYPT_ERRORS, "CRYPTO INFO: WARNING: zero key detected");
     return true;
 }
@@ -907,17 +931,13 @@ check_key(struct key *key, const struct key_type *kt)
 {
     if (kt->cipher)
     {
-        /*
-         * Check for zero key
-         */
+        /* Check for zero key */
         if (key_is_zero(key, kt))
         {
             return false;
         }
 
-        /*
-         * Check for weak or semi-weak DES keys.
-         */
+        /* Check for weak or semi-weak DES keys. */
         {
             const int ndc = key_des_num_cblocks(kt->cipher);
             if (ndc)
@@ -962,7 +982,8 @@ fixup_key(struct key *key, const struct key_type *kt)
         {
             if (memcmp(orig.cipher, key->cipher, kt->cipher_length))
             {
-                dmsg(D_CRYPTO_DEBUG, "CRYPTO INFO: fixup_key: before=%s after=%s",
+                dmsg(D_CRYPTO_DEBUG,
+                     "CRYPTO INFO: fixup_key: before=%s after=%s",
                      format_hex(orig.cipher, kt->cipher_length, 0, &gc),
                      format_hex(key->cipher, kt->cipher_length, 0, &gc));
             }
@@ -1000,12 +1021,14 @@ generate_key_random(struct key *key, const struct key_type *kt)
         CLEAR(*key);
         if (kt)
         {
-            if (kt->cipher && kt->cipher_length > 0 && kt->cipher_length <= cipher_len)
+            if (kt->cipher && kt->cipher_length > 0
+                && kt->cipher_length <= cipher_len)
             {
                 cipher_len = kt->cipher_length;
             }
 
-            if (kt->digest && kt->hmac_length > 0 && kt->hmac_length <= hmac_len)
+            if (kt->digest && kt->hmac_length > 0
+                && kt->hmac_length <= hmac_len)
             {
                 hmac_len = kt->hmac_length;
             }
@@ -1013,11 +1036,14 @@ generate_key_random(struct key *key, const struct key_type *kt)
         if (!rand_bytes(key->cipher, cipher_len)
             || !rand_bytes(key->hmac, hmac_len))
         {
-            msg(M_FATAL, "ERROR: Random number generator cannot obtain entropy for key generation");
+            msg(M_FATAL,
+                "ERROR: Random number generator cannot obtain entropy for key generation");
         }
 
-        dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %s", format_hex(key->cipher, cipher_len, 0, &gc));
-        dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->hmac, hmac_len, 0, &gc));
+        dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %s",
+             format_hex(key->cipher, cipher_len, 0, &gc));
+        dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s",
+             format_hex(key->hmac, hmac_len, 0, &gc));
 
         if (kt)
         {
@@ -1039,17 +1065,13 @@ key2_print(const struct key2 *k,
 {
     struct gc_arena gc = gc_new();
     ASSERT(k->n == 2);
-    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s",
-         prefix0,
+    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s", prefix0,
          format_hex(k->keys[0].cipher, kt->cipher_length, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
-         prefix0,
+    dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s", prefix0,
          format_hex(k->keys[0].hmac, kt->hmac_length, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s",
-         prefix1,
+    dmsg(D_SHOW_KEY_SOURCE, "%s (cipher): %s", prefix1,
          format_hex(k->keys[1].cipher, kt->cipher_length, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s",
-         prefix1,
+    dmsg(D_SHOW_KEY_SOURCE, "%s (hmac): %s", prefix1,
          format_hex(k->keys[1].hmac, kt->hmac_length, 0, &gc));
     gc_free(&gc);
 }
@@ -1071,25 +1093,22 @@ test_crypto(struct crypto_options *co, struct frame *frame)
 
 #ifdef HAVE_AEAD_CIPHER_MODES
     /* init implicit IV */
+    const cipher_kt_t *cipher =
+        cipher_ctx_get_cipher_kt(co->key_ctx_bi.encrypt.cipher);
+    if (cipher_kt_mode_aead(cipher))
     {
-        const cipher_kt_t *cipher =
-            cipher_ctx_get_cipher_kt(co->key_ctx_bi.encrypt.cipher);
+        size_t impl_iv_len = cipher_kt_iv_size(cipher) - sizeof(packet_id_type);
+        ASSERT(cipher_kt_iv_size(cipher) <= OPENVPN_MAX_IV_LENGTH);
+        ASSERT(cipher_kt_iv_size(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
 
-        if (cipher_kt_mode_aead(cipher))
-        {
-            size_t impl_iv_len = cipher_kt_iv_size(cipher) - sizeof(packet_id_type);
-            ASSERT(cipher_kt_iv_size(cipher) <= OPENVPN_MAX_IV_LENGTH);
-            ASSERT(cipher_kt_iv_size(cipher) >= OPENVPN_AEAD_MIN_IV_LEN);
-
-            /* Generate dummy implicit IV */
-            ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
-                              OPENVPN_MAX_IV_LENGTH));
-            co->key_ctx_bi.encrypt.implicit_iv_len = impl_iv_len;
-
-            memcpy(co->key_ctx_bi.decrypt.implicit_iv,
-                   co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
-            co->key_ctx_bi.decrypt.implicit_iv_len = impl_iv_len;
-        }
+        /* Generate dummy implicit IV */
+        ASSERT(rand_bytes(co->key_ctx_bi.encrypt.implicit_iv,
+                          OPENVPN_MAX_IV_LENGTH));
+        co->key_ctx_bi.encrypt.implicit_iv_len = impl_iv_len;
+
+        memcpy(co->key_ctx_bi.decrypt.implicit_iv,
+               co->key_ctx_bi.encrypt.implicit_iv, OPENVPN_MAX_IV_LENGTH);
+        co->key_ctx_bi.decrypt.implicit_iv_len = impl_iv_len;
     }
 #endif /* ifdef HAVE_AEAD_CIPHER_MODES */
 
@@ -1114,7 +1133,7 @@ test_crypto(struct crypto_options *co, struct frame *frame)
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLEN(&src));
 
-        /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
+        /* initialize work buffer with sufficient prepend capacity */
         ASSERT(buf_init(&encrypt_workspace, FRAME_HEADROOM(frame)));
 
         /* encrypt */
@@ -1126,7 +1145,8 @@ test_crypto(struct crypto_options *co, struct frame *frame)
         /* compare */
         if (buf.len != src.len)
         {
-            msg(M_FATAL, "SELF TEST FAILED, src.len=%d buf.len=%d", src.len, buf.len);
+            msg(M_FATAL, "SELF TEST FAILED, src.len=%d buf.len=%d", src.len,
+                buf.len);
         }
         for (j = 0; j < i; ++j)
         {
@@ -1134,7 +1154,8 @@ test_crypto(struct crypto_options *co, struct frame *frame)
             const uint8_t out = *(BPTR(&buf) + j);
             if (in != out)
             {
-                msg(M_FATAL, "SELF TEST FAILED, pos=%d in=%d out=%d", j, in, out);
+                msg(M_FATAL, "SELF TEST FAILED, pos=%d in=%d out=%d", j, in,
+                    out);
             }
         }
     }
@@ -1143,9 +1164,10 @@ test_crypto(struct crypto_options *co, struct frame *frame)
 }
 
 void
-crypto_read_openvpn_key(const struct key_type *key_type,
-                        struct key_ctx_bi *ctx, const char *key_file, const char *key_inline,
-                        const int key_direction, const char *key_name, const char *opt_name)
+crypto_read_openvpn_key(const struct key_type *key_type, struct key_ctx_bi *ctx,
+                        const char *key_file, const char *key_inline,
+                        const int key_direction, const char *key_name,
+                        const char *opt_name)
 {
     struct key2 key2;
     struct key_direction_state kds;
@@ -1153,7 +1175,7 @@ crypto_read_openvpn_key(const struct key_type *key_type,
 
     if (key_inline)
     {
-        read_key_file(&key2, key_inline, RKF_MUST_SUCCEED|RKF_INLINE);
+        read_key_file(&key2, key_inline, RKF_MUST_SUCCEED | RKF_INLINE);
     }
     else
     {
@@ -1237,14 +1259,16 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
      * Key can be provided as a filename in 'file' or if RKF_INLINE
      * is set, the actual key data itself in ascii form.
      */
-    if (flags & RKF_INLINE) /* 'file' is a string containing ascii representation of key */
+    if (flags & RKF_INLINE)
     {
+        /* 'file' is a string containing ascii representation of key */
         size = strlen(file) + 1;
         buf_set_read(&in, (const uint8_t *)file, size);
         error_filename = INLINE_FILE_TAG;
     }
-    else /* 'file' is a filename which refers to a file containing the ascii key */
+    else
     {
+        /* 'file' is the filename of a file containing the ascii key */
         in = alloc_buf_gc(2048, &gc);
         fd = platform_open(file, O_RDONLY, 0);
         if (fd == -1)
@@ -1258,7 +1282,8 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
         }
         if (size == in.capacity)
         {
-            msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes", file, (int)in.capacity);
+            msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes",
+                file, (int)in.capacity);
         }
         close(fd);
     }
@@ -1290,7 +1315,8 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
                 }
 
                 /* first char of footer */
-                if ((state == PARSE_DATA || state == PARSE_DATA_COMPLETE) && c == '-')
+                if ((state == PARSE_DATA || state == PARSE_DATA_COMPLETE)
+                    && c == '-')
                 {
                     state = PARSE_FOOT;
                 }
@@ -1345,7 +1371,7 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
                 else
                 {
                     msg(M_FATAL,
-                        (isprint(c) ? printable_char_fmt : unprintable_char_fmt),
+                        isprint(c) ? printable_char_fmt : unprintable_char_fmt,
                         c, line_num, error_filename, count, onekeylen, keylen);
                 }
             }
@@ -1366,13 +1392,15 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     {
         if (!key2->n)
         {
-            msg(M_FATAL, "Insufficient key material or header text not found in file '%s' (%d/%d/%d bytes found/min/max)",
+            msg(M_FATAL,
+                "Insufficient key material or header text not found in file '%s' (%d/%d/%d bytes found/min/max)",
                 error_filename, count, onekeylen, keylen);
         }
 
         if (state != PARSE_FINISHED)
         {
-            msg(M_FATAL, "Footer text not found in file '%s' (%d/%d/%d bytes found/min/max)",
+            msg(M_FATAL,
+                "Footer text not found in file '%s' (%d/%d/%d bytes found/min/max)",
                 error_filename, count, onekeylen, keylen);
         }
     }
@@ -1383,24 +1411,13 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
         buf_clear(&in);
     }
 
-#if 0
-    /* DEBUGGING */
+    dmsg(D_SHOW_KEYS, "%s: KEY READ, n=%d\n", __func__, key2->n);
+    for (int i = 0; i < (int) SIZE(key2->keys); ++i)
     {
-        int i;
-        printf("KEY READ, n=%d\n", key2->n);
-        for (i = 0; i < (int) SIZE(key2->keys); ++i)
-        {
-            /* format key as ascii */
-            const char *fmt = format_hex_ex((const uint8_t *)&key2->keys[i],
-                                            sizeof(key2->keys[i]),
-                                            0,
-                                            16,
-                                            "\n",
-                                            &gc);
-            printf("[%d]\n%s\n\n", i, fmt);
-        }
+        const char *fmt = format_hex_ex((const uint8_t *)&key2->keys[i],
+                                        sizeof(key2->keys[i]), 0, 16, "\n", &gc);
+        dmsg(D_SHOW_KEYS, "[%d]\n%s\n\n", i, fmt);
     }
-#endif
 
     /* pop our garbage collection level */
     gc_free(&gc);
@@ -1426,7 +1443,8 @@ write_key_file(const int nkeys, const char *filename)
     const int bytes_per_line = 16;
 
     /* open key file */
-    fd = platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR);
+    fd = platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
+                       S_IRUSR | S_IWUSR);
 
     if (fd == -1)
     {
@@ -1444,12 +1462,8 @@ write_key_file(const int nkeys, const char *filename)
         generate_key_random(&key, NULL);
 
         /* format key as ascii */
-        fmt = format_hex_ex((const uint8_t *)&key,
-                            sizeof(key),
-                            0,
-                            bytes_per_line,
-                            "\n",
-                            &gc);
+        fmt = format_hex_ex((const uint8_t *)&key, sizeof(key), 0,
+                            bytes_per_line, "\n", &gc);
 
         /* increment random bits counter */
         nbits += sizeof(key) * 8;
@@ -1486,14 +1500,19 @@ write_key_file(const int nkeys, const char *filename)
 }
 
 void
-must_have_n_keys(const char *filename, const char *option, const struct key2 *key2, int n)
+must_have_n_keys(const char *filename, const char *option,
+                 const struct key2 *key2, int n)
 {
     if (key2->n < n)
     {
 #ifdef ENABLE_SMALL
-        msg(M_FATAL, "Key file '%s' used in --%s contains insufficient key material [keys found=%d required=%d]", filename, option, key2->n, n);
+        msg(M_FATAL,
+            "Key file '%s' used in --%s contains insufficient key material [keys found=%d required=%d]",
+            filename, option, key2->n, n);
 #else
-        msg(M_FATAL, "Key file '%s' used in --%s contains insufficient key material [keys found=%d required=%d] -- try generating a new key file with '" PACKAGE " --genkey --secret [file]', or use the existing key file in bidirectional mode by specifying --%s without a key direction parameter", filename, option, key2->n, n, option);
+        msg(M_FATAL,
+            "Key file '%s' used in --%s contains insufficient key material [keys found=%d required=%d] -- try generating a new key file with '" PACKAGE " --genkey --secret [file]', or use the existing key file in bidirectional mode by specifying --%s without a key direction parameter",
+            filename, option, key2->n, n, option);
 #endif
     }
 }
@@ -1573,7 +1592,8 @@ key_direction_state_init(struct key_direction_state *kds, int key_direction)
 }
 
 void
-verify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shared_secret_file)
+verify_fix_key2(struct key2 *key2, const struct key_type *kt,
+                const char *shared_secret_file)
 {
     int i;
 
@@ -1585,8 +1605,9 @@ verify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shared
         /* This should be a very improbable failure */
         if (!check_key(&key2->keys[i], kt))
         {
-            msg(M_FATAL, "Key #%d in '%s' is bad.  Try making a new key with --genkey.",
-                i+1, shared_secret_file);
+            msg(M_FATAL,
+                "Key #%d in '%s' is bad.  Try making a new key with --genkey.",
+                i + 1, shared_secret_file);
         }
     }
 }
@@ -1687,14 +1708,17 @@ prng_reset_nonce()
 #if 1 /* Must be 1 for real usage */
     if (!rand_bytes(nonce_data, size))
     {
-        msg(M_FATAL, "ERROR: Random number generator cannot obtain entropy for PRNG");
+        msg(M_FATAL,
+            "ERROR: Random number generator cannot obtain entropy for PRNG");
     }
-#else
+#else  /* if 1 */
     /* Only for testing -- will cause a predictable PRNG sequence */
     {
         int i;
         for (i = 0; i < size; ++i)
+        {
             nonce_data[i] = (uint8_t) i;
+        }
     }
 #endif
 }
@@ -1706,15 +1730,16 @@ prng_init(const char *md_name, const int nonce_secret_len_parm)
     nonce_md = md_name ? md_kt_get(md_name) : NULL;
     if (nonce_md)
     {
-        ASSERT(nonce_secret_len_parm >= NONCE_SECRET_LEN_MIN && nonce_secret_len_parm <= NONCE_SECRET_LEN_MAX);
+        ASSERT(nonce_secret_len_parm >= NONCE_SECRET_LEN_MIN
+               && nonce_secret_len_parm <= NONCE_SECRET_LEN_MAX);
         nonce_secret_len = nonce_secret_len_parm;
-        {
-            const int size = md_kt_size(nonce_md) + nonce_secret_len;
-            dmsg(D_CRYPTO_DEBUG, "PRNG init md=%s size=%d", md_kt_name(nonce_md), size);
-            nonce_data = (uint8_t *) malloc(size);
-            check_malloc_return(nonce_data);
-            prng_reset_nonce();
-        }
+
+        const int size = md_kt_size(nonce_md) + nonce_secret_len;
+        dmsg(D_CRYPTO_DEBUG, "PRNG init md=%s size=%d",
+             md_kt_name(nonce_md), size);
+        nonce_data = (uint8_t *) malloc(size);
+        check_malloc_return(nonce_data);
+        prng_reset_nonce();
     }
 }
 
@@ -1738,7 +1763,8 @@ prng_bytes(uint8_t *output, int len)
         while (len > 0)
         {
             const int blen = min_int(len, md_size);
-            md_full(nonce_md, nonce_data, md_size + nonce_secret_len, nonce_data);
+            md_full(nonce_md, nonce_data, md_size + nonce_secret_len,
+                    nonce_data);
             memcpy(output, nonce_data, blen);
             output += blen;
             len -= blen;
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index a7a0941..647358d 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -37,8 +37,8 @@
  *  - \b Peer-id, if using the v2 data channel packet format (see @ref
  *    network_protocol "Network protocol").
  *  - \b HMAC, covering the ciphertext IV + ciphertext. The HMAC size depends
- *    on the \c \-\-auth option. If \c \-\-auth \c none is specified, there is no
- *    HMAC at all.
+ *    on the \c \-\-auth option. If \c \-\-auth \c none is specified, there is
+ *    no HMAC at all.
  *  - \b Ciphertext \b IV. The IV size depends on the \c \-\-cipher option.
  *  - \b Packet \b ID, a 32-bit incrementing packet counter that provides replay
  *    protection (if not disabled by \c \-\-no-replay).
@@ -173,9 +173,12 @@ struct key_ctx
     size_t implicit_iv_len;     /**< The length of implicit_iv */
 };
 
-#define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
-#define KEY_DIRECTION_NORMAL        1 /* encrypt with keys[0], decrypt with keys[1] */
-#define KEY_DIRECTION_INVERSE       2 /* encrypt with keys[1], decrypt with keys[0] */
+/* same keys for both directions */
+#define KEY_DIRECTION_BIDIRECTIONAL 0
+/* encrypt with keys[0], decrypt with keys[1] */
+#define KEY_DIRECTION_NORMAL        1
+/* encrypt with keys[1], decrypt with keys[0] */
+#define KEY_DIRECTION_INVERSE       2
 
 /**
  * Container for bidirectional cipher and HMAC %key material.
@@ -262,7 +265,8 @@ struct crypto_options
 };
 
 #define CRYPT_ERROR(format) \
-    do { msg(D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit; } while (false)
+    do { msg(D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit; } \
+    while (false)
 
 /**
  * Minimal IV length for AEAD mode ciphers (in bytes):
@@ -272,7 +276,8 @@ struct crypto_options
 
 #define RKF_MUST_SUCCEED (1<<0)
 #define RKF_INLINE       (1<<1)
-void read_key_file(struct key2 *key2, const char *file, const unsigned int flags);
+void read_key_file(struct key2 *key2, const char *file,
+                   const unsigned int flags);
 
 int write_key_file(const int nkeys, const char *filename);
 
@@ -393,7 +398,9 @@ bool openvpn_decrypt(struct buffer *buf, struct buffer work,
                      struct crypto_options *opt, const struct frame *frame,
                      const uint8_t *ad_start);
 
-/** @} name Functions for performing security operations on data channel packets */
+/**
+ * @} name Functions for performing security operations on data channel packets
+ */
 
 /**
  * Check packet ID for replay, and perform replay administration.
@@ -406,7 +413,8 @@ bool openvpn_decrypt(struct buffer *buf, struct buffer work,
  * @return true if packet ID is validated to be not a replay, false otherwise.
  */
 bool crypto_check_replay(struct crypto_options *opt,
-                         const struct packet_id_net *pin, const char *error_prefix,
+                         const struct packet_id_net *pin,
+                         const char *error_prefix,
                          struct gc_arena *gc);
 
 
@@ -461,11 +469,14 @@ void test_crypto(struct crypto_options *co, struct frame *f);
 
 /* key direction functions */
 
-void key_direction_state_init(struct key_direction_state *kds, int key_direction);
+void key_direction_state_init(struct key_direction_state *kds,
+                              int key_direction);
 
-void verify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shared_secret_file);
+void verify_fix_key2(struct key2 *key2, const struct key_type *kt,
+                     const char *shared_secret_file);
 
-void must_have_n_keys(const char *filename, const char *option, const struct key2 *key2, int n);
+void must_have_n_keys(const char *filename, const char *option,
+                      const struct key2 *key2, int n);
 
 int ascii2keydirection(int msglevel, const char *str);
 
@@ -478,8 +489,10 @@ void key2_print(const struct key2 *k,
                 const char *prefix1);
 
 void crypto_read_openvpn_key(const struct key_type *key_type,
-                             struct key_ctx_bi *ctx, const char *key_file, const char *key_inline,
-                             const int key_direction, const char *key_name, const char *opt_name);
+                             struct key_ctx_bi *ctx, const char *key_file,
+                             const char *key_inline,
+                             const int key_direction, const char *key_name,
+                             const char *opt_name);
 
 /*
  * Inline functions
@@ -496,7 +509,8 @@ memcmp_constant_time(const void *a, const void *b, size_t size) {
     int ret = 0;
     size_t i;
 
-    for (i = 0; i < size; i++) {
+    for (i = 0; i < size; i++)
+    {
         ret |= *a1++ ^ *b1++;
     }
 
@@ -506,7 +520,8 @@ memcmp_constant_time(const void *a, const void *b, size_t size) {
 static inline bool
 key_ctx_bi_defined(const struct key_ctx_bi *key)
 {
-    return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cipher || key->decrypt.hmac;
+    return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cipher
+           || key->decrypt.hmac;
 }
 
 
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 942684c..405d03a 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -63,8 +63,8 @@
 void
 crypto_init_lib_engine(const char *engine_name)
 {
-    msg(M_WARN, "Note: mbed TLS hardware crypto engine functionality is not "
-        "available");
+    msg(M_WARN,
+        "Note: mbed TLS hardware crypto engine functionality is not available");
 }
 
 /*
@@ -137,7 +137,8 @@ const cipher_name_pair cipher_name_translation_table[] = {
     { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
 };
 const size_t cipher_name_translation_table_count =
-    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);
+    sizeof(cipher_name_translation_table)
+    / sizeof(*cipher_name_translation_table);
 
 static void
 print_cipher(const cipher_kt_t *info)
@@ -148,10 +149,10 @@ print_cipher(const cipher_kt_t *info)
 #endif
                  ))
     {
-        const char *ssl_only = cipher_kt_mode_cbc(info) ?
-                               "" : ", TLS client/server mode only";
-        const char *var_key_size = info->flags & MBEDTLS_CIPHER_VARIABLE_KEY_LEN ?
-                                   " by default" : "";
+        const char *ssl_only =
+            cipher_kt_mode_cbc(info) ? "" : ", TLS client/server mode only";
+        const char *var_key_size =
+            info->flags & MBEDTLS_CIPHER_VARIABLE_KEY_LEN ? " by default" : "";
 
         printf("%s  (%d bit key%s, %d bit block%s)\n",
                cipher_kt_name(info), cipher_kt_key_size(info) * 8, var_key_size,
@@ -226,8 +227,7 @@ show_available_digests()
 void
 show_available_engines()
 {
-    printf("Sorry, mbed TLS hardware crypto engine functionality is not "
-           "available\n");
+    printf("mbed TLS hardware crypto engine functionality is not available\n");
 }
 
 /*
@@ -260,14 +260,16 @@ rand_ctx_get()
          * 800-90 section 8.7.1). We have very little information at this stage.
          * Include Program Name, memory address of the context and PID.
          */
-        buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx, time_string(0, 0, 0, &gc));
+        buf_printf(&pers_string, "OpenVPN %0u %p %s",
+                   platform_getpid(), &cd_ctx, time_string(0, 0, 0, &gc));
 
         /* Initialise mbed TLS RNG, and built-in entropy sources */
         mbedtls_entropy_init(&ec);
 
         mbedtls_ctr_drbg_init(&cd_ctx);
         if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, &ec,
-                                           BPTR(&pers_string), BLEN(&pers_string))))
+                                           BPTR(&pers_string),
+                                           BLEN(&pers_string))))
         {
             msg(M_FATAL, "Failed to initialize random generator");
         }
@@ -350,17 +352,20 @@ key_des_check(uint8_t *key, int key_len, int ndc)
         unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
         if (!key)
         {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
+            msg(D_CRYPT_ERRORS,
+                "CRYPTO INFO: check_key_DES: insufficient key material");
             goto err;
         }
         if (0 != mbedtls_des_key_check_weak(key))
         {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
+            msg(D_CRYPT_ERRORS,
+                "CRYPTO INFO: check_key_DES: weak key detected");
             goto err;
         }
         if (0 != mbedtls_des_key_check_key_parity(key))
         {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
+            msg(D_CRYPT_ERRORS,
+                "CRYPTO INFO: check_key_DES: bad parity detected");
             goto err;
         }
     }
@@ -382,7 +387,8 @@ key_des_fixup(uint8_t *key, int key_len, int ndc)
         unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
         if (!key)
         {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
+            msg(D_CRYPT_ERRORS,
+                "CRYPTO INFO: fixup_key_DES: insufficient key material");
             return;
         }
         mbedtls_des_key_set_parity(key);
@@ -413,9 +419,10 @@ cipher_kt_get(const char *ciphername)
 
     if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
     {
-        msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
-            "which is larger than " PACKAGE_NAME "'s current maximum key size "
-            "(%d bytes)", ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY_LENGTH);
+        msg(D_LOW,
+            "Cipher algorithm '%s' uses a default key size (%d bytes) which is "
+            "larger than "PACKAGE_NAME "'s current maximum key size (%d bytes)",
+            ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY_LENGTH);
         return NULL;
     }
 
@@ -509,10 +516,10 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
  *
  */
 
-
 void
 cipher_ctx_init(mbedtls_cipher_context_t *ctx, uint8_t *key, int key_len,
-                const mbedtls_cipher_info_t *kt, const mbedtls_operation_t operation)
+                const mbedtls_cipher_info_t *kt,
+                const mbedtls_operation_t operation)
 {
     ASSERT(NULL != kt && NULL != ctx);
 
@@ -726,10 +733,9 @@ md_kt_get(const char *digest)
     }
     if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
     {
-        msg(M_FATAL, "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
-            digest,
-            mbedtls_md_get_size(md),
-            MAX_HMAC_KEY_LENGTH);
+        msg(M_FATAL,
+            "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME "'s current maximum hash size (%d bytes)",
+            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);
     }
     return md;
 }
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 14188de..e23e275 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -79,8 +79,8 @@ typedef mbedtls_md_context_t hmac_ctx_t;
 /**
  * Returns a singleton instance of the mbed TLS random number generator.
  *
- * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generator. If it
- * hasn't been initialised yet, the RNG will be initialised using the default
+ * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generator. If
+ * it hasn't been initialised yet, the RNG will be initialised using the default
  * entropy sources. Aside from the default platform entropy sources, an
  * additional entropy source, the HAVEGE random number generator will also be
  * added. During initialisation, a personalisation string will be added based
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b016d98..bd0065c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -55,11 +55,15 @@
  */
 
 #if MAX_CIPHER_KEY_LENGTH < EVP_MAX_KEY_LENGTH
-#warning Some OpenSSL EVP ciphers now support key lengths greater than MAX_CIPHER_KEY_LENGTH -- consider increasing MAX_CIPHER_KEY_LENGTH
+#warning \
+    Some OpenSSL EVP ciphers now support key lengths greater than MAX_CIPHER_KEY_LENGTH \
+    -- consider increasing MAX_CIPHER_KEY_LENGTH
 #endif
 
 #if MAX_HMAC_KEY_LENGTH < EVP_MAX_MD_SIZE
-#warning Some OpenSSL HMAC message digests now support key lengths greater than MAX_HMAC_KEY_LENGTH -- consider increasing MAX_HMAC_KEY_LENGTH
+#warning \
+    Some OpenSSL HMAC message digests now support key lengths greater than MAX_HMAC_KEY_LENGTH \
+    -- consider increasing MAX_HMAC_KEY_LENGTH
 #endif
 
 #if HAVE_OPENSSL_ENGINE
@@ -135,7 +139,8 @@ crypto_init_lib_engine(const char *engine_name)
         engine_initialized = true;
     }
 #else  /* if HAVE_OPENSSL_ENGINE */
-    msg(M_WARN, "Note: OpenSSL hardware crypto engine functionality is not available");
+    msg(M_WARN,
+        "Note: OpenSSL hardware crypto engine functionality is not available");
 #endif
 }
 
@@ -247,7 +252,8 @@ const cipher_name_pair cipher_name_translation_table[] = {
     { "AES-256-GCM", "id-aes256-GCM" },
 };
 const size_t cipher_name_translation_table_count =
-    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);
+    sizeof(cipher_name_translation_table)
+    / sizeof(*cipher_name_translation_table);
 
 
 static int
@@ -321,7 +327,8 @@ show_available_ciphers()
 
     qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
 
-    for (i = 0; i < num_ciphers; i++) {
+    for (i = 0; i < num_ciphers; i++)
+    {
         if (cipher_kt_block_size(cipher_list[i]) >= 128/8)
         {
             print_cipher(cipher_list[i]);
@@ -330,7 +337,8 @@ show_available_ciphers()
 
     printf("\nThe following ciphers have a block size of less than 128 bits, \n"
            "and are therefore deprecated.  Do not use unless you have to.\n\n");
-    for (i = 0; i < num_ciphers; i++) {
+    for (i = 0; i < num_ciphers; i++)
+    {
         if (cipher_kt_block_size(cipher_list[i]) < 128/8)
         {
             print_cipher(cipher_list[i]);
@@ -377,14 +385,13 @@ show_available_engines()
     e = ENGINE_get_first();
     while (e)
     {
-        printf("%s [%s]\n",
-               ENGINE_get_name(e),
-               ENGINE_get_id(e));
+        printf("%s [%s]\n", ENGINE_get_name(e), ENGINE_get_id(e));
         e = ENGINE_get_next(e);
     }
     ENGINE_cleanup();
 #else  /* if HAVE_OPENSSL_ENGINE */
-    printf("Sorry, OpenSSL hardware crypto engine functionality is not available.\n");
+    printf(
+        "Sorry, OpenSSL hardware crypto engine functionality is not available.\n");
 #endif
 }
 
@@ -484,7 +491,8 @@ key_des_fixup(uint8_t *key, int key_len, int ndc)
         DES_cblock *dc = (DES_cblock *) buf_read_alloc(&b, sizeof(DES_cblock));
         if (!dc)
         {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
+            msg(D_CRYPT_ERRORS,
+                "CRYPTO INFO: fixup_key_DES: insufficient key material");
             ERR_clear_error();
             return;
         }
@@ -515,7 +523,6 @@ cipher_kt_get(const char *ciphername)
         return NULL;
     }
 
-
     if (EVP_CIPHER_key_length(cipher) > MAX_CIPHER_KEY_LENGTH)
     {
         msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
@@ -552,7 +559,8 @@ cipher_kt_iv_size(const EVP_CIPHER *cipher_kt)
 
 int
 cipher_kt_block_size(const EVP_CIPHER *cipher) {
-    /* OpenSSL reports OFB/CFB/GCM cipher block sizes as '1 byte'.  To work
+    /*
+     * OpenSSL reports OFB/CFB/GCM cipher block sizes as '1 byte'.  To work
      * around that, try to replace the mode with 'CBC' and return the block size
      * reported for that cipher, if possible.  If that doesn't work, just return
      * the value reported by OpenSSL.
@@ -805,8 +813,8 @@ md_kt_get(const char *digest)
     if (EVP_MD_size(md) > MAX_HMAC_KEY_LENGTH)
     {
         crypto_msg(M_FATAL, "Message hash algorithm '%s' uses a default hash "
-                   "size (%d bytes) which is larger than " PACKAGE_NAME "'s current "
-                   "maximum hash size (%d bytes)",
+                   "size (%d bytes) which is larger than " PACKAGE_NAME "'s "
+                   "current maximum hash size (%d bytes)",
                    digest, EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
     }
     return md;
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 69a5a32..6eecd77 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -58,7 +58,8 @@
 #define CERT_SYSTEM_STORE_CURRENT_USER_ID 1
 #endif
 #ifndef CERT_SYSTEM_STORE_CURRENT_USER
-#define CERT_SYSTEM_STORE_CURRENT_USER (CERT_SYSTEM_STORE_CURRENT_USER_ID << CERT_SYSTEM_STORE_LOCATION_SHIFT)
+#define CERT_SYSTEM_STORE_CURRENT_USER \
+    (CERT_SYSTEM_STORE_CURRENT_USER_ID << CERT_SYSTEM_STORE_LOCATION_SHIFT)
 #endif
 #ifndef CERT_STORE_READONLY_FLAG
 #define CERT_STORE_READONLY_FLAG 0x00008000
@@ -72,7 +73,8 @@
 
 /* try to funnel any Windows/CryptoAPI error messages to OpenSSL ERR_... */
 #define ERR_LIB_CRYPTOAPI (ERR_LIB_USER + 69)   /* 69 is just a number... */
-#define CRYPTOAPIerr(f)   err_put_ms_error(GetLastError(), (f), __FILE__, __LINE__)
+#define CRYPTOAPIerr(f) \
+    err_put_ms_error(GetLastError(), (f), __FILE__, __LINE__)
 #define CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE                  100
 #define CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE          101
 #define CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY   102
@@ -84,16 +86,26 @@
 #define CRYPTOAPI_F_GET_PROC_ADDRESS                        108
 
 static ERR_STRING_DATA CRYPTOAPI_str_functs[] = {
-    { ERR_PACK(ERR_LIB_CRYPTOAPI, 0, 0),                                    "microsoft cryptoapi"},
-    { ERR_PACK(0, CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE, 0),                   "CertOpenSystemStore" },
-    { ERR_PACK(0, CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE, 0),           "CertFindCertificateInStore" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY, 0),    "CryptAcquireCertificatePrivateKey" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_CREATE_HASH, 0),                        "CryptCreateHash" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_GET_HASH_PARAM, 0),                     "CryptGetHashParam" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SET_HASH_PARAM, 0),                     "CryptSetHashParam" },
-    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SIGN_HASH, 0),                          "CryptSignHash" },
-    { ERR_PACK(0, CRYPTOAPI_F_LOAD_LIBRARY, 0),                             "LoadLibrary" },
-    { ERR_PACK(0, CRYPTOAPI_F_GET_PROC_ADDRESS, 0),                         "GetProcAddress" },
+    { ERR_PACK(ERR_LIB_CRYPTOAPI, 0, 0),
+      "microsoft cryptoapi"},
+    { ERR_PACK(0, CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE, 0),
+      "CertOpenSystemStore" },
+    { ERR_PACK(0, CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE, 0),
+      "CertFindCertificateInStore" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_ACQUIRE_CERTIFICATE_PRIVATE_KEY, 0),
+      "CryptAcquireCertificatePrivateKey" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_CREATE_HASH, 0),
+      "CryptCreateHash" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_GET_HASH_PARAM, 0),
+      "CryptGetHashParam" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SET_HASH_PARAM, 0),
+      "CryptSetHashParam" },
+    { ERR_PACK(0, CRYPTOAPI_F_CRYPT_SIGN_HASH, 0),
+      "CryptSignHash" },
+    { ERR_PACK(0, CRYPTOAPI_F_LOAD_LIBRARY, 0),
+      "LoadLibrary" },
+    { ERR_PACK(0, CRYPTOAPI_F_GET_PROC_ADDRESS, 0),
+      "GetProcAddress" },
     { 0, NULL }
 };
 
@@ -112,8 +124,8 @@ ms_error_text(DWORD ms_err)
 
     FormatMessage(
         FORMAT_MESSAGE_ALLOCATE_BUFFER
-        |FORMAT_MESSAGE_FROM_SYSTEM
-        |FORMAT_MESSAGE_IGNORE_INSERTS,
+        | FORMAT_MESSAGE_FROM_SYSTEM
+        | FORMAT_MESSAGE_IGNORE_INSERTS,
         NULL, ms_err,
         MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), /* Default language */
         (LPTSTR) &lpMsgBuf, 0, NULL);
@@ -125,7 +137,8 @@ ms_error_text(DWORD ms_err)
         /* trim to the left */
         if (rv)
         {
-            for (p = rv + strlen(rv) - 1; p >= rv; p--) {
+            for (p = rv + strlen(rv) - 1; p >= rv; p--)
+            {
                 if (isspace(*p))
                 {
                     *p = '\0';
@@ -144,11 +157,15 @@ static void
 err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
 {
     static int init = 0;
+    /*
+     * I don't think we get more than 16 *different* errors in here, before we
+     * give up the whole thing...
+     */
 #define ERR_MAP_SZ 16
     static struct {
         int err;
-        DWORD ms_err;       /* I don't think we get more than 16 *different* errors */
-    } err_map[ERR_MAP_SZ];  /* in here, before we give up the whole thing...        */
+        DWORD ms_err;
+    } err_map[ERR_MAP_SZ];
     int i;
 
     if (ms_err == 0)
@@ -164,7 +181,8 @@ err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
     }
     /* since MS error codes are 32 bit, and the ones in the ERR_... system is
      * only 12, we must have a mapping table between them.  */
-    for (i = 0; i < ERR_MAP_SZ; i++) {
+    for (i = 0; i < ERR_MAP_SZ; i++)
+    {
         if (err_map[i].ms_err == ms_err)
         {
             ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file, line);
@@ -191,9 +209,13 @@ err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
 
 /* encrypt */
 static int
-rsa_pub_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+rsa_pub_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
+            int padding)
 {
-    /* I haven't been able to trigger this one, but I want to know if it happens... */
+    /*
+     * I haven't been able to trigger this one, but I want to know if it
+     * happens...
+     */
     assert(0);
 
     return 0;
@@ -201,9 +223,13 @@ rsa_pub_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, in
 
 /* verify arbitrary data */
 static int
-rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
+            int padding)
 {
-    /* I haven't been able to trigger this one, but I want to know if it happens... */
+    /*
+     * I haven't been able to trigger this one, but I want to know if it
+     * happens...
+     */
     assert(0);
 
     return 0;
@@ -211,7 +237,8 @@ rsa_pub_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, in
 
 /* sign arbitrary data */
 static int
-rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
+             int padding)
 {
     CAPI_DATA *cd = (CAPI_DATA *) rsa->meth->app_data;
     HCRYPTHASH hash;
@@ -279,7 +306,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
         free(buf);
         return 0;
     }
-    /* and now, we have to reverse the byte-order in the result from CryptSignHash()... */
+    /* now we have to reverse the byte-order of the CryptSignHash() result... */
     for (i = 0; i < len; i++)
         to[i] = buf[len - i - 1];
     free(buf);
@@ -290,9 +317,13 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
 
 /* decrypt */
 static int
-rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+rsa_priv_dec(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
+             int padding)
 {
-    /* I haven't been able to trigger this one, but I want to know if it happens... */
+    /*
+     * I haven't been able to trigger this one, but I want to know if it
+     * happens...
+     */
     assert(0);
 
     return 0;
@@ -345,8 +376,10 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
     {
         /* skip the tag */
         cert_prop += 5;
-        rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
-                                        0, CERT_FIND_SUBJECT_STR_A, cert_prop, NULL);
+        rv = CertFindCertificateInStore(cert_store,
+                                        X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
+                                        0, CERT_FIND_SUBJECT_STR_A, cert_prop,
+                                        NULL);
 
     }
     else if (!strncmp(cert_prop, "THUMB:", 6))
@@ -358,7 +391,8 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 
         /* skip the tag */
         cert_prop += 6;
-        for (p = (char *) cert_prop, i = 0; *p && i < sizeof(hash); i++) {
+        for (p = (char *) cert_prop, i = 0; *p && i < sizeof(hash); i++)
+        {
             if (*p >= '0' && *p <= '9')
             {
                 x = (*p - '0') << 4;
@@ -393,7 +427,8 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
         }
         blob.cbData = i;
         blob.pbData = (unsigned char *) &hash;
-        rv = CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
+        rv = CertFindCertificateInStore(cert_store,
+                                        X509_ASN_ENCODING | PKCS_7_ASN_ENCODING,
                                         0, CERT_FIND_HASH, &blob, NULL);
 
     }
@@ -416,8 +451,10 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
         goto err;
     }
     /* search CURRENT_USER first, then LOCAL_MACHINE */
-    cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER
-                       |CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
+    cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0,
+                       CERT_SYSTEM_STORE_CURRENT_USER
+                       | CERT_STORE_OPEN_EXISTING_FLAG
+                       | CERT_STORE_READONLY_FLAG, L"MY");
     if (cs == NULL)
     {
         CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
@@ -427,8 +464,10 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     CertCloseStore(cs, 0);
     if (!cd->cert_context)
     {
-        cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_LOCAL_MACHINE
-                           |CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
+        cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0,
+                           CERT_SYSTEM_STORE_LOCAL_MACHINE
+                           | CERT_STORE_OPEN_EXISTING_FLAG
+                           | CERT_STORE_READONLY_FLAG, L"MY");
         if (cs == NULL)
         {
             CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
@@ -444,7 +483,8 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
 
     /* cert_context->pbCertEncoded is the cert X509 DER encoded. */
-    cert = d2i_X509(NULL, (const unsigned char **) &cd->cert_context->pbCertEncoded,
+    cert = d2i_X509(NULL,
+                    (const unsigned char **) &cd->cert_context->pbCertEncoded,
                     cd->cert_context->cbCertEncoded);
     if (cert == NULL)
     {
@@ -453,8 +493,10 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
 
     /* set up stuff to use the private key */
-    if (!CryptAcquireCertificatePrivateKey(cd->cert_context, CRYPT_ACQUIRE_COMPARE_KEY_FLAG,
-                                           NULL, &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))
+    if (!CryptAcquireCertificatePrivateKey(cd->cert_context,
+                                           CRYPT_ACQUIRE_COMPARE_KEY_FLAG,
+                                           NULL, &cd->crypt_prov, &cd->key_spec,
+                                           &cd->free_crypt_prov))
     {
         /* if we don't have a smart card reader here, and we try to access a
          * smart card certificate, we get:
@@ -495,8 +537,11 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     X509_free(cert);
     cert = NULL;
 
-    /* I'm not sure about what we have to fill in in the RSA, trying out stuff... */
-    /* rsa->n indicates the key size */
+    /*
+     * I'm not sure about what we have to fill in in the RSA, trying out stuff..
+     *
+     * rsa->n indicates the key size
+     */
     rsa->n = BN_dup(pub_rsa->n);
     rsa->flags |= RSA_FLAG_EXT_PKEY;
     if (!RSA_set_method(rsa, my_rsa_method))
@@ -545,9 +590,10 @@ err:
 }
 
 #else  /* ifdef ENABLE_CRYPTOAPI */
-#ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
+#ifdef _MSC_VER
+/* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void
 dummy(void) {
 }
 #endif
-#endif                          /* _WIN32 */
+#endif /* ifdef ENABLE_CRYPTOAPI */
-- 
2.7.4


