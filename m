Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41589CC6B1D
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJvPgunTYEEM1RulXI6Lh5xLYG6BsirgNv/mfGRlm4g=; b=HZnvUQWGcytfdeopFWjEGeoWDx
	TYoxr+DsmcXv3Ypci2YaGXwNUa2w9JoH7eIM4uv/T1/2y+BTqmSNVqlJABj9o8IgYten/A5rhzUXx
	cN2vkA/0Q5QxQO4BA2sBZnjKeRrlMuOtzCXMjQPKA9Wa7baLauCfkClJfym9nnWMXSqs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGwp2-00082o-UD;
	Wed, 14 Oct 2026 11:07:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGwoh-00082D-4u
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o38WWcu8pF0bYRR4TONiTqM369Ht6QvJhjs5neiPazs=; b=V8yQ/iWPbgZzLYUNe1bomhw+7L
 g0HOixxsv0CUX5PYzYtKBM1bEG77GN8IBsTwv+/qjff6xxzLOr/zvBa8P96siogCfSgohFoW3cy6b
 2ChE+1XTGliVeW5WlaQCQw77pPec2CBHffcOjshNfkhjbsO8Ce/bOhbKyl33z6wXz620=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o38WWcu8pF0bYRR4TONiTqM369Ht6QvJhjs5neiPazs=; b=X
 M/OaLXh76X5a2RkfKPISw2SBiEQMDlgVTAUJuKQfjFTJV6cvD6UklpwPQb/xZM5Gtbfh1O8Za7Pdl
 g6ByEN0/8aFpcVqJ7YfMLGCXNbGMbwBmk3DVTXyq5Xr/ML/IFHxi3K9eGvWJtKmyZXkUK9OzXUu7Y
 J0Zq5xNoX8IJrkoM=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGwoT-0006gj-C4 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:06:29 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so34810515e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791975979; x=1792580779; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o38WWcu8pF0bYRR4TONiTqM369Ht6QvJhjs5neiPazs=;
 b=bjVr7suGL/XVxrZ1kWfeaxgxnX2HSBmIFCfh1uTM66s9PbnyJ2mYQm2bC05hCCHqBV
 dPjE/4Yrlv4FusMZoIvcDUus7iv+DY8admGMdpRHiX7HDmyf9I2HgLEfWYkYkCXMPlh4
 Hgn8vMxhRtCzEtlXtPPXHYR1FJ42pkM0Mc5LjJ63P4fWXOUKPNx5xEKLUpsG8LMojPTW
 8gFksrOhNO+VLAWPbzoyJahuQG3GuYM/qtMbj4m+Q4FinCqQpaU4QivhEg1k+1fDVEyR
 K3D3tLWT3AALOYfudsp5nUIIRffyQbZYm5N7s/L801OHqo3jTqxY4/EX6tJ6KfMF7aV/
 04mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975979; x=1792580779;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=o38WWcu8pF0bYRR4TONiTqM369Ht6QvJhjs5neiPazs=;
 b=ZmR9qLh3jZMhpignRquXIw6kgTdgSOzSlLEY8F5t84wOO97vO0IQpg9qmJtpqdckKO
 BZUcGskYBEM15rjoBOxGEdlU6RXlDpjxIeyDZLIKIF8g1zLs7R7Ew57TpZXbEQnWlX0n
 f/+DDtD24K3jG7H9O4ItiRKrBQQVWba8ExOKyv437AWQzmc0Pde2QChhP67aVXE9V5YL
 TLJbrpadlztMrhSFt4gucqhQcrKCRWvTFtX9tQ+cbM2eGLj3rjUU/Jv0vhHYb5fXVfcK
 uGk2/oV1JFLdjurLSkCNTyUbACzsULMKG+EFYppIq3ZSjFPrHlBRuXWm/f0D63xwSU3j
 mJnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz25PNYlQZMr5jxQGFfPwnIOhLrw1McHRtEH49VeWcbo2C4p0MBk6eiB0zUc6hvrNc0jISHkjUlw/FCxKmb@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJUepwJMiEP8tr4AmxPTP0K1PWHCyFEqwiClUyU91FrDh64+PZR
 RHiUw1bA92d3dh8hrPre3+sph72LXA2mKF1G4tSrw3LP3XPQcITL8Ck/x6bp3ZcRGjv+4bU2332
 87+QSC4O4c6+zhAajFbtbXx5e7ehWjIYbVGfgJuSR7FIQanGtyzVbKKd1BAjfRwVYH4fRsQVLcq
 G/zeegew==
