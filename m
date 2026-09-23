Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB0EC9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wbLVd3UGSwsiakVSGn+w1oo+dL+gt7UTam3z+mrYuq4=; b=IEsmJPXbbKEQEwNhtCvRcb9TIZ
	xAQISwxxs8EBlyzkv6UX5IwExfqJaJ3/R4PfZR70KYOPDJHqf6u2kEiB5+USNUAJq/bXGhirtQTMi
	ad3FAT88ONGr40aibOIZ62UdWZH891kztjw/28spDLGrX8iv+UMIBuXHbWVAhcD7hMLY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9P5M-0003VV-Qr;
	Wed, 23 Sep 2026 15:40:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9P54-0003VF-1Z
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wsMiLAa7oHosq1xL7JYgUwYJjzsuwAiEclDVkj4mTvA=; b=XlDfHcHtQXA/nYMSugePjEhh59
 uLQUxQVRAZRwoES9eeYSSOOL+d7KL2xQ+61PudJA8QnEgYfWL4fHCPTsrDLvmyhdeXwDP85+Z7zQ8
 gglZ3Oa8tMhAL0EwZO0uxnnTJEePR6Se6KfeyYsCPd/lTRBxrbdn8Tf4nCfIKJ7Ca51Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wsMiLAa7oHosq1xL7JYgUwYJjzsuwAiEclDVkj4mTvA=; b=C
 rAfk5F1PWhLjRVjwPk72G74I8PCo2zQ98oqm05j7sB8i5E7zNqfnnpwIAeJK0gSJm7t9uoYHz2uTa
 3BkHpTTg4IH67zxRlUJB1sEOiBGKjj0Qb32Um2dyShO2/jnttYkT3wvmDITsRfupAcfo+H912JAHs
 nDEOUZ19bWZpj4vw=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9P4y-00052R-8A for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:40:19 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so6575685e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790178010; x=1790782810; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wsMiLAa7oHosq1xL7JYgUwYJjzsuwAiEclDVkj4mTvA=;
 b=UfczOCFTEyb+EgI7WNZQm6SQycSwUxH2sgrNfcO9Y4Fq12MIWZ6AE8Y/HMLU+qru05
 mBb1IKIm2vlhGZpYJGKnuAfK1fSOOqNb3kIQoq+1ngDNcSiQ5ZKP2rA2JECgk0wN9fMz
 kvwjut1AjIpGGwoGM1uS5Piww2y9sd/heyy972MOP9f3I7IddAp+FFN+CEr661q5seNj
 dvHWxKEJDrgPLDmbkG/QPPpmGu8U1QhJ/zEbs5Lv1vPiVmoScR7ZdZOfNShl81oHYLK+
 LtsCGLDMtOBz9qCD9n+mFx+5Ibdl5EanJSGcvSjT15slmjqrpmIko5+L+IixFpa13w3M
 6WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178010; x=1790782810;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wsMiLAa7oHosq1xL7JYgUwYJjzsuwAiEclDVkj4mTvA=;
 b=Y+8LNLHbTY9K8lpihtnviXO3LLbGi8SAnwBWzg1K22Q1++3XMvCTveEH48YvIq7AdG
 IrK4FwZYbJtvpe3fJs+VV3yuYUFBF7o7j3/GcV+G1P2H9XI9LluvBFqpDCjshdB36svs
 jbSKZzfYDiHu4OFYAbQucUX/SjZ+cHyjuz+e5e0q+ss3Xtyvt92JcgOVwsl6GgbannTO
 BZXVI4B9EZNth+hnAq9Vl2Ien+39TWI2+QdRGS0ADHqBNhlQfRHYrF9gUwplOuBTkMyj
 E+IV8TZzR/S9K4H25UbczXzoCgzXwTww5L5PiEL4fZVArYxip68aCNkDa+mOK9uIDEXk
 qikg==
X-Gm-Message-State: AFuF++m4H1BRE0X1M+B1FOvLl54sPutqVTcocMu84G5yv7ZAg+DAGZl6
 OsMwE8khNXiikt1emGAZ1ATRzM2qPlHsWd7EJtKal4S1mdQDDNZNe6niPTGqvi5pHv9zgZtuKis
 S6OnUg/vOLk3JLxYT93cP2Yae0sW1YKM0ZdvBzdFQvkuPYwq0fUgx/yXVl7s6009uBXyBWLz2bf
 8u6gAKNQ==
