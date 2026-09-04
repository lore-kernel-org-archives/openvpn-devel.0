Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39334C61DD3
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 01:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:Message-Id:To:Date:
	MIME-Version:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qvZunsBZv67aMoqF3RBQzY1lNE2DIIyBs0Vb5c5wKgc=; b=c+l1uYm9U6QBplpan+91b1oyMl
	sfrm/nsUTg4EJk0493LEQdECPRl1XC4FpkEV7QuADcC6Ed9OOPMWd3U8Ih1SExmFTy9T+FuelG6oe
	mNfPhrjtPs3r6R2I1Oj2k2RMQC31NBJuHMm9BicMxp3PCPPCm+w8tLG/5DQ/h0Z/DrwI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2ImJ-00013I-Rs;
	Fri, 04 Sep 2026 01:31:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <root@fossjon.com>) id 1x2Im5-00012v-Nv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:31:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Subject:
 References:In-Reply-To:Message-Id:To:From:Date:MIME-Version:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D7myP7iHbD05ESff20V8XGGhbZZi6LfsHOIefnjBr2s=; b=R5Sy/VQ3o8yUtHg8k2JLaotbc4
 wRoBaQXHwwHfFsZ4ExZ7IRIvdv3AaSpj2B1TOwpt+A1mK+EH2hDNlUXgsxeZkfltdrSFk4hSGnj4r
 VZ9UzVEVHc8/X4TNCz3HQq0woXwQ+nJ1STGYm7R6A3TQD9TmCJyEMmGUEjs4IXb0zccA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Subject:References:In-Reply-To:
 Message-Id:To:From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D7myP7iHbD05ESff20V8XGGhbZZi6LfsHOIefnjBr2s=; b=QeDmznsrmvqoLqU8yZYznfsM1F
 4SkBWqSNhfREQKDsSERYJZ3tNGEyyq6m1t7xEyhIcVJJFi4810Y0B87YSGyEnEaTdPO/gHxJyYgwx
 TU/5eMzIP+qmoNeEGj8J5cAphGLjFgP6fnaE5gqgtx/+mWRIIeJYgXL2Xw3fWf38kDbk=;
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2Ils-0002Ca-Pt for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 01:31:15 +0000
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id EC509EC0121;
 Thu,  3 Sep 2026 21:12:57 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
 by phl-compute-05.internal (MEProxy); Thu, 03 Sep 2026 21:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fossjon.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1788484377;
 x=1788570777; bh=D7myP7iHbD05ESff20V8XGGhbZZi6LfsHOIefnjBr2s=; b=
 OFEVr/s0V7iqchi/R0tlkHn9LpytKcPTrSLSwETRYVmaVlWVjGpaJXXGvIm8rc2/
 U866NrVF166598WyRgnwgQF/eF4EDO9932wVHh0H0dXjcmce6+I8TmuRs0rfzQwX
 Iuhp4XJFIQNDsXOqvfeyLkkSzUzVawd/25UcCSWN2xPh7gvXOzpngOjmne9FXN/e
 lNWr9K3QO3o9qPWj7dh+7mupA8ymeZhdljwhto0LBpXivat9+97NkMO385ov5wbk
 rnWHngz1qCvfA6OaiuNaTikH0PgEuUaSzYur+ggdk4PSuhNZaY/OcYbmJSAfNxc3
 szb2huDPUAA7VMGMSZbmwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1788484377; x=1788570777; bh=D
 7myP7iHbD05ESff20V8XGGhbZZi6LfsHOIefnjBr2s=; b=UvYncWdDgNUhf7XLk
 SyhGU28i9Gwbc+0TxaEzqx+0A8F0+n8phetZBnctulRTgGWm1xBnK3CVOwuR2b20
 GyLeMKc4e9JB7E8GHTEUgogKlWFcjquEfNBVUfUUFSDDEZiGvcAitLH7qmTqV1vu
 +NQB2A6MFwQ5n/HLYOJJ1FEoIOqfqHH0CH0cf67GyLPH9os0tQnJCALOiZ8Ne5oY
 IfmKk/1kNP4fYuh76S8PJ+LAgvaBIicriUtoACoA7RqobP5Rl8asSsW0cumZVwUJ
 gSAfQmEqJgBA1xHtJZ+AohVdN/fTy6gm/5fKQcMxO+Y9d6ov8HLklQFxARf3iVxo
 2gt9A==
X-ME-Sender: <xms:GRuaatQlsIJ1jOCzywIZbPfuXkZI96X0fOT_6DvhpV4aU1D9CtGbLQ>
 <xme:GRuaahln-3n8Cl_HdIdd-0gUg9x96Q-vcZzaFs9bUbBB-OBugNqm6zCvUEcwxzqEo
 Au3xPmrHS0VdQQ0vAKLhARTh6ytBZaBiSsiBRPGg0H1TyhF2zg8wTYX4Q>
