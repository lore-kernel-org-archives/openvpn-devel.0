Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E150FCDE00E
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 20:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gW4FPCthz7acsuKlftFDic4HmlzeEyfCCtwqffW7pak=; b=GrkFIO8EXzS80TvczHgPF5bUk5
	sDGRNx5gk4JkxhTauy5I7NjY48A+ymXQrnbCFWkvTMB9lkpbILlyhofXvJxHfOtjahFuQiVFZDcxW
	3GPuQcS9QrsUEHnT6muXrqi9h7uzZa84Cjc+EIHvP+arJQKbK2kysazk3LeyJWbTX67k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcqza-0002im-Sv;
	Thu, 25 Jun 2026 20:48:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tnyberg@midjourney.com>) id 1wcqzZ-0002iV-0b
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 20:48:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+2A7+HpJAbncI8Dmvnodwi3wC2pLyEY5nQe7f8dfCKg=; b=lt4QM3Zt/cDOPrGl7O1opUOW3V
 qrnlFeDmFIVS2TtgFWLKlp9H9f1Qb2zUkfAqStKZJGpAN23XuxvPnSfWYTfPxq0LjOhBFUvZtoKLj
 YO8Z66RMtRc1P5TweBzPdKPywyUegQSMRlan8Rb6yQxEGBnSk8YE2mmhZpM2pCr5JJUE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+2A7+HpJAbncI8Dmvnodwi3wC2pLyEY5nQe7f8dfCKg=; b=HtpizVd2bN7gHXIF/Qu2FfSkPz
 IuKAJ7/s2tWV4gu85qggBc0Iq/hQ0W0BmiBGiCEPzxYdnsuzSloWywOtgzYXjpdNVVzcYD2lYLEIp
 Ait63KgxJlVaaEkB6SuypmE2j3CmVgpIW6s63Dkz0c+OLPdJBJy1fxXAmeqYYNn8FjdM=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcqzY-0001se-KL for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 20:48:09 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4629051c946so143482f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=midjourney.com; s=google; t=1782420477; x=1783025277;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+2A7+HpJAbncI8Dmvnodwi3wC2pLyEY5nQe7f8dfCKg=;
 b=YAbQhAq3yophQiWSZxVAASxq0M5VUJZqOu2NHm9HxEua3pm0ltzadN5NCW/RtVSb0a
 PphGV6aVGywD+ZowDFaB2aVusc326O37W21ySEllwWhbamKmd4y21pRL8oVmTmg/4Hy7
 AOiGNAj9J4loWqtI+XoCRw/J4+n37GWibVy77wm3g4vzpJHml2hEaPfj+sxyj4q6cV68
 N31Cp/kcBVPzakPUF/xgYwjv39J+13BxNdhLR7L0effvNMWd+olTuekbJowKCkWTvGrK
 VStykDK9q+EroUEYbCC/S79PwyC4//9SheEzIKqjRCy/2Rjt50hIBoynw1FR45WOqMQx
 LskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420477; x=1783025277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+2A7+HpJAbncI8Dmvnodwi3wC2pLyEY5nQe7f8dfCKg=;
 b=KBMvgrKcNu9wO2/7QyecXazw2MqyE4VnuEygej/Ld4qDt25xhWpxROv9ZrxOzXwMa5
 BoXr1RqG5ujAQYUwW9UR2Ph8BUAdeQvAuo9P/pqTkGz6OS/12l43orW2d3ZI3zhC0dly
 XzJFCEXsts81WzF7BZecmOvXvJrCBeADZ/DzugZxTJh+dnMShKDdOjjCrlz1J4j9o+vT
 V6YE/HmQRRO7//6sowlCBwMdxFsts8iVKa+lSs9ic2K80hxv9IIF2pU0yghnzVjaOih/
 8IB9nZupIsWE/384B8vsJfNpitEQ1Lc6OK3mOfUakAoSyG0qm4dlzfwPpvDhabwRD4BF
 Dcqw==
X-Gm-Message-State: AOJu0YxFeAS/Hmibf4sPaL/8/xkarQy2yGGrdIxleq7c9GKtSUhlihtq
 nTSMaHqnrY/7GJo3K5fY5VSciqyHMce0wZ5/DkePFJg6XgDCaZlKk8G1LL6qIKkH3vfYyNJGXq1
 VWmrgIDvDCA==
