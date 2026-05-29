Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC492CD6E4A
	for <openvpn-devel@archiver.kernel.org>; Fri, 29 May 2026 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5/MZCSCTwhp2aKV7SZZYmDOkN9hmsy1kUgTgYGe5zg=; b=W6q5swY1j74I1lLruw8RjbL7Mq
	s8q4CSNQ7g1MfVUK4pSalcAEomlvEXTW7xkJQ0OOS8Zrjjmyw66gAJrgX6u14D+7dCk2utO6vF6TH
	neSGauOOZFGY6MdVpzi9eCDpWdWTnMeMJsrwcPyWIrGd+a2l3xMfosv9kSceUOaDwt9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSwVC-0000Gw-7s;
	Fri, 29 May 2026 12:39:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wSwUh-0000GQ-4A
 for openvpn-devel@lists.sourceforge.net;
 Fri, 29 May 2026 12:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y0fQN6emifLiDn3VuPGDH79AHVZdZjJlw6VN7JebvYI=; b=OvOypBGfWGVFwu3uCj/yYVyERq
 EOrvbaWB5OxetGlUbUpGeQfHwEldHlbxaEDy1sJMGZun6qJo/LXiL/nc32RraZDOnwQTkLXWydiCc
 6In6omWRIeKpZU4tB7yMDCIR6sBqIxITw9KZ9KjewwroNkR8Ry5nYHTpq06gnIslax2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y0fQN6emifLiDn3VuPGDH79AHVZdZjJlw6VN7JebvYI=; b=c3RQY0t1rMnhrIaRgnluk8KTZW
 IMUDHhRs0HN5QbdsOZpQAa4ecG3sWYhvPLvV9F2IoRueWwd/28fQfBtbWi1yJOq/ZwCmGckZJ9S3K
 Xqzmuv6YkzXidW0QIMfYjm6+/ZRD81egrnYt5DfZt0Vh1KTgqoAeFW9V5GOYr3eEomK0=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSwUc-00058Q-Fq for openvpn-devel@lists.sourceforge.net;
 Fri, 29 May 2026 12:39:16 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gRjb93S1Cz9v87;
 Fri, 29 May 2026 14:39:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780058341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0fQN6emifLiDn3VuPGDH79AHVZdZjJlw6VN7JebvYI=;
 b=0A3p063dQabQlq73iHTxepbCVgxnaBy0rvJjvewtEz+/kpJX+U2739kXpyo6f8iH/Vm93m
 8t5TWVOVifeZmZOjMqBppayJg0T0OfQZnh1Y23Tk8n3CkSVGDUXgTXdAeteh8Vv77DpjDZ
 6GxeFQ0MNw0x+Ynnrgo2tRAyhQxJMTURAfzMUZJP3v28ha6QPa6YsokKG+V0/OL4sm/Bpp
 SKD50g6+4VN4gWYejboUYW+0tk/dxHums60APH5gkO1BRuVET0Pc1T68on9hFn9D3Kfoov
 ducixRTZAm4jGyX234W95weMI2jeOKpDEU+asdaFq7gzApftKveU0pSo7zbM0Q==
Message-ID: <b7ec7ba2-0a9a-4f52-8fff-0ae2b44d4884@unstable.cc>
Date: Fri, 29 May 2026 14:38:59 +0200
MIME-Version: 1.0
To: openvpn-devel@lists.sourceforge.net
References: <20260526231850.2511369-1-a@unstable.cc>
 <20260526231850.2511369-3-a@unstable.cc>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260526231850.2511369-3-a@unstable.cc>
X-Headers-End: 1wSwUc-00058Q-Fq
Subject: Re: [Openvpn-devel] [PATCH ovpn net 3/9] ovpn: fix data race
 reading cached local endpoint on TX path
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On 27/05/2026 01:18, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@openvpn.net>
> 
> The cached local source address bind->local is updated in place on a
> live, RCU-published ovpn_bind while holding peer->lock: the UDP output
> error paths reset it (ovpn_udp4_output()/ovpn_udp6_output()) and the RX
> float path learns it (ovpn_peer_endpoints_update()). The UDP TX fast
> path and the netlink dump, however, read bind->local holding only
> rcu_read_lock(), never peer->lock.
> 
> For bind->local.ipv6 this is a torn read: struct in6_addr is 128 bit and
> is copied as multiple words, so a concurrent in-place update can make a
> reader observe a mix of the old and new address. The mangled source
> address then feeds ip6_dst_lookup_flow() and udp_tunnel6_xmit_skb(). For
> bind->local.ipv4 (a single aligned word) it is a data race without
> tearing.
> 
> A spinlock on the per-packet TX path is not acceptable, and
> READ_ONCE()/WRITE_ONCE() cannot atomically access the 128-bit IPv6
> address (the >8-byte access is rejected at build time and per-word
> accesses still can't yield a consistent snapshot).
> 
> Serialize the IPv6 field with a per-peer seqcount_spinlock_t tied to the
> existing peer->lock: the in-place writers (already under peer->lock) bump
> it, and readers take a lock-free read_seqcount_begin()/retry() snapshot
> via the new ovpn_peer_local_ipv6() helper. The single-word IPv4 field is
> handled with plain READ_ONCE()/WRITE_ONCE(). bind->remote is untouched:
> it is immutable for a given bind object (only swapped via whole-bind RCU
> replacement), so reading it locklessly remains safe.
> 
> Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Using seqcount_spinlock may be a bit overkill and complicated.

Ralf is attempting a fix by turning the ovpn_bind object to an RCU 
protected pointer.

This way any modification will be made by creating a new bind object and 
purging the old one, rather than modifying the current one.

We'll see how large the patch happens to be and possibly replace this one.

Regards,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
