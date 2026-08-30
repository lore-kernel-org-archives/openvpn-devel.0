Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4CBC61DE8
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWM24ap34pPJLHnJtKUvtjvJbKf6V7+hzyejhcVJviE=; b=Th7DqLlNf+IU2pA5lcdawYlpT6
	w64NKTCTyR+m84OFUJeV99Szfr/TcCkLZMV1T43lzKNDTkVQx3MfwCMtuGZqZRQ+we6mXaMQHKk5T
	wVH9tHBGCY2ngxhnby1ZblibTAQtNtPvomLMo6lxIRDmRMi13Bwaruj3hnmzSBCpdq4k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0mSh-0000VR-9y;
	Sun, 30 Aug 2026 20:49:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0mSg-0000VL-0P
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 20:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=weTnPij9puw5L27HJc+Ue35QKPRMX5bEOYXttE0lfSU=; b=KZimSDRyB6Hz1O9nVANcFtPhDq
 K49ooOIAk/VkGrsECyLjxBEJ9jvZT2sBNVbLTRusRCInGejFppWfH4cAe2QHujjn0XZJPyKEDV3Zd
 DFvrLQ0Yfgdp+EjXb/IVHnM0nJ/DZVfNMeqTlicQt8jYpCeNLvDdOFd1+KU+KVrNdb2s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=weTnPij9puw5L27HJc+Ue35QKPRMX5bEOYXttE0lfSU=; b=Q
 xBVpzK/pORdGpU4vwbCwRcK88jZsBSalvE04eTpDLmjyLa788aIlzZ3v7Em4mNfy5PsjEeG8W5vaY
 eDGVwjV1ehzRQofKl/t4yBzy5TcZVAmobRJYAxMOwJEf1NCs8eVuZbmyTuX3emS1ZO6VaAZaq45Ju
 JlvkrfE/Tv/fDqpI=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0mSc-00065a-3B for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 20:49:06 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-482fc2b44a7so2226214f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 13:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788122935; x=1788727735; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=weTnPij9puw5L27HJc+Ue35QKPRMX5bEOYXttE0lfSU=;
 b=elFkJL/qhdiqNWTEL25iCgXB+q194OymJyIZtgElx0sKcfoAeI0FvQZ1jRGE6hmKf0
 e43lMQ+3VFED98D/fipNyJfWk6U/sSHdEMbLhuq0uweYiCUsb/Kylzadfc9PwrrKN8vq
 C3NNnORfPiubpMqWPqsFWdGKmNW0GtnJ/N8bOhrTKSGQ4esNw7/HOjUPeWwT4lyT+Wkq
 WNWgU881o/uj6oJfXffSSq4eNdzY0dD6AnpVHa+4mfBwkjVnbxh2xTd3YA7YlHUAjp5d
 WF08NDx46x6pEFQPJUidBVYOhoQyKc5+K860ZJkKJTFg9tdwWyhM/IQmc3QUy9G7qlTX
 PaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788122935; x=1788727735;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=weTnPij9puw5L27HJc+Ue35QKPRMX5bEOYXttE0lfSU=;
 b=VIeNfYUVWLt3vyZZ+XX9Vt5YkWu/SxF6n56eIXVN339NiCz/N5ib5al25KbHtTmEUl
 KoYjEnAfkqUGkqnBMJ8Vr7hStJnNcdpOEWI9CT4voqqH4gYaIAqPq9cqhwSBCqJTyCjZ
 zdN3FDapRoitIw06EyVz2AORJLECHofZttxid6vr+yWFVFH09kYsTjBWfWsbZ68wrcGt
 wbpxs410IBkYj3mDtaWMstDTSkRZlxfCswzS9L28RtO2LT3o3Bca4CGXC79OvA8o3wXR
 +QavOsIMLuuXt5NlD+RIig90iEnKSxDeM/kgFkPG015MUg0h7WNlOwRoYJ2T0EcS0Pg6
 zJzw==
X-Gm-Message-State: AFuF++mhmSewxPszsJpw3jBRJTpZ7Q/c5w9yve6FKbjNQ/b9owve9Uzr
 cvkVJWjnnS6i8nGsP49LRQcGr4cSyDn/0i2CIeBH3SU2++xgbrNSt1fuU3hqNIGG2eKNJ60tiyi
 /rBxXdJYSVlY/qk6txay4Y8vm1MkHpBWawucAwAHNP/35WmEpamqDLLKaQzWya0EFNv6g
X-Gm-Gg: AYBFou1n6eql3mwSuwrfrgBt0hEj5fKrlsDjCUnQEbqzlfNhxBOekFr1nO7l5dUHtdV
 gioF2NlZInwdDAem2R1C4VLtUbsG9cBw2Vz979oFKSIotfZe5Jc/Nzo+m/KHJZqeMqEI7SIIL75
 q/xnO+fvx1CJg1AIcT40jY20ziBTq+pkZu+3Vi0uu8q3nUiL3nydbZC3m5XZyb9EEBgyjjFtLuT
 HeSIIA2NHa6j6uP/OpM2zhENIQhxuJgM+xVer9uWVXWcIgOfiOQP5qbpYoKmnCiqyWdHtZ46EaN
 r+lWUpwlIq1htCZUft1f6+i2C5U+ce/6rUAGcQ1JtY1Cniuah1sYmszsFbkjVi5QXi3lfkS7mAu
 epgOZSarQ4rWZDsQ+3AuS1Cp+RH38vror47Hb+XizVVaKJrwnxQ8Vp7FGRSo3wiruRaTHzdVXao
 bdAVZu4O+Y+i9TXhJ1UU+oOwY4vX0rjA4CE3FokwkNkaxKnGPMRt2AsnH0vYGc0p4J/ndmq4X8M
 26yw7s4lv8qw6gge6dInkVf4qH/fkW6zat7OXeyJAW6NDw4tI5WwUJ67CePPpyBRsfFxn26+hPq
 eLNL4PhARDL1QIf8YyvBT5NLMxKAD6HLlsb9PLY3FB0XxTdQsRvGDU++jllMJ8k=
