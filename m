Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E866BCCA464
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3zdVVui3ENu4JAF00DbFZJrxxckArUVJuBPybEXNb5o=; b=jVZM0gJ/WAHCN6Jo/EiqlFWxzs
	wN0j5BRRZveiWn9DP0czL+wNFOki7gmmJ1yysBoXvdCS4Dr23kXoEHCucNPVyQ/h8TzEiNBGhCG2f
	yjoQ8QZOpM0b493jI8hW4ap1NLZXB8XgITVBmehbijrVNNFPDsVOA1NRtMASsbvk808o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHgFp-0001yG-Om;
	Fri, 16 Oct 2026 11:37:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHgFp-0001wo-13
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 11:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=aIJAHG71HsJqhyWkc9VffXNrbROLfcdOd9LK7Bz/dtk=; b=ESAWg31tMCAz8hy+FEA+cYP7L9
 UwGCQIEGnoRUqDwJjlwltnRsxMAkTVhKCgShSh5Wq/hyWlw3RqnnpTKHaotUBi+b2JHuxk7aXh85f
 JzL5fenJz7RYAi+kiGIPJWfG00KxA9Y0Q2xXuACCFUyBl45LGO+6Cjgk8VsOI1/5fTq8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aIJAHG71HsJqhyWkc9VffXNrbROLfcdOd9LK7Bz/dtk=; b=f
 Hisiqt2HQDw4J6bBI4knHWrWnkfbatEFMuzHvIdSyJd85qqGnb6FSnVOLXhdJ/TqJ5FE6QGlm6g6n
 0g2+cHFmHvnWFFGSjGP0wKHftVdi5j5OqokkhJWnH8G3ort0ARdLe6qiNgxG+R2Xg2VX2CP3saMvU
 rFwkawGEzhCymluM=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHgFV-0004QY-4o for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 11:37:24 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a16c399641so60944595e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792150635; x=1792755435; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aIJAHG71HsJqhyWkc9VffXNrbROLfcdOd9LK7Bz/dtk=;
 b=IpHUODsg+rGWtuOkxjNxAH+teBR2aHXte37oqpWnYv49q7wVc/hyTEix+Y7nLs0gFU
 txxJUgQGMeFeRinpjxd34+IzLO6aD8D5jo9BhZNmEeWMcydliJ+C/KjyOHsvgXaT8dgx
 feYAz9Nid6rqOJwTpoR/GRS/BZXS7+9BGsQhVW3tMWoQGJQuOQ9lXpMxjICcueUHV7fO
 Y063KhoLWRu+6ctkl5M6VL7mMySLTmuIrErZHSqo1TWzDeOaboBJe0V+cv5yl+yrFNdC
 +Qhx8UG0ANP77prcfJIj7TKLCRBUGsoZs2VQiArgfduPQS3jvOOD9zGptqewcegbFtuR
 1WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792150635; x=1792755435;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aIJAHG71HsJqhyWkc9VffXNrbROLfcdOd9LK7Bz/dtk=;
 b=o4kLhnDgfmghZFeGdUNSTZc8gDSTe328RZq03WABTQjGmrEshqY0sz7vZsarBtaU26
 8rPKzpTkPiL3ez7ShRK8Kq5VOSWz1bXaeO/Iqn1fGRAVS35l3QmmUn7ekjIU4H6YPBqr
 TRZOY2bvnOkvembpQ2DpxFdsdsyZ9H+4mm9adJy1sC5XnXbeQ3Aut5F4u1BstiIPH3Pe
 n6nuFZgTbcL9MCIBmw2+HJziU2eEuAd80E4Y+1AhPHSiUHWkmMJwtuleOH+f3jWm4HIn
 S/001HvMSYfjN3xzbzKIpid4FRev0BtHT3zk+NotjCIZ0ebTtppuED9i4cGlz1StX4Gq
 7u9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaJBjAUav/wLwe2OYjx4ZMcn0c7RtJxLmYrnqglmCnjn0kOi7zs4izxMpyoJKYKv88TOgKW/sD1GeT5Uca@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLGnevzAp7qPmkn3kx48VC6Ge/eaOqme5UDH88s8QojP/W0SeDL
 dACSEC222/7BgJ+DYjBVyqqAimfT73cYplEyJekGtyqeNiHkgtimddKq5W6eLaUAwyu2HQzT8Zd
 SZHMbjlxmizbYdvyQMhIvFZCcjADGZU+A3MBtI0Zmjosl3H0jRu3vab5Nq/Fd2KNMUudb
