Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB6E606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HV559cEl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WTCTLGyQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Bu8RACDR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JsGapHd/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=yXnZg3NSQ5Xjcn6WzgUB2nyExcklBvZQzsSM14CAXSA=; b=HV559cElcnTq1THrkwzFd9ABu1
	wTOfRM1n03n8HYEiX76hR33ROvcB6enoU2lgmUTH487YBWgKLz0sWaW+ugsNHYDG/YKSZbiHc4pSF
	PVEAh7kDKynNP6+xalPWmsgKoWKKHCgFaTgbNSLyZz1mYlmyQlTjjcOGOP5k+VwguRxw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM3r0-000000008Vo-3Sv1;
	Wed, 28 Oct 2026 13:38:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM3qw-000000008Ve-2YdA
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YTXQ2O5SoGZxJu2WjT0ks/7O2tEgITbUOM1emAdAygk=; b=WTCTLGyQJqdUIP59A3x8aB8SGv
 9nEidd2rLvsZQgFY41wViDNkhMxzWd34+zqgdmMEOhy2M8tqGrF47QtP4GuA8hHLMdCaKCmrlt5jg
 uU0AcW1WddjoifrGJMEPtqgHQDU9227w+47jQ1lC2QjUMTQZ15my9BdHdbEP3QqCIxZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YTXQ2O5SoGZxJu2WjT0ks/7O2tEgITbUOM1emAdAygk=; b=Bu8RACDRxPSIS7x9hUCYONXJf+
 h+rljfTZyCBV5+JpXUbvAfeK0hxsTXxuZnp678sRyouC02pLsCm7xiGhQDGmjMb0RGKDe0bkdvLAO
 pQPUa+XEZ+WxAP6ajgQPNnfS7MG2e17Zp5z2deQLiGYFjS3Q1rlvEvN2cAGYEA7TY4Gg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM3qu-0000000089n-42yi for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 13:38:06 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so7847175e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 06:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793194678; x=1793799478; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YTXQ2O5SoGZxJu2WjT0ks/7O2tEgITbUOM1emAdAygk=;
 b=JsGapHd/KE+KTKYfDbL2+MfMSdftfOM11G8/CqbK5Yhs6hk1UhuSWgBb/ippwwcn3M
 /+y5pJsdKoaKXDTMuRg28ztR14Aeyg5xZC/AhK1/hN7ib0fwCoTy7FV8dSy+o3vdizUk
 E2XJ0tl0e+1ISTai3MBuud9otmGojJbpl1grSKOCkt8r9Mli+Ms6FFEIollbbyXxLm9O
 MsClD0PBt1+c9SpgAmMo5YHm+V21c9pWZul2Q2iA6Z2qnU1smyy/O1HFB73Fxl0TXYNf
 O1a0/Lu/aYCyxrNog+whUGEwauiXu2aoZ0/vzYGKSdd23MpD6fZ4/myFvAcF8cnJElbc
 WTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793194678; x=1793799478;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YTXQ2O5SoGZxJu2WjT0ks/7O2tEgITbUOM1emAdAygk=;
 b=njlVFxjo7Y1nN4Ius+Qic2LUldMA8HMoof92mMyWieaD/7KJmT72mTD1GkrSL3u2zq
 X4FPxMtzTfk/QqRqVjSFlE5da5jDTcbPUZmWkFLYpcaduyccgHJXHCwKEeiFOs8Dc5nH
 WCGZ0R/K2K3q54rwHnsqUTSdOeo08rDPyUoaZYozaP/S4RWvlii5QvZeiiUyjOjcgawd
 sxLlzvC/w9UlnRAxj9l1MKQfcwQ+iJp1+Or71PtbhQ10MKJ0hhF6rKfhmuL9Izp16wpv
 XTxY/v/UcjuIgHTkuX/AwhAby9e20At963g43BIWwEooZtFMwya6Nbz/e9vCcYIV6P/Q
 820g==
X-Gm-Message-State: AFq9FYJXQcQs+fTYehBsuXd4WoOQOJM5aKYctH91r70KVwEgJacjSsTi
 gNjMORwJLiaayAJS/1RK4ca7N0Lxk31ZeA9lE9omPf7fiILgy0TueZW9q5Moo+GH0XZPevePG46
 GYUXxtO0+FRYab7VsLvknkCxDOfK9Sn6pYal8mjJpCpgL4hL93g3/+Qfhahr9wZyrkknguus+2p
 Ls4+0pjw==
