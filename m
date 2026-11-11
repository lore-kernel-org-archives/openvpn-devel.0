Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AFD606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZdEr075W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SyworBWW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kfn9uysO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=c+0XL76D1VFh868qEAlr/jYbAzVfMBHud/j7OfoDmAM=; b=ZdEr075W006sEF
	6biHl25jk3P20CEraIL9UHtIpe+IuMCZNr3qEtoThDc+1WTxv/rzkC2G5qWoff8nxlMtxZVptgKO9
	KL5CTL+lG0v4Ym0vnFHwmztD2VSMxdFhR+CRjN/YjVWAP7PUDPWs06pp1KI1QCo+cc7Dal8JPef5X
	k3I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRBKB-000000003Vk-2g7q;
	Wed, 11 Nov 2026 16:37:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRBKA-000000003Vb-2orx for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 16:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bewf/FKfxT/UTonWZdv4m72eSty1R5smN4Mfw6XpTEI=; b=SyworBWWKjBwnOrHnqspScoRlC
 PjJZfbbdFjb9ZYExGGp/adIBBDpBciKb1v3B/ZqfmQuaGpMvWGf74H9jjz33DBljft0SIdxfLtt35
 DeyanEdYsMrl7Ci9WEIH2pQtX0xNAcKA7Bn5nauKUcEPpMMZ6GTbH5cHZVpHODQKc/7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bewf/FKfxT/UTonWZdv4m72eSty1R5smN4Mfw6XpTEI=; b=kfn9uysOOF2+BqYJto0qKxRH60
 6BN3xQW07Wi48R/AUCZP0Q4FdOdkexYhlFDkqWp4aJinlJUL1y46WGauzm3rMhos3E/V8rxajgJb1
 iOqRPQFavyMfP4wA+OkhXjL9igQRTmXQu3B/4UGsDz3CYMCA2pHdSOkrDfyvm/5axkTM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRBK8-000000002Y8-2AMR for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 16:37:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ABGbH6X006385
 for <openvpn-devel@lists.sourceforge.net>; Wed, 11 Nov 2026 17:37:17 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ABGbHm2006384
 for openvpn-devel@lists.sourceforge.net; Wed, 11 Nov 2026 17:37:17 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 11 Nov 2026 17:37:09 +0100
Message-ID: <20261111163717.6369-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
References: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRBK8-000000002Y8-2AMR
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: always free the domains in
 UndoDnsSearchDomains()
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

The domains string was only freed when the search list key could be
opened. Free it unconditionally, as the caller frees the undo data
right after.

Broken since ae90cbad ("dns: support multiple domains without DHCP").

Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2160
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2160
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 81205d6..710a797 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1754,10 +1754,10 @@
         RemoveDnsSearchDomains(dns_searchlist_key, undo_data->domains);
         RegCloseKey(dns_searchlist_key);
         ApplyDnsSettings(gpol);
-
-        free(undo_data->domains);
-        undo_data->domains = NULL;
     }
+
+    free(undo_data->domains);
+    undo_data->domains = NULL;
 }
 
 /**


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
