Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB91C79F8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZvnigrapRJxWsKGZ518j6qcC1iVtT+znz1INjzf0pi4=; b=j7MdtV6EhVtw/sUOMKzwoGW3ut
	ZZSEMqvaQrlhRQhukoyc1AceFTW9Dlkavho2S0Yf1RC0APQ/o3eqpchlqMDbWNp2OdbGb4soGzMM8
	lXvg+G5lDzQIOtAbg0zsPlCiOcqv2+j8Y3n96rGZ6PRtLNndIYwjIoemh60zKVIMkAkg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3Gmj-0006dF-2D;
	Sun, 06 Sep 2026 17:36:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3Gmh-0006d8-DD
 for openvpn-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 17:36:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TtWhgtQIdsFl4+7/di4xEzrefn/Cztaq/BSDIXHXIkQ=; b=OLUoxpxQIMrYSMAgbKoQ+CvvT9
 8p1E8jBuDE5r9xEl/q/dD2VpaYk71kagAqmNMrVO5hp3VtZcJh5bt9yFsbmO/Qbae+AZIZhA9LQX4
 W2vTUNIpkJZOohUlmnwA/rWLqsjfdIr4Q3cvhVYUkgQreSiL2kfc3jOP209vjwdlmxEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TtWhgtQIdsFl4+7/di4xEzrefn/Cztaq/BSDIXHXIkQ=; b=K
 x+cf1+aNYCsp1+vp4Y++Yh8wIHLJ/IxLIZlmeib7X5t7GqtYi0ZhhTbbpAd1BF7X8Cbsg8m/RoCga
 EK+QeqdEg76B0b23yujs/GV+7gU76THJP/aJC5Ws6qgEMIkbOSKUJ9ad3X1lmOwrjcU/w5GMRT2k2
 c6e+TYaFzkg4WtoY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3Gmg-0005cw-0H for openvpn-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 17:36:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso41167875e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 10:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788716155; x=1789320955; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TtWhgtQIdsFl4+7/di4xEzrefn/Cztaq/BSDIXHXIkQ=;
 b=NLkBeFIdrSEBHUjobTvTS+KMSZUbhDNSz8tjovfYcVAXhSRtGs65jUyAPL0zSgZBaW
 ps5OpNqzsDP5WdfWKOUZf9aeIsxLFpbpnz672XDkrUjsCLlS+hWhuz1JDc/3n7LH6Zwz
 nTrjmtXmwCZxNcQDIP2JXwBSqitaWdIQaruNPM8EwYc4OY82hsR8NctB1u6Y9SNemksh
 nDvUJ6JWp1QGnz43e1Re9S8s4ZbOLNhMO7qdIy9uKRolQa3e9/1mWeW8mdQEZo1gt+Dj
 EwNPPWq1rGhFpmXpxSKHuvLhLnBPaQkXbYE30aRTElbWjBy6VQ9xb22FTnnQQeIb97J7
 4+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788716155; x=1789320955;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TtWhgtQIdsFl4+7/di4xEzrefn/Cztaq/BSDIXHXIkQ=;
 b=Tpmw4Ug4mvxngiiAEOo1xAvM4Sv1l46oBlPgbsvcv74Bdn0oF0gxILfpYfmoF9JiT+
 080N4kQO1jZB88643NHSVed7QUg/3yTyn1CXSai3Hy68KuZpzH2ljXCpIyxrqhvSMDkC
 zUCzdSxUntO4p3VlfKD+9G3eQyowyo0Tvucz2PTZWK1ZqjbSbr1pt8+fLQ+ObBRBUqQn
 L8zr2pMC9ShIQmP6OdDKyqsoQxmWyazk5OzxTt+T1sBgqlvbhuTfBtALwWcCRpkvku6A
 hXD0daj0lgP3yckYLaRmLsW9+nv16zYQmmoqVlPvOOQovwyohh984dBTVQMsVpcJfX7b
 A4jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwl7yNzC2cAcv7GnPjpIX1shUvLl3N4ABaDMgNiUytBoLspWhE926Z+GfDkiqWQaWAnX+FCDRxMqbJ60Unu@lists.sourceforge.net
