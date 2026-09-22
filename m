Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCA6C982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbiqbK4qDh/hh/wJC4HOlMmJFirxz9UBEAnaIAenNuQ=; b=SXWJq73CADWbaNC/vvuFBN9/CK
	A5hsCBMOD3nQvBj/k0CUiZulEzqQXxyjGYRecV1LScn6NKPda2zHlkNNU87aune1f806K/svQZ+9d
	DBCatQOyHtw5ZMHuUR12Qtft07ie42x3IwLgKeaYK//E7e2sl/5MiZ+8HcC9p8czODg8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91J8-0000FP-9a;
	Tue, 22 Sep 2026 14:17:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x91J7-0000FE-3a
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:17:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QG01bBdtAfycJx6fiGG30JYO2Nj7uQbGR23Zjgw4Os0=; b=UAtjTV5r1ORyozfJpDmGbpCOiV
 Sxe1+py/IVBwcYXIOGShMOpUlMEU1sMf039ontgucYHma+n2hfcBRUKHCH/2uO9vnrOiXMsD8RMot
 QiSEmps1jFcV1XjugGpwd/OSXllZRAfu3dwIpGGfY/C0qU+axEYRqQo9QU5uOYYaG5UI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QG01bBdtAfycJx6fiGG30JYO2Nj7uQbGR23Zjgw4Os0=; b=l
 tT/XXs26NhrC83f9zhc5mV/z82Qs5ceO0d2nFiYuHB+cSx5Bm2h4OEWFggCEpKXpph83ASKE1ETPE
 YELzqCaUXB4693YYcB2nkqIvvd4NAoPQftAAGuKI+PPsICLdQeuN2iNtj2DTycK3M4Uz1UUZAlDCl
 JcbrCPEn+PN3r/pI=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91J4-0005Ru-TE for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:17:17 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd38e0f79so23887825e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790086628; x=1790691428; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QG01bBdtAfycJx6fiGG30JYO2Nj7uQbGR23Zjgw4Os0=;
 b=MrIIzF8F0yF5mOULB0L/iEXVMjd0vglRtJuv7+r41qsi0q61tneyaFkgQDxpv2O0Ky
 XCZj0yUymf+D5xdTtsErpyWFqmYSINzV5Lg5x1B0PCCbxqRhEq0gZKEj9tWK20IoLxlq
 1VIAZx5Qm7YQ7a6nKmswjQBcgWcpUlgwgIOou9kol+EebFsl+2dDhiRpB37oIDcogJxw
 13GSTHO8VBl6+BqYDOikLyONEFU69V1z8dY4/VvdL6WkKSCpNIrWSwuNvHI5G1jdR4WL
 awiBQlL23Izi8NsQD0Qk90XjWtLcnfMQ+eRNnLUHLa0NvguCikWyIGJi1l0iJgGkMiue
 AxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790086628; x=1790691428;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QG01bBdtAfycJx6fiGG30JYO2Nj7uQbGR23Zjgw4Os0=;
 b=RKhgyodJ/UZg5XlDDu8/FU/BGuANZxKq9fopvZZRIOnsJ5LgexVJjvGXzAwmUqXKIb
 2b/KLAP40BA8x55TeQracN59nAI0IJnBOfQTbo6oDoG1iJxaUQ513+u7FX4vE5g3Z0LR
 nYol1xp5v+uk4rh74D09UK5aKa5nmQA4bspPaxpXSgG7Eryd8m/QTSy9lHC4OVs1wmLL
 jgwdpwAKhDHuntZC0MG+R3SO+ziDB4NFg5VCvD9CIsy/mk96JdfF2EWS3NVIx3bvL+yt
 K/UPd3F1ZRYDRGKCc4fggzhMUqOG1lIIz/GCAhJObeGajOIzFqh0ag99GmnOYorgWtTk
 7J7Q==
X-Gm-Message-State: AFuF++lKNC+qrNaGyhRAlnI7ZG0LiQ47XuQo/F8+IZI8UYFDe2NYdNFs
 EBljjmVAmh5vtGm0J/yFk0f5B4kVF8OTWu6uix3gzSMnWlsBU07U84xpiUPY+DB274WhOLb3aaV
 Ns3zgpK/AFUipb44DbRJEtsiTDi5czEZxKReiaD3MX6B3+UT+6fH/Yary3SL13/nxK1wsPgw0hP
 wNHrOmUA==
