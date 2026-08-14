Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1719C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=206TRK0XwYkYVy74KNadlJ/T4APcx4qGXwflTzJMpDo=; b=Cl8hSuM5ISnsFHV3hOwyMCL5Te
	CmMhJRMpecJrv5APcWs6/JLuuizUXDMjrv2wLvDVzBp4DIQ4pz79SRE1KugS5S9gjlGjuoH0hCJER
	WwB1LU3LMJAwKq4/oqUqW22mQDqdbTvDoV46wGj59EYZBjmPKjG/Hq/a0Nt/dtkw97QY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuoif-0007Pe-B4;
	Fri, 14 Aug 2026 10:00:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wuoiN-0007PG-B3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sk0tLa7KuVfqOnPKe3lac8V6Tp+Q1Vch1nqJh2crz1I=; b=lxRiX6/et7zCKHnwUhCSdSJAnx
 g/hv9WDxvIEdiWa8KEUkAm3dWWwhhOgblOeDoyoaObU2wGZXvREKglF/RPTeFF7a2ee/vS1bz8nxF
 my051I04yvTQ5m2wVrpq/zEaDxQO+sXZN/rrNORG0xc49ROZCn09GjhxB+e7onvtIW+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Sk0tLa7KuVfqOnPKe3lac8V6Tp+Q1Vch1nqJh2crz1I=; b=DD3NucD6BHdbd5vIBqIlFKtLQt
 DGWukxsnEyegrmS1WOnsJh6gYW1W3pqJc5iw5uiTbfahD5tByOw7s0O/1+OxzZD7TbC+fUhzJEnFR
 ifPSRrFAo5CkCbHTndxygCjAx62XqORThELl6Odge3o/l34Hlvb+DXbuPZ9fbgdUReaw=;
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuoiL-0001yX-C0 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:00:35 +0000
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 0F6301400168;
 Fri, 14 Aug 2026 06:00:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 14 Aug 2026 06:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786701628; x=
 1786788028; bh=Sk0tLa7KuVfqOnPKe3lac8V6Tp+Q1Vch1nqJh2crz1I=; b=u
 NzbrjECJzca38AqMqAG8UstNjTbHF+CURQvFc3hRmZ4EbRgPIL+5D3ccGt6H9EYl
 j5MKtnuQa0KZOihLbGop4Awv+87CahAh9bLRPuX9Kly5q/wwwSgJZfNZslr3ElZo
 EaAjGaU2FmJB3cNkd4l9S8ITaT8EsbYTZXtEp96Vu4vXV4ZdaIv2K2RrQmbkO7++
 GuGXT6rM+yBPgvPfyynp9LjshSg32Xdrln8WZ4RnFVh/Y1OqQL+tuISg1O8vSjJc
 6zxHRjTHQUIqN48w5iNW/FQxcOVPMkaerhWZ0Ziixa1B/dgYCWIIsEGzI9kom/2g
 OsUPRvYTwCCyOXrg2sFkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1786701628; x=1786788028; bh=Sk0tLa7KuVfqOnPKe3lac8V6Tp+Q1Vch1nq
 Jh2crz1I=; b=XMvbAxQYLC4cXr/kj9NoxkV3aTf57jtEj2/MlEHX2mVDFF57AmD
 yAsFQDUTKp575fmRUqH4Tq47dpOUbPLvxHHt6cgXfagyb/O0NjaqKTgJ8txjffA1
 4tWbO9UUmRiXeIGHQMbgm6z9Kas6X3nr2lX+LI45d8/uHkcrCfoRTSUlQ+tWg9yl
 aoNfFC544+CC7jKV7ZdkALy4KENn1Ffo2WcxrJaqyE7wfx1XIMqgsY7vH49HXRXp
 lZo2aJ2DyXBoLU2qGaMUc2UEZK1eGQdK5znN2wnMlpgVDR5Pl+i2t4K2Rxvqs04L
 cNb6wvSZX/WCoeVYkiepPk4JtsNSq6raS2Q==
X-ME-Sender: <xms:O-d-akbt5u5I3ipq-h7OZHuq_0EH5v4KGbFgayHYywtv3S4h-8VV9A>
 <xme:O-d-alaKm3pm9EMS37GVR0UkpdSSNbzZTXnouSvjYv8N9-zEpGNWarJJIww6VGqhq
 nUEIw86Exe5C55vnyGICRbcMkvW19TKnEdC4xjdWtZt2UuRWod6c3w>
