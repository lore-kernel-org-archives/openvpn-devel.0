Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEAFCCA462
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5TBRdYWP5rpS5CzxoapxVyNPvF4PX64kLFRbYc5QESE=; b=WM5ifDcNxFMlE4PVlei6FQcN/X
	VQSMKmIbqR0rkyURJzCd1NU4dv3RCiAHo+9H5Vj7myjqBMnWZ0fRlHQAzMF1M/bD+XlJeEtEL/tYo
	UWTs0QnZ16m/UT7qmwqZfDrmOo9bX9EBUpJEGg8My/BmCxqUS5x77mC5QNK6N9eU1lFo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHgFu-0005aZ-4H;
	Fri, 16 Oct 2026 11:37:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHgFs-0005J2-9s
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 11:37:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Y72uDzwf0acoBHCWa6gEOH5+KA9IcoQeYaFKJnhQ/2E=; b=DZJvA5FSkOBpQVIMYjQhqBe50O
 n+8UvgWvZUNNwkKDfWjmkpOzab4L3CFBx87gaVg/nqlfNXNVgYmA5HwFvPu3srfwsoy5fLuYdvkEn
 jMINAjgZL79zNsRVA+6G1ULQHCLlkZMwPVPvbb0to4omeFmFZlz1vKHynB1oz0Mvr2N0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y72uDzwf0acoBHCWa6gEOH5+KA9IcoQeYaFKJnhQ/2E=; b=Y
 Ha1yrntPTA1sPebCga0Pmn9wZX7eR+fxWzUM3D17321jQHmpYaMpUwOZWbRcspVPJ8o8dcH3Lpv5s
 j9FOLg0I7zZDKib8ALOwjQTLO8AaM+syv0qWxaxi/cQNWRAG2smvYWmYeuj477KzwhmBAbOPbytvI
 Q8MooKno+TU70Hsk=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHgFU-0004QX-8z for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 11:37:24 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso27207585e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792150634; x=1792755434; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y72uDzwf0acoBHCWa6gEOH5+KA9IcoQeYaFKJnhQ/2E=;
 b=PEAqZhetC/PtQEnPHpz0+wkFDhxRK9oIbYDgM+FCdRQ3EtJL42YETknYdXSKI3A+/v
 0W64Lv6mcavSKvdWLkP1OVY8Hlx7kGxxPyZFlpduSnuyeqzxS+eDiVmu+GGFjcdNZ4+p
 ZNrhWibgJxfkpctbmPIahPOidhrjXPjmD7ZoTEEmRrplNAcPh17bQtJaMKPnnyi++27F
 +hMT2nFzWPx7se899qPz0zoR2oxrF/eM5Md1JPszHymRKdjG5opnc9Uum8BUBMOeofEg
 aFNo23LL/1IPN9mLQSUGRCR8iOP2d4bBi8TsHUa300FC5aW2o/UD3Bim209nXt+ob1wv
 SCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792150634; x=1792755434;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y72uDzwf0acoBHCWa6gEOH5+KA9IcoQeYaFKJnhQ/2E=;
 b=KO1sIsZj2OL9p7ZCvdgeaAFOr1R+df1wJz4TaekXE6YVQHYm2AJlnlPghjiIIj+Cu/
 ekLfcI0EHLbQ7+wcIOBxwdqgR6gGeWzPp2wVs4xqhs3A3DJhKubc2ZT3NGQiNmxbUQf5
 GXZptlEVZ8bJlQAKgFoOGHGbf3Al+VljuIjZsq8Q8EYc/yv//HqWPnJ/EK+iwtzGauBL
 l96o2MuzcB63FLYzuNB8H1es1sJJMkUNJAkvqFmTJFF6aCsj3gKstaTl6V5XTDLu5uQA
 PNjehKv8Ea8ama+USiFpMU/+G3EUd6/+6NLTjsaghlJFI0l3gWNruCWLMEu5QsA763hp
 hw+Q==
