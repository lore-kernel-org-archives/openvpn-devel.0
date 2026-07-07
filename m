Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6156C43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6a7lauGxWSsIHT05wy+H4g3KqWYFBan+Bhn0HPg9vbY=; b=UHxPuDxzev43otLwbn7Wks+yUO
	73zWLXSRF/+kNCsEVsc6qePPULRTlPG3oyt2zHYGUhdNfqK0OCCV5ieKNxII/2kB9q2KHYQRWmKnF
	TPclBj9FV1WClYEl0gkzyaW6gzao2bm2bC/TptUGll8Ob+VBOsWrv5W5RhwXLiyhDu0I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wh37k-0003uR-3s;
	Tue, 07 Jul 2026 10:33:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wh37j-0003uI-0x
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 10:33:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=akuTrJZg0xXJNXZ8iq3R9OxTLQLQNKn1ORvSl4j8vEQ=; b=Gr/WDwBy6FwiZ0GQrtpbzHiuuk
 fz+hwqDk68l6oqct7/5p4wfQ/N9QnwwzCH8gBuhCurVz6kliAb1uPX4U5maL6uwI6f0G1JwdKt+97
 vf2c19P9RMuRwEk/uJoW8Z0nAkDumVUNQIpaA4kxpUXgTkV+wlULqL/4yn00w28St9rY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=akuTrJZg0xXJNXZ8iq3R9OxTLQLQNKn1ORvSl4j8vEQ=; b=j5gxr+UxndVTbT6b1XzHZDFj/C
 Od0Jfxs85bWc8lxP+hQUm6Cz3+Ti5i1UAqjgxi4yVQ2be2UQ/ppI29soBpQUcmkvAFW0pRN9EvBzA
 KrGXqcqh6lU1G9J4m9clSemPrcExD4tFYS4yQv6KC4wJmW/PIkrwhEyvtoxrkSOqZU6U=;
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wh37h-0000M2-6S for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 10:33:54 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 3575BEC00C7;
 Tue,  7 Jul 2026 06:18:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 07 Jul 2026 06:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1783419491; x=
 1783505891; bh=akuTrJZg0xXJNXZ8iq3R9OxTLQLQNKn1ORvSl4j8vEQ=; b=R
 QNr02s3Yh7zj7NNgknyfQxTDSQ8MqG1XXLFZaZHBw3/aBS+8xs0G2J9tKhdDBlZ+
 /uXJkNBl8Kv6eZXmj17UjojFIn352CRFYso4C21T78DM/uOadRbvRdbIAdAqRZlb
 tNC0BxnRHBzZAS/B+TyWO48wtjU4MLR2J+xVDkLkLqY0ytx5B9X7YJlN77JxmHkw
 VB3KzummpLmPRdX/R8eWL4edJtfs+vZZoZ73uOaRag0CB0RnUeZ39ZGRUoXGrZnf
 /1BG1abt7G9l3E+nWzYDOUIU/MDKpz0FAQp4T2/5xemD8od8SjHv7aeylx2E6qpz
 RTgC2AYKaDkSTYFTy9FOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783419491; x=1783505891; bh=akuTrJZg0xXJNXZ8iq3R9OxTLQLQNKn1ORv
 Sl4j8vEQ=; b=fG8xHXaBk1A31BImOKF4TuMvLLztDYm2JhYqHOwjzTlm54e3e3h
 iRjBOOrgaI9oIClT3H6SLDpBI+XM4nGcbikDZem/i9wMu5T7feXs08IJ4K594n/l
 J01IOq00jeV7m8XcMtc1zDxXbq4wuA6tP0Z8CxrFfuMygQNP9lbebMvDu0ZVHZYN
 TzJNE8Q4MxbyQPQfOFxjFcmYKZ0Mv6SpLpbxg4flyeJDtHdVVCWiHEdpo0emLiez
 uXO71TUAAoviyXPtC/R57zoSlq8hdEKHwFblHSoiEse1FvExc1eUYsVDO30lVGjA
 wGLvSkISlW28EqCzNNVW6aCruhKwknlY18w==
X-ME-Sender: <xms:YtJMakZ2YgMNETrJY8YB1LBpa7NpqrSSE-bmXB7dlmu2j6OIJ2zB1A>
 <xme:YtJMalbfSnzmQCcUz1xnyVdKHJcloZUP433Ti6B5qQIr1IRnOvTa9daj-AkmsiJB9
 wCiGK_XNglnEfBEr4KLYSNTjvE5wWR06sRb7cFY-DW-Nv-hp4k7HQ>
X-ME-Received: <xmr:YtJMaslRGdwgdvZywPgMfKioj3DxsPI3vZFkS6_qjC-oQIX74dolQas4YK0>
X-ME-Proxy-Cause: dmFkZTGUcifqXzwIYvLc/ys/WgQ6hg3jfeJft3qWMgZD/CMib2zaIUKG8u5h9kT1PFCU4g
 QAbiBj3vtYSca2C5d7TMAK7102m5vdPzvxZzhhDcePzahTMkQceNpwJMzhwQ/D/CqRwdlP
 V85qdwuVbk7MhZX+B6943X5rJ9PT9RIbRG7QIjb6F7+KX6ithduRPpx7Yl0+ESVBeJvulu
 M9gv/GFp8MpxZAriO/FaeyQUpDoVfXOPPX39/jccPsAUKqGH7UybeR7ntmu7RQQJPE9bFK
 1BLkgC6f3cHPxbnMTamDo2Hb/c1R4kgL5I8yWTHw0eByHKC8U1uxPyK3G6ZF/CSy2lBKED
 mNicQoTU3fzVAw8G1BQIL4TukymSE6m4p0J8ytDkGG+0I8H2y1EXXa4+HC3uZ1apV00ZZP
 XQKXME5RILitlkdvS3w+qT6T91Dz5s5/WGdmlZ1nSeNg94ZaLte1EO5K8m4dM+LhABZg83
 hJbH7on5IhMKe7A4zXRxbYx8R6bdDEEsYavAWQ7mbAZ/vaw8ojLOnqryz5Rbf3Xf8wlK6r
 PA3Rq5Wic3WA/Wlx6mFC0vGylLPqchXkVSvf2u0hE7VSZuR2buss6m9jSRcpGLKkXO/kym
 uCY2uz519oLtpRRr4AT4DIvUbmk6hXUTmk9OaP4t8lSA1QHggGOhbleeX8wQ
