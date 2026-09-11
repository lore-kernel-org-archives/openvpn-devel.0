Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E744C88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8K1xe5afFf+JYMoA42li7+a7ZVTYeovI3LRFk2a9/9o=; b=Z67hbMxluF1Zgub/QkQNrFAV0/
	n1X5Qtz4shiH3oHF7oeR/M1juHPrYR8ay2oIvUiai9tEr0DN2Kd9EZ/dW3WltTjksLBDdIh2e6xHU
	mGFh0IZfsa4TvLQQZrUxcmMk0PTJI8KQc3AD3etfdR9fsRrsEVnOfCFirUCIFbLndUTo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x587f-0007Bx-Ji;
	Fri, 11 Sep 2026 20:45:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x587e-0007Bq-6l
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 20:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rH3ebRhdqj3gb1EU/w/oixtIVMszJNjE2o+Z+tgGM9M=; b=bdgUA2J5DHuc942/6XO6JiUTng
 a2iI+qhRUMHDZxvgXh6b+fUqFamIpAP47wKc7UxddU7qwN95RCfL5Sv0MRgou61VyizTbkZevkZ6u
 oIlOltrg8M0dFmraMCc2oNQZWMUMnxDD/n+KarGqB2ODeyn2vx9+hHMlFFPofQMzVoxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rH3ebRhdqj3gb1EU/w/oixtIVMszJNjE2o+Z+tgGM9M=; b=XmcWlrhlm93SL6fJ58MyVYWCTN
 dR/FMCuSgRjtitZClm5RjzA7YJKd7VxOgk4GcVyuQrLddFqOBJCqzUnhmflzYYJ5Px3QenjkiERI9
 YP+WOlMqWvgLWbCKbWQx0eHYdS/jakaK2XxBdr1h6do/VRQx4qTf9p3Tjj/HluAmETeY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x587c-0003iG-Px for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 20:45:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68BKjD2D015710
 for <openvpn-devel@lists.sourceforge.net>; Fri, 11 Sep 2026 22:45:13 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68BKjDfq015709
 for openvpn-devel@lists.sourceforge.net; Fri, 11 Sep 2026 22:45:13 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 11 Sep 2026 22:45:07 +0200
Message-ID: <20260911204513.15692-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x587c-0003iG-Px
Subject: [Openvpn-devel] [PATCH v4] buffer: When extracting pointers from
 buffer, retain const
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Currently you can use BPTR and similar to implicitly remove
const. That avoids some warnings that we should get and
confuses tools like cppcheck into giving wrong suggestions.

So make sure that by default we only return a non-const
pointer if the buffer pointer is not const. Change all call
sites that threw warnings.

Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1904
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1904
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 5d00415..21e113d 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -109,7 +109,7 @@
 #endif
     ret.data = (uint8_t *)malloc(buf->capacity);
     check_malloc_return(ret.data);
-    memcpy(BPTR(&ret), BPTR(buf), BLENZ(buf));
+    memcpy(BPTR(&ret), CBPTR(buf), BLENZ(buf));
     return ret;
 }
 
@@ -162,7 +162,7 @@
     {
         return false;
     }
-    return buf_write(dest, BPTR(src), BLENZ(src));
+    return buf_write(dest, CBPTR(src), BLENZ(src));
 }
 
 void
@@ -293,7 +293,7 @@
         return false;
     }
 
-    const ssize_t size = write(fd, BPTR(buf), (unsigned int)BLEN(buf));
+    const ssize_t size = write(fd, CBPTR(buf), (unsigned int)BLEN(buf));
     if (size != BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -732,7 +732,7 @@
     {
         return false;
     }
-    return memcmp(BPTR(src), match, size) == 0;
+    return memcmp(CBPTR(src), match, size) == 0;
 }
 
 bool
@@ -1035,13 +1035,13 @@
 }
 
 bool
