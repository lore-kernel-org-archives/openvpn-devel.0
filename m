Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855A606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RIps5+Y/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e7pvwuVR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h2UFJfke;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L8lHl7kN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NqzHsxCkdDQ+GyXazAJJIlgHqaauWAzgBKVbgNnQkCg=; b=RIps5+Y/UIzUcvL+wrvFMvo0G2
	8Nhw/1Mqcb/shKWnMpGSkD4PM1QFVF5hpcnLEZX1y00JRN7mfhZpDbfJgxJUHSzAIxizqkVnO7U6m
	5gPDZIrP+CkyiVQ3cj5Z7PvtOrMfT9Zi/sSSntDJpdc15rDWG62sZk6i9amApSKQqh3E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSy10-000000006tO-0fRn;
	Mon, 16 Nov 2026 14:49:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSy0f-000000006sK-46wR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nletny2ibMVc9hzJ6ukyRt2Xe8feM3hzRS4WpfeoWJM=; b=e7pvwuVR5TtWW4tcuhdb8Nag8d
 O8lLdTR/WMrZZF2KOmszks2wE0gKi8uaV6JsQ10ZiUUdE/Z12WYzu2zBS5daSXBgwsGP8z94GZ47R
 V/9DxA3CQ6EnbQVt3eZNFpD0V1DuvvTuVNwVORMDJfjAZ4zFaFexd92s9sMiFldYEFB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nletny2ibMVc9hzJ6ukyRt2Xe8feM3hzRS4WpfeoWJM=; b=h2UFJfkegdxXFy6YQAtoT/iXFz
 VKEkCGIjL+R7EWTBpCLTHI7bcuefvUqbWx7dLCY0BnfxPs+Ene+mJvN2mzQVs4+Y7B1XiyWC0EMRT
 uup4wifuV5fF6B4eaoszjCcCvQ8kbOCNf0LZ9On1xhiT/YyTHIaTLLPS3WvDSX+7EFcA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSy0T-000000000oj-1TWd for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:48:29 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so23773085e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794840503; x=1795445303; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nletny2ibMVc9hzJ6ukyRt2Xe8feM3hzRS4WpfeoWJM=;
 b=L8lHl7kNGD2pUjuMahP7mqz1mWO1EyfpeDOZQV/XDwDeTEQ+hmR3cji7AyKVszreCj
 t9O42oBgku4vHsLt/zq58yDHbhqfQwcd7n1DTY6yXhp3j6AZoiT/BxbmlOuVfNC6vylz
 KW67vmu/WFOQDN5I7UnYHfJc5k+Ja5eeREy4bXlFivhPvURbkoSGAJrV5mtb/IIDkP1+
 /ZW3R/5mxy+/j+YVOsaM2PICZFjanJ+XB2KuEirxQrPPcfk7alZC+/FKRyx+rOtQIKL5
 lTgmQ4s06eUV65Nm+NIr/hOS8eLOiqvklUz+0DWjuQM59TYlFGtr2dGVH9v2P87MFKfp
 gm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840503; x=1795445303;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Nletny2ibMVc9hzJ6ukyRt2Xe8feM3hzRS4WpfeoWJM=;
 b=VKDsukzW4v7mLGjXaYxspuZbR0H2EOLaPUeKhZRjXR6wQ/lCtk6o/5vd0HCXyrS+gd
 1UEq/qRfLjTV/oeS9JTZ3VeYE9sGVibulsjH+rlhFJRMQqj0nMo+NhH0TfmJWG5zol5f
 pr6ATBAwYGieFB8QCHnNt7gH3x/aPeuShNPJdLACxibBqrAgLtgUvftPE3mS1opYSLnY
 UheI7ktWmG0zZR4aixkJdgCpFLNz4XkL2D8RY/SvcHTYRyht4RHMjAoTTmjaX77GWhn3
 Ws8JQVD0jq53mESfKgMSRycIi6ik61pCP3tJrGcAdhk44+jfLz64EG4IUQx7s+Xox7mK
 c8yw==
