Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5379C982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6WLUwTwyRGeHPD5sYBbunttbK84ZpKZQizhLXH1yVU=; b=J0Mz4m6LJ474BizzeI6SxwnQMO
	qN7VLachHYDa6Il/3haKLF/Hl4ttw58wNaLe8g6TUNOe3m3OUygRpYL62YHFYGKqvmNgTEV5RPKbj
	3Kf8Bax0BxuDZ4Lsux/n2F/gjnolktpdqmmGFtzWb1qIzKJFnvekX5T5+RZUIh9dEBeU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91zq-00033G-2j;
	Tue, 22 Sep 2026 15:01:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x91zi-000336-Cn
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:01:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5xzKhNPu4oQKxAFjAtrVNPQLTbv9NOkrRZUlNivMU4I=; b=JKQ1B7EBVSq7Xla8ANQ1PzyfuL
 sdK7sQ8LJ/qy7tR2lIKXUV16l2vWeScYkWvvitkAI5i+Yk4IXXxGvEXtOV/dpgVZEFCfTKdUHGXnD
 x4mD/h0it3E+KvnmpTEDGQTfz0wuc+wvtH2v7/wP4fzixs2P7AuV33hlxxSZ+qoYel00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5xzKhNPu4oQKxAFjAtrVNPQLTbv9NOkrRZUlNivMU4I=; b=b
 rCAS7yof7S26X0IQegtsm68t979UWEHSRWkn3zwOFUGDC7ZmQXuDRdYVTJ2YYn/ECNipbTxvG+EHC
 6W+MRAVHYr9jFauT1iKTFVEwvdVrfK6e2BUwzdLfE4BZ1KOKOLDh1MWhUpi9y0oiyoBUV9nPfZ/YI
 6etWQmN6CYjN6bkY=;
Received: from mail-wr2-f17.google.com ([74.125.225.81])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91zf-0003Lc-Jd for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 15:01:18 +0000
Received: by mail-wr2-f17.google.com with SMTP id
 ffacd0b85a97d-484366874b0so18470f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790089269; x=1790694069; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5xzKhNPu4oQKxAFjAtrVNPQLTbv9NOkrRZUlNivMU4I=;
 b=hWF79SJEDyWpmJZe8Db0QG53LDIktOgQ3EbEOFSX2e7hpbQfeFNTSh2n8CBltzpLhz
 W16g6GG1C9yoMhbHpvVta4pwcov3ir211AA66yWvAzWwxhHCzrYp8ytGrFEi1jOFirdG
 WOzfAzETGZOYKyMUFnLlXLWxZxsQQEjs/UdJ+SyzKKyFLP31xCCEi8Bflyq0wCj/PCk6
 HYT49+BToKqjX38AxZh4XbZKqd47NGH4IUt5/cfbe78Rp5yVW8lpO3x4/r5CpB+uwRPj
 EpSxperMpCGHDigjB8A0s9rvkshBqt1GOBPVWx/WFBbzrHS6JSlc0MU+TwqXxuiPPF+C
 plyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790089269; x=1790694069;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5xzKhNPu4oQKxAFjAtrVNPQLTbv9NOkrRZUlNivMU4I=;
 b=hU92vpEozQC49S8YiabIhFgBckDIde8UE6Jukl9FwA1GVHFP72rd7krR8Zzhi/HBcW
 0/9yukKfmb9M5n/V8H7p+tFQQOVrIINknvsLfkVezR0GPbcYgk3FZNvgDBCQtA6ExeXy
 JMO9dPPcOVOdtRNBxwU+QpqL/gVhW0rpzPINLhheI85X4h71rea6ktZUvyo8ZkAJK77n
 FDT8vGLazObOo7mwzANkfnxl/Fpyv9COOrO7j75vNskR4BkjbyhvVIaWaqUusFUhW2By
 Jvw+nqT+D1Q5dilB1jTlQNvTUJ0Wv10aq383+V2uBpVbn24JnUSWVKTFULmjw02eKfU4
 RBjg==
X-Gm-Message-State: AFuF++mXAsVD0oDqy2hqgKWZ9EHM2WB5GpQVDwk1WwCYUDBCRqcnyBPB
 7kkiW0rNWNr2+w58OFfdhvsFBsXR7AEUFjSt7ODlNiNoOUT0sPMT1JwH8kx3uibz+RAPi3OjigU
 GkrMq1Xnl8DI4ChuZmM74D8jLY/mUTrJCGG5h+sfkwoCdNrzcfftgLTsR6oTB3TV9Y/5X/84vxk
 NfUbCbvw==
