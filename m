Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CEFCA601C
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vur7V20GvAR1zKO0W7b0n35Zh6/e3ZesWCb86mLVfN0=; b=MRtdnFGKiPqpn1EeGBXfttG+Ir
	xcwmF0OIVqVOJ3jGrplFLnr9vyCYUR70vp8Lht3WZoTBVMQbEHw432S3c3q97yR0YgiraNaS5Wkk/
	i+yLhkdbQ+c7k3O1K//PdrD4tn7dmn+kpZg4tB5PCJWCfjt+Jmk/tNmUqM1KRxow3ZsA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xF7g7-000144-6M;
	Fri, 09 Oct 2026 10:18:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xF7g4-00013Q-KD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1EpKwW1wNNlpcFyeuC7iGslNQnfC67J4qpn2g32+Cdk=; b=TywY9xwHrAfaIqp4U3s3ZZKy41
 NCYcXSDsI1yyyVrQYUd2Wnru3UAbelyhk7R427dDwpGclMLbN2nn4AfeT5VFJRIuWG9EQdpm/UdFA
 BtmS5b1PsERxxxJqSzNAJzm8wzQCXP0oC7ZnwVprvpeznlTsqiqzOg/fnsxOR6wogBIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1EpKwW1wNNlpcFyeuC7iGslNQnfC67J4qpn2g32+Cdk=; b=M
 O9dXU+/ALRHIbTW8MlKqEkIpe7aEqEsy7S0b9WmZZz7RgW1dZ5ItRvZKSf3XcwTnqBhNDtvsc08qz
 qy43mwgBMvAqPk1iHc4PdndLRTV6hOpOy5xTuUQ3ilpsGNZV8FkCcM6Yt9U3De9yy/W7MGqlvmQ6S
 9j7rOwTg4xHNKnu0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF7fy-00049z-9p for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:18:07 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so28210065e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 03:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791541080; x=1792145880; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1EpKwW1wNNlpcFyeuC7iGslNQnfC67J4qpn2g32+Cdk=;
 b=clwCyUj5mehQPPLPrKe/KzCEJwUvID0gqQFFmdPHfkZ/WB98RSugjSmfZwBm6iD1rC
 xOnwBg3ve4Kbl8rnx3RTjOElv3IM+AEV7s/Ubecf2/X87mCSXV73D9G5Np4SrnpCvnF3
 OR9cMmPI9YoPrmImyv5816B7AzkUFYWhUnn9yaYyWNZ7FY+A2sudc1Iu3A0SfTLmbcvo
 zKfNfPpYJaC7YD5HsEAziFn2raY1ZeS5WrnlgZA736xVqf01r0dVCMvxPK9PlS9O+RZA
 bpfJ+DZoSh5V/slBAbJJ82A5F8qIW/LAF6+BX4FdITI4y8l/dGnwChZtAEtdc6bTRviI
 7Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791541080; x=1792145880;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1EpKwW1wNNlpcFyeuC7iGslNQnfC67J4qpn2g32+Cdk=;
 b=hu5tc7Qq7uqnC//YayuB0sPdQL27gC5dbc4hUXagc/d8i2o8Mvv62oHy4AuSyeje2c
 bXnLhaicR2T31swWebPJsaym35Ws8/gAsRSOohbMwlZHTezRFVd2OAeQ4fYJTFifvUkI
 wVq0p0WSG6xTFZT4ZvRIGOo9OOsWIUNe7Q/HJRa/LVNlfkcpn1uEQtZ8PTdqvQHXQzOl
 0pRp6lZkaDUVebryVtCVWzCwLausOk5kNYeI3qe0qCGUp7jxEuF5mfvqvj0ssCf0Ak9L
 w8sICY/hm08aniH/7SFGWtGXCtW+ifLp4fWurej6fFVMI6cHRyO+DzkcqRkKOKfjRTzF
 xtbg==
X-Gm-Message-State: AFuF++mi+ds2p87IUSEIYiNyKwSFGxkmzb3E6bFCETAU4tJnGfNUrHQb
 CU5iyGKANler91aEBolQ4CArv4DGMpz5Z8Vau8aBJaLqZh+gIIytjVQVPqWAUPkQpxcNFxF9zrc
 5ye16EmYeXazo27bqGy6hI575oX6ekSvKA4S3RNxTbGCtaexgjVohC/LKW/YwP3GTGJdy
