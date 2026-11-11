Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884B606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GrsBTWsh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AXhPrLdx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XygsQstE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=icA9F9Arc33CA2D6TJwQGnI9L/ZuIlut6pYiuk7y71U=; b=GrsBTWshbp3abu
	oCtyYzpSF+ivV/mRIanFSw0GmVXI7kMtHGVDPH8jsgjzVXIInUjC2xlg46rdSjMbqNeGWy9w0JcAJ
	BT1b0rt5OEP95dDlo4YZXBssTlPSZ8UI6n8qooD4dfZK+4Y0hu/EVhn4t1k1yZ1/vBGhZxATQblUx
	Yh4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRD6x-000000000vN-1449;
	Wed, 11 Nov 2026 18:31:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRD6v-000000000vG-0aBY for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJmSv1/qgfGJOTggNxuf3THZOQ3io1mQ4wayrOdGN6k=; b=AXhPrLdxvRFx+5doW7oE9X4QzS
 6fJUg5oC3itFx+GalytVGNVhDyQaVNYDV7057o88IyNmi+gkjK3P9lhy4dZHXXFTZItqLV3sQlM30
 vePg6Eev3hQWG2Bu2RvHz5Tq7hqW8Tc6711iFJsnEG8eZQUPN9RDwSuBtTF1BvN+2rXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJmSv1/qgfGJOTggNxuf3THZOQ3io1mQ4wayrOdGN6k=; b=XygsQstEk4pmiYeTNxnDSY0hw+
 aT+ENvVJ3GYOaX4XpqeWqPn0wgQqiWCIh7Wu394OjoKMXWscp1SqiHKf9t1hnEHHCZFA+Nybko44h
 r/fc/gmUeHDtzYe9uJc+Qx55qDin5YN9LAMOKEMtnIOLW3NFy/EivAvj9tNPiSiOOyQQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRD6t-0000000054k-1DLV for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:31:53 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ABIViVf018689
 for <openvpn-devel@lists.sourceforge.net>; Wed, 11 Nov 2026 19:31:44 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ABIViEc018688
 for openvpn-devel@lists.sourceforge.net; Wed, 11 Nov 2026 19:31:44 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 19:31:39 +0100
Message-ID: <20261111183144.18676-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRD6t-0000000054k-1DLV
Subject: [Openvpn-devel] [PATCH v5] crypto*: Avoid sign conversion warnings
 by using defines directly
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

Using the defines directly avoids the issue with sign
conversion by letting the compiler deduce the types of
the literals.

I do not think that using an intermediate variable
increases the readability.

Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2158
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2158
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a4c2683..6955760 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -81,7 +81,6 @@
 
     const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out = NULL;
-    const int mac_len = OPENVPN_AEAD_TAG_LENGTH;
 
     /* IV, packet-ID and implicit IV required for this mode. */
     ASSERT(ctx->cipher);
@@ -142,7 +141,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* Buffer overflow check */
-    if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&work, BLENZ(buf) + OPENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_size(ctx->cipher)))
     {
         msg(D_CRYPT_ERRORS, "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d",
             buf->capacity, buf->offset, buf->len, work.capacity, work.offset, work.len);
@@ -156,7 +155,7 @@
     if (!use_epoch_data_format)
     {
         /* Reserve space for authentication tag */
-        mac_out = buf_write_alloc(&work, mac_len);
+        mac_out = buf_write_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);
         ASSERT(mac_out);
     }
 
@@ -177,12 +176,12 @@
     if (use_epoch_data_format)
     {
         /* Reserve space for authentication tag */
-        mac_out = buf_write_alloc(&work, mac_len);
+        mac_out = buf_write_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);
         ASSERT(mac_out);
     }
 
     /* Write authentication tag */
-    ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, mac_len));
+    ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, OPENVPN_AEAD_TAG_LENGTH));
 
     *buf = work;
 
@@ -453,9 +452,6 @@
         CRYPT_DROP("Decryption failed verification limit reached.");
     }
 
-    const int tag_size = OPENVPN_AEAD_TAG_LENGTH;
-
-
     ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
@@ -470,14 +466,14 @@
     ASSERT(packet_id_initialized(&opt->packet_id));
 
     /* Ensure that the packet size is long enough */
-    int min_packet_len = packet_id_size(false) + tag_size + 1;
+    size_t min_packet_len = packet_id_size(false) + OPENVPN_AEAD_TAG_LENGTH + 1;
 
     if (use_epoch_data_format)
     {
         min_packet_len += sizeof(uint32_t);
     }
 
-    if (buf->len < min_packet_len)
+    if (BLENZ(buf) < min_packet_len)
     {
         CRYPT_ERROR("missing IV info, missing tag or no payload");
     }
@@ -540,24 +536,24 @@
         }
     }
 
