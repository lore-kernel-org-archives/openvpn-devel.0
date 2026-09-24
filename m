Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E45C98317
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQ+OVdx5HAGrJSrpV9mf99ECU+rTBg217Z8PifIC1q8=; b=ApU/B4xt4TiQoLukPPniQ+iq9i
	Dvmrkjn4n7lbc93BlokDsrrkVzy+ymUtOy6y+Budea+Cg2vkQ0WrwxsQZw6Qqzkr8T2S4NivhTGM6
	z3wY3SCZLLGaYfa73Z6oCx4dhQA6mads4iQyGODHQFxiXOFleXESDPwNxtCaSProSmxk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9ih0-0000cJ-Qc;
	Thu, 24 Sep 2026 12:36:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9igz-0000cD-Jy
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:36:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=F2tNs9L5NRbwNDkHgwaLC8DqtGUaFWTnSG3YvtUH644=; b=mqvetQS9No37nqrCOHknUMKH59
 s+Lqjyr1HX8QIyf0TG66Bkv+mAFtWIcYfrx/GGVoLpGtonnDDstqmxfz7M/bJdXd5ukfs/VQvtYaV
 wgOa+6p8K99NwBUsDLEw28/QftGTYDR1oKsbXeLSQ5kzbVmEQAv5krl8Ssgq7H3FmAqo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F2tNs9L5NRbwNDkHgwaLC8DqtGUaFWTnSG3YvtUH644=; b=m
 HXrcrq4Di5sEPn7TrHFgfv+/+NrNzPAkDzXLVarOw/hBIuMdWKexJODl5zhXartMywTkfDV3QPMyD
 TP9/aAR8ce3c05x7mwvF5u2OwOTuA0KA9AKm+B0TJbwxxOr90dRjXiH+QUzLgoMFZXkOnnzpnKSeL
 HygbJfzipJlhUct8=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9igw-0007sU-AH for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:36:49 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843796e373so1357253f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790253400; x=1790858200; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F2tNs9L5NRbwNDkHgwaLC8DqtGUaFWTnSG3YvtUH644=;
 b=df76ju2Jm0hQBO8m1C89wFt2xjY1ySOWeZXIO7EF8J1/08E+d3Ii6mYoFlueFQ8LeZ
 coKRj1eeR1PbowA1LkI/orhjiqfi8qQ+sA0OoCGUZMOMEYSZl07dFDELAvyxhmKP2XvA
 n3dnE5ghVY/3BbjwZskt9tt/xjNkj2+zUZjuIQLBMSGJwcA14T00gbwd6VkUi4ommgt6
 DVJXKKC/HV8ZAaaefArEnovBWbsY0iFi6JywzgSM2HyZthPTVGXKjbem5KVeozh9Kwl3
 /nyoYHvxWHWdQX5ZmkzP9lJZK0885zZZPKB8r4rADxV97yG9hyqMDy3C961Rdq2qvFhV
 KAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790253400; x=1790858200;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F2tNs9L5NRbwNDkHgwaLC8DqtGUaFWTnSG3YvtUH644=;
 b=16mrOBMb3n3IyQkUtd9BGFZyMaUSlXiV7gs74uwMliOnLjY8PdU9sDEVODth6Uu4nX
 FDo7tlkokxCAfynPmYDRbozXbUBQKrUGZKyf3ab2JX0fmUqRXp1E6bFvppQZJw5UwYoI
 v6S7E52RCSNIU9ttDdlzeZylncHIHhIy2f7KZjfGObXddwgDaeiUPZ8DtNsmk/EmMomT
 yU6Y9RWRnffpBLg3uhVGPJAwV6HQXjbO128t+3dMpjDDpezTXZUeecAd81UhpRgyLJBN
 Y+fHUmSX0UklmF0DnZUuxNHkOiVYBXKncxENLtKLjVvOHTJQpLEy1JtPmlPkBYnBFze1
 Fe2g==
X-Gm-Message-State: AFuF++kzutDRSRAM4j3679miNlJXznpj6F3/jqyZvBLzyy/gGGeOqScG
 cfg6wCc7Sc9n+oS4kUqsJU03AAz4OohkETyvQySVqVj46k8ADDfLeBObP3wAH3oXxKliqjWJCSN
 w7926YvVE8CODvHUzh/6YB3k0kZsxxzok/e33c+qKtiJxUH/Xv9FiPmTcG9vefttbUO8w3jlqn+
 u81YQCHQ==
X-Gm-Gg: AYBFou0WHP1IvR5W2h0TcqV9mNHzbRhEivUwrrU0MIRpj2vIXzfiYpAvW83iQiP7GsC
 eEtm8oOrUFbxuZT79ryVmyN8or7qP+cmr01Zio/hEgkMhyX1b+XT+fl1HtXyuJR39STNaPOS1qW
 YWJKGyAy9Ce3wDQCa5jAW4wIrwyFAJrt5cwgp620fTMTOR2syARf8OFqDgZG4f4wUcO61nXioN1
 mzmkXqG8LmPde9p4fnajAQr5iMMUJVAZFxcWAnAjub0txyt4c9ZhUFjDcIm983zyI4GDJNssE03
 fh+JJKOh17d+z78mVsl+9VSCDp5+aazuPK58SX/Uzp4A98vlazMmOgbWabxgSgRh7CK4amficFx
 Z7nIcI88J+LP8Uf8Ux2bJI/5xrsOoa2z8mp1W7O564FmFkwrnbebw3NWGyft3gmsbEfr5nY1rMp
 QqM+zeYecbNwW8Q3RFqvcRo4Xw5/D2lPlUDTP3BoAZbgMN5+PdSm22M3VXcR/C4fRw7961TTBWE
 MEUpUnMdgITXAvdZscEdq1SvXqrssvhqA9RkRnJV6H6KWoT/aoWTIWhz1xvmhUk2oTZ5s241SpK
 o8DIvAmoFIpLm1q1iZVOrf52eJMIQK2LHWSErh5grZDPS5kjKMUK3uQpfaYfy0e9BG5QMB8=
