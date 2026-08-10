Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532B2C5AD55
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0NeFhGL7uJPGDK9A3ZNwztAHxlwt6sI95jJvBvCt0c=; b=kUBSGOV5wsgiou897xedslr3lF
	q3+32vZCAQkmN+roBfVBeeSY5r2cEz/+KAMrnBwrv4cvBzCx0NNIee60ux7K+ikWt2LiXewObR23y
	QlQvz3UF9j4TpSnGdCibJ4GKEft1TmjHKTh2YmI5yvkziFwddzf7bHGEiTI3wK5NnrcY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtP6Q-0002z6-2A;
	Mon, 10 Aug 2026 12:27:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtP6O-0002yt-W5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:27:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hAkinlpPJNymX9MzEnQubIc3751gBa90B0r1AjTcPwc=; b=aNn9JSs7fDxnDfGtHf7og/+cyV
 LQu2rHgnXsAwOhvT8BuUd5XJmkOsghRLCrLeb7e+u3S4aleZMayKWuhUV4qhYiKTBGSFfWIKEhXXz
 nSoAqqv2iYQMffcueXIQymWN68XPiZgn8JPydC8SwAacRTmipJOfRj6gGhXMvMrvg8PI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hAkinlpPJNymX9MzEnQubIc3751gBa90B0r1AjTcPwc=; b=l
 IG85rwA9sX6mmVKPxmuZ3woZObycBEGyxWROBo5MAfPbBlFXLXqJpL+EcIDBKUf9XKRwX+uAezavb
 2wzSQVaNFdepsZRKrtNbsaAMvdA48L6Ed3ZB/4FANnveGy3hdmtgy7tzMqs3B4KLIUfEnWtbScl+F
 pEtKUvj7uEqrtpFs=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtP6P-0002TV-FQ for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:27:37 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1006356f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786364847; x=1786969647; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hAkinlpPJNymX9MzEnQubIc3751gBa90B0r1AjTcPwc=;
 b=NxqC/BNcM+VqgEPXGl5DBHHhoNEywmAr2nPOkf68NYpIvgAsXLmRhS3F8RgudTMrqQ
 zx18KVD15vJiE8OtjA0eUcSgR8frL180vjsg7izZiZmoRgPH7/oHEDef6k105mGG1xVz
 kZIQThWbQXtEMUjQ4xRIfYbtZO3grgLhQiR7RDeEwETHvqFbq/w9Iyd7P3VJvnW4Vl7E
 3lJ3uA78oVBe52A1jt0TJtWvaNp72EL+i4VKWC8RQwQUDXHWcGABLVABBuK8yTdgLecC
 RkvfW+rCnghSfCTfJMYobFm7NIpk+VK7HsOfuI4R0IAFrxpSxujGLT1QcAMMLNTZSxEN
 05gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786364847; x=1786969647;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hAkinlpPJNymX9MzEnQubIc3751gBa90B0r1AjTcPwc=;
 b=WVkaqU42/BG5jwgfyYQ0zFBJIf/+WoVdKZUZooSM5yAIjZkeZg029kuWy///YtU/3w
 WpBw3+GAS4qyojFYn7O1DHFAz/trbvEP9moRD8/9O28lTqPdCmWdGJYdEhiRz+QmWygV
 vIEj8iR2SG4iBwzCQ0pF/0v2gpAO1YvTazadGxQzibobhWkWBzMTUN2JyCr0Lv8mr5sj
 p31LsKyUXEKuC7vwUc7Oh5sLL9dj5EPYcdmGX0GYZi88z2pw/U3jPEs2Pz3ob/mIAn9m
 2zUGhBvqC9nymhc3q4NwVVRlhhuFv1Fc1m6LyJwnyquS5oPUQa/IoiIx/0UBk4BaihAJ
 SmsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoixLBxYx76loVGd81cgV0phpLg3BUXba/UeWtIR0Towo1il8Ld9GCdt3aXYSbFSHBVH9JdmqPYqxlby72V@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzQA0AbH/gaIigwA5xvHM77haCSYJK44QDDiX/J7+C5buvS3fYA
 wYC6tREdJo2W89kKCihyOGc9jJf3igcOvbLsn1L2Fj/5XW14Ew7SPicQzWZ5Bimzna241G4cZMR
 d/krZT105O3JNfq53RdKTjd7f5NcbSzJ9Z70GNHTF/0p5pkZW78ygSSbPHtj5Ld2D8N8q
