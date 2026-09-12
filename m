Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708FCC88E59
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ls/uzdaTVEf2uUp3ESitiOQ45sScXqnLdmRiSpxmBrk=; b=I58tdeLwQGhZ3dfJukSFOnfmUL
	Cvhyt2yYA1Iofxpt67NKArCshgKwL+50PWdhcm+iC/2nf3m3/8MzVlk/gHGIU1duQvtSigdGIlRLy
	9GG1ozaN3tbS8DV/YbuqftVD+KNAOUqC4oUr36fQ0jkI2hFkocdS8yRnpU0JiGY1SiF0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5RwF-0006NC-Tm;
	Sat, 12 Sep 2026 17:54:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5RwF-0006N6-46
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yfKsJSuoOS3hoNSJPQE52+tiRZJ84C30mTwZBKF8sGQ=; b=BeTGEC1ypNcc6Bwp+05FxV0QTw
 g6bdMQzDHKsq28X9aQhaVUUH62+htPuBRDwy+v6Bcp/tzdASyFcIPBV9lc4AvRtFpNEfE3QyDCogr
 JjXsk7Th9XwvcdF9+ZpWSThN0zSMTzirxyLnpVwTfSUau3uioOoVyo7/5r5j+nqxFXVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yfKsJSuoOS3hoNSJPQE52+tiRZJ84C30mTwZBKF8sGQ=; b=X
 kUmmlbqA74W/bXl30G2QZcetQwWCXzEWGW0a/iEXTVCQj0cHcrzyLmPOpI/GRJDFEH23GID6vSRjI
 lXzCoqgKdR75boufZZVHK5o5L+m/mQdmWhopbhEEcPHBXQgztxTgBVP5KwYaOZScINuL/ro3gndPe
 niw9v12lLu2ZeHHQ=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5RwE-00086A-D2 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 17:54:55 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so251230f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789235688; x=1789840488; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yfKsJSuoOS3hoNSJPQE52+tiRZJ84C30mTwZBKF8sGQ=;
 b=fZygTMKyHoFXmWs3YRy1pZffLYkSUqxje/eGqk9uLmoXe2CXx/aN1M8LNcFOUmHLUf
 LSo4Hpb7L4b0yNOnPXTZnKDUDhH2Ii0gjizx+0HWMSrbYkTa4FNTps5hv1Xhhi0K9Ocd
 dkHk3vXeysPhPF4QYtP+NSXkMcCL8jhN3JEcx4A/W7LuAc2gk0H2lO2Ohj1HH/xy65Pw
 LiBf6IbUv2zA1EVAT5sfwsMSxPgmH+AYI6WUtcitm6kJ+54Ziv0I99QwmJUI0uYvQu6i
 grSuX7zy/i+nTIMaGXRhvS7m9HSzLxFBX4rK9zD6CBffBmeXdGjNNilNWMW2BzBZFTG1
 Scpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789235688; x=1789840488;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yfKsJSuoOS3hoNSJPQE52+tiRZJ84C30mTwZBKF8sGQ=;
 b=EKOtJGus/uFTmr7z4VjjgifdxGWTn/tvPT39uPSn0omhpMGU3RrNSNFlh7tAKKpTb+
 wz7kTGI++qlsD+lKkYseIfaX9kLGmlH//IUtotH8jDN+gtOAYX/hN/TuaGGZT8CLv7iM
 yWJb7Gz8lyf+kroKb8K/zcOttzUundJheLY98aPulEx1c/dN86LT9I3HfiDGriTrBcL/
 H2sxWeEPn0vKyosOvSpGayzr6KbSgyU2drQQ7vCusg+mf9kKx6fnQAZ1VZaPzhKIg1wQ
 6ip5nXZ/wpodIvEhJt34u4+QP2NuGR8fl1Kq+qUAhQpUFnvbDpzHBjTPNOBbPsM+a4GU
 GGfg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXRPiAfjDBwd5kmJVbOU3Lkdgjb2h/THkINzxNkVutNKquZRxEn/+/rU+us1tkN6rDGbkrIgN5BM14Nr9g@lists.sourceforge.net
