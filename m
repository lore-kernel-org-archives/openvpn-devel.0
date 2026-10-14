Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1DBCC6B2C
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s41yaqQmoc7eiLM7qrptA+xeUUmyGQdhJck1Ii6mHTM=; b=cpoKM06HKHP7NY3ge21KPhmAAM
	QH5ybHov7A53sz5Bnf411c8OMKBq+Ss5c01FlRrQB/zzucefz0zZSdMLOTtxiEMh1B+5c5S56nS/6
	0FHJwc/Zlm6kGclIitvxFod/faTZqOBP2O87rUPngBVzwPypQViyClVO/YAQSj2cxXlM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxAX-0008CM-5C;
	Wed, 14 Oct 2026 11:29:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxAV-0008C6-BB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dR4IYI/g3CK1WJtfoewMpDC7fViwqxuAGyvedGII6PY=; b=ZC7OXvJnbfQusd6sV60nRMEIc1
 YFq5MEfZ3q9fs7qnu3MieuXsYNmpvU5W3MxyE2KzqbH9NDmfKSWcHISyIPzeGwszQ+SMMtbh2Tc8o
 jvtYiqGhQaqw5GMmrLHI+yqn1ccP//QxxGu97PVvQ4w4af1IYsuUzuG1wmh08t3tQhBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dR4IYI/g3CK1WJtfoewMpDC7fViwqxuAGyvedGII6PY=; b=F
 8S9gMl2NW7WUzYhy2ISsUQk8Gsn1nRJtbCvtA1WO8bxnXGEdGCU5UhSlIt1asXPTKugPFlC0ZkHxj
 M/ODE9hrjSar1/9zKNPeLrvfrBbn6R0QpbcRoIat/rMR4SJTCdd3O445TKilKtBx/4u77lSo5xkoY
 0aKalQtTPC18N+EE=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxAS-0004BO-CF for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so36240065e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977342; x=1792582142; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dR4IYI/g3CK1WJtfoewMpDC7fViwqxuAGyvedGII6PY=;
 b=M/IfPHynbuYm+Kmi/7AAssQB+GwmOC5XQ/0tNUXcxhwlcukjkE32osJEC8J7Qs8oVj
 jvRQrP9vfK0wDgqUKHAKVJPNRQyFXKzHPBl/P+K+S31oXM0UUWInu0ybSrkUgjUut+a9
 JYT468TRWODm5UldvGCoQa5QRLodKrq+nR5gnei5TIWk2ioQxaqgI/nFeatIS1JbIF7O
 07GdmJ4CqoNHGfjoa13H3q+7DmMOQ2j5fOE75y/gXhFTJc8sMASbicT/Y4TGKeCmVcmg
 PNMLAo3yXDMaa12Eyfxro2gpgl/FO+StsVOWuRoWZshq0KH75A+L1XKhiNryRjp6jpsw
 vAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977342; x=1792582142;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dR4IYI/g3CK1WJtfoewMpDC7fViwqxuAGyvedGII6PY=;
 b=RxJny5+WianMRC5Brzl9eS1JRg+DOHtt2suIZ3zSHlUzT4wGaP3/JhuoIhRb9LZkM9
 eYi2gfkke/0gSqgyvM0yYp0o44YLB4S8mAji8TnubFPthD6N5Y1tdSTg04hOpVbXAQF0
 8Ya7y3hX2G/oRFTnDKkp4CORuGy/XwUBtryzmT9cYZphTzLhyKcRY0WGFKcR7Rfa5mCT
 z+hbNv3c1z/4P9g0Avly9ytxXDdGhH7F+N9W/Qqbc8gjG+2mLaLDgr7MQ40YKnhiXHm4
 QZutLy2W2wggg/0PezCN8737Fx66Qum77ou69Y5tiAuIulYa+4M5DlytmxuEpj37WRi4
 bHcA==
X-Gm-Message-State: AFq9FYLlEDZsKjbxVPxVSJDc/edHAS/ZanMXU5IlL1svC6PAlUN4G7/y
 8vsK9WRbFk0eLd/YXubG43ze2pM7ZXNvadKE2uKKUvYihpMNzgmQqrPNoKIoQKHThobpqj5wzHM
 GPxYZvUVpAEy3CCf3KlAsjVa5N5towAivCQYMLO3GZO6wXdXgXjSsQo1OxVj46r8DCI0Y1tuPzR
 HEfc1QRw==