X-Received: by 2002:a05:6000:4692:b0:47f:762f:32a9 with SMTP id
 ffacd0b85a97d-482f79b1ed2mr26128796f8f.12.1788122935205; 
 Sun, 30 Aug 2026 13:48:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48437b30959sm6904048f8f.27.2026.08.30.13.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 13:48:54 -0700 (PDT)
X-Google-Original-From: "srkyn (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 20:48:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: db8854f550226474ea84c377fdbc5024620f05e4
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5afa4baa66ec48d949376e8daf79c73d1f2a454-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0mSc-00065a-3B
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
Content-Type: multipart/mixed; boundary="===============0884689935048034017=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0884689935048034017==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HOfOQBh/mc8="; charset=UTF-8

--HOfOQBh/mc8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: srkyn=2E

Hello plaisthos, razvanc, 
=

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1881?usp=3Demail

to look at the new patch set (#3)=
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
A src/compat/close-fds=2Ec
A src/compat/close-fds=2Eh
M=
 src/openvpn/ps=2Ec
M src/plugins/auth-pam/Makefile=2Eam
M src/plugins/auth=
-pam/auth-pam=2Ec
M src/plugins/down-root/Makefile=2Eam
M src/plugins/down-=
root/down-root=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_te=
sts/openvpn/test_misc=2Ec
13 files changed, 285 insertions(+), 74 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81=
/1881/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2c3324d=2E=
=2E204cca1 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -19,6 +1=
9,7 @@
 include(CheckLinkerFlag OPTIONAL)
 include(CheckTypeSize)
 include(=
CheckStructHasMember)
+include(CMakePushCheckState)
 include(CTest)
 
 opti=
on(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
@@ -196,6 +197,10 @@
=
     check_symbol_exists(fork unistd=2Eh HAVE_FORK)
     check_symbol_exist=
s(execve unistd=2Eh HAVE_EXECVE)
     check_symbol_exists(ftruncate unistd=
=2Eh HAVE_FTRUNCATE)
+    cmake_push_check_state()
+    list(APPEND CMAKE_R=
EQUIRED_DEFINITIONS -D_GNU_SOURCE)
+    check_symbol_exists(close_range uni=
std=2Eh HAVE_CLOSE_RANGE)
+    cmake_pop_check_state()
     check_symbol_ex=
ists(nice unistd=2Eh HAVE_NICE)
     check_symbol_exists(setgid unistd=2Eh =
HAVE_SETGID)
     check_symbol_exists(setuid unistd=2Eh HAVE_SETUID)
@@ -42=
4,6 +429,8 @@
     src/compat/compat-gettimeofday=2Ec
     src/compat/compa=
t-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/compat/close-fds=
=2Ec
+    src/compat/close-fds=2Eh
     src/openvpn/argv=2Ec
     src/openv=
pn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -854,6 +861,11 @@
         src/o=
penvpn/siphash=2Ec
         src/openvpn/siphash_reference=2Ec
     )
+    i=
f (NOT WIN32)
+        target_sources(test_misc PRIVATE
+            src/co=
mpat/close-fds=2Ec
+        )
+    endif ()
 
     target_sources(test_ncp =
PRIVATE
         src/openvpn/crypto_epoch=2Ec
diff --git a/config=2Eh=2Ecma=
ke=2Ein b/config=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=2Ec507787 100644
--- a/c=
onfig=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -75,6 +75,9 @@
 /* =
Define to 1 if you have the `chsize' function=2E */
 #cmakedefine HAVE_CHSI=
ZE
 
+/* Define to 1 if you have the `close_range' function=2E */
+#cmakede=
fine HAVE_CLOSE_RANGE
+
 /* struct cmsghdr needed for extended socket error=
 support */
 #cmakedefine HAVE_CMSGHDR
 
diff --git a/configure=2Eac b/conf=
igure=2Eac
index 469a475=2E=2Ebaa185a 100644
--- a/configure=2Eac
+++ b/con=
figure=2Eac
@@ -567,7 +567,7 @@
 	syslog openlog mlockall getrlimit getgrna=
m setgid \
 	setgroups flock gettimeofday \
 	setsid chdir \
-	chsize ftrun=
cate execve getpeereid basename dirname \
+	chsize ftruncate execve getpeer=
eid basename dirname close_range \
 	epoll_create strsep strtok_r \
 ])
 
d=
iff --git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam
index 22867=
b3=2E=2E12c3f95 100644
--- a/src/compat/Makefile=2Eam
+++ b/src/compat/Make=
file=2Eam
@@ -16,9 +16,10 @@
 
 libcompat_la_SOURCES =3D \
 	compat=2Eh \
+=
	close-fds=2Ec close-fds=2Eh \
 	compat-dirname=2Ec \
 	compat-basename=2Ec=
 \
 	compat-gettimeofday=2Ec \
 	compat-daemon=2Ec \
 	compat-strsep=2Ec \
