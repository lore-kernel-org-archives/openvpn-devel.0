Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F19C982FA
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 09:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=biC0xd70SrD/sZwa1SeVfO/PHo2ggyQi7E9VV3mtQNk=; b=dfcrzI4Ue+paAxGU6+oMF8Hnp4
	tu/08XDnzJk3UJ3b70VcLyqz0uPNrnc86eTmPbebFmCzscVW0KJlOvGUtBR0HAz5Im8CtUd1pH8qk
	DHoPhhjhNobRF723hTTW1+5oXzWKvrVtPLl4jJ1YCuNapBMWlF8WbfTN+0MPPTY/RBK8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Jf7-00024M-Nl;
	Wed, 23 Sep 2026 09:53:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Jf6-00024G-He
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l+uDse2rMZDTINiemDESrRvZqYn87DRGEW1Ruu2/DYI=; b=HFdxo5VePYqC5RrOUp6c8+3wbM
 lmb3GXLx56pRAsGV5xgS+5PYwTf/lL1P0HjoGricg2r7gaxkrBxOrmH5bRWf0Zs7jHcBOHh/IMGL/
 2KWP0IE2FLy8ctrpEVkJkiTMVYCdrvXDlD3IV5YoOD7s/RbBfToey4p0W41vNiWIc5ZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l+uDse2rMZDTINiemDESrRvZqYn87DRGEW1Ruu2/DYI=; b=E
 AmkG25GBrU4f3dU9El8zURaQbxB/nhgeRqHN3vO9ZlC8pMOrOCMxnOB4nMe+woA7zfs1t+vUTL3I2
 j5mdWTdGj4vprlpciDEyGLX8wDH0LcuyPGyxQbSXI8fl2fo9Mby4Km5luJCZtpmZLvC2KTCVCxWSk
 uuLN/g5GyMnqpp78=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Jf2-0003Mv-Vd for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 09:53:13 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso3094905e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790157182; x=1790761982; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l+uDse2rMZDTINiemDESrRvZqYn87DRGEW1Ruu2/DYI=;
 b=Iie5hmoyYsvyXFjN3Hy30GSN32QDLqQTFxAR7MSDec8tOLHFPTq5hvWhlezWsFU4h4
 x1cHqO8PZfBH1dTCZ0E4GAQ6hsIxSitimVP6QnMC0JQ4uJu1LFLWHp+yizKVQHhl4JRV
 4LxvZue0eRPSM6fp6ndwuchH+aj00aymAetGIz1gGrHn6AgzFRPeGmN8yEhOO9bv8Z3V
 9Ese1YdRu8YjgPmi2OpM1x4rO0xDJX+fW7w3YBheHeQvKJM+HlrXPJTgCmFZkEYeyLd8
 W0r8Plkma1DbuJVncv9zkRJtrSeyHRM3eUTrF6kh9YOF7IMo+dZBM/tWisBaxb6mJBCb
 lpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790157182; x=1790761982;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l+uDse2rMZDTINiemDESrRvZqYn87DRGEW1Ruu2/DYI=;
 b=UAOehQMKyHIekeTLBQ9x/wKoMmgUA5kgRYGbiSKttKcWEGIk+xZZ2Crl4FintHwI7B
 mcU7RMCzgxy+oQH6nzvYWxgdYuQk+X6N/WF45eK20L5ikhtfIvKxJ4dS0VO4rMsf6GuV
 f3mPOJwWDB7JjbRpmskR03h/3wbK2QZvax7amfaRGLgjK98JdKpra1Sw1I0VjziWiqoF
 8jQOZK5/oKLa1eJuydyaM6Ql01cvETH3JPpLs5oNED62pflMEJpCliR3gp6SXLiW38On
 JXm+7yaLG4otkr7gUy2s/Lj6UFyAo7xQiqJEbc9N0fG3do5Z8/rorPbzwaoxzNDevCd8
 Q9aw==
X-Gm-Message-State: AFuF++n8nO1rgFMKgxeMFyGUjW22hTguRHWrviSGSQK+IlNJFUDyJ9Cp
 uG0SnAVvtGb4X9Q8Dq+SdeuldTO/gHExB1BJ4w815HGmPjZ3ghgeTalWWK5Tspn7PcE1o+B9JMp
 VcR4PUsF09AP5qFlyI9emxm1+9o0nZEockGrVGdSjloYaV5szSuXYFtXfEW1zFcDrFdKqBd97GF
 /5hLECGA==
