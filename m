Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CFDC44503
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=snf86ACK7pR/66YC38aPi3X1DEvpWi3gjafw99J7Jq4=; b=aiDRlPanEB2sIxpKVLgTEp8OrU
	IJRfgDwEDu3Wr71MLsuV5cURoIQaHMis9ORaTedWJc0iqoIctcsgs2YLTr7h8zx0lu2N2gB3sd4N5
	x0O4z9rgj2QWt6acFEkzjY6Dt5EdQUJBF9Ue6OMc1R+5bofWOgJcoi2+2w410c5umYDw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wghaz-0000Qf-4z;
	Mon, 06 Jul 2026 11:34:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wghax-0000QR-4u
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3ZkA9c6PszFdxD78qgW/7qFDfcs1CN1vNs0EKzltPtk=; b=hljvTr/a+qjpb5L+EGNjVHyQwK
 XEzfc3bO7Gm09o4QpJmXRDxFdpKtmD69/e0Xl7c23wpxF73FrPlg7yIfcf4A1YRIXFYqpU8ORnx3Q
 YXRdjE2A8ByWB5BodixJMxc03gxJoN4xELeKVsWN3E6E6ImIBF57wgjY55xKrtvd/6NE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3ZkA9c6PszFdxD78qgW/7qFDfcs1CN1vNs0EKzltPtk=; b=fOofZ4zcwueEJEvG186rvwPi16
 PuIp7McOmFV1PJru1TIw7zKWIkKzyxK9vpOQZl3wVR5qI8bZ2wVkSJhTud79ka93cotV6jNfW3bgV
 RIpJ+pHx7seGEfCHWJxP7b3KpW/kFVGRvcJix53NX9h7KA2QPMqJrrQgl7gY5UA/lhFM=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wghar-0006lt-F1 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 11:34:36 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gv2M03kSlzDvmW;
 Mon,  6 Jul 2026 13:34:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783337660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ZkA9c6PszFdxD78qgW/7qFDfcs1CN1vNs0EKzltPtk=;
 b=Y5PqyC+nhRhHUklfTbgKiGAHmWTG5gwjqaN/0UD3hSSzRQDxLQjdnH7e5N2pBZ0LkFIkZR
 r9kHxkM2Mzm1QyssqOOHLAdpZzGn1lJDjfAsDLUwbvSWCEXABptmnHVQNFbI4En18fxGDq
 A1KI+e2OM/+BlvHt4sAuYeJrI0USid7ASPwVSWFw4hB7SbugNgvxPb258nSYu/xFHKYIni
 32tx5nxpp/XG6b4t7rmSV9MvqJaLDoU5peBoMaru+2LGv+kSe7AWAhkcuBaALPAKCy7eXp
 iC5yp6l1Er+SgZFWMM9FF0ZawgLNBEDPnmihINI336nNJ6y171bPb6Vd+bXC0g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  6 Jul 2026 13:34:00 +0200
Message-ID: <6e44855f0fcd704da43dd83b42a1236cb804c76e.1783336121.git.ralf@mandelbit.com>
In-Reply-To: <cover.1783336121.git.ralf@mandelbit.com>
References: <cover.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gv2M03kSlzDvmW
X-Headers-End: 1wghar-0006lt-F1
Subject: [Openvpn-devel] [PATCH ovpn net v5 2/6] ovpn: use nla_put_u32 for
 the key ID attribute in ovpn_nl_key_swap_notify
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

Currently, in ovpn_nl_key_swap_notify, the OVPN_A_KEYCONF_KEY_ID
attribute is packed as a 16-bit value despite being defined as a 32-bit
u32 attribute in the YAML policy.

Fix this inconsistency by using nla_put_u32.

Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v4 of this series https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/
- Add this previously posted standalone fix to the series so the whole
  set can be picked in order.
- No changes since v1 of the original single patch
  https://lore.kernel.org/openvpn-devel/8577555cc95646d0bd58a5b78e59c7e6a9b1a0c6.1783058844.git.ralf@mandelbit.com/

 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 4c66c1ec497e..abf038206a62 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1335,7 +1335,7 @@ int ovpn_nl_key_swap_notify(struct ovpn_peer *peer, u8 key_id)
 	if (nla_put_u32(msg, OVPN_A_KEYCONF_PEER_ID, peer->id))
 		goto err_cancel_msg;
 
-	if (nla_put_u16(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
+	if (nla_put_u32(msg, OVPN_A_KEYCONF_KEY_ID, key_id))
 		goto err_cancel_msg;
 
 	nla_nest_end(msg, k_attr);
-- 
2.55.0


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