X-Gm-Gg: AR+sD11Rlou+YgRfAkKaT/rVtoJPaxHogs3YxbBA+GUjXCI/P4MVfXa9fR/aiaxOTUP
 kKgJiaH3sNxDtv8sKfnYvx7aQ7VamndfJWqSfcROs2mGwcO2KUGjJ/4E2gwebBfj2lzKvSeWm7y
 Ug26GboHyskpCeAUd1I2JCBUY+IO+mH7BgZzHnRoEIQeto9k1R/V97FRkWQ+NicxQXOb3fFx32x
 ipdlHVKVAOjnF0ABQZBUmTB+EYWsLh1KiXkjSSTS6mY5JQqa9VJoHKrqk2dn0VzTMkrmY1/W/xw
 dTvoklVV4JG6arAFnHvlqE+6I1TfXeZSWNM6vlG8bdkxcLRMAMSE5toxl/oQFRtXGPUSJT6oSd/
 GcYVIlo1F9g+VWJStOEmRPzG1Kv/O+T76I0j/N0+j9oi8WLglbhl62l5f73otjo4381mORcHCaD
 AngQwLENpIvUcjrBhsusDk4329bx4WwoHES1XO5iM7caDv7rfVNmp4dB9bqOr3+CGlVco7jtoue
 ulSljs57ePGhoVrGdrZ62pjvcFgadx3kZYhkKGhe4X/vCwTlGzaEQwfs41mAaSBxbmVVE4Vyj21
 dUv9vt63xqJSmEoXYNLimytQNCU2SSvjmkYbWhVrO+KwOQAKm4yjTGavoFiagA==
X-Received: by 2002:a05:6000:4815:b0:47f:9c6f:8844 with SMTP id
 ffacd0b85a97d-481455d7386mr2637560f8f.9.1786364842388; 
 Mon, 10 Aug 2026 05:27:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220ab11sm36391783f8f.35.2026.08.10.05.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:27:22 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 12:27:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: 603aa9698c140d15b7464af8fb83bd2aa71da680
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d900846208315a7e719be9f5fa716b8792e47355-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtP6P-0002TV-FQ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============7445811148966129708=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7445811148966129708==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p6LEDTCMMFg="; charset=UTF-8

--p6LEDTCMMFg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1837?usp=3Demail )

Change subject: Reenable xmit_hold when using p2p t=
cp-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Reenable xmit_hold when using p2p tcp-server and tls-server

=
Commit 619c3e9 changed the logic to enable xmit_hold only
when c->mode is C=
M_CHILD_TCP=2E This works for --mode server and
was probably done to allow =
to properly work when the server
is listening on multiple sockets and optio=
ns->ce=2Eproto cannot be used
to determine if this socket is tcp or udp=2E
=

Restore the logic for p2p to avoid both sides starting sending
resets at t=
he same time=2E

Github: closes OpenVPN/openvpn#1089
Change-Id: I728067ef08=
481c87c7b6918c88ebcaeeec466534
Signed-off-by: Arne Schwabe <arne@rfc2549=2E=
org>
Acked-by: MaxF <max@max-fillinger=2Enet>
Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1837
Message-Id: <20260810114212=2E28379-1-gert@g=
reenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38265=2Ehtml
Signed-off-by: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
1 file changed, 1 insertion(+),=
 1 deletion(-)




diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=

index 69d226d=2E=2E08278fc2 100644
--- a/src/openvpn/init=2Ec
+++ b/src/op=
envpn/init=2Ec
@@ -3332,7 +3332,7 @@
 
     /* should we not xmit any packe=
ts until we get an initial
      * response from client? */
-    if (to=2Es=
erver && c->mode =3D=3D CM_CHILD_TCP)
+    if (to=2Eserver && (c->mode =3D=
=3D CM_CHILD_TCP || (c->mode =3D=3D CM_P2P && options->ce=2Eproto =3D=3D PR=
OTO_TCP_SERVER)))
     {
         to=2Exmit_hold =3D true;
     }

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebc=
aeeec466534
Gerrit-Change-Number: 1837
Gerrit-PatchSet: 5
Gerrit-Owner: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinge=
r=2Enet>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--p6LEDTCMMFg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1837?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Reenable xmit_hold when using p2p tcp-serv=
er and tls-server<br><br>Commit 619c3e9 changed the logic to enable xmit_ho=
ld only<br>when c-&gt;mode is CM_CHILD_TCP=2E This works for --mode server =
and<br>was probably done to allow to properly work when the server<br>is li=
stening on multiple sockets and options-&gt;ce=2Eproto cannot be used<br>to=
 determine if this socket is tcp or udp=2E<br><br>Restore the logic for p2p=
 to avoid both sides starting sending<br>resets at the same time=2E<br><br>=
Github: closes OpenVPN/openvpn#1089<br>Change-Id: I728067ef08481c87c7b6918c=
88ebcaeeec466534<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<=
br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1837<br>Message-Id: &lt;20260810114212=2E2=
8379-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg38265=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=
=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index =
69d226d=2E=2E08278fc2 100644</span><br><span>--- a/src/openvpn/init=2Ec</sp=
an><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3332,7 +3332,7 =
@@</span><br><span> </span><br><span>     /* should we not xmit any packets=
 until we get an initial</span><br><span>      * response from client? */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to=2Eserver &am=
p;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (to=2Eserver &amp;&amp; (c-&gt;mode =3D=3D CM_CH=
ILD_TCP || (c-&gt;mode =3D=3D CM_P2P &amp;&amp; options-&gt;ce=2Eproto =3D=
=3D PROTO_TCP_SERVER)))</span><br><span>     {</span><br><span>         to=
=2Exmit_hold =3D true;</span><br><span>     }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1837?usp=3Demail">change 1837</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1837 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit=
-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--p6LEDTCMMFg=--


--===============7445811148966129708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7445811148966129708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7445811148966129708==--