X-Received: by 2002:a05:6000:299c:20b0:488:73c8:a847 with SMTP id
 ffacd0b85a97d-48873c8b8e2mr2018524f8f.37.1790253399128; 
 Thu, 24 Sep 2026 05:36:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889337sm14767446f8f.34.2026.09.24.05.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:36:38 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 12:36:37 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: b777402583b3385f7b9c68b189084eaa469d0740
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b7231e1a2f88f81c2695b52392131515c7fdcfbb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9igw-0007sU-AH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6393124856325867879=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6393124856325867879==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lDK1qnZ+7q8="; charset=UTF-8

--lDK1qnZ+7q8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new pa=
tch set (#9)=2E

The following approvals got outdated and were removed:
Cod=
e-Review+2 by flichtenheld

The change is no longer submittable: Code-Revie=
w and checks~ChecksSubmitRule are unsatisfied now=2E


Change subject: Chan=
ge most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change most ENABLE_DEBUG ifdefs to if=
ndef ENABLE_SMALL

Most of these are verbose logging or even enable logging=
 at high
verbosity level or just useful tools like --show-gateway=2E

We ha=
d --enabled-debug on by default forever, so these "debug"
logs are on by de=
fault=2E This patch instead moves them to
enable-small=2E

Since the verbos=
e logging is now always enabled
(apart from --enable-small), --enable-debug=
 now only covers true
debug options like gremlin=2E

Rename the configure o=
ption from --enable-debug to
--enable-developer-debug to ensure existing bu=
ild
script/maintainer do not enable this option
by default=2E

This patch a=
lso adds [SMALL] and [DEBUG] as identifier in the OpenVPN
version string mo=
re easily identify builds with this feature=2E

In addition both configure =
and openvpn itself will add a warning
about --enable-developer-debug to dis=
courage users and maintainers
from enabling this feature=2E

Remove dmsg ma=
cro from tapctl's error=2Eh since it does
not use that macro at all=2E

Cha=
nge-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
---
M CMakeLists=2Etxt
M =
Changes=2Emd
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M dev-tools/cppchec=
k-suppression
M dev-tools/openvpn-cppcheck-library=2Ecfg
M src/openvpn/comp=
stub=2Ec
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_lega=
cy=2Ec
M src/openvpn/error=2Eh
M src/openvpn/event=2Ec
M src/openvpn/forwar=
d=2Ec
M src/openvpn/mroute=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2E=
c
M src/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/openvpn=
=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/pack=
et_id=2Ec
M src/openvpn/plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/r=
eliable=2Ec
M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl=
/error=2Eh
27 files changed, 83 insertions(+), 57 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/9

diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644=

--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(EN=
ABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compil=
er warnings as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android b=
ut do not use actual cross compile/Android cmake to build for simple compil=
e checks on Linux")
+option(ENABLE_DEBUG "Enable building with debug" OFF)
=
 
 option(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" O=
N)
 set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown=
" CACHE STRING "Default location for the DNS up/down script")
diff --git a/=
Changes=2Emd b/Changes=2Emd
index 2684251=2E=2E5c3270b 100644
--- a/Changes=
=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,12 @@
   the characters mentioned abo=
ve were already escaped=2E However, the behavior of
   Mbed TLS is slightly=
 different from OpenSSL in that it also escapes "=3D"=2E
 
+## Maintainer-v=
isible changes
+
+- The configure-time option `--enable-debug` is no longer=
  available
+  and the verbose logging is now always included unless `--ena=
ble-small`
+  is enabled=2E
+
 # Overview of changes in 2=2E7
 
 ## New fea=
tures
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index =
c3bb5a5=2E=2Ec6c0a96 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=
=2Ecmake=2Ein
@@ -18,8 +18,8 @@
 /* Enable shared data channel offload */
 =
#cmakedefine ENABLE_DCO
 
-/* Enable debugging support (needed for verb>=3D=
4) */
-#define ENABLE_DEBUG 1
+/* Enable debugging support */
+#cmakedefine=
 ENABLE_DEBUG
 
 /* Enable internal fragmentation support */
 #define ENABL=
E_FRAGMENT 1
diff --git a/configure=2Eac b/configure=2Eac
index 469a475=2E=
=2E1fa0e63 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -130,10 +130=
,10 @@
 )
 
 AC_ARG_ENABLE(
-	[debug],
-	[AS_HELP_STRING([--disable-debug],=
 [disable debugging support (disable gremlin and verb 7+ messages) @<:@defa=
ult=3Dyes@:>@])],
-	,
-	[enable_debug=3D"yes"]
+	[developer-debug],
+	[AS_H=
ELP_STRING([--enable-developer-debug], [enable developer debugging support =
(enable gremlin) @<:@default=3Dno@:>@])],
+	[enable_debug=3D"yes"],
+	[enab=
le_debug=3D"no"]
 )
 
 AC_ARG_ENABLE(
@@ -1393,3 +1393,8 @@
 ])
 AC_CONFIG_=
FILES([tests/t_client=2Esh], [chmod +x tests/t_client=2Esh])
 AC_OUTPUT
+
+=
# Put the warning at the end, so it is better visible
+if test "${enable_de=
bug}" =3D "yes"; then
+    AC_MSG_WARN([--enable-developer-debug is enabled=
=2E This should be only used for test/development builds and not for produc=
tion usage])
+fi
\ No newline at end of file
diff --git a/dev-tools/cppchec=
k-suppression b/dev-tools/cppcheck-suppression
index 299d7a3=2E=2Eb505aef 1=
00644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppres=
sion
@@ -42,7 +42,7 @@
 intToPointerCast:src/openvpn/multi_io=2Ec
 intToPoi=
nterCast:src/openvpn/ps=2Ec
 # FP: constant but differs between platforms
-=
knownConditionTrueFalse:src/openvpn/error=2Eh:380
+knownConditionTrueFalse:=
src/openvpn/error=2Eh:382
 knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:8=
0
 knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64
 knownConditionTrueFal=
se:src/openvpn/platform=2Ec
diff --git a/dev-tools/openvpn-cppcheck-library=
=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg
index 1ea91f4=2E=2Edecac6=
7 100644
--- a/dev-tools/openvpn-cppcheck-library=2Ecfg
+++ b/dev-tools/ope=
nvpn-cppcheck-library=2Ecfg
@@ -26,4 +26,6 @@
   <!-- work around macro con=
fusion -->
   <define name=3D"CMSG_FIRSTHDR" value=3D"cmsg_firsthdr" />
   =
