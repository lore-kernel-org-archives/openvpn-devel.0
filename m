Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9331CD4F54
	for <openvpn-devel@archiver.kernel.org>; Thu, 28 May 2026 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mli7ysmyI2OfAU9pvqqjANu4pO7TzKCydIzYBkkmtY0=; b=b80gSv+4kma0DiVNuhkG3Y/cKL
	fdt4X1BwXmVwoHpxv5LJs8C1XGEuDq94njRyaTZmnGHXSs8higvQS8KYBu+zdumNcXGUCRksI6fJ7
	9DbOHcdGWDDyq8H2198/8xkBcrnGwyuDjahsTx++SIYe9ZlSfxg1UdjS3meS7F8LWE9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSfnw-0006x9-Pi;
	Thu, 28 May 2026 18:50:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wSfnu-0006wz-Lo
 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 18:50:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DOOxEZ1SBaqmMtL6KJZIbaKJqB6H1Q/oynk5CXCATEw=; b=hKUN23YR/VwWNzLfllQVyeIKcP
 1x1UutWYjcg2f4mNJPRJ44uB2tjwLqOuEsbvjvCYfmm94n32AwUvXHSR59OZH5CBw+Ad8MXKD1hIO
 3JJIXi7OnOdEsfNYM7RKpdtKAlKVuo0ClUQCZTTmdTXgKitVwJguUGpU0xiocpLGBn7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DOOxEZ1SBaqmMtL6KJZIbaKJqB6H1Q/oynk5CXCATEw=; b=YaRNcb+hHNkLuJIcdtSsAQKEuU
 +YoASyz44cIC6XGGu/bhWp3s03naNKcK9w6CYQOOXmJr5vs+B0u2hiaKhmphWKk9tjwnKyBEyYk0z
 VPZ9FUQw+wwF0smZVUzzOyVdh/sIzgIoYw2Dmfw5M98TZ9PwmHB0TCzX8rkoKqp4Q3iU=;
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSfnq-0005cX-IM for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 18:50:01 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id E415F7A00E7;
 Thu, 28 May 2026 14:24:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 28 May 2026 14:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1779992680; x=
 1780079080; bh=DOOxEZ1SBaqmMtL6KJZIbaKJqB6H1Q/oynk5CXCATEw=; b=M
 MRAPaQCCZS2x8v4kXugfDcx8t1zFgFfJ6g8o5dW0nTAfTaFWhFaltcHK8o7ET8ib
 w+HfKBkkDPTeQzehpLkBzNTadQ6/Tsi4jqPvudvjXngut4mc9Qxnd/qqSiMCtALS
 tKBcSQNO8P2KeawfMY8jYIRSeXgJfJFQaV3VvmGfR0gIOP/BfOJea1xk5a/C69iK
 GDQYoyWnSnh0g39V3mPNOuCoB4MRJd4+fwy+XR63jlOfn7B+8bxO69KJPp7CK+eB
 5m8/oPN0khu/n0jIGVOlqgdmb3Qyj/Rke1Y8ydX8cfiB5Y0MXv7mGI0p6ysf4W1q
 A3b1iRpBzQ/aQiYPy8Ccw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1779992680; x=1780079080; bh=DOOxEZ1SBaqmMtL6KJZIbaKJqB6H1Q/oynk
 5CXCATEw=; b=LmdCUGOabTJ+6VT3k4eXKBgMLQDiqKsuqxDdkFnB9dwZo/En1rC
 q9nWonajdHnJGJQ5i2jTctMyQvdgMRMFAhByOcs3K7pqgxJykTUbALOxhY/+qP52
 6ibgaeoh5sIg7JkHQAjCE92wdHBJJCqGneMxjC2m/DkYWonMYzzK4sDsiaRSTqFc
 Y3MGXkbv/S1KWUV01n3RvVvJauoXYl4oa8TecXrbIvWs7H3CW+rRCm6kkfaFTfpH
 aMH+AbHCklGvzRWaTHEkLoc8Q6J/zXF/wPe0E8x+RL377v9yRe7nipk/w3Ua5y6J
 hKk2gDNkxIn6tbmbW/xxwtIy48RZSFfnPaQ==
X-ME-Sender: <xms:aIgYaoGWC2IrwzrOHr_QlgSgzSYQ5ZRl1-30ql7p4e9ayVRofgDc8w>
 <xme:aIgYaozy5HZ6_JnkE9sYYNRzYTMJHRJ9M5k7DF5D7KCsIRJRIXc2NL6t4WuEOcsjG
 VfehgP0IdwsA-9WSn8xvkOBVctt0Svh6cAzlmucUEbieeSYW8cWEno>
