Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5653C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pI7bylyW74+ZP7NF9uc7OLLpozCN8/whmoybYSqrfy0=; b=edLNZEpQECYSWbx+ZbnQ2YkL1b
	7E3+POpetmE6lU6GK978iXNF11bT4kzey4xWvEE1KgFFlNw1RLP3TyV+yIeAWVWV5+22BqBKP5rjF
	6EWtR8Hxke6HLL3YDFdtR3JrdmwlGYiceyXTcjjJPaW/q2WDjNAmymo6rotxzvx9O2uA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA3Bx-00046n-Sr;
	Fri, 25 Sep 2026 10:30:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA3Bk-00045h-C1
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 10:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K5P309CwlregwL+zoCppIPdT69P7Of34CJ6/QO0fCKg=; b=j+6+O2omArTZfSSFrc2RUwPTdg
 hVU8ckJGemlVNYhPoB1y6U+/fP3/5K6amoMIWMIlrfDUF1qETLcVT9UAUzaDBp3ZT9CYoQiGTkd0o
 V2L/5JplXI8JGa0CMnTkmUH+hSLAsz85EhnTzogsBXllkVEg3ewiT9gJYlc/Uy5751m8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K5P309CwlregwL+zoCppIPdT69P7Of34CJ6/QO0fCKg=; b=g
 hth2W2V+MKM2HNTIvLSBrFUtVOxzTji6DEmILBhes4X+YKCndX/uhZ1EnbXXylJQI4h3lEqabpb6W
 IYAfrdvEcmjFyk6UcXS0GPoxJnv4cVuXmMuS16s4/DlkpUBRKQdYIQuTbLaGt4vT2wdSGZ+0oOeKU
 /lop1OiWM2Fb7wKg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA3Bj-0004Bp-NE for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 10:29:57 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912df756so6206225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790332189; x=1790936989; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K5P309CwlregwL+zoCppIPdT69P7Of34CJ6/QO0fCKg=;
 b=DgVee2j8GjhWoOI0DIIm6KyOySVZsD8ZPOCHwVF5b2JPD/GtB9UupA1Nn6Sh4a2uEV
 6JZAeNong7swQtYUDP2E78e7ABCFYr0ZRqLPL98NIcONV6SBjsilsApRN6ZcBU1Kr0pK
 TslENMUn8UFu0RrTZQjf8ZzxoNL2289Fyik++mSoWESps8AnpRRxHV/zuVhmoduaNTdf
 5wQzaiEplL3DdHdsB4cLLXJGhN/dLZHFjYelPuDY8gZvb5Yl2erljZZC8ghPM7jUaFMA
 HfVntNlbFCnIrhqp0KB7gyT3H2yE3ss/Uxegh1cd7M7lSO4oYdmTfvtIZSz4kcuQuK0c
 0F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790332189; x=1790936989;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K5P309CwlregwL+zoCppIPdT69P7Of34CJ6/QO0fCKg=;
 b=IXBEwx8vuuljrsFesE9OpMVNUAz/nE/Y7uVgZ2lzDglOMZHdDP8VBBv7kAynVunKJD
 1vXHD8ou0ctDYd6/PrQzJhWuDgQvO9Ry5O5UhHVuXRZw8HH0Wtm/ZZNLEmGqHSeVTb1W
 1f2DAutFj8D6hV8e2JcD6I84MJRK8d9xwxdSRd6eveipIUHWr7PBFoBtxXGIXKGknDEX
 Ye6JgVy8G9g3D1n/avece/y9emgMsgQNgvPi563JZ6MmQEyCxT5vIdMPtnfju2+zIOWk
 qxGHmVJIlsh8grJgknWRgMM+fF8gW2lQo1wgbkIgFQyUyk8ibKewfmzU3KPknRLbwuV8
 81zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHlPeyGjKHwAeFVq8Mk+sPN69MTubtKy1S2eRiEkIH8kzF+a/rQdp+9bsxtgBWw7XJcxtB10Ws+9Wb928Y@lists.sourceforge.net
