Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD025C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Snq5fmO7RvHvjtEr6ElIBVZ0BA6RemgqnsuumO0u14s=; b=CWiBhchSeKlPBuclcvvztUGajY
	pbmjC3o4wW7NWl5GBwziksNdn51LfxzSIOHILTCLnIrrvc1xlvNQ+Ut5cRWzaCoult+euet2QwBB8
	jJ/N/RI+YYqEQHj51eJ3ZePi9iopq6RfHOX20PSTmsjtrcszl58msyYgySx3tMQSSdEs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wetFN-0007L0-Ew;
	Wed, 01 Jul 2026 11:36:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wetFD-0007Kp-Ri
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 11:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5rpDBCR0e9Y2W5XcENlT/R6V0xlwanTBByx9WXJ81Ao=; b=MpknWe6bxvv6bVBfmlRwzoSM5O
 3GP3N4elltSlkFjEjz72UN2YeEI2Zi8hc2+vpMMSivfA++c0ml7hPiC2+HU3A1/Kv1JmS4ShchLqd
 OEoZWB4vFCvbgEsT9nPdbleTSnOd9V6yt1OM5oCsG9fPc6FpyzNiIMkxFVc+27xbbJDQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5rpDBCR0e9Y2W5XcENlT/R6V0xlwanTBByx9WXJ81Ao=; b=T
 pqekzCeda7ObvQr0LnLyxIAmVFu3E2pSY8gr0CZl+oC0pLGDqCybGGV2VEvudItaMOHpFZKaEU8jl
 5hCvYvO8rZO/3+eBroSa6oY85VsMzOjWdPJNEGz85yJMcyYJcyi/1PyikJgArei4tCdvU28UB+Bai
 ZMKqubpEWeOw6lJY=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wetFA-00043o-EO for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 11:36:42 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4631679f204so1015409f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782905789; x=1783510589; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5rpDBCR0e9Y2W5XcENlT/R6V0xlwanTBByx9WXJ81Ao=;
 b=U+9lDZkBaF0fP029UdYct/VnFr+1pf0g3sgKtVIAVcDPF3EQHcfUiT2e3mivHxyOgK
 LylafPwNfnSmXDMpekWCyzURWROlfkHVhth1WoDeFnRk5r4fiNMflIYuWJp8lBhb3Wo2
 9DMC5yi5gNV/YFGCA0LhTS/QgSlLUG129x6IJuabLPB7uCEDYsRq3+lPLeihxUMP15pi
 51dtmj5nobWqTH/yLdHwW5N4202bxnk34/sNneyEtMhENV+bibyZCZstYZqQ1+tbzeTt
 6fKd1GcKG+G3bcSWBEORXLYWwXNOXnE78c4a3Kq+hbAKSB6uYXI0ZgKooo45cLaM81t0
 d96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782905789; x=1783510589;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rpDBCR0e9Y2W5XcENlT/R6V0xlwanTBByx9WXJ81Ao=;
 b=ZWr9AioF4xQbIsRQKncm5871bNqL8OMNa36NhvG4PbYKRM7E/+phEAByBpdmkcREu/
 fZWqXamV8p2x7U9d6Yk0N484J5MUH+kDFfow9KcVxZLlUV9GKyqnZSNmRJucycDThQHr
 gAmywTH4fve7B53PUUx/LYXu88zblkELK+BDrV2iYN10bJBjgqauFBPSZXYaTWBiCtD3
 WNH80toO876QudmfVcgHXIv3dw8OgBJ0554w6tWTpdJYT73+/H9ZX2U9xOLivzUgi+ch
 9zGUeSTJpQT0z/ptBVwCaJ3DAGuu8/2VVh7Qf6JLElrkpEumrXDcgQbANOqi5N/mlSsi
 TJCg==
X-Gm-Message-State: AOJu0Yxr5C4QMzhrm1/HZRV34LZlII+bXoBylqWmaS3vnZe1YD96Eebp
 E6IbIb5GaCOJyG8NpFfjq+flU8WmjIgeRTEkhF8MmjtipJ8H2kYyraQSHYHiKZi9Y0kkzWglCva
 oX+LkWDNZPjUBejmygHt9rxiwx3GEG6kZBpR7hSph2fEJeZjNyc3F47NhffACz0KE+nzE8HR5tX
 6LTHTphQ==