X-Gm-Gg: AYBFou2DlKYkhT4TOxTKmBlDG+ZxuN74WRzEU6n9/3tx4DRVIiK1iKilFWd5EcD8zGG
 74ND/Yvzxo9yALoyj03MrR8WJViofCCR6A5ibq8uxMZXFstLOmFlOx2yxTzZprJXuTmmTHrJxDz
 V+cwAy2jMC/yWBlm+KdJXUpDo/dCZPhmcx9ohEaUP74NWgT5h8BQ8ds3obGa93FbBeJGt0Y0oYG
 sVmpwfQL3m/u61ozXpIBE1I4O/HOGA7dmFRNKv76gIhwJot8FAEfDHp2kw4c8zQYYuCDytnjCpN
 fp7BP+Qih5WFuSoNs7Xo8UcWH+ee155dvLcDXhKBIc+9OLkY0cgpx5rWCg4UXh7RweRziJTYLci
 /8GqO1qvr8iaoMJUts5f3Uw9PDdJsBF5mMSBHWhGLib5GRA2HKLQfMVTfl3mhGgVCFABY3ZyTRC
 5iAH9ayvxP3hYNZHBbAGCDo69aC+igmn+bEy6Kq8C47HJhBR7HtBIp1EZR4hH3+RVmShTO6JdA/
 +ltJkJxJU+Pzskj8NiNI5SMmQDQMoamUv4jBFC5oZhP5g+9kM7L1CevYrkg+94zLRPDuHysu9p+
 08n5f7zd+YD22ZnY/BKMQc5ZqVGcwlQUcQqwuUD2T//vT+wob7lpdlXkHsXl
X-Received: by 2002:a05:600d:82c6:b0:4a1:d41a:afc2 with SMTP id
 5b1f17b1804b1-4a1d41ab12dmr7921765e9.3.1792150634392; 
 Fri, 16 Oct 2026 04:37:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ec8dfsm4793464f8f.26.2026.10.16.04.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 04:37:13 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 11:37:13 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
X-Gerrit-Change-Number: 1994
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1994?usp=email>
X-Gerrit-Commit: f659b6ecffccdca4469c2a20a819d7a29fc3c7c0
In-Reply-To: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
References: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk5MDZiM2ZhZDVkNTIxZTFlNGIwZjE1YWZmNzYzY2Y0ZDRkOGJjMzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e8365c0629a8e3c16d22328188d74e6baceb57e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHgFV-0004QY-4o
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5979626389552809624=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5979626389552809624==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D5VveuIa900="; charset=UTF-8

--D5VveuIa900=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1994?usp=3Demail )

Change subject: compat: Add strlcpy and str=
lcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

compat:=
 Add strlcpy and strlcat

Available on most systems (Linux since glibc 2=2E=
38), but not all=2E
We already have strncpynt, but switching to the standar=
d strlcpy
makes the code more accessible for both humans and tools=2E

This=
 commit only introduces the possibility to use strlcpy in general
code (we =
already have one usage in BSD-specific code)=2E No users are
introduced, ye=
t=2E

Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
Signed-off-by: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
94
Message-Id: <20261016085833=2E27514-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg399=
16=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMake=
Lists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M src/compat/Makefil=
e=2Eam
A src/compat/compat-strlcpy=2Ec
M src/compat/compat=2Eh
M tests/unit=
_tests/openvpn/Makefile=2Eam
7 files changed, 90 insertions(+), 2 deletions=
(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index bac4dd4=2E=
=2Eb286ee2 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -248,6 +=
248,7 @@
 
 check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)
 check_symbol_ex=
ists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)
+check_symbol_exists(strlcp=
y string=2Eh HAVE_STRLCPY)
 check_symbol_exists(strsep string=2Eh HAVE_STRS=
EP)
 check_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)
 
@@ -431,6 +43=
2,7 @@
     src/compat/compat-daemon=2Ec
     src/compat/compat-dirname=2Ec=

     src/compat/compat-gettimeofday=2Ec
