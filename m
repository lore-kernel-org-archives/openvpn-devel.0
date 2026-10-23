Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A0606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W2ZXkJja;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TnQoQUVF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=achYu44S;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eT9ytt9f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/aBjYnoMKRe7ziAByKXLvNFTIB/rVnj6pDGv0sZVufA=; b=W2ZXkJjak1grxseZI9SmHOxw7/
	uqMtHqz9SitF2fYNW7gcmq7K42JM1i2euHpIYjgXz1VXNhSMp4+fCr6/h2MvBtctR8y0fFeoEspra
	GDycs4oFsiyxDe6oHxa3ssy9Ln3EykUJwGpabRgPo6gTAEeUXvrUT5Y6mI8NIc60LnUs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xKKuT-000000000NM-2YoA;
	Fri, 23 Oct 2026 19:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xKKuT-000000000ND-05VE
 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 19:26:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FOFiJv5IE6Oa7bnWqqEqt7CZbpP1AUR7n3FBn7Op7WU=; b=TnQoQUVFFqOroe4QagQAbYNQQw
 E0XptcEqtYdSRhXn3Lzsd8B7NElBOIwe2f9fb8PkTwcQKCbMonkPDstKnS5ny5hgcNqa+Kcv15Bt+
 CC26ET8S1n8tA2gGTW/wc/z5csaBOdFDNP9sIheKu424881lEvl01l5PLktEiRyqsKoI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FOFiJv5IE6Oa7bnWqqEqt7CZbpP1AUR7n3FBn7Op7WU=; b=achYu44SKuYH0tv0v9P6OTJLjJ
 XWPg1WGkZzmEgrIixgY0+ZQdleqxZYcFC/wMCv+49CsvKRSgTQ49o8ygdQCuNEa3jBUf8G7moZcUW
 W4Q6aNWeQ6Xb1cLOm2KGW1ss8vYAPetqOJoeu8KGjKPPnJ3EhWIrOcf9ITg/lgyBRxPw=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xKKuR-000000002Dj-0UQ3 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 19:26:36 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so13030105e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792783588; x=1793388388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FOFiJv5IE6Oa7bnWqqEqt7CZbpP1AUR7n3FBn7Op7WU=;
 b=eT9ytt9f//qL2NdUFVwzJhq6LfK4H/QAln1VlC4SXVs6xG4wj9XaO/baujvPnIPgCb
 1zI38CmpA6g++E6UGll2FoVzVvOktJ6S6H+1ORBLcsVMrDyqQkDrsBmOnfeq5M0JAkzM
 TswGEl9XAqGCgQA5uHX/kGYiwNdgaBSzNVKUUKgYsuMYm5/cub5S5KGacYeAwA4xWzXH
 sQ7jH7qAMUPqk0x+DzeDRC1gX2pAUZI7Se5Ccice9varMmkgj+I651Mnp8tS8IUyfzvt
 d9npPfmuPvCtRGAj/3+Wfq9a/7NNnvUIZvvwEtogMkeYYrI3oeZ0RMj04jbOuiZP3Q3z
 OFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792783588; x=1793388388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FOFiJv5IE6Oa7bnWqqEqt7CZbpP1AUR7n3FBn7Op7WU=;
 b=0S9YlZgeDL3dxm/uqyi1eAP0slHARU7++R8pw/BxMm+ezV8AFWsbYSJ0jeB6xgmLM3
 DS90dFicgPYNbfaoq6b709AMrjOp6H06KqDi60+1hsX+8UX/u7LSBJp3EY+n1O8+QzAJ
 pJgidZDGTg5blt67hmAxdoHZl1PlRoYleQ+xGQNj/14B+4ynG51hPkl2lHBnh8Qp54/B
 44lZbaiC9vms0bI+mj0QDjB4mqq6dwf274b1yrhnkG1f5q8tUmfunMQ9jP/uw+l+2ggF
 WwE1eASVf55K1dizs9XPNyG1aDuBjIS0sYzKrkQ6/yXEiLicCHi7envvP4cGNozZ66OV
 YV4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZdRopaTI88LXg71xVG9Xp+uUwXbJi4a57EZUvQJMbRmPwwYlky5PoqpfZK7aWH4RbAnBkioCV6xIFwtFK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL025kX+TXZJUf1rW+EY9bt7adN9Qkn26idS+8g03e+rFJ/n4j3
 1+FUJD5mbQvtoZKv7mdXKGgaGDib0vBK7va5YZ+hLbZkxX+tkre8i7b0b3g/7D2h4J9Z9OVfuts
 firWldGBduVRRpl0f6OkFYO62cRHlD3KrejBD1Ocqgs/ppbju/JTwzZhSgnBN74TMLSBPLi3qCi
 VLMn5uRg==
