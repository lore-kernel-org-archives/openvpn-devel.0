Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA94C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9S0siRaz2fVI9+a1y6Z0c/4w77JXLUUJ4I5+tZ0EXDM=; b=Ypz4aPfu6ci4N9gtF3gck7gDDW
	iQmeSuyXsouEJZCKSQ0NY6rU438eAJ6CMMvozbXNhiu8tryjqQoU6oId7HKQGbcw1o6H3wSLGLTJP
	6qsr6PdcbXNxuaHV8i5QUPscHNCST7BFcVBlo4zyTZ6Npp/8qNS2l0PPVqGimiCygQ3k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnK3n-0005oZ-Aa;
	Fri, 24 Jul 2026 17:51:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnK3l-0005oS-US
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 17:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AlocLDKlE+k+lF0x2G/nmi/PWR1tqvKR+qK4nuFX/dI=; b=EGTWBbN+7GB+LNli3WygY0ERnI
 uxM/Y/k9q574usKCfGcMUQApS4ZxCLCyQrAF7wh1e2qF2yRLbBGRoFGcgnevfB1PJxhobWyeSSYnC
 aB/jgMKAg4KIo7eGTUNfW5X91+B7tp7eVJblEMB+RUrZJ9LLdQ6Edu9hd+0axJGW8OiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AlocLDKlE+k+lF0x2G/nmi/PWR1tqvKR+qK4nuFX/dI=; b=d
 JZRzV8lDcasaOjdzXup5qRrpl7va502+YlDsWm82ojySGYVdfzE13qtq4C+2+VAvZoZhu0sb6+Zkl
 wBoA1X43JZdJiaWLZDVjgs7mmWeFNF5zPaezx0QvmC+wddkCnTb0+uT1cV35hTXjzMPvJQw09MBKX
 813PoTj72CuEoa6U=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnK3h-0005A9-II for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 17:51:43 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso8093825e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784915495; x=1785520295; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AlocLDKlE+k+lF0x2G/nmi/PWR1tqvKR+qK4nuFX/dI=;
 b=VGUocsBA/rDAZIcjm2ko1mw2Z9MxBP8m2S4k2CTqgBNTadCzaUohAryeOWMYB29v3t
 sz/fI0ICOkgOnK6xIxmop9SdAG3nSQMbGqpkGoRu+WRq8c2pjz+7d4CGYiIYxVLV1eK6
 j29i+ch5LWcnKEIwvroqWa8ZbDmo8FrfsUiZfqxYrYddI8bDpKJB/n0KF6hlnBNIR4su
 C2z2ousw3VNB9q8HmZE/j2PNAaCD5K1Py+rbd29JZ3b8S3d+7H0URPf0LDqV3rDuVfjd
 sykvka/ErsueZEUwC6U1snhdoXZlENT20NRnt+QsfnNbcDFIBG85n69VAni073uSneA5
 UJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784915495; x=1785520295;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AlocLDKlE+k+lF0x2G/nmi/PWR1tqvKR+qK4nuFX/dI=;
 b=qX7oFES1+CexBez5kwGogWkWY0YSg3CzYr/T+6+15IK5fwwCPSaTHC4k6Ky6GrWMRZ
 GF/ppAVa4QhmXPepL5A9UagV2MLg1vU2Vf07eDXtspFXqWyf5m4R9GxD6nYuwG4Vi8Py
 2RB641I++BzhuoUMAasg4FG2FQ3PhH3VK1vKtTNDY4l9msfatcEJyhQch5Qpol1ENHmF
 yqMsZFsjsc8Nj+nsJF9oTQZLICcp9jhQ3nczlRo5zZtVoK31g/zuYB0vsMBkZw/0NAOa
 bivTWBryNWbP4NjZukIEGttTzS1Y+QMN8BsqSR1hcFKnIRm3xK6bXSInx1v/5Wpj/GqR
 +gEA==