=
-	compat-strtok_r=2Ec
\ No newline at end of file
+	compat-strtok_r=2Ec
dif=
f --git a/src/compat/close-fds=2Ec b/src/compat/close-fds=2Ec
new file mode=
 100644
index 0000000=2E=2E335b6e1
--- /dev/null
+++ b/src/compat/close-fds=
=2Ec
@@ -0,0 +1,82 @@
+/*
+ *  OpenVPN -- An application to securely tunnel=
 IP networks
+ *             over a single UDP port, with support for SSL/T=
LS-based
+ *             session authentication and key exchange,
+ *      =
       packet encryption, packet authentication, and
+ *             packet=
 compression=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This p=
rogram is free software; you can redistribute it and/or modify
+ *  it unde=
r the terms of the GNU General Public License version 2
+ *  as published b=
y the Free Software Foundation=2E
+ *
+ *  This program is distributed in t=
he hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even=
 the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
=
+ *  You should have received a copy of the GNU General Public License alon=
g
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef =
_WIN32
+
+#include "close-fds=2Eh"
+
+#include <limits=2Eh>
+#include <stdb=
ool=2Eh>
+#include <unistd=2Eh>
+#include <syslog=2Eh>
+
+void
+close_fds_e=
xcept(int keep)
+{
+    closelog();
+
+#ifdef HAVE_CLOSE_RANGE
+    bool ra=
nges_closed =3D true;
+    if (keep >=3D 3)
+    {
+        if (keep > 3)
+=
        {
+            const unsigned int last =3D (unsigned int)keep - 1;
=
+            ranges_closed =3D close_range(3, last, 0) =3D=3D 0;
+        }=

+
+        const unsigned int first =3D (unsigned int)keep + 1;
+        i=
f (close_range(first, ~0U, 0) !=3D 0)
+        {
+            ranges_closed=
 =3D false;
+        }
+    }
+    else
+    {
+        ranges_closed =3D c=
lose_range(3, ~0U, 0) =3D=3D 0;
+    }
+    if (ranges_closed)
+    {
+    =
    return;
+    }
+#endif
+
+    const long open_max =3D sysconf(_SC_OPEN_=
MAX);
+    int max_fd =3D 1024;
+    if (open_max > 0)
+    {
+        max_=
fd =3D open_max > INT_MAX ? INT_MAX : (int)open_max;
+    }
+    for (int f=
d =3D 3; fd < max_fd; ++fd)
+    {
+        if (fd !=3D keep)
+        {
+ =
           close(fd);
+        }
+    }
+}
+
+#endif /* !_WIN32 */
diff --g=
it a/src/compat/close-fds=2Eh b/src/compat/close-fds=2Eh
new file mode 1006=
44
index 0000000=2E=2E35fe7de
--- /dev/null
+++ b/src/compat/close-fds=2Eh
=
@@ -0,0 +1,38 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP n=
etworks
+ *             over a single UDP port, with support for SSL/TLS-ba=
sed
+ *             session authentication and key exchange,
+ *           =
  packet encryption, packet authentication, and
+ *             packet comp=
ression=2E
+ *
+ *  Copyright (C) 2026 David Sarkisyan
+ *
+ *  This progra=
m is free software; you can redistribute it and/or modify
+ *  it under the=
 terms of the GNU General Public License version 2
+ *  as published by the=
 Free Software Foundation=2E
+ *
+ *  This program is distributed in the ho=
pe that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the =
implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  =
You should have received a copy of the GNU General Public License along
+ *=
  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ *=
/
+
+#ifndef CLOSE_FDS_H
+#define CLOSE_FDS_H
+
+#ifndef _WIN32
+/**
+ * Cl=
ose descriptors inherited across fork that are unrelated to a helper=2E
+ *=

+ * Standard input, standard output, standard error, and @p keep remain op=
en=2E
+ * All other file descriptors starting at 3 are closed=2E
+ *
+ * @p=
aram keep file descriptor used for communication with the parent process
+ =
*/
+void close_fds_except(int keep);
+#endif
+
+#endif /* CLOSE_FDS_H */
di=
ff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be91a99=2E=2Edbe5a=
1e 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -33,6 +33,7 =
@@
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
 #include "ps=2Eh"
+#inclu=
de "close-fds=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -96,30 +97,6 @@
 }
 
 /*
-=
 * Close most of parent's fds=2E
- * Keep stdin/stdout/stderr, plus one
- *=
 other fd which is presumed to be
- * our pipe back to parent=2E
- * Admitt=
edly, a bit of a kludge,
- * but posix doesn't give us a kind
- * of FD_CLO=
EXEC which will stop
- * fds from crossing a fork()=2E
- */
-static void
-c=
lose_fds_except(int keep)
-{
-    socket_descriptor_t i;
-    closelog();
-=
    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if (i !=3D keep)
-      =
  {
-            openvpn_close_socket(i);
-        }
-    }
-}
-
-/*
  * Us=
ually we ignore signals, because our parent will
  * deal with them=2E
  */=

diff --git a/src/plugins/auth-pam/Makefile=2Eam b/src/plugins/auth-pam/Mak=
efile=2Eam
index e6dc27e=2E=2Efb7fd30 100644
--- a/src/plugins/auth-pam/Mak=
efile=2Eam
+++ b/src/plugins/auth-pam/Makefile=2Eam
@@ -9,6 +9,7 @@
 
 AM_C=
