Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635BEC55162
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oshTGEp9ovFi3NifW+D4Uglq1PLYvuOHP/Hk4x9v6Uc=; b=BXp6S0jRomGXWzlUnTFUJY/Z6l
	EdhZoMQIPxnOyxmtagMIyv4M7t3fXb9qKpi/Eb8x5EHDUXeQ/bFsAF64hvPSwWz6D8SK6uXi1S1Nx
	zOZPoCr87WKLOyyCoMKUnf/820WTRiNywJgEZmmQ6N3c1rdezzfKyan79l3pfrEmfhvk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpRun-0004rI-No;
	Thu, 30 Jul 2026 14:39:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wpRuk-0004r7-7K
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 14:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mAG7WxB++BqPFTwQqbD5WFJ0ZfGLL6bA8XO/i4Ae4RM=; b=mp0bQdInqoV4Av1HpPh+eYZFOL
 +o5JCEfAjLTWhFnMHKYFPknQFu85C9CE7vA6GIpQgGR0rkuPWjlvvPI0cr+b0mGd+EK2Eq/Ud1Hq3
 8A0FSuT68JbO2DaXMahSmRr/mHTKssTiERbt++r9VKi5e+OAVBOihBc871n1jRyFVULo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mAG7WxB++BqPFTwQqbD5WFJ0ZfGLL6bA8XO/i4Ae4RM=; b=SlEmLdPkBbTbiATcVP+GI0gimf
 4HTdcWcGLoie/dQ6opGvbYyMqgvFG724yC3aApcWTqiSdK8ZnVGkCmr7fGD8l8BZELVSyzQ+bUz2n
 V74QWB12Iudo+ICBUcBTQ5e57ItxRj90Bp870QNW7IQdChNr8prI/gK9bDzRUSqurXa0=;
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpRui-0004pI-9j for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 14:39:14 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 399AEEC0139;
 Thu, 30 Jul 2026 10:39:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 30 Jul 2026 10:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1785422346; x=
 1785508746; bh=mAG7WxB++BqPFTwQqbD5WFJ0ZfGLL6bA8XO/i4Ae4RM=; b=q
 HmnskCIYjIBmipqsR+9Exp4jHHOecAkv+pj4jN8z6L8wCeA10xg4wrVLmu0dftFa
 aQ/esRsdPJaO66dZ1LdUbykH92JfP0cTajZs6AFC+yJN9SAWkudrt7v0xZxjpcPy
 5ghojAq/pEZCtjB5BoQmCsoExgagg4XFM4BNR1VxVLs7TpGXttx4i7rtClnqp/iR
 y3d1fV+uzlieNQ89t+BMIlH2KF8eUlrR9PR3u089gqCn0dO3O0D1m2XVC/T/NaLO
 xDYCfcvO+Qh/7ItVd2EEA5GpI7WNJerJPvabftgzrQuqzUCfxTMEuEM/YIAJMtM/
 Tep//sZnxgbAtobxzHZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785422346; x=1785508746; bh=mAG7WxB++BqPFTwQqbD5WFJ0ZfGLL6bA8XO
 /i4Ae4RM=; b=gDHT1rddfWOEQ/wL2/XkqtDLtJBPDDO6aTjtTlcIwibCvKS69NM
 eEgcnZWZO+TZEyR0YyPWRgNm50tArmfpF1P03Qh/8L888ipuvIcfCGbtnOuK704z
 /O47/vIHh4R8KutxNDA6b1dsn8LkPFQN1M2jqpFg2pLB+M30IDW0GXdY6NnWUNWw
 ymvNU4QAvnILtO3KQXNfcju9+rHeqHOGrOE9uoXWfgYHO97PDQdG/9XAKDc5Tzha
 0iRuZEPYvQlVIq+iOdtJGy6vxJc8kwc7+HXtYPt7bQ2spaFBudcv/SS+g9scg5Q7
 PyxA4yGpXTuLiEvNOVjH6FvpvV1d5KBtuzA==
X-ME-Sender: <xms:CmJralCodjQtnC3dXK4CM75GTGBrG-M-fZQ1Qc0pzMnIqx5llmayHg>
 <xme:CmJraq-BTy3H3HG9BYFkWJAEVgZJsPUkTTEtmzXJkA03hXps4FbrpGC9TCrDdcWkV
 gPy5Jd2wwSftMyQSwFV-wiq26XFZcTB89jHk2YtR6sk4R2-0yw0XB72>