X-Gm-Gg: AYBFou1if99XMmsVsxZkv7V8J4K+pfMKgnLwVgBSNtw/ZOdh/lgRjYhLHZTn9tEPOkH
 1k5zXGS/+Nia2KAO6cDqK86FM9/+sVwOm9D2091Gmcv1Si4e2PpGUGv6BXauOi3SMpDduwYRwyr
 HIf5z6ZcSK+Dmzk7pP/wc46oqeM2GHxMTDcDiGki01TwhRX4uBbAuy1mxMbBAsF9dJZBF7F5MzD
 U6v0haNNuWJf9I/b3LNDEYx75sO8Xd7ZugRGMySaU8U/fkI8GdTF5eKiQChe/JMnXztUVu5dPZq
 IvQFpE4heFlcQm6vLVRjYpVUgua3CoX1Ktu8IQd9kgLWZSCsO++4SF9REj5fPeSXspY8ZK3skXe
 Tu9Q2VF9gfG1fLOhdOABhmq50gxOJ8m3DTfa9BiHdM0jEOGTZqyfjDCswAitGsa8iA5xxMxp3iP
 ZBrx3PVRC9GQNSxbXPwSW3ph9o6IMLNSpmg65RlPREIrqKvCjcDLOtVP4S0Ng+UQIffGOsI5rIE
 rs48ho4O692EGMCVLt3/FGgDHsgjIV1GDArjiTqtAd2SgRZDjafD6G0resGZmyWaVDP8uQSziSE
 Lik/uNpw3BkL1Gds7V+OV+noKv5T39XZ0ak/Z1KkOIg0OGoLWBAST2Ywg6Q/OUCvL8BqprXU3C1
 MkOW9S5wq3hQFooAT3BNJA9zWbd+HVS7bHnjGcdYRjAm8Ejv4DawLZ0kxvU5dhnq0fWSDyM9i1D
 EqVockmjbBOeCFeaY=
X-Received: by 2002:a05:600c:8114:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a997cf5091mr44950195e9.17.1793194678232; 
 Wed, 28 Oct 2026 06:37:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c9f150fsm42988255e9.10.2026.10.28.06.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:37:57 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 13:37:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138
X-Gerrit-Change-Number: 2059
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2059?usp=email>
X-Gerrit-Commit: ec513f49473a63b5b67b5acb273782bbdb5ad29d
References: <gerrit.1793194671000.Ib1f78af0550ee9ab47a9598bc8055dc46c1df138@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkliMWY3OGFmMDU1MGVlOWFiNDdhOTU5OGJjODA1NWRjNDZjMWRmMTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e7033f86fe7a9da278dede4800c2c1f180fb198-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM3qu-0000000089n-42yi
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: skip DCO
 route installation when address learning fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1697565256625975477=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1697565256625975477==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="chByFE8IQao="; charset=UTF-8

--chByFE8IQao=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2059?usp=3Demail

to review the following change=2E
=


Change subject: multi: skip DCO route installation when address learning =
fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: =
skip DCO route installation when address learning fails

Only notify manage=
ment and install a DCO route when the learned address
belongs to the reques=
ting client=2E Apply this to IPv4 and IPv6, including
the initial client-co=
nnect path=2E

Change-Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138
Signed-=
off-by: Marco Baffo <marco@mandelbit=2Ecom>
---
M src/openvpn/multi=2Ec
1 f=
ile changed, 10 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/59/2059/1

diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2Eabc26b9 100644
--- a=
/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1211,8 +1211,12 @@
 =
    }
 
     struct multi_instance *owner =3D multi_learn_addr(m, mi, &addr=
, MULTI_ROUTE_PERMANENT);
+    if (owner !=3D mi)
+    {
+        return ow=
ner;
+    }
 #ifdef ENABLE_MANAGEMENT
-    if (management && owner)
+    if=
 (management)
     {
         management_learn_addr(&mi->context=2Ec2=2Emda=
_context, &addr, primary);
     }
@@ -1256,8 +1260,12 @@
     }
 
     stru=
ct multi_instance *owner =3D multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PER=
MANENT);
+    if (owner !=3D mi)
+    {
+        return owner;
+    }
 #ifd=
ef ENABLE_MANAGEMENT
-    if (management && owner)
+    if (management)
   =
  {
         management_learn_addr(&mi->context=2Ec2=2Emda_context, &addr, =
primary);
     }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2059?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Ib1f78af0550ee9ab47a9598bc8055dc46c1df138
Gerrit-Change-Number: 2059
Gerrit=
-PatchSet: 1
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>

--chByFE8IQao=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo would like Arne S=
chwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">multi: skip DCO route installation when address learning fails<b=
r><br>Only notify management and install a DCO route when the learned addre=
ss<br>belongs to the requesting client=2E Apply this to IPv4 and IPv6, incl=
uding<br>the initial client-connect path=2E<br><br>Change-Id: Ib1f78af0550e=
e9ab47a9598bc8055dc46c1df138<br>Signed-off-by: Marco Baffo &lt;marco@mandel=
bit=2Ecom&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 10 inser=
tions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2059/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=
=2E=2Eabc26b9 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -1211,8 +1211,12 @@</s=
pan><br><span>     }</span><br><span> </span><br><span>     struct multi_in=
stance *owner =3D multi_learn_addr(m, mi, &amp;addr, MULTI_ROUTE_PERMANENT)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (owner !=3D=
 mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return owner;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #ifd=
ef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (management &amp;&amp; owner)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (management)</span><br><span>     {</span><br><span>=
         management_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp=
;addr, primary);</span><br><span>     }</span><br><span>@@ -1256,8 +1260,12=
 @@</span><br><span>     }</span><br><span> </span><br><span>     struct mu=
lti_instance *owner =3D multi_learn_addr(m, mi, &amp;addr, MULTI_ROUTE_PERM=
ANENT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (owne=
r !=3D mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return owner;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (management &amp;&amp; owner)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (management)</span><br><span>     {</span><br>=
<span>         management_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context=
, &amp;addr, primary);</span><br><span>     }</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Demail=
">change 2059</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
059?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2059 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Mar=
co Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--chByFE8IQao=--


--===============1697565256625975477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1697565256625975477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1697565256625975477==--

