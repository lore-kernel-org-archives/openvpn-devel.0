Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCFBCA5FB1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xZpMmBEB4SdlHz1+eVQA5vIRpi5ACNLUk5c0b+qH9ec=; b=iqQsN8bT4K3WqcMeadIaZJ0641
	7d+nWM87JkJZhEKm2jbB7fZZO89QR7SL5mC4M0622dfixGO91RnQD6kcEtbmNijUh5j8jqMaAwXx5
	HUvNt3RKIgjTZf78YNmSYsNMC797RKzroufISXz7RU78FDb8tuaZIpS0q/wzeaQMbhJY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpfv-0001jd-6n;
	Wed, 30 Sep 2026 08:28:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpfo-0001jN-S8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:28:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=E461XsYsWBl0oufRPvGdrOAyxa9LznndtVQ+YpgomZU=; b=nIoiPvT5U/IBlEfogOlDvZ0OAL
 m+XV3PseagINeag3w4/MavkiWmMNiIJEunT0b0RXoN665UnSlOp3f4ENRapg9LxcOXmu5hPV498dm
 +PwcUV8xFVygxVT24pUjNLPiwJGG2DDsYBmQ3lrWlOWE6pKkLMD4pvcbY593uNAWlquU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E461XsYsWBl0oufRPvGdrOAyxa9LznndtVQ+YpgomZU=; b=d
 hE0gCQVLnXAt2MwwfDb0uk1xF/VEvMSUVs/5i0mz6g+VIunMn01jNmvq9kZQL5niqgaAry9LEFgES
 b2ZbHweLi3SAKn0lGFNLz3nvHDWByvXeUI17HyQF4YGXw1zJZQwFaDnbFPFQ2qBcyK2f9ZQo2vrZ2
 hNv75vxHRnDlVqfU=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpfk-0005v8-Sj for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:28:18 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so3614664f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756890; x=1791361690; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E461XsYsWBl0oufRPvGdrOAyxa9LznndtVQ+YpgomZU=;
 b=Z7SfbNgjaDJ25AIY8GGlU/VSbrZMr+BrL5XfM5L/ZCmOxrS1aIeFaC5Tk4AlxvbkTr
 WSQaKLFCo0uLnEzwFo/ZnXmwXuFlCL1mw0HOHA2LEsxU56y9VQ3am36Bk6FOADim8i4T
 Kt/re6L7Gx70hhuhS/WP1cZWfuJdHURTg7Dq5lgibh/8yoOFfaGN3+w7+Xbp8OM5GiME
 1ZNoJ5KQZc0iam/oPa+Jf2ePgMweAGA1nVb7AZaIcxyVI3uf3Gx1denc1Kk5X2DOSpgb
 zj7s3A9e92N6meYxe6ww6QLFFXYtaJuiEI3oMIM6Iyxl5q0xBii62LsRl+SBM0tQCskG
 kkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756890; x=1791361690;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E461XsYsWBl0oufRPvGdrOAyxa9LznndtVQ+YpgomZU=;
 b=fYSTrPOu0bOIQwtOrPkxSc7NfxJhqlIePbX6R9hUnUFcl5i2Qkh7tYLYBFc4lWEtbt
 /Cw1qRGmpGnfTjmsIK9Qu9BIrynqjIHvPgHtK2S3jMKfDx4WegR18W/uMpeW0of5uzov
 ZlhC+9jj8Slow6yKlNy9NnuEuqkFWrSI6VaQ7SS3U3yXN6a3olxAYBVFR+bI0wOHTTE1
 3AmjF+UFuhCvWpGwtlrkARtRRewFqU9pkrRp3c77EwY0oVlCTIsUTJ5FuOUMZ1Abc0m3
 Wc9/NoUZokmeQtIAZsX/4yru86Snl33fVgptW4JB1lBOwBeICeKgmK9sJmaKWCCqiMkF
 76/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmmF2gN9PW6klefh9nAS5k175DnzWwEZsdT/BPQiv+3r7X6uhyyeaKBDgQgTDWp+70A1g/jmrhGYWBYlD4@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKWpK2M84/TU2w31rOFZtoDVV7i6nsmvgHh+dDl5eEYLVyb5Jm4
 IFUTIx8Z1eLPG/9NANgkj8C8SViPPIuj3eRCedNjkd2EopLyq1xQqQ5Romv6L1/2aqP0qIt3zSs
 PXLCvS2YEKGjp4QJjGE4bmF+C8kp1GUnAdQUOxKRTzXZbLfiCnC1xGlpn5TjekdxE6GHFBWaAXD
 FTPwMvJA==
