Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0AAC5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C0Air2jdEfV8LYyw3jqX0F8GC8K0DisOBkzDRuYmcts=; b=CgCy1EuzuwsStCqGYDKHro9+aq
	OA3P2jUajC6OSKXIZf1WR37uukqzvUY0YjyAKgs9NMa6N7uk02jSbxedXgyBvux/9RlcKlCA7Tedo
	B0MtuR15bljLkN0Gb8+fBuBy1N2P4QvLW0K/RD2zPiWWijVkfGRf6VJTAp21HZUyz36c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXJX-00030P-LU;
	Mon, 24 Aug 2026 16:14:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyXJW-00030J-7Z
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:14:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bksiXmbfm2J55cvyy6LNKa5Iu5xjI4DNhKZMiv4ZWi8=; b=Et/GEAnfDSLDAMTyMuryladK/S
 GZPKrBXeIwOutdf/44cvqk/Xi6feE4HAtC4UA8RKfjuo9XOW/1US8rZd1SgbhlyC0DYjdmuYLhtjT
 T7tN8ZOjn8BSIh93lEh7AFiV21slFzp3aObeAGcgXwqBL/MYNI6XrJ9f4rkj1GCr4kMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bksiXmbfm2J55cvyy6LNKa5Iu5xjI4DNhKZMiv4ZWi8=; b=h
 cQNPcXz4MhNNT1/JA2KLpQeirTDNPh8tiCSeBz07kTRLg1QKl40nyXzbchkED9rFpRFosVzUVxW5y
 jX0cOeSy16UOIqmWQuTNvMNz2pHe5et/9BORKhtolXLXAovDe3ljCgVxO4la+ggU4rgBWPjOC0eCT
 dU/LdyrveBQkvASA=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyXJT-0001XD-Er for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:14:22 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso521087166b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787588053; x=1788192853; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bksiXmbfm2J55cvyy6LNKa5Iu5xjI4DNhKZMiv4ZWi8=;
 b=DJ6Bx4hfYQc4+Uk1jsEupK9bJem+BTRgPvd4cJbogRksSCksALZsHp++JzbsfHiR6K
 NbC5o+f8USF9PDcKRt0UjB5P7QBCc532QmsbHDmV1ndgFJZylI1XrCD/m3mmGHwKX/Ag
 zYh1KWxuGUchAVSmyn/ArWFGj+PeMyx25gRUVN3jMownQQpMbzznyZOe1EnIfzxw3Egy
 qwVmck4Fp6BIk+KhWVnRS4WNKlNCFBp1VeAON94SqcugB4aK7z5PZJXOpDbXgteMexwx
 Qf7LT8i5GExi3/co73DY4Jx1agIjtqmg8bbZXfWHFiXCntL8t6VPv5Fu1NA1vVWDngAi
 r7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787588053; x=1788192853;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bksiXmbfm2J55cvyy6LNKa5Iu5xjI4DNhKZMiv4ZWi8=;
 b=TudPGGtHpToq3lAq2zKrdgQyQdHtsrGt+eT+/FhrqaIXBqpr/u+7ywRc8A007m6gf1
 GPh/i8q85faztT4iM1VVpeVXTaed4Y6hDU4NxbY5k8AEiYkzg7uIJaAujejKF27uFtC7
 dsZuC7VuYkCfTIoE0MH/lBauHJfN8EIUFxlnmdkreSOmmfRhT1ErFwe69fY9AVB0PvVQ
 clro7c58qWcdn2S/VbjwNhmecIzyZF5unZMRXmhRiv1zz+Ctw73soRpzgeiHa76EEHhy
 Yh722vMfgHnIWUOS+nl5Cc8LAjD0Vt0MKFuijbQf+IcoITQmLsUv1imeCbPZGX+qJH01
 XZbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBCbuo2/d+sKFeA16c2OU2qxjUUEvJR0w5HT9Jiq0m3bg4aktAIvjhrfIY1Bbs9Yw8l1lebj+llKzoNk8s@lists.sourceforge.net