X-Gm-Gg: AYBFou1T/8EQURmVmLOkCvkXj5jWYFV3o58WHpWXOKmpjnM9lrHg8gv9H2Bf7fJ962U
 PZPinpvN4MMZ0Oamv1uQFjTZqVn6qpWmCn8RI+EhurAUqdrJCYOnyUfxgKlev+4/c7ipGBHTN91
 5Xy72SJZZV2zy3sqlNpRKs5S4P1UTjFbIlFww6muj6J2D7fqeSgW9ZsHFsGXaqbua1UCd9+FMB9
 YWTfavlXYvHRyGGJGr5y7WYcpcVaoqCZd58BMga5UFioSLRzbAlFP3ilkwfPWJHsUL7ssQx8JCJ
 corTLuz5CwWr105T06Gowij2bIt90w/mXdz9dnpQ0rOgah9IwcI94Q3e1dQo2uA4Rgv6UhvHebr
 jbBl0eeUzWoIycVDid8I8RTC90975QMKNmLNEx4Ga9UAH9bO2/SS+JveWEAmlvbmPVSac69j/Dg
 +krx74C9CVryNuN7FCPs2iDkxC88BCnJ7CnjLUNy1QEpS1MLdj5oxWg6QH3BQ4s8a1Rr1RbE7Xn
 1676/U3o+Y8hFxIvC7iXb1RX/tiB6Wxk2T4+3C4w7pupCDH9dQzKcQvjtZ1/E/WwOSbeL0ockMt
 4z3RpyoZHMwtEzGaBJVzWZWsAWtZYXbUeuhKtYIgkS/lwU3Vj60pRRdCfEFP
X-Received: by 2002:a05:600c:e556:10b0:4a1:93fd:8f2 with SMTP id
 5b1f17b1804b1-4a193fd0a16mr169952105e9.6.1791977341518; 
 Wed, 14 Oct 2026 04:29:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd733fsm11446388f8f.58.2026.10.14.04.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:29:01 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:28:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
X-Gerrit-Change-Number: 1994
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1994?usp=email>
X-Gerrit-Commit: 62776994cb146315c7d1ee6a83edad3f0ff54ea4
In-Reply-To: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
References: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk5MDZiM2ZhZDVkNTIxZTFlNGIwZjE1YWZmNzYzY2Y0ZDRkOGJjMzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <466e09e46c8dda1046f581809bffed6562e3b318-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxAS-0004BO-CF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: compat: Add strlcpy
 and strlcat
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8654554120924177255=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8654554120924177255==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7lPKLnX2v+s="; charset=UTF-8

--7lPKLnX2v+s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1994?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: compat: Add strlcpy and strlcat
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

compat: Add strlcpy and strlcat=


Avaibable on most systems (Linux since
glibc 2=2E38), but not all=2E We a=
lready
have strncpynt, but switching to the
standard strlcpy makes the code=
 more
accessible for both humans and tools=2E

This commit only introduces =
the
possibility to use strlcpy in general
code (we already have one usage i=
n
BSD-specific code)=2E No users are
introduced, yet=2E

Change-Id: I906b3f=
ad5d521e1e4b0f15aff763cf4d4d8bc35e
Signed-off-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
M confi=
gure=2Eac
M src/compat/Makefile=2Eam
A src/compat/compat-strlcpy=2Ec
M src/=
compat/compat=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
7 files changed,=
 90 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/94/1994/2

diff --git a/CMakeLists=2Etxt b/CMak=
eLists=2Etxt
index bac4dd4=2E=2Eb286ee2 100644
--- a/CMakeLists=2Etxt
+++ b=
/CMakeLists=2Etxt
@@ -248,6 +248,7 @@
 
 check_symbol_exists(chsize io=2Eh =
HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT=
)
+check_symbol_exists(strlcpy string=2Eh HAVE_STRLCPY)
 check_symbol_exist=
s(strsep string=2Eh HAVE_STRSEP)
 check_symbol_exists(strtok_r string=2Eh H=
AVE_STRTOK_R)
 
