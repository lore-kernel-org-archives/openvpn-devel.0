Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F41C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U23ukpvrjbbePdNw1GHc42f8+K045f6ErtZ4XWo8Y0Q=; b=eCRkcd9m6U6UJ40AcMfRJVR1m6
	+CVQi11TpagDJBf5MBD35KBtKHDT2twPRq4p+fkVCtrY7IOV25nqORzFjvuIN2fKQRRduT2GwLvec
	BLIFMS8Vwb9OqD5q5xKWTlU+8CW/W5Oa9ZV42pOxf7506l0ArsYhG+vNgZ+d7UkL9HVM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9PFE-00015f-F4;
	Wed, 23 Sep 2026 15:50:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9PFD-00015Z-93
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZL1mDvivPhfT7/0XuWt5xsX9IlOkLPZkOeD5VbvYHJg=; b=kR5g0NBXT5PYcymaJNkVWkCQsk
 HfXdw+ys8/r4pg8ffBhTZzm+aTVYlzZF29IA71RmetSzvsNDFNtQMMgsX0yLmuHNxzV3u6VMYBSQc
 ygs/05VCQcZ3ZZ44Tiumk9inVHyLA/S4j3zbsvJVemXKOhjdSxOztWOZX2PC84MyPRRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZL1mDvivPhfT7/0XuWt5xsX9IlOkLPZkOeD5VbvYHJg=; b=e
 v2TYGOg3y/Nf5ERJ2VuwZrtdVJrfEdYFF3KsNOsdX7OS0fCkrR9qJ2fgdj6gswL1rWa18a71b0GuK
 eEQhHu2IkjRr/WVVIOGuxHxNR0v1IRn88/YOTev7TY46uw17MZUJ9NURGXlthbIVNZ62+Og0SW9rE
 1B6owEDpOxHOlYo8=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9PFB-00043x-Eo for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:50:51 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so705038f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790178643; x=1790783443; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZL1mDvivPhfT7/0XuWt5xsX9IlOkLPZkOeD5VbvYHJg=;
 b=JGw+Blr87HVa9VN+gKu+usPFMVUWwfvecBcnEmcD2GGjYCzcrGD12L43q39ShOCqju
 KhJxG7zFb75Us3BaTvqtbFQ44eexXwpNnELSTMkB5Nhq0O0rhzdIdsSNpfzl6a2GEcuc
 aeLrQPWZnQbqiMYkHn2ckGJXrnbcbV/IUDD8TB9gI6Xzwck6c2vJ7TfVMvyrCI2C86ZP
 O0kRiL8r4SWwOMxwugW109wip1uspfNuZOmivGrI6K3TgsuHkpwzwjC4xNM0+7yCciuU
 zMTXXbRlzW5hvZOyjQ8DN93WnQarLovKyGqtj7jp9j4r0FuytrsPJITQ8dDIWfQpsBgm
 sOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178643; x=1790783443;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZL1mDvivPhfT7/0XuWt5xsX9IlOkLPZkOeD5VbvYHJg=;
 b=zI5320NfLHOTn7PXgSgyiNHW+QLhmOMRQE/Oa984+zQ/4rCh2NUFRe1Kx0wkhOQXlP
 v35MFnX9400/Dui+py6DPl6mSxwxlrausMXpDZxB1fOrGa6LjpXLWWoLLsCEEGc1wzW9
 4q/RUfTxWFbX4jmzxvfdAE4/ZkGYp6M5OdSjdtpWRdMsGuZaNk5DFjjT6NdrkZvm2UYt
 NxnlyQZyn1nbxtGwJfb4E6wsBfEoUcyfH1iGjxyCCHdl4Ch0RTRS8PopPoEBa104wCzu
 VRTduU0xf59iFUj+0XzJgtjYEvk502b9QCN1X3f9rqjvZ5sjemDPhynnTLiD68jAV8mU
 wdlQ==
X-Gm-Message-State: AFuF++kIzkbCqsi+yLqQ9RmOfDnH6dJsx7PfRFqdimjvTqsbaYCGcq+C
 mdogVmwfG8xtL/cS9si+pwZ3u1dnT+mGnRVVXp8i/oxeuIGnUJXdC/UEsAWYc0YRVUAsEBECr1Y
 wRdpD7v8kPEQlNEP99JS+Xk5B17Oy4A1g4bBr1h78M682f5R2ASNjAo5AGk5lu+MsNNJ3qRL3B+
 ADQn0DBQ==
X-Gm-Gg: AYBFou1XdY8AUcYbxm4i5iWsKvqbEm0p8NH+A73e13HoUaNP11itgJOjaULpHBwv+sQ
 DSRM9gSSFmFFLCUiAdTdNZ17+lQ8NGjHLWciwMzzIrXSRaRC3CfTW9EpeZYobje+HJvUyDdFxTY
 Cnx0UT8XMIAAxcniu4caMjrYjUrPmAnlqYfcKaNCviOYsHfGNpC3NVJZD7UXSzvbruIlCp2DwAc
 nHZxkbNDt6wjIgVoURJcpO8P7r8HG7TOi4WhQ6pHmkPkyRC71Siw6AWElZOhj3z7CC6g6R3ALhH
 W7ChZhXXwgOLyjhewgWG1ZyGirPx3iLIaPSFhHmTDOKyqv4Iy6SBSC7F0E36z8Cn+yl1TFSBPTZ
 R6vm6itb0KUTRpho93jchgaLMG2gdcAkVans+qR59pK1bApi5yn+bzZuW3y/zhZE5GlK6O46RbB
 QEzm+lm5Z3QDaVdjGgiK2clU7ua4LFbCoMuPwVBmWRzwhf4kypxUe0H/dChlevCwWHGfG6Ae26w
 uA0xgQTv5oJF60idvP41RKMAFqo2pFHiuCq3U49/gR0Qigo8/7Rn2dvisbrFDCkEsmXHsHXnWDa
 CAWxC+tke10L1tEZzhnm9FPwGtGa3NBpn8gg2RHv6G3iec10+SH7Lm1azxuORq2iRxoasoM=