FLAGS =3D \
 	-I$(top_srcdir)/include \
+	-I$(top_srcdir)/src/compat \
 	$(=
PLUGIN_AUTH_PAM_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
@@ -23,6 +24,7 @@
 =
	pamdl=2Ec  pamdl=2Eh \
 	auth-pam=2Eexports
 openvpn_plugin_auth_pam_la_LI=
BADD =3D \
+	$(top_builddir)/src/compat/libcompat=2Ela \
 	$(PLUGIN_AUTH_PA=
M_LIBS)
 openvpn_plugin_auth_pam_la_LDFLAGS =3D $(AM_LDFLAGS) \
 	-export-s=
ymbols "$(srcdir)/auth-pam=2Eexports" \
diff --git a/src/plugins/auth-pam/a=
uth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 948b6af=2E=2E04bb7d8 =
100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/plugins/auth-pam/a=
uth-pam=2Ec
@@ -51,6 +51,8 @@
 #include <arpa/inet=2Eh>
 #include <openvpn-=
plugin=2Eh>
 
+#include "close-fds=2Eh"
+
 #define DEBUG(verb) ((verb) >=3D=
 4)
 
 /* Command codes for foreground -> background communication */
@@ -2=
40,30 +242,6 @@
 #endif /* ifdef DO_DAEMONIZE */
 
 /*
- * Close most of pa=
rent's fds=2E
- * Keep stdin/stdout/stderr, plus one
- * other fd which is =
presumed to be
- * our pipe back to parent=2E
- * Admittedly, a bit of a kl=
udge,
- * but posix doesn't give us a kind
- * of FD_CLOEXEC which will sto=
p
- * fds from crossing a fork()=2E
- */
-static void
-close_fds_except(int=
 keep)
-{
-    int i;
-    closelog();
-    for (i =3D 3; i <=3D 100; ++i)
=
-    {
-        if (i !=3D keep)
-        {
-            close(i);
-       =
 }
-    }
-}
-
-/*
  * Usually we ignore signals, because our parent will
 =
 * deal with them=2E
  */
diff --git a/src/plugins/down-root/Makefile=2Eam =
b/src/plugins/down-root/Makefile=2Eam
index 7ca5a4e=2E=2E83bc04f 100644
---=
 a/src/plugins/down-root/Makefile=2Eam
+++ b/src/plugins/down-root/Makefile=
=2Eam
@@ -9,6 +9,7 @@
 
 AM_CFLAGS =3D \
 	-I$(top_srcdir)/include \
+	-I$(=
top_srcdir)/src/compat \
 	$(OPTIONAL_CRYPTO_CFLAGS)
 
 if ENABLE_PLUGIN_DO=
WN_ROOT
@@ -19,6 +20,8 @@
 openvpn_plugin_down_root_la_SOURCES =3D \
 	down=
-root=2Ec \
 	down-root=2Eexports
+openvpn_plugin_down_root_la_LIBADD =3D \=

+	$(top_builddir)/src/compat/libcompat=2Ela
 openvpn_plugin_down_root_la_L=
DFLAGS =3D $(AM_LDFLAGS) \
 	-export-symbols "$(srcdir)/down-root=2Eexports=
" \
 	-module -shared -avoid-version -no-undefined
diff --git a/src/plugins=
/down-root/down-root=2Ec b/src/plugins/down-root/down-root=2Ec
index cd5718=
9=2E=2Ef0ee7ea 100644
--- a/src/plugins/down-root/down-root=2Ec
+++ b/src/p=
lugins/down-root/down-root=2Ec
@@ -44,6 +44,8 @@
 
 #include <openvpn-plugi=
n=2Eh>
 
+#include "close-fds=2Eh"
+
 #define DEBUG(verb) ((verb) >=3D 7)
 =

 /* Command codes for foreground -> background communication */
@@ -191,30=
 +193,6 @@
 }
 
 /*
- * Close most of parent's fds=2E
- * Keep stdin/stdout=
/stderr, plus one
- * other fd which is presumed to be
- * our pipe back to=
 parent=2E
- * Admittedly, a bit of a kludge,
- * but posix doesn't give us=
 a kind
- * of FD_CLOEXEC which will stop
- * fds from crossing a fork()=2E=

- */
-static void
-close_fds_except(int keep)
-{
-    int i;
-    closelog=
();
-    for (i =3D 3; i <=3D 100; ++i)
-    {
-        if (i !=3D keep)
- =
       {
-            close(i);
-        }
-    }
-}
-
-/*
  * Usually we i=
gnore signals, because our parent will
  * deal with them=2E
  */
diff --gi=
t a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makef=
ile=2Eam
index 6db611e=2E=2E71726be 100644
--- a/tests/unit_tests/openvpn/M=
akefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -388,6 +388,10=
 @@
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec
 
+if !WIN32
+misc_testdriver_SOURCES +=3D $(top_srcdi=
r)/src/compat/close-fds=2Ec
+endif
+
 push_update_msg_testdriver_CFLAGS =3D=
 -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_src=
dir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/openvpn/test_=
misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index a41c27b=2E=2Ed74773=
8 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_test=
s/openvpn/test_misc=2Ec
@@ -42,6 +42,14 @@
 #include "crypto=2Eh"
 #ifdef _=
WIN32
 #include "win32-util=2Eh"