X-Gm-Gg: AfdE7cnu/Horbgd2QoF4weWgOumLqhYDgn20VgX/T8vJv0iRiG82nWRNqpOyy88q23F
 QerSUsktbKAcOiHXeYQyrC4cywqmXWvarwemZv1BJagIT81grZmrp2g7UJftUAEUgW6Lgar74qs
 HSXylZvUuabN4+JE+GoaJsai69DzggX+lNN669cz4mH6a77ukHfaYaBTDwUE68frTZBxXwSznUF
 mw4RxG0df/0+GINKQ0omfxFEuAX6ykSoBVWYbqjkunC1Kn97pGlXQNVbe5Zyvbh2zgukYOwuvfb
 FurRDwxOZdd4nzuis8C/JJ+wbDQW1IUM+Ly0uRlj3ckfonP8AvXzGFERFj5qX17nKVhyqbqIjpk
 5BkhI/Svn1zeJkDA9QB2sjuLuRICIPEf5HxHxqzTDJQIC04bd1yjDfM6ZqWcMjdC+l8+Rg+fCbE
 EfutoH+asD5a3Lfan9R/yBC2QwjUVkJvgGQhSUgDFeXC/pCEiiNUSsieDex+afphBNf1YUYVuSi
 2li
X-Received: by 2002:a05:6000:310b:b0:46c:aaa8:3ed with SMTP id
 ffacd0b85a97d-46caaa80672mr12557463f8f.13.1782420477479; 
 Thu, 25 Jun 2026 13:47:57 -0700 (PDT)
Received: from [192.168.100.107] (109-81-172-38.rct.o2.cz. [109.81.172.38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279bc77sm17927002f8f.32.2026.06.25.13.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 13:47:57 -0700 (PDT)
Message-ID: <69de67ae-e4db-45c3-99f2-36e8354af415@midjourney.com>
Date: Thu, 25 Jun 2026 22:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Gert Doering <gert@greenie.muc.de>
References: <5afdb852-eabf-4829-b95f-6a322ed5d56a@midjourney.com>
 <aj2LVcoBm4HVKF8M@greenie.muc.de>
Content-Language: en-US
In-Reply-To: <aj2LVcoBm4HVKF8M@greenie.muc.de>
X-Headers-End: 1wcqzY-0001se-KL
Subject: Re: [Openvpn-devel] [RFC] Backport request: 7791f535 (#919 fix) to
 release/2.6 ??? DCO peer-table desync
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
From: Thomas Nyberg via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Thomas Nyberg <tnyberg@midjourney.com>
Cc: openvpn-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Hi,

You know I'm getting the feeling it is me and not you who is confused 
here...

Yeah sorry I'm not sure how I messed this up. I was bouncing around many 
different versions of both the kernel module and the userspace program 
load testing it in different ways to force the different bugs and I 
guess I just somehow screwed this up? I'm not sure how Claude missed it, 
but I'm in the driver's seat here so I should have found that myself. 
Can't blame robots for everything.

In any case, thanks so much for the clarification! I will adapt the 
debian bug report I created to instead cherry-pick the commits from the 
2.6.20 branch instead of concocting commits of my own monstrosity like I 
did.

Sorry for the noise! Thanks for the info this is the best possible 
outcome since you fixed my problem before I even asked for it!

Cheers,
Thomas

On 6/25/26 22:11, Gert Doering wrote:
> Hi,
> 
> On Thu, Jun 25, 2026 at 04:06:16PM +0200, Thomas Nyberg via Openvpn-devel wrote:
>> Full disclosure: I used Claude for a lot of this work including the text
>> below. That said, I was very thorough in all the testing I've done here and
>> been careful to verify the bugs and was careful to read through the details
>> below. But I don't want to pretend like there weren't robots involved...
>>
>> 7791f535 ("dco: process messages immediately after read", fixes #919) is in
>> master and release/2.7, but not in release/2.6. 2.6.x DCO server deployments
>> are still exposed to the underlying bug, and it bites hard at scale. I'd
>> like to ask whether you'd consider a release/2.6 backport -- and, since
>> it can't be > a straight cherry-pick, what form you'd prefer.
> 
> I'm confused.  My release/2.6 git log says
> 
> commit e78a8af2f5ce5ef3bbfefc2dc8efeca84027c018
> Author: Ralf Lici <ralf@mandelbit.com>
> Date:   Tue Apr 21 10:49:01 2026 +0200
> 
>      dco: backport immediate notification processing on Linux and FreeBSD
>      
>      Backport the immediate DCO message processing model from commit 7791f53
>      ("dco: process messages immediately after read").
> ...
>      Github: OpenVPN/openvpn#900
>      Github: OpenVPN/openvpn#918
>      Github: OpenVPN/openvpn#931
>      Github: fixes OpenVPN/openvpn#919
>      Github: closes OpenVPN/openvpn#945
> 
> ... and this went into 2.6.20 release.
> 
> Can you ask claude what it is talking about?
> 
> gert
> 
> 



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
