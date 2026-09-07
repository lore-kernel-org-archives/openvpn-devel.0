Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27976C79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2T1d6XT+JH7ajX2U7DWaijbiyAirVob+Dnmc6L2MOno=; b=TMVhoRQ5KGyIZORtNt8nMA+btg
	c+gx+4XPKSYooGUdHmHYVHuyqENvTq5CHH7meAsk1ZQcs4xLjoXmJelHpXS7k4q4Oac4V5dx5g43h
	EnGAF1+wQvISF834zyS2yR+jnjjoiE8679QFMzaf9+HkP4TUTRlQA20LSNDNZRLYBxrA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3aWj-0000ou-AW;
	Mon, 07 Sep 2026 14:40:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3aWd-0000ol-92
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KHOGMznh/Akz2EY9kJJ0nKUlIhZxFG0e/qsN78EGZ50=; b=Hu8aUYIvc+xXxIa7zmkrUp/oup
 /H/c398tIiDBkoPbEyRRDZCkL9OwL7Eo9MZDSbB/maDUl0c36fYiKOnCJmdqE4zfiTJm6tVBMySZN
 GGeN3jEn4/UQZquF8k3IKU5WKTt3i1yvNh5EQbagGKxNetFHzXRnn/eRGoYpl7ny7TMs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KHOGMznh/Akz2EY9kJJ0nKUlIhZxFG0e/qsN78EGZ50=; b=U
 ziiD7ijom2mbmFdlzVzodokuj+gWtRW+JzJEr+fSr4xflTeV+Zszc+KBlokTqbzCjqcbfAizktJVE
 dcdGBEiZAN9NpKSvzpNSLcBzDFDOs6911P6rEacLDT5Ghp+Z4ik9tkRQK+7vNakUYMvLp+Leml36b
 JE8LGhvOpqeJNyc4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3aWW-0007e6-Sv for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 14:40:44 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48441a2ba14so3196054f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 07:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788792034; x=1789396834; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KHOGMznh/Akz2EY9kJJ0nKUlIhZxFG0e/qsN78EGZ50=;
 b=L598HYOFmdL6P6Bvkt73nOvyr2C1bXd5H+ETOJUutCXQYMJMZaHwNSBhdPxQoWut2M
 IMWPGesmcHhnNuTfZFqJaNjst39ioMH3EXnW3H2+RoQAr3D3p7p01ws0a4xko/Np2Zq3
 oW1JLzbUtmOPNLkAiypmI252epCldQViRuzrhc4WWvMeSlPw6HtSjEhwNiDG90h9+j+C
 5yWnnHgWnsE6xW5FfvsGyYHRHZGsrDoX/K17CRPXaM+FCsanwicGWKQG/4zeialAXy3V
 Smh/kynbHFziCf04r0G0ILhb1moA/6FcuCyYWAaZCGc/mLiL+PNvTGpQ+BgG+u74QV0q
 CRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792034; x=1789396834;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KHOGMznh/Akz2EY9kJJ0nKUlIhZxFG0e/qsN78EGZ50=;
 b=U1FP0wZbdksK+yefsqiUJ1WPYi/thF+K4JUrVsXGDZmwNjvQ4XNrQmfzGZ+AsvvPRP
 rplyqUyPexy9pKiYNcZ1/AJjilOwwldH+Kh5ZVp9TatrcPwb8y39+isdngYh4tXJHcNp
 GOLlD5THMM4L+gWgfhyNKL7Tc8NMkg9sh2+5S+hoyZ2Hd4WYUSpAx/cOLIWmhoDGnBHZ
 ypkAMTwM6peJp0XUZ2LYjJ2gvI5sM9HS7jnlWQhGF4yV6Nis1Rl7TgpDQA3u2xTku0OI
 qDnqM8wE3erV1/uZTyBvE6s1kj/RcfKmad0OES8EQmEG+n4b/xp1e75xEbEETWYqbQEF
 OFQA==
X-Gm-Message-State: AFuF++mbvcQEw+7EJt8eNrUUtLL0PUbtGGnk92IpBrOqzsv2hOpAS7z1
 LzjW/UjtCDvTKf5Rp2XTYgbSuUebKLhChVY0M7jSIwqrZZRWCQyn5aMcbnrN7WtFoyo+6KOpnkj
 65aqQyDvQ3IYwnfDwgrGtIfP+tNZJXfWDpt1JUMI77Vx7ahXBFUoMYFjgxr1GpStCp2sr
X-Gm-Gg: AYBFou39VqqqoRoKLjH8SIFMpwoxkiKsd9mNTH6QuXJ46JPNu/Dl42E0lAaOuAss1cJ
 5YxHhuwIhJ55lc82494nEPcQCRwlPScRHiwDqbaMEJCESD9DnpJN+w7fxdWuT/rCtQ8xZ1YN41w
 4b84g69iitZ3IKUza6zaI6uM9Op54sfzoMACkLEUPosGF97sSfLNY50yD6o1nRuEzA1smQoCV57
 u+1L/11LIMW9Zj+sU5aHVsqHR8TOvQ3dSB4Vj/VjN7wPIaIYOmcdUF4V1SvdVIy4eEFAiKRS3z5
 K/MkvFW4Vjql3fwvZ09ThFEXKEOXV754j6MFDp2fNjsFdnWuTrut9zJSK1REfX5wJJaY0KKe3My
 fxXVBS2/zOOxZ+LKFc2Zi91g3dccm8QJlKHnfH7xoxZUw0bvr7aP64MbCTWmtQiC6gYWB39vKVO
 acxy5NHsN5wvv5MBrNoPTjmjA3VV+hfBLeNsBvDfHwvdaK2iN14QOswj+wn4JMOotiB3Bo3dxRI
 4QN0LMLU78MUfqpgJu3mb/qlDiUr6Z/EDQDE5ouWVDNYcacktwIWQwtdlzA6EiWBnIVpc4pIF7/
 HNKa5S0M/5Zp91cBMegcCPRpvLHxjgoC9BevloEID2GSICxEHRY=