X-Gm-Gg: AYBFou3XLk3nyzzUpKCSEjWnHiYS8aeNK5jf5D+PBIy98LmyD18UtrX0hPuL5Bq9yha
 SsxSRlcwITbisRgjsk8VrALuxX93iEq/gUuU9Rpl24jRg55O/cjcj2WIqqGkbXDMBCQ+aFwLrYY
 0uMqB4aM/sSI2Li6KOPEzz9JQF4XeaEA8NBBjehEhXuFjS03LHE0+XgNulf+WOKbYkcUm+qw9kr
 QcNaTAXBmYwfPrBsI4wWoKQSlbEDNJU42xB5uocxSnAhv02lD0cd5/rWyPVdq8miT68yNYzN54O
 ngAmBgtrQAlIVz9OElUftTn+2YiY461+d7lI2hgH7pgYeLhUrInZxuF0BNC2IsAjGGZPivbx80J
 6r7RKfIaFlnGRR0JKqXzY6s0ibXI7mH3h6wNdbkLT/7sjlNpTq9zsyBi39yDnLw5a03Iu/opv2x
 mG6zDr0cw2k7dYgYuHjL/5eYoPmhx9GD59Tz8hEsqozb4geCCzHH1jNz73+PGio+NeuxIpog7Rr
 1gh2l3XyxoJGxjd834EKaHzT/gnvYPhgo5AcHLowvQ7abM7BfTvCxwuU5nkKN/8UTSuPDms1Wbk
 tXvNIYanbivhormofb/s50LM+xQ4kWMYwJg0v83VvweTp/DvwVss63i2ZFcQ
X-Received: by 2002:a05:600c:1549:b0:49f:ce73:7ac with SMTP id
 5b1f17b1804b1-49fdf352358mr24735955e9.35.1790157181625; 
 Wed, 23 Sep 2026 02:53:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde1ccccfsm61465775e9.7.2026.09.23.02.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 02:53:00 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 09:52:58 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 4632c58ef3da2dd36f66f5420c78c475b32a5a79
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <13e209b295270fbdfe61a7f74eacbcbc30bce9dd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Jf2-0003Mv-Vd
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
Content-Type: multipart/mixed; boundary="===============5411789154425729545=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5411789154425729545==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EPtBStE23Lo="; charset=UTF-8

--EPtBStE23Lo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new patch set (#5=
)=2E


Change subject: Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMA=
LL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change mos=
t ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

Most of these are verbose log=
ging or even enable logging at high
verbosity level or just useful tools li=
ke --show-gateway=2E

We had --enabled-debug on by default forever, so thes=
e "debug"
logs are on by default=2E This patch instead moves them to
enable=
-small=2E

Since the verbose logging is now always enabled
(apart from --en=
able-small), --enable-debug now only covers true
debug options like gremlin=
=2E

Rename the configure option from --enable-debug to
--enable-developer-=
debug to ensure existing build
script/maintainer do not enable this option
=
by default=2E

Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
---
M C=
MakeLists=2Etxt
M Changes=2Emd
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M=
 dev-tools/run-cppcheck=2Esh
M src/openvpn/compstub=2Ec
M src/openvpn/crypt=
o_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/error=
=2Eh
M src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/mroute=
=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
=
M src/openvpn/multi_io=2Ec
M src/openvpn/options=2Ec
M src/openvpn/packet_i=
d=2Ec
M src/openvpn/plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/relia=
ble=2Ec
M src/openvpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl/err=
or=2Eh
24 files changed, 48 insertions(+), 41 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/5

diff --git =
a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
---=
 a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE=
_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler w=
arnings as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but d=
o not use actual cross compile/Android cmake to build for simple compile ch=
ecks on Linux")
+option(ENABLE_DEBUG "Enable building with debug" OFF)
 
 o=
ption(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
 =
set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CA=
CHE STRING "Default location for the DNS up/down script")
diff --git a/Chan=
ges=2Emd b/Changes=2Emd
index 2684251=2E=2E7763d59 100644
--- a/Changes=2Em=
d
+++ b/Changes=2Emd
@@ -23,6 +23,11 @@
   the characters mentioned above w=
ere already escaped=2E However, the behavior of
   Mbed TLS is slightly dif=
ferent from OpenSSL in that it also escapes "=3D"=2E
 
