Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29426606A325
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VwZbJ1D/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kutKiiKb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IppxRvtC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=e/cjnlBU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o6kHqeL3SXg/j5wEQh35lqGk1GkWIpT1AFFFVzGLyI8=; b=VwZbJ1D/ZW8pMzMNsUAaMe4pJr
	zvxnKjti4JCAXDAb/hiXe/kpY/QAK0DzYI4Bx8i+o3uhepAubnQdwROZ2+6YmH7qH0MKNP8pmaLfY
	5gSWqiUh0mEBd0+vSVarQvTih7NgpX1iRJiMYRKff5FdsmEYal02OS5p1GYqgxUJk2Ng=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU5Ak-000000003qm-2UGM;
	Thu, 19 Nov 2026 16:39:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU5Aj-000000003qg-0yPY
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mko7TI9G9kebwMFV5tYHARq++Zz6glFOQBVI0M5ob2k=; b=kutKiiKb67cG6EhRv0u60pvMOm
 hF8libhHuZi3bjiI5TKm2EnRyhWpWxiqkHatCfnfUPmQdo/F36ULcu68BNjITttj1bVadDg2AjyAB
 7ztgJLCmyMaG5xOKdkEMwB/ZQx+xTeKTMfWRAtHHofE2z/tFfrMNdFB3YKeFgT763Euw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mko7TI9G9kebwMFV5tYHARq++Zz6glFOQBVI0M5ob2k=; b=IppxRvtCMSqglm2RWyduyppjzx
 GzAiNrlN/YWoKP0cpw2vP3K8+hzL11SNj0oSo0sHmT3W37M94kA821QqAvcwtU7x3gs7e4WyLBEgM
 /TH6dCyv3Mc5NoUdiechrCFrCGXMtU0pyZ4intxsW+8mHHZt2zQGB2KLJ4Qm4sHvUzhM=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU5Ah-000000006Vv-0kK0 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:39:41 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso14389865e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 08:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795106372; x=1795711172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mko7TI9G9kebwMFV5tYHARq++Zz6glFOQBVI0M5ob2k=;
 b=e/cjnlBUMib4njyaGdWvB3368Uozq5KcYy7oDqvwYUROZAW+onI5+lrQsXRnIBRauj
 voyHY65vTS8FaJNn1PN3FLGP4M8+z5e4YpakxIA6odt8RT7OjebvpeM5qjsXYIjZ0BO/
 dGMO6aZidEzr2mKyJFZazvFSizaA50ofR8rndItR+3vkL6vn+4NMR+mYBB89W8FtzFDA
 V69HUW3JPUe3DYEctaInbRhVhwiNFTs5Nry2ep1BtlomlUCgkNvVo9VuoVTndKnuFu9u
 /McNX6d6sWkkV1WMuk6PqF9LrnUo4yhcS5/3uG54v7xBgmdeQ2qQp6I+c1Ef3Uqtv5tx
 nKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106372; x=1795711172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mko7TI9G9kebwMFV5tYHARq++Zz6glFOQBVI0M5ob2k=;
 b=J9vuyG8ZheVCQ68hjmvE/OmuqX530HsuBslYuzvAnkSm18HVDWRVrNMO+q4AS18GU2
 D+w3FTKXyF/lt4akEIB89WdWOFnohThvwe6kfg61hF38Xni3naZ0H/CqPZYHCviSGojH
 FL/v7m9a0Y5K6zGIy2zwWIz+S+7L3AWCuGsO/BtEQ0vJR0PiiJCEqoS1mJVcitHx2rXB
 zaSyygAz0xaxWHhmxOkorGRB8i4PicdgnYghw/hkKJOi5lCJ2IYPUHRuT6zsxvhvs6GX
 lJ+qiWqPzQ/yj2e+W6goojpxw3zbPryJJgYeCn7BsiutkVUFkxcXVwmVBDoD7FvCzHqw
 F1Rg==
X-Gm-Message-State: APuU4Z9fKtyu3CKTw69uZYkzvae+wt6YRakuSB2vX0uj9r8Vl5N0uKXW
 Tq2jps6knr7mPFGLOpoAk8hksA4dssCFCxXggoeXeEiqBnC2gFLgxOGQMQH7fgXiBuzpbs4RJeb
 sJa5jIOM1a2MXRLPxEwnEKlMJV5XYUP3Lf79evmQq8olSFTtfBjmAnxaNpTvzvBCGdUx4