X-ME-Received: <xmr:aIgYavgV84Y3CAdjg4pbg1EfR1ts6JRz38MPucV7omN3atlIdI40QIESCppix9hXpVESdCKkbAXiq6ke11afN6s>
X-ME-Proxy-Cause: dmFkZTFPsS8Qe9KOGUQfS1JXEx0dR1Qk/cCOHFXntoKfR9xdfp58E1hY/6/f++gybiLetf
 Di6g+2kok45uGrveHMicVmezAHZEO8WmV5Rz+xCFuU+yfjU0rBp1iJ4lhhmWyCY5q5gE4u
 vz4TT7Au4X/I2IVsmHD6gkpfpDsuQ/XmD3kPHMIDMhZGPWWEmnZYavMiE6lRGeih4Xz3M5
 Ic7Jglfl4CizSib7/S4Cj41mJvwCtsjpC+nXQqDj540mSTWC8HvANC5amvpE5/6VYgP5Xd
 oHqYwDBSU5X+/R7lkDXhduDbqvWVQtmAurvc9n3E7mF6TbTxSwSSgx3Lk66KSAbGVAxkla
 QWwZ+EX8RUrNkO8cZJKHhg5B8qlyyCc/2ErBorb7NVzQAyMxLQYG32puVimRC36i62uFwu
 qk/ljGtaMtivX0n35AHsWwM77WR/gFWtyuKWOQzHpfRxkG9teB56rc2iy5LtAqpsuRi08t
 rWS2F/mKM4VeeqLGS2/7AcjOOGsAxNxoDxtPSaWMG/4AY1CiOj9uLj+ijlLQefhDFfIc8P
 Ses9u/toGRh7kARvuSaedrD/zvsA0dhdxogXf1REmfU1kDAYGFJtQbqTIP+oCV+WMDCr8E
 1aKUBZQQrsi1cd3nSQ1/t0G6ZOES6u4LWxyy9wDUCKF/1b57OMkgjj7ZflLA
X-ME-Proxy: <xmx:aIgYajyupxS39Lst2jnPvy3AzfJhGBW2uxMWMEMtaOwHHHq_ojjoeQ>
 <xmx:aIgYaiKToIN4PAfJCb18lKD-M3GULI-nINHWmiYtaLN-HX2b2Swkng>
 <xmx:aIgYaqSyeHntusE6GkrmnIHtkquHoW-aM_blLz-wocaZtI--EmkMnQ>
 <xmx:aIgYaqpx5n0DjbUg9Nri1XcKxvGe7d6OaeXF-rtD3IyE_UrntWAiqQ>
 <xmx:aIgYamRizwbK2e-dev0zgjtXrmzITS_nPlknm6ZsG3h1XhYgu0khrr1t>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 14:24:39 -0400 (EDT)
Date: Thu, 28 May 2026 20:24:37 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <a@unstable.cc>
Message-ID: <ahiIZX6iG6HjnsiS@krikkit>
References: <20260526231850.2511369-1-a@unstable.cc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526231850.2511369-1-a@unstable.cc>
X-Headers-End: 1wSfnq-0005cX-IM
Subject: Re: [Openvpn-devel] [PATCH ovpn net 1/9] ovpn: skip rehash for
 peers already removed from by_id
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

2026-05-27, 01:18:42 +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@openvpn.net>
> 
> ovpn_nl_peer_set_doit() resolves the target peer via
> ovpn_peer_get_by_id() before taking ovpn->lock. In the window between
> the lookup (which only takes a refcount) and the subsequent
> spin_lock_bh(&ovpn->lock), a concurrent OVPN_CMD_PEER_DEL, keepalive
> expiry, or socket teardown can take ovpn->lock first, run
> ovpn_peer_remove() to unhash the peer from all four tables (by_id,
> by_vpn_addr4/6, by_transp_addr) and release the lock. set_doit then
> acquires ovpn->lock and calls ovpn_peer_hash_vpn_ip(), which
> re-inserts the now-removed peer back into the rehashing tables.
> 
> The same race affects the float path: ovpn_peer_endpoints_update()
> holds only a refcount and acquires ovpn->lock very late (after async
> AEAD decrypt and a netlink notification), then rehashes the peer
> in the by_transp_addr table.
> 
> The resurrected peer becomes reachable again from the RX lookup
> (ovpn_peer_get_by_transp_addr) and the TX VPN-IP lookup, even though
> userspace believes it is gone. Once the data-path refcount drops the
> peer is freed via call_rcu while the hash entries embedded in it
> remain linked, opening a UAF window.
> 
> Bail out of the rehash when hash_entry_id is unhashed, mirroring
> the sentinel already used by ovpn_peer_remove() to detect the
> already-removed state. The check is safe under ovpn->lock, which
> serializes every mutation of hash_entry_id, and is a no-op for the
> add path because ovpn_peer_add_mp() inserts hash_entry_id before
> calling ovpn_peer_hash_vpn_ip().
> 
> Fixes: 1d36a36f6d53 ("ovpn: implement peer add/get/dump/delete via netlink")
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>  drivers/net/ovpn/peer.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

This looks correct to me, just one small thing:

> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index a09d61296425..a472ffe3016b 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -307,6 +307,16 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
>  			return;
>  		}
>  
> +		/* peer may have been concurrently removed between the caller's
> +		 * initial lookup and our acquisition of ovpn->lock; skip the
> +		 * rehash so we don't re-insert a removed peer
> +		 */
> +		if (unlikely(hlist_unhashed(&peer->hash_entry_id))) {
> +			spin_unlock_bh(&peer->lock);
> +			spin_unlock_bh(&peer->ovpn->lock);
> +			return;
> +		}

I'd add an "unlock2" label (or "unlock_both") to unlock both (maybe
just after the "hlist_nulls_add_head_rcu", before the existing
unlock). The unlock/return is a bit verbose and we have it 3 times
after this patch.

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