X-Gm-Gg: AYBFou3efKWBBsV+VgqjHu6xH5diVis+X44OKGFWjeFeHQZtklmQC/xqeFJuMCSCNsD
 OBZZVWOP1hViZtJcagMar/o9AyytEvxL+9JI9diGB7BqDAkD2sRbsQrT6GUkz9jmMWFc51dgivS
 i6vN/D0o+37CR3eMz2ScpMLyWI3TSlcCpLx/IKcnCeMj8DPVlRB0fTVVvQO6WAuFgLDFxv4kf+k
 v2v/1IYH6UC9e8CTiZjKsTDMGrV6PoCuzbTcAUHz41VPV9RilQPD+df5ZS6KdMR0ktKm0nLp1YL
 3CiF3XM1bnkF2DjEK2OmT/hOhlO7rbsbdC2gVenkMtb4whTlare0KLzjmb4kWtID+ndGz7ne+oN
 Piyo3AcHUs9y4ch0ozg7AwrXPtxUmVe0TrS6m1T6nzSlQfRx7fe7hx2R5Rt9e5gTj0NhbrqBqsu
 WvMbXfaQ45nRRatS/cG5pQXdMKaoYDWKBQ4Vs371/pYwQL8k6FUgvOWR0DAJ8Te+afp66NpJlvs
 a3WsZjykVY8qlyTxT6lCQ03h4vlk8EXSrT20DiTNcWKldC4PxGk4cFQCG8tKJ/S8hed49N75Qcs
 +y9bAboVh2MMxfZq8y9ymIc4g+xtU7BsKutSUfk3O8ocS6fOEclDMOEM3oO7
X-Received: by 2002:a05:600c:3f18:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a18e4cedfcmr286761275e9.33.1791975978464; 
 Wed, 14 Oct 2026 04:06:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f318c31sm201085035e9.3.2026.10.14.04.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:06:18 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:06:16 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: a05840749fae02ea496242e2624097ed6817b9b2
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 11:06:16 +0000
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80e6cb26e7e7db62454835354e93c60c1dd8e996-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGwoT-0006gj-C4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix small
 issues buf_printf and buf_puts
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1425470213290355339=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1425470213290355339==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PddoTnGXKSk="; charset=UTF-8

--PddoTnGXKSk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail )

Change=
 subject: buffer: Fix small issues buf_printf and buf_puts
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

=
File tests/unit_tests/openvpn/test_buffer=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1997/comment/ffed094b_b53d8478?usp=3Demail :
PS1, Line 68: =
    assert_buf_equals_str(&buf, "123some text, t");
> Yes, this was just to=
 confirm the behavior=2E It did not change=2E
Acknowledged



-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3=
d3bc827a
Gerrit-Change-Number: 1997
Gerrit-PatchSet: 1
Gerrit-Owner: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 1=
4 Oct 2026 11:06:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Com=
ment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-R=
eply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--PddoTnGXKSk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/te=
st_buffer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/ffed094b_b53d84=
78?usp=3Demail">Patch Set #1, Line 68:</a> <code style=3D"font-family:monos=
pace,monospace">    assert_buf_equals_str(&amp;buf, &quot;123some text, t&q=
uot;);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Yes, this was just to confirm the behavior=2E =
It did not change=2E</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997=
?usp=3Demail">change 1997</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1997?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1997 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 14 Oct 2026 11:06:16 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--PddoTnGXKSk=--


--===============1425470213290355339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1425470213290355339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1425470213290355339==--