<define name=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
+  <!-- otherwise a l=
ot of unused variables are shown for enable-small builds -->
+  <define nam=
e=3D"DMSG_ALWAYS_AVAILABLE" value=3D"1" />
 </def>
diff --git a/src/openvpn=
/compstub=2Ec b/src/openvpn/compstub=2Ec
index f0c89f7=2E=2E2eef587 100644
=
--- a/src/openvpn/compstub=2Ec
+++ b/src/openvpn/compstub=2Ec
@@ -125,7 +12=
5,7 @@
         return;
     }
 
-    uint8_t *head =3D BPTR(buf);
+    con=
st uint8_t *head =3D BPTR(buf);
 
     /* no compression or packet to short=
*/
     if (head[0] !=3D COMP_ALGV2_INDICATOR_BYTE)
diff --git a/src/openvp=
n/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=2E=2E05=
bb60d 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_=
mbedtls=2Ec
@@ -842,8 +842,8 @@
     struct gc_arena gc =3D gc_new();
     =
uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the=
 D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENAB=
LE_SMALL
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL t=
o avoid unused
      * variables warnings if compiled with --enable-small *=
/
     const size_t olen_orig =3D olen;
     const uint8_t *out_orig =3D ou=
t;
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_=
mbedtls_legacy=2Ec
index bbd012f6=2E=2Ef46d8bf 100644
--- a/src/openvpn/cry=
pto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -989,=
8 +989,8 @@
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_=
KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, =
guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* use=
d by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
     =
 * variables warnings if compiled with --enable-small */
     const size_t =
olen_orig =3D olen;
     const uint8_t *out_orig =3D out;
diff --git a/src/=
openvpn/error=2Eh b/src/openvpn/error=2Eh
index a887fc7=2E=2E9f39572 100644=

--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -158,7 +158,9 @=
@
         }                                \
         EXIT_FATAL(flags);  =
             \
     } while (false)
-#ifdef ENABLE_DEBUG
+/* We have DMSG_A=
LWAYS_AVAILABLE here to able to silence unused warnings for
+ * cppcheck */=

+#if !defined(ENABLE_SMALL) || defined(DMSG_ALWAYS_AVAILABLE)
 #define dms=
g(flags, =2E=2E=2E)                 \
     do                              =
     \
     {                                    \
diff --git a/src/openvpn=
/event=2Ec b/src/openvpn/event=2Ec
index 8b7716a=2E=2E2cb4e04 100644
--- a/=
src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -398,7 +398,7 @@
 
   =
  dmsg(D_EVENT_WAIT, "WE_WAIT enter n=3D%d to=3D%d", wes->n_events, timeout=
);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(=
D_EVENT_WAIT))
     {
         int i;
diff --git a/src/openvpn/forward=2Ec =
b/src/openvpn/forward=2Ec
index 6fe5849=2E=2Ea8a4a07 100644
--- a/src/openv=
pn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -50,7 +50,7 @@
 
 /* show e=
vent wait debugging info */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
=
 static const char *
 wait_status_string(struct context *c, struct gc_arena=
 *gc)
@@ -75,7 +75,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEB=
UG */
+#endif
 
 static void
 check_tls_errors_co(struct context *c)
@@ -21=
90,7 +2190,7 @@
         {
             int status;
 
-#ifdef ENABLE_DEBUG
=
+#ifndef ENABLE_SMALL
             if (check_debug_level(D_EVENT_WAIT))
   =
          {
                 show_wait_status(c);
diff --git a/src/openvpn/=
mroute=2Ec b/src/openvpn/mroute=2Ec
index 39fa482=2E=2E261d25a 100644
--- a=
/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -501,7 +501,7 @@
  =
   }
     mh->n_net_len =3D j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL=

     if (check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena=
 gc =3D gc_new();
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
=
index 5d88f8a=2E=2Eb0125f1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/open=
vpn/mtcp=2Ec
@@ -74,7 +74,7 @@
         mi->did_real_hash =3D true;
     }
=
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (mi)
     {
         d=
msg(D_MULTI_DEBUG, "MULTI TCP: instance added: %s", mroute_addr_print(&mi->=
real, &gc));
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index=
 88b0091=2E=2E4794b7e 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/m=
udp=2Ec
@@ -431,7 +431,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifnd=
ef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
         =
struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/multi=2Ec b/src/o=
penvpn/multi=2Ec
index 3e72b92=2E=2E67204c3 100644
--- a/src/openvpn/multi=
=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1145,7 +1145,7 @@
         }
     }
 
=
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MUL=
TI_DEBUG))
     {
         struct gc_arena gc =3D gc_new();
diff --git a/sr=
c/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 3604684=2E=2E4b96c5=
7 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -=
46,7 +46,7 @@
 #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI=
_IO_DCO              ((void *)6)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMA=
LL
 static const char *
 pract(int action)
 {
@@ -89,7 +89,7 @@
           =
  return "?";
     }
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline=
 struct context *
 multi_get_context(struct multi_context *m, struct multi_=
instance *mi)
diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2E=
c
index 24d6bb6=2E=2Eacd366d 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src=
/openvpn/openvpn=2Ec
@@ -252,6 +252,8 @@
 #endif
             show_library_=
versions(M_INFO);
 
+            show_debug_warning(M_INFO);
+
            =
 show_dco_version(M_INFO);
 
             /* misc stuff */
diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2E3c5a249 1=
00644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -113,9=
 +113,16 @@
 #ifdef ENABLE_DCO
     " [DCO]"
 #endif
+#ifdef ENABLE_SMALL
+=
    " [SMALL]"
+#endif
+#ifdef ENABLE_DEBUG
+    " [DEBUG]"
+#endif
 #ifdef=
 CONFIGURE_GIT_REVISION
     " built on " __DATE__
 #endif
+
     ;
 
 #ifn=
def ENABLE_SMALL
@@ -785,7 +792,7 @@
 #endif /* ENABLE_PKCS11 */
     "\n"
=
     "General Standalone Options:\n"
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_S=
MALL
     "--show-gateway [address]: Show info about gateway [to v4/v6 addr=
ess]=2E\n"
 #endif
     ;
@@ -3534,6 +3541,9 @@
     msg(M_INFO | M_NOPREFI=
X, "special build: %s", CONFIGURE_SPECIAL_BUILD);
 #endif
 #endif