-    const int ad_size = (int)(BPTR(buf) - ad_start);
+    const uintptr_t ad_size = (uintptr_t)(BPTR(buf) - ad_start);
 
     uint8_t *tag_ptr = NULL;
     int data_len = 0;
 
     if (use_epoch_data_format)
     {
-        data_len = BLEN(buf) - tag_size;
+        data_len = BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;
         tag_ptr = BPTR(buf) + data_len;
     }
     else
     {
         tag_ptr = BPTR(buf);
-        ASSERT(buf_advance(buf, tag_size));
+        ASSERT(buf_advance(buf, OPENVPN_AEAD_TAG_LENGTH));
         data_len = BLEN(buf);
     }
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &gc));
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
     /* Buffer overflow check (should never fail) */
@@ -567,7 +563,7 @@
     }
 
     /* feed in tag and the authenticated data */
-    ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, (int)ad_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s", format_hex(ad_start, ad_size, 0, &gc));
 
     /* Decrypt and authenticate packet */
@@ -578,7 +574,7 @@
     }
 
     ASSERT(buf_inc_len(&work, outlen));
-    if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen, &outlen, tag_ptr, tag_size))
+    if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen, &outlen, tag_ptr, OPENVPN_AEAD_TAG_LENGTH))
     {
         ctx->failed_verifications++;
         CRYPT_DROP("packet tag authentication failed");
@@ -1118,20 +1114,19 @@
 static void
 generate_key_random(struct key *key)
 {
-    int cipher_len = MAX_CIPHER_KEY_LENGTH;
-    int hmac_len = MAX_HMAC_KEY_LENGTH;
-
     struct gc_arena gc = gc_new();
 
     CLEAR(*key);
-    if (!rand_bytes(key->cipher, cipher_len) || !rand_bytes(key->hmac, hmac_len))
+    if (!rand_bytes(key->cipher, MAX_CIPHER_KEY_LENGTH)
+        || !rand_bytes(key->hmac, MAX_HMAC_KEY_LENGTH))
     {
         msg(M_FATAL, "ERROR: Random number generator cannot obtain entropy for key generation");
     }
 
     dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %s",
-         format_hex(key->cipher, cipher_len, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->hmac, hmac_len, 0, &gc));
+         format_hex(key->cipher, MAX_CIPHER_KEY_LENGTH, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s",
+         format_hex(key->hmac, MAX_HMAC_KEY_LENGTH, 0, &gc));
 
     gc_free(&gc);
 }
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 243b5a2..40e8cec 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -38,11 +38,6 @@
 #include "buffer.h"
 #include "integer.h"
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_len,
                  uint8_t *out, size_t out_len)
@@ -51,26 +46,23 @@
     hmac_ctx_init(hmac_ctx, secret, "SHA256");
 
     ASSERT(info_len <= INT_MAX);
-    const unsigned int digest_size = SHA256_DIGEST_LENGTH;
 
     /* T(0) = empty string */
     uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    unsigned int t_prev_len = 0;
 
-    for (uint8_t block = 1; (block - 1) * digest_size < out_len; block++)
+    for (uint8_t block = 1; (block - 1u) * SHA256_DIGEST_LENGTH < out_len; block++)
     {
         hmac_ctx_reset(hmac_ctx);
 
         /* calculate T(block) */
-        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);
+        hmac_ctx_update(hmac_ctx, t_prev, block == 1 ? 0 : SHA256_DIGEST_LENGTH);
         hmac_ctx_update(hmac_ctx, info, (int)info_len);
         hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_final(hmac_ctx, t_prev);
-        t_prev_len = digest_size;
 
         /* Copy a full hmac output or remaining bytes */
-        size_t out_offset = (block - 1) * digest_size;
-        size_t copylen = min_size(digest_size, out_len - out_offset);
+        size_t out_offset = (block - 1u) * SHA256_DIGEST_LENGTH;
+        size_t copylen = min_size(SHA256_DIGEST_LENGTH, out_len - out_offset);
 
         memcpy(out + out_offset, t_prev, copylen);
     }
@@ -463,7 +455,3 @@
         epoch_iterate_send_key(opt);
     }
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 48752d3..782dd58 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -312,7 +312,7 @@
 const char *packet_id_net_print(const struct packet_id_net *pin, bool print_timestamp,
                                 struct gc_arena *gc);
 
-static inline int
+static inline unsigned int
 packet_id_size(bool long_form)
 {
     return sizeof(packet_id_type) + (long_form ? sizeof(net_time_t) : 0);
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2dadc4f..7eb83ce 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -52,7 +52,7 @@
     return create_kt("AES-256-CTR", "SHA256", "tls-crypt");
 }
 
-int
+unsigned int
 tls_crypt_buf_overhead(void)
 {
     return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index d179cbb..8e5567f 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -130,7 +130,7 @@
  * Returns the maximum overhead (in bytes) added to the destination buffer by
  * tls_crypt_wrap().
  */
-int tls_crypt_buf_overhead(void);
+unsigned int tls_crypt_buf_overhead(void);
 
 /**
  * Wrap a control channel packet (both authenticates and encrypts the data).
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 2d31c00..00de73a 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -232,11 +232,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /**
  * Check that short messages are successfully wrapped-and-unwrapped.
  */
@@ -778,10 +773,6 @@
     tls_wrap_free(&wrap_ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 test_tls_crypt_v2_write_server_key_file(void **state)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