+    src/compat/compat-strlcpy=2Ec=

     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec
    =
 src/openvpn/argv=2Ec
@@ -764,6 +766,7 @@
             src/openvpn/platform=
=2Ec
             src/openvpn/win32-util=2Ec
             src/compat/compat=
-gettimeofday=2Ec
+            src/compat/compat-strlcpy=2Ec
             s=
rc/compat/compat-strsep=2Ec
             src/compat/compat-strtok_r=2Ec
   =
          )
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
=
index 8c3088e=2E=2E483de45 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/confi=
g=2Eh=2Ecmake=2Ein
@@ -267,6 +267,9 @@
 /* Define to 1 if you have the <str=
ing=2Eh> header file=2E */
 #define HAVE_STRING_H 1
 
+/* Define to 1 if yo=
u have the `strlcpy' function=2E */
+#cmakedefine HAVE_STRLCPY
+
 /* Define=
 to 1 if you have the `strsep' function=2E */
 #cmakedefine HAVE_STRSEP
 
d=
iff --git a/configure=2Eac b/configure=2Eac
index 56109af=2E=2Ead3f8f1 1006=
44
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -568,7 +568,7 @@
 	setgroup=
s flock gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeerei=
d basename dirname \
-	epoll_create strsep strtok_r \
+	epoll_create strlcp=
y strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff --git a/src/compat/Makefile=
=2Eam b/src/compat/Makefile=2Eam
index 22867b3=2E=2E8b1d44a 100644
--- a/sr=
c/compat/Makefile=2Eam
+++ b/src/compat/Makefile=2Eam
@@ -20,5 +20,6 @@
 	c=
ompat-basename=2Ec \
 	compat-gettimeofday=2Ec \
 	compat-daemon=2Ec \
+	co=
mpat-strlcpy=2Ec \
 	compat-strsep=2Ec \
-	compat-strtok_r=2Ec
\ No newline=
 at end of file
+	compat-strtok_r=2Ec
diff --git a/src/compat/compat-strlcp=
y=2Ec b/src/compat/compat-strlcpy=2Ec
new file mode 100644
index 0000000=2E=
=2E8c1e80a
--- /dev/null
+++ b/src/compat/compat-strlcpy=2Ec
@@ -0,0 +1,52 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single UDP port, with support for SSL/TLS-based
+ *       =
      session authentication and key exchange,
+ *             packet encry=
ption, packet authentication, and
+ *             packet compression=2E
+ *=

+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  Th=
is program is free software; you can redistribute it and/or modify
+ *  it =
under the terms of the GNU General Public License version 2
+ *  as publish=
ed by the Free Software Foundation=2E
+ *
+ *  This program is distributed =
in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
=
+ *
+ *  You should have received a copy of the GNU General Public License =
along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses=
/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifnde=
f HAVE_STRLCPY
+#include <string=2Eh>
+
+size_t
+strlcpy(char *dest, const =
char *src, size_t maxlen)
+{
+    if (maxlen > 0)
+    {
+        strncpy(d=
est, src, maxlen - 1);
+        dest[maxlen - 1] =3D 0;
+    }
+    return =
strlen(src);
+}
+
+size_t
+strlcat(char *dest, const char *src, size_t maxl=
en)
+{
+    size_t dest_len =3D strnlen(dest, maxlen);
+    if (maxlen > de=
st_len)
+    {
+        strncat(dest, src, maxlen - dest_len - 1);
+    }
+=
    return dest_len + strlen(src);
+}
+
+#endif /* ifndef HAVE_STRLCPY */
d=
iff --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh
index 9e6f95c=2E=
=2E4ee9141 100644
--- a/src/compat/compat=2Eh
+++ b/src/compat/compat=2Eh
@=
@ -56,6 +56,15 @@
 
 #endif
 
+#ifndef HAVE_STRLCPY
+size_t
+strlcpy(char *=
dest, const char *src, size_t maxlen);
+
+size_t
+strlcat(char *dest, const=
 char *src, size_t maxlen);
+
+#endif
+
 #ifndef HAVE_STRSEP
 char *strsep(=
char **stringp, const char *delim);
 
