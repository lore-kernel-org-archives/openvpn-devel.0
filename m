Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C350C982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1NCqSlDMZm/B2J/jC/325AT/Orbcs5whUjVY00X4ZAc=; b=WGNWv00KayFWUoRYq0fekaxadI
	hOoDENI5d4J1IPCoUZTlo/WEdg6b1aToDDC1rlPam9OaLsQSKaq30CKBB/nIPf478bi8V5RE2dQ5/
	1L4xWt+IC2Q2J78Z5WuP5rmVe4+zVUeToIhW40Yon9bRjET1zxJPCiQbWu+iwDUuP12Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6sOQ-0004Y7-Ap;
	Wed, 16 Sep 2026 16:21:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6sOP-0004Y1-0e
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BhNlzJOB8dZhcxWLTIkjS4pAnqIA3/F4Ul4N3JDL9kU=; b=mF2kevraqsISufEH5H6mOSgThv
 5RfF4xTIbdav+BdlKLZfWGK9CLntliNoAeFLhZ4+/lgJCYMPltRerHQ1KT63qub73Rzd1LZcWeloZ
 aDKbqk77HDddhkSKwvnQgLCos1acX8q3ucqEXQv2CFkPIzZV1HNji7gOO+3AqNYmn8FI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BhNlzJOB8dZhcxWLTIkjS4pAnqIA3/F4Ul4N3JDL9kU=; b=B
 8NnP2hLMROjfo0H5HwGlo2fmFMAEKCKPzW4W/zoip32EoHLHRcv0Qm9v/djJU6RvOpb2cNGx6GbLw
 7tPSQGJmcxYcGdfR8g+qezB4+Q16D/t/AHziYQI3qeISTuAkRSJv/7dkEDpK9aQf4VxuY+5nizKav
 so87eqjP9LQ8qZpk=;
Received: from mail-wr2-f37.google.com ([74.125.225.101])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6sOK-0001OO-Kt for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 16:21:50 +0000
Received: by mail-wr2-f37.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso807060f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789575702; x=1790180502; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BhNlzJOB8dZhcxWLTIkjS4pAnqIA3/F4Ul4N3JDL9kU=;
 b=ZpVa7JnrPVwyAFKCewQTySlhHC3dypQY+G0Er3i5E/rZq9+KqQso2V1PRuZ92DEVbO
 Aibsk1WAzvmYV00ZNBCFnQiei6XdcyJLCTR0iOJ8uTK8k5lQe7KdOa9K/S2b7U0A9Eeg
 o4B77z27zr4DxSJ189ftua26zLLQ4OKRbr0SEKrKHUTKh5Ov9hb1637df81mQ7vVp1Hd
 wM233I31EcIfSRyJgjUnkbx1yixTkfo3FBD+tdxxLJUjrSdNZ1tvNdzq+pBqEmQMoAke
 4fWd34lLXqe9qWIrGOXCsgIcdC/H0hqeUJAGKfMHc/xWqUaUx1nc3SSz+nwOkAeW5cZl
 dXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789575702; x=1790180502;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BhNlzJOB8dZhcxWLTIkjS4pAnqIA3/F4Ul4N3JDL9kU=;
 b=Q1CBNvxNXJr01bzwqMPFN/tpleXPxosjc4BCFIYVQBcuZKjWG/mIuFvR8yfbOdSyOq
 eCHUBvIy1+ObsKnw4WNq+vvXnWQIaXNfZiCXmh3o2fjOumBeu+YUxkGmypgYmi3lWYDf
 QYi9aUGN5OimMjWWgVLKS19z+3KGCI+mMk9WFBuKE95Os6RyLBXv/WwzYIKAnBwuQd9R
 s8JHiykRSUS1JjcY6me15K59JzD/leKkTv13peO79brePkvf/we15Brq+0QECGzLb0KY
 rtFf7u0JhWleb246OCjKxEcOoH2ADqjo+quFtiql6glTEpa0f1lSiq2LdtIUkna6ITDY
 dOHA==
X-Gm-Message-State: AFuF++liedD6+PCH0h5EBWllFCzvg2fstT5tKViK74QmGD2EOXMYl8kK
 MEoy7PRIJCH1URGq3UhfzrCtyI80R44eqT4Cj1ksjfh/t5VYmG8+U65COj1J7xX9T/G3/D0GANj
 uunCc+04MOV6Q9WbkNlebYfuESWU109uuzg8ysLj49GQtQf0b7SOsEP+hPksrvKzF4yl5Rb5HsY
 LnsP5V4Q==
X-Gm-Gg: AYBFou2iUl/GfZdTS06pFAKmaHcwQZliP3pJIaHH123Dyn7Yq+oBnESci0imZ084WWP
 iJxCY4IyGHypPBmDW3WIBA4uRswKSCalRqUPMCCRVSEzO5yt7IjLLy5ZHcXNGrCGIvIk23UQEG6
 p4bQNSNE/jMBhjEYUWKZZdtb3nScWFimcR3yenfvN6LQdF3bdBnJGj0GGSgYWYOnqn01MDY1Maj
 o2/BN8DjFKICI0xcSiFZ4cADWWkdbXWHIFaBEbq6aAKhhkbipWyBjkmOfYXBzQfUsZpzTczQNlG
 k56jno7LjBAwPF4cEhyB7Yim31mTYdLQWUk67RIrUrIMIn+VuorWO6UK+OmxDdkTvt9jUcYN10V
 avNXLug4oIWHNOkrvGNqKwdILvmD2Wjfh1VTbPPDjnJVmyxXlOQicL8Q0vAdbHTNPrRu2sprxhm
 Ka6VqpaOy3XNRyIgx3DcGSQKsEUDMgHI0im3cBR3qRXwaRvA7+/jQ5suP+DiXpjnK2uZ/xccod6
 zPJTomOZUGE9Vbxoz3Q1UV58I+61TnFs1551zrVGmzim7CyAzopJvgy54E68bwYelpVUn15Zfla
 UEwlR/NSmK5jPbVmVGb3Y/svjOVuLcVM4AByUmdedb4NHWfjg7xOhrwfh6DxEEM=
X-Received: by 2002:a05:6000:4543:b0:487:62d:37d6 with SMTP id
 ffacd0b85a97d-4870d062278mr4559499f8f.23.1789560915844; 
 Wed, 16 Sep 2026 05:15:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa7dsm6942111f8f.8.2026.09.16.05.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:15:15 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 12:15:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: 8f83012ce38ef3afa7a1335f301b503c101e5ec8
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 12:15:14 +0000
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ea6261f465b1952e9331e1f41d7fc3492e86c13-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6sOK-0001OO-Kt
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.5]: Backport
 stricter check for valid tokens
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6743059010653405788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6743059010653405788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yG9b3EZ0Kcs="; charset=UTF-8

--yG9b3EZ0Kcs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1766?usp=3Demail )

Change subject: Backport stricter check for valid =
tokens
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1766?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-=
Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
Gerrit-Change-Number: =
1766
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 16 Sep 2026 12:15:14 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--yG9b3EZ0Kcs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1766?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail">change 1766</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: rele=
ase/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16187153e5=
b107eb08ccb7c9c9ed4acd6377af0c </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1766 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 16 Sep 2026 12:15:14 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--yG9b3EZ0Kcs=--


--===============6743059010653405788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6743059010653405788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6743059010653405788==--

