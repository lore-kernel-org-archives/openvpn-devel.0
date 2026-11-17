Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF3606A339
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LYkvINDU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zo9wjbWN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lJdd5W3M;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Bx4qkTfy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=p5uI21zEmKDuFGNOEz86jH076vOS1xtY0cNsz4wrOxo=; b=LYkvINDU6T7OkbMFuKe+KYThDV
	1pfVAjF/O/AHgMiwV9us1xxD8DAaouWHCscW9udvOfdLfw6b+8N1HCoYawh4X05vDFYmGq/6U1Kwp
	3ZB4FIUKauWPd58av2cTdTP/6JPr7gLuJWT94ZX/NQQn+deyldiUEpgMSjpIgNSMA4JM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTMGM-000000008S5-38CP;
	Tue, 17 Nov 2026 16:42:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTMGC-000000008Rt-1rmb
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:42:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FXIvqmZ3ZvM4ue80XUUVzP2k8AbSblm5CqI1uhervoQ=; b=Zo9wjbWNuXIV6Rbn8cCVZWKCIW
 tHt5L8l+84fVKLHVeTVSYTBbVQS6eDLzXCQajVGCa9/VaoQkjIMXxtpHQjWlk7fECp+jKF9qVcssK
 3yHdHZQtkYeR45k15xvZkfI2ETOm37kzg1bMEmRV91x916CajmOIJC/SG5WfvHI9CZBQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FXIvqmZ3ZvM4ue80XUUVzP2k8AbSblm5CqI1uhervoQ=; b=lJdd5W3M0kVqC6ibeaETj5tcC6
 9CVpe7xhUoHBELklnzNh4+0iFi/Ghu4UiXAGSB5TbsVT8NyRtt5TtzoaLs2YtY85FqLVkK0gyRLDV
 YJ2JhmW0vgZPRQ6aw5IK45egt9gB4UiodYFLxCu9TmBuaCPfIIIP4iMlFLLVP06kbQpU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTMG8-000000007BN-3BuH for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 16:42:20 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so666315e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 08:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794933730; x=1795538530; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FXIvqmZ3ZvM4ue80XUUVzP2k8AbSblm5CqI1uhervoQ=;
 b=Bx4qkTfyTE77n8zgAiQNJRdb8hLDFZzg5vkXMjP8tbaxZFavvBQUMWsor9DpkCIWI8
 7A5ii1gtjRlcpBmIVDCrBo368AUVuO0mIoZsGrUNW++3301x0eENB3UhIshpXjjCRkWZ
 HcKOjdIxK+bVw7eoKfpDh5eina9G4Dt590zSdm//MkbDfelvNRPuHC/oWNpgq4wsl3L5
 bn58E8aF2AAvIht2r7StAlI2fOpQUd/tesBjgzRehEVv/YxEWRCDA1tkwWtrcqngWQK5
 b9Uo6ZoISuRDNNNhzQ5AVF0oYYTJafjGpDLr/faNhTMHXk+JFdH8qW+faADD5FgWD+4G
 In1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794933730; x=1795538530;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FXIvqmZ3ZvM4ue80XUUVzP2k8AbSblm5CqI1uhervoQ=;
 b=raiBKsZ+bVTvBhn9l8j0x2SzoF+sw3ocPJKVdZItTO2CDPpYePA5vDEfislMin6/RB
 sJwQCmQBcE4pLjiAXb1rmb69rNN5QqWIdYfO3ms+Re0AOK2hcYjJjddqsPAbxVs3uU0u
 N5LkRvaUAZQOU4VZheyh/SwbBEGX1ruPoZyj3YeaRj9iIngBD1+cC0+BmrqGjVzCfWyl
 KGQfU3z/gk8UPJhjEZhkWK2I8EQfZw0CLNFkaBwTaEbv4hrHUsG/RmknqCueTzE1Pv08
 jJ1eCax2TtU9G/3sZIbaYWI02wDYCKBUtlwMQddzLW7TSM3ZXNrSvpjxK8nSHsi56Gwz
 1xTQ==