X-Gm-Message-State: AFq9FYKZ7SlhjHgqFC2PaBN2THVGmojvBr8foY9M4SnM56J4WqcSyeYp
 trrTpwpFevjKWZEkEHWisHkyTcEBep/ODmx9K6ipn5UARKoobt11QUhApgR2QYy2QYdE8Q85+Wq
 7mzrPx1Uc3/b53CLroxTXbinTQuqGtbf3xS53tp1ZcFU0QTJpdhxtUEVoDAZoIyvoJd5h
X-Gm-Gg: AYBFou0lhTdVc4h9yurEhnzESjEkRMnThDwEhnkDbRu7gJJp2UBjVLitEVnY4szf5Lm
 C29Wp7syMu/U5Lkk0B2xB9pxCz5M9KDv+LgNomvAmV2W3P9/br5ndwaz3UEju2nNSeWOxh2zhB9
 V/L0CpxjyvzJcPmdtsZJl8kCcboVRSohTEPJyiJWQLbQA5VJjvVZVI5Fm98nMxTycMYxC/T8bZP
 Q2y+Kld0Q1LYSjwM8CvgAT2wpRS40ClaaQWW9TFAnzPrWBwb28rtJKYJSfbbZHGAkbU0NkLkJwV
 Y/52RYF4tBXhkIgKcInTnGnL2OWaETEW+uir/ml8GdCDNWbGQJHUyiaokQpAHxZFX9+nIYC0QEk
 GNzSU8vev1GC+89XtU6yR9d7V1DnEjPdR65hYoDgQihtZCZSyAXN0FXPBAOTAKNum8arSYAuWMy
 kD2q+AuafmJ8hQ7ybFCaX4xe8LZqrprO9TD4XwJptDnsZXxuKxWHsnman0arKPSuQVPMzsXorlw
 uJfETKcJAfvWSBUAw3LULKpbiar41oE1T0mJb61Okjh7zL+kdeJ/7gdj1Ucuh5UDcf99LS+t2F8
 Ypql6oHVIWs1Y7VN/WYQf7b0tOx7UaO5pcZKT78WzezLYcRSnu3+Vz8EYo+t
X-Received: by 2002:a05:600c:e557:10b0:4a1:8efb:c9ae with SMTP id
 5b1f17b1804b1-4a18efbcae9mr283585885e9.23.1792150633410; 
 Fri, 16 Oct 2026 04:37:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ae6d2esm52558475e9.6.2026.10.16.04.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 04:37:12 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 11:37:11 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
X-Gerrit-Change-Number: 1994
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1994?usp=email>
X-Gerrit-Commit: f659b6ecffccdca4469c2a20a819d7a29fc3c7c0
In-Reply-To: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
References: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk5MDZiM2ZhZDVkNTIxZTFlNGIwZjE1YWZmNzYzY2Y0ZDRkOGJjMzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e8365c0629a8e3c16d22328188d74e6baceb57e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHgFU-0004QX-8z
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3276195359424901982=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3276195359424901982==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QjL8Cf2EuTQ="; charset=UTF-8

--QjL8Cf2EuTQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
994?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: compat: Add strlcpy =
and strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

c=
ompat: Add strlcpy and strlcat

Available on most systems (Linux since glib=
c 2=2E38), but not all=2E
We already have strncpynt, but switching to the s=
tandard strlcpy
makes the code more accessible for both humans and tools=2E=


This commit only introduces the possibility to use strlcpy in general
cod=
e (we already have one usage in BSD-specific code)=2E No users are
introduc=
ed, yet=2E

Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
Signed-off=
-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1994
Message-Id: <20261016085833=2E27514-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg39916=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M src/compat/M=
akefile=2Eam
A src/compat/compat-strlcpy=2Ec
M src/compat/compat=2Eh
M test=
s/unit_tests/openvpn/Makefile=2Eam
7 files changed, 90 insertions(+), 2 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/94/1994/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index bac4d=
d4=2E=2Eb286ee2 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -24=
8,6 +248,7 @@
 
 check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)
 check_symb=