X-ME-Received: <xmr:CmJrat95Lz2lplvSLS8UTEoFnt5lKkGwh6YWHDBMD8XcLBR_vRiVOYUsKUk>
X-ME-Proxy-Cause: dmFkZTFAsBB25WeVFIxkmIil8CrOzEr8wFWjK9B0/rmtxzDqtIkYVvDMBzigRatUXoZ8oY
 B6cOUUVBRO5TWn2YY4QKETPtOt0Se/qozojyeG55ASgMrqAuT/lIHAPPl36nIwwpW8gvzj
 TyNG9opazzXXHqjVYhVjzIvMiiBjxjXYrgq2InoXyXnPEf2bNhrZGMkKw8vwEhe+JN4n7P
 fUbm/TvDFVfPlrVBAQH1+DGHhzv8rM2Ylp6qXuSwmZdV3MI/JAErnCoXa5+sZPnByKN5pK
 7tLkqWxmN8aRHN/87jQFtdjkRSMi3GtbdV7jwFeInXgGVKiZNGvKr344xGA/tCf6fCFlnl
 PbnJPH5JC9RBRb+DwO9W0gzkiIkr9nwT37SddVoBdIb0JECt99MsckwdGYMQYmNhuUeIzN
 KbfY7BnTahTwhwmnAl8P3G5WCE40B2GpZsUxnnNR8RgwVtsRvu9GegzOhSdc/+DU0CIemL
 1+v2OOGUSDJTIaWn2MeDlaRy6h+1vq8FkygiTyajTLDD9f7OA+U7ZXJJyGiMRbUojrQ/Js
 LN4aCHrBMr1TWxNr2QovRqHXcQEQZHEMyhC7ov6sp+XEMtAfnTYriUE8yii6QDP//txTk8
 XkT4S4RxpBOkii2lreoc3r9V2lk+MPb6lk2d2DAQ7pm9AI5bLrRaQa1/fqsw
X-ME-Proxy: <xmx:CmJrapfBE1nbol_BMGQE2jFZWtMzIEkmTvTKKAtdKg1z7sv4OBXVkA>
 <xmx:CmJrauGS7IDDwLQWdHaJuFG9wE2nyFeWURCPm8POxXeC-NUasL1RVg>
 <xmx:CmJravcwrgA6PaNEVs4QnCHGeHpOhbidb7cS3MX08qvpkvJUX2-Erw>
 <xmx:CmJragHNr43t6ufbrGelMBR8ZgSuicX7dHvL-fFhDikpNPG_QptM8g>
 <xmx:CmJranfmP2CAsUNdE6ExgPLokk9ZlTJUSHP-sKhPQg1YcbiFyzBqIt35>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 10:39:05 -0400 (EDT)
Date: Thu, 30 Jul 2026 16:39:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <a@unstable.cc>
Message-ID: <amtiBzqcFxpoOgkD@krikkit>
References: <20260728114855.1323861-1-a@unstable.cc>
 <20260728114855.1323861-6-a@unstable.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260728114855.1323861-6-a@unstable.cc>
X-Headers-End: 1wpRui-0004pI-9j
Subject: Re: [Openvpn-devel] [PATCH ovpn net v4 5/9] ovpn: zero-initialize
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
Cc: Antonio Quartulli <antonio@openvpn.net>,
 openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

2026-07-28, 13:48:51 +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@openvpn.net>
> 
> ovpn_peer_endpoints_update() builds the new remote endpoint in an
> on-stack struct sockaddr_storage that is left uninitialized. For IPv4
> only sin_family/sin_addr/sin_port are written, leaving the 8-byte
> sin_zero padding as stack garbage (for IPv6, sin6_flowinfo is left
> uninitialized likewise).
> 
> ovpn_peer_reset_sockaddr() -> ovpn_bind_from_sockaddr() then memcpy()s
> sizeof(struct sockaddr_in)/sizeof(struct sockaddr_in6) bytes - padding
> included - into bind->remote. That buffer is later hashed with jhash()
> over the same length to place the peer in the by_transp_addr table, so
> the garbage padding lands the floated peer in an essentially random
> bucket. Lockless lookups in ovpn_peer_get_by_transp_addr() build their
> key from a zero-initialized sockaddr_storage, compute a different bucket
> and fail to find the peer.
> 
> This is also a plain use of uninitialized stack memory in jhash().
> 
> Build the floated endpoint with a designated initializer so the
> padding (sin_zero for IPv4, sin6_flowinfo for IPv6) is zeroed as part
> of the assignment. This keeps the padding out of the by_transp_addr
> hash key without memset-ing the whole sockaddr_storage on every
> received packet.
> 
> Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/peer.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 3554da01e406..00971bbd3dcf 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -244,9 +244,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>  			 */
>  			local_ip = &ip_hdr(skb)->daddr;
>  			sa = (struct sockaddr_in *)&ss;
> -			sa->sin_family = AF_INET;
> -			sa->sin_addr.s_addr = ip_hdr(skb)->saddr;
> -			sa->sin_port = udp_hdr(skb)->source;
> +			/* use a designated initializer so the sin_zero padding
> +			 * is zeroed (it ends up in the by_transp_addr hash key)
> +			 * without memset-ing the whole sockaddr_storage on the
> +			 * RX fast path
> +			 */
> +			*sa = (struct sockaddr_in) {
> +				.sin_family = AF_INET,
> +				.sin_addr.s_addr = ip_hdr(skb)->saddr,
> +				.sin_port = udp_hdr(skb)->source,
> +			};

I'm running behind on reviews, so I missed this version of the patch
until it landed on netdev. I find this syntax really ugly. I get that
sashiko was upset about the useless memset [*], but a memset in that
branch would have been fine too.

[*] sometimes it's also ok to ignore it. a small memset, even in the
hotpath, probably has a non-measurable effect on throughput for a
codepath that also encrypts/decrypts full packets.

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