@@ -431,6 +432,7 @@
     src/compat/compat-daemon=2Ec
     =
src/compat/compat-dirname=2Ec
     src/compat/compat-gettimeofday=2Ec
+    =
src/compat/compat-strlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/co=
mpat/compat-strtok_r=2Ec
     src/openvpn/argv=2Ec
@@ -764,6 +766,7 @@
    =
         src/openvpn/platform=2Ec
             src/openvpn/win32-util=2Ec
 =
            src/compat/compat-gettimeofday=2Ec
+            src/compat/comp=
at-strlcpy=2Ec
             src/compat/compat-strsep=2Ec
             src/c=
ompat/compat-strtok_r=2Ec
             )
diff --git a/config=2Eh=2Ecmake=2E=
in b/config=2Eh=2Ecmake=2Ein
index 8c3088e=2E=2E483de45 100644
--- a/config=
=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -267,6 +267,9 @@
 /* Def=
ine to 1 if you have the <string=2Eh> header file=2E */
 #define HAVE_STRIN=
G_H 1
 
+/* Define to 1 if you have the `strlcpy' function=2E */
+#cmakedef=
ine HAVE_STRLCPY
+
 /* Define to 1 if you have the `strsep' function=2E */
=
 #cmakedefine HAVE_STRSEP
 
diff --git a/configure=2Eac b/configure=2Eac
in=
dex 56109af=2E=2Ead3f8f1 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@=
@ -568,7 +568,7 @@
 	setgroups flock gettimeofday \
 	setsid chdir \
 	chsi=
ze ftruncate execve getpeereid basename dirname \
-	epoll_create strsep str=
tok_r \
+	epoll_create strlcpy strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff =
--git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam
index 22867b3=
=2E=2E8b1d44a 100644
--- a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefi=
le=2Eam
@@ -20,5 +20,6 @@
 	compat-basename=2Ec \
 	compat-gettimeofday=2Ec=
 \
 	compat-daemon=2Ec \
+	compat-strlcpy=2Ec \
 	compat-strsep=2Ec \
-	com=
pat-strtok_r=2Ec
\ No newline at end of file
+	compat-strtok_r=2Ec
diff --g=
it a/src/compat/compat-strlcpy=2Ec b/src/compat/compat-strlcpy=2Ec
new file=
 mode 100644
index 0000000=2E=2E8c1e80a
--- /dev/null
+++ b/src/compat/comp=
at-strlcpy=2Ec
@@ -0,0 +1,52 @@
+/*
+ *  OpenVPN -- An application to secur=
ely tunnel IP networks
+ *             over a single UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "=
config=2Eh"
+#endif
+
+#ifndef HAVE_STRLCPY
+#include <string=2Eh>
+
+size_=
t
+strlcpy(char *dest, const char *src, size_t maxlen)
+{
+    if (maxlen >=
 0)
+    {
+        strncpy(dest, src, maxlen - 1);
+        dest[maxlen - =
1] =3D 0;
+    }
+    return strlen(src);
+}
+
+size_t
+strlcat(char *dest,=
 const char *src, size_t maxlen)
+{
+    size_t dest_len =3D strnlen(dest, =
maxlen);
+    if (maxlen > dest_len)
+    {
+        strncat(dest, src, max=
len - dest_len - 1);
+    }
+    return dest_len + strlen(src);
+}
+
+#endi=
f /* ifndef HAVE_STRLCPY */
diff --git a/src/compat/compat=2Eh b/src/compat=
/compat=2Eh
index 9e6f95c=2E=2E4ee9141 100644
--- a/src/compat/compat=2Eh
+=
++ b/src/compat/compat=2Eh
@@ -56,6 +56,15 @@
 
 #endif
 
+#ifndef HAVE_STR=
LCPY
+size_t
+strlcpy(char *dest, const char *src, size_t maxlen);
+
+size_=
t
+strlcat(char *dest, const char *src, size_t maxlen);
+
+#endif
+
 #ifnde=
f HAVE_STRSEP
 char *strsep(char **stringp, const char *delim);
 
diff --gi=
t a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makef=
ile=2Eam
index 5430ecb=2E=2E38299f5 100644
--- a/tests/unit_tests/openvpn/M=
akefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -54,6 +54,7 @@=

 argv_testdriver_SOURCES =3D test_argv=2Ec \
 	mock_msg=2Ec mock_msg=2Eh t=
