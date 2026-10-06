Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBBACA5FFE
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=warjo6vznQ4F0MNGwySgtmXUzg74I8ZCMwVaAv82EqA=; b=O6JeO8IeN3Z3+OEzpk7lwOlwO0
	RTCxrPKZBDqDgXaZbDpwXyjrMIhTg7476ZOYFCma88wOshnnod/S0b3/okBWbbTIxU3JwRiFLtQDL
	r1KgmDRmf1SYQwgcRlf6uanFgD51Y7Rh+iYa3MJe3WLQnRKoOplWljx8q1eZLB56+tgg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDyml-0002u9-3g;
	Tue, 06 Oct 2026 06:36:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDymk-0002u3-5A
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 06:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sc/IzVSn+k7ADoWuFh6WTrGy5KtlHjd7cucQTrdt57Y=; b=a+NuoJyegMo00NNCRm4+iIX1hw
 cHecnkB61ak5WOKAzplwChSdthVkgUsr1PKcNqpTLXs9iArVEsalsVP6i16B7Y2hu6/81ks6H5csb
 wzJQXm5fZGYr9NKr9NxFdrdaDouMnEO8Hy//c5eVAk5b8/Yk3NN7DyrSITvMlExNYOtM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sc/IzVSn+k7ADoWuFh6WTrGy5KtlHjd7cucQTrdt57Y=; b=j
 BB194Edy/n99vh48JwthrTe8fMcVe7jVIDwlIV6wsJVGHov7QJDzYtYyRES99itvcxmXei2Nv50Fm
 guVBaj8FVCZtRBaI+Q37XckRGktqAbz/tDFi6exuaaOMAt3Aze89noHUkPxKSaHyErCOE/BcY78Uu
 cMXc5GMguwiMKFTg=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDymj-0004ot-F2 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 06:36:22 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4649b3aaso150452f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 23:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791268575; x=1791873375; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sc/IzVSn+k7ADoWuFh6WTrGy5KtlHjd7cucQTrdt57Y=;
 b=b35skHXB/+Axh4qQZ7Qm3+lvWZp1Vlje4GgNns7SMBvFxgz2DMGEO/0QpyBKyxqe/Z
 irVMPpEq3DvOQ0WRzr0nFD9QDs16uFmdPhcgDUNIPrS+CgCw+CCTnGsyUSQLvTMN4SMi
 AculzsgX1H7yTRRimiCZKxYHYwbkvJKi+72RvApaVWIRg+lsUwJAN/JD/4URpz0W3OFS
 5Yz3NcrTkUAuR9crLuAE4jlG3MWaWanwW2rrMB9eWhZi+zBNi5ES92HCW87oz2KiTvts
 cpCyyOnQCcdnYiY/FVx01XMSlRBbdaH5bs9YcLhwqB6WQ11JZa6rSdrlIT1ah2n2hin0
 67TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791268575; x=1791873375;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sc/IzVSn+k7ADoWuFh6WTrGy5KtlHjd7cucQTrdt57Y=;
 b=MkT4zl5mZ86oBPAN0lCzuFV8oOt0ww7o52gLuTOS56J1QFCXhd2OWNaBRNdZITa3ur
 1ik6Rek9jV5z0hS20QYj7NTs+KvShAvd9bcvhyTIqEdbOiA1vzPKsWJ3zuEjxDuryNfO
 +OQvShAh+Dw3kQcjSHV4cYF9KgPPpj7HhTB9eTZUIANgeeuyH2yX7MIcw0nzS7NVXwUe
 h4g60nRm7SD0IUNvqR9CyXyp8G+xO3YTZkcoxO9HxDjkc+lqeFRxLLiJZA1PqmnDaktd
 nUGAoik8tH/Z0JPyPpgFj6cIUACvePl1UrKB9RPvqFO12DnnlXkb+bbP0Qy4mz1/M9cI
 MsJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVzDT1LEFedXn/VrfHth7EB3n9VlY05Qzms1NwMsaaw6vdl1AjdWqrTgzgl/ZrLhPJ5zkFouD8O5OaPMy8@lists.sourceforge.net
X-Gm-Message-State: AFq9FYINi+GT7PIXPmFFy2u3o7P874jdfwmjmo5qLxUw4fejo3LhAmAL
 5QyMwhELwUTBPnzILpaZT+UGwTYZTcN/QoD8l9RS8fhcc/c2pSA35r8H5OpKaWSnaoce19N4ZSs
 ii7pHhRbNnTwW88+ywf3FAFjWoQjQ3w5Id4manz7QlrBz/7IwJN5LIs7peZpRWhvYhbayy8YH69
 T1QMm/aA==