X-Gm-Gg: AYBFou294fDswOJlD9YvW9W1JLTe1kOvFI5ziWDGiQK7G2W5GjGFjQitOonT6XIrdW7
 L35P7J9wx16T9MJTrAdZazkTYt+Opgo42MxZcnN1DlMseOqEOzdb0iRmD7MavBRUfrzVD9l8OWq
 gioXuJbLNPVU4OMerGUxehkWVJaOvs88R3nMLIvcJXsmqDBhGT43R1bYR1SYTyHEDdXpswvUGfG
 2dSPRuCzP1mBP41mSvEnNCiBJ0rHTeYY4LFsZ6JBpmH5jVYykhnVBR/6tPzwe39Od1OGfj5U/UF
 bBDT4/oautEy8vcW8QNj6N7fxtph5976qZFX+R61vgmIIMpwdzUjs7z2zHE3TVoV37tItsxgm2U
 JrDak+/it71qFhkZ+HsTdOQLqEG/VNkG8aVB5Kuuc/NmaWwXeTp4l401zTI4ghNGjHmfi158ezd
 s9OzKuFo38wMGxud284oMfdokJrjRm0eSgwtj16v5Xuh/qOfWZiRrMQXFAflcKfuXyGvjAdOGIg
 TzSHMz4NHNjbRVsLoLp/YjBcc1FOIIvbdF4J52CE9traaG5gh2RzCt/GXfX2ryyNgEkUjH4rDNS
 BKKHs+idvP73buMrtnAA4j9WfslLe0n5ciDIpfKddIqn7O1bT3pRnAcrEtZP6m8x+CJwZNSoBkI
 x0cVnu2OxzqclQtB3SElKure95TV3CRQBbkn/nsVsOj2GoOigJPWh9LogUrWttnyjoDpnxmiZyY
 mKHeHwa70rg9QBuzzuJ0qgdHBkjXeepK9jLiy/
X-Received: by 2002:a05:600c:46cc:b0:4bb:6f41:399f with SMTP id
 5b1f17b1804b1-4bb888236a3mr842915e9.24.1795106372231; 
 Thu, 19 Nov 2026 08:39:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d55sm559276f8f.5.2026.11.19.08.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:39:31 -0800 (PST)
X-Google-Original-From: "Aravind O R (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 16:39:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8d883b028b7acba33019a4474101f3fee4de7bdc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU5Ah-000000006Vv-0kK0
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Aravind O R \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7722294655550933516=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7722294655550933516==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GCU8k9P/vAw="; charset=UTF-8

--GCU8k9P/vAw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Hello A=
rne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a change=2E Ple=
ase visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
=

