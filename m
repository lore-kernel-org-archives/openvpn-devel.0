Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9735C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlyd8jNIZyAL8R6lkGHuyp/iUrv+d6CEPlCB8umZxtI=; b=gUcyKtM9BVNexFcraA/fIh3jdS
	5soQK9mNc2btsFYbsOamOUuCas35Pgseg0LCZPZHdnwisVrDVKEyfFER0kGeewnFst8HlCyd7Mtyt
	kmggxBcNE33/4KTEEVnI8VPGOzt7e+gHUXfb5B6HoSieXHORypkpi+Pj9okoWTO76PBE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuoaa-0006vu-6J;
	Fri, 14 Aug 2026 09:52:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wuoaX-0006vg-F0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9JJ3L4jCKBtMYWDR4fQDRgAhSmmdYxcT7uu8nFHKJFQ=; b=lP7MXVYTAvJrnKKGadS3mzx4Lj
 llW4xlj2r2+73o5DF5q+hKv+HaF9VaayUXFwtY8BpDGAOS4K49tfS5txpyPkYkHv3+AvLTuqav7KT
 jSnLUaHcxWWaGf3872i+xveVmSzBV9qDfGws7lZYGXJKLVij1OijXceOWfgc+Xc+xHZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9JJ3L4jCKBtMYWDR4fQDRgAhSmmdYxcT7uu8nFHKJFQ=; b=WCM9tGzV4mT6n63RfCkRDXA6Rj
 2ol0Qs/mIje5Rf0A9IG4qgBYuXHrxl2pNYjODmb1ncUQR+A7o06DjHX0RT1n/lUaXik+GhzcggKGH
 7JQBhuxkajgrwOGYdN7i9Oa/XM9iJ0HuXh7NkezMaELYtZpOyaO0qJ1YK+QIWdRW72LM=;
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoaW-0001iK-VV for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 09:52:30 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id A4DEEEC01F3;
 Fri, 14 Aug 2026 05:52:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Fri, 14 Aug 2026 05:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786701143; x=
 1786787543; bh=9JJ3L4jCKBtMYWDR4fQDRgAhSmmdYxcT7uu8nFHKJFQ=; b=k
 AMME8byoYXDw0T+WWXURXOuF2L4bLlWqCLB+eZHHdDwUVfjuc+E4Wg/KT6BtVNx3
 ZFVrUE1aI/bfqc3+wVB132QtYD8KJ/L0u7YfAxD3Qvze5HL3TYXwnbkjoNhuLEcF
 PwwkA2684LB52SlLhP0Qs+OLbmAgUV97a1VYO+L/E7Z7dYmAO504yyvF/Z7g0qYB
 F5g18MrcvLFtoOM8uHf2mWq3f2VJe2leombTPBRn2BqGmtQnOngQybHLaraweVSY
 NnBuYtaE7mTBEJtysSgEhvpaQNt9ho6Y0AUfjKKaCq+1mA2KsTpfE7dpZ9x+S20M
 jH0nkLT2QRM1S7Ona3klQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786701143; x=1786787543; bh=9JJ3L4jCKBtMYWDR4fQDRgAhSmmdYxcT7uu
 8nFHKJFQ=; b=M6IcrS/LazylR6UhqCZ8XulbPoUWFx2Bl6Qkq91PHarV/uoXaez
 kaHQnV68BHhLSlwi2p1+epchPGHyQOfb4XE8KFup7ut0t230LJyiegqwz8AEsaIA
 REyB68p+dJwMYUgptbEOuwPnSBg+0T+GcnbuOYIl6frBWImURmmcgKkvL5fHg5hg
 2gNVGxPE1JykzGa0kd+3a5TXoY/Kac75cvaRDXxQ7Qo80xsw/aucnkByNTxaBwJZ
 6V5ZoZZaeMrWUxhk0IXHqZXKGZwxklF8BTXZQn8sAXlsvnVdM44mX287+dsIuT8U
 6qVNT23EwFJ4vllrTlECXvcokJnJRc8j5VA==
X-ME-Sender: <xms:V-V-aiY2xUpilAOBCsN0VNO4h0eK6JHiw8aRsWV_1PWc-5HwVa8tHg>
 <xme:V-V-arbRObz4RFwKVDss71LpVr_Sfcp9PzwbNRaeM0-H5asAkWkJVbe_mFL6TfCfj
 a7D9L_CCiir9ilKeckPD5S1KRT-1iRK36plgymhQNyaCB-2JxcvTwxn>
