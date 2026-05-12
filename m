Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2F8CD4851
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQq7i3hTRaqcbiiS4msKqcJfsDwLIzslY7rbYGV/Eag=; b=BdYA8CKjuCTdgRBHTTblXmBn+i
	A0tMixhw8siCjftH1EKM5gHSItH16KHBLhuOQ+wcYkJHBrQaPqiraAzSD2FiNUual8u0Y49Sqs/WU
	MLYAuGPabzLaR4Rnjo2UNxqWeMiADgVfYn/MsUZRWfdoQqQ6fQRudCRvb1rs22D/PG78=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMoMA-000762-Gn;
	Tue, 12 May 2026 14:45:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wMoM7-00075u-Th
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QIDyo6Q12BWEooP0o6eJfp8msatQvnTtzrGnwIjsvFg=; b=c6lZDqj9/HObEOCqaqsk7wZq2a
 dHEfoTugYK5ryjNL8lgc1dcHSqf1RO98lSgY4cz3wrG0WLhOPlIh4srY6UGTLZxIXvMbx0AW803p+
 1461j7DPcN9zJCUNlCH9aTXcbXwKxCc8Us9PK0aDRu2MKNhU0FniK17Yh9jwx71QIepY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QIDyo6Q12BWEooP0o6eJfp8msatQvnTtzrGnwIjsvFg=; b=N043nRr49BA+zYRsyY+bmDMm4Z
 4QSBddLkJPfFHPapX7uC5vILkqE0B4st32q2xZxiIP8qsG+DRhbI7C7LBW1fNvfS3udqhZxdfKL0V
 NpoNyMUaQRJWYYCDwu/ixDnrRwClZMDwaiFOXdJoyYz/4LoS2sNCxsbfcCQckG3i49Wc=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMoM5-0007Id-29 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 14:45:06 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gFKBD66V3z9tnp;
 Tue, 12 May 2026 16:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778597092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIDyo6Q12BWEooP0o6eJfp8msatQvnTtzrGnwIjsvFg=;
 b=SPAbJIDIV3Y4XvIy5/wvSGBqBtbciRF5qEVgOsC7hASudIJ+Vumn77aYbOmzBO1HaevF7I
 PSJQn7arY3GLJY3ltyAAs8GKzZ2jesgvyFHT25Jtl+fDHkaIb/qHaEd95JLU/h3WnMihC/
 xkOMljO8xYMh00I96lEWh+7Zo+Zbxmfhun2+7Y123mvcFMmdJF+Pp7m5zNSKfDVrLxlKl5
 v1T/xlkG4Yf/u8Aja3w813O8VUQ1/SPPDdPRr/7coZjtqJcwYbNxYTjxunR2mqRIkd6ti5
 L9VdZvaQnnpxqS1MVgpIBQc7SjsVPjGg5nquDdGr6p6r2T8EO4mhTyHeH441xw==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 12 May 2026 16:43:56 +0200
Message-ID: <20260512144358.419599-3-a@unstable.cc>
In-Reply-To: <20260512144358.419599-1-a@unstable.cc>
References: <20260512144358.419599-1-a@unstable.cc>
MIME-Version: 1.0
X-Headers-End: 1wMoM5-0007Id-29
Subject: [Openvpn-devel] [PATCH ovpn net-next 3/5] ovpn: use bound address
 in UDP when available
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

From: Ralf Lici <ralf@mandelbit.com>

Use the socket's locally bound address if it's explicitly specified via
the --local option in openvpn.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index 78b9aea06de9..b5d1ca014732 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -147,7 +147,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 {
 	struct rtable *rt;
 	struct flowi4 fl = {
-		.saddr = bind->local.ipv4.s_addr,
+		.saddr = inet_sk(sk)->inet_rcv_saddr ?: bind->local.ipv4.s_addr,
 		.daddr = bind->remote.in4.sin_addr.s_addr,
 		.fl4_sport = inet_sk(sk)->inet_sport,
 		.fl4_dport = bind->remote.in4.sin_port,
@@ -225,7 +225,9 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	int ret;
 
 	struct flowi6 fl = {
-		.saddr = bind->local.ipv6,
+		.saddr = ipv6_addr_any(&sk->sk_v6_rcv_saddr) ?
+				 bind->local.ipv6 :
+				 sk->sk_v6_rcv_saddr,
 		.daddr = bind->remote.in6.sin6_addr,
 		.fl6_sport = inet_sk(sk)->inet_sport,
 		.fl6_dport = bind->remote.in6.sin6_port,
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
