Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2681CCD6E4A
	for <openvpn-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fC+KQQAcuUGMjLkkDnnNs3enihVuy2VMpKOGNxN854g=; b=XWOXxMPAemPIPExOQojyWcNdq5
	Y5PXbLNayK31rcCKLHF9kpANbPJBxGTfSO6XHnm76j6iVIMl+RrVeidu6SkmeA+nA6EhVA39z4qsi
	LyFd6Olorj86J0zPvGQqQnxRICV5JYrx/WXxridYN4bZ+AqFrO+yJynHk2C53nGNLW2k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wV9aF-0000tB-CQ;
	Thu, 04 Jun 2026 15:02:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ralf@mandelbit.com>) id 1wV9aD-0000t4-GW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 04 Jun 2026 15:02:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0uSoFakxT5wYxhIAyJzwovqxFUrMkXGkqFtiH8dH3I4=; b=KqL6qlMpUYQozBUOeTeYF0TGmf
 l3v3eirP0PBXaHzfd8sSVpHuwHEmerzD2/mdLWRyeOyEtL465RMZsKn5pyixPwF3b3O9IqCO69EHP
 hJWDD+7C9LzuvdQ+sOhjRL82fnzvrRjIWeFNA9cL3+BmTBKL00upzub6J3cihnnioUQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0uSoFakxT5wYxhIAyJzwovqxFUrMkXGkqFtiH8dH3I4=; b=OqbYAszOdpp08ITYWi17mBj/zJ
 o54pmf0rjAgasZhBpgHth4cfkQ6bngHxNeHxQzTWY0PpD8jIV5OwtoQ8GW//GvWa6tysrxtfXvUct
 Lzqvf+e7/4ZXFBecmIBrwEFMQwHW3Mt9/39pzS7PgRsE6zQ7VXYW+MxMEcY9hGDWvs8Y=;