+#else
+#include "close-fds=2Eh"
+
+#inclu=
de <errno=2Eh>
+#include <fcntl=2Eh>
+#include <sys/socket=2Eh>
+#include <=
sys/wait=2Eh>
+#include <unistd=2Eh>
 #endif
 #include "test_schedule=2Eh"
=
 
@@ -475,9 +483,134 @@
 }
 #endif /* _WIN32 */
 
+#ifndef _WIN32
+static b=
ool
+fd_is_closed(int fd)
+{
+    errno =3D 0;
+    return fcntl(fd, F_GETF=
D) =3D=3D -1 && errno =3D=3D EBADF;
+}
+
+static bool
+fd_is_open(int fd)
+=
{
+    return fcntl(fd, F_GETFD) !=3D -1;
+}
+
+static int
+run_close_fds_c=
ase(int keep_target)
+{
+    int control[2];
+    if (socketpair(AF_UNIX, S=
OCK_STREAM, 0, control) < 0)
+    {
+        return EXIT_FAILURE;
+    }
+
=
+    const pid_t pid =3D fork();
+    if (pid < 0)
+    {
+        close(co=
ntrol[0]);
+        close(control[1]);
+        return EXIT_FAILURE;
+    }=

+
+    if (pid =3D=3D 0)
+    {
+        close(control[0]);
+
+        int=
 keep =3D control[1];
+        if (keep_target >=3D 3 && keep_target !=3D k=
eep)
+        {
+            if (dup2(keep, keep_target) < 0)
+            =
{
+                _exit(EXIT_FAILURE);
+            }
+            close(k=
eep);
+            keep =3D keep_target;
+        }
+
+        const int so=
urce =3D open("/dev/null", O_RDWR);
+        if (source < 0)
+        {
+  =
          _exit(EXIT_FAILURE);
+        }
+        for (int fd =3D STDIN_FI=
LENO; fd <=3D STDERR_FILENO; ++fd)
+        {
+            if (dup2(source,=
 fd) < 0)
+            {
+                _exit(EXIT_FAILURE);
+           =
 }
+        }
+        if (dup2(source, 100) < 0 || dup2(source, 200) < 0)
=
+        {
+            _exit(EXIT_FAILURE);
+        }
+        if (source=
 > STDERR_FILENO && source !=3D keep)
+        {
+            close(source)=
;
+        }
+
+        close_fds_except(keep);
+
+        const char resul=
t =3D fd_is_open(STDIN_FILENO) && fd_is_open(STDOUT_FILENO)
+              =
                      && fd_is_open(STDERR_FILENO) && fd_is_closed(100)
+  =
                                  && fd_is_closed(200)
+                   =
             ? '1'
+                                : '0';
+        if (wri=
te(keep, &result, sizeof(result)) !=3D sizeof(result))
+        {
+        =
    _exit(EXIT_FAILURE);
+        }
+        close(keep);
+        _exit(re=
sult =3D=3D '1' ? EXIT_SUCCESS : EXIT_FAILURE);
+    }
+
+    close(control=
[1]);
+    char result =3D '0';
+    const ssize_t size =3D read(control[0]=
, &result, sizeof(result));
+    close(control[0]);
+
+    int status =3D 0=
;
+    if (waitpid(pid, &status, 0) !=3D pid)
+    {
+        return EXIT_F=
AILURE;
+    }
+
+    return size =3D=3D sizeof(result) && result =3D=3D '1=
' && WIFEXITED(status)
+                   && WEXITSTATUS(status) =3D=3D EX=
IT_SUCCESS
+               ? EXIT_SUCCESS
+               : EXIT_FAILURE;
+=
}
+
+static void
+test_close_fds_default_keep(void **state)
+{
+    (void)s=
tate;
+    assert_int_equal(run_close_fds_case(-1), EXIT_SUCCESS);
+}
+
+st=
atic void
+test_close_fds_keep_three(void **state)
+{
+    (void)state;
+  =
  assert_int_equal(run_close_fds_case(3), EXIT_SUCCESS);
+}
+
+static void
=
+test_close_fds_keep_middle(void **state)
+{
+    (void)state;
+    assert_=
int_equal(run_close_fds_case(150), EXIT_SUCCESS);
+}
+#endif /* !_WIN32 */
=
+
 const struct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_un=
it_test(test_win_path_in_dir),
+#else
+    cmocka_unit_test(test_close_fds_=
default_keep),
+    cmocka_unit_test(test_close_fds_keep_three),
+    cmock=
a_unit_test(test_close_fds_keep_middle),
 #endif
     cmocka_unit_test(test=
_compat_lzo_string),
     cmocka_unit_test(test_auth_fail_temp_no_flags),

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cf=
b25b2b364ca661fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 3
Gerri=
t-Owner: srkyn <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: srkyn <david@srkyn=2Ecom>

--HOfOQBh/mc8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: srkyn=2E </p>
<p>srkyn <strong>uploaded patch set #3<=
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
le=2Eam<br>A src/compat/close-fds=2Ec<br>A src/compat/close-fds=2Eh<br>M sr=
c/openvpn/ps=2Ec<br>M src/plugins/auth-pam/Makefile=2Eam<br>M src/plugins/a=
uth-pam/auth-pam=2Ec<br>M src/plugins/down-root/Makefile=2Eam<br>M src/plug=
ins/down-root/down-root=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>=
M tests/unit_tests/openvpn/test_misc=2Ec<br>13 files changed, 285 insertion=
s(+), 74 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/81/1881/3</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMake=
Lists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2c3324d=2E=2E204cca1 1=
00644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLis=
ts=2Etxt</span><br><span>@@ -19,6 +19,7 @@</span><br><span> include(CheckLi=
nkerFlag OPTIONAL)</span><br><span> include(CheckTypeSize)</span><br><span>=
 include(CheckStructHasMember)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+include(CMakePushCheckState)</span><br><span> include(CTest)</sp=