X-Gm-Gg: AYBFou2wLf6MN6stwUFh8TBYUV8PzyV/95yzbC/bUwjenaRUEVZ2uzEch7pDnv5HafP
 HKTesKjW/kO6fsPgqPbbYZ4q405F+jydsjf5Anc4iId8KwClGZxAiG0jHIj05ZvGjYY5h3oH3/2
 rlxuPd9xVfcXursZK/goM7j5tx1UUlYoCyJhvyjwRNf+cHnMDYl0XBS/ljOUB0ASuHOeBuZDfJh
 xkNPCw/5Uve/S4cUSmjnm8LkdoF3RewRxz91pt/12yPwQRBdjIo59soNdTwfN4TpedjqPi7ZUOM
 6mVIvG+qqf4/6icNIapMZE9+UE3khZVy0Pq7hHxSaJT9YU2pmuWE0S4x/I22YtKdfqjuospG5yJ
 7IypbE2a90jA6dmGRZP3MD8pulpJ0gbr7CCKQ+1KzMy90xUg7R7m2A3XImeQqvxgpLDYTxaPdCD
 t93lyDWePb4+adrTfeSlCGmA/hrAUUsO4YpPT+5+RAPQScaZ9hSyh7CBvU9GflH7zeF+EQ14JaC
 rFDRhG4a8QEnLriEArhlYng4znbDu+/eW5p5DvntffUSl26ErjAqHyeGzdcyBNWBzLW1GWhY7pD
 6b18XQfSFHltKpTCY08VHq21o5Utjtvf7P+j7ZjJ4pCj9eESHtYAqGRDBQ7M
X-Received: by 2002:a05:600c:548e:b0:49f:f9d1:e618 with SMTP id
 5b1f17b1804b1-4a18e4aa057mr24954685e9.17.1791541079495; 
 Fri, 09 Oct 2026 03:17:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm71730725e9.4.2026.10.09.03.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 03:17:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 10:17:57 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
X-Gerrit-Change-Number: 1986
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1986?usp=email>
X-Gerrit-Commit: 1c7812a580e7d118f1a6ece8e08edae3b98bd208
In-Reply-To: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
References: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDU4MTU1MDAwLkk4YTUzNDlmNjZmNWMxYjUyODg5YzJmNTkzZTAxYzIxODI0ZjkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b890994b0e675fb7123aaf19a70ce2f97ece1b75-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xF7fy-00049z-9p
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: config.h.cmake.in:
 Fix issues with string functions
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8933992077865766601=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8933992077865766601==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pN0ndRPWQCQ="; charset=UTF-8

--pN0ndRPWQCQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
986?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: config=2Eh=2Ecmake=
=2Ein: Fix issues with string functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

config=2Eh=2Ecmake=2Ein: Fix issues with strin=
g functions

- Add missing HAVE_STRTOK_R
- Make HAVE_STRSEP a proper cmaked=
efine

Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
Signed-off-by: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
986
Message-Id: <20261008205006=2E28086-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39=
794=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M conf=
ig=2Eh=2Ecmake=2Ein
1 file changed, 4 insertions(+), 1 deletion(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1986/3

dif=
f --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 6c8660c=
=2E=2E8c3088e 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=
=2Ein
@@ -268,7 +268,10 @@
 #define HAVE_STRING_H 1
 
 /* Define to 1 if yo=
u have the `strsep' function=2E */
-#undef HAVE_STRSEP
+#cmakedefine HAVE_S=
TRSEP
+
+/* Define to 1 if you have the `strtok_r' function=2E */
+#cmakede=
fine HAVE_STRTOK_R
 
 /* Define to 1 if you have the `syslog' function=2E *=
/
 #cmakedefine HAVE_SYSLOG

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1986?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
Gerrit-Change-Number=
: 1986
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--pN0ndRPWQCQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1986?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">config=2Eh=2Ecmake=2Ein: Fix issues with string functions<br><br>- Add =
missing HAVE_STRTOK_R<br>- Make HAVE_STRSEP a proper cmakedefine<br><br>Cha=
nge-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1986<br>Message-Id: &lt;20261008205006=2E28086-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg39794=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M config=2Eh=2Ecmake=2Ein<br>1 file changed=
, 4 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/1986/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>i=
ndex 6c8660c=2E=2E8c3088e 100644</span><br><span>--- a/config=2Eh=2Ecmake=
=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -268=
,7 +268,10 @@</span><br><span> #define HAVE_STRING_H 1</span><br><span> </s=
pan><br><span> /* Define to 1 if you have the `strsep&#39; function=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_STRSEP</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_STRSEP=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `strtok=
_r&#39; function=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#cmakedefine HAVE_STRTOK_R</span><br><span> </span><br><span> /* Define =
to 1 if you have the `syslog&#39; function=2E */</span><br><span> #cmakedef=
ine HAVE_SYSLOG</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail">change 1986</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a5349f66f5c1b5=
2889c2f593e01c21824f937f0 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1986 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>=

<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--pN0ndRPWQCQ=--


--===============8933992077865766601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8933992077865766601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8933992077865766601==--

