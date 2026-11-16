Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593D606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pi/p1U9L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bpgo2V90;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D3Fzb3mO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SUXMS/jtqqoRGeFmF72C8HmUz9r5mVtCBldDzC3/0KE=; b=Pi/p1U9LRQ9vJm
	zzuJ5koJw3cGR6FZm9uXpV1GBiFvOGzqN971qFI2EjkRQ/PORq8efQMnQUF8J1zidWzpAB0DUXg99
	GJBmdu3bnpl7L/SzhEcinaQfMcyWc6KOF31Vp/wqyPAh7n3I7HrLWmE8fvKCNDmXFHbFzs5TSX2+6
	nnY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSy9b-000000005Zp-2F1y;
	Mon, 16 Nov 2026 14:57:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSy9a-000000005Zj-1LU8 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ck2dUoPcKK2PQd+LWiBbjtUMtr9yFX7q2MT/yBh2LS0=; b=bpgo2V905YMvDgsUPyKt97Rh3m
 0x1SFXvC1aQD2dh6A0HZLTFyVx4UOQGOvwhHJb9LQJwCEoXvY3rWg/VSPV9Ugi3QW8/3b8b/ROFhK
 xJa0qBKUMCM+6WE579OMZMrT73DCsfbwnSSL1NJWFlfYmjrvPpz7cpaFbEYzs12h1gtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ck2dUoPcKK2PQd+LWiBbjtUMtr9yFX7q2MT/yBh2LS0=; b=D3Fzb3mOd5w/SZ6X/UJXVj40pz
 8TqP4WTslE+twhIwFgc6+GT5BlpsMUWQ4ec1fFNh0Tzfl75eRxx+wiGjzA3cbfANtAURhLpzkV75t
 9q0SrNWy9j67MECxQZK914CPsqR8CcRtza6y126PCYiMpaCPA4PI4QAHnDkRVEsW62IY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSy9Y-000000006ic-2ket for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:57:54 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGEvjVC008312
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 15:57:45 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGEvjv4008311
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 15:57:45 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 15:57:36 +0100
Message-ID: <20261116145745.8299-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
References: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSy9Y-000000006ic-2ket
Subject: [Openvpn-devel] [PATCH v2] ssl_util: Switch get_num_elements to
 size_t
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

ALLOC_ARRAY already wants size_t.

Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2199
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2199
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 2d29e60..19a2d48 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -199,11 +199,6 @@
         ciphers);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -217,7 +212,7 @@
     ASSERT(NULL != ctx);
 
     /* Get number of ciphers */
-    int cipher_count = get_num_elements(ciphers, ':');
+    size_t cipher_count = get_num_elements(ciphers, ':');
 
     /* Allocate an array for them */
     ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count + 1)
@@ -339,7 +334,7 @@
     struct gc_arena gc = gc_new();
 
     /* Get number of groups and allocate an array in ctx */
-    int groups_count = get_num_elements(groups, ':');
+    size_t groups_count = get_num_elements(groups, ':');
     ALLOC_ARRAY_CLEAR(ctx->groups, uint16_t, groups_count + 1)
 
     /* Parse allowed ciphers, getting IDs */
@@ -1188,10 +1183,6 @@
     return 1;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* **************************************
  *
  * Information functions
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 7622d88..30ef383 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -518,11 +518,6 @@
 {
     ASSERT(ctx);
 #if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(ENABLE_CRYPTO_WOLFSSL)
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
     struct gc_arena gc = gc_new();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups_list(ctx->ctx, groups)
@@ -533,7 +528,7 @@
      * Also note that the code is wrong in the presence of OpenSSL3 providers.
      */
 
-    int groups_count = get_num_elements(groups, ':');
+    size_t groups_count = get_num_elements(groups, ':');
 
     int *glist;
     /* Allocate an array for them */
@@ -569,9 +564,6 @@
     }
     gc_free(&gc);
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
 #else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     if (!SSL_CTX_set1_groups_list(ctx->ctx, groups))
     {
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 337faed..6c17fe5 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -359,14 +359,14 @@
     return NULL;
 }
 
-int
+size_t
 get_num_elements(const char *string, char delimiter)
 {
     const size_t string_len = strlen(string);
 
     ASSERT(0 != string_len);
 
-    int element_count = 1;
+    size_t element_count = 1;
     /* Get number of ciphers */
     for (size_t i = 0; i < string_len; i++)
     {
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 6f9f65b..db5e17c 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -125,6 +125,6 @@
  * @param delimiter     the delimiter to count, typically ':'
  * @return              occrrences of delimiter + 1
  */
-int get_num_elements(const char *string, char delimiter);
+size_t get_num_elements(const char *string, char delimiter);
 
 #endif /* ifndef SSL_UTIL_H_ */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