+## Maintainer-visib=
le changes
+
+- The configure-time option `--enable-debug` is no longer
+  =
available and the verbose logging is now always included=2E
+
 # Overview o=
f changes in 2=2E7
 
 ## New features
diff --git a/config=2Eh=2Ecmake=2Ein =
b/config=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=2Ec6c0a96 100644
--- a/config=2E=
h=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -18,8 +18,8 @@
 /* Enable s=
hared data channel offload */
 #cmakedefine ENABLE_DCO
 
-/* Enable debuggi=
ng support (needed for verb>=3D4) */
-#define ENABLE_DEBUG 1
+/* Enable deb=
ugging support */
+#cmakedefine ENABLE_DEBUG
 
 /* Enable internal fragment=
ation support */
 #define ENABLE_FRAGMENT 1
diff --git a/configure=2Eac b/c=
onfigure=2Eac
index 469a475=2E=2E4226515 100644
--- a/configure=2Eac
+++ b/=
configure=2Eac
@@ -131,9 +131,9 @@
 
 AC_ARG_ENABLE(
 	[debug],
-	[AS_HELP_=
STRING([--disable-debug], [disable debugging support (disable gremlin and v=
erb 7+ messages) @<:@default=3Dyes@:>@])],
+	[AS_HELP_STRING([--enable-deve=
loper-debug], [enable developer debugging support (enable gremlin) @<:@defa=
ult=3Dno@:>@])],
 	,
-	[enable_debug=3D"yes"]
+	[enable_debug=3D"no"]
 )
 
=
 AC_ARG_ENABLE(
diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cp=
pcheck=2Esh
index 37de267=2E=2Ed1cfaa8 100755
--- a/dev-tools/run-cppcheck=
=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -21,7 +21,7 @@
 : ${SOURCE_DIR:=
=3D$SCRIPT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$PWD}
 : ${INCLUDE_FLAGS:=3D}
-CPP=
CHECK_DIR=3D"${BUILD_DIR}/cppcheck_build_dir"
+CPPCHECK_DIR=3D"${BUILD_DIR}=
/cppcheck_build_dir_test_arne"
 COMMON_ARGS=3D"-j$(nproc) ${verbosity_arg} =
\
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
  -I=
=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
diff --git a/src/openvpn/com=
pstub=2Ec b/src/openvpn/compstub=2Ec
index f0c89f7=2E=2E2eef587 100644
--- =
a/src/openvpn/compstub=2Ec
+++ b/src/openvpn/compstub=2Ec
@@ -125,7 +125,7 =
@@
         return;
     }
 
-    uint8_t *head =3D BPTR(buf);
+    const u=
int8_t *head =3D BPTR(buf);
 
     /* no compression or packet to short*/
 =
    if (head[0] !=3D COMP_ALGV2_INDICATOR_BYTE)
diff --git a/src/openvpn/cr=
ypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=2E=2E05bb60=
d 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbed=
tls=2Ec
@@ -842,8 +842,8 @@
     struct gc_arena gc =3D gc_new();
     uint=
8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_S=
HOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_S=
MALL
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to av=
oid unused
      * variables warnings if compiled with --enable-small */
  =
   const size_t olen_orig =3D olen;
     const uint8_t *out_orig =3D out;
d=
iff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbed=
tls_legacy=2Ec
index bbd012f6=2E=2Ef46d8bf 100644
--- a/src/openvpn/crypto_=
mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -989,8 +9=
89,8 @@
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_=
LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guar=
ded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by=
 the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
      * v=
ariables warnings if compiled with --enable-small */
     const size_t olen=
_orig =3D olen;
     const uint8_t *out_orig =3D out;
