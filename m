Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFB9C44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HsMZaIFrJWH6qPbY8DKfxkLf7k7a2FNDfYxvbf28Mr8=; b=U9Qtb3iBgeQejso84yAp66k28b
	kByYErYk5Nz3oyl81WKarg+2JgZBlDy5sNPb6kBrhpd3ijUWHX0E8AzM6lWA71cH6D8i1J4gV3V3G
	rOlmu3TntB6jBvlQD3QfVYAMpnRNF013WRT3GyaQ3a+X43p1FzxXsUBcIZOWQh57gWwM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk285-0008Pq-Ep;
	Wed, 15 Jul 2026 16:06:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk283-0008Pi-K7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 16:06:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wA2BONH9G8QeQW/4Wdu9mOkKXVUnHJRsq3sLaP+G03E=; b=B+tb8VNyUpP/7URfNHF422yu5s
 AYTnR8ZoBXZTAvO5oCltqBDqgbkaHOGjXjh5o/MGtdV2wxF7Q07GTgknOdHye7pjAz1YKTwz8Phop
 kmgZIQ9ZXsfOj0KS6WsjeZUOWUssJswOINM4+RONZcCF4JvAuEgaFKGxAxUi4xA1vqiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wA2BONH9G8QeQW/4Wdu9mOkKXVUnHJRsq3sLaP+G03E=; b=O
 8gPXz+WGedPZvoJjPqKmjfcXVtruRD5gSrWPdyFTVcC8+1L2dpuBjAvPm4TDNcSuceYudgcHblNdD
 2dYEK1319Ipa95BG5yzBWd7BGZgs8b5jzBcbY0SKSgBB/n0jddu6r0qwumE6XQD2yhibTCBE36LTp
 PdUvbb5Eo0HBeAvM=;