X-Gm-Message-State: AFuF++kylEqX0ga4N8406/lcd+tFNQWrSSOZUIjWvzSgUXndPUhaJWme
 RMXG8UcYz0pSwBiq0C5c/nmwLH5K0cNDPvS58MBZChQb0w6nTpd01Msis7uqpuI/VxahrLLE5RQ
 8raFjtq0vZ5a6fMGLRACgUR/E+H6L7eX6Y1YaozMGD9Ahm4iWoLEulakWgd/UqLRTveBq
X-Gm-Gg: AYBFou3EoV+bBYC26FVOs2N9Cw81Coy2myU+xFJVWQz/I/A1aXPSFCTesvuDRhuorjL
 Z4OwI3wQCZo7K/kdXu9+Vok4B/xgHJZ3t0wMr5Okw9x1u0hi4SGtMffigxORk7yG6ncWgGIglHB
 aJo1j5E7mw6nwczB6K9VpbxSMUi8XX2/1iITVHz4GknWCFxpN9TQ95M3WnoGLICgIJAYVW3Hokz
 kUFuyl4FTtu4mbMGaquUSdMyvEcdKsD6g6pRevSmmuOJ+73vx15bk4uExwzLcL+vOUk4UEJu4qa
 sjVcnne2xpTA6Xdflx6UvLWzRI1g+mhOshCXZkQz+ynzuQeYdqbSy/ILlugbGgM/m7KmTCAG4GC
 9lYStf3i9q8tcG3Lg9+jDWX8tD0ngwKm+v+505+9MbhOi8lR4mn6M5T6gj5K/hhdZe7mPddEQ6X
 fC5xuOqX78xSQUjMsP+ozz/TIm5HOxMKW8jGGsN9AolwYRM7G1bTR0ix1MtTLbvrQZy4J+kZPTK
 7b/spF0COVNcUHGYydiKh41IJRsUKoXR3Tu7caWaE/j304xI1QEOgkN21fSmM/KzIpe5JJLSMwZ
 FoE3/ZgqyLg6SumcVRm+DJT4PAOpmvt4517P1ZBcRtg1dxi1tYc=
X-Received: by 2002:a05:600c:8b6b:b0:49c:e1cd:536 with SMTP id
 5b1f17b1804b1-49cf826be5bmr179616165e9.12.1788716155236; 
 Sun, 06 Sep 2026 10:35:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff8195ffsm188581425e9.14.2026.09.06.10.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 10:35:54 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 6 Sep 2026 17:35:53 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: eda13e5920b005cb50abb11bf776bb8e7cc32fe7
X-Gerrit-Comment-Date: Sun, 6 Sep 2026 17:35:53 +0000
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08bf10835dcc75c1abc7b66883c36d0a50039700-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3Gmg-0005cw-0H
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for null-bytes
 in certificate subjects
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8955733688548191427=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8955733688548191427==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="obS+YrTGJDc="; charset=UTF-8

--obS+YrTGJDc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

MaxF has posted =
comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1898?usp=3Demail )

Change subject: Check for null-bytes in certificate=
 subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

Patchset:

PS1: 
> building the unit tests with =
-Werror fails, at least on the Ubuntus [=E2=80=A6]
I don't understand how t=
his happens=2E They are defined and used in one function, and there are no =
ifdefs in there=2E Are asserts not compiled in the mingw build?



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic334518048d6ca57a504257e2104=
67f9c451d268
Gerrit-Change-Number: 1898
Gerrit-PatchSet: 1
Gerrit-Owner: Ma=
xF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 syzzer <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: =
Sun, 06 Sep 2026 17:35:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--obS+YrTGJDc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">building the unit tests=
 with -Werror fails, at least on the Ubuntus [=E2=80=A6]</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I=
 don&#39;t understand how this happens=2E They are defined and used in one =
function, and there are no ifdefs in there=2E Are asserts not compiled in t=
he mingw build?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">change 1898</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic334518048d6ca5=
7a504257e210467f9c451d268 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1898 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@g=
reenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sun, 06 Sep 2026 17:35:53 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body=
></html>
--obS+YrTGJDc=--


--===============8955733688548191427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8955733688548191427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8955733688548191427==--