X-Received: by 2002:a05:6000:2001:b0:486:e920:6726 with SMTP id
 ffacd0b85a97d-488670c5272mr5543158f8f.51.1790178642448; 
 Wed, 23 Sep 2026 08:50:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889130sm7608069f8f.37.2026.09.23.08.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:50:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 15:50:39 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 61ec725bc26e80622b42f983253dda74bcffa763
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e4ee5c0959e7d71a20121e03c873f723a6fc519-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9PFB-00043x-Eo
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
Content-Type: multipart/mixed; boundary="===============5491748335080589652=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5491748335080589652==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bEpoIOLvy7w="; charset=UTF-8

--bEpoIOLvy7w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new pa=
tch set (#8)=2E


Change subject: Change most ENABLE_DEBUG ifdefs to ifndef=
 ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

Most of these are=
 verbose logging or even enable logging at high
verbosity level or just use=
ful tools like --show-gateway=2E

We had --enabled-debug on by default fore=
ver, so these "debug"
logs are on by default=2E This patch instead moves th=
em to
enable-small=2E

Since the verbose logging is now always enabled
(apa=
rt from --enable-small), --enable-debug now only covers true
debug options =
like gremlin=2E

Rename the configure option from --enable-debug to
--enabl=
e-developer-debug to ensure existing build
script/maintainer do not enable =
this option
by default=2E

Remove dmsg macro from tapctl's error=2Eh since =
it does
not use that macro at all=2E

Change-Id: I3f96cd1c3488b558b8a597594=
d99edcba1214d27
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=2Eh=2Ecmake=
=2Ein
M configure=2Eac
M dev-tools/cppcheck-suppression
M dev-tools/openvpn=
-cppcheck-library=2Ecfg
M src/openvpn/compstub=2Ec
M src/openvpn/crypto_mbe=
dtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/error=2Eh
M =
src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/mroute=2Ec
M =
src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/o=
penvpn/multi_io=2Ec
M src/openvpn/options=2Ec
M src/openvpn/packet_id=2Ec
M=
 src/openvpn/plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/reliable=2Ec=

M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl/error=2Eh
=
25 files changed, 54 insertions(+), 55 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/8

diff --git a/CMake=
Lists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
--- a/CMak=
eLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11=
 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings=
 as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not u=
se actual cross compile/Android cmake to build for simple compile checks on=
 Linux")
+option(ENABLE_DEBUG "Enable building with debug" OFF)
 
 option(E=
NABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS=
_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STR=
ING "Default location for the DNS up/down script")
diff --git a/Changes=2Em=
d b/Changes=2Emd
index 2684251=2E=2E5c3270b 100644
--- a/Changes=2Emd
+++ b=
/Changes=2Emd
@@ -23,6 +23,12 @@
   the characters mentioned above were alr=
eady escaped=2E However, the behavior of
   Mbed TLS is slightly different =
from OpenSSL in that it also escapes "=3D"=2E
 
+## Maintainer-visible chan=
ges
+
+- The configure-time option `--enable-debug` is no longer  available=

+  and the verbose logging is now always included unless `--enable-small`
=
+  is enabled=2E
+
 # Overview of changes in 2=2E7
 
 ## New features
diff =
--git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=
=2Ec6c0a96 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2E=
in
@@ -18,8 +18,8 @@
 /* Enable shared data channel offload */
 #cmakedefin=
e ENABLE_DCO
 
-/* Enable debugging support (needed for verb>=3D4) */
-#def=
ine ENABLE_DEBUG 1
+/* Enable debugging support */
+#cmakedefine ENABLE_DEB=
UG
 
 /* Enable internal fragmentation support */
 #define ENABLE_FRAGMENT =
1
diff --git a/configure=2Eac b/configure=2Eac
index 469a475=2E=2E4226515 1=
00644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -131,9 +131,9 @@
 
 AC_A=
RG_ENABLE(
 	[debug],
-	[AS_HELP_STRING([--disable-debug], [disable debuggi=
ng support (disable gremlin and verb 7+ messages) @<:@default=3Dyes@:>@])],=

+	[AS_HELP_STRING([--enable-developer-debug], [enable developer debugging =
support (enable gremlin) @<:@default=3Dno@:>@])],
 	,
-	[enable_debug=3D"ye=
s"]
+	[enable_debug=3D"no"]
 )
 
 AC_ARG_ENABLE(
diff --git a/dev-tools/cpp=
check-suppression b/dev-tools/cppcheck-suppression
index 299d7a3=2E=2Eb505a=
ef 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-sup=
pression
@@ -42,7 +42,7 @@
 intToPointerCast:src/openvpn/multi_io=2Ec
 intT=
oPointerCast:src/openvpn/ps=2Ec
 # FP: constant but differs between platfor=
ms
-knownConditionTrueFalse:src/openvpn/error=2Eh:380
+knownConditionTrueFa=
lse:src/openvpn/error=2Eh:382
 knownConditionTrueFalse:src/openvpn/fdmisc=
=2Ec:80
 knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64
 knownConditionT=
rueFalse:src/openvpn/platform=2Ec
diff --git a/dev-tools/openvpn-cppcheck-l=
ibrary=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg
index 1ea91f4=2E=2E=
decac67 100644
--- a/dev-tools/openvpn-cppcheck-library=2Ecfg
+++ b/dev-too=
ls/openvpn-cppcheck-library=2Ecfg
@@ -26,4 +26,6 @@
   <!-- work around mac=
ro confusion -->
   <define name=3D"CMSG_FIRSTHDR" value=3D"cmsg_firsthdr" =
/>
   <define name=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
+  <!-- otherwi=
se a lot of unused variables are shown for enable-small builds -->
+  <defi=
ne name=3D"DMSG_ALWAYS_AVAILABLE" value=3D"1" />
 </def>
diff --git a/src/o=
penvpn/compstub=2Ec b/src/openvpn/compstub=2Ec
index f0c89f7=2E=2E2eef587 1=
00644
--- a/src/openvpn/compstub=2Ec
+++ b/src/openvpn/compstub=2Ec
@@ -125=
,7 +125,7 @@
         return;
     }
 
-    uint8_t *head =3D BPTR(buf);
+ =
   const uint8_t *head =3D BPTR(buf);
 
     /* no compression or packet to=
 short*/
     if (head[0] !=3D COMP_ALGV2_INDICATOR_BYTE)
diff --git a/src/=
openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=
=2E=2E05bb60d 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn=
/crypto_mbedtls=2Ec
@@ -842,8 +842,8 @@
     struct gc_arena gc =3D gc_new(=
);
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* use=
d by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifn=
def ENABLE_SMALL
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE=
_SMALL to avoid unused
      * variables warnings if compiled with --enable=
-small */
     const size_t olen_orig =3D olen;
     const uint8_t *out_ori=
g =3D out;
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn=
/crypto_mbedtls_legacy=2Ec
index bbd012f6=2E=2Ef46d8bf 100644
--- a/src/ope=
nvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
=
@@ -989,8 +989,8 @@
     struct gc_arena gc =3D gc_new();
     uint8_t A1[M=
AX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_=
SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+  =
  /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unus=
ed
      * variables warnings if compiled with --enable-small */
     const=
 size_t olen_orig =3D olen;
     const uint8_t *out_orig =3D out;
diff --gi=
t a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index a887fc7=2E=2E9f3957=
2 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -158,7 =
+158,9 @@
         }                                \
         EXIT_FATAL(f=
lags);               \
     } while (false)
-#ifdef ENABLE_DEBUG
+/* We hav=
e DMSG_ALWAYS_AVAILABLE here to able to silence unused warnings for
+ * cpp=
check */
+#if !defined(ENABLE_SMALL) || defined(DMSG_ALWAYS_AVAILABLE)
 #de=
fine dmsg(flags, =2E=2E=2E)                 \
     do                      =
             \
     {                                    \
diff --git a/src=
/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 8b7716a=2E=2E2cb4e04 10064=
4
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -398,7 +398,7 =
@@
 
     dmsg(D_EVENT_WAIT, "WE_WAIT enter n=3D%d to=3D%d", wes->n_events,=
 timeout);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debu=
g_level(D_EVENT_WAIT))
     {
         int i;
diff --git a/src/openvpn/forw=
ard=2Ec b/src/openvpn/forward=2Ec
index 6fe5849=2E=2Ea8a4a07 100644
--- a/s=
rc/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -50,7 +50,7 @@
 
 /=
* show event wait debugging info */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_=
SMALL
 
 static const char *
 wait_status_string(struct context *c, struct =
gc_arena *gc)
@@ -75,7 +75,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef EN=
ABLE_DEBUG */
+#endif
 
 static void
 check_tls_errors_co(struct context *c=
)
@@ -2190,7 +2190,7 @@
         {
             int status;
 
-#ifdef ENABL=
E_DEBUG
+#ifndef ENABLE_SMALL
             if (check_debug_level(D_EVENT_WA=
IT))
             {
                 show_wait_status(c);
diff --git a/src/=
openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 39fa482=2E=2E261d25a 1006=
44
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -501,7 +501=
,7 @@
     }
     mh->n_net_len =3D j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENAB=
LE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
         struct =
gc_arena gc =3D gc_new();
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/m=
tcp=2Ec
index 5d88f8a=2E=2Eb0125f1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/=
src/openvpn/mtcp=2Ec
@@ -74,7 +74,7 @@
         mi->did_real_hash =3D true;=

     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (mi)
     {
  =
       dmsg(D_MULTI_DEBUG, "MULTI TCP: instance added: %s", mroute_addr_pri=
nt(&mi->real, &gc));
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec
index 88b0091=2E=2E4794b7e 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src=
/openvpn/mudp=2Ec
@@ -431,7 +431,7 @@
         }
     }
 
-#ifdef ENABLE_DE=
BUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {=

         struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=2E=2E67204c3 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1145,7 +1145,7 @@
         =
}
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_=
level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new();
diff=
 --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 3604684=
=2E=2E4b96c57 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi=
_io=2Ec
@@ -46,7 +46,7 @@
 #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #=
define MULTI_IO_DCO              ((void *)6)
 
-#ifdef ENABLE_DEBUG
+#ifnde=
f ENABLE_SMALL
 static const char *
 pract(int action)
 {
@@ -89,7 +89,7 @@=

             return "?";
     }
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 s=
tatic inline struct context *
 multi_get_context(struct multi_context *m, s=
truct multi_instance *mi)
diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec
index e3cd527=2E=2Ed53c2c5 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -785,7 +785,7 @@
 #endif /* ENABLE_PK=
CS11 */
     "\n"
     "General Standalone Options:\n"
-#ifdef ENABLE_DEBUG=

+#ifndef ENABLE_SMALL
     "--show-gateway [address]: Show info about gate=
way [to v4/v6 address]=2E\n"
 #endif
     ;
@@ -4229,7 +4229,7 @@
         =
read_config_file(options, p[1], level, file, line, msglevel, permission_mas=
k,
                          option_types_found, es);
     }
-#if defined(E=
NABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
     else if (=
streq(p[0], "show-gateway") && !p[2])
     {
         struct route_gateway_=
info rgi;
@@ -4938,12 +4938,13 @@
              * mbed TLS always generatin=
g debug level logging */
             options->ssl_flags |=3D SSLF_TLS_DEBU=
G_ENABLED;
         }
-#if !defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)=

+#ifdef ENABLE_SMALL
         /* Warn when a debug verbosity is supplied w=
hen built without debug support */
         if (options->verbosity >=3D 7)
=
         {
             msg(M_WARN,
-                "NOTE: debug verbosity=
 (--verb %d) is enabled but this build lacks debug support=2E",
+          =
      "NOTE: debug verbosity (--verb %d) is enabled but this build is "
+  =
              "built with --enable-small that lacks support for high --verb=
 settings",
                 options->verbosity);
         }
 #endif
diff -=
-git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index a4b627c=
=2E=2E22c53c7 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/pack=
et_id=2Ec
@@ -52,18 +52,18 @@
 #define SEQ_UNSEEN  ((time_t)0)
 #define SEQ=
_EXPIRED ((time_t)1)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static v=
oid packet_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,=

                                   const struct packet_id_net *pin, const =
char *message,
                                   packet_id_print_type valu=
e);
 
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline void
 packet_id_d=
