Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828C606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lyehIDWz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m8BxN5ur;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V6mIEDwm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QXdexjyhUms8YpzSN4kd2J7CiZjG/1U78E/5ojZKe5E=; b=lyehIDWzeDy9Y8
	v8WTxdL8y/oHaOtoKDVYqBRkXBKmCl2iSIvafKuNZ48UUi8+uE2xmmqjt+cHiqx5Xb2EueJiY68QN
	jUeW3vbRNmjWjc2n3zetCzRwXeNJ/UA7DvLuY8E/XLRWcnngGpKoeTMsYZw08Ywfv4mOvggdftLMf
	LCw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUmOj-000000005Zg-1Hsq;
	Sat, 21 Nov 2026 14:49:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUmOi-000000005ZZ-0P1M for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:49:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ExzMidO66lj0vuL3MgyZGbWd/tbloxlU1w3SDdMzgI=; b=m8BxN5ur/3ONH73ElXzytdCxFE
 csfHb7vcSi1VoStqTQL9SSP+bcgnIwlpnsgQCVQ6d6rcK3vK2BV+p4N7S0EvZX4w9b0MhXcG2n44u
 W7otKiYg5PNRV27HLtzwfuYgVsX82lYd0O5DxQ8phtFq/SU078/n0xzXoqxlIRZCS4t8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0ExzMidO66lj0vuL3MgyZGbWd/tbloxlU1w3SDdMzgI=; b=V6mIEDwmE/1tnYno1nRa9DHsTE
 jpWvaptyjJny0cO7OTL2W6DH9s+Ald0LFVXbzp43AAKO9hyLWke/p8uQg2iuVPOeE/1EMAQqPQEy6
 VaAs68tUMGXZ227gKMwLwhT9KUUYM5Jv1Wc/iwqEUmDGBhLHn6TDe1fpANirHKBpY0AQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUmOg-000000004Rw-19Vs for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 14:48:59 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ALEmpAD026747
 for <openvpn-devel@lists.sourceforge.net>; Sat, 21 Nov 2026 15:48:51 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ALEmp13026746
 for openvpn-devel@lists.sourceforge.net; Sat, 21 Nov 2026 15:48:51 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 21 Nov 2026 15:48:45 +0100
Message-ID: <20261121144850.26734-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
References: <gerrit.1795173017000.I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUmOg-000000004Rw-19Vs
Subject: [Openvpn-devel] [PATCH v1] route: initialize the table of
 block-local routes
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

add_block_local_item() allocates the routes without clearing them and
left table_id unset, so the routes went to a garbage table. Use 0, the
default table, like the other internal routes.

Change-Id: I1d516b1acee3edc2a69c670d62f49e3cd34d6dc7
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2227
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.7.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2227
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 4dfdd5f..5b1d012 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -557,6 +557,7 @@
         /* split a route into two smaller blocking routes, and direct them to target */
         l2 = ((~gateway->netmask) + 1) >> 1;
         r1->flags = RT_DEFINED;
+        r1->table_id = 0;
         r1->gateway = target;
         r1->network = gateway->addr & gateway->netmask;
         r1->netmask = ~(l2 - 1);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
