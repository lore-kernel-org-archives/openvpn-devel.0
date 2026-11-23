Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212DA606A6B5
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fanr4ffJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PDBGrOzN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jtyZr3xZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MmKUH70R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=e+TyTUwJEW5JCgO2OZQY2Jc/DcWPUaVJjAmrqe4iE/8=; b=Fanr4ffJcdh8VUjy+zWvd/ed0r
	6kYa5W01cidrdejKHoFwp2uqZkQe1HQ457hw5+Q72zVX6PCoZkNjg2IXoyTtAheELqimPKdLiuwf+
	lBPU+0O7zCKMkCX8vfsA2Km65MksWr/032Y1V6FoM22iiXdJfO7ah6GyahDnt7lEy9DI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTdr-000000001xi-16CH;
	Mon, 23 Nov 2026 12:59:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVTdp-000000001xc-42lX
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6hh8e6yb6k5lTMwmXQVOGIu+9RFger5Dn/z3CD/OPec=; b=PDBGrOzNXykiIDFQ0qZDGvtQaH
 c0+ObCHYwQUEUnxMXM5yTRrnVFYL1nIo2qIYSg/XBIbVF4geDVOSf5mVAU5hDWolXPVCXlLp8pvim
 Gidufpwlbu3zUqAHBpCfe+8iUkHBRFR/2fOkvPP5882yH9aiyDHYGgmpA/KH1AvZVEpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6hh8e6yb6k5lTMwmXQVOGIu+9RFger5Dn/z3CD/OPec=; b=jtyZr3xZXCzvfIlnB4s9MLXryy
 Ewm1TlzxfVDb3kiPMq6DBQoBK5NfsUK6CpuuqAU3D2Z9//QTMFsjjD8V4dvVth5Bfsfu1tS7ftiT9
 ZV7QPvhQR71GqBF6A0zKuYWkc4OMSOx4kU5D3lXNi4thlqdLe//omNG2xmla4iq8RQRY=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVTdo-0000000024T-2KEw for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 12:59:29 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so2650889f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 04:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438762; x=1796043562; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6hh8e6yb6k5lTMwmXQVOGIu+9RFger5Dn/z3CD/OPec=;
 b=MmKUH70RfDIccDeUvRyQ5NaBXODB5827jSLeoPkw8gztK3TTYTFRerHcHmrK+r3t2W
 aNXwolW/IJT5Bv2IHBDYhQ7Jwb4Av2HIgoDVXjNMIxGJ1DiGltMmgQBvwUc2kyxZr9EM
 NKYBz4BtcY5UgWBtDig3CpIOi76Oih1QK0yH8x18f9xLQU2navi0pof01W63mIRWJnZZ
 BpzQHbHW+BDDRWLprFl5Oi4XXXl4p0I8eCw9YjSlYN9KQtFferFpobuZE86Z/c1/+Lz0
 0x0YKQzdy4QAwlyFFsdQKu2RC9ahm+FoOcHOvWiawBv/umuGikKRm8cPPTKE+MDTeaSL
 BNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438762; x=1796043562;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6hh8e6yb6k5lTMwmXQVOGIu+9RFger5Dn/z3CD/OPec=;
 b=H8DPQVDf+8aiKbi+h6BbwuPPIWBTd0sYExS448tvrd7Ax767I/+/FeW36k7QGCg25l
 +gFvCTXQ0WzXjpDPFvWBEZ77TYoJNTGhVIT76oHIlDS3x3TXTfjtl8KO1+aVxsxBD1M0
 kTV0HhAEIaEAp4P5f1M2YyJ6RZ/c1ItpSbHCN0xYGw0lNZkuYLClUMalKOHYeRHnJgKE
 NA4Q4tfWgf3fKWCkE5IjaidgA3jwT4O40MfbblM3s+3wYM5cbQMTj6tdW9gH9lOw/rxT
 4q6A4vEOZA43JXQd0xkhbwz3eH5mzSjUXVz/O9MXA4Hpcbb/8fBg2cFYbViozfI/buLI
 r/cA==
