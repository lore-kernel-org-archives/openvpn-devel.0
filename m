Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2CEC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blVoSQUJkf0R77Pq0NwixbV9Orxbe9EGWqhHG3Qz9Io=; b=I6YTsMl//QVRzLFGhkJC1CG7Q2
	/bzZlI3oITUeK9msuZjsZvfSIRZYLtEva0ZM5PZHj/vJO8gOnnQ4jCDcINL2LdCN4EXDrfLrBMZP4
	8VjUnNv7BlbGNLqX1K/ILNFKd8GVgQqAcQq8yLSIRtmKAJbOXi/oqMkVkTk9K86pOi2E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wofJL-0004tC-NC;
	Tue, 28 Jul 2026 10:45:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wofIq-0004rt-Ok
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 10:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GzqJdOq4sU8WzX/2E8KNl2dosPjbyDuZG6+J2uXQdeQ=; b=hNJoIxQAae5SK1A6fBcVW9EX01
 YE+jTsBOdjHKAJ/Eix69/DG8ADThn9gwuD0+1mKOp3FylCF2O3w2LhdYwAF5cv+YSv1ZZR9k5hfsB
 yFN2wVBZRYzVauUtHk8eigC8fTGvet/5yUNVMO679DtqEhKfZIq6pYFPBP0zI6Okpvvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GzqJdOq4sU8WzX/2E8KNl2dosPjbyDuZG6+J2uXQdeQ=; b=JDy8z5B0uGCu1bVnC3jN8zw5I/
 xnfwkwzy1amaYOcl6VWTJG4DK4glpOHywEPfoFA+lF5e5Q0EXg0gKDiH39Da8dSqDh1EP6bfXpHLu
 qk65+umCq/8z++pholCCZA4KpSLsxAWWAEdm5Nlx3FA0h4iyqi5vRp9HBRFV9+nEVmWk=;
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wofIo-0001F4-5R for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 10:44:53 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4DE4114000CC;
 Tue, 28 Jul 2026 06:44:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 28 Jul 2026 06:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1785235483; x=
 1785321883; bh=GzqJdOq4sU8WzX/2E8KNl2dosPjbyDuZG6+J2uXQdeQ=; b=m
 eWbqQC5xutT3kHyfx1uHuu5b+aTHBR553bcr2XL3QZTUtawMUaUWdwkgESmEfbtQ
 Z0CE2GSXfTpNnfAiLz94zNAVB3nUNVtkv4ejJqcDvqoQhXwIwsQXsmEkqaoGyMUg
 hCIsvLgBaH/rD2wYR+9zGOyH17lXZLlJY4AbI/rhXZQ+CGVUUoPsrfHrOrva/wsn
 cwVdaqs1pLEovdn/FdA8yAVdIntVfRZIaOk89YkdH8c26qgfFJ6+EidEwABwEe9g
 dhM0IoEypbdxc6j9nuugpkNdc7VigeiNVixrqqEfWd8pu+XhhsEEWNkZBCoSVhFK
 SX0a1x2L5nO0MF+iP5wzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1785235483; x=1785321883; bh=GzqJdOq4sU8WzX/2E8KNl2dosPjbyDuZG6+
 J2uXQdeQ=; b=B++onz7071JqnqCPNCjH7TMFvvHI5IGiOGyJTf43ywNmY24J0MU
 6Spd++QmANzqZDutBPLlYfbDf9sQGtNE3UgByEJoSZxUUAFnh/K+zkhbJlAkqXT/
 FSRtlZlgJVs9j4NmIzV9hTtCe+xVsZUTyJZ1+PM5cCH8IauvgX+a6yrM0b1b2JD4
 +PG3Un84YjJnGJeSKoriYTT4oPUOPUAHmPQnqmNSJKpQTUhKkQOJcf2271UZIoBx
 jNvEhglwEYcL5hWac6XG3+5uhROX9hGbJna2tXiGoQo6a6D3RvDPBZPFRBLkPUid
 TzJA7VfpaobOOlZo9uWXVbW+f4U1mAwcujA==
X-ME-Sender: <xms:G4hoapJ2cviIg32r_h_gIfnBAAYvSkbqbv4uukm_yH_stzAnpWAcTw>
 <xme:G4hoarJHb2Jmf0nKyx9q4wtLfoQNm5VImkzvDo-KtxG1e81a8ouVERmCc5fY4uzH7
 l3i4UOjEVnVFGw6vApoIRpcsU8oOOztCPn0wCjYymHgi0PTPo4TJ1A>
