Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C0EC88E5C
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZX6Rpanr0vUBAUa/qWWUps5VLlpyoCAEEU/ZdWwbD4=; b=RI3COGR+g7er7+mtS2yNZ/MNKl
	q0hWcV5ELu0+387TAnvVnAiHlmX8vSLIFdVOF7vpyicRZPVg/ORAtvtF0DoLjjEO5oAeAVWqokGyX
	S4/0gr/h098w5q0gRI7g1SJA4Pqgzs4E0Ld8rNXy/p4f48yYIdPLifeLKCkPBlHJ/o8c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6m1D-0007oB-SD;
	Wed, 16 Sep 2026 09:33:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6m1C-0007nw-20
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 09:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qnk1LhVGGXEApkr8k8MvbLQ6RfCmlUafXY91SInBDQw=; b=ZWxY3/GQofMBbqvBLFe4RuKVE0
 zHnQz44cajH7goy4NvVVTOBZxu87BblP+6SSdmX+Zo5Pa/NmFKHYVAaOjAygP/hvM5woQgLatLP/n
 Gm6htIC3jZ9WMnLza/Ko+7FQ6GMUl/HAWw5Ku/wRYmGubmUFruTwf9l9qNbrE9C89Wq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qnk1LhVGGXEApkr8k8MvbLQ6RfCmlUafXY91SInBDQw=; b=g
 yrrKVOsUxYr2LrAErydnP+Vip4lo/K2zgtYyFngyITXYx7du0au2CjXt6xOu1Rq7hd2BVpMBFpZ52
 j+g1U2I1ZNfkkmmhJGsQKBfdSy0jU4QmXJpW+7H0CCMvYH0zzUGx8+7NwOYJKkSFbQ+DXaqSIpQ2S
 dGii1WP65gUJ+3PQ=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6m1C-0002qR-4U for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 09:33:30 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so370891f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789551203; x=1790156003; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qnk1LhVGGXEApkr8k8MvbLQ6RfCmlUafXY91SInBDQw=;
 b=e/+ju/s909+IVk33NoFIjHQxGuE9TNmwrOFfkVm5lycE/sE3209bFtZL4jyqRn0wpB
 3e3kgamzZlWYtH5Z6E4e6Nh3nt8tGb6akQ/YmauXDojQe65uAVjkPS77Pa4zbJI6Xg1J
 t/168TqPKtKKezlLOsTiT31UwvvQDHZS+AgR5JVGRpxk81/Uzl32yxIzYf3KNq3GklBE
 2mLUCJv1ZnssGviAWldxPE/LI8Cb6AvOei9qlBZp43LQl5fsqG6XC4wUJYe+P1pwcQ2N
 7tQ3vKdXgTOqS5E33hvFof/9kj9QLjeGN1bZY/BKwfm/RJT33IoqksbbNPbWZJfqKMFU
 bMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789551203; x=1790156003;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qnk1LhVGGXEApkr8k8MvbLQ6RfCmlUafXY91SInBDQw=;
 b=cZ1qn8qaP+VvfYkIdk5p0nWj1kJetSvO4ztUitFPNOwsju60SJ/jmKLJpIGi5uTUXj
 tUwp+3K7vPyZQzXJKuZcPJ8YmGIlT+fqUtdu0COMSwhQDzBdM8jgIiFknMTaqjZIpdRF
 Bw1Mylz94Hpp+TfFQpxymH20o8aKgoSs8fBXksVGDwWnvkqP6DbcnmYXnIy9MZDRU4lx
 WCvdOGbApjmgyURVuS/SIif0CeWckqwFB2KSr7gnsFNo6+XqwpEa/6HMb1teyliIELOB
 4QjgotxqkH4yBBOwv89aPKdem+MkX0RKJFcu71tPtF9LS8UIGcQuEEJqoRGRWnfdm/MC
 0ISw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkgvXU5/p7wzrtPRbRVDV0yKLNz0NVrfUbq4Ns23hKGJWZ0BnJYWkyiiaqeIpqgMQ8dnIw994VisIVqKji@lists.sourceforge.net
X-Gm-Message-State: AFuF++knzpu0TvaWFgFrQAld0XZyWD5E3Ndx9RsadcoZPVhQiLzlEBb/
 XHL2+ZAVK3bAqXHgg5lt8FbJLnP+VYue7YqleQTPjRbwhf3ou8HwT3yril9JPxw7bWXjR6WpRcz
 wsq/NRtLQaSf+NkXX5CS1JtB+02Q3AD1HG8/vjMa61b/rv1W9aeG9lB61J0WGZbVib11l