diff --git a/src/open=
vpn/error=2Eh b/src/openvpn/error=2Eh
index a887fc7=2E=2E5811bef 100644
---=
 a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -158,7 +158,7 @@
  =
       }                                \
         EXIT_FATAL(flags);      =
         \
     } while (false)
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
=
 #define dmsg(flags, =2E=2E=2E)                 \
     do                  =
                 \
     {                                    \
diff --git a=
/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 8b7716a=2E=2E2cb4e04 1=
00644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -398,7 +39=
8,7 @@
 
     dmsg(D_EVENT_WAIT, "WE_WAIT enter n=3D%d to=3D%d", wes->n_eve=
nts, timeout);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_=
debug_level(D_EVENT_WAIT))
     {
         int i;
diff --git a/src/openvpn/=
forward=2Ec b/src/openvpn/forward=2Ec
index 6fe5849=2E=2E7811245 100644
---=
 a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -50,7 +50,7 @@
=
 
 /* show event wait debugging info */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENA=
BLE_SMALL
 
 static const char *
 wait_status_string(struct context *c, str=
uct gc_arena *gc)
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
adde5=2E=2Ed10f9fa 100644
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
diff --git a/src/openvp=
n/plugin=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2E684632c 100644
---=
 a/src/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,7 +135,7 @@
=
 
 void plugin_return_free(struct plugin_return *pr);
 
-#ifdef ENABLE_DEBU=
G
+#ifndef ENABLE_SMALL
 void plugin_return_print(const msglvl_t msglevel, =
const char *prefix, const struct plugin_return *pr);
 
 #endif
diff --git a=
/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index ced438e=2E=2Eb53=
15ff 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@=
@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 =
/* print the current sequence of active packet IDs */
 static const char *
=
 reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
@@ -48=
0,7 +480,7 @@
     }
     return BSTR(&out);
 }
-#endif /* ENABLE_DEBUG */
=
+#endif
 
 /* true if at least one free buffer available */
 bool
diff --gi=
t a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 03a2526=2E=2Ee8001b=
3 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -81,7 +=
81,7 @@
 
 static void get_bypass_addresses(struct route_bypass *rb, const =
unsigned int flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static=
 void
 print_bypass_addresses(const struct route_bypass *rb)
@@ -617,7 +617=
,7 @@
     if (rl->ngi=2Eflags & RGI_ADDR_DEFINED)
     {
         setenv_r=
oute_addr(es, "net_gateway", rl->ngi=2Egateway=2Eaddr, -1);
-#if defined(EN=
ABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_=
default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
     }
@@ -660,7 +660,7 @=
@
             add_block_local_routes(rl);
         }
         get_bypass_a=
ddresses(&rl->spec=2Ebypass, rl->flags);
-#ifdef ENABLE_DEBUG
+#ifndef ENAB=
LE_SMALL
         print_bypass_addresses(&rl->spec=2Ebypass);
 #endif
     =
}
@@ -768,7 +768,7 @@
     if (rl6->ngi6=2Eflags & RGI_ADDR_DEFINED)
     {=

         setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6=2Egat=
eway=2Eaddr_ipv6, 0, &gc));
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_S=
MALL)
+#ifndef ENABLE_SMALL
         print_default_gateway(D_ROUTE, NULL, &=
rl6->rgi6);
 #endif
     }
diff --git a/src/openvpn/schedule=2Ec b/src/open=
vpn/schedule=2Ec
index 6772ad6=2E=2E6c60dc2 100644
--- a/src/openvpn/schedu=
le=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,7 +33,7 @@
 
 #include "memdbg=
=2Eh"
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void
 schedule_e=
ntry_debug_info(const char *caller, const struct schedule_entry *e)
 {
@@ -=
308,7 +308,7 @@
 void
 schedule_add_modify(struct schedule *s, struct sched=
ule_entry *e)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_=
debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_info("schedu=
le_add_modify", e);
@@ -355,7 +355,7 @@
         }
     }
 
