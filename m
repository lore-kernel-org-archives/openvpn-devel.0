Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791A6C982C1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QwE/4hEWJI1fZ1Gi+3Aw/aGj5qTmdEVgxCKIrhy5l9U=; b=BI/ORA87aEFWtWPLH9plY1c98E
	+Q+pmYC7hAaz9uO1+Tts1SPH78glu4hsS2lSBV5XYPTtxZRvSU7+5e8hLe9B9dpbPbc/WwiK+d9MK
	sL9x3DV+AeTrfNdsWHNlpM8iwgJnqQRXjA1ToeJMsuUuLoWbZK1OGLIH4NCRSK1j8154=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x772I-0008Di-A9;
	Thu, 17 Sep 2026 08:00:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x772G-0008Cs-Hj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:00:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JP2W073AMWnHC3MoMCJc5eQjo4m+Wo+vl9K74fh3Dw8=; b=JU2y4YFMKr4gGXhJ1S+Ffz4xLR
 58j2Fw9TId0gq45pDI3fNiLwziKBK37pROuqOSanf5GOeLjJRpyDRqP8wcBoiEU/+yUWElwOIMqei
 uCCqmvLRcIXImnfzBLbEvDJr7+Jva8nPTlZs4Wrw9V7NHguKR8QiEaRN+irRGGiMytt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JP2W073AMWnHC3MoMCJc5eQjo4m+Wo+vl9K74fh3Dw8=; b=O
 ajqTVG/mjMb1azxYGHK5lpIlB93MsqIxa+hUbBn4Erib0Qzm/fRInyHRmjS6XPfLFvg6W002QBUPk
 dlz+bWIz5S5ialMpwt0zeWynnF6DSZY7FtotPRSWWyEWjEyHYpkuaVY8l8jxaFkIeqeGrMiNUSUtd
 TQyV/MaqxfNo40Ug=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x772F-00081c-GW for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:00:01 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so2741355e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789631993; x=1790236793; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JP2W073AMWnHC3MoMCJc5eQjo4m+Wo+vl9K74fh3Dw8=;
 b=VdY2IYiHiL801jHcyxRmfhbV1JECDEdDRqMOEIGMMLuCNb9AHwA+kAcpZOv7N46zG1
 wuyUez7MpnXuSODD2wuhWDkt9KnfLgpk0lZ2lOMeNx080/Q3sM/oEeN1QwzXMIS4sFp/
 UUbgfSH/ODIUDyNz2+dS/ro6b/RVTX0SB8h+GH7bq65O+nLr/0WRAmbzhVr/mSoXZwTS
 qvrfLTx6JibAZapGOupv25Laze2EuWpfX/47zkneH5dE2tTKuulqh62Eg0tRCiBip13C
 RekvvGdqzBrg9iYCH5iQj/J3KLwiscf8YABlG6bEkConYPqO8Y62xfLSj6qjpGqr0I8Z
 hlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631993; x=1790236793;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JP2W073AMWnHC3MoMCJc5eQjo4m+Wo+vl9K74fh3Dw8=;
 b=Irbw88UQB8zh7E8zZ0FOd/a0nkPmghio0xzSUaACDdRIP/IPhYEei2xiXkm55hCnD5
 qy75wzuCO9T8NLypmqgkL1dLGYRaRh8LXY3JB0Z5LqrP5peyANasegwdndADTX8FgjwJ
 6WekcyQSgiPlIGspDG6pEq1NPA5ryesi9oaxseNpZFNKqNYgAjcQNVqUrm/5MtnOCePa
 P2DLO1Ng9srB8LkjaDM/qdJFY+xDr5R6iSNq5LU0r2GEkxiq2TzlmNEEOEazmivc0oJh
 1XTNiKkZYP3GaSpeLyhYncnYbpYEY2mUfIZ9bBTWK4OTBaEfCUznW86wOHf3qL2bHcX9
 sDbw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnn6BZfzKWrjFN9NrJ/6nBjykusNyJYysjmswcJFanEr57B8LX10wbTpkqs1FO61xXSEi8tSEf4vpQDzfW@lists.sourceforge.net
X-Gm-Message-State: AFuF++mjjbfNJaaXIekMPl+e67FRI8B57Zqs58PjtLWrjCPdSyaJd9AA
 bg+bjusuXSrU3U9BT8N4AWdsld7XKfRYgus3klIib1lDSieCCueeRQ+OsKQYO2ztmvWF9AH9gk/
 MsVvb/LPBtDMm6lqEbUJoZ93f4lOMiAh951O4flaSNXs72aJEBwX6+bHg/d+pwMNdkv/1
