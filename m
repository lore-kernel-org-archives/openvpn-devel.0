Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80CDCD98C5
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYdZz4zLHqdiFyq2F5rkY2eRXmDbvXH6fLkvAT7pMho=; b=IdJOjns7zCKvges3j3BVtCX9OS
	hMVVEcrYJBG2g6YJyXifXLoxt2uiP1D4tgTtAfIinmd4gq1+lnITHcTzXknWufvA9zv7cqVc90scy
	pkb9WM8velsTQUfRloGph2kP67L/5Hh/rq3jr9Vq/1BcFtNbkhapEFFWBuf6jXa34iYs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWykt-0000er-Vo;
	Tue, 09 Jun 2026 15:52:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWyks-0000ek-IA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:52:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2AI/+NTKrlSTZCIZKKLQAtY/dSwRKAqcDbwVplVyOqk=; b=fPTMrg9Ap+Cx36Pu3/yeod1fcS
 IVLOo37k0SiUqDMav0mYl2DWz/DzfmZwnN2PGfJWMv5hDCtj6+X1z8WEheWnDNnF+j2DY4na3RzBm
 /jvW9lb5VjWDAFktapfRoTlkRoKUlS+Ot/xxBHlstGQ3rk+F5oqLrMnD2zi9GOH5uwBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2AI/+NTKrlSTZCIZKKLQAtY/dSwRKAqcDbwVplVyOqk=; b=mWbbxGY+oYjBrKC64YFqtntLyf
 TtJhcItkYW/wySplLeHdHLaxScw+x567iI8uixom+AVVliyERuPuV3fyW2AHnILQ2WavViOHIknNL
 x/Y0OVd3WgDSB6rw9ajLoctYsvf4zNP3zg2Mof2mihuqi75V4XV+yfEn5h2OLjc8h89k=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWykn-0008Bc-Pl for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:52:39 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 659FqQET030841
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 17:52:26 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 659FqQKK030840
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 17:52:26 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 17:52:21 +0200
Message-ID: <20260609155226.30827-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
References: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWykn-0008Bc-Pl
Subject: [Openvpn-devel] [PATCH v1] AWS-LC: Add casts and openssl_opt_t
 typdef to allow AWS-LC with -Werror
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

From: Arne Schwabe <arne@rfc2549.org>

Change-Id: I88254e985d67234d827b92908079795df23daf20
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1637
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1637
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e4cb799..5cc1a7d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -347,6 +347,4 @@
       gitref: v1.70.0
       libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$LIBPREFIX" -DBUILD_SHARED_LIBS=1
       libmake: cmake --build build
-      libinstall: sudo cmake --install build
-      # not ready for --enable-werror
-      ovpnconfigureflags:
+      libinstall: sudo cmake --install build
\ No newline at end of file
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index c11cfd8..fa9eb67 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -425,7 +425,7 @@
 print_digest(EVP_MD *digest, void *unused)
 {
     printf("%s %d bit digest size\n", md_kt_name(EVP_MD_get0_name(digest)),
-           EVP_MD_size(digest) * 8);
+           (int)EVP_MD_size(digest) * 8);
 }
 
 void
@@ -1025,7 +1025,7 @@
                    "Message hash algorithm '%s' uses a default hash "
                    "size (%d bytes) which is larger than " PACKAGE_NAME "'s current "
                    "maximum hash size (%d bytes)",
-                   digest, EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
+                   digest, (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
     }
     return md;
 }
@@ -1144,7 +1144,7 @@
 int
 md_ctx_size(const EVP_MD_CTX *ctx)
 {
-    return EVP_MD_CTX_size(ctx);
+    return (int)EVP_MD_CTX_size(ctx);
 }
 
 void
@@ -1188,7 +1188,7 @@
     evp_md_type *kt = md_get(mdname);
     ASSERT(NULL != kt && NULL != ctx);
 
-    int key_len = EVP_MD_size(kt);
+    int key_len = (int)EVP_MD_size(kt);
     HMAC_CTX_reset(ctx);
     if (!HMAC_Init_ex(ctx, key, key_len, kt, NULL))
     {
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ec059ac..b61bcbf 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -51,10 +51,14 @@
 typedef uint32_t openssl_err_t;
 typedef size_t openssl_stack_size_t;
 #define PRI_OPENSSL_STACK "zu"
+typedef uint32_t openssl_opt_t;
 #else
 typedef unsigned long openssl_err_t;
 typedef int openssl_stack_size_t;
 #define PRI_OPENSSL_STACK "d"
+/* OpenSSL 4.0 actually uses bits in the upper half of the uint64_t (e.g.
+ * SSL_OP_PREFER_NO_DHE_KEX), so we really should use an uint64_t here */
+typedef uint64_t openssl_opt_t;
 #endif
 
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6ce5f3f..ef99b22 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -328,7 +328,7 @@
     ASSERT(NULL != ctx);
 
     /* process SSL options */
-    uint64_t sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
+    openssl_opt_t sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
     sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif
@@ -1656,7 +1656,7 @@
 ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
            unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
 {
-    int capacity = ECDSA_size(ec);
+    int capacity = (int)ECDSA_size(ec);
     /*
      * ECDSA does not seem to have proper constants for paddings since
      * there are only signatures without padding at the moment, use
@@ -1672,12 +1672,14 @@
     return 0;
 }
 
+#ifndef OPENSSL_IS_AWSLC
 /* EC_KEY_METHOD callback: sign_setup(). We do no precomputations */
 static int
 ecdsa_sign_setup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
 {
     return 1;
 }
+#endif
 
 /* EC_KEY_METHOD callback: sign_sig().
  * Sign the hash and return the result as a newly allocated ECDS_SIG
@@ -1688,7 +1690,7 @@
                EC_KEY *ec)
 {
     ECDSA_SIG *ecsig = NULL;
-    unsigned int len = ECDSA_size(ec);
+    unsigned int len = (unsigned int)ECDSA_size(ec);
     struct gc_arena gc = gc_new();
 
     unsigned char *buf = gc_malloc(len, false, &gc);
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 6bb61b6..b8648fd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -357,7 +357,7 @@
     const EVP_MD *sha1 = EVP_sha1();
     struct buffer hash = alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);
     X509_digest(cert, EVP_sha1(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha1)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha1)));
     return hash;
 }
 
@@ -367,7 +367,7 @@
     const EVP_MD *sha256 = EVP_sha256();
     struct buffer hash = alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);
     X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha256)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha256)));
     return hash;
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
