Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E4C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yrZR3EBOS8eBGob4Znrw9+s3HiU5ChoerdCGl0ePizs=; b=kqGTyZHMUYgMzmuGp42NfxIfok
	+pCJh2i8u2iW6apjA6Z4fXqwPUgwzeTCskowhPN9R5zMxKwwzvBb+7OgyDLAxBQbKHD0PUXnMgBtW
	bRIqyTj4ewxSmS46knr2hkmPrXbfsgvYcoY0pp2AMUWLG8lpDfwuZRDgeBgsziGic8mY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnDR4-0004eG-CS;
	Fri, 24 Jul 2026 10:47:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnDR3-0004eA-4N
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Mrpsh+yMjBsJ5skmkNZxDN90u/ZxnyPnDOkh5aekADk=; b=Cat1v/vuqYhgbu3k0AOvHX908A
 ifXPjxb86KcTerERr5BTyo2bGZsFutn2OJ/k4ABazm6BH7GA8IizEkmblWSHZXIqG2BvXkmXF7D8+
 JQ9YjC32Qo5fC3e4QYxuRVhlLanZ17v6v07JdYitUKKRGnWF1qbw/e3NQsc+ZSLWBV0M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mrpsh+yMjBsJ5skmkNZxDN90u/ZxnyPnDOkh5aekADk=; b=c
 NywOzO9Y6J2bgGEudA3656l9JpVNDGeTHO0kDuGmZf0Hb1KYZucuKb7CmUlr96Thm3tvMKNjWU/Ar
 YMtLTSxVUiUiPZ2kCbaqSHRwQhtfJDAIGaDO0r0iCMkQq0PbG+8kifGqPkM1bvukGdl4D7cwQujDj
 hn27DmDpKAV4Nfso=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnDR2-0004pI-0G for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 10:47:21 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso2578315e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784890033; x=1785494833; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mrpsh+yMjBsJ5skmkNZxDN90u/ZxnyPnDOkh5aekADk=;
 b=ek0FkntD1M8GTx3w8/Ac/A1OyKRRWSEVxaqT2qDQWTrM29hVaEOMV29J5Lj4gS4Fii
 tLbLlohU+4MH0JdlOnoWKXec0T12aEcisd4hRSiMSXppqUQbwxmkI+a1/vwFOVLLnDYT
 65098dgx8IH7dBMrR3eE5Mq87Y53afRx8whdahM0Ro5pVI0cCKAwkF72WA/l2OmEx4mH
 ZOc2V7162UK2i03NnhYcQteBOZgRkGdsyIi3GLmZJLns1TKWzk1Hzxf7IspAL4SckJcV
 ATDwKrmhclNP4xElTlZwkO4DSYPBO+kuNfMQ2pHLkRhgKraE06u7QJgqrcTgj10enWmu
 3jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784890033; x=1785494833;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mrpsh+yMjBsJ5skmkNZxDN90u/ZxnyPnDOkh5aekADk=;
 b=bnVZ/ABJvHoSglVZHQO1/BDpdOcXrjmf3CaR0PZK9hsRUYekM+nCipfndlMmevvdy4
 QoxvFdVUThaxNYF4hao27ysAUDOi4VYLqiubDo9DTSuTNcBUs6+OdAmb4a8veRexB2v6
 E5tBK4Xm7BSfYtWzkND4b05TobvwkPeUQxM3GAgIFoL/lG94dGzSWR2iLCLIc2ts7wCh
 AHNHD4wl4g9B9L4QQilUlvzTfzr+xEP6vbFYokeaEcVME+tsRKPShbKY+Fi8fatiy173
 TCNhxkpzL/TUauXVA6mNXzPhO2Zr+vplXMUCao1ySv5czCTm8M7xO9+TW+Zl5h9e7G1P
 K2Vg==
