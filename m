Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E61C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 02:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwIpkLQhunZjMUaShZsnf7SGry2eg0edhxaSxT4zptY=; b=Z3IFPSkxi0vnx7H6619QE694mY
	yJmYnypT34njPOAtta/p+Vc8nWBZVBP0wc+CaiTjIkVNc6D2WTTl0MZc02DdS60Vmrh7LEv+mYOLF
	POhQQGmeYIWNiylKaaCrEJPuE00U4bnaOBW1P1Us+reJUsGNpPU9/sExvxNVVOfeZeZQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnoGT-0007zv-Hj;
	Sun, 26 Jul 2026 02:06:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnoGR-0007zo-Ou
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=S05VbhLoYhpgvfEzZm1uBv4QjHqgTYtABtpCv91q/Ks=; b=IRd+FD2SaDqNdCr6vGalUMAEwD
 bq3vaxjDLJBpEI6WGdD8e1PKnxizCaMjS3me5xwBtrM8RgYhNHcmkV69W12lPc98pkgZ0U+IrJuBa
 vwCaABnux4TeI10KJ8h4ZaJU0LnOK35hGOYQoKLQb31IkdbXIr2bx+y4D0Vhppjc+bMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S05VbhLoYhpgvfEzZm1uBv4QjHqgTYtABtpCv91q/Ks=; b=e
 sf1ZjMvyOzlVGE6F6paPIiAdCneTzB+DNso/gk9HYZs3+FK5tuBfm2A/7be9fHNGRaVtjS7AOrbRL
 1dQf7Kx5er5dWjVRys1tPGsePfRY7f11a8U1z0Xgi4+Kp8yXNd5JghqD+FqXi3qrRD10c5KaN6YmK
 AjcGyOs1MCE+R9Kw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnoGO-00033n-IR for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:06:49 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso827242f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 19:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785031602; x=1785636402; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S05VbhLoYhpgvfEzZm1uBv4QjHqgTYtABtpCv91q/Ks=;
 b=feQQbQlcTs7332ishnsDnUfe/9YAyq5VlDseOnfNY5+C4oN4ed1W0RTCGKlSf+X6Ga
 PygQXiKdi1ke6iV5WfMyCUkcsnT2gAh7ocdHZKxzdswUg+I9Lb0ac8YQg9L4jQOdQOCY
 Qba7LThwWNxXba/tTL18FDqzVxvx0DgNFzESULFO/l8EFeQpvt5Q67590Bd32EPtGgbF
 ZVQNP96G+7+oJJFDD3fAFeM1X2hkIHovbwxUPomhqBI6HVxb9jwpR9pdwak/ZF8fnQ7t
 El9kf3mJAIIGtx/22AN1GVP67TGhpO3nWKM3Z47o5hAgJH641z1S8r0EYtMy3mcOVQ6E
 6yVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785031602; x=1785636402;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S05VbhLoYhpgvfEzZm1uBv4QjHqgTYtABtpCv91q/Ks=;
 b=PrlHuTg5i0QdK9h7OUWCDOY5ojjGc2pUqPv6itgUWnWVV5G3AKwhrLXeJ2d3FrLilI
 L/gU/dtfsykHU1c7gMnO9xjOcvUo6JH2gaOWZ1GRCDnowqBDsYFj7NhV3N3NEB8mG+YL
 wNYgH7nbP1vxPV3Dx2aeInYBksPJgP86a27wMlCzYhx8mmCXS2lXMUWgrHiGACPyiN8h
 nX+yyCc6Rx/tjJnB4yqY1ErGRxw7HOfxfg86o+7FoVrggQiS08glogejKi6BSbOY87d9
 UN4jGaw9x3bDAfozvC4L1fNtoICWmMkYDTXl93UbR2gP9du/qfZpijcNeqdGR5bp8yHd
 Hc2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHMSU+uREAodpFUoDdirBebPPA+wqnPLtc6OxsR87p+9LZeN65X2qYnR6yxUFoBC5pb3YRynkYFCcVGRMX@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx48C5u6h+d99xfSUk+rKLmNDemM95YkKk8N95JNJ2Etq+tmeor
 +6pSNZaYihtsBea3Rx+acFkbTUOggdYHne5dTGlCkWAdtimMskZt972DkCeYcUNHkgaPgV/vvob
 u9As++7uRJRKTd9rZ2zDv5u6Y+O7FFom8u4nTYp2kDBk4zCwatsFxD47FM4u/fhdJy4uZxzz36l
 XVse5ZGQ==
