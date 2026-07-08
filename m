Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D215C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3cJGN7aGz70uQIll9fd67atYfulrJ07HNzlnh3xifvQ=; b=hnb6FwqoVeODvA3U0w8LxH5QFS
	pbTdTaprGDT6wqUwrStLtffLDGLmhIrpU+B0Bjd1f1DtKhtsFk/ctMoQ5KCkF/PCfN9+9M9/gSuUk
	n+wCSuUFcsK93/sr1ehjd9ZiQOh3OMldkyLhOIcJP3l15j0iNBSjbSIf1BjahtPDyDmE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whMH6-00054z-6d;
	Wed, 08 Jul 2026 07:00:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1whMH4-00054r-8i
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 07:00:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=szic1hGilwfTL0+oEzhtpsok/uADdXgrRwAeyHij9Ew=; b=cdknwQpwoeqrSDPFie1njCIaO9
 045pK9RoVg07H++CqTQ82grzxyFMOEDFNth/Rlzx0tR6N9lkcxs/6FVQfS+am/pVuBVtjhY/2oA5D
 OW/pEPQUVgzR8c/4Kz9PD+wC9BGWgU7e29bj8qloP4pSxMm+wRWI3HKRPo45zX4s4X7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=szic1hGilwfTL0+oEzhtpsok/uADdXgrRwAeyHij9Ew=; b=HY6e8/6CADMfE6fSpIBphTQSR8
 dnlBEcwx/DNFXPOz5p7IW9CSKAnjXjTdl9Qo8fzZcihjSWQ9hlD6D2ylSRSNG8MOZvP6TmU0wwvBt
 TveS72je6gKUWMwjDHyvaasxZJZehmTzmZpTbn9l0Wq3TbzUfwiZW0Mho2USG9QwfO+g=;
Received: from mout-b-106.mailbox.org ([195.10.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whMH3-0000oB-1Q for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 07:00:50 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-b-106.mailbox.org (Postfix) with ESMTPS id 4gw8BD13h8zNldr;
 Wed, 08 Jul 2026 09:00:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1783494036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szic1hGilwfTL0+oEzhtpsok/uADdXgrRwAeyHij9Ew=;
 b=D3gz4WoY7ubvomZJNhlLbD7rhcms3hyKAmeL1phzVM9wIBhPZLm9tyf00/zYpVGWEvvx2N
 8ujDIlDAgYPZ9FoXQlFGV7U0Fgz3LsxrTogf2O4k46x9hJsrxOiFW9EMw+2qi7sjuC5IvM
 2gcH6YmH4mb2mw9dGr9n2DFNSB7cC8OL7vVNsoBJsRi7gHG6KfyO+FFj8V37pzi/L7xjFW
 AnSwcNPqbgJPQViw0PyxbQ7KxPBpKZHbcEJQd8D2xlMa2NSMjpmzm03wOQ0QMn8x1fuXiZ
 oCnUJo2Tfw6G6HtSrLt33pvuAoal/uMu8q84TrNmhwpPOft9sA01k43HxSVLkQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Wed,  8 Jul 2026 09:00:21 +0200
Message-ID: <20260708070023.57242-1-ralf@mandelbit.com>
In-Reply-To: <akzdRR4C9dzJ05la@krikkit>
References: <akzdRR4C9dzJ05la@krikkit>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gw8BD13h8zNldr
X-Headers-End: 1whMH3-0000oB-1Q
Subject: Re: [Openvpn-devel] [PATCH ovpn net v5 3/6] ovpn: initialize TCP
 state before registering UAPI
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

On Tue, 07 Jul 2026 13:04:37 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> 2026-07-06, 13:34:01 +0200, Ralf Lici wrote:
> > ovpn_tcp_init initializes the TCP proto and proto_ops templates used
> > when a TCP socket is attached to an ovpn peer but ovpn_init registers
> > the rtnl link ops and generic netlink family before initializing those
> > templates. Once either interface is visible, userspace can create an
>
> If only the rtnl part is registered, we can create a netdevice but not
> attach a socket to it, so the ovpn_tcp_* ops should not be reachable.
>

Right, thanks for catching the imprecise wording. I'll reword the commit
message to make that clear.

> > ovpn device and configure a TCP socket while the TCP templates are still
> > zero-initialized.
> > 
> > Initialize the TCP templates before publishing the rtnl and netlink
> > interfaces, so externally reachable setup paths can only observe
> > initialized TCP state.
> > 
> > Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
> > Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> > ---
> > New patch added in v5.
> > 
> >  drivers/net/ovpn/main.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> > index 9993c1dfe471..c2c3af0c3c55 100644
> > --- a/drivers/net/ovpn/main.c
> > +++ b/drivers/net/ovpn/main.c
> > @@ -233,8 +233,14 @@ static struct rtnl_link_ops ovpn_link_ops = {
> >  
> >  static int __init ovpn_init(void)
> >  {
> > -	int err = rtnl_link_register(&ovpn_link_ops);
> > +	int err;
> >  
> > +	/* initialize the TCP protos before the module is exposed through rtnl
> > +	 * or netlink
> > +	 */
>
> I don't think that comment adds much. The commit message explains why
> this needs to be moved (and why this had to be moved, if someone
> touches this later)
>

Agreed, I'll drop the comment. I added it as a warning for future
changes, but the commit message and history should be enough context.

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
