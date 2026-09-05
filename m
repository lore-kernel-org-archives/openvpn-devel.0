Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE09C624DB
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIOYBdZsT4bnvY7EedjYaEDsecFgI6xM0UZF7Gu2hLM=; b=S6LBHLGedNppCs/CEDEKKwO9lw
	87Ui/wqowLbD1O564kXHIu2nmFiSfs1qgXhohLdmbvRITaoymUyFt4PRP6KmaGbMzmN3DRVwcV0yr
	ZNRMSv823j3UyLs4k2SBwWSuccNICLhnstzt6KMXoQyTU/aHHLZRbVa/nVR1nvslmTQU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2ux1-00076h-Qc;
	Sat, 05 Sep 2026 18:17:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2uwv-000768-Tf
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 18:17:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X5udurARsphg4VlXWJuNy8r+1TmzMlgsF7fhI19Ildk=; b=QEB8SWQ9IH73Ua3zdEmL3ee0vo
 iuIbxr0J2YOWwIWsR8hlF/2MvYgwTl4gQ9MLLj4V+Ttko6A/Z4mMOZ42s+rUk2lgsPS8FHLaoalxn
 PbeDMlAkzreFx02X94ne46DGGJiPhrLHl9TqWa7r7StDMmX/SeJvsfb8onlJEzvrSdVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X5udurARsphg4VlXWJuNy8r+1TmzMlgsF7fhI19Ildk=; b=M
 6Mn6jtQE+qoU4czR/S3k1N/BWtUWDFhGdveV0mOWkUzecHkQt5iEc6+cfy3n4dmBxLrpH6Mojg7hl
 ZCpPVm88ad/3oFqHkZgrOBoTD3PdgYEkBlCJbIsZEupn+bcy2U5StU7Pvazd0TZjdRkbiO7cb27a8
 89nLmdp1RovhfTs4=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2uwq-0005sJ-GJ for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 18:17:10 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso20012605e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788632218; x=1789237018; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X5udurARsphg4VlXWJuNy8r+1TmzMlgsF7fhI19Ildk=;
 b=eopQXsuszNLk93ScjDOTft70qLB1iHwsIFHIdIH2j+I/vrZGOeeSSXQGBPyCXXNn20
 TVh7qZyIyO9nVTNSwXpU+NlS2RKO6Ann3IjDyjpNSO0U4pwTX1L/v9vNuA1F2lA3IHuS
 fEJmD2bsl24/I/3cyooMlVgzpOTEfdyOB6zEOLK0UAwGIBbPNQapEhf0Y24IkMld9hmU
 G9mHeHALZHw2rly5gKGCnAMYG0egLSmIopEzIFtRRnN8uSyPXE2midI4zlfhgh7Vxw7A
 EEokzA6tQ8JilrYaASmcCu5b+8Z4Wy5lSCDT5D1kGXoZYF0E1s2JQsEqUsbn4OqMich/
 OVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788632218; x=1789237018;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X5udurARsphg4VlXWJuNy8r+1TmzMlgsF7fhI19Ildk=;
 b=sshIxwH5X1wmSrO6RMdsiHl4IJbrvr/tSIYPSNM/AYsliesgbqsNg9oORX2qEZPNKZ
 y+YgFnZzG4/VER5AFFUG90kXTOIi3t2P7zuMriCCM0DHs+PCbbu7IKrH3/BaB5CCcsuO
 fAmEVT+L6mbbmP8W6Fm6zARLlDAWFJIo88DKBS0pD354xXn61vr0F/KC28iCY/yLAXQp
 2kBqCiGNCr/ap2L3G7mYt2ZxTkVZArDgg0pECJJT+2xdhD4X2EkLCI2o/NnorvMV1nun
 iVdGl/SaEnTRgn1j3OLkM8nrtEXlZ0Bn9jap9561GhazFiaXip3Lies+Pip5zADj+94N
 bjuw==
X-Gm-Message-State: AFuF++mRkXbcoEwIMVXQsToElvA6axzWT18FHdd8oaOfvTp23IFzc4WB
 i/90X8kUaw4FmOltq7qqzJZQItIhoKvwDqQe8pKmyt2ygS49lEu+n/KChbCNpEBQeCXGiYIQab+
 47eGJ6r+04aIOYZAKNQcTnmx7Hh6oJP4wqB6hwCD1Ib9FdCHeialCc/ezuwAgtLgaHLMb
X-Gm-Gg: AYBFou3m1DhXLGx0TDuXvwj8t3H/M3V1A5w6SFlkTidCHuiSTj/8HzqlITxxhxovpcX
 9rYrJhxy+JGaDpd3HZvOpUNcybE5hT9FJBltFqOVR1xy8iSyCAYCE1eMOxOPDuyZVg6DFEAcurn
 q25+y/p3Tvw/+S+4S6x0ncv1htLurRS3K4dw9Kz1v1fKhVvISewEEK7A2AMtN9bcXB+z7P2SYqc
 i7skmA2N/cdYfktEpyL3Hv9lw0Q8Y8rGaT6w3egzvQ/jPdXO9d0pg6dQQz9Ej20n9twSplhn9gj
 ShITd3adAY1VsHstlFnDSGgfpCEPjFijWMYjKzII6dhbfwjnJpTo5zrgJp7bqpfxC1LJggs3n8d
 xtetfyEM/bDk9gs1UHbQQH59r2fTQBa5pR1tQyhfSECaRStsAVbaVEEkdoGvyiN/dr7r5A7J+WU
 /A5PuKTZqem7d3JbCtlOpbKGszKgHotSBlehVoY4efIw4djWhnbNw1aU/TwbJJeQGkbLQH2g4cH
 +z27tM46UAttMhQe1g0FJQ+uNBKt38KeZk3spaW0zmUayOxmsQ4/h1/uYJBsWnsjHTGDtfftQJQ
 mTrGwfT/XZ5vPTpUtlluy9tF9UQPYE40UshZ4MJj8HbmnzVnoCU=
