Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F4AC44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mXKEnPNLuKNFPIIEx/3+FFLt7y/ZIlMVXMutuYEzMIU=; b=MraBlYPpfoTdiW1ah2LjjeJZt+
	sxMTVloo/U0cm49RB79JckEoEpJPXG3vzYVuludXcZg5WfSoDrRWchIB61aMnIvbFo9oK2OFOzDZi
	EjD1pgVB23WI420vMRPxQtrCvaiWb421fc0ujDu8dAqC1Ihut7krEGXKyhuYJtokYZag=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk3YU-00032O-Ke;
	Wed, 15 Jul 2026 17:37:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk3YS-00032F-Tc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 17:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lEz3VzAkgQqumm3mdaR3FXd6I82hFoo+OU0WkVMKd6s=; b=E2Jz2gYx+fxkuX5KOeO8/tNGIp
 8mLmnq5qq+Tawe9B/tjVInQh1E4jeawmKU/X23poK5FhS8UUEkrqMA3DYSig03ZQQzIa58Xx/QCnc
 q8WaabenW9RxF0S72Ku0ZTOQbGd+erR/ZfRuR3enawfQq8F720S8g7SFhNBK3U5cP98k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lEz3VzAkgQqumm3mdaR3FXd6I82hFoo+OU0WkVMKd6s=; b=F
 gUoVJ5ekVi9k5Mkuq0nV8BFDYqWki5098UdbKdJwi7HRjwfF6eUdXn1BzOXS6imn2V6QGbd8U5b/j
 j+A4LeTrJGrSgtYX4ISsPKRMnSGumPZIVd5kb0M40AxGMR0mih+Xtmt74QALoYjZAFlcVaIJNmliu
 DUCG40DO3oad//do=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk3YL-0007bi-S6 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 17:37:56 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso40381625e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784137058; x=1784741858; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lEz3VzAkgQqumm3mdaR3FXd6I82hFoo+OU0WkVMKd6s=;
 b=Gm/2jfizN4/4hZ+1PoGWTQtMme1jET7VdGu8we7q+myVJ4npTrgC5Nd8pzQWIxzsZY
 rDRF9WLFTgLbQCxYZ2EXdc4ZUOqrzwNZ//n/knjnNVOsS2gLPRnZUEptVkIQxrglxMel
 p7Mpwxcpw2w14ph5++zaFux2P40Rqb9gqykHoRtz/uTxQFpZ5f32/uAB7Fsj4Z2pACfN
 OTULpDq42/EfblHfNzHGHeQsU7rnd2aPhfig77/tOkUr9GlZNhNQ5pI+PNAKQHyyAPm8
 QpTc2ufxzDFNoJucKkw2j/V5NHjsph1Gz+pkJbONfHSF+Gy07mcdZHZRJXzpjnwM5llU
 5Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784137058; x=1784741858;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lEz3VzAkgQqumm3mdaR3FXd6I82hFoo+OU0WkVMKd6s=;
 b=FxKqpPrO9VIBQ64qVK/kutxlFnWRmIQGtyNidIcE9BcGoAw9qMZA0a6LsXu/O7sOmb
 ud6BKJKxWZkv6C1O7HtuRQEQ1CfwS3fE428TA+WRzlnL6KQoi9TgManT1bYQzmWbpKTW
 gSIkHVj0QOeL4b+/xmTZtYmfvNDqNGqYkYuw2vxBE4uQhCsJuDibqN21ulhneXPBtMwW
 V49GNJi+w0pErMXsNAqhDKPCAZnJQqYFOBrEc5KgTKhQ/wKitL+5DIyV/aUi1uRCsynV
 mR6YdYeFPHZqQchrySiAonvOKu43thnULOUl8uNI7q8T1rVPR+86Iux9LGtZXD0kKbgs
 MglA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4wOaJUv6nGX6lOrZ5LK4iP1SHdGSXUPFdeo/lhdg0kufMDHWcgZhCGhJQtSr7/az11HvH5mvsIZSDw3oQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy5uboDxqnybdRA7bVMXrSHmYLsCG1Pzsj9TJ4l5EBWZ5CpCPZ8
 iL93xDW1A23ZJcwnhUbj+jKt2k19pEGUl5rqlazUGqaK2EVowyrdGzzLn3UugyRQD4sE/OlFXP/
 n4y+c/ycAVOGDA5obFbCuqCj4sfPAg0b9tiOa8ubywv+QxVDjwbtLjGwQIknHfrvAmNyVOdpBWs
 sx4z/Nqg==
