Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490C5C88E73
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d9TE0KAAh5rS9RwM2lQ+QxgVtcGej7ubt8ODG5GUaos=; b=OB+SUNbIAUvbTgUE7WQ67l8Zut
	Gl9mk3rMpF0Xx7V09OGuEZ24tQo2O971/RppOYunh5m+tBxPfWHnpWRm6710Eefl0HddfIrdRkmgi
	+OlJNi2l5QJ7c1j/lLVFUeCh1p7zXPtcavttw9mh2BUt4ElaeWSF7ZlF1/wfqrm2Su98=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67mW-0001QM-Pr;
	Mon, 14 Sep 2026 14:35:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67mW-0001QG-8J
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:35:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=saBZq4z65cKoNsKOTcvIxk01CEoKeD+O+rLFcUVQAes=; b=c/1Bfx7IAz457MfbHL+DOhlklG
 NPBTa/Vvh0of53U4LViyt7nRBkf00aWwRXlytMP3Z/VQHDFBfd5FR0QAQ30pP58H3bEaaQPis+RA0
 mDxahVbQr8FADjWxAqCHiyT0jd9WH88yBq7y5LcRqwLizphOlURxB4jGTqccOgNUhn9c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=saBZq4z65cKoNsKOTcvIxk01CEoKeD+O+rLFcUVQAes=; b=Z
 3m/VsXPJMhM+moGniL+Zc7pLHSV8lR4Lc2Mx3hsQq9DbAmqluTI9ls5t3aVWKzdSRY+o7Cra5oP8c
 gJ0Gy02E0tRLJHya6qBmZJ0ip23JWC1jVNLsue+sqClznADybjnjczeu5w4P8iQSsU3T5Qm8XDMuE
 TnXoQzRfkvfWp+JM=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67mR-00020t-Qp for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:35:37 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49e6e69d528so21458985e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789396529; x=1790001329; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=saBZq4z65cKoNsKOTcvIxk01CEoKeD+O+rLFcUVQAes=;
 b=ZOb4Ep74pB5tGlIeaUquAJFgw8tQpBkDFLpOVx63plZPbVX2gxbxg6B9WsuKPX9hno
 d50kvIhkoUqMDza2bdgM7CUxFE1K9yB3+L9QLXvhVIIadYzZH3whF/fkonl3wbzlSmeK
 iMgKZN27SL8np/gqe3ho0HAMtQDJsJ1dlWwuLhta/ZMDweITBHOWDZdjfFYb3H2RdaDZ
 qlGimzuuEa81rsyCE6hLvlrucEU5O9RsZxLFVeWagjAq3Jb+uAmaFtvG1SELZPYKV7Ht
 gN7XbFBft4Z0KM4/8z8ndoEWWFyAYOybSCRDWRX/99u7hje7capBFQ7aylrAmOiGP1ce
 wv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789396529; x=1790001329;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=saBZq4z65cKoNsKOTcvIxk01CEoKeD+O+rLFcUVQAes=;
 b=tHHweUdWX8/bGJ7Qr+rPDQtgfjMNqHZ7v8QTgeTrGEeimacCVsPxaocSD1Dq5/4Rw/
 0MQxDN53tJvKRTRKov54ccPupnjEK6GYv062G+MO5cweWmR/dAbSiT8ziAFJz5+2yVnO
 lGAetey/7W8jjV23QRAMFRNpVMe2QCcyCd12sJZ7zO+1DYEZO4G93m2+cu/pFka8iIwr
 aLp0rLeYCIcXzQl3oDaokaiyfTUo4YzcRYnRvSkBQ4W/P7FRBTd/fDjN9aAVT0sfunUC
 6tgs9V6tWSlWt2t+BnWcbQUGD/IdwW1Vi9bBau7uhGp8oju3wcLFZk8r8owCOawNW3nU
 x59A==
X-Forwarded-Encrypted: i=1;
 AKwUvByw90Q3EspKROhr0vK/UvxUyCyA3ACiP/eMu2zZVTPqbVirVIU2sRZoYwKzm1tkluQ5KdKTd7rQ240dfTwz@lists.sourceforge.net
