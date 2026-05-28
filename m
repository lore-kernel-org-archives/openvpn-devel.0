Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95618CD5BD5
	for <openvpn-devel@archiver.kernel.org>; Thu, 28 May 2026 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L+7rbol04LOa+AN0/pZAY2PrzacNjaKMViPRBwLeFPI=; b=M8EsjCFFDUEXnv6dQbdMm17s/B
	SFIDH3UoY7wMlSYD1DLrJ1JyB6ZvHrG6L5tdu7XlOfoxUHgNGpBM2MFYr7zUaAg5YruI8ORYAw5MO
	I8MmlvCYA1XKN/AHlJ0i7MrMSg8K7w0h2sErN001bx+XtUwbdvD1R/v0E5dVFDKktBew=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wSeZk-0002BZ-JL;
	Thu, 28 May 2026 17:31:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sd@queasysnail.net>) id 1wSeZi-0002BQ-04
 for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 17:31:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8CMBR7/6oepI5C3keyozqOS7X99qRY/U6Cbd4qstMv8=; b=PWEkFicyNn2Fc4kp+aBJWobIye
 Hq5k6+5h7Dh6IyYrfNKKqwiKUndY7p0CwMX8ICdaUT3jGzf61pCZt+t+3L/x2QluZKtwAC5CQzDgz
 bUDSMNKzzWSzNiutPtdV8CAPIGzbLAZibhQJLDciqzgDTB6lAZOKb/+7+qWo5YVbLOAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8CMBR7/6oepI5C3keyozqOS7X99qRY/U6Cbd4qstMv8=; b=XTnTxHlw3XQEK+dAz1lbqh28Bm
 LBRfdpimvJ/5LsYFCet/hba7vq0Vd1ymwdwhah2oEEtCyVSgEb1KQp0fx77QBldMThPnjFdxn1/X8
 O6jNXpmJfRw02RAJmcln4h6ETzlSYP8IFEwxkx5U9W9U6XgjzJwWM6/pbNqOUf8BGFFI=;
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSeZg-00050o-8I for openvpn-devel@lists.sourceforge.net;
 Thu, 28 May 2026 17:31:18 +0000
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id DCFB8EC0104;
 Thu, 28 May 2026 13:15:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 28 May 2026 13:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1779988527; x=
 1780074927; bh=8CMBR7/6oepI5C3keyozqOS7X99qRY/U6Cbd4qstMv8=; b=S
 MTqHix2+0u+uYjY1xNFlFD/isLX5F3yXEBrWCAjPYRYJuELuN58oXhCaWEOlpU6J
 QDG3+YPulS9b1/EAcy14b4T5Am8CLk74+uMIloPLdHwfMigPDhEzZ4K43ekYLaoi
 UA3JYi+7s/o3pyDOzIm7ZrpKZnDTsmx1NCvtf683iw5E0NfjS1UqGGgAJzzL0EUc
 91Ph5r+nr63Uz90FqUhW/JeDv61OkPU6005Wobc2Aaa+M668nUmIuMTF3/gGNgi7
 V6XwQhDbCxtg4uO5vm6X+lNhY2Npb4CGQIUPKKDkxbYzjtbOs/RPGwVisw+DOTj2
 0i8+tQX1PqeDeeJ4HQBFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1779988527; x=1780074927; bh=8CMBR7/6oepI5C3keyozqOS7X99qRY/U6Cb
 d4qstMv8=; b=Dds3YSXZ/XrEcLj+GDmPYA24yFoaj7JOVXdn/KjvNklOj59G0gx
 jfwAtIjYsRLkKqvSN7cXyubghrCtGAIkDRAGi34SfjV1mLmupGSpKP3pJtOtJmn2
 Ls0lY7jyWYTypYxEiLaJpwxjt2mzWHSUHabq/ctnVJU2izLLrggO96HlvZ0Eem6A
 cnrJfefXd6f1Y/neLKSImfvrTOWyfGJPfUaIRvHSHSfs0QUPr4XQhiXo2e1YtVj3
 WrzDGPhJsTK8ggcj8va6BMFOSVcf6hFeDRFmXe3snsmSlrkKEUrsI2M4fz+TC1YP
 /9Epb4bfo4pyOkElQyI6XN+ZxsVXB805KBA==
X-ME-Sender: <xms:L3gYakFO1uYPJ-FEG0T5RE0qd71UP_WlbuBY7i5buPl8QVwrlhUHoA>
 <xme:L3gYajVXDS4j_aOkWEjGUlVyDRkFIPx7yh188GE2k0LZ7gjpPOUSAEQ6U4Ahcfy2A
 YaLE8b7fpAqRUz-6QzlKhKFJwvCXRcI4JKeHPrmArQNM3xeP3ukxw>
