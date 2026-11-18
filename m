Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C43606A32C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Js/VJcYP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cgAOEqme;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZXFY3nnq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CIf4CHbJB6quSBt3mtzw8JgtBdAuFf8lMYSkE31W99E=; b=Js/VJcYPm6YWpL
	sWGqvratF4ano906zDws9m64HbvjhNT40BgVk5oO7bkZs831YSC5XUqM1fLQWIcMGF401TObG1foy
	D31zVPdAvTDdbqO480Yv9+FkMWWmcTsU2MY0JaZr+nBB83AoNcr9TUNx1VbYQLXUnRnYyKQwn0BE1
	vSI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThLJ-0000000057Q-3SUo;
	Wed, 18 Nov 2026 15:13:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xThKt-0000000056v-10IM for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RwzW17I/F3v6nyGePrtzikLKAgr/9hS9wrkQkz8VkIw=; b=cgAOEqmeYmOF/P1ncLm9uLbThw
 M9aYjIVsRLlK+9Zr5KgUR8nfpCObPAadJVwnX9WbOy8gHDqn2PVQCiOsuWWlw+WsnXUdYTb6if/T4
 sCEOoL5mqxD7GBAsbQc/P83gOv2GiInPWjGsWZ42wsVELUmRQh0i66RmAH2xHW3Yr9EY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RwzW17I/F3v6nyGePrtzikLKAgr/9hS9wrkQkz8VkIw=; b=ZXFY3nnqxAECIQu5AFAEt/eO8U
 b7CTOi6wdWktLp8kDAwCSGKrCyfD7zlzi3JgZOoq/Pv07JF0hi4XU3wat/Xj8MGcWKtO3R6HXl+2K
 P6BlE4iLSX4JguNTYYCz6tnk/FBmPN2pDq9c50AwQMCRwnkKrhFVT/IHgGF1bg2+iejM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xThKq-000000003za-1cuG for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:12:35 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AIFCP9k014899
 for <openvpn-devel@lists.sourceforge.net>; Wed, 18 Nov 2026 16:12:25 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIFCPTd014898
 for openvpn-devel@lists.sourceforge.net; Wed, 18 Nov 2026 16:12:25 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 16:12:19 +0100
Message-ID: <20261118151224.14866-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
References: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xThKq-000000003za-1cuG
Subject: [Openvpn-devel] [PATCH v1] ssl_openssl: don't log inline CRL
 contents
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

With an inline <crl-verify>, crl_file holds the PEM data, and the
"CRL: loaded" message printed all of it. Use print_key_filename() as
the other CRL messages do.

Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2216
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2216
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index b95de8e..7fdb3c5 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1415,7 +1415,8 @@
         }
         num_crls_loaded++;
     }
-    msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_loaded, crl_file);
+    msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_loaded,
+        print_key_filename(crl_file, crl_inline));
     ssl_ctx->crls = crls;
     BIO_free(in);
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
