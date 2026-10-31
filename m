Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC58606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JWkZwxqP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gLba7mEu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sw8JYvt2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PXy6nxkZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=drU8mAP56uVALCm5FtvZnIsLkUD4BtXgCs1p6xiGZ9g=; b=JWkZwxqPREHyYlcshq6dQ5p9PX
	x8RwsfAnSk1Z6ONI0Tqqh5/BXLnaJQHse8kWlqy8i7RZ0X0zzceOnTSfVim1a6We7gn1ImeXls8lk
	SetqiAl4N7cdfOyAKnkpala0F6PfKm53x5Lx0NWeTlhzpStkct7KLKoxT0ytZ8y7lTNo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8fW-000000001Rj-0FGJ;
	Sat, 31 Oct 2026 12:58:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8fV-000000001Rd-0PSw
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:58:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PKQLZiLUwhfY7Hz7/CDI6vmUo/OiuddGOLQXNMy9nbA=; b=gLba7mEuQthGCOoqRJnM0vgUOq
 /gWWl6AyN3X41NAM/4MZTh3L/KMn2QGR61pedva+s9XWVz2Qk37wyGAQvnnMD3ajbbVK8CqOnqUGJ
 oOkM+McIgIOuKMOa4tSp0gMlZAyQsRn47KzOYQQ4U9ayujbrzB4NvtbKEXC8Fzn1bVws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PKQLZiLUwhfY7Hz7/CDI6vmUo/OiuddGOLQXNMy9nbA=; b=Sw8JYvt2Wa+UdO2yzcQqg2fBrP
 iLfEmuiCqdKra8Lxs0xNFzdjCbnx+iZ/MwgCmiq/DOTE3pTqJ3xue/u7YR4NtOz7WcvKN08Z2Ycja
 DoqC8JTq0QvbRDolTpOFmSSBpXeiwKf03OVtvM5V1WcoLQDzuMlgS9REZ42z97+pSAE0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8fU-000000003eq-1vXb for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:58:45 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso16543425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793451518; x=1794056318; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PKQLZiLUwhfY7Hz7/CDI6vmUo/OiuddGOLQXNMy9nbA=;
 b=PXy6nxkZM+0n7NnLThcnq8+G+g7LCp+NXWm7r5LzcwXnwVnED5WbXQB3RFNfDvEi3r
 bZcZT4qW4QOyuOVi2TEhI5DxwiqqhhuKxJJo2SWLKweHjwk4fQjs0s0H0pCzvgRr3ElJ
 pC/8cBiy8YYe2WCEbhsD5CiP8zSZr4+rG9W1Hk7Q1R8xjFWAgrnj0hobYzEc3gcwRVB+
 6G/5s+ECA/r3i/G2nVW0ZP6vgjt3rOncOhdMtyLeQj8ODI/q0VejnzGRWyu5pRhKu0iR
 lfqDrQxrQA2J0GprpNCd3Nsp/fqpxyCnFtWkC4St9hnaYcXciPlA5mRhi0N8/NuasKq+
 djHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793451518; x=1794056318;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PKQLZiLUwhfY7Hz7/CDI6vmUo/OiuddGOLQXNMy9nbA=;
 b=TINWcNY/Dzy+0UdXwy/zXGhhQDSX/ZIvJohALh/w+SYOO/Urv0oDFkvTicZbaXozyH
 n42IjUHAVvFNFRra8SpvmGu7mB2ZpLtwNaYLxtC3QEB2T39tzf5IhZawlSDNLAqGf0Rc
 +cYzG3r1Vfxz8b6TYrT/IP4PO9RREg9oyFsGGAGfPnJhe4Ut92hZ5PBoMGksotQnoZnw
 wXKRY68MLX0YitSg2sLfBGABc19m6Y1fkSrv1BqBj3+3D0ArTZabVR/Syl37ICzabUyU
 lAd6AbT74/o6eFGwczLaaE9DvrsgtBnTN6KEVx+RpP2x/8iTkiCIQkN5zFHTNUS5QUbx
 Nk5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/e0ktnKnfKcv0P1W3QyXun1wVqsQGXot7qJftL6p6wb+jzB76D9bclbbriVktJyDBHhs5rIuG8ri5F7gh@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJZ5iVZO4IYaJn8v/O7MYB1kRYgKmwQJtDtcw7vyAf3BkL3PaU7
 9Hpu4XFcC3+oq0fmFk9Fl416MBytr8FI93sIDv5UUFdqjtWzbyCJ/YNwspg5VUct+YoPczJs12+
 6u9edmQzaumNfO0nf05Ag8RuBVH0JNsZSiuwvFeB3OZLZcYrLmAgf35qKs7GjbN8F/JcM
