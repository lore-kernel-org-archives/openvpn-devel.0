Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4411CC624DA
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ys+Nj6W/oxisPND2s5dm3sS+EobJ1bFF6pUyHVtbYAI=; b=kr1aMuHvNq6jG2aHXqRwJEkB20
	HUMagRgjll0ZyhVApjtxV87N7UQYZ93Edked3cdW+9YCcmc5z06Qcn2zKTiHUjfyPGpY+K3kXRed4
	daGQkuGnQmLwYPuDLpWkHxnI7mb6ZuAnVMawif4LifooGHKVx7nI7nGKyqj5dVGAJG/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2DCv-00072v-HZ;
	Thu, 03 Sep 2026 19:34:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2DCd-00072c-Gm
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 19:34:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=P9mNdyFfY7H/ZzC4a0gd0nCcQtYf4VSpREbQNXdz6sk=; b=USuk5CTZ+Pz9O4NfPBXRv9sMes
 DbeTFmAJm+csEXgLdkCmqnXrLStOcHy6yXd54G5qiG9iyJIoPrZSUnCrHGiZwlX1yvle1/Eo4leCa
 f8Bt2KadUhrd+zVuOtcUrtX6VpfVDVlcHq4TMqjRvnH90LD0u6tvxvRIdAltb0GO80Yc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=P9mNdyFfY7H/ZzC4a0gd0nCcQtYf4VSpREbQNXdz6sk=; b=J
 nlIkAo8vm60NlEv2UpBfi3n2t2g3CUvaQ34cficcv3+nOXPTWN5kKL8OXJ9ayMjCJmkbfZBI6wOts
 kEbJEGg+wWv0HNo/WHE7trCGcsfK0UOVAaB+sP2YdlLp42PAmeD5ZGEVMvWkNGxveaqiEs1STTvOZ
 WaxSNWuGwLmZo6PM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2DCW-0000yw-Lm for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 19:34:22 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495590dde14so3815345e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 12:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788464054; x=1789068854; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P9mNdyFfY7H/ZzC4a0gd0nCcQtYf4VSpREbQNXdz6sk=;
 b=DwBlhRW8pGO1xfPZd84O+fzhq+kGs62wQWh0WUncAEmcW8W/lluCgMC77DP6OPD9tu
 YcnD2umqRT/VkjdkvBNS//rjjZL7TesnmFm0zUblXF3ej0h/5APUt39BYAkJa/diYkE6
 8DG+uUs1/M6jjC1M4Eu5KDjlzoGG9zP7MOp3ne8tzYapt81IdjS/TlcBVYBneI3cWoTo
 TNJBoVJVor/VMAgVe6HanXfvQ3hAZcFdEwMBxXmh5gx/1J9s6HpitH7dfilwStp0az8V
 W/CNy8LQBRLr0uuqYrJHyAgiMYO4E4OBasZgtlce4w6vz3vFPEzmxdnikWzG5Mr96+JJ
 sl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464054; x=1789068854;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P9mNdyFfY7H/ZzC4a0gd0nCcQtYf4VSpREbQNXdz6sk=;
 b=Fp496T30+p2bD2gsKZYgNvKaLgnLrAhYoRWoX97LPuEHmqU1zAYKioQtYl6kbFNiKV
 sSwOInqNJW0kyg//18riabIEEv7N4V06BWObInMHwpUtw6qhVMkNE2y56iL8lMCX7sH4
 LJfgHe8gKezT5KhAePnACSGr0ljObXOq3sXiadgfN76vp6PbxManPfv9QrcRX561Kdfn
 gJ7y9fr6cPvBx8EY97pgG5QaxJu4+1oPgmHPCpgJ1pKuj74vriwC3Q5vaMlsFBnYWRQm
 D0y3yvCwltB54hAdH7MMXSrdUirbJ5cVZlqVsHqWVJ36LwHm9tVJGrv25tS3+vvbqeX6
 rDwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV4EkbU6I2XecRy72/76ucSDyAW3wGXytdaXh/b2bN9xTzNgWW3gkWH5OlYFi7aS6U9tJG93nKnYhZFwAe@lists.sourceforge.net