X-Gm-Gg: AYBFou1LmtY9n7eBy10D9DHJCqNkgKgNj1DXQJY5el2IA9zZ/J7StItSTc8+n/cF/8p
 ffSUw4qgi82nzii9ZRLROu9psAKskknVcYiCKwUo5D+4NQF9emigoGNEYOB1/5w7sC1d6VmHqkP
 8p/oq0Og54uWGG/JsQxkUlDauqaw9BzQ+5QAGiXQbjeIrCeFbwKGFiBd9rOLIQyQVGmMNa8GF5I
 tJEwiluD0dgp/Au7eplvLaOn3/TVVx8GEhWUeV9OAJ1tqnTzJmXK0ECFK7VIBFdh7iwNeMT/vDN
 trocDkRmH7RCkBW14c95P2izFlQTwHBBHXuYda1iqKvXZcM9gFq3l8rPzXsrOuTasBIs0MalYrI
 Uh9ZxliBGDoAJpVUGB5H+x641+WYsqx4TB2PGtKmFQTOo9cNBeW6omdIrnLsFdEt2oKEAK9BpEz
 /hGzVdFrGcHeCiGt3z18fJ4MWGKLagFOTrC6CyCkBlwPDlx3QDnzmz32I9ah5KKkRdtT4zzTUMQ
 zFnjIkVT4uWfcX/d4QIfByS3a/HlbQ16Us1bmRRhebOhUPNGs2DJCNP8exQZd8GfDefl+oc6jK5
 3yXItmT1gieuTZ4nMdJ/EerGx03AeEqX+5AJ6nH92PaBYQi6c7V5oucoD16OnV+5E9/J7AvX
X-Received: by 2002:a05:600c:8b72:b0:49e:6692:27fd with SMTP id
 5b1f17b1804b1-49fc566458cmr291230675e9.2.1790086627890; 
 Tue, 22 Sep 2026 07:17:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8ce24fesm131177125e9.12.2026.09.22.07.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:17:07 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 14:17:05 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: b5441a00d42b8562b077cc63c9c2622eec52903d
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <96b2b36c02189a79e56759e7c85242a29d587d57-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x91J4-0005Ru-TE
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
Content-Type: multipart/mixed; boundary="===============0535306091287864383=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0535306091287864383==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5nSuACHkc7Y="; charset=UTF-8

--5nSuACHkc7Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new pa=
tch set (#3)=2E

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

Change-Id: I3f96cd1c3488b558b8a59759=
4d99edcba1214d27
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=2Eh=2Ecmake=
=2Ein
M configure=2Eac
M src/openvpn/compstub=2Ec
M src/openvpn/crypto_mbed=
tls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/error=2Eh
M s=
rc/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/mroute=2Ec
M s=
rc/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/op=
envpn/multi_io=2Ec
M src/openvpn/options=2Ec
M src/openvpn/packet_id=2Ec
M =
src/openvpn/plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/reliable=2Ec
=
M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl/error=2Eh
2=
3 files changed, 46 insertions(+), 39 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/3

diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
--- a/CMake=
Lists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 =
"BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings =
as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not us=
e actual cross compile/Android cmake to build for simple compile checks on =
Linux")
+option(ENABLE_DEBUG "Enable building with debug" OFF)
 
 option(EN=
ABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS_=
UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRI=
NG "Default location for the DNS up/down script")
diff --git a/Changes=2Emd=
 b/Changes=2Emd
index 2684251=2E=2E7763d59 100644
--- a/Changes=2Emd
+++ b/=
Changes=2Emd
@@ -23,6 +23,11 @@
   the characters mentioned above were alre=
ady escaped=2E However, the behavior of
   Mbed TLS is slightly different f=
rom OpenSSL in that it also escapes "=3D"=2E
 
+## Maintainer-visible chang=
es
+
+- The configure-time option `--enable-debug` is no longer
+  availabl=
e and the verbose logging is now always included=2E
+
 # Overview of change=
s in 2=2E7
 
 ## New features
diff --git a/config=2Eh=2Ecmake=2Ein b/config=
=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=2Ec6c0a96 100644
--- a/config=2Eh=2Ecmak=
e=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -18,8 +18,8 @@
 /* Enable shared da=
ta channel offload */
 #cmakedefine ENABLE_DCO
 
-/* Enable debugging suppo=
rt (needed for verb>=3D4) */
-#define ENABLE_DEBUG 1
+/* Enable debugging s=
upport */
+#cmakedefine ENABLE_DEBUG
 
 /* Enable internal fragmentation su=
pport */
 #define ENABLE_FRAGMENT 1
diff --git a/configure=2Eac b/configure=
=2Eac
index 469a475=2E=2E47e4759 100644
--- a/configure=2Eac
+++ b/configur=
e=2Eac
@@ -131,9 +131,9 @@
 
 AC_ARG_ENABLE(
 	[debug],
-	[AS_HELP_STRING([=
--disable-debug], [disable debugging support (disable gremlin and verb 7+ m=
essages) @<:@default=3Dyes@:>@])],
+	[AS_HELP_STRING([--enable-developer-de=
bug], [enable developer debugging support (enable gremlin) @<:@default=3Dye=
s@:>@])],
 	,
-	[enable_debug=3D"yes"]
+	[enable_debug=3D"no"]
 )
 
 AC_ARG=
_ENABLE(
diff --git a/src/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec
i=
ndex f0c89f7=2E=2E2eef587 100644
--- a/src/openvpn/compstub=2Ec
+++ b/src/o=
penvpn/compstub=2Ec
@@ -125,7 +125,7 @@
         return;
     }
 
-    uint=
8_t *head =3D BPTR(buf);
+    const uint8_t *head =3D BPTR(buf);
 
     /* =
no compression or packet to short*/
     if (head[0] !=3D COMP_ALGV2_INDICA=
TOR_BYTE)
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_=
mbedtls=2Ec
index 0c5beb4=2E=2E9d19902 100644
--- a/src/openvpn/crypto_mbed=
tls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -842,7 +842,7 @@
     struc=
t gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef=
 ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     /* used by the D_SHOW_KEY_SOURCE, =
guarded with ENABLE_DEBUG to avoid unused
      * variables warnings if com=
piled with --enable-small */
     const size_t olen_orig =3D olen;
diff --g=
it a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_leg=
acy=2Ec
index bbd012f6=2E=2Ef46d8bf 100644
--- a/src/openvpn/crypto_mbedtls=
_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -989,8 +989,8 @@=

     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH]=
