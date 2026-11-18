Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F459606A338
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L424j3w3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gqCyjbtV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J08kBmsQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CtcHmV9u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=y1c6y3Ch3nk5VzYaxVRMlSJtj1EE4mxfDI6eMQaREKs=; b=L424j3w3SoYT0eU8xzMuCAzXxD
	0NSMGKDAOgrNwPcbW6kaSoDVkt7bkWbUpshtGIq8V0Ufkku+Hy1DdzmIXnvS2OQ2e9beUf7sYVPcv
	FNZgG9u7yWL+aaJYHiwJ/xU4ukJeYRpKAZvC3YSZPsga9UK44bsXoeUcxdZsP/vst4xU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgxi-000000004OD-21Pp;
	Wed, 18 Nov 2026 14:48:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgxc-000000004O4-1IIC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:48:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MQedEev4auf+BDidJw6pIbRPM3uOeI5w4MrjTyLRSf0=; b=gqCyjbtVLLTMI8JVf6MUA8l4/9
 u9piBG+N2t7modZsMQtKixFlOX1pW0ueMWCokUl64k3JX7m8DTXsZoQC24M3Ocku2Hq6muq+VlMAi
 uGurmaC770ELbeUIQH7Owxsk4qlsMNjBPeOCADTiexy8eYaD03pPK5VwVBUCbaFIwqaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MQedEev4auf+BDidJw6pIbRPM3uOeI5w4MrjTyLRSf0=; b=J08kBmsQ+p3hy+W99jt0mlMGz7
 5fwnolzhEntoxYlu88N7/F1TXSDH1yY7dGG6F4XSJOhps9rPSOP6SuLIEyQML2C+o6mbmnoxETt23
 Wixy2uyFi4Rfmc8UwVaIVuNd9iOOVr1nKrZLdvAz6G7Bfk8UNHd9asyix2UXD7liS0U0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgxZ-000000001Gt-1A4s for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:48:30 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so8101755e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795013303; x=1795618103; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MQedEev4auf+BDidJw6pIbRPM3uOeI5w4MrjTyLRSf0=;
 b=CtcHmV9ugZwAtKzs2mg7usds+SxkWJKXnZH7hz8JBDWX/jleBG37/jUIhoFdaj6tF5
 SGRYjybMovKYqp4gb1OOmmt49y5ZGYj3ncutj0yRlVp9bnatv2vR4MWIGAM4KZXsu9eL
 OqdSKdo9QvpvrSFGlsp6G4uU6AQzuZbVT+y8NLKlLCIUoCowbXkIDg/ZGfVWlG9/H0p8
 EiZoIpFOgmnImuFixiPS/eATIRwYtyeZi4VcaN9yv6S4w0vAIy9wMDeY2dif3Dwt40cE
 ldHiMB1bVXu1MLDeXhH6o52H8rFyLhN+0+IDblBXMMGUxrrutOFFk6rPL5e5oohWCMN7
 tT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795013303; x=1795618103;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MQedEev4auf+BDidJw6pIbRPM3uOeI5w4MrjTyLRSf0=;
 b=bIvkTqblpVTZACKnuh3majZ4o/MvoJo7W/+sBXZmI3leQB9TEUyHLi8lgY9H5X4Cn4
 bx2NqLhVjR/m+3xBDTarNYt41B/FAP+DHbzsJ+g2DXXnHpgPfONv4NPjBD2+Nx+gK8Ju
 c13Z0+My2qV0AEtLHdo/ARGf4Vz0UPS9hYt8Qldld+moWC1XQkxru3Zjii1wYba5mrVE
 nZHqpVw4f+ehj2+ufWdB6G7DusVejYF/LnyAvC1n/lrVhe/8NO3rmib8Um3tXpGp0PpJ
 Kzrnqqj9NIQGBEQ51EiOktiYuM33qMCgb4w2n2rxEWpPY4gs784guGzePRirJUxInQTQ
 qAsw==