X-ME-Received: <xmr:L3gYary1LCdq1knQ4QQH3dDUMPZ1tssQow5Z7HaWrWIe6umruB2mFtYcT2VMYS-JJxE27xAtqfjnaQxrl69oIe4>
X-ME-Proxy-Cause: dmFkZTE75QTxmi5IolPxbT8mTZNXmadhMFIlnvqQlaNehciBjRCyljQXbzvHFbNilbeJcc
 ZnZrQycVkEYfYnNHU9PA+B/o1hFVpfsxzJjm7/CVX2p6rgjbERubwZupjDeHHiAB0xoau1
 QwLMwxVRQ9qU79DyY5N7ahJWo34hNOV6F6XeJ+cWr1Mkroas/5xHEnBrHctzj9m1LRM+X8
 rgqj0IU3Z1WFf7R2M8gUi0JQEtMdXUFTpIuLtsceXiuUlzNfe8Gxvrp9YVEYcQMdu01229
 2T7qT43AURYWik5Fs65gVZQ9+64KF6aSg+Jj+9oGHQ3JljwNOY4Mu+zmnPeE+kbaXcr8m8
 +JlA3WNkiem9a07yGn3in3Aie8TgGFZzxuwEPDmXbQn+HKfj4yw+xY2xRlFsCKVm7saobT
 SmNNpp5bwk7uJl9qnz7ORoM3Ex9VAKsI/idueDf822mRe9tgPkBZ+Wcym2JMjrTikGleec
 Nbe8q8CAsU50TqdFt4imp8yN50/AGIQhV0y3cJWOEfGNGdb2TUT5jomQ3mucdjWW0azBP1
 fw7ccWyHu+tmXEWQpfXsuWjC6c4sa48q+yEIrlISMAWAudGeSTCpEc9Tl+FArvBjMtpojI
 PNvk68dKbROPzfpT9wN1OJwoZn7ehrE7cPRipucW3XM/4XtfvcW9HQyxnPVw
X-ME-Proxy: <xmx:L3gYahOSepJoGz3uvO0sAV8aadIOGlvvgkmvix2fi-jxDkJtnbyJ1Q>
 <xmx:L3gYas7Bt4pownYvwRILtD4YjGzmI6GFTZd6Qi0VWkH6IOEsnJrWkA>
 <xmx:L3gYaiOE3BMjGXNlbMUCiKPlsqhpbPflTf-RSRKpUjebitPqGDIX_Q>
 <xmx:L3gYaqlndJkvga8ysNpjYlX1X8Tim0MCBcwUnJFbfCtE2-7hb7C4Kg>
 <xmx:L3gYahoJiVrnzLUnnT_NxvfW5D_qjgYkeUz-b5kR7XnZUwb7zYBWp-1l>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 13:15:26 -0400 (EDT)
Date: Thu, 28 May 2026 19:15:24 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ralf Lici <ralf@mandelbit.com>
Message-ID: <ahh4LBUUkQQLCGtI@krikkit>
References: <20260526124544.425791-1-ralf@mandelbit.com>
 <20260526124544.425791-3-ralf@mandelbit.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260526124544.425791-3-ralf@mandelbit.com>
X-Headers-End: 1wSeZg-00050o-8I
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

Hi Ralf,

2026-05-26, 14:45:40 +0200, Ralf Lici wrote:
> ovpn accepts a userspace-provided socket and a peer remote endpoint
> through netlink. For UDP peers, the remote endpoint family selects the
> transmit path used later by ovpn_udp_output.
> 
> An IPv4 UDP socket cannot be used with an IPv6 remote endpoint. If
> accepted, the transmit path may reach IPv6 routing and UDP tunnel
> helpers with an IPv4 socket. Similarly, an IPv6-only UDP socket cannot
> be used with an IPv4 remote endpoint. Otherwise ovpn may enter the IPv4
> UDP transmit path, where IPv4 routing treats the unspecified source as a
> normal source-selection request and may choose an IPv4 source address,
> bypassing the check that udpv6_sendmsg would normally enforce.
> 
> Parse the remote endpoint once in the peer new/set paths and reject UDP
> remotes when the provided socket cannot send to them. Pass the parsed
> endpoint into the common peer modify helper so the validation and the
> stored endpoint use the same normalized sockaddr.

Since this can be changed at any time by userspace, I'm not convinced
checking it at setup time is very useful.

AFAIU, the next patch fixes the actual issue. This one seems to mainly
help userspace avoid drops in case they incorrectly set up their
socket (as long as they do that in the "right order", ie all
setsockopt before passing the socket to ovpn).

-- 
Sabrina


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
