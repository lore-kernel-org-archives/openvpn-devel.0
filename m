Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BE606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kS3bYnWU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fT78HmRe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=m6kxRvUM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5Nnrj4LrF1Qm5u05a0EFVeoD7Uz2hysas5WITHP+2zE=; b=kS3bYnWU3odANa
	j/TqFNRPXLZ6RvgStD/4SNP4dMJJzu+4Tha2GtcJfUSYJ4nyker1HpkAhzTjE2r0yzxrnRu48nYaA
	ZvZno7+Rwaz/ZTOJ/HoIWmA4DyrJvbP5+fkH0fPUyuGy1IVxDBs/PcQ/0PW/CTLJ2GwGHDlcd3w2h
	1+U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmyu-000000000dL-1pFB;
	Tue, 10 Nov 2026 14:37:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQmyr-000000000d3-1KMe for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1kZPDB2v/b+H4XU07qvQRC3Aw7ov1zh0AwHi/Q5CtNI=; b=fT78HmReBZHPFIMRA95FJ8OZHh
 vhR7o5nsTxc8hQFKN6edGj4Oa2gbixZxmdFRlFzR2EIpvaQ++n9N8qHCuOGCvwuCTiNHvxypja1Qx
 lViUhoKSx5T3Rp1dTslhdlxMnUzJTuOQmInuVRG0V14DhmwN7osZn53qLSLiVIbsmpM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1kZPDB2v/b+H4XU07qvQRC3Aw7ov1zh0AwHi/Q5CtNI=; b=m6kxRvUM39mq8to5VMKkWx7aHO
 4EjRHlVPUHP9rb+uAPl3Td00aLerZiy6QKzMpbbP9VIFg1UVtwUYgN1F2f3sPjMUc5aaYhrlohobp
 eGEWe5CzFO4wKJP1QE0j35yJ6w8RMnaIyvmRJPlS6Hma9Ufpk94PLNYut4DTMDihlTQ0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQmyW-000000008RR-3ars for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:37:30 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AAEbME5015207
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 15:37:22 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AAEbMC0015206
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 15:37:22 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 15:37:16 +0100
Message-ID: <20261110143722.15193-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQmyW-000000008RR-3ars
Subject: [Openvpn-devel] [PATCH v4] Various trivial -Wsign-conversion fixes
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Lichtenheld <frank@lichtenheld.com>

