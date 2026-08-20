Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55447C5DF87
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+gmrr538UZRDf6xONmn03ai3Y15nuYeNZz0HINAo04=; b=KE32hakoovAa9zufjCVR35U7jy
	x2uAuEq4McOqPyUhYjltSYDmFr5tRg7S9yKU1ZTJwKTwjIKHZOvxbXHWbanyyXGRlFxH+zwOTaNxm
	wCUXMRGB4w2jMiquiVN9EH5e7ttM0OtQQuowsjT44hLPpCT0yaqcZW9YeAEwmWJArMzM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx017-0000oY-Vv;
	Thu, 20 Aug 2026 10:29:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx017-0000oL-3t
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3eSOzIVdepcf8vdoVa44O5W6YBcWHFGcKQTFHA33X1M=; b=k+0C37ccRV6tIyAIKy4WPMKF+X
 ATgJYhO/84tpqfry0IPC16SU0xwObJDko5V28Z7kRg2NQoHYKmf5s4qMLCE9XMEvyaTpTC24DfYHq
 /kibmBIMrRN063oF8DpcYlW3f2IzFf6/TXW2geVcNoWrolojOosmgdnuM9jJmL3VDQS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3eSOzIVdepcf8vdoVa44O5W6YBcWHFGcKQTFHA33X1M=; b=j
 twf7jnDe3lMiMyNr7Lsg0hkXYcev8kc2OfQStzkxAYZ4boX7S+qYNhrc4JR39VSKG9+lgiYGsOshy
 twWisCqMJKkhOE4PrsKSrqdYrdqcJtAIJab6ZJkfoEKlmZSNgoEOxc+QlH/bB4+ce8BgWgu07rxAE
 iUGF5QZ3avI/Szgw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx014-0003kk-TU for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:29:01 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4998e0916faso16128815e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787221732; x=1787826532; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3eSOzIVdepcf8vdoVa44O5W6YBcWHFGcKQTFHA33X1M=;
 b=NsqkVbpfkw/6Nv9JX8wQEJh1B8mqWYxs78j4mUGG+/t0Je4Z+u29zQ0fjh6ORQAItM
 RXtBYu+pXefXzbEyb3b3EbQSV0lSco1iJSAyNuRPicnhMg1OGcbuO85h+K+THtgWITd2
 bs6nbZlaqBBSk25dsbgQxLfM5qHf7LvsMzd2B21UF5LAfoh7z9oOTEQtCMo3hu0RA5qh
 MVKZalUMHQ6+jP7QUrfujYUcH2HpIpRuqXnTGIgiimV9o9dmTotsXtqCdzyO/Kz0LhgX
 +wez+qbcorT7ZuqJdcNx8zUlMhjjLIWpMWERSiCE6XcRh+AF65JdIyMC1ac358s0+Guu
 i9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787221732; x=1787826532;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3eSOzIVdepcf8vdoVa44O5W6YBcWHFGcKQTFHA33X1M=;
 b=T1IzYrV5ROmjlPhFUGgYdxAU0YQFkET6gCDGLgf05bwVwVkT2e7a5SV5F3YKJuG2tU
 z/T4vlwkLA6tRoawBimLJEqATSDzxmDptNXio85cFt6egN14cVQQpzSO552JWay55dY6
 qADFSD9qDjlgs8tmf189HPUCNcF3GVc+4QzYpbUsfLJHz7N1IOayVb1LF6ycndPuTxCs
 EdNcUbtcm7anlu5zk5WWiLveIukh6OMKHevgAg/3okP1ZTjVfHB3iZ/XDzGqFCqRugtD
 gLwW+cL70ZkAY1MN3lyr6dH8PqQUA6rmeojbwKAy2or4UUyEUyq8H/OV14T8YF900x66
 KPFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6jkHmf9jv97BMFmBg+1EQ5vpOUxhPZ8clqICIx4rspX6SJpnQPQ5F4HiEW+tvPwSac8NzqdO8jD1oqYfW@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxSL3tdCmslF1uTl/kIbbRrPOyqw2OC9vD/SH5kDSRKYUYJ639F
 8mImy/+6EA23RkgQYo6q0r8PYUfZUAflf92qZDAGHanFHrvkLPHIcmQf1TNNvTAGz7bBFyTVd/b
 cE5L5k4/fcGPCkHCVYeXYczailRCta2ty/CRpSYxfl+No2TmTllSd3Fjh/BqZt9f1j+ie