X-Gm-Gg: AYBFou1rjdh5UAawgC7da8g967pFOBj6GiHlrZQTkjXmhoWNzH95mgxLOKlnNWNx8jS
 enNdKRRseca9HsBZmkByzU3ZrpycI6xDJuON4Pg6lQFCwz8AnEMdv/IzpvCrtLXdrqJ1nhfizNL
 uQPkLdmJVeCwroIjTV/KWxhPJlkoH0O1SG9R/KX+Kjj2R4rIaPlNv9unBa3sRNECzr7d00ClIGh
 1N+xArXPM2R+FlrSVuEBr9QLYhzeUK+YvhOOWwYphFHto1wvW2WVkVF6tSL6/X1kjSPemNNbmUE
 QJqBOzZgkOwL6UCqSS0dXidWDrJrAEHoB+Qo85UxJUra4zILn/gcMmv+RgsxwDwjQoKe3HZUcb6
 4K2q1GbNjduMHDx0QGUJ3lskHSiZRIOzvIqt1mUaJnvS7oP/4+NfUle2VlWjMy4m/hWk1diNJNk
 fNWkLlHBMTeCx29yyIED6nVQ3eljTyI7xSgSfZUhneHMksGbFnoxvEwjtGfs7WHCpX0n6x+TImB
 08F4zsIck7zVyuxiWH9T+119NQ0hIdfyAgXIPtuNM/rH9EPwb6+nNVpcV51wsOZoaK0266YSKJQ
 KXfJKwomJZefQpIA/I9WZWjX8aafe0jbrFs75Wg652stOYG/NLdshZJrRAO1
X-Received: by 2002:a05:600c:34ca:b0:49f:ce78:3568 with SMTP id
 5b1f17b1804b1-49fdeffd818mr44396045e9.25.1790178009269; 
 Wed, 23 Sep 2026 08:40:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdf158147sm61715375e9.0.2026.09.23.08.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:40:08 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 15:40:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 42b7486a6691de80998eb79285e86de5e80e4665
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83b45c635ac7b02a8802d6c418c5bfb2d4446b96-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9P4y-00052R-8A
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
Content-Type: multipart/mixed; boundary="===============6848095559750554240=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6848095559750554240==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nqH83da2RTI="; charset=UTF-8

