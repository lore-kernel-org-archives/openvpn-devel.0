Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A736C54F52
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ogwDEVF9CzV/ilHmRI+bqTiOhMnfPJtRPd1h7Y4VslQ=; b=lKZLParv9JyyA9MjeKc6scFv75
	LG3TUjVogcgXR5GpWmSYYzzkrrVCot7RoZppeHdB66+Zsu36OQbucD/C5L0Gbr+vfok91zOaRFNJD
	82Q8D+MluGNDsQ6RQb/mVWfmKOhoITqsO8hydbH6ze7eEiIFl4BHhuJwfKpjg/yOuq2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp4Y3-0008M6-IU;
	Wed, 29 Jul 2026 13:42:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp4Xp-0008Li-7I
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZI3+vxXVDzBF1IyI8qcsoNbY9W2dj8LRI/yhlhtT40k=; b=S6qt4XpJzNf4M4n6e46GCtWf/6
 /8okAUDSaENgQqjr8fO+5O5s48VQ7/RMM8lxMzxJGkI+9ZbINqTQzK/8kG6CnjfmJRYqeLBPgmr3A
 c9EQrtGAzv7FMBJNbe1GPLrcHNeSSQHI1ETYsQ665w/dNO2vxwIv+PDvk3Ew16iBXWIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZI3+vxXVDzBF1IyI8qcsoNbY9W2dj8LRI/yhlhtT40k=; b=m
 /QxpIk0pPfEKJ9JyDVFjeutYfdmdWBne8cXIvpP2td8cb0dfNEs0f67ovnOGM5acXv0dQpl1RurkR
 5WO5s5CGldgaH4lZhR5i0w24HUlHyxTg7WM1uDJIOusLBa71Ut6gdV3t6WPAzhkbrXH1+fc5GtxH9
 ikqFGLGvhXzJ6S6A=;
Received: from mout-b-203.mailbox.org ([195.10.208.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp4Xr-0006wT-10 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 13:42:01 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4h9D5W4QMQzLllb;
 Wed, 29 Jul 2026 15:41:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785332511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZI3+vxXVDzBF1IyI8qcsoNbY9W2dj8LRI/yhlhtT40k=;
 b=i4MamIAbU1BH4/a4yh9a9EJMPr+sATtIr9aUgMG1t65lZLuFOSxcUEmH3YzLJDiJOjBFer
 pcCT6ZzLW3u1x2uFjtu59szdRjlxy2aEvyGeGL+hwwW9kkTm6AqouqpDjaN0NDdnRLPIgn
 d7EfGMFpPp4n8lon61lPQPr0ePskYz/OEtUUmuX72Fx9Hrv9+BVNg3Zqtxr109uUeVPqyh
 3ig8R9ARsTomMD4uu0/dMuu44j4km1NZVwdJf5U9PVlcyMOj+/5nQf+q5NoLO8n11RSoYi
 TsziXSIyZPaupasapbCtBZH6Vl0ycNDq+qKOfx5xFzegzt2DndXYW+vcU7cUSA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 15:41:30 +0200
Message-ID: <bd44d25247e13a6f0c7d72a17db03cbf17b351e6.1785330764.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h9D5W4QMQzLllb
X-Headers-End: 1wp4Xr-0006wT-10
Subject: [Openvpn-devel] [PATCH ovpn net v2 1/2] ovpn: add missing
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

ovpn_fill_info emits IFLA_OVPN_MODE inside IFLA_INFO_DATA, but
ovpn_link_ops does not provide a get_size callback. Consequently,
rtnetlink's size estimate for ovpn link messages does not include the
nested mode attribute.

Available skb tailroom may hide this mismatch. When the remaining space
is insufficient, however, ovpn_fill_info returns -EMSGSIZE and message
construction fails.

Add the callback and account for IFLA_OVPN_MODE.

Fixes: c2d950c4672a ("ovpn: add basic interface creation/destruction/management routines")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
Changes since v1 https://lore.kernel.org/openvpn-devel/20260603145007.603632-1-ralf@mandelbit.com/
- Clarify in the commit message that the incorrect size estimate causes
  a failure when skb tailroom is insufficient.
- Add the selftest as patch 2/2.

 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..9d9a0ff690d6 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -210,6 +210,12 @@ static int ovpn_newlink(struct net_device *dev,
 	return register_netdevice(dev);
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
@@ -228,6 +234,7 @@ static struct rtnl_link_ops ovpn_link_ops = {
 	.policy = ovpn_policy,
 	.maxtype = IFLA_OVPN_MAX,
 	.newlink = ovpn_newlink,
+	.get_size = ovpn_get_size,
 	.fill_info = ovpn_fill_info,
 };
 
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