to look at the new patch set (#2)=2E


Change subject: configure: add comp=
iler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

configure: add compiler and linker hardening flags

The=
 MSVC build already uses /sdl, /guard:cf and, for x86/x64 Release
builds, /=
CETCOMPAT=2E A =2E/configure build only gets what the compiler
enables by d=
efault or what is passed in CFLAGS and LDFLAGS=2E
Distribution packages get=
 hardening flags from their build tools, but
self-built binaries and embedd=
ed builds often do not=2E Compiler defaults
differ too: on Ubuntu 24=2E04 a=
 build with gcc gets a stack protector and
BIND_NOW, the same build with cl=
ang gets neither=2E

Add the run-time protections from the OpenSSF "Compile=
r Options
Hardening Guide for C and C++" that Fedora and Arch apply to all =
their
packages, and Debian with dpkg-buildflags hardening=3D+all, through b=
uild
flags or toolchain defaults, where the toolchain accepts them:

  -D_F=
ORTIFY_SOURCE=3D3 (or 2)
  -fstack-protector-strong
  -fstack-clash-protect=
ion
  -fcf-protection=3Dfull (x86) or -mbranch-protection=3Dstandard (arm64=
)
  -Wl,-z,relro -Wl,-z,now
  -Wl,-z,noexecstack

-Wl,-z,noexecstack is the=
 default for compiler output, but gold, and
GNU ld as built by Debian and U=
buntu, make the stack executable when an
object has no =2Enote=2EGNU-stack =
section=2E

Of the distribution flags, -fexceptions is left out because ope=
nvpn
creates no threads, -Wl,--as-needed because it changes which libraries=

are linked rather than protecting the code, and -pie because the
plugins l=
ink with the same LDFLAGS: with gcc, -pie after -shared links
an executable=
=2E C++-only flags do not apply, and
-Wl,--no-copy-dt-needed-entries is alr=
eady the GNU ld default=2E Of the
guide's other flags, -Wl,-z,nodlopen woul=
d stop the plugins from
loading, and -fno-strict-overflow, -fno-strict-alia=
sing,
-fno-delete-null-pointer-checks, -ftrivial-auto-var-init,
-fzero-call=
-used-regs, -fzero-init-padding-bits and
-fstrict-flex-arrays are not appli=
ed by distributions by default, so
they deserve their own discussion=2E -fh=
ardened (GCC 14) also enables
-ftrivial-auto-var-init=3Dzero and -pie=2E Wa=
rning flags stay with the
existing list in configure=2Eac=2E

A flag is onl=
y used if a small test program with a stack buffer and
calls to fortified l=
ibc functions still compiles and links without any
warning, so nothing is a=
dded if the user's flags alone make it warn=2E
Warnings count as failure be=
cause GNU ld and lld only warn about an
unknown -z option=2E The accepted f=
lags go in front of CFLAGS and
LDFLAGS, so a choice made there, like -fno-s=
tack-protector or
-Wl,-z,lazy, takes precedence=2E GCC 14 and later combine=
 repeated
-fcf-protection options instead, so -fcf-protection and
-mbranch-=
protection are not added when CC, CPPFLAGS or CFLAGS already
set one=2E --d=
isable-hardening turns all of this off=2E

_FORTIFY_SOURCE goes into CFLAGS=
 rather than CPPFLAGS, as Fedora and
Arch do, because it needs optimization=
: a make-time CFLAGS=3D-O0 then
replaces it together with the -O flag=2E Le=
vel 3 needs GCC 12 or clang 9,
otherwise level 2 is used, and glibc 2=2E32 =
and older treat 3 as 2=2E
Unlike the guide, this does not use -U_FORTIFY_SO=
URCE, so a level
chosen elsewhere is respected: the define is skipped when =
CPPFLAGS,
CFLAGS or the compiler set another level or -U_FORTIFY_SOURCE, wh=
en
building without optimization, and for ASan builds, where FORTIFY can
hi=
de an overflow from ASan=2E

MinGW builds are not changed: there -fstack-pr=
otector and
_FORTIFY_SOURCE can need libssp or a recent mingw-w64 runtime=
=2E The
CMake build can follow in a separate patch=2E

Tested on x86_64 Lin=
ux only=2E On Arch (GCC 16, clang 23, glibc 2=2E44,
bfd, gold and lld): con=
figure with 19 combinations of CC, CPPFLAGS,
CFLAGS and LDFLAGS (among them=
 the Arch package flags, Debian-style
flags, -O0, -U_FORTIFY_SOURCE, -fcf-p=
rotection in CC, CPPFLAGS and
CFLAGS, -Wl,-z,execstack and the ASan flags o=
f the GitHub workflow), and
"make check" of --enable-werror builds with gcc=
, clang, and clang with
ASan/UBSan=2E In containers, gcc and clang builds w=
ith and without this
patch on Ubuntu 22=2E04 and 24=2E04, Debian 11 and 12,=
 AlmaLinux 9 and
Alpine 3=2E22 (GCC 10 to 14, clang 11 to 22, musl): no new=
 warnings and
the same test results (t_net fails either way, the containers=
 have no
ip tool)=2E Debian 11 gcc and Alpine clang were built without
--en=
able-werror, which fails there on master too=2E Not tested: the BSDs,
macOS=
, Solaris and other architectures=2E

Assisted-by: Claude Code:claude-opus-=
5-5
Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
Signed-off-by: Ara=
vind O R <aravindor@gmail=2Ecom>
---
M Changes=2Emd
M configure=2Eac
2 file=
s changed, 116 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/13/2213/2

diff --git a/Changes=2Emd=
 b/Changes=2Emd
index 89a72fe=2E=2E10c9b96 100644
--- a/Changes=2Emd
+++ b/=
Changes=2Emd
@@ -45,6 +45,14 @@
 - Support for Mbed TLS 3 is dropped=2E If =
you build OpenVPN with the Mbed TLS crypto
   backend, you need to upgrade =
to Mbed TLS 4=2E
 
+- configure now adds compiler and linker hardening flag=
s that the toolchain
+  accepts without warnings: `-D_FORTIFY_SOURCE=3D3` (=
or 2),
+  `-fstack-protector-strong`, `-fstack-clash-protection`,
+  `-fcf-=
protection=3Dfull` (x86) or `-mbranch-protection=3Dstandard` (arm64), and
+=
  `-Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack`=2E Flags given in `CFLAGS` o=
r
+  `LDFLAGS`, and a `_FORTIFY_SOURCE` level in `CPPFLAGS`, take precedenc=
e=2E
+  MinGW builds are not changed=2E Use `--disable-hardening` to turn t=
his off=2E
+
 # Overview of changes in 2=2E7
 
 ## New features
diff --git =
a/configure=2Eac b/configure=2Eac
index 585c3bd=2E=2E886c29e 100644
--- a/c=
onfigure=2Eac
+++ b/configure=2Eac
@@ -214,6 +214,13 @@
 )
 
 AC_ARG_ENABLE=