an><br><span> </span><br><span> option(UNSUPPORTED_BUILDS &quot;Allow unsup=
ported builds&quot; OFF)</span><br><span>@@ -196,6 +197,10 @@</span><br><sp=
an>     check_symbol_exists(fork unistd=2Eh HAVE_FORK)</span><br><span>    =
 check_symbol_exists(execve unistd=2Eh HAVE_EXECVE)</span><br><span>     ch=
eck_symbol_exists(ftruncate unistd=2Eh HAVE_FTRUNCATE)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    cmake_push_check_state()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    list(APPEND CMAKE_REQUIRED_=
DEFINITIONS -D_GNU_SOURCE)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    check_symbol_exists(close_range unistd=2Eh HAVE_CLOSE_RANGE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmake_pop_check_sta=
te()</span><br><span>     check_symbol_exists(nice unistd=2Eh HAVE_NICE)</s=
pan><br><span>     check_symbol_exists(setgid unistd=2Eh HAVE_SETGID)</span=
><br><span>     check_symbol_exists(setuid unistd=2Eh HAVE_SETUID)</span><b=
r><span>@@ -424,6 +429,8 @@</span><br><span>     src/compat/compat-gettimeo=
fday=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span><br><span>=
     src/compat/compat-strtok_r=2Ec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/compat/close-fds=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    src/compat/close-fds=2Eh</span><br><span>     =
src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><s=
pan>     src/openvpn/base64=2Ec</span><br><span>@@ -854,6 +861,11 @@</span>=
<br><span>         src/openvpn/siphash=2Ec</span><br><span>         src/ope=
nvpn/siphash_reference=2Ec</span><br><span>     )</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (NOT WIN32)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        target_sources(test_misc PRIVATE</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/compat/cl=
ose-fds=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()</span=
><br><span> </span><br><span>     target_sources(test_ncp PRIVATE</span><br=
><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/c=
onfig=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index c3bb=
5a5=2E=2Ec507787 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span=
><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -75,6 +75,9 @@<=
/span><br><span> /* Define to 1 if you have the `chsize&#39; function=2E */=
</span><br><span> #cmakedefine HAVE_CHSIZE</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `cl=
ose_range&#39; function=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#cmakedefine HAVE_CLOSE_RANGE</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> /* struct cmsghdr needed for extended=
 socket error support */</span><br><span> #cmakedefine HAVE_CMSGHDR</span><=
br><span> </span><br><span>diff --git a/configure=2Eac b/configure=2Eac</sp=
an><br><span>index 469a475=2E=2Ebaa185a 100644</span><br><span>--- a/config=
ure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -567,7 +56=
7,7 @@</span><br><span> 	syslog openlog mlockall getrlimit getgrnam setgid =
\</span><br><span> 	setgroups flock gettimeofday \</span><br><span> 	setsid=
 chdir \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	chsize ftrun=
cate execve getpeereid basename dirname \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	chsize ftruncate execve getpeereid basename dirname =
close_range \</span><br><span> 	epoll_create strsep strtok_r \</span><br><s=
pan> ])</span><br><span> </span><br><span>diff --git a/src/compat/Makefile=
=2Eam b/src/compat/Makefile=2Eam</span><br><span>index 22867b3=2E=2E12c3f95=
 100644</span><br><span>--- a/src/compat/Makefile=2Eam</span><br><span>+++ =