est_common=2Eh \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/compat/compat-=
strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
@@ -64,=
6 +65,7 @@
 buffer_testdriver_SOURCES =3D test_buffer=2Ec \
 	mock_msg=2Ec =
mock_msg=2Eh test_common=2Eh \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/=
compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	=
$(top_srcdir)/src/openvpn/platform=2Ec
 
@@ -74,6 +76,7 @@
 crypto_testdriv=
er_SOURCES =3D test_crypto=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=2E=
h \
 	siphash_openssl=2Ec siphash_openssl=2Eh \
+	$(top_srcdir)/src/compat/=
compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdi=
r)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec =
\
@@ -94,6 +97,7 @@
 dhcp_testdriver_SOURCES =3D test_dhcp=2Ec \
 	mock_msg=
=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_get_random=2Ec \
+	$(top_srcdir)=
/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \=

 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/win32=
-util=2Ec
@@ -106,6 +110,7 @@
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \=

 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec =
\
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openv=
pn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/=
openvpn/buffer=2Ec \
@@ -145,6 +150,7 @@
 packet_id_testdriver_SOURCES =3D =
test_packet_id=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_g=
et_random=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_src=
dir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(t=
op_srcdir)/src/openvpn/packet_id=2Ec \
@@ -158,6 +164,7 @@
 	@TEST_CFLAGS@
=
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 pkt_testdriver_SOURCES =3D test=
_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \
=
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn=
/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/op=
envpn/buffer=2Ec \
@@ -190,6 +197,7 @@
 tls_crypt_testdriver_SOURCES =3D te=
st_tls_crypt=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_win=
32_execve=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_src=
dir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(to=
p_srcdir)/src/openvpn/buffer=2Ec \
@@ -212,6 +220,7 @@
 networking_testdriv=
er_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CR=
YPTO_LIBS)
 networking_testdriver_SOURCES =3D test_networking=2Ec mock_msg=
=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/=
openvpn/networking_sitnl=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$=
(top_srcdir)/src/openvpn/crypto=2Ec \
@@ -230,6 +239,7 @@
 options_parse_te=
stdriver_SOURCES =3D test_options_parse=2Ec \
 	mock_msg=2Ec mock_msg=2Eh t=
est_common=2Eh \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/compat/compat-=
strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/options_parse=2Ec \
 	$(top_srcdi=
r)/src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
=
@@ -243,6 +253,7 @@
 	$(OPTIONAL_CRYPTO_LIBS)
 
 provider_testdriver_SOURCE=
S =3D test_provider=2Ec mock_msg=2Ec \
+	$(top_srcdir)/src/compat/compat-st=
rlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/xkey_helper=2Ec \
 	$(top_srcdir)/s=
rc/openvpn/xkey_provider=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ =
-259,6 +270,7 @@
 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_te=
stdriver_SOURCES =3D test_cryptoapi=2Ec mock_msg=2Ec \
 	pkey_test_utils=2E=
c cert_data=2Eh \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_s=
rcdir)/src/openvpn/xkey_helper=2Ec \
 	$(top_srcdir)/src/openvpn/xkey_provi=
der=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -278,6 +290,7 @@
 pkc=
s11_testdriver_SOURCES =3D test_pkcs11=2Ec \
 	mock_msg=2Ec test_common=2Eh=
 \
 	pkey_test_utils=2Ec cert_data=2Eh mock_get_random=2Ec \
+	$(top_srcdir=
)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/xkey_helper=
=2Ec \
 	$(top_srcdir)/src/openvpn/xkey_provider=2Ec \
 	$(top_srcdir)/src/=
openvpn/argv=2Ec \
@@ -300,6 +313,7 @@
 
 auth_token_testdriver_SOURCES =3D=
 test_auth_token=2Ec \
 	mock_msg=2Ec test_common=2Eh \