X-Gm-Message-State: AOJu0Ywee4MDKT0j/f9PBfb/X4UQ/9SdFKabVkPfEcdRnIE2mJrxiynE
 aZ81DAaRmkb7QxsdG8FZU0kIhWF0Yj4E0vRXVsEUn2G85W2AZz/0PRwTgJZBOZ88I109EuuvABd
 gN1/f0BYenXWlJC/qIhXyeRacGT7JcH5LjFB5rEIeSaJLl/oqInavMuWz2zi3skb0Rjawh8Xm3g
 vcZiGI3g==
X-Gm-Gg: AR+sD12su2rkebT8m0SJb+hmMX/kISQ2fZY1GrZsQnYKPAlgOYZdVtB/4H/oFCe5bog
 FMmvqNDUy1OOCySPhoszdP3LH8iDS3+ZaHjfW/Up8yk7ERvh44slmE6cLj40wpPRZwb1LwwVlh4
 vmRqvAuJLVHlxw9DNb9CBNNRlS4h4pAteMfwLZd1YIm8esezwvethI9ffHesbbNmK0sclZJTu2l
 WoUOiUIteNcAGXXDxayIQ3e2KSznyKxxhzQh+i6GzARqEV97iXk9GvC4+razJaeeHG+Ss6Yp6yy
 3TCV2TCRDqjA7zYfTTauG5O4wTs0FoDbtYM8hWqCCzzp0utbQ5mbYYbx2WX0P1oeAjm0yLh3K0m
 VUYofhbvBpQ6e5mD4YewAaSWYK270c12ZUdRg0CBwTYFwKVT1O/cJsNzouuz2jOvU0MaTGvucXz
 3xZChHIi8txAj3iy81CXkX1kvFg4S0N1rGrOW2AAhZ4brU84xnRxe2hrQxziVMXy2aVzOEXSA6B
 MzzShpTtIuhNPz66cZZIBW4ltIqSuQ4SEATpRfa1ZvjCJ1YQK4I1yuja3nBNyjKvOb8
X-Received: by 2002:a05:600c:1914:b0:495:4d00:2fc0 with SMTP id
 5b1f17b1804b1-49573ccb598mr103688695e9.12.1784915494809; 
 Fri, 24 Jul 2026 10:51:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4d8d6efsm2283925e9.0.2026.07.24.10.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 10:51:34 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 17:51:32 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
X-Gerrit-Change-Number: 1582
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1582?usp=email>
X-Gerrit-Commit: b7b768c1787d2f6b7193e3a73c525a592c63d8c0
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 17:51:32 +0000
In-Reply-To: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
References: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkk0OTIwMzE4YWM1MzcwNjQ1MDhlZWUzY2E0NDlkNDhkZTc2YzJlYTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <52c4c52e234625b9f0b5f5a8a17ebed5525e747a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnK3h-0005A9-II
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix compilation with
 --with-mem-check=dmalloc
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8891260654753681058=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8891260654753681058==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7jsiK12DSQw="; charset=UTF-8

--7jsiK12DSQw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1582?usp=3Demail )

Change subject: Fix compilation with --wit=
h-mem-check=3Ddmalloc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
I wonder if we shou=
ld just remove dmalloc support=2E I don't think anyone has use this in a lo=
ng time and nowadays I think ASAN does 90% what dmalloc does anyway=2E



-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4920318ac537064508eee3=
ca449d48de76c2ea5d
Gerrit-Change-Number: 1582
Gerrit-PatchSet: 1
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Fri, 24 Jul 2026 17:51:32 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No

--7jsiK12DSQw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1582?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?tab=3Dcomments&amp;=
usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">I wonder if we should just remove dmall=
oc support=2E I don&#39;t think anyone has use this in a long time and nowa=
days I think ASAN does 90% what dmalloc does anyway=2E</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
582?usp=3Demail">change 1582</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1582?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1582 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 17:51:32 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--7jsiK12DSQw=--


--===============8891260654753681058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8891260654753681058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8891260654753681058==--

