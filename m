Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CADCD8C92
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zpX9EwO08ADwzY3PiOKENEpNRwVTVPw3gKARHPaJtF8=; b=i0X+dhESkbH1enXn1Cjx44h8Bq
	LK6tgfbx9Fb+BwM6mIKUgXChqGu8tzstWz7rnEXAAWV2slEuu9MBNlzrVtVr/daeTKTLm0NpD+Ig3
	Iq5TcfhfPKP0DGckQ45nLLG0Xjtwa8QtGMlLRsC7PU+tLCtKu11ppJ+knlpXWe/5tUVc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWa9D-0001KA-3c;
	Mon, 08 Jun 2026 13:36:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wWa9B-0001K2-W5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GEs9yKEbL+mkeBII9lkIa6at4I9lpBRwNxlPNiHverw=; b=Fgc5f0+YcptOxsVZsB6POBuLCA
 mJ58qRXeIoFVtTSHAWYaHRZ2uf9WxQBpOkCTDnFxXsbjnyLnLQU46kmagkT9cXASmx3AvVEOY9Z3q
 Dw/ceEG6RM1s0UHXbh4Vndp7tkUfpT3hAy2PWiKDg8elYNe5rAAITEsPAGsE0QXTZw+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GEs9yKEbL+mkeBII9lkIa6at4I9lpBRwNxlPNiHverw=; b=ZqIJkgfahCpH9cCa25KKzKCYfl
 cDFxmbwqAYTBP8HY8lkbvNLBl6AdIqqWcxqMTasi5AwTMAWxd/wCJaWnZpdAgesC5yE4++Fllt9/Q
 kSgdevdKBdMQvgB7Rmzp8EcReluVcW9u2gl7CziGZZNAuVrRSHNirCMhJkIF8cWnih2w=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWa9A-0005X2-H1 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 13:36:10 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gYtND2FQjz9vH2;
 Mon,  8 Jun 2026 15:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1780925756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEs9yKEbL+mkeBII9lkIa6at4I9lpBRwNxlPNiHverw=;
 b=ib3JWVMufqTuaKQCdOzKXkyXmgTJhxhPFRQ7b3RZ61/2xsRkmslH7Wdpx3R1JkOkAuQ/dS
 cAntuP2d6lEeYtXsvv90fJlX5bqFIOrqksEdDRIiDFK/DuGDTRk1Vdm9XRpKYLD8ZjylyT
 HZAkx3wqXDmYdj6PDJPg4cujDZxGP32OBOZ2C75WtjRzjyHsN+g4by6skN90jgBE9XNToK
 BAfhWW4ODHwLmxEVdEcqVXGCK3nkd69gYpuOnvGv1OmfmVHXgL7BcncdlTQc+8mPsjCaLx
 RSKpOUJ/xZv5ptbStWg590SzM8Inv+mSwFMKEv+39tprVHf1LxjLhnVbVN+eVw==
Message-ID: <ed70297b-6844-4068-9523-d6fd7f77e0fa@unstable.cc>
Date: Mon, 8 Jun 2026 15:35:55 +0200
MIME-Version: 1.0
To: Marco Baffo <marco@mandelbit.com>, openvpn-devel@lists.sourceforge.net
References: <20260527113954.3592539-1-marco@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260527113954.3592539-1-marco@mandelbit.com>
X-Headers-End: 1wWa9A-0005X2-H1
Subject: Re: [Openvpn-devel] [RFC ovpn net] ovpn: fix use after free in
 unlock_ovpn()
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

Hi Marco,

On 27/05/2026 13:39, Marco Baffo wrote:
> unlock_ovpn() iterates over the release_list using llist_for_each_entry()
> and drops the peer reference inside the loop body via ovpn_peer_put().
> 
> If this drops the last reference, the peer is eventually freed. However,
> llist_for_each_entry() reads peer->release_entry.next in the loop advance
> expression, which runs after the body. By that time the peer may have
> already been freed, resulting in a use after free when advancing to the
> next list entry.
> 
> Fix this by using llist_for_each_entry_safe(), which caches the next
> pointer before executing the loop body.
> 
> Signed-off-by: Marco Baffo <marco@mandelbit.com>

Nice fix. Please send this as PATCH as well.

Regards,

> ---
>   drivers/net/ovpn/peer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index c02dfab51a6e..ff7c6ce9fcad 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -26,11 +26,11 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
>   			 struct llist_head *release_list)
>   	__releases(&ovpn->lock)
>   {
> -	struct ovpn_peer *peer;
> +	struct ovpn_peer *peer, *next;
>   
>   	spin_unlock_bh(&ovpn->lock);
>   
> -	llist_for_each_entry(peer, release_list->first, release_entry) {
> +	llist_for_each_entry_safe(peer, next, release_list->first, release_entry) {
>   		ovpn_socket_release(peer);
>   		ovpn_peer_put(peer);
>   	}

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
