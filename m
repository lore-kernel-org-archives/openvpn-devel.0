Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEC9C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dTK/V1wceE0Agk5RDROHqPybcCFgegqBaPoNxp+9xiE=; b=EOa7043NJCVbiN+0OMtd0QulDt
	47so7sk/crioWrBhM1ZuAJgfYEDk+2Gk8AXenuMjsk4ZxF8TpJiOc1BYNfVi2Zq5+fYst0IZq1FvE
	hc3ubQsdK/dj4F5x1/BQvKLgUncY8mUmtCibiwu9NOXrrJimRjjYt9WFmo4i8w6X22NU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9TtL-0007ot-DR;
	Wed, 23 Sep 2026 20:48:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9TtK-0007om-Bw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 20:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kgq4s/TForL5I2D2ELY7E6NPR7lLPBAQTTqHRofay2Y=; b=TGmGjblfR3tS8+sx9b/8d9UQWU
 +gq0sTyRBVqpu29Na4HBjaOp5bHeozQCZcjwnnCmCRrzJOouwlBj+mc01C5h6bkjKWSRl00e9A0rn
 bE6pez5LPYj2UtGGeAPb+0p5ND1jrtgmFsV5gQoZeWNwhyrlF9jvunsSdUoGx8WaG+6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kgq4s/TForL5I2D2ELY7E6NPR7lLPBAQTTqHRofay2Y=; b=A
 E53QPJ/TxUfsekVKMLtB5q7SF7mD3YgxtP+1mTaZS3OS1Hfl5ILMLpRtTdCnpk72mb9F2OGcnDGvI
 oIzoRIyXCxjTDY5HK/cCIQD6I0bva4CRvzJPzGSkbrl+E07o3E8ANVIzK4t6xjxfviI2+aJYWMXjb
 OVX/4t2h/EYVcPBk=;
Received: from mail-wr2-f43.google.com ([74.125.225.107])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9TtK-00035i-E2 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 20:48:35 +0000
Received: by mail-wr2-f43.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so582777f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790196508; x=1790801308; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kgq4s/TForL5I2D2ELY7E6NPR7lLPBAQTTqHRofay2Y=;
 b=AZOu79FUGriY2GwESJT0NJnJYdsaTrTVfX/Myb4rIx58Gjjcfo0b1RBNspkEttdoSi
 tzbtfaJizMylrOQ/xro9QPqhieIMRievdPwH2R2xQI9aGEb5VFudLIPv8BEm68CtVLm/
 MbE3uDg1Q9xY/+KiVvYvd7MT0WfgUhvO+o+eSwPkEHHjE1fyqPH+TT97pzd3fS6I6ho5
 h/Tu3mBkHGNaZr514x9fNDAJGduaVdLCqkOev0BJpivKAzuJWCaKcpEbokOW3mJDzgKN
 CC4q5aFCeXButAC9asOVhVR/Y8eP1jKHjz6SAtPOLEoIUtQYjecxB27qvo2JPX5XcqCX
 fyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790196508; x=1790801308;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kgq4s/TForL5I2D2ELY7E6NPR7lLPBAQTTqHRofay2Y=;
 b=LfYHpxtLL692Im1iQb9awhFCXZqmxbGmcHq2tJK4vvcKSNonMQ1c5qksv2JwyQVoMC
 +xWd3blSSWz7Gu5IDhJELQcS+Z0zErlc82CunFLbE0rEHjiywqfljOhPM8p3H0z2O490
 qgOtfkH2GhVsKIlXRLFx+mMwe8tO5pMXpRbbUummQz7xf6dfVemax5/MP5lPr3mGkw72
 87cfHWoGI+Uh9/noUxxx5RzIwoaJK6CHcqWaQrTs+3B/87/VhL2p60IR0kXcdJuk4RFb
 Yz571QSXMLNIfxMdlXhYaW7L+zrU6EXg3wdRhZGYM1E2PTTsCjTaojhNt+v2YgKTO3oR
 tc9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByzC940BTSNOuLyiWUC/TwWvmx02lUGhyk20pz//bUWYe7/EqLFjjSDw0FJV6FK0Mqj/K6dxKow6z2Sacjx@lists.sourceforge.net
