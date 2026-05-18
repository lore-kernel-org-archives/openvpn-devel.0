Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4E5CD4F48
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 07:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dnF8rcOneovqn54BuBslIXyWxxtG+QEdjAgi3r4aZaw=; b=TFCzEfEsda7za9K4Xr96XIJtIi
	p323eymjrl6nB7NjOldjJSM1P5pRab55IoCPLajiRgzhulH/GIK6zRhunT+Ka9h+EfIG3XZJihqGv
	OswaveaQJKkx/SwXkRs75p58/8qOS4osaG7komZzoG0xtfmhhDbKDnGgLl2THdOL/GpA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOsIy-0005J6-Lo;
	Mon, 18 May 2026 07:22:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wOsIv-0005GU-N1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 07:22:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Un/QTlq1LuAJXytlFcXIdligMrebHeYt8vDzORxeT0A=; b=YEUjrYoX5cshK47lV/KRyu1SGB
 6LbJVk56Hk79u1ZODIvcc8mpQTCy7vfLHF/cQ/hLAp0gddxjH+/g0NuPZSi/M69el2DoCRTbmfqGM
 CBd2cKa08vUgI38JDZSoBZTqZL4rw4zMrg1aG24LYUmhf03sOCAN4AYx8N8ZJ4qMVTgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Un/QTlq1LuAJXytlFcXIdligMrebHeYt8vDzORxeT0A=; b=YRNmr1NhiNoqITJmFPymBiiADE
 9eErZ6cazBPr3jiHdcddKD6mhKqNzlBk0/lmz+yJqlTkii2DbYD53s1qAX8N5/0SJcLoLijLGD1QV
 6stQ/APuQlGpjAM/0jac6jBN3R1d61P9gMSLEY34sjWL4xO8Pezg47k6WMKClZlIFJ2I=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wOsIr-0000em-1h for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 07:22:19 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gJq4W6fLgz9tg3;
 Mon, 18 May 2026 09:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1779088923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Un/QTlq1LuAJXytlFcXIdligMrebHeYt8vDzORxeT0A=;
 b=CZtfczO3F63ixrJnXy1sQZIqGk8ik5SV3e6GgSlv8fx1RuYlSIipWs4Ha5pWcyRWIpkJeF
 pADsQbIy7CPYeVImPRnt8tjzFmZ5CSPe4FYHIkAmx93bQdge8fXIRJPVwbU51+VGGPH1jO
 jvrdFQqlp1YrHddP1ggC/BL1GeeMPDm95htMM0UcqVdZDFt2sZVOTQUradk5r0ql1PKHL/
 gmMeWcnKzp6QHRpRXg5HOXfxOziUjS1AnCf0jg7hO+qNfBZlLZAwThKDvu9A8PR2fj4siZ
 Dxka4uvkrWWq9983NjAeW7WWV2X6FnLyz+LVKWQB020i5XOTE/aZ7Nv6RPl/hQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of a@unstable.cc designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=a@unstable.cc
Message-ID: <e519fd93-d75f-4422-b7b2-8860b510595a@unstable.cc>
Date: Mon, 18 May 2026 09:22:01 +0200
MIME-Version: 1.0
To: Gert Doering <gert@greenie.muc.de>, Piotr Dobrogost <2026@p.dobrogost.net>
References: <2f645b45-0de9-4264-a386-1a9541a36478@unstable.cc>
 <CAA6tFMunrvac7ZZHO6ZMnR8Mu2J-OAmP1bur1GsnyS5rCv7arw@mail.gmail.com>
 <59ef0fa8-56da-4f6f-8f1b-360d74203f8a@unstable.cc>
 <CAA6tFMs=-_+-u82rEbfSLoBf6z+6MhZh6JkdMK=ddAXewycnwg@mail.gmail.com>
 <agYtSFxVCjCHwyNk@greenie.muc.de>
 <CAA6tFMs76rT4iHzwy0FSn97RT2Hva3VbTHOVw-FPLV_Qz-00_Q@mail.gmail.com>
 <4e82cb26-201f-4a11-bf02-faa9aaa45c84@unstable.cc>
 <CAA6tFMsXEvMBr8n-x7N2aZwrn-jTfvHozBjHbRKA8tvAEFeayQ@mail.gmail.com>
 <aga71mZ3jRgl0TEA@greenie.muc.de>
 <CAA6tFMuzF31kpzB5j7pRTh6nC2RRSwBkTEiFLGu3XGOvYgb7mw@mail.gmail.com>
 <agjUFRBdLyfZvlWN@greenie.muc.de>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <agjUFRBdLyfZvlWN@greenie.muc.de>
X-Rspamd-Queue-Id: 4gJq4W6fLgz9tg3
X-Headers-End: 1wOsIr-0000em-1h
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

As mentioned by Piotr, the port unreach messages are very likely some 
residual from a previous connection, where the client is not active 
anymore and thus rejectng the incoming packets.

That also explains the different port.


On 16/05/2026 22:31, Gert Doering wrote:
> ... but at least some of *these* are the pings - and unlike the last
> dump, we see no response whatsoever, and it's using the correct source
> port.  So whatever happened in that other dump (ICMP unreach) is not
> happening here.
> 
>> 18:06:20.550251 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 105
>> 18:06:21.355157 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 97
>> 18:06:21.362815 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 387
>> 18:06:21.541736 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 108
>> 18:06:21.550201 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 105
>> 18:06:22.137235 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
>> 18:06:22.137443 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 92
>> 18:06:22.565714 IP hostx.34701 > xyz.sfx.pl.openvpn: UDP, length 108
>> 18:06:22.573739 IP xyz.sfx.pl.openvpn > hostx.34701: UDP, length 105
> 
> ... here we have quite a bit of bidirectional chatter, which looks
> quite reasonable on the outside...
> 

Looking at the timing, this pretty much feels like the ICMP request and 
reply going out and back in.

If Piotr could dump on the tun device of the server, he may indeed see 
the ICMP traffic.

> So, to be honest, I have no idea right now.  I did not look very closely
> at the OpenVPN log (it's late), maybe some more insights can be found
> there (correlating time stamps).
> 

If the above is confirmed, it feels as if packets are being dropped on 
the way in, but there is no indicator as to why or who is dropping them.

We know that on other F44 installations ovpn works just fine.
So there must be some bit on this setup that we are not aware of..

Not sure what it could be.

Piotr, not sure I asked before: could you check the stats with 'ip -s 
link ovpn-sfx' ?

The dropped counter should increase if it's ovpn the one effectively 
rejecting the packets.

Regards,

> gert
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
