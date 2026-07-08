Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5FBC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZ4pLGN6s0C+WbdZLfCe/FD9OBdUm+WiadmlmEcOZzs=; b=TebrLOC0r1wKJgHo8puiDySpv1
	G9nNNddrhfFievgms7v4mUKuoWAGDYV3ZIL4GtVAIwStjU8d2fGq8V56IVhA1Nww3ZQGpdQtT60RU
	G1u6jRFm7uAfT8HSeRooazsrKb6HImZB1hlkQCf1F8Ap4koCCIpRKD4oyuV1iASlwmvo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whPIk-0000Wi-QX;
	Wed, 08 Jul 2026 10:14:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1whPIO-0000WM-98
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 10:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tW6HOpsyIFchM8puA52poCQoI5e9gAgGwTbK1+AxXoc=; b=W1fYAgXucbu1RipTEOFdQ05mRg
 +MVvVmhBls13pDKCA/w8uvH5hgH+X2Zvwm6MwkabEOsFnpWWeSDGZs58A3AeAeBjAwY9GyHSoMKL8
 sPuge13jTdHAYCmKoOHBch0Gmy3JroFtl9ir++7GIe7+qpRJWyMB/TUCuOtR/FS8BkR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tW6HOpsyIFchM8puA52poCQoI5e9gAgGwTbK1+AxXoc=; b=nWZX+C0o4K3cKeHUlcmsRWi3ir
 T9OT0/FlXjhaKQiesKt/bG56/gKMohGkDzw4O+TBodj8I9wF2WoIDr18Ku5cxxaIk8wmfvV6oRbF7
 VRR3Dh62tkSHELfHNgGo9/6Mh5yMVo29V338pZyqi09WabNIhm6pTllYqDi2zZ7Epsjk=;
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whPIM-00075Z-Ni for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 10:14:24 +0000
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 1235D1D00183;
 Wed,  8 Jul 2026 06:14:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 06:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1783505651; x=
 1783592051; bh=tW6HOpsyIFchM8puA52poCQoI5e9gAgGwTbK1+AxXoc=; b=J
 xziIMR038R2mVW6Pt4tyybbxS4rb3npvy4kA/bxaxaniQUK8wWMS4g8ZTlvxkE1O
 vZk1OpGJSNFeNux1hrz9xSBoEuUzf7plLrWKtOoj2rIfGAUQhDykDMEa6i45ZebN
 w8egcizbP6nlyEIsbHdiJBtn8I0UzvFfLzZ1zjZtWCgB0Bo2bpJXQQUGWHm+HaG+
 Cjp3IcTXmQKu1T70qMpDS2HaAGzFUD6J5uumWhhAbgfnNUG8Dc19M7nJB//p56tr
 mp5/d2fR1cCuG132R0CyDJXUkY/QQ6Z+qE9OawdmzBhPTnKNGQ4J0AwNaGzmAiOq
 3qy/MIFwHJcMc2jd0cSGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783505651; x=1783592051; bh=tW6HOpsyIFchM8puA52poCQoI5e9gAgGwTb
 K1+AxXoc=; b=Nn+CzCoeCbhlPHyESfd+CBdLBa5k2Uq8K16UX74KdOzp73SVAlb
 PEX/+aLjo19aY2DrXBuZ2PW3o+LqBrknn8qKz94QCYnDoSZjVNaf2KYRRSyZcQ6M
 fUw3o2oufVtnKcaRUphjDyAimZf7NZChFxnJJvpYWzFiUl+p/eSG/zTGCE1HnxAS
 jcr0vQpCtnICpHEjNu+/VJ77dAFLX+Vi5YngploY67j6uugtZ+zJVYQsEalTJLS1
 m8hkMdBis6lNI3ngnPPovf2eF5+D3scM8ROi1cb5fp+Iy0qs8D5FwTmwTp3a7MZ/
 +99m1RlYM0HDtVeCg+LAU+t7qaY/GH3ferQ==