X-Gm-Message-State: AFuF++lN+203go2MxD3Qa39KhzmK3SKuI5gSYBTzcLm0z2vG9FvDqij1
 nOPUVMCGVVCiV4+eEx2uYZUYz4MkunHdQ6WDR55++QTnKjSb3xuJpDCOYo+gpTS/Lkt6yueJXGY
 5LBcw+S/HXszW83E+FqLGJ01pCFT1Sx5qbnH2Cjfg3CIxfstXOqsQnIR3KTkALl2OhJ/1RGSa/s
 J5sNreXA==
X-Gm-Gg: AR+sD116jNdswsu+2NTsmThW8iqTdbS2jXbvHdCeTj10MFzFAM6EqT6p1ZDRUpt0JBJ
 VgVgKNrVsZYs1ptc6bwOUYIpYz7xaVn7qB3cGix5r7xYWM7j48cXAIzQQzIX54jmI0265wnXenV
 IjTsY3XIOXV4EegUGpYRagixtzgkGYAGuqg0c8RBzC0NXq8Wxs/Ap9Tbdq7OkeZAAbw99vo5vQo
 5s92WVaehvWuKS7xlZJ/Lqssjb7y9BMWuWJdys0n1ln1rrQDwBNv5HRcUVVY6/LI+5XfItENYiu
 AfdcesYhWreo8cGGUUxhl5YZVSUHg+hQIj4Wy7rgBfpTQl5WUJhnadHmDTMrC66EVO/4Du1FwNy
 JkeWwkaR9cKUwOzEbZIzCI+wOryPHvM/rkoXYy5FoIGmdewQh2UaN9/LFdwgIMLKk7Q9u/eTNf+
 RT4zWHl8udnfeQVgpb9J4lSBaTfPmPbQiTmbhwFx1N3zD8ESEcfsdbFycPZVPL9dIuIDsAR++M+
 x/j1B2Ocf3iRKS+fh5KtTEKDrPbWw1gzdJok3H6JaQGjFxpZxRpzNj5YdiZcjWKZf7ZoSyAdIWK
 ga3pwTdjVYRQW98LcwfwLTD+LYdt+mg+dqz9tIltIjM5yr6fy8c=
X-Received: by 2002:a17:907:e1d0:20b0:c20:f864:d480 with SMTP id
 a640c23a62f3a-c246a6559aemr2249395166b.13.1787588052608; 
 Mon, 24 Aug 2026 09:14:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b696sm1492774166b.7.2026.08.24.09.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:14:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 16:14:10 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
X-Gerrit-Change-Number: 1865
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1865?usp=email>
X-Gerrit-Commit: 48b7adb1a9cc67261a820bc1be2b548794c221d9
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 16:14:10 +0000
In-Reply-To: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
References: <gerrit.1787570563000.Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklkZmE3ODY0M2RhMjdmZThhOGJkMGZmMmJjZjMwMjVkODY4NzAyNGE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1de8986be242f90ee334d3a779d49452abfd115d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyXJT-0001XD-Er
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: Remove unused
 function print_routes
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6429517958423248982=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6429517958423248982==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="31hESPtHJiM="; charset=UTF-8

--31hESPtHJiM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1865?usp=3Demail )

Change subject: route: Remove unuse=
d function print_routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Idfa78643da27fe8a8bd0ff2bcf3025d8687024a9
Gerrit-Chang=
e-Number: 1865
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Mon, 24 Aug 2026 16:14:10 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--31hESPtHJiM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail">change 1865=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1865?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idfa7=
8643da27fe8a8bd0ff2bcf3025d8687024a9 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1865 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 16:=
14:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--31hESPtHJiM=--


--===============6429517958423248982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6429517958423248982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6429517958423248982==--

