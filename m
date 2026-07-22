Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07383C44533
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WGSd9GaicPrnkLFjnnu3r+5GTdvkx1AXJCmzYXvfD+0=; b=Dz1iDpVknV8kBmC9BVi960kwBU
	/5p0vaJEa1+LnXZziPgzUyUEctEke5wmMbBL0Owy9YJu4l8EJOOpACsJqXHYkkrqkRJMBRgokSt2R
	/Y2xL9sjuOMrCe7tIcflm//bvHufEJML1+wPZ9aIEj9BjdR5f13TbXgdP7z88qayO9i8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmSCw-00050h-Ta;
	Wed, 22 Jul 2026 08:21:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wmSCv-00050O-LA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 08:21:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AN3opHY859d/U05gBjCIgjv5xGGwdL+v0TAsh/yYhKk=; b=UdIUZE9gcdLchwFcQrTfHV2ySf
 JJoxcyc+nG3xIx+RAR8wjjG7Z+QvZKYdEcnXnBj7pPGCwEPjFkDHDKHlMijCAJkJaoGyJuvpq4Qrb
 Haba5QlMYyvgjksu2yDJZH57So3zC8wifsM5ypWgyCj4trF2abG1qgBscdWzjvqNTlg0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AN3opHY859d/U05gBjCIgjv5xGGwdL+v0TAsh/yYhKk=; b=UoW9OAFdbwwHPwq3Yif79s2Rhi
 sWqsNJBmz6MEr1LXp75lPB7mJ2q46H2URxkGbsRLsUWyw9W1+Pw9EJWlIGDOeMuQ9rdYf/XzmzZTQ
 ICugPjG5KtsNkZ+7anBpzVTMXkOHXJjg8+z3PDMmcOVL4azzVV4H3VykqkL8hL+nAHJQ=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmSCu-0007wM-EV for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 08:21:38 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h4nJz46s9zKmSq;
 Wed, 22 Jul 2026 10:21:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1784708483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AN3opHY859d/U05gBjCIgjv5xGGwdL+v0TAsh/yYhKk=;
 b=Fy81A29MfkDUjGzsCQMgd/L9YQ7+BMtnPCcUQAwe/UPL21uwmZT2m/QK1GsCZx4gueGN96
 i9yM9VWa4yRDFJUjd/2WQmJXN0Hk6rDWY0+Vb5R8rr0qC0zUK7reaUh9u6iK79t11GbhTw
 BETu3JJL/msnrVPiY3Fs+67T3rLl+PCalnHxxZV2M5SxBq0yd1huJCnVl5ROOsMk+PKt3j
 FoG1Qna4MazKu7/pRkRZ4yQdcBBfQvJlG1pUe8ypfMaLlscMxUBEgx+i2jiZqJHDGCYW1e
 9DxE8HJAGxl/C0a8usXEs/4AVbY5utk3rmiEXG7U2DXoUrHvaCFoJF6/kcOKIA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <e01b799e-0b55-49cb-955c-6e81706db649@unstable.cc>
Date: Wed, 22 Jul 2026 10:21:22 +0200
MIME-Version: 1.0
To: Qingfang Deng <qingfang.deng@linux.dev>,
 openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@openvpn.net>
References: <20260722015638.1295-1-qingfang.deng@linux.dev>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260722015638.1295-1-qingfang.deng@linux.dev>
X-Rspamd-Queue-Id: 4h4nJz46s9zKmSq
X-Headers-End: 1wmSCu-0007wM-EV
Subject: Re: [Openvpn-devel] [PATCH ovpn-net] ovpn: fix incorrect use of
 rcu_access_pointer()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi!

On 22/07/2026 03:56, Qingfang Deng wrote:
> rcu_access_pointer() should only be used to test the value of a pointer,
> not to dereference it. Use rcu_dereference() instead. No extra
> rcu_read_lock() is needed here, as the spin_lock_bh() above marks an RCU
> critical section.
> 
> Fixes: f6226ae7a0cd ("ovpn: introduce the ovpn_socket object")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>   drivers/net/ovpn/peer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index a09d61296425..8de737579112 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -1164,7 +1164,7 @@ static void ovpn_peer_release_p2p(struct ovpn_priv *ovpn, struct sock *sk,
>   	}
>   
>   	if (sk) {
> -		ovpn_sock = rcu_access_pointer(peer->sock);
> +		ovpn_sock = rcu_dereference(peer->sock);

Sashiko says:

Using `rcu_dereference()` instead of `rcu_dereference_bh()` under 
`spin_lock_bh()` triggers a lockdep warning.


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
