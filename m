Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PcOjT1MD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B7EeB3/U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y3ddYK09
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zq3KHIJko2+RBvLTQ9QBxnwTjR/tYTQtlaAFwZJKQ9E=; b=PcOjT1MDC4WCrD
	LoFEeESh31V/4ndrG+4eHYC6xZloWJDK0vWNS1IlJ+/XSFAuzoVeltXpgdFxJXeh0lfzE2RIHdngv
	3d/SL36z3kR+CAUaErDcOO1Ldgj5chy+j+hC994Xgp1gWUWahudUoEJqE3MHfZewE/hhfSjYl9EBU
	UB4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQLPt-000000008HP-0mDw;
	Mon, 09 Nov 2026 09:11:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQLPr-000000008HJ-2CWF for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 09:11:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sqOVK+VD3Tyft+rPIG2F++qHkCy4Iq3xjHLMccV95gI=; b=B7EeB3/UFCc6Nc2bPc7NlVOZB6
 7n1x5vAlatIyKOTJF3YJIUL+lQUvrHonZLWPrKAMIhkJEZYJvYfvOGTmMFVXNdBmTyZbQDpkJoJ2S
 gxGUqF7xKkkzkoKpMww9eFGxWyI8gw4pHqPZhltXzdwiRnEJxEbr4qsCOSiDsoGXgDwc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sqOVK+VD3Tyft+rPIG2F++qHkCy4Iq3xjHLMccV95gI=; b=Y3ddYK099iECsdmqd/2Mf0W9aC
 7JfcFZMiSy6GTGtEzFpbWuuUAk4n9DD8NJHSfvSsio0vt3+QoawoRnsv7I9LzYOSPUrtGNfVMZYNL
 kGZyZ4afatODIJpDAUMHYFp872W2aylIl7OTF9A3R2w86NFtWW3vL7P7PwkZ+tteqkA4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQLPn-000000001eu-0Z1z for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 09:11:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A99Be42004862
 for <openvpn-devel@lists.sourceforge.net>; Mon, 9 Nov 2026 10:11:40 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A99BeoO004861
 for openvpn-devel@lists.sourceforge.net; Mon, 9 Nov 2026 10:11:40 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  9 Nov 2026 10:11:32 +0100
Message-ID: <20261109091139.4816-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQLPn-000000001eu-0Z1z
Subject: [Openvpn-devel] [PATCH v2] reflect_filter: initialise
 warning_displayed in the rate limiter
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

From: Lev Stipakov <lev@openvpn.net>

initial_rate_limit_init() allocates with ALLOC_OBJ, which does not
clear, and assigns every field but warning_displayed. The first period
reset assigns it before anything reads it, so nothing misbehaves today,
but there is no reason to leave a field undefined.

Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2146
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2146
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
index e5226e4..953fff5 100644
--- a/src/openvpn/reflect_filter.c
+++ b/src/openvpn/reflect_filter.c
@@ -95,6 +95,7 @@
     irl->period_length = period_length;
     irl->curr_period_counter = 0;
     irl->last_period_reset = 0;
+    irl->warning_displayed = false;
 
     return irl;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