X-Gm-Message-State: AFuF++lfm/QnVoT7kySQJXvkn2MnoDXxt+8IoLDWrdlz/mSFDnGNKoTo
 ooK41Wci372P2y/GGQz4QvbllamX4vom57gESux9rVRHE0Mpwn35q49bTjxr+jItHrMQdEo/gKE
 G2XJPhmkI0oa/IXeTJM54SCwrEUL704Xf6S67YRg9Va0uyFSuzRLP98ikbQ7C5xXk5lyd
X-Gm-Gg: AYBFou0NkcnbhQGqIzJDLg4Qil/mEl3/Bbpj4JGJDgHSHWiwbi8whszPDT35VgmX46h
 I8FO8ft3nRnxtcJSFt/CNJSgDvc8yEqQvudDCghA4uuOXBLrfOfuJ1WPt8JXR8IzYjqr9Vco3J5
 S3KCi0fwFV+mpoulVmiB90qOETECN9T1tvfvsXTeM4W8Y79ZlNvPJw1B4F2lUzkkJ9qsSBJQVwA
 1mLZNFaebrfDTauJu5aUz7v3cSKvu+NzXlcnXmpbg1pOxTkETGgStYpIonDc5Sdu7c5mHGDsv+N
 GIjat+n2cKz/xpDJNkWGLVafxuReIQRpWEUIH5HxYxI9wLf1Lky21fkZxWUmD7yv3++UUQbiG7P
 W5Q9ZebOzxLt0G1AEIk2kfp5D/fMlzDavK2udY6jNhHT6WeRNBnKRvJs9JgWZd6bv1BSHP1g00J
 9HXFJ+NjvaGkb6DsYCXUjcvVndDxLNZTKlMp/w5tF4mBlve0zzRr0vB0Q0Iiu/tIch68LEUZ860
 sxKV6+NeSJi03Jo/nsm2KGHZ2wsJfckV9oQOqP91gtgb2DJQCFtQCrE4huACVwoD9eXxG5RWO5r
 x5NQO5VDRnks8C4VGXvWOSfDm+cG3PlnA4ypuNavumzOajzTwzs=
X-Received: by 2002:a05:600c:8519:b0:49c:d27e:8f7c with SMTP id
 5b1f17b1804b1-49cf8251111mr4110635e9.12.1788464053493; 
 Thu, 03 Sep 2026 12:34:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c6ba4sm843161f8f.25.2026.09.03.12.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:34:13 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 19:34:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
X-Gerrit-Change-Number: 1894
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1894?usp=email>
X-Gerrit-Commit: 287f1ca39cc776ca7491d1196e2500a61bf1faef
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 19:34:11 +0000
In-Reply-To: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
References: <gerrit.1788416209000.I3c6ad247614fb204a279b73e98f8c4704e16da2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDE2MjA5MDAwLkkzYzZhZDI0NzYxNGZiMjA0YTI3OWI3M2U5OGY4YzQ3MDRlMTZkYTJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18cc447ed5b3aab12668af14ce32382d84f0ef00-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2DCW-0000yw-Lm
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: add unit
 tests for ACK and backoff DoS hardening
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1199499087025410091=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1199499087025410091==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q6fL80Ho7XU="; charset=UTF-8

--q6fL80Ho7XU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
894?usp=3Demail )

Change subject: reliable: add unit tests for ACK and bac=
koff DoS hardening
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1894?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I3c6ad247614fb204a279b73e98f8c4704e16da2a
Gerrit-Change-Num=
ber: 1894
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Thu, 03 Sep 2026 19:34:11 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--q6fL80Ho7XU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1894?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail">change 1894</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1894?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3c6ad247614fb204a=
279b73e98f8c4704e16da2a </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1894 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gr=
eenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Thu, 03 Sep 2026 19:34:11 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--q6fL80Ho7XU=--


--===============1199499087025410091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1199499087025410091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1199499087025410091==--