X-ME-Sender: <xms:8yJOav7pxreWs9E8WLuejiy9niWUHeYGrFKVC4uN-lIV13oQ5GSMzA>
 <xme:8yJOaq50p8gPhzmw1kV6OKbrE3YSZkjQoVbOphA7b2Sl0qipdwAn5h_eOTkhifhFI
 opQv3TUv7SJZIoPZPEZPR_UgdqfZEfzFLEL2QPt52V3b3pFjNtP5Q>
X-ME-Received: <xmr:8yJOakH40YpsV2KnH-ZJVb5IsLhs6TqNsIUyYCQBVPMw_2njTuJvza8VRH4>
X-ME-Proxy-Cause: dmFkZTEqG2Fg5c8hvLUAN7uAfOohbmujnSeTiWodWRfUwtv57RFX6cMkhylq5PV9PRXOBT
 Eu9UMkd4p+xHnb/Yk6wZWmz6BZC+WUKPfXkZ3aHDNYGPe1t2f+5ji7mwlVA9gfzATz0aWM
 CqJJwUkI7scBphudw9okJzMYO+R5Dfw/d40Z/PDTMI3+YouXn8m+puwgoqIxB7ITdbSfrR
 DgyoC5JEsqNp3GK/Vsqyef3YceesmQyeXwm0/ySmT1k2Ni3GB2QJDPAUdlMNEmaQ/IBn5g
 xCUQa8AjaKL1jLS/fHk3UcTqpuu9lgb4fNkzwxuED4Js9pIQZAaVHT5zOkqpVizb+r4ymi
 QCb9mF0E7tYMiYuEATn396mnk5O/7FwmqAZgCEqEpkCW1w1v9oQazJddBMXR4XxhYyY1Jj
 l5kp2qVPz2gDZ7xp2YIfrnUiCZpxkv+ei4bPzwj1BBztTPZ/pAEtcEo/Q567aiDehcOU/a
 gehXfzGcY7gicKPkk9NJSXBqZxs6RscYXcxvO0+79P+jfXah6/rfCOiadCe+p+y7wbGUrq
 vviWaUA3lCQ1N+QMX3AXKs9VOq2XkpcrawPw/lvntMU4Z8LxX3IinnTFqT1UH48cVjPnFv
 w2bizTOgMoIdOz7wBQV9ac7nWlCMsBaOHsyIg5QU8pUV0WCBqGMNwx9qGnVQ
X-ME-Proxy: <xmx:8yJOarRiNyKNDNz_jxzbS5WgkMuAN8XupkOcNaQ2YrZ1GIlLiNI_eA>
 <xmx:8yJOals8-VOyZM0JYrcYKACdtSaKIztP6LsWOQaHzq2uBB4mqjdiTw>
 <xmx:8yJOaixg1Ni14M3J6cWp1TWIJcsc44QKEmugn6ZtSOFOaP-Os6GqGQ>
 <xmx:8yJOan4t-cx3PNS_7RFdkk1M8yjwhMROYHUKzPv-2M5PzmMxMgbhrQ>
 <xmx:8yJOaoIZwhG7IhxXEjUHc0AJynLxMBq1mx-UKG4SjciWabMxcUpzEpvV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 06:14:10 -0400 (EDT)
Date: Wed, 8 Jul 2026 12:14:08 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <ak4i8LmnbeStiufT@krikkit>
References: <ak0KZ8XIkWh8e6AI@krikkit>
 <20260708070443.62591-1-ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260708070443.62591-1-ralf@mandelbit.com>
X-Headers-End: 1whPIM-00075Z-Ni
Subject: Re: [Openvpn-devel] [PATCH ovpn net v5 6/6] ovpn: defer key slot
 crypto freeing to workqueue
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