X-Forwarded-Encrypted: i=1;
 AL+hErERAcD0c5hdPFZQsRz7nnrq0MykA+50+wKyMgkIo6/2GlQ56bkziYu84DJrvqmStSNEYYbV0zUeXPkMQW7B@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8cEgHf81cE6ngElzjSzNf3P6Q8alnCSsHoYQB+MxLj+54J/QJW
 oHq0xJLcbN2hYIocc99a+ZzD2+67Wa4a46+UlHSY23LVaoyIQDgglAx5FY7/AG3b82ZNXyBh1YO
 3vE6viIJ3NDmjBPdS5xx2eePQ2163NByK9nAwgEMCllsCpQqZoU4SiIXR8NwKXUUy3uHO
X-Gm-Gg: AYBFou2QZYzb4pb9s4u5UWzgBybCJdRBudjNR+azooPrHpx/e+wclFIIB2YeMzm4aPo
 NJK3DxYIpYaJ12p/F7YflZKoUjSxv/tG+exm02UDjMkr6PCoEwTWACtg5xN6VFCvDMjPM2hhPq/
 t/Y6uD1xkRdkzkDB8j7mLOyecE4up5HPThEINWqo2bWYI45pPWUW9g545fA3B6z80doVvntboUS
 +cO/0BS3lNfYfeeQyJrQJMlO9UNcmCr7sWanjCLHCHmHQDgfB+jU+9iwF+lp6Nq61opFLmrU3QT
 fYWjBaTZ/IrHe6bqmKBgreVRKpxuBMWrLF0raN/GpCnua21h70gieArKvNX6w7mVbUaJ72p28j/
 SX1PjKGPEGUCy8NLDlYsxPZhPeFuPtz3BH6ovEAbQApuOACwfTliXbSkwzi6TXmiGm/dLBrs7SI
 ml23lJOkkDp3rRuD2+cJZXBwa8DoRGMm4l1LbMUceES3uYV2DEZBV1MU9MjJsHZlp2zJ5L9hCqk
 mg29gOiO51qAE1D+GzMnppEnRbHB/K7FQtVhoTHFyKxQ2Qj7zt/Qq7cZ7lC5ohoDdy1pGIonZVJ
 yv9KX6vM49Crz5yjT3gtu12VLf+Za9p+J4ioF0OPCtrd+tKWqFPk9YPiHPn4bhIFTCy9vYXM1Xb
 iiNLhay4FS+up1PWxDv5/O30+CcvGUCBtcPCVZ+gfLiJSLIRTikwceuGMTJE9Uom/KLzDgTvW4o
 LJsXTuRt04ivYBtUZu
X-Received: by 2002:a05:600c:6708:b0:4a1:f8cb:7d70 with SMTP id
 5b1f17b1804b1-4bb7da37038mr53453475e9.24.1795013302557; 
 Wed, 18 Nov 2026 06:48:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783862d6sm130147285e9.2.2026.11.18.06.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:48:22 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:48:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
X-Gerrit-Change-Number: 2216
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2216?usp=email>
X-Gerrit-Commit: 8e7f261193afc791050c8d50f259d1a5f4a6c5a1
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 14:48:21 +0000
In-Reply-To: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
References: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwOTIwMDAwLkllNTMzNjEyMWU4YTQ4ZTVhNjNiNTA5ZDZhMzAzNDliZTQyZDMxMWY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f80687007d41f56e8bc75f97044cf3a734bccce1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgxZ-000000001Gt-1A4s
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: don't
 log inline CRL contents
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8206574847561455867=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8206574847561455867==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZPS+oIlaTRE="; charset=UTF-8

--ZPS+oIlaTRE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216?usp=3Demail )

Cha=
nge subject: ssl_openssl: don't log inline CRL contents
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie5336121e8a48e5a63=
b509d6a30349be42d311f9
Gerrit-Change-Number: 2216
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comme=
nt-Date: Wed, 18 Nov 2026 14:48:21 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--ZPS+oIlaTRE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216?=
usp=3Demail">change 2216</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2216?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2216 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 14:48:21 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ZPS+oIlaTRE=--


--===============8206574847561455867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8206574847561455867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8206574847561455867==--