X-ME-Received: <xmr:O-d-askgFEI3PtQbdFgm-fJtbW7zH5lMscEkwzoJU4VTJIhm3dS9oBELyc4>
X-ME-Proxy-Cause: dmFkZTFRC8o3QHiX+Atv3Q63ait4YETuhcOjFAFoLG0ao+H5aTNWdcxZhI566WXTQGWfYE
 R5rIqCc9sp76zok0lspJkf0OG0+jAa5MTUfa461f2fwB67R41/dqhic8J4nioruNJ+A/Mx
 0rfne2H69rhpK6ToHt1Clgt1NYSRKBQ/1Fy0Y2el/z9T27ZkqTeaLhOVHJ0ZZngF38wPNi
 pYCUNFIEqrZJ1F7GqA0UyWjKxHqEMlmgdhsT873GJOkIGnJtoxxUZIg5w0sJ/SMfyNFMki
 ktbNEQJd3W0U4Agz2HCLl7QhqyrMTw04FkEkkl+YhjpPYQsOvLasClyuh5/R3r/K/m0VHH
 IbwCK+/mhbl+0jvC8VZ+BM7oI7746cxgowvU6T28OvSTIk/g4mX4IHIaBFRq1ydNQzU0s/
 9kuvd2O5yT5B5b/xA+QPIXjqcOXWJ73H+vXIEWAP1QM881WjL8RPJKHAgE0OtOgcsj9hPS
 JdFpsqG3xUMerZLBcbOLIgRuoCTbxLGlynnGC+9FkXApgJ+kEA2Z4CqvNGA1bQ7C3+8y5g
 m/UbDdV8EhD2PaOtLfkttS5NMnaV8Tcl0ETsNYj8qACJnNhL0+6p7sVGeXaKauU83QA0X5
 lAaeiG3V6xIY85gEL+Z4xBVE4GrZr0CYo9PpX+/Pdga0Tr6YGo12kWBrZ7Vg
X-ME-Proxy: <xmx:O-d-apzULOd7H8PU31eN_roIan1HiWJS-GmRDPrSQW6J0oUP81IRqA>
 <xmx:O-d-aiMsseYgAHuHHA4WEYMfDOZ3dTegIxOkT1X-elN3G5Dd0V9fDQ>
 <xmx:O-d-alQo8w70-gDzmKCt9eXco1ZCaqmU8ayNlsOHLFVT8Wzwf343QQ>
 <xmx:O-d-aoZWyLQqai2Mu2O_BuJgvrA4Citd4w5bhb8pJwTRGSDm2bXDLA>
 <xmx:POd-apPju0qEob4GsF5mOBYYc4mJJ17aA5Auf-liXhosMRUYf9Ct_mGB>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 06:00:27 -0400 (EDT)
Date: Fri, 14 Aug 2026 12:00:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <an7nOeDF3u_DVV4L@krikkit>
References: <cover.1785338921.git.ralf@mandelbit.com>
 <17ced9a7caee691e602e3c02f5e399aa9a35067c.1785338921.git.ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17ced9a7caee691e602e3c02f5e399aa9a35067c.1785338921.git.ralf@mandelbit.com>
X-Headers-End: 1wuoiL-0001yX-C0
Subject: Re: [Openvpn-devel] [PATCH ovpn net 3/5] ovpn: reject multipeer
 peers without VPN addresses
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

2026-07-29, 17:37:41 +0200, Ralf Lici wrote:
> In MP mode, ovpn uses the peer VPN addresses to select the peer for
> outgoing tunnel packets. Peer creation currently requires a VPN IPv4 or
> IPv6 attribute, but it only checks for the presence of the attribute and
> not for a usable address value.
> 
> This allows userspace to create an MP peer with only unspecified VPN
> addresses, or to update an existing peer so that both VPN address
> families become unspecified. Such a peer cannot be selected through the
> VPN address hash tables.
> 
> Reject MP peer creation or update when the resulting peer would not have
> at least one VPN address configured.

Same comment about "this has never worked".

> @@ -371,11 +373,19 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>  		return -EINVAL;
>  
>  	/* in MP mode VPN IPs are required for selecting the right peer */
> -	if (ovpn->mode == OVPN_MODE_MP && !attrs[OVPN_A_PEER_VPN_IPV4] &&
> -	    !attrs[OVPN_A_PEER_VPN_IPV6]) {
> -		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> -				       "VPN IP must be provided in MP mode");
> -		return -EINVAL;
> +	if (ovpn->mode == OVPN_MODE_MP) {
> +		if (attrs[OVPN_A_PEER_VPN_IPV4])
> +			vpn_addr4.s_addr =
> +				nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
> +		if (attrs[OVPN_A_PEER_VPN_IPV6])
> +			vpn_addr6 =
> +				nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
> +
> +		if (!vpn_addr4.s_addr && ipv6_addr_any(&vpn_addr6)) {

minor nit, only if you end up resending this patch: the inconsistency
between !s_addr and != htonl(INADDR_ANY) isn't great. (but I don't
think it's confusing anyone)

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
