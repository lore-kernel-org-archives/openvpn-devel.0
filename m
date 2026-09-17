Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71E3C982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yNjJj+EuNQiTeLvEh2V8ti6yDVB+4RoMIbizumaq750=; b=CjdSPg9jbHJ9jfqcnEYJM8D8P1
	eePWwUubloQcQ7x3v+itTiSzwbfW0YMj8Vyq7VaIgADurPDHUwDq5FNfz/3fXlnyAR5/sJRhk1R2R
	XiQ+TJN+Zprk16hf1Gb+YKOxnekqBXbZuBnk1DeEeefBMXnhDrl2CcYJlRLdFfjmeXq4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Bv4-0000Ba-DA;
	Thu, 17 Sep 2026 13:12:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Bv3-0000BP-6L
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dAMujs1BDUSv4lMnHYxT8Vs5p0bzsZDHVeFMD1bybnA=; b=AYzR9R6dbFK5+iStEL6ABKORqL
 3mM5ip18a5e/Da3We42i2Sv8CynlmGqa5TWp/FxNeTbEv1sYZe5//T4P0EeJxG4zmFo80mAGLIaIq
 rMyLh4PT8FEEyGsQb/9m7AcjnT/r9zYxzAZSlvZxNOCWADZZZXjuE2ew9qh9kYSpWt0s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dAMujs1BDUSv4lMnHYxT8Vs5p0bzsZDHVeFMD1bybnA=; b=b
 0iDBUpzia5VYxKm4IzTl53tTuhqkzSbiccIk9bDAm6crq0c54RHRmy9h6cgLs9vpTR7fISi0D9083
 WohAToarHksCH6YEptfjU1dd9Gi1f7f3YlIEN+KPNvNcLb0lIVPiaMmYUD0VG3zOeSPWixorP+eRz
 cjOdEhEZo1Rpp60Y=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Bv2-0007M5-1A for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:12:53 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so6919995e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789650765; x=1790255565; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dAMujs1BDUSv4lMnHYxT8Vs5p0bzsZDHVeFMD1bybnA=;
 b=IrVHkcTGaVNrMLs1BbfnV5gF0RNdsq9xvymnWo9VlQd52lLj4Iqm7ME4pvof/ey3Oz
 FYFHX66/HGxF4E4V+CyM4G4T5YiPdZuQMmxeSjVAgFJxlJ64zVgKwb/AvMgVbHSbxpDo
 roZuoA2U2jlclQi9cEGrc+fe8uNctd3Zt0PODQ2HVElMvj34JC8K6yAx3FRfC8d6f1L3
 OvQbIEJdEnX3XGigzLmLu4GITk8M0ecHCXMEeAIgvUwFVHc9glyeg3wIxy9IIzX6ilKo
 BGUN8LL4OnidLeDoYSUXTNHwZhmDfoj7JzdbIPu6KaWFNprqiexlHmPpmUq4rnSaKW1v
 eZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789650765; x=1790255565;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dAMujs1BDUSv4lMnHYxT8Vs5p0bzsZDHVeFMD1bybnA=;
 b=qVfoQC0rc0lL+C5aN5TiQBeP3uFZp//oiBx2ttwQ71mofGhMj6o+Br6woQckd6Qw8t
 8DYn3vxwxScySqKNcfQSe+DRap1SxdMj331xV/KPulVw6iky9k9UQQGPCKIDnIutWIwV
 yRwbnfB/i3NJSwKhl9vXrmQY24QT6eSvyIpGjp5VwZhk8yZCVrsoTvTFaTxZzfny8kqT
 RnbZYy8pOw5AGw6N5xQhGum4Zx+myMUro4x4Qk0jOpbhqfP7SOjW+QknWLKjMgr1TiFn
 iNWSQJryvxchkFjWsEG0F5I7BHEc+/eJdLQaKLb4ef1zczX/3Vj3xdkt2bicSkE8ppfP
 TDlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfLcTE0qTAs1QTjJVsz/PGMksgYYLZ/fJ3W1UsBtST8N+DVgGyXHiMC7u8Sr4PE5fgIxPbi+PiC//tA/Jb@lists.sourceforge.net
X-Gm-Message-State: AFuF++l1krG5ihBjyyF0CUiAC6FGLJ6E7XUMC/Cooqmmhyd1yvgBGG4P
 GGCrJafSElnMoLjZ9AXsT1SX86nyf1BZlRMVyCPKxOFHlp5PG5DQBWjjkVEYoZrBvao3iP+LThb
 jQb5iA2dQwgtrm3HuyilSGfQMwpL5+HUbTVs/BsJwJPPKap1L5UpNrdSzRFjfRUtQsbgu
