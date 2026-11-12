Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AB606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aNwX8hQh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iz8eKIsw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FlRjRHX7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pIXEXVRDfJ9i5lvSxBlah43Tz1ZkobeyA2CBw/dptjA=; b=aNwX8hQhLOYx+7
	AyCd/MLEigB/1h4LKIm2X76NX3KUAwEqQZ3EA83Wb3ldx8UYHqjehJF7ukoQiD0K/R5XiG7MNANqN
	lyNBvWWmEYa6hycS2WAWCbY2MtMaWU2gs6RobunhxA5XfEweDHC73rLTIQpz5CKUkkxevKNLScENq
	TCo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYp9-0000000048c-1RRV;
	Thu, 12 Nov 2026 17:42:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRYoy-00000000483-1eKi for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=66HJhCtZReihk1QlbaWiPz43DuGjm0L2/b8NVGZtnTg=; b=iz8eKIswbo4c4BiLedcbhRL0OQ
 azy4ewXNuD5qJ2UY1g4o/sLZ22bh6PX+Gw/ME+HJBo+a/vlIN2oXChw8q31Zi1nQsc23gz2Li31Rj
 pCc+N9ZHqDwxsq5m9TsB+W29Aa/t5z5Ox7ri1kH+Pv83rtTLWFUTZAUJmrxle4TDu9Ek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=66HJhCtZReihk1QlbaWiPz43DuGjm0L2/b8NVGZtnTg=; b=FlRjRHX7HxaMmYmZiBZ+GWy8Up
 PC/pUlNlEZ1OiG/i0rvKZyOBQVlj7ElIbrcbx82VxfU9t0JNY1XundWMcJU9EAeCBvpbAgVjHYpjk
 xJnD5f+8BC/zrb/QN3iWaHQzfCx8Ti11cuPR/827pGDdWUaCmRl6ZkCnjj6cNPteuZ1Y=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRYoW-000000003ny-2Xbv for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:42:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ACHgEbT023848
 for <openvpn-devel@lists.sourceforge.net>; Thu, 12 Nov 2026 18:42:14 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACHgEAT023847
 for openvpn-devel@lists.sourceforge.net; Thu, 12 Nov 2026 18:42:14 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 12 Nov 2026 18:42:07 +0100
Message-ID: <20261112174213.23832-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRYoW-000000003ny-2Xbv
Subject: [Openvpn-devel] [PATCH v20] Enable -Wsign-conversion
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

As before with -Wconversion override all the known issues
to be able to address them one by one.

Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1186
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1186
This mail reflects revision 20 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5cf1a30..a90eb1a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -117,7 +117,7 @@
     check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
-    add_compile_options(-Wconversion -Wno-sign-conversion)
+    add_compile_options(-Wconversion)
     add_compile_options(-Wextra -Wno-unused-parameter)
     # clang doesn't have the different levels but also doesn't include it in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=2 GCCImplicitFallthrough)
diff --git a/configure.ac b/configure.ac
index 5f18798..ea338d8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1249,7 +1249,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-unused-parameter])
 # clang doesn't have the different levels but also doesn't include it in -Wextra
