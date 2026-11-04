Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FA8606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mGkOBjIC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=deeR+SIg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FI9q5wO1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kpGCQu64j6Wx0RwSV2YFj/Vdkpd1Z4y5FtLh5HgFnGk=; b=mGkOBjICfjqOFb
	v5LQmQB04V1uTzvwVQ+mjc1X/9XbyEr8RlYFE9XZ45dU/rw/A0snuKNhvzskFPpyur+1RYY0PNbRq
	cs/jwoypnaNdVqvSfl8Yi5TRKCLPRx0dS0fws25vHaLNlC+hXbo/emHhRD+ELrNYv/E5A7xWnT9ec
	qVU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOZz7-000000005kl-3PcD;
	Wed, 04 Nov 2026 12:20:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOZz6-000000005kd-137Z for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:20:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XlpjipfyQI315qFxDmjahlTs4JELYkp6Ob7OqB+HnBg=; b=deeR+SIguYk495mBnLBcN+Yb4g
 TjnQKEdHlBOuyD1R+TnpnGzHTyMoZnlzvCLe4tAnB17qvcX4Y7GijKckpCoJfPvDQSQ3s6eSIwlVD
 DzZ8Br8oapUAy/RVlTSgEhRbCZoeYrTI40qekPfJU8mex2JldliQNweeBIZWgXikwm0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XlpjipfyQI315qFxDmjahlTs4JELYkp6Ob7OqB+HnBg=; b=FI9q5wO1WxuQF306A5MmIVL237
 CKuYVj97BYgMFD/zHBY0ponL34ku72Xiv5VuzGhpYmSzFiOolgSKpw7VNBgb4tX9EcpcDGzV4TNO/
 T66CXMPuPXu2aEDF1cqd+S1nasT47NFM5eqZg7oRIGqgPb4PrUJDAo2YI2avJpKGu6bo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOZz5-0000000087j-0E7h for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:20:56 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4CKmN6015619
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 13:20:48 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4CKmU4015618
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 13:20:48 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 13:20:42 +0100
Message-ID: <20261104122047.15606-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
References: <gerrit.1793776256000.I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOZz5-0000000087j-0E7h
Subject: [Openvpn-devel] [PATCH v1] manage: fix "cr-response" typo in
 unsupported command error
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

Broken since caf1b903 ("Use a template for 'unsupported management
commands' error").

Change-Id: I427bd9ef8b4903cbc1386d3dcef1b68a460b44c8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2116
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2116
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 58f63e6..c1e89e9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -886,7 +886,7 @@
     }
     else
     {
-        man_command_unsupported("cr-repsonse");
+        man_command_unsupported("cr-response");
     }
 }
 #ifdef ENABLE_PKCS11


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