ebug(msglvl_t msglevel, const struct packet_id_rec *p,
                 con=
st struct packet_id_net *pin, const char *message, uint64_t value)
 {
-#ifd=
ef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (unlikely(check_debug_level(m=
sglevel)))
     {
         packet_id_debug_print(msglevel, p, pin, message,=
 value);
@@ -576,7 +576,7 @@
     return (char *)out=2Edata;
 }
 
-#ifdef E=
NABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 packet_id_debug_print(msg=
lvl_t msglevel, const struct packet_id_rec *p,
@@ -648,7 +648,7 @@
     gc_=
free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 
 uint16_t
 packe=
t_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)
diff --git a=
/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index f8adde5=2E=2Ea94f07b=
 100644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,7=
 +993,7 @@
     pr->n =3D 0;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMAL=
L
 void
 plugin_return_print(const msglvl_t msglevel, const char *prefix, c=
onst struct plugin_return *pr)
 {
@@ -1012,5 +1012,5 @@
         }
     }
 =
}
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 #endif /* ENABLE_PLUGIN */
diff=
 --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=
=2E684632c 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh=

@@ -135,7 +135,7 @@
 
 void plugin_return_free(struct plugin_return *pr);
=
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void plugin_return_print(cons=
t msglvl_t msglevel, const char *prefix, const struct plugin_return *pr);
 =

 #endif
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
i=
ndex ced438e=2E=2Eb5315ff 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/o=
penvpn/reliable=2Ec
@@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#=
ifndef ENABLE_SMALL
 /* print the current sequence of active packet IDs */
