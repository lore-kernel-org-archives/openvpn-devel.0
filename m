Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF193C61DD6
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MHa8qsfCRtk2Mgyn+iY4tb4K+h85Ygcb2eIw3pZwqyk=; b=GBiJYGMT3XKahsF4BqeWHK8Xzu
	izlcAIZG1nF4NsSEpPTGcn00p34DRV7Vgjo4lrbA8hxn9CfkECMH0julHYx+Ue4OdQZhQHW61hCZg
	5D6lFxJEwtmH712f+zikA9Q631Y0UqhrdB01tgIio9aFA1P/2gHcPDdAiSetTYfjB17w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2Tft-0003Rh-JS;
	Fri, 04 Sep 2026 13:09:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <root@fossjon.com>) id 1x2Tfr-0003RZ-Mx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 13:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:Cc:To:From:Date:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XmLWMvet4LCMphGctYGtMZiKlgZgaGrqfCgdlS79KWE=; b=NyCenFBs0p5UlSzFGgMFsfFW9+
 +nnZcb/btbMEQlpwYggZ3JFxQAv/33QaIC6Rkko0w2qANW8CcNQgAArqRee0aOzE1O4F/jaRrFJyv
 o6GvOqiqSA+rXsYWvAO6IdIFxgKEU3DvZOUU12wga8YpG7A0giIDzr1XWdXEaTFVBwOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XmLWMvet4LCMphGctYGtMZiKlgZgaGrqfCgdlS79KWE=; b=jtrM+2f8uuz3vkzAVJN6+n3eX0
 /ZIh2zTaEbZsqYlrNkv4C+5d4ybFUyCpfaQYcPWFKaIUr1xtBx4KogTU4hiTUZzjUkHyeyellpJv6
 OXHtUUGyLkFPuSL9Xd8ldewKGQMvNMr/BC6qpUXgWWt5egv7YNYarPf+rwAJnHZ7xrXg=;
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2Tfo-0005O2-Jd for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 13:09:43 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B915A1400140;
 Fri,  4 Sep 2026 09:09:34 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 09:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fossjon.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1788527374;
 x=1788613774; bh=XmLWMvet4LCMphGctYGtMZiKlgZgaGrqfCgdlS79KWE=; b=
 Fe8T2/lCcyZ875OIXuxYuPLfr3taVZ/F3d7pWYkEr80WTgJd32GMJM7S/exbLqgv
 p3zOY3Rqp8BrEL03csFUUvdSyOzxjwdQ1rY61QX63t470txCjQ4c5nN/aL3L8Kdy
 U5C/nq8qIHMp0rGAt2C95SknnZR5kqm+rfcifz1DKAxYY3IPUTZoPRQLwG5n7kof
 ZbuJgAC9G0r7UBJ3aimb1QUGcSqBsI6f6Vm2rG4uSPUhaW13CVZd22Ja5M97A6u/
 x50IArU3JJSc5gxh3a5y7pOab1TF5uYsHAoew31gvFbVCb2QlqgOL6f7dOcH2MAk
 pkF2gVU5Y3/dk2+ep7+b2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788527374; x=
 1788613774; bh=XmLWMvet4LCMphGctYGtMZiKlgZgaGrqfCgdlS79KWE=; b=J
 6kHOuSocn/DWKyr+cMCEPDiDzbeq4V91P88oeD6uJ/BdcOTiLxAKVKnqrSovACxU
 w/M7Rg0om055M1hYvrxPXNhkgwdm5OvV8KdcXk18BPPCYmyEjhVJ5teoRhdHPVzk
 Y06KHaUyfwVgIUHoy7AJ4+Q6imKjIFDclwbSdkwspAlkUnHE9LotaI7CTmLdWrL+
 PkOvf7MofTVdeSIVc4kWPMcznJiZHzd445EH+z3awM/EafTK2la3Gem7ZJs/imY0
 zhz8baR/hgoG2Epz9g+52Ie0gicCEcCcOumkPC770pzYo3lK2ouuc1upd5QrNWg1
 1OFMRQizMJ4oRdCBGvUhA==
X-ME-Sender: <xms:DsOaah-9jLBF4tt8RxR-lZHNJAAIqs9u0q0HMfgCDeP1RmauFUpmkA>
 <xme:DsOaagg0-bO5EkXHnItgnUaAbNcYsjmNw4TvN0r3ipIi7Pqt2OIMzddZR-AqhMIR6
 8-o20LpA6hyL0SgOHg0xf935coXaf3BmlZgQqh8FVQFJpFQsqQWQcc>
