Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DE1C5CFCF
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=byFb5tgSxAOMB8LrA/IC6w5+Weny970SjUGfhVjLqEc=; b=Vr7inHe2yVWLZUvDik51pP0Bam
	MZarayvuAixx+7B1fFELbshHTDhl7X4yoQpsY9E10gI2n2uLlU00uOJoVFvfvQB0l6nLjgD2tdTZa
	X1XGhYw30FpEPBhi4KkGLpmDXyc726OoACwZ/8nH2q66kjmA5iEeq0w0Q3FnL7LNpGj0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYxu-0007wA-N7;
	Thu, 13 Aug 2026 17:11:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wuYxs-0007w1-Tm
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zRv+/V1t3F55v24W5CSvbViDZ55gyoDz0uk+zo5jsBA=; b=a8xcnacFfVoB6blehSWDWnh2Oa
 a7WDF+feX40GBD6f078534SltYLHIGrM5i9d9jiXZDS3ptHnxAY9/Nukty+4mxPOXbFIiOZAR4JGy
 gt2G0pirBJy6Oth8vWe9LcVSbGWO77uOGuL/vcdS3fkHxfdFoapbpfw9wF2EEle8ExNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zRv+/V1t3F55v24W5CSvbViDZ55gyoDz0uk+zo5jsBA=; b=E+mlEgA09KaI0yPVSpSAcezD6/
 p4n9XbgRneK3CHbJhi6Gs4Av5InmaCSc8t67cOUKJvb2c9NpBgeOpvHZTpV8p1qeov1d8tsQKWsLE
 HKwTl1ZU0uXMHG4rqQM8Uvz8nxZUr+z28Swxz/UJIL7c75uFKyaSTlf9pVcyGys8TEK0=;
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuYxr-0005SK-H1 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 17:11:37 +0000
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id BBC961D000AF;
 Thu, 13 Aug 2026 12:55:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 13 Aug 2026 12:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786640136; x=
 1786726536; bh=zRv+/V1t3F55v24W5CSvbViDZ55gyoDz0uk+zo5jsBA=; b=G
 ct/hw7315Yxi1/EPidcAPXUzrqYsNX+neDNGS/kxLBsoylmd+jlcS0topJu04rDr
 2pz33rD0SJZUr2pFbvYZattBFCwdYg1a4ymfNshLOT+OQ6npGmSi5D8It8JsxVCH
 yvr4VmA+xLqxd1FB3TsMK2b5kF35rtdsmpBruY6GJDCY3eTR0hl1ABLox+CKBlxI
 xfNks7aQl70Io/20cJKthvx6g/wvFpn3U10KppA59HeN0RuwhHx+mLCloW/26VQ3
 7Z2xxh7bfeTOWqacW6AL0IMya+06JsfmnTO8vRpp0n4U+DK0fNmww6eUewra1oXr
 sUxLX7Ns5pCAbZr3odCag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786640136; x=1786726536; bh=zRv+/V1t3F55v24W5CSvbViDZ55gyoDz0uk
 +zo5jsBA=; b=I0DbQVjbu+dH4RtllzijNtIwqe43RLoz80ygltUQpqylfLO9utT
 RTyYZxMym7yK0GsD07zE3/8Gc8Sm57c/RKKBxwJLf7zWIKI35Rk/qMXg/+KSIsL+
 4FrZKv54Am6MUBmRNFjQodc2o90fJPPcqiG/q0LyUfHT8y0ewD6qDd0IC33awa4H
 lB3DDNIeudY1rhu8Bx8OH2GK2oQgzFUqyJORi9q0FdzkmC1rBHwxEf7onqu5B1fl
 Mdu1a3Wa4xaQKQBmzT4anHKeBITDKifBf0EXgQ5pUSoFwZv0De7rA97qkZu+XLwZ
 O9PIp9KAO8GYlt+Y16L2zVAL8nv0QUdq+FQ==
X-ME-Sender: <xms:CPd9aj7XggWcaX37dvPOOcOeo2tf9_fulp7chkZrfU5zC6-OI34jlg>
 <xme:CPd9au740u-JV40DX3yUnQnRoRj_aKY2IWOh_vvMKvI4UwKM8Xg63jFqfR24GkwO7
 GACr9xwIW8ZZx7UY8EV8_lUsdCsE7w_3bOLHRmviwP5ZaVb2wf6w9Zv>
X-ME-Received: <xmr:CPd9aoHHKrxd51KiCYAxELRW7gzKjE313lH5pPF0oWnpMMhlQT6zQYqPaFo>
X-ME-Proxy-Cause: dmFkZTGvJdkcgBUbXdQbo1bZ/GJVnuzf0yQNGrpmyW4YNlV09S+4EhvJdMKmM14K18Qakm
 QR/5Bla6jNBIMf5BS6KrvFDTEn/tUHwfBc2PAUzlhDPSfFPhejws2bY8sfAlgPK++GoEuT
 zl9EzVGZQjJjhah+K+YGw2Z+5QSCg+wWx7cpPA7dxd7z17dfIBfkY45pBcSA/T8LivyIH6
 SFlEeEwXjgyaRHKrfmP6AgKaCPULtr3mni+pc3Jz1kYKzQJMJ1H6qnxg0WvSjR/eaFlCqa
 SGTQCZX01XenBuQbR7W9aPDIRUA43vDxIVOb4DiawfGmumEutm7sCYIFl6TYIl5030j4VN
 Yl7ZW58YiUcAvl2+vbDPb+QX/5ECET8slkFau1JfxXgYPYCN4QE24eRM1DE0Lla1arJw/D
 a5sAQkrOtryiddpGjzE/agbhrSsXVDtxoYasuMSr8jWpg3QwDOpa6ZQ9z+OxQb7rQ1G4rQ
 GtdNS6RRVK23K6U9gLjhcSO2iF/FFNBtpRaqHNIzOKRrbkhy5RvjVFbGiHRutFaQ+sI/TP
 5Ha5r+5auX7hnezFHmhPhcLvNoxy0D7CIBBY9vfqJlQ931Zvo++sx8K8cM3jUsvjr9pdyy
 Fem4NA5LDG9LH1vBe1ckJXGZQnmCnD2EsjEpLwvcaERH4RjHpjauxrShHvaA
