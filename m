Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C152CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u1RvNHEltTRpZT/UWL+FVyYJ9JPYyxy5m8Y7KU4zzCI=; b=GyLcXwGx/jKBlWqH+RxmTxjmHP
	xtzD2v7Dzl8hvF07fzSRi8MuQCNvo4kmaaYxtfcmy2q5FqHBJp6a9BrX9gMwQ1avBSUvBR29C0gxc
	6+nUoNoJJJKINoJnGImqgc/MARr5nZeriAM/17C0WPRu1iar8LxHzr03vdLv4Vq3WNdQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBusw-0002hw-KK;
	Wed, 30 Sep 2026 14:02:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBusv-0002ho-0F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:02:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5HFFdGTLmCNAmOxNHVzuaX8Y8VOF9YyQtXaroEr3Hz4=; b=ZVLzcMyqfGYteeNZl/22vNds3W
 dxZH47JYhbZMbQMpb+Krx8TFdB0+Iqt84xRiDm31jXmU7Z3UnHcd5vjts+GSMM6tqD4Y1V9hLwhFL
 uIs/+NLqSF+n/+jCVeXdqv/+ags8jM33kfpbYS2mEYxpdU5tUDlpkrPWVqJoLd+XoSac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5HFFdGTLmCNAmOxNHVzuaX8Y8VOF9YyQtXaroEr3Hz4=; b=R
 L5KLdH9aJiWliaie8o9dgF6pMKIKlWDWH68YZI4j+CDx0MxwHkge38or+Kt4b21fi0vXQVdD2bmeR
 LmIixFkzOReHKao0+dzQOc8K1GbrmLgVgan17aZsNDcXNAX+F6i73ZCPjYKMCJDFqJf0wD8OS2UJh
 aQ7wfXtEPeCxEPws=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuss-0006SB-IM for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 14:02:13 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso12969105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790776924; x=1791381724; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5HFFdGTLmCNAmOxNHVzuaX8Y8VOF9YyQtXaroEr3Hz4=;
 b=FeOvVeNVRQKQDbGq/YpHIn3yMnmVwX//UmBROzsd1zfWwESD/tP0oOnYREU4fmivdu
 sjS+zRJe/gAXgrjVjGyZTfHvJ1bhucbYymM21OnZTHF2ldhwIivacaAY1+Wu8DPnNbmQ
 jRq2668OAmq0qzSEb7xCEn90VdLC7j2XhTiV1OqkPxpVQmpiWFjmPkV/5GsdNu+3gAwr
 Bs1dgjwmVU4UiaLWcuh1/jNah247R2txoR90Z4EBdFKZ9eKeqX3xDZszPsZ7ahx7/kmI
 IkL+1SjsTJoUkPRWKspcrqtG5+cYB7wHldIP77t7veR95eI+AxOmFSJiM5T3OYulOdSi
 W3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790776924; x=1791381724;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5HFFdGTLmCNAmOxNHVzuaX8Y8VOF9YyQtXaroEr3Hz4=;
 b=hdmbEafwWPFGe/o2q71q8RzNex6IK/m4HgC4n9BJKez+e/2h8wRvIcyuyhKunYoO1T
 DqNz9V8FKMOivbv4nIgGoF9X7OQ5vuo4At/eR+cgTEOnTRmyMx2BafR8OsU+2n+fXkCU
 L0xLz/UmM6+PXHNI7KHtg8u5EHK1+qZOtl7ScJESqvVjfh3WUiI6uW4/pEebF/8AeQCM
 4qd1a2br+ewfQMPz9iw28AlhCvNECDm+of7EyMps3yAM4aV6XC0JjhD9r3bMbDnFNBUC
 4KXOp3vXVdOfWPiHT/UQbOFLr9wHrHwk16/tQvuMYewzbodiQI7cmMonmzdVxM57yzaU
 OLXA==