+
+    sh=
ow_debug_warning(M_INFO | M_NOPREFIX);
+
     openvpn_exit(OPENVPN_EXIT_STA=
TUS_GOOD);
 }
 
@@ -4229,7 +4239,7 @@
         read_config_file(options, p[=
1], level, file, line, msglevel, permission_mask,
                         =
 option_types_found, es);
     }
-#if defined(ENABLE_DEBUG) && !defined(ENA=
BLE_SMALL)
+#ifndef ENABLE_SMALL
     else if (streq(p[0], "show-gateway") =
&& !p[2])
     {
         struct route_gateway_info rgi;
@@ -4938,12 +4948,=
13 @@
              * mbed TLS always generating debug level logging */
   =
          options->ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;
         }
-#if !=
defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifdef ENABLE_SMALL
      =
   /* Warn when a debug verbosity is supplied when built without debug supp=
ort */
         if (options->verbosity >=3D 7)
         {
             msg(=
M_WARN,
-                "NOTE: debug verbosity (--verb %d) is enabled but =
this build lacks debug support=2E",
+                "NOTE: debug verbosity=
 (--verb %d) is enabled but this build is "
+                "built with --=
enable-small that lacks support for high --verb settings",
                =
 options->verbosity);
         }
 #endif
diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh
index f472676=2E=2Ee4fd3ca 100644
--- a/src/=
openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -888,6 +888,16 @@
 
 v=
oid show_library_versions(const unsigned int flags);
 
+static inline void
=
+show_debug_warning(const unsigned int flags)
+{
+#ifdef ENABLE_DEBUG
+    =
msg(flags, "Warning: OpenVPN has been compiled with --enable-developer-debu=
g=2E "
+               "This should be only used for test/development build=
s and not for "
+               "production usage");
+#endif
+}
+
 #ifdef _=
WIN32
 void show_windows_version(const unsigned int flags);
 
diff --git a/=
src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index a4b627c=2E=2E22=
c53c7 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2E=
c
@@ -52,18 +52,18 @@
 #define SEQ_UNSEEN  ((time_t)0)
 #define SEQ_EXPIRED=
 ((time_t)1)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void pack=
et_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,
       =
                            const struct packet_id_net *pin, const char *me=
ssage,
                                   packet_id_print_type value);
 
-#=
endif /* ENABLE_DEBUG */
+#endif
 
 static inline void
 packet_id_debug(msg=
lvl_t msglevel, const struct packet_id_rec *p,
                 const struc=
t packet_id_net *pin, const char *message, uint64_t value)
 {
-#ifdef ENABL=
E_DEBUG
+#ifndef ENABLE_SMALL
     if (unlikely(check_debug_level(msglevel)=
))
     {
         packet_id_debug_print(msglevel, p, pin, message, value);=

@@ -576,7 +576,7 @@
     return (char *)out=2Edata;
 }
 
-#ifdef ENABLE_DE=
BUG
+#ifndef ENABLE_SMALL
 
 static void
 packet_id_debug_print(msglvl_t ms=
glevel, const struct packet_id_rec *p,
@@ -648,7 +648,7 @@
     gc_free(&gc=
);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 
 uint16_t
 packet_id_rea=
d_epoch(struct packet_id_net *pin, struct buffer *buf)
diff --git a/src/ope=
nvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index f8adde5=2E=2Ea94f07b 100644
=
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,7 +993,7 =
@@
     pr->n =3D 0;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void
=
 plugin_return_print(const msglvl_t msglevel, const char *prefix, const str=
uct plugin_return *pr)
 {
@@ -1012,5 +1012,5 @@
         }
     }
 }
-#endi=
f /* ifdef ENABLE_DEBUG */
+#endif
 #endif /* ENABLE_PLUGIN */
diff --git a=
/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2E684632c=
 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,7=
 +135,7 @@
 
 void plugin_return_free(struct plugin_return *pr);
 
-#ifdef =
ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void plugin_return_print(const msglvl_t=
 msglevel, const char *prefix, const struct plugin_return *pr);
 
 #endif
d=
iff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index ced43=
8e=2E=2Eb5315ff 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/rel=
iable=2Ec
@@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENA=
BLE_SMALL
 /* print the current sequence of active packet IDs */
 static co=
nst char *
 reliable_print_ids(const struct reliable *rel, struct gc_arena =
*gc)
@@ -480,7 +480,7 @@
     }
     return BSTR(&out);
 }
-#endif /* ENABL=
E_DEBUG */
+#endif
 
 /* true if at least one free buffer available */
 boo=
l
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 03a2526=
=2E=2Ee8001b3 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2E=
c
@@ -81,7 +81,7 @@
 
 static void get_bypass_addresses(struct route_bypass=
 *rb, const unsigned int flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMA=
LL
 
 static void
 print_bypass_addresses(const struct route_bypass *rb)
@@=
 -617,7 +617,7 @@
     if (rl->ngi=2Eflags & RGI_ADDR_DEFINED)
     {
     =
    setenv_route_addr(es, "net_gateway", rl->ngi=2Egateway=2Eaddr, -1);
-#i=
f defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
   =
      print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
     }
@@ -66=
0,7 +660,7 @@
             add_block_local_routes(rl);
         }
         =
get_bypass_addresses(&rl->spec=2Ebypass, rl->flags);
-#ifdef ENABLE_DEBUG
+=
#ifndef ENABLE_SMALL
         print_bypass_addresses(&rl->spec=2Ebypass);
 =
#endif
     }
@@ -768,7 +768,7 @@
     if (rl6->ngi6=2Eflags & RGI_ADDR_DEF=
INED)
     {
         setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6=
->ngi6=2Egateway=2Eaddr_ipv6, 0, &gc));
-#if defined(ENABLE_DEBUG) && !defi=
ned(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_default_gateway(D_RO=
UTE, NULL, &rl6->rgi6);
 #endif
     }
diff --git a/src/openvpn/schedule=2E=
c b/src/openvpn/schedule=2Ec
index 6772ad6=2E=2E6c60dc2 100644
--- a/src/op=
envpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,7 +33,7 @@
 
 #inc=
