Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E683606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nAIdWFQV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JTRlqOIo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jYtLwPmY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JQ1wzmMc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=QpvUicbmAaKRVSAaocJBI3i3oyzf57oMSR5IUUecryY=; b=nAIdWFQV7CWof6
	lsQxotxC9eEgOwv8pPJLxMd/fvmcKTAmS4/y5zGqQMtuWH99fxrv1Xp8tKAh27UvELD02Z8k9ri/d
	xkFSdaHH8n3MhjaJsWi6miUWzyO94OqbxaKhabE+V6UU0JRgC7Dx6hWU2/aP26/n3K1tt4L8hXdcm
	T7I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJAJ2-0007Bv-6h;
	Tue, 20 Oct 2026 13:55:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJAJ0-0007Bo-PX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:55:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ARAKDacgOFyGMBgLDnAQ/a6iczUqDW+47OD09YNdgas=; b=JTRlqOIocOeIiLWaac36g/qVii
 XYPAwaYbsx/QNQ0cgK+yeZN7/zDvqhAsS5bNXwnMwNPLVL0LBVF5S+b1DZWkk+H1iPLRGUQPmtPSd
 eaEfuvqbtVFssZyAqrsnJFVdCw/NU/6MEG1S0o9g/vit9jWDDDYc4RPuWAIkWRFXTh4c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ARAKDacgOFyGMBgLDnAQ/a6iczUqDW+47OD09YNdgas=; b=j
 YtLwPmY/fQWNPFSAgHv3WybYmm7aRDwWphQp9c/AI78EhGwMnQ3Xd05FBeJzvbmF8DbhJALIDxZcd
 VIKyhAMXw0cCiijZIHoClh2xQjyxkpfJAarogxUKhHJwkznn80/1ADBiqA/8L6eQI52y3nxb6Y/9C
 2JAg4VSzQTdYeDY4=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJAIx-0005ol-Et for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:55:06 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so19794485e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792504497; x=1793109297; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ARAKDacgOFyGMBgLDnAQ/a6iczUqDW+47OD09YNdgas=;
 b=JQ1wzmMcG1fjpQ212HOu/3T4iKiUPt/mD9zxJ/MdkMr4esTbOQ5D4tMRkpLZMTVju0
 UjeqKEMH+Unr0Z8/aa0KSqZHNGbulFR4cXYeogGP3ELSjuad5m3Y89JQObIYkHARdQNx
 6a9WGeumZ1Khfv6j8qv+CUmg/zixJgllqe2bIguQ5y1dNH7pQQmUu2v+hPGof4Cfbwhh
 WgCK+ycoHGyHYzkGYXYPjmHC4t92QcedELTS3RjRWx5IsaY140Y3v+q4S5E+MwesdfJZ
 KUQQA/uVyzd0tfkxu/Ysi0qKJAgHpLV8kaFCXRFsdXbTVPnzLAsA8OA215vDSusXe4gZ
 DF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792504497; x=1793109297;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ARAKDacgOFyGMBgLDnAQ/a6iczUqDW+47OD09YNdgas=;
 b=Y+wDaI2mHykadzBN4FZsdInBquZ89s19JvNFTTUXHQdsk6E48H3vA1lVcHYXzaC3Ik
 NEba8tkelgnH5VDV0cp33nLp8GlTbKkTFJmDt2fhbpmOgHm1litY+X2WYGuh0fAMLjyk
 oaxkd2AqFyXldMRfGS6NXippv9aUPrldL9a9D5dT0/KkxUbYQWk3pzr0p1hl6x7VDjgf
 7lXb7/tM0hzTbLY5DzU+W49X4SXiLcrUhk0woXfoRa+7R4Ai6x9tdRMqCuF/EgISkuoc
 LKJpppnO/ZrI3o5uZNFbkTzQ+rUGd3+zTD6Mm+63btvWXpH/aI0qg9nwZhtvoTrEJ1Ff
 qxEw==
X-Gm-Message-State: AFq9FYJ8QvByVffuoWsLP8GSH+DBtPY01BiD7qLFCwKDs8hprzf96O7S
 o9Y5ra9o5esRQBZ46wnZxw0hwok3cAEAj+NlusM3ZqkwTY1mhApiIfGW74OvPuH1RX2Y0hJ5cOH
 Oii+DF1NcX/tsja2Ew0McPygWAF/PC9xQRQ1rgXNFTBXufvlT7SKvUosT1LF9GrhekWbv7McM3W
 FX6GfhzA==