diff --git a/tests/unit_tests/openvpn=
/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5430ecb=2E=2E=
38299f5 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam
@@ -54,6 +54,7 @@
 argv_testdriver_SOURCES =
=3D test_argv=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_ge=
t_random=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcd=
ir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$=
(top_srcdir)/src/openvpn/win32-util=2Ec \
@@ -64,6 +65,7 @@
 buffer_testdri=
ver_SOURCES =3D test_buffer=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=
=2Eh \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2E=
c \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvp=
n/platform=2Ec
 
@@ -74,6 +76,7 @@
 crypto_testdriver_SOURCES =3D test_cryp=
to=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	siphash_openssl=2E=
c siphash_openssl=2Eh \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$=
(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2E=
c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
@@ -94,6 +97,7 @@
 dhc=
p_testdriver_SOURCES =3D test_dhcp=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_c=
ommon=2Eh \
 	mock_get_random=2Ec \
+	$(top_srcdir)/src/compat/compat-strlc=
py=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec
@@ -106,6 +110=
,7 @@
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_management=2Ec \=

 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
+	$(top_srcdir)/src/co=
mpat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_sr=
cdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ =
-145,6 +150,7 @@
 packet_id_testdriver_SOURCES =3D test_packet_id=2Ec \
 	m=
ock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_get_random=2Ec \
+	$(top_=
srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/=
packet_id=2Ec \
@@ -158,6 +164,7 @@
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS=
 =3D @TEST_LDFLAGS@
 pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec m=
ock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \
+	$(top_srcdir)/src/com=
pat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_src=
dir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -=
190,6 +197,7 @@
 tls_crypt_testdriver_SOURCES =3D test_tls_crypt=2Ec \
 	mo=
ck_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_win32_execve=2Ec \
+	$(top=
_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=
=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn=
/buffer=2Ec \
@@ -212,6 +220,7 @@
 networking_testdriver_LDFLAGS =3D @TEST_=
LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networkin=
g_testdriver_SOURCES =3D test_networking=2Ec mock_msg=2Ec \
+	$(top_srcdir)=
/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/networking_sit=
nl=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openv=
pn/crypto=2Ec \
@@ -230,6 +239,7 @@
 options_parse_testdriver_SOURCES =3D t=
est_options_parse=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	moc=
k_get_random=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_=
srcdir)/src/openvpn/options_parse=2Ec \
 	$(top_srcdir)/src/openvpn/options=
_util=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -243,6 +253,7 @@
 	=
$(OPTIONAL_CRYPTO_LIBS)
 
 provider_testdriver_SOURCES =3D test_provider=2E=
c mock_msg=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_sr=
cdir)/src/openvpn/xkey_helper=2Ec \
 	$(top_srcdir)/src/openvpn/xkey_provid=
er=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -259,6 +270,7 @@
 	$(O=
PTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt
 cryptoapi_testdriver_SOURCES =3D t=
est_cryptoapi=2Ec mock_msg=2Ec \
 	pkey_test_utils=2Ec cert_data=2Eh \
+	$(=
top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/xke=
y_helper=2Ec \
 	$(top_srcdir)/src/openvpn/xkey_provider=2Ec \
 	$(top_srcd=
ir)/src/openvpn/buffer=2Ec \
@@ -278,6 +290,7 @@
 pkcs11_testdriver_SOURCES=
 =3D test_pkcs11=2Ec \
 	mock_msg=2Ec test_common=2Eh \
 	pkey_test_utils=
=2Ec cert_data=2Eh mock_get_random=2Ec \
+	$(top_srcdir)/src/compat/compat-=
strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/xkey_helper=2Ec \
 	$(top_srcdir)=
/src/openvpn/xkey_provider=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
@@ =
-300,6 +313,7 @@
 
 auth_token_testdriver_SOURCES =3D test_auth_token=2Ec \=

 	mock_msg=2Ec test_common=2Eh \
+	$(top_srcdir)/src/compat/compat-strlcpy=
=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn=
/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
@@ -320,6 +334=
,7 @@
 
 user_pass_testdriver_SOURCES =3D test_user_pass=2Ec \
 	mock_msg=
=2Ec test_common=2Eh \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(=
top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/console=2E=
c \
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
@@ -339,6 +354,7 @@
 
 ncp_te=
stdriver_SOURCES =3D test_ncp=2Ec \
 	mock_msg=2Ec test_common=2Eh \
+	$(to=
p_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffe=
r=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvp=
n/crypto_epoch=2Ec \
@@ -362,6 +378,7 @@
 mbuf_testdriver_SOURCES =3D test_=
mbuf=2Ec \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
+	$(to=
p_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffe=
r=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/op=
envpn/platform=2Ec \
@@ -377,6 +394,7 @@
 	test_schedule=2Ec test_schedule=
=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
+	$(top_sr=
cdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2E=
c \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
 	$(top_srcdir)/src/open=
vpn/ssl_util=2Ec \
@@ -402,6 +420,7 @@
 	mock_msg=2Ec \
 	mock_get_random=
=2Ec \
 	mock_push_dependencies=2Ec \
+	$(top_srcdir)/src/compat/compat-str=
lcpy=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
@@ -419,=
6 +438,7 @@
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
 	moc=
k_management=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_=
srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec=
 \
 	$(top_srcdir)/src/openvpn/platform=2Ec \

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
Gerrit-=
Change-Number: 1994
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--D5VveuIa900=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1994?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">compat: Add strlcpy and strlcat<br=
><br>Available on most systems (Linux since glibc 2=2E38), but not all=2E<b=
r>We already have strncpynt, but switching to the standard strlcpy<br>makes=
 the code more accessible for both humans and tools=2E<br><br>This commit o=
nly introduces the possibility to use strlcpy in general<br>code (we alread=
y have one usage in BSD-specific code)=2E No users are<br>introduced, yet=
=2E<br><br>Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1994<br>Message-Id: &lt;20261016085833=2E27514-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg39916=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M confi=
g=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M src/compat/Makefile=2Eam<br>A s=
rc/compat/compat-strlcpy=2Ec<br>M src/compat/compat=2Eh<br>M tests/unit_tes=
ts/openvpn/Makefile=2Eam<br>7 files changed, 90 insertions(+), 2 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span>=
<br><span>index bac4dd4=2E=2Eb286ee2 100644</span><br><span>--- a/CMakeList=
s=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -248,6 +2=
48,7 @@</span><br><span> </span><br><span> check_symbol_exists(chsize io=2E=
h HAVE_CHSIZE)</span><br><span> check_symbol_exists(getrlimit sys/resource=
=2Eh HAVE_GETRLIMIT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+check_symbol_exists(strlcpy string=2Eh HAVE_STRLCPY)</span><br><span> chec=
k_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><span> check_symbo=
l_exists(strtok_r string=2Eh HAVE_STRTOK_R)</span><br><span> </span><br><sp=
an>@@ -431,6 +432,7 @@</span><br><span>     src/compat/compat-daemon=2Ec</s=
pan><br><span>     src/compat/compat-dirname=2Ec</span><br><span>     src/c=
ompat/compat-gettimeofday=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    src/compat/compat-strlcpy=2Ec</span><br><span>     src/compat=
/compat-strsep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</spa=
n><br><span>     src/openvpn/argv=2Ec</span><br><span>@@ -764,6 +766,7 @@</=
span><br><span>             src/openvpn/platform=2Ec</span><br><span>      =
       src/openvpn/win32-util=2Ec</span><br><span>             src/compat/c=
ompat-gettimeofday=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            src/compat/compat-strlcpy=2Ec</span><br><span>             s=
rc/compat/compat-strsep=2Ec</span><br><span>             src/compat/compat-=
strtok_r=2Ec</span><br><span>             )</span><br><span>diff --git a/co=
nfig=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index 8c308=
8e=2E=2E483de45 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span>=
<br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -267,6 +267,9 @@=
</span><br><span> /* Define to 1 if you have the &lt;string=2Eh&gt; header =
file=2E */</span><br><span> #define HAVE_STRING_H 1</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you hav=
e the `strlcpy&#39; function=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#cmakedefine HAVE_STRLCPY</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /* Define to 1 if you have the `strs=
ep&#39; function=2E */</span><br><span> #cmakedefine HAVE_STRSEP</span><br>=
<span> </span><br><span>diff --git a/configure=2Eac b/configure=2Eac</span>=
<br><span>index 56109af=2E=2Ead3f8f1 100644</span><br><span>--- a/configure=
=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -568,7 +568,7=
 @@</span><br><span> 	setgroups flock gettimeofday \</span><br><span> 	sets=
id chdir \</span><br><span> 	chsize ftruncate execve getpeereid basename di=
rname \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	epoll_create =
strsep strtok_r \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	e=
poll_create strlcpy strsep strtok_r \</span><br><span> ])</span><br><span> =
</span><br><span> AC_CHECK_LIB(</span><br><span>diff --git a/src/compat/Mak=
efile=2Eam b/src/compat/Makefile=2Eam</span><br><span>index 22867b3=2E=2E8b=
1d44a 100644</span><br><span>--- a/src/compat/Makefile=2Eam</span><br><span=
>+++ b/src/compat/Makefile=2Eam</span><br><span>@@ -20,5 +20,6 @@</span><br=
><span> 	compat-basename=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \<=
/span><br><span> 	compat-daemon=2Ec \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	compat-strlcpy=2Ec \</span><br><span> 	compat-strsep=2Ec=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	compat-strtok_r=2E=
c</span><br><span>\ No newline at end of file</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	compat-strtok_r=2Ec</span><br><span>diff --git a=
/src/compat/compat-strlcpy=2Ec b/src/compat/compat-strlcpy=2Ec</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E8c1e80a</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/compat/compat-strlcpy=2Ec<=
/span><br><span>@@ -0,0 +1,52 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
OpenVPN -- An application to securely tunnel IP networks</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port,=
 with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             session authentication and key exchange,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encry=
ption, packet authentication, and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             packet compression=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2En=
et&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softw=
are; you can redistribute it and/or modify</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lic=
ense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  a=
s published by the Free Software Foundation=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is distributed in the hope that it will be usefu=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef HAVE_STRLCPY</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strlcpy(char *dest=
, const char *src, size_t maxlen)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (maxlen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpy=
(dest, src, maxlen - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        dest[maxlen - 1] =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return strlen(src);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+strlcat(char *dest, const char *src, size=
_t maxlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t dest_len =3D str=
nlen(dest, maxlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (maxlen &gt; dest_len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    strncat(dest, src, maxlen - dest_len - 1);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return dest_len + strlen(src);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 ifndef HAVE_STRLCPY */</span><br><span>diff --git a/src/compat/compat=2Eh =
b/src/compat/compat=2Eh</span><br><span>index 9e6f95c=2E=2E4ee9141 100644</=
span><br><span>--- a/src/compat/compat=2Eh</span><br><span>+++ b/src/compat=
/compat=2Eh</span><br><span>@@ -56,6 +56,15 @@</span><br><span> </span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef HAVE_STRLCPY</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
strlcpy(char *dest, const char *src, size_t maxlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+strlcat(char *dest, const char *src, size_t maxlen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #ifndef HAVE_STRSEP</span><br><span> char *strsep(char=
 **stringp, const char *delim);</span><br><span> </span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makef=
ile=2Eam</span><br><span>index 5430ecb=2E=2E38299f5 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>@@ -54,6 +54,7 @@</span><br>=
<span> argv_testdriver_SOURCES =3D test_argv=2Ec \</span><br><span> 	mock_m=
sg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_get_random=2Ec=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/p=
latform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span>@@=
 -64,6 +65,7 @@</span><br><span> buffer_testdriver_SOURCES =3D test_buffer=
=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span>=
<br><span> 	mock_get_random=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/platform=2Ec</span><br><span> </span><br><span>@@ -74,6 +76=
,7 @@</span><br><span> crypto_testdriver_SOURCES =3D test_crypto=2Ec \</spa=
n><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> =
	siphash_openssl=2Ec siphash_openssl=2Eh \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/crypto_mbedtls=2Ec \</span><br><span>@@ -94,6 +97,7 @@</span><br><span> =
dhcp_testdriver_SOURCES =3D test_dhcp=2Ec \</span><br><span> 	mock_msg=2Ec =
mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_get_random=2Ec \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compa=
t/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec</span><br><span>@@ -106,6 +=
110,7 @@</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</spa=
n><br><span> 	mock_management=2Ec \</span><br><span> 	mock_ssl_dependencies=
=2Ec mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \<=
/span><br><span>@@ -145,6 +150,7 @@</span><br><span> packet_id_testdriver_S=
OURCES =3D test_packet_id=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh=
 test_common=2Eh \</span><br><span> 	mock_get_random=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-str=
lcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/packet_id=2Ec \</span><br><span>@@ -158,6 +164,7 @@</span=
><br><span> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@</span><br><span> pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_ms=
g=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-str=
lcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -190,6 +197,7 @@</span><br=
><span> tls_crypt_testdriver_SOURCES =3D test_tls_crypt=2Ec \</span><br><sp=
an> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_win=
32_execve=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base64=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><=
span>@@ -212,6 +220,7 @@</span><br><span> networking_testdriver_LDFLAGS =3D=
 @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \</span><br><span> 	$(OPTIONAL_=
CRYPTO_LIBS)</span><br><span> networking_testdriver_SOURCES =3D test_networ=
king=2Ec mock_msg=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/networking_sitnl=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \</span><br><span>@@ -230,6 +239,7 @@</span><br><span> options_parse_t=
estdriver_SOURCES =3D test_options_parse=2Ec \</span><br><span> 	mock_msg=
=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_get_random=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/opt=
ions_parse=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><=
span>@@ -243,6 +253,7 @@</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><b=
r><span> </span><br><span> provider_testdriver_SOURCES =3D test_provider=2E=
c mock_msg=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/xkey_helper=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
xkey_provider=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec =
\</span><br><span>@@ -259,6 +270,7 @@</span><br><span> 	$(OPTIONAL_CRYPTO_L=
IBS) -lcrypt32 -lncrypt</span><br><span> cryptoapi_testdriver_SOURCES =3D t=
est_cryptoapi=2Ec mock_msg=2Ec \</span><br><span> 	pkey_test_utils=2Ec cert=
_data=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/xkey_helper=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey_=
provider=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</sp=
an><br><span>@@ -278,6 +290,7 @@</span><br><span> pkcs11_testdriver_SOURCES=
 =3D test_pkcs11=2Ec \</span><br><span> 	mock_msg=2Ec test_common=2Eh \</sp=
an><br><span> 	pkey_test_utils=2Ec cert_data=2Eh mock_get_random=2Ec \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compa=
t/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey_hel=
per=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey_provider=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span>@@ -3=
00,6 +313,7 @@</span><br><span> </span><br><span> auth_token_testdriver_SOU=
RCES =3D test_auth_token=2Ec \</span><br><span> 	mock_msg=2Ec test_common=
=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><spa=
n>@@ -320,6 +334,7 @@</span><br><span> </span><br><span> user_pass_testdriv=
er_SOURCES =3D test_user_pass=2Ec \</span><br><span> 	mock_msg=2Ec test_com=
mon=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_src=
dir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/console=2Ec =
\</span><br><span> 	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><br><span=
>@@ -339,6 +354,7 @@</span><br><span> </span><br><span> ncp_testdriver_SOUR=
CES =3D test_ncp=2Ec \</span><br><span> 	mock_msg=2Ec test_common=2Eh \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/comp=
at/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span>@@ -362=
,6 +378,7 @@</span><br><span> mbuf_testdriver_SOURCES =3D test_mbuf=2Ec \</=
span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get=
_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top=
_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-ut=
il=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><=
br><span>@@ -377,6 +394,7 @@</span><br><span> 	test_schedule=2Ec test_sched=
ule=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span=
> 	mock_get_random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=
=2Ec \</span><br><span>@@ -402,6 +420,7 @@</span><br><span> 	mock_msg=2Ec \=
</span><br><span> 	mock_get_random=2Ec \</span><br><span> 	mock_push_depend=
encies=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span=
><br><span>@@ -419,6 +438,7 @@</span><br><span> 	mock_msg=2Ec test_common=
=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><span> 	mock_mana=
gement=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-uti=
l=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1994?usp=3Demail">change 1994</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1994?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1994 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--D5VveuIa900=--


--===============5979626389552809624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5979626389552809624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5979626389552809624==--