X-Gm-Gg: AYBFou01NZv8/rYCE/Ky3JBwnSPcYg/pUBrj8Oaodv/jab1fjbjax6gIKATFXjlS/KX
 V8M6dDkS4k2FZfbkVpVnH+/iW72tPIMpjZTWdeQR8jWQmMva8qfajySl0c5MRiAhkPkW2LJAcmP
 Xpnx2uQhn+u+dUmaP5K4hNDkNkUCf5mb8ioKDaoeFLaw9nXCWPSh8YfMuph9Iy1vzdG7eKTsBD5
 IVTuf8wPGOHxP2+wCbssDXBxCPuz6xL/lICuq7dCF5gNTpDeAL3yOQIwHBTP5TA7WQW0U5zA53u
 EOK+wWoe2jXSxZNYyJuk+lZL/0fz4ExWqZmB5BmI4FQ2w0nTVE5/D8I2xCcSwvOkykljQ20k7bF
 injKq7h/3ARZ+6jINk2xY/UHNAnfvLcUhDyMudxiVz5c7bGsDEt+Dvopg7f9N9mqayE2zdsDn3r
 WdrYbfhmGxpdmAis62e/wz+9qMUHXMMfWrfUwv+Hz0Pr3/nLHoGzrzYHPvWYP0axnwAu9wGWC8W
 T6dW1VXit9vOL4q6SozogdjvyytUz+JFtYqDwU4ET0lTLWvAt19/MWdZ/NPb77SQNBQbenhBYSr
 5DevgsbHxEcJIkr9b93BLRJD1mgisLpawdJ54KO869Amz7NRUHCIc2MxuRNk
X-Received: by 2002:a5d:5d0e:0:b0:487:27f6:a4da with SMTP id
 ffacd0b85a97d-48727f6a725mr17740480f8f.42.1790089268658; 
 Tue, 22 Sep 2026 08:01:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862789080sm5931367f8f.28.2026.09.22.08.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:01:08 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 15:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: b4cb1d8aa312b8ab550c9b540cd670f93839beff
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <35af28dc4292931694d02f2492e042b4f1a65023-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x91zf-0003Lc-Jd
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
Content-Type: multipart/mixed; boundary="===============6779076264489258406=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6779076264489258406==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gXorp+0ryao="; charset=UTF-8