;
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guarded wit=
h ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by the D_=
SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
      * variable=
s warnings if compiled with --enable-small */
     const size_t olen_orig =
=3D olen;
     const uint8_t *out_orig =3D out;
diff --git a/src/openvpn/er=
ror=2Eh b/src/openvpn/error=2Eh
index a887fc7=2E=2E5811bef 100644
--- a/src=
/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -158,7 +158,7 @@
        =
 }                                \
         EXIT_FATAL(flags);            =
   \
     } while (false)
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 #defi=
ne dmsg(flags, =2E=2E=2E)                 \
     do                        =
           \
     {                                    \
diff --git a/src/o=
penvpn/event=2Ec b/src/openvpn/event=2Ec
index 8b7716a=2E=2E2cb4e04 100644
=
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -398,7 +398,7 @@=

 
     dmsg(D_EVENT_WAIT, "WE_WAIT enter n=3D%d to=3D%d", wes->n_events, t=
imeout);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_=
level(D_EVENT_WAIT))
     {
         int i;
diff --git a/src/openvpn/forwar=
d=2Ec b/src/openvpn/forward=2Ec
index 6fe5849=2E=2E7811245 100644
--- a/src=
/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -50,7 +50,7 @@
 
 /* =
show event wait debugging info */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SM=
ALL
 
 static const char *
 wait_status_string(struct context *c, struct gc=
_arena *gc)
@@ -2190,7 +2190,7 @@
         {
             int status;
 
-#i=
fdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
             if (check_debug_level(=
D_EVENT_WAIT))
             {
                 show_wait_status(c);
diff --=
git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 39fa482=2E=2E26=
1d25a 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -=
501,7 +501,7 @@
     }
     mh->n_net_len =3D j;
 
-#ifdef ENABLE_DEBUG
+#i=
fndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
      =
   struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/mtcp=2Ec b/src=
/openvpn/mtcp=2Ec
index 5d88f8a=2E=2Eb0125f1 100644
--- a/src/openvpn/mtcp=
=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -74,7 +74,7 @@
         mi->did_real_has=
h =3D true;
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (mi=
)
     {
         dmsg(D_MULTI_DEBUG, "MULTI TCP: instance added: %s", mrou=
te_addr_print(&mi->real, &gc));
diff --git a/src/openvpn/mudp=2Ec b/src/ope=
nvpn/mudp=2Ec
index 88b0091=2E=2E4794b7e 100644
--- a/src/openvpn/mudp=2Ec
=
+++ b/src/openvpn/mudp=2Ec
@@ -431,7 +431,7 @@
         }
     }
 
-#ifdef =
ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG=
))
     {
         struct gc_arena gc =3D gc_new();
diff --git a/src/openvp=
n/multi=2Ec b/src/openvpn/multi=2Ec
index 3e72b92=2E=2E67204c3 100644
--- a=
/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1145,7 +1145,7 @@
  =
       }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check=
_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new(=
);
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 3=
604684=2E=2E4b96c57 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn=
/multi_io=2Ec
@@ -46,7 +46,7 @@
 #define MULTI_IO_FILE_CLOSE_WRITE ((void *=
)5)
 #define MULTI_IO_DCO              ((void *)6)
 
-#ifdef ENABLE_DEBUG
+=
#ifndef ENABLE_SMALL
 static const char *
 pract(int action)
 {
@@ -89,7 +8=
9,7 @@
             return "?";
     }
 }
-#endif /* ENABLE_DEBUG */
+#endi=
f
 
 static inline struct context *
 multi_get_context(struct multi_context=
 *m, struct multi_instance *mi)
diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec
index e3cd527=2E=2Ee8ec9db 100644
--- a/src/openvpn/opt=
ions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -785,7 +785,7 @@
 #endif /* ENABL=