X-Gm-Message-State: APuU4Z95ZplYf2tQG9QxMlsWEoBWQgEhrLFY9x5we4FvcnuiMn7T04g0
 X3veG9ZFZ/9S3PuTgWrzrG1iTSJJjvdkEQPSVNRQPejiWMhsrwFtujo8StYnPFv8LLh1eKTdk5y
 mqFGrKa00T/n4KH2ph2tDFFEPSvm5ArH3DE1oNTojQPpya/1O4nZFGamkvls1fxaGAjO5
X-Gm-Gg: AYBFou2ANx+smuQQBO46pfOCx/1wfvaWKSaanBz9Q2crynE+UJ6SLrtHDMoDQmY4b2v
 CP3yJuZ4Y3AN/laZl5roCH4Brs3Kaepecnb5RbuDXu3ZHeq05UWFKi3wcUaxNhAy6TEXjNT8Zw4
 q38t8Gvq7vkF3mFlfFugC13suvnPXz9/ZqdypDnJ5QSqOVCeE/rxsnDDoZKjC1LVipXV/csKAiN
 xmVvjwqBccYk/3giz5ehiZM58C40owBU5y4+C1GqIdrtlHAxEfMNZdPFOy9JLA3Tc8x11j5aEIG
 kgRs+zt/t11tihh5jOkQPhgC7Hzf5DxNoBA6kYidAU/8rJqkCttrqEkL7L1J5VA9y0vVr+ovaMi
 /FnoQDfQgKj3AmLwhlDeG20b4QTkf251fzBY6ic1ELl8u1VEx+8OnjKtapuh8nb07P63knLCy0U
 uGXRDYVkq4m55qW7VIQgvv7cYEJLCMX/VOVBmgYa8hx+967l0oz3p+JklF/28/G6Xadnuu2YvEp
 EbUZSkYRFPoZjo/M2uHvmX9TCB56cmJdsU0TVApeWOVonTIdhrSTPsgEl2NTaE7Lv44vykoPygo
 X4HCCZe5G+DepjVPONKfxFNzNohkNVuWgkzc3Kz2rI9IAWz4obUbf4RVZKbQlgrZOmMNkkSQyOz
 yOoLi1zEoqU7JcaAcetWXLIRLPGl16n9VAboz64sLVP4Fl96iNFjH41n4qWysZoSYY1qCsIGvi0
 21EjcZhY5MSugcfdU=
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id
 5b1f17b1804b1-4bb55a4f1b4mr305953805e9.13.1794933729724; 
 Tue, 17 Nov 2026 08:42:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb78420edasm115751935e9.9.2026.11.17.08.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:42:09 -0800 (PST)
X-Google-Original-From: "Aravind O R (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 16:42:09 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: eace777a91aea4065622707b07668aaed6b3883b
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b19c7925b672e7a71d9d67406d3a69911e9b24d5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTMG8-000000007BN-3BuH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Aravind O R \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Aravind O R \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1206112444276806422=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1206112444276806422==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gM1oMUaqac4="; charset=UTF-8

--gM1oMUaqac4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe,

I'd like you to do a code review=2E
Please visit

    h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail

to review the f=
ollowing change=2E


Change subject: configure: add compiler and linker har=
dening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


configure: add compiler and linker hardening flags

The MSVC build alread=
y hardens the binaries with /sdl, /guard:cf and,
for x86/x64 Release builds=
, /CETCOMPAT=2E A =2E/configure build only gets
what the compiler enables b=
y default or what is passed in CFLAGS and
LDFLAGS=2E Distribution packages =
get hardening flags from their build
tools, but self-built binaries, ports =
and embedded builds often do not=2E
Compiler defaults differ too: on Ubuntu=
 24=2E04 a build with gcc gets a
stack protector and BIND_NOW, the same bui=
ld with clang gets neither=2E

Add a subset of the flags recommended by the=
 OpenSSF "Compiler Options
Hardening Guide for C and C++", where the toolch=
ain accepts them:

  -D_FORTIFY_SOURCE=3D3 (or 2)
  -fstack-protector-stron=
g
  -fstack-clash-protection
  -fcf-protection=3Dfull (x86) or -mbranch-pro=
tection=3Dstandard (arm64)
  -Wl,-z,relro -Wl,-z,now

A flag is only used i=
f a small test program with a stack buffer and
calls to fortified libc func=
tions still compiles and links without any
warning=2E Warnings count as fai=
lure because GNU ld and lld only warn
about an unknown -z option=2E