X-Gm-Gg: AR+sD12rftfbzMlaEVKrZJ5ra58pPhwJ2nhFMDQ1W7RZz+7C+OIepgGIeKOL9bmIl5d
 GdNEjPqswAc4Vq3EBtS96JOjBOAc6lzkN3TRfjmkHEWT4/F8EC8z6HOiA7d/HJJZ+2N7F3ldlSJ
 MsesrEZGSuG7ZEN2cjm32YPCAOcPBfmcOIkMEReLqLwMxA1uYF7GJe/qqZH+ga84hGmpxQqH4+N
 oMnKu0sHRYFfU/AS7fzMDwDA8K51/ANMbGRGW5UByUTrTrJyjWsh3ivgfFizcM5hw+Z0+g7PFof
 +W1kJldAgdwlOQQK9cXKh+3cIqr5v7RSJZ6CCwuRRRGkKNEnoFHusgKYLXxSiH3AuhmqVumtHZS
 mIMgEdQBXOJsAjv0IaVZHlOly5LaK9mS5uGD0ovK8VhdpCdd01sA28FxaByS1TLWFDMKJzOrbe9
 kMoftLGnaGWuUDfhBaziROWJQ0HGY+h2NBxpTfWjlykulx+LUJ124sihCyRJdA9V7Cob6x2m4F8
 oG/+YfxGnb8sijpylZGNJ5tgD6YXfuPYpc2Mg/JW/qu1j/i8usUIF1WV/JupXj4DhYzLvsjfila
 ANd59k1H96KUJUg5jdMDF3Ij8NpMgV9cjPKlcH7nLZKsksqS4h741gGK4YV3H8s=
X-Received: by 2002:a05:600c:528d:b0:499:87b6:f3c0 with SMTP id
 5b1f17b1804b1-499aa1c5f88mr227050205e9.14.1787221732211; 
 Thu, 20 Aug 2026 03:28:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa17fc80sm147038755e9.14.2026.08.20.03.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:28:51 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:28:50 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 63603d64043f4ffc0761d964988ccddc36772709
X-Gerrit-Comment-Date: Thu, 20 Aug 2026 10:28:50 +0000
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <205d044ef815dd8f10b41e808b995665c218710a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx014-0003kk-TU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Work-around
 bug in mbedtls 4.1.0 and 4.2.0
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============1889680447701993738=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1889680447701993738==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7gbJ7K7RttQ="; charset=UTF-8

--7gbJ7K7RttQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1849?usp=3Demail )

Change subject: mbedtls: Work-aro=
und bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvp=
n/mbedtls_compat=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849/comme=
nt/7bf7e771_e75277ab?usp=3Demail :
PS1, Line 240:                          =
                    (size_t *)&prv->MBEDTLS_PRIVATE(pub_raw_len))));
These =
two casts would build even if the types of the variables would change in th=
e future=2E

Would it be good to cast the whole thing upfront, then no long=
er require the cast, e=2Eg=2E `mbedtls_pk_context *mut_prv =3D (mbedtls_pk_=
context *)prv;` + use `mut_prv` (with no casts for individual data members)=
?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I694410615958afb=
b422d9ead71f04c1a60edc640
Gerrit-Change-Number: 1849
Gerrit-PatchSet: 1
Ger=
rit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: MaxF <max@max-fillinger=2Enet>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC:=
 razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Thu, 20 Aug 2026 10:28:50 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: No

--7gbJ7K7RttQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/mbedtls_compat=2Eh:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1849/comment/7bf7e771_e75277ab?usp=3Demail">Patch Set #1, Lin=
e 240:</a> <code style=3D"font-family:monospace,monospace">                =
                             (size_t *)&amp;prv-&gt;MBEDTLS_PRIVATE(pub_raw=
_len))));</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">These two casts would build even if the types of the v=
ariables would change in the future=2E</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Would it be good to cast the who=
le thing upfront, then no longer require the cast, e=2Eg=2E `mbedtls_pk_con=
text *mut_prv =3D (mbedtls_pk_context *)prv;` + use `mut_prv` (with no cast=
s for individual data members)?</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">change=
 1849</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I694410615958afbb422d9ead71f04c1a60edc640 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1849 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 20 Aug 20=
26 10:28:50 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body=
></html>
--7gbJ7K7RttQ=--


--===============1889680447701993738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1889680447701993738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1889680447701993738==--

