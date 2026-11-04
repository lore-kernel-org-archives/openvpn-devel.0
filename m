Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11798606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HRPKIxQO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=F2AsN98Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Lx2EfzNY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SJxcETOj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CZvetik2yrCwkOynU8I+8S9XzzQpJB9yvPKSOC5tBNk=; b=HRPKIxQOv+8Pe539kCx1nd4OsO
	nSgsNDjPs/dNI9Q/3XoxMO1GlOxI2T5CnLIr1H9wu8pnp7ZhamP40OZN9BfCvEgoPDXxTuLdqDW+U
	o4iPppj8oppSzC08/ef3cItzdASOvg4CYHOqboF46kWROuqJlkRLHTnsX7CQg1A6FsFc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOfLb-000000001i5-0Btk;
	Wed, 04 Nov 2026 18:04:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOfLZ-000000001hy-2x5h
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 18:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EfDDdIG1HTFcH72aLFJpM81c1WER14e1KwLc4DVNzvw=; b=F2AsN98QxhuxIxhUIqVhSKh/uV
 jUIz/SE0IjkdC49lGXwVo/XCmUJnsbj6XeYvciPC6MfdLqFfHDt+Xw/a4BZeb8MoTUU50b5AOGMBT
 55+05PSbwY8Pw+e+Bj6YRU1jjQVKdtEfopfHeYaqExCD41mlZKxw+cm7HysVU1Hb/lcs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EfDDdIG1HTFcH72aLFJpM81c1WER14e1KwLc4DVNzvw=; b=Lx2EfzNY8ESTZmpD/EZrqjEKUT
 4AwwCymRh7Aiaa72djUnUzk2h3/hAd5CNmFzBwH/x6A2hLFRZwifzEP7yY5tBReB5bDhkArutMJZ7
 p//d8NVE5z8+s5a1+b/JL/88boQD1eFmxYVMd1XomDlce2u5wCG3yKe6usdwQqCoDcQM=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOfLX-000000003no-2TUT for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 18:04:29 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-490c1d337d8so320236f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793815461; x=1794420261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EfDDdIG1HTFcH72aLFJpM81c1WER14e1KwLc4DVNzvw=;
 b=SJxcETOjl/qqJxg1SdHN0uD+l4xuRK1//drXOmtRXShouDMIG8wrgEHYuudQ+hXTYF
 13+wWI9H2d5p8+MD9aGP48WhuPgfAx/0dAQHwCyTDGmSZ3rCa3maCrTicJRS1gzKHJRN
 /v5durXdSEZ2CpChWZRUvUJnQrc5lTahtIcbWP2eRCr3+sZWiUGIMkGPF661b+qmYwqU
 bMdifEIeO3Jn86SC/0Sw0NeTK4WW/7M9YZktZ3AxQ99ywGIKZe3o/E4vIzCIZQdfPTw0
 s68MxyiF5esr8Y8Ib/fYLa49NjdnU92pHAKs0FYmsHdIRF6ghKN7orBMurMIixxw9JoF
 x0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815461; x=1794420261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EfDDdIG1HTFcH72aLFJpM81c1WER14e1KwLc4DVNzvw=;
 b=VTCthG0A8ktS5c0rmlMvCc43ckQBxrVdiqFZz1VsFxBj5XMGvg9l4LYqI+go4v51hc
 uwOJOVOtu8o+c9sBGb0+mkkiH1WJ02MlE5IWgFLXaA34XDLmtdE3qjggVnmfpTiiur29
 9V1WfVLH5ROAgimNpCmADbl0V2hLvmetlOX2XIor3RKhmeG/npRtaaW0jEJjsNzcfAlN
 IDAC8H2FOYwBRz5o7x3NkVewWLSb1UkHRDS+LTn0Qc/Rq6aSagb3c2j6swsaoXsNKeVZ
 +FZ+Rb89/7+5eJ5YVV1Gw0+8FnJdEQdkbn5zXsMARAgwa3WyoiPe0L7fuDzHAqr0ml3k
 cM0w==
