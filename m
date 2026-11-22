Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF3606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bp6K/jyu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=S9TZe5iz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dM8Sz3dU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Lu7Jy1FNAANH34hjFGxWTFjYIdPzfSLD2hUemck6T8g=; b=bp6K/jyuvKyo2S
	naLRmQRGHgyBn4H+lZbSYIohyC5JunvBiFff50g0p5Q6PhTlTgTX8KZuuknN1cb+GBK/y08SMPFVH
	i5/hULDVKEKRmjtrNU8rfjlWhiKFuqIvb3fSU1yPAvSo1990uYYE7cGQq9FAWwGNSJYLts0yRUGLu
	8+A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5bp-000000007Ox-3rtc;
	Sun, 22 Nov 2026 11:19:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xV5bp-000000007Or-1rCh for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D3Ip1vqHM5R91g4weBgnfd7D76Im/6vyTRwCjqBawW0=; b=S9TZe5iz2BaWQT8GMcgqda7Q+x
 vxl4Uij1FeJfXgGE4+BjVD0945YE+dQ686NVjflx6SZv++BcLHkerZNAIrbvro8WbXbQKKnqM2rvE
 5Tja0p8Fe52TR4oubryoAuRD8bKZ2dZ1N5bP/m4EGs01ka3bV8JyaR6cnPwt+2t7wp7E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D3Ip1vqHM5R91g4weBgnfd7D76Im/6vyTRwCjqBawW0=; b=dM8Sz3dU2bG8gdprpBwXZVwhoN
 ZRJYDKiHflIW8u8csshwOIJBualxeCftgAIfJn9ht5LlV5VqbDRZucMCWY7m9iPvlKCvZ/tIjs1np
 hN+aAphvFf+UPOmfcLPUj9lKfOcna4Lk902/5Zj4AphDigBrIZzhq1ggHDCwiy2S2EnQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xV5bo-000000005Pi-1bSr for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:19:49 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AMBJeoQ031708
 for <openvpn-devel@lists.sourceforge.net>; Sun, 22 Nov 2026 12:19:40 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AMBJe42031707
 for openvpn-devel@lists.sourceforge.net; Sun, 22 Nov 2026 12:19:40 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 22 Nov 2026 12:19:33 +0100
Message-ID: <20261122111940.31671-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
References: <gerrit.1795207472000.I1d36996218c3c61f1f16e2c97f922afa66df6b66@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xV5bo-000000005Pi-1bSr
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: check room for the DHCPv6
 name server separator
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

From: Heiko Hund <heiko@ist.eigentlich.net>

GetItfDnsServersV6() added a separator between addresses even if only
the terminating zero still fit into the buffer, overwriting it, and
relied on inet_ntop() failing with a zero size buffer afterwards.

Return ERROR_MORE_DATA before adding the separator instead.

Change-Id: I1d36996218c3c61f1f16e2c97f922afa66df6b66
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2234
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2234
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 24705a9..32b1688 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2256,7 +2256,12 @@
         {
             if (i != 0)
             {
-                /* Add separator */
+                /* Add separator, if there is room for more than the terminator */
+                if (s < 2)
+                {
+                    *size = 0;
+                    return ERROR_MORE_DATA;
+                }
                 *pos++ = ',';
                 s--;
             }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
