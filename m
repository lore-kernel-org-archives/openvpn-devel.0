Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CF1CA600B
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=61DmJ5Tx5BZ0rYvp36ftmDpZpzIM4JF4BAfwTSbe2Ys=; b=X6af2MrenAKoQS
	Wb9aY1/WmpCuhQrFPo54PKoKBrGWRPpe2gj0XHM4LKdWtvpKh+sHxUsHtsiBZeSTWGQgLhNUlj9R+
	7H0B1q7MaXvTTyj8o1NuT7IxEQF583/T0ViXZV3dmbV5u4Xul65aIlfJfr5l3dThJ0+l+ZQ896ked
	5dI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEm6e-0002Fg-Rl;
	Thu, 08 Oct 2026 11:16:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEm6d-0002Fa-KP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9m5+bLV7ITrwrjdDWq0Lg0ePMD70OM2Jou6zOYV1hR4=; b=EBbZ8fbY+TtQuM8c6mlvCl4tUj
 +Ccw8I5Ce1Zb4yPgkqPxB29zEwu/PHp4AP+fE+4nYuvyBV64k+x08xw/3Z6R44zS983DW8C8BON0z
 DIqlel2LPxSH7sTxFTir5oBWHBqVZHiTqwZqkKvXu0AMefzll92xlS3g9GUnL8X4sBEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9m5+bLV7ITrwrjdDWq0Lg0ePMD70OM2Jou6zOYV1hR4=; b=J
 hcJ60UgwwFal+wl+CWTwpjwIXDqv50TjvVekePaS7+KdaJZsMPb1gGwPBXSGotQx3FUXkgC6L4I/Y
 cBHc6Qh5fm17dU+QbCE+Mq66GclhzwXtbPIVmI7LyBIBEFSkTmwX6UzOyu3LIKD49M+jWnuZWEBYi
 kYKhS9u9nYpja0qI=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEm6Z-000413-5Q for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:16:09 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so21600715e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791458160; x=1792062960; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9m5+bLV7ITrwrjdDWq0Lg0ePMD70OM2Jou6zOYV1hR4=;
 b=GNWXVbWrzVpLWteGlP2pHingMXBn0Ae7De8j1n5RI45O9/yQclj9tOhL5iGV6RSNtc
 88NwLyp9tmJaT7M6sa3WNRZZ3Za3oSSfTPxcyGvE7nwxSPpOWkWYAhVe79HSYUQf43P9
 RD9+uPFmEn9Yi4Dq6pABOdMYAc5hiesbeEY+pcA5ZWqj0BnzpjflPNkqq4cMlZMYIoH4
 POcVHWYjvDb3bLB4ozABzHqzp0u3oz7BsRRy6YmQR0nltGJRKuXBh/oYzyg9o4m8SsNX
 qYJMBiGR26jdATkLTtCWnT884nOiBpucjgFw8b6HwfjR3aLhx1f0IxdBtS36TuKmKkuq
 OGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791458160; x=1792062960;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9m5+bLV7ITrwrjdDWq0Lg0ePMD70OM2Jou6zOYV1hR4=;
 b=enc50DuBdDPp9yfWNZnxnhksNf6ZQYy2wyrzI52t10wXTFC7NQwHXw23PQRDU4gTGJ
 A4E0IHVxoVZd5zD3h9ZiwIpByJds4Kl5wXSxS3T+BdgQ6saLweZI3vf9o6ccUi3BQ6ly
 Z4wzZnb8Jnso8mQEbL6WXtFrI1NxatZpCDdE2JGrpT9v/o05wp+UPbfw/aFVA84heeqT
 FcXXtcba/zwlrLpQcanleSY4HRHW++whVK+Lf8z24yi0DmXtBucrRBkSkeDTnbKYPLSD
 KGERQdhEeV1e/FhUl03B03TNH0+/OBtmiSpyez2Mzz8Fr+HvKO5HmLlx+60ULODzJ2dy
 Mw4Q==
X-Gm-Message-State: AFuF++lplvLD3ulmBSCYtMrXB9l1eqSxlbUGl4apF1SM9nLoYeH4ulVZ
 oA6hdfYOQ4iche2LUtBiG/yvX2hLKq9loMAV7ndZp70y7h+IBQi3eiotp4QdOchcnGj5VfCOPsn
 jpdY/q2MFVhlmqSkVKTvxYHURVKscWaVITBvggdlcix9V9YGCwY8Kt8DpuUsEuRUsFMfT2DFsQG
 tX8gi3Lg==
