Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB83C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pbo0r27ANmfScPwGvqMdwykKonfIgv3AnD62FTEdr3A=; b=ft1drWHAEYp4/Q3xHztNRv0yVa
	xM3aim5ovEFb5lYrynjntgmZyoHFleOcjPdSUhexkKd6SXQHqNXe2uiMLC+Y0hVoV/Lav0zo5RbqS
	FFAhWggSSXqT5MmoTqyxxkU+1YBuTrCrZPOuhZHjV1hxfT9OMlwcExJUInzNdIFcKlVY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x51jq-0006Gr-VA;
	Fri, 11 Sep 2026 13:56:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x51jS-0006GO-Rf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JY7DTmIOp2zbZQxuxGREAmxq7GqDiBn11Xe0mQjswVo=; b=P6Jm35qORabVBqbLvgi90AS5VD
 KnDMXcgGFzs8ayVNyNgtUJZtR/CRaf9AslXUqqJ5+jYMCg6Bm0GzG1MQ6dC0/Ldy+VdTMSNhPJauY
 N9+AuVjZYRZhR1PGgfHJuZAaHmqO7oXQY4sz3SnMKEb4qs2Y8skJGI6h/x/Ak8PLpvs8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JY7DTmIOp2zbZQxuxGREAmxq7GqDiBn11Xe0mQjswVo=; b=b
 m+5VaZuKYFqmRHyFQAAFQRMOAeFXQ6EQFYlRkxm9tfIKQAk3g6V2xQcxG9haJbokOjgp4X0RBXgq6
 hUFxiBtKUTnQZXrcG+IjhmfgVoUb1yNBIyFfTPNE0PoGga9hoTzweNA9RDORenLxvGebzc0N2wZSg
 AGl+jd3Ia7AFTrCw=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x51jQ-0006br-KL for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:55:58 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso8266435e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789134950; x=1789739750; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JY7DTmIOp2zbZQxuxGREAmxq7GqDiBn11Xe0mQjswVo=;
 b=eMghFKuR+ebZlycvuvjWukMUQrqfFZQ2iSpZDDAiGtwMJChl05uY+wmM6P5FucwTrf
 +oZ/AdfXfardJlHZ9+Al0laBYzDhZvVKj9VzvoJqgsayS/6iw48aqfHyfGTGFiSQnjmh
 NQOEdohOGzGPkkKLkVHIvKIG2X5akpxl5DJETDw0QLwt28Wm5LoXup3XeqiE/t04jsNA
 Ur1UT3q7eumdK+sYK6WpivXJTssU3UfdIxF51OUBfOkM0iOTjt1/9Td4r4QgK2Ofzwf9
 tWEwSgxLkxZONlw/K/FI+yX2M65fDCeSdBlOg5OXEgQzz/NbSarL236TS3wtQoEWK3Fj
 TAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789134950; x=1789739750;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JY7DTmIOp2zbZQxuxGREAmxq7GqDiBn11Xe0mQjswVo=;
 b=WJhtBjp90VG+gnkuFKJpBBCgskLxPzi85onOvdKg/5g6rCTYhdlABGQk0sgzYzXz1+
 q7urCKse2vYaK7sjzZGQfvpXSk+Y29Q+FdEKi1M9/7lL6Z3bazqpJ0pWWgEv9o2aozXK
 +B1cUSEo1ZGqJLQF+GHrNIkgh9irIl3U8N0NCtzcHky+8pzlENl2hEjH5BJlDPIde0u3
 Tn90uKnldSLbNTx6ex5riurhzEOYU/iJbxQDWFK1+3zhEU+jVzkpc0BAU+oulcktxojI
 fAg7nNRF5U5N2a6MhztN3Cy7EHbwkJJSbWRS5gwfywEvymWCSHEN9q3NhmkptG4zkFE7
 AjDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR5s3qTZ+SvVGZoZhXJ6Zd3gxs9oxIunzx1MvSqkoCjV6aZAMC8p9Na/bzp27zVYLa5TXyoKdlkCch2LNN@lists.sourceforge.net
X-Gm-Message-State: AFuF++klbTveEI5i+70kc3hHPY4vqrL6DT76opL7pHDg0GoeM6xrswM3
 dBUU4TQ1h4V1+n6zEq9X0FMgH/4XCZTAYlisJpqY52NVW1LJ+CBR+fMLkHRluElyGSCUlMxLidO
 kk7RQKpM5L35iKm2AkJhZBuy7TzvIPxqzlK2TApRgsAjVsZ0E232fb5LV3VhaXNm4gjb4msg6yA
 nEAiPZgQ==
X-Gm-Gg: AYBFou2p9qdtKR3Ks1UzoDHSK5Aim6XBVPuRbDEbYFFOvdoABm5U7zoXSUWa14kgGAa
 Bl0wwOILhJhrFbDCdWiFCcQczboDI/0O7aT/1JF2ipDIYAgtDNU8Blpm8NG5QI3rZmAEzO4hwdu
 nfXjXVacq5/QgySh8gyHw5nM6Ipc/j6vWBRBcxqfzcZ4Qtco1CUV1w3zxEsjWaFMaSg+a3oKkir
 nfxBGtEC4GCHLG/EJYgAGdWa+giQzh+UpFIG0Vn6CEyNOK1EtS0IqPmvnK+PG1lAhnSvszKhyCT
 nbZkA2g8ooQNfrGiToVI9EAfImXLjZe6K65v/lHJxQezqW219SlW9fvfJYqzNX3tIndnh1YBr60
 4SaEwRPhrUq9sE+mubFubiJn3cCQ/7soeY0kq7FbHl7oedfU2SWc4SZ4kHRYD0kY8SunBXOAQI2
 rENtCpj6zKsVLsWY1uKk9fLCYUDypDQjz+xAHK8QIpakGLcMcbkQiv9iJnjg4OuqyumIjyezm9Q
 VjcodBWUMexqpCthSFk/Jyr2b+PMUBznwmntJd98MXjTC9NrCgoVCLwXMR7OSW7g7S/zwP1D84W
 59DW3owADKe67ZHUfbIAaXZch1d722Q1OlfevO1qJXcJMlaP7m14kNQ61PIvLA==
X-Received: by 2002:a05:600c:4f88:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49e6198cf7emr48114145e9.11.1789134949910; 
 Fri, 11 Sep 2026 06:55:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm266233065e9.6.2026.09.11.06.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:55:49 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:55:48 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
X-Gerrit-Change-Number: 1910
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1910?usp=email>
X-Gerrit-Commit: 91a8a065f47d169f28fa7d2b4b772126da5179e2
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 13:55:48 +0000
In-Reply-To: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
References: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTE0Njk2MDAwLkk4ZjJiZDY5NDE0NmFhY2QyNDRhMWQzODVkZGZlOWJiODRlYzI5MzM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2ee6dc08a81707facc902b092a0098019bfff820-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x51jQ-0006br-KL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: factor out
 UDP socket creation and setup
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
Content-Type: multipart/mixed; boundary="===============4595621766227570183=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4595621766227570183==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ttY5qgqLD6g="; charset=UTF-8

--ttY5qgqLD6g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1910?usp=3Demail )

Change subject: socket: factor out UDP socket=
 creation and setup
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1910?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
Gerrit-Change-Num=
ber: 1910
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf=
_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Fr=
i, 11 Sep 2026 13:55:48 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--ttY5qgqLD6g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail">change 1910</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f2bd694=
146aacd244a1d385ddfe9bb84ec29334 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1910 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 13:55:48 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ttY5qgqLD6g=--


--===============4595621766227570183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4595621766227570183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4595621766227570183==--