X-ME-Received: <xmr:G4hoavVoLIz5y6AH8Wmra-dEWTSA_wPswmdgZKLYYpdM0C2Oyb6IJlPjBEE>
X-ME-Proxy-Cause: dmFkZTFTO/3K/9DCNuHPOiZmcyx7MfKJt0x8ihiTon3F5DJ3pqD9eRfoYeAyumu1rMmDrr
 A9InNgCb6OpvdcF7hNBVaBDvgs7sJ/eItUN2bI+lOEikkjifFRrzo3vqIqojcb2e9hrhXw
 E08Gs44GcTPQinT26xlgqFpojQbBPYYHHXpG5Mt0Clj4oW2aSAo2yKc+Msm2OVBPIMmZL7
 TJY/MU34oAajHOp9RRiW4RQNQxmA6fEuafgfv89ADWufRHTVldzwLDjBwdPTvwgBlZtDWI
 3MhEtKg3T743luOJeBdeXGUqdiINssEGX3MHmeX+MUCGtkW+cWXoAlV/dKfnmvlcw6iajj
 BjaQ7y/yGt7+/rFEjfjvuFzQid7SMtH+bvV8wW9tRvg053GLyAh3OFVtl7RcEkvnD2IPs6
 NobLkklPAC0VoWui/ejUzSbcFSaHm5CSZgEVAyfdrBHT5aJmc5JqpnCGb9U1kTxYEywPma
 E3CKgKjCIEyClAZIlAt5M33sWT38F1WZu5GFd3UouVX0juEvGWQfC3satzP4Y977mKlKHG
 CQ15zwYlwUr4LqlCHzXyj5vRjEu3l6hu8XcMNaARApynxjq5RNzyO0xpLccWHa9cJDAULR
 dPkYd6A8csbsCm87GcjAqN5uPqsX6atWWQXWi6BtRavDlJfZ4Btkv5sMqHIA
X-ME-Proxy: <xmx:G4hoalgX6_SLeBXLKeKpOqaE5qDRXrjT4RaakY5o6e0bnt8K2XfSvQ>
 <xmx:G4hoai9--D1gP8M0LmteRgMCh4aOPbdDpyJ4bAz2zeqNcEqEHGPIQg>
 <xmx:G4hoanDfF1frkvwz90nxPy8bZlyASo-couJ-L37gZrUUOv9xMfsPJg>
 <xmx:G4hoanJ1vX4Apn1w1a_lfm_wrKGYI8kxau9nxR9Qkl6-JYxHHqLpNA>
 <xmx:G4hoarYWPFyWQTZ50hnpRR1wxoIRIRW6WFaCu3Nm_xQvtWNQk5OyHekd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 06:44:42 -0400 (EDT)
Date: Tue, 28 Jul 2026 12:44:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <amiIGDgDhnc8ntZ9@krikkit>
References: <ak4i8LmnbeStiufT@krikkit>
 <20260708153126.590075-1-ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260708153126.590075-1-ralf@mandelbit.com>
X-Headers-End: 1wofIo-0001F4-5R
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

2026-07-08, 17:30:49 +0200, Ralf Lici wrote:
> On Wed, 08 Jul 2026 12:14:08 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> > Am I making any sense? (it's quite possible I need another 3 cups of
> > coffee for this type of reasoning :))
> >
> 
> Yes, definitely it makes sense.
> 
> I went through the ovpn_wq producers:
> - ovpn->keepalive_work: disabled from ovpn_net_uninit before peers are
>   freed;
> - peer->keepalive_work: queued by the scanner, it holds a peer reference
>   and can indirectly hit the TCP deferred-delete path through TX
>   failure;
> - peer->tcp.defer_del_work: queued from TCP RX/TX error paths, each
>   successfully queued instance owns a peer reference and peer release
>   drops crypto state before dropping the netdev reference;
> - sock->tcp_tx_work: queued from TCP write_space, socket teardown
>   cancels it;
> - key-slot free work/rcu_work: queued from final key-slot put.
> 
> So after rtnl_link_unregister has returned, I don't see a peer-owned
> producer that can create new key-slot rcu_work without first holding a
> peer reference that would have kept unregister_netdevice waiting. Then

All those objects referencing each other make it really hard to reason
about correctness :/

> flush_workqueue waits for the remaining worker tails that may still be
> executing module text. After that, rcu_barrier forces pending rcu_work
> callbacks to queue their actual work, and destroy_workqueue drains that
> cleanup work before module text goes away.
> 
> So the ordering I'd use with queue_rcu_work is:
> 
>     ovpn_nl_unregister();
>     rtnl_link_unregister(&ovpn_link_ops);
>     flush_workqueue(ovpn_wq);
>     rcu_barrier();
>     destroy_workqueue(ovpn_wq);
> 
> Makes sense?
> 
> Avoiding work on deleted peers is nice cleanup, but I don't think the
> unload safety depends on it because the stronger invariant is that any
> peer-owned work that can queue more work either already owns a peer ref
> or takes one before queueing.
> 
> WDYT?

All this looks correct. Thanks.

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
