Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C63606A323
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DPCrjheS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Jxb1SjO/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kcP8No50
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=49z81dcEaZyYLjyt/f6x/B34P2ysCE+LfcoXOpeUKMg=; b=DPCrjheSL1fB/Y
	A/R4E9VQ1lQdM2ePTl/5F3sk78xvU8eBmTiIlnWwEVZV6Szt7RKxXsYJR6imv++frW9TMKMjT1nb0
	ZZ9UJltNOlfZf08N8MoAUGwFVr6rsaAupexiQ3iuG0jo+U0Cjd79LvqDVVeU+dxOyS+8k4KsYAFNC
	lYU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGHY-000000006WM-2Icf;
	Tue, 17 Nov 2026 10:19:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTGHW-000000006W4-2txp for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:19:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UOvy5QDHw4J+QsVBbuyW69c6PHHh5T4sf2hsEnVolhY=; b=Jxb1SjO/FdKmaP3WcXdzlyLyKV
 xhtHanVh738xBeLfdD9Q7EAXeCo5PHYV/lZvzjk7L8GF6sXdh3Z44gC7Mjo1FpHFd7MTHnzHKyawa
 +hB57zwPGhbEZVjjTWWNnng4eQ7XkEVJbvQHwzRGdoleANWYaSuySu+LkP4yCuO2LKTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UOvy5QDHw4J+QsVBbuyW69c6PHHh5T4sf2hsEnVolhY=; b=kcP8No50SmLcYEr6gyGaQBc97P
 0vcBEpRsDfWesVqGNzTucOnk3LmqMq9WIpf2wHgPujkWXTh9HoSCgvE9cTr+5Vq+rHCDBaTso2GnN
 k3d8X37tBE2KjEucI4tsGeIcGFWoxMW+EwHT2KAyDuE6cfJN2e7XOVB08FG5569uRrmg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTGHV-000000006AS-02hB for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:19:18 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHAJAOM030779
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 11:19:10 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHAJAgd030778
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 11:19:10 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 11:19:01 +0100
Message-ID: <20261117101909.30743-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
References: <gerrit.1794839855000.I9c2403c21ef8f21a0fbd998346c8ad719b4b9972@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTGHV-000000006AS-02hB
Subject: [Openvpn-devel] [PATCH v3] buffer: Switch buf_forward_capacity and
 buf_set_write to size_t
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

To make them consistent with buf_forward_capacity_total
and buf_set_read that were already switched.

Review call sites.