X-ME-Proxy: <xmx:CPd9avQgO35vYKjHLSLourhZ96tboQlouZXxCXL-T5G_6d-NskXHIA>
 <xmx:CPd9apu9fsFURWSxImxDSv_PrZzMPGXyuUL1ycc8AlK5H2A1CalbrA>
 <xmx:CPd9amzoyxMeLSZI_vVbCocN5aKHhc2yrpW0XEKml80SDYXqdO4AOA>
 <xmx:CPd9ar6wx2fuwIYo0EV8JrSj-pY4Tno-u_nvlg9EKPn8yfXy8ZXQrA>
 <xmx:CPd9asIwekxMxLCvMjLiHuXp7o500x75NnPJP_ZTWp9FhC2yi9v7EHJ_>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 12:55:35 -0400 (EDT)
Date: Thu, 13 Aug 2026 18:55:33 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <an33BZPh-XSyJ2Ks@krikkit>
References: <cover.1785308184.git.ralf@mandelbit.com>
 <082540583b9145d89e1cdd5a74c485ea3a53d285.1785308184.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <082540583b9145d89e1cdd5a74c485ea3a53d285.1785308184.git.ralf@mandelbit.com>
X-Headers-End: 1wuYxr-0005SK-H1
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 4/5] ovpn: avoid in-place
 updates of peer bind local address
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

2026-07-29, 09:20:35 +0200, Ralf Lici wrote:
> struct ovpn_bind is published through peer->bind with RCU. Remote
> endpoint changes already replace the whole bind object, but local
> endpoint learning and UDP source fallback still updated bind->local in
> place. UDP TX can read it locklessly while another CPU updates it under
> peer->lock. For IPv6, that can produce torn reads of the address field.
> 
> Fix this by making the local endpoint immutable after publication too:
> build a new bind object with the updated local address and publish it
> through peer->bind.
> 
> When UDP TX discovers that the remembered local source is no longer
> usable, retry route lookup with a wildcard source. If the lookup
> succeeds and the bind used for the lookup is still current, invalidate
> the peer dst cache and best-effort publish a replacement bind with
> wildcard local address. The current packet can still be transmitted with
> the resolved route even if that bind replacement fails; a later cache
> miss will retry the repair.
> 
> Only store the resolved dst when the local address did not need to be
> reset. A local address change invalidates all per-CPU dst cache entries,
> while dst_cache_set_ip4 and dst_cache_set_ip6 only update the current
> CPU slot. Avoid the old reset-then-set pattern and let the next TX
> repopulate the cache from the new bind state.

This feels like 2 or 3 different bugs. At least making the endpoint
changes rebuild the bind object seems like a standalone patch.

> Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
> Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> ---
> No changes since v1 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785253480.git.ralf@mandelbit.com/
> 
>  drivers/net/ovpn/peer.c |  36 +++++++++-----
>  drivers/net/ovpn/udp.c  | 108 +++++++++++++++++++++++++++++++---------
>  2 files changed, 107 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 4806e942be27..383d712582c9 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
[...]
> @@ -267,26 +263,40 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>  					    netdev_name(peer->ovpn->dev),
>  					    peer->id, &bind->local.ipv6,
>  					    &ipv6_hdr(skb)->daddr);
> -			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
> -			reset_cache = true;
> +			local_ip = &ipv6_hdr(skb)->daddr;
>  		}
>  		break;
>  	default:
>  		goto unlock;
>  	}
>  
> -	if (unlikely(reset_cache))
> -		dst_cache_reset(&peer->dst_cache);
> -
> -	/* if the peer did not float, we can bail out now */
> -	if (likely(!salen))
> +	/* if there was no float and the local address is unchanged, bail out */
> +	if (likely(!salen && !local_ip))
>  		goto unlock;

nit: !salen is redundant? local_ip is also set in the float case.

but this whole check could be skipped by adding a "break" in the
"local endpoint changed" case and a "goto unlock" if nothing changed
in both cases of the skb->protocol switch.

>  
> +	/* if only the local address changed, populate ss with the current
> +	 * remote
> +	 */
> +	if (!salen)
> +		memcpy(&ss, &bind->remote,
> +		       bind->remote.in4.sin_family == AF_INET ?
> +			       sizeof(struct sockaddr_in) :
> +			       sizeof(struct sockaddr_in6));

nit: Maybe move that under the "learning local IPv*" blocks to avoid
the sizeof ugliness here?


-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