Received: from mail-lf1-f46.google.com ([209.85.167.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk27z-0002Rm-Cr for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 16:06:33 +0000
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aeb2bc82ccso3021937e87.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784131580; x=1784736380; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wA2BONH9G8QeQW/4Wdu9mOkKXVUnHJRsq3sLaP+G03E=;
 b=Bm51zyw6wY8IQPhE8rbkJkF+Ka8VI8W6afdcTjzAcGg7pB3sg8pVPimkowFlWSPnwg
 vPP7QG43x2GeOmQ6l0IKTjgPOQNpuzze/Vm7lkBpCwMLtDnQddBEPCqNSxBa9h6gx7rK
 1Gi7cQqBUqHfsHxGbu1LnJaZHzFuxv/KKlCLXygkthZRVoXaNcfRjNcQC6swpdC+4lm2
 HxHjf19EqRlAiPNFI1VzseepEaR+8YXwMv8QUZ3WzSo662dAWoTDk8U2lUs0lU0Db7i8
 lvdESBZO3rBtiPcjMj06rVbGk/orS+XBzjsmsM+j34Sh3DJ6imHVjWfFZ2EQaXa/fUCh
 ezwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784131580; x=1784736380;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wA2BONH9G8QeQW/4Wdu9mOkKXVUnHJRsq3sLaP+G03E=;
 b=SRs23dWKInL960RPDareD15anWjIh1boPP8svZyxA+Bky5OT/HyXGU04UG3hV2WA58
 WUWui6uGr18YNK/YiS4f/dgOwKNw675CARqajIx1oCS0uWzROMC2dFTCpAQTtMnZfPhX
 Mt5nb5DmNJsiP8TGAfYclsi2xp/4vQKMOJLdmNyE020/GcFJRexKasYg788e7bM6+Klz
 DyEBzDt7puhjg+1LwoBu9eBSooRp6MGDvfXRloPPLTjnDTsmlhIGK9n18nb8YH9GSK2x
 86RKCL3XmmORPO3mgExNnkA7+IYpd7JVlRQIVzRumfqHvhxJ9RMnU5L9MeZF7obNLQDy
 YcBg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0DTnh0V3uJdpgJ/xPPdBjHgkv+XeK98dtErzI2s88D2pBUFguoh7gGPpb9Gyc/45onsixxJWPx75uz/Hv@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzktYYRUh9pkSRq/vwuFX8dwvzohf2Srd0WtDCaeWVEA+/j9oYF
 kPa1of5bToRSGXyearLDPyJr1OQ7fUAirNxe/1bMaC2Alz24009QuVCvWdHcWZPEAnGJxqEtkxU
 s2vGAvCRQJ5XlYZ7i+o6iiXqkeJrl6pJbXQmS5Ru6Q8rCI/hCJYZuHBEqI1/klhTTPohGgO/Tqn
 qh6esfxg==
X-Gm-Gg: AfdE7cmTeUvvWbWlGgkFoCnBUZG102p/9zS4FGl6jhSCmY+5GzQ0lTZDhdhYDYRQmyo
 ik8E0lzTXD2oCJ7+8O84gAKrqcim+t7BH6G9gT4DwJtcu5upQ9q1EnATB5FdH0NwoLiNk22eGQh
 KOM24aGdYlCyYZajrZ5LlhHkdfMJeIc0Xgse6F1joqMFtq0eXMjoVBXZyvitwmDCXiQfAzfSHvf
 kSBY6N588FJlNmbaE1pAj+KzJcVZwb7DdIadzP0s9dhn61e7yMpdIFQNFanshGEJu2Y9/wfTmXw
 0ADbuZi9xnfN+vqVsFN24qGmXcvHUqvKE+fvCDFsnngc+NnGKb4yOGowGHcQczk9mfuWdTyNxGH
 40+mE811r6Xlk8l/bxyy2KWIgUbzPHyjC6vZ7jO1/q0UUfYXawqs4xJYl168hYN6AFVr/eu7Xyw
 ny9l5iFMpjjY8A65BMi3vFix8PlNj3qDwF4uTy7m3iL7zmXDGmT6VFVvt5q1/yNB3/EUZtmWjYM
 ud42BuzOn4a6liFJP1irFsHHRKmBNwo5/X5zkMJvwxd9+Td4Lha/nBiaJ2raMCOXItSS3c8GOnX
 llw=
X-Received: by 2002:a05:600c:4504:b0:493:fbc3:78c8 with SMTP id
 5b1f17b1804b1-493fde56da1mr149026575e9.38.1784121859291; 
 Wed, 15 Jul 2026 06:24:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495087366c0sm274475935e9.7.2026.07.15.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:24:17 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:24:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I087cbccc9b4a994376aa2d2409509a2307068899
X-Gerrit-Change-Number: 1784
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1784?usp=email>
X-Gerrit-Commit: b180e57b096faa86e9821d68b0bf05f9ee15f42f
In-Reply-To: <gerrit.1784067448000.I087cbccc9b4a994376aa2d2409509a2307068899@gerrit.openvpn.net>
References: <gerrit.1784067448000.I087cbccc9b4a994376aa2d2409509a2307068899@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkkwODdjYmNjYzliNGE5OTQzNzZhYTJkMjQwOTUwOWEyMzA3MDY4ODk5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6a9397f5291b83cc383f22666e11b787737f58c1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk27z-0002Rm-Cr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options_util: move
 subnet_pool_by_tag out of multi.c
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4352630329552707200=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4352630329552707200==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FWE9UIILUU4="; charset=UTF-8

--FWE9UIILUU4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ordex has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1784?usp=3Demail )

Change subject: options_util: move subnet_pool_by_t=
ag out of multi=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Abandoned
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1784?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I08=
7cbccc9b4a994376aa2d2409509a2307068899
Gerrit-Change-Number: 1784
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cr=
on2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--FWE9UIILUU4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>ordex <strong>aba=
ndoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1784?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1784?usp=3Demail">change 1784</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1784?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I087cbccc9b4a994376aa2d2409=
509a2307068899 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 17=
84 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--FWE9UIILUU4=--


--===============4352630329552707200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4352630329552707200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4352630329552707200==--

