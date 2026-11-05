Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610F606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EMAbLaPo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZBhzvGPZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l4E8uuGQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T2ohHKbe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Al2Sp8SBMs6pHJvxMPLGKlIw329bc5tHOLzRa0kCprs=; b=EMAbLaPoUKghZt9FlIS6/Eieng
	mjvG9IBwVxx7WJTd3PN2wdiivpD56Tj1gi1gZe/lUQTPafavwQi5Mel3WXtYcTZBFPrA21+SBVzYe
	CthlBCaIw54gZ6HEFdNjA4HC58Dl7l9GT4AJyDfzqcjAzWfK/eNXvmSdMeBrsl/EN5po=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOxh6-000000000sL-3MBY;
	Thu, 05 Nov 2026 13:39:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOxh5-000000000sD-3Wx0
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CCRVrsKtfukshZsXXaxGBFc1+OIZ5RfvABrWPtUDYEc=; b=ZBhzvGPZM1DsePwjAN826rTYU+
 LdwJ2OZD3lN+aOh2OwD+rsbHvIFtnaW8sjbIaEv7CtJcQtYeuVZB1MnjabInpBXZ3ZpwERgbsJ3Bc
 8YPzQ2c15XBwWp4heuHBih1u+bbsgZM9F0mKFydFFYdGHGxUTrlK77ISqb1LLVPgX14w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CCRVrsKtfukshZsXXaxGBFc1+OIZ5RfvABrWPtUDYEc=; b=l4E8uuGQjpAF6TgKDoFec5Ay3F
 uiQjVxv+78wZqTl+z+bTEDh+b9kgkkIijsGas5PtrazcJdnCZe0wnhDTCH0MzyVa5Mnz4fbuoivJ5
 09GuQJdtuiYdH3Qljf+Ot3mZGfjmGlAiLhE3wuBuz2pzEjwQUMWhTdHcx/iQ7D1BYMBQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOxh4-0000000055l-1hX4 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:39:55 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so17390265e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793885987; x=1794490787; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CCRVrsKtfukshZsXXaxGBFc1+OIZ5RfvABrWPtUDYEc=;
 b=T2ohHKbekK73jukD+l93UVunL65RXUUt1ofsMyJFXgtIgfrOLjPEljoLho949Fa3gh
 RPpgqMGuXKAf2vU8/MX3Cxf/KN2Qi1HYe2Ut+wwEwkYPA04FeRQTmLpwmUd26d94bqCy
 p/JBpf2fChFaDyqDYz1i+WlnjUoh/JlLOEoh+c4yB6498UiayvE9IDamIiRYqZOHub9h
 GSQljYnIueFnpqhDP2k0OG7wfM1D4kBUabG36e4QKsB8fA8R6a5+0s7Hd3k9ejuDJB0N
 04p0LqjWhMDn+stPiXTs+tfH7K80RMOrp3jostl0O9wsNVX1OUdAJFZB9/q6TnHPzKre
 KfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793885987; x=1794490787;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CCRVrsKtfukshZsXXaxGBFc1+OIZ5RfvABrWPtUDYEc=;
 b=RX3AJmozwCuSHHHVzbzmzsSArUhwqUqdDExhspMImx0K2JlhTqE6zIPdy2ksxFGGBy
 ykr3hDQ4NOXnGlC7HHVXTvZCJD+DMZUGZSUcBsXbmMhqDnPQQgE64S32XLj2GNz/sWQ0
 x0DktGpI0f8Z5cMKIwpYNsQti0Y1xCAFYIsW9z+8NqEh+Higtpe7patUWwBCMYcpPgVA
 kpIvUBlrjuTMzKFENJoV5OekvEP46jeAx2cxEP9eIoFdShidtlHkm23FXmlvC7p+tp78
 pzsczBbvQKWo5Uba5f65mDny/9ZNyjul1JMVlFtRrq27dWPUnvwDrnFZGMAikDJy4wbC
 qLAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxae2iCN+xkZLF9MsnAlSUi9uM+NrynsmBa61Sn9Do8Wb5o2ujgnd1kwfj0x7LKQfl6Lw/B7ZGfPmRPZn91@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9hr+rlv/JcbQ0qZshAQ5DHKDX+Xktn8rBbUtOQTcM460EBTkFB
 h2aYGIO1GP/yrIv5bjKxsykyKiBeXTBhKpMetnZZfO3Jo02bzHq26eBSWMNx4SCyQIgImNQCMdV
 KiA5q1p+dXMtjx2rtChVuThqcS6OpWjsl9UC2w59zBwy0DjwvF1c1IvtIgJU9WhsHjNVaHs+IRC
 bfkrJTSw==