X-Received: by 2002:a05:600c:6091:b0:49c:eb17:cf3b with SMTP id
 5b1f17b1804b1-49cf8252497mr130314585e9.8.1788632217210; 
 Sat, 05 Sep 2026 11:16:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm200829135e9.10.2026.09.05.11.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:16:56 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 5 Sep 2026 18:16:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: 89a1011cb5d3a17d56b5fdad59531d8be8e20835
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2ae78bff6e809012da4bb798f5456ce43e4c6ea-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2uwq-0005sJ-GJ
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
Content-Type: multipart/mixed; boundary="===============2385533458990775250=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2385533458990775250==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6s17LVY9cDQ="; charset=UTF-8

--6s17LVY9cDQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: srkyn=2E

Hello plaisthos, razvanc, 
=

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1881?usp=3Demail

to look at the new patch set (#4)=
=2E


Change subject: compat: close all unrelated fds in forked helpers
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

compat: close al=
l unrelated fds in forked helpers

The forked auth-pam, down-root, and port=
-share helpers only closed
descriptor numbers 3 through 100=2E Descriptors =
above that range could
remain open in long-lived helper processes, includin=
g helpers that
intentionally retain privilege=2E

Add a shared compatibilit=
y helper that uses close_range() when available
and falls back to the proce=
ss descriptor limit=2E Preserve the helper
command socket and add coverage =
for both low and high preserved
descriptors=2E

Change-Id: Iacd56d245e9ab30=
cfb25b2b364ca661fa289dc55
Signed-off-by: David Sarkisyan <david@srkyn=2Ecom=
>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M src/c=
ompat/Makefile=2Eam
A src/compat/compat-close-fds=2Ec
A src/compat/compat-c=
lose-fds=2Eh
M src/openvpn/ps=2Ec
M src/plugins/auth-pam/Makefile=2Eam
M sr=
c/plugins/auth-pam/auth-pam=2Ec
M src/plugins/down-root/Makefile=2Eam
M src=
/plugins/down-root/down-root=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
M=
 tests/unit_tests/openvpn/test_misc=2Ec
13 files changed, 285 insertions(+)=
, 74 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/81/1881/4

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
ind=
ex 6eb5954=2E=2Ee9fd3f4 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etx=
t
@@ -19,6 +19,7 @@
 include(CheckLinkerFlag OPTIONAL)
 include(CheckTypeSi=
ze)
 include(CheckStructHasMember)
+include(CMakePushCheckState)
 include(C=
Test)
 
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
@@ -196,=
6 +197,10 @@
     check_symbol_exists(fork unistd=2Eh HAVE_FORK)
     check=
_symbol_exists(execve unistd=2Eh HAVE_EXECVE)
     check_symbol_exists(ftru=
ncate unistd=2Eh HAVE_FTRUNCATE)
+    cmake_push_check_state()
+    list(AP=
PEND CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)
+    check_symbol_exists(clo=
se_range unistd=2Eh HAVE_CLOSE_RANGE)
+    cmake_pop_check_state()
     che=
ck_symbol_exists(nice unistd=2Eh HAVE_NICE)
     check_symbol_exists(setgid=
 unistd=2Eh HAVE_SETGID)
     check_symbol_exists(setuid unistd=2Eh HAVE_SE=
TUID)
@@ -424,6 +429,8 @@
     src/compat/compat-gettimeofday=2Ec
     src/=
compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/compa=
t/compat-close-fds=2Ec
+    src/compat/compat-close-fds=2Eh
     src/openvp=
n/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -854,6 =
+861,11 @@
         src/openvpn/siphash=2Ec
         src/openvpn/siphash_re=
ference=2Ec
     )
+    if (NOT WIN32)
+        target_sources(test_misc PR=
IVATE
+            src/compat/compat-close-fds=2Ec
+        )
+    endif ()=

 
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=
=2Ec
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c=
3bb5a5=2E=2Ec507787 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=
=2Ecmake=2Ein
@@ -75,6 +75,9 @@
 /* Define to 1 if you have the `chsize' fu=
nction=2E */
 #cmakedefine HAVE_CHSIZE
 
+/* Define to 1 if you have the `c=
lose_range' function=2E */
+#cmakedefine HAVE_CLOSE_RANGE
+
 /* struct cmsg=
hdr needed for extended socket error support */
 #cmakedefine HAVE_CMSGHDR
=
 
diff --git a/configure=2Eac b/configure=2Eac
index 469a475=2E=2Ebaa185a 1=
00644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -567,7 +567,7 @@
 	syslo=
g openlog mlockall getrlimit getgrnam setgid \
 	setgroups flock gettimeofd=
ay \
 	setsid chdir \
-	chsize ftruncate execve getpeereid basename dirname=
 \
+	chsize ftruncate execve getpeereid basename dirname close_range \
 	ep=
oll_create strsep strtok_r \
 ])
 
diff --git a/src/compat/Makefile=2Eam b/=
src/compat/Makefile=2Eam
index 22867b3=2E=2Ed479915 100644
--- a/src/compat=
/Makefile=2Eam
+++ b/src/compat/Makefile=2Eam
@@ -16,9 +16,10 @@
 
 libcomp=
at_la_SOURCES =3D \
 	compat=2Eh \
+	compat-close-fds=2Ec compat-close-fds=
=2Eh \
 	compat-dirname=2Ec \
 	compat-basename=2Ec \
 	compat-gettimeofday=
=2Ec \
 	compat-daemon=2Ec \
 	compat-strsep=2Ec \
