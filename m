Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F1EC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+deLUqWcZCAX/FH4koGnp4NV2kEfdl5foTBWCVMsdM=; b=FkD/HJXFfegCQ0H6bGtMvcRRqZ
	do1YBIQxIn5L7q/KqhXXf4Mw3jktvfdJkkl4IT1J7kmLPRmrA/HlHGb4XxqERKy0eCFeKlRkFF55d
	SqXQGOWuON0rl4chjRE7UI8V8yNIy4Woq6Emx8e/32jpthcVwJsaa+BtBdJYMBuSjB+k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuttd-000186-6m;
	Fri, 14 Aug 2026 15:32:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wuttb-00017y-H3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:32:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gcBHOrIiIBgL7VD8FGiC7bssbGSa//+gB9/Nwfl0ceU=; b=PlNBmOaf/3FUdJIzkXjIeVEBT8
 nqbL6+Yq39OZPc2Ui9Ofz2SHo++S0MvNYuztZ0UMoNTDh39Idm0fi0d0/8oh2MBzEIEb3yacEupAF
 gIO91THl25BBDWoLIvpw+Wqhh53BH5dqxYbuYaZbnWby/b6gKKouJSTlXqTFUOJl4bKE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gcBHOrIiIBgL7VD8FGiC7bssbGSa//+gB9/Nwfl0ceU=; b=TdA36baerz1LDk15Gbki8DfEcq
 SVwe+N52C+ppobeLfySrv8kA0gM0MmQdqVM4gxR7EB3ZTX9Z+pdejKkA17YrMLIglfWFeegwjzPnX
 U8yOJaRJusVc8nPHFM6m4q4eGJjzDrhvge6FIi8vOfCO9xgBxYqUZGik2r4Hc8OSt0a8=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wutta-00050n-Bd for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:32:36 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4hM5nj5xgszNkH8;
 Fri, 14 Aug 2026 17:32:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1786721545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcBHOrIiIBgL7VD8FGiC7bssbGSa//+gB9/Nwfl0ceU=;
 b=GkGS94gFK0PLKrGKkST8fbIaQ5flhX/zVHB3ErEF8lEogQFFcWEoIBUBHKul/cps6IF28t
 QZWfdCL/pUzLY/EDJaIewycV3e/+VNLalgy4rxsZH5C0jK/qx/aZNSyb+XEDxUL4rQhmLd
 T/nPVeZI7SXl0+LLBj7uz7vA4tnTu4AzsiMnJxJv458fuujtjQO4BMO3j6K5LGd+hOnfVE
 no4zUc8M7tMwEutkRQrTHAypwHY7163+aN6527htZ02jnfC5/2rXgxjx7WrjqWJDa8eM96
 HXSsRhGW2IdQdVZPm0HuUrg+BGkq59iF/f2b/42I2G7yX8N+HBYCADVqpLrY7g==
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Fri, 14 Aug 2026 17:32:13 +0200
Message-ID: <20260814153214.633523-1-ralf@mandelbit.com>
In-Reply-To: <an7lVHXNzGDFGAwo@krikkit>
References: <an7lVHXNzGDFGAwo@krikkit>
MIME-Version: 1.0
X-Headers-End: 1wutta-00050n-Bd
Subject: Re: [Openvpn-devel] [PATCH ovpn net 2/5] ovpn: reject duplicate
 peer VPN addresses
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

On Fri, 14 Aug 2026 11:52:20 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-07-29, 17:37:40 +0200, Ralf Lici wrote:
> > In MP mode, ovpn uses the peer VPN addresses as lookup keys for
> > selecting the peer that should receive an outgoing tunnel packet.
> > However, the netlink peer configuration path does not currently reject
> > duplicate VPN addresses.
> > 
> > If two peers are configured with the same VPN address, both can be
> > inserted in the VPN address hash table and lookups return whichever peer
> > is found first. This makes peer selection ambiguous and dependent on
> > hash insertion order.
> > 
> > Reject peer creation or update when the resulting VPN address is already
> > assigned to another peer. Ignore unspecified addresses because those are
> > not inserted in the VPN address hash tables.
>
> Maybe mention that it's a user-visible change of behavior, but it
> doesn't matter since that setup has never worked.
>
>

Will do.

> > @@ -522,22 +524,41 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
> >  	rcu_read_unlock();
> >  
> >  	spin_lock_bh(&ovpn->lock);
> > -	ret = ovpn_nl_peer_modify(peer, info, attrs);
> > -	if (ret < 0) {
> > -		spin_unlock_bh(&ovpn->lock);
> > -		ovpn_peer_put(peer);
> > -		return ret;
> > +
> > +	vpn_addr4 = peer->vpn_addrs.ipv4;
> > +	vpn_addr6 = peer->vpn_addrs.ipv6;
> > +
> > +	if (attrs[OVPN_A_PEER_VPN_IPV4])
> > +		vpn_addr4.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
> > +
> > +	if (attrs[OVPN_A_PEER_VPN_IPV6])
> > +		vpn_addr6 = nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
> > +
> > +	/* reject peer with conflicting VPN address */
> > +	if ((attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_IPV6]) &&
> > +	    ovpn_peer_vpn_addr_conflict(ovpn, peer, &vpn_addr4, &vpn_addr6)) {
> > +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> > +				       "VPN IP is already assigned to another peer");
> > +		ret = -EADDRINUSE;
> > +		goto unlock;
> >  	}
>
> nit: maybe splitting conflict() into conflict{4,6}() would be a bit
> cleaner? passing addresses of 2 families feels kind of strange.
>
> 	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
> 		struct in_addr vpn_addr4 = {
> 			.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]),
> 		};
> 		if (ovpn_peer_vpn_addr_conflict4(ovpn, peer, &vpn_addr4))
> 			goto addr_conflict;
> 	}
>
>
> And then conflict* looks slightly nicer too:
>
> bool ovpn_peer_vpn_addr_conflict4(struct ovpn_priv *ovpn,
> 				  const struct ovpn_peer *peer,
> 				  const struct in_addr *addr)
> {
> 	struct ovpn_peer *tmp = NULL;
>
> 	lockdep_assert_held(&ovpn->lock);
>
> 	/* we don't hash INADDR_ANY, no conflict in that case */
> 	if (addr->s_addr != htonl(INADDR_ANY))
> 		tmp = ovpn_peer_get_by_vpn_addr4(ovpn, addr->s_addr);
>
> 	return tmp && tmp != peer;
> }
>

Yes, it's a nice refactoring. I'll apply it to v2.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
