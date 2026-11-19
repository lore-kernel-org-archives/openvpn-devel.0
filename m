Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B075B606A325
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N0vvwn4E;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IBJq9MRC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LTJLCoqC;
	dkim=neutral header.d=unstable.cc header.i=@unstable.cc header.a=rsa-sha256 header.s=MBO0001 header.b=Uflk5hLa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ZF9D4a6iZROW019Lg2wY2pji6WQvJjaFR/S9xsmdZHs=; b=N0vvwn4EsxPHdD1Is3RPEWBvc/
	ypS8cs4YUyo4P9jFfuKBAkA4SckNrq827AIdLA3Op9VWCMfKjEJKmUVLtf52wt7U6e33wWt6CmJxS
	TflrRBI1l7A0ivS5pxEieNM0XzteVj6c20sAppdMDy3MJo1S30Ns/y2kRLEqmOexBkcY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzZ5-000000008UX-1lvN;
	Thu, 19 Nov 2026 10:40:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <a@unstable.cc>) id 1xTzYm-000000008UD-40oL
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Msy03PbKPdfocOn33kNko17UV1vs+sZQdvXBLMTw1xo=; b=IBJq9MRCpuLHJotdgrjHC+164/
 qBWuG8FxUA/8yHVBXUtFRwNJFtguol/j2oMAwauL+NL/br1HQmzTkWU0UYLnHoigmEaXkwYwc7PU1
 erugceSyCKbAyGnzEZ2xkpCnTWcuMYZdyd8pd50tPDWfNxtPEcqeMPx15ir1VU65sroc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Msy03PbKPdfocOn33kNko17UV1vs+sZQdvXBLMTw1xo=; b=LTJLCoqCy+3OV38fHpCqZdp6lD
 emw/taCzRAfANPvFMKMJ3euR258P5rqMMNj9n/VvXfvpGWJRDHhiQziEcNXqVqmCtx/+P5tsUcdJQ
 pOrFbgnCjCbV+8FcFs9kcG+dj0vaPkj0gHt7HGeVQQav32aDAReaAHM72g7vGijeL/Uk=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTzYh-000000005tF-3bLb for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:40:05 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jVZjR6z6Yz8vcZ;
 Thu, 19 Nov 2026 11:39:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1795084795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Msy03PbKPdfocOn33kNko17UV1vs+sZQdvXBLMTw1xo=;
 b=Uflk5hLaRZ2jLuGcpI/gQvxRLI/61aSJbcUrlVdLNq28iFnxT5CjrlS/OGOhdWBaN0RfhP
 QHecHE/DsPmygrnQIpcDQ744IGbT7BA2rIu2hyaI6UR4gzLHn82tna+fJtY+iT/imjp9qu
 +vcgMz3mJRMmAzkc+A6m7hlOfeTFKzOfiJtwpKZb3e/TZ/erVm7eXeOdHyk2WHwzW/meOV
 1BSspm5kclVp4Uxe/HzEYBxjHapWAoANV485RIh2wNObMoXgJ41QTfIMcUxhc4LXhEzkmc
 4cDC5JGHl95e6fXMZSyWr56oLpj/Y2VQYsMIxwtgX8kT/lPM4MpvDOGvf08iDg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <8d8fdff4-0d8f-44e3-89d9-0af5782f95f9@unstable.cc>
Date: Thu, 19 Nov 2026 11:39:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Liu Chong <979504756@qq.com>
References: <tencent_DB0ADABF741A42D32620ADE82AF77005FC09@qq.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <tencent_DB0ADABF741A42D32620ADE82AF77005FC09@qq.com>
X-Rspamd-Queue-Id: 4jVZjR6z6Yz8vcZ
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTzYh-000000005tF-3bLb
Subject: Re: [Openvpn-devel] [PATCH] ovpn-dco: fix IPv6 VPN address
 comparison in peer lookup
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Liu,

thanks for your patches.

Out of curiosity, why are you still on ovpn-dco-v2 and haven't 
transitioned to the new ovpn kernel module yet?

Best,

On 19/11/2026 05:40, Liu Chong via Openvpn-devel wrote:
> In ovpn_peer_lookup_vpn_addr6() the word-by-word comparison uses
> 'continue' on mismatch, but it only skips to the next word of the
> inner loop, not to the next peer. The comparison therefore has no
> effect and the first holdable peer in the bucket is returned even
> if its IPv6 address does not match.
> 
> In multi-peer mode a packet can be sent to the wrong peer whenever
> two IPv6 peers share a hash bucket (with a single peer per bucket
> the bug is masked).
> 
> Replace the broken loop with ipv6_addr_equal(), like in the IPv4
> lookup path.
> 
> Fixes: 94581f0cb760 ("ovpn-dco: restructure code to allow supporting multiple link to peers")
> Signed-off-by: Liu Chong <979504756@qq.com>
> ---
>   drivers/net/ovpn-dco/peer.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ovpn-dco/peer.c b/drivers/net/ovpn-dco/peer.c
> index cecbbb4..aee9f11 100644
> --- a/drivers/net/ovpn-dco/peer.c
> +++ b/drivers/net/ovpn-dco/peer.c
> @@ -355,14 +355,11 @@ static struct ovpn_peer *ovpn_peer_lookup_vpn_addr4(struct hlist_head *head, __b
>   static struct ovpn_peer *ovpn_peer_lookup_vpn_addr6(struct hlist_head *head, struct in6_addr *addr)
>   {
>   	struct ovpn_peer *tmp, *peer = NULL;
> -	int i;
>   
>   	rcu_read_lock();
>   	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr6) {
> -		for (i = 0; i < 4; i++) {
> -			if (addr->s6_addr32[i] != tmp->vpn_addrs.ipv6.s6_addr32[i])
> -				continue;
> -		}
> +		if (!ipv6_addr_equal(addr, &tmp->vpn_addrs.ipv6))
> +			continue;
>   
>   		if (!ovpn_peer_hold(tmp))
>   			continue;

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