X-Received: by 2002:a05:6000:40c7:b0:484:3310:f394 with SMTP id
 ffacd0b85a97d-485872d2de3mr22900832f8f.23.1788792033949; 
 Mon, 07 Sep 2026 07:40:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d312ca0sm29021595f8f.4.2026.09.07.07.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:40:33 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 14:40:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 67bc78c7f97e197fe98ce901e36edb13709376c2
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <893e7a6cae478c6ea6390320ed862ff142d04c95-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3aWW-0007e6-Sv
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "srkyn \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: david@srkyn.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "srkyn \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3844520984806724774=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3844520984806724774==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FUZiqkK80e0="; charset=UTF-8

--FUZiqkK80e0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, srkyn=2E

Hello plaisthos, raz=
vanc, 

I'd like you to reexamine a change=2E Please visit

    http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail

to look at the new patch s=
et (#5)=2E


Change subject: compat: close all unrelated fds in forked help=
ers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

compat:=
 close all unrelated fds in forked helpers

The forked auth-pam, down-root,=
 and port-share helpers only closed
descriptor numbers 3 through 100=2E Des=
criptors above that range could
remain open in long-lived helper processes,=
 including helpers that
intentionally retain privilege=2E

Add a shared com=
patibility helper that uses close_range() when available
and falls back to =
the process descriptor limit=2E Preserve the helper
command socket and add =
coverage for both low and high preserved
descriptors=2E

Change-Id: Iacd56d=
245e9ab30cfb25b2b364ca661fa289dc55
Signed-off-by: David Sarkisyan <david@sr=
kyn=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Ea=
c
M src/compat/Makefile=2Eam
A src/compat/compat-close-fds=2Ec
A src/compat=
/compat-close-fds=2Eh
M src/openvpn/ps=2Ec
M src/plugins/auth-pam/Makefile=
=2Eam
M src/plugins/auth-pam/auth-pam=2Ec
M src/plugins/down-root/Makefile=
=2Eam
M src/plugins/down-root/down-root=2Ec
M tests/unit_tests/openvpn/Make=
file=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
13 files changed, 297 in=
sertions(+), 74 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/81/1881/5

diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt
index 6eb5954=2E=2Ee9fd3f4 100644
--- a/CMakeLists=2Etxt
+++ b/CMak=
eLists=2Etxt
@@ -19,6 +19,7 @@
 include(CheckLinkerFlag OPTIONAL)
 include(=
CheckTypeSize)
 include(CheckStructHasMember)
+include(CMakePushCheckState)=

 include(CTest)
 
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OF=
F)
@@ -196,6 +197,10 @@
     check_symbol_exists(fork unistd=2Eh HAVE_FORK)=

     check_symbol_exists(execve unistd=2Eh HAVE_EXECVE)
     check_symbol_=
exists(ftruncate unistd=2Eh HAVE_FTRUNCATE)
+    cmake_push_check_state()
+=
    list(APPEND CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)
+    check_symbol=
_exists(close_range unistd=2Eh HAVE_CLOSE_RANGE)
+    cmake_pop_check_state=
()
     check_symbol_exists(nice unistd=2Eh HAVE_NICE)
     check_symbol_ex=
ists(setgid unistd=2Eh HAVE_SETGID)
     check_symbol_exists(setuid unistd=
=2Eh HAVE_SETUID)
@@ -424,6 +429,8 @@
     src/compat/compat-gettimeofday=
=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
=
+    src/compat/compat-close-fds=2Ec
+    src/compat/compat-close-fds=2Eh
 =
    src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=
=2Ec
@@ -854,6 +861,11 @@
         src/openvpn/siphash=2Ec
         src/ope=
nvpn/siphash_reference=2Ec
     )
+    if (NOT WIN32)
+        target_sourc=
es(test_misc PRIVATE
+            src/compat/compat-close-fds=2Ec
+        =
)
+    endif ()
 
     target_sources(test_ncp PRIVATE
         src/openvpn=
/crypto_epoch=2Ec
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=
=2Ein
index c3bb5a5=2E=2Ec507787 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b=
/config=2Eh=2Ecmake=2Ein
@@ -75,6 +75,9 @@
 /* Define to 1 if you have the =
`chsize' function=2E */
 #cmakedefine HAVE_CHSIZE
 
+/* Define to 1 if you =
have the `close_range' function=2E */
+#cmakedefine HAVE_CLOSE_RANGE
+
 /* =
struct cmsghdr needed for extended socket error support */
 #cmakedefine HA=
VE_CMSGHDR
 
diff --git a/configure=2Eac b/configure=2Eac
index 469a475=2E=
=2Ebaa185a 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -567,7 +567,=
7 @@
 	syslog openlog mlockall getrlimit getgrnam setgid \
 	setgroups floc=
k gettimeofday \
 	setsid chdir \
-	chsize ftruncate execve getpeereid base=
name dirname \
+	chsize ftruncate execve getpeereid basename dirname close_=
range \
 	epoll_create strsep strtok_r \
 ])
 
diff --git a/src/compat/Make=
file=2Eam b/src/compat/Makefile=2Eam
index 22867b3=2E=2Ed479915 100644
--- =
a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefile=2Eam
@@ -16,9 +16,10 @=
@
 
 libcompat_la_SOURCES =3D \
 	compat=2Eh \
+	compat-close-fds=2Ec compa=
t-close-fds=2Eh \
 	compat-dirname=2Ec \
 	compat-basename=2Ec \
 	compat-g=
ettimeofday=2Ec \
 	compat-daemon=2Ec \
 	compat-strsep=2Ec \
