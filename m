Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B45606A335
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iNStted+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gHcpbcTG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P06pNwRx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SXLM/H6v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=F5GC5FgoxWM8uIvr7NQopxZD4Inxiv3/goIVCbvuIyY=; b=iNStted+9dopipiH3RcRKTE+gr
	LginUcB1foYF0I+Gi0MkAY6SQNVIiy0maQlPsuhG+Ij54VkKsh3PdxyHVzIMSWWYvBywNU2ZMPlHI
	omRXNYehd/rmwd/zHT1nUu34fE9xtQ737tiBtpLyuUzXMfpGAvu7dOvOtbmGyCKToPf0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPLur-000000003T0-2k7K;
	Fri, 06 Nov 2026 15:31:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPLuq-000000003St-3aOG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 15:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aVnefLut9eyNyo+dgCC5jfopTvogFbo3BERaBNDJI6Y=; b=gHcpbcTGSt/ktNQ0PZQ+++TN2Z
 01UcqvzadWaM4gQxaBjn0waojsW40TMoP2R+EF7vu3hBrnuFIwQM3n7Vup5mNiPhlcOyaR3UA8bn3
 TeQAGqFrn/tx/suvYK8cEiyuMTrlkqbVclobP8jZT3I6cOdCyLaKoPqBsmAh+iIwzqGw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aVnefLut9eyNyo+dgCC5jfopTvogFbo3BERaBNDJI6Y=; b=P06pNwRxG6gM41SAkuyTQKMzxL
 xv90KT6N/V7ZmvGMnJSr+vha6n2oas3cevV9VzmXhgY2/fNiLGbwjOSSYOyMYoX+18wcp4oz3/atq
 AnRRKF5jkRzJrI44Xeajy3VZZSpT9O/wwVKJvx8fGrX+EqF60NyOXLtTdxBIRH9TGidc=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPLum-000000001Jd-22ch for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 15:31:44 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso689846f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 07:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793979094; x=1794583894; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aVnefLut9eyNyo+dgCC5jfopTvogFbo3BERaBNDJI6Y=;
 b=SXLM/H6vUo4M/OT7uQ9ZJ6isch27eF1iBeMa4u/w9Bx8G0XytqsuXOte6KanwgQ7hK
 8hoM1BOYGhwEcEbukQDBSSLHHW7xX2nRI3plFFaWrR/tqJkQNOWZgRBAFuntEnOfkWbo
 11pUjMYh33xjuWshWfZU2TdMOoLNbHRRaF++ecm+CwIOPqCaqkuCQwQYbYEzKoK8AWvy
 +ZrqsPgCrGHJuFZY7SzgZi0q79sR+g0advvPUf2WUYhDhK8ABHD74R66r9PuHaFzTuaE
 YlvAgFdNFtT5BxDLeQsOMnEhkpNiNb5CbcIzlrBpTMuupabij8PXWmRLjYP0kmng9+B9
 ytRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793979094; x=1794583894;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aVnefLut9eyNyo+dgCC5jfopTvogFbo3BERaBNDJI6Y=;
 b=U+rykk8ewcTzHkc4clh5TemL5SNhqQpwvQwnI41axet0RTcpZufGWkv3JOUiu4aT3l
 X9g7hWCSEzX0tg3wRXIXjmcWpAuUaGDy957c1mNi3iMNVAPunTgu8r8wuHmpT7K2QWSQ
 wD6l6Gphjc6A3p5bCps6M30bYrBcMyaCTZJ4uS64/PwZyKE6niu8tHSjf6EI9WiyUJYv
 bflxQV1d7pxqj2kaljwzStYStfBG8wroKu8LDiWNHg7antHOO/40bno38s5CD390QmaZ
 vsRNN4TReqo0YWB9UyGdpSW+kGFEyNb9SkMZCdyVGTQpYlZJqnOzf1SxWesRFGAiJJoT
 i6NQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE9aLysHrF3ynWI8hVKM49HyClp+mN8TRM6EfWWyllgLStb/rYnuY9RZU7Wpa+7stlAufCbshKodNR5o536@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8cSBQ9M331ws4fD4KvLP+JqCatX9QuDHAJ+m3YxCqthY/vzEdH
 AcI0oPosdWiH77TQnJlHyzdxzAUkMhXXiVZSTrseE5TESFXm1+9yFHfK7e+V7YTm6MoK3/JSc/F
 uBVuQfNWPVk4yhlNMtnWRCubyVDkfWFWitXK+89DknlfhAuNBJJ7uqkeS/kSPivLHq94T
