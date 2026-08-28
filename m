Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3479C61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mtLGzCJvGqthvASNVuiM58nUGDP6x4Oqr3FQMOlxXkg=; b=ZBvGwnAIl6daQFr0aKvI5mCLSP
	EgE9tvWuQRgrY3QnzxBI+lJnEBuDrkwTNCQW6+HKEnlIlElT/5rUdGiJjUjcNRd+UEk4DiPBKXTIW
	Az/75oVENeXSVGK8tVMrAgTTBEFGqco6DK4U6rrB0eLbprTmC7HA4ZaNt4YswvfSv8jE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzxyu-0004EB-4H;
	Fri, 28 Aug 2026 14:55:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wzxys-0004E3-Vt
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D9xP+W3+Q55XjtgNaW6L3RB4g2wherle9rPO4+HpYos=; b=Vf8CKfUPrZErBicRNOM3OVSFEP
 C85TQIxwfbSvwSKInd3gJ4edbEj1y6uriNZFgI3gWWQjTWnGIHZfTTuBeJ3xumMjh7/rP665yvP+x
 IxEHYNuyshuHtZh+wiDgoL/E7mSYcrkn59pFKnmRxciHJWJhtStJwhUXap8fAlbnBwcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D9xP+W3+Q55XjtgNaW6L3RB4g2wherle9rPO4+HpYos=; b=TCGOgKZL6YQQTPvFc3eiItgb3o
 +Y6+YrMXLk7pLj56lyciakN9P9ttU8ZJfrP2eCIY7/Y0Vmse+drmUO4Jkn9N+jKVHcLcBNR49v1pq
 37jjKZ8E4kIemaW+MIKZ70eSpRnwp+bHGldn+mfDrc/2uggoV2l3/XuSnOzBeTH3MQyM=;
Received: from mout-b-110.mailbox.org ([195.10.208.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzxys-0008Az-WE for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 14:54:59 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4hWhHv6MC8zNl9x;
 Fri, 28 Aug 2026 16:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1787928891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9xP+W3+Q55XjtgNaW6L3RB4g2wherle9rPO4+HpYos=;
 b=bIwc+sWPjde9foaCibA+dYLmYpWJ3j5Yqob/JG1QfshI8j4ARI4yXK7PY99vAnba5c/rBO
 3b7jcLcfy6nnvYCX68loX/Xf9uMn8eO5xzF+QpbeKtj6SDE5IwgEWNse3ZNa/PC1+/lALq
 kdA0y6LvHkwxWrZqn8QcisLxwgJ1WtdaxQNiKonvxk/F8DLYRRO9fcULVLNUShBIOKByTz
 5FVLjUwF2Dm+1bIG5mIbViNdUyRD8VQFBF1JLStFDbDboenQGhB4wJxjCMx6tU0lbSD4Uy
 cVlROPyEhlxmZI6RUNNzC7QbaQdoJNvU9mIg0ZPrjHyvEFEnWt6d9zpUg5xGcw==
From: Ralf Lici <ralf@mandelbit.com>
To: Ralf Lici <ralf@mandelbit.com>
Date: Fri, 28 Aug 2026 16:54:41 +0200
Message-ID: <20260828145442.791181-1-ralf@mandelbit.com>
In-Reply-To: <20260814082530.190853-1-ralf@mandelbit.com>
References: <20260814082530.190853-1-ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wzxys-0008Az-WE
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2 4/5] ovpn: avoid in-place
 updates of peer bind local address
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
Cc: openvpn-devel@lists.sourceforge.net, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On Fri, 14 Aug 2026 10:25:29 +0200, Ralf Lici <ralf@mandelbit.com> wrote:
> On Thu, 13 Aug 2026 18:55:33 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> > [...]
> > > @@ -267,26 +263,40 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
> > >  					    netdev_name(peer->ovpn->dev),
> > >  					    peer->id, &bind->local.ipv6,
> > >  					    &ipv6_hdr(skb)->daddr);
> > > -			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
> > > -			reset_cache = true;
> > > +			local_ip = &ipv6_hdr(skb)->daddr;
> > >  		}
> > >  		break;
> > >  	default:
> > >  		goto unlock;
> > >  	}
> > >  
> > > -	if (unlikely(reset_cache))
> > > -		dst_cache_reset(&peer->dst_cache);
> > > -
> > > -	/* if the peer did not float, we can bail out now */
> > > -	if (likely(!salen))
> > > +	/* if there was no float and the local address is unchanged, bail out */
> > > +	if (likely(!salen && !local_ip))
> > >  		goto unlock;
> >
> > nit: !salen is redundant? local_ip is also set in the float case.
> >
>
> Good catch.
>

Small correction to my previous reply: !salen was not actually
redundant. It implicitly distinguished a remote endpoint float from a
local endpoint update, so only float reached notification and
transport-address rehashing. Since that was unclear, v3 replaces it with
an explicit "floated" boolean.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