--nqH83da2RTI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new pa=
tch set (#7)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by flichtenheld


Change subject: Change most ENABLE_DEBUG ifdef=
s to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

Most =
of these are verbose logging or even enable logging at high
verbosity level=
 or just useful tools like --show-gateway=2E

We had --enabled-debug on by =
default forever, so these "debug"
logs are on by default=2E This patch inst=
ead moves them to
enable-small=2E

Since the verbose logging is now always =
enabled
(apart from --enable-small), --enable-debug now only covers true
de=
bug options like gremlin=2E

Rename the configure option from --enable-debu=
g to
--enable-developer-debug to ensure existing build
script/maintainer do=
 not enable this option
by default=2E

Remove dmsg macro from tapctl's erro=
r=2Eh since it does
not use that macro at all=2E

Change-Id: I3f96cd1c3488b=
558b8a597594d99edcba1214d27
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=
=2Eh=2Ecmake=2Ein
M configure=2Eac
M dev-tools/cppcheck-suppression
M dev-t=
ools/openvpn-cppcheck-library=2Ecfg
M src/openvpn/compstub=2Ec
M src/openvp=
n/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/=
error=2Eh
M src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/m=
route=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=
=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/options=2Ec
M src/openvpn/pac=
ket_id=2Ec
M src/openvpn/plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/=
reliable=2Ec
M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapct=
l/error=2Eh
25 files changed, 54 insertions(+), 55 deletions(-)


  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/7

diff -=
-git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 10064=
4
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(E=
NABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compi=
ler warnings as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android =
but do not use actual cross compile/Android cmake to build for simple compi=
le checks on Linux")
+option(ENABLE_DEBUG "Enable building with debug" OFF)=

 
 option(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" =
ON)
 set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updow=
n" CACHE STRING "Default location for the DNS up/down script")
diff --git a=
/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2Ef46d1a3 100644
--- a/Change=
s=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,12 @@
   the characters mentioned ab=
ove were already escaped=2E However, the behavior of
   Mbed TLS is slightl=
y different from OpenSSL in that it also escapes "=3D"=2E
 
+## Maintainer-=
visible changes
+
+- The configure-time option `--enable-debug` is no longe=
r  available 
+  and the verbose logging is now always included unless `--e=
nable-small` 
+  is enabled=2E 
+
 # Overview of changes in 2=2E7
 
 ## New=
 features
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
in=
dex c3bb5a5=2E=2Ec6c0a96 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=
=2Eh=2Ecmake=2Ein
@@ -18,8 +18,8 @@
 /* Enable shared data channel offload =
*/
 #cmakedefine ENABLE_DCO
 
-/* Enable debugging support (needed for verb=
>=3D4) */
-#define ENABLE_DEBUG 1
+/* Enable debugging support */
+#cmakede=
fine ENABLE_DEBUG
 
 /* Enable internal fragmentation support */
 #define E=
NABLE_FRAGMENT 1
diff --git a/configure=2Eac b/configure=2Eac
index 469a475=
=2E=2E4226515 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -131,9 +1=
31,9 @@
 
 AC_ARG_ENABLE(
 	[debug],
-	[AS_HELP_STRING([--disable-debug], [=
disable debugging support (disable gremlin and verb 7+ messages) @<:@defaul=
t=3Dyes@:>@])],
+	[AS_HELP_STRING([--enable-developer-debug], [enable devel=
oper debugging support (enable gremlin) @<:@default=3Dno@:>@])],
 	,
-	[ena=
ble_debug=3D"yes"]
+	[enable_debug=3D"no"]
 )
 
 AC_ARG_ENABLE(
diff --git =
a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 299=
d7a3=2E=2Eb505aef 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-too=
ls/cppcheck-suppression
@@ -42,7 +42,7 @@
 intToPointerCast:src/openvpn/mul=
ti_io=2Ec
 intToPointerCast:src/openvpn/ps=2Ec
 # FP: constant but differs =
between platforms
-knownConditionTrueFalse:src/openvpn/error=2Eh:380
+known=
ConditionTrueFalse:src/openvpn/error=2Eh:382
 knownConditionTrueFalse:src/o=
penvpn/fdmisc=2Ec:80
 knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64
 kn=
ownConditionTrueFalse:src/openvpn/platform=2Ec
diff --git a/dev-tools/openv=
pn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-library=2Ecfg
index =
1ea91f4=2E=2Edecac67 100644
--- a/dev-tools/openvpn-cppcheck-library=2Ecfg
=
+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg
@@ -26,4 +26,6 @@
   <!-- wo=
rk around macro confusion -->
   <define name=3D"CMSG_FIRSTHDR" value=3D"cm=
sg_firsthdr" />
   <define name=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
+ =
 <!-- otherwise a lot of unused variables are shown for enable-small builds=
 -->
+  <define name=3D"DMSG_ALWAYS_AVAILABLE" value=3D"1" />
 </def>
diff =
--git a/src/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec
index f0c89f7=
=2E=2E2eef587 100644
--- a/src/openvpn/compstub=2Ec
+++ b/src/openvpn/comps=
tub=2Ec
@@ -125,7 +125,7 @@
         return;
     }
 
-    uint8_t *head =
=3D BPTR(buf);
+    const uint8_t *head =3D BPTR(buf);
 
     /* no compres=
sion or packet to short*/
     if (head[0] !=3D COMP_ALGV2_INDICATOR_BYTE)
=
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2E=
c
index 0c5beb4=2E=2E05bb60d 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
++=
+ b/src/openvpn/crypto_mbedtls=2Ec
@@ -842,8 +842,8 @@
     struct gc_arena=
 gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DE=
BUG
-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avo=
id unused
+#ifndef ENABLE_SMALL
+    /* used by the D_SHOW_KEY_SOURCE, guar=
ded with ENABLE_SMALL to avoid unused
      * variables warnings if compile=
d with --enable-small */
     const size_t olen_orig =3D olen;
     const u=
int8_t *out_orig =3D out;
diff --git a/src/openvpn/crypto_mbedtls_legacy=2E=
c b/src/openvpn/crypto_mbedtls_legacy=2Ec
index bbd012f6=2E=2Ef46d8bf 10064=
4
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbed=
tls_legacy=2Ec
@@ -989,8 +989,8 @@
     struct gc_arena gc =3D gc_new();
  =
   uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by =
the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef E=
NABLE_SMALL
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMAL=
L to avoid unused
      * variables warnings if compiled with --enable-smal=
l */
     const size_t olen_orig =3D olen;
     const uint8_t *out_orig =3D=
 out;
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index a887=
fc7=2E=2E9f39572 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=
=2Eh
@@ -158,7 +158,9 @@
         }                                \
      =
   EXIT_FATAL(flags);               \
     } while (false)
