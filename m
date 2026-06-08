Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7060CCD8C9D
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sihv14qL/NYG8Vm1v41cAf20MnZRabmtEcW0zJqw81A=; b=DoUomnz+PaVdPaOCJacuzPsCcg
	53QaiV2AJGD9KSKdZWboW5aSc2K3WIdGh5QfBXi9RPrLzHyetFx1CKpmUDt5NAN490DIsUCpcbhd6
	tyZRTv5aqFXtgPuprgpJE97jS42cJLQaTCQgm2fMk2Q0TMTNfrtxq0Ihs8sTdRR7M06U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa6N-0003OH-6b;
	Mon, 08 Jun 2026 13:33:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWa6K-0003Nw-DX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adDWVCSSk383woR3Mgckz7wFutvD2s6h4QcW7/qgDKk=; b=JtCdBbOt54WxYwb5ud7o5lEkiB
 +7x73+38QrEDtaB0xzwFfCR3192wUzAtVNJJrtnM20MNGLEETDfGGAuutK2nNfajktmHtnhqV/tbW
 T2yPI/SS38HvhShW97MPX5wBPHKwDkoOCiBxvcGT5iKVhQN574yrVCVM1cJd/FaMijaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=adDWVCSSk383woR3Mgckz7wFutvD2s6h4QcW7/qgDKk=; b=PR7XeS54JyDnASu3L+TZkZ//u0
 BG5VwM/vnCW7a4VIz/RlN9KWwm1mc/nFKVoVPGd798D0xr7hSkle7J2s0ddPsanp76pMLDrzG/PA3
 TsF5ycgrYGsKx81Vb3ND2zNTsQ4Gahq0DEG3Tn0QrKnHHWxmVMrNy2DJo5+G9LD3f3bQ=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWa6I-0004wb-Eb for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:33:12 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gYtJp1pP9z9tPH;
 Mon,  8 Jun 2026 15:32:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780925578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adDWVCSSk383woR3Mgckz7wFutvD2s6h4QcW7/qgDKk=;
 b=SWOjuNmiYTpKMwMiZg3Gy19RAvXNXnsaKgZDe2GVkAx/erM0UlOWLGZZK2L90SJdhxixhs
 vYh1cF1kYOqisM+K79newmuXFUnbo6iHHwV4Uni44ZDvEIjQl/gAGNv5CDkkYKVQ6a0Cii
 tG3scAwqt+fWxpPThEjQ9MxGp7pY7FA4jKe5iAiawha9gsyc787kYUcpdQUD1P335nqfbH
 /9GezyICuayPbXn/Tqnaoi3E9F2+ruDt3JeR+1k1f39rRnf3dTRZxGGdPspS40tqXy3emM
 t4oAuM1Y4BqneiR2tmDVztwOr0sXpPom36hpAnlQoQ3M+03x1NmZC5lLd0N7HA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=a@unstable.cc
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  8 Jun 2026 15:32:48 +0200
Message-ID: <20260608133251.3128542-6-a@unstable.cc>
In-Reply-To: <20260608133251.3128542-1-a@unstable.cc>
References: <20260608133251.3128542-1-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gYtJp1pP9z9tPH
X-Headers-End: 1wWa6I-0004wb-Eb
Subject: [Openvpn-devel] [PATCH ovpn net v2 6/9] ovpn: zero-initialize
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

Zero-initialize the sockaddr_storage, matching what the lookup and
netlink paths already do.

Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index ee88251f2196..4aa5edc75dec 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -220,7 +220,7 @@ static void __ovpn_peer_hash_transp_addr(struct ovpn_peer *peer,
  */
 void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 {
-	struct sockaddr_storage ss;
+	struct sockaddr_storage ss = {};
 	struct sockaddr_in6 *sa6;
 	bool reset_cache = false;
 	struct sockaddr_in *sa;
-- 
2.53.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