(
+	[hardening],
+	[AS_HELP_STRING([--disable-hardening], [do not add compi=
ler and linker hardening flags like -D_FORTIFY_SOURCE, -fstack-protector-st=
rong and -Wl,-z,now @<:@default=3Dyes@:>@])],
+	,
+	[enable_hardening=3D"ye=
s"]
+)
+
+AC_ARG_ENABLE(
 	[selinux],
 	[AS_HELP_STRING([--enable-selinux],=
 [enable SELinux support @<:@default=3Dno@:>@])],
 	,
@@ -1263,6 +1270,107 =
@@
    [CFLAGS=3D"`echo $CFLAGS | $SED -e 's/-O[a-z0-9]*//g'`"]
 fi
 
+# Ha=
rdening flags: the run-time protections from the OpenSSF "Compiler
+# Optio=
ns Hardening Guide for C and C++" that Fedora and Arch apply to
+# all thei=
r packages, and Debian with dpkg-buildflags hardening=3D+all,
+# through bu=
ild flags or toolchain defaults=2E Left out of those are
+# -fexceptions, b=
ecause openvpn creates no threads, -Wl,--as-needed,
+# because it changes w=
hich libraries are linked rather than protecting
+# the code, and -pie, bec=
ause it must only reach the executable while
+# the plugins link with the s=
ame LDFLAGS=2E -Wl,-z,noexecstack is the
+# default for compiler output, bu=
t GNU ld and gold can make the stack
+# executable when an object has no =
=2Enote=2EGNU-stack section, so it is set
+# explicitly=2E
+#
+# A flag is =
only used if a small program with a stack buffer and calls to
+# fortified =
libc functions still compiles and links without any warning
+# (ac_c_werror=
_flag, as AC_LANG_WERROR sets it), so if the user's flags
+# alone make it =
warn, nothing is added=2E The accepted flags go in front of
+# CFLAGS and L=
DFLAGS, so a choice made there by the user (e=2Eg=2E
+# -fno-stack-protecto=
r or -Wl,-z,lazy) takes precedence=2E
+AC_DEFUN([ACL_CHECK_ADD_HARDENING_FL=
AG], [
+    AC_MSG_CHECKING([whether to add $2])
+    old_hardening_flags=
=3D"$hardening_$1"
+    hardening_$1=3D"${hardening_$1:+$hardening_$1 }$2"
=
+    old_cflags=3D"$CFLAGS"
+    old_ldflags=3D"$LDFLAGS"
+    old_werror_f=
lag=3D"$ac_c_werror_flag"
+    CFLAGS=3D"$hardening_cflags $CFLAGS"
+    LD=
FLAGS=3D"$hardening_ldflags $LDFLAGS"
+    ac_c_werror_flag=3D"yes"
+    AC=
_LINK_IFELSE([AC_LANG_SOURCE([[$3
+#include <stdio=2Eh>
+#include <string=
=2Eh>
+int main(int argc, char **argv)
+{
+    char buf[16];
+    snprintf(=
buf, sizeof(buf), "%s", argv[0]);
+    memcpy(buf, argv[0], (size_t)argc);
=
+    return buf[0];
+}]])], [hardening_ok=3D"yes"], [hardening_ok=3D"no"; h=
ardening_$1=3D"$old_hardening_flags"])
+    AC_MSG_RESULT([$hardening_ok])
=
+    CFLAGS=3D"$old_cflags"
+    LDFLAGS=3D"$old_ldflags"
+    ac_c_werror_=
flag=3D"$old_werror_flag"]
+)
+
+# MinGW is left alone: there -fstack-prote=
ctor and _FORTIFY_SOURCE can
+# need libssp or a recent mingw-w64 runtime=
=2E
+if test "${enable_hardening}" =3D "yes" -a "${WIN32}" !=3D "yes"; then=

+	hardening_cflags=3D""
+	hardening_ldflags=3D""
+	# Level 3 needs GCC 12 =
or clang 9 (glibc 2=2E33 and later warn
+	# otherwise), so fall back to 2=
=2E Older glibc treats 3 as 2=2E Not added
+	# without optimization (glibc =
warns), when CPPFLAGS, CFLAGS or the
+	# compiler already set another level=
 or -U_FORTIFY_SOURCE, or for ASan
+	# builds, where FORTIFY can hide an ov=
erflow from ASan (with clang, the
+	# fortified function aborts before ASan=
 reports it)=2E
+	for fortify_level in 3 2; do
+		ACL_CHECK_ADD_HARDENING_F=
LAG([cflags], [-D_FORTIFY_SOURCE=3D$fortify_level], [
+#if !defined(_FORTIF=
Y_SOURCE) || _FORTIFY_SOURCE !=3D $fortify_level
+#error "_FORTIFY_SOURCE i=
s set elsewhere"
+#endif
+#if defined(__SANITIZE_ADDRESS__)
+#error "ASan b=
uild"
+#elif defined(__has_feature)
+#if __has_feature(address_sanitizer)
+=
#error "ASan build"
+#endif
+#endif
+		])
+		test "${hardening_ok}" =3D "ye=
s" && break
+	done
+	ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-fstack-protec=
tor-strong])
+	ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-fstack-clash-protec=
tion])
+	# GCC 14 and later combine repeated -fcf-protection options instea=
d of
+	# using the last one, so a value set by the user would not take
+	# =
precedence over ours=2E Leave the option to the user then, and treat
+	# -m=
branch-protection the same way=2E
+	case "${CC} ${CPPFLAGS} ${CFLAGS}" in
+=
		*-fcf-protection*)
