Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CF606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dTv3ncfM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V+tZoiLp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Tl3Rv6af;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V8NcKG5L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+Wzom4XXiiiBGsDS79OT+iuYg7Sy8ABEkBboz+38AVw=; b=dTv3ncfMCQ+hkWgKwSOi2bBl5K
	geHwI+Ir2hU6lcG7v1+eApdSUY99TqJrgmXuAVDGm3fIMUekTtkofKRANAukombunh+mBjxkzCQ0Q
	pyk9jr9MwRWNFjFwgJlpczoJHl687b10txaEICanyKs43WsPcWXZrKbXaMs9XaszK/q4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5Gc-000000006hy-43td;
	Wed, 11 Nov 2026 10:09:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5G4-000000006hK-4B0W
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oS1xKdqhtAxfR49PWoid7X2qZmpc9ytznp8SPHF1nys=; b=V+tZoiLpS+FhfthY2jMtOpjiLB
 xte+zmRN56GAeN6cNsULad7kUO0SdtbQfNLGMQriYYAXODlLIOBZ0y0QeO/P940+VfHvToITY5Cky
 97ay/uWKXJkTsLsfTuPzFf6fn5+9erZPVaQyOtLwbsGs442JCn566xGAtb4X+PpM/Ha8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oS1xKdqhtAxfR49PWoid7X2qZmpc9ytznp8SPHF1nys=; b=Tl3Rv6afYK/ezrk6r7XSXgs5gC
 LfmxpFBYib4acRHMpahOy7eq2Dl2Yn0Si5OFfDeiTlBExb0zaz3Bf6PiDigmhAnSt6Utv8Kw+uZza
 isq3M+yu6z/4e6HV0UuDmJcle4LjycfW3vXAv9FNb76w8G14Qq/un4cvbZltEZEBmsn0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5G3-00000000240-2ZJU for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:08:48 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so36296005e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794391721; x=1794996521; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oS1xKdqhtAxfR49PWoid7X2qZmpc9ytznp8SPHF1nys=;
 b=V8NcKG5LT+PDUHyvMgykCSaKMCpyzbMIzDXWKeR7+LAy9plm+b9cA4q0v9cdbS0coF
 fUtUOE8FWhWx6TI0/Ygi63iQ2/SBnNTxBXGJchw5xQcHu7irIzqGzLPBQO4kAa7ZAAj5
 qoigHhMPCnCNCVuGH6/z7hoIZDlOCufKOhXuEe4OD2F8pUhZ/mCHke3d+ki60+yL7JYx
 iw25OvpDunRtch5IvowWW4bMO4X/+bpzhG7Qon4N9m+isPXaV28ovVAS/HD6JX0Eu6b6
 bBvPKH+Qp+LVtRGBq7dtD2NojII1SFZWrc+FIuuT91vYuzvnRDHxLkKILQmmtXiAXMKz
 OD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794391721; x=1794996521;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oS1xKdqhtAxfR49PWoid7X2qZmpc9ytznp8SPHF1nys=;
 b=W6JAZyrs3fvaB4FPNnem9jlhvePJM9hO00s5/SkleaHbMgv13xnK9wkhRMmuxrks9Y
 HtjDI+r57Ke6ye0CQpsC2SNo1vGgi8MuzyZK7ivqzQCqW0I6uCX/2gBA9rCtYoqiVWPm
 GZXICH0XjV4IZxa2yTdzk0xF86e1bCwaiZi9lRbb12UUUuel7X/d3m5hZan4b2Yoh6Jt
 abjJDoFW6LvMsT7ZEbNr3RxDRaE8HKJd4dh/38UqgHLTrssmmszQppcxPIKTtnJ8rqZY
 nzLHOl/WNRMFpt+FQx757Md31aQzLuLjb+PO/rglrWPA3r+G9HziwiJ7VWth+tiIl0lg
 ZvEw==
X-Forwarded-Encrypted: i=1;
 AL+hErEiL6DdE7VPns5D8F71GLz/H7BAHOaotiz16Mg4gkYql2BxKZGPZ4//JMwDBRu27ZWsHOoaLlvYbDpjs67A@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Ca7DxDSsTQ2zpklo7FQxNO929xrJJuSoykdQV3iOendyO5W9K
 5fCPAjTVYttTAudEVgmz7hG8wQdtG+5N/HuYzttULA4d5ZWM3cpIgzRmRNcAIYwnLIh3bfPUDQW
 eCeNtpae2O9g81C3f0MKVATHk04cLnhLOSSw6Q5bFVcEXIvuyk0oZVRVZFHakPLF6TXH7
X-Gm-Gg: AYBFou2YOCLcEAct4u6CM6srvy25/8joAGZiYlIdDMyq9Kn0EizATs5DTN/jNURgnWp
 2+9C8rYwm75FwzgScww5l7SFXflPpW8xDU2seir+lXqWXDt+FB54V1MQMCRcsh9prgUmIHFYfFB
 cSNiIy7TQNfoeIek768vptX0EqXvjCy5cCBpEEyWQwErYjTcHBw2iimi0FI4Zc8enH7P1cUJ4FX
 MrF+QjVkejk+ogoE2HOS8prIazGRaZZKcf312wGKcpXOb7ZvMSnIS++jVkn5czAENI8KC0HXM/o
 LI7SnMnNEpWTAWwLRgQp/W7pViCV9tFqYvglTcHU+66fJhBtb4TH5F+DpZfm7kRdI7le8fla3YR
 jGhxBvsH2ALSQh5rGgd0hyJ9uPfcTynwjTKtgrvV7zbiuRhgKmCq7PceDm2YYI7emeeuRAxV53x
 5oYY64nEe2RXgO94PQzExOLkjkgdw2cQYnBwLqNALjFe9orMrW6R4pEsvZ8pygpZt/TWybgS13O
 yvBPzaE8eSbXc29jVMiKT8OZ/3VxRH84HpVMzIYUVSIRVTE7goIsAlNaaFgO/eb0Pn99o7HoJFJ
 bURO9fKd+BxDkf16ogXSNl55fZt5xdUbODwKS9xnWdkWBzbvkidZMeZTXdvaaGSDTeP8ksbIl4t
 wkQSplYwL25ycVg4rItZ6KrI/0Bw6SfwYBbRX5EVIN55lMAQq23GDfbChTwcFbl1TFelgn+6nw/
 Rq7WueP1Tm6BUCjwg=
X-Received: by 2002:a05:600c:8119:b0:4a1:c27d:e1a8 with SMTP id
 5b1f17b1804b1-4ba0936c932mr32750325e9.10.1794391720853; 
 Wed, 11 Nov 2026 02:08:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08de826asm35509695e9.0.2026.11.11.02.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:08:39 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:08:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 3ac6ba619e4e2bebdc5f54b0e80b79f0dcdf225a
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 10:08:37 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <064e4ca0efc3246101aa7d64865999d10f4486fb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR5G3-00000000240-2ZJU
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: accept
 a lone config file that passes validation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4897259299174305815=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4897259299174305815==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VAfAj7u88nc="; charset=UTF-8

--VAfAj7u88nc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail )

Cha=
nge subject: openvpnserv: accept a lone config file that passes validation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review-1


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2159?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57=
469ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 10:08:37 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--VAfAj7u88nc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?=
usp=3Demail">change 2159</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 10:08:37 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--VAfAj7u88nc=--


--===============4897259299174305815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4897259299174305815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4897259299174305815==--

