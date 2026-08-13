Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3C2C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vxnO9Kt1UKMHJ9ODVFvcTIZaFzPSJ47VHbxUShRwQiw=; b=kvcsRweQezSM5+d6dc9rD5HOGo
	uBpmTp1eGrOkcC2mvlZFpUvQE31DVngX9/+4xM5atFvczb2/H9RFL19KR8Po9R2mAfmn9egYb2Udi
	DhwOWaexpaHmIdh4Jq1HTAt5lSlKf5Kt4XlN+SONNWMVcwAAXeXYMRp7vRI9iHNQFChQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYMp-0003FL-Qg;
	Thu, 13 Aug 2026 16:33:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuYMT-0003Eg-KG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CB76UEGzndmMt+4F9gxhueQ2km3tsKsgx/MNWOKZEDM=; b=NUKW0IzhVVOQ266awxFZXKckNI
 B7/JL01SgdbGJ6AtR1kG6vz5AJhpMvK72XPt/6CmjHW4XcwH1OpXncIAbPWkOQXSyx2vEpTQSi9Q3
 /Q7IaZjMG4CPF0CUFpV5+YkpKqMQ15hvEbtnSlrT8mwTPSrQYVt3XtiIPcJHxDcBse2E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CB76UEGzndmMt+4F9gxhueQ2km3tsKsgx/MNWOKZEDM=; b=KlouPXJ/UcFTJArgbtjoSgLgcO
 Wv1XED/4vEYOwEDSc1oo0jzotJ58qn1r8oxz5r/jzwWAsvnRY0/PeNDQEcbjdjhGLQKl6jrD5LL+T
 0Manav1peTyAiLz4Zd5bvpbBg4nV0q8a0wJgUW0U06GmW9vBXyyaSpgOio+pXFLknBdo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuYMI-0004Cw-Oe for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:32:48 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DGWd5u026579
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 18:32:39 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DGWdFD026578
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 18:32:39 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 18:32:33 +0200
Message-ID: <20260813163239.26557-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
References: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuYMI-0004Cw-Oe
Subject: [Openvpn-devel] [PATCH v1] OpenSSL: avoid resetting the HMAC key on
 every packet
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

From: Gleb Pesin <dormancygrace@gmail.com>

OpenSSL 3.0.3 and newer can reinitialize an EVP_MAC HMAC
context with its existing key when EVP_MAC_init is called without
parameters. Use that path instead of supplying the digest and key
again on every OpenVPN HMAC reset.

Retain the old parameter-based reset for OpenSSL 3.0.0 through
3.0.2, where parameterless EVP_MAC reinitialization did not reset
the underlying HMAC implementation.

Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1840
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1840
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 1191f20..2019280 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1209,7 +1209,7 @@
 
     HMAC_Final(ctx, dst, &in_hmac_len);
 }
-#else  /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
+#else /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 hmac_ctx_t *
 hmac_ctx_new(void)
 {
@@ -1275,10 +1275,14 @@
 void
 hmac_ctx_reset(hmac_ctx_t *ctx)
 {
-    /* The OpenSSL MAC API lacks a reset method and passing NULL as params
-     * does not reset it either, so use the params array to reinitialise it the
-     * same way as before */
-    if (!EVP_MAC_init(ctx->ctx, NULL, 0, ctx->params))
+    /* OpenSSL 3.0.3 fixed EVP_MAC reinitialization with an existing key.
+     * Older versions need the parameters, including the key, to reset. */
+#if OPENSSL_VERSION_NUMBER >= 0x30000030L
+    const OSSL_PARAM *params = NULL;
+#else
+    const OSSL_PARAM *params = ctx->params;
+#endif
+    if (!EVP_MAC_init(ctx->ctx, NULL, 0, params))
     {
         crypto_msg(M_FATAL, "EVP_MAC_init failed");
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