X-Gm-Gg: AfdE7cnabZgauBwrBMJGc690YcG5XZBwxVGCIJvJTpT8hTLKPZFLFlIJb1co2uIQMWF
 3zDNrP+XSzA6wglHdZd0CIaB9JyO0NueB5OmFjK8cgYqeIeL1arRYmLFQ1M67kLhwbDlgbO5r/m
 dJ5t7gNiMyeKnMA3JDG7AMfR6wGsL7azxRqtV/qZGkAtKbloIuMaRmc9HnZDiE7PZ57Ww4jAmXX
 V3nnlEPD+H0jy4Ya9/b0lLdbRMiW5e/J5gCYRVO3d6OxSdabTIhDeLsqjitotVMSlE10mCQVi3h
 22OxHoTOjgPzOkK2JYKK6pKJelmjg0NdVhvjsfPb6lXP/NFxy6677XhkSBqoFa5Le7pdi4rmZEQ
 drNHRDTQi60Zsg0AiIymeLpx3jjIsh9xoONhe5rW2lGcpbe6drDCijnW/9QKNPhwzGQmlD1ksRr
 38GzF9GVCqTBYohz5DFhKcCP5ovmSssr4S6ncm0gFwyKVwJeZygHCPR2CjxZH7yXVOEGZTWYbM5
 cIa7fXvZoKM74Wjb4K/0DLy1t1ragtlGcgH0ssbk7sehe5wUjj+OcIiA07pqAva3enQWXXifHQE
 LPs=
X-Received: by 2002:a05:600c:19d0:b0:492:6efc:7c60 with SMTP id
 5b1f17b1804b1-49518308220mr103313765e9.28.1784137058011; 
 Wed, 15 Jul 2026 10:37:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a935sm17751036f8f.11.2026.07.15.10.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:37:37 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 17:37:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 27df276eabdf87ad97ab88e8e84cc53d2bbc59c8
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce544fd6f526eb80ab5104f1c9d0189a40776b4b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk3YL-0007bi-S6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strtok with
 strtok_r
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1318835698950892666=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1318835698950892666==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wppluVeuX6o="; charset=UTF-8

--wppluVeuX6o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1679?usp=3Demail )

Change subject: Replace strtok with strtok_r
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace strtok with=
 strtok_r

This does not change anything in our source code but makes compi=
ling
with newer Android NDKs (version 30 pre release) -Werror safe again
as=
 it has started throwing warning on this=2E

The compat version is taken fr=
om current FreeBSD (commit dc36d6f9bb1)
src/lib/libc/string/strtok=2Ec and =
reformatted to our clang standard=2E

Change-Id: I70560efd113308b7377424127=
eb2c1da4266371a
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1679
Message-Id: <20260708153107=2E60809-1-frank@li=
chtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37538=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M configure=2Eac
M src/compat/Makefi=
le=2Eam
A src/compat/compat-strtok_r=2Ec
M src/compat/compat=2Eh
M src/open=
vpn/options_util=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=2E=
c
M src/openvpn/ssl_verify=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
10 =
files changed, 130 insertions(+), 12 deletions(-)




diff --git a/CMakeLis=
ts=2Etxt b/CMakeLists=2Etxt
index 23541a5d=2E=2E7473f15 100644
--- a/CMakeL=
ists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -248,6 +248,7 @@
 check_symbol_exists(=
chsize io=2Eh HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource=2Eh =
HAVE_GETRLIMIT)
 check_symbol_exists(strsep string=2Eh HAVE_STRSEP)