-	compat-strt=
ok_r=2Ec
\ No newline at end of file
+	compat-strtok_r=2Ec
diff --git a/src=
/compat/compat-close-fds=2Ec b/src/compat/compat-close-fds=2Ec
new file mod=
e 100644
index 0000000=2E=2Ef3a266c
--- /dev/null
+++ b/src/compat/compat-c=
lose-fds=2Ec
@@ -0,0 +1,74 @@
+/*
+ *  OpenVPN -- An application to securel=
y tunnel IP networks
+ *             over a single UDP port, with support f=
or SSL/TLS-based
+ *             session authentication and key exchange,
+=
 *             packet encryption, packet authentication, and
+ *           =
  packet compression=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *=
  This program is free software; you can redistribute it and/or modify
+ * =
 it under the terms of the GNU General Public License version 2
+ *  as pub=
lished by the Free Software Foundation=2E
+ *
+ *  This program is distribu=
ted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#i=
fndef _WIN32
+
+#include "compat-close-fds=2Eh"
+
+#include <limits=2Eh>
+#=
include <stdbool=2Eh>
+#include <unistd=2Eh>
+#include <syslog=2Eh>
+
+void=

+close_fds_except(int keep)
+{
+    closelog();
+
+#ifdef HAVE_CLOSE_RANGE=

+    bool closed =3D true;
+    unsigned int first =3D 3;
+    if (keep >=
=3D 3)
+    {
+        if (keep > 3)
+        {
+            closed =3D clo=
se_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;
+        }
+        first =
=3D (unsigned int)keep + 1;
+    }
+    closed =3D close_range(first, ~0U, =
0) =3D=3D 0 && closed;
+    if (closed)
+    {
+        return;
+    }
+#en=
dif
+
+    const long open_max =3D sysconf(_SC_OPEN_MAX);
+    int max_fd =
=3D 1024;
+    if (open_max > 0)
+    {
+        max_fd =3D open_max > INT_=
MAX ? INT_MAX : (int)open_max;
+    }
+    for (int fd =3D 3; fd < max_fd; =
++fd)
+    {
+        if (fd !=3D keep)
+        {
+            close(fd);
=
+        }
+    }
+}
+
+#endif /* !_WIN32 */
diff --git a/src/compat/compat=
-close-fds=2Eh b/src/compat/compat-close-fds=2Eh
new file mode 100644
index=
 0000000=2E=2E8480941
--- /dev/null
+++ b/src/compat/compat-close-fds=2Eh
@=
@ -0,0 +1,38 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks
+ *             over a single UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This program=
 is free software; you can redistribute it and/or modify
+ *  it under the =
terms of the GNU General Public License version 2
+ *  as published by the =
Free Software Foundation=2E
+ *
+ *  This program is distributed in the hop=
e that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */=

+
+#ifndef COMPAT_CLOSE_FDS_H
+#define COMPAT_CLOSE_FDS_H
+
+#ifndef _WIN3=
2
+/**
+ * Close descriptors inherited across fork that are unrelated to a =
helper=2E
+ *
+ * Standard input, standard output, standard error, and @p k=
eep remain open=2E
+ * All other file descriptors starting at 3 are closed=
=2E
+ *
+ * @param keep file descriptor used for communication with the par=
ent process
+ */
+void close_fds_except(int keep);
+#endif
+
+#endif /* COM=
PAT_CLOSE_FDS_H */
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
ind=
ex be91a99=2E=2E7f071bd 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/p=
s=2Ec
@@ -33,6 +33,7 @@
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
 #inc=
lude "ps=2Eh"
+#include "compat-close-fds=2Eh"
 
 #include "memdbg=2Eh"
 
@=
@ -96,30 +97,6 @@
 }
 
 /*
- * Close most of parent's fds=2E
- * Keep stdin=
/stdout/stderr, plus one
- * other fd which is presumed to be
- * our pipe =
back to parent=2E
- * Admittedly, a bit of a kludge,
- * but posix doesn't =
give us a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fo=
rk()=2E
- */
-static void
-close_fds_except(int keep)
-{
-    socket_descri=
ptor_t i;
-    closelog();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-    =
    if (i !=3D keep)
-        {
-            openvpn_close_socket(i);
-    =
    }
-    }
-}
-
-/*
  * Usually we ignore signals, because our parent wil=
l
  * deal with them=2E
  */
diff --git a/src/plugins/auth-pam/Makefile=2Ea=
m b/src/plugins/auth-pam/Makefile=2Eam
index e6dc27e=2E=2Efb7fd30 100644
--=
- a/src/plugins/auth-pam/Makefile=2Eam
+++ b/src/plugins/auth-pam/Makefile=
=2Eam
@@ -9,6 +9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(top_srcdir)/include \
+	-I$(=
top_srcdir)/src/compat \
 	$(PLUGIN_AUTH_PAM_CFLAGS) \
 	$(OPTIONAL_CRYPTO_=
CFLAGS)
 
@@ -23,6 +24,7 @@
 	pamdl=2Ec  pamdl=2Eh \
 	auth-pam=2Eexports
 =
openvpn_plugin_auth_pam_la_LIBADD =3D \
+	$(top_builddir)/src/compat/libcom=
pat=2Ela \
 	$(PLUGIN_AUTH_PAM_LIBS)
 openvpn_plugin_auth_pam_la_LDFLAGS =
=3D $(AM_LDFLAGS) \
 	-export-symbols "$(srcdir)/auth-pam=2Eexports" \
diff=
 --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=
=2Ec
index 948b6af=2E=2Ea3fd3aa 100644
--- a/src/plugins/auth-pam/auth-pam=
=2Ec
+++ b/src/plugins/auth-pam/auth-pam=2Ec
@@ -51,6 +51,8 @@
 #include <a=
rpa/inet=2Eh>
 #include <openvpn-plugin=2Eh>
 
+#include "compat-close-fds=
=2Eh"
+
 #define DEBUG(verb) ((verb) >=3D 4)
 
 /* Command codes for foregr=
ound -> background communication */
@@ -240,30 +242,6 @@
 #endif /* ifdef D=