-string_check_buf(struct buffer *buf, const unsigned int inclusive, const unsigned int exclusive)
+string_check_buf(const struct buffer *buf, const unsigned int inclusive, const unsigned int exclusive)
 {
     ASSERT(buf);
 
     for (int i = 0; i < BLEN(buf); i++)
     {
-        char c = BSTR(buf)[i];
+        char c = CBSTR(buf)[i];
 
         if (!char_inc_exc(c, inclusive, exclusive))
         {
@@ -1135,7 +1135,7 @@
     if (buf && buf->len)
     {
         msglvl_t msglevel = D_ALIGN_DEBUG;
-        const uintptr_t u = (uintptr_t)BPTR(buf);
+        const uintptr_t u = (uintptr_t)CBPTR(buf);
 
         if (u & (PAYLOAD_ALIGN - 1))
         {
@@ -1393,16 +1393,16 @@
         return NULL;
     }
 
-    const uint8_t *seppos = memchr(BPTR(buf), sep, buf_len(buf));
+    const uint8_t *seppos = memchr(CBPTR(buf), sep, buf_len(buf));
     if (!seppos)
     {
         return NULL;
     }
-    size_t field_len = seppos - BPTR(buf);
+    size_t field_len = seppos - CBPTR(buf);
 
     char *field = gc_malloc(field_len + 1, false, gc);
 
-    memcpy(field, BPTR(buf), field_len);
+    memcpy(field, CBPTR(buf), field_len);
     field[field_len] = 0;
 
     buf_advance(buf, field_len + 1);
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 0a02e94..22a8b74 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -136,21 +136,29 @@
 
 
 /** Return a pointer to the start of the buffer content. @see buf_bptr() */
-#define BPTR(buf)  (buf_bptr(buf))
+#define BPTR(buf)   (buf_bptr(buf))
+/** Return a const pointer to the start of the buffer content. @see buf_cbptr() */
+#define CBPTR(buf)  (buf_cbptr(buf))
 /** Return a pointer one past the end of the buffer content. @see buf_bend() */
-#define BEND(buf)  (buf_bend(buf))
+#define BEND(buf)   (buf_bend(buf))
+/** Return a const pointer one past the end of the buffer content. @see buf_cbend() */
+#define CBEND(buf)  (buf_cbend(buf))
 /** Return a pointer to the last byte of the buffer content, or NULL if empty. @see buf_blast() */
-#define BLAST(buf) (buf_blast(buf))
+#define BLAST(buf)  (buf_blast(buf))
+/** Return a const pointer to the last byte of the buffer content, or NULL if empty. @see buf_cblast() */
+#define CBLAST(buf) (buf_cblast(buf))
 /** Return the length of the buffer content in bytes. @see buf_len() */
-#define BLEN(buf)  (buf_len(buf))
+#define BLEN(buf)   (buf_len(buf))
 /** Return the length of the buffer content as a \c size_t. @see buf_len() */
-#define BLENZ(buf) ((size_t)buf_len(buf))
+#define BLENZ(buf)  ((size_t)buf_len(buf))
 /** Return true iff the buffer is defined (has non-NULL data pointer). @see buf_defined() */
-#define BDEF(buf)  (buf_defined(buf))
+#define BDEF(buf)   (buf_defined(buf))
 /** Return the buffer content pointer cast to \c char *. @see buf_str() */
-#define BSTR(buf)  (buf_str(buf))
+#define BSTR(buf)   (buf_str(buf))
+/** Return the buffer content pointer cast to \c const char *. @see buf_cstr() */
+#define CBSTR(buf)  (buf_cstr(buf))
 /** Return the number of bytes available for appending to the buffer. @see buf_forward_capacity() */
-#define BCAP(buf)  (buf_forward_capacity(buf))
+#define BCAP(buf)   (buf_forward_capacity(buf))
 
 /**
  * Zeroise and reset a buffer.
@@ -407,15 +415,15 @@
 }
 
 /**
- * Return a pointer to the start of the buffer content.
+ * Return a const pointer to the start of the buffer content.
  *
  * @param buf   The buffer to query.
  *
  * @return Pointer to \c buf->data + \c buf->offset, or NULL if \c buf is
  *         not valid.
  */
-static inline uint8_t *
-buf_bptr(const struct buffer *buf)
+static inline const uint8_t *
+buf_cbptr(const struct buffer *buf)
 {
     if (buf_valid(buf))
     {
@@ -428,6 +436,20 @@
 }
 
 /**
+ * Return a pointer to the start of the buffer content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Pointer to \c buf->data + \c buf->offset, or NULL if \c buf is
+ *         not valid.
+ */
+static inline uint8_t *
+buf_bptr(struct buffer *buf)
+{
+    return (uint8_t *)buf_cbptr(buf);
+}
+
+/**
  * Return the length of the buffer content.
  *
  * @param buf   The buffer to query.
@@ -455,12 +477,46 @@
  * @return Pointer to the byte immediately after the last content byte.
  */
 static inline uint8_t *
-buf_bend(const struct buffer *buf)
+buf_bend(struct buffer *buf)
 {
     return buf_bptr(buf) + buf_len(buf);
 }
 
 /**
+ * Return a const pointer one past the end of the buffer content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Pointer to the byte immediately after the last content byte.
+ */
+static inline const uint8_t *
+buf_cbend(const struct buffer *buf)
+{
+    return buf_cbptr(buf) + buf_len(buf);
+}
+
+/**
+ * Return a const pointer to the last byte of the buffer content.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return Pointer to the last byte, or NULL if the buffer is empty or
+ *         invalid.
+ */
+static inline const uint8_t *
+buf_cblast(const struct buffer *buf)
+{
+    if (buf_len(buf) > 0)
+    {
+        return buf_cbptr(buf) + buf_len(buf) - 1;
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
+/**
  * Return a pointer to the last byte of the buffer content.
  *
  * @param buf   The buffer to query.
@@ -469,16 +525,9 @@
  *         invalid.
  */
 static inline uint8_t *
-buf_blast(const struct buffer *buf)
+buf_blast(struct buffer *buf)
 {
-    if (buf_len(buf) > 0)
-    {
-        return buf_bptr(buf) + buf_len(buf) - 1;
-    }
-    else
-    {
-        return NULL;
-    }
+    return (uint8_t *)buf_cblast(buf);
 }
 
 /**
@@ -518,12 +567,25 @@
  * @return The content pointer as a \c char *, or NULL if \c buf is invalid.
  */
 static inline char *
-buf_str(const struct buffer *buf)
+buf_str(struct buffer *buf)
 {
     return (char *)buf_bptr(buf);
 }
 
 /**
+ * Return the buffer content pointer cast to \c const char *.
+ *
+ * @param buf   The buffer to query.
+ *
+ * @return The content pointer as a \c const char *, or NULL if \c buf is invalid.
+ */
+static inline const char *
+buf_cstr(const struct buffer *buf)
+{
+    return (const char *)buf_cbptr(buf);
+}
+
+/**
  * Reset a buffer to an undefined (unallocated) state.
  *
  * Sets all fields to zero/NULL without freeing any memory.  Use \c free_buf()
@@ -1300,7 +1362,7 @@
 static inline bool
 buf_copy(struct buffer *dest, const struct buffer *src)
 {
-    return buf_write(dest, BPTR(src), BLENZ(src));
+    return buf_write(dest, CBPTR(src), BLENZ(src));
 }
 
 /**
@@ -1427,14 +1489,14 @@
  *         is empty.
  */
 static inline int
-buf_peek_u8(struct buffer *buf)
+buf_peek_u8(const struct buffer *buf)
 {
     int ret;
     if (BLEN(buf) < 1)
     {
         return -1;
     }
-    ret = *BPTR(buf);
+    ret = *CBPTR(buf);
     return ret;
 }
 
@@ -1547,7 +1609,7 @@
 static inline bool
 buf_equal(const struct buffer *a, const struct buffer *b)
 {
-    return BLEN(a) == BLEN(b) && 0 == memcmp(BPTR(a), BPTR(b), BLENZ(a));
+    return BLEN(a) == BLEN(b) && 0 == memcmp(CBPTR(a), CBPTR(b), BLENZ(a));
 }
 
 /**
@@ -1561,7 +1623,7 @@
     {
         return false;
     }
-    return memcmp(BPTR(src), match, size) == 0;
+    return memcmp(CBPTR(src), match, size) == 0;
 }
 
 /**
@@ -1575,7 +1637,7 @@
     {
         return false;
     }
-    return memcmp(BPTR(src), match, size) == 0;
+    return memcmp(CBPTR(src), match, size) == 0;
 }
 
 /**
@@ -1720,7 +1782,7 @@
  * @param exclusive Character classes that are not allowed even if they are also in inclusive.
  * @return True if the string consists only of allowed characters, false otherwise.
  */
-bool string_check_buf(struct buffer *buf, const unsigned int inclusive,
+bool string_check_buf(const struct buffer *buf, const unsigned int inclusive,
                       const unsigned int exclusive);
 
 /**
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 17085d6..7ef6ac4 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -445,7 +445,7 @@
  *
  * @return              \c 0 on failure, \c 1 on success.
  */
-int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len);
+int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len);
 
 /**
  * Pads the final cipher block using PKCS padding, and output to the destination
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 6662def..0c5beb4 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -512,7 +512,7 @@
 }
 
 int
-cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)
+cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len)
 {
     if (src_len < 0)
     {
@@ -1093,7 +1093,7 @@
 
     size_t out_len = 0;
     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        != mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out_len))
+        != mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), NULL, 0, &out_len))
     {
         return false;
     }
@@ -1101,7 +1101,7 @@
     /* We set the size buf to out_len-1 to NOT include the 0 byte that
      * mbedtls_pem_write_buffer in its length calculation */
     *dst = alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
                                           BCAP(dst), &out_len))
         || !(out_len < INT_MAX && out_len > 1)
         || !buf_inc_len(dst, (int)out_len - 1))
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index 9e47c26..bbd012f6 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -249,7 +249,7 @@
 
     size_t out_len = 0;
     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        != mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out_len))
+        != mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), NULL, 0, &out_len))
     {
         return false;
     }