X-Gm-Gg: AYBFou3KdEGLAh+al+UWUlcf8EmlHQ1JbxN6Z4d3ukNBQpZzQcBSiDcB6J2B/bjtS4j
 B4H0eFjeRyjgUkPqCy5AQuRl2doPjPBC4hQ5aRq93JF0oF13fV908I/H6FzP9UBLNxdrPAWlExj
 R/jxub+o7qrzOXH54VR4GUQ1MdsQtX0cMMYCwjQXLdjE1eMSpX5EF7eWz+blbW4iOCS4O1rRVL+
 xDxHssCDw1ekD2ZzC/5YmgQ/BsWdUaDL6Ordsr0EO2Z+JK/kwv2s2ZI5QvWnpLLJd8XxSZTJvzr
 Evjb2XuxWv5TPfZxkYviT48NhZMN/TGDw9kxhOeJvwbwxEOwNF8AiGujtyvu3uXG03vLZOKwkbG
 MwRYUpRcQYH94MmqSprKHMUMWBGVFKqKm4XlAPJIqdfP3zjzMT1XBxmnUoGrH/ezYn5ygb7QEi4
 FBI69Dx52liYC1fwtYwP8JbtZnUlBzjX7K3IIfueiTFke/ekmUW96zX2P4V3kDVwbtJ1zPWSEE1
 83/jgrvFdXiyI7huefNPlJJOEyNRlq3pyXxvIfHhgaXON09Ww1Y0e8u3j+APEY/RiOLd5TTvUux
 TQzCMbBeFPFhE6QE5RgJTwil2H0G6xSHAfAhuPxjlhVrexszIptvKupDjOHr1Q==
X-Received: by 2002:a5d:64e2:0:b0:487:71d:e878 with SMTP id
 ffacd0b85a97d-4870cedc87dmr4965455f8f.2.1789551203391; 
 Wed, 16 Sep 2026 02:33:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27df9sm5481994f8f.19.2026.09.16.02.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 02:33:22 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 09:33:21 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I00208610e0ce4f3ed9a87233e68ece1b3b8a768a
X-Gerrit-Change-Number: 1751
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1751?usp=email>
X-Gerrit-Commit: 90d175b6edad10c9c7bbd944dc9a55902d21c58b
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 09:33:21 +0000
In-Reply-To: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
References: <gerrit.1782719911000.I00208610e0ce4f3ed9a87233e68ece1b3b8a768a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkwMDIwODYxMGUwY2U0ZjNlZDlhODcyMzNlNjhlY2UxYjNiOGE3NjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e8b0653565d3155f5f9126f59cb7f589dae27af7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6m1C-0002qR-4U
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Probe every
 resolved address of a remote
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
Content-Type: multipart/mixed; boundary="===============4880326779996689697=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4880326779996689697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FPc0AbPUp9k="; charset=UTF-8

--FPc0AbPUp9k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1751?usp=3Demail )

Change subject: oob: Probe every resolved add=
ress of a remote
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 24: Code-Review-1

(2 comments)

Commit Message:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1751/comment/60a157b9_f39a3941?usp=3Demail=
 :
PS24, Line 17: first reply for a remote wins
Does this assume that every=
 address of a remote advertises the same priority, weight, and latency marg=
in? If A answers first with priority 100 and B later answers with priority =
0, B is ignored and the whole remote is ranked using A's values, even thoug=
h priority is supposed to take precedence over latency=2E If this is an int=
ended configuration invariant, it should probably be documented=2E


File s=
rc/openvpn/oob=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751/comment=
/ff788675_08592794?usp=3Demail :
PS24, Line 200:     struct timeval sent_at=
; /* when the first probe went out, for the RTT */
Sharing one timestamp fo=
r every address of a remote might be problematic=2E If A is sent at t=3D0, =
B at t=3D20, and B replies at t=3D25, B's RTT is recorded as 25ms rather th=
an 5ms=2E The reply source identifies which destination answered, so the fi=
rst-send timestamp should be stored per destination=2E As written, this mea=
sures time since probing the remote began, not the RTT of the responding ad=
dress=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
51?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00208610e=
0ce4f3ed9a87233e68ece1b3b8a768a
Gerrit-Change-Number: 1751
Gerrit-PatchSet:=
 24
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stip=
a <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 16 Sep 2026 09:33:21 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--FPc0AbPUp9k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 24:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">View Change</a></p><p>2=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751/co=
mment/60a157b9_f39a3941?usp=3Demail">Patch Set #24, Line 17:</a> <code styl=
e=3D"font-family:monospace,monospace">first reply for a remote wins</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Does this assume that every address of a remote advertises the same pri=
ority, weight, and latency margin? If A answers first with priority 100 and=
 B later answers with priority 0, B is ignored and the whole remote is rank=
ed using A&#39;s values, even though priority is supposed to take precedenc=
e over latency=2E If this is an intended configuration invariant, it should=
 probably be documented=2E</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751/comme=
nt/ff788675_08592794?usp=3Demail">Patch Set #24, Line 200:</a> <code style=
=3D"font-family:monospace,monospace">    struct timeval sent_at; /* when th=
e first probe went out, for the RTT */</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Sharing one timestamp fo=
r every address of a remote might be problematic=2E If A is sent at t=3D0, =
B at t=3D20, and B replies at t=3D25, B&#39;s RTT is recorded as 25ms rathe=
r than 5ms=2E The reply source identifies which destination answered, so th=
e first-send timestamp should be stored per destination=2E As written, this=
 measures time since probing the remote began, not the RTT of the respondin=
g address=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail">change 1751</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1751?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00208610e0ce4f3ed=
9a87233e68ece1b3b8a768a </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Wed, 16 Sep 2026 09:33:21 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--FPc0AbPUp9k=--


--===============4880326779996689697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4880326779996689697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4880326779996689697==--