b/src/compat/Makefile=2Eam</span><br><span>@@ -16,9 +16,10 @@</span><br><sp=
an> </span><br><span> libcompat_la_SOURCES =3D \</span><br><span> 	compat=
=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	close-fds=2E=
c close-fds=2Eh \</span><br><span> 	compat-dirname=2Ec \</span><br><span> 	=
compat-basename=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</span><br=
><span> 	compat-daemon=2Ec \</span><br><span> 	compat-strsep=2Ec \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	compat-strtok_r=2Ec</span><br=
><span>\ No newline at end of file</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	compat-strtok_r=2Ec</span><br><span>diff --git a/src/compat=
/close-fds=2Ec b/src/compat/close-fds=2Ec</span><br><span>new file mode 100=
644</span><br><span>index 0000000=2E=2E335b6e1</span><br><span>--- /dev/nul=
l</span><br><span>+++ b/src/compat/close-fds=2Ec</span><br><span>@@ -0,0 +1=
,82 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             packet encryption, packet authenticati=
on, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2026 David Sarkisyan</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope t=
hat it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=
=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;close-fds=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;limits=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &lt;syslog=2Eh&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clos=
e_fds_except(int keep)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    closelog();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CLOSE_RANGE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool ranges_closed =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (keep &gt;=3D =
3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (keep &gt; 3)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            const unsigned int last =
=3D (unsigned int)keep - 1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            ranges_closed =3D close_range(3, last, 0) =3D=3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const unsigned int first =3D (unsigned int)k=
eep + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(close_range(first, ~0U, 0) !=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ranges_closed =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        ranges_closed =3D =
close_range(3, ~0U, 0) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (ranges_closed)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const long open_max =3D sysconf(_SC_OPEN_MAX);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int max_fd =3D 1024;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (open_max &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        max_fd =3D open_max &gt; =
INT_MAX ? INT_MAX : (int)open_max;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int fd =3D 3; fd &lt; max_fd; ++fd)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (fd !=3D keep)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            close(fd);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif /* !_WIN32 */</span><br><span>diff --git a/=
src/compat/close-fds=2Eh b/src/compat/close-fds=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2E35fe7de</span><br><span>--=
- /dev/null</span><br><span>+++ b/src/compat/close-fds=2Eh</span><br><span>=
@@ -0,0 +1,38 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             over a single UDP port, with support fo=
r SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2026 David Sarkisyan</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is free software; you can redistribute it and/or modify<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the ter=
ms of the GNU General Public License version 2</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CLOSE_FDS_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CLOSE_FDS_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Close descriptors inherited across fork that are unrelate=
d to a helper=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Standard input, s=
tandard output, standard error, and @p keep remain open=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * All other file descriptors starti=
ng at 3 are closed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param keep =
file descriptor used for communication with the parent process</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void close_fds_except(int keep);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif /* CLOSE_FDS_H */</span><br><span>diff --git a/src/openvpn/p=
s=2Ec b/src/openvpn/ps=2Ec</span><br><span>index be91a99=2E=2Edbe5a1e 10064=
4</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvp=
n/ps=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;=
fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br=
><span> #include &quot;ps=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;close-fds=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><spa=
n>@@ -96,30 +97,6 @@</span><br><span> }</span><br><span> </span><br><span> =
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Close most of pa=
rent&#39;s fds=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * K=
eep stdin/stdout/stderr, plus one</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * other fd which is presumed to be</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * our pipe back to parent=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Admittedly, a bit of a kludge,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * but posix doesn&#39;t give=
 us a kind</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of FD_CL=
OEXEC which will stop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * fds from crossing a fork()=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-close_fds_except(=
int keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    socket_descriptor_t i;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    closelog();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 3; i &lt;=3D 100; =
++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D keep)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            openvpn_close_socket(i);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  =
* Usually we ignore signals, because our parent will</span><br><span>  * de=
al with them=2E</span><br><span>  */</span><br><span>diff --git a/src/plugi=
ns/auth-pam/Makefile=2Eam b/src/plugins/auth-pam/Makefile=2Eam</span><br><s=
pan>index e6dc27e=2E=2Efb7fd30 100644</span><br><span>--- a/src/plugins/aut=
h-pam/Makefile=2Eam</span><br><span>+++ b/src/plugins/auth-pam/Makefile=2Ea=
m</span><br><span>@@ -9,6 +9,7 @@</span><br><span> </span><br><span> AM_CFL=
AGS =3D \</span><br><span> 	-I$(top_srcdir)/include \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/src/compat \</span><br><=
span> 	$(PLUGIN_AUTH_PAM_CFLAGS) \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLA=
GS)</span><br><span> </span><br><span>@@ -23,6 +24,7 @@</span><br><span> 	p=
amdl=2Ec  pamdl=2Eh \</span><br><span> 	auth-pam=2Eexports</span><br><span>=
 openvpn_plugin_auth_pam_la_LIBADD =3D \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_builddir)/src/compat/libcompat=2Ela \</span><br=
><span> 	$(PLUGIN_AUTH_PAM_LIBS)</span><br><span> openvpn_plugin_auth_pam_l=
a_LDFLAGS =3D $(AM_LDFLAGS) \</span><br><span> 	-export-symbols &quot;$(src=
dir)/auth-pam=2Eexports&quot; \</span><br><span>diff --git a/src/plugins/au=
th-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>ind=
ex 948b6af=2E=2E04bb7d8 100644</span><br><span>--- a/src/plugins/auth-pam/a=
uth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/auth-pam=2Ec</span><=
br><span>@@ -51,6 +51,8 @@</span><br><span> #include &lt;arpa/inet=2Eh&gt;<=
/span><br><span> #include &lt;openvpn-plugin=2Eh&gt;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;close-fds=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #define DEBUG(verb) ((verb) &gt;=3D 4)</span><br><span> </span><br=
><span> /* Command codes for foreground -&gt; background communication */</=
span><br><span>@@ -240,30 +242,6 @@</span><br><span> #endif /* ifdef DO_DAE=
MONIZE */</span><br><span> </span><br><span> /*</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Close most of parent&#39;s fds=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * Keep stdin/stdout/stderr, plus =
one</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * other fd which =
is presumed to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * o=
ur pipe back to parent=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Admittedly, a bit of a kludge,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * but posix doesn&#39;t give us a kind</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * of FD_CLOEXEC which will stop</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * fds from crossing a fork()=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-close_fds_except(int keep)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    closelog();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (i =3D 3; i &lt;=3D 100; ++i)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (i !=3D keep)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
close(i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span>  * Usually we ignore signals, because our parent will</span><=
br><span>  * deal with them=2E</span><br><span>  */</span><br><span>diff --=
git a/src/plugins/down-root/Makefile=2Eam b/src/plugins/down-root/Makefile=
=2Eam</span><br><span>index 7ca5a4e=2E=2E83bc04f 100644</span><br><span>---=
 a/src/plugins/down-root/Makefile=2Eam</span><br><span>+++ b/src/plugins/do=
