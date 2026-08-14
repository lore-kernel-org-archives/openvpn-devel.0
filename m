Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C605C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CElrEfC8xoToZA2uYHi4EoMYMxi0iERS2eJN5LECPMI=; b=hYFb/j6xwuy/9UP8EuG+2Had5U
	c3moi20WH8VrA7hLdo9HkoOIDdbhyJxnbo9BXkytGZ41UJM0evRiwtk10DdFLCrSx/TeTcUHHwNf9
	VqpyFBxdF3/FqvXpmZ5m5aXtCaXuLwTDi80e9aI5u5oHvaKjVo2suyqil+bNGBiX2ano=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wunHT-0004ss-KV;
	Fri, 14 Aug 2026 08:28:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wunHR-0004sm-Ny
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:28:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Jh4BZZO74DTZrkV72NIKVvCSltDjj1FkoIOosV/Komc=; b=SQawYCj4PJWx4LSL29xAk9XdLp
 DS8Q8i04URFpWoODUseuBmqE8b5EOfbvQ4emBPGfv25PufsJkyWF4/63rnGwoDn8B0iyfBHskwGZf
 tlgZgMFAYPAGmpjV3SeiTDUaFaDP5mVWoFhGLm2ABFaIUMr7Ko7gwu0MihYgAOW/+zC8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Jh4BZZO74DTZrkV72NIKVvCSltDjj1FkoIOosV/Komc=; b=I
 zpAognPj+Zw3Hi/ACulazlVyAQvJjKg2oPAkTqC9Wci0d/HLqgXlw/+EXDdMT63vdP2PRXqUKgbsN
 zcwb7/Li+0o5pRolvcCZd4yxosmmTt1oqm0oAOlgFlDZXIHLnRO1NE2jsNbz1NRadmOi47lJOD3wC
 kFf5vBTPqu7mf8AM=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wunHS-000625-MP for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:28:45 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so643769f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786696116; x=1787300916; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jh4BZZO74DTZrkV72NIKVvCSltDjj1FkoIOosV/Komc=;
 b=S0FvUHFQZxQ+l7fdFc1JSJPibVgfw2++tHWAVAGtrcy14CHEJGYECLJgwtISXc4BFJ
 aEeopPdt5SA25h8ZkDMSvkhiGCD3zGCFOS+c74ipapW/BygcDiDfjhOPSJPwlSDekEZx
 xe0tkeTkVTB4DqxGkzd4/FclGvbGQdqYThK+pB3lySR2r4Fj/WjCIDj9/G/p4+81gSE5
 wr/iOfMzu0nRb2vCl7DwHvMvdaCbEoZThbRRmt5oaDvm74HiXQavxCyExEDKYhFm6nOZ
 dekmKNp4h1s7tQeLOok2GubZfIKiHA528Bn2Eb7rCzAv8sVVca9dYouTLYgfqKemwKsg
 pR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786696116; x=1787300916;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Jh4BZZO74DTZrkV72NIKVvCSltDjj1FkoIOosV/Komc=;
 b=aJpbiBEfm7zRR9P3uQ5aB4ppZsg0hsewUch+u9O9XHx3hHq/nYH2DlAHxpo9duHp8a
 7bRZ5BVqv5WcVpfr+CA39wVAn+a/rqDilSR6QlahraV5mJutoVKGlfODNqidgcBHYhv0
 KAtwLunm0NaHaoACzuOkHsXMgY69AxCairCy6O+iZFyg9uBDEAC8Y3ZFqIp1msDLVhPU
 owplJuUPOObXyKUFh8XRQuPGzytsojsbVZ0bPmxdg7yjvg27NaWy1GLyK6x5xbcPdkJu
 smlYc1vUeDuo6bv6GuiPiNDVwTe3Kjs/wxz+Lw6RM8rRMOtFnHlhoQjgkbmQf2EhHlAm
 OtZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpH7vU+vEJUHyllr4VkMB8mlUSzNl3RGzMpcydx6QsCgiVDl5KXirHKjdXx35qi5COleZK3EnyXKv3h6t+x@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx0dr6/a8w8FHKVQeVGoJFcqEkenoWJcAjpJXFGxay58eB+PJ+k
 +pI6TW6D+7tzSTA+9T9576L0he0TJn5ILvftbgXPGXzBPRQLAaDQhfUMes8f8gqyDp4es1oDb8j
 4w0pm73qAw/pQFg/83ncb//rqrL6bovwBBYFKdD3L5/9gxFQ52dTyQgGdrWEb9IV7JIrw
