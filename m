Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFA0C79FA1
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNaYQMaQnZJs7GPLcMJP25PRM/QM/4ADpBRBOtRljsI=; b=TrZqjV2fs34yjJ/DuRPZK6fhEI
	dS5Fe0xduDO1HCRV/zUfRl0NhtLcM90U7ntBoX88pPMs52Xa5n9UNzB0tbH8+B/28ogVvYAMY5S5I
	sXo2fPQMT/Muz5NbLhd8pxbmXXlbDK8IDfdONcRglaHa8qDdWQZYvCbGxfyt64QqulW8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3auD-0002AZ-NY;
	Mon, 07 Sep 2026 15:05:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3auB-0002AS-Uc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 15:05:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7bQ4b0PZ8HyB8P5+ch9SWo5ZyIgp8CO0auQVH/+CV4o=; b=Oz+4spYy4aOB0ASKA3CAPYiBoA
 OwE+CxLUr7hQHKZWY+qV1aBXq9Fj4gypc5fnapxZdbKbOTLHh4Pydpp7yFnXXIV9vIYqqU58YhVfz
 l3qb6mS6JA3Dgkz4Vfqag3NfXipliC9+qoa57ygb8oWSfUZQu8WvRuit/8i0edFrx8JA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7bQ4b0PZ8HyB8P5+ch9SWo5ZyIgp8CO0auQVH/+CV4o=; b=m
 rLg5IpdcJBM6dRKrIfWI7Kxkff5oq7/DC67n0qFi2awaGyIEyS3VqelOVmBEYp+YvjeKQTIOIm+IK
 ifxedgHonXm+2Bmt/bPWuWIXhpGmTDq3Fq6yw6iUURDkkVBS7SDAMG6X0zX0OxpDWjkhTiDVGLouC
 tD0BcERLys4qaSAY=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3au8-0004N3-PS for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 15:05:05 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49557167508so44475455e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 08:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788793498; x=1789398298; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7bQ4b0PZ8HyB8P5+ch9SWo5ZyIgp8CO0auQVH/+CV4o=;
 b=TKXUGZYuE+PYcklY52aybup8Ni8TpYfhi3utIUSiF+947oiJkQieMVLCmRHLv7IwfG
 Ei3Xhr2tqoWKFO7EZ+ZReAIXb9s9VzPnyaxh6Abv8J57nLLL4VK6BvPumgZI7IiYRazV
 JItwlTVulL2EDPRsD1n81fa1V47H+Wncd6WeJZfmFzb7oNbbiPxgpWsIFd+ObIeC7iWY
 4AG/9p9tRuQj/TgB5dpm+y/lxymVvdkT5Sm5lsrGq6X8LxZuJ4gwaWncFnfAgevfQGB7
 nHobsoxGn5kb/M+Flzg52EmdEIdgZ5c+4TKFzlX6Zx6lg8vxfDoIHtOK1CMRKu+px7i4
 Kfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788793498; x=1789398298;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7bQ4b0PZ8HyB8P5+ch9SWo5ZyIgp8CO0auQVH/+CV4o=;
 b=CRHbeZluNjQaRl5qh6jtV9IGv50wPpLkq+b9LXQ2qaXWjffW9st0Udsb+RCk3+rO3q
 o2nnBSzfDMsDkoiVeu4E37UAIUg5jj0j0t5hdB35qOoPLpBNaOYYMTmIwGm7O4Ko8hn3
 fsugDswJgWh12dOay1OAfQcxrF+V24mdVnQ78W7ZG7llhSei+XgwZ9g/4Yj4VGrkCL8T
 saFVQiaaWwHFBq5xOCXWVPytLozo+WS9mvK5q40IMkQkhKGUwt+Zia1ihGnSoXUo5IUQ
 ae8EOYZViyguJE2we9buzzLGZqIFG0AztzOHjsY1tz73FGu2IyUfroeNAJDbperkM8EE
 y5bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRqkDOVc1UOoWIDDxynReBZRRbTbAkun/EcN9DiVyADeRTPKKRL/eZHM9bZCANIs39NkJhz5qImKuGW7X/@lists.sourceforge.net