ol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)
+check_symbol_exists(s=
trlcpy string=2Eh HAVE_STRLCPY)
 check_symbol_exists(strsep string=2Eh HAVE=
_STRSEP)
 check_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)
 
@@ -431,=
6 +432,7 @@
     src/compat/compat-daemon=2Ec
     src/compat/compat-dirnam=
e=2Ec
     src/compat/compat-gettimeofday=2Ec
+    src/compat/compat-strlcp=
y=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-strtok_r=2Ec=

     src/openvpn/argv=2Ec
@@ -764,6 +766,7 @@
             src/openvpn/pla=
tform=2Ec
             src/openvpn/win32-util=2Ec
             src/compat/c=
ompat-gettimeofday=2Ec
+            src/compat/compat-strlcpy=2Ec
         =
    src/compat/compat-strsep=2Ec
             src/compat/compat-strtok_r=2E=
c
             )
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=
=2Ein
index 8c3088e=2E=2E483de45 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b=
/config=2Eh=2Ecmake=2Ein
@@ -267,6 +267,9 @@
 /* Define to 1 if you have th=
e <string=2Eh> header file=2E */
 #define HAVE_STRING_H 1
 
+/* Define to 1=
 if you have the `strlcpy' function=2E */
+#cmakedefine HAVE_STRLCPY
+
 /* =
Define to 1 if you have the `strsep' function=2E */
 #cmakedefine HAVE_STRS=
EP
 
diff --git a/configure=2Eac b/configure=2Eac
index 56109af=2E=2Ead3f8f=
1 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -568,7 +568,7 @@
 	se=
tgroups flock gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve get=
peereid basename dirname \
-	epoll_create strsep strtok_r \
+	epoll_create =
strlcpy strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff --git a/src/compat/Make=
file=2Eam b/src/compat/Makefile=2Eam
index 22867b3=2E=2E8b1d44a 100644
--- =
a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefile=2Eam
@@ -20,5 +20,6 @@=

 	compat-basename=2Ec \
 	compat-gettimeofday=2Ec \
 	compat-daemon=2Ec \
=
+	compat-strlcpy=2Ec \
 	compat-strsep=2Ec \
-	compat-strtok_r=2Ec
\ No new=
line at end of file
+	compat-strtok_r=2Ec
diff --git a/src/compat/compat-st=
rlcpy=2Ec b/src/compat/compat-strlcpy=2Ec
new file mode 100644
index 000000=
0=2E=2E8c1e80a
--- /dev/null
+++ b/src/compat/compat-strlcpy=2Ec
@@ -0,0 +1=
,52 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ =
*             over a single UDP port, with support for SSL/TLS-based
+ *   =
          session authentication and key exchange,
+ *             packet e=
ncryption, packet authentication, and
+ *             packet compression=2E=

+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
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
fndef HAVE_STRLCPY
+#include <string=2Eh>
+
+size_t
+strlcpy(char *dest, co=
nst char *src, size_t maxlen)
+{
+    if (maxlen > 0)
+    {
+        strnc=
py(dest, src, maxlen - 1);
+        dest[maxlen - 1] =3D 0;
+    }
+    ret=
urn strlen(src);
+}
+
+size_t
+strlcat(char *dest, const char *src, size_t =
maxlen)
+{
+    size_t dest_len =3D strnlen(dest, maxlen);
+    if (maxlen =
> dest_len)
+    {
+        strncat(dest, src, maxlen - dest_len - 1);
+   =
 }
+    return dest_len + strlen(src);
+}
+
+#endif /* ifndef HAVE_STRLCPY =
*/
diff --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh
index 9e6f95c=
=2E=2E4ee9141 100644
--- a/src/compat/compat=2Eh
+++ b/src/compat/compat=2E=
h
@@ -56,6 +56,15 @@
 
 #endif
 
+#ifndef HAVE_STRLCPY
+size_t
+strlcpy(cha=
r *dest, const char *src, size_t maxlen);
+
+size_t
+strlcat(char *dest, co=
nst char *src, size_t maxlen);
+
+#endif
+
 #ifndef HAVE_STRSEP
 char *strs=