+			AC_MSG_CHECKING([whether to add -fcf-protection=3D=
full])
+			AC_MSG_RESULT([no, set by the user])
+			;;
+		*)
+			ACL_CHECK_=
ADD_HARDENING_FLAG([cflags], [-fcf-protection=3Dfull])
+			;;
+	esac
+	case=
 "${CC} ${CPPFLAGS} ${CFLAGS}" in
+		*-mbranch-protection*)
+			AC_MSG_CHEC=
KING([whether to add -mbranch-protection=3Dstandard])
+			AC_MSG_RESULT([no=
, set by the user])
+			;;
+		*)
+			ACL_CHECK_ADD_HARDENING_FLAG([cflags],=
 [-mbranch-protection=3Dstandard])
+			;;
+	esac
+	ACL_CHECK_ADD_HARDENING_=
FLAG([ldflags], [-Wl,-z,relro])
+	ACL_CHECK_ADD_HARDENING_FLAG([ldflags], [=
-Wl,-z,now])
+	ACL_CHECK_ADD_HARDENING_FLAG([ldflags], [-Wl,-z,noexecstack]=
)
+	CFLAGS=3D"${hardening_cflags} ${CFLAGS}"
+	LDFLAGS=3D"${hardening_ldfla=
gs} ${LDFLAGS}"
+fi
+
 if test "${enable_pedantic}" =3D "yes"; then
 	CFLAG=
S=3D"${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mod=
e])

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8fe2cbeadd=
e3bad2185c4cee824ed2fe307e29e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: =
2
Gerrit-Owner: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: Aravind O R <aravindor@gmail=2Ecom>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--GCU8k9P/vAw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Aravind O R <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: add compiler and linker hardening flags<br><br>The=
 MSVC build already uses /sdl, /guard:cf and, for x86/x64 Release<br>builds=
, /CETCOMPAT=2E A =2E/configure build only gets what the compiler<br>enable=
s by default or what is passed in CFLAGS and LDFLAGS=2E<br>Distribution pac=
kages get hardening flags from their build tools, but<br>self-built binarie=
s and embedded builds often do not=2E Compiler defaults<br>differ too: on U=
buntu 24=2E04 a build with gcc gets a stack protector and<br>BIND_NOW, the =
same build with clang gets neither=2E<br><br>Add the run-time protections f=
rom the OpenSSF &quot;Compiler Options<br>Hardening Guide for C and C++&quo=
t; that Fedora and Arch apply to all their<br>packages, and Debian with dpk=
g-buildflags hardening=3D+all, through build<br>flags or toolchain defaults=
, where the toolchain accepts them:<br><br>  -D_FORTIFY_SOURCE=3D3 (or 2)<b=
r>  -fstack-protector-strong<br>  -fstack-clash-protection<br>  -fcf-protec=
tion=3Dfull (x86) or -mbranch-protection=3Dstandard (arm64)<br>  -Wl,-z,rel=
ro -Wl,-z,now<br>  -Wl,-z,noexecstack<br><br>-Wl,-z,noexecstack is the defa=
ult for compiler output, but gold, and<br>GNU ld as built by Debian and Ubu=
ntu, make the stack executable when an<br>object has no =2Enote=2EGNU-stack=
 section=2E<br><br>Of the distribution flags, -fexceptions is left out beca=
