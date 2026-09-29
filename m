Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1E4CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 01:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZdEsaoOAwOTSddmE4XU8/w22zIbh8+eJFbZLWXd4Pw=; b=LhiOeKbhD+jjHeq+lByB6GK+Ix
	ZTdzNCWR/1w1PrpyGUAAr9v6nZ9KVSrIReSV7QaQVKYkeUoyAFWGDSglpBHg90LruEkJvnWlZIv8H
	3Alllwd+6ihEj2BEiBUqUJoVxqthm7pG6kuk8Ld7wm0zjku6woCz+9Hf7LJ2dFQ+RfGA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBN6p-0006xy-QN;
	Tue, 29 Sep 2026 01:58:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBN6o-0006xj-Fq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 01:58:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zU3+J2PRYM262WpDDReofxuzLF/bh4O03GraJC0J8xY=; b=Z1ONRbLzpcJl52b5QDu7SIepBB
 liJhQ1VUSJ6tCT1AkYV2cDfb1qwBPQG0olkDpFlCGQ4OTSUEvf6xDa5HIzu2ayjiwMGkm8wZlSpTS
 ZAkR4htr0uGIWBNldYIsktoUfB6WEHbOKuGHzcmgV3AWwtYmC6S1ykpGXLDXl7W1ovt4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zU3+J2PRYM262WpDDReofxuzLF/bh4O03GraJC0J8xY=; b=b
 6PByikr8tFtsZlZpnk804Q6FD7eE+zy/R1ePFsU0hxP1fHzWfWQ/XrkmY8/EKDYlBkTt9i4ViKjpO
 hvDewZMUIpHc0uOnBYruyZWJSUrfzQOvSn8bVnlyigS0i3faE0RA55od3TNeCFy/yo4AETIp0zJVZ
 IWA1ayJG522HlWp4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBN6o-0000mc-Ku for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 01:58:19 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffb83bf7aso21415905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 18:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790647092; x=1791251892; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zU3+J2PRYM262WpDDReofxuzLF/bh4O03GraJC0J8xY=;
 b=K1LIAI6v9GSWUNDjv3j7DNUowk6Ut2Hsr9jMmvLKIx/2OYuKzDE8BPUmwdd7d9SwbK
 3jNuEb0RUgUF6o1CBTYI4UUkY0P3MleNmzsY1i3KYjv9GCD2zMFxoLNTPx0Gac2LDqRM
 2/O1ogHm7/9dKgUJP14wuozPQ7A3P8D8g2fSdCFbiIIQrSPm6tsL1GOKiRtNHYIB+EN8
 NSn7B3EZ2nSbnfxUDLtACLZ21dBAxUBmgRMx8dvuzrUDU7yQ+Mflg9LW0z4CM/1WkzPK
 4cvEYvP3NWp6sf47cKpB2UL+c08EZDQ7UcNf6vRv7GV68Rj6TVzX2CtAXrHoGYKU9wLb
 GqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790647092; x=1791251892;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zU3+J2PRYM262WpDDReofxuzLF/bh4O03GraJC0J8xY=;
 b=JSDmfMt3wuEAtZWSirqUhU9+QWziSj2qGBxWhHjIYtgMQEM01UH1uwqFrvJC9BpUoU
 ehFWvxhUXNKheTY+Y0paJ+0vr2L9t1cQLTCLhoJQwQps1Z23jSKKam5G/FROIUhJLTqG
 JfEJMHRYHLvWnbfvZ7EUYyYKg0eDAmcieq7gvwBMXb1Um5dgcdtCfMH4l/QtcZPLQW7/
 MkFsljbkac2+fjvD4rZFIzsD/RgzLJt6fCxg97ahQInRT4N5xFkWlY/Mmt7J79RWtlPN
 YxsmVVQIC1CTTi/MD837wsCy0hqSpGmtdczVWW//Ufz2NMt5acUEvJdHmhMMLIwj52lE
 OlSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwaAUewT019mIeIhB/+yLu7loRGBROQDRDCA0l4/thjJjFzAzmBrCW/X3b04cWKhJIyS9y2XneOkGnt39X@lists.sourceforge.net
X-Gm-Message-State: AFuF++nZ70c+TdatURknfpclTErxyMSm5LpKLW+L5y9oeGt7iMpLRJxb
 wPO/7fTKQzge9vNTqURYvuSuKuRkA0QsGJBb0qbHTe8eAZ7tkXQ7MgFGDMPovd86G0/N7Pa/IAK
 pspp0SARlTubXo/lqBf+er4MVk83ReDpbFbWaBzhkzQKzzl2vikA2dv+cJgl78PJN6ecR