X-Forwarded-Encrypted: i=1;
 AKwUvByfXHxWYEcIKnjUgdhBcJrt1+t5eq7gBEdse6mZ48uv0vMtZ/j3vuTpchGqXwl+PY96GYMWqWN8OTQullt0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/UNpqpxOx0gd571dNNStD/naBW98TS4qEOfxdQuodmMvsyn4Pi
 GsSunyAqsiPRQVGcxf6zcAJTn39Zc0yzrUAaXculpCk43GRf5YgivNZgrp6+51D50Gj1NUztOVP
 gqqxxOt6h1LDUfsvlfC/r9mllaYbkoQHluYdtNr8Z3VNWoPkszE1S/nwrZJw3kiwdhuH9YJ/D6S
 VB6HtLQA==
X-Gm-Gg: AYBFou3PApnAdpfp7B17G02uRZjKJgz9GauXES8DyqfVtQvsjTdBNcNUJEEAVkEgUOX
 h+wIze5tsnbNhebMznJSgg9DyPiYMR60rWL0wIvwL2SsqBRBHK7CO4F8siELXm++e+k/ABwI5Ln
 8ujgvXlqy8T11Ke/EstITvNKha2IeS/qcuF99sYXwC5isCZx8a1e0HcfCwo/pAzNFuMgnd9WMEM
 bqoRaiuocIFv0fn6fB34nNze0dTGV7J+XOz7AjgrRE0vsSadcEuBC88cHqzndCR4fS+OjUvYngR
 ZWNsI0ngJeg1iCkkNvbdhsR7OFymRSAVfsBGvWzoQGjWtkZe5NSauSvHCdf6xeRKd8H3VSAWbWL
 8NwAA0XiAwBpe1gd0lrUX+ouOo/jflgChxU6D3WB0oxD6y6553IXac/AFOH4jbdRxqGNH2MlkYT
 0yTNfcCzrARAcDkWCLE9Yd1CWMVliKmhCrvoAlTjyQswjOJMjmPsq05r9dnuTPGus4KV4Deyf2/
 2vQ47bVCc1J/nDdon10ZvCDFZuCinHJtGj94jRiTr65HsvsWeFwV0IcswCXmYcPzh5f0YHG51rq
 m0JeSZnDDeMlWCmO6P9dk/gIb8xMBO2KY26pz+B6UVRFB5GhlofnDdnjDc90xyP/raIbd/IAvBE
 DQxZcUUDlhIdyikHAIJqhrx/ony6E/oljA9ctEEYOTZpviiE+UsKyBqUsHfBhGQjOkjmGoNLFwm
 Q7qf/XSuMuOWroZQ==
X-Received: by 2002:a05:6000:2dc3:b0:48e:68da:1c5c with SMTP id
 ffacd0b85a97d-48e6e2f83aamr37342397f8f.16.1793815460850; 
 Wed, 04 Nov 2026 10:04:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fea180ee1sm6060926f8f.4.2026.11.04.10.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 10:04:19 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 18:04:18 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: fb08f2ed58217017e53f66a5bae20280bd48bf1d
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 18:04:18 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e810963c3bc7aa1c580e7afe6fa0658f494a5a09-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOfLX-000000003no-2TUT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1982023825215067161=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1982023825215067161==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QGxrRMKBuh0="; charset=UTF-8

--QGxrRMKBuh0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subject: Add unix-script f=
unctionality to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 16: Code-Review-1

(1 comment)

Pat=
chset:

PS16: 
This syntax unfortunately kills scripts if you run an older =
version version by replacing them with a unix socket for some reason and do=
es not error out=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Ger=
rit-PatchSet: 16
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Wed, 04 Nov 2026 18:04:18 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--QGxrRMKBuh0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 16:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #16:</a> </p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This syntax unfortunatel=
y kills scripts if you run an older version version by replacing them with =
a unix socket for some reason and does not error out=2E</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 18:04:18 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--QGxrRMKBuh0=--


--===============1982023825215067161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1982023825215067161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1982023825215067161==--

