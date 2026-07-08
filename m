Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B228EC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HaDus4G5UORcMZhRNNEo8KnKA0kXbuwgoeNV9HWzeyI=; b=kviI4Wzc8JJ0lPltHboQ4MKMaT
	GrImjvJmX8kT9DcqqHV22wCq0ydcTzVeDjlJ2amvRTNJzBEBvxTbcDiu0GLOE8d7wK1ySFJAE8bzo
	o/18RH9e76HU0TirzEUI+LU/JSzjFWWV7r+EZMob1/7VvJy2OG0wva6XIohsDhBL/z/E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whMLK-00043v-MD;
	Wed, 08 Jul 2026 07:05:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1whMLJ-00043F-PS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 07:05:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uFhRQRHoQB5/eeaG7Qv/hcb/mxUBWAKcD9Qh68CJDao=; b=Oq9owOvfdnewRYVt+ejWQblsuB
 yn0ExUKoD2JbyWzDT2u0wj73lOJxPs4LXh1cBxmnXPwAdUHDlunUHKKh6/tuwciAEqxrAk8T0NPFk
 I0XyMWaLVlefMtAD1oJ3Syv9pGGweOZykyr7dveZbASbyV8n2FxN6vYdEPtskPSlwXPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uFhRQRHoQB5/eeaG7Qv/hcb/mxUBWAKcD9Qh68CJDao=; b=T2P5uKuDj/2vifulEu0YvL7j2K
 uKSGRsNphBzGeUjTXqsWA/3tNoPcmDRAg2S9iu7tFGpEDuuMrMHatiIyNC7pqKb97/fQU5G2I9AND
 oH/PTYlkE6nWtWwh2vNc43ZTMZcoL4E7x8woGw++XtS6/g3Y42Rr59GZORxeXAkalFP4=;
Received: from mout-b-107.mailbox.org ([195.10.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whMLD-00011u-Lv for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 07:05:09 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4gw8HB5fKqzDs81;
 Wed,  8 Jul 2026 09:04:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783494294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFhRQRHoQB5/eeaG7Qv/hcb/mxUBWAKcD9Qh68CJDao=;
 b=wghSflv4MUl84DmukQrxeAYgKQtWlXbY30EqQ2nX1NPE4QoVFn4tKZLuzSt+8fXH8Jcnc5
 kNXBi022aZG9RMXq2ClFsRS0pcdY0rXtah3a4tPEPLecgZRxXCwGJ7ErXQewOWNghlEyGv
 QhjCeLkr0h8gsT5DRBL+rHD75Rro/NpXdnAydQx0Sm9qKMrZ+q1AblKjWlP95U5Nz4D6ps
 T5eYRJv4U0Wz/pUlXXSvUPUI7zmXm5CmU7j4e1pfrSyKpSBo6m9QqbADWR39+P0CmcH4sp
 ex21zc9n6YRlQT3c0vKiL2KpvcEUJvQ6UX7aiWeJ+gDApJrpsrn+fQ7LdI2zkw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Wed,  8 Jul 2026 09:04:42 +0200
Message-ID: <20260708070443.62591-1-ralf@mandelbit.com>
In-Reply-To: <ak0KZ8XIkWh8e6AI@krikkit>
References: <ak0KZ8XIkWh8e6AI@krikkit>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gw8HB5fKqzDs81
X-Headers-End: 1whMLD-00011u-Lv
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

On Tue, 07 Jul 2026 16:17:11 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-07-06, 13:34:04 +0200, Ralf Lici wrote:
> > Key slots are released through a kref and the existing release path frees
> > the AEAD transforms from an RCU callback. That is not safe for all crypto
> > implementations: crypto_free_aead can sleep, for example when an async or
> > hardware implementation has teardown work to complete.
> > 
> > The AEAD transforms are only used while a key-slot reference is held, so
> > the final kref put is enough to prove that no transform user remains.
> > Queue the final crypto teardown on the ovpn workqueue, where sleeping is
> > allowed, and keep the slot memory itself RCU-freed after the transforms
> > have been released.
> > 
> > ovpn_crypto_config_get was the remaining lockless reader of transform
>
> nit: encrypt/decrypt is also lockless, the difference is only the
> refcount, no?
>

Correct, I meant the remaining reader of transform state without holding
a key-slot reference. I'll reword that.

> > state through ovpn_aead_crypto_alg. Make it take a key-slot reference
> > before reading that state, so the transform lifetime is consistently tied
> > to key-slot references. The previous patch drains ovpn_wq during module
>
> Using rcu_work/queue_rcu_work (see commit 6624bba469a3 ("macsec: use
> rcu_work to defer RX SA crypto cleanup out of softirq")) would avoid
> some of the refactoring of the destroy helpers, and the (kind of weird
> and ugly IMO) refcount dance in ovpn_crypto_config_get (with a fairly
> big risk of "well it's dumb to take a refcount here, we could just do
> everything under RCU").
>

One thing I am not fully sure about in this case is the module-exit
ordering. If key-slot release uses queue_rcu_work, the work item is not
queued immediately. The final put first schedules an RCU callback, and
that callback later queues the actual work on ovpn_wq, right?

Does that mean ovpn_cleanup would need a different ordering from the
current destroy_workqueue; rcu_barrier shape?

In particular, with this series ovpn_wq also runs ordinary ovpn work
items, such as the TCP deferred-delete worker and keepalive work. Those
can drop peer references, and the final peer put can release the crypto
state and queue a key-slot rcu_work. So if we only move rcu_barrier
before destroy_workqueue, maybe an already pending/running ovpn worker
could still queue a new rcu_work after the barrier has returned.

Would the safe shape be something like:

    drain_workqueue(ovpn_wq);
    rcu_barrier();
    destroy_workqueue(ovpn_wq);

so that ordinary ovpn work is drained first, including chained work
queued by already running ovpn workers, then pending rcu_work callbacks
are forced to queue their actual work, and finally the workqueue drains
that cleanup work before being destroyed?

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
