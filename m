Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB3606A329
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lU2pEAL9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gOrCO9K5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G1nhM75G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OsMx1vSL1G9ROg0nJsVolOiksyys4O4XInoa6z0YU20=; b=lU2pEAL9Bwezlq
	bg/13m5oRSO/Wm4bqULcg5+Ccij7kAc5n7Q/WTLF+8B4l6XExcsuxZc5wrNrbIMMwySOhaRHs6j3O
	hvd5C7FLCTZrgFDa8QpFEjRyEdP6KsldR+eC0XqeQFktF8xdhP3FB2rfBwHLVgsMB+1wOxZ7Dq8An
	qtU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsqh-000000005Dz-2diA;
	Mon, 02 Nov 2026 14:17:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNsqf-000000005Dq-2PPe for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:17:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GMkhp7T0/8xFLaxgOcXP+dDMGriCla2eZILKMxnm3Io=; b=gOrCO9K5ZrZ8fLTRaSf/OZQrHd
 Woq1VuxUYNFlF29Trirql38geq9Jw7Hr5NEc++rGdIOjfofu/k7VMRprj55QdFBFX26J8WRxEPtG6
 U672QoZp/19QJZ3Rn5eaNtCVKqXOYSw/7EncbVWjeJRWKnFhqElKF4CGPxMkPpHIxW58=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GMkhp7T0/8xFLaxgOcXP+dDMGriCla2eZILKMxnm3Io=; b=G1nhM75G1MZJubw/7J5+oH3hzf
 MtNaM2yEcW/4aAhtDC1zOApOB4piuTWgoqvojwq9NAQZaCYZ1Yxn0e490G8X9miHasvbeXxiUfZ8w
 lY2gPT7QhkTr+tzGBkU+p1jaq64GH7QHsWB7J2ejL+kiYUvT7j27eChwajp/wchg4yrY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNsqa-000000001KZ-38zp for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:17:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2EHAIL030034
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 15:17:10 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2EHAeE030033
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 15:17:10 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 15:17:04 +0100
Message-ID: <20261102141709.30018-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
References: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNsqa-000000001KZ-38zp
Subject: [Openvpn-devel] [PATCH v2] Use ASN1_STRING_get_length instead of
 ASN1_STRING_length
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

From: Arne Schwabe <arne@rfc2549.org>

OpenSSL 4.1 introduced ASN1_STRING_get_length and at the same
time deprecated the ASN1_STRING_length method. Use the
new method and keep and compat macro for older versions and
other OpenSSL like libraries.

Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2087
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2087
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 4305fea..8309cee 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -204,4 +204,9 @@
 #define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000
 #endif
 
+/* Introduced in OpenSSL 4.1.0 */
+#if OPENSSL_VERSION_NUMBER < 0x40100000
+#define ASN1_STRING_get_length (size_t)ASN1_STRING_length
+#endif
+
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 146a384..0c36cf2 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -154,7 +154,7 @@
                     {
                         continue;
                     }
-                    if ((ssize_t)strlen(buf) != ASN1_STRING_length(name->d.rfc822Name))
+                    if (strlen(buf) != ASN1_STRING_get_length(name->d.rfc822Name))
                     {
                         msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero");
                     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