use openvpn<br>creates no threads, -Wl,--as-needed because it changes which=
 libraries<br>are linked rather than protecting the code, and -pie because =
the<br>plugins link with the same LDFLAGS: with gcc, -pie after -shared lin=
ks<br>an executable=2E C++-only flags do not apply, and<br>-Wl,--no-copy-dt=
-needed-entries is already the GNU ld default=2E Of the<br>guide&#39;s othe=
r flags, -Wl,-z,nodlopen would stop the plugins from<br>loading, and -fno-s=
trict-overflow, -fno-strict-aliasing,<br>-fno-delete-null-pointer-checks, -=
ftrivial-auto-var-init,<br>-fzero-call-used-regs, -fzero-init-padding-bits =
and<br>-fstrict-flex-arrays are not applied by distributions by default, so=
<br>they deserve their own discussion=2E -fhardened (GCC 14) also enables<b=
r>-ftrivial-auto-var-init=3Dzero and -pie=2E Warning flags stay with the<br=
>existing list in configure=2Eac=2E<br><br>A flag is only used if a small t=
est program with a stack buffer and<br>calls to fortified libc functions st=
ill compiles and links without any<br>warning, so nothing is added if the u=
ser&#39;s flags alone make it warn=2E<br>Warnings count as failure because =
GNU ld and lld only warn about an<br>unknown -z option=2E The accepted flag=
s go in front of CFLAGS and<br>LDFLAGS, so a choice made there, like -fno-s=
tack-protector or<br>-Wl,-z,lazy, takes precedence=2E GCC 14 and later comb=
ine repeated<br>-fcf-protection options instead, so -fcf-protection and<br>=
-mbranch-protection are not added when CC, CPPFLAGS or CFLAGS already<br>se=
t one=2E --disable-hardening turns all of this off=2E<br><br>_FORTIFY_SOURC=
E goes into CFLAGS rather than CPPFLAGS, as Fedora and<br>Arch do, because =
it needs optimization: a make-time CFLAGS=3D-O0 then<br>replaces it togethe=
r with the -O flag=2E Level 3 needs GCC 12 or clang 9,<br>otherwise level 2=
 is used, and glibc 2=2E32 and older treat 3 as 2=2E<br>Unlike the guide, t=
his does not use -U_FORTIFY_SOURCE, so a level<br>chosen elsewhere is respe=
cted: the define is skipped when CPPFLAGS,<br>CFLAGS or the compiler set an=
other level or -U_FORTIFY_SOURCE, when<br>building without optimization, an=
d for ASan builds, where FORTIFY can<br>hide an overflow from ASan=2E<br><b=
r>MinGW builds are not changed: there -fstack-protector and<br>_FORTIFY_SOU=
RCE can need libssp or a recent mingw-w64 runtime=2E The<br>CMake build can=
 follow in a separate patch=2E<br><br>Tested on x86_64 Linux only=2E On Arc=
h (GCC 16, clang 23, glibc 2=2E44,<br>bfd, gold and lld): configure with 19=
 combinations of CC, CPPFLAGS,<br>CFLAGS and LDFLAGS (among them the Arch p=
ackage flags, Debian-style<br>flags, -O0, -U_FORTIFY_SOURCE, -fcf-protectio=
n in CC, CPPFLAGS and<br>CFLAGS, -Wl,-z,execstack and the ASan flags of the=
 GitHub workflow), and<br>&quot;make check&quot; of --enable-werror builds =
with gcc, clang, and clang with<br>ASan/UBSan=2E In containers, gcc and cla=
ng builds with and without this<br>patch on Ubuntu 22=2E04 and 24=2E04, Deb=
ian 11 and 12, AlmaLinux 9 and<br>Alpine 3=2E22 (GCC 10 to 14, clang 11 to =
22, musl): no new warnings and<br>the same test results (t_net fails either=
 way, the containers have no<br>ip tool)=2E Debian 11 gcc and Alpine clang =
