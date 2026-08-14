Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B34C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oqo5O8DiGuEtUSiO8ecA2uMHg+zXOqrl6oL+s2Q06cY=; b=WfjoRdp5cr7Y72UpSmaA0dNwki
	Y4MwbTDsjllBMUCBkFXt3H6sZ/rt7DBYuMECJdVoGj4KJT4SEpw1REXDYavd2jEkIM38prHKSSgeF
	Ti4hUKRNwm9Drur0nMIKDxixtsvYPi/fDa45uWxe3zMPlZ7qZ8Z+MKXB/JJes38ZEF4A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuq8X-00068K-Pc;
	Fri, 14 Aug 2026 11:31:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wuq8V-00067x-Af
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9gQs5bhRtIGLmqbYtuRg2qkk/tJK2OK1KXq6vHmZOp4=; b=f+6ohar9K4XZ28oo1AFp0RM0DV
 N80O2Ttmckk1F8ZhqD2zzM3vphTaO/jH1A7EwUzgikj/iA8iSRjcLuPTPZ4KGlr2GrXZ9T7DK0+HC
 uKuAv0FteZ3zTouXuK/Ra3kbJ8B8VaaLEXbPZKXnyxwxxpHXpnAYksXpE4ARSTUFKi4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9gQs5bhRtIGLmqbYtuRg2qkk/tJK2OK1KXq6vHmZOp4=; b=j3UljI6POyuYY/eS4id4tutwmj
 uBhE3GuptQMIS5iqYmHibyatuwPVzm7IilLaXEZNwr2a3VmWS0H0G7EIA7hDCwH6zPdVLiyGKsy8g
 8dA1QrXOGCFNELMsUScV4WJ7WKsk/zHb9WlUenRZUsZpBHyo97XNEbh2h5hNb4g0J7gw=;
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuq8X-0005B8-Px for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:31:44 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8700E140011E;
 Fri, 14 Aug 2026 07:31:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 07:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786707096; x=
 1786793496; bh=9gQs5bhRtIGLmqbYtuRg2qkk/tJK2OK1KXq6vHmZOp4=; b=H
 bQUJpR2Qt1ihsXdyeczpU3rv2FetzISm84HuKenL/VT2o8Tc/jEoFpmY8Bt56/Mr
 KDnBPGlk54tF4KpcxsUlGeubCodN/OXmKvT01xb13Clh1cwrBA2D6YdkHq+oOxhM
 HCjGTRy5aIMJBhxWpnOHJJisxcxmhvGCY+0vKwNXYurBLnq9jYtMCjlJWFqBE5Vt
 7ZQA5itg8E9Apzv/rXlg1PhdJuGdNiQgb9avISgzWveQ+In1SPG7OUgfhvy0h9rz
 IGa3lchR0PCZswTgehCPotbcNuGxNNkjgabsMn2VDJpwG7FmySAO17FiT76hqP8j
 pzWKYdhqgM+/nwRiNWNVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786707096; x=1786793496; bh=9gQs5bhRtIGLmqbYtuRg2qkk/tJK2OK1KXq
 6vHmZOp4=; b=Qy1TK1ybVQGnA9H+39HTnMuR6NePR/UID1B3VLzUq2PygH5Tofe
 aHHUyQpglC177PhLnBHtq+XmxOLFwHKqSgS6yBGAtI8G6r52pKZ7Ff4y+9ETmYX2
 dTCEqFu89sVGaNiM+N+DhdmUf1J29noIH5tOCike2b2JbHsbGQwBvfZnBBJ4njwg
 yen2c2K2TgiDqOLCzVxr3OI4wTPbADitx4UIfLQ+5XwWhzDOlyezp3G64iS1GwHg
 svv8GYiJiIC5sxGObU2oZ3GYKrcsp5cNzMiUtCiDwA0VoZwFNyXTsv9ufRRW0Ob0
 E1Wybi1PXIEb53AS7IojLTQGxi8iR2ne2pw==
