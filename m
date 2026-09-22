Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2549DC982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 23:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hwV16/jZsKgvC6oLd/WZQeR4yGzn7cAIyhyzb94y6uI=; b=ftTA8zkybP+GOGvEIl4dabCnMH
	5hXu10NyyTbYZq/CCntFuDq2ukWhvJagXEy5B5I1+BTEXcMtAKsNt3YmqRzstYGsoBOfDaS6uDYgF
	4K9nJmV4RINGaH+sOZpspiZx3pxSggjpL/ECh5OLhtdZdCfAea4uiUXmeTVMAX2YLcGY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x99eu-0004tT-BI;
	Tue, 22 Sep 2026 23:12:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1x99er-0004tI-Gr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 23:12:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fA0r+TJi18F6aSGOd0Sw2YkWfKOEFsa//z98nQa2UtM=; b=QvAGSG3YEpl57K/wf3BUUn5YaF
 rs9zezqWAMwwQ/cpJX63QeabyBbIgsWPun8hd0fzt7uLMnZG39BPImPGazUbOM2Nas2N9g0YOo1OZ
 QdAb57p5luEERG1r0wyRpSEEhmToKU/SzUGwAMbXWRr3emOajGpnD0KUC2ARx25lkP0U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fA0r+TJi18F6aSGOd0Sw2YkWfKOEFsa//z98nQa2UtM=; b=iWdyGWLLZOxJL4Uy9N/IJsTH6f
 UeaZ8qe2ooov0IoBWzPU8yMKm8FB3tvDfmUV9+2+TzzE+fqG2w3bwdLMj73DbUrE0bGO1fHRiXXzH
 KG5Gl2S21Inn4yhKlNwtDJILiNwDPiP2nhHGmVBFsT4jRcIIqMjoKb7e8HtqJ+HIzpMg=;
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x99ep-00063c-Mn for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 23:12:17 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id EEB97EC018C;
 Tue, 22 Sep 2026 18:55:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 22 Sep 2026 18:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1790117729; x=
 1790204129; bh=fA0r+TJi18F6aSGOd0Sw2YkWfKOEFsa//z98nQa2UtM=; b=q
 8Vu+6zwCkm+f4zeBShC7Ifw7H2P9uUuyi8NG0ejqxS886/rsEkGzF4zCiRj8s28U
 jLILZE/yD/OY8357t0aq1GEV2a+uBwjqdYpNhr+LHF/wBocBKCcRlhgVn+PdMiES
 hWOzv950WUSVdPUABB4rW82fleKr3sgy8g0nQnqd9GMa9jkl1X2k2v8gQl43+Fi4
 5AxI9PqjRQ/sRQbnyq0paTpWODXK0cCVD/rjsbSHXO9NcrhFtXWdrcQP8R3xy8Qw
 VDsw8ZPldIZ+oaR4PsnnvDnrOIgHgJn4JAFS7gKbD0GbxrJdhqhmB0zjuYJoFNPg
 vOzRkSKBpyViX7GGTJZoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1790117729; x=1790204129; bh=fA0r+TJi18F6aSGOd0Sw2YkWfKOEFsa//z9
 8nQa2UtM=; b=IjPbUYWWltHTbUvquS8UXQgspkOiOGjke2dglRGsTt1xrjOV3r9
 1cxy9dunNbooCBLfmxLOcWqBEYJKsvlKg4oNecys9MwacgjOFsG1rSJ26jvzChwX
 ttfjprda2DF93iPAEnmPuQEIaliyPrOk236uajxivNel94cBr88HlJ97rvSO86Wm
 bbGvR5fpb3mHDQepaPckOCQ2H2ry7jgxV6d+B4Z52RhpLHpd7exlBHoM6q4VbcQJ
 lzjo3sy1EovvCw1RxLIZSBppdVRgCDXuzhZloZ35NUE8kW0OBzmeMd4PXCTKHkgG
 K3kxWofDx5LpwypAlWeb6kK7JQFn+7C7ShA==
X-ME-Sender: <xms:YQezanWaJaPrXU4REIvyR8I3ck9PccjZDJTeR_ZKppsXVOoG8HwynA>
 <xme:YQezanDZdcugB7aoejx_HrBhzBp5i_nKoxVVBXpMJR18Gaw5NTcvrlYLgZU5kvNKu
 lnxgx9oClPtQ8iWvBAFf5GFg2hnsAm5gRB_4BeguZcu7bF2QMmxxtT5XQ>