-#ifdef ENABLE_D=
EBUG
+/* We have DMSG_ALWAYS_AVAILABLE here to able to silence unused warni=
ngs for
+ * cppcheck */
+#if !defined(ENABLE_SMALL) || defined(DMSG_ALWAYS_=
AVAILABLE)
 #define dmsg(flags, =2E=2E=2E)                 \
     do       =
                            \
     {                                    \
d=
iff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 8b7716a=2E=
=2E2cb4e04 100644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@=
@ -398,7 +398,7 @@
 
     dmsg(D_EVENT_WAIT, "WE_WAIT enter n=3D%d to=3D%d"=
, wes->n_events, timeout);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
   =
  if (check_debug_level(D_EVENT_WAIT))
     {
         int i;
diff --git a/=
src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 6fe5849=2E=2Ea8a4a0=
7 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -50=
,7 +50,7 @@
 
 /* show event wait debugging info */
 
-#ifdef ENABLE_DEBUG
=
+#ifndef ENABLE_SMALL
 
 static const char *
 wait_status_string(struct con=
text *c, struct gc_arena *gc)
@@ -75,7 +75,7 @@
     gc_free(&gc);
 }
 
-#e=
ndif /* ifdef ENABLE_DEBUG */
+#endif
 
 static void
 check_tls_errors_co(s=
truct context *c)
@@ -2190,7 +2190,7 @@
         {
             int status;=

 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
             if (check_debug_=
level(D_EVENT_WAIT))
             {
                 show_wait_status(c);
d=
iff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 39fa482=
=2E=2E261d25a 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=
=2Ec
@@ -501,7 +501,7 @@
     }
     mh->n_net_len =3D j;
 
-#ifdef ENABLE_=
DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
    =
 {
         struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/mtcp=
=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2Eb0125f1 100644
--- a/src/ope=
nvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -74,7 +74,7 @@
         mi->did=
_real_hash =3D true;
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
  =
   if (mi)
     {
         dmsg(D_MULTI_DEBUG, "MULTI TCP: instance added: =
%s", mroute_addr_print(&mi->real, &gc));
diff --git a/src/openvpn/mudp=2Ec =
b/src/openvpn/mudp=2Ec
index 88b0091=2E=2E4794b7e 100644
--- a/src/openvpn/=
mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -431,7 +431,7 @@
         }
     }
 =

-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MU=
LTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new();
diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=2E=2E67204c3 100=
644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1145,7 +114=
5,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     =
if (check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =
=3D gc_new();
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=
=2Ec
index 3604684=2E=2E4b96c57 100644
--- a/src/openvpn/multi_io=2Ec
+++ b=
/src/openvpn/multi_io=2Ec
@@ -46,7 +46,7 @@
 #define MULTI_IO_FILE_CLOSE_WR=
ITE ((void *)5)
 #define MULTI_IO_DCO              ((void *)6)
 
-#ifdef EN=
ABLE_DEBUG
+#ifndef ENABLE_SMALL
 static const char *
 pract(int action)
 {=

@@ -89,7 +89,7 @@
             return "?";
     }
 }
-#endif /* ENABLE_DEB=
UG */
+#endif
 
 static inline struct context *
 multi_get_context(struct m=
ulti_context *m, struct multi_instance *mi)
diff --git a/src/openvpn/option=
s=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2Ed53c2c5 100644
--- a/src=
/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -785,7 +785,7 @@
 #en=
dif /* ENABLE_PKCS11 */
     "\n"
     "General Standalone Options:\n"
-#if=
def ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     "--show-gateway [address]: Show=
 info about gateway [to v4/v6 address]=2E\n"
 #endif
     ;
@@ -4229,7 +422=
9,7 @@
         read_config_file(options, p[1], level, file, line, msglevel=
, permission_mask,
                          option_types_found, es);
     =
}
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMAL=
L
     else if (streq(p[0], "show-gateway") && !p[2])
     {
         struc=
t route_gateway_info rgi;
@@ -4938,12 +4938,13 @@
              * mbed TLS =
always generating debug level logging */
             options->ssl_flags |=
=3D SSLF_TLS_DEBUG_ENABLED;
         }
-#if !defined(ENABLE_DEBUG) && !defi=
ned(ENABLE_SMALL)
+#ifdef ENABLE_SMALL
         /* Warn when a debug verbos=
ity is supplied when built without debug support */
         if (options->v=
erbosity >=3D 7)
         {
             msg(M_WARN,
-                "NOTE=
: debug verbosity (--verb %d) is enabled but this build lacks debug support=
=2E",
+                "NOTE: debug verbosity (--verb %d) is enabled but th=
is build is "
+                "built with --enable-small that lacks suppor=
t for high --verb settings",
                 options->verbosity);
        =
 }
 #endif
diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=
=2Ec
index a4b627c=2E=2E22c53c7 100644
--- a/src/openvpn/packet_id=2Ec
+++ =
b/src/openvpn/packet_id=2Ec
@@ -52,18 +52,18 @@
 #define SEQ_UNSEEN  ((time=
_t)0)
 #define SEQ_EXPIRED ((time_t)1)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENAB=
LE_SMALL
 static void packet_id_debug_print(msglvl_t msglevel, const struct=
 packet_id_rec *p,
                                   const struct packet_i=
d_net *pin, const char *message,
                                   packet_=
id_print_type value);
 
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline=
 void
 packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,
  =
               const struct packet_id_net *pin, const char *message, uint64=
_t value)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (unlikely(c=
heck_debug_level(msglevel)))
     {
         packet_id_debug_print(msglevel=
, p, pin, message, value);
@@ -576,7 +576,7 @@
     return (char *)out=2Eda=
ta;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 packet_=
id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,
@@ -648,7 =
+648,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#endif
=
 
 uint16_t
 packet_id_read_epoch(struct packet_id_net *pin, struct buffer =
*buf)
diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index f8=
adde5=2E=2Ea94f07b 100644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/pl=
ugin=2Ec
@@ -993,7 +993,7 @@
     pr->n =3D 0;
 }
 
-#ifdef ENABLE_DEBUG
+#=
ifndef ENABLE_SMALL
 void
 plugin_return_print(const msglvl_t msglevel, con=
st char *prefix, const struct plugin_return *pr)
 {
@@ -1012,5 +1012,5 @@
 =
        }
     }
 }
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 #endif /* ENA=
BLE_PLUGIN */
diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
=
index 7e9faf3=2E=2E684632c 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/op=
envpn/plugin=2Eh
@@ -135,7 +135,7 @@
 
 void plugin_return_free(struct plug=
in_return *pr);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void plugin_r=
eturn_print(const msglvl_t msglevel, const char *prefix, const struct plugi=
n_return *pr);
 
 #endif
