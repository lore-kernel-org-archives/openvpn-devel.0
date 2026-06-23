Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB923CD4F26
	for <openvpn-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=adxIDdRvwmhh81JQpbALTGQVtnQoz/qpVboPg7COtwM=; b=a7lj0WblT1HgWakG8btVI7C3Ib
	T+nSxFRiIQUCSFh6x2aZWU+xQYzlVShQtjh3+oVRU44WWnfmtaW9Dcx5QCjnziWEzMXbFD20k6E8Z
	yCVkvcfzwFOI6THOgPoN76Q42RMM1wG6ODFIQTRKxPwpfEKsmk5IDQk1uZtjXEL2d9ak=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbw7r-0008KN-Rk;
	Tue, 23 Jun 2026 08:04:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbw7q-0008KH-Ns
 for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 08:04:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K8EZmsbYFKpZ+rVA/xZN3mi3gwYNPNSvtDHmeOFChp8=; b=ifJKlPOI145R9OOzanyhqT7QfR
 CFd9jKaCgc3boblRRGZiT+mykTDVmAPIcqQsUpH7UA6mZ0QtOkF0mx9/fMe6CPB7B052bGaQER7sO
 GqkUs9TU70KdxFzGqfRhn7E4NhEv1SZJRRhfvmDEVAArfqHtV3EQUmQekOgcRCvbiUzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K8EZmsbYFKpZ+rVA/xZN3mi3gwYNPNSvtDHmeOFChp8=; b=k
 y2y7+l8nR5GhYPc5H5QEJFpTSGXALXj+TbsSDgaOJbC4L4L5zcU+uT1Ds8M48ExQlVdvqmepy4ZrQ
 LYXZMVV02WEV+k5Qv+pYrKhz7TtbdUQvBLmSq3fsU7Kjwc9urzT98ge4JXd+FQA46C/Z5Lza3K4dv
 5FG7ASq4f7dDVU7k=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbw7e-0000Tj-0o for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 08:04:54 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49249707788so21873415e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 23 Jun 2026 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782201871; x=1782806671; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K8EZmsbYFKpZ+rVA/xZN3mi3gwYNPNSvtDHmeOFChp8=;
 b=OwQTq3Z0jFXvAFwtae45PV2xAfP7xdyduzodZNt4UTpEbG4QbaQR9trQlr4lwFJGMK
 QD1g84YeM0dOLE1mg0gpMfnOCgPTZ3djpRqOWvZ1coS+lrnKqvLqDmkDve6R/V2NGmDD
 LHEaDcr5/54rsli2RIfzWoIgeanucRoRo4GbFefA4DycrVbzq4zut2SmudINQ8wWAzMg
 WJZmPzkxVeq6yJUBe5XV9fujsOvnRecBAfAX7mFH/aSfrWZtRx3NBYfgwm53vLdh7Nxl
 DtCGek85Qp8DT+Tbg8HzHt52Pbv5V04llF7RSvotPEoG0XaDNwQXUvGrtyZPahBseiT2
 7vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782201871; x=1782806671;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K8EZmsbYFKpZ+rVA/xZN3mi3gwYNPNSvtDHmeOFChp8=;
 b=CQaFWjwbONAHNOSA2kNQKo/CAjFXKLayX2/7WBXg991cm2ttbHPqTXaM/dYoESCMNw
 dL7InaLta+Ud7tWbnGr0j/MfmDxKE2ntpcchzUyFIJrbMAkM4aMuG1aMEOHc8vzpVGZe
 9vu3Ls8ygNXajKluA3ruNUVlD2eQxtjxEhqA+TxYxHj1nTKV2KXeEYRW9EDPjXAqavS6
 CDUsgaNSD6P+law3oOc936s8CsGm4IIdS/p3eIV1knl0pSaZb1JI2EtAS3JwWyA41pv+
 ZpXjHJoh+szCLpKFuhf6aTWmXDQsl5KugwpHE6bnBfRz4Gl7fDb2S7Qe9Ow756BOFPWz
 cFOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gfwa79MK/bVet9Sy5EzphiiuJjZ3ZSXHAbu9dMUrXlduDrzRTyPqbc/MWMnG2F/eVAzCT/1O4i6e6WYgo@lists.sourceforge.net
X-Gm-Message-State: AOJu0YylaXMK/NqeklmmNDD4QcVGoqAkMcpTGkIN/VzCuz/8hvvPjdg7
 5QMxt7WDz5V1dPcyNV8GY/LCPskndFX+DFCTpfQjAS3aq/7h00aXHfWrhXlmzAyQQW8pZyek7mJ
 zGtTxpghtqID2Y7huJRPfEHXjX4zUaX8lZB+il6eo3RrLu93v+hcBHodUjyZ/nmNeHQgv
X-Gm-Gg: AfdE7ckrR5czFFa1a+jen9IeqRptSbdPL0gzgtzx+zFqeXSRvVRQLAmqTPKGtayuU4C
 +N9TnbLK/n0O9ypzZSok+8zCic9r8t0Rh+UoTch0bZkz+/+tOREKdrrEt4YkH9MJWHGQPQqrgHj
 7couYAp2DkaSqVvmcFYpNA4oR0jBMCFI5QLxlBAS46/KnScGCEr2VT40xa6t+SbyyG0rG9pi58J
 F3gCXvNavCt/cUrL7rS+2qNaCLSTt75yMG1qoAuUrtlpE2WOYnkKiJUclHAgcjxvFy4zPT00RB5
 icuwie/vZQo7YSZc7ue8HS+nVlDpk3dsfsn4zFx13ceEFRMNNx1tfaZgUvnLEgNUjpzlEij4DOj
 Ni29SBY6xl+AGykvaCkue8rrL4cK3FgomdPBbQaqYnBxC6XMFQ/gAfvG7eo3vvf3AoFj1/O3gd1
 fvJwmS+KqT0wQjSgXgLKK8SR09r4NY1Kvl248sFx9l9dOZpe92AY2plUFRk45/CbvAQhY1j1YsH
 gMZL/b1y4uw969ZQ/Vaa1kNsvMyfPtRA5wXaH+UjjIdrht5NzLBargPiBjlRFnOAsw3lYAO3V2Y
 pJI=
X-Received: by 2002:a05:600c:a51:b0:492:379c:32ee with SMTP id
 5b1f17b1804b1-49249083c09mr223291385e9.6.1782201870865; 
 Tue, 23 Jun 2026 01:04:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm377344995e9.2.2026.06.23.01.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 01:04:30 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 23 Jun 2026 08:04:28 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 02829edd0828bd5af8934ffba182588901a03440
X-Gerrit-Comment-Date: Tue, 23 Jun 2026 08:04:28 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7611c843d2f01f14772439c6af4a86b5885d8618-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbw7e-0000Tj-0o
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5808610841328796494=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5808610841328796494==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U38X1EArS1I="; charset=UTF-8

--U38X1EArS1I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan=2E

plaisthos=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introdu=
ce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 16: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Chang=
e-Number: 1089
Gerrit-PatchSet: 16
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: T=
ue, 23 Jun 2026 08:04:28 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--U38X1EArS1I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan=2E </p>
<p>Patch set 16:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 108=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a1=
3ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Tue, 23 Jun 2026 08:04:28 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--U38X1EArS1I=--


--===============5808610841328796494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5808610841328796494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5808610841328796494==--