lude "memdbg=2Eh"
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void=

 schedule_entry_debug_info(const char *caller, const struct schedule_entry=
 *e)
 {
@@ -308,7 +308,7 @@
 void
 schedule_add_modify(struct schedule *s, =
struct schedule_entry *e)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
   =
  if (check_debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_=
info("schedule_add_modify", e);
@@ -355,7 +355,7 @@
         }
     }
 
-#i=
fdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDU=
LER))
     {
         schedule_entry_debug_info("schedule_find_least", e);
=
diff --git a/src/tapctl/error=2Eh b/src/tapctl/error=2Eh
index f9586dc=2E=
=2E4424f56 100644
--- a/src/tapctl/error=2Eh
+++ b/src/tapctl/error=2Eh
@@ =
-83,19 +83,6 @@
         }                                \
         EXIT_F=
ATAL(flags);               \
     } while (false)
-#ifdef ENABLE_DEBUG
-#de=
fine dmsg(flags, =2E=2E=2E)                 \
-    do                      =
             \
-    {                                    \
-        if (msg=
_test(flags))             \
-        {                                \
-  =
          x_msg((flags), __VA_ARGS__); \
-        }                        =
        \
-        EXIT_FATAL(flags);               \
-    } while (false)
=
-#else
-#define dmsg(flags, =2E=2E=2E)
-#endif
 
 void x_msg(const unsigned=
 int flags, const char *format, =2E=2E=2E); /* should be called via msg abo=
ve */
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f96cd1c=
3488b558b8a597594d99edcba1214d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet=
: 9
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--lDK1qnZ+7q8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #9</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review+2 by flich=
tenheld</p><p>The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">Change most ENABLE_=
DEBUG ifdefs to ifndef ENABLE_SMALL<br><br>Most of these are verbose loggin=
g or even enable logging at high<br>verbosity level or just useful tools li=
ke --show-gateway=2E<br><br>We had --enabled-debug on by default forever, s=
o these &quot;debug&quot;<br>logs are on by default=2E This patch instead m=
oves them to<br>enable-small=2E<br><br>Since the verbose logging is now alw=
ays enabled<br>(apart from --enable-small), --enable-debug now only covers =
true<br>debug options like gremlin=2E<br><br>Rename the configure option fr=
om --enable-debug to<br>--enable-developer-debug to ensure existing build<b=
r>script/maintainer do not enable this option<br>by default=2E<br><br>This =
patch also adds [SMALL] and [DEBUG] as identifier in the OpenVPN<br>version=
 string more easily identify builds with this feature=2E<br><br>In addition=
 both configure and openvpn itself will add a warning<br>about --enable-dev=
eloper-debug to discourage users and maintainers<br>from enabling this feat=
ure=2E<br><br>Remove dmsg macro from tapctl&#39;s error=2Eh since it does<b=
r>not use that macro at all=2E<br><br>Change-Id: I3f96cd1c3488b558b8a597594=
d99edcba1214d27<br>---<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=
=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M dev-tools/cppcheck-suppression<b=
r>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M src/openvpn/compstub=2Ec<=
br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=
=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/event=2Ec<br>M src/openvpn=
/forward=2Ec<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src=
/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<=
br>M src/openvpn/openvpn=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/=
options=2Eh<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/plugin=2Ec<br>M=
 src/openvpn/plugin=2Eh<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/rout=
e=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/tapctl/error=2Eh<br>27 files c=
hanged, 83 insertions(+), 57 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/9</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6e=
b5954=2E=2Ed553697 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br>=
<span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -40,6 +40,7 @@</span><br><s=
pan> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-helper&quot; ON)</span><b=
r><span> option(USE_WERROR &quot;Treat compiler warnings as errors (-Werror=
)&quot; ON)</span><br><span> option(FAKE_ANDROID &quot;Target Android but d=
o not use actual cross compile/Android cmake to build for simple compile ch=
ecks on Linux&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+option(ENABLE_DEBUG &quot;Enable building with debug&quot; OFF)</span><br>=
<span> </span><br><span> option(ENABLE_DNS_UPDOWN_BY_DEFAULT &quot;Run --dn=
s-updown hook by default&quot; ON)</span><br><span> set(DNS_UPDOWN_PATH &qu=
ot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&quot; CACHE STRING &q=
uot;Default location for the DNS up/down script&quot;)</span><br><span>diff=
 --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 2684251=2E=2E5c3=
270b 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Change=
s=2Emd</span><br><span>@@ -23,6 +23,12 @@</span><br><span>   the characters=
 mentioned above were already escaped=2E However, the behavior of</span><br=
><span>   Mbed TLS is slightly different from OpenSSL in that it also escap=
es &quot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+## Maintainer-visible changes</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+- The configure-time option `--enable-debug` is no longer  avail=
able</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and the verbo=
se logging is now always included unless `--enable-small`</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  is enabled=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Overview of changes i=
n 2=2E7</span><br><span> </span><br><span> ## New features</span><br><span>=
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><s=
pan>index c3bb5a5=2E=2Ec6c0a96 100644</span><br><span>--- a/config=2Eh=2Ecm=
ake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -=
18,8 +18,8 @@</span><br><span> /* Enable shared data channel offload */</sp=
an><br><span> #cmakedefine ENABLE_DCO</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/* Enable debugging support (needed for v=
erb&gt;=3D4) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e ENABLE_DEBUG 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Enable debugging support */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#cmakedefine ENABLE_DEBUG</span><br><span> </span><br><span> /* Ena=
ble internal fragmentation support */</span><br><span> #define ENABLE_FRAGM=
ENT 1</span><br><span>diff --git a/configure=2Eac b/configure=2Eac</span><b=
r><span>index 469a475=2E=2E1fa0e63 100644</span><br><span>--- a/configure=
=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -130,10 +130,=
10 @@</span><br><span> )</span><br><span> </span><br><span> AC_ARG_ENABLE(<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[debug],</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	[AS_HELP_STRING([--disable-debug]=
, [disable debugging support (disable gremlin and verb 7+ messages) @&lt;:@=
default=3Dyes@:&gt;@])],</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[enable_debug=
=3D&quot;yes&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	[developer-debug],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	[AS_HELP_STRING([--enable-developer-debug], [enable developer debugging su=
pport (enable gremlin) @&lt;:@default=3Dno@:&gt;@])],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	[enable_debug=3D&quot;yes&quot;],</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	[enable_debug=3D&quot;no&=
quot;]</span><br><span> )</span><br><span> </span><br><span> AC_ARG_ENABLE(=
</span><br><span>@@ -1393,3 +1393,8 @@</span><br><span> ])</span><br><span>=
 AC_CONFIG_FILES([tests/t_client=2Esh], [chmod +x tests/t_client=2Esh])</sp=
