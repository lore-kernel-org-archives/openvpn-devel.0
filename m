Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2586CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+LAUUA9UbVy8P8MHXBvZd2a2/Hxt5epNE1KuOdt9gDI=; b=Nk4AxSAHYwGwjEOlAScasCCOmY
	P87BBICRe+tpjRRyo1kmPiKHKZc0Xj5kGInULbgBEOyN90l70jrtCYgbRkTar2NZ/sD59cydO85YQ
	k9Xsy/tQSb9hHihtC9TYZRZKHOSr19mViRfTY0AwtrkVH6b0/D9s9i9kcQLr9gCN3WOw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQZs-0006ja-VB;
	Sun, 18 Oct 2026 13:05:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQZp-0006jS-Br
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:05:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jca8mBpvQ9DG9YiZ37yowzrvLhpy3BTJUsw1YdaBZhY=; b=heQ11+KUMywgUZQvnlCuWkC+6o
 EOItrq+Myt6lVQeMSDvU29umMRYf8BBXb4YIH2YaDm8G7ZYZd6FZ6sJsoUYtCIE727jDiO/uekJEo
 BbTmI+uZqL83aP3ISpVPJS5RMyPk5b5zQrggUCBheejC2wq/2cAcTYVAImLcbuv5nw3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jca8mBpvQ9DG9YiZ37yowzrvLhpy3BTJUsw1YdaBZhY=; b=V
 5hO4TFtZvbaTQHRkpaP59r5ti8urxmKiblzZQGJgtlxNR8s471sXwPXsNwobzMAZU2mdsPfY3s8Y7
 Z8Gxc3YG+Q1trlEYMuOCZN+TvmbAXKuquMJ2BpnGc4HXtHSgCqJEpQtIcjpMO1zsGcscdpGnccDYZ
 bKxz3P4g4LxBlFPs=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQZn-0004ay-Ln for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:05:25 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so12807265e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792328717; x=1792933517; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jca8mBpvQ9DG9YiZ37yowzrvLhpy3BTJUsw1YdaBZhY=;
 b=J0y01qrLYDbFtmrVzbDEdVF5PiqPTCbMLAF6E2xFwva+bvEASvsrJxz8PqZURvzKlr
 2IMpsnTm+aspLES5NlBmIvkiSXSsdgtrQBQNc+Awf935dCOMrgNMIEC043/ZFMaaKBed
 LKahX5dhZj7VGq/W7oWhaxcfGQElWrgpRIBOGrC744AUbc48P2ZPYtqMsz+2QXrHzYpn
 NRxrIaa5sT4QxG6dXAqm5TEu5tbf62L8PofAXoaRpPG3DcG2RYAlyt2Gk6MamYj2gYVK
 b4XWiOVxyUpZ9NApUefGnVSKr1PE04NFBwS7HoyUQCxQQ3KNBXd+XywMiJNSqUJDLOsE
 qYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328717; x=1792933517;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jca8mBpvQ9DG9YiZ37yowzrvLhpy3BTJUsw1YdaBZhY=;
 b=krVQwccLCtNzW8PJcbL+Tdj5XnBboo2hu8sNVYA3u2xjzI4cuLyaL0h5Ac9I3d2BSC
 M8hFs7ZcovP/RwvHSBxWPXCwnbKMhuOPBnXH2oJfnT+iueDL/s/0UBk5Iv0k+4hp7qNX
 HSxnnr+ROjWkVITj2n7kLW4HPs8BJDVdhLNtWPz8bNMBzlD6RJ5hxCtCVMGgWwFWvXCv
 mLHNZJp09VXqB/xYjIzailMquoW/Zz1EDgnYnav3uI0bltrRqH0rsx4SBrzK1rxK4t9I
 JMuspnMKk4xirvKWNydFOxSE2phvJMo4kb5ZehFVjxVcHzUF1eAr9HboiubZpjIMKUBA
 LSVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7vhUmhEAsp5DRAZBiEwAU5NLgLv705wY/yyaaugCqt1UM3v2pjIHBg5efD6tEaqi6loDgfjuDHm2aLf+P@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJRNqlQlp+V8cwhdqRQNsu55/5K1Eo7Owls+ZeixmvlkWlZmDwW
 9tg0rA0XRP+PWtwTR63IF2H5XGMwR7pDMoDn3ktNo7bTj6eTvSM2kx1v+zIKNax3BPDRDLM76Gz
 EtpOChbNlsD6BkfUYuhSYe4YCk4s7i6No6/yU3bC1sLWDMRvWpynPqfEyb35tyMsRfSHZG6BhHz
 tH5fSxXg==
