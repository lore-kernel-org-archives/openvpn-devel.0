Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A64C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/x3u79vq4dxa6H7Nl/CvnLwe1HRi86IrLuO/mkkqzNQ=; b=JqnBTHoF6wRKLOSEUXE55eYTnJ
	FdqtbrGpf47SQ2mI90vCqip+QSj0/+RyKSI0QdSocTLX+IhA694FEccewaUYjrbdKznS6iN1CNy6j
	qTSSmHuKTSmlf3XNPZsVFp/qeLvZJrQPsFzpD1cKhk3iYhEDxuNz0UKZUaJwVfHofNL8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp383-0000Iz-OS;
	Wed, 29 Jul 2026 12:11:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wp381-0000Ie-2Q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1OjE3bgCHfNTM2NLK5OCTfl75MbZ4k/Cwc3YvLfVYAg=; b=M19OtkMQblXbmWxb6jXpnajrIS
 /qTOYdKSNk6RSKhFB96FfHzGhVtRDPibFVkZrjMUpSXr8bDuJENunZokiLrPvGa3BnxXmtMJC/Y0f
 JJcA0Ir6SxuwG5HJf0zUKsKElbRUcHTrEiD0Pflqf5qOoEVIt9MH6Dmm5dz5DRXZYS0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1OjE3bgCHfNTM2NLK5OCTfl75MbZ4k/Cwc3YvLfVYAg=; b=L
 pYTv5grtj4HHwHLgFbiAF3HCqtAnDuYHUabxV8YPSBIjO9O3lYFKguYYw1f2PvHsg5B+RMtm/j2EE
 lKCl5F9dNOFexosv/H+0xTGHfejgHIojRU/7ViiIaShU3bTiDruFFun8KVpYwlLg4J+cJLCCp6IxE
 l4XIxBQ01IbmCX9E=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wp37x-00062u-L2 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:11:17 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h99t55PwMzFrC5;
 Wed, 29 Jul 2026 14:01:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785326509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1OjE3bgCHfNTM2NLK5OCTfl75MbZ4k/Cwc3YvLfVYAg=;
 b=Ira0omkairAhODD3+d/ZwkGObe7SfWp/+GrWldFU10DeOFx73uhbzZ4DL+OIhCfaL9sIIJ
 dmaVxfJxj1Azlo9YX6dO6S9MLd/UJP7rmnPNPRC4/f6phN/XGOH/xcDoyv97RybYr/GibL
 ON4syYHjX/VSo7ZM8MtrjO7lXMqUUaOaA3ZBs8EoXyKPSIS0SVj7PawVEs1IaOkUVoDfo6
 7X/Dnatp6Fi7AZMRB6DkYbC0Ln5zXu7rtDzAHb80xzJjRYj34YC23Ey1pMk+Ui6GpwbE4J
 m8WbVuOkjy7hiPPXlgaNxSSdBgbyzY7GNym35pTgLW9ZqrENiSWWIPxjXVMV2Q==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 29 Jul 2026 14:01:31 +0200
Message-ID: <edeed888ce77bffa616da9ed98833b6c5584ecb3.1785326438.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wp37x-00062u-L2
Subject: [Openvpn-devel] [PATCH ovpn net] ovpn: fix UDP TX byte accounting
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

ovpn hands encrypted data packets to udp_tunnel_xmit_skb for UDP
transport transmission. At that point skb->data points at the encrypted
OpenVPN packet, but the skb may still carry inner-header metadata
inherited from the plaintext packet.

The UDP tunnel output path uses skb_inner_network_offset to compute the
packet length passed to iptunnel_xmit_stats. If the inner network header
still points at the pre-encryption payload, the ovpn netdev TX byte
counter does not account the OpenVPN data-channel header and
authentication tag.

Reset the inner network header before handing the skb to the UDP tunnel
helpers, so the encrypted OpenVPN packet is accounted as the UDP tunnel
payload.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/udp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 7f69e8890b5b..48172bd073a9 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -342,6 +342,9 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 {
 	int ret;
 
+	/* the encrypted openvpn packet is the UDP tunnel payload */
+	skb_reset_inner_network_header(skb);
+
 	skb->dev = peer->ovpn->dev;
 	skb->mark = READ_ONCE(sk->sk_mark);
 	/* no checksum performed at this layer */
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