X-Gm-Message-State: AFuF++mA+Qn51Js42V04WibJ0eV6P3RI+Jni5HilZ6j3rP5Zr7jUR9lK
 eL0uNW433rm4+zJo4qHgtoyL2jmEs2k5bFU++OoajLwtDmDp9j9pBcwegmDY+G9YV88EuWy4GDl
 Jy/vVDo9uU157qR7usDdyPpWDEXI+XUr0k2EtKZCFgZs65ULxYjpoWBFwMYdMPbjgIzJr
X-Gm-Gg: AYBFou2VbI988sLZKMwV0nR+O/qyKnlv4dhbJoDbMwFc/DV5CtZpwjzIyfWy6iNRMRU
 olOuMII/i7T7loX05QxLTHVbiWJ38NsZN5FzHFTHATE0+IYmmP3YUzimBf8TNvzcGczHhnhZYAx
 y8V4aqZ1Vdf5V8LxK6dNYwVw02RuQ18dB2+rkg350uWG+Ar4vTNYyPTnsnIUBou2gDI7CDTkYTq
 Sf6c4VR/jVPVwyT10MtbJdpZ1s0rj61hQBfZg4i03wKyltuBSUQVBoYW5weZ/5jZbWOeuMIe29t
 oO2JULzsD6Rct++sNftITxJhfUh63FVvrhJpeBWQiVgCY2O9I1cGl5iDHIkcZcwgRW4/YvIb2tY
 mHohK6+xfqp9VdponIkq9D/yZvjTPmmDJR7H7SNuXia9C2Pnf05QJIcYkg6Lio7WvhkNLqgYVvt
 nXntp0y/lWzjuSPJtHX+CEgje1NU2Zfl8s1c8klcAwiNHqVbRd4WO4S7xV1AuiPUbEwgCCSiG/j
 BOl7TTpgTnAK/llia5a7IyPbLRYKx32YgarfwrFaHqO4Qu6yr8M9UXjJbvoeskBv8h3hyxE/98P
 m1XEtc0T+bxkk6D13FDz2w4ro60WbUeg3iRF/ypEyVCZG8ym67N8dCXmPlDRDMEMRNZycERl
X-Received: by 2002:a05:600c:8b5b:b0:49f:ce73:7aa with SMTP id
 5b1f17b1804b1-4a01b00b470mr24687025e9.35.1790776923887; 
 Wed, 30 Sep 2026 07:02:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cb8af89sm14169035e9.1.2026.09.30.07.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:02:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 14:02:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I924a531c69921cebf563e7ecfd8177764ecc38cb
X-Gerrit-Change-Number: 1964
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1964?usp=email>
X-Gerrit-Commit: a27a40fcd6a533d3c09e84f18350687841aaa995
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 14:02:01 +0000
In-Reply-To: <gerrit.1790696277000.I924a531c69921cebf563e7ecfd8177764ecc38cb@gerrit.openvpn.net>
References: <gerrit.1790696277000.I924a531c69921cebf563e7ecfd8177764ecc38cb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjk2Mjc3MDAwLkk5MjRhNTMxYzY5OTIxY2ViZjU2M2U3ZWNmZDgxNzc3NjRlY2MzOGNiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ccab06068b6cf3909ba19bd82a3610728ddd9a8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBuss-0006SB-IM
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add check for
 termios.h to Cmake
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
Content-Type: multipart/mixed; boundary="===============2542057242909024731=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2542057242909024731==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xnl/IF9o0Og="; charset=UTF-8

--Xnl/IF9o0Og=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1964?usp=3Demail )

Change subject: Add check for termios=2Eh to =
Cmake
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1964?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I924a531c69921cebf563e7ecfd8177764ecc38cb
Gerrit-Change-Number: 1964
Gerri=
t-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 30 Sep 2026 14:02:01 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Xnl/IF9o0Og=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 1:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1964?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1964?usp=3Demail">change 1964</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1964?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I924a531c69921cebf563e=
7ecfd8177764ecc38cb </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1964 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 30 Sep 2026 14:02:01 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--Xnl/IF9o0Og=--


--===============2542057242909024731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2542057242909024731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2542057242909024731==--