-	compat-strtok_r=2Ec
\ =
No newline at end of file
+	compat-strtok_r=2Ec
diff --git a/src/compat/com=
pat-close-fds=2Ec b/src/compat/compat-close-fds=2Ec
new file mode 100644
in=
dex 0000000=2E=2Ef3a266c
--- /dev/null
+++ b/src/compat/compat-close-fds=2E=
c
@@ -0,0 +1,74 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP=
 networks
+ *             over a single UDP port, with support for SSL/TLS-=
based
+ *             session authentication and key exchange,
+ *         =
    packet encryption, packet authentication, and
+ *             packet co=
mpression=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This prog=
ram is free software; you can redistribute it and/or modify
+ *  it under t=
he terms of the GNU General Public License version 2
+ *  as published by t=
he Free Software Foundation=2E
+ *
+ *  This program is distributed in the =
hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *=
  You should have received a copy of the GNU General Public License along
+=
 *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+=
 */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef _WIN3=
2
+
+#include "compat-close-fds=2Eh"
+
+#include <limits=2Eh>
+#include <st=
dbool=2Eh>
+#include <unistd=2Eh>
+#include <syslog=2Eh>
+
+void
+close_fds=
_except(int keep)
+{
+    closelog();
+
+#ifdef HAVE_CLOSE_RANGE
+    bool =
closed =3D true;
+    unsigned int first =3D 3;
+    if (keep >=3D 3)
+    =
{
+        if (keep > 3)
+        {
+            closed =3D close_range(3, =
(unsigned int)keep - 1, 0) =3D=3D 0;
+        }
+        first =3D (unsigne=
d int)keep + 1;
+    }
+    closed =3D close_range(first, ~0U, 0) =3D=3D 0 =
&& closed;
+    if (closed)
+    {
+        return;
+    }
+#endif
+
+    c=
onst long open_max =3D sysconf(_SC_OPEN_MAX);
+    int max_fd =3D 1024;
+  =
  if (open_max > 0)
+    {
+        max_fd =3D open_max > INT_MAX ? INT_MAX=
 : (int)open_max;
+    }
+    for (int fd =3D 3; fd < max_fd; ++fd)
+    {
=
+        if (fd !=3D keep)
+        {
+            close(fd);
+        }
+ =
   }
+}
+
+#endif /* !_WIN32 */
diff --git a/src/compat/compat-close-fds=2E=
h b/src/compat/compat-close-fds=2Eh
new file mode 100644
index 0000000=2E=
=2E8480941
--- /dev/null
+++ b/src/compat/compat-close-fds=2Eh
@@ -0,0 +1,3=
8 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ * =
            over a single UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This program is free so=
ftware; you can redistribute it and/or modify
+ *  it under the terms of th=
e GNU General Public License version 2
+ *  as published by the Free Softwa=
re Foundation=2E
+ *
+ *  This program is distributed in the hope that it w=
ill be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e
+ *  GNU General Public License for more details=2E
+ *
+ *  You should h=
ave received a copy of the GNU General Public License along
+ *  with this =
program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef=
 COMPAT_CLOSE_FDS_H
+#define COMPAT_CLOSE_FDS_H
+
+#ifndef _WIN32
+/**
+ * =
Close descriptors inherited across fork that are unrelated to a helper=2E
+=
 *
+ * Standard input, standard output, standard error, and @p keep remain =
open=2E
+ * All other file descriptors starting at 3 are closed=2E
+ *
+ * =
@param keep file descriptor used for communication with the parent process
=
+ */
+void close_fds_except(int keep);
+#endif
+
+#endif /* COMPAT_CLOSE_FD=
S_H */
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be91a99=
=2E=2E7f071bd 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -=
33,6 +33,7 @@
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
 #include "ps=
=2Eh"
+#include "compat-close-fds=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -96,30=
 +97,6 @@
 }
 
 /*
- * Close most of parent's fds=2E
- * Keep stdin/stdout/=
stderr, plus one
- * other fd which is presumed to be
- * our pipe back to =
parent=2E
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us =
a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork()=2E
=
- */
-static void
-close_fds_except(int keep)
-{
-    socket_descriptor_t i=
;
-    closelog();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if (=
i !=3D keep)
-        {
-            openvpn_close_socket(i);
-        }
- =
   }
-}
-
-/*
  * Usually we ignore signals, because our parent will
  * de=
al with them=2E
  */
