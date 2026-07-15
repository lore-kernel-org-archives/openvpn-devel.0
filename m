Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FF1C44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAWY4HCWn2c6UMbhPLsJ5Qk+tW17iOOJMl96zyHnnUU=; b=d35D4jUDYlO0zz0l4+AE/s8C7p
	vEzssFwvDnHVVa5slpZ355L+5U8Tov3pnlvgS63TbMl741qUnqRMT+RYSuZShdLFQzaRBuHfvHzYE
	RLP0bF3V5Nc+4PlCaL0F3bjwDvH+UuayyYvTCTKRsd1WDxLGAL2FV6uKVPfXKkPC6+hA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk3YS-000534-BU;
	Wed, 15 Jul 2026 17:37:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk3YQ-00052x-UU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 17:37:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GOTU6EeASsGdXx4z+wKTznVHq13lVL8H6qER48KaluQ=; b=VbBwKJOLDPnHo9OI+kcKqVBbMr
 8+NxzbDdiGLtI0gB4ayPhC/MoWOoTEmDNJvyKHZwxwb4/qL4yD0ieQdHHCVJIWu6r77Lu6sVRAXcT
 Av07etTq8WZW90NbaGlGq3OFjfc9K16KC4U7z30SS+0K2NAV5M/1ImWqigI8vTqddWs8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GOTU6EeASsGdXx4z+wKTznVHq13lVL8H6qER48KaluQ=; b=L
 tk96N9bMYB5aDbHUWxu+mSFeAIE8lweWdSAJVVCMi6S+i5gXTKEYJsK2ot0TBj4Cr3hCV9bNWeUM5
 OaB+EpiZ8/jWzdw8iqItqa/DP3iyGnJGfII9DfqAPr8qzcOvwZ/q9RELM5GB+FgdIr69/D+R+MB81
 dbrDR4XIncuh9ej8=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk3YK-0007be-Mq for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 17:37:51 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493f431e317so18253485e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784137057; x=1784741857; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GOTU6EeASsGdXx4z+wKTznVHq13lVL8H6qER48KaluQ=;
 b=bdaABzEPQzKItJA9nNqbIf8x8S2Mjkjpgh5P/SHy4DtJuPK5VDakOJtomA8bzrLGqU
 60dypHB3/VTE37+vGf4ZXv+6KcmNGmz0ykGopnCQiCA1d7L6Ge3nu0VPSfiZfvb5yhyb
 +Fx2rQ7TrUraxXjhEN2dBhFMkFAHuMGXZB749GmDxUT9N0bOD9EoyPiQ9WYeYUJLMLiK
 czsXCy8ULuNNs8ndUVKAZH4EAZe+s5eIQxzSVxuoTt/oVma4+s4AC1q9/CbmhimnpAmi
 kEWVR2K/ScI45THPUZLfLvs6rQBUXI8pQsPOPzuGT4KpLpnp3ipGuqVpYmbh8yHg4Y4+
 0NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784137057; x=1784741857;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GOTU6EeASsGdXx4z+wKTznVHq13lVL8H6qER48KaluQ=;
 b=XpOTnnwJYnNz0maiWHpyU/OfZbO73ayERCUU8kxYU+6V4oicXaa1sYQ7xIWJMaTEU6
 DX/0FpPsJ+kPcb9uqxfuTuBeFw4iUi6iCKiQQhA85ED48bkJ3hjpI+/VLXrb9uFZothb
 lscG2ZHfzgglPMg45br0i4s6Dn2VVhB0LUI4y0IhPToGtwatUKjuIosT506HwOIcoQWE
 eJJEwi2l3GO4yx0YlwL0ZWaysQtLD2lO3DRfc1FtMBFrU3N5h7axwYjzu/LzhH7M4k8Z
 n7OujOAf3srcTxnEUMlqRC2DPmHK9Q8EAUuFK2+y1UlmWYlMd5iHVNYDbXHchhOpvw4S
 84eA==
