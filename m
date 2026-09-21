Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB96C982E6
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z0RuueprAMvoJPZ5tRLAy/QUNSMNWs5xLjJvx+yiiWk=; b=XfaQJSD5jgbvB8dAY3e3csJF8w
	s5WVA6Qf4JypUUAsRAeVIQMNggi8JpTZiXF5QzuZy1IWWxSvmBj+wW29a7Zhc7nLsMtorePFn8umB
	3zjdExiKviLb+pBRwqW5xYc2vN0VhaDunQ8hU+w3ZuU1pSbhTOvfGsXWnlJbvK8hIoac=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8YLs-000127-1w;
	Mon, 21 Sep 2026 07:22:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8YLr-000120-5T
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 07:22:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XyGBXpbYcywKhH7wxTq1P9DdOYjyM7HugsF7+CvYmsk=; b=DTMGIZWg94kKhuQ3c4IxiFt3wO
 Do7Jp/pvq8tnqbdN7tFznmnzAi67Sv2QxSt4JRtYgpRSutCGCypE+RcaP0XFlN+x+KrI264cyh8tw
 7ndbZrJtt9JMrUAIFsR2l7T65w74lwU0h84Ve3k3UFB2ppXWTlJ3kqszD//b3gjMfkro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XyGBXpbYcywKhH7wxTq1P9DdOYjyM7HugsF7+CvYmsk=; b=e
 EQ8BXcuA4wPPlJwX3rmuVpYAyj1CA3v3Fm/5M8fHXh88isUN8ft0pyYJKR9vPy9H8iBTPuTfN8ui4
 VPilyQK5Na4t+khJf/an2sKkj2cI1upXeMFowzWa15IHudpHAqmFxgP533N5NslkYsHOiAmzIn4Hq
 YYr9JAso97YiGR+E=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8YLm-0001UL-O6 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 07:22:08 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so36276335e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 00:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789975320; x=1790580120; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XyGBXpbYcywKhH7wxTq1P9DdOYjyM7HugsF7+CvYmsk=;
 b=Tep6c/5H4GN2fprcVLCg+wXAZ07xZtGEvC+mMieCqNn+NPobN07S6Pi7eJGol4UpST
 s+RHfKdYecVjfyZkEKrJLqi2WldiBP2Aa/Z47+UTMraEYW877KGlc/QVAZiskolCi9/p
 zeDnK1eE6caFmfnx0mAv3dRB/rYxOrlK/NXmuJ7BfFAxUSOgx9ztjeENnDxNJbpfkCcQ
 oC+44uSJv/BusJKL4vRMa9HvHh3YvUBlJWwu37QeReRZ1apXYfQRDeTEUyoL3z9/bLdQ
 75nI8BJwbF+7+JSi7k1MvmIx5MUGYPs0kgjAVmGZDNuSfGjcOzvrlLq3LzBYSd8APb4g
 lzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789975320; x=1790580120;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XyGBXpbYcywKhH7wxTq1P9DdOYjyM7HugsF7+CvYmsk=;
 b=03TNKmhSwF66r3amG8HAv2bl0so8Nm1MwMXJSwR/VsdAMDUyQlN3YEWe5Pg8vxgpUs
 MjPmKf2ClQYoMU7AOb5/59xJLfaan+6a3Qm3zRazIpJHBB+WBW6i6deaRkN56er1VPIW
 9Q8APLMaTLH+8xdBr7GqlSWdOLve7ndycnXfGBD/wCVDffx2H9lGXjFIatfTitouaEiB
 2dktLT6h36dnwkzTQu8ISPo2FNkt3CJRkgIfoFElEEziqyYU3Q33HK8BvlkTJZHl2LgX
 dJF/zB2CPcP8rgtnjJ+c06MstBVHy1Z0qWW5yybgh1dAD8OqxCVTaEBFvFF1qo3gZcXO
 xm2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvVwR2mIPQKKWv5jwJkHe5jBkqPt8eQcqV7aOObe+oGn8WKPonDTievl7xLe4757POH/RONwLfTZ6mSFbx@lists.sourceforge.net
X-Gm-Message-State: AFuF++m/jsuDz2tYolHpgL6fZD9kPWgy9BToPAZ5NmhkArHG2fCoX4k5
 hCZZ9csc2bFimFx2TpMBb/VayzyCTh34QF0dTDMsUeBfs6vxjZV4Fb7Vonw88RoRU7C8KiAxabz
 J1g4GIFDvnnnY794ewfk3Wwrnf/C0GbdQMigMmPXvkm2sv7azpOws1cb//qXLLHrfqoZs