2026-07-08, 09:04:42 +0200, Ralf Lici wrote:
> On Tue, 07 Jul 2026 16:17:11 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> > 2026-07-06, 13:34:04 +0200, Ralf Lici wrote:
> > > Key slots are released through a kref and the existing release path frees
> > > the AEAD transforms from an RCU callback. That is not safe for all crypto
> > > implementations: crypto_free_aead can sleep, for example when an async or
> > > hardware implementation has teardown work to complete.
> > > 
> > > The AEAD transforms are only used while a key-slot reference is held, so
> > > the final kref put is enough to prove that no transform user remains.
> > > Queue the final crypto teardown on the ovpn workqueue, where sleeping is
> > > allowed, and keep the slot memory itself RCU-freed after the transforms
> > > have been released.
> > > 
> > > ovpn_crypto_config_get was the remaining lockless reader of transform
> >
> > nit: encrypt/decrypt is also lockless, the difference is only the
> > refcount, no?
> >
> 
> Correct, I meant the remaining reader of transform state without holding
> a key-slot reference. I'll reword that.
> 
> > > state through ovpn_aead_crypto_alg. Make it take a key-slot reference
> > > before reading that state, so the transform lifetime is consistently tied
> > > to key-slot references. The previous patch drains ovpn_wq during module
> >
> > Using rcu_work/queue_rcu_work (see commit 6624bba469a3 ("macsec: use
> > rcu_work to defer RX SA crypto cleanup out of softirq")) would avoid
> > some of the refactoring of the destroy helpers, and the (kind of weird
> > and ugly IMO) refcount dance in ovpn_crypto_config_get (with a fairly
> > big risk of "well it's dumb to take a refcount here, we could just do
> > everything under RCU").
> >
> 
> One thing I am not fully sure about in this case is the module-exit
> ordering. If key-slot release uses queue_rcu_work, the work item is not
> queued immediately. The final put first schedules an RCU callback, and
> that callback later queues the actual work on ovpn_wq, right?

AFAIU, yes.

> Does that mean ovpn_cleanup would need a different ordering from the
> current destroy_workqueue; rcu_barrier shape?
> 
> In particular, with this series ovpn_wq also runs ordinary ovpn work
> items, such as the TCP deferred-delete worker and keepalive work. Those
> can drop peer references, and the final peer put can release the crypto
> state and queue a key-slot rcu_work. So if we only move rcu_barrier
> before destroy_workqueue, maybe an already pending/running ovpn worker
> could still queue a new rcu_work after the barrier has returned.

Right, that's... a bit hairy.

> Would the safe shape be something like:
> 
>     drain_workqueue(ovpn_wq);
>     rcu_barrier();
>     destroy_workqueue(ovpn_wq);
> 
> so that ordinary ovpn work is drained first, including chained work
> queued by already running ovpn workers, then pending rcu_work callbacks
> are forced to queue their actual work, and finally the workqueue drains
> that cleanup work before being destroyed?

I'm not sure. The comment for drain_workqueue() says:

 * Wait until the workqueue becomes empty.  While draining is in progress,
 * only chain queueing is allowed.  IOW, only currently pending or running
 * work items on @wq can queue further work items on it.  [...]

So any attempt to queue from other contexts will fail (and actually
trigger a WARN it seems, __queue_work -> __WQ_DRAINING), for example
from TCP. Even without the warning, for things like keepalive or
tcp_tx, it shouldn't matter, since we're already cleaning up. Maybe
also defer_del_work, since the peer should already be going away with
its netdevice. But it we can't queue key slot freeing, it's going to
leak.


Would flush_workqueue() be enough? By the time rtnl_link_unregister()
returns, ndo_uninit() has been called for all ovpn devices
(__rtnl_kill_links() -> unregister_netdevice_many_notify() ->
->ndo_uninit()) so ovpn_peers_free() has removed all the peers from
the hashtable/p2p slot.

ovpn_peer_keepalive_work_{p2p,mp} should probably copy the "prevent
double remove" check from ovpn_peer_remove() as "don't do anything for
already deleted peers". tcp_tx_work can queue defer_del_work but the
same check could be used. With this, after rtnl_link_unregister()
returns, there should be no work capable of requeueing work on
ovpn_wq, so no more keepalive_work or defer_del_work running once
flush_workqueue() returns, or maybe only "empty" ones that will just
return immediately without doing anything.

The final destroy_workqueue() will take care of any keyslot
cleanup that has been queued after flush_workqueue() started (whether
it was while flush_workqueue() was running, or during the
rcu_barrier()).

Am I making any sense? (it's quite possible I need another 3 cups of
coffee for this type of reasoning :))

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
