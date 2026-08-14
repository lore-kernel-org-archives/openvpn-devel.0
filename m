Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B86C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EtA55tRRUaiokVRIQwDhRyhGKch1xCvPB5GP3cdVWCk=; b=deUG0vlUTHA5flVesGMkFDThx8
	65j/MGxvLRPE8NIzJl8bPbzFqwxCuQ5AdjNo4Kh8kO8LwRT7QwgRDVKdYKCouc7I+RuFVOSafS5ND
	VY0ft8wQ7rFBQnCqw1BXrv+xbZwcN+0y3hnsenQxyl+UVW83NWU2cUlkdFVeZo6blLFA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wunEq-0007Wq-4e;
	Fri, 14 Aug 2026 08:26:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wunEf-0007UF-Lj
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:25:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m0jR+dd1Y/lyyPdOMOXokAkgB2OZWOcX8fo/seQume8=; b=FuZN8yJkmyIjIfIthFeqsGdRbr
 yBfwD3WhT/3uDB4q5SOXdW0AZTdIqTHycyx8FZI3IVNBdg2JjLYQnxSL4CMBuvNBhY1YxrKJ3FZsd
 CRV3TRlCV8ySbst/HYhwDFZ5fy+5MPvhXmh8EcDVNzQ7FXJnRSTQzMeRzVC3+AbSYH/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m0jR+dd1Y/lyyPdOMOXokAkgB2OZWOcX8fo/seQume8=; b=HG77W0xcG2O9dZpngcyVt1+h+k
 3vynTAxZc6I12SkmObRmOKavvAxo4AvJmTWyWh+R8hjHbFzFIoQ0v5xV0hjw7XAP56RrXx9jXUtV1
 +AtahMlLaib9qPdfs3UNPW6bQnpPfiLZGr6iz8p2+t7/Amvqct5BM/tBFWTv+q7/JmVo=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wunEc-0005rg-KD for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:25:51 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4hLwKG4FxJz5wmw;
 Fri, 14 Aug 2026 10:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1786695938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0jR+dd1Y/lyyPdOMOXokAkgB2OZWOcX8fo/seQume8=;
 b=LS+CCAIBMqdOodrektsthtgh9nfUzituvJVnW8wS281vvjexyMJBo7Lsvjr0yGK0dOzTht
 6VixjiE4m/J1hdFyvVUbuPNSpK4/2L3LSdyCJiS7idLY+nmX7RjIPSE4V3H83CUrK9YmUh
 Pt3fG+HsJOHHGZuUO348z7OhEhTMnv+T9gs3kibWUb5Xy38oF8dbQEzVzLwLKCyymKRc/t
 7aNpZDDRR4413C0+g0x04cpo1jiVg/0lTMTEQQ6m9PfCxCqsc4o8+maPnYjk+xwk4XhxX+
 SL5YElp05FLLBQq/9fHUzO6PYRsCk4n65lkMALjWr+gkmlmyta3n6A/Ja4eChw==
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Fri, 14 Aug 2026 10:25:29 +0200
Message-ID: <20260814082530.190853-1-ralf@mandelbit.com>
In-Reply-To: <an33BZPh-XSyJ2Ks@krikkit>
References: <an33BZPh-XSyJ2Ks@krikkit>
MIME-Version: 1.0
X-Headers-End: 1wunEc-0005rg-KD
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

On Thu, 13 Aug 2026 18:55:33 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> Hi Ralf,
>

Hi Sabrina,

> 2026-07-29, 09:20:35 +0200, Ralf Lici wrote:
> > struct ovpn_bind is published through peer->bind with RCU. Remote
> > endpoint changes already replace the whole bind object, but local
> > endpoint learning and UDP source fallback still updated bind->local in
> > place. UDP TX can read it locklessly while another CPU updates it under
> > peer->lock. For IPv6, that can produce torn reads of the address field.
> > 
> > Fix this by making the local endpoint immutable after publication too:
> > build a new bind object with the updated local address and publish it
> > through peer->bind.
> > 
> > When UDP TX discovers that the remembered local source is no longer
> > usable, retry route lookup with a wildcard source. If the lookup
> > succeeds and the bind used for the lookup is still current, invalidate
> > the peer dst cache and best-effort publish a replacement bind with
> > wildcard local address. The current packet can still be transmitted with
> > the resolved route even if that bind replacement fails; a later cache
> > miss will retry the repair.
> > 
> > Only store the resolved dst when the local address did not need to be
> > reset. A local address change invalidates all per-CPU dst cache entries,
> > while dst_cache_set_ip4 and dst_cache_set_ip6 only update the current
> > CPU slot. Avoid the old reset-then-set pattern and let the next TX
> > repopulate the cache from the new bind state.
>
> This feels like 2 or 3 different bugs. At least making the endpoint
> changes rebuild the bind object seems like a standalone patch.
>

Agreed. My plan is to split this in 3 patches:

1. Validate bind identity and route key before publishing a looked-up
   dst;
2. Make ovpn_peer_endpoints_update replace the bind when learning a new
   local endpoint;
3. Make the UDP output fallback replace the bind when clearing a stale
   local source.

> > Fixes: f0281c1d3732 ("ovpn: add support for updating local or remote UDP endpoint")
> > Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> > ---
> > No changes since v1 https://lore.kernel.org/openvpn-devel/082540583b9145d89e1cdd5a74c485ea3a53d285.1785253480.git.ralf@mandelbit.com/
> > 
> >  drivers/net/ovpn/peer.c |  36 +++++++++-----
> >  drivers/net/ovpn/udp.c  | 108 +++++++++++++++++++++++++++++++---------
> >  2 files changed, 107 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> > index 4806e942be27..383d712582c9 100644
> > --- a/drivers/net/ovpn/peer.c
> > +++ b/drivers/net/ovpn/peer.c
> [...]
> > @@ -267,26 +263,40 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
> >  					    netdev_name(peer->ovpn->dev),
> >  					    peer->id, &bind->local.ipv6,
> >  					    &ipv6_hdr(skb)->daddr);
> > -			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
> > -			reset_cache = true;
> > +			local_ip = &ipv6_hdr(skb)->daddr;
> >  		}
> >  		break;
> >  	default:
> >  		goto unlock;
> >  	}
> >  
> > -	if (unlikely(reset_cache))
> > -		dst_cache_reset(&peer->dst_cache);
> > -
> > -	/* if the peer did not float, we can bail out now */
> > -	if (likely(!salen))
> > +	/* if there was no float and the local address is unchanged, bail out */
> > +	if (likely(!salen && !local_ip))
> >  		goto unlock;
>
> nit: !salen is redundant? local_ip is also set in the float case.
>

Good catch.

> but this whole check could be skipped by adding a "break" in the
> "local endpoint changed" case and a "goto unlock" if nothing changed
> in both cases of the skb->protocol switch.
>

Right, that's cleaner. I'll break from the switch when the local
endpoint changed and go directly to unlock when nothing changed.

> >  
> > +	/* if only the local address changed, populate ss with the current
> > +	 * remote
> > +	 */
> > +	if (!salen)
> > +		memcpy(&ss, &bind->remote,
> > +		       bind->remote.in4.sin_family == AF_INET ?
> > +			       sizeof(struct sockaddr_in) :
> > +			       sizeof(struct sockaddr_in6));
>
> nit: Maybe move that under the "learning local IPv*" blocks to avoid
> the sizeof ugliness here?
>

Yes, agreed. I'll move the copy into each local-endpoint learning block.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