X-Gm-Gg: AYBFou3mUyWRIL5e7GRj+taai0OxXRbqyIhtOVETyvvof8CuawQa5LnBKXw89FMIjMH
 f0ZzWNCESlzrDVXROrlDdvzg/9YMCVHfBQR8pqAQPKYHOi71KxfecnGj562L3gFqZdTk3cw3mtm
 nHHzmTBE76ENz9ZpLU8RefPSObPt9ucmRKixw6glk17QQweVcQV2aKu/MdbkJNux/jNQtBSKdw0
 KNAce4URLKLBScQvjSnsYWgA8M4Rfe4WQ/8nGasYuzG5IwW4TYzj1dJdEmtxj5CCePcqrQRIKNJ
 ZK/Fjk7ydUa6usInyQEzc8D9ehxpPnlv+iw8LwGO05SF8pi7d0QSKO0UVNfhT+m3DPGCY9gxUQG
 jIyGADQu4tH84QYXT3QibRdPvlR+MWrPNxUXyB79GNLj2h47y36VJbGbjjulxyfP5+8FhA985mT
 zcjgs3fZ/o8FJtbH6dtni3Jm1P8+BMDe95DGerpDegNPMO0al6Dnd+rTVohX5U4TMx44NXvLmTU
 fLejNM/MszzAg9/Yp3F60plWntFt5OfAdE3wVBmquTtsHfJNXlAzMPNYkuoMXAOR9SyunnnBX0a
 C5GfqHAgqAhWEU3ThcwSyIJ1+VqCinvTrAVOpgRgMeK/I3fjJFdku4bOo+rf
X-Received: by 2002:a05:600c:3b91:b0:4a1:dfd4:9430 with SMTP id
 5b1f17b1804b1-4a1dfd4955fmr68541635e9.28.1792328717110; 
 Sun, 18 Oct 2026 06:05:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1df164777sm108510275e9.5.2026.10.18.06.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:05:16 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:05:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: b2d31a2fa8b5ae6544ba75ab3a7c8111c51c3390
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 13:05:15 +0000
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b2a22b0dd273e488ed97fe5c986f5d610c5e7d8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQZn-0004ay-Ln
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7604696031193058783=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7604696031193058783==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+kKgF/Ry2bI="; charset=UTF-8

--+kKgF/Ry2bI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Steffan Karger has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail )

Change subje=
ct: gen-sample-keys=2Esh: use a random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

P=
S1: 
> It turns out LibreSSL doesn't support random serials at all=2E [=E2=
=80=A6]
Oh, sorry, missed your comments because the gerrit UI didn't refres=
h (or I didn't)=2E But that fix diff seems to not be the right diff? I can =
see that leaving the counting serial in as a fallback would work, but I thi=
nk we should not let libressl hold us back=2E



-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
Gerr=
it-Change-Number: 2010
Gerrit-PatchSet: 1
Gerrit-Owner: Steffan Karger <ste=
ffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 Oct 2026 13:05:15=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Steffan Ka=
rger <steffan@karger=2Eme>

--+kKgF/Ry2bI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Steffan=
 Karger has posted comments on this change by Steffan Karger=2E</p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2010?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
It turns out LibreSSL doesn&#39;t support random serials at all=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Oh, sorry, missed your comments because the gerrit UI=
 didn&#39;t refresh (or I didn&#39;t)=2E But that fix diff seems to not be =
the right diff? I can see that leaving the counting serial in as a fallback=
 would work, but I think we should not let libressl hold us back=2E</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2010?usp=3Demail">change 2010</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d=
17d668 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2010 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 13:05:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Steffan Ka=
rger &lt;steffan@karger=2Eme&gt; </div>

</body></html>
--+kKgF/Ry2bI=--


--===============7604696031193058783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7604696031193058783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7604696031193058783==--

