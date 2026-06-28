Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FE7C43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xn12rOPPM9mXgT0QXHufUgP8Dbbv+5+VzC49I4wA1Tk=; b=OwLhfPXMcKT6x/QiiPb9UeWJN6
	srv90908f0clbGR3e/uWS7lRenWeKmRolt8gIAXbAi1X8yPUU+X7duQG5qKsrd6cb98OdwAdPaswO
	RSCm/x3Bp2TtdsFBFJ4mPcx2ieqTisRy2bmK9tC2iZpj56spQQDFjf/ML2TmBD9MN/9U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdwCJ-0000Br-JN;
	Sun, 28 Jun 2026 20:33:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdwCJ-0000Bl-7W
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:33:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Dr/ukitg84UoF8647uuNzMkF3/mtTyfqgpXzPUAAnt0=; b=Harjax1auSKh51NEh5mjobJZGP
 2z6inGB3fH8n3mhTs3Qr7zymj7O2v8qIWbjrvO8fDmENsJ/wLW1iG5blrLOdMPsTqdLLOis4JzZzK
 ahIdXrxq/7TNe3h9p4IwWldBB7SbPap+dsPlxBWjoy6dT++S1ksPJ1rCcX591ao99EmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dr/ukitg84UoF8647uuNzMkF3/mtTyfqgpXzPUAAnt0=; b=E
 ++zZbgDFbIRlVJULicoj2WnvXbUndmCa58k0YQ3n3sK2wWAKwhoFq7MwI7PKQhhpFoHUzyJcDGTiL
 fO3oxuIWZGbZMSrukDyPKA5GTdfp2RihyFkBe4+o7f67b6ucO+jDC1Ovj1os5BaOVDFmgVpUJEuZB
 QV0n0TcV0/d46UmU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdwCI-0003QA-MP for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 20:33:47 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so2227941f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 28 Jun 2026 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782678816; x=1783283616; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dr/ukitg84UoF8647uuNzMkF3/mtTyfqgpXzPUAAnt0=;
 b=PMPM9JYqqHuWPUu5OGFnINQCuTYz+OyI0JRXQDxARksS09EEkGGc0gcRFAN9An4uO1
 bhGbSR1u7rEr/79JaO8MqLbVXnsLVnzQ9n4L4A7+DmIc6UKuYVLtt7hZST5KHAogf+e5
 uwTcvUQK38+R6sAWxwAX6OFELoFFRCr3q3SHLL6F4ZWrpbKnwJdjl6cf3zAqcwi0vvjD
 Wn+z7jlCr+gxrZ45IKKtcc6rD1SIWl5Qd09zg7VRxdg3biB6HWCd4835GozjZ/ZRW8Qd
 drK9M9t6gydUDw0OPaoWsQi++suIYcuFJCu739voJr51710KQKDw0DiA+gYXr1BxvAxc
 A3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782678816; x=1783283616;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dr/ukitg84UoF8647uuNzMkF3/mtTyfqgpXzPUAAnt0=;
 b=DY77wkCgH6/mYQkt9P9jbr8RCcRsruTyz53ba+7loXdc7VSIkbJgmBqyW3k7RSvcLd
 oZZdu/t+QSHxY0cr62oNEG9B/CP6VnL/UU8gVB7ycV3mWig0is6HvdY4X6PvuJyRwQf0
 bSMDCGoNWmkymrePkmsG29FLCp7BjU6K60LUTpiN5snR42ghWHlRAC+hy+cPdk+XhXki
 nk5YqVA3ROBXz8XKMIfY+WKTpzUoaXwEi7pJGlrZRQaF6iy4lB1fTX0qFKtRJy8aahDy
 TVwk6Pyv3GQcYAv2z2t3ojtak+TWIU253X2cojEhE8L50dwe7wm5yf/YKStFEuBdMhXx
 FvFw==
X-Gm-Message-State: AOJu0YwU5x92d21BAj2bSLJQQ7rxFyUSyvCxIPrM891ORYd8hX6qFp1q
 8eQR/2PTgICfx8pmCNheSwsfD13+gy3uh7s2wNHByNVDsBRNpYUU21djo/gOwwvR13WV9JXVDsI
 yRGAnp2xw1V9LUd6GUnpIGVEuCKzvpV2atibXpEw0qrB2/yrkcTTLfATiX+RdBwCv8rVB
X-Gm-Gg: AfdE7cn8/iuFZ+I0qSHlOeYM9mD+BvbevulWG00kEkNeAw+KyEnZobP1ai3C80BO3Le
 DcobP/2bx/dwldysHT5A4FsWtpK8dJIN090kO9PhBGWPGWiIrGLltqadnjQ+NwQnfA8kLqVXNn9
 WSvLWRAzgL2Rsyb4VOdX4MNjf5P2kw9/K6b2M6uiH59HeKhOp9/d0OJrWL7Vg6fF/h+uALnhKHh
 J6qlp5k8T14r9L1XpDa4u7FF/u9ngn5dFNYGP4BR/phagtRx5f7eu/gmnbt1/FwQcqSvfcnwer2
 Omm2akLEaLnVQN6BCXmgxskKONnOg3mhYgfKgR6c2kWLQwf/jKsreC4ckUdy+iAYNBHtDTSwbzk
 o+kpk5PF6evRZdtVOl24Hz1efZ24LrgklU2FSI3BDvjEupObEYpLF45kytNT61Ly0tThLgpz1Yz
 28CxCG5lxeor0FOGeYSRCDQxz0SnaxKCTHq+GgGQf6KU9DjGlznGb1XgUtdieMYpo1zKsiNhaNA
 Ozpcof7aZuvKVX/0z7GIW05A4jEOVKgPEe2W269hPzmmnjJHemsABAR8xCgBT1ZCsfYQiZAcsH4
 QLs=