+check_=
symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)
 
 # Some OS (e=2Eg=2E Fre=
eBSD) need some basic headers to allow
 # including network headers
@@ -423=
,6 +424,7 @@
     src/compat/compat-dirname=2Ec
     src/compat/compat-gett=
imeofday=2Ec
     src/compat/compat-strsep=2Ec
+    src/compat/compat-strto=
k_r=2Ec
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvp=
n/base64=2Ec
@@ -743,6 +745,8 @@
             src/openvpn/platform=2Ec
    =
         src/openvpn/win32-util=2Ec
             src/compat/compat-gettimeo=
fday=2Ec
+            src/compat/compat-strsep=2Ec
+            src/compat/=
compat-strtok_r=2Ec
             )
 
         add_library_deps(${test_name}=
)
diff --git a/configure=2Eac b/configure=2Eac
index e19d651=2E=2E188f8fa 1=
00644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -568,7 +568,7 @@
 	setgr=
oups flock gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpee=
reid basename dirname \
-	epoll_create strsep \
+	epoll_create strsep strto=
k_r \
 ])
 
 AC_CHECK_LIB(
diff --git a/src/compat/Makefile=2Eam b/src/comp=
at/Makefile=2Eam
index 69b2990=2E=2E22867b3 100644
--- a/src/compat/Makefil=
e=2Eam
+++ b/src/compat/Makefile=2Eam
@@ -20,4 +20,5 @@
 	compat-basename=
=2Ec \
 	compat-gettimeofday=2Ec \
 	compat-daemon=2Ec \
-	compat-strsep=2E=
c
\ No newline at end of file
+	compat-strsep=2Ec \
+	compat-strtok_r=2Ec
\=
 No newline at end of file
diff --git a/src/compat/compat-strtok_r=2Ec b/sr=
c/compat/compat-strtok_r=2Ec
new file mode 100644
index 0000000=2E=2Edebcdd=
3
--- /dev/null
+++ b/src/compat/compat-strtok_r=2Ec
@@ -0,0 +1,101 @@
+/*-=

+ * SPDX-License-Identifier: BSD-3-Clause
+ *
+ * Copyright (c) 1998 Softw=
eyr LLC=2E  All rights reserved=2E
+ *
+ * strtok_r, from Berkeley strtok
+=
 * Oct 13, 1998 by Wes Peters <wes@softweyr=2Ecom>
+ *
+ * Copyright (c) 19=
88, 1993
+ *      The Regents of the University of California=2E  All right=
s reserved=2E
+ *
+ * Redistribution and use in source and binary forms, wi=
th or without
+ * modification, are permitted provided that the following c=
onditions
+ * are met:
+ * 1=2E Redistributions of source code must retain =
the above copyright
+ *    notices, this list of conditions and the followi=
ng disclaimer=2E
+ * 2=2E Redistributions in binary form must reproduce the=
 above copyright
+ *    notices, this list of conditions and the following =
disclaimer in the
+ *    documentation and/or other materials provided with=
 the distribution=2E
+ * 3=2E Neither the name of the University nor the na=
mes of its contributors
+ *    may be used to endorse or promote products d=
erived from this software
+ *    without specific prior written permission=
=2E
+ *
+ * THIS SOFTWARE IS PROVIDED BY SOFTWEYR LLC, THE REGENTS AND CONT=
RIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BU=
T NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=
 FOR A
+ * PARTICULAR PURPOSE ARE DISCLAIMED=2E  IN NO EVENT SHALL SOFTWEYR=
 LLC, THE
+ * REGENTS, OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, =
INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BU=
T NOT LIMITED
+ * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON =
ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT=
 (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE =
OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E
=
+ */
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef HAVE_S=
TRTOK_R
+#include <string=2Eh>
+
+char *
+strtok_r(char *s, const char *del=
im, char **last)
+{
+    char *spanp, *tok;
+    int c, sc;
+
+    if (s =
=3D=3D NULL && (s =3D *last) =3D=3D NULL)
+    {
+        return (NULL);
+ =
   }
+
+/*
+ * Skip (span) leading delimiters (s +=3D strspn(s, delim), sor=
t of)=2E
+ */
+cont:
+    c =3D *s++;
+    for (spanp =3D (char *)delim; (s=
c =3D *spanp++) !=3D 0;)
+    {
+        if (c =3D=3D sc)
+        {
+     =
       goto cont;
+        }
+    }
+
+    if (c =3D=3D 0)
+    { /* no non=
-delimiter characters */
+        *last =3D NULL;
+        return (NULL);
+=
    }
+    tok =3D s - 1;
+
+    /*
+     * Scan token (scan for delimiters=
: s +=3D strcspn(s, delim), sort of)=2E
+     * Note that delim must have o=
ne NUL; we stop if we see that, too=2E
+     */
+    for (;;)
+    {
+     =
   c =3D *s++;
+        spanp =3D (char *)delim;
+        do
+        {
+  =
          if ((sc =3D *spanp++) =3D=3D c)
+            {
+                i=
f (c =3D=3D 0)
+                {
+                    s =3D NULL;
+       =
         }
+                else
+                {
+                    s[=
-1] =3D '\0';
+                }
+                *last =3D s;
+           =
     return (tok);
+            }
+        } while (sc !=3D 0);
+    }
+   =
 /* NOTREACHED */
+}
+#endif
\ No newline at end of file
diff --git a/src/c=
ompat/compat=2Eh b/src/compat/compat=2Eh
index 6532b86=2E=2E9e6f95c 100644
=
--- a/src/compat/compat=2Eh
+++ b/src/compat/compat=2Eh
@@ -61,4 +61,9 @@
 =

 #endif
 
+#ifndef HAVE_STRTOK_R
+char *
+strtok_r(char *s, const char *de=
lim, char **last);
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/openvp=
n/options_util=2Ec b/src/openvpn/options_util=2Ec
index 47fe0bc=2E=2Ed72ea2=
5c 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=
=2Ec
@@ -48,7 +48,8 @@
         message =3D strstr(reason, "]") + 1;
      =
   /* null terminate the substring to only looks for flags between [ and ] =
*/
         *endofflags =3D '\x00';
-        const char *token =3D strtok(m=
, "[,");
+        char *lasts =3D NULL;
+        const char *token =3D strt=
ok_r(m, "[,", &lasts);
         while (token)
         {
             if (!=
strncmp(token, "backoff ", strlen("backoff ")))
@@ -81,7 +82,7 @@
         =
    {
                 msg(D_PUSH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP =
flag: %s", token);
             }
-            token =3D strtok(NULL, "[,")=
;
+            token =3D strtok_r(NULL, "[,", &lasts);
         }
     }
 
=
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
inde=
x 8a0f7d2=2E=2E07caf08 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/o=
penvpn/ssl_mbedtls=2Ec
@@ -318,9 +318,10 @@
 
     /* Parse allowed ciphers=
, getting IDs */
     int i =3D 0;
+    char *lasts =3D NULL;
     tmp_ciph=
ers_orig =3D tmp_ciphers =3D string_alloc(ciphers, NULL);
 
-    token =3D =
strtok(tmp_ciphers, ":");
+    token =3D strtok_r(tmp_ciphers, ":", &lasts)=
;
     while (token)
     {
         ctx->allowed_ciphers[i] =3D mbedtls_ss=
l_get_ciphersuite_id(tls_translate_cipher_name(token));
@@ -328,7 +329,7 @@=

         {
             i++;
         }
-        token =3D strtok(NULL, ":=
");
+        token =3D strtok_r(NULL, ":", &lasts);
     }
     free(tmp_ci=
phers_orig);
 }
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=
=2Ec
index 649665a=2E=2Ebaf5a95 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/=
src/openvpn/ssl_ncp=2Ec
@@ -100,7 +100,8 @@
     struct buffer new_list =3D=
 alloc_buf(MAX_NCP_CIPHERS_LENGTH);
 
     char *const tmp_ciphers =3D stri=
ng_alloc(list, NULL);
-    const char *token =3D strtok(tmp_ciphers, ":");
=
+    char *lasts =3D NULL;
+    const char *token =3D strtok_r(tmp_ciphers,=
 ":", &lasts);
     while (token)
     {
         /*
@@ -174,7 +175,7 @@
  =
               buf_puts(&new_list, ovpn_cipher_name);
             }
      =
   }
-        token =3D strtok(NULL, ":");
+        token =3D strtok_r(NULL=
, ":", &lasts);
     }
 
 
@@ -207,15 +208,16 @@
 {
     char *tmp_ciphers =
=3D string_alloc(list, NULL);
     char *tmp_ciphers_orig =3D tmp_ciphers;
=
+    char *lasts =3D NULL;
 
-    const char *token =3D strtok(tmp_ciphers,=
 ":");
+    const char *token =3D strtok_r(tmp_ciphers, ":", &lasts);
     =
while (token)
     {
         if (0 =3D=3D strcmp(token, item))
         {
=
             break;
         }
-        token =3D strtok(NULL, ":");
+     =
   token =3D strtok_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig=
);
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
i=
ndex 9197adf=2E=2E162f68f 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src=
/openvpn/ssl_verify=2Ec
@@ -868,7 +868,8 @@
         return false;
     }
 =

-    const char *client_method =3D strtok(iv_sso, ",");
+    char *lasts =
=3D NULL;
+    const char *client_method =3D strtok_r(iv_sso, ",", &lasts);=

     bool supported =3D false;
 
     while (client_method)
@@ -878,7 +879=
,7 @@
             supported =3D true;
             break;
         }
-    =
    client_method =3D strtok(NULL, ",");
+        client_method =3D strtok_=
r(NULL, ",", &lasts);
     }
 
     gc_free(&gc);
diff --git a/tests/unit_t=
ests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 1=
128eb4=2E=2Ed861ef9 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++=
 b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -107,6 +107,7 @@
 	$(top_srcdi=
r)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(to=
p_srcdir)/src/compat/compat-strsep=2Ec \
+	$(top_srcdir)/src/compat/compat-=
strtok_r=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src=
/openvpn/cryptoapi=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
@@ =
-345,6 +346,7 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)=
/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/compat/compat-strsep=2Ec =
\
+	$(top_srcdir)/src/compat/compat-strtok_r=2Ec \
 	$(top_srcdir)/src/open=
vpn/ssl_util=2Ec
 
 mbuf_testdriver_CFLAGS  =3D \

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
Gerri=
t-Change-Number: 1679
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wppluVeuX6o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1679?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Replace strtok with strtok_r<br><br>This d=
oes not change anything in our source code but makes compiling<br>with newe=
r Android NDKs (version 30 pre release) -Werror safe again<br>as it has sta=
rted throwing warning on this=2E<br><br>The compat version is taken from cu=
rrent FreeBSD (commit dc36d6f9bb1)<br>src/lib/libc/string/strtok=2Ec and re=
formatted to our clang standard=2E<br><br>Change-Id: I70560efd113308b737742=
4127eb2c1da4266371a<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679<br>Message-Id: &lt;20=
260708153107=2E60809-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37538=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CM=
akeLists=2Etxt<br>M configure=2Eac<br>M src/compat/Makefile=2Eam<br>A src/c=
ompat/compat-strtok_r=2Ec<br>M src/compat/compat=2Eh<br>M src/openvpn/optio=
ns_util=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<b=
r>M src/openvpn/ssl_verify=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<=
br>10 files changed, 130 insertions(+), 12 deletions(-)<br><br></pre>
<pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 23541a=
5d=2E=2E7473f15 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><sp=
an>+++ b/CMakeLists=2Etxt</span><br><span>@@ -248,6 +248,7 @@</span><br><sp=
an> check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)</span><br><span> check_s=
ymbol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)</span><br><span> ch=
eck_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+check_symbol_exists(strtok_r string=2Eh HAVE_S=
TRTOK_R)</span><br><span> </span><br><span> # Some OS (e=2Eg=2E FreeBSD) ne=
ed some basic headers to allow</span><br><span> # including network headers=
</span><br><span>@@ -423,6 +424,7 @@</span><br><span>     src/compat/compat=
-dirname=2Ec</span><br><span>     src/compat/compat-gettimeofday=2Ec</span>=
<br><span>     src/compat/compat-strsep=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/compat/compat-strtok_r=2Ec</span><br><span>=
     src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><=
br><span>     src/openvpn/base64=2Ec</span><br><span>@@ -743,6 +745,8 @@</s=
pan><br><span>             src/openvpn/platform=2Ec</span><br><span>       =
      src/openvpn/win32-util=2Ec</span><br><span>             src/compat/co=
mpat-gettimeofday=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            src/compat/compat-strsep=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            src/compat/compat-strtok_r=2Ec</span><br=
><span>             )</span><br><span> </span><br><span>         add_librar=
y_deps(${test_name})</span><br><span>diff --git a/configure=2Eac b/configur=
e=2Eac</span><br><span>index e19d651=2E=2E188f8fa 100644</span><br><span>--=
- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ =
-568,7 +568,7 @@</span><br><span> 	setgroups flock gettimeofday \</span><br=
><span> 	setsid chdir \</span><br><span> 	chsize ftruncate execve getpeerei=
d basename dirname \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
epoll_create strsep \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	epoll_create strsep strtok_r \</span><br><span> ])</span><br><span> </sp=
an><br><span> AC_CHECK_LIB(</span><br><span>diff --git a/src/compat/Makefil=
e=2Eam b/src/compat/Makefile=2Eam</span><br><span>index 69b2990=2E=2E22867b=
3 100644</span><br><span>--- a/src/compat/Makefile=2Eam</span><br><span>+++=
 b/src/compat/Makefile=2Eam</span><br><span>@@ -20,4 +20,5 @@</span><br><sp=
an> 	compat-basename=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</spa=
n><br><span> 	compat-daemon=2Ec \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	compat-strsep=2Ec</span><br><span>\ No newline at end of file<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	compat-strsep=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	compat-strtok_r=2E=
c</span><br><span>\ No newline at end of file</span><br><span>diff --git a/=
src/compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=2Ec</span><br><=
span>new file mode 100644</span><br><span>index 0000000=2E=2Edebcdd3</span>=
<br><span>--- /dev/null</span><br><span>+++ b/src/compat/compat-strtok_r=2E=
c</span><br><span>@@ -0,0 +1,101 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * SPDX-License-Identifier: BSD-3-Clause</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Copyright (c) 1998 Softweyr LLC=2E  All rights reserved=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * strtok_r, from Berkeley strtok</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Oct 13, 1998 by Wes Peters &l=
t;wes@softweyr=2Ecom&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copyright=
 (c) 1988, 1993</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
    The Regents of the University of California=2E  All rights reserved=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Redistribution and use in source a=
nd binary forms, with or without</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * modification, are permitted provided that the following con=
ditions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are met:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 1=2E Redistributi=
ons of source code must retain the above copyright</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *    notices, this list of conditions and t=
he following disclaimer=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * 2=2E Redistributions in binary form must reproduce the above copy=
right</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    notices,=
 this list of conditions and the following disclaimer in the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *    documentation and/or other m=
aterials provided with the distribution=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * 3=2E Neither the name of the University nor the n=
ames of its contributors</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *    may be used to endorse or promote products derived from this sof=
tware</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    without =
specific prior written permission=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * THIS SOFTWARE IS PROVIDED BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ``AS IS&#39;&#39;=
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * LIMITED TO, THE IMPLIED WARRANTIE=
S OF MERCHANTABILITY AND FITNESS FOR A</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * PARTICULAR PURPOSE ARE DISCLAIMED=2E  IN NO EVENT SHA=
LL SOFTWEYR LLC, THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * REGENTS, OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SPECIAL, EXEMPL=
ARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * TO, PROCUREMENT OF SUBSTITUTE GOOD=
S OR SERVICES; LOSS OF USE, DATA, OR</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND O=
N ANY THEORY OF</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * L=
IABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * NEGLIGENCE OR OTHERWISE)=
 ARISING IN ANY WAY OUT OF THE USE OF THIS</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF S=
UCH DAMAGE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_STRTOK_R</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+strtok_r(char *s, const char *delim, char **last)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *spanp, *tok;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int c, sc;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (s =3D=3D NULL &amp;&amp; (s =3D *last) =3D=3D NULL)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return (NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Skip (span) l=
eading delimiters (s +=3D strspn(s, delim), sort of)=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+cont:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    c =3D *s++;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (spanp =3D (char *)delim; (sc =3D *spanp++) !=3D 0;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (c =3D=3D sc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto cont;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c =3D=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { /* no non-=
delimiter characters */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        *last =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return (NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 tok =3D s - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * Scan token (scan for delimite=
rs: s +=3D strcspn(s, delim), sort of)=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * Note that delim must have one NUL; we stop if =
we see that, too=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (;;)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        c =3D *s++;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        spanp =3D (char *)delim;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        do</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if ((sc =3D *spanp++) =3D=
=3D c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(c =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           s =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    s[-1] =3D &#39;\0&#39;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                *last =3D s;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                return (tok);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        } while (sc !=3D 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* NOTREACHED */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span>\ No newline at end of file</span><br><=
span>diff --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh</span><br><=
span>index 6532b86=2E=2E9e6f95c 100644</span><br><span>--- a/src/compat/com=
pat=2Eh</span><br><span>+++ b/src/compat/compat=2Eh</span><br><span>@@ -61,=
4 +61,9 @@</span><br><span> </span><br><span> #endif</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_STRTOK_R</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+strtok_r(char *s, const char *delim=
, char **last);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 #endif /* COMPAT_H */</span><br><span>diff --git a/src/openvpn/options_uti=
l=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index 47fe0bc=2E=2Ed72=
ea25c 100644</span><br><span>--- a/src/openvpn/options_util=2Ec</span><br><=
span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -48,7 +48,8 @@</=
span><br><span>         message =3D strstr(reason, &quot;]&quot;) + 1;</spa=
n><br><span>         /* null terminate the substring to only looks for flag=
s between [ and ] */</span><br><span>         *endofflags =3D &#39;\x00&#39=
;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char =
*token =3D strtok(m, &quot;[,&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        char *lasts =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const char *token =3D strtok_r(m, &quot=
;[,&quot;, &amp;lasts);</span><br><span>         while (token)</span><br><s=
pan>         {</span><br><span>             if (!strncmp(token, &quot;backo=
ff &quot;, strlen(&quot;backoff &quot;)))</span><br><span>@@ -81,7 +82,7 @@=
</span><br><span>             {</span><br><span>                 msg(D_PUSH=
_ERRORS, &quot;WARNING: unknown AUTH_FAIL,TEMP flag: %s&quot;, token);</spa=
n><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            token =3D strtok(NULL, &quot;[,&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            token =3D strtok_r(NULL, &=
quot;[,&quot;, &amp;lasts);</span><br><span>         }</span><br><span>    =
 }</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_mbedtls=
=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 8a0f7d2=2E=2E07caf=
08 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -318,9 +318,10 @@</sp=
an><br><span> </span><br><span>     /* Parse allowed ciphers, getting IDs *=
/</span><br><span>     int i =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span>     tmp_ciphers_=
orig =3D tmp_ciphers =3D string_alloc(ciphers, NULL);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    token =3D strtok(tmp_=
ciphers, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);</span>=
<br><span>     while (token)</span><br><span>     {</span><br><span>       =
  ctx-&gt;allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_transla=
te_cipher_name(token));</span><br><span>@@ -328,7 +329,7 @@</span><br><span=
>         {</span><br><span>             i++;</span><br><span>         }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        token =3D strtok=
(NULL, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><=
span>     }</span><br><span>     free(tmp_ciphers_orig);</span><br><span> }=
</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=
=2Ec</span><br><span>index 649665a=2E=2Ebaf5a95 100644</span><br><span>--- =
a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</sp=
an><br><span>@@ -100,7 +100,8 @@</span><br><span>     struct buffer new_lis=
t =3D alloc_buf(MAX_NCP_CIPHERS_LENGTH);</span><br><span> </span><br><span>=
     char *const tmp_ciphers =3D string_alloc(list, NULL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const char *token =3D strtok(tmp_c=
iphers, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &a=
mp;lasts);</span><br><span>     while (token)</span><br><span>     {</span>=
<br><span>         /*</span><br><span>@@ -174,7 +175,7 @@</span><br><span> =
                buf_puts(&amp;new_list, ovpn_cipher_name);</span><br><span>=
             }</span><br><span>         }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        token =3D strtok(NULL, &quot;:&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(N=
ULL, &quot;:&quot;, &amp;lasts);</span><br><span>     }</span><br><span> </=
span><br><span> </span><br><span>@@ -207,15 +208,16 @@</span><br><span> {</=
span><br><span>     char *tmp_ciphers =3D string_alloc(list, NULL);</span><=
br><span>     char *tmp_ciphers_orig =3D tmp_ciphers;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *tok=
en =3D strtok(tmp_ciphers, &quot;:&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_ciphers, &quo=
t;:&quot;, &amp;lasts);</span><br><span>     while (token)</span><br><span>=
     {</span><br><span>         if (0 =3D=3D strcmp(token, item))</span><br=
><span>         {</span><br><span>             break;</span><br><span>     =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        token =
=3D strtok(NULL, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</=
span><br><span>     }</span><br><span>     free(tmp_ciphers_orig);</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/ope=
nvpn/ssl_verify=2Ec</span><br><span>index 9197adf=2E=2E162f68f 100644</span=
><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openv=
pn/ssl_verify=2Ec</span><br><span>@@ -868,7 +868,8 @@</span><br><span>     =
    return false;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const char *client_method =3D strt=
ok(iv_sso, &quot;,&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char *client_method =3D strtok_r(iv_sso, &quot;,&quo=
t;, &amp;lasts);</span><br><span>     bool supported =3D false;</span><br><=
span> </span><br><span>     while (client_method)</span><br><span>@@ -878,7=
 +879,7 @@</span><br><span>             supported =3D true;</span><br><span=
>             break;</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        client_method =3D strtok(NULL, &quot;,&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        client=
_method =3D strtok_r(NULL, &quot;,&quot;, &amp;lasts);</span><br><span>    =
 }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span=
>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/ope=
nvpn/Makefile=2Eam</span><br><span>index 1128eb4=2E=2Ed861ef9 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ =
b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -107,6 +107,7 @=
@</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/compat/compat-strsep=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/compat/compat-strtok_r=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/cryptoapi=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_=
epoch=2Ec \</span><br><span>@@ -345,6 +346,7 @@</span><br><span> 	$(top_src=
dir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strsep=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/compat/compat-strtok_r=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/ssl_util=2Ec</span><br><span> </span><br><span> mbuf_testdriver_CFLAGS =
 =3D \</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">change 1679</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70560efd113308b=
7377424127eb2c1da4266371a </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1679 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>

</body></html>
--wppluVeuX6o=--


--===============1318835698950892666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1318835698950892666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1318835698950892666==--