X-Gm-Gg: AYBFou1SQh7sNjVQJb0r/KEeQKGEhVozKTTLlAk46wRgYSdR6SJ9s9cd0ASbDdqrgfG
 nLJ0jI00oCCM86yUBmJf+QdmK7ec8/7OEcy19C+UC3rRyExx2gjwyFdoVLSK8wV5WNkoqxOr54z
 CzWQZsR0P2bKMnu6FjNU6UYeM/6r5HaYhHbBWUnV9bOevujEvLv38ZR9FKNPxeOZFPtCqPTsAcY
 u1EL9EXpxaaV2zjFrbUI1FQdLh7FslHQF4o7Ea1WZMbdFr7MKyqnSL1uFakuNQUF1KybFK16kBA
 cpUvQawwnYLYulnTKzTAIgqR2gTFbvyH6YsSrfrofnQqxFmnHcG6oZx5SRTC2NpSrYdk6L1uy3/
 Z0TOr9/d/5RXMynfmYpCof6agiyBRhzOxG2mDorwTrlGrJEBXzvVR68iCeZteejupVIQ7qKQmLU
 hvZxbh0Te0e15sv5mHWAzVG8uIvI/9heOqBq42Bvey86PNDopvPMgADyK/SdecXTU1hoKMKJdbL
 uZTdlYr+vMPkB2hQCkk1RN6ciBdpKPyZtD7d+JPTkSCbg4pI/vJeYochgPjwlwaQ8CJ+/mviiiy
 SZRykRN+X+H7p12sMEPgcdOAGxlcwWcoOxZjTNZiwtzTTM1FE5sCReKCCBGEyQ==
X-Received: by 2002:a05:600c:1f87:b0:49c:d818:8764 with SMTP id
 5b1f17b1804b1-49ead86eb54mr77728155e9.11.1789650765345; 
 Thu, 17 Sep 2026 06:12:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33d93sm14763753f8f.22.2026.09.17.06.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:12:44 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 13:12:43 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 010736ef7f721f4841eb67570de51563739399a5
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 13:12:43 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <821be8b789213c6f3f14f5d7db3959f347fcdbd4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Bv2-0007M5-1A
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Answer
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8327315039437221492=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8327315039437221492==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O+apXNIWH30="; charset=UTF-8

--O+apXNIWH30=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SER=
VER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 16: Code-Review-1

(2 comments)
=

File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744=
/comment/985b183c_a9d3a6ac?usp=3Demail :
PS16, Line 138:         || verdict=
 =3D=3D VERDICT_VALID_OOB_V1)
By including OOB packets here, `initial_rate_=
limiter` is charged before `oob_server_probe_check` classifies the payload=
=2E Malformed probes and stale probes rejected by `stale_probe_limiter` the=
refore consume the shared reset-response allowance even though no reply is =
sent=2E


File src/openvpn/reflect_filter=2Eh:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1744/comment/c55a7f5b_aca29375?usp=3Demail :
PS16, Line 49: =
    bool quiet;
`quiet` is not initialized by `initial_rate_limit_init`, wh=
ich uses `ALLOC_OBJ` rather than zero-initialized allocation=2E The stale-p=
robe limiter sets it to true, but the normal initial-rate limiter leaves it=
 indeterminate and may therefore randomly suppress warnings=2E

`warning_di=
splayed` is also left uninitialized=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Chang=
e-Number: 1744
Gerrit-PatchSet: 16
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 13:12:43 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: Yes

--O+apXNIWH30=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
6:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1744/comment/985b183c_a9d3a6ac?usp=3Demail">Patch Set #1=
6, Line 138:</a> <code style=3D"font-family:monospace,monospace">        ||=
 verdict =3D=3D VERDICT_VALID_OOB_V1)</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">By including OOB packets=
 here, `initial_rate_limiter` is charged before `oob_server_probe_check` cl=
assifies the payload=2E Malformed probes and stale probes rejected by `stal=
e_probe_limiter` therefore consume the shared reset-response allowance even=
 though no reply is sent=2E</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/reflect_filter=2Eh:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1744/comment/c55a7f5b_aca29375?usp=3Demail">Patch Set #16, Line 49:</a> =
<code style=3D"font-family:monospace,monospace">    bool quiet;</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
`quiet` is not initialized by `initial_rate_limit_init`, which uses `ALLOC_=
OBJ` rather than zero-initialized allocation=2E The stale-probe limiter set=
s it to true, but the normal initial-rate limiter leaves it indeterminate a=
nd may therefore randomly suppress warnings=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">`warning_displayed` is a=
lso left uninitialized=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d=
3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Thu, 17 Sep 2026 13:12:43 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 Yes </div>

</body></html>
--O+apXNIWH30=--


--===============8327315039437221492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8327315039437221492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8327315039437221492==--

