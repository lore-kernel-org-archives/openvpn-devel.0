Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F606CA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANydHeRvxc4JM6XGaMvK2uql7zE7rPffktkMrynPdWc=; b=QMUyIZ+fADADKNb+eyNCYtTlCT
	QMJ4rimB1N/miLTQLUO7EXv8zmIYRZxiKI3Co+E7/+CZ9gJCoGJ1xHG9PWmdk8HHwOYxQPtIruZKj
	4SAcQxOgxIBMHgl0yw6zLcmvxU6Qvx8r2gkvMZy5f5EeFh0ReilUsSi84HmpY9VY4fyQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDiLo-0007r7-K1;
	Mon, 05 Oct 2026 13:03:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDiLn-0007r0-DM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+F2SoJdigYRYk3iJ8FP8uBjDSclBWVNJLXVkLhKcDYI=; b=JCeUYFFAO4ufeBmLw37oj8JJ6p
 /0Pg1S9FbvOEfW7VttVTnEUrmvCxnuv7KAt4EBjO9WbD/F0FmshMEYjGfN815FM6qTd/aLsXkSqxS
 Gxi/403xwGEFZ7aK1HKbw3AlfjWQBiAQL0nAbzISkjtosKjK+4X9m2NkrGYGRy3DdpAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+F2SoJdigYRYk3iJ8FP8uBjDSclBWVNJLXVkLhKcDYI=; b=c
 xsP4dtBWDcxvv4U4E93oRSweCE2htr6iwrD2JYmgH/EKefmZKrtH5z6b9+8gHuB8pUnH92aPP+dpt
 nU8gyJHSzWjIFKHToqubOADvcfUv9p19OSc4hjLmHfwWmgxe2dXfd9Uo/SnwWcLe/MeuUNZj5Ojw5
 FeyCMpdy5zdmGfPY=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDiLm-0007nt-I4 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:03:27 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48b9d8055dfso1456297f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791205400; x=1791810200; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+F2SoJdigYRYk3iJ8FP8uBjDSclBWVNJLXVkLhKcDYI=;
 b=c0IJt2rNwNm+vTrWdDskrudwcU/zc6OTgTg7mX4q1iYAqKKBg/uB+WbHCNZ07euWIo
 /EFh3ewWuqZVpcHfQ97q0pntv6KWEoGaEyPJX/EQVz2iY0ARDjC+oRaIQzv6Nx8HKh2c
 l3gGAzc2+Etl02w/rm5NZDjEUlLkmzftv2PYZ908gmK3xIaH2R56Sv/E2NrP/btlMZOA
 4DK6yfGtdkvT6vYaQ2QuQ597y3jGO/sQXoaMKtepLlPz7BOFPHF05fj6g55IEpm8vLIp
 rc4aC+IgofnHviaq+XHRHDW5olZm4prENep2zwKo08hIPc+dwJ4D9gSn3emFjf8XiusO
 FMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791205400; x=1791810200;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+F2SoJdigYRYk3iJ8FP8uBjDSclBWVNJLXVkLhKcDYI=;
 b=RNUJohoEHTGajTqH7Lrc5iCoGmymr9KjM7MRxj1yPlcJE2WJYsJ+di37nCHAq2BgF+
 hru5jnzDSuR9W3/qGUXxGcoEMpCWFiDF/wHcwc3yU8xdsjsgzGOPvSs/mUc7u5H4VMCj
 FR7ybkD8CZ3BMyhLbF4ueoGXDCl7iKSdNGuwzhIOFeWbNTNNOIkozHIVAYYr7im4MT8y
 Io9mUpBQROBdLr7m6YSzvIoELVE4oVBz8qZdeclW+Sj9fy9dtQi02mM/0XWlpsfsCZyy
 LbANXJeJpWI2y+opWY53ZqfspJOSVac4O276xKBYu1KnPg9GBdN9nZJDwbb6IuNNDUrq
 2FYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1z0pSKtwmffUfoRFcE7L1ZoEm8EegENsYwA9q15uPPBM96ogkB7s84nnp1jkFb+CJrfGkcCC1Fnn+EFzw@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKMrcI+00mpVefDQcu4GJlDbkpObPBRcjYS9PBoNdce+4DMhj3j
 7wTMR88BIuE8IXJ/lk1KI/spFSkK6hTWloKk2v/Bg1bQfxma+ANqkPhvV2KF4uu8XbQjm7zkbzs
 JXeQruRepholKhMHt3fYsjwJCUcaMbbZNPsj88mrqOaCwQeynfzUwFvEH9k8bOqChfnsF1s4S//
 JVvB4frA==
X-Gm-Gg: AYBFou0qn1Z1ncjalBCRKiCSbDUKMBqkOyrfRgOiXhI7dGjQQGUFzw2/HAnzstV1b/J
 e0IJvQfxPevZLVfN4Ljxq5TPBRVMX7rvdnCs2UKskpoxTazOnPk5Leuif90MqnWcO8MWEpKbOmO
 yFUKxasDBzdMUF+nTbCt7N1CotgkPKVCndNVsDdWewnywrnYTCqd0slXl4jElxR5hHudnD2wDAK
 qKXtv/l3KxQIljcEhm0XbfSokuVbumV8u6y+SfhjG3WafR6vEcet5mzn4H9n6s+62dGYMKED5vu
 RF/S+d7x9LbsEbuqi9xUqRbHxFvLBvMZP0szWgJ4ffpaIHMMqxW+PC8g3sOaApo3MpYYF/iEfLn
 dHAZBFCm8gt0KjCu2OObOdNtXMEzfvo4nOaA+F7SjDpQP5DKlYGxrVIVcktUdZrsEipxm9JwFBT
 MDL+9yuN9iBDQiFpX5sXtbmryxhbqB/Aq+veXVdDK5aKgvnvhzz8Ig0xh/l7ZCfIlNjuNyvb3/m
 pqthtfrllW/6HKXVDAx/HtsX5K6PALPZRTx5S0nwgtNT+siihXLwOkVDqN072c3wfYwhCtLrlY4
 kwggpO3erBBjCAXb0Is86tJEoYCOtlT+bChx6GjkND6EfH7oXV8CNWEPr8Ba
X-Received: by 2002:a05:6000:230a:b0:48b:848:3a48 with SMTP id
 ffacd0b85a97d-48c4801ac5emr15096983f8f.46.1791205399742; 
 Mon, 05 Oct 2026 06:03:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62289e77sm3726025f8f.21.2026.10.05.06.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:03:18 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 13:03:17 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: ee5a484f5ed3ead1661e14d2f0b009139fd3d6a7
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 13:03:17 +0000
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6749d48e0ead4fcb1818ceab0224510530d43356-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDiLm-0007nt-I4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5724153758442329348=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5724153758442329348==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HU6Hpl4UUCU="; charset=UTF-8

--HU6Hpl4UUCU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gianmarco De Gregori, plaisthos=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail )

Cha=
nge subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e=
54
Gerrit-Change-Number: 1962
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De=
 Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gia=
nmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 05 =
Oct 2026 13:03:17 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--HU6Hpl4UUCU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gianmarco De Gregori, plaisthos=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?=
usp=3Demail">change 1962</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1962?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1962 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 13:03:17 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--HU6Hpl4UUCU=--


--===============5724153758442329348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5724153758442329348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5724153758442329348==--