E_PKCS11 */
     "\n"
     "General Standalone Options:\n"
-#ifdef ENABLE_D=
EBUG
+#ifndef ENABLE_SMALL
     "--show-gateway [address]: Show info about =
gateway [to v4/v6 address]=2E\n"
 #endif
     ;
@@ -4229,7 +4229,7 @@
     =
    read_config_file(options, p[1], level, file, line, msglevel, permission=
_mask,
                          option_types_found, es);
     }
-#if defin=
ed(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
     else =
if (streq(p[0], "show-gateway") && !p[2])
     {
         struct route_gate=
way_info rgi;
@@ -4938,12 +4938,13 @@
              * mbed TLS always gener=
ating debug level logging */
             options->ssl_flags |=3D SSLF_TLS_=
DEBUG_ENABLED;
         }
-#if !defined(ENABLE_DEBUG) && !defined(ENABLE_SM=
ALL)
+#if defined(ENABLE_SMALL)
         /* Warn when a debug verbosity is =
supplied when built without debug support */
         if (options->verbosit=
y >=3D 7)
         {
             msg(M_WARN,
-                "NOTE: debug=
 verbosity (--verb %d) is enabled but this build lacks debug support=2E",
+=
                "NOTE: debug verbosity (--verb %d) is enabled but this buil=
d is "
+                "built with --enable-small that lacks support for h=
igh --verb settings",
                 options->verbosity);
         }
 #en=
dif
diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec
inde=
x a4b627c=2E=2E22c53c7 100644
--- a/src/openvpn/packet_id=2Ec
+++ b/src/ope=
nvpn/packet_id=2Ec
@@ -52,18 +52,18 @@
 #define SEQ_UNSEEN  ((time_t)0)
 #d=
efine SEQ_EXPIRED ((time_t)1)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
=
 static void packet_id_debug_print(msglvl_t msglevel, const struct packet_i=
d_rec *p,
                                   const struct packet_id_net *pi=
n, const char *message,
                                   packet_id_print_=
type value);
 
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline void
 pa=
cket_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,
           =
      const struct packet_id_net *pin, const char *message, uint64_t value)=

 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (unlikely(check_debu=
g_level(msglevel)))
     {
         packet_id_debug_print(msglevel, p, pin,=
 message, value);
@@ -576,7 +576,7 @@
     return (char *)out=2Edata;
 }
 
=
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 packet_id_debug_=
print(msglvl_t msglevel, const struct packet_id_rec *p,
@@ -648,7 +648,7 @@=

     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 
 uint16=
_t
 packet_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)
dif=
f --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index f8adde5=2E=
=2Ed10f9fa 100644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec=

@@ -993,7 +993,7 @@
     pr->n =3D 0;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef E=
NABLE_SMALL
 void
 plugin_return_print(const msglvl_t msglevel, const char =
*prefix, const struct plugin_return *pr)
 {
diff --git a/src/openvpn/plugin=
=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2E684632c 100644
--- a/src/o=
penvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,7 +135,7 @@
 
 void =
plugin_return_free(struct plugin_return *pr);
 
-#ifdef ENABLE_DEBUG
+#ifnd=
ef ENABLE_SMALL
 void plugin_return_print(const msglvl_t msglevel, const ch=
ar *prefix, const struct plugin_return *pr);
 
 #endif
diff --git a/src/ope=
nvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index ced438e=2E=2Eb5315ff 100=
644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -462,7=
 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 /* print=
 the current sequence of active packet IDs */
 static const char *
 reliabl=
e_print_ids(const struct reliable *rel, struct gc_arena *gc)
@@ -480,7 +480=
,7 @@
     }
     return BSTR(&out);
 }
-#endif /* ENABLE_DEBUG */
+#endif
=
 
 /* true if at least one free buffer available */
 bool
diff --git a/src/=
openvpn/route=2Ec b/src/openvpn/route=2Ec
index 03a2526=2E=2Ee8001b3 100644=

--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -81,7 +81,7 @@
=
 
 static void get_bypass_addresses(struct route_bypass *rb, const unsigned=
 int flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 p=
rint_bypass_addresses(const struct route_bypass *rb)
@@ -617,7 +617,7 @@
  =
   if (rl->ngi=2Eflags & RGI_ADDR_DEFINED)
     {
         setenv_route_add=
r(es, "net_gateway", rl->ngi=2Egateway=2Eaddr, -1);
-#if defined(ENABLE_DEB=
UG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_default_=
gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
     }
@@ -660,7 +660,7 @@
      =
       add_block_local_routes(rl);
         }
         get_bypass_addresses=
(&rl->spec=2Ebypass, rl->flags);
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL=

         print_bypass_addresses(&rl->spec=2Ebypass);
 #endif
     }