Received: from mout-b-112.mailbox.org ([195.10.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wV9a7-00008F-Bl for openvpn-devel@lists.sourceforge.net;
 Thu, 04 Jun 2026 15:02:06 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4gWSTB6FKhzDvk5;
 Thu,  4 Jun 2026 17:01:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1780585311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uSoFakxT5wYxhIAyJzwovqxFUrMkXGkqFtiH8dH3I4=;
 b=adXyUOiqVE+WN8o+D32G10eBXBPiqAtDKb70S/TQg8Kd8X75tyDc5ylvrQ16J3xO3fVoEK
 QpU98KuWXS+cyFAOe2L2qeHhghkQh17yqhMfeM4FsjOmNcuQBVBuBYhzimWwX3N7XsBbm9
 QL7n3zje8098ATaUkaWbqI9izP07xkZRJLHlcIYASMrQR5IfhjA7X4SQMz3357TCkKIqVp
 CtiIfzlOjyTC3SOmDgq+ajx9khE+sGIx3VgVhJ5Ti/OTeDEdyKepzfEqmQspXXFCvRVOyu
 jcWjHPEnCQ1wXYafYSUIF1rUzcgW5dnlRBGRqh3mOMMqyl/GQqq9JcbqmkEO9A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Date: Thu,  4 Jun 2026 17:01:39 +0200
Message-ID: <20260604150141.637814-1-ralf@mandelbit.com>
In-Reply-To: <aiBqNvZRBxfvFpU-@krikkit>
References: <aiBqNvZRBxfvFpU-@krikkit>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gWSTB6FKhzDvk5
X-Headers-End: 1wV9a7-00008F-Bl
Subject: Re: [Openvpn-devel] [PATCH ovpn net 3/4] ovpn: reject UDP remotes
 incompatible with socket family
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

On Wed, 03 Jun 2026 19:53:58 +0200, Sabrina Dubroca <sd@queasysnail.net> wrote:
> Sorry Ralf, I wanted to reply to this earlier.

No worries, thanks for taking another look.

>
> 2026-05-28, 22:44:57 +0200, Ralf Lici wrote:
> > On 5/28/26 19:15, Sabrina Dubroca wrote:
> > > Hi Ralf,
> > > 
> > > 2026-05-26, 14:45:40 +0200, Ralf Lici wrote:
> > > > ovpn accepts a userspace-provided socket and a peer remote endpoint
> > > > through netlink. For UDP peers, the remote endpoint family selects the
> > > > transmit path used later by ovpn_udp_output.
> > > > 
> > > > An IPv4 UDP socket cannot be used with an IPv6 remote endpoint. If
> > > > accepted, the transmit path may reach IPv6 routing and UDP tunnel
> > > > helpers with an IPv4 socket. Similarly, an IPv6-only UDP socket cannot
> > > > be used with an IPv4 remote endpoint. Otherwise ovpn may enter the IPv4
> > > > UDP transmit path, where IPv4 routing treats the unspecified source as a
> > > > normal source-selection request and may choose an IPv4 source address,
> > > > bypassing the check that udpv6_sendmsg would normally enforce.
> > > > 
> > > > Parse the remote endpoint once in the peer new/set paths and reject UDP
> > > > remotes when the provided socket cannot send to them. Pass the parsed
> > > > endpoint into the common peer modify helper so the validation and the
> > > > stored endpoint use the same normalized sockaddr.
> > > 
> > > Since this can be changed at any time by userspace, I'm not convinced
> > > checking it at setup time is very useful.
> > > 
> > > AFAIU, the next patch fixes the actual issue. This one seems to mainly
> > > help userspace avoid drops in case they incorrectly set up their
> > > socket (as long as they do that in the "right order", ie all
> > > setsockopt before passing the socket to ovpn).
> > > 
> > 
> > Hi Sabrina,
> > 
> > Yes, your understanding is correct: the new/set peer netlink messages give
> > us a chance to detect a broken configuration at setup time, but we cannot
> > prevent userspace from changing the socket properties later on. In this
> > sense this patch is not the actual correctness fix.
>
> Thanks for confirming.
>
> > The next patch enforces the real gate on TX, but the error is ultimately
> > swallowed by ovpn_udp_send_skb after freeing the skb. Antonio suggested
> > adding a netdev_warn_once on these new socket-based failure points
> > (including the sport == 0 case), and I think that would be useful too. But,
> > aside from that, I don't think there's a clean way to report an error to
> > userspace once such misconfigurations are hit from the TX path.
>
> I think adding stats counters could help (probably per-socket, and
> maybe a separate one for each case in patch 4/4). A _once/_ratelimited
> message also sounds reasonable.
>

I agree that counters would improve observability, and I am not opposed
to adding them later if we find they are useful in practice. For this
series, though, I am not sure they are worth adding UAPI for (netlink
operations are currently all peer-related).

These drops are not expected to be normal packet-loss events: they mean
userspace handed ovpn a socket, then left it in a state where that peer
cannot use it anymore. In that case the most useful immediate signal is
the reason why the peer became unusable, rather than a counter of how
many packets were already dropped because of it.

Antonio and I discussed this more in depth and our plan for the respin
is to delete the peer with TRANSPORT_ERROR via deferred work for
socket/remote address family mismatches, instead of keeping a peer
around that can no longer transmit. We would also add a _ratelimited
warning on those TX-side failures (_once appears to be once per call
site, so one bad peer/socket would silence the warning for all later
cases).

For sport == 0 I'd keep dropping and warning for now and think about a
more systematic approach in net-next. For example, we could reject this
at socket setup time and override the UDP socket protocol callbacks to
intercept and prevent disconnect (though that needs some caution because
IPV6_ADDRFORM can apparently switch the sk_prot back to udp_prot).

Does that make sense to you?

> > So the rationale for the current patch is to at least report the specific
> > socket/remote mismatch through extack when it is already present in the
> > netlink request, and avoid installing a peer that would immediately drop
> > traffic.
>
> Yup, that makes sense.
>
> > That said, I see that the commit message may be selling the patch as solving
> > the issue at its core. I can reword it to make clear that this is only early
> > validation/reporting, or drop the patch if you think the value is too low.
>
> A small note to explain that this patch doesn't fully solve the issue
> would be useful.

Sure, I will add it.

>
> This patch is a bit large, but I guess it would solve the issue
> entirely for "well-behaved" userspace (not doing weird setsockopts
> after "gifting" the socket to the kernel module). Is the current
> openvpn client hitting the code in next patch once this one is applied
> (ie finishing config, and then doing V6ONLY/ADDRFORM afterwards)?

No, luckily current openvpn userspace does not change these socket
properties after handing the socket to ovpn. The setup time checks
should therefore be enough for well-behaved userspace. The TX-side
checks are still needed because the socket remains mutable after attach.

>
> -- 
> Sabrina
>

-- 
Ralf Lici
Mandelbit Srl


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