X-Gm-Gg: AYBFou3Js3DWd0mdZAjxHGE1br+41ivbJDJyXB0OqvzBy9MsMEl2fdzcfiOyPciieds
 kErhy2/dJd8gqjklhGBIfKrNc+c4HjRgBksGDcGcMSenGVIr8YSJUM6vR2c+BocxZPv+FVfUB3s
 M6zqM7n18nn1ioC6PkVCuq5C7HRxSEZLm5SLSUpigTyFDU2jUa3pMALRwR6hNRdkB1Sjh47jVpz
 NWywIsHScccEr1UUObT7RskQNKsHo5ILDjRsAdCAMRqH2WwoVQhWH1GA21KEUpwW6fX0pPjPlt+
 7fSDy05Uh7u94eXirdx3OXmRCfF4UrhnXUCT7TgO6XN7a3KzmX1Vt1SAawminpCFpeA+KcWcTi7
 TxZrOv3oyZfFn8SlUkulfaI6mE2F1XtybzbvcU3hqgttO7f9QalEEgJ08EWjCR6rzQtHKLSBiKP
 JIzVxToQdPOBDQOr084pMSVxwPlChenGYOJdnA2uf9qKsvhys6dzTlXJcFTUZ91tAQfD9DX8WkI
 A4FVV1oXfzHu5KSETE+CRgcpk6j48ENjbR+SFrbLvc4qOxwBVzd2B64reGsLiLbNrq5Y5Sc3oN/
 KEePkDh07UchB+lvUcc6Uk1QbebpCebdYqFF/Vgd+IqOodHrMT56GSz0n8I8BQFWE6u2kjumOsK
 tySxIOB1jdFqULSpqrH+YeoMVlCl6afMLBxVCzFWV+ETK5wtafjSeA9gZE3qWO5xDrLkXDiIrAd
 6SmolGi3WKo09VJQ==
X-Received: by 2002:a5d:6f0a:0:b0:48d:dfff:fe6b with SMTP id
 ffacd0b85a97d-492760da71cmr6436799f8f.34.1793979093751; 
 Fri, 06 Nov 2026 07:31:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d837bce2sm4502073f8f.55.2026.11.06.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 07:31:32 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 15:31:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675
X-Gerrit-Change-Number: 2143
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2143?usp=email>
X-Gerrit-Commit: 6579489bd3a3b39f9e153ac50c9d01887c9811a1
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 15:31:29 +0000
In-Reply-To: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
References: <gerrit.1793955112000.I7c9e123a458b9d3757e9de93f401e4e421741675@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTU1MTEyMDAwLkk3YzllMTIzYTQ1OGI5ZDM3NTdlOWRlOTNmNDAxZTRlNDIxNzQxNjc1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <27e4717acb898509818104d18709e2425b106bc6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPLum-000000001Jd-22ch
Subject: [Openvpn-devel] [M] Change in openvpn[master]: comp: share the stub
 compress methods with LZO and LZ4
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0831615345094496429=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0831615345094496429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2NKgCb08Nt0="; charset=UTF-8

--2NKgCb08Nt0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Demail )

Cha=
nge subject: comp: share the stub compress methods with LZO and LZ4
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
43?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7c9e123a=
458b9d3757e9de93f401e4e421741675
Gerrit-Change-Number: 2143
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Fri, 06 Nov 2026 15:31:29 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--2NKgCb08Nt0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2143?=
usp=3Demail">change 2143</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2143?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I7c9e123a458b9d3757e9de93f401e4e421741675 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2143 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 15:31:29 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--2NKgCb08Nt0=--


--===============0831615345094496429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0831615345094496429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0831615345094496429==--