+	$(top_srcdir)/src=
/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(t=
op_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoc=
h=2Ec \
@@ -320,6 +334,7 @@
 
 user_pass_testdriver_SOURCES =3D test_user_p=
ass=2Ec \
 	mock_msg=2Ec test_common=2Eh \
+	$(top_srcdir)/src/compat/compa=
t-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/console=2Ec \
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
@@ -339,6=
 +354,7 @@
 
 ncp_testdriver_SOURCES =3D test_ncp=2Ec \
 	mock_msg=2Ec test=
_common=2Eh \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdi=
r)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(to=
p_srcdir)/src/openvpn/crypto_epoch=2Ec \
@@ -362,6 +378,7 @@
 mbuf_testdriv=
er_SOURCES =3D test_mbuf=2Ec \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get=
_random=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdi=
r)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	=
$(top_srcdir)/src/openvpn/platform=2Ec \
@@ -377,6 +394,7 @@
 	test_schedul=
e=2Ec test_schedule=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_rand=
om=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(t=
op_srcdir)/src/openvpn/ssl_util=2Ec \
@@ -402,6 +420,7 @@
 	mock_msg=2Ec \
=
 	mock_get_random=2Ec \
 	mock_push_dependencies=2Ec \
+	$(top_srcdir)/src/=
compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(to=
p_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/options_ut=
il=2Ec \
@@ -419,6 +438,7 @@
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_r=
andom=2Ec \
 	mock_management=2Ec \
+	$(top_srcdir)/src/compat/compat-strlc=
py=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openv=
pn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I906b3fad5d521e1e4b0f15af=
f763cf4d4d8bc35e
Gerrit-Change-Number: 1994
Gerrit-PatchSet: 2
Gerrit-Owner=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--7lPKLnX2v+s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">compat: Add strlcpy and strlcat<br><br>Avaibable on most systems (Li=
nux since<br>glibc 2=2E38), but not all=2E We already<br>have strncpynt, bu=
t switching to the<br>standard strlcpy makes the code more<br>accessible fo=
r both humans and tools=2E<br><br>This commit only introduces the<br>possib=
ility to use strlcpy in general<br>code (we already have one usage in<br>BS=
D-specific code)=2E No users are<br>introduced, yet=2E<br><br>Change-Id: I9=
06b3fad5d521e1e4b0f15aff763cf4d4d8bc35e<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M config=
=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/compat/Makefile=2Eam<br>A sr=
c/compat/compat-strlcpy=2Ec<br>M src/compat/compat=2Eh<br>M tests/unit_test=
s/openvpn/Makefile=2Eam<br>7 files changed, 90 insertions(+), 2 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/94/1994/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeL=
ists=2Etxt</span><br><span>index bac4dd4=2E=2Eb286ee2 100644</span><br><spa=
n>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><=
span>@@ -248,6 +248,7 @@</span><br><span> </span><br><span> check_symbol_ex=
ists(chsize io=2Eh HAVE_CHSIZE)</span><br><span> check_symbol_exists(getrli=
mit sys/resource=2Eh HAVE_GETRLIMIT)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+check_symbol_exists(strlcpy string=2Eh HAVE_STRLCPY)</span=
><br><span> check_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><s=
pan> check_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)</span><br><span=
> </span><br><span>@@ -431,6 +432,7 @@</span><br><span>     src/compat/comp=
at-daemon=2Ec</span><br><span>     src/compat/compat-dirname=2Ec</span><br>=
<span>     src/compat/compat-gettimeofday=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    src/compat/compat-strlcpy=2Ec</span><br><span=
>     src/compat/compat-strsep=2Ec</span><br><span>     src/compat/compat-s=
trtok_r=2Ec</span><br><span>     src/openvpn/argv=2Ec</span><br><span>@@ -7=
64,6 +766,7 @@</span><br><span>             src/openvpn/platform=2Ec</span>=
<br><span>             src/openvpn/win32-util=2Ec</span><br><span>         =
    src/compat/compat-gettimeofday=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            src/compat/compat-strlcpy=2Ec</span><br><spa=