X-Gm-Message-State: AOJu0Yxxtb9YaBgM11EFsjC9lGDqbQVTk203VF4mL86e6h0Rwn7IPS14
 d3RN85HtlqEhBUjj3qMZno6NFiNQUYs2fK7XxECc534xMDON1LuTnhv5oEcOdtwtrFxU6b50V4j
 WA9AGksOT1W1nBHE7DnCAlM0XZ5ktJkDlVF5rgo6tca8AM22my0VmIzVuUjka7g8iaPNXdWU+kx
 UrgcFfLw==
X-Gm-Gg: AfdE7cm6FfWqyYAXesNknDNcKMntQOR1NuPQn0vZ1Cwnnl1wctSSlKO/gCH0/PVdwC6
 qmDQyoKuv3cdV6FXarxp5gHc8jVIfZaLALRhzmWAhJE1K/drjFKO1WE1GBDOLFqzTFOBU3LpOWP
 5Le6h0ZlLajDpmTWGOAMNNEFmolI7NrTVJldxxT7QNJzp4e2IzIO80lKDrTWaqlku+ArvfPKWyG
 C/TKJ0U2EcRmuVrTH2lPCroyWGkT8mrKIMFokWelCGk357lnB6TVGG7uLmMXNPecBv7QGvp61lo
 ZcYIB1uGjrY8AEdUESU1iL96bcI9uJEJjfBHUoJkAJKdH1q9ZJ+BwysXRp4l8YarmJQT5K/OJzs
 8Oy0sAmhGR/H1zWBUC0gjPT8b7d4f94dlM4dyLaxvM2PdMJQ4fDpPlvHxgXWZORd/ScwrC+t0G7
 8z1YylGCRw+xABiwGC5xRpqJZQ1HQKy0hPoJQPUN3oJGtFh5QK439PG/B3fqV3Z+ktQqj+4vkoR
 OOFp88Nqnk6nNepRQT9SrRHJvc0ZkYqeMPbevJvg2Dhh/j926C/XRk1wJrVKxh+XipcYUJRsW07
 F7s=
X-Received: by 2002:a05:600c:4205:b0:493:f7bc:26e4 with SMTP id
 5b1f17b1804b1-493f8829970mr117342125e9.31.1784137056786; 
 Wed, 15 Jul 2026 10:37:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f635dsm173638995e9.12.2026.07.15.10.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:37:36 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 17:37:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 27df276eabdf87ad97ab88e8e84cc53d2bbc59c8
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ce544fd6f526eb80ab5104f1c9d0189a40776b4b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk3YK-0007be-Mq
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
Content-Type: multipart/mixed; boundary="===============5096052878595589013=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5096052878595589013==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sHglzUzQD+M="; charset=UTF-8

--sHglzUzQD+M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Replace strtok with strtok_r
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace strtok with strtok_r=


This does not change anything in our source code but makes compiling
with=
 newer Android NDKs (version 30 pre release) -Werror safe again
as it has s=
tarted throwing warning on this=2E

The compat version is taken from curren=
t FreeBSD (commit dc36d6f9bb1)
src/lib/libc/string/strtok=2Ec and reformatt=
ed to our clang standard=2E

Change-Id: I70560efd113308b7377424127eb2c1da42=
66371a
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1679
Message-Id: <20260708153107=2E60809-1-frank@lichtenheld=
=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg37538=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M CMakeLists=2Etxt
M configure=2Eac
M src/compat/Makefile=2Eam
A=
 src/compat/compat-strtok_r=2Ec
M src/compat/compat=2Eh
M src/openvpn/optio=
ns_util=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/o=
penvpn/ssl_verify=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
10 files cha=
nged, 130 insertions(+), 12 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/79/1679/6

diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt
index 23541a5d=2E=2E7473f15 100644
--- a/CMakeLists=2Et=
xt
+++ b/CMakeLists=2Etxt
@@ -248,6 +248,7 @@
 check_symbol_exists(chsize i=
o=2Eh HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource=2Eh HAVE_GET=
RLIMIT)
 check_symbol_exists(strsep string=2Eh HAVE_STRSEP)