diff --git a/src/plugins/auth-pam/Makefile=2Eam b/src/=
plugins/auth-pam/Makefile=2Eam
index e6dc27e=2E=2Efb7fd30 100644
--- a/src/=
plugins/auth-pam/Makefile=2Eam
+++ b/src/plugins/auth-pam/Makefile=2Eam
@@ =
-9,6 +9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdi=
r)/src/compat \
 	$(PLUGIN_AUTH_PAM_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 =

@@ -23,6 +24,7 @@
 	pamdl=2Ec  pamdl=2Eh \
 	auth-pam=2Eexports
 openvpn_p=
lugin_auth_pam_la_LIBADD =3D \
+	$(top_builddir)/src/compat/libcompat=2Ela =
\
 	$(PLUGIN_AUTH_PAM_LIBS)
 openvpn_plugin_auth_pam_la_LDFLAGS =3D $(AM_LD=
FLAGS) \
 	-export-symbols "$(srcdir)/auth-pam=2Eexports" \
diff --git a/sr=
c/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 9=
48b6af=2E=2Ea3fd3aa 100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/sr=
c/plugins/auth-pam/auth-pam=2Ec
@@ -51,6 +51,8 @@
 #include <arpa/inet=2Eh>=

 #include <openvpn-plugin=2Eh>
 
+#include "compat-close-fds=2Eh"
+
 #defi=
ne DEBUG(verb) ((verb) >=3D 4)
 
 /* Command codes for foreground -> backgr=
ound communication */
@@ -240,30 +242,6 @@
 #endif /* ifdef DO_DAEMONIZE */=

 
 /*
- * Close most of parent's fds=2E
- * Keep stdin/stdout/stderr, plus=
 one
- * other fd which is presumed to be
- * our pipe back to parent=2E
- =
* Admittedly, a bit of a kludge,
- * but posix doesn't give us a kind
- * o=
f FD_CLOEXEC which will stop
- * fds from crossing a fork()=2E
- */
-static=
 void
-close_fds_except(int keep)
-{
-    int i;
-    closelog();
-    for =
(i =3D 3; i <=3D 100; ++i)
-    {
-        if (i !=3D keep)
-        {
-   =
         close(i);
-        }
-    }
-}
-
-/*
  * Usually we ignore signals=
, because our parent will
  * deal with them=2E
  */
diff --git a/src/plugi=
ns/down-root/Makefile=2Eam b/src/plugins/down-root/Makefile=2Eam
index 7ca5=
a4e=2E=2E83bc04f 100644
--- a/src/plugins/down-root/Makefile=2Eam
+++ b/src=
/plugins/down-root/Makefile=2Eam
@@ -9,6 +9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(t=
op_srcdir)/include \
+	-I$(top_srcdir)/src/compat \
 	$(OPTIONAL_CRYPTO_CFL=
AGS)
 
 if ENABLE_PLUGIN_DOWN_ROOT
@@ -19,6 +20,8 @@
 openvpn_plugin_down_r=
oot_la_SOURCES =3D \
 	down-root=2Ec \
 	down-root=2Eexports
+openvpn_plugi=
n_down_root_la_LIBADD =3D \
+	$(top_builddir)/src/compat/libcompat=2Ela
 op=
envpn_plugin_down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \
 	-export-symbols "$(=
srcdir)/down-root=2Eexports" \
 	-module -shared -avoid-version -no-undefin=
ed
diff --git a/src/plugins/down-root/down-root=2Ec b/src/plugins/down-root=
/down-root=2Ec
index cd57189=2E=2E3f71cdd 100644
--- a/src/plugins/down-roo=
t/down-root=2Ec
+++ b/src/plugins/down-root/down-root=2Ec
@@ -44,6 +44,8 @@=

 
 #include <openvpn-plugin=2Eh>
 
+#include "compat-close-fds=2Eh"
+
 #de=
fine DEBUG(verb) ((verb) >=3D 7)
 
 /* Command codes for foreground -> back=
ground communication */
@@ -191,30 +193,6 @@
 }
 
 /*
- * Close most of par=
ent's fds=2E
- * Keep stdin/stdout/stderr, plus one
- * other fd which is p=
resumed to be
- * our pipe back to parent=2E
- * Admittedly, a bit of a klu=
dge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC which will stop=

- * fds from crossing a fork()=2E
- */
-static void
-close_fds_except(int =
keep)
-{
-    int i;
-    closelog();
-    for (i =3D 3; i <=3D 100; ++i)
-=
    {
-        if (i !=3D keep)
-        {
-            close(i);
-        =
}
-    }
-}
-
-/*
  * Usually we ignore signals, because our parent will
  =
* deal with them=2E
  */
diff --git a/tests/unit_tests/openvpn/Makefile=2Ea=
m b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=2E1b04b1f 10064=
4
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openv=
pn/Makefile=2Eam
@@ -388,6 +388,10 @@
 	$(top_srcdir)/src/openvpn/siphash=
=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
+if !WIN32
+misc=
_testdriver_SOURCES +=3D $(top_srcdir)/src/compat/compat-close-fds=2Ec
+end=
if
+
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 =
	-I$(top_srcdir)/src/compat \
 	-I$(top_srcdir)/tests/unit_tests/openvpn \
=
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/open=
vpn/test_misc=2Ec
index a41c27b=2E=2E6b4000b 100644
--- a/tests/unit_tests/=
openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -42,6=
 +42,14 @@
 #include "crypto=2Eh"
 #ifdef _WIN32
 #include "win32-util=2Eh"=

+#else
+#include "compat-close-fds=2Eh"
+
+#include <errno=2Eh>
+#include =
<fcntl=2Eh>
+#include <sys/socket=2Eh>
+#include <sys/wait=2Eh>
+#include <=
unistd=2Eh>
 #endif
 #include "test_schedule=2Eh"
 
@@ -475,9 +483,142 @@
 =
}
 #endif /* _WIN32 */
 
+#ifndef _WIN32
+static bool
+fd_is_closed(int fd)=

+{
+    errno =3D 0;
+    return fcntl(fd, F_GETFD) =3D=3D -1 && errno =3D=
=3D EBADF;
+}
+
+static bool
+fd_is_open(int fd)
+{
+    return fcntl(fd, F=
_GETFD) !=3D -1;
+}
+
+static int
+run_close_fds_case(int keep_target)
+{
+=
    int control[2];
+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, control) <=
 0)
+    {
+        return EXIT_FAILURE;
+    }
+
+    const pid_t pid =3D =
fork();
+    if (pid < 0)
+    {
+        close(control[0]);
+        close=
(control[1]);
+        return EXIT_FAILURE;
+    }
+
+    if (pid =3D=3D 0)=

