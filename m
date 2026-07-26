Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBAFC531FA
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 02:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLQrENjVuWDktMHsiJ3wODTw6mARg71xfvLbyAf4Vxk=; b=VZAxmPvPpkiJAkog8L2FXHGpBy
	d8Wkiy5B4V6OqdyB3FGo5M+Qi9Jxoc1Iu8VRHz3Q1wcs6vVtEiMGOzErwZZbIp5PmTnWzwPoe42K0
	uvYJ8LWxk/GDdJqc/6nfv1Cp9xjiNwh3heYAJRa7u2NZ8W/rS8/8Mi1MuYpSj+I7XM+U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnoIy-0001mQ-28;
	Sun, 26 Jul 2026 02:09:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnoIg-0001m6-8G
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:09:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HLCxKBAk1LsoYh/PgZF+bgKgMNXCATqNMohFB9EpRgM=; b=Dkj3ULEL1fkoZa2aSOWe8NQNvQ
 s9OArsaBi8AkritDBKk+AfpCjUeZvur6liP1ulGgkzVVcf37p8KCe6jnYcLGYUd3JbmZDArAtS0Of
 07+mxrskBL6p3p/gXzPqmc67cm7IBANnvfLDAi7Plq9oHUtiZBcGaWgbvK+HoguOG+ms=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HLCxKBAk1LsoYh/PgZF+bgKgMNXCATqNMohFB9EpRgM=; b=k
 w8WPd/6/9I1PHBsP8rus0ZODdC6XsV3+qCoKlEcX3D8nGbjczDMysE0ohCsyZU1wrh02ObEW/krwg
 wP/SdAKaPY0NkOoYqPWPXYfa22LfqZhWfIDZyFDl4blLJ9VyR4ZNU+oo7g8NPX4ZipyOTDwplFIe6
 s/wTif1m0z7qW+4Y=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnoIb-0000Ea-Mt for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:09:02 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so1054053f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785031736; x=1785636536; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HLCxKBAk1LsoYh/PgZF+bgKgMNXCATqNMohFB9EpRgM=;
 b=DfsiHKhllHmzh0d7kCRMLHSMCsSDtDwkyBRBsIpm1effT0R3LUECF5mvKplu6+8Lsv
 vuea6oHgyUP/zDEdvdtHMAXC3sh8QZ4rSMG5leSsfhYO436Hp0R3dwI8xKU7HlE77JH9
 uD+EeD+N11TCWSsABMoInfJ0glNvc9sc6dLyvBX587ZKI5BtXv+EW5sdcQH0NuTm284N
 hfyNnToViH5y4XsfihOONHys4ahsnAisP12pX6U2RXq0jdc/b3Aw+vB+tB5JHTlUMVzK
 shwOOP/ULYZ1GmYoiCiaI3udi4A94kT6Q19pJePNaY1r8zUM5TLq66hBdYhAJW1EgQ+X
 nRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785031736; x=1785636536;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HLCxKBAk1LsoYh/PgZF+bgKgMNXCATqNMohFB9EpRgM=;
 b=Df4OMraHwjVQizYtXUjMV08mlee4rOuOhCJLrc9eKN/sZN1maW2sVRiX6f+9Y4ZFzF
 nyOR60FYvrLubmacLRyoWa2mp1V5IrX9yRnSj4ltryNQUJrLS7iRFdCY2LyC4N+XtLfs
 1I8FMOxSucpQpAshEXHO3HxPo1Q3HMrss1WYP8IO4mN5ubAuzRt2/6szBQQSp2rDPhwY
 4HvgABRYFnmIsKXYHv6XNqy8Bn8PFSB7ke1LyRudupmExRclg0MpXp9ibmydMYQKC2r8
 UDeKiLhchwPCFBAoblRmppgw09Mfa6fhHDdWeVk/iOIqkMvDeIJqBZd9/81a+thhqOcI
 SiEw==
