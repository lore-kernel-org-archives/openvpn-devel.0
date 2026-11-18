Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9F606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UBF3ThKX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zv2vze2j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QwKuze6S;
	dkim=neutral header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=qOfZxcoI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=WIdHumC64GfI0xitbjsuWXAnKSgi1DuuiGiplUIY0gk=; b=UBF3ThKXpO0g9An0qVscaNElF4
	67penimQmx1XFo/mOjaoBLgY3FFvc9NWK3KVoCd5JJ7gZwpprG4K4PTGQXrTljkKeR+qhlIuhOXCj
	j+hnq0hHyvDyzSq55I/riBdm3pTGSne444K8Jdz8+hAfQNONS17c+TgHWIiVvCh5/DMw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTafY-000000003xz-1GBj;
	Wed, 18 Nov 2026 08:05:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <ralf@mandelbit.com>) id 1xTafV-000000003xr-3pBX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=czAeZHv8fvipyRaLAW2OdmkArTuBOo1OMVSuqVmQ8lI=; b=Zv2vze2jCSo3uxEp3gS4UuieSr
 YK4jSMTq6AxhmdFpLncr+1/bm+6AKDsnNpTkP4GJOoF/Npgji3HRT/XlhMjDRrbHYOVJURVGB980x
 pGfax8IJmXGFrun2oisjS6awY7NL+tcAYnxNJcpulLjRH2CmkizbRJgp2XjaNC+QeDDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=czAeZHv8fvipyRaLAW2OdmkArTuBOo1OMVSuqVmQ8lI=; b=QwKuze6SLn3p1L+Pu0ugwa79ba
 MXur0DZKnSlj/nC22GN0ASC+wwZN08TMDRXXq+EuVkn3ZG5xl7Xn7+rev9QGVb5eXiB3hHgH3z8bz
 IiIKV2R5MaGlTojiGtiptcRsiHzGnj9ZrzbNVq2Rfp74f//TMyPMn2euoQeovPp9hll8=;
Received: from mout-b-202.mailbox.org ([195.10.208.62])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTafT-0000000062i-3om4 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 08:05:25 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jTvKR6czrzKnmd;
 Wed, 18 Nov 2026 09:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1794989116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=czAeZHv8fvipyRaLAW2OdmkArTuBOo1OMVSuqVmQ8lI=;
 b=qOfZxcoIM0VwvSg29iWHzr26J1DdCWxdWqJr0NR1RjWbOVTT/lD0U48hWKN6CUFd02/FPL
 kAWXwgE73VXDXrtSMRTwyU8zE2/iU4lxZGEHIJBezjT/SdQhTnlXqP8XWBSCHvGJ+vhCng
 Cdhq4w/zqYhOFJDdd+wVR3hPmZwKRqmEH+Dh1FhVhoUYgGsZtX1sbmxxQn9EZ6l8FfoYve
 byfxEi5mgoTc8QUipQC5ouqSGzgrb6Pd+Ti3lEslshr2RM+4wDC9oS0MhlVo5xBXRnSoXd
 bPhEl/shoNQFYOqMvvpEuK2yyb3h+qs+MfQxiJF9qJGQcn7R6UI17ck9HEaHZQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: liuchong <979504756@qq.com>
Date: Wed, 18 Nov 2026 09:05:05 +0100
Message-ID: <20261118080506.71177-1-ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <tencent_4CA59D4D873F946422CA8AAEB20AF7C4CF05@qq.com>
References: <tencent_4CA59D4D873F946422CA8AAEB20AF7C4CF05@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jTvKR6czrzKnmd
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTafT-0000000062i-3om4
Subject: Re: [Openvpn-devel] [PATCH] ovpn-dco: hold peer ref in
 ovpn_tcp_read_sock under RCU
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: antonio@openvpn.net, openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Thanks for the patch.

On Wed, 18 Nov 2026 15:00:37 +0800, liuchong via Openvpn-devel <openvpn-devel@lists.sourceforge.net> wrote:
> ovpn_tcp_read_sock() uses sock->peer without taking a reference.
> ovpn_peer_del() can drop the last hash-table reference while the
> TCP data_ready callback is still attached, so peer->refcount may
> already be zero when ovpn_peer_hold() is later called for
> ovpn_recv(). That leads to a WARN_ON and a refcount underflow when
> the async path puts the peer.
>
> Take the peer reference under rcu_read_lock() before leaving the
> RCU critical section, and drop it on all exit paths. If the peer
> is already being destroyed, stop consuming the stream quietly.
>
> Fixes: 209247cf6d47 ("ovpn-dco: implement TCP transport support")
> Signed-off-by: liuchong <979504756@qq.com>

I'm not sure this SoB tag is fully compliant with the Developer
Certificate of Origin. If you can, please use your real name, as the DCO
asks for a known identity.

> ---
>  drivers/net/ovpn-dco/tcp.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ovpn-dco/tcp.c b/drivers/net/ovpn-dco/tcp.c
> index fe095f9..d8f9afd 100644
> --- a/drivers/net/ovpn-dco/tcp.c
> +++ b/drivers/net/ovpn-dco/tcp.c
> @@ -35,15 +35,26 @@ static int ovpn_tcp_read_sock(read_descriptor_t *desc, struct sk_buff *in_skb,
>  
>  	rcu_read_lock();
>  	sock = rcu_dereference_sk_user_data(sk);
> -	rcu_read_unlock();
> -
>  	if (unlikely(!sock || !sock->peer)) {
> +		rcu_read_unlock();
>  		pr_err("ovpn: read_sock triggered for socket with no metadata\n");
>  		desc->error = -EINVAL;
>  		return 0;
>  	}
>  
> +	/* Take a reference while still under RCU: ovpn_peer_del() may drop the
> +	 * last hash-table reference before socket callbacks are restored in
> +	 * ovpn_peer_release(). Without this hold, a concurrent delete leaves
> +	 * peer->refcount at 0 while this callback still runs, causing
> +	 * ovpn_peer_hold() for ovpn_recv() to fail and a later put to underflow.
> +	 */

The new comment is quite long for what it says, and the commit message
already carries the same explanation.
Something like

    /* hold the peer while still under RCU, it may be getting deleted */

would be enough.

Aside from these two minor nits, neither of which needs a respin on its
own account, the code LGTM.

Reviewed-by: Ralf Lici <ralf@mandelbit.com>

Regards,

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