X-Gm-Gg: AYBFou1vKEJv0WbI/NlSQqxciTMPK/c2mGNRYGjxI3sFZvxvXWDaML/715sMtSvuU0n
 cWwuZqzTbJPCccvdHxDNDhCsoURpIOuNXdSDT17TOgiQmYJKRoHfUY58mX9Q+Sj68/txiKBtQAu
 pd9fpiNNKfy+ykYjwtqIpuqUxoydA064zOtO60gCzLi7e9ilndW7NPgOMv+cRLr4flDCdbdQnGP
 RNVnnIMvU94QsThniKFBM87YBWRHOIqhFiL8bFZllRM5rZdSkmtNP5FSsGD8UM2NkxbHw47mW+v
 QvBMezhEupWgRG1dQbGGlWTnC66wnHq6TAEBkzQ8N/rmcccmFN5u9LeIpz4CPrSFjuEi/rcoZ8R
 ohhK2Xba+xjn6BriDxIntCIzw84iU6nLFUTYBOLDeqrWytsn5MyLoqwQP55N0zIclOok/KmcNwf
 FEeO+KJbz5XeIiim6Kfd88wbsmMza5qVVbm3/4JLclAJ9qyowV8TbYC7t71+cbbA7U6qC8ux1MR
 SQxf/GI6mh0SIL+uPkxm/3jbM5MOB0YPOCakE7lnBuprS1OcHtYbVspNA7j5QsqYvmo+6lnBZSN
 OXHRihqC7HLyfa+C+9SrWePBkQuzAAida7rbMBaWUPLuEb0Dn/0GvfvNmcrQZ12dSp2br/2IjgH
 CNQthJweAHEAA/Sik8JsrxTDJN9t6WiH1EP/N94m/Ow==
X-Received: by 2002:a05:600c:1990:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4a359c9a89fmr5340205e9.9.1792783588359; 
 Fri, 23 Oct 2026 12:26:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm4187745e9.0.2026.10.23.12.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 12:26:27 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 23 Oct 2026 19:26:25 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: b4004c28690cdc057f33573ca50e018eaebe0baf
X-Gerrit-Comment-Date: Fri, 23 Oct 2026 19:26:25 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aa692ad63674a680fdfe1154b0ea6f6149384182-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xKKuR-000000002Dj-0UQ3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4013302023938612059=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4013302023938612059==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pLg7J2ph71Q="; charset=UTF-8

--pLg7J2ph71Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1:=
 
FTR: my UDP throughput, via 25Gbps hairpin NIC, climbs from 7=2E75Gbps to=
 14=2E49Gbps



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1991?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I97c=
55e211f9113d090808724ab43cb3c94099fb0
Gerrit-Change-Number: 1991
Gerrit-Pat=
chSet: 1
Gerrit-Owner: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Fri, 23 Oct 2026 19:26:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No

--pLg7J2ph71Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?tab=3D=
comments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">FTR: my UDP throughput, =
via 25Gbps hairpin NIC, climbs from 7=2E75Gbps to 14=2E49Gbps</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1991?usp=3Demail">change 1991</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099=
fb0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1991 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Fri, 23 Oct 2026 19:26:25 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>

</body></html>
--pLg7J2ph71Q=--


--===============4013302023938612059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4013302023938612059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4013302023938612059==--

