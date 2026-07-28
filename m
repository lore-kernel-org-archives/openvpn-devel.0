Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEE4C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WVBJxS8hJ21PO9M0cCVGQ3NZ//jvWPqSrDtCfNWize0=; b=gxdjU3NomUzanX9SBiJ/9mTz4m
	Z57o82MdYe8r+brHPPpYB5pXMs0P/Zbwud8FhCrByjXqA8I1BUlxiWIfLvlxXQw9wFKM0ZQ/LFv0O
	SGxuPcXcFkdVtADINIWHsDBOtVo+8SbZvZSF3O4FM+ZOQHn+0+Z895zl5a6QhRmFF6io=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogJ9-0002oV-5Z;
	Tue, 28 Jul 2026 11:49:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wogJ8-0002oL-0f
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YJuazhbGH4Gvwf2Gu6aH9UhNU90q2oiwbgb+HRB7nF8=; b=CGHYsTMnsJerZS8PFblKm0dp2L
 uSJn2ZqRS5UuYFMjaSPOBwPyk9Nm6IPhCFxtBmnX3eyNABAoGS/0j8Te7j0fLaZ8+h2u58YqP6Tc1
 BJHk6vK9MfzI7elnluuo0iFMTivv0jsz0uSU4IkWRpci25HDS6jSkq86u+EuUi6TQYN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YJuazhbGH4Gvwf2Gu6aH9UhNU90q2oiwbgb+HRB7nF8=; b=VFGMH8Nc6HsBtnD8HwAyWP99GY
 5nlCvhi03OJuG6ruflrHRxH76tAyWIGaVLKlZI8fwXapRVNbsbiDdJ+TgLbge9I0nifcW0z7aPd8A
 vIITA6dYsy2UC9HeZs4W4sdOUGORjm+l5SFqAJWsZDzOMjCXRMlhf+R/nFCcc2fTVd5k=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wogJ6-0002uq-IZ for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:13 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h8Yds2z0bz8tYs;
 Tue, 28 Jul 2026 13:49:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785239345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YJuazhbGH4Gvwf2Gu6aH9UhNU90q2oiwbgb+HRB7nF8=;
 b=opeNHN9fVF9oJhtWvO/hI0x6yz2DB0qTnJbQI7cLKmlxqhSeIkOIQbhWjfMff9O4xcsokw
 fJbQlrwp1t15fHhVXkHlFQ9c+upZNkJh+mmKJ6GFo25yv3cut06pyS7UW2uhOd16+o43l7
 E4CAtz2p9tkAU118JGCZ89o1+QotwmXEmO+HfySE3twwfWNtEd8iOkCXYdrS6z6FJVTB0S
 hUoeBsCeuPtSLaeVXa8y9XUw+SIR5nOdQNtKYzmjp2cWdngTNu+nfe3At0wozdesqo201W
 65g4F5+8JMERrSCMlGtaKELIgx0QZZbOVcIoBz4meFCzROTrgCpRwkrY/UkJ6A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 13:48:53 +0200
Message-ID: <20260728114855.1323861-8-a@unstable.cc>
In-Reply-To: <20260728114855.1323861-1-a@unstable.cc>
References: <20260728114855.1323861-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h8Yds2z0bz8tYs
X-Headers-End: 1wogJ6-0002uq-IZ
Subject: [Openvpn-devel] [PATCH ovpn net v4 7/9] ovpn: disable IPv4
 redirects on MP interfaces
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

ovpn_mp_alloc() tried to disable SEND_REDIRECTS on a multipeer
interface, but it runs from ovpn_net_init() (->ndo_init), which
register_netdevice() invokes before the NETDEV_REGISTER notifier
chain. The IPv4 in_device is only created when that notifier reaches
inetdev_event() -> inetdev_init(), so __in_dev_get_rtnl() always
returned NULL at ndo_init time and the whole redirect-disabling block
(both the per-device and the per-netns IPV4_DEVCONF_ALL write) was
dead. MP interfaces therefore kept emitting ICMP redirects.

Disabling redirects only once is not enough either: the IPv4
in_device is destroyed and recreated when the interface is moved to a
different network namespace (NETDEV_UNREGISTER/NETDEV_REGISTER), and
the newly created in_device inherits the destination namespace
defaults, silently re-enabling SEND_REDIRECTS.

Disable redirects from ovpn_net_open() (->ndo_open) instead: it runs
every time the interface is brought up, including after the in_device
has been recreated, so the setting is always re-applied. This mirrors
what wireguard does in wg_open(). RTNL is held on the ndo_open() path,
so __in_dev_get_rtnl() is safe.

Fixes: 05003b408c20 ("ovpn: implement multi-peer support")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 50 ++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..c4e775250727 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -35,25 +35,11 @@ static void ovpn_priv_free(struct net_device *net)
 
 static int ovpn_mp_alloc(struct ovpn_priv *ovpn)
 {
-	struct in_device *dev_v4;
 	int i;
 
 	if (ovpn->mode != OVPN_MODE_MP)
 		return 0;
 
-	dev_v4 = __in_dev_get_rtnl(ovpn->dev);
-	if (dev_v4) {
-		/* disable redirects as Linux gets confused by ovpn
-		 * handling same-LAN routing.
-		 * This happens because a multipeer interface is used as
-		 * relay point between hosts in the same subnet, while
-		 * in a classic LAN this would not be needed because the
-		 * two hosts would be able to talk directly.
-		 */
-		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
-		IPV4_DEVCONF_ALL(dev_net(ovpn->dev), SEND_REDIRECTS) = false;
-	}
-
 	/* the peer container is fairly large, therefore we allocate it only in
 	 * MP mode
 	 */
@@ -97,9 +83,38 @@ static void ovpn_net_uninit(struct net_device *dev)
 	gro_cells_destroy(&ovpn->gro_cells);
 }
 
+static int ovpn_net_open(struct net_device *dev)
+{
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+	struct in_device *dev_v4;
+
+	/* the IPv4 in_device (and thus its config) is recreated whenever the
+	 * interface is moved to a new netns, so redirects must be disabled on
+	 * every bring-up rather than once at creation time, otherwise the
+	 * setting is silently lost after such a move
+	 */
+	if (ovpn->mode == OVPN_MODE_MP) {
+		dev_v4 = __in_dev_get_rtnl(dev);
+		if (dev_v4) {
+			/* disable redirects as Linux gets confused by ovpn
+			 * handling same-LAN routing.
+			 * This happens because a multipeer interface is used as
+			 * relay point between hosts in the same subnet, while
+			 * in a classic LAN this would not be needed because the
+			 * two hosts would be able to talk directly.
+			 */
+			IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
+			IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
+		}
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops ovpn_netdev_ops = {
 	.ndo_init		= ovpn_net_init,
 	.ndo_uninit		= ovpn_net_uninit,
+	.ndo_open		= ovpn_net_open,
 	.ndo_start_xmit		= ovpn_net_xmit,
 };
 
@@ -183,6 +198,7 @@ static int ovpn_newlink(struct net_device *dev,
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct nlattr **data = params->data;
 	enum ovpn_mode mode = OVPN_MODE_P2P;
+	int ret;
 
 	if (data && data[IFLA_OVPN_MODE]) {
 		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
@@ -207,7 +223,11 @@ static int ovpn_newlink(struct net_device *dev,
 	else
 		netif_carrier_off(dev);
 
-	return register_netdevice(dev);
+	ret = register_netdevice(dev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
