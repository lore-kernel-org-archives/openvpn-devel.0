Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5197DC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4piHffnBW7jTLe2FhP5GfFgrNgJQ4ZxD//mNcEdQqQo=; b=P8TsM/Pcq7pDYEmKLgNJKNnsZl
	ufv4MIEf2ZJmtK5rlEbMEvA20R7w2fuOB7fZ5524LXdclt7xtFU5MuEY0AXQPyyS1+I8Z6lEh97Sy
	/xxLlYUJaxkyTGdz16VAPxG604bJunu/Stw/cFMHg1B2ayFBcCAPT43JrnxJx40DDC48=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weX81-0004rW-Lk;
	Tue, 30 Jun 2026 11:59:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weX80-0004rN-TR
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:59:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lZOPEzLfTOpV+TLKqdxssIMIVhwJVmL2AbRtTMZx2Rw=; b=UX7glP+xg3u+RlpGJ32FB8dMJC
 Twbyo45k/kkwpHsE1Hj5K6bOiQuGtnexqH8eX0uO0FMDLshzXD3vaQ2U0Xt8V1ijJlHwuZ0I/wLPR
 fiLD/7wroJpPxSUahKiht3HwSboB/6JOWvdXx7v4mUP+0V+yiNcoh3b3Gd7xldnhXq2o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lZOPEzLfTOpV+TLKqdxssIMIVhwJVmL2AbRtTMZx2Rw=; b=W
 UcrSh9xAcYZz2STOxXtV6Dy+s4r4YpGFZj+6C7f6TjhjeMxFm7XKUtqYO1XE6mOVpimG09egZZc5P
 5BylSGDGnQbNcAr8zr8Bw4PC5woTPJuZUZp285mL5lvQJjp5o9ieqpAcHZ9aFSMBoWCCbFAJHx2E+
 M5bGFkdtx8cnOrQw=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weX7x-0004Ja-3y for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:59:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493b786d6c0so5711715e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 04:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782820774; x=1783425574; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lZOPEzLfTOpV+TLKqdxssIMIVhwJVmL2AbRtTMZx2Rw=;
 b=FIJ7b2aeFJW2Y6rQL3YUtuFcO6CNOVfNJlxrliMXE72u6eldP4KHgTl8/IywxGCvti
 ft8JVbGX0Yg6ZSFzpDSLWmn8k4P578LiPJT8dswmZmHGLioyFwCW6aWHf/RgctP2xk5B
 2EPsRkcSRtp+14w4alXeqDPiilQhi/osieDIM+J2se7ZsFeBOtAbl1VLD0nzUIWz0yFw
 Mx8/kM9MpSUDfKkzXm+OqP+YVqDonjpnXpYOYpbTKfmi/NlXORD5WLHZG/6YXogFTfjq
 iTUxyjrepamtPM9w4sGBLYbrJV6jaWx9PFGI95uTR8uviv6gfHwkUYnRPQ01uDneTQ9i
 ZeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782820774; x=1783425574;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZOPEzLfTOpV+TLKqdxssIMIVhwJVmL2AbRtTMZx2Rw=;
 b=OYlh8HqMMUKtS9WR1EeJiZK1uG+qM2SztcXF3vuHFYG3yl89DchI6wosWodGUlCL/Y
 603tgc5yl0y+NL1Z/daQAK7LZygzNXylcpYYrKjdRQU4HNIPpH/p2ih+yW3La1Hhbesi
 EILgkatU8Sv2VmtAIM0ONH+53o3Kt5a3fgCUkDtG0vWMWPiiXgMyOiBAg46xk4t7PYwz
 cJKEcT8slrWaneoq3tPGalQVo5rUZo4wB0Gh0J9pbga643JHMuXu0V5wBNd4rkIr8/XN
 q4I2mXf1VofSaedhUM/syR+0jJVavJoHKZnL4xxmcF7QtmQWCK8oJ0XoVefYmCAcxVHc
 p1eQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+2BaQnoYueOnW1jDeKVXxB0h+AaKrtkYBtUrzi8QgmYbC6sKcpSLGqPZ1DFvOLdyDMid5TGFGOwmrYMM8F@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxWXXXYXLLjC9iyegtjT2Z6+Y6bgQni3os36vPFUFIGxKqy1TcN
 qTmREZ+ALhukLWJsVar/cmgMnSUMEHGALj6NStE/5d0fvMQLjOGrSAqt9M9Mmnzv3llSYFIslG0
 ahdZHEgr3AAOYVGmn/eFe6Ey80SB0Oj4mh9IxsPesZ0K/w8JxkjPkZR8a2nRpNrxx9yzycsXsvK
 TPyZjTTA==
X-Gm-Gg: AfdE7cmvJ5b4Pq75EyoEBz/igcC+luMfuJJbTX0MqbDkkIkxMPFkSvFWmWLn48Mz42V
 yYxBuz9mYhJKYVM78UnYJIxAQbx9UW9sW2fCxRmCr476ZaYYyaKOPuJ2QObR0EP0xN8rP8IWiQZ
 WhwHQ5ambPX/EDim/dABOJ5jMH6mMWPhZFCpxiySQqR2B46fqcOQdad78A7xuxFdYy1OPyHwt3V
 yLUBeUx4OSvQVakODwwrs5dLlHp5xkOmHCRVW/KCABgcvtLAQLRQYAQOMtHhHUQOtMFKid5G177
 aEV4vhin05Xrjx/49B7d6uvy77Ngn4U+ouR+xZ/58vOuVfViMmmy/H8y5/iHMbfJ/eycqjv/26S
 P2XFR+jYG5JDl+yHtBX2wCLI60y+jxtuZU0Cf88m/2qBFo8IFR/Sz+1qWwnRW7mAVFJyiZ6Vy0o
 c4xVqLkkRTpt835M6bvytMM39MqBQVNmJSqr+BBovsKcDziHjBOSsxYRh5IvM3sOUAxf3jn26iK
 IRqWbPL3l85GuYnEKabKqvh5iiWODEkuYJlS06QFJvqkEIF8b61bhFoqZojZdX67KtutzKKk8ZO
 37M=
X-Received: by 2002:a05:600c:6207:b0:493:bc80:69f with SMTP id
 5b1f17b1804b1-493bda5fd91mr4099355e9.19.1782820773913; 
 Tue, 30 Jun 2026 04:59:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4659sm7483973f8f.12.2026.06.30.04.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 04:59:33 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 11:59:32 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: e268a6167a01da9be34af5193ec5ba8a5c093e82
X-Gerrit-Comment-Date: Tue, 30 Jun 2026 11:59:32 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aaf9452cdd9a3c6ddb4cbd70092d6586b96c458e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weX7x-0004Ja-3y
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7759026043788837721=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7759026043788837721==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JDexE7TTbqE="; charset=UTF-8

--JDexE7TTbqE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(1 comment)

Patchset:

PS=
2: 
This fails "make distcheck" (see the -package builds in buildbot)=2E Th=
at is due to oob=2Eh not being referenced anywhere in the Makefiles=2E Plea=
se fix=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
741?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302a=
c57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet=
: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Tue, 30 Jun 2026 11:59=
:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--JDexE7TTbqE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">This fails &quot;make distche=
ck&quot; (see the -package builds in buildbot)=2E That is due to oob=2Eh no=
t being referenced anywhere in the Makefiles=2E Please fix=2E</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Tue, 30 Jun 2026 11:59:32 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 Yes </div>

</body></html>
--JDexE7TTbqE=--


--===============7759026043788837721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7759026043788837721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7759026043788837721==--