an><br><span> AC_OUTPUT</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Put the warni=
ng at the end, so it is better visible</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if test &quot;${enable_debug}&quot; =3D &quot;yes&quot;;=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AC_MSG_WAR=
N([--enable-developer-debug is enabled=2E This should be only used for test=
/development builds and not for production usage])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+fi</span><br><span>\ No newline at end of fi=
le</span><br><span>diff --git a/dev-tools/cppcheck-suppression b/dev-tools/=
cppcheck-suppression</span><br><span>index 299d7a3=2E=2Eb505aef 100644</spa=
n><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-=
tools/cppcheck-suppression</span><br><span>@@ -42,7 +42,7 @@</span><br><spa=
n> intToPointerCast:src/openvpn/multi_io=2Ec</span><br><span> intToPointerC=
ast:src/openvpn/ps=2Ec</span><br><span> # FP: constant but differs between =
platforms</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditi=
onTrueFalse:src/openvpn/error=2Eh:380</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/error=2Eh:382</span><=
br><span> knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br><span=
> knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64</span><br><span> knownC=
onditionTrueFalse:src/openvpn/platform=2Ec</span><br><span>diff --git a/dev=
-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=
=2Ecfg</span><br><span>index 1ea91f4=2E=2Edecac67 100644</span><br><span>--=
- a/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>+++ b/dev-tool=
s/openvpn-cppcheck-library=2Ecfg</span><br><span>@@ -26,4 +26,6 @@</span><b=
r><span>   &lt;!-- work around macro confusion --&gt;</span><br><span>   &l=
t;define name=3D&quot;CMSG_FIRSTHDR&quot; value=3D&quot;cmsg_firsthdr&quot;=
 /&gt;</span><br><span>   &lt;define name=3D&quot;CMSG_NXTHDR&quot; value=
=3D&quot;cmsg_nxthdr&quot; /&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;!-- otherwise a lot of unused variables are shown for en=
able-small builds --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;define name=3D&quot;DMSG_ALWAYS_AVAILABLE&quot; value=3D&quot;1&=
quot; /&gt;</span><br><span> &lt;/def&gt;</span><br><span>diff --git a/src/=
openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec</span><br><span>index f0c89=
f7=2E=2E2eef587 100644</span><br><span>--- a/src/openvpn/compstub=2Ec</span=
><br><span>+++ b/src/openvpn/compstub=2Ec</span><br><span>@@ -125,7 +125,7 =
@@</span><br><span>         return;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =
=3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst uint8_t *head =3D BPTR(buf);</span><br><span> </span><br><span>     /*=
 no compression or packet to short*/</span><br><span>     if (head[0] !=3D =
COMP_ALGV2_INDICATOR_BYTE)</span><br><span>diff --git a/src/openvpn/crypto_=
mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 0c5beb4=
=2E=2E05bb60d 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</=
span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -842=
,8 +842,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURC=
E, guarded with ENABLE_DEBUG to avoid unused</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded wit=
h ENABLE_SMALL to avoid unused</span><br><span>      * variables warnings i=
f compiled with --enable-small */</span><br><span>     const size_t olen_or=
ig =3D olen;</span><br><span>     const uint8_t *out_orig =3D out;</span><b=
r><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/cr=
ypto_mbedtls_legacy=2Ec</span><br><span>index bbd012f6=2E=2Ef46d8bf 100644<=
/span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span=
>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -989,8 +989=
,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guar=
ded with ENABLE_DEBUG to avoid unused</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABL=
E_SMALL to avoid unused</span><br><span>      * variables warnings if compi=
led with --enable-small */</span><br><span>     const size_t olen_orig =3D =
olen;</span><br><span>     const uint8_t *out_orig =3D out;</span><br><span=
>diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span=
>index a887fc7=2E=2E9f39572 100644</span><br><span>--- a/src/openvpn/error=
=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -158,7 =
+158,9 @@</span><br><span>         }                                \</span=
><br><span>         EXIT_FATAL(flags);               \</span><br><span>    =
 } while (false)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* We=
 have DMSG_ALWAYS_AVAILABLE here to able to silence unused warnings for</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cppcheck */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ENABLE_SMALL) |=
