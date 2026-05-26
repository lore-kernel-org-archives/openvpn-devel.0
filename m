Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB2CD5BDE
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 23:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t1ZTKnxNlJ21b8DnJVy3g2SCl09PIytM7iPDmSMLlyA=; b=UV/uhjAYF2WaI1QrGltFFkW5Sf
	gdKXR4XX+5r4BZW72uETNEN7EbuYDGzirs+RMyfntm8Vj31MvmKBsnUh0+/gf5Y5OE9456mzrdLof
	DwrsDXsGVCdK+NkNuJeLnHDVQDVs7wZCV4DVYR27gN+zlOwbkDKpqQ7pAqVi3Z1p2kYY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wS13Z-0002rj-VB;
	Tue, 26 May 2026 23:19:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wS13W-0002pt-RY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JHZVWxjay4RYYLB6BWpD0tHu23AweFOcnfRMIKrXRfY=; b=FTA5zVUEuqfHWJDc5dE/PjE6uK
 fdNCIWX05jAGjPqsg6F8r7t2OP8iNvplWSkWSz0bJapFgZqfMzIq5/WU06VdUVjKrX5S/8OXwsZS7
 jOF3D55iaThc2iFwkE97lnHVQTdXDam+3mvYt3OmfsvMHWlMuBHoEJHWbweDkslXcxoU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JHZVWxjay4RYYLB6BWpD0tHu23AweFOcnfRMIKrXRfY=; b=UweqFdhS1r/ZdoBuI3q1yPPuD6
 g+emnjgDopW6Ga9b9eLLNqi+CxsVWk/ZpV8nTFloJqJfSjRLznno85KLA/ayoFoeHK9Sn78GA3Yr4
 2RF9y6/llD6XK/SF/Qb81QVg6h0o42q4X2UzBfIjXtthpNlCSKLb0xhBCWWTnrUHIWmA=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wS13I-0000UG-MG for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 23:19:13 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gQ7x03JKwz9tdV;
 Wed, 27 May 2026 01:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779837540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHZVWxjay4RYYLB6BWpD0tHu23AweFOcnfRMIKrXRfY=;
 b=G4XGiEjTU+kpv5H4JFvnY9p7HVZ2m7aK92ue9PPZlgCB5SGT4LGOnIvFyaHQxQkUId5OJu
 E0LQWzFxla4Duk8K4pGf0nfvcGZE3WVUf/yry7gEza3BurhKGAbbOTw+bW40PMNRsDZWJg
 kFjVobOPRSAqUIOctldudWIBLfIzjHssz8X429xS08fJlVxc69NR1gbPfvvlPauQCyxIA+
 pzSdVvucsRmEJlN2tN0gzFUp/+bUPuXEZsJkWnZEYL0VOaDjvUGoLQZEq15RX/iS8LWVI8
 +IoHVXZGUyzAK5ERg9X1HSdHhsvIGm+yfztREF2c5HqNEW/OvMpXE9Fo0/E4TQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 27 May 2026 01:18:49 +0200
Message-ID: <20260526231850.2511369-8-a@unstable.cc>
In-Reply-To: <20260526231850.2511369-1-a@unstable.cc>
References: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gQ7x03JKwz9tdV
X-Headers-End: 1wS13I-0000UG-MG
Subject: [Openvpn-devel] [PATCH ovpn net 8/9] ovpn: disable IPv4 redirects
 on MP interface after registration
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

Move the redirect-disabling to ovpn_newlink(), right after a
successful register_netdevice(): at that point the NETDEV_REGISTER
notifier has run and the in_device exists, and RTNL is held by the
newlink path so __in_dev_get_rtnl() is safe. A successful
register_netdevice() guarantees the in_device was created (otherwise
the notifier would have failed and registration rolled back), so the
in_device check is now a real guard rather than dead code.

The peer-table allocation stays in ovpn_mp_alloc()/->ndo_init, where
it belongs (it does not depend on the in_device and is freed in
->ndo_uninit).

Fixes: 05003b408c20 ("ovpn: implement multi-peer support")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 9993c1dfe471..a881510aaac0 100644
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
@@ -183,6 +169,8 @@ static int ovpn_newlink(struct net_device *dev,
 	struct ovpn_priv *ovpn = netdev_priv(dev);
 	struct nlattr **data = params->data;
 	enum ovpn_mode mode = OVPN_MODE_P2P;
+	struct in_device *dev_v4;
+	int ret;
 
 	if (data && data[IFLA_OVPN_MODE]) {
 		mode = nla_get_u8(data[IFLA_OVPN_MODE]);
@@ -207,7 +195,30 @@ static int ovpn_newlink(struct net_device *dev,
 	else
 		netif_carrier_off(dev);
 
-	return register_netdevice(dev);
+	ret = register_netdevice(dev);
+	if (ret < 0)
+		return ret;
+
+	/* The IPv4 in_device is created by the NETDEV_REGISTER notifier, which
+	 * fires inside register_netdevice() above, so this cannot be done
+	 * earlier (e.g. in ndo_init). RTNL is held by the newlink path.
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
 }
 
 static int ovpn_fill_info(struct sk_buff *skb, const struct net_device *dev)
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
