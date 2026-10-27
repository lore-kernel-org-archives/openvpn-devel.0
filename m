Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46711606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IrPX06O4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ijDiuoAm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VG/7qBvt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Z3JWWrpl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6Nt1VFKFf0fBbWk6yZser7JKP0iAHxvLoqNxhi68Dpk=; b=IrPX06O4AR3IiZGa81BKZhhLfd
	Uqsjwv7+CzcHPZ0/AsTmrrf2FOprcNDzbPCnxe4sX59kjAegazTd2Xxsv2+RMrClC1MNc6BF6y3zw
	Pib4DI0ZiHnS9reUKEkfMqNOjEzcBJlXgVIWyrLq+DuVNP4PYSJUIkLKzWsbdpUg4M+U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLfCz-0000000072W-0GcP;
	Tue, 27 Oct 2026 11:19:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLfCS-0000000070L-0GpF
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w5YUySJjqKUFv6TMOJH0nmpQPUsT4HxoG7XYgFMue3c=; b=ijDiuoAmXoS5JVD3p8MiMAharr
 jl6DXqOPaEnhkUO7BlqFLpPTqpLxY0izLxemWmoRTdWco19QI1RexJkb8IXJQPcBlfumkh84y/173
 915pOjH5BgjllQIHsARgYLKxZJbk5VN6CiJxJqYQXX60IoKqayOwMD1gABBhImMI+SXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w5YUySJjqKUFv6TMOJH0nmpQPUsT4HxoG7XYgFMue3c=; b=VG/7qBvtpdpHjD4tzFZ6D59Z0i
 zqBhLZqkKOzUHMre72g+0urPhgIxbB0IsTZTUYkrgoxMqWk0sbNA0n7wAmw7s2xnfaTRGHmM87nau
 QvEdzXglsljEIkGZQx9rTCF+Sivzy8jlw9nJAgBWl4q1/Rr7iJ1uJiJWGkaAVE/dJpd4=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLfCP-000000003fl-2C8f for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:18:39 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso20201125e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793099911; x=1793704711; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w5YUySJjqKUFv6TMOJH0nmpQPUsT4HxoG7XYgFMue3c=;
 b=Z3JWWrplEKzDfyyqd4oN9hsy2kLhWD4weqCzdEH6HEKBxZTrirG9AYpUpzx9WrgG8Q
 ZuTvrkIK+lrneAfCuOCQpgR/6sIex5BH0iif+XV3rlmdKuCnwKVDO90wuACUhkzYbvAS
 0sgHHCnDTvxSOY/qpWZ29GVCCHcBLbxvn3vw1ypctFfpVzw4qRktdG8Dfowueay7+Mae
 PqROlrvpsGTeuo7IPyUYbtK/TWlV1efvTOMOS6JydKRcgcmC7Skx4BaYi/dTcbf/gtzP
 zx8e3Ozoc6FTA8Z3Az7vthOgSjh23eLqkRQz98ljZwYACMFSILpI3A7Qx8aoVQEre+rJ
 38uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099911; x=1793704711;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w5YUySJjqKUFv6TMOJH0nmpQPUsT4HxoG7XYgFMue3c=;
 b=A6zNBiYEyysR8o36hGdx8zq31sSE5/d+hQgh4v4wE+Joy1q+XdBes+XavjL5Vk1LTC
 VYAFooxTDTyXaiyVMjWtj/ROfvWSD7zeE04wSe0NNT4c9R3xskzI4W0+H+TfnOw0hS1i
 EarqBMU/HZMtl2GZ8W/14HItwWGquuA5ExPszeQzUlsrkjbii+pGEA6xLaBRj9VP7Rxs
 BgemwlQpm01UtiYxZQslA0V8wmm7D8D2Ts+Y1uffx/dq6Kw0vGfaheT0dR4M644xzen6
 +p7PmGmZjLLjaIlqCjsq6Zs3hdO7XgWFKBrBv2cDA02T1VIvjrOgfjiDtw3jL3DdnCji
 mOpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmyIp+7+9OT73BJIWWVw0VF26tzAc4Bj15jT0lYocpApXPzsgraT2MzBLGvT7iMiMFUnoUFO2Gqmwe2q2g@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKbVJzP6tR/6Q4SOjm8zwcI6tT2mfGcyglwCLYO28Palw2Nk/AL
 LfAMGPHhOK042MdHBl4099fpagKcdaRO6Ta2IHouo/oVsvQSxzDNmt2xrvSQZ2YeQ8JGxfbPGzz
 wI9BC3tyBt9lz4lUjKCT6B+B3rLeEbCAouWoGDsJWIRWeEIqJJZ3/kYVsLfvdcXpowwWr