were built without<br>--enable-werror, which fails there on master too=2E N=
ot tested: the BSDs,<br>macOS, Solaris and other architectures=2E<br><br>As=
sisted-by: Claude Code:claude-opus-5-5<br>Change-Id: I8fe2cbeadde3bad2185c4=
cee824ed2fe307e29e2<br>Signed-off-by: Aravind O R &lt;aravindor@gmail=2Ecom=
&gt;<br>---<br>M Changes=2Emd<br>M configure=2Eac<br>2 files changed, 116 i=
nsertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/13/2213/2</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/Changes=2Emd b/Changes=2Emd</span><br><span>index 89a72fe=2E=2E10c9b96 10=
0644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd<=
/span><br><span>@@ -45,6 +45,14 @@</span><br><span> - Support for Mbed TLS =
3 is dropped=2E If you build OpenVPN with the Mbed TLS crypto</span><br><sp=
an>   backend, you need to upgrade to Mbed TLS 4=2E</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+- configure now adds comp=
iler and linker hardening flags that the toolchain</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  accepts without warnings: `-D_FORTIFY_SOUR=
CE=3D3` (or 2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `-=
fstack-protector-strong`, `-fstack-clash-protection`,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  `-fcf-protection=3Dfull` (x86) or `-mbr=
anch-protection=3Dstandard` (arm64), and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  `-Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack`=2E Flag=
s given in `CFLAGS` or</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  `LDFLAGS`, and a `_FORTIFY_SOURCE` level in `CPPFLAGS`, take precedenc=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  MinGW builds =
are not changed=2E Use `--disable-hardening` to turn this off=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Overview o=
f changes in 2=2E7</span><br><span> </span><br><span> ## New features</span=
><br><span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>ind=
ex 585c3bd=2E=2E886c29e 100644</span><br><span>--- a/configure=2Eac</span><=
br><span>+++ b/configure=2Eac</span><br><span>@@ -214,6 +214,13 @@</span><b=
r><span> )</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	[hardening],</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--disable-hardening], =
[do not add compiler and linker hardening flags like -D_FORTIFY_SOURCE, -fs=
tack-protector-strong and -Wl,-z,now @&lt;:@default=3Dyes@:&gt;@])],</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	[enable_hardening=3D&quot;yes&quot;]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+AC_ARG_ENABLE(</span><br><span> 	[selinux],</span><br><span>=
 	[AS_HELP_STRING([--enable-selinux], [enable SELinux support @&lt;:@defaul=
t=3Dno@:&gt;@])],</span><br><span> 	,</span><br><span>@@ -1263,6 +1270,107 =
@@</span><br><span>    [CFLAGS=3D&quot;`echo $CFLAGS | $SED -e &#39;s/-O[a-=
z0-9]*//g&#39;`&quot;]</span><br><span> fi</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# Hardening flags: the run-time pr=
otections from the OpenSSF &quot;Compiler</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# Options Hardening Guide for C and C++&quot; that Fe=
dora and Arch apply to</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# all their packages, and Debian with dpkg-buildflags hardening=3D+all,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# through build flag=
s or toolchain defaults=2E Left out of those are</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# -fexceptions, because openvpn creates no thr=
eads, -Wl,--as-needed,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# because it changes which libraries are linked rather than protecting</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# the code, and -pie,=
 because it must only reach the executable while</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# the plugins link with the same LDFLAGS=2E -W=
l,-z,noexecstack is the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+# default for compiler output, but GNU ld and gold can make the stack</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# executable when an =
object has no =2Enote=2EGNU-stack section, so it is set</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# explicitly=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# A flag is only used if a small program with a stack buffe=
r and calls to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# for=
tified libc functions still compiles and links without any warning</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# (ac_c_werror_flag, as AC_L=
ANG_WERROR sets it), so if the user&#39;s flags</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# alone make it warn, nothing is added=2E The a=
ccepted flags go in front of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# CFLAGS and LDFLAGS, so a choice made there by the user (e=2Eg=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -fno-stack-protec=
tor or -Wl,-z,lazy) takes precedence=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+AC_DEFUN([ACL_CHECK_ADD_HARDENING_FLAG], [</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    AC_MSG_CHECKING([whether to =
add $2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    old_har=
dening_flags=3D&quot;$hardening_$1&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    hardening_$1=3D&quot;${hardening_$1:+$hardening_$1=
 }$2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    old_c=
flags=3D&quot;$CFLAGS&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    old_ldflags=3D&quot;$LDFLAGS&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    old_werror_flag=3D&quot;$ac_c_werror_flag&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CFLAGS=3D&qu=
ot;$hardening_cflags $CFLAGS&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    LDFLAGS=3D&quot;$hardening_ldflags $LDFLAGS&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ac_c_werror_flag=3D&qu=
ot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AC_=
LINK_IFELSE([AC_LANG_SOURCE([[$3</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int main(int argc, char **argv)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    char buf[16];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    snprintf(buf, sizeof(buf), &quot;%s&quot;, argv[0])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(buf, ar=
gv[0], (size_t)argc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return buf[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}]])], [hardening_ok=3D&quot;yes&quot;], [hardening_ok=3D&quot;no&quot;; h=
ardening_$1=3D&quot;$old_hardening_flags&quot;])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    AC_MSG_RESULT([$hardening_ok])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CFLAGS=3D&quot;$old_cflags&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LDFLAGS=3D=
&quot;$old_ldflags&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ac_c_werror_flag=3D&quot;$old_werror_flag&quot;]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# MinGW is left alone: there -fstack-protector and _FORTIFY_SOURCE can</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# need libssp or a rece=
nt mingw-w64 runtime=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+if test &quot;${enable_hardening}&quot; =3D &quot;yes&quot; -a &quot;${=
WIN32}&quot; !=3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	hardening_cflags=3D&quot;&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	hardening_ldflags=3D&quot;&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	# Level 3 needs GCC 12 or =
clang 9 (glibc 2=2E33 and later warn</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	# otherwise), so fall back to 2=2E Older glibc treats 3 a=
s 2=2E Not added</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	# =
without optimization (glibc warns), when CPPFLAGS, CFLAGS or the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	# compiler already set anothe=
r level or -U_FORTIFY_SOURCE, or for ASan</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	# builds, where FORTIFY can hide an overflow from AS=
an (with clang, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	# fortified function aborts before ASan reports it)=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	for fortify_level in 3 2; do</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+		ACL_CHECK_ADD_HARDENING_FLA=
G([cflags], [-D_FORTIFY_SOURCE=3D$fortify_level], [</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if !defined(_FORTIFY_SOURCE) || _FORTIFY=
_SOURCE !=3D $fortify_level</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#error &quot;_FORTIFY_SOURCE is set elsewhere&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__SANITIZE_ADDRESS__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#error &quot;ASan build&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(__has_feat=
ure)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if __has_featu=
re(address_sanitizer)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#error &quot;ASan build&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+		test &quot;${hardening_ok}&=
quot; =3D &quot;yes&quot; &amp;&amp; break</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	done</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	ACL_CHECK_ADD_HARDENING_FLAG([cflags], [-fstack-protector-strong]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	ACL_CHECK_ADD_HAR=
DENING_FLAG([cflags], [-fstack-clash-protection])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	# GCC 14 and later combine repeated -fcf-pro=
tection options instead of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	# using the last one, so a value set by the user would not take</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	# precedence over ours=
=2E Leave the option to the user then, and treat</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	# -mbranch-protection the same way=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	case &quot;${CC} ${CPPFLAG=
S} ${CFLAGS}&quot; in</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+		*-fcf-protection*)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+			AC_MSG_CHECKING([whether to add -fcf-protection=3Dfull])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+			AC_MSG_RESULT([no, set by the=
 user])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+		*)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+			ACL_CHECK_ADD_HARDENING_FLAG([cflags],=
 [-fcf-protection=3Dfull])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+			;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	esac</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	case &quot;${CC} ${C=
PPFLAGS} ${CFLAGS}&quot; in</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+		*-mbranch-protection*)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+			AC_MSG_CHECKING([whether to add -mbranch-protection=3Dstand=
ard])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			AC_MSG_RESU=
LT([no, set by the user])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+			;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		*)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+			ACL_CHECK_ADD_HARDEN=
ING_FLAG([cflags], [-mbranch-protection=3Dstandard])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+			;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	esac</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	ACL_CHECK_ADD_HARDENING_FLAG([ldflags], [-Wl,-z,relro])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	ACL_CHECK_ADD_HARDENING_FLAG([l=
dflags], [-Wl,-z,now])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	ACL_CHECK_ADD_HARDENING_FLAG([ldflags], [-Wl,-z,noexecstack])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	CFLAGS=3D&quot;${hardening_c=
flags} ${CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	LDFLAGS=3D&quot;${hardening_ldflags} ${LDFLAGS}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> if test &quot;${enable_pedantic}&quo=
t; =3D &quot;yes&quot;; then</span><br><span> 	CFLAGS=3D&quot;${CFLAGS} -pe=
dantic&quot;</span><br><span> 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic =
mode])</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2213?usp=3Demail">change 2213</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I8fe2cbeadde3bad2185c4c=
ee824ed2fe307e29e2 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2213 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Aravind O R &lt;aravindor@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arav=
ind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--GCU8k9P/vAw=--


--===============7722294655550933516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7722294655550933516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7722294655550933516==--