X-ME-Proxy-Cause: dmFkZTFDoaYy3dto0YAtAkFZVWnBySchvsdcIqFodNvNbDuDyV4TyR3QhhT6iQ5FI/frDv
 lgWq3ZKk10lXhGEl1RgBs8SRM/2aMpL5Iq3hr9OLy/OgXAFa/m6nANaO7XTs+BBABonokq
 PT5YuMKHaG0hFNCOjZ3A+/S6rbgUu056ESJi20hdcnSSE3QS6RMG0DCtuL/4ddxTGe6urm
 y0DNJQctyAEKSLyz73jQ6SWCQ/xfMXdnZpbtkGRTFHIo/Fs4kfp4OKyfm3RbFeTHl3k1m0
 kGXG+g/mFPeH1f4YRaC5autF1eXnkTc5ifgETuy5QYeyNTDHy8fzi2Get9ePd2rbKfhPGJ
 eLTbRUpqs6/zjaCPmyYcwsAJ6hYKHxI/BBoYIumCywtI16tPQsVfJXF6mj+xNflUtqtDhj
 9J9jvl1fB4Yg6WulAh8mYllmPBoJOETZ+Uza7+3OS42NTzwC+u43JaEqIyvYUVGOjLjV8k
 5KAB08/YeZfFwqTuqQY0H2lw1nOtr6FtMBbsJWs8p2Y6dLReINpgrgLIc8h/gx9S9lMkEv
 zWj9+KCEPWW91xfVDxU+p7BNR2pG8+bTIIrq/q6h89KWvrvl0NtigKVa1SlhvDDaKr4tE5
 Qh3zsAJ8ZNYIWMmO6EcoTD+HA2LOoPg8Po/1G9H1S8ooKVYcusy+AYhTQbPg
X-ME-Proxy: <xmx:DsOaaswB3rHwAP_OcHmTv0I5JHijTpRKd5fvsnX0AzOi9o8uoLvhFA>
 <xmx:DsOaakn3y161QgNSXP4L3sIqCqKyxaq1rM16Y4tY6z7aknPxEIXTtQ>
 <xmx:DsOaateS5L1iAP0Pm4t-d6NjGiFih2BXVoe9dwx5shwQswYc3EWeOQ>
 <xmx:DsOaaiqnRbgrIhBeYAriM2TMuZbQP9Yil4KPw43jcPEWHlaS4iNU2g>
 <xmx:DsOaatdaykBYoVmhrNbvN5kuAje00RK53W7aOdz7IZZPaZi18nWOamkK>
Feedback-ID: i961e487e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 04DCB1820082; Fri,  4 Sep 2026 09:09:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AC6Y2XDLo6N-
Date: Fri, 04 Sep 2026 09:09:13 -0400
To: "Gert Doering" <gert@greenie.muc.de>
Message-Id: <faf758be-ff59-441b-a645-e72e702a6e48@app.fastmail.com>
In-Reply-To: <appiT9N7HUjEZ3DC@greenie.muc.de>
References: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
 <appiT9N7HUjEZ3DC@greenie.muc.de>
X-Headers-End: 1x2Tfo-0005O2-Jd
Subject: Re: [Openvpn-devel] It's been some time since I've looked at the
 OVPN source code but I found some cool TUN interface flags recently!
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
From: Jon Chiappetta via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Jon Chiappetta <root@fossjon.com>
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi Gert,

Thanks, I had just one other question on the DCO and what functionality it covers, I tried to look at the source code some time back but I am unable to read kernel level C properly compared to app level C, it hurts my eyes. For example, let's say there are these basic components to a VPN:

- read from interface
- encrypted buffer data
- send to socket
- recv from socket
- decrypt buffer data
- write to interface

When I was looking at the OVPN source code some time back, I saw that the read from tun and write to tun was at the app level and then it handed it off to the DCO module? Does the DCO module primarily cover the encrypt and socket operations and functionality alone?

Thanks again,
Jon C (root)



On Fri, Sep 4, 2026, at 2:16 AM, Gert Doering wrote:
> Hi,
>
> On Thu, Sep 03, 2026 at 05:37:54PM -0400, Jon Chiappetta via 
> Openvpn-devel wrote:
>> I don't know the full history here yet and am still learning but
>> was this option ever considered to be implemented for OpenVPN?
>
> The canoncial answer for "make things complicated but fast" on Linux is
> DCO - there is nothing you can do to in userland process to get the speeds
> you can get with DCO (except go full DPDK), so the focus for userland is
> more on "avoid platform-specific complications" nowadays.
>
> gert
>
> -- 
> "If was one thing all people took for granted, was conviction that if you 
>  feed honest figures into a computer, honest figures come out. Never doubted 
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@greenie.muc.de
>
> Attachments:
> * signature.asc


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