X-Gm-Gg: AYBFou3Er6h+xN7/ywsN8cpmTyrygqlas+8qbQIo8wHI/GpFYzvZMfFjY7fgRyVzs86
 OZ7w1LQpqbnAyiUPrBy+bR6F4XE/c4EK3jN2cU9NyXalQupk0Lz51RIbSFu/2DsOJGQbxosz2gP
 TEoJ9Rw8vaBeF87E/BaXcBpYFz7s4ukfx8uit8r3XCwmx9eUIRF9e1C75tGDD9gLJTBpQd9x76K
 bWAM3+pL/FvJlsPV2CIq8FH/mEj3gNl89QSSS9RS/IbPa5Hwy/i9nsfFIGbiq99w32tj0uKEiAC
 muTLF4XAhkIxyWsbl3Yj92W1sJBfAnk6PURBwLlVED24VNTooEI6AuyIKH1uKf9dgyIKNpeiAv1
 dgGzGcLDUaJIc0I3gXhVovu+ARcrCDygBqLhKfd193AgRrertEs9ZibMcl52hHOB3kaIdvo4own
 cEmEPk+q51/NzXuB78q00ILv6gcVOAPoVEzL2t3SLopVElXcou6fnofOi3xNcM2OnkpJpXIX2QX
 F5iWn8URBtcKO3hZXLnZ6mF88HvOCOVm0XVi25/cylHqh1rch+/dgH10+me0/ZH+wAJU9tlphFW
 cEM6qmnWoZ8Yn7N4nfWLoqaSALCT1qJd1LWiljBK37uzoVXBJBsZoOOtYCAV+c+mD1Qa6VBTIiw
 DdOnQknlWYv+L8nUpBkiJMVKHhrwXmTJBygNaRQ4IGgM=
X-Received: by 2002:a05:600c:8b62:b0:4a2:150f:1610 with SMTP id
 5b1f17b1804b1-4a35acd5f91mr165918265e9.23.1793099910860; 
 Tue, 27 Oct 2026 04:18:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm448570595e9.0.2026.10.27.04.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:18:30 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 11:18:28 +0000
To: Laptops <jeff@incrediblybased.co>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
X-Gerrit-Change-Number: 2034
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2034?usp=email>
X-Gerrit-Commit: 8a522b832d47a21474e5f06da900e418d050f33f
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 11:18:28 +0000
In-Reply-To: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
References: <gerrit.1793032811000.Icf890b018b9950c698e46cc44b39edaa0c6ec566@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDMyODExMDAwLkljZjg5MGIwMThiOTk1MGM2OThlNDZjYzQ0YjM5ZWRhYTBjNmVjNTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3fca4cf2da2455e8013b44ce2997f0400c1b4171-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLfCP-000000003fl-2C8f
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: restructure
 some loops and assignments
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, jeff@incrediblybased.co
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0108447475733877126=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0108447475733877126==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QhVzNKC+gRY="; charset=UTF-8

--QhVzNKC+gRY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Laptops=2E

Frank Licht=
enheld has posted comments on this change by Laptops=2E ( https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2034?usp=3Demail )

Change subject: buffer: restr=
ucture some loops and assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Icf890b018b9950c698e46cc44b39edaa0c6ec566
=
Gerrit-Change-Number: 2034
Gerrit-PatchSet: 1
Gerrit-Owner: Laptops <jeff@i=
ncrediblybased=2Eco>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Laptops <jeff@incrediblybased=2Eco>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 27 Oct 2026 11:18:28 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--QhVzNKC+gRY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Laptops=2E </p>
<p>Frank Lichtenheld ha=
s posted comments on this change by Laptops=2E</p><p>Patch set 1:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demail">change 2034</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2034?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icf8=
90b018b9950c698e46cc44b39edaa0c6ec566 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2034 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Laptops &lt;jeff@in=
crediblybased=2Eco&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Laptops &lt;jeff@incrediblybased=2Eco&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27=
 Oct 2026 11:18:28 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--QhVzNKC+gRY=--


--===============0108447475733877126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0108447475733877126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0108447475733877126==--