The ac=
cepted flags go in front of CFLAGS and LDFLAGS, so a choice made
there, lik=
e -fno-stack-protector or -Wl,-z,lazy, takes precedence=2E
--disable-harden=
ing turns all of this off=2E

_FORTIFY_SOURCE goes into CFLAGS rather than =
CPPFLAGS, as Fedora and
Arch do, because it needs optimization: "make CFLAG=
S=3D-O0" then drops it
together with the -O flag=2E Level 3 needs GCC 12 or=
 clang 9, otherwise
level 2 is used=2E Unlike the guide, this does not use =
-U_FORTIFY_SOURCE,
so a level chosen elsewhere is respected: the define is =
skipped when
CPPFLAGS, CFLAGS or the compiler set another level or
-U_FORTI=
FY_SOURCE, when building without optimization, and for ASan
builds=2E In a =
test with clang 23, a fortified memcpy() overflow aborted
with "buffer over=
flow detected" before ASan could report it=2E

MinGW builds are not changed=
: there -fstack-protector and
_FORTIFY_SOURCE can need libssp or a recent m=
ingw-w64 runtime=2E PIE is
left to the toolchain default=2E The CMake build=
 can follow in a separate
patch=2E

Tested on x86_64 Linux with GCC 16=2E2,=
 clang 23=2E1, glibc 2=2E44 and the
bfd, gold and lld linkers: configure wi=
th 13 combinations of CC,
CPPFLAGS, CFLAGS and LDFLAGS (among them the Arch=
 package flags,
Debian-style flags, -O0, -U_FORTIFY_SOURCE and the ASan fla=
gs of the
GitHub workflow), and "make check" of --enable-werror builds with=
 gcc,
clang, and clang with ASan/UBSan=2E

The same builds, with and withou=
t this patch, in containers: Ubuntu
22=2E04 and 24=2E04, Debian 11 and 12, =
AlmaLinux 9 and Alpine 3=2E22 (musl),
covering GCC 10 to 14 and clang 11 to=
 22=2E No new warnings, and the
only failing test, t_net, fails without the=
 patch too (the containers
have no ip tool)=2E On AlmaLinux 9 (GCC 11, glib=
c 2=2E34) level 3 is
rejected and level 2 used=2E Debian 11 gcc and Alpine =
clang fail
--enable-werror with and without this patch, because of existing=

-Wconversion and -Wsign-compare warnings=2E

Not tested: the BSDs, macOS, =
Solaris and architectures other than
x86_64=2E

Assisted-by: Claude Code:cl=
aude-opus-5-5
Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
Signed-o=
ff-by: Aravind O R <aravindor@gmail=2Ecom>
---
M Changes=2Emd
M configure=
=2Eac
2 files changed, 84 insertions(+), 0 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/2213/1

diff --git a/=
Changes=2Emd b/Changes=2Emd
index 89a72fe=2E=2E9bf188a 100644
--- a/Changes=
=2Emd
+++ b/Changes=2Emd
@@ -45,6 +45,14 @@
 - Support for Mbed TLS 3 is dr=
opped=2E If you build OpenVPN with the Mbed TLS crypto
   backend, you need=
 to upgrade to Mbed TLS 4=2E
 
+- configure now adds compiler and linker ha=
rdening flags that the toolchain
+  accepts without warnings: `-D_FORTIFY_S=
OURCE=3D3` (or 2),
+  `-fstack-protector-strong`, `-fstack-clash-protection=
`,
+  `-fcf-protection=3Dfull` (x86) or `-mbranch-protection=3Dstandard` (a=
rm64), and
+  `-Wl,-z,relro -Wl,-z,now`=2E Flags given in `CPPFLAGS`, `CFLA=
GS` or `LDFLAGS`
+  take precedence=2E MinGW builds are not changed=2E Use =
`--disable-hardening` to
+  turn this off=2E
+
 # Overview of changes in 2=
=2E7
 
 ## New features