X-Gm-Gg: AYBFou0dci9SoNDs27wV0bM6toGj3r+LCmxpfGwfIsdD55KzYtuFLJ6buZ6xnQSzlQE
 xYZ+lWTaDM1ScNxJliMI5LzfVHdGny3ZW0JV8S+47u//amiC0oCG+Av4kf3y1+speMoHAMWbCyT
 DA1cwFD+0Oayt4y83BQxKPkbCdO9OLjs5OE6syjZMJP3q7yuCOL53hO4oteArqkXpXIsVTqe0KT
 wut8lx1LaD220JlV/1DGNbspA4swybUAZS2kmzv0E+Rz1GZrOnhf2AaBTCPv6NYBiIu2IfyGllv
 CoFIHR6yvlQspwM8S2czp8a2FeKK5r3Bh2OBbjT3vCVUlyauNUGVysg81og7Ep5r+0EADB+WHr8
 XL3BkNgRfahL4aDV4UAAoElf69gsD6ltO8vEQMTOT54aF1UIeJGCDjAXnwcil8AqwGMhVRSkE2v
 7IPWgTIXt+M2LKiOORSGEGk6tYhlUgSnzzVTBkEhspqkVbmbUoaguo3GQzmMsfQqlh4mPVDjLb3
 WnV/oOsjNttFZz2AVK9ENXeLMckCw2pRC9EbgIV5God0LMVmYNKKEEfsRt2mB8wl3amYoOJDGBP
 tBTfFl+NfRtX9s53/M7Hy9uBuR6hu2NxD0LRzTAnDEiuuV6KJeHmMMkzQQgulLl9zbOnPlg=
X-Received: by 2002:a05:6000:2903:b0:487:62d:37d9 with SMTP id
 ffacd0b85a97d-48b024e9891mr1522487f8f.27.1790756890160; 
 Wed, 30 Sep 2026 01:28:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029be7cesm1860824f8f.8.2026.09.30.01.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:28:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:28:01 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 9b66f9d7f01932ff34ea618d1557b7cbee7ca158
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 08:28:01 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee20a6709b2cf036ffb9b38ff5f0f921ce30dd2f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpfk-0005v8-Sj
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 P_CONTROL_OOB_V1 and the probe request and reply TLVs
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6001370265975226662=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6001370265975226662==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3MkSrlwORuo="; charset=UTF-8

--3MkSrlwORuo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add P_CONT=
ROL_OOB_V1 and the probe request and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 19:

(2 comments)

Patchset:
=

PS17: 
> We already have TLV parser/write that parses/write TLV with a com=
patible format for TLV_TYPE_EARLY_N [=E2=80=A6]
Yeah makes sense=2E So I mo=
ved TLV parser into a separate commit, which also replaces TLV parsing in s=
sl=2Ec=2E 

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965

This makes htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741 much smaller=2E


Patchset:

P=
S18: 
> This seems to be unfinished=2E [=E2=80=A6]
Yes, I changed the wire =
format only=2E Let me fix the naming and also look into (existing) TLV pars=
er=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c=
5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 19=

Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_li=
ci <ralf@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Wed, 30 Sep 2026 08:28:01 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--3MkSrlwORuo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p>stipa h=
as posted comments on this change by stipa=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>2 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?tab=3Dcommen=
ts&amp;usp=3Demail">Patch Set #17:</a> </p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">We already have TLV =
parser/write that parses/write TLV with a compatible format for TLV_TYPE_EA=
RLY_N [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Yeah makes sense=2E So I moved TLV parse=
r into a separate commit, which also replaces TLV parsing in ssl=2Ec=2E </p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">This makes https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1741 much smaller=2E</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741?tab=3Dcomments&amp;usp=3Demail">Patch Set #18:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
This seems to be unfinished=2E [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, I changed =
the wire format only=2E Let me fix the naming and also look into (existing)=
 TLV parser=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603=
d622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 30 Sep 2026 08:28:01 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--3MkSrlwORuo=--


--===============6001370265975226662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6001370265975226662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6001370265975226662==--

