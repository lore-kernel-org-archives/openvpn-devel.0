Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE1FCD4F49
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kY1wLkZsO5xd6O1/IUSjVFrLGkhr/dNamIzETTUnxvc=; b=Ey+AWsIhnB/7ejKstMaLn+bXfk
	HYkl8SugZkNP4VaEozKObB8qDax1ptAaZo1c4xNAUwwW9x3enPTgBXaA0KXK+p0kpjGRSwCnAfSYi
	fHUFc1Fu0Yh36+3YUqSg6RYYo4y48RqiW9aNQYtpJOllBMfDjCf94ZIIJdwl/cdr5+3c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOyWg-0001bm-DF;
	Mon, 18 May 2026 14:00:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wOyWe-0001a0-9g
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 14:00:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c41XMs5HunBeur8Py8zMcMGBtIIqn+/ztUObVGNqii8=; b=OunGUKWUJe51xDmDXnNL7KpnL/
 lXoxnh36cVVf1Bb5nZr0GwdJg5sUmhSJhC+REN1Pn1jA4wMJ0QGMFuAburJootIUC76U30jZ6ylzp
 BzEvbEEyIE25h7nxxucexolzDxkXESTalWhydUqSFVC2/FWixcHesYR2BVGZwzSit7OE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c41XMs5HunBeur8Py8zMcMGBtIIqn+/ztUObVGNqii8=; b=V1W9IxOP6EZSGSvKuVl34GZ+Jg
 0GWXzbK0zwEosh15u+hEHd1feVIb3WTnyhxH7EeKLh64OgWfvssNKDz5BW5vxruV0sCzTwX0HxQ6N
 lohe7MSgDrqCjHML3ziglRrQAMy6Bch6oSF0Rfij2IZOpfz5MfI9X3/YOAcel1G45N68=;
Received: from mout-b-210.mailbox.org ([195.10.208.40])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOyWL-000253-BJ for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 14:00:40 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4gJzw84zxnzDx09;
 Mon, 18 May 2026 16:00:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1779112824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c41XMs5HunBeur8Py8zMcMGBtIIqn+/ztUObVGNqii8=;
 b=1J7kPaGL4Ryc7Yw2XQhoShmRQQThFlZGp7EmEkkk75frSzGwEjcuV7KGs9/iJ2JfjTkEtr
 w2sdWutlmKR/Jg88kTsH9WCf8KI1tb7StsMVd6bwJcK7lGsu+0CYX24SZHmOXNZeIVp/Ar
 DXVqFs8UuQy19IOTpLGbwYQUjhiM0SEiZpqPCsIoelGGZ2aZr4n7SPSalbch0okrCCK2j6
 xOjqf5cF6ls0GkX9KLx9vhcGR9dISJDKA8iw3hSzrj6eHR5nVMAV7O4AuZXkXG/EfWVPQD
 wPFLmft5VPI5+U9GaU5kq2j1uXGg5/Ysw0OxI3ZbFeT+QLnFVIZz9tpEGXKU+Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Antonio Quartulli <a@unstable.cc>
Date: Mon, 18 May 2026 16:00:06 +0200
Message-ID: <20260518140007.438307-1-ralf@mandelbit.com>
In-Reply-To: <20260512144358.419599-5-a@unstable.cc>
References: <20260512144358.419599-5-a@unstable.cc>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gJzw84zxnzDx09
X-Headers-End: 1wOyWL-000253-BJ
Subject: Re: [Openvpn-devel] [PATCH ovpn net-next 5/5] ovpn: add per-peer
 NAPI for RX decap and reinject
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

On Tue, 12 May 2026 16:43:58 +0200, Antonio Quartulli <a@unstable.cc> wrote:
> From: Ralf Lici <ralf@mandelbit.com>
>
> Currently ovpn processes received packets in the same softirq context
> that delivers the skb. If the packet is valid and decapsulated, it is
> reinjected via a single per-interface gro_cells instance.
>
> To improve parallelism and scaling, add a per-peer NAPI and skb queue
> for reception and reinjection. On receive, the skb is enqueued to the
> peer's queue and the peer NAPI is scheduled. The poll function drains
> the queue, processes the packet, and reinjects the decapsulated skb into
> the stack through that peer NAPI.
>
> This is the first patch introducing a more elaborated packet processing
> pipeline aimed at improving parallelism and scalability.
[...]

Hi,

we decided to drop this patch from the next respin.

We are working on a broader datapath rework that will cover this
optimization more cleanly, so we'll revisit the NAPI part separately
once that work is ready.

Thanks,
-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