+    {
+        close(control[0]);
+
+        int keep =3D control[1];
+  =
      const long open_max =3D sysconf(_SC_OPEN_MAX);
+        if (open_max =
> 3 && keep_target >=3D open_max)
+        {
+            keep_target =3D (=
int)open_max - 1;
+        }
+        if (keep_target >=3D 3 && keep_target=
 !=3D keep)
+        {
+            if (dup2(keep, keep_target) < 0)
+     =
       {
+                _exit(EXIT_FAILURE);
+            }
+            =
close(keep);
+            keep =3D keep_target;
+        }
+
+        const=
 int source =3D open("/dev/null", O_RDWR);
+        if (source < 0)
+      =
  {
+            _exit(EXIT_FAILURE);
+        }
+        for (int fd =3D S=
TDIN_FILENO; fd <=3D STDERR_FILENO; ++fd)
+        {
+            if (dup2(=
source, fd) < 0)
+            {
+                _exit(EXIT_FAILURE);
+    =
        }
+        }
+        const int close_fd_1 =3D dup(source);
+      =
  const int close_fd_2 =3D dup(source);
+        if (close_fd_1 < 0 || clos=
e_fd_2 < 0)
+        {
+            _exit(EXIT_FAILURE);
+        }
+      =
  if (source > STDERR_FILENO && source !=3D keep)
+        {
+            c=
lose(source);
+        }
+
+        close_fds_except(keep);
+
+        cons=
t char result =3D fd_is_open(STDIN_FILENO) && fd_is_open(STDOUT_FILENO)
+  =
                                  && fd_is_open(STDERR_FILENO)
+           =
                         && fd_is_closed(close_fd_1)
+                     =
               && fd_is_closed(close_fd_2)
+                               =
 ? '1'
+                                : '0';
+        if (write(keep, &re=
sult, sizeof(result)) !=3D sizeof(result))
+        {
+            _exit(EX=
IT_FAILURE);
+        }
+        close(keep);
+        _exit(result =3D=3D =
'1' ? EXIT_SUCCESS : EXIT_FAILURE);
+    }
+
+    close(control[1]);
+    c=
har result =3D '0';
+    const ssize_t size =3D read(control[0], &result, s=
izeof(result));
+    close(control[0]);
+
+    int status =3D 0;
+    if (w=
aitpid(pid, &status, 0) !=3D pid)
+    {
+        return EXIT_FAILURE;
+   =
 }
+
+    return size =3D=3D sizeof(result) && result =3D=3D '1' && WIFEXIT=
ED(status)
+                   && WEXITSTATUS(status) =3D=3D EXIT_SUCCESS
+=
               ? EXIT_SUCCESS
+               : EXIT_FAILURE;
+}
+
+static =
void
+test_close_fds_default_keep(void **state)
+{
+    (void)state;
+    a=
ssert_int_equal(run_close_fds_case(-1), EXIT_SUCCESS);
+}
+
+static void
+t=
est_close_fds_keep_three(void **state)
+{
+    (void)state;
+    assert_int=
_equal(run_close_fds_case(3), EXIT_SUCCESS);
+}
+
+static void
+test_close_=
fds_keep_middle(void **state)
+{
+    (void)state;
+    assert_int_equal(ru=
n_close_fds_case(150), EXIT_SUCCESS);
+}
+#endif /* !_WIN32 */
+
 const str=
uct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_unit_test(test=
_win_path_in_dir),
+#else
+    cmocka_unit_test(test_close_fds_default_keep=
),
+    cmocka_unit_test(test_close_fds_keep_three),
+    cmocka_unit_test(=
test_close_fds_keep_middle),
 #endif
     cmocka_unit_test(test_compat_lzo_=
string),
     cmocka_unit_test(test_auth_fail_temp_no_flags),

-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca6=
61fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 4
Gerrit-Owner: srk=
yn <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <gert=
@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: srkyn <david@srkyn=2Ecom>

--6s17LVY9cDQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: srkyn=2E </p>
<p>srkyn <strong>uploaded patch set #4<=
/strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1881?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">compat: close=
 all unrelated fds in forked helpers<br><br>The forked auth-pam, down-root,=
 and port-share helpers only closed<br>descriptor numbers 3 through 100=2E =
Descriptors above that range could<br>remain open in long-lived helper proc=
esses, including helpers that<br>intentionally retain privilege=2E<br><br>A=
dd a shared compatibility helper that uses close_range() when available<br>=
and falls back to the process descriptor limit=2E Preserve the helper<br>co=
mmand socket and add coverage for both low and high preserved<br>descriptor=
s=2E<br><br>Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55<br>Signed-=
off-by: David Sarkisyan &lt;david@srkyn=2Ecom&gt;<br>---<br>M CMakeLists=2E=
txt<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/compat/Makefi=
le=2Eam<br>A src/compat/compat-close-fds=2Ec<br>A src/compat/compat-close-f=
ds=2Eh<br>M src/openvpn/ps=2Ec<br>M src/plugins/auth-pam/Makefile=2Eam<br>M=
 src/plugins/auth-pam/auth-pam=2Ec<br>M src/plugins/down-root/Makefile=2Eam=
<br>M src/plugins/down-root/down-root=2Ec<br>M tests/unit_tests/openvpn/Mak=
efile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>13 files changed,=
 285 insertions(+), 74 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1881/4</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=