X-Gm-Message-State: AOJu0YxF9/W4W2RKX9WIsw2319pfdMjVWsfQP+xqak5hOdVjB8fMCyW0
 iJNvpdrdB6uIjnDWj+CDh6mBkya9Fp/M5uIo8JhL/KsdYTXPufxTHUHdpXxUST1Wu7dEoaxmjhy
 cPuXgyJZE9R6yXmUIUs56V7YdxE3k8ycaOdkMcx4RC9+urSey41Wv7ynuu+HDE9ZZxkbFOWax3Q
 wq8ORjDg==
X-Gm-Gg: AR+sD13FuPRfl1Ml4cpWl2fJA384OC8K3Cb8RAddkCTaZA9CN8Bvfohude/DbSMgdZ2
 HFcWRpA0S97Wkv4xqU8PwqENWQMR9Wy2PZ+bGZx+eYJANjmJseX+drlnxPKvEMrP3RyrgG36KHi
 EoSLYIb494S+EVg+MPiG17SNJMHk8vPg1axNuXghW17qAEyq+wAt32vNs0E2cF5wjLf/4YsrnA2
 TmEo4FR4g4uBlT8WH5LRdsGGoonRLRZzt50N8IQJQMfquMxRHNL9qZ6Dj2PcrlI+fz3F1+kRBKK
 Ir3LvSMoZof9R0ti6jJONABy1oANPk3LtZP2+z/Mqj9Ma7h9TmusL5Kig5con0JVjXY3lfKtxf6
 Pw/iaH2LXzpxGxOCtunb2uTWdc1doyZYycLpo9xYHtJakoKQ+YGG4qsKgXaXLwNKz89G9eBE2mH
 N/NJfzMI4sWBtZJQribyAi+Eq+T6uAJHckyvfpDH6A92XJpDO9DCVmKi9t5pLiHAChfr+wYt7HM
 t2qutiHGP69qmFSt9VREyjnP4WrXZHkbX9blkl0Lis6Bnk53GaKnn8lBxaf6utdeojj3Tg1qsf3
 wFc=
X-Received: by 2002:a7b:ca4a:0:b0:495:4859:8f9b with SMTP id
 5b1f17b1804b1-49573cc6d57mr53461365e9.9.1784890033342; 
 Fri, 24 Jul 2026 03:47:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af6b10esm63988275e9.5.2026.07.24.03.47.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 03:47:12 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 10:47:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 7f223f70b33634472d7e5329855567546ce327ff
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 10:47:11 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62db6d1dd65b83587907d5302dcddd71a6069cb6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnDR2-0004pI-0G
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0637463815184273447=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0637463815184273447==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G5WspUy6Y3Q="; charset=UTF-8

--G5WspUy6Y3Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH =
implementation when available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 20: Code-Review-1

(1 comment)

File tests/unit=
_tests/openvpn/test_crypto=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
31/comment/53a360eb_afdbef74?usp=3Demail :
PS20, Line 935:     const char *=
message =3D "Look behind you, a Three-Headed Monkey!";
All this test data i=
s duplicated, could be shared between the two tests



-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Ge=
rrit-Change-Number: 31
Gerrit-PatchSet: 20
Gerrit-Owner: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri=
, 24 Jul 2026 10:47:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes=


--G5WspUy6Y3Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 20:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File tests/unit_tests/openvpn/test_crypto=2Ec:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/31/comment/53a360eb_afdbef74?usp=3Demail">Patch Set #20, Line =
935:</a> <code style=3D"font-family:monospace,monospace">    const char *me=
ssage =3D &quot;Look behind you, a Three-Headed Monkey!&quot;;</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
ll this test data is duplicated, could be shared between the two tests</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/31?usp=3Demail">change 31</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/31?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageTyp=
e: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </di=
v>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 31 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none=
"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 24 Jul 2026 10:47:1=
1 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--G5WspUy6Y3Q=--


--===============0637463815184273447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0637463815184273447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0637463815184273447==--