* Continue BLEN -> BLENZ replacement
* Remove some unneeded casts
* Some trivial type fixes

Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2157
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2157
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/acc.c b/src/openvpn/acc.c
index e21891d..b8d7c3d 100644
--- a/src/openvpn/acc.c
+++ b/src/openvpn/acc.c
@@ -148,11 +148,6 @@
     return parse_acc_message_flags(flags, err_reason, gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 receive_acc_message(struct context *c, const struct buffer *buffer)
 {
@@ -236,15 +231,10 @@
     msg(D_PUSH_ERRORS, "WARNING: Received malformed custom app control channel "
                        "message (%s): %s",
         err_reason,
-        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+        format_hex(CBPTR(buffer), BLENZ(buffer), 80, &gc));
     gc_free(&gc);
 }
 
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 send_acc_message(struct context *c,
                  struct tls_multi *multi,
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 211af90..b69092c 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -36,11 +36,6 @@
  * padding */
 static_assert(TOKEN_DATA_LEN % 3 == 0, "TOKEN_DATA_LEN is not a multiple of 3");
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 bool
 is_auth_token(const char *password)
 {
@@ -67,7 +62,7 @@
         return;
     }
 
-    int auth_token_state_flags = session->key[KS_PRIMARY].auth_token_state_flags;
+    unsigned int auth_token_state_flags = session->key[KS_PRIMARY].auth_token_state_flags;
 
     const char *state;
 
@@ -188,7 +183,7 @@
 {
     struct gc_arena gc = gc_new();
 
-    int64_t timestamp = htonll((uint64_t)now);
+    int64_t timestamp = (int64_t)htonll((uint64_t)now);
     int64_t initial_timestamp = timestamp;
 
     hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
@@ -273,7 +268,7 @@
         alloc_buf_gc(strlen(SESSION_ID_PREFIX) + strlen(b64output) + 1, &gc);
 
     ASSERT(buf_write(&session_token, SESSION_ID_PREFIX, strlen(SESSION_ID_PREFIX)));
-    ASSERT(buf_write(&session_token, b64output, (int)strlen(b64output)));
+    ASSERT(buf_write(&session_token, b64output, strlen(b64output)));
     ASSERT(buf_write_u8(&session_token, 0));
 
     free(b64output);
@@ -296,10 +291,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const char *username)
 {
diff --git a/src/openvpn/base64.h b/src/openvpn/base64.h
index be7aa64..800e569 100644
--- a/src/openvpn/base64.h
+++ b/src/openvpn/base64.h
@@ -35,7 +35,7 @@
 #define _BASE64_H_
 
 /** Compute resulting base64 length.  6 bits per byte, padded to 4 bytes. */
-#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) + 3) & ~3)
+#define OPENVPN_BASE64_LENGTH(binary_length) ((((8 * binary_length) / 6) + 3) & ~3u)
 
 /** Compute the maximal number of bytes encoded in a base64 string. */
 #define OPENVPN_BASE64_DECODED_LENGTH(base64_length) ((base64_length / 4) * 3)
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index dc71d12..0353ade 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -234,7 +234,7 @@
     if (!echo && (tcgetattr(fileno(fp), &tty_tmp) == 0))
     {
         tty_save = tty_tmp;
-        tty_tmp.c_lflag &= ~(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
+        tty_tmp.c_lflag &= ~(unsigned int)(ECHO | ECHOE | ECHOK | ECHONL | ISIG);
         restore_tty = (tcsetattr(fileno(fp), TCSAFLUSH, &tty_tmp) == 0);
     }
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 88c2c52..a4c2683 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -139,7 +139,7 @@
         ASSERT(cipher_ctx_reset(ctx->cipher, iv));
     }
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* Buffer overflow check */
     if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
@@ -151,7 +151,7 @@
 
     /* For AEAD ciphers, authenticate Additional Data, including opcode */
     ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work)));
-    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", format_hex(BPTR(&work), BLEN(&work), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s", format_hex(BPTR(&work), BLENZ(&work), 0, &gc));
 
     if (!use_epoch_data_format)
     {
@@ -170,8 +170,8 @@
 
     /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n trick
      * to round up the result to the number of blocks used */
-    const int blocksize = AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi.encrypt.plaintext_blocks += (BLEN(&work) + (blocksize - 1)) / blocksize;
+    const unsigned int blocksize = AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.encrypt.plaintext_blocks += (BLENZ(&work) + (blocksize - 1)) / blocksize;
 
     /* if the tag is at end the end, allocate it now */
     if (use_epoch_data_format)
@@ -186,7 +186,7 @@
 
     *buf = work;
 
-    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     gc_free(&gc);
     return;
@@ -257,13 +257,13 @@
             ASSERT(buf_write(&work, iv_buf, iv_size));
             dmsg(D_PACKET_CONTENT, "ENCRYPT IV: %s", format_hex(iv_buf, iv_size, 0, &gc));
 
-            dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+            dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
             /* cipher_ctx was already initialized with key & keylen */
             ASSERT(cipher_ctx_reset(ctx->cipher, iv_buf));
 
             /* Buffer overflow check */
-            if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+            if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
             {
                 msg(D_CRYPT_ERRORS,
                     "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d cbs=%u",
@@ -317,7 +317,7 @@
 
         *buf = work;
 
-        dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
     }
 
     gc_free(&gc);
@@ -460,7 +460,7 @@
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     ASSERT(ad_start >= buf->data && ad_start <= BPTR(buf));
 
@@ -558,10 +558,10 @@
     }
 
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
-    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
     /* Buffer overflow check (should never fail) */
-    if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
     {
         CRYPT_ERROR("potential buffer overflow");
     }
@@ -585,7 +585,7 @@
     }
     ASSERT(buf_inc_len(&work, outlen));
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
 
     if (!crypto_check_replay(opt, &pin, epoch, error_prefix, &gc))
     {
@@ -594,8 +594,8 @@
 
     /* update number of plaintext blocks decrypted. Use the (x + (n-1))/n trick
      * to round up the result to the number of blocks used. */
-    const int blocksize = AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi.decrypt.plaintext_blocks += (BLEN(&work) + (blocksize - 1)) / blocksize;
+    const unsigned int blocksize = AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.decrypt.plaintext_blocks += (BLENZ(&work) + (blocksize - 1)) / blocksize;
 
     *buf = work;
 
@@ -631,7 +631,7 @@
         struct packet_id_net pin;
         bool have_pin = false;
 
-        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
+        dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
         /* Verify the HMAC */
         if (ctx->hmac)
@@ -694,7 +694,7 @@
             }
 
             /* Buffer overflow check (should never happen) */
