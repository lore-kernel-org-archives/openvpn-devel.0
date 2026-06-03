Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4590DCD6E55
	for <openvpn-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uqXfI/dCgQCGxowSPiOCZb/12tkN56dI8Z8kaZERiOs=; b=a6yHsrftBhYNFduIszEC9/CZPi
	qCqS1RxhqSZyxDsAck9Gqgjikm1UNoL4c4iKK8RAYGPXpz/njtg+bdS49DkGwCJQ3lxuMuL4C6RpJ
	tXvg3av7FbuZtWKZnPIT99qIgXTFogTDYgnHvlomCtsvE/4M8dyUssI6fAvZa7GS6rSA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wUmvf-0006Q9-Cy;
	Wed, 03 Jun 2026 14:50:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wUmva-0006Q2-NG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 14:50:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pxNi6HAtD/FgO+847ryv4NPAVaAGFqOxsws/YdMkiyI=; b=WZPuUaVUavEytwWaaUv6G8mBu5
 47f2gHsEMwD+wrt0tJdtDlKwTwd+1mfSasDgIT0o2IzDzh3bqeaE2QSZeP39I8DRI1JFrjhY8AJzN
 ahZg/OmdYzrWfh18mAxhsJqeLKfG/nEmit44t64GoHUeAdes3i3o8h5dh36EcNwy0Gvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pxNi6HAtD/FgO+847ryv4NPAVaAGFqOxsws/YdMkiyI=; b=F
 W3ZutXJdHBmPCegtk/IUwFtiyaSubmD+vyCkkSyT0K9+0zjHktxZSwdKG7ST0Q6zdMrhfGkeIM9Ue
 aEXTFKnfR9l0r52NxfSkibtIK7zOXISuZ1EcikNBbelmjg4s6pCu2zyk1wwOkBn2uXJOUHT41NLd9
 /1PABA2diLWTPziM=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wUmvT-0001D8-5g for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 14:50:40 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gVrGR1dmKzDsS7;
 Wed,  3 Jun 2026 16:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780498223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pxNi6HAtD/FgO+847ryv4NPAVaAGFqOxsws/YdMkiyI=;
 b=WTdHfdSDYVWv4OedQRxBGFkktLJUkYhXjdp3NkLL4/PxW94n7gG0pgDFf+r8tn2YXUTYOj
 2F+L38Nmt1hTqEl4ABHFRAteVj2y2tLAlh6hEIU09x9O7QRe0wMZC64zbohpN8JBj6/j6c
 4/n55LeEDDid/RQwk7ynOXk0iRRfuONEujU9EzgUesQwsCPNBOAW6nVlvQMu1cTtIhCaV8
 4YeBv/LDVRniRTRdJUxflMulKGSzSmleIxtJ9/RwW5rhWZaLKY8S7L2uw+thibZSKIS48J
 yf5mc6SfoHoymdgHPOQmyrALtcKjI0WFiWY5ewIfUjhywPkE260plIVRYN2ZWQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  3 Jun 2026 16:50:05 +0200
Message-ID: <20260603145007.603632-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wUmvT-0001D8-5g
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: add missing
 rtnl_link_ops->get_size callback
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

ovpn_fill_info always emits IFLA_OVPN_MODE inside IFLA_INFO_DATA, but
ovpn_link_ops does not provide a get_size callback. rtnetlink therefore
does not account for the ovpn-specific attribute when sizing RTM_NEWLINK
messages, so ovpn_fill_info can fail with -EMSGSIZE.

Add the callback and reserve room for the mode attribute.

Fixes: c2d950c4672a ("ovpn: add basic interface creation/destruction/management routines")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 2e0420febda0..43c36e7cc81b 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -217,6 +217,12 @@ static void ovpn_dellink(struct net_device *dev, struct list_head *head)
 	unregister_netdevice_queue(dev, head);
 }
 
+static size_t ovpn_get_size(const struct net_device *dev)
+{
+	/* IFLA_OVPN_MODE */
+	return nla_total_size(sizeof(u8));
+}
+
 static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct ovpn_priv *ovpn = netdev_priv(dev);
@@ -236,6 +242,7 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
 	.dellink = ovpn_dellink,
+	.get_size = ovpn_get_size,
 	.fill_info = ovpn_fill_info,
 };
 
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
