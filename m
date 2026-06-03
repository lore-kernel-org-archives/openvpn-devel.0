Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B15CD6E57
	for <openvpn-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATBCEiPM0K4RNKXX/txx5p7Aq/VZcs1d8xBPfW0c9FE=; b=Nby1hIAgIKYlQiyth57fHWNAuV
	uT458OsPPXQ7BD0dKnC55st8pG4w7rNKZDSwxbJSfOsjyzPYdZksNMzSDskux9R8qpRgrib/dHvaZ
	r0pIiZ/QvG7yqGVW7D0HipMy19nl7JBVymgwPk7FwAIPLzQd2KuK8gvfDA5RF/ct3wSU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wUpnE-0004k9-Rc;
	Wed, 03 Jun 2026 17:54:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wUpnC-0004jr-Tc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 17:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WX0AxNDg4oOYUyiNGomRj9DDscESUdifDyjau3Ok4qY=; b=cGChYf2Ipwh1QGHFMt/B2E8B3Q
 PjFyrbrJoXcAokllOSZCRC0Gk1IbKC/Qf3HRxFw6r45ZDKhUC0BQkTSxamsT5BRIoz7tiZL3qVPlS
 EbUfmHkO58C/eWcxDMUPhUdf7yrhU2DvxjwXowiT3dn3mXo9IOT8tfN//5TmdqvHiPh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WX0AxNDg4oOYUyiNGomRj9DDscESUdifDyjau3Ok4qY=; b=fsZlbJxzKnW/JmaFqSCaAA+Ftm
 UmwY2nsKAEFCbmo+8qoih4RLOXWOOClpw8vcdJhX0ft7oWBR/SgKUxIlbkh9odjd1j77JJQpb5HfB
 rCjV9x6o4G03TyoOvrcLU5gT7bS6vHy8ESM/ktz1R0P4hcyZc0Q7vrF9yp5X0ki3jNjU=;
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wUpnA-0005Kz-K1 for openvpn-devel@lists.sourceforge.net;
 Wed, 03 Jun 2026 17:54:15 +0000
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 0C1761D00149;
 Wed,  3 Jun 2026 13:54:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 13:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1780509241; x=
 1780595641; bh=WX0AxNDg4oOYUyiNGomRj9DDscESUdifDyjau3Ok4qY=; b=V
 bgwx9tqyiDTxP6T/e7bORfduyeDXpIfxCXRaNCzMOzHLJGG9VrjZqZvETuTLkVDb
 rjR3qCSBQiiPT2P2UWl09zd3Cw71x0HWivVOf2/5fYLrdoyFF5x+U184Qm7xWpGj
 U2EA7Yy9/pwtpBVfciO3iobQAgn8UFBBYefQ8Ys+e2iJsD8AFgGfb2o6ciXdw0V6
 7sDv5Y8wSDQeNUoPiYR/LDZAsHRbUrv5OIwQVaWMuw+fLZY+1wdhLPQUbDd/PlHB
 S9cVovc+8xC9FaCdBQauI86GOIkKGH9X3XRKhROq12FuoHX+BvS3YH8f5VmqOFtR
 GKls7m2pXWSPzLvmor4kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1780509241; x=1780595641; bh=WX0AxNDg4oOYUyiNGomRj9DDscESUdifDyj
 au3Ok4qY=; b=ivt2CBJeXwGFMituAiaxwT3h1m3ANQwJW+53D5Xz0ywLYqDHQ8Q
 Gsu+S5UMeJlJbRskoiaUreTCQLw5U7LoAwP+q7NvbiOcuj/jbN/AvgTQVcRKIiwL
 6+feCvIlfQr4MS0CzICMsRH7+CQD/C3Yt5eopp2nE/HRF3E2pTcNZr1XJEZkIWDc
 teE9f1wNFqYlmceIRQH/QY9KOmxOztU1oEPLPsSdiMnhxWM9REUddzG1Nl7tZ+Me
 OqNlqn4BWPeUuANkTtaWnJf78ebMhUDgY1Iak92QS2VG4kEUROs/jMQfGcUHuK8g
 yx4xVodSBPoGzlf1aLnMd86YTrOeWpFSnCw==
X-ME-Sender: <xms:OWogai_mGw84u_NATC9vOaNJJvBRwrbTr_77vXETC0Fx2yJMI0azYQ>
 <xme:OWogaovblk0k-x6zcyPAbn6Wj91xmAcyO70kMSWrWqicBDd_5l_sHB636EfjZKdnE
 xA-2-eoxF4q7mFrYCClaI1J-RAJvBuaO4IMlfUNdCnCxULvMcKN4lY>
X-ME-Received: <xmr:OWogalpS57TuEBGfjErNFx_2y9-iXVh5AYGlSPEpavyi0QYXjJrkqvdEPt_3-QHUocQg-omnl1CVshjPj3dUGYs>
X-ME-Proxy-Cause: dmFkZTEAuKmPelFlTOcvMQlDcoTdHBiPvyyyGwq0J12bxS3r6qjNmoxl+otlWxzH9XSa4w
 XHhmt3Zu2wHjfrxjeEWlbqkmNNpcqdXrSr5Tm8w32W5jd5awX3Qh2HPmI2MA51MPPEJr65
 YoX8KZJYVQ82xc+3Pv9tWW993H6ocS9wNNMCtmHArFsyLbkXwM1PFQ0wKuFWvrq+BLFnMY
 ycJIPct82GLPS3XYsUDUluGFynnhztSECJfIdO7H36GiMkdiQ6kcRfSk1r8DNZ6uhOug56
 y73xtFJy/TPDV3S7HK3nH7LAXWg/cWG5akDpfoL8ZdVkDTQgFB7jkMUAcjpBBVP290dNjC
 e5K48ic/+KEsf9n+Czmzx7GYEUTNcGEaVz3fI+wUroBo1lfHmYUip6mqu9HU+JRO4YzQj6
 4MysYTqo4fR5jASvWZV7ZxwNoiMOdqhCdDGa+eJ0Dcp0IVQVGnG06ATkWSBAOWUOojTlEh
 7flm7fAqulYKBGwy8Wls+9uiORKD1A0Gbna8RixbJfnk3qnUbNHYGYwSHjU8MvOyT/to6K
 DOhSR9i5JmckMnL3ew+9noTbXEggh+B+tWAZi8eCdqSWswaJwwtlEveZ0T3wXHtHeiXjxf
 otVdiZLzTlSOMeDycbqA0qXgvvoadwvPgZfMZATjb38LWZBX4wce2YBOWU0g