X-Gm-Gg: AfdE7cl6Q4za+X5cO90qZEQFmIKoC87aOh1GUaCGVDMMRBdLWW4+C4Coj9KSyYSYSim
 vRPwR/e4SGMAj2R3nh9CmbcTxfPycKwV7zEmXJSq6u/2OhYQ+D7thxHmT2mtkJ3HHyd2Bk0Zima
 ZF2tIMJJRjn/PHmvAQq0/X48jZFEEiLqytJl9YFCenH3cJo11L7rrjJaQOXOaSOR42tCmNzkySg
 80A5bizN5BPnAJM72wrgXJzxWfF4pBt/qxJR18Is9P63X1r82yK4Tzsb4lIzefTWNf+1gW6T0Lt
 /RM6Wj5i+gUmXVP2KuFsfhI+xRHf/fPmOXu3XeZVIH4hqptTRGhKSCloqDy7ntP9Iq3VUZA8Gt8
 XIHkXalp/8wkHq0NQUQIk3TNJo8iDrlAlwikacpp+i6yFyNRF6jGpAfOErvmvAr4ak+HwQe9/VC
 atXAD2zIma/TG9ac6C9zOGQAIBhhn7Dzg0YN6q8ZFBf7wJ8V3F/uXzAeppW22HDrYt+utmnY0TG
 a0nWPX1DW/m1FVeKJnQgxboBJ0vFvEEynP0ONaao4MFklAUPGrUGPz0oQ+ffzCq1/DP2Hxgg2Yk
 UXIARAN6e1Gb4Q==
X-Received: by 2002:a05:6000:4919:b0:475:f0c2:75b2 with SMTP id
 ffacd0b85a97d-4774681ab25mr1954291f8f.29.1782905789057; 
 Wed, 01 Jul 2026 04:36:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47566c0deacsm17368218f8f.26.2026.07.01.04.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:36:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 11:36:26 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2
X-Gerrit-Change-Number: 1735
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1735?usp=email>
X-Gerrit-Commit: f0a65c3eb248ff25a418ac3403cd603bd5364782
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 11:36:26 +0000
In-Reply-To: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
References: <gerrit.1782545314000.Ic8c83132a4de64f27e6453ddb90ebcf137500db2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkljOGM4MzEzMmE0ZGU2NGYyN2U2NDUzZGRiOTBlYmNmMTM3NTAwZGIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <221da2d2202e8c0bc9c55f459ff76ab050dd0ba9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wetFA-00043o-EO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: create and
 destroy Linux DCO devices with --mktun/--rmtun
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8891579479115721556=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8891579479115721556==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6k2QFToBNLg="; charset=UTF-8

--6k2QFToBNLg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici=2E

plaisthos has posted co=
mments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1735?usp=3Demail )

Change subject: init: create and destroy Linux D=
CO devices with --mktun/--rmtun
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)

Patchset:

PS=
1: 
I think you need to add a paragraph or something to the man page that e=
xplain the behaviour that this command will create tun or tap depending on =
whether openvpn thinks dco is working and mention disable-dco to disable th=
is=2E

Related question: do we properly figure out if a pre-existing dco tu=
n mode is in the right mode (p2p vs m2mp) or do we just fail miserable?



=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic8c83132a4de64f27e645=
3ddb90ebcf137500db2
Gerrit-Change-Number: 1735
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Commen=
t-Date: Wed, 01 Jul 2026 11:36:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: Yes

--6k2QFToBNLg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1735?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?tab=3Dcomments&amp=
;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I think you need to add a paragraph or=
 something to the man page that explain the behaviour that this command wil=
l create tun or tap depending on whether openvpn thinks dco is working and =
mention disable-dco to disable this=2E</p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Related question: do we properly=
 figure out if a pre-existing dco tun mode is in the right mode (p2p vs m2m=
p) or do we just fail miserable?</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=3Demail">chang=
e 1735</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1735?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ic8c83132a4de64f27e6453ddb90ebcf137500db2 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1735 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Wed, 01 Jul 2026 11:36:26 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--6k2QFToBNLg=--


--===============8891579479115721556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8891579479115721556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8891579479115721556==--

