Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB36BC624C6
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wiahpgtpEzFghRW7VAYO3kcCwauNWGi7VtSHiF392vk=; b=WDZrwvUPcVXg+7MLG6MLqE0tqM
	/VAfb+AZEjg0FSkSB6PQyYWJbi7gD4w8gChYKnVKKXo1T8rtSnLkcFtFYNPC9OGiWKCp4JtQ4toxV
	9XDMIgnInT6ofixwZfY0P8SuTS+xCsKIlX2nVEXHnnqTvYa41Pfcv5h7VUqrfOBx2kT8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x172k-0005Dn-Fk;
	Mon, 31 Aug 2026 18:47:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x172j-0005Da-M4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IbST3yRHxo4JFtuKJga9fthHyreHuyfMJ27tE1h61sQ=; b=ho86e1+BNklO6HhDjOHedw+AAL
 klj21bMb+eC8OWIUtX34yG7V5gmgITIOgbLuuctv+qBXxDXge/8SUJM3bWP2XwivPT9L8bRrxgIv2
 KGK6zRmwxAWeN5l52MBltpns3fM0Lms210WzIvsVm2EDLWsX+aoUzxLbO0Q+2vCV6n1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IbST3yRHxo4JFtuKJga9fthHyreHuyfMJ27tE1h61sQ=; b=aLoJaGVpNX8ggYfetkGjNb/9xb
 eaGWLG9M+vBo3tP033JnpmP+qCZQ9Df98t2wQq0nmb8qJoVDkchCq5HJjT/W6F0tzLHpoa8DcF1Pr
 NdFZa+YyuLUtrAx2B/Jpiqu8cjaneNWh3obQQhAf2QODmTjeaubMMwA23s4qFoLYy8y8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x172h-0004C2-Oq for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 18:47:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67VIlXO0003435
 for <openvpn-devel@lists.sourceforge.net>; Mon, 31 Aug 2026 20:47:33 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67VIlX5V003434
 for openvpn-devel@lists.sourceforge.net; Mon, 31 Aug 2026 20:47:33 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 20:47:26 +0200
Message-ID: <20260831184732.3417-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
References: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x172h-0004C2-Oq
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: fix off-by-one input
 validation
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

From: Heiko Hund <heiko@ist.eigentlich.net>

Code checked for a hypothetical third trailing NUL character,
instead of the second. Could read one extra octet beyond the buffer if
it is used up by the data completely.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
CVE: 2026-78221
Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1888
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1888
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0c6e23f..d2288b9 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2959,7 +2959,7 @@
         const char *rdom = msg->resolve_domains;
         size_t rdom_size = sizeof(msg->resolve_domains);
         size_t rdom_len = strlen(rdom);
-        if (rdom_len && (rdom_len + 1 >= rdom_size || rdom[rdom_len + 2] != 0))
+        if (rdom_len && (rdom_len + 1 >= rdom_size || rdom[rdom_len + 1] != 0))
         {
             return ERROR_MESSAGE_DATA;
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
