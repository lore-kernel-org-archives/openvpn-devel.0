Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52975606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mdmInAjz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CLzRllPv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UZbi4Go5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bZrvPXal
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0CWb0jA2Xhs9slrRgEnWxKRu3jHB20HH03u3nRBcJR0=; b=mdmInAjzpy8AHDvy2dO8ITcZ4G
	hScbjeJJ9NmRjZE2qjWYJA/T5BLO/XBJ1npzVh4owEnbbUcP6aKb73Xw/CnHa8Dmb/8h01VEmTx3x
	G2CHPONp1JjTsku6t+6IgsEIBK3yLNPWD4+j0+3e/oBm5iPHBUiTChP4R3VXqm120aNA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTPx-000000004KE-0Bdp;
	Thu, 26 Nov 2026 06:57:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTPv-000000004K8-42uW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=McADZzEGJIuFE7aPbNbM218ABSorFFvelKmiOKuvBQM=; b=CLzRllPvz17JVQOESQCT55MJQT
 3UP/SyRHGA8FOKsw5tdLqSSPF0WvoqmcNyLPi53rm3H6LMp3SlhVj+szX2RViOU+NBTTWMTBClZmz
 icqcpTbABZrqcLBqNf3ydLOEHJUhXMLPoXVMqL1uMXMLp4JvsI9gf5pgZHciBO939Qag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=McADZzEGJIuFE7aPbNbM218ABSorFFvelKmiOKuvBQM=; b=UZbi4Go5UZFQXML4B4CKzQk+rO
 vE0P9zIlTFPfnk8ZHzZCDBZ2ZL82QFbpTwpPrB+qjAjifQ5dWmyAg5dsf0zNRq1m39IAtbfUXQOx+
 bvAkhjz9DLETBO7sTpPCKU6FqxHAOMufSlNnLu0L2wOMyLAbLzYIkWUTMIBSJ6TipbwQ=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTPu-000000003ye-2JW8 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 06:57:15 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so5889631f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 22:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795676228; x=1796281028; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=McADZzEGJIuFE7aPbNbM218ABSorFFvelKmiOKuvBQM=;
 b=bZrvPXal7h5hqbrDb0gAeI8k9XoC0DnCP1gp6HNJTG9fgih6xz9FnJZXS/71gMj6aw
 RbMhRGb2M72U3YwmAbRDenUDq1de/IwBft7UIh11NCIQSJDBZQWcsP/ReDyice3V95L3
 Dw+QaPV+E2GVlai6HYevALVvjm8CMDPphQKbOqV9vQDZN6JxFlgbFaILxR7T8satvtBV
 jZgx6nmHnSpDTVuKUZd0UifBQSVN9UVA8NBvDrO/TvG0wNOK/vQ2LZOQzHwMDRzmCePU
 NQu7uKTjKL3vhDwLshQSH9yOhyfHR1tal2+22N+h20bj+f3B8+rgWUMPJpG5rt7qEild
 XOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676228; x=1796281028;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=McADZzEGJIuFE7aPbNbM218ABSorFFvelKmiOKuvBQM=;
 b=pMhibqGG0YCq7XhewSlIv3cA65G+w23iWVpg55Rl+B7dKoUq5UYF+uq1e70Ed/yFCx
 3z2Nk1muDBHW1os7ZumpWzjVSjBxWZhi/yco5+eFEKJv2ExaYfe083OFhWGp4crfmVO0
 pjPjDRK6LZxdtRwktK9wX3Y/DQr3cCL/Q7sO97OvBSF2T88sQVFmKbW7+1iceixM9rc9
 UF4qvYxnEi5EhtXPJgiuPLLOlsBH5q6LwzPdfZ7/nD6FUR5Y6LcnIiw6XmuOAiwWAA54
 AE6OtWEjEMAJih1At/zoWl2iy6hRpVV7N0MUVxGnc1TMCZxl/J3cbrM3Y13Y1U5XyVCf
 hNvA==
