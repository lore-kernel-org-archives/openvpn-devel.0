Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63225C5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2P2QDYSDgxLRfq36GyM//4g+S9nTHNdXnaku/FRmgQI=; b=NLcQhwspEe93/V5DNOUeEsmNuw
	eS48bSL9JCZStLdQiLgT77pFTcFmVXd9WEBB7F+BcC5WsJsh4ARLrSsMhXZgIeoh18UUrA231G/JO
	RaYSiOfb1/gtxoijBDNO7TfNuThIHpbI8PxeUyAE3DctYQLJfvi+Wh7blsWgbBuSJ3o8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupIM-0008Iu-4U;
	Fri, 14 Aug 2026 10:37:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupIL-0008Ic-1P
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ax1YAciXYBvv6PCBoMNnATJtJiNqrFitfpY0YcQVOXE=; b=MnkkNoSCW2S/CWp4Ft5AxA7sY4
 Plzw9tSMZLa5XMG8n5QuGCXR3k/XJHp6Uv6kRPhrFqrp33lFkUilHO7tOk77FNcuJopN2lZ0ScwQ1
 uH3mtSu5Hq2KCnFbgGTHJY7alvNyXaCStpferJBXP2CRpLf6b2r0v4lwx0Vx1G1DBllQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ax1YAciXYBvv6PCBoMNnATJtJiNqrFitfpY0YcQVOXE=; b=c
 vCsqYLdj6nobsJEcnR8e1IRSVyHNvKRagP4/8Tq4H6MXLhnqrKX5LQlorvWiJN7gdhRy7IQrtAkgS
 9eGDbqhCbUDSwerLGGlT5lqIzvTmUPLv8FsnvsBLr+J1CsIucjxsqDVyxxIwXIANj8xtza3XpCiXO
 Wvs8unbYxqntgqI0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupI4-0001la-0s for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:37:32 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso481644f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786703845; x=1787308645; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ax1YAciXYBvv6PCBoMNnATJtJiNqrFitfpY0YcQVOXE=;
 b=K6yAYiQBJ9MX/cT0VW9uekEhMzlbO7t6xW+PPgfcWLmDxmeistmz87WSSvBFBpDOpB
 zjKd6DMlmzZnV6PUgQfYKY7Sue7tieTy+CCt1HCVogH6xFQHjY0+A7Js1jQmRLunIDiP
 NXW1T+uEF4DFZBLXo1t0rCPwsZwOGXUFP8w5s5gDtqVaev8+mW5vFinO3W9J5yns1j1H
 JXOiAJT6hX48kQAor6+D7fxCMIDfFYJKGfElqSvRIV8lf5TQU4IccFEdO9+HxwtYiXA+
 ohy3KQiIwYWTF0aow8u1vI6D+ryiLjoUlN9InjwK+FOeDxZl8Sx9Onati7G7aop39lub
 6APA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703845; x=1787308645;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ax1YAciXYBvv6PCBoMNnATJtJiNqrFitfpY0YcQVOXE=;
 b=mVlUVsH+eutTltay8L6D7zivb6UIkbAJcg6dgaXO/rzX94M4AvV0a47AVeqI7Of573
 kZRptyZLWXYMIr4VNH7imuljM1tuUdbGKI6xwtNqXncgkkxrbGn3iCGNtdOXmqYvA1Mb
 EeTCq/9PG/sQpWmBAhtWFQ/LZ6f9f7Q4BRRf6jmBWJHJCLi84pl4Jy39xGZJ1BGAHwXf
 SOQK0qgodCMm0MAMJvMx36UV9vSB4bKTIm0d1YqxLTCgTuDJ6qn2p11uDD4aSzp2OTl2
 JllBbBe1UzD9DWyeKm1b1wM13SITZlt3vAoNIUc1gWy5COod5erSHsxumVacIVPdRQ69
 LE/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOD79i71DZHSHkvSmB00OnZAhomm6s5AjrrzWFyOButoHzegdBCjRh8OLUMN08VGP+stUuWOU9QCAhg54E@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx0fcNRZVkzjAZt9LdHzbsjhNNIEcXfwJ5RMRtzqzm+iVvrndJS
 QT883GtWV6hZMuRTvBXPok1sAfjTHWoxiYY9xatyFy79pbApyWuyCjaFQzb/FPLIa6Y8Tp/ug1A
 Uw5hn3XxgV9heJHsRl1QUpBkOccmVG+GOj91Y5Md8M6WHyNCQ9bPSBiDKlDuDY5CCYZqF
