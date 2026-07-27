Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC14C54F4E
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xv0zSlUOk2szzstBzlGxyib7OVgXa2IUsOBKeaufRp4=; b=JeVWMwFnZr+cOsM2FArJw6mzrh
	EjtE5/YbiSTbtr3mjDSsEb7k1cWHBm7TyGmZY/DiQBMu1vMkgTnkuJIQwkLX/gl21RaLAfKF4ejZS
	swXyPRnNP+XuhYoFyBgTIalL43X4dqWx2138U23bzK6+XLTsTLr5vHrJfYPSROMm3wfk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woRbm-0008Lt-8n;
	Mon, 27 Jul 2026 20:07:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1woRbi-0008Le-OU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SxS5EazCkfznQezlhD63nt8VnLSO3xzQC/LLduZkApU=; b=YMGPaFDO7Ui7+2ukT8PzwuRBeL
 qhclj7VPKWqAqyjmL3aCJ9C98qLSikJdcmWNQL5C6vDTuaTvjULen8tTzVmh4NQ6cQLjUGRtSneD6
 ivgrWTPMIBgbpk2GuLICj2REszNtBDVlXk8UPSFyULsdPIXsOLw3EaPj7KdNZpZ4XKao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SxS5EazCkfznQezlhD63nt8VnLSO3xzQC/LLduZkApU=; b=PPbNpmXvlU32N6e7oLL2IIEuNK
 8DRoKzI4D4BCGGkmExkXq4RNCD6UQf1NSVAjG15EQ5b0EdzZkx3tncQBVyak/rwZYFGwha6qKuBc+
 qEbo7UsIIrUtU73jZ5C+3wtsg/eLrJk1HQwjgmvucDSngH+JIDFd8TQUuMsByGyL+ePM=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1woRbf-0001PK-NQ for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 20:07:24 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h88l80kYVzKw2d;
 Mon, 27 Jul 2026 22:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785182836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SxS5EazCkfznQezlhD63nt8VnLSO3xzQC/LLduZkApU=;
 b=FkNWVE0IJj9XDGynifc4JhZ9PwHEP3acyA6dxnigryZ/8zzFH5pUqvtUuYYc9Td6st9K32
 tFYSUM7LNQ6tb3kQG/kJgge7BwyLUEv5pZ6bHbxuf2AOSgzTIGzmTRAQTYvTiVAXv6T8Lg
 6KLMuI2qN2A1+HKIsiHXu45fA9aP9fwEaDE25nnGN6+3upNfzZ//L5avNSEv2QieueNAi6
 qtc8v5V27wYHUw0AOgUiyTN5KOg0eYtjX7tM0tMg91yCbyt/+SWAR2SWuht03mudHdWQpo
 MoNGaWlqgrnKZPK8gCmgAp/UJnLelCnzHerbZkn36Aw9WtMEp0zwVwLhvQyPsQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 27 Jul 2026 22:07:01 +0200
Message-ID: <20260727200705.869169-6-a@unstable.cc>
In-Reply-To: <20260727200705.869169-1-a@unstable.cc>
References: <20260727200705.869169-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h88l80kYVzKw2d
X-Headers-End: 1woRbf-0001PK-NQ
Subject: [Openvpn-devel] [PATCH ovpn net v3 5/9] ovpn: zero-initialize
 sockaddr before learning a floated endpoint
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>

ovpn_peer_endpoints_update() builds the new remote endpoint in an
on-stack struct sockaddr_storage that is left uninitialized. For IPv4
only sin_family/sin_addr/sin_port are written, leaving the 8-byte
sin_zero padding as stack garbage (for IPv6, sin6_flowinfo is left
uninitialized likewise).

ovpn_peer_reset_sockaddr() -> ovpn_bind_from_sockaddr() then memcpy()s
sizeof(struct sockaddr_in)/sizeof(struct sockaddr_in6) bytes - padding
included - into bind->remote. That buffer is later hashed with jhash()
over the same length to place the peer in the by_transp_addr table, so
the garbage padding lands the floated peer in an essentially random
bucket. Lockless lookups in ovpn_peer_get_by_transp_addr() build their
key from a zero-initialized sockaddr_storage, compute a different bucket
and fail to find the peer.

This is also a plain use of uninitialized stack memory in jhash().

Zero-initialize the sockaddr_storage, matching what the lookup and
netlink paths already do.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 3554da01e406..be772d14ae41 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -221,7 +221,7 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct sockaddr_storage ss;
+	struct sockaddr_storage ss = {};
 	struct sockaddr_in6 *sa6;
 	bool reset_cache = false;
 	struct sockaddr_in *sa;
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
