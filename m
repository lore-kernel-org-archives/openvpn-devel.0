Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A31ECD5BD0
	for <openvpn-devel@archiver.kernel.org>; Tue, 26 May 2026 12:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YsfB5XNRGcNL6K8hcUGjENev9BrugD8QyyXalmO1PuQ=; b=CS+LvS3LU7+VYYUEcjYgslspOr
	nM/sj2BciJBztQdAfOKbtQfvUEZbhYXY8v+zArlFNaFubXYVse9uWvzaFBoVuERxJbvuSk2c6kFhv
	nZ9oGqQ/LffWsb5xsVHj6ftchh6rLp+m2yT+YoeaDGCj64tLMBSCwP2OaatYTK2g4zUM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wRrAm-0007a4-DD;
	Tue, 26 May 2026 12:46:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wRrAj-0007Zu-Eo
 for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nx9PlGRrQ+xzXm4gen2I/NdhH3MCs3z5a5q3sWzBPGQ=; b=CoWgwoH7R9AEL8jNTjGKNMCIOS
 daSadMP8bdcaau/1S+4/+SIxoTCuRXiYP3dEYq1Hr9VYQbEMgLevqf2gzOJe/tzVieYVJ80TpG8al
 wiBN/FfFQ+zd7S+gNkGW5kwG6GbD+UlwDlb6PNSUvpohinS6SROxdliw/+2oL9WQzoCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Nx9PlGRrQ+xzXm4gen2I/NdhH3MCs3z5a5q3sWzBPGQ=; b=Td4eF4Ka8LlymjfUgOxI5A3iad
 BzEcx6hx+1l7+hRbAxouKL40aRIsukcpYfaDYn0aRVNjRySM8AcdT+wA9E0Ee0J8qCOfS9bpqrrmJ
 05bjSldkFG1fdBzMWdTRJjLELz3fXt1o1Ioyp3yI/C32md0tbkfm0dtmRSUHduo1TXnE=;
Received: from mout-b-201.mailbox.org ([195.10.208.61])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRrAh-0007ZQ-TB for openvpn-devel@lists.sourceforge.net;
 Tue, 26 May 2026 12:46:13 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-201.mailbox.org (Postfix) with ESMTPS id 4gPstb3dcrzDrqx;
 Tue, 26 May 2026 14:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779799559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nx9PlGRrQ+xzXm4gen2I/NdhH3MCs3z5a5q3sWzBPGQ=;
 b=qK+cV2ORIx9d8P10GGgN32lhjEiw/XTVlU1/jvTH24v5KuqpYBilJ+9oaBNjwjGQiy2R79
 eFoE+A7MO0G7vg4uEUb3q9l3V1KMO/k8DaIsHWzUC0QQE7NjPjT/lKu7blcmZMRj2WnGgk
 5Cd3LfVNk8NjGgTwt0wfuHXJYhQuEjKvw1VRJo7NayOnivJ7BCBrhsvPbHx4nP8l8sxVnv
 PYgtipQ15E/oZiykTjIq8W14wiG4cDq1rlP6ZEpZpmpGNzVM5JhqkTCnk1FBOWRIhAZ2lX
 /JCwTtxRfbSCzCUAiM5YhTV/aceNQZo01pSL3ieV74jNx0QWTvHXKT0wMkBwTQ==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 26 May 2026 14:45:41 +0200
Message-ID: <20260526124544.425791-4-ralf@mandelbit.com>
In-Reply-To: <20260526124544.425791-1-ralf@mandelbit.com>
References: <20260526124544.425791-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wRrAh-0007ZQ-TB
Subject: [Openvpn-devel] [PATCH ovpn net 4/4] ovpn: recheck UDP socket
 family before transmit
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

ovpn validates UDP peer remotes against the socket family when the
remote endpoint is configured through netlink. The socket itself,
however, remains owned by userspace and some socket options can still
change the family seen by the transmit path.

For example, IPV6_ADDRFORM can turn an AF_INET6 socket into AF_INET
after ovpn accepted an IPv6 remote. Conversely, IPV6_V6ONLY can make a
dual-stack AF_INET6 socket unable to send to an IPv4 remote.

Recheck the socket family in ovpn_udp_output before selecting the UDP
transmit path. Drop the packet with -EAFNOSUPPORT when the peer remote
family no longer matches the socket state.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 drivers/net/ovpn/udp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 2610f3e23bf0..9a3d3dc11235 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -320,18 +320,25 @@ static int ovpn_udp_output(struct ovpn_peer *peer, struct dst_cache *cache,
 		goto out;
 	}
 
+	ret = -EAFNOSUPPORT;
 	switch (bind->remote.in4.sin_family) {
 	case AF_INET:
+		/* userspace might have set IPV6_ONLY */
+		if (unlikely(READ_ONCE(sk->sk_family) == AF_INET6 &&
+			     ipv6_only_sock(sk)))
+			break;
+
 		ret = ovpn_udp4_output(peer, bind, cache, sk, skb);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		/* userspace might have set IPV6_ADDRFORM */
+		if (unlikely(READ_ONCE(sk->sk_family) != AF_INET6))
+			break;
+
 		ret = ovpn_udp6_output(peer, bind, cache, sk, skb);
 		break;
 #endif
-	default:
-		ret = -EAFNOSUPPORT;
-		break;
 	}
 
 out:
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