-#ifdef ENABLE_=
DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {=

         schedule_entry_debug_info("schedule_find_least", e);
diff --git a=
/src/tapctl/error=2Eh b/src/tapctl/error=2Eh
index f9586dc=2E=2E34aa894 100=
644
--- a/src/tapctl/error=2Eh
+++ b/src/tapctl/error=2Eh
@@ -83,7 +83,7 @@=

         }                                \
         EXIT_FATAL(flags);   =
            \
     } while (false)
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMA=
LL
 #define dmsg(flags, =2E=2E=2E)                 \
     do               =
                    \
     {                                    \

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f96cd1c3488b558b8a59759=
4d99edcba1214d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet: 5
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--EPtBStE23Lo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ch=
ange most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL<br><br>Most of these a=
re verbose logging or even enable logging at high<br>verbosity level or jus=
t useful tools like --show-gateway=2E<br><br>We had --enabled-debug on by d=
efault forever, so these &quot;debug&quot;<br>logs are on by default=2E Thi=
s patch instead moves them to<br>enable-small=2E<br><br>Since the verbose l=
ogging is now always enabled<br>(apart from --enable-small), --enable-debug=
 now only covers true<br>debug options like gremlin=2E<br><br>Rename the co=
nfigure option from --enable-debug to<br>--enable-developer-debug to ensure=
 existing build<br>script/maintainer do not enable this option<br>by defaul=
t=2E<br><br>Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27<br>---<br>=
M CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M conf=
igure=2Eac<br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/compstub=2Ec<b=
r>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=
=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/event=2Ec<br>M src/openvpn=
/forward=2Ec<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src=
/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<=
br>M src/openvpn/options=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvp=
n/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M src/openvpn/reliable=2Ec<br>M=
 src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/tapctl/error=
=2Eh<br>24 files changed, 48 insertions(+), 41 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/42/1942/5</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span>=
<br><span>index 6eb5954=2E=2Ed553697 100644</span><br><span>--- a/CMakeList=
s=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -40,6 +40=
,7 @@</span><br><span> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-helper&=
quot; ON)</span><br><span> option(USE_WERROR &quot;Treat compiler warnings =
as errors (-Werror)&quot; ON)</span><br><span> option(FAKE_ANDROID &quot;Ta=
rget Android but do not use actual cross compile/Android cmake to build for=
 simple compile checks on Linux&quot;)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+option(ENABLE_DEBUG &quot;Enable building with debug&quo=
t; OFF)</span><br><span> </span><br><span> option(ENABLE_DNS_UPDOWN_BY_DEFA=
ULT &quot;Run --dns-updown hook by default&quot; ON)</span><br><span> set(D=
NS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&quo=
t; CACHE STRING &quot;Default location for the DNS up/down script&quot;)</s=
pan><br><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>inde=
x 2684251=2E=2E7763d59 100644</span><br><span>--- a/Changes=2Emd</span><br>=
<span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,11 @@</span><br><span=
>   the characters mentioned above were already escaped=2E However, the beh=
avior of</span><br><span>   Mbed TLS is slightly different from OpenSSL in =
that it also escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+## Maintainer-visible changes</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+- The configure-time option `--enable-debug` i=
s no longer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  availa=
ble and the verbose logging is now always included=2E</span><br><span style=
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
r><span>index 469a475=2E=2E4226515 100644</span><br><span>--- a/configure=
=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -131,9 +131,9=
 @@</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span> 	[de=
bug],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AS_HELP_STRING=
([--disable-debug], [disable debugging support (disable gremlin and verb 7+=
 messages) @&lt;:@default=3Dyes@:&gt;@])],</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--enable-developer-debug], [enable=
 developer debugging support (enable gremlin) @&lt;:@default=3Dno@:&gt;@])]=
,</span><br><span> 	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	[enable_debug=3D&quot;yes&quot;]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	[enable_debug=3D&quot;no&quot;]</span><br><span> )</span><br=
><span> </span><br><span> AC_ARG_ENABLE(</span><br><span>diff --git a/dev-t=
ools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index =
37de267=2E=2Ed1cfaa8 100755</span><br><span>--- a/dev-tools/run-cppcheck=2E=
sh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -21=
,7 +21,7 @@</span><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}</span><b=
r><span> : ${BUILD_DIR:=3D$PWD}</span><br><span> : ${INCLUDE_FLAGS:=3D}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-CPPCHECK_DIR=3D&quot;${BU=
ILD_DIR}/cppcheck_build_dir&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir_test_arn=
e&quot;</span><br><span> COMMON_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \<=
/span><br><span>  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_=
EXPORT \</span><br><span>  -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \=
</span><br><span>diff --git a/src/openvpn/compstub=2Ec b/src/openvpn/compst=
ub=2Ec</span><br><span>index f0c89f7=2E=2E2eef587 100644</span><br><span>--=
- a/src/openvpn/compstub=2Ec</span><br><span>+++ b/src/openvpn/compstub=2Ec=
</span><br><span>@@ -125,7 +125,7 @@</span><br><span>         return;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    uint8_t *head =3D BPTR(buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const uint8_t *head =3D BPTR(buf);</span><br=
><span> </span><br><span>     /* no compression or packet to short*/</span>=
<br><span>     if (head[0] !=3D COMP_ALGV2_INDICATOR_BYTE)</span><br><span>=
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2E=
c</span><br><span>index 0c5beb4=2E=2E05bb60d 100644</span><br><span>--- a/s=
rc/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbed=
tls=2Ec</span><br><span>@@ -842,8 +842,8 @@</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH]=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMAL=
L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used by the=
 D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused</span><br><sp=