O_DAEMONIZE */
 
 /*
- * Close most of parent's fds=2E
- * Keep stdin/stdou=
t/stderr, plus one
- * other fd which is presumed to be
- * our pipe back t=
o parent=2E
- * Admittedly, a bit of a kludge,
- * but posix doesn't give u=
s a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork()=
=2E
- */
-static void
-close_fds_except(int keep)
-{
-    int i;
-    close=
log();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if (i !=3D keep)=

-        {
-            close(i);
-        }
-    }
-}
-
-/*
  * Usually w=
e ignore signals, because our parent will
  * deal with them=2E
  */
diff -=
-git a/src/plugins/down-root/Makefile=2Eam b/src/plugins/down-root/Makefile=
=2Eam
index 7ca5a4e=2E=2E83bc04f 100644
--- a/src/plugins/down-root/Makefil=
e=2Eam
+++ b/src/plugins/down-root/Makefile=2Eam
@@ -9,6 +9,7 @@
 
 AM_CFLA=
GS =3D \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src/compat \
 	$(OPT=
IONAL_CRYPTO_CFLAGS)
 
 if ENABLE_PLUGIN_DOWN_ROOT
@@ -19,6 +20,8 @@
 openv=
pn_plugin_down_root_la_SOURCES =3D \
 	down-root=2Ec \
 	down-root=2Eexport=
s
+openvpn_plugin_down_root_la_LIBADD =3D \
+	$(top_builddir)/src/compat/li=
bcompat=2Ela
 openvpn_plugin_down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \
 	-ex=
port-symbols "$(srcdir)/down-root=2Eexports" \
 	-module -shared -avoid-ver=
sion -no-undefined
diff --git a/src/plugins/down-root/down-root=2Ec b/src/p=
lugins/down-root/down-root=2Ec
index cd57189=2E=2E3f71cdd 100644
--- a/src/=
plugins/down-root/down-root=2Ec
+++ b/src/plugins/down-root/down-root=2Ec
@=
@ -44,6 +44,8 @@
 
 #include <openvpn-plugin=2Eh>
 
