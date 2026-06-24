Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50EBCDB47C
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JhA+297JF0OGMiar62LB67nWV6E2XUhUR+FPpUdAqm0=; b=K4BBKIJHbsWKhcgciJIcZRNkfh
	g9FOcgYKbxVBPwoDEyp8T8FtnjKewdA3//3Q3Y83mF5JmYlzc/Ec7OoWzJxfsG5eOvC+Y2PIOrsgY
	0QYZCaUZHjW8tuzkmlBCMyCjAC7Nk74K58PCRoXO9KNZl1jhb2bqzy10Y7Nj+AZmzyiw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcJhz-0003aQ-IE;
	Wed, 24 Jun 2026 09:15:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wcJhw-0003aH-B0
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kJgMHTOIX/mfWCakim6ihpH6eGZPVbrKY8rxEu00KQM=; b=PdNL5X4ukWB4/slpC/xSJVcT6T
 sbY+O/5PtafQB5wDWe8hivsAZz7onWsCeyJznf9cEqqHAgft+oCodPcltopAS4Xm47ai4Z1h5fxVg
 wPphFds2TQ3u6898QoRaxM9sSsRItWpvslSA5bB1SKqjjzr8aHo90cO3ObLC4N2DbBjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kJgMHTOIX/mfWCakim6ihpH6eGZPVbrKY8rxEu00KQM=; b=bijfyBWZLXB+oCXxbmM8ctMXfS
 mptf2j7JMvsYCvrp87f5lWS3hYJYvwX5mg35mAP7h8gfGU56bVDORCL+dXULPjjvtA7XxaXhD3SoU
 MlibL4DGIKqDhKKbq1D0q/CAwH4eEev6DRBRWotvOwqxI11DyJ8u+h8te/6SQcLcg/kw=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcJhs-0002Zx-CE for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 09:15:44 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4glbrJ3FLrz9tcg;
 Wed, 24 Jun 2026 11:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1782292528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJgMHTOIX/mfWCakim6ihpH6eGZPVbrKY8rxEu00KQM=;
 b=NxizPQd858ZJF5BnkfiEQ9SfcjBoKBIkhoT9gIM4ivNMy+l2u8RQqTZQbsXfjoA32Z+rSE
 TUgkz4olg+xbrHNGAzF8HcLD/N/miipTEg5rTJ+EFy2hjtyaI0sQIolvo7AjU8lZsyTXtF
 VtUw3TllV2VL5FJKHvDzu25zpbLZyCwF9aOkN3rbBjXDg/LSq+1wNXFmPO5KNB8bnTac9Z
 2RceByZOP3wyPAnVqynab89/KjJp1iJ/USxLB4qo3w4H4zAzRwssB869u3+ODEEQw6YN6V
 2zJWZbG1gMtYw3IBa2T9oJrHbsHiVtFsE5Or1kIZULB5yVV+arWfEbq6/5M3GA==
Message-ID: <c2f49fc0-ccd1-4dd6-a694-004799f9e62b@unstable.cc>
Date: Wed, 24 Jun 2026 11:15:25 +0200
MIME-Version: 1.0
To: Marco Baffo <marco@mandelbit.com>, openvpn-devel@lists.sourceforge.net
References: <20260610182439.63305-1-marco@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260610182439.63305-1-marco@mandelbit.com>
X-Headers-End: 1wcJhs-0002Zx-CE
Subject: Re: [Openvpn-devel] [PATCH ovpn net v2] ovpn: use monotonic clock
 for peer keepalive timers
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

Hi,

On 10/06/2026 20:24, Marco Baffo wrote:
> Replace ktime_get_real_seconds() with ktime_get_seconds() so that
> peer keepalive timeouts are calculated against a monotonic clock
> instead of wall-clock time.
> 
> Because the driver currently uses CLOCK_REALTIME, an administrative
> settimeofday() or an NTP step adjustment that moves the clock forward
> can cause now to exceed last_recv + timeout instantly. This artificially
> expires healthy peers and, depending on userspace configuration, can
> trigger a premature tunnel restart (--keepalive / --ping-restart) or
> client disconnection (--ping-exit). At the same time a backward step
> can delay the detection of dead peers.
> 
> Switching to ktime_get_seconds() avoid both issues.
> 
> Fixes: 411f445fe91d ("ovpn: implement keepalive mechanism")
> Signed-off-by: Marco Baffo <marco@mandelbit.com>


As discussed offline, we are dropping this patch as we *need* the timer 
to continue also when the host suspends.

Regards,

> ---
> Changes in v2:
> Use ktime_get_seconds() instead of ktime_get_boottime_seconds()
> 
>   drivers/net/ovpn/io.c   | 4 ++--
>   drivers/net/ovpn/peer.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index a6b777a9c2d9..d0b8f7b95995 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -142,7 +142,7 @@ void ovpn_decrypt_post(void *data, int ret)
>   	}
>   
>   	/* keep track of last received authenticated packet for keepalive */
> -	WRITE_ONCE(peer->last_recv, ktime_get_real_seconds());
> +	WRITE_ONCE(peer->last_recv, ktime_get_seconds());
>   
>   	rcu_read_lock();
>   	sock = rcu_dereference(peer->sock);
> @@ -294,7 +294,7 @@ void ovpn_encrypt_post(void *data, int ret)
>   
>   	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
>   	/* keep track of last sent packet for keepalive */
> -	WRITE_ONCE(peer->last_sent, ktime_get_real_seconds());
> +	WRITE_ONCE(peer->last_sent, ktime_get_seconds());
>   	/* skb passed down the stack - don't free it */
>   	skb = NULL;
>   err_unlock:
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index a09d61296425..caee56cd399a 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -44,7 +44,7 @@ static void unlock_ovpn(struct ovpn_priv *ovpn,
>    */
>   void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
>   {
> -	time64_t now = ktime_get_real_seconds();
> +	time64_t now = ktime_get_seconds();
>   
>   	netdev_dbg(peer->ovpn->dev,
>   		   "scheduling keepalive for peer %u: interval=%u timeout=%u\n",
> @@ -1357,7 +1357,7 @@ void ovpn_peer_keepalive_work(struct work_struct *work)
>   {
>   	struct ovpn_priv *ovpn = container_of(work, struct ovpn_priv,
>   					      keepalive_work.work);
> -	time64_t next_run = 0, now = ktime_get_real_seconds();
> +	time64_t next_run = 0, now = ktime_get_seconds();
>   	LLIST_HEAD(release_list);
>   
>   	spin_lock_bh(&ovpn->lock);

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