X-Gm-Message-State: AFuF++nQjfwpEazWM/JGELnqYMX9MhskDm/sLJTZbLNy9732UTfTNzI7
 ApOoiCWQbLCNnfBf3sa44d3uU67dLZEVok3v1UHfFDkOKjXXYw3s6MhXchya8XSI3ghEGeU9x/q
 uEX+LlxUoaIVaakrVAarbdUUi39OHVNCk1hD8HeBdb0Rm0a45mkm1l//8TYP+NEUQjWli
X-Gm-Gg: AYBFou0smcCQMj2UUOfXWi9nDOq6sMc84E3aC58p7bqfoKDRyFbCsQ/TuVlX1wYcLoN
 ezt1rK6QGMq4BB5Y4u4Z6dix1azWtiMylGJD5HKf3xy3It7vIi4a90SYt0pgaFPff05h5n5sgrT
 W5PGIK1/JPxJaD3/u241emBqe8XyQ3JfNfP6uZAY7Z4SMfbqMb2OlNtuunvoQQ8gAa5LxRwXe8b
 5cD4aPiCk5ffAYLgvalYu2KfSEzCrVwlIdx5XnKAdYWg2+PNQlbOWqSEDP2aEewzWKqbFCpl74H
 97gjJtGQxM8OfFxq2guq6lCpR/aMcoKjXVKAZ0vwOyMYpLSUrAa4mdHnLLBWiNAHHCIo9gjJ80G
 zsTlatz53iXSZWMYlkjAYzNlgTkieQz80jiS+ONKLSp68lSa+OPTvOIPKUr5BLuTHWQse2lHiFb
 XUWOKcw8MhMXLu+/smzPWEb81tDqmmhmAnKQWCIavGlEZN1Elx/rEicm9AwdotJs4Cbow/MrSbm
 WztRV0q2FV0sgNeRrFjXbXPGnYGcN/07EGBymZOdMZ1lWw8OLKp7qpYUEuOjzQeSKEgh/CwCVR8
 XcS3oTSgDINscPrnVJg5jOTxQAkenJlaZR0jiKyMYZKHGGMvPWiYI8Z31bfN
X-Received: by 2002:a05:600c:4e12:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-49fe66b6e0emr90836385e9.14.1790332188887; 
 Fri, 25 Sep 2026 03:29:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a746c57sm5584594f8f.35.2026.09.25.03.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 03:29:48 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 10:29:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: cf481197cd8c5e5270f11dbaa63c87265e2b13c8
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 10:29:46 +0000
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97dc6aa506a9d1a1a09eda4745dc7f7615efca7f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA3Bj-0004Bp-NE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Drop the OpenSSL
 errors a failed cipher/digest lookup leaves behind
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8301219718226523684=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8301219718226523684==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gejjWqLtBj8="; charset=UTF-8

--gejjWqLtBj8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail )

Change subject: Drop the =
OpenSSL errors a failed cipher/digest lookup leaves behind
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

=
Patchset:

PS1: 
Via Github (https://github=2Ecom/OpenVPN/openvpn/pull/1104=
)



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I440c4c73865fdbd=
80f2c607e83c50e345a0e2438
Gerrit-Change-Number: 1950
Gerrit-PatchSet: 1
Ger=
rit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-Comment-Date: Fri, 25 Sep 2026 10:29:46 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No

--gejjWqLtBj8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has pos=
ted comments on this change by plaisthos=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Via Github (https://github=2Ecom/O=
penVPN/openvpn/pull/1104)</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">change 1950=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I440c=
4c73865fdbd80f2c607e83c50e345a0e2438 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1950 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Sep 2026 10:29:4=
6 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--gejjWqLtBj8=--


--===============8301219718226523684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8301219718226523684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8301219718226523684==--