wn-root/Makefile=2Eam</span><br><span>@@ -9,6 +9,7 @@</span><br><span> </sp=
an><br><span> AM_CFLAGS =3D \</span><br><span> 	-I$(top_srcdir)/include \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/src/=
compat \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</span><br><span> </spa=
n><br><span> if ENABLE_PLUGIN_DOWN_ROOT</span><br><span>@@ -19,6 +20,8 @@</=
span><br><span> openvpn_plugin_down_root_la_SOURCES =3D \</span><br><span> =
	down-root=2Ec \</span><br><span> 	down-root=2Eexports</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_down_root_la_LIBADD =3D \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_builddir)/sr=
c/compat/libcompat=2Ela</span><br><span> openvpn_plugin_down_root_la_LDFLAG=
S =3D $(AM_LDFLAGS) \</span><br><span> 	-export-symbols &quot;$(srcdir)/dow=
n-root=2Eexports&quot; \</span><br><span> 	-module -shared -avoid-version -=
no-undefined</span><br><span>diff --git a/src/plugins/down-root/down-root=
=2Ec b/src/plugins/down-root/down-root=2Ec</span><br><span>index cd57189=2E=
=2Ef0ee7ea 100644</span><br><span>--- a/src/plugins/down-root/down-root=2Ec=
</span><br><span>+++ b/src/plugins/down-root/down-root=2Ec</span><br><span>=
@@ -44,6 +44,8 @@</span><br><span> </span><br><span> #include &lt;openvpn-p=
lugin=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;close-fds=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #define DEBUG(verb) ((verb) &g=
t;=3D 7)</span><br><span> </span><br><span> /* Command codes for foreground=
 -&gt; background communication */</span><br><span>@@ -191,30 +193,6 @@</sp=
an><br><span> }</span><br><span> </span><br><span> /*</span><br><span style=
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
n/Makefile=2Eam</span><br><span>index 6db611e=2E=2E71726be 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/t=
ests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -388,6 +388,10 @@<=
/span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if !WIN32</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+misc_testdriver_SOURCES +=3D $(top_src=
dir)/src/compat/close-fds=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/ope=
nvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span> 	-I$=
(top_srcdir)/tests/unit_tests/openvpn \</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</=
span><br><span>index a41c27b=2E=2Ed747738 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec</span><br><span>@@ -42,6 +42,14 @@</span><br><span> #i=
nclude &quot;crypto=2Eh&quot;</span><br><span> #ifdef _WIN32</span><br><spa=
n> #include &quot;win32-util=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;close-fds=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &lt;errno=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;fcntl=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;sys/socket=2Eh&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;sys/wait=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;unistd=2Eh&gt;</span><br>=
<span> #endif</span><br><span> #include &quot;test_schedule=2Eh&quot;</span=
><br><span> </span><br><span>@@ -475,9 +483,134 @@</span><br><span> }</span=
><br><span> #endif /* _WIN32 */</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+fd_is_closed(int fd)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    errno =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return fcntl(fd, F_GETFD) =3D=3D -1 &amp;&amp; errno =3D=3D EBADF;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+fd_is_open(int fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fcntl=
(fd, F_GETFD) !=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+run_close_fds_case(int keep_target)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int control[2];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (socketpair(AF_UNIX, SOCK_STREAM, =
0, control) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 EXIT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const pid_t pid =3D fork();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pid &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        close(control[0]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        close(control[1]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return EXIT_FAILUR=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (pid =3D=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        close(control[0]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int keep =3D control[1];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (keep_target &gt;=3D 3 &amp;&amp; keep_target !=3D=
 keep)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (dup2(ke=
ep, keep_target) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               _exit(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            close(keep);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            keep =3D keep_target;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const int source =3D open(&quot;/dev/null&quot;, O_RDWR);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (source &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            _exit(EXIT_FAILURE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        for (int fd =3D STDIN=
_FILENO; fd &lt;=3D STDERR_FILENO; ++fd)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (dup2(source, fd) &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                _exit(EXIT_FAILURE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (dup2(source, 100) &lt; 0 || dup2(s=
ource, 200) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  _exit(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (source &gt; STDERR_FILENO &amp;&amp; source !=3D keep)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            close(source);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        close_fds_except(keep);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const char result =3D fd_is_open(STDIN_FILENO) &amp;&amp; fd_is_op=
en(STDOUT_FILENO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                  &amp;&amp; fd_is_open(STDERR_FILENO) &amp=
;&amp; fd_is_closed(100)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                    &amp;&amp; fd_is_closed(200)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
       ? &#39;1&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                : &#39;0&#39;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (write(keep, &amp;result, sizeof(res=
ult)) !=3D sizeof(result))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         _exit(EXIT_FAILURE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        close(keep);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        _exit(result =3D=3D &#39;1&#39; ? EXIT_SUCCESS : EXIT_FAILURE);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    close(control[1]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char result =3D &#39;0&#39;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D read(control=
[0], &amp;result, sizeof(result));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    close(control[0]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int status =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (waitpid(pid, &amp;status, 0) !=3D pid)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return EXIT_FAILURE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 size =3D=3D sizeof(result) &amp;&amp; result =3D=3D &#39;1&#39; &amp;&amp;=
 WIFEXITED(status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                  &amp;&amp; WEXITSTATUS(status) =3D=3D EXIT_SUCCESS</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+               ? EXIT_SUCC=
ESS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               :=
 EXIT_FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
--HOfOQBh/mc8=--


--===============0884689935048034017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0884689935048034017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0884689935048034017==--