X-ME-Received: <xmr:YQezagw9Rkpbcs0k1QhtRltBccA_u7iKWXWL8PHLTDGpQoBjoWsD72MNppHB>
X-ME-Proxy-Cause: dmFkZTGEgHVFtT5OP05ALYHBLXs5oERRL/IAHIWOXmTOjg7uLS5HKoyf5cnpUVHT2nC/8Y
 eLRK8M8oXA0fS9OUF/bYANZOhG+TPb9WlmsyFPr2RVyZWmV5lfgBKgl23QlX7Q1rm2kr/p
 JuKmtL7d8dK24gra5dsZWvA5jkeWyDqbRJAk6yYJfP64YHakB5KoCE94Y+8teb9c463uy9
 kPmbr/QT+IlmiTVReNRuhP7TnpsAN1eQURP4dU2eHS4I4CN/ytAcDAw8IW29+nzLRHWQ1w
 JKE3/zjU6ixwX393fvVjGFI7mawPp+PfnsUBT1ZY1MhZUDkiE6DvrTGs4yICXXG+130vW3
 EAOQwcnoe5Zxmg/kvt28gC9TsFcH/8rdxLG6nPNtsLvRwujoquT6Tow6EbWAtKYTiZ6+du
 0kOhSA3WHLY49pZ77eEN9qhqhzLN77JamVCGq7HpYVAoQgKQZXB4hLqT8EtLhQWO/K1/dr
 0cK17QZylqdVS3Tg6IXDszdwrbM1Almoyhy4gwbgb8lPiXVDLBjQoj2Vf7LdmekrBaFRms
 XJz9B4ZUMF8YGvV0yQ/BlQRrqKwWoPB0pToszphHIskwOlyyQ4BnWYgHW4emzjOydrzXb/
 N5Wp40W3DbkCA9kgnPUut9+2Rj/ArphgyC3F8Fsp0QW2jXqVFC1CBh3a6ofg
X-ME-Proxy: <xmx:YQezasBJm1KaB2f1PMC95DYFkVwQQZuNrjF5ZBgMPhXUVLKe66uA-Q>
 <xmx:YQezalZiwpcX4Q2ixCEoOF64lc-TscG0ToDGXvrQ-dZroFUdNVam2g>
 <xmx:YQezasij9offG3O0L30JE_28JB2Ss38IGbVgbHFzgiebNWwwDgHy_A>
 <xmx:YQezav51XFXiIr7TOefjR7HpTCS5_jR20pOHk-aNBwbmVgiRhaeiIg>
 <xmx:YQezarpAGiPnt4ygcxkLcFI6i4qOytnnd1qWhD8e-pVe6zGTJHza45pV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 18:55:28 -0400 (EDT)
Date: Wed, 23 Sep 2026 00:55:26 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <a@unstable.cc>
Message-ID: <arMHXj3loK6DgDld@krikkit>
References: <20260729153815.2637139-1-marco@mandelbit.com>
 <eac0bdda-628c-4c0c-82ac-9184c1d602ad@unstable.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eac0bdda-628c-4c0c-82ac-9184c1d602ad@unstable.cc>
X-Headers-End: 1x99ep-00063c-Mn
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next v3 1/4] ovpn: support
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Antonio (and the rest of the ovpn crew),

2026-09-22, 01:40:14 +0200, Antonio Quartulli wrote:
> Hi Sabrina,
> 
> I hope you're doing well!

Yeah. Sorry, I've been struggling to keep up with upstream activity
for a while, and especially with ovpn now that there's so many people
working on it.

> Do you have any strong opinion on this patchset?
> I was eventually hoping to get it to net-next, because it would simplify
> userspace a bit, when dealing with network namespaces.
> 
> Please, let me know what you think.

I've mentioned the permissions issue before, the extra CAP_NET_ADMIN
check that Marco mentioned probably does the trick.

Since there's only one intended user of ovpn (the "official" openvpn
client, though of course you never what happens in the future), make
sure to pick the "right" way of identifying the netns. I've been a bit
traumatized by rtnl_link_get_net_by_nlattr()...

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