X-ME-Received: <xmr:V-V-aqnEGHOkXpuxWlUA4NhbTX0stkLGLIkq2-OKzMs50JRHjYXV2ThQImY>
X-ME-Proxy-Cause: dmFkZTE0xr4av5SkzafFn9U2s8trAFL4cnPaPg+Ti7kWsBe0ozRI+S/hiT+F1PRS4H1zrV
 aBWKHJ3+szmchQLwyG5orLbmB3/ipesmQdyqdamX8SNhcwpLzOd7c2zgrI143OytFTRcyR
 n7UEAWB98BxayR0qWef/U/+TzcBpXYjVt5AH7aE7wLFHqVnfhbYHMykZJiO7bm8Hzzy4GD
 6za54rc/G60N5JtDadrIpDrA8HxuQT9p+HOGcxU6FqzuTOyhkOzh2GiEpKCMECNf4nETuC
 XJhW6Pi63BME5rkf2mukAM2Hm0cxVvJeReA/aMOG7f+Y/32DbT5e/IofcGNM77hBmbyFqf
 d5isCrPPEEM5egbBWBCRt4pEIdlfFRddeSVH8YFPlxJ8EKOrmPn44i0GU4CK5eGRuBLM0q
 svJBewPaLtLodotLVRL+Zyz+Qz2D2mK5B0FKS+d1kpK8QvsNlSLYqjpsYe30g185cb1N9M
 Kw12Rh5pVl6kKX4ss1Lqh06QONdUBWYt6mkG7wFdYoPNRbM/5glIvXh948fh6Yw7eR52+w
 NRO92wK+8QzN2LwNxhyO6HH/KOAluwrwzdUQwyXKjlytNhrkp1Wbi7BqwWrvnS3sM4XqrA
 o1SGHqr3Hz/UkQJU8ro7jmloBaGn7K1pZCypt3FFeyMpacNnweOiTBXfX3ZQ
X-ME-Proxy: <xmx:V-V-avza4UO4HAhjfDapiMYpIJh9grQGPHbTPGrzekcRAZToXDXjkg>
 <xmx:V-V-agMj_yMO5Ln1mN1X1oO-a_smZMCrPHy8YqalXgvM4nVErwLCNw>
 <xmx:V-V-arSFcgvIGWVQOa0Tb4sF5cVBGiZ7bIyeuDLwT47I_zDou0-UDA>
 <xmx:V-V-amZYZ_lXpvNsIQ5DceoRjCgwN8LPhFtGsaT1LZ1vpbPc-SAPbw>
 <xmx:V-V-auree32RyGeGUgrgRzl9457mG5_GTNQSf2S40NqpUNwl8cIUOqqf>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 05:52:22 -0400 (EDT)
Date: Fri, 14 Aug 2026 11:52:20 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <an7lVHXNzGDFGAwo@krikkit>
References: <cover.1785338921.git.ralf@mandelbit.com>
 <872f401e31dae10388fe65b45463c5c55b96ac86.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <872f401e31dae10388fe65b45463c5c55b96ac86.1785338921.git.ralf@mandelbit.com>
X-Headers-End: 1wuoaW-0001iK-VV
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

2026-07-29, 17:37:40 +0200, Ralf Lici wrote:
> In MP mode, ovpn uses the peer VPN addresses as lookup keys for
> selecting the peer that should receive an outgoing tunnel packet.
> However, the netlink peer configuration path does not currently reject
> duplicate VPN addresses.
> 
> If two peers are configured with the same VPN address, both can be
> inserted in the VPN address hash table and lookups return whichever peer
> is found first. This makes peer selection ambiguous and dependent on
> hash insertion order.
> 
> Reject peer creation or update when the resulting VPN address is already
> assigned to another peer. Ignore unspecified addresses because those are
> not inserted in the VPN address hash tables.

Maybe mention that it's a user-visible change of behavior, but it
doesn't matter since that setup has never worked.


> @@ -522,22 +524,41 @@ int ovpn_nl_peer_set_doit(struct sk_buff *skb, struct genl_info *info)
>  	rcu_read_unlock();
>  
>  	spin_lock_bh(&ovpn->lock);
> -	ret = ovpn_nl_peer_modify(peer, info, attrs);
> -	if (ret < 0) {
> -		spin_unlock_bh(&ovpn->lock);
> -		ovpn_peer_put(peer);
> -		return ret;
> +
> +	vpn_addr4 = peer->vpn_addrs.ipv4;
> +	vpn_addr6 = peer->vpn_addrs.ipv6;
> +
> +	if (attrs[OVPN_A_PEER_VPN_IPV4])
> +		vpn_addr4.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
> +
> +	if (attrs[OVPN_A_PEER_VPN_IPV6])
> +		vpn_addr6 = nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
> +
> +	/* reject peer with conflicting VPN address */
> +	if ((attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_IPV6]) &&
> +	    ovpn_peer_vpn_addr_conflict(ovpn, peer, &vpn_addr4, &vpn_addr6)) {
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "VPN IP is already assigned to another peer");
> +		ret = -EADDRINUSE;
> +		goto unlock;
>  	}

nit: maybe splitting conflict() into conflict{4,6}() would be a bit
cleaner? passing addresses of 2 families feels kind of strange.

	if (attrs[OVPN_A_PEER_VPN_IPV4]) {
		struct in_addr vpn_addr4 = {
			.s_addr = nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]),
		};
		if (ovpn_peer_vpn_addr_conflict4(ovpn, peer, &vpn_addr4))
			goto addr_conflict;
	}


And then conflict* looks slightly nicer too:

bool ovpn_peer_vpn_addr_conflict4(struct ovpn_priv *ovpn,
				  const struct ovpn_peer *peer,
				  const struct in_addr *addr)
{
	struct ovpn_peer *tmp = NULL;

	lockdep_assert_held(&ovpn->lock);

	/* we don't hash INADDR_ANY, no conflict in that case */
	if (addr->s_addr != htonl(INADDR_ANY))
		tmp = ovpn_peer_get_by_vpn_addr4(ovpn, addr->s_addr);

	return tmp && tmp != peer;
}

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
