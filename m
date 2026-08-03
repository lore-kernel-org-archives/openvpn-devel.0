Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886ACC55184
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 10:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9+Um8piDZTtp086Cp15vfxC9UFvv9ozlue2SGNBcp+A=; b=INQol53cjNlLVys7DKGBHw8pG0
	Yau6qo1veGAfsK29L7yaovdIgxoLSwWajZciTMEE5XI+Gltoq70//mPWy8PKAR8ySF4R58Jq+AN0k
	YuUWELmCLVk5qupWFeseQVnOGV89dmAySUjeDeBEFRmDTn6UgO51jvA9lKN2o6pg5w8I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqqIQ-00087X-Jb;
	Mon, 03 Aug 2026 10:53:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqqIO-00087J-Vf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 10:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4Y2mExGTNjX7sZM5HUekknhM1jTMwtKoQyYGSHVexnM=; b=ZY4p5LYJlwbIOwsKOIln9X3Ymm
 1VIvxn5f2nKJbK3Pwg/irWMu+mnhCKXg9w0Cc95//epG88F0mZM5Jx9Z4ifgWdPYGrhHmpzDo5xga
 XkwIecCpoIAI2O081dTqrSZDcSghfx1UTXsbsT6pmlFLktRGPehnaGd0nmM2+hBrJ9/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4Y2mExGTNjX7sZM5HUekknhM1jTMwtKoQyYGSHVexnM=; b=j
 Smj4XDoJlx4cBXmMwSzh/k72RGLTBEmFZVWHvcOPyE1sIAT34SrnCgEBMbP190ZkHAoNNIyvXO+Jo
 WgixEQB9LO/gaMuEDUTvOSgs8ea76u0XSR1jkjg8cKcJ3yUz2kRztwci9Wj5nLmG5lSi/1aNLtCg6
 u1eERraGVkbNq1ag=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqqIL-0006os-5h for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 10:53:25 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so3057589f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785754394; x=1786359194; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Y2mExGTNjX7sZM5HUekknhM1jTMwtKoQyYGSHVexnM=;
 b=PFKo46DY6ELXZpp3pmsdh0UpxYdUIVwR+JlKEJFGDZEhdfQQcUOtBlRQzoX3DrTb1Z
 R+rMK5Zi9QbLaeh6uszKPSuxmDhtnlFrTlgL+wiBQVOUkViwyHDB3K4eal8wgAtv3puD
 6UDyXiLhEtgM0/hKXWxHMcbVvlJ21ODmLPPZzA1Qid5nSofrm2e1Di39ENy70yh2Q0NA
 cvL5NT6q6rOkP1wRTwHAgt01p1Y4Drx7OhG0XxK97mCEjGXIBrvadSkQwuWtWPdYPjVp
 8nHT0o+1c2urkMpH6Fb9s0oYL+Ab/w+xlbCvVTxWjA5tAX2CIuXhGIsSIfXBi/Tdr75m
 oFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785754394; x=1786359194;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4Y2mExGTNjX7sZM5HUekknhM1jTMwtKoQyYGSHVexnM=;
 b=coNw1+RDG+bQKKb28dOE2oBjpX0MEDIOJgn3VoUj9bZa1r5pvPAGSfw4S9IXgkBPzQ
 jYRmxcbsoj128smnRVod0EIGyyxYd/wAfFI/wRD2uybfSp3XBmSuBvkTafE39R7PPrT+
 faR1IndA9C2CoVQ3mMB9UqQJ+pGyWDRy5FYNawvcTVUZc5n7wpK+cAcy9woF6Go2DoJ+
 dk/K+Z0D9Ruu6+cyrxCrW1+snUz9h8daYdDuF2tjWaLGgoDkvW5a1y2Zwn/raeCO6+TA
 Pw+HWalUijmOf4YsI0p5tWc0q2FtkHezjyii52enQyzxB8PTUWu68siPOfcvaQEWSfQJ
 DvYA==
X-Gm-Message-State: AOJu0Yy3jnfzMeQGpPv/TtWjLSv6M6ssO3tobi8806bIpfoboDhCGcux
 VijA4CDu9sX49z56EHONEnxIOLm0Gc5zC1AJmpzgCe8D7OrVWB9B/FeCN0uXc/G+3tG64lpyOdT
 0BOvI0r3ojYU5XgNeBMyG5TfO0hYsfamIRaNE4lNQKKAI+1dsnzFZOoKl8tmyZ1T6+IZEDUVh+j
 tZmF1q7Q==