+#include "compat-close=
-fds=2Eh"
+
 #define DEBUG(verb) ((verb) >=3D 7)
 
 /* Command codes for fo=
reground -> background communication */
@@ -191,30 +193,6 @@
 }
 
 /*
- * C=
lose most of parent's fds=2E
- * Keep stdin/stdout/stderr, plus one
- * oth=
er fd which is presumed to be
- * our pipe back to parent=2E
- * Admittedly=
, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC=
 which will stop
- * fds from crossing a fork()=2E
- */
-static void
-close=
_fds_except(int keep)
-{
-    int i;
-    closelog();
-    for (i =3D 3; i =
<=3D 100; ++i)
-    {
-        if (i !=3D keep)
-        {
-            clo=
se(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals, because ou=
r parent will
  * deal with them=2E
  */
diff --git a/tests/unit_tests/open=
vpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=
=2E1b04b1f 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -388,6 +388,10 @@
 	$(top_srcdir)/src/o=
penvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
+i=
f !WIN32
+misc_testdriver_SOURCES +=3D $(top_srcdir)/src/compat/compat-clos=
e-fds=2Ec
+endif
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/s=
rc/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_te=
sts/openvpn \
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/u=
nit_tests/openvpn/test_misc=2Ec
index a41c27b=2E=2E69d1330 100644
--- a/tes=
ts/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_mis=
c=2Ec
@@ -42,6 +42,14 @@
 #include "crypto=2Eh"
 #ifdef _WIN32
 #include "w=
in32-util=2Eh"
+#else
+#include "compat-close-fds=2Eh"
+
+#include <errno=
=2Eh>
+#include <fcntl=2Eh>
+#include <sys/socket=2Eh>
+#include <sys/wait=
=2Eh>
+#include <unistd=2Eh>
 #endif
 #include "test_schedule=2Eh"
 
@@ -47=
5,9 +483,154 @@
 }
 #endif /* _WIN32 */
 
+#ifndef _WIN32
+static bool
+fd_=
is_closed(int fd)
+{
+    errno =3D 0;
+    return fcntl(fd, F_GETFD) =3D=
=3D -1 && errno =3D=3D EBADF;
+}
+
+static bool
+fd_is_open(int fd)
+{
+   =
 return fcntl(fd, F_GETFD) !=3D -1;
+}
+
+static int
+run_close_fds_case(in=
t keep_target)
+{
+    int control[2];
+    if (socketpair(AF_UNIX, SOCK_ST=
REAM, 0, control) < 0)
+    {
+        return EXIT_FAILURE;
+    }
+
+    c=
onst pid_t pid =3D fork();
+    if (pid < 0)
+    {
+        close(control[=
0]);
+        close(control[1]);
+        return EXIT_FAILURE;
+    }
+
+  =
  if (pid =3D=3D 0)
+    {
+        close(control[0]);
+
+        int keep =
=3D control[1];
+        const long open_max =3D sysconf(_SC_OPEN_MAX);
+  =
      if (open_max > 3 && keep_target >=3D open_max)
+        {
+          =
  keep_target =3D (int)open_max - 1;
+        }
+        if (keep_target >=
=3D 3 && keep_target !=3D keep)
+        {
+            if (dup2(keep, keep=
_target) < 0)
+            {
+                _exit(EXIT_FAILURE);
+       =
     }
+            close(keep);
+            keep =3D keep_target;
+      =
  }
+
+        const int source =3D open("/dev/null", O_RDWR);
+        if =
(source < 0)
+        {
+            _exit(EXIT_FAILURE);
+        }
+     =
   for (int fd =3D STDIN_FILENO; fd <=3D STDERR_FILENO; ++fd)
+        {
+ =
           if (dup2(source, fd) < 0)
+            {
+                _exit(=
EXIT_FAILURE);
+            }
+        }
+        const int close_fd_1 =3D =
dup(source);
+        const int close_fd_2 =3D dup(source);
+        if (cl=
ose_fd_1 < 0 || close_fd_2 < 0)
+        {
+            _exit(EXIT_FAILURE)=
;
+        }
+
+        const int close_target =3D 101;
+        int close_=
fd_high =3D -1;
+        if (open_max > close_target && keep !=3D close_tar=
get)
+        {
+            close_fd_high =3D dup2(source, close_target);
=
+            if (close_fd_high < 0)
+            {
+                _exit(E=
XIT_FAILURE);
+            }
+        }
+        if (source > STDERR_FILENO=
 && source !=3D keep)
+        {
+            close(source);
+        }
+
+=
        close_fds_except(keep);
+
+        const char result =3D fd_is_open=
(STDIN_FILENO) && fd_is_open(STDOUT_FILENO)
+                              =
      && fd_is_open(STDERR_FILENO)
+                                    && =
fd_is_closed(close_fd_1)
+                                    && fd_is_clos=
ed(close_fd_2)
+                                    && (close_fd_high < 0 |=
| fd_is_closed(close_fd_high))
+                                ? '1'
+    =
                            : '0';
+        if (write(keep, &result, sizeof=
(result)) !=3D sizeof(result))
+        {
+            _exit(EXIT_FAILURE);=

+        }
+        close(keep);
+        _exit(result =3D=3D '1' ? EXIT_S=
UCCESS : EXIT_FAILURE);
+    }
+
+    close(control[1]);
+    char result =
=3D '0';
+    const ssize_t size =3D read(control[0], &result, sizeof(resul=
t));
+    close(control[0]);
+
+    int status =3D 0;
+    if (waitpid(pid,=
 &status, 0) !=3D pid)
+    {
+        return EXIT_FAILURE;
+    }
+
+    r=
eturn size =3D=3D sizeof(result) && result =3D=3D '1' && WIFEXITED(status)
=
+                   && WEXITSTATUS(status) =3D=3D EXIT_SUCCESS
+           =
    ? EXIT_SUCCESS
+               : EXIT_FAILURE;
+}
+
+static void
+test_=
close_fds_default_keep(void **state)
+{
+    (void)state;
+    assert_int_e=
qual(run_close_fds_case(-1), EXIT_SUCCESS);
+}
+
+static void
+test_close_f=
ds_keep_three(void **state)
+{
+    (void)state;
+    assert_int_equal(run_=
close_fds_case(3), EXIT_SUCCESS);
+}
+
+static void
+test_close_fds_keep_mi=
ddle(void **state)
+{
+    (void)state;
+    assert_int_equal(run_close_fds=
_case(150), EXIT_SUCCESS);
+}
+#endif /* !_WIN32 */
+
 const struct CMUnitT=
est misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_unit_test(test_win_path_i=
n_dir),
+#else
+    cmocka_unit_test(test_close_fds_default_keep),
+    cmo=
cka_unit_test(test_close_fds_keep_three),
+    cmocka_unit_test(test_close_=
fds_keep_middle),
 #endif
     cmocka_unit_test(test_compat_lzo_string),
  =
   cmocka_unit_test(test_auth_fail_temp_no_flags),

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55=

Gerrit-Change-Number: 1881
Gerrit-PatchSet: 5
Gerrit-Owner: srkyn <david@s=
rkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2E=
muc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: srkyn=
 <david@srkyn=2Ecom>

--FUZiqkK80e0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, srkyn=2E </p>
<p>srkyn <strong>uploaded patch =
set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">compa=
t: close all unrelated fds in forked helpers<br><br>The forked auth-pam, do=
wn-root, and port-share helpers only closed<br>descriptor numbers 3 through=
 100=2E Descriptors above that range could<br>remain open in long-lived hel=
per processes, including helpers that<br>intentionally retain privilege=2E<=
br><br>Add a shared compatibility helper that uses close_range() when avail=
able<br>and falls back to the process descriptor limit=2E Preserve the help=
er<br>command socket and add coverage for both low and high preserved<br>de=
scriptors=2E<br><br>Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55<br=
>Signed-off-by: David Sarkisyan &lt;david@srkyn=2Ecom&gt;<br>---<br>M CMake=
Lists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/compa=
t/Makefile=2Eam<br>A src/compat/compat-close-fds=2Ec<br>A src/compat/compat=
-close-fds=2Eh<br>M src/openvpn/ps=2Ec<br>M src/plugins/auth-pam/Makefile=
=2Eam<br>M src/plugins/auth-pam/auth-pam=2Ec<br>M src/plugins/down-root/Mak=
efile=2Eam<br>M src/plugins/down-root/down-root=2Ec<br>M tests/unit_tests/o=
penvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>13 file=
s changed, 297 insertions(+), 74 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1881/5</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>inde=
x 6eb5954=2E=2Ee9fd3f4 100644</span><br><span>--- a/CMakeLists=2Etxt</span>=
<br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -19,6 +19,7 @@</span><b=
r><span> include(CheckLinkerFlag OPTIONAL)</span><br><span> include(CheckTy=
peSize)</span><br><span> include(CheckStructHasMember)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+include(CMakePushCheckState)</span><br><=
span> include(CTest)</span><br><span> </span><br><span> option(UNSUPPORTED_=
BUILDS &quot;Allow unsupported builds&quot; OFF)</span><br><span>@@ -196,6 =
+197,10 @@</span><br><span>     check_symbol_exists(fork unistd=2Eh HAVE_FO=
RK)</span><br><span>     check_symbol_exists(execve unistd=2Eh HAVE_EXECVE)=
</span><br><span>     check_symbol_exists(ftruncate unistd=2Eh HAVE_FTRUNCA=
TE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmake_push_c=
heck_state()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    lis=
t(APPEND CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    check_symbol_exists(close_range unistd=
=2Eh HAVE_CLOSE_RANGE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    cmake_pop_check_state()</span><br><span>     check_symbol_exists(nic=
e unistd=2Eh HAVE_NICE)</span><br><span>     check_symbol_exists(setgid uni=
std=2Eh HAVE_SETGID)</span><br><span>     check_symbol_exists(setuid unistd=
=2Eh HAVE_SETUID)</span><br><span>@@ -424,6 +429,8 @@</span><br><span>     =
src/compat/compat-gettimeofday=2Ec</span><br><span>     src/compat/compat-s=
trsep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/compat/compat-close-fds=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/compat/=
compat-close-fds=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><s=
pan>     src/openvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</=
span><br><span>@@ -854,6 +861,11 @@</span><br><span>         src/openvpn/si=
phash=2Ec</span><br><span>         src/openvpn/siphash_reference=2Ec</span>=
<br><span>     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (NOT WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    target_sources(test_misc PRIVATE</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            src/compat/compat-close-fds=2Ec</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span> </span><br><sp=
an>     target_sources(test_ncp PRIVATE</span><br><span>         src/openvp=
n/crypto_epoch=2Ec</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/c=
onfig=2Eh=2Ecmake=2Ein</span><br><span>index c3bb5a5=2E=2Ec507787 100644</s=
pan><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2E=
h=2Ecmake=2Ein</span><br><span>@@ -75,6 +75,9 @@</span><br><span> /* Define=
 to 1 if you have the `chsize&#39; function=2E */</span><br><span> #cmakede=
fine HAVE_CHSIZE</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Define to 1 if you have the `close_range&#39; function=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAV=
E_CLOSE_RANGE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /* struct cmsghdr needed for extended socket error support */</=
span><br><span> #cmakedefine HAVE_CMSGHDR</span><br><span> </span><br><span=
>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 469a475=
=2E=2Ebaa185a 100644</span><br><span>--- a/configure=2Eac</span><br><span>+=
++ b/configure=2Eac</span><br><span>@@ -567,7 +567,7 @@</span><br><span> 	s=
yslog openlog mlockall getrlimit getgrnam setgid \</span><br><span> 	setgro=
ups flock gettimeofday \</span><br><span> 	setsid chdir \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	chsize ftruncate execve getpeereid bas=
ename dirname \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	chs=
ize ftruncate execve getpeereid basename dirname close_range \</span><br><s=
pan> 	epoll_create strsep strtok_r \</span><br><span> ])</span><br><span> <=
/span><br><span>diff --git a/src/compat/Makefile=2Eam b/src/compat/Makefile=
=2Eam</span><br><span>index 22867b3=2E=2Ed479915 100644</span><br><span>---=
 a/src/compat/Makefile=2Eam</span><br><span>+++ b/src/compat/Makefile=2Eam<=
/span><br><span>@@ -16,9 +16,10 @@</span><br><span> </span><br><span> libco=
mpat_la_SOURCES =3D \</span><br><span> 	compat=2Eh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	compat-close-fds=2Ec compat-close-fds=2E=
h \</span><br><span> 	compat-dirname=2Ec \</span><br><span> 	compat-basenam=
e=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</span><br><span> 	compa=
t-daemon=2Ec \</span><br><span> 	compat-strsep=2Ec \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	compat-strtok_r=2Ec</span><br><span>\ No n=
ewline at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	compat-strtok_r=2Ec</span><br><span>diff --git a/src/compat/compat-close=
-fds=2Ec b/src/compat/compat-close-fds=2Ec</span><br><span>new file mode 10=
0644</span><br><span>index 0000000=2E=2Ef3a266c</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/src/compat/compat-close-fds=2Ec</span><br><span>@@=
 -0,0 +1,74 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An appl=
ication to securely tunnel IP networks</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             over a single UDP port, with support for =
SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         session authentication and key exchange,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet encryption, packet auth=
entication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           packet compression=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2026 David Sarkisyan</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more deta=
ils=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;compat-close-fds=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;limits=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;syslog=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+close_fds_except(int keep)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    closelog();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CLOSE_=
RANGE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool close=
d =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsi=
gned int first =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (keep &gt;=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (keep &gt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
losed =3D close_range(3, (unsigned int)keep - 1, 0) =3D=3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        first =3D (unsigned int)keep + 1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    closed =3D close_range(first,=
 ~0U, 0) =3D=3D 0 &amp;&amp; closed;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (closed)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const long open_max =3D sysconf(_SC_OPEN_MAX);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_fd =3D 1=
024;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (open_ma=
x &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        max_fd =3D open_=
max &gt; INT_MAX ? INT_MAX : (int)open_max;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int fd =3D 3; fd &lt; max_fd; ++fd)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (fd !=3D keep)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            close(fd);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* !_WIN32 */</span><br><span>diff=
 --git a/src/compat/compat-close-fds=2Eh b/src/compat/compat-close-fds=2Eh<=
/span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E848=
0941</span><br><span>--- /dev/null</span><br><span>+++ b/src/compat/compat-=
close-fds=2Eh</span><br><span>@@ -0,0 +1,38 @@</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a si=
ngle UDP port, with support for SSL/TLS-based</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             session authentication and key exc=
hange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet encryption, packet authentication, and</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 David Sarkisyan</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is free software; you can re=
distribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  it under the terms of the GNU General Public License version 2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by =
the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  T=
his program is distributed in the hope that it will be useful,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  =
See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gene=
ral Public License for more details=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  You should have received a copy of the GNU General Public License alo=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pro=
gram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef COMPAT_CLOSE_FDS_H</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define COMPAT_CLOSE_FDS_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Close descripto=
rs inherited across fork that are unrelated to a helper=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Standard input, standard output, standard error, a=
nd @p keep remain open=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * All other file descriptors starting at 3 are closed=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param keep file descriptor used for communic=
ation with the parent process</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void c=
lose_fds_except(int keep);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* COMPAT_CLOSE_FD=
S_H */</span><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec=
</span><br><span>index be91a99=2E=2E7f071bd 100644</span><br><span>--- a/sr=
c/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@=
@ -33,6 +33,7 @@</span><br><span> #include &quot;fdmisc=2Eh&quot;</span><br=
><span> #include &quot;crypto=2Eh&quot;</span><br><span> #include &quot;ps=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;compat-close-fds=2Eh&quot;</span><br><span> </span><br><span> #includ=
e &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -96,30 +97,6 =
@@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Close most of parent&#39;s fds=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Keep stdin/stdout/s=
tderr, plus one</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * oth=
er fd which is presumed to be</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * our pipe back to parent=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Admittedly, a bit of a kludge,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * but posix doesn&#39;t give us a kind</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * of FD_CLOEXEC which will s=
top</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * fds from crossi=
ng a fork()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-close_fds_except(int keep)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    socket_descriptor_t i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    closelog();</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (i !=3D keep)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            openvpn_close_socket(i);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Usually we ign=
ore signals, because our parent will</span><br><span>  * deal with them=2E<=
/span><br><span>  */</span><br><span>diff --git a/src/plugins/auth-pam/Make=
file=2Eam b/src/plugins/auth-pam/Makefile=2Eam</span><br><span>index e6dc27=
e=2E=2Efb7fd30 100644</span><br><span>--- a/src/plugins/auth-pam/Makefile=
=2Eam</span><br><span>+++ b/src/plugins/auth-pam/Makefile=2Eam</span><br><s=
pan>@@ -9,6 +9,7 @@</span><br><span> </span><br><span> AM_CFLAGS =3D \</spa=
n><br><span> 	-I$(top_srcdir)/include \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat \</span><br><span> 	$(PLUGI=
N_AUTH_PAM_CFLAGS) \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</span><br>=
<span> </span><br><span>@@ -23,6 +24,7 @@</span><br><span> 	pamdl=2Ec  pamd=
l=2Eh \</span><br><span> 	auth-pam=2Eexports</span><br><span> openvpn_plugi=
n_auth_pam_la_LIBADD =3D \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	$(top_builddir)/src/compat/libcompat=2Ela \</span><br><span> 	$(PLU=
GIN_AUTH_PAM_LIBS)</span><br><span> openvpn_plugin_auth_pam_la_LDFLAGS =3D =
$(AM_LDFLAGS) \</span><br><span> 	-export-symbols &quot;$(srcdir)/auth-pam=
=2Eexports&quot; \</span><br><span>diff --git a/src/plugins/auth-pam/auth-p=
am=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>index 948b6af=2E=
=2Ea3fd3aa 100644</span><br><span>--- a/src/plugins/auth-pam/auth-pam=2Ec</=
span><br><span>+++ b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>@@ -=
51,6 +51,8 @@</span><br><span> #include &lt;arpa/inet=2Eh&gt;</span><br><sp=
an> #include &lt;openvpn-plugin=2Eh&gt;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;compat-close-fds=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #define DEBUG(verb) ((verb) &gt;=3D 4)</span><br><span> </span><br><span=
> /* Command codes for foreground -&gt; background communication */</span><=
br><span>@@ -240,30 +242,6 @@</span><br><span> #endif /* ifdef DO_DAEMONIZE=
 */</span><br><span> </span><br><span> /*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Close most of parent&#39;s fds=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Keep stdin/stdout/stderr, plus one</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * other fd which is pre=
sumed to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * our pip=
e back to parent=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Admittedly, a bit of a kludge,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * but posix doesn&#39;t give us a kind</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * of FD_CLOEXEC which will stop</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * fds from crossing a fork()=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-close_fds_except(int keep)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
closelog();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i=
 =3D 3; i &lt;=3D 100; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (i !=3D keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            close(i=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br>=
<span>  * Usually we ignore signals, because our parent will</span><br><spa=
n>  * deal with them=2E</span><br><span>  */</span><br><span>diff --git a/s=
rc/plugins/down-root/Makefile=2Eam b/src/plugins/down-root/Makefile=2Eam</s=
pan><br><span>index 7ca5a4e=2E=2E83bc04f 100644</span><br><span>--- a/src/p=
lugins/down-root/Makefile=2Eam</span><br><span>+++ b/src/plugins/down-root/=
Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@</span><br><span> </span><br><=
span> AM_CFLAGS =3D \</span><br><span> 	-I$(top_srcdir)/include \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat \=
</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</span><br><span> </span><br><s=
pan> if ENABLE_PLUGIN_DOWN_ROOT</span><br><span>@@ -19,6 +20,8 @@</span><br=
><span> openvpn_plugin_down_root_la_SOURCES =3D \</span><br><span> 	down-ro=
ot=2Ec \</span><br><span> 	down-root=2Eexports</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+openvpn_plugin_down_root_la_LIBADD =3D \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_builddir)/src/compat=
/libcompat=2Ela</span><br><span> openvpn_plugin_down_root_la_LDFLAGS =3D $(=
AM_LDFLAGS) \</span><br><span> 	-export-symbols &quot;$(srcdir)/down-root=
=2Eexports&quot; \</span><br><span> 	-module -shared -avoid-version -no-und=
efined</span><br><span>diff --git a/src/plugins/down-root/down-root=2Ec b/s=
rc/plugins/down-root/down-root=2Ec</span><br><span>index cd57189=2E=2E3f71c=
dd 100644</span><br><span>--- a/src/plugins/down-root/down-root=2Ec</span><=
br><span>+++ b/src/plugins/down-root/down-root=2Ec</span><br><span>@@ -44,6=
 +44,8 @@</span><br><span> </span><br><span> #include &lt;openvpn-plugin=2E=
h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;compat-close-fds=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #define DEBUG(verb) ((verb) &gt=
;=3D 7)</span><br><span> </span><br><span> /* Command codes for foreground =
-&gt; background communication */</span><br><span>@@ -191,30 +193,6 @@</spa=
n><br><span> }</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Close most of parent&#39;s fds=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Keep stdin/stdout/stderr,=
 plus one</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * other fd =
which is presumed to be</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * our pipe back to parent=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Admittedly, a bit of a kludge,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * but posix doesn&#39;t give us a kind</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * of FD_CLOEXEC which will stop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * fds from crossing a f=
ork()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-close_fds_except(int keep)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    closelog();</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (i !=3D keep)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     close(i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span>  * Usually we ignore signals, because our parent will</s=
pan><br><span>  * deal with them=2E</span><br><span>  */</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvp=
n/Makefile=2Eam</span><br><span>index 5954902=2E=2E1b04b1f 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/t=
ests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -388,6 +388,10 @@<=
/span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if !WIN32</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+misc_testdriver_SOURCES +=3D $(top_src=
dir)/src/compat/compat-close-fds=2Ec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/=
src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><spa=
n> 	-I$(top_srcdir)/tests/unit_tests/openvpn \</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_mis=
c=2Ec</span><br><span>index a41c27b=2E=2E69d1330 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_misc=2Ec</span><br><span>@@ -42,6 +42,14 @@</span><br><s=
pan> #include &quot;crypto=2Eh&quot;</span><br><span> #ifdef _WIN32</span><=
br><span> #include &quot;win32-util=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;compat-close-fds=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;errno=2Eh&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;fcntl=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;sys/socket=2Eh&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/wait=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&=
gt;</span><br><span> #endif</span><br><span> #include &quot;test_schedule=
=2Eh&quot;</span><br><span> </span><br><span>@@ -475,9 +483,154 @@</span><b=
r><span> }</span><br><span> #endif /* _WIN32 */</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+fd_is_closed(int fd)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    errno =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return fcntl(fd, F_GETFD) =3D=3D -1 &amp;&amp; errno =3D=
=3D EBADF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fd_is_open(int fd)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return fcntl(fd, F_GETFD) !=3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+run_close_fds_case(int ke=
ep_target)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int control[2];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (socketpair(AF_UNIX,=
 SOCK_STREAM, 0, control) &lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return EXIT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const pid_t pid =3D =
fork();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pid =
&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        close(control[0]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(contr=
ol[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn EXIT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (pid =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        close(control[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        int keep =3D control[1];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const long open_max =3D sysconf(_SC_OPE=
N_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
open_max &gt; 3 &amp;&amp; keep_target &gt;=3D open_max)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            keep_target =3D (int)open_max - 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (keep_target &gt;=3D=
 3 &amp;&amp; keep_target !=3D keep)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (dup2(keep, keep_target) &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                _exit(EXIT_FAILURE);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            close(keep);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            keep =3D keep_targ=
et;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const int source =3D open(&quot;/dev/=
null&quot;, O_RDWR);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (source &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          _exit(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        for (int fd =3D STDIN_FILENO; fd &lt;=3D STDERR_FILENO; ++fd)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (dup2(source, fd) &=
lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                _ex=
it(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int =
close_fd_1 =3D dup(source);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        const int close_fd_2 =3D dup(source);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (close_fd_1 &lt; 0 || close_fd=
_2 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            _exit(E=
XIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const int close_target =3D =
101;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int clo=
se_fd_high =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (open_max &gt; close_target &amp;&amp; keep !=3D close_target)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            close_fd_high =3D du=
p2(source, close_target);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (close_fd_high &lt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                _exit(EXIT_FAILURE);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (source &gt; STDERR_FILENO &amp;&amp; source =
!=3D keep)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            close(s=
ource);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        close_fds_except(keep);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const char result =3D fd_is_open(STDIN_F=
ILENO) &amp;&amp; fd_is_open(STDOUT_FILENO)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                    &amp;&amp; fd_i=
s_open(STDERR_FILENO)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                    &amp;&amp; fd_is_closed(close_fd_1)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
               &amp;&amp; fd_is_closed(close_fd_2)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                    &amp;&am=
p; (close_fd_high &lt; 0 || fd_is_closed(close_fd_high))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                ? &#39=
;1&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                    : &#39;0&#39;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (write(keep, &amp;result, sizeof(result)) !=3D si=
zeof(result))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            _exi=
t(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close=
(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _exi=
t(result =3D=3D &#39;1&#39; ? EXIT_SUCCESS : EXIT_FAILURE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    close(control[1]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char result =3D &#39;0&#39;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const ssize_t size =3D read(control[0], &amp;res=
ult, sizeof(result));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    close(control[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (wait=
pid(pid, &amp;status, 0) !=3D pid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return EXIT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return size =3D=3D =
sizeof(result) &amp;&amp; result =3D=3D &#39;1&#39; &amp;&amp; WIFEXITED(st=
atus)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     &amp;&amp; WEXITSTATUS(status) =3D=3D EXIT_SUCCESS</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+               ? EXIT_SUCCESS</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+               : EXIT_FAILURE=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_close_fds_default_keep(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    (void)state;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(run_close_fds_case(-1), EXIT_SUCCESS);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_close_fds_keep_three(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    (void)state;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(run_close_fds_case(3), EXIT_SUCCESS);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_close_fds_keep_middle(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    (void)state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(run_close_fds_case(150), EXIT_SUCCESS);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif /* !_WIN32 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnitTest misc_tes=
ts[] =3D {</span><br><span> #ifdef _WIN32</span><br><span>     cmocka_unit_=
test(test_win_path_in_dir),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cm=
ocka_unit_test(test_close_fds_default_keep),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_close_fds_keep_three),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(=
test_close_fds_keep_middle),</span><br><span> #endif</span><br><span>     c=
mocka_unit_test(test_compat_lzo_string),</span><br><span>     cmocka_unit_t=
est(test_auth_fail_temp_no_flags),</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3D=
email">change 1881</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1881 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner=
: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;=
openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: srkyn &lt;david@srkyn=2Ecom&gt; </d=
iv>

</body></html>
--FUZiqkK80e0=--


--===============3844520984806724774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3844520984806724774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3844520984806724774==--