X-Received: by 2002:a05:6000:2204:b0:472:a14c:9892 with SMTP id
 ffacd0b85a97d-472a14c9967mr5688042f8f.40.1782678815100; 
 Sun, 28 Jun 2026 13:33:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4737769b6a0sm4043471f8f.28.2026.06.28.13.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 13:33:34 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 28 Jun 2026 20:33:31 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
X-Gerrit-Change-Number: 1604
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1604?usp=email>
X-Gerrit-Commit: 9e2f3843df1cdacffb20f7ca4e6aba6a784acb05
In-Reply-To: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
References: <gerrit.1775130235000.I355760e43c3e2da0dda0cdec6e4253c028cefe38@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MTMwMjM1MDAwLkkzNTU3NjBlNDNjM2UyZGEwZGRhMGNkZWM2ZTQyNTNjMDI4Y2VmZTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc1458e998b0d81a618f8fabcc6e441cfd4e3d4e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdwCI-0003QA-MP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix building
 wolfSSL with CMake
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2639180957016696156=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2639180957016696156==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kdwUhd9jRVE="; charset=UTF-8

--kdwUhd9jRVE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Fix building wolfSSL with CMake
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix building wolfSSL with=
 CMake

Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
Signed-off-by:=
 Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604
M=
essage-Id: <20260628150320=2E13244-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37342=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLi=
sts=2Etxt
M config=2Eh=2Ecmake=2Ein
2 files changed, 3 insertions(+), 0 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/04/1604/7

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 715d0=
2c=2E=2E4779d69 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -32=
7,6 +327,7 @@
     elseif (${WOLFSSL})
         pkg_search_module(wolfssl w=
olfssl REQUIRED)
         target_link_libraries(${target} PUBLIC ${wolfssl_=
LINK_LIBRARIES})
+        target_include_directories(${target} PRIVATE ${wo=
lfssl_INCLUDE_DIRS})
         target_include_directories(${target} PRIVATE =
${wolfssl_INCLUDE_DIRS}/wolfssl)
     else ()
         find_package(OpenSSL=
 REQUIRED)
@@ -367,6 +368,7 @@
 elseif (${WOLFSSL})
     set(ENABLE_CRYPTO_=
OPENSSL YES)
     set(ENABLE_CRYPTO_WOLFSSL YES)
+    set(EXTERNAL_OPTS_OPE=
NVPN YES)
 else ()
     set(ENABLE_CRYPTO_OPENSSL YES)
 endif ()
diff --git=
 a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index ae1d264=2E=2E34f=
289d 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ =
-13,6 +13,7 @@
 
 /* Use wolfSSL crypto library */
 #cmakedefine ENABLE_CRY=
PTO_WOLFSSL
+#cmakedefine EXTERNAL_OPTS_OPENVPN
 
 /* Enable shared data ch=
annel offload */
 #cmakedefine ENABLE_DCO

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38
Gerrit-C=
hange-Number: 1604
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--kdwUhd9jRVE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Fix building wolfSSL=
 with CMake<br><br>Change-Id: I355760e43c3e2da0dda0cdec6e4253c028cefe38<br>=
Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1604<br>Message-Id: &lt;20260628150320=2E13244-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg37342=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M con=
fig=2Eh=2Ecmake=2Ein<br>2 files changed, 3 insertions(+), 0 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/04/1604/7</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index 715d02c=2E=2E4779d69 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -327,6 +327,7 @@</span><br><span>     elseif (${WOLFSSL})</span><br><sp=
an>         pkg_search_module(wolfssl wolfssl REQUIRED)</span><br><span>   =
      target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_include_=
directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS})</span><br><span>    =
     target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/w=
olfssl)</span><br><span>     else ()</span><br><span>         find_package(=
OpenSSL REQUIRED)</span><br><span>@@ -367,6 +368,7 @@</span><br><span> else=
if (${WOLFSSL})</span><br><span>     set(ENABLE_CRYPTO_OPENSSL YES)</span><=
br><span>     set(ENABLE_CRYPTO_WOLFSSL YES)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    set(EXTERNAL_OPTS_OPENVPN YES)</span><br><span=
> else ()</span><br><span>     set(ENABLE_CRYPTO_OPENSSL YES)</span><br><sp=
an> endif ()</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=
=2Eh=2Ecmake=2Ein</span><br><span>index ae1d264=2E=2E34f289d 100644</span><=
br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ec=
make=2Ein</span><br><span>@@ -13,6 +13,7 @@</span><br><span> </span><br><sp=
an> /* Use wolfSSL crypto library */</span><br><span> #cmakedefine ENABLE_C=
RYPTO_WOLFSSL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmake=
define EXTERNAL_OPTS_OPENVPN</span><br><span> </span><br><span> /* Enable s=
hared data channel offload */</span><br><span> #cmakedefine ENABLE_DCO</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1604?usp=3Demail">change 1604</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1604?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I355760e43c3e2da0d=
da0cdec6e4253c028cefe38 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1604 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--kdwUhd9jRVE=--


--===============2639180957016696156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2639180957016696156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2639180957016696156==--