X-Gm-Message-State: AOJu0YzC+h2CTG88GsbkbRSVTQDXxdeLa9pK6PT6pXCjN29q4GhBhu78
 qjTFDvugOpZ627E/zjB+RvnC3urR3xPkyGSAfAr5rer6KJTnYkEWTcYAUs2RX8FJUkJxUyIAffT
 lC1KiUkql4/ITtcF07FBjP8yIR7wlYDyXS7e/4vbV4i1RViR9w0afRdfcnlXlXU43f6I4qocDxF
 n+1PDNLg==
X-Gm-Gg: AR+sD118BxUoKyR5zOTwCiFlggnQLl9CTHS1+9qzV6ibDakXIUWXcaslwLRdlGZMOf1
 YIK/JiytdHR1YeBCMcaQ/WL2hV3IzvGLViAq2j2pkTmhXZ9GRnkSvkxqWsotlqsZtW/eqZEcPig
 JA/i3p+tiGmYjEKfjmNMj0CXTALUpSmZ34TgQaLYF4SeGNdP7DfbDuKkfRxz7VzQzwRAAUpWBgN
 GIvVLP9ClqJjB4eNd/ZW0+31W+pEpMbH1BZPW+sVIQO5ukRNF2VImbBP2JikhG5/yHd79Q8N+mp
 2myK4QJw0V/L8HNBJmlSQETvqZwbZ67p797WbOXvzqQEInLs84MfqCyys2pIRIEipUb2k03ChHI
 7/XbqSozlJ5B3F9Whb1Fss5xcLIJAxnJsyTl2hFlC/g6x+HVzfyP7FYKh1O4t6rQGUxG/DcS5Yl
 SpderNhAbc944G9OijlLRcmVLRZTHDxknShzrpnE8Asj8gl9LZTPaCEUajfTmly2yKuHI4Rtes1
 5pLtb8WCYnjdDSDrION/vBCcsSNOudYDryzmH9oPXS3++n6p8wsjmeUt7wOpuC12jXN
X-Received: by 2002:a05:6000:25f6:b0:47f:93e4:5389 with SMTP id
 ffacd0b85a97d-47f9fc903dbmr4450355f8f.20.1785031735522; 
 Sat, 25 Jul 2026 19:08:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c631fdsm35090405f8f.28.2026.07.25.19.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 19:08:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 02:08:53 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 060ee6a4015f002fe2c9e7029a22834c596bd667
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 02:08:53 +0000
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aa26bea56293e2e3938ee4574e7c90b2f028b0ac-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnoIb-0000Ea-Mt
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: fall back
 quickly when a handshake shortcut is ignored
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7127988173242732527=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7127988173242732527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1LB7+B33u2Y="; charset=UTF-8

--1LB7+B33u2Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
771?usp=3Demail )

Change subject: oob: fall back quickly when a handshake =
shortcut is ignored
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 8:

(2 comments)

Patchset:

PS8: 
I am really confused =
what you are trying to do here=2E This seems more like fixing/masking an ot=
her bug/sympthon=2E


Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1771/comment/e1447272_221f0d12?usp=3Demail :
PS8, Line 10: drops the =
larger P_CONTROL_WKC_V1, or a version/bug mismatch), the client
This is wro=
ng=2E The P_CONTROL_WKC_V1 would be identical whether you do the full three=
 way handshake with RESET_V3 or with OOB_WKC_V1=2E



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
G=
errit-Change-Number: 1771
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul 2026 02=
:08:53 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--1LB7+B33u2Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1771?usp=3Demail">View Change</a></p><p>2 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #8:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I am really confused what you are trying t=
o do here=2E This seems more like fixing/masking an other bug/sympthon=2E</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1771/comment/e1447272_221f0d12?usp=3Demail">Pa=
tch Set #8, Line 10:</a> <code style=3D"font-family:monospace,monospace">dr=
ops the larger P_CONTROL_WKC_V1, or a version/bug mismatch), the client</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">This is wrong=2E The P_CONTROL_WKC_V1 would be identical whether yo=
u do the full three way handshake with RESET_V3 or with OOB_WKC_V1=2E</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1771?usp=3Demail">change 1771</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5d=
dfaab9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1771 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Sun, 26 Jul 2026 02:08:53 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--1LB7+B33u2Y=--


--===============7127988173242732527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7127988173242732527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7127988173242732527==--

