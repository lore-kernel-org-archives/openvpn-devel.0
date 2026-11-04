Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E613606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QzxWNtG8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GX3KLnbC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AlXyvF17
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7b6coYREGBFAoVbvBaJkIKc374tiYKoSmZaZx788exQ=; b=QzxWNtG8woF8qd
	aGwqMSsy5jyQBHHWcGqCZkfCmNFjQ4Qg5NH9eQmNDkaLMR+MdOwOWNNdT+5HzekEyX3Ej6GQDE7AS
	0WUfqq2tKFlDFcAD6ZM4eW2HsQ8XKEzh32ZCt6egaG/sjExh1iE2XQGmJZu0KmeNCrBe7k9hEZHHP
	fj4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYf7-0000000061f-0NuI;
	Wed, 04 Nov 2026 10:56:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOYf3-00000000616-3d6A for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sT1zWDAz+AnVdtV4rBk3PRWikG921VuRBcABV6hVRg4=; b=GX3KLnbCv78PWnoK8meB3snY/L
 MvD0stobYRwwHMYmv87jV5Ynw0pNSnwJM4MQlnqQHY2MyAU5Hp2Y6h6C2BnPVqhqMsz7jRO2LuwIZ
 kgmlUeADeKNsQFx/8owKoI0VO7GWr/2v30Uq0bxOrNVQxBx2P5mKnHHNjg8zBq4U2nu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sT1zWDAz+AnVdtV4rBk3PRWikG921VuRBcABV6hVRg4=; b=AlXyvF17hU8EJGKZ/omtsg8mXj
 8xrFmT+1iRCHM2lRJv2HvdUwHomFRSROQQ7ND1fCrzEIrHxBVSHuKVUnzOBy1PvYT9Pj05C/MQesv
 Yx2JojQsmekr5IGRCy6Fe7jI2MpNU6NCdbcsWxlh0Jgv4E/MBfv9TJsYsqdD6zvZ9WZU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOYeZ-0000000064c-0bHk for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:55:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4AtVp2007116
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 11:55:31 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4AtVki007115
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 11:55:31 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 11:55:26 +0100
Message-ID: <20261104105531.7096-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
References: <gerrit.1793779170000.I23c6480967d4785beada3879667d50d60d7d8df4@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOYeZ-0000000064c-0bHk
Subject: [Openvpn-devel] [PATCH v1] ssl_mbedtls: remove empty
 tls_ctx_personalise_random()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

Mbed TLS 4 has no application-owned CTR_DRBG to personalise, so
494fb718 ("Add support for Mbed TLS 4") limited the function body to
older versions, and 77a04d48 ("Remove Mbed TLS 3 compatibility")
removed that body but kept the empty function and its call.

Change-Id: I23c6480967d4785beada3879667d50d60d7d8df4
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2122
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2122
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 12b6119..b701c0a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -672,11 +672,6 @@
         tls_ctx_load_ecdh_params(new_ctx, options->ecdh_curve);
     }
 
-#ifdef ENABLE_CRYPTO_MBEDTLS
-    /* Personalise the random by mixing in the certificate */
-    tls_ctx_personalise_random(new_ctx);
-#endif
-
     tls_clear_error();
     return new_ctx;
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 2150d81..b4604ea 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -327,17 +327,6 @@
 void tls_ctx_load_extra_certs(struct tls_root_ctx *ctx, const char *extra_certs_file,
                               bool extra_certs_file_inline);
 
-#ifdef ENABLE_CRYPTO_MBEDTLS
-/**
- * Add a personalisation string to the mbed TLS RNG, based on the certificate
- * loaded into the given context.
- *
- * @param ctx                   TLS context to use
- */
-void tls_ctx_personalise_random(struct tls_root_ctx *ctx);
-
-#endif
-
 /* **************************************
  *
  * Key-state specific functions
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8aaca96..45d7715 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -767,14 +767,6 @@
     msg(my_loglevel, "mbed TLS msg (%s:%d): %s", file, line, str);
 }
 
-/*
- * Further personalise the RNG using a hash of the public key
- */
-void
-tls_ctx_personalise_random(struct tls_root_ctx *ctx)
-{
-}
-
 int
 tls_version_max(void)
 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