X-Gm-Message-State: AFuF++nwGbgd6bqlclQEXdtBoIi8rNxZOTyOsNhXo8R4jaCt2NdZAJqm
 3yrXk9P8f1SsLqJf/21QtrXZAZrYfsW0YR+T1fv9mbdPLpQ/mK+T1xM00d3R6XblwDJ0Rqhx1Nh
 PyuFIawrZVz5q1pZM7myDjgO2CIppSZUFSeAreWfYwyL813m/GrFxntrmOxiUl8OjxWOy
X-Gm-Gg: AYBFou2YMioKh8FgUeABKqu+8v7YHFcOI+Rr+ByzGCzPAsMsee9lNQxwm4kdESHpzqP
 MeRnx0tcLEQFoowJ5RhCO/jejT9GGqbsyAH6J4WO7vWHBi6GR6Prn6xFoadrlyt3Dm7759Aaq1N
 aFUq1jtpuqnm9hbb5uVFOF6Idmxt5iTb1S7VXanOOxzbHj9B/bJE0S0RwmMBjhW7/qYPnA/1bUH
 DM81ph+wDbn9mKVLTNkybDG9ZKBDsOaEzhe0u6sDeDhoW4p3fAmbs6ht/0W7GQ9PyT6DC9GHnZl
 Pf5vtNNxo/7TqjO7eIop/X81AMkoKsWUQKlwowPPGZkKrPXBOTXp31AvqMA8AWB0SPryZvORDMo
 TjH/iFSXiYoPBltVdabtgbV0aSRlPDTltDwgSB1mxDA2JztQ2rjr6yqGRccs9aHoLhuTi5msgE7
 HhUFKY0J2Mv6hqfDqrFdjjzVHZoUDyjMPKYohvBYdQtF2cItr3JW9zy1p3DjqNycJHYQK+lBSND
 a3U/Lle+/1nQ6ZzHH2klrpOahfKXJyKu3GTNoOWuD9AgAcA+deEUTH36nwHcEIpxY73jI0IjpP1
 POsipJDer5Jp7+R0RYqMgGJ1SwyD3h4rE9Rf4yxRiWbfZvK/22CWRUcVfhfubBQ=
X-Received: by 2002:a05:600c:6219:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49e6caacf19mr29454805e9.7.1789235687725; 
 Sat, 12 Sep 2026 10:54:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm235408815e9.3.2026.09.12.10.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 10:54:47 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 17:54:45 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 35aca022b11f9efa8a8f0f3eef5c632a9c52102b
X-Gerrit-Comment-Date: Sat, 12 Sep 2026 17:54:45 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b3b385fc27be1867866019e372fdd7ffd4d4f917-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5RwE-00086A-D2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8401394306520048251=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8401394306520048251==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MjM3vuL/LNc="; charset=UTF-8

--MjM3vuL/LNc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove var=
ious useless assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 21: Code-Review+2

(1 comment)

File src/openvpn/p=
kcs11_openssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/=
37bd7045_cd56a7b6?usp=3Demail :
PS21, Line 187:             sigalg=2Eop =3D=
 "Sign";
My cppcheck run also flagged this as an `unreadVariable`=2E Is it =
a false positive?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1617?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
d0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-=
PatchSet: 21
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Co=
mment-Date: Sat, 12 Sep 2026 17:54:45 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: Yes

--MjM3vuL/LNc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 2=
1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/pkcs11_openssl=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1617/comment/37bd7045_cd56a7b6?usp=3Demail">Patch=
 Set #21, Line 187:</a> <code style=3D"font-family:monospace,monospace">   =
         sigalg=2Eop =3D &quot;Sign&quot;;</code></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">My cppcheck run also =
flagged this as an `unreadVariable`=2E Is it a false positive?</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1617?usp=3Demail">change 1617</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 1617 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none=
"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sat, 12 Sep 2026 17:54:45 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--MjM3vuL/LNc=--


--===============8401394306520048251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8401394306520048251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8401394306520048251==--