=
 static const char *
 reliable_print_ids(const struct reliable *rel, struct=
 gc_arena *gc)
@@ -480,7 +480,7 @@
     }
     return BSTR(&out);
 }
-#endi=
f /* ENABLE_DEBUG */
+#endif
 
 /* true if at least one free buffer availab=
le */
 bool
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
inde=
x 03a2526=2E=2Ee8001b3 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn=
/route=2Ec
@@ -81,7 +81,7 @@
 
 static void get_bypass_addresses(struct rou=
te_bypass *rb, const unsigned int flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef E=
NABLE_SMALL
 
 static void
 print_bypass_addresses(const struct route_bypas=
s *rb)
@@ -617,7 +617,7 @@
     if (rl->ngi=2Eflags & RGI_ADDR_DEFINED)
   =
  {
         setenv_route_addr(es, "net_gateway", rl->ngi=2Egateway=2Eaddr,=
 -1);
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_=
SMALL
         print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
    =
 }
@@ -660,7 +660,7 @@
             add_block_local_routes(rl);
         }
=
         get_bypass_addresses(&rl->spec=2Ebypass, rl->flags);
-#ifdef ENABL=
E_DEBUG
+#ifndef ENABLE_SMALL
         print_bypass_addresses(&rl->spec=2Eb=
ypass);
 #endif
     }
@@ -768,7 +768,7 @@
     if (rl6->ngi6=2Eflags & RGI=
_ADDR_DEFINED)
     {
         setenv_str(es, "net_gateway_ipv6", print_in6=
_addr(rl6->ngi6=2Egateway=2Eaddr_ipv6, 0, &gc));
-#if defined(ENABLE_DEBUG)=
 && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_default_gat=
eway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
     }
diff --git a/src/openvpn/sc=
hedule=2Ec b/src/openvpn/schedule=2Ec
index 6772ad6=2E=2E6c60dc2 100644
---=
 a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,7 +33,7 @=
@
 
 #include "memdbg=2Eh"
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 st=
atic void
 schedule_entry_debug_info(const char *caller, const struct sched=
ule_entry *e)
 {
@@ -308,7 +308,7 @@
 void
 schedule_add_modify(struct sche=
dule *s, struct schedule_entry *e)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_=
SMALL
     if (check_debug_level(D_SCHEDULER))
     {
         schedule_ent=
ry_debug_info("schedule_add_modify", e);
@@ -355,7 +355,7 @@
         }
   =
  }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level=