=2E=2Ee9fd3f4 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -19,6 +19,7 @@</span><br><span> =
include(CheckLinkerFlag OPTIONAL)</span><br><span> include(CheckTypeSize)</=
span><br><span> include(CheckStructHasMember)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+include(CMakePushCheckState)</span><br><span> inc=
lude(CTest)</span><br><span> </span><br><span> option(UNSUPPORTED_BUILDS &q=
uot;Allow unsupported builds&quot; OFF)</span><br><span>@@ -196,6 +197,10 @=
@</span><br><span>     check_symbol_exists(fork unistd=2Eh HAVE_FORK)</span=
><br><span>     check_symbol_exists(execve unistd=2Eh HAVE_EXECVE)</span><b=
r><span>     check_symbol_exists(ftruncate unistd=2Eh HAVE_FTRUNCATE)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmake_push_check_stat=
e()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    list(APPEND =
CMAKE_REQUIRED_DEFINITIONS -D_GNU_SOURCE)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    check_symbol_exists(close_range unistd=2Eh HAVE_C=
LOSE_RANGE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmak=
e_pop_check_state()</span><br><span>     check_symbol_exists(nice unistd=2E=
h HAVE_NICE)</span><br><span>     check_symbol_exists(setgid unistd=2Eh HAV=
E_SETGID)</span><br><span>     check_symbol_exists(setuid unistd=2Eh HAVE_S=
ETUID)</span><br><span>@@ -424,6 +429,8 @@</span><br><span>     src/compat/=
compat-gettimeofday=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</=
span><br><span>     src/compat/compat-strtok_r=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/compat/compat-close-fds=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/compat/compat-close-=
fds=2Eh</span><br><span>     src/openvpn/argv=2Ec</span><br><span>     src/=
openvpn/argv=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><spa=
n>@@ -854,6 +861,11 @@</span><br><span>         src/openvpn/siphash=2Ec</sp=
an><br><span>         src/openvpn/siphash_reference=2Ec</span><br><span>   =
  )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (NOT WIN3=
2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        target_so=
urces(test_misc PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            src/compat/compat-close-fds=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    endif ()</span><br><span> </span><br><span>     targe=
t_sources(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoc=
h=2Ec</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ec=
make=2Ein</span><br><span>index c3bb5a5=2E=2Ec507787 100644</span><br><span=
>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ei=
n</span><br><span>@@ -75,6 +75,9 @@</span><br><span> /* Define to 1 if you =
have the `chsize&#39; function=2E */</span><br><span> #cmakedefine HAVE_CHS=
IZE</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Define to 1 if you have the `close_range&#39; function=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CLOSE_RANGE=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
* struct cmsghdr needed for extended socket error support */</span><br><spa=
n> #cmakedefine HAVE_CMSGHDR</span><br><span> </span><br><span>diff --git a=
/configure=2Eac b/configure=2Eac</span><br><span>index 469a475=2E=2Ebaa185a=
 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configur=
e=2Eac</span><br><span>@@ -567,7 +567,7 @@</span><br><span> 	syslog openlog=
 mlockall getrlimit getgrnam setgid \</span><br><span> 	setgroups flock get=
timeofday \</span><br><span> 	setsid chdir \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	chsize ftruncate execve getpeereid basename dirname=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	chsize ftruncate=
 execve getpeereid basename dirname close_range \</span><br><span> 	epoll_c=
reate strsep strtok_r \</span><br><span> ])</span><br><span> </span><br><sp=
an>diff --git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam</span><=
br><span>index 22867b3=2E=2Ed479915 100644</span><br><span>--- a/src/compat=
/Makefile=2Eam</span><br><span>+++ b/src/compat/Makefile=2Eam</span><br><sp=
an>@@ -16,9 +16,10 @@</span><br><span> </span><br><span> libcompat_la_SOURC=
ES =3D \</span><br><span> 	compat=2Eh \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	compat-close-fds=2Ec compat-close-fds=2Eh \</span><br>=
<span> 	compat-dirname=2Ec \</span><br><span> 	compat-basename=2Ec \</span>=
<br><span> 	compat-gettimeofday=2Ec \</span><br><span> 	compat-daemon=2Ec \=
</span><br><span> 	compat-strsep=2Ec \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	compat-strtok_r=2Ec</span><br><span>\ No newline at end o=
f file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	compat-strto=
k_r=2Ec</span><br><span>diff --git a/src/compat/compat-close-fds=2Ec b/src/=
compat/compat-close-fds=2Ec</span><br><span>new file mode 100644</span><br>=
<span>index 0000000=2E=2Ef3a266c</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/src/compat/compat-close-fds=2Ec</span><br><span>@@ -0,0 +1,74 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secu=
rely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             over a single UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
026 David Sarkisyan</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is free software; you can redistribute it and/or modify</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gener=
al Public License version 2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  as published by the Free Software Foundation=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it =
will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  GNU General Public License for more details=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/l=
icenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;compat-close-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;limits=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;syslog=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+close=
_fds_except(int keep)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    closelog();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CLOSE_RANGE</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool closed =3D true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int first =3D 3;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (keep &gt;=
=3D 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (keep &gt; 3)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            closed =3D close_ran=
ge(3, (unsigned int)keep - 1, 0) =3D=3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        first =3D (unsigned int)keep + 1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    closed =3D close_range(first, ~0U, 0) =3D=3D 0 &am=
p;&amp; closed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (closed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const long open_max =3D sysconf(_SC_OPEN_MAX);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int max_fd =3D 1024;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (open_max &gt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        max_fd =3D open_max &gt; INT_MAX ? IN=
T_MAX : (int)open_max;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t fd =3D 3; fd &lt; max_fd; ++fd)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (fd !=3D keep)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        close(fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif /* !_WIN32 */</span><br><span>diff --git a/src/compat=
/compat-close-fds=2Eh b/src/compat/compat-close-fds=2Eh</span><br><span>new=
 file mode 100644</span><br><span>index 0000000=2E=2E8480941</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/src/compat/compat-close-fds=2Eh</span=
><br><span>@@ -0,0 +1,38 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2026 David Sarkisyan</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  This program is free software; you can redistribute it and=
/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it un=
der the terms of the GNU General Public License version 2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software=
 Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is di=
stributed in the hope that it will be useful,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licens=
e for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see=
 &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef C=
OMPAT_CLOSE_FDS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine COMPAT_CLOSE_FDS_H</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Close descriptors inherited acro=
ss fork that are unrelated to a helper=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Standard input, standard output, standard error, and @p keep remain=
 open=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * All othe=
r file descriptors starting at 3 are closed=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param keep file descriptor used for communication with the pa=
rent process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void close_fds_except(i=
nt keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* COMPAT_CLOSE_FDS_H */</span><br=
><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span=
>index be91a99=2E=2E7f071bd 100644</span><br><span>--- a/src/openvpn/ps=2Ec=
</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -33,6 +33,7 @@=
</span><br><span> #include &quot;fdmisc=2Eh&quot;</span><br><span> #include=
 &quot;crypto=2Eh&quot;</span><br><span> #include &quot;ps=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;compat-clos=
e-fds=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2E=
h&quot;</span><br><span> </span><br><span>@@ -96,30 +97,6 @@</span><br><spa=
n> }</span><br><span> </span><br><span> /*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Close most of parent&#39;s fds=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Keep stdin/stdout/stderr, plus one</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * other fd which is pr=
esumed to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * our pi=
pe back to parent=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Admittedly, a bit of a kludge,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * but posix doesn&#39;t give us a kind</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * of FD_CLOEXEC which will stop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * fds from crossing a fork()=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-close_fds_except(int keep)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    socket_descriptor_t i;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    closelog();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (i =3D 3; i &lt;=3D 100; ++i)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (i !=3D keep)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          openvpn_close_socket(i);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/*</span><br><span>  * Usually we ignore signals, becaus=
e our parent will</span><br><span>  * deal with them=2E</span><br><span>  *=
/</span><br><span>diff --git a/src/plugins/auth-pam/Makefile=2Eam b/src/plu=
gins/auth-pam/Makefile=2Eam</span><br><span>index e6dc27e=2E=2Efb7fd30 1006=
44</span><br><span>--- a/src/plugins/auth-pam/Makefile=2Eam</span><br><span=
>+++ b/src/plugins/auth-pam/Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@</=
span><br><span> </span><br><span> AM_CFLAGS =3D \</span><br><span> 	-I$(top=
_srcdir)/include \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
-I$(top_srcdir)/src/compat \</span><br><span> 	$(PLUGIN_AUTH_PAM_CFLAGS) \<=
/span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</span><br><span> </span><br><sp=
an>@@ -23,6 +24,7 @@</span><br><span> 	pamdl=2Ec  pamdl=2Eh \</span><br><sp=
an> 	auth-pam=2Eexports</span><br><span> openvpn_plugin_auth_pam_la_LIBADD =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_builddi=
r)/src/compat/libcompat=2Ela \</span><br><span> 	$(PLUGIN_AUTH_PAM_LIBS)</s=
pan><br><span> openvpn_plugin_auth_pam_la_LDFLAGS =3D $(AM_LDFLAGS) \</span=
><br><span> 	-export-symbols &quot;$(srcdir)/auth-pam=2Eexports&quot; \</sp=
an><br><span>diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/a=
uth-pam/auth-pam=2Ec</span><br><span>index 948b6af=2E=2Ea3fd3aa 100644</spa=
n><br><span>--- a/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/s=
rc/plugins/auth-pam/auth-pam=2Ec</span><br><span>@@ -51,6 +51,8 @@</span><b=
r><span> #include &lt;arpa/inet=2Eh&gt;</span><br><span> #include &lt;openv=
pn-plugin=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;compat-close-fds=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define DEBUG(verb)=
 ((verb) &gt;=3D 4)</span><br><span> </span><br><span> /* Command codes for=
 foreground -&gt; background communication */</span><br><span>@@ -240,30 +2=
42,6 @@</span><br><span> #endif /* ifdef DO_DAEMONIZE */</span><br><span> <=
/span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Close most of parent&#39;s fds=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Keep stdin/stdout/stderr, plus one</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * other fd which is presumed to be</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * our pipe back to parent=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit of =
a kludge,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * but posix=
 doesn&#39;t give us a kind</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * of FD_CLOEXEC which will stop</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * fds from crossing a fork()=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
close_fds_except(int keep)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    closelog();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100;=
 ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D keep)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            close(i);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Usually we i=
gnore signals, because our parent will</span><br><span>  * deal with them=
=2E</span><br><span>  */</span><br><span>diff --git a/src/plugins/down-root=
/Makefile=2Eam b/src/plugins/down-root/Makefile=2Eam</span><br><span>index =
7ca5a4e=2E=2E83bc04f 100644</span><br><span>--- a/src/plugins/down-root/Mak=
efile=2Eam</span><br><span>+++ b/src/plugins/down-root/Makefile=2Eam</span>=
<br><span>@@ -9,6 +9,7 @@</span><br><span> </span><br><span> AM_CFLAGS =3D =
\</span><br><span> 	-I$(top_srcdir)/include \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat \</span><br><span> 	$=
(OPTIONAL_CRYPTO_CFLAGS)</span><br><span> </span><br><span> if ENABLE_PLUGI=
N_DOWN_ROOT</span><br><span>@@ -19,6 +20,8 @@</span><br><span> openvpn_plug=
in_down_root_la_SOURCES =3D \</span><br><span> 	down-root=2Ec \</span><br><=
span> 	down-root=2Eexports</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+openvpn_plugin_down_root_la_LIBADD =3D \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_builddir)/src/compat/libcompat=2Ela</spa=
n><br><span> openvpn_plugin_down_root_la_LDFLAGS =3D $(AM_LDFLAGS) \</span>=
<br><span> 	-export-symbols &quot;$(srcdir)/down-root=2Eexports&quot; \</sp=
an><br><span> 	-module -shared -avoid-version -no-undefined</span><br><span=
>diff --git a/src/plugins/down-root/down-root=2Ec b/src/plugins/down-root/d=
own-root=2Ec</span><br><span>index cd57189=2E=2E3f71cdd 100644</span><br><s=
pan>--- a/src/plugins/down-root/down-root=2Ec</span><br><span>+++ b/src/plu=
gins/down-root/down-root=2Ec</span><br><span>@@ -44,6 +44,8 @@</span><br><s=
pan> </span><br><span> #include &lt;openvpn-plugin=2Eh&gt;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;com=
pat-close-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #define DEBUG(verb) ((verb) &gt;=3D 7)</span><br><spa=
n> </span><br><span> /* Command codes for foreground -&gt; background commu=
nication */</span><br><span>@@ -191,30 +193,6 @@</span><br><span> }</span><=
br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Close most of parent&#39;s fds=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Keep stdin/stdout/stderr, plus one</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * other fd which is presumed to be=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * our pipe back to p=
arent=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Admittedly=
, a bit of a kludge,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* but posix doesn&#39;t give us a kind</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * of FD_CLOEXEC which will stop</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * fds from crossing a fork()=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-close_fds_except(int keep)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    closelog();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 3; i &=
lt;=3D 100; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D ke=
ep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            close(i);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * U=
sually we ignore signals, because our parent will</span><br><span>  * deal =
with them=2E</span><br><span>  */</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><=
br><span>index 5954902=2E=2E1b04b1f 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn=
/Makefile=2Eam</span><br><span>@@ -388,6 +388,10 @@</span><br><span> 	$(top=
_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/siphash_reference=2Ec</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+if !WIN32</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+misc_testdriver_SOURCES +=3D $(top_srcdir)/src/compat/compat-=
close-fds=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> pu=
sh_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br=
><span> 	-I$(top_srcdir)/src/compat \</span><br><span> 	-I$(top_srcdir)/tes=
ts/unit_tests/openvpn \</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>i=
ndex a41c27b=2E=2E6b4000b 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>@@ -42,6 +42,14 @@</span><br><span> #include &quot;cry=
pto=2Eh&quot;</span><br><span> #ifdef _WIN32</span><br><span> #include &quo=
t;win32-util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;compat-close-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;errno=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;fcntl=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;sys/socket=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;sys/wait=2Eh&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><span> #e=
ndif</span><br><span> #include &quot;test_schedule=2Eh&quot;</span><br><spa=
n> </span><br><span>@@ -475,9 +483,142 @@</span><br><span> }</span><br><spa=
n> #endif /* _WIN32 */</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+fd_is_closed(int fd)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errno=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return f=
cntl(fd, F_GETFD) =3D=3D -1 &amp;&amp; errno =3D=3D EBADF;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fd_is_=
open(int fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fcntl(fd, F_GE=
TFD) !=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+run_close_fds_case(int keep_target)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int control[2];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (socketpair(AF_UNIX, SOCK_STREAM, 0, control)=
 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return EXIT_FAILU=
RE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const pid_t pid =3D fork();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (pid &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        close(control[0]);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        close(control[1]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return EXIT_FAILURE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (pid =3D=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        close(control[0]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt keep =3D control[1];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const long open_max =3D sysconf(_SC_OPEN_MAX);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (open_max &gt; 3 &amp;&am=
p; keep_target &gt;=3D open_max)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            keep_target =3D (int)open_max - 1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (keep_target &gt;=3D 3 &amp;&amp; keep_targe=
t !=3D keep)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (d=
up2(keep, keep_target) &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                _exit(EXIT_FAILURE);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            close(keep);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            keep =3D keep_target;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const int source =3D open(&quot;/dev/null&quot;, O_RDWR);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (source &lt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            _exit(EXIT_FAI=
LURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int fd =3D=
 STDIN_FILENO; fd &lt;=3D STDERR_FILENO; ++fd)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (dup2(source, fd) &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                _exit(EXIT_FAILURE);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        const int close_fd_1 =3D dup(sou=
rce);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
int close_fd_2 =3D dup(source);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (close_fd_1 &lt; 0 || close_fd_2 &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            _exit(EXIT_FAILURE);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (source &gt; STDERR_FILENO =
&amp;&amp; source !=3D keep)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           close(source);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        close_fds_excep=
t(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const char result =3D =
fd_is_open(STDIN_FILENO) &amp;&amp; fd_is_open(STDOUT_FILENO)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
   &amp;&amp; fd_is_open(STDERR_FILENO)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                    &amp;&amp; fd_is_cl=
osed(close_fd_1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                 &amp;&amp; fd_is_closed(close_fd_2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
      ? &#39;1&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                : &#39;0&#39;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (write(keep, &amp;result, sizeof(resu=
lt)) !=3D sizeof(result))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        _exit(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       close(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        _exit(result =3D=3D &#39;1&#39; ? EXIT_SUCCESS : EXIT_FAILURE);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    close(control[1]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    char result =3D &#39;0&#39;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D read(control[=
0], &amp;result, sizeof(result));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    close(control[0]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int status =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (waitpid(pid, &amp;status, 0) !=3D pid)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return EXIT_FAILURE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
size =3D=3D sizeof(result) &amp;&amp; result =3D=3D &#39;1&#39; &amp;&amp; =
WIFEXITED(status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                 &amp;&amp; WEXITSTATUS(status) =3D=3D EXIT_SUCCESS</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+               ? EXIT_SUCCE=
SS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               : =
EXIT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_close_fds_default_keep(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    (void)state;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(run_close_fds_case(-1), EXI=
T_SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_close_fds_keep_three(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    (void)state;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(run_close_fds_case(3), EXIT_SUCCE=
SS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_close_fds_keep_middle(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    (void)state;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(run_close_fds_case(150), EXIT_SUCCESS);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* !_WIN32 */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUni=
tTest misc_tests[] =3D {</span><br><span> #ifdef _WIN32</span><br><span>   =
  cmocka_unit_test(test_win_path_in_dir),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmocka_unit_test(test_close_fds_default_keep),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_close_fds_=
keep_three),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmo=
cka_unit_test(test_close_fds_keep_middle),</span><br><span> #endif</span><b=
r><span>     cmocka_unit_test(test_compat_lzo_string),</span><br><span>    =
 cmocka_unit_test(test_auth_fail_temp_no_flags),</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1881?usp=3Demail">change 1881</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1881 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: srkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;ger=
t@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: srkyn &lt;david@srkyn=2Ecom&gt; </div=
>

</body></html>
--6s17LVY9cDQ=--


--===============2385533458990775250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2385533458990775250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2385533458990775250==--

