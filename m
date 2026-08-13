Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8EDC5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B31pKALrTRdXJJqPujo0Hn0qaUm0jzORDJwDL8ZOcsY=; b=eQMHOa5+/S3MfhePdVlMmEZSfP
	GSEi2t3jmDtqc+JReg6bDdHXrU2wDssRScfNDq0u7EJ7FPv/+8SHSY8PTfpru+o6iiVpNbKUubwIq
	83YNJuhKwftU2+hfEIugoVXDdI5bFgfuZiggSM0xtQVDs8Jfe2JvEYznxyLX1gBmwGzE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuZCT-0004M5-8L;
	Thu, 13 Aug 2026 17:26:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wuZCR-0004Lj-0Q
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:26:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HdptWVzEd2vpzNK82GHYwwobNQ1NZVq2mciuL+021vQ=; b=XtMyhBcIlMUhE6SQSZYB2bM1is
 +HS6EhjQ2DEVFvZtaDOpX2pPzqBl3q6O7zfLG5+NVnYpCrsi/bmOPWQpdIep9Qtv2mJKKi4GJqWvM
 NLTOHgQTyVgkJy2waezm8YruXP0N6r+mmzHce+KU61vViD9w+51HQLggnj3/heREFJIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HdptWVzEd2vpzNK82GHYwwobNQ1NZVq2mciuL+021vQ=; b=mpS0IdvCPdCmYRajKWdbRENd0v
 E533AeqI86PwtvWSRj5cpxOmCqq3FU9WWVM5k3tSXLTMvtstODXiKTSHgW4G4m4Iz8yYSViWJQuvL
 m+2IJzbRsCnYdH7zVMOpnE3hgeYHQpyPfYOwg60ki11s+m7GcrPotjEzYOFNZH6syk4A=;
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuZCT-0000Be-7n for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:26:39 +0000
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 364FC1D000E2;
 Thu, 13 Aug 2026 13:26:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Thu, 13 Aug 2026 13:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786641992; x=
 1786728392; bh=HdptWVzEd2vpzNK82GHYwwobNQ1NZVq2mciuL+021vQ=; b=S
 HP63ZEdTIBIggVbOUC7dGhrnpZM6DHZVEv68RT20HRgg9zV7XCyjIc0DAi+hyFNA
 WS7dOZEtBx0cqZ9gkDLbcCs0BKE3ZhgM15zg9LSfNsGBUO8dTXKFODA+sZ5NqJNX
 A91O30er9H+HT2UOlEmrUiwMOSzfkKLiRrUndjzP0olnJd5u1Cj69hVP4F8RDw1G
 r7sVXp5OAIemoX3W18/Y4/Ssxtv2XtT6H7LTqzR+pJNyGJxbr8LZUOaTHAMLXvbf
 fm0U35wsikSpxldWFFWJ1zVUas6QNW2pd9m8EisP8ePSg0pHig5R6fyMY5b+OdVC
 sOkp3bu5SxwUei7RPk1Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786641992; x=1786728392; bh=HdptWVzEd2vpzNK82GHYwwobNQ1NZVq2mci
 uL+021vQ=; b=CGuuWnVmu8WiK2RWM3thaoGPCZY/M32jUfp3oqcjNpOKxJkkbAR
 spTf8he0UxYDprOTC7BvpY9S31C1wqToWsxCpE6AEywyLmSTW3+F5JWFu2f742sr
 BGB1FUOhx2n0t+z4Iiq/dwI4jiVgAA3pvLWSJYfCjiRUQszuvH14IV37s8n0uaKa
 fwXP/9pr4KOtoEW8JB3RkaZr6iGkYhxeqd6Ob7/SdkuC/V76OaXC7BXbqPSEryDh
 VvwT7kyJ/eVS6moH6hz3ogqZu40Vm446aQggn8wtf7RJWXn8LCd51EuzwtPwW1hV
 n48CakAcQ9QkL9JebrCDgtl6KtrE4Hc+Vpw==
X-ME-Sender: <xms:R_59anlJePV9j5MXO4EFA0k7YlO3IWsDUpmuVUhBWJC0q2MJqVivFQ>
 <xme:R_59ag2eWRjcGAfXK96cVZYHZHNj98DrVdMmSdZOhRbK7ayZ08SBqbMlXitNIeQnn
 m7i80IvPmCeJRwmlLDUxZG8AXnX1WvLd1iVQcyAn5z779JXiTXLhS38>