(D_SCHEDULER))
     {
         schedule_entry_debug_info("schedule_find_lea=
st", e);
diff --git a/src/tapctl/error=2Eh b/src/tapctl/error=2Eh
index f95=
86dc=2E=2E4424f56 100644
--- a/src/tapctl/error=2Eh
+++ b/src/tapctl/error=
=2Eh
@@ -83,19 +83,6 @@
         }                                \
       =
  EXIT_FATAL(flags);               \
     } while (false)
-#ifdef ENABLE_DE=
BUG
-#define dmsg(flags, =2E=2E=2E)                 \
-    do              =
                     \
-    {                                    \
-       =
 if (msg_test(flags))             \
-        {                             =
   \
-            x_msg((flags), __VA_ARGS__); \
-        }                =
                \
-        EXIT_FATAL(flags);               \
-    } while =
(false)
-#else
-#define dmsg(flags, =2E=2E=2E)
-#endif
 
 void x_msg(const =
unsigned int flags, const char *format, =2E=2E=2E); /* should be called via=
 msg above */
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1942?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Change-Number: 1942
Gerrit-=
PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom=
>

--bEpoIOLvy7w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #8</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL<br><br>Most=
 of these are verbose logging or even enable logging at high<br>verbosity l=
evel or just useful tools like --show-gateway=2E<br><br>We had --enabled-de=
bug on by default forever, so these &quot;debug&quot;<br>logs are on by def=
ault=2E This patch instead moves them to<br>enable-small=2E<br><br>Since th=
e verbose logging is now always enabled<br>(apart from --enable-small), --e=
nable-debug now only covers true<br>debug options like gremlin=2E<br><br>Re=
name the configure option from --enable-debug to<br>--enable-developer-debu=
g to ensure existing build<br>script/maintainer do not enable this option<b=
r>by default=2E<br><br>Remove dmsg macro from tapctl&#39;s error=2Eh since =
it does<br>not use that macro at all=2E<br><br>Change-Id: I3f96cd1c3488b558=
b8a597594d99edcba1214d27<br>---<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>=
M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M dev-tools/cppcheck-suppr=
ession<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M src/openvpn/comps=
tub=2Ec<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls=
_legacy=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/event=2Ec<br>M src/=
openvpn/forward=2Ec<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mtcp=2Ec<b=
r>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_=
io=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src=
/openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M src/openvpn/reliable=
=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/tapc=
tl/error=2Eh<br>25 files changed, 54 insertions(+), 55 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/42/1942/8</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etx=
t</span><br><span>index 6eb5954=2E=2Ed553697 100644</span><br><span>--- a/C=
MakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -=
40,6 +40,7 @@</span><br><span> option(ENABLE_PKCS11 &quot;BUILD with pkcs11=
-helper&quot; ON)</span><br><span> option(USE_WERROR &quot;Treat compiler w=
arnings as errors (-Werror)&quot; ON)</span><br><span> option(FAKE_ANDROID =
&quot;Target Android but do not use actual cross compile/Android cmake to b=
uild for simple compile checks on Linux&quot;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+option(ENABLE_DEBUG &quot;Enable building with d=
ebug&quot; OFF)</span><br><span> </span><br><span> option(ENABLE_DNS_UPDOWN=
_BY_DEFAULT &quot;Run --dns-updown hook by default&quot; ON)</span><br><spa=
n> set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-up=
down&quot; CACHE STRING &quot;Default location for the DNS up/down script&q=
uot;)</span><br><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><s=
pan>index 2684251=2E=2E5c3270b 100644</span><br><span>--- a/Changes=2Emd</s=
pan><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,12 @@</span><=
br><span>   the characters mentioned above were already escaped=2E However,=
 the behavior of</span><br><span>   Mbed TLS is slightly different from Ope=
