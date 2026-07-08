Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014B4C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NOSulcpYGIIiQ+ZA/ebRiWwybCESZsygLNcL3pjv9gI=; b=iN931/9oSsu5Fl1c3IJIAHL5La
	xaFTB2mnfnv5Z1eTJkEBd9DIItRTY3TQUdrG4k4WO8xDOJyz9bWs1c090MtGpBunTCf6lxC5nHFw3
	M7m7/JJoOSuFNMZ63CC9n8mTV9QsS9HUfjza1eQY/8yPT/mSyCEBr579Rbq+YjfkM8zA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whUG0-0004Yd-Qx;
	Wed, 08 Jul 2026 15:32:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1whUFm-0004Y1-Mw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:32:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SknBqmUhY+ZoTDK6O6aVEmYnMC3nMB6DO9neG5J3ips=; b=OFH9QyE3lRLIZ86+1hpF3pce1Z
 620Q8nvnflu92OhMRooW3qVpkw/9XCHSlqUWaY7dDjgDqQyB8heMIr00HVuiVrLlGWuoVXk8b1w6q
 Sy89vbQMtMz8NE6MdVis5WF2oji61k0zO/THJnItrxr39N7NktKt69zmgeZ2qhFGGayo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SknBqmUhY+ZoTDK6O6aVEmYnMC3nMB6DO9neG5J3ips=; b=OKNzqQrA3Y6l46j6OT/LPTJ6h+
 nXq3zVhea7sRqjTz+czWuXkRPc9vBhSzCx8C/l/8GoKoMFnGz2y6VxaUrIYguPoz+UbaGtdEgBHOH
 IKcfE3iIDZRyGqUTAx/elhiecwTtQiDeRI0obpDmnIjXvKsfokOmKYlnaR2LSnwhbv8Q=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whUFa-0007gW-Vw for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:31:53 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4gwMWt0bvtzDsRb;
 Wed,  8 Jul 2026 17:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783524698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SknBqmUhY+ZoTDK6O6aVEmYnMC3nMB6DO9neG5J3ips=;
 b=xcIUwYJwiDYlD6PWtS0ISQ1eAOeR+/DG3lWU7gTlWt0Ad9VBYQ6YVoklV2HczwjiTvFhRT
 Jr3ahprhS8pE0NyItUME3V/mLA1NFVTG58AGv0rZS6p5gIm2yY5aM+keHyZVMk0OrsLZ/p
 C7TcujXzySX0VC8weChXv/3n86SkTLoRxE9/BITww+QHd3YkZZ0VFhx01NwpPJYPyW5VmB
 c8Rtcs3KKCMp3a/2JcOGdSTFRWcbCT8t+tuCDrD17DMGyjg9DiFDVO+uHIrcXU8PsgWX+q
 YpOQxqOMOEk4RR3s/2JoH4Mx1Is7AT6ZDa4t1VweLlSSokG1QQrEdzs7MviSmQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Wed,  8 Jul 2026 17:30:49 +0200
Message-ID: <20260708153126.590075-1-ralf@mandelbit.com>
In-Reply-To: <ak4i8LmnbeStiufT@krikkit>
References: <ak4i8LmnbeStiufT@krikkit>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gwMWt0bvtzDsRb
X-Headers-End: 1whUFa-0007gW-Vw
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