X-ME-Received: <xmr:R_59arTvbBCNoP6F7EjsuhexgwCIeamsTlik6_tiiW0yo_u_pNUU1d5mMF8>
X-ME-Proxy-Cause: dmFkZTEHPfIBRvvaYS+BTWR7f6A0LpHBKAvSP0KIibKftVMpvfdhlKh6uuEEMHsj8jVmuy
 21RIg4B4fXyrkj9Xh3i0a/8GlneRczc02AgflHlQaTpno+RfIy8SUneQwuC6mbh3FNZUe7
 8WaUIoZJBgFdawQ/AgCCCrivxSaVYfL6w6rJ7dmBJAw8XrommST51yMo8LCQQcOahohFKF
 Bqg132/mOqRtLpew8J2GRrrrhlnwBYqGNVaddMNJ0t9ubEmZiI0mtrWct1L4rgmG7zTlSY
 +E2B65PFAqUvAAQ2c4u3QFgSFdeECjRZC6ahnrt4v5L268AyRjwp7T2A5aMhlc1uJNXFIM
 GwZM4JXRWFRwCSw1hNzZCqa09avgegaP26eemrBZlQqjIVh5LQOI/WnQaJ8su2ldZ4lyP1
 q5ajGrOYOfHfS+WJ14kX/3XjpNdRFJIRpapirzeMBZIQZUSIbQNxBgv6DP99wglLbTvZf4
 5/ro/y6RFwXTBWRGMSegjNgKY0desvJRFzRRTfIePGKbUP7XPeek3xNJKcp8a4gosPULXk
 hgIR21vWSl62B+3+Sgck1xa0gcxP3WExRlAX7+bRJFT6Q9quhpHqWFJGNJEw5ne4kdct8T
 qPxmRp+cxAVI/S3QSb1yAOQnDEAM5LBhgZnvmxQJK7+WWDJISgBYXRVv2Dvw
X-ME-Proxy: <xmx:R_59aqsQiBeUNb5CleG31NYo1FvqrAfPlNgRhBCa6t8hMQYaKBkSUw>
 <xmx:R_59aoY4U9VPR8evW7hi7m-eVdADPrev23M9SgxXELcHTwALy1XDWg>
 <xmx:R_59antgV4ZY6CWP1kl2cg2f16pv7qJlA7S9RRCLrZ5YPp6yoL1fdA>
 <xmx:R_59aiFJ2yrTw_U70i0GbCGb8WIRIaBS8CBtgp73qLNtl9CpjUkrgg>
 <xmx:SP59atVRhEWA2RtlSXX2x2HCnoVMjGcrvrrcY4MMU5s2Ydff-82Gvt1I>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 13:26:31 -0400 (EDT)
Date: Thu, 13 Aug 2026 19:26:29 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <an3-RStpF4RmkkSt@krikkit>
References: <cover.1785308184.git.ralf@mandelbit.com>
 <25d830e082b03afb4615aaeed6e0dc1d1370ecbc.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <25d830e082b03afb4615aaeed6e0dc1d1370ecbc.1785308184.git.ralf@mandelbit.com>
X-Headers-End: 1wuZCT-0000Be-7n
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 5/5] ovpn: avoid caching
 stale IPv6 dst after FIB changes
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

2026-07-29, 09:20:36 +0200, Ralf Lici wrote:
> ovpn stores the IPv6 route used for UDP transmission in a per-peer dst
> cache. IPv6 dst validation uses a cookie derived from the route itself,
> or, for routes without their own sernum, from the associated fib6 node.
> 
> If the IPv6 FIB changes after ip6_dst_lookup_flow returns but before
> dst_cache_set_ip6 reads the cookie, ovpn can store an old dst with a new
> cookie. Later dst_cache_get_ip6 can then consider that stale dst valid
> because the stored cookie matches the updated fib6 node sernum.
> 
> Sample the IPv6 FIB generation before and after route lookup, and only
> populate ovpn's peer dst cache if the generation did not change while
> the lookup was in flight. Also add a dst_cache helper that stores a
> caller-provided IPv6 cookie, so the cached dst carries the cookie
> sampled from the lookup result instead of one read after a concurrent
> FIB update.
> 
> The current packet may still be transmitted with the route returned by
> the lookup if the FIB changes before TX completion. This patch only
> prevents that potentially stale route from being preserved in ovpn's
> peer dst cache and reused for later packets.
> 
> Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
> Changes since v1 https://lore.kernel.org/openvpn-devel/d6c941fe19455b940dd24019e32b121f332fdc95.1785253480.git.ralf@mandelbit.com/
> - Add smp_rmb barriers after the initial generation read and before the
>   final generation read to avoid reordering around the lookup on weakly
>   ordered architectures (Sashiko).
> 
>  drivers/net/ovpn/udp.c  | 50 ++++++++++++++++++++++++++++-------------
>  include/net/dst_cache.h | 13 +++++++++++
>  net/core/dst_cache.c    | 16 +++++++++----
>  3 files changed, 60 insertions(+), 19 deletions(-)

I think you should submit this one to netdev for review (as a patch,
not as part of the next ovpn pull request), since it touches code
outside of ovpn.

I also feel like there should be a better way to do this. Modules
doing their own cookie comparison seems wrong.

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
