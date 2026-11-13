Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA26606A337
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ffam38g7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gf1YAAW6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PvCvsMmY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4xRLJPs5cb9jQG2CXVT7/aRTN6v1EYw6whYG+p6pnPc=; b=Ffam38g7YCG6Uo
	U/nJm7Q5Bg4ERbwQmM9JHBbCQbHBv34+P0QwWvR/F/db27s3Grh9omHh/7W4RX3FTTBLliM0iCXUn
	qQqEj+17GwCxEHHkMS1gAZL6KwdfXqjnR431pbe8Yr8RKr7/rAT7yje4ZzwstSEkwMm7QQTZdvfqx
	mTo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRwvR-000000006rX-3ATf;
	Fri, 13 Nov 2026 19:27:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRwvQ-000000006rR-0d49 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 19:27:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zairybfA9aDxaaAD3IO3EMYa7S0qLWQDiw8n9WrFzW4=; b=Gf1YAAW68JuPk7cRvWmmzmhmVW
 a25+HojEWnOnIQg6lA6fCVyLOpKEcfWz2uu6vSs2wINggGQiaU8OrTLgjMCowxPDhwL7hBgyHzPer
 dHVp3o9N5R/iQK3bsA0X7eqf6CDxk2Lrs0BhcvrXWN+5seVlUDA5uN5/pMBv4CheoQLE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zairybfA9aDxaaAD3IO3EMYa7S0qLWQDiw8n9WrFzW4=; b=PvCvsMmYF4tDK7y1i94aTrpLk2
 a6MeTpOX6AnL2FxZ/mwXvEaUv7F+W8RIStcD+/DjDjiLFil10arKygOaNbjkcKWUuRIIF9wZ7pmb+
 7h6Pklbbpeg6twUV7lJY7g7OjtT763JCYF0yeViPJK4Iv8Kff1XU9t27RPgFMWxsRKj0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRwvO-000000002Z9-09Ed for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 19:27:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ADJQsP1011352
 for <openvpn-devel@lists.sourceforge.net>; Fri, 13 Nov 2026 20:26:54 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ADJQswQ011351
 for openvpn-devel@lists.sourceforge.net; Fri, 13 Nov 2026 20:26:54 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 13 Nov 2026 20:26:48 +0100
Message-ID: <20261113192654.11321-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
References: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRwvO-000000002Z9-09Ed
Subject: [Openvpn-devel] [PATCH v1] init: free actual_name when replacing
 the Android tuntap
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

With --persist-tun, do_open_tun() frees the old tuntap struct but
not its actual_name, leaking it on every reconnect.

Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2171
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2171
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3bc4de4..6664a4d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1845,6 +1845,7 @@
         if (c->c1.tuntap)
         {
             oldtunfd = c->c1.tuntap->fd;
+            free(c->c1.tuntap->actual_name);
             free(c->c1.tuntap);
             c->c1.tuntap = NULL;
             c->c1.tuntap_owned = false;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
