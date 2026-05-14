Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3BCCD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N29w3QYbrhlVBhS/5hySSvE9RFz1mDjFTKgZiT/1dIg=; b=IkGqd4sadf9boXUCOWkRZIMGXu
	lw9518mFD9TkbF/PvGD9zBZDK/u/EJotwnmrGLTMvPuHbEoT1edj/nLPptHcXc66t2xKpshz5hiZA
	sr5q6zSMK/yioichs9eHGET2h2QLcyP10rMAcl7nksX3PFCYZbh+9WoFKaPRojdGWBnc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNSk3-0001el-GG;
	Thu, 14 May 2026 09:52:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <marco@mandelbit.com>) id 1wNSk0-0001eP-3H
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P7cGHdZcQ2cb3dm/1mwoHgGW2CiTsiZ51s+HG70/cF0=; b=CwaNOh3hsIdwFezhJpcd3rQO7Z
 wPuz7Iu3rA9YlODzSHcqKRYUtZr2JNhft2jDow7m6YWvZPMmh/2btDeS4eLh6Y4ez8tYXwazpcVRd
 fQSVEA8lQQbFi/ecd46GmvNgmDEKCEDT0WKAdjDExmdRDnYjLBhZbXLAj2JPjAaSni2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P7cGHdZcQ2cb3dm/1mwoHgGW2CiTsiZ51s+HG70/cF0=; b=TnJNbMsU6IFuwDW5SjQiIJvkX7
 jveREUdQDtUCPfy9VkY904xZNW1InYYpjYHKpUpEWaMchOcGTVdMRn6cQdiG/kqTo1Hpp6HmnuE+I
 9DnH87mp2VD50fWdgEaJmX7Cc8qzY8OPKPr1vrVlylkRUXmSMWyj2AFH3THlnHjJaxzU=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNSjy-0004To-NH for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:52:28 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gGQbg5hnbzDs2B;
 Thu, 14 May 2026 11:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1778752335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7cGHdZcQ2cb3dm/1mwoHgGW2CiTsiZ51s+HG70/cF0=;
 b=dOcQ9YWUu4jD0Z/ysOGxItyNNWyMH2mpLsp3BRQ6cfZYePIMeEqPcRag3q3IhCtjsNjwwR
 F+FMe5kQc1tMq82mhIqVPAtpnApkPcaVd0jHkdl7VeSuGlK1GWH6rUuJtKmxqhrWsibZ9w
 KTH5eQk6RWEdNfcTFKHbmPGbFqClJhO1Fh6T4nivCDG6j17vJ2pt19mUt1JQ6n1lbdjWwz
 WAP+7jksUefyXWdUoSK3WnezYOJwmqZqPEJinPmJY3vIL7qXpZ9OycQveGrDYflZVaLP71
 igJiZKdreMdPifGxbR2AsoUsNlTz1aNME8onMV70gYlJBZS3oAABZgBD6a3Hjg==
From: Marco Baffo <marco@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 14 May 2026 11:52:08 +0200
Message-ID: <20260514095210.288979-3-marco@mandelbit.com>
In-Reply-To: <20260514095210.288979-1-marco@mandelbit.com>
References: <20260514095210.288979-1-marco@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wNSjy-0004To-NH
Subject: [Openvpn-devel] [RFC ovpn net-next 3/5] ovpn: filter incoming
 multicast data packets
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

When the Ovpn server receive a multicast data packet that
has to be trasmitted to the peers, if its IP destination
is a multicast group to which no peer is currently subscribed,
the packet is dropped instead of being broadcasted.
Multicast control messages (IGMP/MLD) are still broadcasted
to all peers.