+check_symbol_e=
xists(strtok_r string=2Eh HAVE_STRTOK_R)
 
 # Some OS (e=2Eg=2E FreeBSD) ne=
ed some basic headers to allow
 # including network headers
@@ -423,6 +424,=
7 @@
     src/compat/compat-dirname=2Ec
     src/compat/compat-gettimeofday=
=2Ec
     src/compat/compat-strsep=2Ec
+    src/compat/compat-strtok_r=2Ec
=
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=
=2Ec
@@ -743,6 +745,8 @@
             src/openvpn/platform=2Ec
            =
 src/openvpn/win32-util=2Ec
             src/compat/compat-gettimeofday=2Ec=

+            src/compat/compat-strsep=2Ec
+            src/compat/compat-s=
trtok_r=2Ec
             )
 
         add_library_deps(${test_name})
diff -=
-git a/configure=2Eac b/configure=2Eac
index e19d651=2E=2E188f8fa 100644
--=
- a/configure=2Eac
+++ b/configure=2Eac
@@ -568,7 +568,7 @@
 	setgroups flo=
ck gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeereid bas=
ename dirname \
-	epoll_create strsep \
+	epoll_create strsep strtok_r \
 ]=
)
 
 AC_CHECK_LIB(
diff --git a/src/compat/Makefile=2Eam b/src/compat/Makef=
ile=2Eam
index 69b2990=2E=2E22867b3 100644
--- a/src/compat/Makefile=2Eam
+=
++ b/src/compat/Makefile=2Eam
@@ -20,4 +20,5 @@
 	compat-basename=2Ec \
 	c=
ompat-gettimeofday=2Ec \
 	compat-daemon=2Ec \
-	compat-strsep=2Ec
\ No new=
line at end of file
+	compat-strsep=2Ec \
+	compat-strtok_r=2Ec
\ No newlin=
e at end of file
diff --git a/src/compat/compat-strtok_r=2Ec b/src/compat/c=
ompat-strtok_r=2Ec
new file mode 100644
index 0000000=2E=2Edebcdd3
--- /dev=
/null
+++ b/src/compat/compat-strtok_r=2Ec
@@ -0,0 +1,101 @@
+/*-
+ * SPDX-=
License-Identifier: BSD-3-Clause
+ *
+ * Copyright (c) 1998 Softweyr LLC=2E=
  All rights reserved=2E
+ *
+ * strtok_r, from Berkeley strtok
+ * Oct 13,=
 1998 by Wes Peters <wes@softweyr=2Ecom>
+ *
+ * Copyright (c) 1988, 1993
+=
 *      The Regents of the University of California=2E  All rights reserved=
=2E
+ *
+ * Redistribution and use in source and binary forms, with or with=
out
+ * modification, are permitted provided that the following conditions
=
+ * are met:
+ * 1=2E Redistributions of source code must retain the above =
copyright
+ *    notices, this list of conditions and the following disclai=
mer=2E
+ * 2=2E Redistributions in binary form must reproduce the above cop=
yright
+ *    notices, this list of conditions and the following disclaimer=
 in the
+ *    documentation and/or other materials provided with the distr=
ibution=2E
+ * 3=2E Neither the name of the University nor the names of its=
 contributors
+ *    may be used to endorse or promote products derived fro=
m this software
+ *    without specific prior written permission=2E
+ *
+ *=
 THIS SOFTWARE IS PROVIDED BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS
+ =
* ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * L=
IMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ * =
PARTICULAR PURPOSE ARE DISCLAIMED=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE
+=
 * REGENTS, OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,=

+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMIT=
ED
+ * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, =
OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY =
OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING=

+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ *=
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E
+ */
+#ifde=
f HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef HAVE_STRTOK_R
+#i=
nclude <string=2Eh>
+
+char *
+strtok_r(char *s, const char *delim, char **=
last)
+{
+    char *spanp, *tok;
+    int c, sc;
+
+    if (s =3D=3D NULL &=
& (s =3D *last) =3D=3D NULL)
+    {
+        return (NULL);
+    }
+
+/*
+ =
* Skip (span) leading delimiters (s +=3D strspn(s, delim), sort of)=2E
+ */=

+cont:
+    c =3D *s++;
+    for (spanp =3D (char *)delim; (sc =3D *spanp+=
+) !=3D 0;)
+    {
+        if (c =3D=3D sc)
+        {
+            goto c=
ont;
+        }
+    }
+
+    if (c =3D=3D 0)
+    { /* no non-delimiter ch=
aracters */
+        *last =3D NULL;
+        return (NULL);
+    }
+    to=
k =3D s - 1;
+
+    /*
+     * Scan token (scan for delimiters: s +=3D strc=
spn(s, delim), sort of)=2E
+     * Note that delim must have one NUL; we st=
op if we see that, too=2E
+     */
+    for (;;)
+    {
+        c =3D *s++=
;
+        spanp =3D (char *)delim;
+        do
+        {
+            if =
((sc =3D *spanp++) =3D=3D c)
+            {
+                if (c =3D=3D 0=
)
+                {
+                    s =3D NULL;
+                }
+ =
               else
+                {
+                    s[-1] =3D '\0';=

+                }
+                *last =3D s;
+                return (=
tok);
+            }
+        } while (sc !=3D 0);
+    }
+    /* NOTREACHE=
D */
+}
+#endif
\ No newline at end of file
diff --git a/src/compat/compat=
=2Eh b/src/compat/compat=2Eh
index 6532b86=2E=2E9e6f95c 100644
--- a/src/co=
mpat/compat=2Eh
+++ b/src/compat/compat=2Eh
@@ -61,4 +61,9 @@
 
 #endif
 
+=
#ifndef HAVE_STRTOK_R
+char *
+strtok_r(char *s, const char *delim, char **=
last);
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/openvpn/options_ut=
il=2Ec b/src/openvpn/options_util=2Ec
index 47fe0bc=2E=2Ed72ea25c 100644
--=
- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -48,=
7 +48,8 @@
         message =3D strstr(reason, "]") + 1;
         /* null t=
erminate the substring to only looks for flags between [ and ] */
         =
*endofflags =3D '\x00';
-        const char *token =3D strtok(m, "[,");
+  =
      char *lasts =3D NULL;
+        const char *token =3D strtok_r(m, "[,"=
, &lasts);
         while (token)
         {
             if (!strncmp(toke=
n, "backoff ", strlen("backoff ")))
@@ -81,7 +82,7 @@
             {
      =
           msg(D_PUSH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP flag: %s", t=
oken);
             }
-            token =3D strtok(NULL, "[,");
+         =
   token =3D strtok_r(NULL, "[,", &lasts);
         }
     }
 