X-Gm-Gg: AR+sD13vcOAz9KUI+HFvd6SXSeYloSaWxvHTKKAyL8kE2tto7s2b84IhS5tBspe9HwE
 4Pj/LYWqpg/ivYl73XM5yvbotYOZuGwVYg4wshuGWHJMOmdi+A30ehs8aEuj4h6mzccHVolRrGU
 YBQz9oDVU0fii1m11qjUcKNvrPOa8/nIYIQeoOpHGj4m155IMdq8IGididiUb7N5STGrn5gn/RP
 od+FjrXh7a2AsYzHRA3SciicUg1qYP+BzjkOSWXN5kx5FeF5NI1Lwx30+VR3WSPpZtSolb/kH5t
 wW7Y58ad5o2l7pnaenOA6tTw3KgX68/BbrKZ4t3N3ukjr14wAswAYhWup+PhfoVOlJ/xuJ3Q8i7
 f94Ldgh97njEuHAZonrEiwnOV/Rh13ZFjl3npvQnI5z4lxO9r+tvQiPVCtR7kMVg/Z243JGed+l
 tE3eYYWIji2ONzky4JgG9BptqyV5VL/Bv+ES+FercQdG/SLoo/Pgn4YSfArJhWjTU95/soyRn4A
 AZtSTCGriXJIhRIbjrpWtYCKR/CkNnW/LAq/0GA+YXNqhKwlRkDXzjiNR+oHNKstCrB8Ks16/A9
 lGZEZB0m7aUZUOShu49KkHlQdptv0Sk0/onoq9DQ2l1efqtcVZg=
X-Received: by 2002:a5d:59c7:0:b0:47f:9839:a79a with SMTP id
 ffacd0b85a97d-47fd729e880mr24966566f8f.10.1785754394354; 
 Mon, 03 Aug 2026 03:53:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm33064236f8f.11.2026.08.03.03.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 03:53:12 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 10:53:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b539ed
X-Gerrit-Change-Number: 1830
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1830?usp=email>
X-Gerrit-Commit: 86bac756964e392febc55fb025cba9a203b8befa
X-Gerrit-Comment-Date: Mon, 3 Aug 2026 10:53:10 +0000
In-Reply-To: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
References: <gerrit.1785312487000.I96b5ea3542df77b1be17079874fb9e4970b539ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MzEyNDg3MDAwLkk5NmI1ZWEzNTQyZGY3N2IxYmUxNzA3OTg3NGZiOWU0OTcwYjUzOWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8297e19a8ae0678ac2aa678f12c23bee71e66386-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqqIL-0006os-5h
Subject: [Openvpn-devel] [S] Change in openvpn[master]: SIGHUP-restart
 instance on UDP write error EADDRNOTAVAIL
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
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2059519310598756911=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2059519310598756911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vDZUBuH5pdQ="; charset=UTF-8

--vDZUBuH5pdQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

plaisthos has posted commen=
ts on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
830?usp=3Demail )

Change subject: SIGHUP-restart instance on UDP write err=
or EADDRNOTAVAIL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(1 comment)

Commit Message:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1830/comment/0ef016e2_d2031880?usp=3Demail :
PS2, Line 1=
7: not - so we can notice, and restart the instance=2E  A full SIGHUP resta=
rt
I think SIGHUP is a bit too much here since it reloads the config and ot=
her things=2E I think SIGUSR1 should be enough=2E If we need to remove rout=
es/close tun we should have some flag/extended SIGURS1=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I96b5ea3542df77b1be17079874fb9e4970b=
539ed
Gerrit-Change-Number: 1830
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Mon, 03 Aug 2026 10:53:10 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: No

--vDZUBuH5pdQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1830?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830/comment/0ef016e2_d=
2031880?usp=3Demail">Patch Set #2, Line 17:</a> <code style=3D"font-family:=
monospace,monospace">not - so we can notice, and restart the instance=2E  A=
 full SIGHUP restart</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I think SIGHUP is a bit too much here since=
 it reloads the config and other things=2E I think SIGUSR1 should be enough=
=2E If we need to remove routes/close tun we should have some flag/extended=
 SIGURS1=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail">change 1830</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1830?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I96b5ea3542df77b1b=
e17079874fb9e4970b539ed </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1830 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Mon, 03 Aug 2026 10:53:10 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>

</body></html>
--vDZUBuH5pdQ=--


--===============2059519310598756911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2059519310598756911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2059519310598756911==--

