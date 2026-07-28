Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02091C54F54
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LO4FpBapn/kWixcblzlYC0Q9G/fM1QaDvR/ssXqDM0s=; b=AD6MjVZp66Ob3RTHZ6xXlIqZp7
	RP6GjBn5ed8a7uCYx+f2Bh8kAEBqu9ozxqzv7nTSbOBqp4MNtlvQdY4GRzuSLZQSVNOMvJ9ozvm9+
	CMShUyeOD1H0nw8VUTYw60MCShMO53F0R9BrKq4KCtrrLMJQmj3wsULgUOXmXAtc+BH4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogJ8-000663-T7;
	Tue, 28 Jul 2026 11:49:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wogJ6-00065p-1W
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OB1wJIkO3dO6uhO/DiOC9lTI+DvWuIBap7OwdXV6sls=; b=bDvHygDWhEXS6TGKB0mr6ZeJJg
 uqMXxB7Y5CM0+YXzGZ5JBzPB7MLnW/QcsRomeE3biHU0SBVRhC42SuQMiriMSRGowpfVJHWMTPFP9
 cBBl6Qoc7nHfqhENw6h7GS7qh07YTIPpKDO2Sseb5VBijG8f0W3EcQ2Yc854ZEEOpx/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OB1wJIkO3dO6uhO/DiOC9lTI+DvWuIBap7OwdXV6sls=; b=Z6AbPy8iXtNmNF5aIEyVSmCWpx
 yVLGC7taDX/mDDOKeR19AWkHC+bpyFzWQcXAULCKpd8tTKojru7zqB66V/FsEskiUjVYrL/0MLMc5
 fl8IVCOQxv5bj28QR9dbyHHzp4K7cCyltIfC1J0TLPriWuhwkmwX8YCJ15MVX9M9H3E0=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wogJ9-0003Bo-Lg for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:49:12 +0000
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h8Ydr1ry5zMlHV;
 Tue, 28 Jul 2026 13:49:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785239344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OB1wJIkO3dO6uhO/DiOC9lTI+DvWuIBap7OwdXV6sls=;
 b=zOfUB+psEc+MJbKKKU8ikmPhfeug5oDd1yxrlZYp92x/+Ij9hEsa5iui6VWQhT9K+M6s5X
 sRwq3hgqPv+0mVvJ/ujGWP/+SfHENRzFquzvD2Y/CHML8KR2ZTak55iUjENWwsLdYM+zEF
 4EffhKKa4KZ9UA3BIZTtfHg36VRwhQdC6tAOUz1hB7AutOrmSxz6SIY8pn9d6AgSCL4aLQ
 lAhgoX8ty2Lv2crOoFzMvuWGs0pv7KIMJFJo/c5oMoHzjydXKr5xTQ9oTmwznIR3M5KjzF
 1M9hDw/+F4lBoU/RzdsFuC//Qf0DyvBMFAmYUeqmW77OQqE2VHFyp9WMBID+WQ==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 28 Jul 2026 13:48:51 +0200
Message-ID: <20260728114855.1323861-6-a@unstable.cc>
In-Reply-To: <20260728114855.1323861-1-a@unstable.cc>
References: <20260728114855.1323861-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wogJ9-0003Bo-Lg
Subject: [Openvpn-devel] [PATCH ovpn net v4 5/9] ovpn: zero-initialize
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

Build the floated endpoint with a designated initializer so the
padding (sin_zero for IPv4, sin6_flowinfo for IPv6) is zeroed as part
of the assignment. This keeps the padding out of the by_transp_addr
hash key without memset-ing the whole sockaddr_storage on every
received packet.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 3554da01e406..00971bbd3dcf 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -244,9 +244,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			 */
 			local_ip = &ip_hdr(skb)->daddr;
 			sa = (struct sockaddr_in *)&ss;
-			sa->sin_family = AF_INET;
-			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
-			sa->sin_port = udp_hdr(skb)->source;
+			/* use a designated initializer so the sin_zero padding
+			 * is zeroed (it ends up in the by_transp_addr hash key)
+			 * without memset-ing the whole sockaddr_storage on the
+			 * RX fast path
+			 */
+			*sa = (struct sockaddr_in) {
+				.sin_family = AF_INET,
+				.sin_addr.s_addr = ip_hdr(skb)->saddr,
+				.sin_port = udp_hdr(skb)->source,
+			};
 			salen = sizeof(*sa);
 			reset_cache = true;
 			break;
@@ -272,11 +279,19 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 			 */
 			local_ip = &ipv6_hdr(skb)->daddr;
 			sa6 = (struct sockaddr_in6 *)&ss;
-			sa6->sin6_family = AF_INET6;
-			sa6->sin6_addr = ipv6_hdr(skb)->saddr;
-			sa6->sin6_port = udp_hdr(skb)->source;
-			sa6->sin6_scope_id = ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
-								 skb->skb_iif);
+			/* use a designated initializer so the sin6_flowinfo
+			 * padding is zeroed (it ends up in the by_transp_addr
+			 * hash key) without memset-ing the whole
+			 * sockaddr_storage on the RX fast path
+			 */
+			*sa6 = (struct sockaddr_in6) {
+				.sin6_family = AF_INET6,
+				.sin6_addr = ipv6_hdr(skb)->saddr,
+				.sin6_port = udp_hdr(skb)->source,
+				.sin6_scope_id =
+					ipv6_iface_scope_id(&ipv6_hdr(skb)->saddr,
+							    skb->skb_iif),
+			};
 			salen = sizeof(*sa6);
 			reset_cache = true;
 			break;
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