@@ -257,7 +257,7 @@
     /* We set the size buf to out_len-1 to NOT include the 0 byte that
      * mbedtls_pem_write_buffer in its length calculation */
     *dst = alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
                                           BCAP(dst), &out_len))
         || !buf_inc_len(dst, out_len - 1))
     {
@@ -684,7 +684,7 @@
 }
 
 int
-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,
+cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src,
                   int src_len)
 {
     size_t s_dst_len = *dst_len;
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 2019280..29c5fa6 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -465,7 +465,7 @@
 {
     bool ret = false;
     BIO *bio = BIO_new(BIO_s_mem());
-    if (!bio || !PEM_write_bio(bio, name, "", BPTR(src), BLEN(src)))
+    if (!bio || !PEM_write_bio(bio, name, "", CBPTR(src), BLEN(src)))
     {
         ret = false;
         goto cleanup;
@@ -492,7 +492,7 @@
 {
     bool ret = false;
 
-    BIO *bio = BIO_new_mem_buf((char *)BPTR(src), BLEN(src));
+    BIO *bio = BIO_new_mem_buf(CBPTR(src), BLEN(src));
     if (!bio)
     {
         crypto_msg(M_FATAL, "Cannot open memory BIO for PEM decode");
@@ -941,7 +941,7 @@
 }
 
 int
-cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)
+cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len)
 {
     if (!EVP_CipherUpdate(ctx, dst, dst_len, src, src_len))
     {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2ade321..ad43d40 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -271,7 +271,7 @@
     }
     else
     {
-        msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR(buf));
+        msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", CBSTR(buf));
     }
 }
 
@@ -1646,7 +1646,7 @@
             return;
         }
 