X-Gm-Gg: AYBFou003V02FWtxkQ08YMQZNP1WJV3M57MtSSh+Co2mnFnJUaDzmiyDNonzreb3l3P
 DFQjQk5Zvvkhmzd+DpDTyq7D9LouAu7feK1m7C3HhKTg/l443Wk1GiPc4Dkgc1QvRhZz6qZYbBX
 L0n2jXL9GuEAYCLdIwliV7+CbgLA20lJ7+JB6/d4BRZwD1zMuJwCqsEMEGlOQxikJnbYvLeWHXS
 jqj+UUSEfACyJKeAVHvmc1vMCwOAWYU5InKV61ON+KPt4n60eK2uBTEAF0w4eUYYU7W74gNQXTU
 ftbE39avyESNJVANNqcZLZb7RhxP6g+BLD6iqrTR5alHC9TBzEtRhmZBsvroMyGBIAk5kuCmGpY
 mjVyIzYoe+YA3IySf+/qhCmRfZejclWUf7eqkQqooTpHSsabU1MAbTxupm3ZGIylUkpVX9yzXTs
 1y4330kmPbI/UmjWroiAuhdga69pS0ckthivBFCh84m0G5zkkkZrt09ZJoh1v1qJWv5FmrA3MuS
 0zzfNeMuAPZTbl8esWK8R/TZ2WOF/z3LTsyznezQbTywqtjyaPg99ujldy8QK2+G26tZfM48BWI
 zDt79LbEz1wv8DeOdZABOz1O+luFEHevZWeUJtmwMZe74n3+JEkz2K+iUUQzSEU=
X-Received: by 2002:a05:600c:37c4:b0:4a0:b6:460f with SMTP id
 5b1f17b1804b1-4a001e8c579mr95181775e9.33.1790647091976; 
 Mon, 28 Sep 2026 18:58:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30bcdbsm31249662f8f.2.2026.09.28.18.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 18:58:11 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 01:58:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 1d4de58aa6dd1e086e4bf715e30fbfc9feb5c723
X-Gerrit-Comment-Date: Tue, 29 Sep 2026 01:58:09 +0000
In-Reply-To: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c9d62d1686e6d2ca68963501a40d0c2f5ee80ca-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBN6o-0000mc-Ku
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tests: add an
 end-to-end test for --route gateway keywords
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1863895119853427029=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1863895119853427029==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+QRaz6sz6ek="; charset=UTF-8

--+QRaz6sz6ek=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

chugly ha=
s posted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1949?usp=3Demail )

Change subject: tests: add an end-to-end=
 test for --route gateway keywords
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

PS3 changes how the test decides it c=
annot run=2E The tunnel is now waited for separately from the route and /de=
v/net/tun is checked up front, so an environment that cannot open a tunnel =
skips=2E A tunnel that comes up without the route, or with the wrong gatewa=
y, is still a failure=2E Both paths now print the client and server logs al=
ong with the addresses and routes=2E

That is a guess at the cause though=
=2E PS2 failed arch-factory-default and debian-13-factory-default and I hav=
e not managed to reproduce either=2E It passes here as a normal user and as=
 root, and in the full tests/ suite alongside t_cltsrv=2Esh=2E Every other =
builder is green, including debian-unstable, so it does not look like a too=
lchain issue=2E

I also do not know how to read the buildbot logs=2E The li=
nks in the checks point at buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein, which=
 I cannot reach, so I have no way to see what actually failed=2E If someone=
 can paste the relevant part of either log, or tell me how to get at them, =
I can fix the real cause instead of guessing=2E


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Gerri=
t-Change-Number: 1949
Gerrit-PatchSet: 3
Gerrit-Owner: chugly <charlie=2Evi=
gue@openvpn=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Tue, 29 Sep 2026 01:58:09 +0000
Gerrit-Has=
Comments: No
Gerrit-Has-Labels: No

--+QRaz6sz6ek=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>chugly has posted =
comments on this change by chugly=2E</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">PS3 changes how the test decides i=
t cannot run=2E The tunnel is now waited for separately from the route and =
/dev/net/tun is checked up front, so an environment that cannot open a tunn=
el skips=2E A tunnel that comes up without the route, or with the wrong gat=
eway, is still a failure=2E Both paths now print the client and server logs=
 along with the addresses and routes=2E</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">That is a guess at the cause th=
ough=2E PS2 failed arch-factory-default and debian-13-factory-default and I=
 have not managed to reproduce either=2E It passes here as a normal user an=
d as root, and in the full tests/ suite alongside t_cltsrv=2Esh=2E Every ot=
her builder is green, including debian-unstable, so it does not look like a=
 toolchain issue=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">I also do not know how to read the buildbot logs=2E=
 The links in the checks point at buildbot=2Ecommunity=2Eaws=2Eopenvpn=2Ein=
, which I cannot reach, so I have no way to see what actually failed=2E If =
someone can paste the relevant part of either log, or tell me how to get at=
 them, I can fix the real cause instead of guessing=2E</p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail">change 1949=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2e8f=
1449fe54e7f628e2bdb042ee2a567f25e02d </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1949 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=
=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 29 Sep=
 2026 01:58:09 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</bo=
dy></html>
--+QRaz6sz6ek=--


--===============1863895119853427029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1863895119853427029==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1863895119853427029==--