X-Forwarded-Encrypted: i=1;
 AL+hErGNBTmh6xWwhdgAX/XMme/fu6nw9/IbuKvAeCOxaaEaVKA4l9pnMJSiscl1L9KP7NdLom8hmO3vPUzpEmjD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z87g5FogQaCQ4fkP4tRT3XAcJIS5lozSr1iDLn5UmBx2QHTr0r8
 ILOuHDzJG9Db4o/aTWVDVwYW8vxLe7tBuJgVNsUqsfZF1fdBtduqi+GS+mq7LGBrG1SLC4iTc3Z
 Xv12veIxfokLkbpipk2ZLvoWOcHYmtlM7iHKmXduXLbtyG1m2OFjIN4iJ9euEgg3YsEZrnIA9Bx
 bXufk10Q==
X-Gm-Gg: AYBFou2WgeAvK/6NleWIrmvwaIs+VeRmjCT6MVaEscX0GbVSvopzkBJbYr4QmiZFTt9
 SjxQRYuih/Zw2Wflb+AamtNANabApA+nNgJoSp3zdNWMLo4DgZRpW+f0pWLP4tKjN2vVlKnFYEU
 fe20mrhqhiYUlku0U20C8RY89P89+kIB56egyBiQOVdw3l9Q2v4cqeXt9xjzqAi/g7pps5I1+KM
 yLE+j2sLwZ0oJR/AOmYiDMkgD4dYrOSQhpzp5VttCQj3vRVYQL5D+rIYj0JIw7dYYB0WLX/eWp2
 ijj2ItcPiFzyTsJlECa8w8cLvrefSLNtUkYETcBCsDFCevQt7MyUqhgqeBkGjF68XbU3Vh7+DcV
 aO0uuyZ6ENqGyst6nZ6M4ac7jVslep4x91yM3k93uWG58QjHdRX7BNffYVSf1bNpudWabT4GpGc
 /+5jGMZTWPSNzkrT6xS8JMAvDLfjvUPVc6+YzD8OeAuZyWYnSPwJD8IAoTh6WRN/BAzDwVNDsEt
 4Q40MaFSvsZa4WruWk1Mbqgrp+x+E2ax225hHPttN52M/2igV/NjEGf3KC3YoNCjR117VvrTdjP
 KvhH2T86um8ptlyJt/2GQvQIkJgiMF1ZWCF2uRMhGCBtl4IvdYbt3p5oGuoQvs1D8fRsaeHMm+s
 ZEvho3mkwpABGB3hX7xNtDqRWEzT0WEvai++gKm4/XZsi/+TIgvJxTCx/uVw8xyp9FI8WVWzOZk
 wPFZ61gdHOYOJ1pgVS
X-Received: by 2002:a05:600c:548b:b0:4a2:1364:252b with SMTP id
 5b1f17b1804b1-4bb55ab07c6mr232629015e9.35.1794840502700; 
 Mon, 16 Nov 2026 06:48:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm233437795e9.14.2026.11.16.06.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:48:21 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:48:20 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
X-Gerrit-Change-Number: 2199
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2199?usp=email>
X-Gerrit-Commit: 1410cb97ef3e502f29609a7028069fd1030dbf4a
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 14:48:20 +0000
In-Reply-To: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
References: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLklmNzlkNDM1NmI1ZGE4MmMyODQ0Y2Q5ZThjNTlhMGZjNDFhZWZmM2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <40890cb1b9abfdbae53a8e76ccb76b10f0f1d908-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSy0T-000000000oj-1TWd
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_util: Switch
 get_num_elements to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7437570884490846730=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7437570884490846730==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z1qMM+Dhqu4="; charset=UTF-8

--Z1qMM+Dhqu4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail )

Change=
 subject: ssl_util: Switch get_num_elements to size_t
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If79d4356b5da82c2844cd9e=
8c59a0fc41aeff3c0
Gerrit-Change-Number: 2199
Gerrit-PatchSet: 1
Gerrit-Owne=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Mon, 16 Nov 2026 14:48:20 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--Z1qMM+Dhqu4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=
=3Demail">change 2199</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2199?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2199 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 14:48:20 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Z1qMM+Dhqu4=--


--===============7437570884490846730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7437570884490846730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7437570884490846730==--

