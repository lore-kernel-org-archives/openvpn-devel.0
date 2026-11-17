Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEA606A32F
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HfBMAUPs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CBeub3WE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mLo/leUz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IWBRRSX2TC/jPluXmOKSyfwfiOj5HSk6Sv8dBnNKXDs=; b=HfBMAUPspOFF4/
	U8dIXBX/RDQnVqwQFsPukzYHNFYrBAhun0ar5LFW8ELla05Us0NMXw/LEeh1EjLgtD1uUmm1Ko0+s
	ZO5CnQG9nVu4x7lzgTxFKAHbKPnErvvQG8JEGN6KhkGz1UddGxObEykpaQSHyqERe5EL3/6wdtOBA
	k38=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNQ8-000000006yW-2JZP;
	Tue, 17 Nov 2026 17:56:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTNQ6-000000006vh-407F for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:56:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tXx6E4gMMzZqCi1R4tzDrvp6nVu9arxhk+yRdOMzg4U=; b=CBeub3WEknEI/cYf5td28rbsvA
 QUlEoxJ6ACU5ZNI1wxPc8OQsxwEVQJcfF+tMTHpXVdmBWPxjOany6TCtn8wrfhj2rkZkjRO1Ymfzk
 DBzSdRJu961o8lBIoxcm7A9+Z76pKPCBdxDYyzLZGK6Pl+0TNla2qDGn840lvwFfD3hc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tXx6E4gMMzZqCi1R4tzDrvp6nVu9arxhk+yRdOMzg4U=; b=mLo/leUzq2K9eNFn9OkxtzCAA7
 j7jbxpl92jN6LOv0aMMJb1apKt48MHCSlUcx6JZFnh4XUgRuwXCOWKqJTXqKWefdToyHF2B7P0Rop
 HWTpwcnQQp24aWfQVFfgF7Ndv0pCKibwR5QHmQ96LhC/0nhHnHGpdW66X7ogUn5vAh/k=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTNPg-000000000ej-3ulj for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:56:14 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHHu6nO014972
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 18:56:06 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHHu6Vd014971
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 18:56:06 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 18:55:58 +0100
Message-ID: <20261117175605.14945-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
References: <gerrit.1794827563000.Ib645e0bf5c8941f4b1e14f13397794be15eab68f@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTNPg-000000000ej-3ulj
Subject: [Openvpn-devel] [PATCH v2] ssl: remove obsolete preprocessor guards
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

- MBEDTLS_SSL_CBC_RECORD_SPLITTING and its API were removed in
  mbed TLS 3; the minimum is now 4.0.
- INFO_CALLBACK_SSL_CONST is never defined.
- TLS1_3_VERSION is already used unguarded, and the only caller of
  convert_tls13_list_to_openssl() isn't guarded.

Change-Id: Ib645e0bf5c8941f4b1e14f13397794be15eab68f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2189
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2189
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 19a2d48..dbc1b9d 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -892,15 +892,6 @@
     mbedtls_ssl_conf_renegotiation(ks_ssl->ssl_config, MBEDTLS_SSL_RENEGOTIATION_DISABLED);
 #endif /* MBEDTLS_SSL_RENEGOTIATION */
 
-    /* Disable record splitting (for now).  OpenVPN assumes records are sent
-     * unfragmented, and changing that will require thorough review and
-     * testing.  Since OpenVPN is not susceptible to BEAST, we can just
-     * disable record splitting as a quick fix. */
-#if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTING)
-    mbedtls_ssl_conf_cbc_record_splitting(ks_ssl->ssl_config,
-                                          MBEDTLS_SSL_CBC_RECORD_SPLITTING_DISABLED);
-#endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
-
     /* Initialise authentication information */
     (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key));
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 30ef383..4d4a990 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -159,11 +159,8 @@
  * Print debugging information on SSL/TLS session negotiation.
  */
 
-#ifndef INFO_CALLBACK_SSL_CONST
-#define INFO_CALLBACK_SSL_CONST const
-#endif
 static void
-info_callback(INFO_CALLBACK_SSL_CONST SSL *s, int where, int ret)
+info_callback(const SSL *s, int where, int ret)
 {
     if (where & SSL_CB_LOOP)
     {
@@ -425,7 +422,6 @@
     }
 }
 
-#ifdef TLS1_3_VERSION
 static void
 convert_tls13_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)
 {
@@ -449,7 +445,6 @@
         }
     }
 }
-#endif
 
 void
 tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