X-ME-Proxy: <xmx:OWogalk1TfkoMCDT7ee6F3dGekAVCiQR2JPhC02OOdWLtClzs7JOfw>
 <xmx:OWogapwqoMm_9OdmCjRUunNx_gdotLpHq98Hs9E469qIAlqNzfW5IQ>
 <xmx:OWogatk34uwK8U9ITq8Ie2Mo-Xm7d31ISZQTz7O3MTOfpkdtn0TKiw>
 <xmx:OWogaidwH6Bta_PqAnL1sR5sQ0CULuoE_qTcycZy6cDfBYhQ6yTg5w>
 <xmx:OWogaujwi8hGCYXEVyVB73wVvq0jAGElRSH2hCqGNijiSPygkvM0tdxU>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 13:54:00 -0400 (EDT)
Date: Wed, 3 Jun 2026 19:53:58 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <aiBqNvZRBxfvFpU-@krikkit>
References: <20260526124544.425791-1-ralf@mandelbit.com>
 <20260526124544.425791-3-ralf@mandelbit.com>
 <ahh4LBUUkQQLCGtI@krikkit>
 <98630806-c88e-4905-b7fc-679575ea758f@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <98630806-c88e-4905-b7fc-679575ea758f@mandelbit.com>
X-Headers-End: 1wUpnA-0005Kz-K1
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

Sorry Ralf, I wanted to reply to this earlier.

2026-05-28, 22:44:57 +0200, Ralf Lici wrote:
> On 5/28/26 19:15, Sabrina Dubroca wrote:
> > Hi Ralf,
> > 
> > 2026-05-26, 14:45:40 +0200, Ralf Lici wrote:
> > > ovpn accepts a userspace-provided socket and a peer remote endpoint
> > > through netlink. For UDP peers, the remote endpoint family selects the
> > > transmit path used later by ovpn_udp_output.
> > > 
> > > An IPv4 UDP socket cannot be used with an IPv6 remote endpoint. If
> > > accepted, the transmit path may reach IPv6 routing and UDP tunnel
> > > helpers with an IPv4 socket. Similarly, an IPv6-only UDP socket cannot
> > > be used with an IPv4 remote endpoint. Otherwise ovpn may enter the IPv4
> > > UDP transmit path, where IPv4 routing treats the unspecified source as a
> > > normal source-selection request and may choose an IPv4 source address,
> > > bypassing the check that udpv6_sendmsg would normally enforce.
> > > 
> > > Parse the remote endpoint once in the peer new/set paths and reject UDP
> > > remotes when the provided socket cannot send to them. Pass the parsed
> > > endpoint into the common peer modify helper so the validation and the
> > > stored endpoint use the same normalized sockaddr.
> > 
> > Since this can be changed at any time by userspace, I'm not convinced
> > checking it at setup time is very useful.
> > 
> > AFAIU, the next patch fixes the actual issue. This one seems to mainly
> > help userspace avoid drops in case they incorrectly set up their
> > socket (as long as they do that in the "right order", ie all
> > setsockopt before passing the socket to ovpn).
> > 
> 
> Hi Sabrina,
> 
> Yes, your understanding is correct: the new/set peer netlink messages give
> us a chance to detect a broken configuration at setup time, but we cannot
> prevent userspace from changing the socket properties later on. In this
> sense this patch is not the actual correctness fix.

Thanks for confirming.

> The next patch enforces the real gate on TX, but the error is ultimately
> swallowed by ovpn_udp_send_skb after freeing the skb. Antonio suggested
> adding a netdev_warn_once on these new socket-based failure points
> (including the sport == 0 case), and I think that would be useful too. But,
> aside from that, I don't think there's a clean way to report an error to
> userspace once such misconfigurations are hit from the TX path.

I think adding stats counters could help (probably per-socket, and
maybe a separate one for each case in patch 4/4). A _once/_ratelimited
message also sounds reasonable.

> So the rationale for the current patch is to at least report the specific
> socket/remote mismatch through extack when it is already present in the
> netlink request, and avoid installing a peer that would immediately drop
> traffic.

Yup, that makes sense.

> That said, I see that the commit message may be selling the patch as solving
> the issue at its core. I can reword it to make clear that this is only early
> validation/reporting, or drop the patch if you think the value is too low.

A small note to explain that this patch doesn't fully solve the issue
would be useful.

This patch is a bit large, but I guess it would solve the issue
entirely for "well-behaved" userspace (not doing weird setsockopts
after "gifting" the socket to the kernel module). Is the current
openvpn client hitting the code in next patch once this one is applied
(ie finishing config, and then doing V6ONLY/ADDRFORM afterwards)?

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