X-Gm-Message-State: AFuF++mQL25kFnusO9UrHUkmR9qrc8MDrckWUR4Xl1xYLtIt5OvcSVGV
 13TNkofxn9BycSMf3A+nBQ/wU4MPXvkEn0X7pBehsV49rutLvRisFS4f8AT87uOx78ezeGG4a90
 JstekFp6PBbsdQYF+prLg9WNNR5y8huqMhcQLhDzAlL58N36zcJnqWf0lRjKOcp6ELBXs
X-Gm-Gg: AYBFou0H+z8vy0lHozkiJ/txo0F5R6e0DNou7DmRuLjwD/SveVl4uIHscBi96mtzxsq
 T0Va7HUPT4BJ0DZb0+0a2N6C337bs9mY8FjeBi+dqKRBd4NUFh1mTDyvKIEROIfH1JGZNcLFyKb
 u1fHrci8Rgu4N87iqpuc0D51DxgN53Z5Tq82bB9lpEmLzbbA1WGvT0NMAQg5bKWR28CIwC2pP3s
 PzkOA2rZBKieG6hXRtd21qB65ig3Gw5ORei23yE+zbbjsyhXRhWJnBe3OWFiztOE8QgS/QbwvUC
 obCcj09OUmzefl9iYMR2IbuU/iX0v5SjJJWeqaERes20ym3ZCbOa4Efsbo9R+13viIG6OFHsNs2
 1wk5CBKeCP3FY9R7H7hdVQYscW2lAdEFhTctHczvHji8Nb6h0OgkGut70ElwEtW9VJ+4Q44Hcir
 KZzOvesz2E66L9zFNybfx1TxMZFo2fhV7oQx2CgwcaMOHkxmdbXgJ4Gus7HDhI7MZYlItQBG5Ip
 vNO/8hkgXAZpKKIeZ5LLTUNHblJE9QICkKiLn3bhGLrF5TXr3zxYwhLdVEVv/RfzwrBs7CgUM/C
 dtwiD3oYRNylVReRPn+ngtIGtdkvOfAs3720U9B2nuI1iNotoSHlWwhw29TQNMAVD8HCsU1S
X-Received: by 2002:a05:600c:3b1d:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49e7a685a5cmr32984355e9.17.1789396528968; 
 Mon, 14 Sep 2026 07:35:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d28c734sm3665535e9.1.2026.09.14.07.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:35:28 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:35:25 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 7ae449254bdf2e78c59214b71fe4e36cf389e76d
X-Gerrit-Comment-Date: Mon, 14 Sep 2026 14:35:25 +0000
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c20e8c90cb245ec818467ea51e5bde564aa5aee5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67mR-00020t-Qp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 SERVER_PROBE with tls-auth/tls-crypt
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5843931826816307427=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5843931826816307427==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mjZX2m2V1Ws="; charset=UTF-8

--mjZX2m2V1Ws=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1750?usp=3Demail )

Change subject: oob: Wrap the client SERVER_P=
ROBE with tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 20: Code-Review+1

(2 comments)

Patchset:

PS2=
0: 
Non blocking: The existing OOB round-trip tests cover client-to-server =
wrapping through `tls_pre_decrypt_lite`, but not the new server-to-client r=
eply path through `read_control_auth`=2E A reverse-direction test would be =
useful


File src/openvpn/oob_client=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1750/comment/e6070c47_7d38f33f?usp=3Demail :
PS20, Line 220: entr=
y 0
nit: probably a leftover from the previous implementation



-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c=
5ba4c03ac
Gerrit-Change-Number: 1750
Gerrit-PatchSet: 20
Gerrit-Owner: stip=
a <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2E=
com>
Gerrit-Comment-Date: Mon, 14 Sep 2026 14:35:25 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--mjZX2m2V1Ws=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 20:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><p>2=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #20:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Non blocking: The existing =
OOB round-trip tests cover client-to-server wrapping through `tls_pre_decry=
pt_lite`, but not the new server-to-client reply path through `read_control=
_auth`=2E A reverse-direction test would be useful</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1750/comment/e6070c47_7d38f33f?usp=3Demail">Patch Set =
#20, Line 220:</a> <code style=3D"font-family:monospace,monospace">entry 0<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">nit: probably a leftover from the previous implementation</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1750?usp=3Demail">change 1750</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c0=
3ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1750 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;r=
alf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Mon, 14 Sep 2026 14:35:25 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 Yes </div>

</body></html>
--mjZX2m2V1Ws=--


--===============5843931826816307427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5843931826816307427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5843931826816307427==--