X-Gm-Gg: AR+sD10W9idAETAubqcXIWT+MIAOCcB6okG/9I24TV0XZT2ITjhGdJsnGbLtJqOD1Nq
 SJYj6WEshvAp2LBn/fgf2O9iEa7kvogoBpc/nu2wIwTJNT08myvpwxw1otJvaT9Edp9gO+eDZD7
 gcQF58B9LfbTiJizYq76ei5AWry6Gd0Ytkm30WqnO8UElac4/XsSVOy6Sr9BFDzqrzUlVxecO6q
 C2KciSyzYtqfY1TCrtIHoBYUfrUvA8Iix0Xf8KuOfp9ti79LYuXV5TrsSXZ6mFy0n/4G2ACtV6Y
 g+7q8QVS1lunFJWPqYO1nJ2vZrhBcwtDOJRqgID9x1UVqqnXlxk9CsL/jdB/cEQCwHbCID73Nea
 LMkRytEYKd/07NeIbbHuYpn+z3HApVNTZ2nK5C3b/N8tSGyYcFt9dFANbkPzxNPDybGVDxxk7gc
 5J7bXk/6K7ubXRv/IWjA043FVbznbk9BUXKsBGd02AizSohhI0A7ixEJyI1aSHvup1LmCq6WNbY
 NvqBW4vDONqRMVreLyYGA0PKRl4WgVGHObBWTdZRbw3qYhdzVGQcbsAM1FyHoax4kccFT4be2x8
 6FI101hP6ha49ux/gJxHvTg07VruaXKemGeCHM4LaMWNzw6dnzU=
X-Received: by 2002:adf:e198:0:b0:47f:96e3:530e with SMTP id
 ffacd0b85a97d-48160715c21mr6229699f8f.8.1786696116385; 
 Fri, 14 Aug 2026 01:28:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1fb7sm6680833f8f.17.2026.08.14.01.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 01:28:35 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 08:28:33 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
X-Gerrit-Change-Number: 1151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1151?usp=email>
X-Gerrit-Commit: b609470e7d0d6d80081897b55725e09f75e403ad
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 08:28:33 +0000
In-Reply-To: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
References: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODcwMzE3MDAwLkljMzA2MTI5NzEzNjdhNGFhNTRjYTg5ZjkzNDUyZWZjMTcyZDRmNGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eab18667e04fc46cfb5b52d2aa4228e5bbda0945-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wunHS-000625-MP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Introduce
 boolean_flag() and review usages of atoi_warn
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4822313950526279213=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4822313950526279213==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pgIAertXpV0="; charset=UTF-8

--pgIAertXpV0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1151?usp=3Demail )

Change subject: options: Introduc=
e boolean_flag() and review usages of atoi_warn
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 9: Code-Review+2


-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc=
172d4f4e2
Gerrit-Change-Number: 1151
Gerrit-PatchSet: 9
Gerrit-Owner: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026 08:28:33 +0000
Ge=
rrit-HasComments: No
Gerrit-Has-Labels: Yes

--pgIAertXpV0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 9:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail">change 1151=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic306=
12971367a4aa54ca89f93452efc172d4f4e2 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1151 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 08:=
28:33 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--pgIAertXpV0=--


--===============4822313950526279213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4822313950526279213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4822313950526279213==--

