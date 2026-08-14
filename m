Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D77C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbqjykJ0nbyYndZZXXB3K1u6v7pJRY8EHVdF7NYcpeM=; b=jl6m/AVMk3nQc7qfkymLU2g0uM
	XOApXXJt8HyVHhCyjuhlbSZjwPoyH99n2db41GBfYJ3IzP5HhcJiBby64T7VOyCvqSAy7HKDaL8o4
	aYukyLCydSFJA3okZuXHQS/zbMeDo1ATpo3DK+fA4Xl5OxEcNH5d13t2Mvqg7VkSUAvo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wutw9-0005sR-OG;
	Fri, 14 Aug 2026 15:35:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wutw8-0005sK-OH
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:35:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Httt1vBReBQZE+SMmTsVglfl6c5Evzb3yXD2mYAZ0s=; b=T4dIP9uwfh70zb9UNGng4HOYgy
 +OQ37uAldmNSAEPeDAOOynH0Nx577mrV66ndSJNBUPNi4ikG1g4r5eDJCuyHVuJOmhp0WSYb4r+j1
 Ptr6M7fcIuy1n8q73O5U9vsIfr8bcU5M4sOHMBoSUlhL63MrAV5F+coDP+upIFzD0pCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3Httt1vBReBQZE+SMmTsVglfl6c5Evzb3yXD2mYAZ0s=; b=MdJVSuNJfWilMT9tsafQJHZ1bo
 ED37eOXcy9b7LfY1d5hr+nFYrltvba5DHeJVdODvKXWPq2iNoSwK3dceLyI77SBk7ZhpfjHptiaab
 Qh8SXCQa8TImezb4ItEC8S/G+EbU2mdFHE5Mq9wGILiACD0dtMQxhXgkHtQiO/W9D68k=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wutw8-000568-4e for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:35:12 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4hM5rm5nxqzFrFf;
 Fri, 14 Aug 2026 17:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1786721704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Httt1vBReBQZE+SMmTsVglfl6c5Evzb3yXD2mYAZ0s=;
 b=cl8CY0fCaizkPrkjcyuwcfBHUo6KrRy4OgdcEsKUIaFvn6MCWdMfYyUACfq9OSMGIt5ive
 luJbzB0lMZIvF3EqXNzSjfEuF6Cdnx8etYJ0XL9STS5JetZEKTs10uUXXAY/PVlbnEBU6c
 cwaA8THk+BWX0IlyrT/a9VhflxhmL82EH1afVLQdxxmmgE1dVeXvPMPpZ85GJw8RXyhc2J
 DHD5wpFkYyH3yMRPMUL6a2CHOHLgiDaPYmR+9BEI570Y/LlUVHzSqo/pZJNTQe2/c2xsez
 I7oywwUH1aPVmvDAOc94BARZyIGu29L57qMdAKkuEJrcRjb1VYGMu0niL3398w==
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Fri, 14 Aug 2026 17:34:50 +0200
Message-ID: <20260814153453.637313-1-ralf@mandelbit.com>
In-Reply-To: <an7nOeDF3u_DVV4L@krikkit>
References: <an7nOeDF3u_DVV4L@krikkit>
MIME-Version: 1.0
X-Headers-End: 1wutw8-000568-4e
Subject: Re: [Openvpn-devel] [PATCH ovpn net 3/5] ovpn: reject multipeer
 peers without VPN addresses
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

On Fri, 14 Aug 2026 12:00:25 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-07-29, 17:37:41 +0200, Ralf Lici wrote:
> > In MP mode, ovpn uses the peer VPN addresses to select the peer for
> > outgoing tunnel packets. Peer creation currently requires a VPN IPv4 or
> > IPv6 attribute, but it only checks for the presence of the attribute and
> > not for a usable address value.
> > 
> > This allows userspace to create an MP peer with only unspecified VPN
> > addresses, or to update an existing peer so that both VPN address
> > families become unspecified. Such a peer cannot be selected through the
> > VPN address hash tables.
> > 
> > Reject MP peer creation or update when the resulting peer would not have
> > at least one VPN address configured.
>
> Same comment about "this has never worked".
>

ACK.

> > @@ -371,11 +373,19 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
> >  		return -EINVAL;
> >  
> >  	/* in MP mode VPN IPs are required for selecting the right peer */
> > -	if (ovpn->mode == OVPN_MODE_MP && !attrs[OVPN_A_PEER_VPN_IPV4] &&
> > -	    !attrs[OVPN_A_PEER_VPN_IPV6]) {
> > -		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > -				       "VPN IP must be provided in MP mode");
> > -		return -EINVAL;
> > +	if (ovpn->mode == OVPN_MODE_MP) {
> > +		if (attrs[OVPN_A_PEER_VPN_IPV4])
> > +			vpn_addr4.s_addr =
> > +				nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
> > +		if (attrs[OVPN_A_PEER_VPN_IPV6])
> > +			vpn_addr6 =
> > +				nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
> > +
> > +		if (!vpn_addr4.s_addr && ipv6_addr_any(&vpn_addr6)) {
>
> minor nit, only if you end up resending this patch: the inconsistency
> between !s_addr and != htonl(INADDR_ANY) isn't great. (but I don't
> think it's confusing anyone)
>

Ah right, I missed this one. I'll resend the series anyway so I'll make
sure to use != htonl(INADDR_ANY) here as well.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