X-Gm-Gg: AYBFou2+w3tZyBuDlke40pzB6IFNe1QglXxPedCPBmDhBj8zQzj5ebaUsY3/IHX4en/
 fXpsyVU8RGW8erxIaOI/TgbAUKD6OvkIY/UkVZfIqG2EwH25eJJaYo/NrUkx1pbxvYQAmOBt3Z2
 Q2D/4u7tDBQCeYdt4/ew5kp0YaIRhN9SgGEQrykPmUYZy/2aXM3gUQaVB0Jvx9ePp8abWLh0X3M
 iyM+yno5QI+ufMQjazwEt8XID+5I4Ig4ygKmY74GwbqHVqv1w/4WScwiC/mBULh5M5gc8w87lil
 FncRABlK49J7QUlYv7XuYaR3qfAPrEBvspgxvg/OsOYe0gJoVS5NenYFBdJDaC4282komX6hXwZ
 BTHsxpdsh9xtahuWdhWcURz1ZpMf3aWDvcUZ58IdeC8XScprr2j+txJBqOTKEXs0nA43Ecg0/Ec
 qf9r5oerV3yiUEwBhPO/hs7KruWH+kAd2d0XSmKuK7b8QMocG58YO9jelGclagTu18al5ZcO8Hu
 72sFv4OMYGBJAMQ9s9HTVHn1eyB+rdl3Zd/LB0x9MyIQRIV6WnBwcOZcozPXKT93ANnvaFHRErs
 9mQiqpk6gNvEJjXVHPcBB3bF7MT0M+SPrg1UvGXgNKUJAhbTaYL+0CTvpc5DRg==
X-Received: by 2002:a05:600c:1913:b0:49e:816a:9bae with SMTP id
 5b1f17b1804b1-49eb733e538mr68020425e9.28.1789631991873; 
 Thu, 17 Sep 2026 00:59:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd232bd9sm53741315e9.5.2026.09.17.00.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:59:51 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:59:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 19e9f522e6ee47792e065ebaaec5880ae78957be
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 07:59:49 +0000
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb9af9cf51e62948daa90095d76498101844d489-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x772F-00081c-GW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1725832761091729791=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1725832761091729791==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/UGvABtkcVg="; charset=UTF-8

--/UGvABtkcVg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1748?usp=3Demail )

Change subject: oob: Measure probe RTT for ca=
ndidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 24:

(2 comments)

File src/openvpn/oob_client=2Ec:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/7c8ef95e_86b86be8?us=
p=3Demail :
PS19, Line 274:         results[i]=2Ertt_ms =3D (ms > 0) ? (uns=
igned int)ms : 0;
> Is it intentional that RTT is always measured from the =
first probe? `targets[i]=2E [=E2=80=A6]
Deliberate: a reply carries nothing=
 that ties it to a send round, so measuring from a resend would make a serv=
er that lost the first probe look fast=2E The comment at the send says so n=
ow, and since 1751 the first-send time is kept per address=2E


http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/e3b356c4_6521d091?usp=3Demail :=

PS19, Line 583:         openvpn_gettimeofday(&targets[i]=2Esent_at, NULL);=

> The RTT measurement are confounded by the serialized operations that tak=
e place between the send pha [=E2=80=A6]
The send phase is only sendto() ca=
lls =E2=80=94 resolution happens before it =E2=80=94 so the gap between the=
 first send and the first recvfrom is microseconds per address, not tens of=
 milliseconds; the comment at the receive notes that queue time is included=
=2E Kernel receive timestamps (SO_TIMESTAMP) would remove even that, but th=
ere is no portable equivalent on Windows, so I left it=2E The duplicate-end=
point part is fixed: the address is sent once and every entry sharing it ge=
ts that one send time=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Change-Number: 1748
=
Gerrit-PatchSet: 24
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ra=
lf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 17 S=
ep 2026 07:59:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Commen=
t-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--/UGvABtkcVg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1748/comment/7c8ef95e_86b86be8?usp=3Demail">Patch Set #19, Line 274=
:</a> <code style=3D"font-family:monospace,monospace">        results[i]=2E=
rtt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is it =
intentional that RTT is always measured from the first probe? `targets[i]=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Deliberate: a reply carries nothing that t=
ies it to a send round, so measuring from a resend would make a server that=
 lost the first probe look fast=2E The comment at the send says so now, and=
 since 1751 the first-send time is kept per address=2E</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/e3b356c4_6521d09=
1?usp=3Demail">Patch Set #19, Line 583:</a> <code style=3D"font-family:mono=
space,monospace">        openvpn_gettimeofday(&amp;targets[i]=2Esent_at, NU=
LL);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">The RTT measurement are confounded by the serial=
ized operations that take place between the send pha [=E2=80=A6]</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">The send phase is only sendto() calls =E2=80=94 resolution happens b=
efore it =E2=80=94 so the gap between the first send and the first recvfrom=
 is microseconds per address, not tens of milliseconds; the comment at the =
receive notes that queue time is included=2E Kernel receive timestamps (SO_=
TIMESTAMP) would remove even that, but there is no portable equivalent on W=
indows, so I left it=2E The duplicate-endpoint part is fixed: the address i=
s sent once and every entry sharing it gets that one send time=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1748?usp=3Demail">change 1748</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1748?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a=
8bb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;=
ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Thu, 17 Sep 2026 07:59:49 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--/UGvABtkcVg=--


--===============1725832761091729791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1725832761091729791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1725832761091729791==--