X-Gm-Message-State: AFuF++mK9sAhkkRESNEQPnZAX/inG5F154R6aQjF2CnRr5QAAS/iBPjt
 yZxoznoB1NBNQehzjqySc2ocjUvuImbjDjNBfqUktl2RjqCdivIfgSTAejY3z8/mwcxnAPqGp88
 pvIKN3p8fWfhXatEvm3ojp1xe31SFCztMAooTW0rGEhqx7fyJV4yXLhGW1C3x0IuDqVrfBhMNu8
 njdyC49w==
X-Gm-Gg: AYBFou1bAjIZWwNl+xynBY2NHpalkqi7HptSTnX+cG2OKE5lc8xaBJzSAzEj9iKFmdH
 vxvVI0IyGMAjtrTAJX2/3fWaiex7SJjnvsqsciM3rUtz1m1jG2MYXfcZ3s4H5IaQNQQJoVmSp10
 XQVMPlYTSRKTm0MScbXNzFQLoNG3cu4s8cw2IVsdgEIUYhFGWXlJSeUenuBUwmzr3IBX1PpZB81
 t1oQCCbwFchQBTUuYXc/RzpTWwg/LoS2Aevo6HDcPlQl1ECA/foW6FvpyjQwFS3AgSTNSAeITYZ
 aafxM3jD23p7CNoa9VI9fIFOJws9lt7hrJcmGbRQ5LfM8dqN4pkBgVCuMt1orkCbPrhFn/6FFMg
 mjz1pHaiwkHFR+ALnqDo68lPQa0U5GxYWZq5YGj6a8sifmEDwV7IxAWTRQhqBD4ogBl8sryatf/
 vpoOaqwwlfKrlmOtdE+mXf1HyWZL6q2hU1SJ7pCWg4BMfumaL+UotLci1wDEPTmKApSKp6wTCtP
 LdI2oyfRWv23q33Xywc1Fa4etdhdw3ffdH3WXJCBglybRdgRvDFFJrLDXv7DaY8JcUfR3pjJvJA
 jNptC/Fo29BCdJ2LX9FbUnnSQ6931NXS1C5qjRVqJ6s9v7PXmvn0WVR7x1LQsgI+VI/i1iY=
X-Received: by 2002:a05:6000:491e:b0:484:3311:257a with SMTP id
 ffacd0b85a97d-488716bf6c9mr554875f8f.14.1790196507740; 
 Wed, 23 Sep 2026 13:48:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682668dcsm10045882f8f.1.2026.09.23.13.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:48:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 20:48:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: e064870a823d64266e703fb724cb088f366f593f
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 20:48:24 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79e8e71fd39a8a181734eaa2d3066cfc349f84c1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9TtK-00035i-E2
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1862896282189432764=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1862896282189432764==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d4wEU0kTIGI="; charset=UTF-8

--d4wEU0kTIGI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, razvanc=2E

plai=
sthos has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=
=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchset:=


PS3: 
> Android doesn't actually install routes, and remove routes=2E [=
=E2=80=A6]
Yeah, my client has shipped with this patch or a variation of th=
at (the older version used to ignore the DEF1 flag in a different area and =
used more code) for almost ever=2E

It would be good to finally have a tree=
 in my app that does not carry local patches anymore=2E



-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea7=
57
Gerrit-Change-Number: 890
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: ra=
zvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 23 Sep 2026 20:48:24=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: r=
azvanc <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: cron2 <gert@greenie=2Em=
uc=2Ede>

--d4wEU0kTIGI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, razvanc=2E </p>
<p>plaisthos has=
 posted comments on this change by plaisthos=2E</p><p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #3:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Android doesn&#39;t ac=
tually install routes, and remove routes=2E [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ye=
ah, my client has shipped with this patch or a variation of that (the older=
 version used to ignore the DEF1 flag in a different area and used more cod=
e) for almost ever=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">It would be good to finally have a tree in my app=
 that does not carry local patches anymore=2E</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3D=
email">change 890</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/890?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 890 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 23 Sep 2026 20:48:24 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</bo=
dy></html>
--d4wEU0kTIGI=--


--===============1862896282189432764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1862896282189432764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1862896282189432764==--