Change-Id: I9c2403c21ef8f21a0fbd998346c8ad719b4b9972
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2198
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2198
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index c60936a..c33a987 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -234,17 +234,16 @@
     if (buf_defined(buf))
     {
         char *ptr = (char *)BEND(buf);
-        int cap = buf_forward_capacity(buf);
+        size_t cap = buf_forward_capacity(buf);
 
         if (cap > 1) /* can write more than \0 */
         {
-            int stat;
             va_list arglist;
             va_start(arglist, format);
-            stat = vsnprintf(ptr, cap, format, arglist);
+            int stat = vsnprintf(ptr, cap, format, arglist);
             va_end(arglist);
             buf->len += (int)strnlen(ptr, cap);
-            if (stat >= 0 && stat < cap)
+            if (stat >= 0 && stat < (int)cap)
             {
                 ret = true;
             }
@@ -257,11 +256,11 @@
 buf_puts(struct buffer *buf, const char *str)
 {
     char *ptr = (char *)BEND(buf);
-    int cap = buf_forward_capacity(buf);
+    size_t cap = buf_forward_capacity(buf);
     if (cap > 1) /* can write more than \0 */
     {
-        int str_len = (int)strlcpy(ptr, str, cap);
-        buf->len += (str_len < cap) ? str_len : cap - 1;
+        size_t str_len = strlcpy(ptr, str, cap);
+        buf->len += (str_len < cap) ? (int)str_len : (int)cap - 1;
     }
 }
 
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 541f0bd..32b49d3 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -643,11 +643,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /**
  * Initialise a buffer with an externally provided writable memory region.
  *
@@ -660,7 +655,7 @@
  * @param size  Size of the memory region in bytes.
  */
 static inline void
-buf_set_write(struct buffer *buf, uint8_t *data, int size)
+buf_set_write(struct buffer *buf, uint8_t *data, size_t size)
 {
     if (!buf_size_valid(size))
     {
@@ -668,7 +663,7 @@
     }
     buf->len = 0;
     buf->offset = 0;
-    buf->capacity = size;
+    buf->capacity = (int)size;
     buf->data = data;
     if (size > 0 && data)
     {
@@ -1039,7 +1034,7 @@
  * @return Number of bytes available for appending, or 0 if \c buf is
  *         invalid.
  */
-static inline int
+static inline size_t
 buf_forward_capacity(const struct buffer *buf)
 {
     if (buf_valid(buf))
@@ -1049,7 +1044,7 @@
         {
             ret = 0;
         }
-        return ret;
+        return (size_t)ret;
     }
     else
     {
@@ -1252,6 +1247,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Prepend data to a buffer.
  *
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index db1cb41..8b4cc3b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1825,7 +1825,7 @@
 bool
 generate_ephemeral_key(struct buffer *key, const char *key_name)
 {
-    const int len = BCAP(key);
+    const int len = (int)BCAP(key);
 
     msg(M_INFO, "Using random %s.", key_name);
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0a1d00c..1246bc6 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -523,7 +523,7 @@
     uint8_t *dst_data = buf_write_alloc(dst, data_read_len);
     if (!dst_data)
     {
-        dmsg(D_CRYPT_ERRORS, "%s: dst too small (%i, needs %li)", __func__, BCAP(dst),
+        dmsg(D_CRYPT_ERRORS, "%s: dst too small (%zu, needs %li)", __func__, BCAP(dst),
              data_read_len);
         goto cleanup;
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6f628b8..eb11107 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -805,7 +805,7 @@
 #endif
 
 static bool
-send_push_options(struct context *c, struct buffer *buf, struct push_list *push_list, int safe_cap,
+send_push_options(struct context *c, struct buffer *buf, struct push_list *push_list, size_t safe_cap,
                   bool *push_sent, bool *multi_push)
 {
     struct push_entry *e = push_list->head;
@@ -820,7 +820,7 @@
                 msg(M_WARN, "--push option is too long");
                 return false;
             }
-            if (BLEN(buf) + (int)l >= safe_cap)
+            if (BLENZ(buf) + l >= safe_cap)
             {
                 buf_printf(buf, ",push-continuation 2");
                 {
@@ -835,7 +835,7 @@
                     buf_printf(buf, "%s", push_reply_cmd);
                 }
             }
-            if (BLEN(buf) + (int)l >= safe_cap)
+            if (BLENZ(buf) + l >= safe_cap)
             {
                 msg(M_WARN, "--push option is too long");
                 return false;
@@ -873,8 +873,8 @@
     struct gc_arena gc = gc_new();
     struct buffer buf = alloc_buf_gc(PUSH_BUNDLE_SIZE, &gc);
     bool multi_push = false;
-    const int extra = 84; /* extra space for possible trailing ifconfig and push-continuation */
-    const int safe_cap = BCAP(&buf) - extra;
+    const size_t extra = 84; /* extra space for possible trailing ifconfig and push-continuation */
+    const size_t safe_cap = BCAP(&buf) - extra;
     bool push_sent = false;
 
     buf_printf(&buf, "%s", push_reply_cmd);
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 93e67fd..19a2d48 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1063,7 +1063,6 @@
 key_state_read_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval = 0;
-    int len = 0;
 
     ASSERT(NULL != ks);
     ASSERT(buf);
@@ -1074,9 +1073,7 @@
         return 0;
     }
 
-    len = buf_forward_capacity(buf);
-
-    retval = endless_buf_read(&ks->bio_ctx->out, BPTR(buf), len);
+    retval = endless_buf_read(&ks->bio_ctx->out, BPTR(buf), BCAP(buf));
 
     /* Error during read, check for retry error */
     if (retval < 0)
@@ -1148,7 +1145,6 @@
 key_state_read_plaintext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval = 0;
-    int len = 0;
 
     ASSERT(NULL != ks);
     ASSERT(buf);
@@ -1159,9 +1155,7 @@
         return 0;
     }
 
-    len = buf_forward_capacity(buf);
-
-    retval = mbedtls_ssl_read(ks->ctx, BPTR(buf), len);
+    retval = mbedtls_ssl_read(ks->ctx, BPTR(buf), BCAP(buf));
 
     /* Error during read, check for retry error */
     if (retval < 0)
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index df9e42c..7b15f5f 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -154,7 +154,7 @@
             }
 
             /* Ensure buffer has capacity for cipher name + : + \0 */
-            if (buf_forward_capacity(&new_list) < (int)strlen(ovpn_cipher_name) + 2)
+            if (buf_forward_capacity(&new_list) < strlen(ovpn_cipher_name) + 2)
             {
                 msg(M_WARN, "Length of --data-ciphers is over the "
                             "limit of 127 chars");
@@ -563,8 +563,7 @@
     uint8_t *ncp_ciphers = gc_malloc(ncp_ciphers_len, true, &o->gc);
 
     struct buffer ncp_ciphers_buf;
-    ASSERT(ncp_ciphers_len <= INT_MAX);
-    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, (int)ncp_ciphers_len);
+    buf_set_write(&ncp_ciphers_buf, ncp_ciphers, ncp_ciphers_len);
 
     const char *def = strstr(o->ncp_ciphers, search);
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 57ef9f7..30ef383 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2155,13 +2155,12 @@
          * if the buffer is not empty */
         return 0;
     }
-    int len = buf_forward_capacity(buf);
 
     /*
      * BIO_read brackets most of the serious RSA
      * key negotiation number crunching.
      */
-    int i = BIO_read(bio, BPTR(buf), len);
+    int i = BIO_read(bio, BPTR(buf), (int)BCAP(buf));
 
     VALGRIND_MAKE_READABLE((void *)&i, sizeof(i));
 
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 533619f..0a3fc019 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -215,11 +215,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 #define STATUS_PRINTF_MAXLEN 512
 
 void
@@ -281,7 +276,7 @@
             if (c == -1)
             {
                 ASSERT(buf_init(&so->read_buf, 0));
-                ssize_t len = read(so->fd, BPTR(&so->read_buf), BCAP(&so->read_buf));
+                ssize_t len = read(so->fd, BPTR(&so->read_buf), (unsigned int)BCAP(&so->read_buf));
                 if (len <= 0)
                 {
                     break;
@@ -311,7 +306,3 @@
 
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d7f69f7..5617ad3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -380,8 +380,8 @@
         msg(M_WARN, "ERROR: could not write tag");
         return false;
     }
-    const int data_len = BLEN(src_metadata) + sizeof(src_key->keys) + sizeof(uint16_t);
-    const int tagged_len = data_len + TLS_CRYPT_TAG_SIZE;
+    const size_t data_len = BLENZ(src_metadata) + sizeof(src_key->keys) + sizeof(uint16_t);
+    const size_t tagged_len = data_len + TLS_CRYPT_TAG_SIZE;
     const uint16_t net_len = htons((uint16_t)tagged_len);
     hmac_ctx_t *hmac_ctx = server_key->hmac;
     hmac_ctx_reset(hmac_ctx);
@@ -396,7 +396,7 @@
     ASSERT(cipher_ctx_reset(cipher_ctx, tag));
 
     /* Overflow check (OpenSSL requires an extra block in the dst buffer) */
-    const int padded_len = data_len + cipher_ctx_block_size(cipher_ctx);
+    const size_t padded_len = data_len + cipher_ctx_block_size(cipher_ctx);
     if (buf_forward_capacity(&work) < padded_len)
     {
         msg(M_WARN, "ERROR: could not crypt: insufficient space in dst");
@@ -735,7 +735,7 @@
         size_t b64_length = strlen(b64_metadata);
         metadata = alloc_buf_gc(OPENVPN_BASE64_DECODED_LENGTH(b64_length) + 1, &gc);
         ASSERT(buf_write(&metadata, &TLS_CRYPT_METADATA_TYPE_USER, 1));
-        int decoded_len = openvpn_base64_decode(b64_metadata, BEND(&metadata), BCAP(&metadata));
+        int decoded_len = openvpn_base64_decode(b64_metadata, BEND(&metadata), (int)BCAP(&metadata));
         if (decoded_len < 0)
         {
             msg(M_FATAL, "ERROR: failed to base64 decode provided metadata");
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0ba8a4a..c56ace3 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4008,7 +4008,7 @@
  * registry for the TAP device # = device_number.
  */
 static const char *
-get_unspecified_device_guid(const int device_number, uint8_t *actual_name, int actual_name_size,
+get_unspecified_device_guid(const int device_number, uint8_t *actual_name, size_t actual_name_size,
                             const struct tap_reg *tap_reg_src,
                             const struct panel_reg *panel_reg_src,
                             enum tun_driver_type *windows_driver, struct gc_arena *gc)
@@ -4071,7 +4071,7 @@
  * returning the GUID and optional actual_name and device type
  */
 static const char *
-get_device_guid(const char *name, uint8_t *actual_name, int actual_name_size,
+get_device_guid(const char *name, uint8_t *actual_name, size_t actual_name_size,
                 enum tun_driver_type *windows_driver, const struct tap_reg *tap_reg,
                 const struct panel_reg *panel_reg, struct gc_arena *gc)
 {
@@ -6087,8 +6087,9 @@
     {
         struct buffer out = alloc_buf_gc(256, gc);
         DWORD len;
-        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&out), BCAP(&out), BSTR(&out),
-                            BCAP(&out), &len, NULL))
+        if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_INFO, BSTR(&out),
+                            (DWORD)BCAP(&out), BSTR(&out),
+                            (DWORD)BCAP(&out), &len, NULL))
         {
             return BSTR(&out);
         }
@@ -6103,8 +6104,8 @@
     {
         struct buffer out = alloc_buf(1024);
         DWORD len;
-        while (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), BCAP(&out),
-                               BSTR(&out), BCAP(&out), &len, NULL))
+        while (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_LOG_LINE, BSTR(&out), (DWORD)BCAP(&out),
+                               BSTR(&out), (DWORD)BCAP(&out), &len, NULL))
         {
             msg(D_TAP_WIN_DEBUG, "TAP-Windows: %s", BSTR(&out));
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