@@ -76=
8,7 +768,7 @@
     if (rl6->ngi6=2Eflags & RGI_ADDR_DEFINED)
     {
       =
  setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6=2Egateway=2Ea=
ddr_ipv6, 0, &gc));
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#=
ifndef ENABLE_SMALL
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi=
6);
 #endif
     }
diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/sche=
dule=2Ec
index 6772ad6=2E=2E6c60dc2 100644
--- a/src/openvpn/schedule=2Ec
+=
++ b/src/openvpn/schedule=2Ec
@@ -33,7 +33,7 @@
 
 #include "memdbg=2Eh"
 
=
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void
 schedule_entry_deb=
ug_info(const char *caller, const struct schedule_entry *e)
 {
@@ -308,7 +3=
08,7 @@
 void
 schedule_add_modify(struct schedule *s, struct schedule_entr=
y *e)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_le=
vel(D_SCHEDULER))
     {
         schedule_entry_debug_info("schedule_add_m=
odify", e);
@@ -355,7 +355,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#=
ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {
       =
  schedule_entry_debug_info("schedule_find_least", e);
diff --git a/src/tap=
ctl/error=2Eh b/src/tapctl/error=2Eh
index f9586dc=2E=2E34aa894 100644
--- =
a/src/tapctl/error=2Eh
+++ b/src/tapctl/error=2Eh
@@ -83,7 +83,7 @@
       =
  }                                \
         EXIT_FATAL(flags);           =
    \
     } while (false)
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 #def=
ine dmsg(flags, =2E=2E=2E)                 \
     do                       =
            \
     {                                    \

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba=
1214d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet: 3
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: flichtenheld <frank@lichtenheld=2Ecom>

--5nSuACHkc7Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://ge=
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
le this option<br>by default=2E<br><br>Change-Id: I3f96cd1c3488b558b8a59759=
4d99edcba1214d27<br>---<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=
=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/openvpn/compstub=2Ec<br>M sr=
c/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>=
M src/openvpn/error=2Eh<br>M src/openvpn/event=2Ec<br>M src/openvpn/forward=
=2Ec<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn=
/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src=
/openvpn/options=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/plugin=
=2Ec<br>M src/openvpn/plugin=2Eh<br>M src/openvpn/reliable=2Ec<br>M src/ope=
nvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/tapctl/error=2Eh<br>2=
3 files changed, 46 insertions(+), 39 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/194=
2/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><spa=
n>index 6eb5954=2E=2Ed553697 100644</span><br><span>--- a/CMakeLists=2Etxt<=
/span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -40,6 +40,7 @@</s=
pan><br><span> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-helper&quot; ON=
)</span><br><span> option(USE_WERROR &quot;Treat compiler warnings as error=
s (-Werror)&quot; ON)</span><br><span> option(FAKE_ANDROID &quot;Target And=
roid but do not use actual cross compile/Android cmake to build for simple =
compile checks on Linux&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+option(ENABLE_DEBUG &quot;Enable building with debug&quot; OFF)<=
/span><br><span> </span><br><span> option(ENABLE_DNS_UPDOWN_BY_DEFAULT &quo=
t;Run --dns-updown hook by default&quot; ON)</span><br><span> set(DNS_UPDOW=
N_PATH &quot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&quot; CACHE=
 STRING &quot;Default location for the DNS up/down script&quot;)</span><br>=
<span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 268425=
1=2E=2E7763d59 100644</span><br><span>--- a/Changes=2Emd</span><br><span>++=
+ b/Changes=2Emd</span><br><span>@@ -23,6 +23,11 @@</span><br><span>   the =
characters mentioned above were already escaped=2E However, the behavior of=
</span><br><span>   Mbed TLS is slightly different from OpenSSL in that it =
also escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+## Maintainer-visible changes</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+- The configure-time option `--enable-debug` is no lon=
ger</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  available and =
the verbose logging is now always included=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> # Overview of changes in 2=2E7<=
/span><br><span> </span><br><span> ## New features</span><br><span>diff --g=
it a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>inde=
x c3bb5a5=2E=2Ec6c0a96 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein=
</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -18,8 +18=
,8 @@</span><br><span> /* Enable shared data channel offload */</span><br><=
span> #cmakedefine ENABLE_DCO</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/* Enable debugging support (needed for verb&gt;=
=3D4) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ENABL=
E_DEBUG 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable =
debugging support */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#cmakedefine ENABLE_DEBUG</span><br><span> </span><br><span> /* Enable int=
ernal fragmentation support */</span><br><span> #define ENABLE_FRAGMENT 1</=
span><br><span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span=
>index 469a475=2E=2E47e4759 100644</span><br><span>--- a/configure=2Eac</sp=
an><br><span>+++ b/configure=2Eac</span><br><span>@@ -131,9 +131,9 @@</span=
><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span> 	[debug],</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AS_HELP_STRING([--disab=
le-debug], [disable debugging support (disable gremlin and verb 7+ messages=
) @&lt;:@default=3Dyes@:&gt;@])],</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	[AS_HELP_STRING([--enable-developer-debug], [enable develope=
r debugging support (enable gremlin) @&lt;:@default=3Dyes@:&gt;@])],</span>=
<br><span> 	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[enable=
_debug=3D&quot;yes&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	[enable_debug=3D&quot;no&quot;]</span><br><span> )</span><br><span> =
</span><br><span> AC_ARG_ENABLE(</span><br><span>diff --git a/src/openvpn/c=
ompstub=2Ec b/src/openvpn/compstub=2Ec</span><br><span>index f0c89f7=2E=2E2=
eef587 100644</span><br><span>--- a/src/openvpn/compstub=2Ec</span><br><spa=
n>+++ b/src/openvpn/compstub=2Ec</span><br><span>@@ -125,7 +125,7 @@</span>=
<br><span>         return;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_=
t *head =3D BPTR(buf);</span><br><span> </span><br><span>     /* no compres=
sion or packet to short*/</span><br><span>     if (head[0] !=3D COMP_ALGV2_=
INDICATOR_BYTE)</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec=
 b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 0c5beb4=2E=2E9d1990=
2 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><sp=
an>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -842,7 +842,7 @@=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>    =
 uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>    =
 /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unuse=
d</span><br><span>      * variables warnings if compiled with --enable-smal=
l */</span><br><span>     const size_t olen_orig =3D olen;</span><br><span>=
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbe=
dtls_legacy=2Ec</span><br><span>index bbd012f6=2E=2Ef46d8bf 100644</span><b=
r><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ b/s=
rc/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -989,8 +989,8 @@</s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     ui=
nt8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guarded with=
 ENABLE_DEBUG to avoid unused</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL =
to avoid unused</span><br><span>      * variables warnings if compiled with=
 --enable-small */</span><br><span>     const size_t olen_orig =3D olen;</s=
pan><br><span>     const uint8_t *out_orig =3D out;</span><br><span>diff --=
git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span>index a=
887fc7=2E=2E5811bef 100644</span><br><span>--- a/src/openvpn/error=2Eh</spa=
n><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -158,7 +158,7 @@=
</span><br><span>         }                                \</span><br><spa=
n>         EXIT_FATAL(flags);               \</span><br><span>     } while =
(false)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE=
_SMALL</span><br><span> #define dmsg(flags, =2E=2E=2E)                 \</s=
pan><br><span>     do                                   \</span><br><span> =
    {                                    \</span><br><span>diff --git a/src=
/openvpn/event=2Ec b/src/openvpn/event=2Ec</span><br><span>index 8b7716a=2E=
=2E2cb4e04 100644</span><br><span>--- a/src/openvpn/event=2Ec</span><br><sp=
an>+++ b/src/openvpn/event=2Ec</span><br><span>@@ -398,7 +398,7 @@</span><b=
r><span> </span><br><span>     dmsg(D_EVENT_WAIT, &quot;WE_WAIT enter n=3D%=
d to=3D%d&quot;, wes-&gt;n_events, timeout);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><sp=
an>     if (check_debug_level(D_EVENT_WAIT))</span><br><span>     {</span><=
br><span>         int i;</span><br><span>diff --git a/src/openvpn/forward=
=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 6fe5849=2E=2E7811245 1=
00644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/s=
rc/openvpn/forward=2Ec</span><br><span>@@ -50,7 +50,7 @@</span><br><span> <=
/span><br><span> /* show event wait debugging info */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</spa=
n><br><span> </span><br><span> static const char *</span><br><span> wait_st=
atus_string(struct context *c, struct gc_arena *gc)</span><br><span>@@ -219=
0,7 +2190,7 @@</span><br><span>         {</span><br><span>             int =
status;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef ENABLE_SMALL</span><br><span>             if (check_debug_level=
(D_EVENT_WAIT))</span><br><span>             {</span><br><span>            =
     show_wait_status(c);</span><br><span>diff --git a/src/openvpn/mroute=
=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 39fa482=2E=2E261d25a 10=
0644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src=
/openvpn/mroute=2Ec</span><br><span>@@ -501,7 +501,7 @@</span><br><span>   =
  }</span><br><span>     mh-&gt;n_net_len =3D j;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br=
><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {</s=
pan><br><span>         struct gc_arena gc =3D gc_new();</span><br><span>dif=
f --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index=
 5d88f8a=2E=2Eb0125f1 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</sp=
an><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -74,7 +74,7 @@</=
span><br><span>         mi-&gt;did_real_hash =3D true;</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef ENABLE_SMALL</span><br><span>     if (mi)</span><br><span>     {</sp=
an><br><span>         dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: instance added: =
%s&quot;, mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>inde=
x 88b0091=2E=2E4794b7e 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</s=
pan><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -431,7 +431,7 @=
@</span><br><span>         }</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span>=
<br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {=
</span><br><span>         struct gc_arena gc =3D gc_new();</span><br><span>=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>=
index 3e72b92=2E=2E67204c3 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -1145,7=
 +1145,7 @@</span><br><span>         }</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEB=
UG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SM=
ALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br><s=
pan>     {</span><br><span>         struct gc_arena gc =3D gc_new();</span>=
<br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec<=
/span><br><span>index 3604684=2E=2E4b96c57 100644</span><br><span>--- a/src=
/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span>=
<br><span>@@ -46,7 +46,7 @@</span><br><span> #define MULTI_IO_FILE_CLOSE_WR=
ITE ((void *)5)</span><br><span> #define MULTI_IO_DCO              ((void *=
)6)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef ENABLE_SMALL</span><br><span> static const char *</span><br><span> =
pract(int action)</span><br><span> {</span><br><span>@@ -89,7 +89,7 @@</spa=
n><br><span>             return &quot;?&quot;;</span><br><span>     }</span=
><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> static inline struct context *</spa=
n><br><span> multi_get_context(struct multi_context *m, struct multi_instan=
ce *mi)</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/=
options=2Ec</span><br><span>index e3cd527=2E=2Ee8ec9db 100644</span><br><sp=
an>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -785,7 +785,7 @@</span><br><span> #endif /* ENABLE_=
PKCS11 */</span><br><span>     &quot;\n&quot;</span><br><span>     &quot;Ge=
neral Standalone Options:\n&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     &quot;--show-gateway =
[address]: Show info about gateway [to v4/v6 address]=2E\n&quot;</span><br>=
<span> #endif</span><br><span>     ;</span><br><span>@@ -4229,7 +4229,7 @@<=
/span><br><span>         read_config_file(options, p[1], level, file, line,=
 msglevel, permission_mask,</span><br><span>                          optio=
n_types_found, es);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_S=
MALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE=
_SMALL</span><br><span>     else if (streq(p[0], &quot;show-gateway&quot;) =
&amp;&amp; !p[2])</span><br><span>     {</span><br><span>         struct ro=
ute_gateway_info rgi;</span><br><span>@@ -4938,12 +4938,13 @@</span><br><sp=
an>              * mbed TLS always generating debug level logging */</span>=
<br><span>             options-&gt;ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;</=
span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if !defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_SMALL)</spa=
n><br><span>         /* Warn when a debug verbosity is supplied when built =
without debug support */</span><br><span>         if (options-&gt;verbosity=
 &gt;=3D 7)</span><br><span>         {</span><br><span>             msg(M_W=
ARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &=
quot;NOTE: debug verbosity (--verb %d) is enabled but this build lacks debu=
g support=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;NOTE: debug verbosity (--verb %d) is enabled but this=
 build is &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             &quot;built with --enable-small that lacks support for high --=
verb settings&quot;,</span><br><span>                 options-&gt;verbosity=
);</span><br><span>         }</span><br><span> #endif</span><br><span>diff =
--git a/src/openvpn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><sp=
an>index a4b627c=2E=2E22c53c7 100644</span><br><span>--- a/src/openvpn/pack=
et_id=2Ec</span><br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@=
@ -52,18 +52,18 @@</span><br><span> #define SEQ_UNSEEN  ((time_t)0)</span><=
br><span> #define SEQ_EXPIRED ((time_t)1)</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>=
 static void packet_id_debug_print(msglvl_t msglevel, const struct packet_i=
d_rec *p,</span><br><span>                                   const struct p=
acket_id_net *pin, const char *message,</span><br><span>                   =
                packet_id_print_type value);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> static inline void</span><br><span> packet_id_debug(msglvl_t =
msglevel, const struct packet_id_rec *p,</span><br><span>                 c=
onst struct packet_id_net *pin, const char *message, uint64_t value)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef EN=
ABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef E=
NABLE_SMALL</span><br><span>     if (unlikely(check_debug_level(msglevel)))=
</span><br><span>     {</span><br><span>         packet_id_debug_print(msgl=
evel, p, pin, message, value);</span><br><span>@@ -576,7 +576,7 @@</span><b=
r><span>     return (char *)out=2Edata;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL=
</span><br><span> </span><br><span> static void</span><br><span> packet_id_=
debug_print(msglvl_t msglevel, const struct packet_id_rec *p,</span><br><sp=
an>@@ -648,7 +648,7 @@</span><br><span>     gc_free(&amp;gc);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span> </span><br><span> uint16_t</span><br>=
<span> packet_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)<=
/span><br><span>diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2E=
c</span><br><span>index f8adde5=2E=2Ed10f9fa 100644</span><br><span>--- a/s=
rc/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><b=
r><span>@@ -993,7 +993,7 @@</span><br><span>     pr-&gt;n =3D 0;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef ENABLE_SMALL</span><br><span> void</span><br><span> plugin_ret=
urn_print(const msglvl_t msglevel, const char *prefix, const struct plugin_=
return *pr)</span><br><span> {</span><br><span>diff --git a/src/openvpn/plu=
gin=2Eh b/src/openvpn/plugin=2Eh</span><br><span>index 7e9faf3=2E=2E684632c=
 100644</span><br><span>--- a/src/openvpn/plugin=2Eh</span><br><span>+++ b/=
src/openvpn/plugin=2Eh</span><br><span>@@ -135,7 +135,7 @@</span><br><span>=
 </span><br><span> void plugin_return_free(struct plugin_return *pr);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef EN=
ABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef E=
NABLE_SMALL</span><br><span> void plugin_return_print(const msglvl_t msglev=
el, const char *prefix, const struct plugin_return *pr);</span><br><span> <=
/span><br><span> #endif</span><br><span>diff --git a/src/openvpn/reliable=
=2Ec b/src/openvpn/reliable=2Ec</span><br><span>index ced438e=2E=2Eb5315ff =
100644</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b=
/src/openvpn/reliable=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> /* print the=
 current sequence of active packet IDs */</span><br><span> static const cha=
r *</span><br><span> reliable_print_ids(const struct reliable *rel, struct =
gc_arena *gc)</span><br><span>@@ -480,7 +480,7 @@</span><br><span>     }</s=
pan><br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span=
><br><span> /* true if at least one free buffer available */</span><br><spa=
n> bool</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/ro=
ute=2Ec</span><br><span>index 03a2526=2E=2Ee8001b3 100644</span><br><span>-=
-- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</spa=
n><br><span>@@ -81,7 +81,7 @@</span><br><span> </span><br><span> static voi=
d get_bypass_addresses(struct route_bypass *rb, const unsigned int flags);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span> </span><br><span> static void</span><br><=
span> print_bypass_addresses(const struct route_bypass *rb)</span><br><span=
>@@ -617,7 +617,7 @@</span><br><span>     if (rl-&gt;ngi=2Eflags &amp; RGI_=
ADDR_DEFINED)</span><br><span>     {</span><br><span>         setenv_route_=
addr(es, &quot;net_gateway&quot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &am=
p;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         print_default_gate=
way(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><span> #endif</span><br><spa=
n>     }</span><br><span>@@ -660,7 +660,7 @@</span><br><span>             a=
dd_block_local_routes(rl);</span><br><span>         }</span><br><span>     =
    get_bypass_addresses(&amp;rl-&gt;spec=2Ebypass, rl-&gt;flags);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br=
><span>         print_bypass_addresses(&amp;rl-&gt;spec=2Ebypass);</span><b=
r><span> #endif</span><br><span>     }</span><br><span>@@ -768,7 +768,7 @@<=
/span><br><span>     if (rl6-&gt;ngi6=2Eflags &amp; RGI_ADDR_DEFINED)</span=
><br><span>     {</span><br><span>         setenv_str(es, &quot;net_gateway=
_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_=
DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         print_de=
fault_gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</s=
pan><br><span>     }</span><br><span>diff --git a/src/openvpn/schedule=2Ec =
b/src/openvpn/schedule=2Ec</span><br><span>index 6772ad6=2E=2E6c60dc2 10064=
4</span><br><span>--- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/=
openvpn/schedule=2Ec</span><br><span>@@ -33,7 +33,7 @@</span><br><span> </s=
pan><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><=
span> static void</span><br><span> schedule_entry_debug_info(const char *ca=
ller, const struct schedule_entry *e)</span><br><span> {</span><br><span>@@=
 -308,7 +308,7 @@</span><br><span> void</span><br><span> schedule_add_modif=
y(struct schedule *s, struct schedule_entry *e)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br=
><span>     if (check_debug_level(D_SCHEDULER))</span><br><span>     {</spa=
n><br><span>         schedule_entry_debug_info(&quot;schedule_add_modify&qu=
ot;, e);</span><br><span>@@ -355,7 +355,7 @@</span><br><span>         }</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_l=
evel(D_SCHEDULER))</span><br><span>     {</span><br><span>         schedule=
_entry_debug_info(&quot;schedule_find_least&quot;, e);</span><br><span>diff=
 --git a/src/tapctl/error=2Eh b/src/tapctl/error=2Eh</span><br><span>index =
f9586dc=2E=2E34aa894 100644</span><br><span>--- a/src/tapctl/error=2Eh</spa=
n><br><span>+++ b/src/tapctl/error=2Eh</span><br><span>@@ -83,7 +83,7 @@</s=
pan><br><span>         }                                \</span><br><span> =
        EXIT_FATAL(flags);               \</span><br><span>     } while (fa=
lse)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEB=
UG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SM=
ALL</span><br><span> #define dmsg(flags, =2E=2E=2E)                 \</span=
><br><span>     do                                   \</span><br><span>    =
 {                                    \</span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">chang=
e 1942</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1942 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

=
</body></html>
--5nSuACHkc7Y=--


--===============0535306091287864383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0535306091287864383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0535306091287864383==--