Signed-off-by: Marco Baffo <marco@mandelbit.com>
---
 drivers/net/ovpn/mcast.c | 41 ++++++++++++++++++++++++++++++++++++++--
 drivers/net/ovpn/mcast.h |  1 +
 drivers/net/ovpn/peer.c  |  7 +++++--
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/mcast.c b/drivers/net/ovpn/mcast.c
index c90ef2b8d8b8..59b0b62afcde 100644
--- a/drivers/net/ovpn/mcast.c
+++ b/drivers/net/ovpn/mcast.c
@@ -358,12 +358,49 @@ bool ovpn_mcast_snoop_skb(struct ovpn_peer *peer, struct sk_buff *skb)
 {
 	if (peer->ovpn->mode != OVPN_MODE_MP)
 		return false;
+
 	if (skb->protocol == htons(ETH_P_IP)) {
 		if (ip_hdr(skb)->protocol == IPPROTO_IGMP)
 			return ovpn_mcast_snoop_igmp(peer, skb);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
-		if (ipv6_hdr(skb)->nexthdr == IPPROTO_ICMPV6)
-			return ovpn_mcast_snoop_mld(peer, skb);
+		return ovpn_mcast_snoop_mld(peer, skb);
+	}
+
+	return false;
+}
+
+/**
+ * ovpn_mcast_is_control - determine whether an skb is multicast control traffic
+ * @skb: the packet to inspect
+ *
+ * Return: true if the skb contains IGMP or MLD control traffic,
+ *         false otherwise
+ */
+bool ovpn_mcast_is_control(struct sk_buff *skb)
+{
+	unsigned int offset;
+	struct icmp6hdr *ih;
+
+	if (skb->protocol == htons(ETH_P_IP))
+		return ip_hdr(skb)->protocol == IPPROTO_IGMP;
+
+	if (skb->protocol != htons(ETH_P_IPV6))
+		return false;
+
+	if (!ovpn_mcast_mld_offset(skb, &offset))
+		return false;
+
+	if (!pskb_may_pull(skb, offset + sizeof(*ih)))
+		return false;
+
+	ih = (struct icmp6hdr *)(skb_network_header(skb) + offset);
+	switch (ih->icmp6_type) {
+	case ICMPV6_MGM_QUERY:
+	case ICMPV6_MGM_REPORT:
+	case ICMPV6_MGM_REDUCTION:
+	case ICMPV6_MLD2_REPORT:
+		return true;
 	}
+
 	return false;
 }
diff --git a/drivers/net/ovpn/mcast.h b/drivers/net/ovpn/mcast.h
index e9e14d807270..9e06e893a355 100644
--- a/drivers/net/ovpn/mcast.h
+++ b/drivers/net/ovpn/mcast.h
@@ -22,6 +22,7 @@ void ovpn_mcast_leave_all(struct ovpn_peer *peer);
 bool ovpn_peer_list_get_by_mcast_group(struct ovpn_priv *ovpn,
 				       const struct in6_addr *group_addr,
 				       struct llist_head *list);
+bool ovpn_mcast_is_control(struct sk_buff *skb);
 bool ovpn_mcast_snoop_skb(struct ovpn_peer *peer, struct sk_buff *skb);
 
 #endif /* _NET_OVPN_MCAST_H_ */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 5159a8f9dfba..a9728a157210 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -779,8 +779,10 @@ void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		addr_type = inet_dev_addr_type(dev_net(ovpn->dev), ovpn->dev, addr4);
 		if (addr_type == RTN_MULTICAST) {
 			ipv6_addr_set_v4mapped(addr4, &addr6);
-			if (!ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list))
+			if (!ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list) &&
+			    ovpn_mcast_is_control(skb)) {
 				ovpn_peer_list_get_all(ovpn, list);
+			}
 		} else if (addr_type == RTN_BROADCAST) {
 			ovpn_peer_list_get_all(ovpn, list);
 		}
@@ -795,7 +797,8 @@ void ovpn_peer_list_get_by_dst(struct ovpn_priv *ovpn, struct sk_buff *skb,
 
 		rcu_read_unlock();
 		if (ipv6_addr_is_multicast(&addr6) &&
-		    !ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list)) {
+		    !ovpn_peer_list_get_by_mcast_group(ovpn, &addr6, list) &&
+		    ovpn_mcast_is_control(skb)) {
 			ovpn_peer_list_get_all(ovpn, list);
 		}
 		return;
-- 
2.43.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