X-Gm-Gg: AYBFou0PMoWtaCooNfkafyYsHvWtEWUds4pYJfwkUIjrcSThXNU2Gd2JxiAxU0YYZpS
 RpG7S6r+l7ISoJER24wVUOACecOEXeeUl9ygGvG716UR3wtFOWlewQNx9G9uZS2l8g10zImVWyG
 S2DFOAqA78JqvtTgDhP/BpbzSKEfiIGulz5fp/Q74EMriq3T9BaCh+chy+kxrW4exje3xcV7Xp0
 q4ll/AKwzr/BPI2TWnbxVsKfkILctxaQdITEMC+sKH8qXcWH6yUPpBVsVKPm14kRFDulcVczg3Y
 LO1XMA4RFdkpRgNTWjJvBqtqINhr5T44aNPpTHOUDJM1oo3OeHzfJErQYFg2XgrSWjIH52pBPUX
 wC7s0d4y1P6qOmT7Lt1YVn9HNPuqct5kYS4ZLngO8IpEi46blclVNuV0TOJvXtq7bfkjoaF5qfg
 GT4EGTFVgsF8OtoS2uR6lC5RzSPiR3UYowGhLzeOpiJwL61AUxPeCff9efelHOZzcKE2L1bCakh
 Wf4N2nTXTO4nSSIYw46Rafzud4ntYGAUErv9JdY03Y6/9zXyiY42Y6nx9RRmcCddTeK0vtf7e/P
 OyrmayDm+zr1vIQQAOHe+zX5hFyR9tp2J1y1D4DlA8zlSLTA1XExRSA8HwZG9Q1N6e0oPIhBaih
 jqxaV8VXo/1Toy26BTZv99T2lkdGRxbsljbEHBa8725b3DsgimD8vC+PiAKAwnCKtZiZG+95lIl
 VGvmbAEpK9ifeVjcc=
X-Received: by 2002:a05:600c:46ce:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4ac18a88820mr121650415e9.33.1793451517880; 
 Sat, 31 Oct 2026 05:58:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf6e63e0esm169953395e9.12.2026.10.31.05.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:58:37 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 12:58:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70ebdadd660e41b40ed53f4238be6885f0a7bb8b
X-Gerrit-Change-Number: 2074
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2074?usp=email>
X-Gerrit-Commit: c8572113a1bc19f64d5e09a9e1d362e87611c823
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 12:58:36 +0000
In-Reply-To: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
References: <gerrit.1793450471000.I70ebdadd660e41b40ed53f4238be6885f0a7bb8b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDUwNDcxMDAwLkk3MGViZGFkZDY2MGU0MWI0MGVkNTNmNDIzOGJlNjg4NWYwYTdiYjhiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a9e1b570d37bce92898c0e253ae1cff2cdd1ff6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xN8fU-000000003eq-1vXb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: port-share: do not
 follow symlinks when writing journal file
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2373437369459116164=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2373437369459116164==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ohJLapJVMdY="; charset=UTF-8

--ohJLapJVMdY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by Gert Doering=2E ( http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail )

Change subject: =
port-share: do not follow symlinks when writing journal file
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment=
)

Patchset:

PS1: 
> This will not protect against hard links at all=2E
It=
 does not claim to=2E=2E=2E but we could ask the original author to add an =
`O_EXCL`, but tbh I'm not sure how good the port-share code is at cleaning =
up old files, so re-using of port numbers might lead to spurious failures t=
hen=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/207=
4?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70ebdadd6=
60e41b40ed53f4238be6885f0a7bb8b
Gerrit-Change-Number: 2074
Gerrit-PatchSet:=
 1
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Sat, 31 Oct 2026 12:58:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=


--ohJLapJVMdY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by Gert Doering=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2074?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This=
 will not protect against hard links at all=2E</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">It does not=
 claim to=2E=2E=2E but we could ask the original author to add an `O_EXCL`,=
 but tbh I&#39;m not sure how good the port-share code is at cleaning up ol=
d files, so re-using of port numbers might lead to spurious failures then=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2074?usp=3Demail">change 2074</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2074?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I70ebdadd660e41b40ed53=
f4238be6885f0a7bb8b </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2074 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 31 Oct 2026=
 12:58:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>

</body></html>
--ohJLapJVMdY=--


--===============2373437369459116164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2373437369459116164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2373437369459116164==--