X-Gm-Gg: AYBFou0OrCP7GLzyErQwZYmxlS/HSPWbZTCklCkSNryiMYuSMlauxLPJyxFOPRzDxqP
 k0f7GCUwzq9x9YRY7ArC5n5VlUqKjngoBjRTV8/Ee+GWPmV6TuMjPzC4oxv5ZKCMXMfGJ7jNkzj
 YlF2sa6qan/uAZCnkrpwlXRGBITh1sMkwUCyVFaAIEmY+A0uc8yCxAx8BM5FNwkESy1vMzUn3M5
 4XmuLhi/BQZfwPNzucnVxH8qD38PtdSaSBSRD+jZOHs9luSEo4HrrkMOgRMooAKJF6jpPshP9V8
 Ei0nXu8BU7fxRTIvE+3U5Q7q0WyKzDAtMkU6wuzkwTBuBdS5Vy7amzN+1kNVy8cRezYkbCCBQU4
 8HP9fTY57G84iPuv3eb5+sA/Qbpp0To5Yc0Lcpkz75ZWLUaOIfqhG6kClXlRWIyVJqQ9SM/diRN
 RxNOEb0+2x5gg2zxu9AKEB3mnReS7ZF3LhWvTLnDtqdceCUThluqcqLY4D+KOeWy27n/aORz1+p
 XIz4+bAtA+Cjz/nXn2QoAECZg/Y9tYptXzGZhklawNvMx4Y0nwdphAoPg+YKKoCUIXAfWLomX4Z
 xof+U/YwcW50mjnOGnedVPsY+T63XyH4DWM1RZDV0eFL0zsSBfN+/vBDewPv
X-Received: by 2002:a05:600c:a00d:b0:4a1:f736:79d1 with SMTP id
 5b1f17b1804b1-4a1f7367ac7mr35397245e9.16.1792504495814; 
 Tue, 20 Oct 2026 06:54:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c9e9c3sm67656135e9.3.2026.10.20.06.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:54:55 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 13:54:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9
X-Gerrit-Change-Number: 2026
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2026?usp=email>
X-Gerrit-Commit: b5c3a15c1a4cc9f6b0c8d6704bedc4dd27f95112
References: <gerrit.1792504491000.I230654e770c0556976a9bf4aaae9bcbea79b31e9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTA0NDkxMDAwLkkyMzA2NTRlNzcwYzA1NTY5NzZhOWJmNGFhYWU5YmNiZWE3OWIzMWU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <272c7a4566798bedf4102da1222e1a7d0e0783a2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJAIx-0005ol-Et
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure: Output
 compiler version
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1520787835872235900=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1520787835872235900==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lbZXD7Ophys="; charset=UTF-8

--lbZXD7Ophys=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2026?usp=3Demail

to review the following change=2E
=


Change subject: configure: Output compiler version
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

configure: Output compiler version=


CMake does this and it is really useful when looking at
logs in buildbot,=
 so one does know which compiler was
used=2E

Change-Id: I230654e770c055697=
6a9bf4aaae9bcbea79b31e9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M configure=2Eac
1 file changed, 4 insertions(+), 0 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/=
2026/1

diff --git a/configure=2Eac b/configure=2Eac
index e83aba7=2E=2E818=
b10d 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -391,6 +391,10 @@
=
 fi
 
 AC_PROG_CC
+# AC_PROG_CC doesn't output any useful information
+AC_M=
SG_CHECKING([compiler version])
+CC_version=3D$($CC --version | head -n1)
+=
AC_MSG_RESULT([$CC_version])
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I230654e770c05569=
76a9bf4aaae9bcbea79b31e9
Gerrit-Change-Number: 2026
Gerrit-PatchSet: 1
Gerr=
it-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>

--lbZXD7Ophys=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">configure: Output compiler version<br><br>CMake does this =
and it is really useful when looking at<br>logs in buildbot, so one does kn=
ow which compiler was<br>used=2E<br><br>Change-Id: I230654e770c0556976a9bf4=
aaae9bcbea79b31e9<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M configure=2Eac<br>1 file changed, 4 insertions(+), 0=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/26/2026/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/configure=2Ea=
c b/configure=2Eac</span><br><span>index e83aba7=2E=2E818b10d 100644</span>=
<br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><=
br><span>@@ -391,6 +391,10 @@</span><br><span> fi</span><br><span> </span><=
br><span> AC_PROG_CC</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# AC_PROG_CC doesn&#39;t output any useful information</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+AC_MSG_CHECKING([compiler version])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+CC_version=3D$($CC --ve=
rsion | head -n1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC=
_MSG_RESULT([$CC_version])</span><br><span> AC_PROG_CPP</span><br><span> AC=
_PROG_INSTALL</span><br><span> AC_PROG_LN_S</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2026?usp=3Demail">=
change 2026</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/202=
6?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2026 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--lbZXD7Ophys=--


--===============1520787835872235900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1520787835872235900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1520787835872235900==--