X-ME-Proxy-Cause: dmFkZTEmoL0V/8fr+TDs7Rm2VnTU+SbKOkouaiytlh0tqePcHFf65gmw4t2GsV9OT41dXN
 sU/1MxxGMpLAj0zhoYFuriacF93kUc89LB3Hdwoj6uJRPf5B/Dta7ZP31seWDEHzYXNFKg
 qoUBpZxOS4BY1cm435lFVUeBwdNRPZX0aEC3in1m6plZ4HVvlcopjgwPGFdKpUXx4MRtsv
 uml2XDZzd/nEuDp54bINgJhoNvm/YZPedEXczYu4M9QQRY81E5jmWNvD5hGjb7//MSk95Z
 HgHBWUxHAyLk3ArtSlACqvFBfOy1vFK0rLpxh/Ry/TN+DJgC5HIxcS0lUrigehRZ+pQPZk
 UBkN4QG7E5GbkOPyrrCUEFam5Umy5O4iSukVgm3yBhm2i8yGUrBeRKu9R1weotiSwCppz5
 a/LJVXaIH1byjiaw4EXG06NIv3U+862ZW4Jdom3KNwfHtd/PVNAP8ccMn9jKHupscPwSSZ
 qwuIgCEwzfxNNc39I2HiHrvK2thn37FF5e5rEwoph37Z4k4eVO1JdO5vJeqaZk0dO3sA40
 AaX9CArVEBU12FNGYLNB8UccnH8EknZ9ul+OTx2nDvSQH+FdPGJbBm3BiEmEuB7x9VZw0h
 5xWn0WJMuzALRpX8DP+KNLJ97HtB7Wc302oleIK7Rd/dOVCtPCss4ehkGaGQ
X-ME-Proxy: <xmx:GRuaav-pXy7dzPbw2cxkyDtY8unijIJP_OAk8oJdnsfczSPtd-HR0g>
 <xmx:GRuaaprEZLLc8wwQP63BWv2QPuIVTaipgwZKhdw_QA0WKZt4uoK_xg>
 <xmx:GRuaakmPSDEnhncaF5-EYQVkITo5ZQCHqoXdeCb541-VmLSZwYg4Tw>
 <xmx:GRuaaoKDhC-tdW_T8Au-odKUFevYQ8QVf_cyXYchQVX0RwBoUYzW9w>
 <xmx:GRuaajI_18f2XtM4WsX-Xmj69by3449OkmF569n5sPJkV9N8k5gg5KkE>
Feedback-ID: i961e487e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 8A437182007E; Thu,  3 Sep 2026 21:12:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AC6Y2XDLo6N-
Date: Thu, 03 Sep 2026 21:12:37 -0400
To: "Arne Schwabe" <arne@rfc2549.org>, openvpn-devel@lists.sourceforge.net
Message-Id: <a2a550e4-3c59-48ba-9aec-1f1172abab3a@app.fastmail.com>
In-Reply-To: <f9d9c8f8-c198-45b7-8825-747e9ce54fff@rfc2549.org>
References: <b200b1f7-2a43-4d20-89c2-a24a97fd3cb7@app.fastmail.com>
 <f9d9c8f8-c198-45b7-8825-747e9ce54fff@rfc2549.org>
X-Headers-End: 1x2Ils-0002Ca-Pt
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Apologies, I placed the dots ... on the wrong lines, I meant to put them after the if error statements. But yeah, I think you're right about that, I forgot and I remember now there was a part of the OVPN code base where it parses the IPv4 headers out but I forget why and what that part of the code was doing within the framework. So I guess bulk reading packets may not be the best idea also because you'd have to unpack it all anyway!

Thanks for the reply and all the work you folks do on this project,

Jon C (root)
:)


On Thu, Sep 3, 2026, at 6:12 PM, Arne Schwabe wrote:
> Am 03.09.26 um 23:37 schrieb Jon Chiappetta via Openvpn-devel:
>> Hey all,
>> 
>> I've been busy in life and I haven't had much time to keep up with the development of the OVPN source code and all the commits and everything (it's been a little while since I last posted). I ended up creating a custom framework for my own personal use that is based on the original modifications I did for OpenVPN (multi-threaded, bulk-reads, TCP-only, standard-MTU). I was able to get over a gigabit speeds on my wifi client with this network-wide VPN solution I have now.
>> 
>> I found these 2 new-to-me parameters for TUN interfaces which are really cool and I didn't know existed (I also didn't see them last time I checked the source code here) - IFF_MULTI_QUEUE | IFF_VNET_HDR. Obviously the multi-queue flag wouldn't work by default here (since it's not multi-threaded) however this other one is pretty nice if you adjust your buffer sizes to be much bigger :)
>> 
>> For example, I was able to read thousands of bytes of data in one call from TUN if you set the below parameters in C:
>> 
>> ifrq.ifr_flags = (IFF_TUN | IFF_NO_PI | IFF_MULTI_QUEUE | IFF_VNET_HDR);
>> TUNF[z] = open("/dev/net/tun", O_RDWR);
>> ...
>> erro = ioctl(TUNF[z], TUNSETIFF, &ifrq);
>> if (erro < 0) { printf("%s ERRO TUNSETIFF [%d]\n", date(), z); }
>> ...
>> int leng = sizeof(struct virtio_net_hdr);
>> erro = ioctl(TUNF[z], TUNSETVNETHDRSZ, &leng);
>> ...
>> if (erro < 0) { printf("%s ERRO TUNSETVNETHDRSZ [%d]\n", date(), z); }
>> unsigned int offl = (TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6);
>> ...
>> erro = ioctl(TUNF[z], TUNSETOFFLOAD, offl);
>> if (erro < 0) { printf("%s ERRO TUNSETOFFLOAD [%d]\n", date(), z); }
>> 
>> I don't know the full history here yet and am still learning but was this option ever considered to be implemented for OpenVPN?
>
> I had a quick look into what IFF_VNET_HDR does. And it seem that
> IFF_VNET_HDR does GSO/GRO and basically merging multiple packets into 
> one on receive and send. This works probably well on a client as that 
> does not forward IP packets. For an OpenVPN server, this will probably 
> really mess with the packets as it changes the segmentation of the 
> packets traversing the OpenVPN server. This will probably work for 95% 
> of traffic and cause extremely hard to debug problems on the rest of them.
>
> Soe this needs a lot more careful consideration when we could use this 
> flag as MTU related problem are already often present on connection and
> this flag has the potential to cause more of them.
>
> Arne


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