X-ME-Proxy: <xmx:YtJMapyxaFG7qQdaH-6p2cnAXfY6YiTxTmTGQp1RtTODmbT4k0lizg>
 <xmx:YtJMaiNFvKZMlHjeDCSFDHyZ2p8120i7UDwnR6nuZGrAL8opzaFcOg>
 <xmx:YtJMalTNItiog5_OYygQnHAa-zJdsQaZrYiw-1w7ZtjT3FIogFmGIw>
 <xmx:YtJMaoaXT0icy2iUgRCfu-TqhSMU9DOolV81LOvYYWpTGOtHvf597A>
 <xmx:Y9JMagoAVOASyerKrwnZOCQtx3X2fGK02TN8yr05YwoaaLejSIhvysU4>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 06:18:10 -0400 (EDT)
Date: Tue, 7 Jul 2026 12:18:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <akzSYPstl_VoWKV5@krikkit>
References: <cover.1783336121.git.ralf@mandelbit.com>
 <b2f5120a3efa20c62a83397d96e949eac6a983df.1783336121.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2f5120a3efa20c62a83397d96e949eac6a983df.1783336121.git.ralf@mandelbit.com>
X-Headers-End: 1wh37h-0000M2-6S
Subject: Re: [Openvpn-devel] [PATCH ovpn net v5 1/6] ovpn: fix NULL
 dereference when killing missing key
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

Hi Ralf,

Sorry, I'm slowly catching up with the recent activity here.

2026-07-06, 13:33:59 +0200, Ralf Lici wrote:
> ovpn_crypto_kill_key assumes both crypto slots are populated and
> dereferences each slot before checking it. That is not guaranteed: a
> peer can have only one installed key, and the kill path may be asked to
> remove a key that is not present.
> 
> Read each slot once while holding the crypto state lock, check for NULL
> before looking at key_id, and only replace the slot that actually
> matches.
> 
> Fixes: 89d3c0e4612a ("ovpn: kill key and notify userspace in case of IV exhaustion")
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
> Changes since v4 of this series https://lore.kernel.org/openvpn-devel/981d2ea51cca45138210aa52c6e5a0e55c0da7a0.1783099626.git.ralf@mandelbit.com/
> - Add this previously posted standalone fix to the series so the whole
>   set can be picked in order.
> - No changes since v2 of the original single patch
>   https://lore.kernel.org/openvpn-devel/19318904cf077d067cd4ec628a22bab03ed7dd29.1782993857.git.ralf@mandelbit.com/
> 
> Changes since v1 of the original single patch https://lore.kernel.org/openvpn-devel/9fc33e6f9fae10b9e372a3e06934d697edf5b024.1782829171.git.ralf@mandelbit.com/
> - Remove unnecessary braces around single-statement if/else branches.
> 
>  drivers/net/ovpn/crypto.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
> index 90580e32052f..8cb7078a1d93 100644
> --- a/drivers/net/ovpn/crypto.c
> +++ b/drivers/net/ovpn/crypto.c
> @@ -58,15 +58,19 @@ void ovpn_crypto_state_release(struct ovpn_crypto_state *cs)
>  bool ovpn_crypto_kill_key(struct ovpn_crypto_state *cs, u8 key_id)
>  {
>  	struct ovpn_crypto_key_slot *ks = NULL;
> +	struct ovpn_crypto_key_slot *tmp;
>  
>  	spin_lock_bh(&cs->lock);
> -	if (rcu_access_pointer(cs->slots[0])->key_id == key_id) {
> +	tmp = rcu_access_pointer(cs->slots[0]);
> +	if (tmp && tmp->key_id == key_id)
>  		ks = rcu_replace_pointer(cs->slots[0], NULL,
>  					 lockdep_is_held(&cs->lock));
> -	} else if (rcu_access_pointer(cs->slots[1])->key_id == key_id) {
> +	else
> +		tmp = rcu_access_pointer(cs->slots[1]);
> +
> +	if (!ks && tmp && tmp->key_id == key_id)
>  		ks = rcu_replace_pointer(cs->slots[1], NULL,
>  					 lockdep_is_held(&cs->lock));
> -	}

I find the "!ks && tmp" logic really confusing. Maybe something like
this (untested) would be more readable?


	int slot;

	spin_lock_bh(&cs->lock);
	slot = 0;
	tmp = rcu_access_pointer(cs->slots[slot]);
	if (!tmp || tmp->key_id != key_id) {
		slot = 1;
		tmp = rcu_access_pointer(cs->slots[slot]);
	}

	if (tmp && tmp->key_id == key_id)
		ks = rcu_replace_pointer(cs->slots[slot], NULL,
					 lockdep_is_held(&cs->lock));
	spin_unlock_bh(&cs->lock);
[...]



-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