X-ME-Sender: <xms:mPx-arusn5bRv_w60v4TEfvuXHd_3UbEZCYkWqXVGcbOecO1xChiaA>
 <xme:mPx-aj6FYq_XjU4o2u8soCI6j5N0uIZN5FmzT1jacCio6m-nUzhzVvlBR9v7tVW5x
 6b_Bqw-AWVeaGML3Bi-v5wzfKQJIyAEcWAIR9FehHf2hDedX4sg1MVV>
X-ME-Received: <xmr:mPx-asJ3Tv4fT756XpdhN0QgoQIPOJPDvzFj3NMgaMyQoqTxNUQPDndZMYA>
X-ME-Proxy-Cause: dmFkZTFnGj5vdhTG89aXFO0vSP02sZnuG7GL5Abgh4qWTYs3F4QfA+Re5BJnEgc02qqheN
 xFSvcaB6x2ToVt3HdKBDjl0hHRPdJPZ1KmfrfXWqH9rtZ/AtMINN7b8EVniWljVwwYDBVR
 Zk5SVLOxfqGNVA0kpGVqLZhmGvilmYKHl9Jozhf6Ti6Yds4Az+McxM4qd3BLmOeM5fxgKE
 sZuP9VTmeDzkdTrCGUOeWD0O4p1c02GqraHQ5DDPgiNyKBR1QDTU+wQpxL+9Jotlxy5uKo
 ND9Iz6wq7C2yCS7aXNG1uWEGZ+Z+1MF3jPEmIiLtjJCYbzfhYf+vfjVx9ZHJzqIFo87qXb
 pbfLAVH77lEfeM/eO/nSxJDO8C3cMopJUmUlDmkuXb8ugp4DPIx0UqTNbV0A2HOaCvj8rj
 lMOv2hXCEJd7ACGYJHhWrOQ9HREfCaNB52aKI2TIbRuBG75qsh5zR96r3+V81ZZP5HBM0d
 5SssNHweY7dKuySqYM8WPFoABYlOClfIT1xVJNnLCm0vyzuB82PDZ6ND46igOa+WaphwTC
 e0A/nvz1ZRi2umUapZEPDKAM/26mqqS6xSwwqEMPcdXgOYmavHu7Z1Fx6CxGCzfrmwPk6c
 TCmbaitSo81FWPWAUJZWG2xXqIo2lOPNMWB9xBhDt9rQFYF5CI23kjwiTAvA
X-ME-Proxy: <xmx:mPx-aj7No1J1YeSguVtOVdBsTuc6nWv8NxFv7YDEZ86F7RKPuGCN8A>
 <xmx:mPx-avySrb0_Zom6ZsnrqISVwZk2iLEt2dbVLbRJvccxxfVwtDjxDA>
 <xmx:mPx-anZ-18dOkZJJu7RAhUzjEW_YS0nkPVwTNmGEnFCpIUngekpVTg>
 <xmx:mPx-ahTm-QhQMhq3l3uPkFiufPk3O4CjykwZlybveNkl0rO_lPg2yg>
 <xmx:mPx-asxnW1HMRdaxwJeAVma06wRhy4aCetBlqWLpe31KugCRH4Htvz7Y>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 07:31:35 -0400 (EDT)
Date: Fri, 14 Aug 2026 13:31:33 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Marco Baffo <marco@mandelbit.com>
Message-ID: <an78lfnWKHNx0mUc@krikkit>
References: <20260806154948.795039-1-marco@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260806154948.795039-1-marco@mandelbit.com>
X-Headers-End: 1wuq8X-0005B8-Px
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v4 1/3] ovpn: support
 operations on interfaces in foreign netns
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
Cc: Antonio Quartulli <antonio@openvpn.net>,
 openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

2026-08-06, 17:49:46 +0200, Marco Baffo wrote:
> ovpn currently looks up the target interface in the network namespace
> associated with the netlink socket. This prevents a userspace process
> from controlling an ovpn interface located in another namespace.
> 
> Add the optional OVPN_A_TARGET_NETNSID attribute. When present, it
> identifies the namespace containing the target interface relative to the
> namespace of the requesting Netlink socket. Resolve the ID and perform
> the interface lookup there. When absent, preserve the existing lookup
> behavior.

I'm not so sure about this. Why not open a socket in the target netns
directly?

Also, all this cross-net stuff is a pain wrt permissions.

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