ep(char **stringp, const char *delim);
 
diff --git a/tests/unit_tests/open=
vpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5430ecb=2E=
=2E38299f5 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -54,6 +54,7 @@
 argv_testdriver_SOURCES=
 =3D test_argv=2Ec \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_g=
et_random=2Ec \
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_src=
dir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	=
$(top_srcdir)/src/openvpn/win32-util=2Ec \
@@ -64,6 +65,7 @@
 buffer_testdr=
iver_SOURCES =3D test_buffer=2Ec \
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
Ge=
rrit-Change-Number: 1994
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--QjL8Cf2EuTQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1994?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">compat: Add strlcpy and strlcat<br><br>Available on most systems (Linux=
 since glibc 2=2E38), but not all=2E<br>We already have strncpynt, but swit=
ching to the standard strlcpy<br>makes the code more accessible for both hu=
mans and tools=2E<br><br>This commit only introduces the possibility to use=
 strlcpy in general<br>code (we already have one usage in BSD-specific code=
)=2E No users are<br>introduced, yet=2E<br><br>Change-Id: I906b3fad5d521e1e=
4b0f15aff763cf4d4d8bc35e<br>Signed-off-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994<br>Message=
-Id: &lt;20261016085833=2E27514-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3991=
6=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<=
br>M src/compat/Makefile=2Eam<br>A src/compat/compat-strlcpy=2Ec<br>M src/c=
ompat/compat=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>7 files cha=
nged, 90 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/1994/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index bac4d=
d4=2E=2Eb286ee2 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><sp=
an>+++ b/CMakeLists=2Etxt</span><br><span>@@ -248,6 +248,7 @@</span><br><sp=
an> </span><br><span> check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)</span>=
<br><span> check_symbol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(s=
trlcpy string=2Eh HAVE_STRLCPY)</span><br><span> check_symbol_exists(strsep=
 string=2Eh HAVE_STRSEP)</span><br><span> check_symbol_exists(strtok_r stri=
ng=2Eh HAVE_STRTOK_R)</span><br><span> </span><br><span>@@ -431,6 +432,7 @@=
</span><br><span>     src/compat/compat-daemon=2Ec</span><br><span>     src=
/compat/compat-dirname=2Ec</span><br><span>     src/compat/compat-gettimeof=
day=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/comp=
at/compat-strlcpy=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</sp=
an><br><span>     src/compat/compat-strtok_r=2Ec</span><br><span>     src/o=
penvpn/argv=2Ec</span><br><span>@@ -764,6 +766,7 @@</span><br><span>       =
      src/openvpn/platform=2Ec</span><br><span>             src/openvpn/win=