n>             src/compat/compat-strsep=2Ec</span><br><span>             sr=
c/compat/compat-strtok_r=2Ec</span><br><span>             )</span><br><span=
>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><=
span>index 8c3088e=2E=2E483de45 100644</span><br><span>--- a/config=2Eh=2Ec=
make=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ =
-267,6 +267,9 @@</span><br><span> /* Define to 1 if you have the &lt;string=
=2Eh&gt; header file=2E */</span><br><span> #define HAVE_STRING_H 1</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define=
 to 1 if you have the `strlcpy&#39; function=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_STRLCPY</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Define to 1 if yo=
u have the `strsep&#39; function=2E */</span><br><span> #cmakedefine HAVE_S=
TRSEP</span><br><span> </span><br><span>diff --git a/configure=2Eac b/confi=
gure=2Eac</span><br><span>index 56109af=2E=2Ead3f8f1 100644</span><br><span=
>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>=
@@ -568,7 +568,7 @@</span><br><span> 	setgroups flock gettimeofday \</span>=
<br><span> 	setsid chdir \</span><br><span> 	chsize ftruncate execve getpee=
reid basename dirname \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	epoll_create strsep strtok_r \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	epoll_create strlcpy strsep strtok_r \</span><br><span> ])</=
span><br><span> </span><br><span> AC_CHECK_LIB(</span><br><span>diff --git =
a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam</span><br><span>index=
 22867b3=2E=2E8b1d44a 100644</span><br><span>--- a/src/compat/Makefile=2Eam=
</span><br><span>+++ b/src/compat/Makefile=2Eam</span><br><span>@@ -20,5 +2=
0,6 @@</span><br><span> 	compat-basename=2Ec \</span><br><span> 	compat-get=
timeofday=2Ec \</span><br><span> 	compat-daemon=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	compat-strlcpy=2Ec \</span><br><span> 	c=
ompat-strsep=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	co=
mpat-strtok_r=2Ec</span><br><span>\ No newline at end of file</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	compat-strtok_r=2Ec</span><br><s=
pan>diff --git a/src/compat/compat-strlcpy=2Ec b/src/compat/compat-strlcpy=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E8c1e80a</span><br><span>--- /dev/null</span><br><span>+++ b/src/compat/c=
ompat-strlcpy=2Ec</span><br><span>@@ -0,0 +1,52 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single UDP port, with support for SSL/TLS-based</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             session authentication and key=
 exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
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
: hsl(120, 100%, 40%);">+#ifndef HAVE_STRLCPY</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+strlcpy(char *dest, const char *src, size_t maxlen)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (maxlen &gt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        strncpy(dest, src, maxlen - 1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        dest[maxlen - 1] =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return strlen(src);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+strlcat(char *dest, con=
st char *src, size_t maxlen)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t dest_len =3D strnlen(dest, maxlen);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (maxlen &gt; dest_len)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        strncat(dest, src, maxlen - dest_len - 1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return dest_len + strlen(src);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif /* ifndef HAVE_STRLCPY */</span><br><span>diff --git a/src/=
compat/compat=2Eh b/src/compat/compat=2Eh</span><br><span>index 9e6f95c=2E=
=2E4ee9141 100644</span><br><span>--- a/src/compat/compat=2Eh</span><br><sp=
an>+++ b/src/compat/compat=2Eh</span><br><span>@@ -56,6 +56,15 @@</span><br=
><span> </span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifndef HAVE_STRLCPY</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+strlcpy(char *dest, const char *src, size_t maxlen);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+strlcat(char *dest, const char *src, size_t maxlen);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> #ifndef HAVE_STRSEP</span><br><spa=
n> char *strsep(char **stringp, const char *delim);</span><br><span> </span=
><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit=
_tests/openvpn/Makefile=2Eam</span><br><span>index 5430ecb=2E=2E38299f5 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br>=
<span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -54,6=
 +54,7 @@</span><br><span> argv_testdriver_SOURCES =3D test_argv=2Ec \</spa=
n><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> =
	mock_get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec =
\</span><br><span>@@ -64,6 +65,7 @@</span><br><span> buffer_testdriver_SOUR=
CES =3D test_buffer=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_=
common=2Eh \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec</span><br><span> </span><=
br><span>@@ -74,6 +76,7 @@</span><br><span> crypto_testdriver_SOURCES =3D t=
est_crypto=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2E=
h \</span><br><span> 	siphash_openssl=2Ec siphash_openssl=2Eh \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compa=
t-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span>@@ -94,6 +97,7=
 @@</span><br><span> dhcp_testdriver_SOURCES =3D test_dhcp=2Ec \</span><br>=
<span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_=
get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buf=
fer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec</span>=
<br><span>@@ -106,6 +110,7 @@</span><br><span> 	mock_msg=2Ec mock_msg=2Eh t=
est_common=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><span> 	=
mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec =
\</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/buffer=2Ec \</span><br><span>@@ -145,6 +150,7 @@</span><br><span> p=
acket_id_testdriver_SOURCES =3D test_packet_id=2Ec \</span><br><span> 	mock=
_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_get_random=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/packet_id=2Ec \</span><br><span>@@=
 -158,6 +164,7 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> pkt_test=
driver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> pkt_testdriver_SOURCES =
=3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_commo=
n=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdi=
r)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -1=
90,6 +197,7 @@</span><br><span> tls_crypt_testdriver_SOURCES =3D test_tls_c=
rypt=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</s=
pan><br><span> 	mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/bu=
ffer=2Ec \</span><br><span>@@ -212,6 +220,7 @@</span><br><span> networking_=
testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \</span><=
br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> networking_testdriver_S=
OURCES =3D test_networking=2Ec mock_msg=2Ec \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/networking_sitnl=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/crypto=2Ec \</span><br><span>@@ -230,6 +239,7 @@</span><br>=
<span> options_parse_testdriver_SOURCES =3D test_options_parse=2Ec \</span>=
<br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	m=
ock_get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/options_parse=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span>@@ -243,6 +253,7 @@</span><br><span> 	$(OPTIONAL_CRY=
PTO_LIBS)</span><br><span> </span><br><span> provider_testdriver_SOURCES =
=3D test_provider=2Ec mock_msg=2Ec \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/xkey_helper=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/xkey_provider=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/buffer=2Ec \</span><br><span>@@ -259,6 +270,7 @@</span><br><span> =
	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt</span><br><span> cryptoapi_test=