--gXorp+0ryao=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new pa=
tch set (#4)=2E


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

Change-Id: I3f96cd1c3488b558b8a597594d99edcba121=
4d27
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=2Eh=2Ecmake=2Ein
M conf=
igure=2Eac
M src/openvpn/compstub=2Ec
M src/openvpn/crypto_mbedtls=2Ec
M sr=
c/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/error=2Eh
M src/openvpn/e=
vent=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/mroute=2Ec
M src/openvpn/m=
tcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi_=
io=2Ec
M src/openvpn/options=2Ec
M src/openvpn/packet_id=2Ec
M src/openvpn/=
plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/reliable=2Ec
M src/openvp=
n/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl/error=2Eh
23 files chan=
ged, 47 insertions(+), 40 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/42/1942/4

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD with=
 pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (=
-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual cr=
oss compile/Android cmake to build for simple compile checks on Linux")
+op=
tion(ENABLE_DEBUG "Enable building with debug" OFF)
 
 option(ENABLE_DNS_UP=
DOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS_UPDOWN_PATH=
 "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "Default=
 location for the DNS up/down script")
diff --git a/Changes=2Emd b/Changes=
=2Emd
index 2684251=2E=2E7763d59 100644
--- a/Changes=2Emd
+++ b/Changes=2E=
md
@@ -23,6 +23,11 @@
   the characters mentioned above were already escape=
d=2E However, the behavior of
   Mbed TLS is slightly different from OpenSS=
L in that it also escapes "=3D"=2E
 
+## Maintainer-visible changes
+
+- Th=
e configure-time option `--enable-debug` is no longer
+  available and the =
verbose logging is now always included=2E
+
 # Overview of changes in 2=2E7=

 
 ## New features
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecma=
ke=2Ein
index c3bb5a5=2E=2Ec6c0a96 100644
--- a/config=2Eh=2Ecmake=2Ein
+++=
 b/config=2Eh=2Ecmake=2Ein
@@ -18,8 +18,8 @@
 /* Enable shared data channel=
 offload */
 #cmakedefine ENABLE_DCO
 
-/* Enable debugging support (needed=
 for verb>=3D4) */
-#define ENABLE_DEBUG 1
+/* Enable debugging support */
=
+#cmakedefine ENABLE_DEBUG
 
 /* Enable internal fragmentation support */
 =
#define ENABLE_FRAGMENT 1
diff --git a/configure=2Eac b/configure=2Eac
inde=
x 469a475=2E=2E4226515 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ =
-131,9 +131,9 @@
 
 AC_ARG_ENABLE(
 	[debug],
-	[AS_HELP_STRING([--disable-=
debug], [disable debugging support (disable gremlin and verb 7+ messages) @=
<:@default=3Dyes@:>@])],
+	[AS_HELP_STRING([--enable-developer-debug], [ena=
ble developer debugging support (enable gremlin) @<:@default=3Dno@:>@])],
 =
	,
-	[enable_debug=3D"yes"]
+	[enable_debug=3D"no"]
 )
 
 AC_ARG_ENABLE(
di=
ff --git a/src/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec
index f0c89f=
7=2E=2E2eef587 100644
--- a/src/openvpn/compstub=2Ec
+++ b/src/openvpn/comp=
stub=2Ec
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
fc7=2E=2E5811bef 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=
=2Eh
@@ -158,7 +158,7 @@
         }                                \
      =
   EXIT_FATAL(flags);               \
     } while (false)
-#ifdef ENABLE_D=
EBUG
+#ifndef ENABLE_SMALL
 #define dmsg(flags, =2E=2E=2E)                 =
\
     do                                   \
     {                       =
             \
diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
i=
ndex 8b7716a=2E=2E2cb4e04 100644
--- a/src/openvpn/event=2Ec
+++ b/src/open=
vpn/event=2Ec
@@ -398,7 +398,7 @@
 
     dmsg(D_EVENT_WAIT, "WE_WAIT enter =
n=3D%d to=3D%d", wes->n_events, timeout);
 
-#ifdef ENABLE_DEBUG
+#ifndef E=
NABLE_SMALL
     if (check_debug_level(D_EVENT_WAIT))
     {
         int i=
;
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 6fe5=
849=2E=2E7811245 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/for=
ward=2Ec
@@ -50,7 +50,7 @@
 
 /* show event wait debugging info */
 
-#ifde=
f ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static const char *
 wait_status_st=
ring(struct context *c, struct gc_arena *gc)
@@ -2190,7 +2190,7 @@
        =
 {
             int status;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
  =
           if (check_debug_level(D_EVENT_WAIT))
             {
            =
     show_wait_status(c);
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn=
/mroute=2Ec
index 39fa482=2E=2E261d25a 100644
--- a/src/openvpn/mroute=2Ec
=
+++ b/src/openvpn/mroute=2Ec
@@ -501,7 +501,7 @@
     }
     mh->n_net_len =
=3D j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_le=
vel(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new();
diff -=
-git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2Eb0125=
f1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -74,7 +7=
4,7 @@
         mi->did_real_hash =3D true;
     }
 
-#ifdef ENABLE_DEBUG
+=
#ifndef ENABLE_SMALL
     if (mi)
     {
         dmsg(D_MULTI_DEBUG, "MULT=
I TCP: instance added: %s", mroute_addr_print(&mi->real, &gc));
diff --git =
a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 88b0091=2E=2E4794b7e 10=
0644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -431,7 +431,7=
 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if =
(check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D g=
c_new();
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3=
e72b92=2E=2E67204c3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mu=
lti=2Ec
@@ -1145,7 +1145,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#if=
ndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
       =
  struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/multi_io=2Ec b/=
src/openvpn/multi_io=2Ec
index 3604684=2E=2E4b96c57 100644
--- a/src/openvp=
n/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -46,7 +46,7 @@
 #define MU=
LTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO              ((vo=
id *)6)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static const char *
 =
pract(int action)
 {
@@ -89,7 +89,7 @@
             return "?";
     }
 }
-=
#endif /* ENABLE_DEBUG */
+#endif
 
 static inline struct context *
 multi_=
get_context(struct multi_context *m, struct multi_instance *mi)
diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2Ed53c=
2c5 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -=
785,7 +785,7 @@
 #endif /* ENABLE_PKCS11 */
     "\n"
     "General Standal=
one Options:\n"
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     "--show-gat=
eway [address]: Show info about gateway [to v4/v6 address]=2E\n"
 #endif
  =
   ;
@@ -4229,7 +4229,7 @@
         read_config_file(options, p[1], level, =
file, line, msglevel, permission_mask,
                          option_typ=
es_found, es);
     }
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
=
+#ifndef ENABLE_SMALL
     else if (streq(p[0], "show-gateway") && !p[2])
 =
    {
         struct route_gateway_info rgi;
@@ -4938,12 +4938,13 @@
     =
         * mbed TLS always generating debug level logging */
             o=
ptions->ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;
         }
-#if !defined(ENA=
BLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifdef ENABLE_SMALL
         /* Warn =
when a debug verbosity is supplied when built without debug support */
    =
     if (options->verbosity >=3D 7)
         {
             msg(M_WARN,
-  =
              "NOTE: debug verbosity (--verb %d) is enabled but this build =
lacks debug support=2E",
+                "NOTE: debug verbosity (--verb %d=
) is enabled but this build is "
+                "built with --enable-smal=
l that lacks support for high --verb settings",
                 options->v=
erbosity);
         }
 #endif
diff --git a/src/openvpn/packet_id=2Ec b/src/=
openvpn/packet_id=2Ec
index a4b627c=2E=2E22c53c7 100644
--- a/src/openvpn/p=
acket_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -52,18 +52,18 @@
 #define S=
EQ_UNSEEN  ((time_t)0)
 #define SEQ_EXPIRED ((time_t)1)
 
-#ifdef ENABLE_DE=
BUG
+#ifndef ENABLE_SMALL
 static void packet_id_debug_print(msglvl_t msgle=
vel, const struct packet_id_rec *p,
                                   cons=
t struct packet_id_net *pin, const char *message,
                         =
          packet_id_print_type value);
 
-#endif /* ENABLE_DEBUG */
+#endif=

 
 static inline void
 packet_id_debug(msglvl_t msglevel, const struct pac=
ket_id_rec *p,
                 const struct packet_id_net *pin, const char=
 *message, uint64_t value)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
  =
   if (unlikely(check_debug_level(msglevel)))
     {
         packet_id_deb=
ug_print(msglevel, p, pin, message, value);
@@ -576,7 +576,7 @@
     return=
 (char *)out=2Edata;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 sta=
tic void
 packet_id_debug_print(msglvl_t msglevel, const struct packet_id_r=
ec *p,
@@ -648,7 +648,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_=
DEBUG */
+#endif
 
 uint16_t
 packet_id_read_epoch(struct packet_id_net *pi=
n, struct buffer *buf)
diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/pl=
ugin=2Ec
index f8adde5=2E=2Ed10f9fa 100644
--- a/src/openvpn/plugin=2Ec
+++=
 b/src/openvpn/plugin=2Ec
@@ -993,7 +993,7 @@
     pr->n =3D 0;
 }
 
-#ifde=
f ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void
 plugin_return_print(const msglv=
l_t msglevel, const char *prefix, const struct plugin_return *pr)
 {
diff -=
-git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2E6=
84632c 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ =
-135,7 +135,7 @@
 
 void plugin_return_free(struct plugin_return *pr);
 
-#=
ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void plugin_return_print(const ms=
glvl_t msglevel, const char *prefix, const struct plugin_return *pr);
 
 #e=
ndif
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index=
 ced438e=2E=2Eb5315ff 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openv=
pn/reliable=2Ec
@@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#ifnd=
ef ENABLE_SMALL
 /* print the current sequence of active packet IDs */
 sta=
tic const char *
 reliable_print_ids(const struct reliable *rel, struct gc_=
arena *gc)
@@ -480,7 +480,7 @@
     }
     return BSTR(&out);
 }
-#endif /*=
 ENABLE_DEBUG */
+#endif
 
 /* true if at least one free buffer available *=
/
 bool
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 03=
a2526=2E=2Ee8001b3 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -81,7 +81,7 @@
 
 static void get_bypass_addresses(struct route_b=
ypass *rb, const unsigned int flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABL=
E_SMALL
 
 static void
 print_bypass_addresses(const struct route_bypass *r=
b)
@@ -617,7 +617,7 @@
     if (rl->ngi=2Eflags & RGI_ADDR_DEFINED)
     {
=
         setenv_route_addr(es, "net_gateway", rl->ngi=2Egateway=2Eaddr, -1)=
;
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMAL=
L
         print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
     }
@=
@ -660,7 +660,7 @@
             add_block_local_routes(rl);
         }
    =
     get_bypass_addresses(&rl->spec=2Ebypass, rl->flags);
-#ifdef ENABLE_DE=
BUG
+#ifndef ENABLE_SMALL
         print_bypass_addresses(&rl->spec=2Ebypas=
s);
 #endif
     }
@@ -768,7 +768,7 @@
     if (rl6->ngi6=2Eflags & RGI_ADD=
R_DEFINED)
     {
         setenv_str(es, "net_gateway_ipv6", print_in6_add=
r(rl6->ngi6=2Egateway=2Eaddr_ipv6, 0, &gc));
-#if defined(ENABLE_DEBUG) && =
!defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_default_gateway=
(D_ROUTE, NULL, &rl6->rgi6);
 #endif
     }
diff --git a/src/openvpn/schedu=
le=2Ec b/src/openvpn/schedule=2Ec
index 6772ad6=2E=2E6c60dc2 100644
--- a/s=
rc/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,7 +33,7 @@
 
=
 #include "memdbg=2Eh"
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static=
 void
 schedule_entry_debug_info(const char *caller, const struct schedule_=
entry *e)
 {
@@ -308,7 +308,7 @@
 void
 schedule_add_modify(struct schedule=
 *s, struct schedule_entry *e)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMAL=
L
     if (check_debug_level(D_SCHEDULER))
     {
         schedule_entry_d=
ebug_info("schedule_add_modify", e);
@@ -355,7 +355,7 @@
         }
     }
=
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_S=
CHEDULER))
     {
         schedule_entry_debug_info("schedule_find_least",=
 e);
diff --git a/src/tapctl/error=2Eh b/src/tapctl/error=2Eh
index f9586dc=
=2E=2E34aa894 100644
--- a/src/tapctl/error=2Eh
+++ b/src/tapctl/error=2Eh
=
@@ -83,7 +83,7 @@
         }                                \
         EXIT=
_FATAL(flags);               \
     } while (false)
-#ifdef ENABLE_DEBUG
+#=
ifndef ENABLE_SMALL
 #define dmsg(flags, =2E=2E=2E)                 \
     =
do                                   \
     {                              =
      \

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
: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--gXorp+0ryao=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://ge=
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
r>by default=2E<br><br>Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27=
<br>---<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=2Eh=2Ecmake=2Ei=
n<br>M configure=2Eac<br>M src/openvpn/compstub=2Ec<br>M src/openvpn/crypto=
_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/er=
ror=2Eh<br>M src/openvpn/event=2Ec<br>M src/openvpn/forward=2Ec<br>M src/op=
envpn/mroute=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M s=
rc/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/packet_id=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/op=
envpn/plugin=2Eh<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/route=2Ec<b=
r>M src/openvpn/schedule=2Ec<br>M src/tapctl/error=2Eh<br>23 files changed,=
 47 insertions(+), 40 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1942/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=
=2E=2Ed553697 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -40,6 +40,7 @@</span><br><span> =
option(ENABLE_PKCS11 &quot;BUILD with pkcs11-helper&quot; ON)</span><br><sp=
an> option(USE_WERROR &quot;Treat compiler warnings as errors (-Werror)&quo=
t; ON)</span><br><span> option(FAKE_ANDROID &quot;Target Android but do not=
 use actual cross compile/Android cmake to build for simple compile checks =
on Linux&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opti=
on(ENABLE_DEBUG &quot;Enable building with debug&quot; OFF)</span><br><span=
> </span><br><span> option(ENABLE_DNS_UPDOWN_BY_DEFAULT &quot;Run --dns-upd=
own hook by default&quot; ON)</span><br><span> set(DNS_UPDOWN_PATH &quot;${=
CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&quot; CACHE STRING &quot;D=
efault location for the DNS up/down script&quot;)</span><br><span>diff --gi=
t a/Changes=2Emd b/Changes=2Emd</span><br><span>index 2684251=2E=2E7763d59 =
100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Em=
d</span><br><span>@@ -23,6 +23,11 @@</span><br><span>   the characters ment=
ioned above were already escaped=2E However, the behavior of</span><br><spa=
n>   Mbed TLS is slightly different from OpenSSL in that it also escapes &q=
uot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+## Maintainer-visible changes</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- The configure-time option `--enable-debug` is no longer</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  available and the verbose log=
ging is now always included=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> # Overview of changes in 2=2E7</span><br><span=
> </span><br><span> ## New features</span><br><span>diff --git a/config=2Eh=
=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index c3bb5a5=2E=2E=
c6c0a96 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><spa=
n>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -18,8 +18,8 @@</span><br=
><span> /* Enable shared data channel offload */</span><br><span> #cmakedef=
ine ENABLE_DCO</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* Enable debugging support (needed for verb&gt;=3D4) */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_DEBUG 1</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable debugging suppor=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine EN=
ABLE_DEBUG</span><br><span> </span><br><span> /* Enable internal fragmentat=
ion support */</span><br><span> #define ENABLE_FRAGMENT 1</span><br><span>d=
iff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 469a475=
=2E=2E4226515 100644</span><br><span>--- a/configure=2Eac</span><br><span>+=
++ b/configure=2Eac</span><br><span>@@ -131,9 +131,9 @@</span><br><span> </=
span><br><span> AC_ARG_ENABLE(</span><br><span> 	[debug],</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	[AS_HELP_STRING([--disable-debug], [di=
sable debugging support (disable gremlin and verb 7+ messages) @&lt;:@defau=
lt=3Dyes@:&gt;@])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	[AS_HELP_STRING([--enable-developer-debug], [enable developer debugging su=
pport (enable gremlin) @&lt;:@default=3Dno@:&gt;@])],</span><br><span> 	,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[enable_debug=3D&quot;=
yes&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[enable_=
debug=3D&quot;no&quot;]</span><br><span> )</span><br><span> </span><br><spa=
n> AC_ARG_ENABLE(</span><br><span>diff --git a/src/openvpn/compstub=2Ec b/s=
rc/openvpn/compstub=2Ec</span><br><span>index f0c89f7=2E=2E2eef587 100644</=
span><br><span>--- a/src/openvpn/compstub=2Ec</span><br><span>+++ b/src/ope=
nvpn/compstub=2Ec</span><br><span>@@ -125,7 +125,7 @@</span><br><span>     =
    return;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *head =3D BP=
TR(buf);</span><br><span> </span><br><span>     /* no compression or packet=
 to short*/</span><br><span>     if (head[0] !=3D COMP_ALGV2_INDICATOR_BYTE=
)</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn=
/crypto_mbedtls=2Ec</span><br><span>index 0c5beb4=2E=2E05bb60d 100644</span=
><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/o=
penvpn/crypto_mbedtls=2Ec</span><br><span>@@ -842,8 +842,8 @@</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span>     uint8_t A1[MA=
X_HMAC_KEY_LENGTH];</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEB=
UG to avoid unused</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid un=
used</span><br><span>      * variables warnings if compiled with --enable-s=
mall */</span><br><span>     const size_t olen_orig =3D olen;</span><br><sp=
an>     const uint8_t *out_orig =3D out;</span><br><span>diff --git a/src/o=
penvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</s=
pan><br><span>index bbd012f6=2E=2Ef46d8bf 100644</span><br><span>--- a/src/=
openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_=
mbedtls_legacy=2Ec</span><br><span>@@ -989,8 +989,8 @@</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_=
KEY_LENGTH];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to a=
void unused</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef =
ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused</s=
pan><br><span>      * variables warnings if compiled with --enable-small */=
</span><br><span>     const size_t olen_orig =3D olen;</span><br><span>    =
 const uint8_t *out_orig =3D out;</span><br><span>diff --git a/src/openvpn/=
error=2Eh b/src/openvpn/error=2Eh</span><br><span>index a887fc7=2E=2E5811be=
f 100644</span><br><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/=
src/openvpn/error=2Eh</span><br><span>@@ -158,7 +158,7 @@</span><br><span> =
        }                                \</span><br><span>         EXIT_FA=
TAL(flags);               \</span><br><span>     } while (false)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><=
span> #define dmsg(flags, =2E=2E=2E)                 \</span><br><span>    =
 do                                   \</span><br><span>     {             =
                       \</span><br><span>diff --git a/src/openvpn/event=2Ec=
 b/src/openvpn/event=2Ec</span><br><span>index 8b7716a=2E=2E2cb4e04 100644<=
/span><br><span>--- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openv=
pn/event=2Ec</span><br><span>@@ -398,7 +398,7 @@</span><br><span> </span><b=
r><span>     dmsg(D_EVENT_WAIT, &quot;WE_WAIT enter n=3D%d to=3D%d&quot;, w=
es-&gt;n_events, timeout);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_=
debug_level(D_EVENT_WAIT))</span><br><span>     {</span><br><span>         =
int i;</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/f=
orward=2Ec</span><br><span>index 6fe5849=2E=2E7811245 100644</span><br><spa=
n>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=
=2Ec</span><br><span>@@ -50,7 +50,7 @@</span><br><span> </span><br><span> /=
* show event wait debugging info */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </s=
pan><br><span> static const char *</span><br><span> wait_status_string(stru=
ct context *c, struct gc_arena *gc)</span><br><span>@@ -2190,7 +2190,7 @@</=
span><br><span>         {</span><br><span>             int status;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABL=
E_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENAB=
LE_SMALL</span><br><span>             if (check_debug_level(D_EVENT_WAIT))<=
/span><br><span>             {</span><br><span>                 show_wait_s=
tatus(c);</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn=
/mroute=2Ec</span><br><span>index 39fa482=2E=2E261d25a 100644</span><br><sp=
an>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2E=
c</span><br><span>@@ -501,7 +501,7 @@</span><br><span>     }</span><br><spa=
n>     mh-&gt;n_net_len =3D j;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (ch=
eck_debug_level(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>    =
     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/open=
vpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2Eb012=
5f1 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b=
/src/openvpn/mtcp=2Ec</span><br><span>@@ -74,7 +74,7 @@</span><br><span>   =
      mi-&gt;did_real_hash =3D true;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMAL=
L</span><br><span>     if (mi)</span><br><span>     {</span><br><span>     =
    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: instance added: %s&quot;, mroute_a=
ddr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 88b0091=2E=2E479=
4b7e 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ =
b/src/openvpn/mudp=2Ec</span><br><span>@@ -431,7 +431,7 @@</span><br><span>=
         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>    =
 if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {</span><br><sp=
an>         struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3e72b92=
=2E=2E67204c3 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -1145,7 +1145,7 @@</sp=
an><br><span>         }</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><=
span>     if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {</spa=
n><br><span>         struct gc_arena gc =3D gc_new();</span><br><span>diff =
--git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span=
>index 3604684=2E=2E4b96c57 100644</span><br><span>--- a/src/openvpn/multi_=
io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -4=
6,7 +46,7 @@</span><br><span> #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)=
</span><br><span> #define MULTI_IO_DCO              ((void *)6)</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_D=
EBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_=
SMALL</span><br><span> static const char *</span><br><span> pract(int actio=
n)</span><br><span> {</span><br><span>@@ -89,7 +89,7 @@</span><br><span>   =
          return &quot;?&quot;;</span><br><span>     }</span><br><span> }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> </span><br><span> static inline struct context *</span><br><span> mu=
lti_get_context(struct multi_context *m, struct multi_instance *mi)</span><=
br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</sp=
an><br><span>index e3cd527=2E=2Ed53c2c5 100644</span><br><span>--- a/src/op=
envpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><=
span>@@ -785,7 +785,7 @@</span><br><span> #endif /* ENABLE_PKCS11 */</span>=
<br><span>     &quot;\n&quot;</span><br><span>     &quot;General Standalone=
 Options:\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>     &quot;--show-gateway [address]: Show =
info about gateway [to v4/v6 address]=2E\n&quot;</span><br><span> #endif</s=
pan><br><span>     ;</span><br><span>@@ -4229,7 +4229,7 @@</span><br><span>=
         read_config_file(options, p[1], level, file, line, msglevel, permi=
ssion_mask,</span><br><span>                          option_types_found, e=
s);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br=
><span>     else if (streq(p[0], &quot;show-gateway&quot;) &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         struct route_gateway_info=
 rgi;</span><br><span>@@ -4938,12 +4938,13 @@</span><br><span>             =
 * mbed TLS always generating debug level logging */</span><br><span>      =
       options-&gt;ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;</span><br><span> =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined=
(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifdef ENABLE_SMALL</span><br><span>         /=
* Warn when a debug verbosity is supplied when built without debug support =
*/</span><br><span>         if (options-&gt;verbosity &gt;=3D 7)</span><br>=
<span>         {</span><br><span>             msg(M_WARN,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                &quot;NOTE: debug verbo=
sity (--verb %d) is enabled but this build lacks debug support=2E&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;=
NOTE: debug verbosity (--verb %d) is enabled but this build is &quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;bui=
lt with --enable-small that lacks support for high --verb settings&quot;,</=
span><br><span>                 options-&gt;verbosity);</span><br><span>   =
      }</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/pa=
cket_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index a4b627c=2E=2E=
22c53c7 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><s=
pan>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -52,18 +52,18 @@</sp=
an><br><span> #define SEQ_UNSEEN  ((time_t)0)</span><br><span> #define SEQ_=
EXPIRED ((time_t)1)</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void packet_id=
_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,</span><br><s=
pan>                                   const struct packet_id_net *pin, con=
st char *message,</span><br><span>                                   packet=
_id_print_type value);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> static i=
nline void</span><br><span> packet_id_debug(msglvl_t msglevel, const struct=
 packet_id_rec *p,</span><br><span>                 const struct packet_id_=
net *pin, const char *message, uint64_t value)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br>=
<span>     if (unlikely(check_debug_level(msglevel)))</span><br><span>     =
{</span><br><span>         packet_id_debug_print(msglevel, p, pin, message,=
 value);</span><br><span>@@ -576,7 +576,7 @@</span><br><span>     return (c=
har *)out=2Edata;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </s=
pan><br><span> static void</span><br><span> packet_id_debug_print(msglvl_t =
msglevel, const struct packet_id_rec *p,</span><br><span>@@ -648,7 +648,7 @=
@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENA=
BLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span> </span><br><span> uint16_t</span><br><span> packet_id_read=
_epoch(struct packet_id_net *pin, struct buffer *buf)</span><br><span>diff =
--git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>ind=
ex f8adde5=2E=2Ed10f9fa 100644</span><br><span>--- a/src/openvpn/plugin=2Ec=
</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -993,7 +99=
3,7 @@</span><br><span>     pr-&gt;n =3D 0;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DE=
BUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_S=
MALL</span><br><span> void</span><br><span> plugin_return_print(const msglv=
l_t msglevel, const char *prefix, const struct plugin_return *pr)</span><br=
><span> {</span><br><span>diff --git a/src/openvpn/plugin=2Eh b/src/openvpn=
/plugin=2Eh</span><br><span>index 7e9faf3=2E=2E684632c 100644</span><br><sp=
an>--- a/src/openvpn/plugin=2Eh</span><br><span>+++ b/src/openvpn/plugin=2E=
h</span><br><span>@@ -135,7 +135,7 @@</span><br><span> </span><br><span> vo=
id plugin_return_free(struct plugin_return *pr);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br=
><span> void plugin_return_print(const msglvl_t msglevel, const char *prefi=
x, const struct plugin_return *pr);</span><br><span> </span><br><span> #end=
if</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reli=
able=2Ec</span><br><span>index ced438e=2E=2Eb5315ff 100644</span><br><span>=
--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=
=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef ENABLE_SMALL</span><br><span> /* print the current sequence of =
active packet IDs */</span><br><span> static const char *</span><br><span> =
reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)</span><=
br><span>@@ -480,7 +480,7 @@</span><br><span>     }</span><br><span>     re=
turn BSTR(&amp;out);</span><br><span> }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* true i=
f at least one free buffer available */</span><br><span> bool</span><br><sp=
an>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><sp=
an>index 03a2526=2E=2Ee8001b3 100644</span><br><span>--- a/src/openvpn/rout=
e=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -81,7 =
+81,7 @@</span><br><span> </span><br><span> static void get_bypass_addresse=
s(struct route_bypass *rb, const unsigned int flags);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</spa=
n><br><span> </span><br><span> static void</span><br><span> print_bypass_ad=
dresses(const struct route_bypass *rb)</span><br><span>@@ -617,7 +617,7 @@<=
/span><br><span>     if (rl-&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span><=
br><span>     {</span><br><span>         setenv_route_addr(es, &quot;net_ga=
teway&quot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENAB=
LE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef EN=
ABLE_SMALL</span><br><span>         print_default_gateway(D_ROUTE, &amp;rl-=
&gt;rgi, NULL);</span><br><span> #endif</span><br><span>     }</span><br><s=
pan>@@ -660,7 +660,7 @@</span><br><span>             add_block_local_routes=
(rl);</span><br><span>         }</span><br><span>         get_bypass_addres=
ses(&amp;rl-&gt;spec=2Ebypass, rl-&gt;flags);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         print=
_bypass_addresses(&amp;rl-&gt;spec=2Ebypass);</span><br><span> #endif</span=
><br><span>     }</span><br><span>@@ -768,7 +768,7 @@</span><br><span>     =
if (rl6-&gt;ngi6=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</sp=
an><br><span>         setenv_str(es, &quot;net_gateway_ipv6&quot;, print_in=
6_addr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !de=
fined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef ENABLE_SMALL</span><br><span>         print_default_gateway(D_ROUTE=
, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</span><br><span>     }<=
/span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedul=
e=2Ec</span><br><span>index 6772ad6=2E=2E6c60dc2 100644</span><br><span>---=
 a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec<=
/span><br><span>@@ -33,7 +33,7 @@</span><br><span> </span><br><span> #inclu=
de &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void</sp=
an><br><span> schedule_entry_debug_info(const char *caller, const struct sc=
hedule_entry *e)</span><br><span> {</span><br><span>@@ -308,7 +308,7 @@</sp=
an><br><span> void</span><br><span> schedule_add_modify(struct schedule *s,=
 struct schedule_entry *e)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check=
_debug_level(D_SCHEDULER))</span><br><span>     {</span><br><span>         =
schedule_entry_debug_info(&quot;schedule_add_modify&quot;, e);</span><br><s=
pan>@@ -355,7 +355,7 @@</span><br><span>         }</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))</s=
pan><br><span>     {</span><br><span>         schedule_entry_debug_info(&qu=
ot;schedule_find_least&quot;, e);</span><br><span>diff --git a/src/tapctl/e=
rror=2Eh b/src/tapctl/error=2Eh</span><br><span>index f9586dc=2E=2E34aa894 =
100644</span><br><span>--- a/src/tapctl/error=2Eh</span><br><span>+++ b/src=
/tapctl/error=2Eh</span><br><span>@@ -83,7 +83,7 @@</span><br><span>       =
  }                                \</span><br><span>         EXIT_FATAL(fl=
ags);               \</span><br><span>     } while (false)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> =
#define dmsg(flags, =2E=2E=2E)                 \</span><br><span>     do   =
                                \</span><br><span>     {                   =
                 \</span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b=
558b8a597594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--gXorp+0ryao=--


--===============6779076264489258406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6779076264489258406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6779076264489258406==--