an>      * variables warnings if compiled with --enable-small */</span><br>=
<span>     const size_t olen_orig =3D olen;</span><br><span>     const uint=
8_t *out_orig =3D out;</span><br><span>diff --git a/src/openvpn/crypto_mbed=
tls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>inde=
x bbd012f6=2E=2Ef46d8bf 100644</span><br><span>--- a/src/openvpn/crypto_mbe=
dtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec=
</span><br><span>@@ -989,8 +989,8 @@</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef EN=
ABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* used=
 by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used by the D_SHOW=
_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused</span><br><span>    =
  * variables warnings if compiled with --enable-small */</span><br><span> =
    const size_t olen_orig =3D olen;</span><br><span>     const uint8_t *ou=
t_orig =3D out;</span><br><span>diff --git a/src/openvpn/error=2Eh b/src/op=
envpn/error=2Eh</span><br><span>index a887fc7=2E=2E5811bef 100644</span><br=
><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/error=
=2Eh</span><br><span>@@ -158,7 +158,7 @@</span><br><span>         }        =
                        \</span><br><span>         EXIT_FATAL(flags);      =
         \</span><br><span>     } while (false)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> #define dms=
g(flags, =2E=2E=2E)                 \</span><br><span>     do              =
                     \</span><br><span>     {                              =
      \</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/ev=
ent=2Ec</span><br><span>index 8b7716a=2E=2E2cb4e04 100644</span><br><span>-=
-- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</spa=
n><br><span>@@ -398,7 +398,7 @@</span><br><span> </span><br><span>     dmsg=
(D_EVENT_WAIT, &quot;WE_WAIT enter n=3D%d to=3D%d&quot;, wes-&gt;n_events, =
timeout);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_EVE=
NT_WAIT))</span><br><span>     {</span><br><span>         int i;</span><br>=
<span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span>=
<br><span>index 6fe5849=2E=2E7811245 100644</span><br><span>--- a/src/openv=
pn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><spa=
n>@@ -50,7 +50,7 @@</span><br><span> </span><br><span> /* show event wait d=
ebugging info */</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static=
 const char *</span><br><span> wait_status_string(struct context *c, struct=
 gc_arena *gc)</span><br><span>@@ -2190,7 +2190,7 @@</span><br><span>      =
   {</span><br><span>             int status;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><s=
pan>             if (check_debug_level(D_EVENT_WAIT))</span><br><span>     =
        {</span><br><span>                 show_wait_status(c);</span><br><=
span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br=
><span>index 39fa482=2E=2E261d25a 100644</span><br><span>--- a/src/openvpn/=
mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ =
-501,7 +501,7 @@</span><br><span>     }</span><br><span>     mh-&gt;n_net_l=
en =3D j;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_MUL=
TI_DEBUG))</span><br><span>     {</span><br><span>         struct gc_arena =
gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/op=
envpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2Eb0125f1 100644</span><br>=
<span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec=
</span><br><span>@@ -74,7 +74,7 @@</span><br><span>         mi-&gt;did_real=
_hash =3D true;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>   =
  if (mi)</span><br><span>     {</span><br><span>         dmsg(D_MULTI_DEBU=
G, &quot;MULTI TCP: instance added: %s&quot;, mroute_addr_print(&amp;mi-&gt=
;real, &amp;gc));</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec</span><br><span>index 88b0091=2E=2E4794b7e 100644</span><br=
><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2E=
c</span><br><span>@@ -431,7 +431,7 @@</span><br><span>         }</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_=
MULTI_DEBUG))</span><br><span>     {</span><br><span>         struct gc_are=
na gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec</span><br><span>index 3e72b92=2E=2E67204c3 100644</span=
><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mu=
lti=2Ec</span><br><span>@@ -1145,7 +1145,7 @@</span><br><span>         }</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_=
level(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>         struc=
t gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/multi_=
io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 3604684=2E=2E4b96c5=
7 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++=
 b/src/openvpn/multi_io=2Ec</span><br><span>@@ -46,7 +46,7 @@</span><br><sp=
an> #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)</span><br><span> #define =
MULTI_IO_DCO              ((void *)6)</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> sta=
tic const char *</span><br><span> pract(int action)</span><br><span> {</spa=
n><br><span>@@ -89,7 +89,7 @@</span><br><span>             return &quot;?&q=
uot;;</span><br><span>     }</span><br><span> }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 static inline struct context *</span><br><span> multi_get_context(struct m=
ulti_context *m, struct multi_instance *mi)</span><br><span>diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index e3cd5=
27=2E=2Ed53c2c5 100644</span><br><span>--- a/src/openvpn/options=2Ec</span>=
<br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -785,7 +785,7 @@=
</span><br><span> #endif /* ENABLE_PKCS11 */</span><br><span>     &quot;\n&=
quot;</span><br><span>     &quot;General Standalone Options:\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><=
br><span>     &quot;--show-gateway [address]: Show info about gateway [to v=
4/v6 address]=2E\n&quot;</span><br><span> #endif</span><br><span>     ;</sp=
an><br><span>@@ -4229,7 +4229,7 @@</span><br><span>         read_config_fil=
e(options, p[1], level, file, line, msglevel, permission_mask,</span><br><s=
pan>                          option_types_found, es);</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_=
DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     else if (str=
eq(p[0], &quot;show-gateway&quot;) &amp;&amp; !p[2])</span><br><span>     {=
</span><br><span>         struct route_gateway_info rgi;</span><br><span>@@=
 -4938,12 +4938,13 @@</span><br><span>              * mbed TLS always gener=
ating debug level logging */</span><br><span>             options-&gt;ssl_f=
lags |=3D SSLF_TLS_DEBUG_ENABLED;</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if !defined(ENABLE_DEBUG) &amp;&amp=
; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef ENABLE_SMALL</span><br><span>         /* Warn when a debug verb=
osity is supplied when built without debug support */</span><br><span>     =
    if (options-&gt;verbosity &gt;=3D 7)</span><br><span>         {</span><=
br><span>             msg(M_WARN,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;NOTE: debug verbosity (--verb %d) is enab=
led but this build lacks debug support=2E&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                &quot;NOTE: debug verbosity (-=
-verb %d) is enabled but this build is &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                &quot;built with --enable-small t=
hat lacks support for high --verb settings&quot;,</span><br><span>         =
        options-&gt;verbosity);</span><br><span>         }</span><br><span>=
 #endif</span><br><span>diff --git a/src/openvpn/packet_id=2Ec b/src/openvp=
n/packet_id=2Ec</span><br><span>index a4b627c=2E=2E22c53c7 100644</span><br=
><span>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/src/openvpn/pa=
cket_id=2Ec</span><br><span>@@ -52,18 +52,18 @@</span><br><span> #define SE=
Q_UNSEEN  ((time_t)0)</span><br><span> #define SEQ_EXPIRED ((time_t)1)</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef E=
NABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
ENABLE_SMALL</span><br><span> static void packet_id_debug_print(msglvl_t ms=
glevel, const struct packet_id_rec *p,</span><br><span>                    =
               const struct packet_id_net *pin, const char *message,</span>=
<br><span>                                   packet_id_print_type value);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span> </span><br><span> static inline void</span><br><sp=
an> packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,</span=
><br><span>                 const struct packet_id_net *pin, const char *me=
ssage, uint64_t value)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (unlikely(=
check_debug_level(msglevel)))</span><br><span>     {</span><br><span>      =
   packet_id_debug_print(msglevel, p, pin, message, value);</span><br><span=
>@@ -576,7 +576,7 @@</span><br><span>     return (char *)out=2Edata;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static voi=
d</span><br><span> packet_id_debug_print(msglvl_t msglevel, const struct pa=
cket_id_rec *p,</span><br><span>@@ -648,7 +648,7 @@</span><br><span>     gc=
_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span>=
<br><span> uint16_t</span><br><span> packet_id_read_epoch(struct packet_id_=
net *pin, struct buffer *buf)</span><br><span>diff --git a/src/openvpn/plug=
in=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index f8adde5=2E=2Ed10f9fa =
100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/s=
rc/openvpn/plugin=2Ec</span><br><span>@@ -993,7 +993,7 @@</span><br><span> =
    pr-&gt;n =3D 0;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> vo=
id</span><br><span> plugin_return_print(const msglvl_t msglevel, const char=
 *prefix, const struct plugin_return *pr)</span><br><span> {</span><br><spa=
n>diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><s=
pan>index 7e9faf3=2E=2E684632c 100644</span><br><span>--- a/src/openvpn/plu=
gin=2Eh</span><br><span>+++ b/src/openvpn/plugin=2Eh</span><br><span>@@ -13=
5,7 +135,7 @@</span><br><span> </span><br><span> void plugin_return_free(st=
ruct plugin_return *pr);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> void plugin_retu=
rn_print(const msglvl_t msglevel, const char *prefix, const struct plugin_r=
eturn *pr);</span><br><span> </span><br><span> #endif</span><br><span>diff =
--git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span=
>index ced438e=2E=2Eb5315ff 100644</span><br><span>--- a/src/openvpn/reliab=
le=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -4=
62,7 +462,7 @@</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</=
span><br><span> /* print the current sequence of active packet IDs */</span=
><br><span> static const char *</span><br><span> reliable_print_ids(const s=
truct reliable *rel, struct gc_arena *gc)</span><br><span>@@ -480,7 +480,7 =
@@</span><br><span>     }</span><br><span>     return BSTR(&amp;out);</span=
><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> /* true if at least one free buffer=
 available */</span><br><span> bool</span><br><span>diff --git a/src/openvp=
n/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 03a2526=2E=2Ee800=
1b3 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ =
b/src/openvpn/route=2Ec</span><br><span>@@ -81,7 +81,7 @@</span><br><span> =
</span><br><span> static void get_bypass_addresses(struct route_bypass *rb,=
 const unsigned int flags);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><s=
pan> static void</span><br><span> print_bypass_addresses(const struct route=
_bypass *rb)</span><br><span>@@ -617,7 +617,7 @@</span><br><span>     if (r=
l-&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br>=
<span>         setenv_route_addr(es, &quot;net_gateway&quot;, rl-&gt;ngi=2E=
gateway=2Eaddr, -1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span=
>         print_default_gateway(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br>=
<span> #endif</span><br><span>     }</span><br><span>@@ -660,7 +660,7 @@</s=
pan><br><span>             add_block_local_routes(rl);</span><br><span>    =
     }</span><br><span>         get_bypass_addresses(&amp;rl-&gt;spec=2Ebyp=
ass, rl-&gt;flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fndef ENABLE_SMALL</span><br><span>         print_bypass_addresses(&amp;rl-=
&gt;spec=2Ebypass);</span><br><span> #endif</span><br><span>     }</span><b=
r><span>@@ -768,7 +768,7 @@</span><br><span>     if (rl6-&gt;ngi6=2Eflags &=
amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span>         sete=
nv_str(es, &quot;net_gateway_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6=2Egate=
way=2Eaddr_ipv6, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span=
><br><span>         print_default_gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6)=
;</span><br><span> #endif</span><br><span>     }</span><br><span>diff --git=
 a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>inde=
x 6772ad6=2E=2E6c60dc2 100644</span><br><span>--- a/src/openvpn/schedule=2E=
c</span><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -33,7 +=
33,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span> static void</span><br><span> schedule_ent=
ry_debug_info(const char *caller, const struct schedule_entry *e)</span><br=
><span> {</span><br><span>@@ -308,7 +308,7 @@</span><br><span> void</span><=
br><span> schedule_add_modify(struct schedule *s, struct schedule_entry *e)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))=
</span><br><span>     {</span><br><span>         schedule_entry_debug_info(=
&quot;schedule_add_modify&quot;, e);</span><br><span>@@ -355,7 +355,7 @@</s=
pan><br><span>         }</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br>=
<span>     if (check_debug_level(D_SCHEDULER))</span><br><span>     {</span=
><br><span>         schedule_entry_debug_info(&quot;schedule_find_least&quo=
t;, e);</span><br><span>diff --git a/src/tapctl/error=2Eh b/src/tapctl/erro=
r=2Eh</span><br><span>index f9586dc=2E=2E34aa894 100644</span><br><span>---=
 a/src/tapctl/error=2Eh</span><br><span>+++ b/src/tapctl/error=2Eh</span><b=
r><span>@@ -83,7 +83,7 @@</span><br><span>         }                       =
         \</span><br><span>         EXIT_FATAL(flags);               \</spa=
n><br><span>     } while (false)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> #define dmsg(flags, =2E=2E=
=2E)                 \</span><br><span>     do                             =
      \</span><br><span>     {                                    \</span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1942?usp=3Demail">change 1942</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1942 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--EPtBStE23Lo=--


--===============5411789154425729545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5411789154425729545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5411789154425729545==--