driver_SOURCES =3D test_cryptoapi=2Ec mock_msg=2Ec \</span><br><span> 	pkey=
_test_utils=2Ec cert_data=2Eh \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/xkey_helper=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/xkey_provider=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/buffer=2Ec \</span><br><span>@@ -278,6 +290,7 @@</span><br><span> pkcs1=
1_testdriver_SOURCES =3D test_pkcs11=2Ec \</span><br><span> 	mock_msg=2Ec t=
est_common=2Eh \</span><br><span> 	pkey_test_utils=2Ec cert_data=2Eh mock_g=
et_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/xkey_helper=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/x=
key_provider=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</=
span><br><span>@@ -300,6 +313,7 @@</span><br><span> </span><br><span> auth_=
token_testdriver_SOURCES =3D test_auth_token=2Ec \</span><br><span> 	mock_m=
sg=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2E=
c \</span><br><span>@@ -320,6 +334,7 @@</span><br><span> </span><br><span> =
user_pass_testdriver_SOURCES =3D test_user_pass=2Ec \</span><br><span> 	moc=
k_msg=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/console=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set=2Ec=
 \</span><br><span>@@ -339,6 +354,7 @@</span><br><span> </span><br><span> n=
cp_testdriver_SOURCES =3D test_ncp=2Ec \</span><br><span> 	mock_msg=2Ec tes=
t_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(to=
p_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span=
><br><span>@@ -362,6 +378,7 @@</span><br><span> mbuf_testdriver_SOURCES =3D=
 test_mbuf=2Ec \</span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><b=
r><span> 	mock_get_random=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/plat=
form=2Ec \</span><br><span>@@ -377,6 +394,7 @@</span><br><span> 	test_sched=
ule=2Ec test_schedule=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2Eh =
 \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/ssl_util=2Ec \</span><br><span>@@ -402,6 +420,7 @@</span><br><span=
> 	mock_msg=2Ec \</span><br><span> 	mock_get_random=2Ec \</span><br><span> =
	mock_push_dependencies=2Ec \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_=
util=2Ec \</span><br><span>@@ -419,6 +438,7 @@</span><br><span> 	mock_msg=
=2Ec test_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><=
span> 	mock_management=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platfor=
m=2Ec \</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1994?usp=3Demail">change 1994</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I906b3fad5d521e1e4b0f15=
aff763cf4d4d8bc35e </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1994 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--7lPKLnX2v+s=--


--===============8654554120924177255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8654554120924177255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8654554120924177255==--