X-Gm-Gg: AYBFou32IviEzCEGNuxspd/MdZvdT7NBUTfDWSEPIFCVbStRSiEQ7pLj9r2G4c8SoBk
 8TKlNhRVJuMEIWNFG2oizjxBnkD1tqf0nYS/FYS+M2pHGzbj2ad/Gn1uO2n/wJRxeZ2xK6F3nE0
 CLKICiNTPJ9Rgxn3fbn1X2wwIbbnwdug4S6WMoDoOl/ordoi62WofI8llTCzFA5PZGvbHYlW8Vp
 5tematKscAZnUFQDJpz98S2v3GTP5rHRD64M4J9j0kJApgiYrzzGVug76QbqPjSiatdpoiW3PfB
 8m85Jfxem5ZqFPEAXwboFEhPdhwymIz9M2QzcgheY5XWKN9t9N6xteqvWVXgH+xf2QP18XFPzNJ
 Nd/8jMb40Fufm2kTaP9oOs4blV9eW2q3Q5893zP5WcAACy6RYeY8owbu3KBVbnmFjcuL4V7czP/
 TM4ah0ug6rtKFiN0PEbTPuLBM/79JyODx+m/BjZ+2zi/lwXP+D8h8pG8DUrCAGBa7rXtLhuUpPq
 iKgl3s95lBNDHvHy9VD9xFEQzZb6mHBZ/x/qrL378wdcxiGSDp+mnRSTji1RymFs509mLp7XbIH
 IBTsvZnwi3OU7FKk6xjzecY2hcNbfULWh4+IyEfo3u5QOfYrrXSRsqymagqK42QxZsPvO5F5lcz
 UtabX8eke1hWuCRpav2l2P0r4k0fTo4iGBWswUmBqXSExDk7bjbTAwarLs+IhA6utp4CfjEyGfV
 kA0/aK2Vgzd7B6Gg==
X-Received: by 2002:adf:e001:0:20b0:48e:d88:55f4 with SMTP id
 ffacd0b85a97d-48e6e2bc855mr33625794f8f.2.1793885986414; 
 Thu, 05 Nov 2026 05:39:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed5538basm9746006f8f.44.2026.11.05.05.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 05:39:45 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 13:39:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 56f107a0d912541dcb20f932e82fc2668c3fb01f
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 13:39:42 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d8ebc4848f793d18a1d153a044ec5eefbbc840f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOxh4-0000000055l-1hX4
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1669392292424753984=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1669392292424753984==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9yofeZZdSbk="; charset=UTF-8

--9yofeZZdSbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici=2E

Lev Stipakov has posted comments on this change by Lev Stipakov=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change=
 subject: control_msg: Add P_CONTROL_V2 and the probe request and reply TLV=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 23:

(1 comment)

Patchset:

PS23: 
This is now rebased on top of oob-grou=
ndwork series (3 independent patches), also chugly comments are fixed=2E


=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d6=
22a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 23
Gerri=
t-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC=
: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbi=
t=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date=
: Thu, 05 Nov 2026 13:39:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No

--9yofeZZdSbk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici=2E </p>
<p=
>Lev Stipakov has posted comments on this change by Lev Stipakov=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1741?tab=3Dcomments&amp;usp=3Demail">Patch Set #23:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This is=
 now rebased on top of oob-groundwork series (3 independent patches), also =
chugly comments are fixed=2E</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1=
741</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipa=
kov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ralf Lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Nov 2=
026 13:39:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</bod=
y></html>
--9yofeZZdSbk=--


--===============1669392292424753984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1669392292424753984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1669392292424753984==--

