Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29889C531F9
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bv+82I5ekuYArNMM82Nk+cFeu6N0qImBmfZv+/KaSFk=; b=BNObUfjRTRxVVPwRQb5qrAvUzY
	QF3SB8GqkyfByED1uMjthFhwyhx78FDOUnOk8JhCLjYbXj6T2fQwv9kGKYNk1/jyZ1zxxanRIB+ow
	A9z/R/0iDGOL+4rX56dbLEtmQJyFDxN3rmg3/Xgw3FH0M3JHhlKE0FJr5MLwLieG9B4g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wokYU-0003aJ-UB;
	Tue, 28 Jul 2026 16:21:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wokYS-0003aA-OE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 16:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5eGSQMJY3iU4r22mm95MhTw5uTVzk+3vL3ZR7xzicJU=; b=B6olHO2kqJM+FPl6FZLpy+myWn
 xkt3yoIzdOGHBB+0SRlX4V69nlHnKWFXOJ7o71IFtM+5FQ66Wk/2vVl/shG+jzt1MJlWIlU/2uHG7
 Iihf8X4uCI2DuhtT5CUcePZdWE/WyoZI/fYlAoZQb5HaAxxjdhVK2MjkbP7YLkwWrwJk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5eGSQMJY3iU4r22mm95MhTw5uTVzk+3vL3ZR7xzicJU=; b=ktP5BlOEi96YHXuwbmZ0NRZX2E
 k7U2SLznqTMCueHfXVJU7/qfI6gDuobTeKAV5iXf1IBhrJ/uObB7xE3tpz7qXrpnJBWgzgnVDiAOw
 HJ5aVyghoeeE75zEpdavxm/eOcbU5UP6tKTrLKF5IPiPxX/m6+5dn8WJTOWlq9miHeWE=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wokYU-0003U4-Og for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 16:21:21 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4h8ggq5QzNzFr0T;
 Tue, 28 Jul 2026 18:21:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1785255671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eGSQMJY3iU4r22mm95MhTw5uTVzk+3vL3ZR7xzicJU=;
 b=Hv2eqBHSP31ezpJpSgLv62YbYkaIrNEPBwfyJ39yA7pd94xaBR3EvXsMIYu/NUe7pW7K7w
 UADWjApOLN1iKy6pXI8MpeVfuJAC3rbnvy6OX/KckkjW/Awm9pAQWko6PC6vnbXSLbhoAc
 5M6WUARs7aoqq+6VHKA/BAtOC96n17nswOz0dNZn0UztPzuKUDS+ngJZqUqg6MgssjUBN5
 ouOTsVOu1xC7Qmw1dAL9pHMBHw4G4rnOWLA03yqT04O3TGgdlbJX7IE5l8qJ6VsLq8r3S8
 FNV7UzTfEzgZk2yu1ZUS71D6tJDEYfCymVamzGdG3ffasNd23t212w7Xt6OcRw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Tue, 28 Jul 2026 18:21:04 +0200
Message-ID: <20260728162105.739734-1-ralf@mandelbit.com>
In-Reply-To: <amiIGDgDhnc8ntZ9@krikkit>
References: <amiIGDgDhnc8ntZ9@krikkit>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4h8ggq5QzNzFr0T
X-Headers-End: 1wokYU-0003U4-Og
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

On Tue, 28 Jul 2026 12:44:40 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-07-08, 17:30:49 +0200, Ralf Lici wrote:
> > On Wed, 08 Jul 2026 12:14:08 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> > > Am I making any sense? (it's quite possible I need another 3 cups of
> > > coffee for this type of reasoning :))
> > >
> > 
> > Yes, definitely it makes sense.
> > 
> > I went through the ovpn_wq producers:
> > - ovpn->keepalive_work: disabled from ovpn_net_uninit before peers are
> >   freed;
> > - peer->keepalive_work: queued by the scanner, it holds a peer reference
> >   and can indirectly hit the TCP deferred-delete path through TX
> >   failure;
> > - peer->tcp.defer_del_work: queued from TCP RX/TX error paths, each
> >   successfully queued instance owns a peer reference and peer release
> >   drops crypto state before dropping the netdev reference;
> > - sock->tcp_tx_work: queued from TCP write_space, socket teardown
> >   cancels it;
> > - key-slot free work/rcu_work: queued from final key-slot put.
> > 
> > So after rtnl_link_unregister has returned, I don't see a peer-owned
> > producer that can create new key-slot rcu_work without first holding a
> > peer reference that would have kept unregister_netdevice waiting. Then
>
> All those objects referencing each other make it really hard to reason
> about correctness :/
>

Yeah, same. I wasn't expecting it to be such a maze either at first.

> > flush_workqueue waits for the remaining worker tails that may still be
> > executing module text. After that, rcu_barrier forces pending rcu_work
> > callbacks to queue their actual work, and destroy_workqueue drains that
> > cleanup work before module text goes away.
> > 
> > So the ordering I'd use with queue_rcu_work is:
> > 
> >     ovpn_nl_unregister();
> >     rtnl_link_unregister(&ovpn_link_ops);
> >     flush_workqueue(ovpn_wq);
> >     rcu_barrier();
> >     destroy_workqueue(ovpn_wq);
> > 
> > Makes sense?
> > 
> > Avoiding work on deleted peers is nice cleanup, but I don't think the
> > unload safety depends on it because the stronger invariant is that any
> > peer-owned work that can queue more work either already owns a peer ref
> > or takes one before queueing.
> > 
> > WDYT?
>
> All this looks correct. Thanks.
>

Perfect, then I'll respin the series with the fixes we agreed on.

Thanks!

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