X-Gm-Gg: AYBFou38orKx3lW2UYqv/JQmhz/muxdnllC2H1iBsbcFtH4ALTQVwViaq663yOXUVjE
 5A0UBJFb4w0/eTUV6zjqXRdxRrphOmQhwzlHxCyh2jWQKzIRwODOexqDVk2qr7HLFdv7ZOId5eL
 kGIUrgPQLhvG6qDi4bpt+fbcJ8PsvGA2Ay8d/518bg3zd10RBCO8JtfA1rbs1vcO9OrxnvKOr7T
 7jrvwgJJani/bEH3BnrJUY4EydgS7t+7h7XI2xE1HJ1HtU0tYYJ3Y0/plwmxBjl//QybcOrWeYJ
 WFaJuKP4dy5eubH47BNN8sZyURrepUqvWGa7S+1lp792rhtkAQDbdK7x8sA+dvJu+/AX036B/5q
 DUIu4sSmV9D6cal9RUjBCthZ983ZdwItpkfteciOeHc5Nr5ivKQgJlV87WqD9DM5nFCRIM/O+ZJ
 WhctoIxp1FV2YOWfKiFWMQ8wvEarAaYkfUiHnefYk6WUf5ESLWrkUSFl6jT7NYzzma5+umt+B9D
 fWlAJW7pwKbChK1gG9DFzVoU8ovKDklulqQ51WK2e4FwEOw1NKb37369gH40d56a5Pre11gtOWW
 OZCQT8K455qaRZgmGkTvwrwoQYpVqk034UleTLQppZcDM51PbpbZopkUd/O6
X-Received: by 2002:adf:e189:0:b0:48a:ff55:4ffb with SMTP id
 ffacd0b85a97d-48c6d1bf14amr627760f8f.33.1791268574131; 
 Mon, 05 Oct 2026 23:36:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6d9ab09asm637319f8f.46.2026.10.05.23.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:36:13 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 06:36:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 90dac0ff74b5023b593c7903d89f7c9210fbd403
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 06:36:12 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42c9567a23d4c0826f5e027edad3bd18cdaa0d53-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDymj-0004ot-F2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5284441192560119580=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5284441192560119580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zewzU8tO+oc="; charset=UTF-8

--zewzU8tO+oc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

chugly has posted comments on this change by chugly=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail )

Change su=
bject: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(2 comments)

File CMakeList=
s=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/d385ed35_=
ce6350aa?usp=3Demail :
PS3, Line 947:             tests/unit_tests/openvpn/=
cert_data=2Eh
> breaks the windows builds
Fixed in PS4=2E Those two mock_ge=
t_random=2Ec removals were never meant to be part of this change=2E


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/5dd9864c_2536edf7?usp=3D=
email :
PS3, Line 1007:     if (TARGET test_pkcs11)
> Why was this removed?=
 It broke the build=2E
Fixed in PS4=2E Those two mock_get_random=2Ec remova=
ls were never meant to be part of this change=2E



-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
G=
errit-Change-Number: 1946
Gerrit-PatchSet: 3
Gerrit-Owner: chugly <charlie=
=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Tue, 06 Oct 2026 06:36:12 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>

--zewzU8tO+oc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>chugly has posted comments on this change by chugly=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1946/comment/d385ed35_ce6350aa?usp=3Demail">Patch Set #3=
, Line 947:</a> <code style=3D"font-family:monospace,monospace">           =
 tests/unit_tests/openvpn/cert_data=2Eh</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">breaks the wi=
ndows builds</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Fixed in PS4=2E Those two mock_get_random=2Ec=
 removals were never meant to be part of this change=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/5dd9864c_2536=
edf7?usp=3Demail">Patch Set #3, Line 1007:</a> <code style=3D"font-family:m=
onospace,monospace">    if (TARGET test_pkcs11)</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why w=
as this removed? It broke the build=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Fixed in PS4=2E Tho=
se two mock_get_random=2Ec removals were never meant to be part of this cha=
nge=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd31839=
b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Tue, 06 Oct 2026 06:36:12 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:=
none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>

</body></html>
--zewzU8tO+oc=--


--===============5284441192560119580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5284441192560119580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5284441192560119580==--