-        const struct openvpn_ethhdr *orig_ethhdr = (struct openvpn_ethhdr *)BPTR(buf);
+        const struct openvpn_ethhdr *orig_ethhdr = (const struct openvpn_ethhdr *)CBPTR(buf);
 
         /* Copy frametype and reverse source/destination for the response */
         struct openvpn_ethhdr ethhdr;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 310d2e1..c301687 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2278,7 +2278,7 @@
 
 #ifdef TARGET_ANDROID
 static ssize_t
-man_send_with_fd(int fd, void *ptr, size_t nbytes, int flags, int sendfd)
+man_send_with_fd(int fd, const void *ptr, size_t nbytes, int flags, int sendfd)
 {
     struct msghdr msg = { 0 };
     struct iovec iov[1];
@@ -2302,12 +2302,14 @@
     msg.msg_name = NULL;
     msg.msg_namelen = 0;
 
-    iov[0].iov_base = ptr;
+    /* sendmsg takes a const msghdr, but we can't construct that here
+       directly, so cast */
+    iov[0].iov_base = (void *)ptr;
     iov[0].iov_len = nbytes;
     msg.msg_iov = iov;
     msg.msg_iovlen = 1;
 
-    return (sendmsg(fd, &msg, flags));
+    return sendmsg(fd, &msg, flags);
 }
 
 static ssize_t