X-Forwarded-Encrypted: i=1;
 AL+hErHJS89RIICY/lImW6V2kmlZhY11q7eoENyBrqRq8ae8wIdTluHBVL4Be2TUaq81QyTQmLGHozgsqwg+K5Gk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Y4KadCKtLkls9AsM6bQWELYaOBMKDSWc7qxk+t5eKm+LvAp/v
 PtTU61oZ100TCfZpGbe3KpyLz97coZ+d1lT3MQ1YIa0tDr/BUi7gJHqs0LJwxlkwcwPG6jgMyQl
 y0nm5IA7H17scScgaGqfDz7PibYpEZC93rg6tzzNyXbT8Rql0nnz1FCsfR7oGRv1oHbo4HhRO/G
 icaXH1Og==
X-Gm-Gg: AZFdTZdf8Hhx5t5/Xyygy/oaLsZV3TrvyeokhrXnrgx1lTmJExZ1bSl48DNQ2vITUvU
 4Zo/HHq48eg29RW7v05aubMHRFI5q0+WnY966T8OfzrKKRXam+M3m6t52yRQ6qSNrZl9pFong+B
 H1ke7GvjR6EQ6MxBnIIw074/eDxxleiCRYVujCBf3y4tEnpszgD6ypBkXUQxajgItr8dbepunZC
 slGUlHGYzXWHdF4fyzoIg/x/8Z+VA7BcevPioZodRqaSymMDNqTCqOhePdCS60oumJVG7mxnINU
 T74levPQ+6O0xkUr5rKcdkAxNDIPnGnwFvhNG2K/TPmeqAhlopKccfThzNbuKXgXfhngdIbP7bF
 oAXa6SPWcfXJcONApIdoTD3bsvXzqHwTS9vaAusB599E3BXHZeOiv6DmN5AbFbiMjQy3DNgw8/9
 Rfn8NIoToxtJsbc5ol/S2T6MxA7zHPAXZBZ/RYWAi6GC16Tsng/OtTcn1gwPONpxhjbUsbosxmJ
 1jb48YYMU3JGVFca2abeD6uLlroND1vjKPk1iqc/mUGVLijU81N4V59r5F0xM+hmsrEhML+OS4Y
 Jg02XEymVacNfQKw7w1N/f+ETiKArP3DQ1dOfukKO5qzyPcusBsyzDKiC0BCZrir0QHmYO0FDvq
 iXGjwHd32589MZJFKcwwLbfkBIhf+Q1MTn/RCwbbxMXkwwbo9+EGdVi33QRIJ4I+7aZXRG7SfBL
 RV/GLsnm/77nJy/Lg=
X-Received: by 2002:a05:600c:a08e:b0:4a1:fae5:f2e2 with SMTP id
 5b1f17b1804b1-4bb887e0682mr405730005e9.4.1795676227761; 
 Wed, 25 Nov 2026 22:57:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba6a0d65fsm105095855e9.3.2026.11.25.22.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:57:07 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 06:57:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: 8e2bca57b9c422b8c104ad665f8186cd65a93fe5
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 06:57:05 +0000
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8709655a75380bc2fd9f661112d53b466faa9882-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWTPu-000000003ye-2JW8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6814838373257722474=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6814838373257722474==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8SHcIS69HcI="; charset=UTF-8

--8SHcIS69HcI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Heiko Hund has poste=
d comments on this change by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2349?usp=3Demail )

Change subject: dns: restrict dns var name=
s and values in the updown runner
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS2: 
So, thi=
s one is a bit defense in depth=2E It makes sure the var names and values a=
re sane=2E For them not to be someone must have been creative with --dev na=
mes or in control of the unprivileged openvpn process=2E So, this _can_ rai=
se an eyebrow or two=2E Up for decision if we need it or not so much, or ma=
ybe only in master=2E Up to someone else=2E =3DP



-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
G=
errit-Change-Number: 2349
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund <heik=
o@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Thu, 26 Nov 2026 06:57:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No

--8SHcIS69HcI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund has posted comment=
s on this change by Heiko Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2349?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">So, this one is a bit defense in depth=2E=
 It makes sure the var names and values are sane=2E For them not to be some=
one must have been creative with --dev names or in control of the unprivile=
ged openvpn process=2E So, this _can_ raise an eyebrow or two=2E Up for dec=
ision if we need it or not so much, or maybe only in master=2E Up to someon=
e else=2E =3DP</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail">change 2349</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5847d602a0240=
44d9109f521de7885d55d28a968 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2349 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eei=
gentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 26 Nov 2026 06:57:05 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>

</body></html>
--8SHcIS69HcI=--


--===============6814838373257722474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6814838373257722474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6814838373257722474==--