diff --git a/src/openvpn/reliable=2Ec b/src/openvp=
n/reliable=2Ec
index ced438e=2E=2Eb5315ff 100644
--- a/src/openvpn/reliable=
=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -462,7 +462,7 @@
     }
 }
 
-#ifdef=
 ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 /* print the current sequence of activ=
e packet IDs */
 static const char *
 reliable_print_ids(const struct relia=
ble *rel, struct gc_arena *gc)
@@ -480,7 +480,7 @@
     }
     return BSTR(=
&out);
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 /* true if at least one fre=
e buffer available */
 bool
diff --git a/src/openvpn/route=2Ec b/src/openvp=
n/route=2Ec
index 03a2526=2E=2Ee8001b3 100644
--- a/src/openvpn/route=2Ec
+=
++ b/src/openvpn/route=2Ec
@@ -81,7 +81,7 @@
 
 static void get_bypass_addr=
esses(struct route_bypass *rb, const unsigned int flags);
 
-#ifdef ENABLE_=
DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 print_bypass_addresses(const st=
ruct route_bypass *rb)
@@ -617,7 +617,7 @@
     if (rl->ngi=2Eflags & RGI_A=
DDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->ngi=
=2Egateway=2Eaddr, -1);
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL=
)
+#ifndef ENABLE_SMALL
         print_default_gateway(D_ROUTE, &rl->rgi, N=
ULL);
 #endif
     }
@@ -660,7 +660,7 @@
             add_block_local_route=
s(rl);
         }
         get_bypass_addresses(&rl->spec=2Ebypass, rl->fla=
gs);
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
         print_bypass_addre=
sses(&rl->spec=2Ebypass);
 #endif
     }