diff --git a/src/openvpn/acc.c b/src/openvpn/acc.c
index 455f56d..e21891d 100644
--- a/src/openvpn/acc.c
+++ b/src/openvpn/acc.c
@@ -148,6 +148,11 @@
     return parse_acc_message_flags(flags, err_reason, gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 receive_acc_message(struct context *c, const struct buffer *buffer)
 {
@@ -236,6 +241,10 @@
 }
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 send_acc_message(struct context *c,
                  struct tls_multi *multi,
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 028671d..c716e5b0 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -323,6 +323,11 @@
     return f;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  *  Create a struct argv based on a format string
  *
@@ -418,6 +423,10 @@
     return res;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  *  printf() variant which populates a struct argv.  It processes the
  *  format string with the provided arguments.  For each space separator found
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 84558af..211af90 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -36,6 +36,11 @@
  * padding */
 static_assert(TOKEN_DATA_LEN % 3 == 0, "TOKEN_DATA_LEN is not a multiple of 3");
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 is_auth_token(const char *password)
 {
@@ -291,6 +296,9 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 static bool
 check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const char *username)
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8813fa5..7f142c4f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -92,6 +92,11 @@
     return buf;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct buffer
 #ifdef BUF_INIT_TRACKING
 clone_buf_debug(const struct buffer *buf, const char *file, int line)
@@ -305,6 +310,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Garbage collection
  */
@@ -439,6 +448,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Hex dump -- Output a binary buffer to a hex string and return it.
  */
@@ -538,6 +552,10 @@
     buf_null_terminate(buf);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const char *
 skip_leading_whitespace(const char *str)
 {
@@ -717,6 +735,11 @@
     return memcmp(CBPTR(src), match, size) == 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 buf_string_compare_advance(struct buffer *src, const char *match)
 {
@@ -731,6 +754,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 buf_substring_len(const struct buffer *buf, int delim)
 {
@@ -957,6 +984,11 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline bool
 char_inc_exc(const char c, const unsigned int inclusive, const unsigned int exclusive)
 {
@@ -964,6 +996,10 @@
            && !char_class((unsigned char)c, exclusive);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 string_class(const char *str, const unsigned int inclusive, const unsigned int exclusive)
 {
@@ -1241,6 +1277,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 buffer_list_aggregate_separator(struct buffer_list *bl, const size_t max_len, const char *sep)
 {
@@ -1286,6 +1327,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 buffer_list_aggregate(struct buffer_list *bl, const size_t max)
 {
@@ -1323,6 +1368,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct buffer_list *
 buffer_list_file(const char *fn, int max_line_len)
 {
@@ -1402,3 +1452,7 @@
     buf_advance(buf, field_len + 1);
     return field;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 7af4444..ede3066 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -643,6 +643,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Initialise a buffer with an externally provided writable memory region.
  *
@@ -1619,6 +1624,10 @@
     return memcmp(CBPTR(src), match, size) == 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Return true if the head of \c src matches the string \c match.
  *
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 57c6bb3..0c5f22f 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -89,6 +89,11 @@
     compv2_escape_data_ifneeded(buf);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 do_lz4_decompress(int zlen_max, struct buffer *work, struct buffer *buf,
                   struct compress_context *compctx)
@@ -198,6 +203,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const struct compress_alg lz4_alg = { "lz4", lz4_compress_init, lz4_compress_uninit, lz4_compress,
                                       lz4_decompress };
 
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 4737677..dc71d12 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -41,6 +41,11 @@
 #include <termios.h>
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #ifdef _WIN32
 
 #include "win32.h"
@@ -289,3 +294,7 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index eaed24e..8fc7f72 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -53,6 +53,11 @@
     return (sd_booted() > 0) && (stat(SYSTEMD_ASK_PASSWORD_PATH, &c) == 0);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 get_console_input_systemd(const char *prompt, const bool echo, char *input, const int capacity)
 {
@@ -86,6 +91,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  *  Systemd aware implementation of query_user_exec().  If systemd is not running
  *  it will fall back to use query_user_exec_builtin() instead.
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a8ad7f0..33e0376 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -62,6 +62,11 @@
  * happen unless the frame parameters are wrong.
  */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 openvpn_encrypt_aead(struct buffer *buf, struct buffer work, struct crypto_options *opt)
 {
@@ -1577,6 +1582,10 @@
     return nbits;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 must_have_n_keys(const char *filename, const char *option, const struct key2 *key2, int n)
 {
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 35f9b55..312cf6f 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -38,6 +38,11 @@
 #include "buffer.h"
 #include "integer.h"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, size_t info_len,
                  uint8_t *out, size_t out_len)
@@ -458,3 +463,7 @@
         epoch_iterate_send_key(opt);
     }
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 3a2a8c6..ceaaad4 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -821,6 +821,11 @@
     ASSERT(hmac_length == dst_size);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1149,4 +1154,8 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b7f2ef3..0a1d00c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -487,6 +487,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 crypto_pem_decode(const char *name, struct buffer *dst, const struct buffer *src)
 {
@@ -1306,6 +1311,10 @@
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 memcmp_constant_time(const void *a, const void *b, size_t size)
 {
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index ef3c94c..30a5144 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -62,7 +62,7 @@
     return 0;
 }
 
-#else  /* HAVE_XKEY_PROVIDER */
+#else /* HAVE_XKEY_PROVIDER */
 
 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;
 
@@ -260,6 +260,11 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -598,6 +603,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 {
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index f3b5d44..236be93 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -50,6 +50,11 @@
 #include <cap-ng.h>
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static int
 dco_install_key(struct tls_multi *multi, struct key_state *ks, const uint8_t *encrypt_key,
                 const uint8_t *encrypt_iv, const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
@@ -807,4 +812,8 @@
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 3148f10..11b8dff 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -577,6 +577,11 @@
         __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dco_write_bytes);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 int
 dco_read_and_process(dco_context_t *dco)
 {
@@ -762,6 +767,10 @@
     return available;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const char *
 dco_version_string(struct gc_arena *gc)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a84e310..60107c4 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -220,6 +220,11 @@
     return sock;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
              struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,
@@ -1257,6 +1262,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 12b0666..a854045 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -220,6 +220,11 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)
 {
@@ -1091,6 +1096,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 dco_supports_epoch_data(const struct context *c)
 {
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 19e9e2d..525d567 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -72,6 +72,11 @@
     return -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static in_addr_t
 do_extract(struct dhcp *dhcp, int optlen)
 {
@@ -186,6 +191,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #if defined(_WIN32) || defined(DHCP_UNIT_TEST)
 
 /*
@@ -327,6 +336,11 @@
     buf_write(buf, tmp_buf, len);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
 {
@@ -375,4 +389,8 @@
     return !error;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index abe30ed..e2cb981 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -58,6 +58,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 dns_server_addr_parse(struct dns_server *server, const char *addr)
 {
@@ -144,6 +149,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_arena *gc)
 {
@@ -402,6 +411,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 run_up_down_service(bool add, const struct options *o, const struct tuntap *tt)
 {
@@ -476,7 +490,11 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
 
-#else  /* ifdef _WIN32 */
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
+#else /* ifdef _WIN32 */
 
 static void
 setenv_dns_option(struct env_set *es, const char *format, size_t i, size_t j, const char *value)
@@ -702,6 +720,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt,
                     struct dns_updown_runner_info *updown_runner)
@@ -780,6 +803,10 @@
     msg(M_INFO, "dns %s command exited with status %d", up ? "up" : "down", status);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* _WIN32 */
 
 void
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 67a5bf5..d59115a 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -432,6 +432,11 @@
     return (script_security() >= SSEC_PW_ENV || !is_password_env_var(str));
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* Make arrays of strings */
 
 const char **
@@ -470,3 +475,7 @@
     ret[i] = NULL;
     return (const char **)ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 32d819d..a3f7990 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -219,6 +219,11 @@
     va_end(arglist);
 }
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static const char *
 openvpn_strerror(int err, bool crt_error, struct gc_arena *gc)
 {
@@ -689,6 +694,10 @@
     }
 }
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * In multiclient mode, put a client-specific prefix
  * before each message.
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 373cbc1..0056d05 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -406,6 +406,11 @@
 }
 #endif
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)
 {
@@ -426,6 +431,10 @@
     return err;
 }
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
+
 #include "errlevel.h"
 
 #endif /* ifndef ERROR_H */
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 5e17ea1..c4a856d 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -486,6 +486,11 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static struct event_set *
 we_init(int *maxevents, unsigned int flags)
 {
@@ -524,8 +529,17 @@
     return (struct event_set *)wes;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* _WIN32 */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #if EPOLL
 
 struct ep_set
@@ -1122,6 +1136,10 @@
 }
 #endif /* SELECT */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static struct event_set *
 event_set_init_simple(int *maxevents, unsigned int flags)
 {
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 6910f81..e715964 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -31,6 +31,11 @@
 
 #include "memdbg.h"
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* Set a file descriptor to non-blocking */
 bool
 set_nonblock_action(socket_descriptor_t fd)
@@ -50,6 +55,10 @@
     return true;
 }
 
+#if defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
+
 /* Set a file descriptor to not be passed across execs */
 bool
 set_cloexec_action(socket_descriptor_t fd)
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index eac8075..15ee3cd 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -35,6 +35,11 @@
 
 void set_cloexec(socket_descriptor_t fd);
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline void
 openvpn_fd_set(socket_descriptor_t fd, fd_set *setp)
 {
@@ -45,4 +50,8 @@
 }
 #undef FD_SET /* prevent direct use of FD_SET() */
 
-#endif        /* FD_MISC_H */
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
+#endif /* FD_MISC_H */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 82cb6c9..bcad559 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -286,6 +286,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Handle incoming configuration
  * messages on the control channel.
@@ -2033,6 +2038,10 @@
     check_timeout_random_component(c);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 multi_io_process_flags(struct context *c, struct event_set *es, struct link_socket *sock, const unsigned int flags)
 {
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index c454434..55f2a08 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -40,6 +40,11 @@
         goto error; \
     }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 fragment_list_buf_init(struct fragment_list *list, const struct frame *frame)
 {
@@ -284,6 +289,10 @@
     ASSERT(buf_write_prepend(buf, &flags, sizeof(flags)));
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Without changing the number of fragments, return a possibly smaller
  * max fragment size that will allow for the last fragment to be of
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 6b5fcee6..d9ddf6a 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -148,6 +148,11 @@
 }
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Process server, server-bridge, and client helper
  * directives after the parameters themselves have been
@@ -507,6 +512,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  *
  * HELPER DIRECTIVE:
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 29c24f2..5235c4f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -103,6 +103,11 @@
     c->persist = cpsave;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Pass tunnel endpoint and MTU parms to a user-supplied script.
  * Used to execute the up/down script/plugins.
@@ -3687,6 +3692,10 @@
     c->c2.link_socket_owned = true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * bind TCP/UDP sockets
  */
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 51cf5e8..2b0691b 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -40,6 +40,11 @@
 #include "memdbg.h"
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 lzo_compress_init(struct compress_context *compctx)
 {
@@ -120,6 +125,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const struct compress_alg lzo_alg = { "lzo", lzo_compress_init, lzo_compress_uninit, lzo_compress,
                                       lzo_decompress };
 #endif /* ENABLE_LZO */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 581e7be..4809532 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -779,6 +779,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 man_query_user_pass(struct management *man, const char *type, const char *string, const bool needed,
                     const char *prompt, char *dest, int len)
@@ -804,6 +809,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 man_query_username(struct management *man, const char *type, const char *string)
 {
@@ -2473,6 +2482,11 @@
 
 #endif /* ifdef TARGET_ANDROID */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static ssize_t
 man_read(struct management *man)
 {
@@ -2611,6 +2625,10 @@
     return sent;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 man_connection_clear(struct man_connection *mc)
 {
@@ -2682,6 +2700,11 @@
     CLEAR(*mp);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 man_settings_init(struct man_settings *ms, const char *addr, const char *port,
                   const char *pass_file, const char *client_user, const char *client_group,
@@ -3297,6 +3320,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifdef _WIN32
 
 void
@@ -3606,6 +3633,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Process the management event loop for sec seconds
  */
@@ -4341,6 +4373,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 management_check_bytecount_client(struct context *c, struct management *man, struct timeval *timeval)
 {
@@ -4475,6 +4511,12 @@
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32.h"
+
+#if !defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 management_sleep(const int n)
 {
@@ -4488,4 +4530,8 @@
 #endif /* ifdef _WIN32 */
 }
 
+#if !defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENABLE_MANAGEMENT */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 8c9ad08..9a307a2 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -72,6 +72,11 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #ifdef ENABLE_MANAGEMENT
 /* Get username/password from the management interface */
 static bool
@@ -762,6 +767,10 @@
     return (state == 2);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 output_peer_info_env(struct env_set *es, const char *peer_info)
 {
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 0cfa272d..5bc94d9 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -194,6 +194,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline size_t
 adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
@@ -313,6 +318,10 @@
     frame->mss_fix = (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_overhead);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 frame_calculate_dynamic(struct frame *frame, const struct key_type *kt, const struct options *options,
                         const struct link_socket_info *lsi)
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 2d0af06..fc5b657 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -37,6 +37,11 @@
 #include <sys/inotify.h>
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock)
 {
@@ -88,6 +93,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 multi_tcp_instance_specific_free(struct multi_instance *mi)
 {
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 5ce40c8..7892935 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -37,6 +37,11 @@
 #include "memdbg.h"
 #include "ssl_common.h"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* allocate a buffer for socket or tun layer */
 void
 alloc_buf_sock_tun(struct buffer *buf, const struct frame *frame)
@@ -383,6 +388,10 @@
     return BSTR(&out);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 set_sock_extended_error_passing(int sd, sa_family_t proto_af)
 {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index bcaa012..0890480 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -247,6 +247,11 @@
 
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #ifdef ENABLE_ASYNC_PUSH
 static uint64_t
 /*
@@ -4555,3 +4560,7 @@
     return (!ipv6_net_contains_host(&ifconfig_local, o->ifconfig_ipv6_netbits,
                                     dest));
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index fb4810b..e07b691 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -104,6 +104,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct multi_io *
 multi_io_init(const int maxclients)
 {
@@ -121,6 +126,10 @@
     return multi_io;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 multi_io_free(struct multi_io *multi_io)
 {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 97ff7bd..501c635 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -243,6 +243,11 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Send Netlink message and run callback on reply (if specified)
  */
@@ -1485,6 +1490,10 @@
     return sitnl_send(&req.n, 0, 0, NULL, NULL);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* !ENABLE_SITNL */
 
 #endif /* TARGET_LINUX */
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index f25ae19..38685f5 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -177,6 +177,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif
 
 void
@@ -352,10 +353,6 @@
     c->c2.occ_op = -1;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 process_received_occ_msg(struct context *c)
 {
@@ -426,3 +423,7 @@
     }
     c->c2.buf.len = 0; /* don't pass packet on */
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index b32f009..9f0f50c 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -351,6 +351,12 @@
 }
 
 #ifdef _WIN32
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 int
 wmain(int argc, wchar_t *wargv[])
 {
@@ -394,6 +400,11 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #else  /* ifdef _WIN32 */
 int
 main(int argc, char *argv[])
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 454d2d6..dbbeb00 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -947,6 +947,11 @@
     setenv_str_i(es, "local_port", e->port, i);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 setenv_settings(struct env_set *es, const struct options *o)
 {
@@ -7874,6 +7879,7 @@
 
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
+#pragma GCC diagnostic pop
 #endif
 
 bool
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index 5d6f93e..0a5eae5 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -234,6 +234,11 @@
     } u;
 };
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 in_src_get(const struct in_src *is, char *line, const int size)
 {
@@ -298,6 +303,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 check_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)
 {
diff --git a/src/openvpn/options_show.c b/src/openvpn/options_show.c
index 321a37b..88422e0 100644
--- a/src/openvpn/options_show.c
+++ b/src/openvpn/options_show.c
@@ -341,6 +341,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 show_settings(const struct options *o)
 {
@@ -629,4 +634,8 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifndef ENABLE_SMALL */
diff --git a/src/openvpn/options_string.c b/src/openvpn/options_string.c
index 4a43fce4..4fe34bf 100644
--- a/src/openvpn/options_string.c
+++ b/src/openvpn/options_string.c
@@ -380,6 +380,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wsign-compare"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif
 
 char *
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index d25d85c..23fdac7 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -211,6 +211,11 @@
                                            "route-metric", "topology",
                                            "tun-mtu", "keepalive" };
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 check_push_update_option_flags(char *line, int *i, uint64_t *flags)
 {
@@ -273,6 +278,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 apply_pull_filter(const struct options *o, char *line)
 {
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 9dd6ce3..881df5d 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -71,6 +71,11 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time_backtrack,
                     const char *name, int unit)
@@ -175,6 +180,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Expire sequence numbers which can no longer
  * be accepted because they would violate
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 526e64c..bbacd20 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -64,6 +64,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Should we ping the remote?
  */
@@ -84,3 +89,7 @@
     c->c2.buf.len = 0;
     dmsg(D_PING, "SENT PING");
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index f00ba9b..b4bed12 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -54,6 +54,11 @@
 }
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 __mysleep(unsigned long usec)
 {
@@ -812,4 +817,9 @@
     pkcs11h_terminate();
     gc_free(&gc);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENABLE_PKCS11 */
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 8abd60a..c5974fce 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -130,6 +130,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Sign op called from xkey provider
  *
@@ -230,6 +235,10 @@
     return 1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* wrapper for handle free */
 static void
 xkey_handle_free(void *handle)
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 9412eeb..e10161f 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -76,6 +76,11 @@
 
 /* Get/Set UID of process */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 platform_user_get(const char *username, struct platform_state_user *state)
 {
@@ -658,6 +663,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 platform_absolute_pathname(const char *pathname)
 {
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index d1f228e..2872265 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -463,6 +463,11 @@
 #define _OPENVPN_PATCH_LEVEL "git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_FLAGS
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 plugin_open_item(struct plugin *p, const struct plugin_option *o,
                  struct openvpn_plugin_string_list **retlist, const char **envp,
@@ -545,6 +550,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 plugin_call_item(const struct plugin *p, void *per_client_context, const int type,
                  const struct argv *av, struct openvpn_plugin_string_list **retlist,
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index fff0e3f..016f3a8 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -137,6 +137,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct ifconfig_pool *
 ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t start, in_addr_t end,
                    const bool duplicate_cn, const bool ipv6_pool, const struct in6_addr ipv6_base,
@@ -708,6 +713,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 ifconfig_pool_write(struct ifconfig_pool_persist *persist, const struct ifconfig_pool *pool)
 {
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 7b5a289..cd9f3b2 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -53,6 +53,11 @@
 }
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* cached proxy username/password */
 static struct user_pass static_proxy_user_pass;
 
@@ -288,6 +293,10 @@
     p->up = static_proxy_user_pass; /* this is a copy of protected memory */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #if 0
 /* function only used in #if 0 debug statement */
 static void
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index f8cfe1c5..86b4fc9 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -165,6 +165,11 @@
     return CMSG_SPACE(sizeof(socket_descriptor_t));
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Send a command (char), data (head), and a file descriptor (sd_send) to a local process
  * over unix socket sd.  Unfortunately, there's no portable way to send file descriptors
@@ -618,6 +623,10 @@
     return IOSTAT_GOOD;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Forward data from pc to pc->counterpart.
  */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a18f33b..6f628b8 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -389,6 +389,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 receive_auth_pending(struct context *c, const struct buffer *buffer)
 {
@@ -795,6 +800,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 send_push_options(struct context *c, struct buffer *buf, struct push_list *push_list, int safe_cap,
                   bool *push_sent, bool *multi_push)
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 7b5b17c..b045b1f 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -311,6 +311,11 @@
  * struct reliable member functions.
  */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 reliable_init(struct reliable *rel, int buf_size, int offset, int array_size, bool hold)
 {
@@ -780,6 +785,10 @@
     ASSERT(0); /* buf not found in rel */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Enable an outgoing buffer previously returned by a get function as active.
  */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d0d26c6..e8e1f60 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -582,6 +582,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 block_local_needed(const struct route_list *rl)
 {
@@ -3217,6 +3222,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* IPv6 implementation using netlink
  * https://www.linuxjournal.com/article/7356 - "Kernel Korner - Why and How to Use Netlink Socket"
  * netlink(3), netlink(7), rtnetlink(7)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 1fbd07b..c07ef60 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -422,6 +422,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 socket_descriptor_t
 socket_do_accept(socket_descriptor_t sd, struct link_socket_actual *act, const bool nowait)
 {
@@ -2084,6 +2089,10 @@
     return buf->len;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifndef _WIN32 */
 
 /*
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 52e09c9..2210bfe 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -288,12 +288,21 @@
     return sh.is_handle ? (int)GetLastError() : WSAGetLastError();
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 inline static void
 SocketHandleSetLastError(sockethandle_t sh, DWORD err)
 {
     sh.is_handle ? SetLastError(err) : WSASetLastError(err);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static inline void
 SocketHandleSetInvalError(sockethandle_t sh)
 {
@@ -459,6 +468,11 @@
 
 #endif /* if PORT_SHARE */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline bool
 socket_connection_reset(const struct link_socket *sock, ssize_t status)
 {
@@ -482,6 +496,10 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static inline bool
 link_socket_verify_incoming_addr(const struct buffer *buf, const struct link_socket_info *info,
                                  const struct link_socket_actual *from_addr)
@@ -649,6 +667,11 @@
 ssize_t link_socket_write_tcp(struct link_socket *sock, struct buffer *buf,
                               struct link_socket_actual *to);
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #ifdef _WIN32
 
 static inline int
@@ -721,6 +744,10 @@
 
 #endif /* ifdef _WIN32 */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static inline ssize_t
 link_socket_write_udp(struct link_socket *sock, struct buffer *buf, struct link_socket_actual *to)
 {
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 879be73..a049f33 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -123,6 +123,11 @@
 #define IF_NAMESIZE 16
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 const char *
 print_link_socket_actual_ex(const struct link_socket_actual *act, const char *separator,
                             const unsigned int flags, struct gc_arena *gc)
@@ -188,6 +193,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Convert an in_addr_t in host byte order
  * to an ascii dotted quad.
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index a8c9fd3..51e3a1e 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -226,6 +226,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,
                  const struct event_timeout *server_poll_timeout, volatile int *signal_received)
@@ -310,6 +315,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 port_from_servname(const char *servname)
 {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a538b52..e253242 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -152,6 +152,11 @@
     return limit;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 tls_init_control_channel_frame_parameters(struct frame *frame, int tls_mtu)
 {
@@ -236,6 +241,10 @@
     return overhead;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 init_ssl_lib(void)
 {
@@ -797,6 +806,11 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /** @addtogroup control_processor
  *  @{ */
 
@@ -1048,6 +1062,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Clean up a \c tls_session structure.
  * @ingroup control_processor
@@ -1330,6 +1348,11 @@
     key_source_print(&k->server, "Server");
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 openvpn_PRF(const uint8_t *secret, size_t secret_len, const char *label, const uint8_t *client_seed,
             size_t client_seed_len, const uint8_t *server_seed, size_t server_seed_len,
@@ -4482,3 +4505,7 @@
 done:
     return BSTR(&out);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 45d7715..cbc3118 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -199,6 +199,11 @@
         ciphers);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -1187,6 +1192,10 @@
     return 1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* **************************************
  *
  * Information functions
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index f13f507..df9e42c 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -393,6 +393,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session, const char *common_cipher)
 {
@@ -576,6 +581,10 @@
     o->ncp_ciphers = (char *)ncp_ciphers;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index fe2bfda..035cfb8 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -277,7 +277,14 @@
     sslopt |= SSL_OP_NO_RENEGOTIATION;
 #endif
 
+#if defined(LIBRESSL_VERSION_NUMBER) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
     SSL_CTX_set_options(ctx->ctx, sslopt);
+#if defined(LIBRESSL_VERSION_NUMBER) && (defined(__GNUC__) || defined(__clang__))
+#pragma GCC diagnostic pop
+#endif
 
     if (!tls_ctx_set_tls_versions(ctx, ssl_flags))
     {
@@ -511,6 +518,11 @@
 {
     ASSERT(ctx);
 #if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
     struct gc_arena gc = gc_new();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
@@ -556,6 +568,10 @@
         crypto_msg(M_FATAL, "Failed to set allowed TLS group list: %s", groups);
     }
     gc_free(&gc);
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 #else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
     {
@@ -1466,6 +1482,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Pass the input hash in 'dgst' to management and get the signature back.
  *
@@ -1710,6 +1731,11 @@
     return 0;
 }
 #endif /* !defined(OPENSSL_NO_EC) */
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENABLE_MANAGEMENT && !HAVE_XKEY_PROVIDER */
 
 #ifdef ENABLE_MANAGEMENT
@@ -2099,6 +2125,11 @@
  * to BIOs.
  */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 bio_write_post(const int status, struct buffer *buf)
 {
@@ -2110,6 +2141,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Read from an OpenSSL BIO in non-blocking mode.
  */
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index f78782f..60573ee 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -40,6 +40,11 @@
  */
 #define SWAP_BUF_SIZE 256
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Move a packet authentication HMAC + related fields to or from the front
  * of the buffer so it can be processed by encrypt/decrypt.
@@ -591,3 +596,7 @@
     buf_advance(buf, cmdlen);
     return cmdbuf;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index ba185c1..337faed 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -86,6 +86,10 @@
     return var_value;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
 
 unsigned int
 peer_info_extract_int(const char *peer_info, const char *field, const char *format, unsigned int default_value)
@@ -166,6 +170,10 @@
     return BSTR(&buf);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * SSL/TLS Cipher suite name translation table
  */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0cdec1e..bf0267d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -400,6 +400,11 @@
     return SUCCESS;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Export the subject, common_name, and raw certificate fields to the
  * environment for later verification by scripts and plugins.
@@ -803,6 +808,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* ***************************************************************************
  * Functions for the management of deferred authentication when using
  * user/password authentication.
@@ -884,6 +893,11 @@
     return supported;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  *  Checks if the deferred state should also send auth pending
  *  request to the client. Also removes the auth_pending control file
@@ -958,6 +972,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  *  Removes auth_pending and auth_control files from file system
  *  and key_state structure
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index a132f12..bba2f2f 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -222,6 +222,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 result_t
 backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
@@ -786,6 +791,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Dummy function because Netscape certificate types are not supported in OpenVPN with mbedtls.
  * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise. */
 result_t
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 0c36cf2..19339ad 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -317,6 +317,11 @@
     return serial;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 char *
 backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
@@ -573,6 +578,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Save X509 fields to environment, using the naming convention:
  *
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 1036536..533619f 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -55,6 +55,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct status_output *
 status_open(const char *filename, const int refresh_freq, const int msglevel,
             const struct virtual_output *vout, const unsigned int flags)
@@ -119,6 +124,10 @@
     return so;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 status_trigger(struct status_output *so)
 {
@@ -206,6 +215,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 #define STATUS_PRINTF_MAXLEN 512
 
 void
@@ -297,3 +311,7 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d66b96d..2dadc4f 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -93,6 +93,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 tls_session_generate_dynamic_tls_crypt_key(struct tls_session *session)
 {
@@ -518,6 +523,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 tls_crypt_v2_check_client_key_age(const struct buffer *tls_crypt_v2_metadata, int max_days)
 {
@@ -698,6 +707,11 @@
     write_pem_key_file(filename, tls_crypt_v2_srv_pem_name);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 tls_crypt_v2_write_client_key_file(const char *filename, const char *b64_metadata,
                                    const char *server_key_file, bool server_key_inline)
@@ -801,3 +815,7 @@
 
     gc_free(&gc);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index bcea331..07e036e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -112,6 +112,11 @@
 
 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static bool
 do_address_service(const bool add, const short family, const struct tuntap *tt)
 {
@@ -479,6 +484,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifdef _WIN32 */
 
 #ifdef TARGET_SOLARIS
@@ -815,6 +824,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Init tun/tap object.
  *
@@ -1556,6 +1570,10 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* execute the ifconfig command through the shell */
 void
 do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu, const struct env_set *es,
@@ -1701,6 +1719,11 @@
 #include <netinet/ip.h>
 #include <sys/uio.h>
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline ssize_t
 header_modify_read_write_return(ssize_t len)
 {
@@ -1786,6 +1809,10 @@
 }
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
 
 bool
@@ -2043,6 +2070,11 @@
     free(tt);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 ssize_t
 write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
@@ -2055,6 +2087,10 @@
     return read(tt->fd, buf, len);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_LINUX)
 
 #if !PEDANTIC
@@ -2252,6 +2288,11 @@
     free(tt);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 ssize_t
 write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
@@ -2264,6 +2305,10 @@
     return read(tt->fd, buf, len);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_SOLARIS)
 
 #ifndef TUNNEWPPA
@@ -2881,6 +2926,11 @@
 
 #elif defined(TARGET_DARWIN)
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* Darwin (MacOS X) is mostly "just use the generic stuff", but there
  * is always one caveat...:
  *
@@ -2946,6 +2996,10 @@
     return fd;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
@@ -3095,6 +3149,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 ssize_t
 write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
@@ -3121,6 +3180,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_AIX)
 
 void
@@ -3257,6 +3320,11 @@
 
 #elif defined(_WIN32)
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 int
 tun_read_queue(struct tuntap *tt, int maxsize)
 {
@@ -6101,6 +6169,10 @@
     argv_free(&argv);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 close_tun_handle(struct tuntap *tt)
 {
@@ -6280,7 +6352,7 @@
     return BSTR(&out);
 }
 
-#else                        /* generic */
+#else  /* generic */
 
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
@@ -6310,4 +6382,4 @@
     return read(tt->fd, buf, len);
 }
 
-#endif                       /* if defined (TARGET_ANDROID) */
+#endif /* if defined (TARGET_ANDROID) */
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 79d706a..155bf8d 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -48,6 +48,11 @@
 #include <stdlib.h>
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, const struct env_set *env)
 {
@@ -171,6 +176,11 @@
      * with error messages */
     return read(tt->fd, buf, len);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #else  /* ifndef WIN32 */
 
 // cppcheck-suppress-begin constParameterPointer ; stubs
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 04e18d6..d44dac1 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -56,6 +56,11 @@
         (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (htons(vid) & OPENVPN_8021Q_MASK_VID);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * vlan_decapsulate - remove 802.1q header and return VID
  *
@@ -170,6 +175,10 @@
     return -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * vlan_encapsulate - add 802.1q header and set the context related VID
  *
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 4d38fdb..b576899 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -131,6 +131,11 @@
     return err;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Block outgoing local traffic, possibly DNS only, except for
  * (i) adapter with the specified index (and loopback, if all is blocked)
@@ -340,6 +345,10 @@
     return err;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 DWORD
 delete_wfp_block_filters(HANDLE engine_handle)
 {
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index e2c8810..5f99e2b 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -36,6 +36,11 @@
 #include "buffer.h"
 #include "win32-util.h"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 WCHAR *
 wide_string(const char *utf8, struct gc_arena *gc)
 {
@@ -131,6 +136,10 @@
     return utf8;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Return true if filename is safe to be used on Windows,
  * by avoiding the following reserved names:
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 3af58ed..079869f 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -545,6 +545,11 @@
     CLEAR(*ws);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 win32_signal_open(struct win32_signal *ws, int force, const char *exit_event_name,
                   bool exit_event_initial_state)
@@ -1661,4 +1666,8 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 6908cbb..f4be796 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -146,6 +146,11 @@
 }
 
 #ifdef ENABLE_MANAGEMENT
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
 /**
  * Signature callback for xkey_provider with management-external-key
  *
@@ -276,6 +281,10 @@
 
     return (*siglen > 0);
 }
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENABLE MANAGEMENT */
 
 /**
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index a349d4d..9211c11 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -940,6 +940,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static int
 signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsize,
                const unsigned char *tbs, size_t tbslen)
@@ -1074,6 +1079,10 @@
     return signature_sign(ctx, sig, siglen, sigsize, buf, sz);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Sign digest using native sign function -- will only work for native keys
  */
 int
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 85ebda9..777c823 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -98,6 +98,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {
@@ -189,3 +194,7 @@
                       hRecordProg);
     MsiCloseHandle(hRecordProg);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 671ddde..e20feb7 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -30,6 +30,11 @@
 LPCWSTR service_instance = L"";
 static wchar_t win_sys_path[MAX_PATH];
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static DWORD
 GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR default_value)
 {
@@ -309,6 +314,10 @@
     return utf16;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const wchar_t *
 get_win_sys_path(void)
 {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 81205d6..ac6a264 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -524,6 +524,10 @@
     free(sud->directory);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
 
 static SOCKADDR_INET
 sockaddr_inet(short family, const inet_address_t *addr)
@@ -3964,6 +3968,9 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 static DWORD WINAPI
 ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 948b6af..0cd201d 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -184,6 +184,11 @@
     return -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static ssize_t
 send_string(int fd, const char *string)
 {
@@ -199,6 +204,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifdef DO_DAEMONIZE
 
 /*
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index ac1ecd2..a3d83e9 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -102,6 +102,11 @@
 }
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Returns length of string of strings
  *
@@ -1226,6 +1231,9 @@
     return dwResult;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 void
 tap_free_adapter_list(_In_ struct tap_adapter_node *pAdapterList)
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 338265d..b480985 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -106,6 +106,11 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 test_buffer_format_hex_ex(void **state)
 {
@@ -139,6 +144,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 struct test_buffer_list_aggregate_ctx
 {
     struct buffer_list *empty;
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index f86aca8..e68a0b2 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -52,6 +52,11 @@
 
 static const char testtext[] = "Dummy text to test PEM encoding";
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 crypto_pem_encode_decode_loopback(void **state)
 {
@@ -799,6 +804,10 @@
     assert_null(epoch_lookup_decrypt_key(co, 23));
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 crypto_test_epoch_key_overflow(void **state)
 {
@@ -914,6 +923,11 @@
     assert_memory_equal(out, expected_hash, UT_SIPHASH_HASH_SIZE);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 test_siphash_openssl(void **state)
 {
@@ -959,6 +973,9 @@
     siphash_openssl_uninit(sipctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 int
 main(void)
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 37bbe92..55aafbb 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -137,6 +137,11 @@
     return c->cert ? c : NULL;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* import sample certificates into windows cert store */
 static void
 import_certs(void **state)
@@ -223,6 +228,10 @@
     certs_loaded = true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 cleanup(void **state)
 {
diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/openvpn/test_dhcp.c
index 3a84e1e..e331d3d 100644
--- a/tests/unit_tests/openvpn/test_dhcp.c
+++ b/tests/unit_tests/openvpn/test_dhcp.c
@@ -50,6 +50,11 @@
     return "dummy";
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 test_write_dhcp_search_str(void **state)
 {
@@ -141,6 +146,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 main(void)
 {
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 1c9cac1..ae75386 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -40,6 +40,11 @@
     return net_iface_del(NULL, name);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static int
 net__iface_mtu_set(int mtu)
 {
@@ -48,6 +53,10 @@
     return net_iface_mtu_set(NULL, iface, mtu);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 net__addr_v4_add(const char *addr_str, int prefixlen)
 {
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 49ba833..889e6d7 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -618,6 +618,11 @@
     assert_memory_equal(server_id2_p1.id, server_id_p2.id, SID_SIZE);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 test_generate_reset_packet_plain(void **ut_state)
 {
@@ -696,6 +701,10 @@
     free_tas(&tas_server);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* A peer can ask us to append the wrapped client key (WKc) to our next
  * control packet. Only a tls-crypt-v2 client has one, so check that we
  * refuse to build such a packet when we have no key instead of walking
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 4987dd0..85b8d12 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -265,6 +265,10 @@
 #endif /* HAVE_OPENSSL_STORE */
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
 
 static void
 init_frame_parameters(struct frame *frame)
@@ -886,6 +890,10 @@
     free_certificate(cert);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Certificate with two CNs, "foo" and "bar".
  *
  * Generated with:
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index f8aa199..ab90ea5 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -232,6 +232,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Check that short messages are successfully wrapped-and-unwrapped.
  */
@@ -773,6 +778,10 @@
     tls_wrap_free(&wrap_ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 test_tls_crypt_v2_write_server_key_file(void **state)
 {
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 776a86a..5bc1d2a 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -46,6 +46,12 @@
     return query_user_exec_builtin();
 }
 #endif
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 query_user_exec_builtin(void)
 {
@@ -58,6 +64,11 @@
 
     return mock();
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 management_auth_failure(const struct management *man, const char *type, const char *reason)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