-            if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+            if (!buf_safe(&work, BLENZ(buf) + cipher_ctx_block_size(ctx->cipher)))
             {
                 CRYPT_ERROR("packet too big to decrypt");
             }
@@ -713,7 +713,7 @@
             }
             ASSERT(buf_inc_len(&work, outlen));
 
-            dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLEN(&work), 80, &gc));
+            dmsg(D_PACKET_CONTENT, "DECRYPT TO: %s", format_hex(BPTR(&work), BLENZ(&work), 80, &gc));
 
             /* Get packet ID from plaintext buffer or IV, depending on cipher mode */
             {
@@ -855,7 +855,7 @@
 crypto_max_overhead(void)
 {
     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH + OPENVPN_MAX_CIPHER_BLOCK_SIZE
-           + max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
+           + max_uint(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
 static void
@@ -1366,7 +1366,7 @@
         size_t buf_size = strlen(file) + 1;
         ASSERT(buf_size <= INT_MAX);
         size = (int)buf_size;
-        buf_set_read(&in, (const uint8_t *)file, size);
+        buf_set_read(&in, (const uint8_t *)file, buf_size);
     }
     else /* 'file' is a filename which refers to a file containing the ascii key */
     {
@@ -1535,7 +1535,7 @@
     struct buffer out = alloc_buf_gc(2048, &gc);
 
     /* how to format the ascii file representation of key */
-    const int bytes_per_line = 16;
+    const unsigned int bytes_per_line = 16;
 
     /* write header */
     buf_printf(&out, "#\n# %d bit OpenVPN static key\n#\n", nbits);
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index dbe0802..fd632be 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -760,12 +760,12 @@
  * to read.
  */
 static inline bool
-aead_usage_limit_reached(const uint64_t limit, const struct key_ctx *key_ctx, int64_t higest_pid)
+aead_usage_limit_reached(const uint64_t limit, const struct key_ctx *key_ctx, uint64_t higest_pid)
 {
     /* This is the  q + s <=  p^(1/2) * 2^(129/2) - 1 calculation where
      * q is the number of protected messages (highest_pid)
      * s Total plaintext length in all messages (in blocks) */
-    return (limit > 0 && key_ctx->plaintext_blocks + (uint64_t)higest_pid > limit);
+    return (limit > 0 && key_ctx->plaintext_blocks + higest_pid > limit);
 }
 
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 312cf6f..243b5a2 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -98,7 +98,7 @@
     const uint8_t *label_prefix = (const uint8_t *)("ovpn ");
     uint8_t prefix_len = 5;
 
-    size_t hkdf_label_len = 2 + prefix_len + 1 + label_len + 1 + context_len;
+    size_t hkdf_label_len = 2u + prefix_len + 1u + label_len + 1u + context_len;
     struct buffer hkdf_label = alloc_buf_gc(hkdf_label_len, &gc);
 
     buf_write_u16(&hkdf_label, (uint16_t)out_len);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 4809532..1760c90 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2758,7 +2758,7 @@
             else
             {
                 int status;
-                int resolve_flags = GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
+                unsigned int resolve_flags = GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
 
                 if (!(flags & MF_CONNECT_AS_CLIENT))
                 {
@@ -4001,11 +4001,11 @@
         desc = "rsa-sign";
     }
 
-    buf_write(&buf_data, b64_data, (int)strlen(b64_data));
+    buf_write(&buf_data, b64_data, strlen(b64_data));
     if (man->connection.client_version >= MCV_PKSIGN_ALG)
     {
-        buf_write(&buf_data, ",", (int)strlen(","));
-        buf_write(&buf_data, algorithm, (int)strlen(algorithm));
+        buf_write(&buf_data, ",", strlen(","));
+        buf_write(&buf_data, algorithm, strlen(algorithm));
     }
     char *ret = management_query_multiline_flatten(man, (char *)buf_bptr(&buf_data), prompt, desc,
                                                    &man->connection.ext_key_state,
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index cbc3118..f4e142b 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1119,7 +1119,7 @@
         return 0;
     }
 
-    retval = endless_buf_write(&ks->bio_ctx->in, BPTR(buf), buf->len);
+    retval = endless_buf_write(&ks->bio_ctx->in, BPTR(buf), BLENZ(buf));
 
     if (retval < 0)
     {
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index bea51b5..37f6218 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -52,11 +52,6 @@
 
 static const char testtext[] = "Dummy text to test PEM encoding";
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 crypto_pem_encode_decode_loopback(void **state)
 {
@@ -467,14 +462,14 @@
      * current mode (FIPS), this will still return -1 */
     assert_int_equal(cipher_get_aead_limits("CHACHA20-POLY1305"), 0);
 
-    int64_t aeslimit = cipher_get_aead_limits("AES-128-GCM");
+    uint64_t aeslimit = cipher_get_aead_limits("AES-128-GCM");
 
     assert_int_equal(aeslimit, (1ull << 36) - 1);
 
     /* Check if this matches our exception for 1600 size packets assuming
      * AEAD_LIMIT_BLOCKSIZE (128 bits/ 16 bytes). Gives us 100 blocks
      * + 1 for the packet */
-    int64_t L = 101;
+    uint64_t L = 101;
     /* 2 ^ 29.34, using the result here to avoid linking to libm */
     assert_int_equal(aeslimit / L, 680390858);
 
@@ -520,7 +515,7 @@
                          0xec, 0xed, 0xee, 0xef, 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
                          0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };
 
-    const int L = 82;
+    const size_t L = 82;
     uint8_t okm[82] = { 0xb1, 0x1e, 0x39, 0x8d, 0xc8, 0x03, 0x27, 0xa1, 0xc8, 0xe7, 0xf7, 0x8c,
                         0x59, 0x6a, 0x49, 0x34, 0x4f, 0x01, 0x2e, 0xda, 0x2d, 0x4e, 0xfa, 0xd8,
                         0xa0, 0x50, 0xcc, 0x4c, 0x19, 0xaf, 0xa9, 0x7c, 0x59, 0x04, 0x5a, 0x99,
@@ -545,7 +540,7 @@
 
     const uint8_t info[] = { 0 };
 
-    int L = 42;
+    const size_t L = 42;
     uint8_t okm[42] = { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,
                         0x2a, 0x06, 0x3c, 0x5a, 0x31, 0xb8, 0xa1, 0x1f, 0x5c, 0x5e, 0xe1,
                         0x87, 0x9e, 0xc3, 0x45, 0x4e, 0x5f, 0x3c, 0x73, 0x8d, 0x2d, 0x9d,
@@ -570,7 +565,7 @@
     uint8_t info[18] = { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,
                          0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };
 
-    int L = 27;
+    const size_t L = 27;
     uint8_t okm[27] = { 0x87, 0x5a, 0x8e, 0xec, 0x18, 0x55, 0x63, 0x80, 0xb8,
                         0xd9, 0x33, 0xed, 0x32, 0x3c, 0x2d, 0xf8, 0xe8, 0xec,
                         0xcf, 0x49, 0x72, 0xe6, 0x83, 0xf0, 0x6a, 0x83, 0xac };
@@ -782,7 +777,7 @@
 
     /* lookup some wacky things that should fail */
     assert_null(epoch_lookup_decrypt_key(co, 2000));
-    assert_null(epoch_lookup_decrypt_key(co, -1));
+    assert_null(epoch_lookup_decrypt_key(co, UINT16_MAX));
     assert_null(epoch_lookup_decrypt_key(co, 0xefff));
 
     /* Lookup the edges of the current window */
@@ -833,10 +828,6 @@
     assert_null(epoch_lookup_decrypt_key(co, 23));
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 crypto_test_epoch_key_overflow(void **state)
 {
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index ae75386..3699a2a1 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -40,23 +40,14 @@
     return net_iface_del(NULL, name);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static int
-net__iface_mtu_set(int mtu)
+net__iface_mtu_set(uint32_t mtu)
 {
-    printf("CMD: ip link set %s mtu %d\n", iface, mtu);
+    printf("CMD: ip link set %s mtu %u\n", iface, mtu);
 
     return net_iface_mtu_set(NULL, iface, mtu);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 net__addr_v4_add(const char *addr_str, int prefixlen)
 {
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 5ace810..fbbb40f 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -618,11 +618,6 @@
     assert_memory_equal(server_id2_p1.id, server_id_p2.id, SID_SIZE);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 test_generate_reset_packet_plain(void **ut_state)
 {
@@ -701,10 +696,6 @@
     free_tas(&tas_server);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* A peer can ask us to append the wrapped client key (WKc) to our next
  * control packet. Only a tls-crypt-v2 client has one, so check that we
  * refuse to build such a packet when we have no key instead of walking
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index ab90ea5..2d31c00 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -352,7 +352,7 @@
     skip_if_tls_crypt_not_supported(ctx);
 
     buf_clear(&ctx->source);
-    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLEN(&ctx->ciphertext)
+    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLENZ(&ctx->ciphertext)
                                                       - tls_crypt_buf_overhead()));
 
     assert_true(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
@@ -373,7 +373,7 @@
     skip_if_tls_crypt_not_supported(ctx);
 
     buf_clear(&ctx->source);
-    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLEN(&ctx->ciphertext)
+    assert_non_null(buf_write_alloc(&ctx->source, TESTBUF_SIZE - BLENZ(&ctx->ciphertext)
                                                       - tls_crypt_buf_overhead() + 1));
     assert_false(tls_crypt_wrap(&ctx->source, &ctx->ciphertext, &ctx->co));
 }
@@ -553,7 +553,7 @@
     assert_false(tls_crypt_v2_extract_client_key(&ctx->wkc, &wrap_ctx, NULL));
 
     /* add a opcode in front of the key to make it valid to extract */
-    struct buffer wkcop = alloc_buf_gc(buf_len(&ctx->wkc) + 1, &ctx->gc);
+    struct buffer wkcop = alloc_buf_gc(BLENZ(&ctx->wkc) + 1, &ctx->gc);
     buf_write_u8(&wkcop, 0x50);
     buf_copy(&wkcop, &ctx->wkc);
     assert_true(tls_crypt_v2_extract_client_key(&wkcop, &wrap_ctx, NULL));
@@ -638,7 +638,7 @@
     int64_t create_time = now - (days_ago * 24 * 60 * 60);
     assert_true(create_time > 0);
 
-    int64_t timestamp = htonll((uint64_t)create_time);
+    uint64_t timestamp = htonll((uint64_t)create_time);
     ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_TIMESTAMP, 1));
     ASSERT(buf_write(&metadata, &timestamp, sizeof(timestamp)));
 
@@ -660,7 +660,7 @@
                                              &ctx->server_keys.encrypt, &ctx->gc));
 
     /* add a opcode in front of the key to make it valid to extract */
-    struct buffer pseudo_packet = alloc_buf_gc(buf_len(&ctx->wkc) + 1, &ctx->gc);
+    struct buffer pseudo_packet = alloc_buf_gc(BLENZ(&ctx->wkc) + 1, &ctx->gc);
 
     buf_write_u8(&pseudo_packet, 0x50);
     buf_copy(&pseudo_packet, &ctx->wkc);
@@ -745,7 +745,7 @@
     struct buffer expected_metadata = create_metadata_days_ago(&ctx->gc, 29);
     buf_advance(&expected_metadata, 1);
 
-    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), buf_len(&expected_metadata));
+    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), BLENZ(&expected_metadata));
     will_return(__wrap_buffer_write_file, true);
 
     tmp = create_client_key_input(ctx, 29);
@@ -760,7 +760,7 @@
     }
 
     expect_string(__wrap_buffer_write_file, filename, tmpfile_path);
-    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), buf_len(&expected_metadata));
+    expect_memory(__wrap_buffer_write_file, pem, buf_bptr(&expected_metadata), BLENZ(&expected_metadata));
     will_return(__wrap_buffer_write_file, true);
 
     tmp = create_client_key_input(ctx, 29);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