X-Forwarded-Encrypted: i=1;
 AL+hErHtdSESDXz4Sp6k116Xo5bst8Re23NhUJvTPO2wjIlQXBteNjajRijQ9aFqBP2yWC3eZTVAxOkhd5gg3SR6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/1ubfgiwM6Xyz7WdV1+ipoiUhmfLUyt85PDJKqEhjFqqBAPf/1
 GeSbe1a0D2YjdoZf2BfZlrBDAuJKb6Tk3sqi5atpqaOYfFY7N0J2BGsu5NI8zlwCfKhypY16Uey
 a969Pb9aQ8cFA6T95CSJfYQMxNEZRFc30QbTwNUMOlcWPEd9VPr8QClmcjXLWPEiISJrttBs+X6
 iAsKcRfA==
X-Gm-Gg: AZFdTZeh0rhGDWjjSkzXTAJKXfTznpsfOPm9KtGIrQsnkKBgmY4rRcRIH0zweewsZwH
 ZaAZhI+gGynQk5reJj0WLffiMxlGBb2TKqscOtutsqpqBcDh5rmjwXbvd4BFVr4hqLdN0GEI8hC
 UdwvyCPB/ii7wD9Qjbp43q6eGmf+ELu/aYoA7H6OEgKyM0tytiFE5DRStA0h6j10usPdJWnAVJu
 b6ruj3n++myTirsHh/zPQYJTvcSTy243ecRiwWTxJ5+kdTwKl/ULi3mNn2+ZKJh6lWeblJMGSYw
 NSofYFLtAO/puT6IT4OZ7h4gIHIgnkZ0tHJ3fXIUA1cgAhFMHMPN8xB3HiqdMKChKDLAfsPdKdf
 OqZNQdfoGEmBmrlWCzvQh5jB79V4WUbbCucdHddTClZMMHD7iogYk7yovchNNxj1x2mzHD/8BI8
 LU/0vIhCagcLGejEMQBVxrWiP9pzbLrmaAjFX7Phe4JB5CDO7yVVJe3gAw+7heMQ7RulNwPHgmp
 8oJN3yqTqlhVkNJfsQ439+RrPU/VVWI1nqEftg+mw/wow3DChMDwNZhZdBylDHYV04HFkXmmuHB
 7mMZ7IxNW3laYuN7hB9Sdgs8PGzfI+rTYTirDAQDFyfy/a9bP0t6hALEmsmxay9pvx7mIc3JNQC
 9AO9sggXHWSYdSToWQsX0IX+EA9ON4/PEGKn23LcUkMDAxhbVoJ/56U/xsAbIdF9tWXJRcEfDvy
 9bAKbZtS5ZFUCkNPU=
X-Received: by 2002:a05:6000:2c05:b0:498:b92a:30b with SMTP id
 ffacd0b85a97d-4abb0c5d560mr22360349f8f.15.1795438761733; 
 Mon, 23 Nov 2026 04:59:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm15441677f8f.15.2026.11.23.04.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 04:59:21 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 12:59:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41
X-Gerrit-Change-Number: 2239
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2239?usp=email>
X-Gerrit-Commit: e95844217da65b3cc1cd464b09ac5a0ae55c01db
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 12:59:20 +0000
In-Reply-To: <gerrit.1795378662000.Id142eda108dd4385dcdc263a4842aeb314a12f41@gerrit.openvpn.net>
References: <gerrit.1795378662000.Id142eda108dd4385dcdc263a4842aeb314a12f41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc4NjYyMDAwLklkMTQyZWRhMTA4ZGQ0Mzg1ZGNkYzI2M2E0ODQyYWViMzE0YTEyZjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <19278340d9a8bd425c887c3f1abc27512a3546d0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVTdo-0000000024T-2KEw
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: don't log key
 generation failure twice
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
Content-Type: multipart/mixed; boundary="===============0267510666518279752=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0267510666518279752==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fxEhzEIaYyI="; charset=UTF-8

--fxEhzEIaYyI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail )

Cha=
nge subject: ssl: don't log key generation failure twice
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id142eda108dd4385dc=
dc263a4842aeb314a12f41
Gerrit-Change-Number: 2239
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
nt-Date: Mon, 23 Nov 2026 12:59:20 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--fxEhzEIaYyI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?=
usp=3Demail">change 2239</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2239?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2239 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 12:59:20 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--fxEhzEIaYyI=--


--===============0267510666518279752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0267510666518279752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0267510666518279752==--

