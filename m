Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050F4C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iXsnfohyHgZxYTs6h7Y/k4vjUQ0c6v6cB3leHz9CAFg=; b=jqlrtBtAZKSIldUhqNykYOWL2q
	AVN/5JkIUG8ztal6xI1CJC2cGnTUEhaVYLWrSbH10/TVc7S4KHUUIoafVZh+eOTMXdbACIFbI4VGO
	6gBqRzasAt5oW/ESagk4Qgul5SyxIteDjHMGe0VrWB+dvitoWdXZtHjWIo5fDMMnx91Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupDK-0000PW-4y;
	Fri, 14 Aug 2026 10:32:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupD1-0000P8-OV
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:32:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sXZ/zTag8LYzNZg0GyF0I6cY2sMtFRUmZCphPODjL3Q=; b=c3G/rFPbU2/54hQqLTbOye2ktq
 x61AH2izwZ+5XSb15VcYs4MHdAcfow87pm8ehNtIgKcM41CFOeK8qzwUsBvzBVjqxagGRovTxM+6j
 qd5pmhOJuiENmHNcl721zlSfQx7t9kVz8QCrSN4P4jaavOn4i4zlNFYA369cfBYmaoDE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sXZ/zTag8LYzNZg0GyF0I6cY2sMtFRUmZCphPODjL3Q=; b=i
 WOyjOLSW5bopLr1uH4hYC2U1TUuqUkSMMJhBwajxWf08B8dzmlX4FmV0JjrRHX4EfI1+DaFTp3Gxr
 lWaDhXZ0Ib8yxvEj9XmjwQTo9tg4G/YOU5I+l/mntJqItzqft+a8gFtMfEXW6WC8h9wZokflLq0d+
 pcYUAqFUxotulIJ0=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupCp-0001a9-7e for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:32:07 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so488173f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786703521; x=1787308321; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sXZ/zTag8LYzNZg0GyF0I6cY2sMtFRUmZCphPODjL3Q=;
 b=Kv6ty07+fMlCgGrxLuWv5v6n/6ONt81xrQJfOfxvAfp7JDtyStfrYb6FkPoTLZEkRF
 7lGgWLhbOD5DNRLuNMrv3ys91/HdtJp+m2j47JRQSfQrRc/6osz2ApNmFEIPTDBZfvlT
 Z4XboUc3uqSUAb4XJVg7kwVWrxz3IYeD1pp2nhdx0HKQmWu9ZvAonPsPekw/nK+WbP17
 8ahdNHZK05d1RJn7FMuhcnK88QbflaErx5nvvilMRmhTVInzVxK/omnRUiBmABlvICfP
 L1v8PP7xjGlFqeWQr/wdPHIpKlMj+/fYqdO1oPWfY7Yzi08rgMDEKGC3jZDy1/hyMBjR
 JdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703521; x=1787308321;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sXZ/zTag8LYzNZg0GyF0I6cY2sMtFRUmZCphPODjL3Q=;
 b=nTGETQ3FnAgVO8G2BxkH7YQGXPmLyTUQeiqbK9bVl2enfhcOrpAg7REljK59AmU6+A
 g/+mN2ZOkguBgwNlvJKFLNG2cDFm31VOOM3Vn+/RZGy8/utv6+DUtFX02NA/xYkreVhQ
 I99Tx4Y/Pxuvz3lMJDf7o/AB9bfsUxd2ACcXp7qbgFB26Denc/Jz3t8YeeH+airCziNO
 Y44CzxHOiAuoYpwj2ugkuh3hEewjfp6yWLX2kvo9MJaXg4XymhZYOr0P6jck7lnAbwQc
 m/h6B35RwTImW7H2PXv6A+zVJ2zqZYczrFbVQbsCFC5RkS6intkSn1srRNIZCxmg35Qr
 vA3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RojZSsGza6nNIHskTu8JfRQOooSDX4Xa42rB/Vdq4tW3VIsjahaeg3b8veRUU3zykVvhOHUCbBKdf/tudTW@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yys2/JW58QXcfOA8pFBtjDMkWePfib9WzVOi3zkWpTcRqiGKlxa
 TORCBzowvdWXI3jflWy0GuVl6IT44zzfsD5vg0c0MWGIp3QmhUPdlpbMBzcVZDT4ESbPLAz0jHW
 Yc/2ZNKH0dLNNdKs1fejdil83elrAqTpVGx/7xMcXX0XHsyONpvFz1ah4C2FwJXdc5GdHVhggdj
 PSGJTu1w==
X-Gm-Gg: AR+sD10R/CFpQdK2zdAXSaHFWhuTX0DYFg1MGh0MW+2Sj4nmZis+nEYVdSeKHJZF37F
 xe/bqwBpASi64rPERvZPYyDsbMV6Cx1iOAmNywDr1uqN/1YC3pLGd+IESmIq2ukLd/ofTCknq1F
 /gwu8k4dKpHfoWk0gRRUAtBVhOJJGAxN4/U3/wyIbJBRtuwtqsIemZtt83CVqusqnio3o6JcHu7
 rxIjRancCbhdJ8a2d/lJjWgzqYyM/+ROqK3+o4XjlM0/gSgs9oGknWo3/NnyLKEhnKoaS1Hs8pZ
 VHWtsGIKkeMeh/Nfp6Vur9GPsG4IcRO9nuUnlqKkQA+00L4QFEJK1dxvls8xC8ukWR0Uk4ukCuY
 4xsefsYogtOaKDr2ZyyO4HOCA5Sg1BZq+URDhjPPzNw5vRcnVsseY8PUHbSb+aDalC9wfYC1U3V
 p2py85W/wiBBSUiY/eripq5xSWUV+yp1xwWnhD4xyYtO1Jf3apYPgcdbi3SOQYn7zTIboMeYaFr
 u/y/34yK1foFSSL2k4V4v0D7XYIvAG7ORi3OleevMFNuQnSRKztnynbLJ03Bf83SUPZ/c8B2HVb
 swSQfYaj0z+KX1QP5cfLO/KA3utuZMLkzZAdQhjM5Xax3sYhu88Stqr5HudKoA==
X-Received: by 2002:a05:6000:40cc:b0:481:4697:a6b0 with SMTP id
 ffacd0b85a97d-481607a819bmr6726617f8f.20.1786703520616; 
 Fri, 14 Aug 2026 03:32:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c0a75sm7662740f8f.25.2026.08.14.03.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:32:00 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:31:56 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
X-Gerrit-Change-Number: 1661
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1661?usp=email>
X-Gerrit-Commit: 0d5e957d0e99e43b2e56527d4bf0f0d3d1949b84
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:31:56 +0000
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDEzNjAxMDAwLkkyYjcxZGFlMzdlYmU2M2MyNmE2Njc2MWY4NzdiMjVkMzI2ZWQxNDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <52d26be9e969eeddbf55eb955780599d5584425a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupCp-0001a9-7e
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7659239018942544890=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7659239018942544890==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KwfSPJIBO8Y="; charset=UTF-8

--KwfSPJIBO8Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1661?usp=3Demail )

Change subject: Remove instances of=
 constVariable/constVariablePointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10: Code-Review+2


-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63c26a66761f=
877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 10
Gerrit-Owne=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 14 Aug 2026 10:31:56 +0=
000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--KwfSPJIBO8Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 10:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">change 166=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2b7=
1dae37ebe63c26a66761f877b25d326ed140f </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1661 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 10:=
31:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--KwfSPJIBO8Y=--


--===============7659239018942544890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7659239018942544890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7659239018942544890==--

