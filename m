Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12983CD8C81
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0x2fvMR+B7s39Ep9hyaUkEUtQaS1LBTliAylM71lrwc=; b=QxcO8Gd6A+dw2tB6KGTuLqdZI1
	C68uZmOgFoa95Ym4lllodMSPPu1CEyXzUrPMWyPSqNt3yblol2S6yfrveajEoViDB56IN3MZG42BW
	SBYGaOC4QTZdh8k4zTRuzmZnQ3+/HvA5Hp7yT9nKRnhFYGeW2LabO4pKNtXUZeTwdW8M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVUN1-0008VN-8I;
	Fri, 05 Jun 2026 13:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wVUMx-0008Uz-Q8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 13:13:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6eZ9HnErO8SQMdn4QNJxUd7AjK2FRNQoImFn8yEW9Nw=; b=S5RpIUTVPTTVz9CXsXkNJFApFY
 zosQ4va3TkXX2OhrevtPIosBCoCiXvAu5yKLTJj53+rvycYvcLOkItKtQUDPkMRZFHursLxhkEIo/
 2D1QWXLTU4Bw6+o1Rm8FPXJ+L+nDt7akIrkh+qwmC6P1BARTgfS/9YSXYZ2WQiGvvgDQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6eZ9HnErO8SQMdn4QNJxUd7AjK2FRNQoImFn8yEW9Nw=; b=f
 HmYo2cP2s7GZOsi5TEGXNOS0KKNskGRpIsqd/+e9g+XhYGO/1/GzvxL7y4OZOGHALUygg1fD1LT+a
 n+qAdh1sReQLWNvMpcxsMXAFBPeaVf/zuwxQiOonVw2ybBIASx7ZYW1RJrxnAtZmxFwfk8ZDvVc0r
 JY+M4hDdHcpb5828=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVUMx-0006tV-C5 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 13:13:52 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gX21t2xQ9zDs54;
 Fri,  5 Jun 2026 15:13:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780665218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6eZ9HnErO8SQMdn4QNJxUd7AjK2FRNQoImFn8yEW9Nw=;
 b=zYIp1mBtTgZlq06Q7BaSeplu7ec29RKC63H35DXB8NzXb4a3wniHGqLWtbYJo9eukyrfDC
 zkQWpggJQcMDgWUtkqurU9/NJTklGLYwe5lTec3dH0oBdOTyXu0sjUEQpYv6ziB33zEkzK
 6DrxzYL4nRa6HJPuElfy0lpLNWx2g41a6mucyKbmU3xVj81F9KQXJbjZ/lXE60xpL88y3K
 tyaj3xD0Iy6SeCkeY6Ei1Tdqqt1RdnH1vqJeS3tevFxx2aS3XbBYPpGHmN+0zpTE38G1Of
 P+8oh0hi7eRSR9Ph9mUQRo0K/ZYz2P2++Y/zyORiYrwL8LnySh3BcZWl7Xnduw==
From: Ralf Lici <ralf@mandelbit.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  5 Jun 2026 15:13:07 +0200
Message-ID: <cover.1780663425.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wVUMx-0006tV-C5
Subject: [Openvpn-devel] [PATCH ovpn net v2 0/4] ovpn: harden UDP TX against
 mutable socket state
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

Hi,

v1 added setup-time validation for userspace-provided sockets and TX-time
checks for socket state that can still change after the socket is attached
to ovpn.

In v1, ovpn_udp_send_skb consumed the error internally, so
ovpn_encrypt_post could still update link TX stats and last_sent for a
packet that was dropped before transmit. v2 propagates those errors back
to the common TX completion path, so TX-side checks are handled as local
transmit failures, not as successful handoff to the UDP stack.

v2 also makes socket/remote address-family mismatches fatal for the peer.
Those mismatches mean the peer can no longer transmit with the socket it
was configured with, so keeping it around would just keep dropping packets.
The peer deletion is deferred through a common transport-error work item,
which is also reused by the TCP transport-error paths.

The source-port-zero case is kept as drop+warning for now. It is still a
broken socket state for ovpn TX, but it is not treated as a peer-fatal
address-family mismatch in this series.

Thanks,
Ralf

---
Changes since v1 https://lore.kernel.org/openvpn-devel/20260526124544.425791-1-ralf@mandelbit.com/T/
- Add ratelimited warnings for TX-side socket state failures.
- Propagate local UDP TX errors to ovpn_encrypt_post, so local drops do
  not update link TX stats or last_sent.
- Delete peers with TRANSPORT_ERROR on UDP socket/remote address-family
  mismatches.
- Add a common deferred transport-error deletion helper shared by TCP and
  UDP.
- Clarify that netlink socket/remote validation is setup-time diagnostics;
  the TX path remains the runtime gate for mutable socket state.
- Use a single READ_ONCE() snapshot of sk->sk_family in the netlink helper.
- Fix the IPV6_V6ONLY typo.

Ralf Lici (4):
  ovpn: avoid sending UDP packets with source port 0
  ovpn: validate sockets before attaching peer transports
  ovpn: reject UDP remotes incompatible with socket family
  ovpn: recheck UDP socket family before transmit

 drivers/net/ovpn/io.c      |   4 +-
 drivers/net/ovpn/netlink.c | 133 ++++++++++++++++++++++++++++---------
 drivers/net/ovpn/peer.c    |  19 ++++++
 drivers/net/ovpn/peer.h    |   5 +-
 drivers/net/ovpn/socket.c  |  16 +++--
 drivers/net/ovpn/tcp.c     |  21 +-----
 drivers/net/ovpn/udp.c     |  57 ++++++++++++----
 drivers/net/ovpn/udp.h     |   4 +-
 8 files changed, 183 insertions(+), 76 deletions(-)

-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