@@ -768,7 +768,7 @@
     if (rl6->=
ngi6=2Eflags & RGI_ADDR_DEFINED)
     {
         setenv_str(es, "net_gatewa=
y_ipv6", print_in6_addr(rl6->ngi6=2Egateway=2Eaddr_ipv6, 0, &gc));
-#if def=
ined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
        =
 print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
     }
diff --gi=
t a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6772ad6=2E=2E=
6c60dc2 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2E=
c
@@ -33,7 +33,7 @@
 
 #include "memdbg=2Eh"
 
-#ifdef ENABLE_DEBUG
+#ifnde=
f ENABLE_SMALL
 static void
 schedule_entry_debug_info(const char *caller, =
const struct schedule_entry *e)
 {
@@ -308,7 +308,7 @@
 void
 schedule_add_=
modify(struct schedule *s, struct schedule_entry *e)
 {
-#ifdef ENABLE_DEBU=
G
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {
   =
      schedule_entry_debug_info("schedule_add_modify", e);
@@ -355,7 +355,7=
 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if =
(check_debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_info(=
"schedule_find_least", e);
diff --git a/src/tapctl/error=2Eh b/src/tapctl/e=
rror=2Eh
index f9586dc=2E=2E4424f56 100644
--- a/src/tapctl/error=2Eh
+++ b=
/src/tapctl/error=2Eh
@@ -83,19 +83,6 @@
         }                        =
        \
         EXIT_FATAL(flags);               \
     } while (false)
=
-#ifdef ENABLE_DEBUG
-#define dmsg(flags, =2E=2E=2E)                 \
-   =
 do                                   \
-    {                             =
       \
-        if (msg_test(flags))             \
-        {            =
                    \
-            x_msg((flags), __VA_ARGS__); \
-        =
}                                \
-        EXIT_FATAL(flags);             =
  \
-    } while (false)
-#else
-#define dmsg(flags, =2E=2E=2E)
-#endif
 
 =
void x_msg(const unsigned int flags, const char *format, =2E=2E=2E); /* sho=
uld be called via msg above */
 

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Change-Num=
ber: 1942
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank=
@lichtenheld=2Ecom>

--nqH83da2RTI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #7</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_S=
MALL<br><br>Most of these are verbose logging or even enable logging at hig=
h<br>verbosity level or just useful tools like --show-gateway=2E<br><br>We =
had --enabled-debug on by default forever, so these &quot;debug&quot;<br>lo=
gs are on by default=2E This patch instead moves them to<br>enable-small=2E=
<br><br>Since the verbose logging is now always enabled<br>(apart from --en=
able-small), --enable-debug now only covers true<br>debug options like grem=
lin=2E<br><br>Rename the configure option from --enable-debug to<br>--enabl=
e-developer-debug to ensure existing build<br>script/maintainer do not enab=
le this option<br>by default=2E<br><br>Remove dmsg macro from tapctl&#39;s =
error=2Eh since it does<br>not use that macro at all=2E<br><br>Change-Id: I=
3f96cd1c3488b558b8a597594d99edcba1214d27<br>---<br>M CMakeLists=2Etxt<br>M =
Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M dev-tool=
s/cppcheck-suppression<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M s=
rc/openvpn/compstub=2Ec<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvp=
n/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/eve=
nt=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mroute=2Ec<br>M src/op=
envpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M sr=
c/openvpn/multi_io=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/packet=
_id=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M src/op=
envpn/reliable=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec=
<br>M src/tapctl/error=2Eh<br>25 files changed, 54 insertions(+), 55 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/42/1942/7</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/C=
MakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Ed553697 100644</span><br=
><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span>=
<br><span>@@ -40,6 +40,7 @@</span><br><span> option(ENABLE_PKCS11 &quot;BUI=
LD with pkcs11-helper&quot; ON)</span><br><span> option(USE_WERROR &quot;Tr=
eat compiler warnings as errors (-Werror)&quot; ON)</span><br><span> option=
(FAKE_ANDROID &quot;Target Android but do not use actual cross compile/Andr=
oid cmake to build for simple compile checks on Linux&quot;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+option(ENABLE_DEBUG &quot;Enable b=
uilding with debug&quot; OFF)</span><br><span> </span><br><span> option(ENA=
BLE_DNS_UPDOWN_BY_DEFAULT &quot;Run --dns-updown hook by default&quot; ON)<=
/span><br><span> set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libexec/=
openvpn/dns-updown&quot; CACHE STRING &quot;Default location for the DNS up=
/down script&quot;)</span><br><span>diff --git a/Changes=2Emd b/Changes=2Em=
d</span><br><span>index 2684251=2E=2Ef46d1a3 100644</span><br><span>--- a/C=
hanges=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23=
,12 @@</span><br><span>   the characters mentioned above were already escap=
ed=2E However, the behavior of</span><br><span>   Mbed TLS is slightly diff=
erent from OpenSSL in that it also escapes &quot;=3D&quot;=2E</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Maintainer-v=
isible changes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+- The configure-time opt=
ion `--enable-debug` is no longer  available </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  and the verbose logging is now always included =
unless `--enable-small` </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  is enabled=2E </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> # Overview of changes in 2=2E7</span><br><span> </span>=
<br><span> ## New features</span><br><span>diff --git a/config=2Eh=2Ecmake=
=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index c3bb5a5=2E=2Ec6c0a96 =
100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/=
config=2Eh=2Ecmake=2Ein</span><br><span>@@ -18,8 +18,8 @@</span><br><span> =
/* Enable shared data channel offload */</span><br><span> #cmakedefine ENAB=
LE_DCO</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/* Enable debugging support (needed for verb&gt;=3D4) */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_DEBUG 1</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Enable debugging support */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_DEB=
UG</span><br><span> </span><br><span> /* Enable internal fragmentation supp=
ort */</span><br><span> #define ENABLE_FRAGMENT 1</span><br><span>diff --gi=
t a/configure=2Eac b/configure=2Eac</span><br><span>index 469a475=2E=2E4226=
515 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/confi=
gure=2Eac</span><br><span>@@ -131,9 +131,9 @@</span><br><span> </span><br><=
span> AC_ARG_ENABLE(</span><br><span> 	[debug],</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	[AS_HELP_STRING([--disable-debug], [disable debu=
gging support (disable gremlin and verb 7+ messages) @&lt;:@default=3Dyes@:=
&gt;@])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_=
STRING([--enable-developer-debug], [enable developer debugging support (ena=
ble gremlin) @&lt;:@default=3Dno@:&gt;@])],</span><br><span> 	,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	[enable_debug=3D&quot;yes&quot;]=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[enable_debug=3D&q=
uot;no&quot;]</span><br><span> )</span><br><span> </span><br><span> AC_ARG_=
ENABLE(</span><br><span>diff --git a/dev-tools/cppcheck-suppression b/dev-t=
ools/cppcheck-suppression</span><br><span>index 299d7a3=2E=2Eb505aef 100644=
</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b=
/dev-tools/cppcheck-suppression</span><br><span>@@ -42,7 +42,7 @@</span><br=
><span> intToPointerCast:src/openvpn/multi_io=2Ec</span><br><span> intToPoi=
nterCast:src/openvpn/ps=2Ec</span><br><span> # FP: constant but differs bet=
ween platforms</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownCo=
nditionTrueFalse:src/openvpn/error=2Eh:380</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/error=2Eh:382</s=
pan><br><span> knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br>=
<span> knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64</span><br><span> k=
nownConditionTrueFalse:src/openvpn/platform=2Ec</span><br><span>diff --git =
a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-lib=
rary=2Ecfg</span><br><span>index 1ea91f4=2E=2Edecac67 100644</span><br><spa=
n>--- a/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>+++ b/dev-=
tools/openvpn-cppcheck-library=2Ecfg</span><br><span>@@ -26,4 +26,6 @@</spa=
n><br><span>   &lt;!-- work around macro confusion --&gt;</span><br><span> =
  &lt;define name=3D&quot;CMSG_FIRSTHDR&quot; value=3D&quot;cmsg_firsthdr&q=
uot; /&gt;</span><br><span>   &lt;define name=3D&quot;CMSG_NXTHDR&quot; val=
ue=3D&quot;cmsg_nxthdr&quot; /&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &lt;!-- otherwise a lot of unused variables are shown for =
enable-small builds --&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &lt;define name=3D&quot;DMSG_ALWAYS_AVAILABLE&quot; value=3D&quot;=
1&quot; /&gt;</span><br><span> &lt;/def&gt;</span><br><span>diff --git a/sr=
c/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec</span><br><span>index f0c=
89f7=2E=2E2eef587 100644</span><br><span>--- a/src/openvpn/compstub=2Ec</sp=
an><br><span>+++ b/src/openvpn/compstub=2Ec</span><br><span>@@ -125,7 +125,=
7 @@</span><br><span>         return;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =
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
ulti_instance *mi)</span><br><span>diff --git a/src/openvpn/options=2Ec b/s=
rc/openvpn/options=2Ec</span><br><span>index e3cd527=2E=2Ed53c2c5 100644</s=
pan><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openv=
pn/options=2Ec</span><br><span>@@ -785,7 +785,7 @@</span><br><span> #endif =
/* ENABLE_PKCS11 */</span><br><span>     &quot;\n&quot;</span><br><span>   =
  &quot;General Standalone Options:\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     &quot;--sho=
w-gateway [address]: Show info about gateway [to v4/v6 address]=2E\n&quot;<=
/span><br><span> #endif</span><br><span>     ;</span><br><span>@@ -4229,7 +=
4229,7 @@</span><br><span>         read_config_file(options, p[1], level, f=
ile, line, msglevel, permission_mask,</span><br><span>                     =
     option_types_found, es);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defin=
ed(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
ndef ENABLE_SMALL</span><br><span>     else if (streq(p[0], &quot;show-gate=
way&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><br><span>       =
  struct route_gateway_info rgi;</span><br><span>@@ -4938,12 +4938,13 @@</s=
pan><br><span>              * mbed TLS always generating debug level loggin=
g */</span><br><span>             options-&gt;ssl_flags |=3D SSLF_TLS_DEBUG=
_ENABLED;</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if !defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SMALL=
</span><br><span>         /* Warn when a debug verbosity is supplied when b=
uilt without debug support */</span><br><span>         if (options-&gt;verb=
osity &gt;=3D 7)</span><br><span>         {</span><br><span>             ms=
g(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    &quot;NOTE: debug verbosity (--verb %d) is enabled but this build lacks=
 debug support=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;NOTE: debug verbosity (--verb %d) is enabled but=
 this build is &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                &quot;built with --enable-small that lacks support for hi=
gh --verb settings&quot;,</span><br><span>                 options-&gt;verb=
osity);</span><br><span>         }</span><br><span> #endif</span><br><span>=
diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><b=
r><span>index a4b627c=2E=2E22c53c7 100644</span><br><span>--- a/src/openvpn=
/packet_id=2Ec</span><br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><s=
pan>@@ -52,18 +52,18 @@</span><br><span> #define SEQ_UNSEEN  ((time_t)0)</s=
pan><br><span> #define SEQ_EXPIRED ((time_t)1)</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><=
span> static void packet_id_debug_print(msglvl_t msglevel, const struct pac=
ket_id_rec *p,</span><br><span>                                   const str=
uct packet_id_net *pin, const char *message,</span><br><span>              =
                     packet_id_print_type value);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
 </span><br><span> static inline void</span><br><span> packet_id_debug(msgl=
vl_t msglevel, const struct packet_id_rec *p,</span><br><span>             =
    const struct packet_id_net *pin, const char *message, uint64_t value)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>     if (unlikely(check_debug_level(msglev=
el)))</span><br><span>     {</span><br><span>         packet_id_debug_print=
(msglevel, p, pin, message, value);</span><br><span>@@ -576,7 +576,7 @@</sp=
an><br><span>     return (char *)out=2Edata;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_D=
EBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_=
SMALL</span><br><span> </span><br><span> static void</span><br><span> packe=
t_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,</span><b=
r><span>@@ -648,7 +648,7 @@</span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span> </span><br><span> uint16_t</span=
><br><span> packet_id_read_epoch(struct packet_id_net *pin, struct buffer *=
buf)</span><br><span>diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plug=
in=2Ec</span><br><span>index f8adde5=2E=2Ea94f07b 100644</span><br><span>--=
- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</sp=
an><br><span>@@ -993,7 +993,7 @@</span><br><span>     pr-&gt;n =3D 0;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifndef ENABLE_SMALL</span><br><span> void</span><br><span> plugi=
n_return_print(const msglvl_t msglevel, const char *prefix, const struct pl=
ugin_return *pr)</span><br><span> {</span><br><span>@@ -1012,5 +1012,5 @@</=
span><br><span>         }</span><br><span>     }</span><br><span> }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> #endif /* ENABLE_PLUGIN */</span><br><span>diff --git a/src/openvpn/=
plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><span>index 7e9faf3=2E=2E6846=
32c 100644</span><br><span>--- a/src/openvpn/plugin=2Eh</span><br><span>+++=
 b/src/openvpn/plugin=2Eh</span><br><span>@@ -135,7 +135,7 @@</span><br><sp=
an> </span><br><span> void plugin_return_free(struct plugin_return *pr);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SMALL</span><br><span> void plugin_return_print(const msglvl_t msg=
level, const char *prefix, const struct plugin_return *pr);</span><br><span=
> </span><br><span> #endif</span><br><span>diff --git a/src/openvpn/reliabl=
e=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index ced438e=2E=2Eb5315ff=
 100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ =
b/src/openvpn/reliable=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> /* print th=
e current sequence of active packet IDs */</span><br><span> static const ch=
ar *</span><br><span> reliable_print_ids(const struct reliable *rel, struct=
 gc_arena *gc)</span><br><span>@@ -480,7 +480,7 @@</span><br><span>     }</=
span><br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </spa=
n><br><span> /* true if at least one free buffer available */</span><br><sp=
an> bool</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/r=
oute=2Ec</span><br><span>index 03a2526=2E=2Ee8001b3 100644</span><br><span>=
--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</sp=
an><br><span>@@ -81,7 +81,7 @@</span><br><span> </span><br><span> static vo=
id get_bypass_addresses(struct route_bypass *rb, const unsigned int flags);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
ndef ENABLE_SMALL</span><br><span> </span><br><span> static void</span><br>=
<span> print_bypass_addresses(const struct route_bypass *rb)</span><br><spa=
n>@@ -617,7 +617,7 @@</span><br><span>     if (rl-&gt;ngi=2Eflags &amp; RGI=
_ADDR_DEFINED)</span><br><span>     {</span><br><span>         setenv_route=
_addr(es, &quot;net_gateway&quot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &a=
mp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         print_default_gat=
eway(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><span> #endif</span><br><sp=
an>     }</span><br><span>@@ -660,7 +660,7 @@</span><br><span>             =
add_block_local_routes(rl);</span><br><span>         }</span><br><span>    =
     get_bypass_addresses(&amp;rl-&gt;spec=2Ebypass, rl-&gt;flags);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><b=
r><span>         print_bypass_addresses(&amp;rl-&gt;spec=2Ebypass);</span><=
br><span> #endif</span><br><span>     }</span><br><span>@@ -768,7 +768,7 @@=
</span><br><span>     if (rl6-&gt;ngi6=2Eflags &amp; RGI_ADDR_DEFINED)</spa=
n><br><span>     {</span><br><span>         setenv_str(es, &quot;net_gatewa=
y_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE=
_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         print_d=
efault_gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</=
span><br><span>     }</span><br><span>diff --git a/src/openvpn/schedule=2Ec=
 b/src/openvpn/schedule=2Ec</span><br><span>index 6772ad6=2E=2E6c60dc2 1006=
44</span><br><span>--- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src=
/openvpn/schedule=2Ec</span><br><span>@@ -33,7 +33,7 @@</span><br><span> </=
span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br>=
<span> static void</span><br><span> schedule_entry_debug_info(const char *c=
aller, const struct schedule_entry *e)</span><br><span> {</span><br><span>@=
@ -308,7 +308,7 @@</span><br><span> void</span><br><span> schedule_add_modi=
fy(struct schedule *s, struct schedule_entry *e)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><b=
r><span>     if (check_debug_level(D_SCHEDULER))</span><br><span>     {</sp=
an><br><span>         schedule_entry_debug_info(&quot;schedule_add_modify&q=
uot;, e);</span><br><span>@@ -355,7 +355,7 @@</span><br><span>         }</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_=
level(D_SCHEDULER))</span><br><span>     {</span><br><span>         schedul=
e_entry_debug_info(&quot;schedule_find_least&quot;, e);</span><br><span>dif=
f --git a/src/tapctl/error=2Eh b/src/tapctl/error=2Eh</span><br><span>index=
 f9586dc=2E=2E4424f56 100644</span><br><span>--- a/src/tapctl/error=2Eh</sp=
an><br><span>+++ b/src/tapctl/error=2Eh</span><br><span>@@ -83,19 +83,6 @@<=
/span><br><span>         }                                \</span><br><span=
>         EXIT_FATAL(flags);               \</span><br><span>     } while (=
false)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_D=
EBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define dmsg(flag=
s, =2E=2E=2E)                 \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    do                                   \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {                                    \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (msg_test(f=
lags))             \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {                                \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            x_msg((flags), __VA_ARGS__); \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }                         =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        EXIT_=
FATAL(flags);               \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    } while (false)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define dm=
sg(flags, =2E=2E=2E)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span> </span><br><span> void x_msg(const unsigned int flag=
s, const char *format, =2E=2E=2E); /* should be called via msg above */</sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1=
214d27 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1942 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>

</body></html>
--nqH83da2RTI=--


--===============6848095559750554240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6848095559750554240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6848095559750554240==--