X-Gm-Gg: AYBFou3o0yN1ZYDGupOtjYtz/MNT9qNJZTLIsWNSEqwn6k1umJoeIcumyyTa6H1mKbN
 HJ0pgEcBFJE9yenJ9Bq9A1QMpEkhT+inKDl4+BDrqVBR44vF3j3QkjoqbvsQbs+6YthkAcQ3QFf
 HaH/6rkqdswlVz9DwmoeVhCE8wzeoz2NQJuulHjZK5UA1XGhoPj84ksjDyDyVu0Gp5ZJ2rPV3PD
 TiohgTkm5+JjBkaAkZ4Dk2JulEA7aLiuPtqaxoes3m4g8ojmv6DamuIVOeQRZd6k0jt3Mj1a7X/
 NDCO8C4iSbZEieq0QCqlYWRdkDfV8lJAwS8l5CZYyEbwlkdq3q2Gh3zo95rosHRkaPr8OnHCMuY
 vaCz87MYuQN9DzydOq0zKeuU3k7GHqgiWvK/2h8Z82UrWrkP5EXPlLBAcRIvW7xYA+oYMMZi2AL
 BOG3gUWxvIU3DWxtsCUIBs18YaVJ9qcPQS3vrfkShmXVSJ/bwXXBAGcByglnjGOsDs3/Y9G7gFW
 yLZZmi1B8Rfn8YSVqc5QSusv3U6GsDGvLBnl1bA2vMewQ3ch9yOjq0H86VFbhA2iByM3hf/o4m1
 vtQNvcgRQiZxHCmyp7QSfj1IQo/A8C2lOFTUkeOHqWSFyf6S+j+dIaOLEB3SKA==
X-Received: by 2002:a05:600c:1548:b0:49e:6ac4:b76e with SMTP id
 5b1f17b1804b1-49fc574eed4mr141555535e9.30.1789975319939; 
 Mon, 21 Sep 2026 00:21:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd0735c9sm205693915e9.6.2026.09.21.00.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 00:21:58 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 07:21:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: e341e3134d523bec7b04ac998cad8c2a9b284616
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 07:21:57 +0000
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7fbde99011164d25b08b82f0b806014dbcd12c40-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8YLm-0001UL-O6
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
Content-Type: multipart/mixed; boundary="===============6111334608775736100=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6111334608775736100==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nhyHQl23iWI="; charset=UTF-8

--nhyHQl23iWI=
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


Patch Set 27:

(1 comment)

File src/openvpn/oob_client=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/9a658f2c_aa23cbfe?usp=
=3Demail :
PS19, Line 274:         results[i]=2Ertt_ms =3D (ms > 0) ? (unsi=
gned int)ms : 0;
> So that seems like an omission in our spec that we have =
this problem=2E [=E2=80=A6]
Agreed=2E Let's have a per-send id: a uint32 pr=
obe_id in probe_parameter that the server echoes in probe_reply=2E A resend=
 gets a new id, the client can match a reply to the exact send and time it =
from there, and the first-send rule goes away=2E I can put a PR against the=
 spec, the implementation would be a follow-up to this series=2E



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I375a41749060b7d006647bc27002=
c55436c8a8bb
Gerrit-Change-Number: 1748
Gerrit-PatchSet: 27
Gerrit-Owner: s=
tipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelb=
it=2Ecom>
Gerrit-Comment-Date: Mon, 21 Sep 2026 07:21:57 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>
Co=
mment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--nhyHQl23iWI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1748/comment/9a658f2c_aa23cbfe?usp=3Demail">Patch Set #19, Line 274:=
</a> <code style=3D"font-family:monospace,monospace">        results[i]=2Er=
tt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So that=
 seems like an omission in our spec that we have this problem=2E [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Agreed=2E Let&#39;s have a per-send id: a uint32 probe_i=
d in probe_parameter that the server echoes in probe_reply=2E A resend gets=
 a new id, the client can match a reply to the exact send and time it from =
there, and the first-send rule goes away=2E I can put a PR against the spec=
, the implementation would be a follow-up to this series=2E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1748?usp=3Demail">change 1748</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1748?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1748 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div style=3D"display:none"=
> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 21 Sep 2026 07:21:57 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Comment-In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

<=
/body></html>
--nhyHQl23iWI=--


--===============6111334608775736100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6111334608775736100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6111334608775736100==--