diff --git a=
/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 8a0f7d2=2E=
=2E07caf08 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_m=
bedtls=2Ec
@@ -318,9 +318,10 @@
 
     /* Parse allowed ciphers, getting ID=
s */
     int i =3D 0;
+    char *lasts =3D NULL;
     tmp_ciphers_orig =3D=
 tmp_ciphers =3D string_alloc(ciphers, NULL);
 
-    token =3D strtok(tmp_c=
iphers, ":");
+    token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while=
 (token)
     {
         ctx->allowed_ciphers[i] =3D mbedtls_ssl_get_cipher=
suite_id(tls_translate_cipher_name(token));
@@ -328,7 +329,7 @@
         {
=
             i++;
         }
-        token =3D strtok(NULL, ":");
+       =
 token =3D strtok_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);=

 }
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index 64=
9665a=2E=2Ebaf5a95 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/s=
sl_ncp=2Ec
@@ -100,7 +100,8 @@
     struct buffer new_list =3D alloc_buf(MA=
X_NCP_CIPHERS_LENGTH);
 
     char *const tmp_ciphers =3D string_alloc(list=
, NULL);
-    const char *token =3D strtok(tmp_ciphers, ":");
+    char *la=
sts =3D NULL;
+    const char *token =3D strtok_r(tmp_ciphers, ":", &lasts)=
;
     while (token)
     {
         /*
@@ -174,7 +175,7 @@
               =
  buf_puts(&new_list, ovpn_cipher_name);
             }
         }
-       =
 token =3D strtok(NULL, ":");
+        token =3D strtok_r(NULL, ":", &lasts=
);
     }
 
 
@@ -207,15 +208,16 @@
 {
     char *tmp_ciphers =3D string_al=
loc(list, NULL);
     char *tmp_ciphers_orig =3D tmp_ciphers;
+    char *la=
sts =3D NULL;
 
-    const char *token =3D strtok(tmp_ciphers, ":");
+    c=
onst char *token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)=

     {
         if (0 =3D=3D strcmp(token, item))
         {
             =
break;
         }
-        token =3D strtok(NULL, ":");
+        token =3D =
strtok_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 
diff --g=
it a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 9197adf=
=2E=2E162f68f 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl=
_verify=2Ec
@@ -868,7 +868,8 @@
         return false;
     }
 
-    const =
char *client_method =3D strtok(iv_sso, ",");
+    char *lasts =3D NULL;
+  =
  const char *client_method =3D strtok_r(iv_sso, ",", &lasts);
     bool su=
pported =3D false;
 
     while (client_method)
@@ -878,7 +879,7 @@
       =
      supported =3D true;
             break;
         }
-        client_me=
thod =3D strtok(NULL, ",");
+        client_method =3D strtok_r(NULL, ",", =
&lasts);
     }
 
     gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/=
Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 1128eb4=2E=2Ed=
861ef9 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit=
_tests/openvpn/Makefile=2Eam
@@ -107,6 +107,7 @@
 	$(top_srcdir)/src/openvp=
n/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src=
/compat/compat-strsep=2Ec \
+	$(top_srcdir)/src/compat/compat-strtok_r=2Ec =
\
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/cryp=
toapi=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
@@ -345,6 +346,7=
 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/=
win32-util=2Ec \
 	$(top_srcdir)/src/compat/compat-strsep=2Ec \
+	$(top_src=
dir)/src/compat/compat-strtok_r=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=
=2Ec
 
 mbuf_testdriver_CFLAGS  =3D \

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1679?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
Gerrit-Chang=
e-Number: 1679
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--sHglzUzQD+M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Replace strtok with =
strtok_r<br><br>This does not change anything in our source code but makes =
compiling<br>with newer Android NDKs (version 30 pre release) -Werror safe =
again<br>as it has started throwing warning on this=2E<br><br>The compat ve=
rsion is taken from current FreeBSD (commit dc36d6f9bb1)<br>src/lib/libc/st=
ring/strtok=2Ec and reformatted to our clang standard=2E<br><br>Change-Id: =
I70560efd113308b7377424127eb2c1da4266371a<br>Signed-off-by: Arne Schwabe &l=
t;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679=
<br>Message-Id: &lt;20260708153107=2E60809-1-frank@lichtenheld=2Ecom&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg37538=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M configure=2Eac<br>M src/compat/=
Makefile=2Eam<br>A src/compat/compat-strtok_r=2Ec<br>M src/compat/compat=2E=
h<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M s=
rc/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M tests/unit_test=
s/openvpn/Makefile=2Eam<br>10 files changed, 130 insertions(+), 12 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/79/1679/6</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMa=
keLists=2Etxt</span><br><span>index 23541a5d=2E=2E7473f15 100644</span><br>=
<span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><=
br><span>@@ -248,6 +248,7 @@</span><br><span> check_symbol_exists(chsize io=
=2Eh HAVE_CHSIZE)</span><br><span> check_symbol_exists(getrlimit sys/resour=
ce=2Eh HAVE_GETRLIMIT)</span><br><span> check_symbol_exists(strsep string=
=2Eh HAVE_STRSEP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
eck_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)</span><br><span> </spa=
n><br><span> # Some OS (e=2Eg=2E FreeBSD) need some basic headers to allow<=
/span><br><span> # including network headers</span><br><span>@@ -423,6 +424=
,7 @@</span><br><span>     src/compat/compat-dirname=2Ec</span><br><span>  =
   src/compat/compat-gettimeofday=2Ec</span><br><span>     src/compat/compa=
t-strsep=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src=
/compat/compat-strtok_r=2Ec</span><br><span>     src/openvpn/argv=2Ec</span=
><br><span>     src/openvpn/argv=2Eh</span><br><span>     src/openvpn/base6=
4=2Ec</span><br><span>@@ -743,6 +745,8 @@</span><br><span>             src/=
openvpn/platform=2Ec</span><br><span>             src/openvpn/win32-util=2E=
c</span><br><span>             src/compat/compat-gettimeofday=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/compat/compat=
-strsep=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    src/compat/compat-strtok_r=2Ec</span><br><span>             )</span><br=
><span> </span><br><span>         add_library_deps(${test_name})</span><br>=
<span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index e1=
9d651=2E=2E188f8fa 100644</span><br><span>--- a/configure=2Eac</span><br><s=
pan>+++ b/configure=2Eac</span><br><span>@@ -568,7 +568,7 @@</span><br><spa=
n> 	setgroups flock gettimeofday \</span><br><span> 	setsid chdir \</span><=
br><span> 	chsize ftruncate execve getpeereid basename dirname \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	epoll_create strsep \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	epoll_create strsep strtok_r=
 \</span><br><span> ])</span><br><span> </span><br><span> AC_CHECK_LIB(</sp=
an><br><span>diff --git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2E=
am</span><br><span>index 69b2990=2E=2E22867b3 100644</span><br><span>--- a/=
src/compat/Makefile=2Eam</span><br><span>+++ b/src/compat/Makefile=2Eam</sp=
an><br><span>@@ -20,4 +20,5 @@</span><br><span> 	compat-basename=2Ec \</spa=
n><br><span> 	compat-gettimeofday=2Ec \</span><br><span> 	compat-daemon=2Ec=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	compat-strsep=2Ec<=
/span><br><span>\ No newline at end of file</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	compat-strsep=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	compat-strtok_r=2Ec</span><br><span>\ No newline =
at end of file</span><br><span>diff --git a/src/compat/compat-strtok_r=2Ec =
b/src/compat/compat-strtok_r=2Ec</span><br><span>new file mode 100644</span=
><br><span>index 0000000=2E=2Edebcdd3</span><br><span>--- /dev/null</span><=
br><span>+++ b/src/compat/compat-strtok_r=2Ec</span><br><span>@@ -0,0 +1,10=
1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*-</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * SPDX-License-Identifier: BSD=
-3-Clause</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c) 1998 Softw=
eyr LLC=2E  All rights reserved=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 strtok_r, from Berkeley strtok</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Oct 13, 1998 by Wes Peters &lt;wes@softweyr=2Ecom&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c) 1988, 1993</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *      The Regents of the Univer=
sity of California=2E  All rights reserved=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Redistribution and use in source and binary forms, with or with=
out</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * modification,=
 are permitted provided that the following conditions</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * are met:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * 1=2E Redistributions of source code must retai=
n the above copyright</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *    notices, this list of conditions and the following disclaimer=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 2=2E Redistribution=
s in binary form must reproduce the above copyright</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *    notices, this list of conditions an=
d the following disclaimer in the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *    documentation and/or other materials provided with the =
distribution=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 3=
=2E Neither the name of the University nor the names of its contributors</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    may be used to e=
ndorse or promote products derived from this software</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *    without specific prior written perm=
ission=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * THIS SOFTWARE IS PROVIDE=
D BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * ``AS IS&#39;&#39; AND ANY EXPRESS OR IMPLIED=
 WARRANTIES, INCLUDING, BUT NOT</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FI=
TNESS FOR A</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * PARTI=
CULAR PURPOSE ARE DISCLAIMED=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * REGENTS, OR CONTRIBUTOR=
S BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAG=
ES (INCLUDING, BUT NOT LIMITED</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,=
 DATA, OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * PROFITS=
; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * LIABILITY, WHETHER IN CONTRA=
CT, STRICT LIABILITY, OR TORT (INCLUDING</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF =
THE USE OF THIS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * S=
OFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef HAVE_STRTOK_R</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
ar *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strtok_r(char *=
s, const char *delim, char **last)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *spanp, *tok;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int c, sc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s =3D=3D NULL &a=
mp;&amp; (s =3D *last) =3D=3D NULL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return (NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Skip (span) leading delimiters (s +=3D str=
spn(s, delim), sort of)=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cont:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    c =3D *s++;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (spanp =3D (char *)=
delim; (sc =3D *spanp++) !=3D 0;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (c =3D=3D sc)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       goto cont;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (c =3D=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    { /* no non-delimiter characters */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        *last =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (NULL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    tok =3D s - 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * Scan token (scan for delimiters: s +=3D strcspn(s, delim),=
 sort of)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
Note that delim must have one NUL; we stop if we see that, too=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (;;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c =3D *s++;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        spanp =3D (char *)delim;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        do</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if ((sc =3D *spanp++) =3D=3D c)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (c =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    s =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    s[-1] =3D &=
#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       *last =3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                return (tok);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        } while (sc !=3D 0);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* NOTREACHED */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span>\ No newline at end of file</span><br><span>diff --git a/src/compat/co=
mpat=2Eh b/src/compat/compat=2Eh</span><br><span>index 6532b86=2E=2E9e6f95c=
 100644</span><br><span>--- a/src/compat/compat=2Eh</span><br><span>+++ b/s=
rc/compat/compat=2Eh</span><br><span>@@ -61,4 +61,9 @@</span><br><span> </s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifndef HAVE_STRTOK_R</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+strtok_r(char *s, const char *delim, char **last);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #endif /* COMPAT_H */</span><b=
r><span>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_uti=
l=2Ec</span><br><span>index 47fe0bc=2E=2Ed72ea25c 100644</span><br><span>--=
- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_=
util=2Ec</span><br><span>@@ -48,7 +48,8 @@</span><br><span>         message=
 =3D strstr(reason, &quot;]&quot;) + 1;</span><br><span>         /* null te=
rminate the substring to only looks for flags between [ and ] */</span><br>=
<span>         *endofflags =3D &#39;\x00&#39;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const char *token =3D strtok(m, &quot;[,&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char =
*lasts =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     const char *token =3D strtok_r(m, &quot;[,&quot;, &amp;lasts);</span><=
br><span>         while (token)</span><br><span>         {</span><br><span>=
             if (!strncmp(token, &quot;backoff &quot;, strlen(&quot;backoff=
 &quot;)))</span><br><span>@@ -81,7 +82,7 @@</span><br><span>             {=
</span><br><span>                 msg(D_PUSH_ERRORS, &quot;WARNING: unknown=
 AUTH_FAIL,TEMP flag: %s&quot;, token);</span><br><span>             }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            token =3D strt=
ok(NULL, &quot;[,&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            token =3D strtok_r(NULL, &quot;[,&quot;, &amp;lasts);</sp=
an><br><span>         }</span><br><span>     }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2E=
c</span><br><span>index 8a0f7d2=2E=2E07caf08 100644</span><br><span>--- a/s=
rc/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2E=
c</span><br><span>@@ -318,9 +318,10 @@</span><br><span> </span><br><span>  =
   /* Parse allowed ciphers, getting IDs */</span><br><span>     int i =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =
=3D NULL;</span><br><span>     tmp_ciphers_orig =3D tmp_ciphers =3D string_=
alloc(ciphers, NULL);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    token =3D strtok(tmp_ciphers, &quot;:&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    token =3D strtok_r(tmp_=
ciphers, &quot;:&quot;, &amp;lasts);</span><br><span>     while (token)</sp=
an><br><span>     {</span><br><span>         ctx-&gt;allowed_ciphers[i] =3D=
 mbedtls_ssl_get_ciphersuite_id(tls_translate_cipher_name(token));</span><b=
r><span>@@ -328,7 +329,7 @@</span><br><span>         {</span><br><span>    =
         i++;</span><br><span>         }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        token =3D strtok(NULL, &quot;:&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NU=
LL, &quot;:&quot;, &amp;lasts);</span><br><span>     }</span><br><span>    =
 free(tmp_ciphers_orig);</span><br><span> }</span><br><span>diff --git a/sr=
c/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index 64966=
5a=2E=2Ebaf5a95 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span>=
<br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -100,7 +100,8 @@=
</span><br><span>     struct buffer new_list =3D alloc_buf(MAX_NCP_CIPHERS_=
LENGTH);</span><br><span> </span><br><span>     char *const tmp_ciphers =3D=
 string_alloc(list, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const char *token =3D strtok(tmp_ciphers, &quot;:&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =
=3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);</span><br><span>     =
while (token)</span><br><span>     {</span><br><span>         /*</span><br>=
<span>@@ -174,7 +175,7 @@</span><br><span>                 buf_puts(&amp;ne=
w_list, ovpn_cipher_name);</span><br><span>             }</span><br><span> =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        toke=
n =3D strtok(NULL, &quot;:&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);=
</span><br><span>     }</span><br><span> </span><br><span> </span><br><span=
>@@ -207,15 +208,16 @@</span><br><span> {</span><br><span>     char *tmp_ci=
phers =3D string_alloc(list, NULL);</span><br><span>     char *tmp_ciphers_=
orig =3D tmp_ciphers;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *lasts =3D NULL;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const char *token =3D strtok(tmp_ciphers, &quot=
;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);</span><b=
r><span>     while (token)</span><br><span>     {</span><br><span>         =
if (0 =3D=3D strcmp(token, item))</span><br><span>         {</span><br><spa=
n>             break;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        token =3D strtok(NULL, &quot;:&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D str=
tok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span>     }</span><br><s=
pan>     free(tmp_ciphers_orig);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><spa=
n>index 9197adf=2E=2E162f68f 100644</span><br><span>--- a/src/openvpn/ssl_v=
erify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>=
@@ -868,7 +868,8 @@</span><br><span>         return false;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const char *client_method =3D strtok(iv_sso, &quot;,&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *clien=
t_method =3D strtok_r(iv_sso, &quot;,&quot;, &amp;lasts);</span><br><span> =
    bool supported =3D false;</span><br><span> </span><br><span>     while =
(client_method)</span><br><span>@@ -878,7 +879,7 @@</span><br><span>       =
      supported =3D true;</span><br><span>             break;</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
client_method =3D strtok(NULL, &quot;,&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        client_method =3D strtok_r(NULL, &quot;,=
&quot;, &amp;lasts);</span><br><span>     }</span><br><span> </span><br><sp=
an>     gc_free(&amp;gc);</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>index 1128eb4=2E=2Ed861ef9 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>@@ -107,6 +107,7 @@</span><br><span> 	$(top_srcdir)/=
src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strsep=2Ec \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat=
/compat-strtok_r=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/cryptoapi=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span>@@ -=
345,6 +346,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/compat/compat-strsep=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strtok_r=2Ec =
\</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec</span><br><span>=
 </span><br><span> mbuf_testdriver_CFLAGS  =3D \</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1679?usp=3Demail">change 1679</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1679?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1679 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--sHglzUzQD+M=--


--===============5096052878595589013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5096052878595589013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5096052878595589013==--