@@ -2512,24 +2514,23 @@
 {
     const int size_hint = 1024;
     ssize_t sent = 0;
-    const struct buffer *buf;
 
     buffer_list_aggregate(man->connection.out, size_hint);
-    buf = buffer_list_peek(man->connection.out);
+    const struct buffer *buf = buffer_list_peek(man->connection.out);
     if (buf && BLEN(buf))
     {
         const int len = min_int(size_hint, BLEN(buf));
 #ifdef TARGET_ANDROID
         if (man->connection.fdtosend > 0)
         {
-            sent = man_send_with_fd(man->connection.sd_cli, BPTR(buf), len, MSG_NOSIGNAL,
+            sent = man_send_with_fd(man->connection.sd_cli, CBPTR(buf), len, MSG_NOSIGNAL,
                                     man->connection.fdtosend);
             man->connection.fdtosend = -1;
         }
         else
 #endif
         {
-            sent = send(man->connection.sd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);
+            sent = send(man->connection.sd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
         if (sent >= 0)
         {
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index edf8239..39fa482 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -150,12 +150,12 @@
     unsigned int ret = 0;
     if (BLEN(buf) >= 1)
     {
-        switch (OPENVPN_IPH_GET_VER(*BPTR(buf)))
+        switch (OPENVPN_IPH_GET_VER(*CBPTR(buf)))
         {
             case 4:
                 if (BLENZ(buf) >= sizeof(struct openvpn_iphdr))
                 {
-                    const struct openvpn_iphdr *ip = (const struct openvpn_iphdr *)BPTR(buf);
+                    const struct openvpn_iphdr *ip = (const struct openvpn_iphdr *)CBPTR(buf);
 
                     mroute_get_in_addr_t(src, ip->saddr);
                     mroute_get_in_addr_t(dest, ip->daddr);
@@ -179,7 +179,7 @@
             case 6:
                 if (BLENZ(buf) >= sizeof(struct openvpn_ipv6hdr))
                 {
-                    const struct openvpn_ipv6hdr *ipv6 = (const struct openvpn_ipv6hdr *)BPTR(buf);
+                    const struct openvpn_ipv6hdr *ipv6 = (const struct openvpn_ipv6hdr *)CBPTR(buf);
 #if 0 /* very basic debug */
                     struct gc_arena gc = gc_new();
                     msg( M_INFO, "IPv6 packet! src=%s, dst=%s",
@@ -202,7 +202,7 @@
 
             default:
                 msg(M_WARN, "IP packet with unknown IP version=%d seen",
-                    OPENVPN_IPH_GET_VER(*BPTR(buf)));
+                    OPENVPN_IPH_GET_VER(*CBPTR(buf)));
         }
     }
     return ret;
@@ -226,7 +226,7 @@
     unsigned int ret = 0;
     if (BLEN(buf) >= (int)sizeof(struct openvpn_ethhdr))
     {
-        const struct openvpn_ethhdr *eth = (const struct openvpn_ethhdr *)BPTR(buf);
+        const struct openvpn_ethhdr *eth = (const struct openvpn_ethhdr *)CBPTR(buf);
         if (src)
         {
             mroute_copy_ether_to_addr(src, eth->source, vid);
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 3570582..9bb0866 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -258,7 +258,7 @@
         *ip_hdr_offset = 0;
         if (likely(BLEN(buf) >= (int)sizeof(struct openvpn_iphdr)))
         {
-            ip_ver = OPENVPN_IPH_GET_VER(*BPTR(buf));
+            ip_ver = OPENVPN_IPH_GET_VER(*CBPTR(buf));
         }
     }
     else if (tunnel_type == DEV_TYPE_TAP)
@@ -267,7 +267,7 @@
         /* for tap get ip version from eth header */
         if (likely(BLEN(buf) >= *ip_hdr_offset))
         {
-            const struct openvpn_ethhdr *eh = (const struct openvpn_ethhdr *)BPTR(buf);
+            const struct openvpn_ethhdr *eh = (const struct openvpn_ethhdr *)CBPTR(buf);
             uint16_t proto = ntohs(eh->proto);
             if (proto == OPENVPN_ETH_P_IPV6)
             {
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index be91a99..08c2673 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -208,7 +208,9 @@
 
         if (head)
         {
-            iov[1].iov_base = BPTR(head);
+            /* sendmsg takes a const msghdr, but we can't construct that here
+               directly, so cast */
+            iov[1].iov_base = (char *)CBPTR(head);
             iov[1].iov_len = BLENZ(head);
             mesg.msg_iovlen = 2;
         }
@@ -964,7 +966,7 @@
 bool
 is_openvpn_protocol(const struct buffer *buf)
 {
-    const unsigned char *p = (const unsigned char *)BSTR(buf);
+    const unsigned char *p = (const unsigned char *)CBSTR(buf);
     const int len = BLEN(buf);
     if (len >= 3)
     {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index da2bb9f..761a59e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -47,7 +47,7 @@
 void
 receive_auth_failed(struct context *c, const struct buffer *buffer)
 {
-    msg(M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
+    msg(M_VERB0, "AUTH: Received control message: %s", CBSTR(buffer));
     c->options.no_advance = true;
 
     if (!c->options.pull)
@@ -64,7 +64,7 @@
     const char *reason = NULL;
     if (authfail_extended && BLEN(&buf))
     {
-        reason = BSTR(&buf);
+        reason = CBSTR(&buf);
     }
 
     if (authfail_extended && buf_string_match_head_str(&buf, "TEMP"))
@@ -116,7 +116,7 @@
      */
     if (authfail_extended && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
     {
-        ssl_put_auth_challenge(BSTR(&buf));
+        ssl_put_auth_challenge(CBSTR(&buf));
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
@@ -508,7 +508,7 @@
     uint64_t option_types_found = 0;
 
     msg(D_PUSH, "PUSH: Received control message: '%s'",
-        sanitize_control_message(BSTR(buffer), &gc));
+        sanitize_control_message(CBSTR(buffer), &gc));
 
     int status = process_incoming_push_msg(c, buffer, c->options.pull, pull_permission_mask(c),
                                            &option_types_found);
@@ -516,7 +516,7 @@
     if (status == PUSH_MSG_ERROR)
     {
         msg(D_PUSH_ERRORS, "WARNING: Received bad push/pull message: %s",
-            sanitize_control_message(BSTR(buffer), &gc));
+            sanitize_control_message(CBSTR(buffer), &gc));
     }
     else if (status == PUSH_MSG_REPLY || status == PUSH_MSG_UPDATE
              || status == PUSH_MSG_CONTINUATION)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7c6217a..7f39268 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2446,7 +2446,9 @@
     struct cmsghdr *cmsg;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
 
-    iov.iov_base = BPTR(buf);
+    /* sendmsg takes a const msghdr, but we can't construct that here
+       directly, so cast */
+    iov.iov_base = (char *)CBPTR(buf);
     iov.iov_len = BLENZ(buf);
     mesg.msg_iov = &iov;
     mesg.msg_iovlen = 1;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 89465bc..c6a29f4 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -709,14 +709,14 @@
     }
     else
 #endif
-        return sendto(sock->sd, BPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&to->dest.addr.sa,
+        return sendto(sock->sd, CBPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&to->dest.addr.sa,
                       (socklen_t)af_addr_size(to->dest.addr.sa.sa_family));
 }
 
 static inline ssize_t
 link_socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)
 {
-    return send(sock->sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
+    return send(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
 
 #endif /* ifdef _WIN32 */
@@ -761,7 +761,7 @@
 {
     if (sock && ipbuf)
     {
-        const struct openvpn_iphdr *iph = (struct openvpn_iphdr *)BPTR(ipbuf);
+        const struct openvpn_iphdr *iph = (const struct openvpn_iphdr *)CBPTR(ipbuf);
         sock->ptos = iph->tos;
         sock->ptos_defined = true;
     }
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 6a6d9f9..90b2aec 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -305,7 +305,7 @@
     }
 
     /* get opcode and key ID */
-    uint8_t pkt_firstbyte = *BPTR(buf);
+    uint8_t pkt_firstbyte = *CBPTR(buf);
     int op = pkt_firstbyte >> P_OPCODE_SHIFT;
     int key_id = pkt_firstbyte & P_KEY_ID_MASK;
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 063fa5d..3653eb4 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -207,7 +207,7 @@
 
         struct cert_hash *ch = session->cert_hash_set->ch[error_depth];
         ASSERT(sizeof(ch->sha256_hash) == BLEN(cert_hash));
-        memcpy(ch->sha256_hash, BPTR(cert_hash), sizeof(ch->sha256_hash));
+        memcpy(ch->sha256_hash, CBPTR(cert_hash), sizeof(ch->sha256_hash));
     }
 }
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 47f5ac5..23c7975 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -148,7 +148,7 @@
 
     gc_init(&gc);
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM: %s", format_hex(CBPTR(src), BLEN(src), 80, &gc));
 
     /* Get packet ID */
     if (!packet_id_write(&opt->packet_id.send, dst, true, false))
@@ -157,7 +157,7 @@
         goto err;
     }
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", format_hex(BPTR(dst), BLEN(dst), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", format_hex(CBPTR(dst), BLEN(dst), 0, &gc));
 
     /* Buffer overflow check */
     if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))
@@ -173,8 +173,8 @@
     {
         uint8_t *tag = NULL;
         hmac_ctx_reset(ctx->hmac);
-        hmac_ctx_update(ctx->hmac, BPTR(dst), BLEN(dst));
-        hmac_ctx_update(ctx->hmac, BPTR(src), BLEN(src));
+        hmac_ctx_update(ctx->hmac, CBPTR(dst), BLEN(dst));
+        hmac_ctx_update(ctx->hmac, CBPTR(src), BLEN(src));
 
         ASSERT(tag = buf_write_alloc(dst, TLS_CRYPT_TAG_SIZE));
         hmac_ctx_final(ctx->hmac, tag);
@@ -189,7 +189,7 @@
     /* Encrypt src */
     {
         int outlen = 0;
-        ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &outlen, BPTR(src), BLEN(src)));
+        ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &outlen, CBPTR(src), BLEN(src)));
         ASSERT(buf_inc_len(dst, outlen));
         ASSERT(cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen));
         ASSERT(buf_inc_len(dst, outlen));
@@ -220,7 +220,7 @@
     ASSERT(ctx->cipher);
     ASSERT(packet_id_initialized(&opt->packet_id) || (opt->flags & CO_IGNORE_PACKET_ID));
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(CBPTR(src), BLEN(src), 80, &gc));
 
     if (BLENZ(src) < TLS_CRYPT_OFF_CT)
     {
@@ -237,11 +237,11 @@
             CRYPT_ERROR("potential buffer overflow");
         }
 
-        if (!cipher_ctx_reset(ctx->cipher, BPTR(src) + TLS_CRYPT_OFF_TAG))
+        if (!cipher_ctx_reset(ctx->cipher, CBPTR(src) + TLS_CRYPT_OFF_TAG))
         {
             CRYPT_ERROR("cipher reset failed");
         }
-        if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen, BPTR(src) + TLS_CRYPT_OFF_CT,
+        if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen, CBPTR(src) + TLS_CRYPT_OFF_CT,
                                BLEN(src) - (int)TLS_CRYPT_OFF_CT))
         {
             CRYPT_ERROR("cipher update failed");
@@ -256,17 +256,17 @@
 
     /* Check authentication */
     {
-        const uint8_t *tag = BPTR(src) + TLS_CRYPT_OFF_TAG;
+        const uint8_t *tag = CBPTR(src) + TLS_CRYPT_OFF_TAG;
         uint8_t tag_check[TLS_CRYPT_TAG_SIZE] = { 0 };
 
         dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP AD: %s",
-             format_hex(BPTR(src), TLS_CRYPT_OFF_TAG, 0, &gc));
+             format_hex(CBPTR(src), TLS_CRYPT_OFF_TAG, 0, &gc));
         dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP TO: %s",
-             format_hex(BPTR(dst), BLEN(dst), 80, &gc));
+             format_hex(CBPTR(dst), BLEN(dst), 80, &gc));
 
         hmac_ctx_reset(ctx->hmac);
-        hmac_ctx_update(ctx->hmac, BPTR(src), TLS_CRYPT_OFF_TAG);
-        hmac_ctx_update(ctx->hmac, BPTR(dst), BLEN(dst));
+        hmac_ctx_update(ctx->hmac, CBPTR(src), TLS_CRYPT_OFF_TAG);
+        hmac_ctx_update(ctx->hmac, CBPTR(dst), BLEN(dst));
         hmac_ctx_final(ctx->hmac, tag_check);
 
         if (memcmp_constant_time(tag, tag_check, sizeof(tag_check)))
@@ -384,7 +384,7 @@
     hmac_ctx_reset(hmac_ctx);
     hmac_ctx_update(hmac_ctx, (void *)&net_len, sizeof(net_len));
     hmac_ctx_update(hmac_ctx, (void *)src_key->keys, sizeof(src_key->keys));
-    hmac_ctx_update(hmac_ctx, BPTR(src_metadata), BLEN(src_metadata));
+    hmac_ctx_update(hmac_ctx, CBPTR(src_metadata), BLEN(src_metadata));
     hmac_ctx_final(hmac_ctx, tag);
 
     dmsg(D_CRYPTO_DEBUG, "TLS-CRYPT WRAP TAG: %s", format_hex(tag, TLS_CRYPT_TAG_SIZE, 0, gc));
@@ -405,7 +405,7 @@
     ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen, (void *)src_key->keys,
                              sizeof(src_key->keys)));
     ASSERT(buf_inc_len(&work, outlen));