| defined(DMSG_ALWAYS_AVAILABLE)</span><br><span> #define dmsg(flags, =2E=
=2E=2E)                 \</span><br><span>     do                          =
         \</span><br><span>     {                                    \</spa=
n><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec</spa=
n><br><span>index 8b7716a=2E=2E2cb4e04 100644</span><br><span>--- a/src/ope=
nvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><br><span>=
@@ -398,7 +398,7 @@</span><br><span> </span><br><span>     dmsg(D_EVENT_WAI=
T, &quot;WE_WAIT enter n=3D%d to=3D%d&quot;, wes-&gt;n_events, timeout);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SMALL</span><br><span>     if (check_debug_level(D_EVENT_WAIT))</s=
pan><br><span>     {</span><br><span>         int i;</span><br><span>diff -=
-git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>in=
dex 6fe5849=2E=2Ea8a4a07 100644</span><br><span>--- a/src/openvpn/forward=
=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -50,7=
 +50,7 @@</span><br><span> </span><br><span> /* show event wait debugging i=
nfo */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static const cha=
r *</span><br><span> wait_status_string(struct context *c, struct gc_arena =
*gc)</span><br><span>@@ -75,7 +75,7 @@</span><br><span>     gc_free(&amp;gc=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> sta=
tic void</span><br><span> check_tls_errors_co(struct context *c)</span><br>=
<span>@@ -2190,7 +2190,7 @@</span><br><span>         {</span><br><span>    =
         int status;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>             if (chec=
k_debug_level(D_EVENT_WAIT))</span><br><span>             {</span><br><span=
>                 show_wait_status(c);</span><br><span>diff --git a/src/ope=
nvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 39fa482=2E=
=2E261d25a 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><s=
pan>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -501,7 +501,7 @@</span>=
<br><span>     }</span><br><span>     mh-&gt;n_net_len =3D j;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEB=
UG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SM=
ALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br><s=
pan>     {</span><br><span>         struct gc_arena gc =3D gc_new();</span>=
<br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><b=
r><span>index 5d88f8a=2E=2Eb0125f1 100644</span><br><span>--- a/src/openvpn=
/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -74=
,7 +74,7 @@</span><br><span>         mi-&gt;did_real_hash =3D true;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (mi)</span><br><sp=
an>     {</span><br><span>         dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: ins=
tance added: %s&quot;, mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span=
><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><=
br><span>index 88b0091=2E=2E4794b7e 100644</span><br><span>--- a/src/openvp=
n/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -4=
31,7 +431,7 @@</span><br><span>         }</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE=
_SMALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br=
><span>     {</span><br><span>         struct gc_arena gc =3D gc_new();</sp=
an><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</sp=
an><br><span>index 3e72b92=2E=2E67204c3 100644</span><br><span>--- a/src/op=
envpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span=
>@@ -1145,7 +1145,7 @@</span><br><span>         }</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SMALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</=
span><br><span>     {</span><br><span>         struct gc_arena gc =3D gc_ne=
w();</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/mu=
lti_io=2Ec</span><br><span>index 3604684=2E=2E4b96c57 100644</span><br><spa=
n>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=
=2Ec</span><br><span>@@ -46,7 +46,7 @@</span><br><span> #define MULTI_IO_FI=
LE_CLOSE_WRITE ((void *)5)</span><br><span> #define MULTI_IO_DCO           =
   ((void *)6)</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static const char *</span>=
<br><span> pract(int action)</span><br><span> {</span><br><span>@@ -89,7 +8=
9,7 @@</span><br><span>             return &quot;?&quot;;</span><br><span> =
    }</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span> </span><br><span> static inline struct con=
text *</span><br><span> multi_get_context(struct multi_context *m, struct m=
ulti_instance *mi)</span><br><span>diff --git a/src/openvpn/openvpn=2Ec b/s=
rc/openvpn/openvpn=2Ec</span><br><span>index 24d6bb6=2E=2Eacd366d 100644</s=
pan><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openv=
pn/openvpn=2Ec</span><br><span>@@ -252,6 +252,8 @@</span><br><span> #endif<=
/span><br><span>             show_library_versions(M_INFO);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+            show_=
debug_warning(M_INFO);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>             show_dco_version(M_INFO);</span><br><span>=
 </span><br><span>             /* misc stuff */</span><br><span>diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index e=
3cd527=2E=2E3c5a249 100644</span><br><span>--- a/src/openvpn/options=2Ec</s=
pan><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -113,9 +113,=
16 @@</span><br><span> #ifdef ENABLE_DCO</span><br><span>     &quot; [DCO]&=
quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot; [SMALL]&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot; [DEBUG]&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> #ifdef CONFIGURE_GIT_REVISION</span><br><spa=
n>     &quot; built on &quot; __DATE__</span><br><span> #endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ;</span><b=
r><span> </span><br><span> #ifndef ENABLE_SMALL</span><br><span>@@ -785,7 +=
792,7 @@</span><br><span> #endif /* ENABLE_PKCS11 */</span><br><span>     &=
quot;\n&quot;</span><br><span>     &quot;General Standalone Options:\n&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL=
</span><br><span>     &quot;--show-gateway [address]: Show info about gatew=
ay [to v4/v6 address]=2E\n&quot;</span><br><span> #endif</span><br><span>  =
   ;</span><br><span>@@ -3534,6 +3541,9 @@</span><br><span>     msg(M_INFO =
| M_NOPREFIX, &quot;special build: %s&quot;, CONFIGURE_SPECIAL_BUILD);</spa=
n><br><span> #endif</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    show_debug_warning(M_INFO | M_NOPREFIX);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     openvpn_exit(OPENVPN_EX=
IT_STATUS_GOOD);</span><br><span> }</span><br><span> </span><br><span>@@ -4=
229,7 +4239,7 @@</span><br><span>         read_config_file(options, p[1], l=
evel, file, line, msglevel, permission_mask,</span><br><span>              =
            option_types_found, es);</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; =
!defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SMALL</span><br><span>     else if (streq(p[0], &quot;sho=
w-gateway&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        struct route_gateway_info rgi;</span><br><span>@@ -4938,12 +4948,13=
 @@</span><br><span>              * mbed TLS always generating debug level =
logging */</span><br><span>             options-&gt;ssl_flags |=3D SSLF_TLS=
_DEBUG_ENABLED;</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if !defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_=
SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE=
_SMALL</span><br><span>         /* Warn when a debug verbosity is supplied =
when built without debug support */</span><br><span>         if (options-&g=
t;verbosity &gt;=3D 7)</span><br><span>         {</span><br><span>         =
    msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          &quot;NOTE: debug verbosity (--verb %d) is enabled but this build=
 lacks debug support=2E&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                &quot;NOTE: debug verbosity (--verb %d) is enabl=
ed but this build is &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                &quot;built with --enable-small that lacks support =
for high --verb settings&quot;,</span><br><span>                 options-&g=
t;verbosity);</span><br><span>         }</span><br><span> #endif</span><br>=
<span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span>=
<br><span>index f472676=2E=2Ee4fd3ca 100644</span><br><span>--- a/src/openv=
pn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><spa=
n>@@ -888,6 +888,16 @@</span><br><span> </span><br><span> void show_library=
_versions(const unsigned int flags);</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+show_debug_warning(const unsigned int fla=
gs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(flags, &quot;Warning: Open=
VPN has been compiled with --enable-developer-debug=2E &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+               &quot;This should =
be only used for test/development builds and not for &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+               &quot;production usa=
ge&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><b=
r><span> void show_windows_version(const unsigned int flags);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/p=
acket_id=2Ec</span><br><span>index a4b627c=2E=2E22c53c7 100644</span><br><s=
pan>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/src/openvpn/packe=
t_id=2Ec</span><br><span>@@ -52,18 +52,18 @@</span><br><span> #define SEQ_U=
NSEEN  ((time_t)0)</span><br><span> #define SEQ_EXPIRED ((time_t)1)</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENA=
BLE_SMALL</span><br><span> static void packet_id_debug_print(msglvl_t msgle=
vel, const struct packet_id_rec *p,</span><br><span>                       =
            const struct packet_id_net *pin, const char *message,</span><br=
><span>                                   packet_id_print_type value);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> static inline void</span><br><span>=
 packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,</span><b=
r><span>                 const struct packet_id_net *pin, const char *messa=
ge, uint64_t value)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (unlikely(che=
ck_debug_level(msglevel)))</span><br><span>     {</span><br><span>         =
packet_id_debug_print(msglevel, p, pin, message, value);</span><br><span>@@=
 -576,7 +576,7 @@</span><br><span>     return (char *)out=2Edata;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static void</=
span><br><span> packet_id_debug_print(msglvl_t msglevel, const struct packe=
t_id_rec *p,</span><br><span>@@ -648,7 +648,7 @@</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br>=
<span> uint16_t</span><br><span> packet_id_read_epoch(struct packet_id_net =
*pin, struct buffer *buf)</span><br><span>diff --git a/src/openvpn/plugin=
=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index f8adde5=2E=2Ea94f07b 10=
0644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src=
/openvpn/plugin=2Ec</span><br><span>@@ -993,7 +993,7 @@</span><br><span>   =
  pr-&gt;n =3D 0;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> voi=
d</span><br><span> plugin_return_print(const msglvl_t msglevel, const char =
*prefix, const struct plugin_return *pr)</span><br><span> {</span><br><span=
>@@ -1012,5 +1012,5 @@</span><br><span>         }</span><br><span>     }</s=
pan><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> #endif /* ENABLE_PLUGIN */</span><br><span>d=
iff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><span=
>index 7e9faf3=2E=2E684632c 100644</span><br><span>--- a/src/openvpn/plugin=
=2Eh</span><br><span>+++ b/src/openvpn/plugin=2Eh</span><br><span>@@ -135,7=
 +135,7 @@</span><br><span> </span><br><span> void plugin_return_free(struc=
t plugin_return *pr);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> void plugin_return_=
print(const msglvl_t msglevel, const char *prefix, const struct plugin_retu=
rn *pr);</span><br><span> </span><br><span> #endif</span><br><span>diff --g=
it a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>in=
dex ced438e=2E=2Eb5315ff 100644</span><br><span>--- a/src/openvpn/reliable=
=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -462=
,7 +462,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</sp=
an><br><span> /* print the current sequence of active packet IDs */</span><=
br><span> static const char *</span><br><span> reliable_print_ids(const str=
uct reliable *rel, struct gc_arena *gc)</span><br><span>@@ -480,7 +480,7 @@=
</span><br><span>     }</span><br><span>     return BSTR(&amp;out);</span><=
br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span> </span><br><span> /* true if at least one free buffer a=
vailable */</span><br><span> bool</span><br><span>diff --git a/src/openvpn/=
route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 03a2526=2E=2Ee8001b=
3 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/=
src/openvpn/route=2Ec</span><br><span>@@ -81,7 +81,7 @@</span><br><span> </=
span><br><span> static void get_bypass_addresses(struct route_bypass *rb, c=
onst unsigned int flags);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><spa=
n> static void</span><br><span> print_bypass_addresses(const struct route_b=
ypass *rb)</span><br><span>@@ -617,7 +617,7 @@</span><br><span>     if (rl-=
&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><s=
pan>         setenv_route_addr(es, &quot;net_gateway&quot;, rl-&gt;ngi=2Ega=
teway=2Eaddr, -1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> =
        print_default_gateway(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><s=
pan> #endif</span><br><span>     }</span><br><span>@@ -660,7 +660,7 @@</spa=
n><br><span>             add_block_local_routes(rl);</span><br><span>      =
   }</span><br><span>         get_bypass_addresses(&amp;rl-&gt;spec=2Ebypas=
s, rl-&gt;flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>         print_bypass_addresses(&amp;rl-&g=
t;spec=2Ebypass);</span><br><span> #endif</span><br><span>     }</span><br>=
<span>@@ -768,7 +768,7 @@</span><br><span>     if (rl6-&gt;ngi6=2Eflags &am=
p; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span>         setenv=
_str(es, &quot;net_gateway_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6=2Egatewa=
y=2Eaddr_ipv6, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><=
br><span>         print_default_gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6);<=
/span><br><span> #endif</span><br><span>     }</span><br><span>diff --git a=
/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index =
6772ad6=2E=2E6c60dc2 100644</span><br><span>--- a/src/openvpn/schedule=2Ec<=
/span><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -33,7 +33=
,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SMALL</span><br><span> static void</span><br><span> schedule_entry=
_debug_info(const char *caller, const struct schedule_entry *e)</span><br><=
span> {</span><br><span>@@ -308,7 +308,7 @@</span><br><span> void</span><br=
><span> schedule_add_modify(struct schedule *s, struct schedule_entry *e)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))</=
span><br><span>     {</span><br><span>         schedule_entry_debug_info(&q=
uot;schedule_add_modify&quot;, e);</span><br><span>@@ -355,7 +355,7 @@</spa=
n><br><span>         }</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><s=
pan>     if (check_debug_level(D_SCHEDULER))</span><br><span>     {</span><=
br><span>         schedule_entry_debug_info(&quot;schedule_find_least&quot;=
, e);</span><br><span>diff --git a/src/tapctl/error=2Eh b/src/tapctl/error=
=2Eh</span><br><span>index f9586dc=2E=2E4424f56 100644</span><br><span>--- =
a/src/tapctl/error=2Eh</span><br><span>+++ b/src/tapctl/error=2Eh</span><br=
><span>@@ -83,19 +83,6 @@</span><br><span>         }                       =
         \</span><br><span>         EXIT_FATAL(flags);               \</spa=
n><br><span>     } while (false)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define dmsg(flags, =2E=2E=2E)                 \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    do                                 =
  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {             =
                       \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (msg_test(flags))             \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {                                \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            x_msg((flags), __V=
A_ARGS__); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
                                \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        EXIT_FATAL(flags);               \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    } while (false)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define dmsg(flags, =2E=2E=2E)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span> void x_m=
sg(const unsigned int flags, const char *format, =2E=2E=2E); /* should be c=
alled via msg above */</span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c348=
8b558b8a597594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </=
div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--lDK1qnZ+7q8=--


--===============6393124856325867879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6393124856325867879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6393124856325867879==--

