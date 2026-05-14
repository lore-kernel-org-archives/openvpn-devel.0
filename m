Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2D7CD37AC
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 19:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7dWOPo5we0AcfRvN/OTEQJOV9Yf9WW94qEjTM7+GKRo=; b=ENEydfFu7/1yPjp1oSk2mkyjgo
	0b6/ylZCM57LDA/xUqENcDATEQ7W3lrmPqmj7QAyfqYhbvgdcPQMT4GXNtUXjwdOo0+UHJxIORZ9g
	p7aM0OOAYsSjcngwnd95a8nSrJeqjTPQS20ZB5CDJ1LnxCKGlup4zRFIwNTQ42L0ZSh0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNcDL-0003HI-4o;
	Thu, 14 May 2026 19:59:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wNcCy-0003Gn-5X
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:59:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MMk4sTWVk06BoZiw3tuOQEbYxblz7iGoyWg9ResQy/M=; b=jziTceEgkd+QZ4zT4aQiv2Nkwi
 t3VtC7UvQSwul1PdkySMmPSuNRdRro86mBxC+QmxI7hKXdwDTa98xY0F231m5iMLjnp2jQk5EsLDW
 0RtNYOV72IJ3drkci5bh0BdSq2q2idSnSmVR9blSyLx19B8l/FercsdXFRRGlpzFpqog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MMk4sTWVk06BoZiw3tuOQEbYxblz7iGoyWg9ResQy/M=; b=Bvs6KhDhg3IsUqZFM7+H2/yrN+
 YwNmxC9YzWXPfm1ytdrMbJHxJT89WtG4oJHYyQBjMJCN8VYMQ+sribFLvQP+BuNrDPAmo4lx8qF7b
 wa9yxAIPFJYz7SeA2x9uUsI+3Gs5R/v8CROye3D50tTHPUNnsa8URDewUBO3404w6lCo=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNcCw-00084K-Kx for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:59:00 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gGh3b18MSz9vM3;
 Thu, 14 May 2026 21:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1778788731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MMk4sTWVk06BoZiw3tuOQEbYxblz7iGoyWg9ResQy/M=;
 b=yl5774aQ6HBODTinGTvugztKZ7qhrvJOpbiGZubdmRhAdR9CyTzIMO6Si7Lqr1pXT+APTh
 G27Ej/hFCZtlKMuNhwLuS8iCmJLran2wUKRWHnZh9SByJ6AR9c5IxLBd4SUDzxlG0vgRoL
 I4E1tNYfBTKCBdSf3Flh6XCXwZrVt0LkbJPAYRIXCMq/HjgPZP3MRm7vUMKnT8f31gZVRw
 5pL1PE48qf+ypQIVh0S+f6FkTsOK7mzVfK1jZJJOklX7MK1AkUyv066KsgWKGup/vzODhv
 Gm2gsqQZMnZMNBI5oISjZ/LS0CYoimN38Rstx8ZIj5ZaUYEl51cDzIjU7DcrQA==
Message-ID: <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
Date: Thu, 14 May 2026 21:58:49 +0200
MIME-Version: 1.0
To: Piotr Dobrogost <2026@p.dobrogost.net>
References: <CAA6tFMtd39GY5m+EjRKMxG9gbGwt4ENUW+oD6Mp=ytV-RuZ48A@mail.gmail.com>
 <749b893d-bb99-45f2-9205-ad5f4383f96e@unstable.cc>
 <CAA6tFMtxUHFtcyDY6hLSHCyZRSvx-BckF3P7_CgY3Q=qkyY0jQ@mail.gmail.com>
 <d7bd1d3d-c9e3-4f4a-ba75-0fdccb5006f5@unstable.cc>
 <agWNa_czBd91yZ47@greenie.muc.de>
 <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
X-Headers-End: 1wNcCw-00084K-Kx
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN tunnel stopped working
 (no traffic) after upgrade to OpenVPN 2.7 (Fedora 44)
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
Cc: Gert Doering <gert@greenie.muc.de>, openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

On 14/05/2026 21:53, Piotr Dobrogost wrote:
>> This (and also on the local LAN interface to see if they are actually
>> getting out).
> 
> [miner@hostx ~]$ sudo tcpdump -i enp5s0 icmp
> dropped privs to tcpdump
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on enp5s0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 21:35:04.694647 IP hostx > xyz.sfx.pl: ICMP hostx udp port 46099
> unreachable, length 141
> 21:35:05.718684 IP hostx > xyz.sfx.pl: ICMP hostx udp port 46099
> unreachable, length 141
> 21:35:06.742366 IP hostx > xyz.sfx.pl: ICMP hostx udp port 46099
> unreachable, length 141
> 21:35:07.766012 IP hostx > xyz.sfx.pl: ICMP hostx udp port 46099
> unreachable, length 141
> 21:35:08.790908 IP hostx > xyz.sfx.pl: ICMP hostx udp port 46099
> unreachable, length 141
> 

This looks interesting, but please don't filter for "icmp", because on 
the uplink interface you can't see what's inside the OpenVPN packets.
So here you are filtering for "outern ICMPs".

Please rather filter for "host xyz.sfx.pl" and do the test again.


Regards,



-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