-    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen, BPTR(src_metadata),
+    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen, CBPTR(src_metadata),
                              BLEN(src_metadata)));
     ASSERT(buf_inc_len(&work, outlen));
     ASSERT(cipher_ctx_final(cipher_ctx, BEND(&work), &outlen));
@@ -529,7 +529,7 @@
         return false;
     }
 
-    const uint8_t *metadata = buf_bptr(tls_crypt_v2_metadata);
+    const uint8_t *metadata = CBPTR(tls_crypt_v2_metadata);
     if (*metadata != TLS_CRYPT_METADATA_TYPE_TIMESTAMP)
     {
         msg(M_WARN, "ERROR: Client key does not have a timestamp.");
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 931e54d..2477560 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -504,7 +504,7 @@
 static inline bool
 is_ip_packet_valid(const struct buffer *buf)
 {
-    const struct openvpn_iphdr *ih = (const struct openvpn_iphdr *)BPTR(buf);
+    const struct openvpn_iphdr *ih = (const struct openvpn_iphdr *)CBPTR(buf);
 
     if (OPENVPN_IPH_GET_VER(ih->version_len) == 4)
     {
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index bffc60e..69ac10d 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -269,7 +269,7 @@
         return false;
     }
 
-    vlanhdr = (const struct openvpn_8021qhdr *)BPTR(buf);
+    vlanhdr = (const struct openvpn_8021qhdr *)CBPTR(buf);
 
     if (ntohs(vlanhdr->tpid) != OPENVPN_ETH_P_8021Q)
     {
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 7fb9162..7bd0c45 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -51,7 +51,7 @@
 
 #define assert_buf_equals_str(buf, str)        \
     assert_int_equal(BLENZ(buf), strlen(str)); \
-    assert_memory_equal(BPTR(buf), str, BLENZ(buf));
+    assert_memory_equal(CBPTR(buf), str, BLENZ(buf));
 
 static void
 test_buffer_printf_catrunc(void **state)
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index db03437..f648e13 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -130,7 +130,7 @@
 bool
 __wrap_buffer_write_file(const char *filename, const struct buffer *buf)
 {
-    const char *pem = BSTR(buf);
+    const char *pem = CBSTR(buf);
     check_expected_ptr(filename);
     check_expected_ptr(pem);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