X-Gm-Gg: AR+sD13c9Dmd0qcER/9fe0/JQIig2PvTNp9tFrDO8etuw7vS2xEs9p4tA9RLOhFIwUc
 0bE7iKBT2fKpPBT0c4QKMOVkRDvLTo5/SwdyUV7TQnpHf4ZxQzilM+QmZ4iNB/I1a0mVy786DHo
 FiZTwfm2TuChLAwz0FEJhNjMAUQwud3YiizjrYcbGwyWAdDWsbdvMpkoWIdn1zuwGKG6DtI+8hV
 9Fi0e14yWDMCrT5T0N+tA4hqDrfhDjdSEwSkWR5v+oQ8ODVoE17Dg7qQxU1nR1EQQdPjuYOTeYw
 zB9apxpg+0tqg29tLE3tpNsIZRMi3ROI1wyLGOIwOYzBAB3zf+jOriAN6/btB+WpvIuSoX4NVbo
 nHlumkoFwJvT51beNVxu9Xfb2KwK55trjAW961uEjeaXEqfFIwnVOOaNBV5zFxxh+1p+09D/fA4
 WwZKEtknUunZx3dnAnZ+0xXrQuSO4w9/K4F9D/Ur/YoK6ygJw9qmzIxdGfIA+2H29Xx6nrYNA/s
 CBhRk2HM+DWvoWQahR/8Fs8zkoYHrImmmRYaqYMBgGmV5HHUlwE3gLBX/LojVqSXqY15SRhFhKg
 nyU5x9KGWm/vsX+QbLzSJS579XTZoHW7A33WZMSEoR/KCIW0f+U=
X-Received: by 2002:a05:6000:2284:b0:47f:8d71:210a with SMTP id
 ffacd0b85a97d-481607499ecmr5744493f8f.15.1786703845350; 
 Fri, 14 Aug 2026 03:37:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f21df13sm5924441f8f.15.2026.08.14.03.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:37:24 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:37:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: ed759afec30cf6e1ce9c06af92679a17afdc89f1
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:37:22 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c4b60fc80cea84924c9026ee547f52b7ac8989b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupI4-0001la-0s
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2299292585321889952=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2299292585321889952==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i6P0DbfhyHg="; charset=UTF-8

--i6P0DbfhyHg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables that shad=
ow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 13:

(1 comment)

File src/openvpn/push=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/4bf9e78a_36ce4ac9?=
usp=3Demail :
PS11, Line 1004:         openvpn_time(&local_now);
> Moved th=
is change to separate change: http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/184=
1 [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1618?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I528f5fd200d877841e473e5e05b7ac7915fa2e33
Gerrit-Change-Number: 1618
Gerrit=
-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 14 Aug 2026 10:37:22 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lic=
htenheld=2Ecom>

--i6P0DbfhyHg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comme=
nt/4bf9e78a_36ce4ac9?usp=3Demail">Patch Set #11, Line 1004:</a> <code style=
=3D"font-family:monospace,monospace">        openvpn_time(&amp;local_now);<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">Moved this change to separate change: http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1841 [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1618?usp=3Demail">change 1618</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2=
e33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1618 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 10=
:37:22 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--i6P0DbfhyHg=--


--===============2299292585321889952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2299292585321889952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2299292585321889952==--