X-Gm-Gg: AR+sD12J1GSxXzZoEweO0V4Sgqj+PX1Oj13Xhh8Fp2Fn/ay4bgzTl2q+pSfJc19yoLp
 t94A2RK4igGg4wh9fMrr/YCbItoRdaYR6YTx9pdNY1vBAaiBB3H7v+ulLfPfik7oJCMjQhXFj9j
 aQitMZufJC/cMPQQyinSdYhVJt+kXcgiSsyKfOA+FPDtd63OCHi8na45QaEk6efy5n8UGhbf+IC
 Ua3+lXSnN1KS60DlO6vcJLruRXr3Yb7prW0q64tg8alcDYmxDIIhDO+ej65UANItpPbnjFSnyt6
 vX45cxKTXYvgfqX2zigZpO0FssIyE0lHuc5JSjRCDivV0M3chyVqBh3/HzNizkjgL5bH844SfiF
 rG8QC5gARRkKsXR3BuO2iUXr6itWDyVIr/uNVGgadDZ76xVws/tEGAkLJaY2B4s8kkFRjjUdMO3
 7hm9xvUD62cadMOcjckxPA8qzBdsvudViBBOT7cHmrHkMhAmjSn74/ETwU5y/DG4cjbIz9hca67
 KLCMS+BApTNqWaUv8WICfSLnZVkLUlB1Rv9sZheTg6j/W5V4a1WpTFS+77V2WqAecYU
X-Received: by 2002:a5d:5849:0:b0:476:8a:5 with SMTP id
 ffacd0b85a97d-47f9fe97419mr4254556f8f.34.1785031601884; 
 Sat, 25 Jul 2026 19:06:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531basm39203354f8f.19.2026.07.25.19.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 19:06:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 02:06:40 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: c615b953bdde58c49ce0609f5f8ca62efdbe1460
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 02:06:40 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8781c6c8d43bdf17bbd6271871b012bd36bb0e48-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnoGO-00033n-IR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9203352273782465677=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9203352273782465677==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ECBM8bvIPKA="; charset=UTF-8

--ECBM8bvIPKA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
744?usp=3Demail )

Change subject: oob: Answer SERVER_PROBE on the server (=
P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 8:

(1 comment)

File src/openvpn/mudp=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/ee3d505b_49eb3095?usp=3Demail :
P=
S8, Line 250:         if (!reflect_filter_rate_limit_check(m->initial_rate_=
limiter))
> Why did you move this check here instead of just extending the =
if condition above?
I agree since the oob reply is an extended server_reset=
 reply in many ways it should follow the same code paths=2E



-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d1083=
43d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lsti=
pakov@gmail=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul 2026 02:06:40 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenhel=
d <frank@lichtenheld=2Ecom>

--ECBM8bvIPKA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1744?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment=
/ee3d505b_49eb3095?usp=3Demail">Patch Set #8, Line 250:</a> <code style=3D"=
font-family:monospace,monospace">        if (!reflect_filter_rate_limit_che=
ck(m-&gt;initial_rate_limiter))</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why did you move this=
 check here instead of just extending the if condition above?</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">I agree since the oob reply is an extended server_reset reply in many w=
ays it should follow the same code paths=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3De=
mail">change 1744</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1744 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Sun, 26 Jul 2026 02:06:40 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></=
html>
--ECBM8bvIPKA=--


--===============9203352273782465677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9203352273782465677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9203352273782465677==--