nSSL in that it also escapes &quot;=3D&quot;=2E</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+## Maintainer-visible changes=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+- The configure-time option `--enable-=
debug` is no longer  available</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  and the verbose logging is now always included unless `--enabl=
e-small`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is enable=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> # Overview of changes in 2=2E7</span><br><span> </span><br><span> ## New=
 features</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=
=2Ecmake=2Ein</span><br><span>index c3bb5a5=2E=2Ec6c0a96 100644</span><br><=
span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=
=2Ein</span><br><span>@@ -18,8 +18,8 @@</span><br><span> /* Enable shared d=
ata channel offload */</span><br><span> #cmakedefine ENABLE_DCO</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Enable debug=
ging support (needed for verb&gt;=3D4) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define ENABLE_DEBUG 1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Enable debugging support */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_DEBUG</span><br><span=
> </span><br><span> /* Enable internal fragmentation support */</span><br><=
span> #define ENABLE_FRAGMENT 1</span><br><span>diff --git a/configure=2Eac=
 b/configure=2Eac</span><br><span>index 469a475=2E=2E4226515 100644</span><=
br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><b=
r><span>@@ -131,9 +131,9 @@</span><br><span> </span><br><span> AC_ARG_ENABL=
E(</span><br><span> 	[debug],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	[AS_HELP_STRING([--disable-debug], [disable debugging support (dis=
able gremlin and verb 7+ messages) @&lt;:@default=3Dyes@:&gt;@])],</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--enable-d=
eveloper-debug], [enable developer debugging support (enable gremlin) @&lt;=
:@default=3Dno@:&gt;@])],</span><br><span> 	,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	[enable_debug=3D&quot;yes&quot;]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	[enable_debug=3D&quot;no&quot;]</spa=
n><br><span> )</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br>=
<span>diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-supp=
ression</span><br><span>index 299d7a3=2E=2Eb505aef 100644</span><br><span>-=
-- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-tools/cppchec=
k-suppression</span><br><span>@@ -42,7 +42,7 @@</span><br><span> intToPoint=
erCast:src/openvpn/multi_io=2Ec</span><br><span> intToPointerCast:src/openv=
pn/ps=2Ec</span><br><span> # FP: constant but differs between platforms</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:s=
rc/openvpn/error=2Eh:380</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+knownConditionTrueFalse:src/openvpn/error=2Eh:382</span><br><span> kno=
wnConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br><span> knownCondit=
ionTrueFalse:src/openvpn/lladdr=2Ec:64</span><br><span> knownConditionTrueF=
alse:src/openvpn/platform=2Ec</span><br><span>diff --git a/dev-tools/openvp=
n-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><=
br><span>index 1ea91f4=2E=2Edecac67 100644</span><br><span>--- a/dev-tools/=
openvpn-cppcheck-library=2Ecfg</span><br><span>+++ b/dev-tools/openvpn-cppc=
heck-library=2Ecfg</span><br><span>@@ -26,4 +26,6 @@</span><br><span>   &lt=
;!-- work around macro confusion --&gt;</span><br><span>   &lt;define name=
=3D&quot;CMSG_FIRSTHDR&quot; value=3D&quot;cmsg_firsthdr&quot; /&gt;</span>=
<br><span>   &lt;define name=3D&quot;CMSG_NXTHDR&quot; value=3D&quot;cmsg_n=
xthdr&quot; /&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
&lt;!-- otherwise a lot of unused variables are shown for enable-small buil=
ds --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;defi=
ne name=3D&quot;DMSG_ALWAYS_AVAILABLE&quot; value=3D&quot;1&quot; /&gt;</sp=
an><br><span> &lt;/def&gt;</span><br><span>diff --git a/src/openvpn/compstu=
b=2Ec b/src/openvpn/compstub=2Ec</span><br><span>index f0c89f7=2E=2E2eef587=
 100644</span><br><span>--- a/src/openvpn/compstub=2Ec</span><br><span>+++ =
b/src/openvpn/compstub=2Ec</span><br><span>@@ -125,7 +125,7 @@</span><br><s=
pan>         return;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *hea=
d =3D BPTR(buf);</span><br><span> </span><br><span>     /* no compression o=
r packet to short*/</span><br><span>     if (head[0] !=3D COMP_ALGV2_INDICA=
TOR_BYTE)</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src=
/openvpn/crypto_mbedtls=2Ec</span><br><span>index 0c5beb4=2E=2E05bb60d 1006=
44</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++=
 b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -842,8 +842,8 @@</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     uint8=
_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guarded with EN=
ABLE_DEBUG to avoid unused</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to =
avoid unused</span><br><span>      * variables warnings if compiled with --=
enable-small */</span><br><span>     const size_t olen_orig =3D olen;</span=
><br><span>     const uint8_t *out_orig =3D out;</span><br><span>diff --git=
 a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legac=
y=2Ec</span><br><span>index bbd012f6=2E=2Ef46d8bf 100644</span><br><span>--=
- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn=
/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -989,8 +989,8 @@</span><br><s=
pan>     struct gc_arena gc =3D gc_new();</span><br><span>     uint8_t A1[M=
AX_HMAC_KEY_LENGTH];</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DE=
BUG to avoid unused</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid u=
nused</span><br><span>      * variables warnings if compiled with --enable-=
small */</span><br><span>     const size_t olen_orig =3D olen;</span><br><s=
pan>     const uint8_t *out_orig =3D out;</span><br><span>diff --git a/src/=
openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span>index a887fc7=2E=
=2E9f39572 100644</span><br><span>--- a/src/openvpn/error=2Eh</span><br><sp=
an>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -158,7 +158,9 @@</span><b=
r><span>         }                                \</span><br><span>       =
  EXIT_FATAL(flags);               \</span><br><span>     } while (false)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* We have DMSG_ALWAYS_=
AVAILABLE here to able to silence unused warnings for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * cppcheck */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if !defined(ENABLE_SMALL) || defined(DMSG_ALW=
AYS_AVAILABLE)</span><br><span> #define dmsg(flags, =2E=2E=2E)             =
    \</span><br><span>     do                                   \</span><br=
><span>     {                                    \</span><br><span>diff --g=
it a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec</span><br><span>index 8b=
7716a=2E=2E2cb4e04 100644</span><br><span>--- a/src/openvpn/event=2Ec</span=
><br><span>+++ b/src/openvpn/event=2Ec</span><br><span>@@ -398,7 +398,7 @@<=
/span><br><span> </span><br><span>     dmsg(D_EVENT_WAIT, &quot;WE_WAIT ent=
er n=3D%d to=3D%d&quot;, wes-&gt;n_events, timeout);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span=
><br><span>     if (check_debug_level(D_EVENT_WAIT))</span><br><span>     {=
</span><br><span>         int i;</span><br><span>diff --git a/src/openvpn/f=
orward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 6fe5849=2E=2Ea8a=
4a07 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+=
++ b/src/openvpn/forward=2Ec</span><br><span>@@ -50,7 +50,7 @@</span><br><s=
pan> </span><br><span> /* show event wait debugging info */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMAL=
L</span><br><span> </span><br><span> static const char *</span><br><span> w=
ait_status_string(struct context *c, struct gc_arena *gc)</span><br><span>@=
@ -75,7 +75,7 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span> </span><br><span> static void</span><br><sp=
an> check_tls_errors_co(struct context *c)</span><br><span>@@ -2190,7 +2190=
,7 @@</span><br><span>         {</span><br><span>             int status;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef ENABLE_SMALL</span><br><span>             if (check_debug_level(D_EVENT_=
WAIT))</span><br><span>             {</span><br><span>                 show=
_wait_status(c);</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/=
openvpn/mroute=2Ec</span><br><span>index 39fa482=2E=2E261d25a 100644</span>=
<br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mr=
oute=2Ec</span><br><span>@@ -501,7 +501,7 @@</span><br><span>     }</span><=
br><span>     mh-&gt;n_net_len =3D j;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>    =
 if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {</span><br><sp=
an>         struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/s=
rc/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=
=2Eb0125f1 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><spa=
n>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -74,7 +74,7 @@</span><br><s=
pan>         mi-&gt;did_real_hash =3D true;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABL=
E_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENAB=
LE_SMALL</span><br><span>     if (mi)</span><br><span>     {</span><br><spa=
n>         dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: instance added: %s&quot;, m=
route_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>diff --git a/=
src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 88b0091=
=2E=2E4794b7e 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><=
span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -431,7 +431,7 @@</span><=
br><span>         }</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span=
>     if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {</span><b=
r><span>         struct gc_arena gc =3D gc_new();</span><br><span>diff --gi=
t a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3e7=
2b92=2E=2E67204c3 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span>=
<br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -1145,7 +1145,7 @@=
</span><br><span>         }</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><=
br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {<=
/span><br><span>         struct gc_arena gc =3D gc_new();</span><br><span>d=
iff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><=
span>index 3604684=2E=2E4b96c57 100644</span><br><span>--- a/src/openvpn/mu=
lti_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@=
@ -46,7 +46,7 @@</span><br><span> #define MULTI_IO_FILE_CLOSE_WRITE ((void =
*)5)</span><br><span> #define MULTI_IO_DCO              ((void *)6)</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENA=
BLE_SMALL</span><br><span> static const char *</span><br><span> pract(int a=
ction)</span><br><span> {</span><br><span>@@ -89,7 +89,7 @@</span><br><span=
>             return &quot;?&quot;;</span><br><span>     }</span><br><span>=
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DE=
BUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span> </span><br><span> static inline struct context *</span><br><span=
> multi_get_context(struct multi_context *m, struct multi_instance *mi)</sp=
an><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec=
</span><br><span>index e3cd527=2E=2Ed53c2c5 100644</span><br><span>--- a/sr=
c/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><=
br><span>@@ -785,7 +785,7 @@</span><br><span> #endif /* ENABLE_PKCS11 */</s=
pan><br><span>     &quot;\n&quot;</span><br><span>     &quot;General Standa=
lone Options:\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef ENABLE_SMALL</span><br><span>     &quot;--show-gateway [address]: S=
how info about gateway [to v4/v6 address]=2E\n&quot;</span><br><span> #endi=
f</span><br><span>     ;</span><br><span>@@ -4229,7 +4229,7 @@</span><br><s=
pan>         read_config_file(options, p[1], level, file, line, msglevel, p=
ermission_mask,</span><br><span>                          option_types_foun=
d, es);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span=
><br><span>     else if (streq(p[0], &quot;show-gateway&quot;) &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         struct route_gateway_=
info rgi;</span><br><span>@@ -4938,12 +4938,13 @@</span><br><span>         =
     * mbed TLS always generating debug level logging */</span><br><span>  =
           options-&gt;ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !def=
ined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SMALL</span><br><span>     =
    /* Warn when a debug verbosity is supplied when built without debug sup=
port */</span><br><span>         if (options-&gt;verbosity &gt;=3D 7)</span=
><br><span>         {</span><br><span>             msg(M_WARN,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                &quot;NOTE: debug =
verbosity (--verb %d) is enabled but this build lacks debug support=2E&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &=
quot;NOTE: debug verbosity (--verb %d) is enabled but this build is &quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quo=
t;built with --enable-small that lacks support for high --verb settings&quo=
t;,</span><br><span>                 options-&gt;verbosity);</span><br><spa=
n>         }</span><br><span> #endif</span><br><span>diff --git a/src/openv=
pn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index a4b627c=
=2E=2E22c53c7 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span>=
<br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -52,18 +52,18 =
@@</span><br><span> #define SEQ_UNSEEN  ((time_t)0)</span><br><span> #defin=
e SEQ_EXPIRED ((time_t)1)</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void pac=
ket_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,</span>=
<br><span>                                   const struct packet_id_net *pi=
n, const char *message,</span><br><span>                                   =
packet_id_print_type value);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> st=
atic inline void</span><br><span> packet_id_debug(msglvl_t msglevel, const =
struct packet_id_rec *p,</span><br><span>                 const struct pack=
et_id_net *pin, const char *message, uint64_t value)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</spa=
n><br><span>     if (unlikely(check_debug_level(msglevel)))</span><br><span=
>     {</span><br><span>         packet_id_debug_print(msglevel, p, pin, me=
ssage, value);</span><br><span>@@ -576,7 +576,7 @@</span><br><span>     ret=
urn (char *)out=2Edata;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span=
> </span><br><span> static void</span><br><span> packet_id_debug_print(msgl=
vl_t msglevel, const struct packet_id_rec *p,</span><br><span>@@ -648,7 +64=
8,7 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifde=
f ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> uint16_t</span><br><span> packet_id=
_read_epoch(struct packet_id_net *pin, struct buffer *buf)</span><br><span>=
diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><spa=
n>index f8adde5=2E=2Ea94f07b 100644</span><br><span>--- a/src/openvpn/plugi=
n=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -993,=
7 +993,7 @@</span><br><span>     pr-&gt;n =3D 0;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENA=
BLE_SMALL</span><br><span> void</span><br><span> plugin_return_print(const =
msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)</spa=
n><br><span> {</span><br><span>@@ -1012,5 +1012,5 @@</span><br><span>      =
   }</span><br><span>     }</span><br><span> }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #endif /* ENAB=
LE_PLUGIN */</span><br><span>diff --git a/src/openvpn/plugin=2Eh b/src/open=
vpn/plugin=2Eh</span><br><span>index 7e9faf3=2E=2E684632c 100644</span><br>=
<span>--- a/src/openvpn/plugin=2Eh</span><br><span>+++ b/src/openvpn/plugin=
=2Eh</span><br><span>@@ -135,7 +135,7 @@</span><br><span> </span><br><span>=
 void plugin_return_free(struct plugin_return *pr);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span>=
<br><span> void plugin_return_print(const msglvl_t msglevel, const char *pr=
efix, const struct plugin_return *pr);</span><br><span> </span><br><span> #=
endif</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/r=
eliable=2Ec</span><br><span>index ced438e=2E=2Eb5315ff 100644</span><br><sp=
an>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliabl=
e=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef ENABLE_SMALL</span><br><span> /* print the current sequence of=
 active packet IDs */</span><br><span> static const char *</span><br><span>=
 reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)</span>=
<br><span>@@ -480,7 +480,7 @@</span><br><span>     }</span><br><span>     r=
eturn BSTR(&amp;out);</span><br><span> }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* true =
if at least one free buffer available */</span><br><span> bool</span><br><s=
pan>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><s=
pan>index 03a2526=2E=2Ee8001b3 100644</span><br><span>--- a/src/openvpn/rou=
te=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -81,7=
 +81,7 @@</span><br><span> </span><br><span> static void get_bypass_address=
es(struct route_bypass *rb, const unsigned int flags);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</sp=
an><br><span> </span><br><span> static void</span><br><span> print_bypass_a=
ddresses(const struct route_bypass *rb)</span><br><span>@@ -617,7 +617,7 @@=
</span><br><span>     if (rl-&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span>=
<br><span>     {</span><br><span>         setenv_route_addr(es, &quot;net_g=
ateway&quot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENA=
BLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef E=
NABLE_SMALL</span><br><span>         print_default_gateway(D_ROUTE, &amp;rl=
-&gt;rgi, NULL);</span><br><span> #endif</span><br><span>     }</span><br><=
span>@@ -660,7 +660,7 @@</span><br><span>             add_block_local_route=
s(rl);</span><br><span>         }</span><br><span>         get_bypass_addre=
sses(&amp;rl-&gt;spec=2Ebypass, rl-&gt;flags);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         prin=
t_bypass_addresses(&amp;rl-&gt;spec=2Ebypass);</span><br><span> #endif</spa=
n><br><span>     }</span><br><span>@@ -768,7 +768,7 @@</span><br><span>    =
 if (rl6-&gt;ngi6=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</s=
pan><br><span>         setenv_str(es, &quot;net_gateway_ipv6&quot;, print_i=
n6_addr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !d=
efined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef ENABLE_SMALL</span><br><span>         print_default_gateway(D_ROUT=
E, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</span><br><span>     }=
</span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedu=
le=2Ec</span><br><span>index 6772ad6=2E=2E6c60dc2 100644</span><br><span>--=
- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec=
</span><br><span>@@ -33,7 +33,7 @@</span><br><span> </span><br><span> #incl=
ude &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void</s=
pan><br><span> schedule_entry_debug_info(const char *caller, const struct s=
chedule_entry *e)</span><br><span> {</span><br><span>@@ -308,7 +308,7 @@</s=
pan><br><span> void</span><br><span> schedule_add_modify(struct schedule *s=
, struct schedule_entry *e)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (chec=
k_debug_level(D_SCHEDULER))</span><br><span>     {</span><br><span>        =
 schedule_entry_debug_info(&quot;schedule_add_modify&quot;, e);</span><br><=
span>@@ -355,7 +355,7 @@</span><br><span>         }</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))</=
span><br><span>     {</span><br><span>         schedule_entry_debug_info(&q=
uot;schedule_find_least&quot;, e);</span><br><span>diff --git a/src/tapctl/=
error=2Eh b/src/tapctl/error=2Eh</span><br><span>index f9586dc=2E=2E4424f56=
 100644</span><br><span>--- a/src/tapctl/error=2Eh</span><br><span>+++ b/sr=
c/tapctl/error=2Eh</span><br><span>@@ -83,19 +83,6 @@</span><br><span>     =
    }                                \</span><br><span>         EXIT_FATAL(=
flags);               \</span><br><span>     } while (false)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define dmsg(flags, =2E=2E=2E)        =
         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do     =
                              \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {                                    \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (msg_test(flags))             \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {             =
                   \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           x_msg((flags), __VA_ARGS__); \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }                                \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        EXIT_FATAL(flags);        =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (=
false)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define dmsg(flags, =2E=2E=2E)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
> </span><br><span> void x_msg(const unsigned int flags, const char *format=
, =2E=2E=2E); /* should be called via msg above */</span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3De=
mail">change 1942</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1942?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1942 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--bEpoIOLvy7w=--


--===============5491748335080589652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5491748335080589652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5491748335080589652==--