32-util=2Ec</span><br><span>             src/compat/compat-gettimeofday=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/com=
pat/compat-strlcpy=2Ec</span><br><span>             src/compat/compat-strse=
p=2Ec</span><br><span>             src/compat/compat-strtok_r=2Ec</span><br=
><span>             )</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein =
b/config=2Eh=2Ecmake=2Ein</span><br><span>index 8c3088e=2E=2E483de45 100644=
</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=
=2Eh=2Ecmake=2Ein</span><br><span>@@ -267,6 +267,9 @@</span><br><span> /* D=
efine to 1 if you have the &lt;string=2Eh&gt; header file=2E */</span><br><=
span> #define HAVE_STRING_H 1</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Define to 1 if you have the `strlcpy&#39; fu=
nction=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmaked=
efine HAVE_STRLCPY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /* Define to 1 if you have the `strsep&#39; function=2E */=
</span><br><span> #cmakedefine HAVE_STRSEP</span><br><span> </span><br><spa=
n>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 56109a=
f=2E=2Ead3f8f1 100644</span><br><span>--- a/configure=2Eac</span><br><span>=
+++ b/configure=2Eac</span><br><span>@@ -568,7 +568,7 @@</span><br><span> 	=
setgroups flock gettimeofday \</span><br><span> 	setsid chdir \</span><br><=
span> 	chsize ftruncate execve getpeereid basename dirname \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	epoll_create strsep strtok_r \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	epoll_create strlcpy st=
rsep strtok_r \</span><br><span> ])</span><br><span> </span><br><span> AC_C=
HECK_LIB(</span><br><span>diff --git a/src/compat/Makefile=2Eam b/src/compa=
t/Makefile=2Eam</span><br><span>index 22867b3=2E=2E8b1d44a 100644</span><br=
><span>--- a/src/compat/Makefile=2Eam</span><br><span>+++ b/src/compat/Make=
file=2Eam</span><br><span>@@ -20,5 +20,6 @@</span><br><span> 	compat-basena=
me=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</span><br><span> 	comp=
at-daemon=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	com=
pat-strlcpy=2Ec \</span><br><span> 	compat-strsep=2Ec \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	compat-strtok_r=2Ec</span><br><span>\ No=
 newline at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	compat-strtok_r=2Ec</span><br><span>diff --git a/src/compat/compat-str=
lcpy=2Ec b/src/compat/compat-strlcpy=2Ec</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2E8c1e80a</span><br><span>--- /dev/null=
</span><br><span>+++ b/src/compat/compat-strlcpy=2Ec</span><br><span>@@ -0,=
0 +1,52 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             over a single UDP port, with support for SSL/=
TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     session authentication and key exchange,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet encryption, packet authenti=
cation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet compression=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copy=
right (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  it under the terms of the GNU General Public License version 2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fre=
e Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pro=
gram is distributed in the hope that it will be useful,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pub=
lic License for more details=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_STRLC=
PY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stri=
ng=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+strlcpy(char *dest, const char *src, size=
_t maxlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (maxlen &gt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        strncpy(dest, src, maxlen - 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dest[maxle=
n - 1] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return strlen(sr=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+strlcat(char *dest, const char *src, size_t maxlen)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    size_t dest_len =3D strnlen(dest, maxlen);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (maxlen &gt; dest_=
len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        strncat(dest, src, ma=
xlen - dest_len - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return d=
est_len + strlen(src);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef HAVE_STRLCPY */</=
span><br><span>diff --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh</=
span><br><span>index 9e6f95c=2E=2E4ee9141 100644</span><br><span>--- a/src/=
compat/compat=2Eh</span><br><span>+++ b/src/compat/compat=2Eh</span><br><sp=
an>@@ -56,6 +56,15 @@</span><br><span> </span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_=
STRLCPY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+strlcpy(char *dest, const=
 char *src, size_t maxlen);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+size_t</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+strlcat(char *dest, cons=
t char *src, size_t maxlen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifnd=
ef HAVE_STRSEP</span><br><span> char *strsep(char **stringp, const char *de=
lim);</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openv=
pn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>i=
ndex 5430ecb=2E=2E38299f5 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>@@ -54,6 +54,7 @@</span><br><span> argv_testdriver_SO=
URCES =3D test_argv=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_=
common=2Eh \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/win32-util=2Ec \</span><br><span>@@ -64,6 +65,7 @@</span><=
br><span> buffer_testdriver_SOURCES =3D test_buffer=2Ec \</span><br><span> =
	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_get_ran=
dom=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_src=
dir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=
=2Ec</span><br><span> </span><br><span>@@ -74,6 +76,7 @@</span><br><span> c=
rypto_testdriver_SOURCES =3D test_crypto=2Ec \</span><br><span> 	mock_msg=
=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	siphash_openssl=2Ec s=
iphash_openssl=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/c=
rypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec =
\</span><br><span>@@ -94,6 +97,7 @@</span><br><span> dhcp_testdriver_SOURCE=
S =3D test_dhcp=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_comm=
on=2Eh \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span=
> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/win32-util=2Ec</span><br><span>@@ -106,6 +110,7 @@</span><br><sp=
an> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_man=
agement=2Ec \</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32_execve=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -14=
5,6 +150,7 @@</span><br><span> packet_id_testdriver_SOURCES =3D test_packet=
_id=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</sp=
an><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/pack=
et_id=2Ec \</span><br><span>@@ -158,6 +164,7 @@</span><br><span> 	@TEST_CFL=
AGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><=
span> pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh moc=
k_win32_execve=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffe=
r=2Ec \</span><br><span>@@ -190,6 +197,7 @@</span><br><span> tls_crypt_test=
driver_SOURCES =3D test_tls_crypt=2Ec \</span><br><span> 	mock_msg=2Ec mock=
_msg=2Eh test_common=2Eh \</span><br><span> 	mock_win32_execve=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/=
compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -212,6 +220,7 @@=
</span><br><span> networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_=
srcdir)/src/openvpn \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><=
span> networking_testdriver_SOURCES =3D test_networking=2Ec mock_msg=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/c=
ompat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/netw=
orking_sitnl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span>@=
@ -230,6 +239,7 @@</span><br><span> options_parse_testdriver_SOURCES =3D te=
st_options_parse=2Ec \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_com=
mon=2Eh \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec =
\</span><br><span> 	$(top_srcdir)/src/openvpn/options_parse=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -243,6 +253,7 @@</sp=
an><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> </span><br><span> p=
rovider_testdriver_SOURCES =3D test_provider=2Ec mock_msg=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compa=
t-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey_helper=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey_provider=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -259,6 =
+270,7 @@</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS) -lcrypt32 -lncrypt</spa=
n><br><span> cryptoapi_testdriver_SOURCES =3D test_cryptoapi=2Ec mock_msg=
=2Ec \</span><br><span> 	pkey_test_utils=2Ec cert_data=2Eh \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-s=
trlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey_helper=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/xkey_provider=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -278,6 +29=
0,7 @@</span><br><span> pkcs11_testdriver_SOURCES =3D test_pkcs11=2Ec \</sp=
an><br><span> 	mock_msg=2Ec test_common=2Eh \</span><br><span> 	pkey_test_u=
tils=2Ec cert_data=2Eh mock_get_random=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/xkey_helper=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/xkey_provider=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/argv=2Ec \</span><br><span>@@ -300,6 +313,7 @@</span><br><=
span> </span><br><span> auth_token_testdriver_SOURCES =3D test_auth_token=
=2Ec \</span><br><span> 	mock_msg=2Ec test_common=2Eh \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcp=
y=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/crypto_epoch=2Ec \</span><br><span>@@ -320,6 +334,7 @@</spa=
n><br><span> </span><br><span> user_pass_testdriver_SOURCES =3D test_user_p=
ass=2Ec \</span><br><span> 	mock_msg=2Ec test_common=2Eh \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-str=
lcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/console=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/env_set=2Ec \</span><br><span>@@ -339,6 +354,7 @@</span=
><br><span> </span><br><span> ncp_testdriver_SOURCES =3D test_ncp=2Ec \</sp=
an><br><span> 	mock_msg=2Ec test_common=2Eh \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/crypto_epoch=2Ec \</span><br><span>@@ -362,6 +378,7 @@</span><br><spa=
n> mbuf_testdriver_SOURCES =3D test_mbuf=2Ec \</span><br><span> 	mock_msg=
=2Ec test_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compa=
t-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span>@@ -377,6 +394,7=
 @@</span><br><span> 	test_schedule=2Ec test_schedule=2Eh \</span><br><span=
> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/c=
ompat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buff=
er=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span>@@ =
-402,6 +420,7 @@</span><br><span> 	mock_msg=2Ec \</span><br><span> 	mock_ge=
t_random=2Ec \</span><br><span> 	mock_push_dependencies=2Ec \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-=
strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span>@@ -419,6 +438,7=
 @@</span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	moc=
k_get_random=2Ec \</span><br><span> 	mock_management=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-str=
lcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/platform=2Ec \</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail">change=
 1994</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1994 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--QjL8Cf2EuTQ=--


--===============3276195359424901982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3276195359424901982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3276195359424901982==--