X-Gm-Gg: AYBFou3ewc6xwkRg+HZpdJBgQTTn80/6La5uSOAmvoa/G+iVFGht7kbj5gNxxgYXLMi
 GPILW06zHK+OeCBpfOQ9WOg7LkvYp2219VjSH5UhdXSCAcBem4+zDYiKBLQGKoOfEzVNi6PnXd+
 3JQMLXMokR6o9DejJ6xbJSa76cUvae64YRIsE5bemqLealiQs86INYfUOot7i3qKunXaWGkVGJd
 HT7PaOYhKz0zglvUItuz6EiMzApHaV0M1gER3SH0qV5CopmsjRhqcXD5gVZwyQa1aR3jMknii0p
 KJraFCCiBvfnH2KeObNijcg0t+WW4LSAJESW/stat1cbThBo6f9Fv9oRxPGx8HTobCTISIoBDGc
 GDsWDXBhh4cZaOGSLGgf9Skkzr8+yextvcIPKeMhNvFMRL1Nx6q5pX0ALMMLGfT8vlzWO7bDUs9
 dbr3d1BiXDrL9d0qrFw5p9ig3OzasfdF4Zs9tSJyxP5vAFjoCQeJyU7KvjNqw85/vftNtiQ3xXK
 Ap8/U3BJHr2heCKPGHp8kV3hdVUSAI6PDHm3FknEYZNGwRVDHzDFJXDW8Z3npPOOp5oWtz6RhD2
 7zi/V0ptb4xclFwoFH0GPf31ltLQeG1ZoJnhQIVIhbg5XpOaudFcP9XMqwXx
X-Received: by 2002:a05:600c:3e88:b0:4a1:746e:5898 with SMTP id
 5b1f17b1804b1-4a18045e153mr92395685e9.13.1791458160306; 
 Thu, 08 Oct 2026 04:16:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1842a349bsm63904135e9.2.2026.10.08.04.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 04:15:59 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 11:15:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
X-Gerrit-Change-Number: 1986
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1986?usp=email>
X-Gerrit-Commit: 5c5bfa88beb26e2e2993f82af002a91330b8c15c
References: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDU4MTU1MDAwLkk4YTUzNDlmNjZmNWMxYjUyODg5YzJmNTkzZTAxYzIxODI0ZjkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0124d19c8bdf969ef145cceded3d7e50e451e20a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEm6Z-000413-5Q
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: config.h.cmake.in:
 Add missing HAVE_STRTOK_R
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4966288950684949144=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4966288950684949144==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bFRDpPOFJEQ="; charset=UTF-8

--bFRDpPOFJEQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1986?usp=3Demail

to review the following change=2E
=


Change subject: config=2Eh=2Ecmake=2Ein: Add missing HAVE_STRTOK_R
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

config=2Eh=2Ecmake=
=2Ein: Add missing HAVE_STRTOK_R

Change-Id: I8a5349f66f5c1b52889c2f593e01c=
21824f937f0
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
=
M config=2Eh=2Ecmake=2Ein
1 file changed, 3 insertions(+), 0 deletions(-)

=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/198=
6/1

diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 6=
c8660c=2E=2Eb2d8e40 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=
=2Ecmake=2Ein
@@ -270,6 +270,9 @@
 /* Define to 1 if you have the `strsep' =
function=2E */
 #undef HAVE_STRSEP
 
+/* Define to 1 if you have the `strto=
k_r' function=2E */
+#cmakedefine HAVE_STRTOK_R
+
 /* Define to 1 if you ha=
ve the `syslog' function=2E */
 #cmakedefine HAVE_SYSLOG
 

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c218=
24f937f0
Gerrit-Change-Number: 1986
Gerrit-PatchSet: 1
Gerrit-Owner: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--bFRDpPOFJEQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">config=2Eh=2Ecmake=2Ein: Add missing HAVE_STRTOK_R<br><br>=
Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0<br>Signed-off-by: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M config=2Eh=2Ecmak=
e=2Ein<br>1 file changed, 3 insertions(+), 0 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
86/1986/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=
=2Ein</span><br><span>index 6c8660c=2E=2Eb2d8e40 100644</span><br><span>---=
 a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</s=
pan><br><span>@@ -270,6 +270,9 @@</span><br><span> /* Define to 1 if you ha=
ve the `strsep&#39; function=2E */</span><br><span> #undef HAVE_STRSEP</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Def=
ine to 1 if you have the `strtok_r&#39; function=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_STRTOK_R</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Define to 1 =
if you have the `syslog&#39; function=2E */</span><br><span> #cmakedefine H=
AVE_SYSLOG</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1986?usp=3Demail">change 1986</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a5349f66f5c1b52889=
c2f593e01c21824f937f0 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1986 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--bFRDpPOFJEQ=--


--===============4966288950684949144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4966288950684949144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4966288950684949144==--