diff --git a/configure=2Eac b/configure=2Eac
index =
585c3bd=2E=2E674a315 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -2=
14,6 +214,13 @@
 )
 
 AC_ARG_ENABLE(
+	[hardening],
+	[AS_HELP_STRING([--di=
sable-hardening], [do not add compiler and linker hardening flags like -D_F=
ORTIFY_SOURCE, -fstack-protector-strong and -Wl,-z,now @<:@default=3Dyes@:>=
@])],
+	,
+	[enable_hardening=3D"yes"]
+)
+
+AC_ARG_ENABLE(
 	[selinux],
 	=
[AS_HELP_STRING([--enable-selinux], [enable SELinux support @<:@default=3Dn=
o@:>@])],
 	,
@@ -1263,6 +1270,75 @@
    [CFLAGS=3D"`echo $CFLAGS | $SED -e=
 's/-O[a-z0-9]*//g'`"]
 fi
 
+# Hardening flags, a subset of the OpenSSF "C=
ompiler Options Hardening
+# Guide for C and C++"=2E Distribution packages =
usually get similar flags
+# from their build tools; this gives other build=
s the same protection=2E
+# A flag is only used if a small program with a s=
tack buffer and calls to
+# fortified libc functions still compiles and lin=
ks without any warning
+# (ac_c_werror_flag, as AC_LANG_WERROR sets it)=2E =
The accepted flags go in
+# front of CFLAGS and LDFLAGS, so a choice made t=
here by the user (e=2Eg=2E
+# -fno-stack-protector or -Wl,-z,lazy) takes pr=
ecedence=2E
+AC_DEFUN([ACL_CHECK_ADD_HARDENING_FLAG], [
+    AC_MSG_CHECKIN=
G([whether the toolchain accepts $2])
+    old_hardening_flags=3D"$hardenin=
g_$1"
+    hardening_$1=3D"${hardening_$1:+$hardening_$1 }$2"
+    old_cfla=
gs=3D"$CFLAGS"
+    old_ldflags=3D"$LDFLAGS"
+    old_werror_flag=3D"$ac_c_=
werror_flag"
+    CFLAGS=3D"$hardening_cflags $CFLAGS"
+    LDFLAGS=3D"$har=
dening_ldflags $LDFLAGS"
+    ac_c_werror_flag=3D"yes"
+    AC_LINK_IFELSE(=
[AC_LANG_SOURCE([[$3
+#include <stdio=2Eh>
+#include <string=2Eh>
+int main=
(int argc, char **argv)
+{
+    char buf[16];
+    snprintf(buf, sizeof(buf=
), "%s", argv[0]);
+    memcpy(buf, argv[0], (size_t)argc);
+    return buf=
[0];
+}]])], [hardening_ok=3D"yes"], [hardening_ok=3D"no"; hardening_$1=3D"=
$old_hardening_flags"])
+    AC_MSG_RESULT([$hardening_ok])
+    CFLAGS=3D"=
$old_cflags"
+    LDFLAGS=3D"$old_ldflags"
+    ac_c_werror_flag=3D"$old_we=
rror_flag"]
+)
+
+# MinGW is left alone: there -fstack-protector and _FORTI=
FY_SOURCE can
+# need libssp or a recent mingw-w64 runtime=2E
+if test "${e=
nable_hardening}" =3D "yes" -a "${WIN32}" !=3D "yes"; then
+	hardening_cfla=
gs=3D""
+	hardening_ldflags=3D""
+	# Level 3 needs GCC 12 or clang 9 (glibc=
 warns otherwise), so fall
+	# back to 2=2E Not added without optimization =
(glibc warns), when
+	# CPPFLAGS, CFLAGS or the compiler already set anothe=
r level or
+	# -U_FORTIFY_SOURCE, or for ASan builds, where a fortified fun=
ction
+	# would abort before ASan can report the overflow=2E
+	for fortify_=
level in 3 2; do
+		ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-D_FORTIFY_SOUR=
CE=3D$fortify_level], [
+#if !defined(_FORTIFY_SOURCE) || _FORTIFY_SOURCE !=
=3D $fortify_level
+#error "_FORTIFY_SOURCE is set elsewhere"
+#endif
+#if =
defined(__SANITIZE_ADDRESS__)
+#error "ASan build"
+#elif defined(__has_fea=
ture)
+#if __has_feature(address_sanitizer)
+#error "ASan build"
+#endif
+#=
endif
+		])
+		test "${hardening_ok}" =3D "yes" && break
+	done
+	ACL_CHECK=
_ADD_HARDENING_FLAG([cflags], [-fstack-protector-strong])
+	ACL_CHECK_ADD_H=
ARDENING_FLAG([cflags], [-fstack-clash-protection])
+	ACL_CHECK_ADD_HARDENI=
NG_FLAG([cflags], [-fcf-protection=3Dfull])
+	ACL_CHECK_ADD_HARDENING_FLAG(=
[cflags], [-mbranch-protection=3Dstandard])
+	ACL_CHECK_ADD_HARDENING_FLAG(=
[ldflags], [-Wl,-z,relro])
+	ACL_CHECK_ADD_HARDENING_FLAG([ldflags], [-Wl,-=
z,now])
+	CFLAGS=3D"${hardening_cflags} ${CFLAGS}"
+	LDFLAGS=3D"${hardening=
_ldflags} ${LDFLAGS}"
+fi
+
 if test "${enable_pedantic}" =3D "yes"; then
 =
	CFLAGS=3D"${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedant=
ic mode])

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
13?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newcha=
nge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8fe2cb=
eadde3bad2185c4cee824ed2fe307e29e2
Gerrit-Change-Number: 2213
Gerrit-PatchS=
et: 1
Gerrit-Owner: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--gM1oMUaqac4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Aravind O =
R would like Arne Schwabe to <strong>review</strong> this change=2E
</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">Vie=
w Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">configure: add compiler and linker hardening =
flags<br><br>The MSVC build already hardens the binaries with /sdl, /guard:=
cf and,<br>for x86/x64 Release builds, /CETCOMPAT=2E A =2E/configure build =
only gets<br>what the compiler enables by default or what is passed in CFLA=
GS and<br>LDFLAGS=2E Distribution packages get hardening flags from their b=
uild<br>tools, but self-built binaries, ports and embedded builds often do =
not=2E<br>Compiler defaults differ too: on Ubuntu 24=2E04 a build with gcc =
gets a<br>stack protector and BIND_NOW, the same build with clang gets neit=
her=2E<br><br>Add a subset of the flags recommended by the OpenSSF &quot;Co=
mpiler Options<br>Hardening Guide for C and C++&quot;, where the toolchain =
accepts them:<br><br>  -D_FORTIFY_SOURCE=3D3 (or 2)<br>  -fstack-protector-=
strong<br>  -fstack-clash-protection<br>  -fcf-protection=3Dfull (x86) or -=
mbranch-protection=3Dstandard (arm64)<br>  -Wl,-z,relro -Wl,-z,now<br><br>A=
 flag is only used if a small test program with a stack buffer and<br>calls=
 to fortified libc functions still compiles and links without any<br>warnin=
g=2E Warnings count as failure because GNU ld and lld only warn<br>about an=
 unknown -z option=2E<br><br>The accepted flags go in front of CFLAGS and L=
DFLAGS, so a choice made<br>there, like -fno-stack-protector or -Wl,-z,lazy=
, takes precedence=2E<br>--disable-hardening turns all of this off=2E<br><b=
r>_FORTIFY_SOURCE goes into CFLAGS rather than CPPFLAGS, as Fedora and<br>A=
rch do, because it needs optimization: &quot;make CFLAGS=3D-O0&quot; then d=
rops it<br>together with the -O flag=2E Level 3 needs GCC 12 or clang 9, ot=
herwise<br>level 2 is used=2E Unlike the guide, this does not use -U_FORTIF=
Y_SOURCE,<br>so a level chosen elsewhere is respected: the define is skippe=
d when<br>CPPFLAGS, CFLAGS or the compiler set another level or<br>-U_FORTI=
FY_SOURCE, when building without optimization, and for ASan<br>builds=2E In=
 a test with clang 23, a fortified memcpy() overflow aborted<br>with &quot;=
buffer overflow detected&quot; before ASan could report it=2E<br><br>MinGW =
builds are not changed: there -fstack-protector and<br>_FORTIFY_SOURCE can =
need libssp or a recent mingw-w64 runtime=2E PIE is<br>left to the toolchai=
n default=2E The CMake build can follow in a separate<br>patch=2E<br><br>Te=
sted on x86_64 Linux with GCC 16=2E2, clang 23=2E1, glibc 2=2E44 and the<br=
>bfd, gold and lld linkers: configure with 13 combinations of CC,<br>CPPFLA=
GS, CFLAGS and LDFLAGS (among them the Arch package flags,<br>Debian-style =
flags, -O0, -U_FORTIFY_SOURCE and the ASan flags of the<br>GitHub workflow)=
, and &quot;make check&quot; of --enable-werror builds with gcc,<br>clang, =
and clang with ASan/UBSan=2E<br><br>The same builds, with and without this =
patch, in containers: Ubuntu<br>22=2E04 and 24=2E04, Debian 11 and 12, Alma=
Linux 9 and Alpine 3=2E22 (musl),<br>covering GCC 10 to 14 and clang 11 to =
22=2E No new warnings, and the<br>only failing test, t_net, fails without t=
he patch too (the containers<br>have no ip tool)=2E On AlmaLinux 9 (GCC 11,=
 glibc 2=2E34) level 3 is<br>rejected and level 2 used=2E Debian 11 gcc and=
 Alpine clang fail<br>--enable-werror with and without this patch, because =
of existing<br>-Wconversion and -Wsign-compare warnings=2E<br><br>Not teste=
d: the BSDs, macOS, Solaris and architectures other than<br>x86_64=2E<br><b=
r>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id: I8fe2cbeadde3bad21=
85c4cee824ed2fe307e29e2<br>Signed-off-by: Aravind O R &lt;aravindor@gmail=
=2Ecom&gt;<br>---<br>M Changes=2Emd<br>M configure=2Eac<br>2 files changed,=
 84 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/2213/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 89a72fe=2E=2E9bf1=
88a 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=
=2Emd</span><br><span>@@ -45,6 +45,14 @@</span><br><span> - Support for Mbe=
d TLS 3 is dropped=2E If you build OpenVPN with the Mbed TLS crypto</span><=
br><span>   backend, you need to upgrade to Mbed TLS 4=2E</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- configure now add=
s compiler and linker hardening flags that the toolchain</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  accepts without warnings: `-D_FORTIF=
Y_SOURCE=3D3` (or 2),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  `-fstack-protector-strong`, `-fstack-clash-protection`,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  `-fcf-protection=3Dfull` (x86) or=
 `-mbranch-protection=3Dstandard` (arm64), and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  `-Wl,-z,relro -Wl,-z,now`=2E Flags given in `C=
PPFLAGS`, `CFLAGS` or `LDFLAGS`</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  take precedence=2E MinGW builds are not changed=2E Use `--dis=
able-hardening` to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 turn this off=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> # Overview of changes in 2=2E7</span><br><span> </span><br>=
<span> ## New features</span><br><span>diff --git a/configure=2Eac b/config=
ure=2Eac</span><br><span>index 585c3bd=2E=2E674a315 100644</span><br><span>=
--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@=
@ -214,6 +214,13 @@</span><br><span> )</span><br><span> </span><br><span> A=
C_ARG_ENABLE(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[hard=
ening],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_ST=
RING([--disable-hardening], [do not add compiler and linker hardening flags=
 like -D_FORTIFY_SOURCE, -fstack-protector-strong and -Wl,-z,now @&lt;:@def=
ault=3Dyes@:&gt;@])],</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	[enable_harden=
ing=3D&quot;yes&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+AC_ARG_ENABLE(</span><br><span> 	[=
selinux],</span><br><span> 	[AS_HELP_STRING([--enable-selinux], [enable SEL=
inux support @&lt;:@default=3Dno@:&gt;@])],</span><br><span> 	,</span><br><=
span>@@ -1263,6 +1270,75 @@</span><br><span>    [CFLAGS=3D&quot;`echo $CFLA=
GS | $SED -e &#39;s/-O[a-z0-9]*//g&#39;`&quot;]</span><br><span> fi</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Hardeni=
ng flags, a subset of the OpenSSF &quot;Compiler Options Hardening</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# Guide for C and C++&quot;=
=2E Distribution packages usually get similar flags</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# from their build tools; this gives othe=
r builds the same protection=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# A flag is only used if a small program with a stack buffer an=
d calls to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# fortifi=
ed libc functions still compiles and links without any warning</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# (ac_c_werror_flag, as AC_LANG_=
WERROR sets it)=2E The accepted flags go in</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# front of CFLAGS and LDFLAGS, so a choice made the=
re by the user (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# -fno-stack-protector or -Wl,-z,lazy) takes precedence=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([ACL_CHECK_ADD_HARDENI=
NG_FLAG], [</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AC_M=
SG_CHECKING([whether the toolchain accepts $2])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    old_hardening_flags=3D&quot;$hardening_$1&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hardening_$=
1=3D&quot;${hardening_$1:+$hardening_$1 }$2&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    old_cflags=3D&quot;$CFLAGS&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    old_ldflags=3D&quot;$LDF=
LAGS&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    old_w=
error_flag=3D&quot;$ac_c_werror_flag&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    CFLAGS=3D&quot;$hardening_cflags $CFLAGS&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LDFLAGS=3D&quot;$=
hardening_ldflags $LDFLAGS&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ac_c_werror_flag=3D&quot;yes&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    AC_LINK_IFELSE([AC_LANG_SOURCE([[$3</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;s=
tring=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int ma=
in(int argc, char **argv)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char buf=
[16];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(b=
uf, sizeof(buf), &quot;%s&quot;, argv[0]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    memcpy(buf, argv[0], (size_t)argc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return buf[0];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}]])], [hardening_ok=3D&quot;yes&=
quot;], [hardening_ok=3D&quot;no&quot;; hardening_$1=3D&quot;$old_hardening=
_flags&quot;])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
C_MSG_RESULT([$hardening_ok])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    CFLAGS=3D&quot;$old_cflags&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    LDFLAGS=3D&quot;$old_ldflags&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ac_c_werror_flag=3D&quot;=
$old_werror_flag&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# MinGW is left alone: there -fst=
ack-protector and _FORTIFY_SOURCE can</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# need libssp or a recent mingw-w64 runtime=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+if test &quot;${enable_hardeni=
ng}&quot; =3D &quot;yes&quot; -a &quot;${WIN32}&quot; !=3D &quot;yes&quot;;=
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	hardening_cfl=
ags=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
hardening_ldflags=3D&quot;&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	# Level 3 needs GCC 12 or clang 9 (glibc warns otherwise), so=
 fall</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# back to 2=
=2E Not added without optimization (glibc warns), when</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	# CPPFLAGS, CFLAGS or the compiler alre=
ady set another level or</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	# -U_FORTIFY_SOURCE, or for ASan builds, where a fortified function</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# would abort before=
 ASan can report the overflow=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	for fortify_level in 3 2; do</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+		ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-D_FORTIFY=
_SOURCE=3D$fortify_level], [</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if !defined(_FORTIFY_SOURCE) || _FORTIFY_SOURCE !=3D $fortify_lev=
el</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#error &quot;_FOR=
TIFY_SOURCE is set elsewhere&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__SANITIZE_ADDRESS__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#error &quot;ASan build&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#elif defined(__has_feature)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if __has_feature(address_sanitizer)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#error &quot;ASan build=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+		])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+		test &quot;${hardening_ok}&quot; =3D &quot;yes&quot;=
 &amp;&amp; break</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	d=
one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	ACL_CHECK_ADD_H=
ARDENING_FLAG([cflags], [-fstack-protector-strong])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	ACL_CHECK_ADD_HARDENING_FLAG([cflags], [=
-fstack-clash-protection])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-fcf-protection=3Dfull])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	ACL_CHECK_ADD_HARDENI=
NG_FLAG([cflags], [-mbranch-protection=3Dstandard])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	ACL_CHECK_ADD_HARDENING_FLAG([ldflags], =
[-Wl,-z,relro])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	ACL=
_CHECK_ADD_HARDENING_FLAG([ldflags], [-Wl,-z,now])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	CFLAGS=3D&quot;${hardening_cflags} ${CFLAGS=
}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	LDFLAGS=3D&=
quot;${hardening_ldflags} ${LDFLAGS}&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> if test &quot;${enable_pedantic}&quot; =3D &quot;ye=
s&quot;; then</span><br><span> 	CFLAGS=3D&quot;${CFLAGS} -pedantic&quot;</s=
pan><br><span> 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2213?usp=3Demail">change 2213</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2213?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </di=
v>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 2213 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--gM1oMUaqac4=--


--===============1206112444276806422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1206112444276806422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1206112444276806422==--