On Wed, 08 Jul 2026 12:14:08 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-07-08, 09:04:42 +0200, Ralf Lici wrote:
> > On Tue, 07 Jul 2026 16:17:11 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> > > 2026-07-06, 13:34:04 +0200, Ralf Lici wrote:
> > > > Key slots are released through a kref and the existing release path frees
> > > > the AEAD transforms from an RCU callback. That is not safe for all crypto
> > > > implementations: crypto_free_aead can sleep, for example when an async or
> > > > hardware implementation has teardown work to complete.
> > > > 
> > > > The AEAD transforms are only used while a key-slot reference is held, so
> > > > the final kref put is enough to prove that no transform user remains.
> > > > Queue the final crypto teardown on the ovpn workqueue, where sleeping is
> > > > allowed, and keep the slot memory itself RCU-freed after the transforms
> > > > have been released.
> > > > 
> > > > ovpn_crypto_config_get was the remaining lockless reader of transform
> > >
> > > nit: encrypt/decrypt is also lockless, the difference is only the
> > > refcount, no?
> > >
> > 
> > Correct, I meant the remaining reader of transform state without holding
> > a key-slot reference. I'll reword that.
> > 
> > > > state through ovpn_aead_crypto_alg. Make it take a key-slot reference
> > > > before reading that state, so the transform lifetime is consistently tied
> > > > to key-slot references. The previous patch drains ovpn_wq during module
> > >
> > > Using rcu_work/queue_rcu_work (see commit 6624bba469a3 ("macsec: use
> > > rcu_work to defer RX SA crypto cleanup out of softirq")) would avoid
> > > some of the refactoring of the destroy helpers, and the (kind of weird
> > > and ugly IMO) refcount dance in ovpn_crypto_config_get (with a fairly
> > > big risk of "well it's dumb to take a refcount here, we could just do
> > > everything under RCU").
> > >
> > 
> > One thing I am not fully sure about in this case is the module-exit
> > ordering. If key-slot release uses queue_rcu_work, the work item is not
> > queued immediately. The final put first schedules an RCU callback, and
> > that callback later queues the actual work on ovpn_wq, right?
>
> AFAIU, yes.
>
> > Does that mean ovpn_cleanup would need a different ordering from the
> > current destroy_workqueue; rcu_barrier shape?
> > 
> > In particular, with this series ovpn_wq also runs ordinary ovpn work
> > items, such as the TCP deferred-delete worker and keepalive work. Those
> > can drop peer references, and the final peer put can release the crypto
> > state and queue a key-slot rcu_work. So if we only move rcu_barrier
> > before destroy_workqueue, maybe an already pending/running ovpn worker
> > could still queue a new rcu_work after the barrier has returned.
>
> Right, that's... a bit hairy.
>
> > Would the safe shape be something like:
> > 
> >     drain_workqueue(ovpn_wq);
> >     rcu_barrier();
> >     destroy_workqueue(ovpn_wq);
> > 
> > so that ordinary ovpn work is drained first, including chained work
> > queued by already running ovpn workers, then pending rcu_work callbacks
> > are forced to queue their actual work, and finally the workqueue drains
> > that cleanup work before being destroyed?
>
> I'm not sure. The comment for drain_workqueue() says:
>
>  * Wait until the workqueue becomes empty.  While draining is in progress,
>  * only chain queueing is allowed.  IOW, only currently pending or running
>  * work items on @wq can queue further work items on it.  [...]
>
> So any attempt to queue from other contexts will fail (and actually
> trigger a WARN it seems, __queue_work -> __WQ_DRAINING), for example
> from TCP. Even without the warning, for things like keepalive or
> tcp_tx, it shouldn't matter, since we're already cleaning up. Maybe
> also defer_del_work, since the peer should already be going away with
> its netdevice. But it we can't queue key slot freeing, it's going to
> leak.
>

Right, I wrongly assumed queue_rcu_work was "chain queueing" but it
queues from an RCU callback, not from a worker currently running on
ovpn_wq.

>
> Would flush_workqueue() be enough? By the time rtnl_link_unregister()
> returns, ndo_uninit() has been called for all ovpn devices
> (__rtnl_kill_links() -> unregister_netdevice_many_notify() ->
> ->ndo_uninit()) so ovpn_peers_free() has removed all the peers from
> the hashtable/p2p slot.
>
> ovpn_peer_keepalive_work_{p2p,mp} should probably copy the "prevent
> double remove" check from ovpn_peer_remove() as "don't do anything for
> already deleted peers". tcp_tx_work can queue defer_del_work but the
> same check could be used. With this, after rtnl_link_unregister()
> returns, there should be no work capable of requeueing work on
> ovpn_wq, so no more keepalive_work or defer_del_work running once
> flush_workqueue() returns, or maybe only "empty" ones that will just
> return immediately without doing anything.
>
> The final destroy_workqueue() will take care of any keyslot
> cleanup that has been queued after flush_workqueue() started (whether
> it was while flush_workqueue() was running, or during the
> rcu_barrier()).
>
> Am I making any sense? (it's quite possible I need another 3 cups of
> coffee for this type of reasoning :))
>

Yes, definitely it makes sense.

I went through the ovpn_wq producers:
- ovpn->keepalive_work: disabled from ovpn_net_uninit before peers are
  freed;
- peer->keepalive_work: queued by the scanner, it holds a peer reference
  and can indirectly hit the TCP deferred-delete path through TX
  failure;
- peer->tcp.defer_del_work: queued from TCP RX/TX error paths, each
  successfully queued instance owns a peer reference and peer release
  drops crypto state before dropping the netdev reference;
- sock->tcp_tx_work: queued from TCP write_space, socket teardown
  cancels it;
- key-slot free work/rcu_work: queued from final key-slot put.

So after rtnl_link_unregister has returned, I don't see a peer-owned
producer that can create new key-slot rcu_work without first holding a
peer reference that would have kept unregister_netdevice waiting. Then
flush_workqueue waits for the remaining worker tails that may still be
executing module text. After that, rcu_barrier forces pending rcu_work
callbacks to queue their actual work, and destroy_workqueue drains that
cleanup work before module text goes away.

So the ordering I'd use with queue_rcu_work is:

    ovpn_nl_unregister();
    rtnl_link_unregister(&ovpn_link_ops);
    flush_workqueue(ovpn_wq);
    rcu_barrier();
    destroy_workqueue(ovpn_wq);

Makes sense?

Avoiding work on deleted peers is nice cleanup, but I don't think the
unload safety depends on it because the stronger invariant is that any
peer-owned work that can queue more work either already owns a peer ref
or takes one before queueing.

WDYT?

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