X-Gm-Message-State: AFuF++k4Yxx6I/fXIv3xZse8P3SiN1aquIfSJT7KtMTy5CQmSxNURbur
 N+50Z2F+lIls0SC2xJNC+upeqX87+oZW3GSr1Erjq8jRU+GCVTXO1gqmpetw+3zr1KUzi5QyQ5J
 d+DfEMARSO3JxXabnxJ/xIK1qIpa1nz1qb5HU5QtvAXFBfa2+d8dehbLT4GjPm8vipC4lhjMtK3
 n/Dur7Og==
X-Gm-Gg: AYBFou3yEiFAOyI7Iax5CJdekkSF0qkHzCB651EU4z9IwUp8HjeAHdS1cHCR9AxlyIS
 NRmTk9mccrzueWD//0f3s8hwy1U/iX+vkht0PdYvvSr8iBXHMIq1cit8IP6eyCyDXB21KdecU0d
 CcSag1TiRzvk4M7wxqatRIP6PtOew203xwHqXDxAPm2OfMA/YdyhhIKf4Q1klcln8qG7mH2Yud7
 s3AFkADmYWL8oRxFwARPxW8qYmuOWSVtbtQ1l0zjRtUpvURdtAQzXfg30jnnyKsUWDYoAnGzi31
 CkAtTPAtpr2Zi9bV6b1ARUg3CpIuyOhzGdbn5JesyzVa1y2tx+M4Wnr1SNl62EGWvQAxfDqmKUN
 MH9FXVxjIwrddLps5de6ng75XLjRYKju0CmpGL97moB93VPgJ6L0hrN3EaQ721/sZiBDAg+RvUW
 c/cipnU0WGACcdISWxgqxBlBdwSMTEr5NHiieIOtIgSyPUrLni6KgmIwQCDNOJZNaMofozvFcFH
 7lRo2QxQwpgUA7x4g/umUk9LkHelm4bQ33xYMpXmTRfhxUoDJ/X7S+AyPiE0nHDGr3l7V12AUic
 IpcxbsxPUbFacPmif0q+avmScf+VGrjXcaSma8A5FcLIDfh2oWA=
X-Received: by 2002:a05:600c:4712:b0:499:7a15:fcec with SMTP id
 5b1f17b1804b1-49cf8248cd3mr385129765e9.13.1788793497831; 
 Mon, 07 Sep 2026 08:04:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883be709sm29822265f8f.21.2026.09.07.08.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:04:57 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 15:04:56 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
X-Gerrit-Change-Number: 1767
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1767?usp=email>
X-Gerrit-Commit: 6f2ad2bfd2adf630a3c2dc5916f947541e2b3383
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 15:04:56 +0000
In-Reply-To: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
References: <gerrit.1782994293000.I8887fa7ccf407d727c2b59397000149e45487e13@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTk0MjkzMDAwLkk4ODg3ZmE3Y2NmNDA3ZDcyN2MyYjU5Mzk3MDAwMTQ5ZTQ1NDg3ZTEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0fecda10692f5f1954d8c20f7950e827229ace8b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3au8-0004N3-PS
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Convert Changes.rst
 to Markdown
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
Content-Type: multipart/mixed; boundary="===============7957801375510219041=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7957801375510219041==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GZo3oLjtsAA="; charset=UTF-8

--GZo3oLjtsAA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1767?usp=3Demail )

Change subject: Convert Changes=
=2Erst to Markdown
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1767?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I8887fa7ccf407d727c2b59397000149e45487e13
Gerrit-Change-Num=
ber: 1767
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Mon, 07 Sep 2026 15:04:56 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--GZo3oLjtsAA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail">change 1767=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1767?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8887=
fa7ccf407d727c2b59397000149e45487e13 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1767 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 07 Sep 2026 15:=
04:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--GZo3oLjtsAA=--


--===============7957801375510219041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7957801375510219041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7957801375510219041==--

