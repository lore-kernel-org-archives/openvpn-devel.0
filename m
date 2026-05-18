Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31512CD4F50
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Cc:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C3xCtGjw4UDxsdokDXC+H+eI1GdOjRqxkiTpMdXavro=; b=YbNHeb2E5yohiMKMdBC78T2S+H
	MpkK5rUUeHa1TaazIEV+49bN59DMBccAQxlZacFyGkKV2fyY63VDkm+Vgv5XwwuVK4umnFR3xG1tI
	05M2FQwYuN5u9ay/x9eWWpffFDO/Cc3GUubMLbfH5ws696ZfKrrAWbatw6vpBxs7GM+4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOxy9-0006vd-8O;
	Mon, 18 May 2026 13:25:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wOxxs-0006uj-Mi
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 13:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mXqlC2uV45Fkaq6+zko1lrVH1IIsRZRV9ecyS9+baSU=; b=HSpCyHBviq2V0Q2A7c3mQmAVs5
 Mb/TiPJrLRuOdLBOYLNhcyukL50BZ1SgkneLW3ahvSPt8GMn6NYFVBLHgtsPlQhmhEV8LZDHBQ/PD
 tHgYT2qlDDEw2rneJPwPAX6CFmK69xK44dA/YS6rPQhzLPAzLqQTMDhJzZamw9EQrifk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mXqlC2uV45Fkaq6+zko1lrVH1IIsRZRV9ecyS9+baSU=; b=P
 uqlbxOy8ZJEeb4zBDE3KIJghb17fQrF1RzrLN5HgUEWHlZ/GeWLpzofK7gAUHjtV5r+jxWN+baMEJ
 6NANnqthIlfo07Pt2Gy4j/2yPk0s59gzNDfqbWOZZ0pwdZ4FH/fRo81GNj7tmwMCPWlfSeccHz+GL
 rwnR3JPWWp9n0a2s=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wOxxo-0000Cu-OH for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 13:25:00 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-67c2d57a5ceso3848673a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 06:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779110690; x=1779715490; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mXqlC2uV45Fkaq6+zko1lrVH1IIsRZRV9ecyS9+baSU=;
 b=P5SgdspaL3EneKvfhj3CL0iFdRIkebHG0DOeqRhjWcdvR76kYwklcMwkjfCP7bPtB6
 r05Vv97lT9/HAt5aYoEBIGbtaXbb/n+2HiKgNnRh60t9wmbdDZIrVQrfgDFZl9kLWR7g
 K0kF4Xs/IKdWJjeB6zuLpOkpWqO2nq2EcbG8i/SqiaTLjn7DZtM/3ApmBTaLp0JChZlj
 jQzAMBSlWCgPIQ2ENZnbzyrxDVNGe5GP8SqqFHJ8Sd8mmvUTvt60K0AqNZzCnC1Ng8oP
 Cq0Y1DQPqTPquPkfGSetZOZmJ3u+DfY5Eb+puBASXUvhUIZmNRZuyctS8o8E5HD3RI6p
 pDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779110690; x=1779715490;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mXqlC2uV45Fkaq6+zko1lrVH1IIsRZRV9ecyS9+baSU=;
 b=Vd9LHPdQUOCjSxmY7z+gI8kpgk5bY3M4pqLqoC0LoBqyvrhfBSBm15FfKnTqVUJSe6
 J0+t7kkCZiVb9Qpi1ZgFckEimYSzyBTZh1eGAEDkOr+dfj350XtxITmdh1L7nANSGUwM
 cqs0LKZMMFzC+FFiqCXcZWEUdwK2TpijiDA0QHViCEZLxhV/wHnPTQmpWS/2MJM3B0HS
 BdP6vT5d4BEN6PKuPK0hasVxwjL3w+/TqS54aLfBkQSIHm9tLy/GpE8AI3VaEYiOAbNg
 h4F3+KPmnUcKGpa8I8PvfA26K9tUcrvuAqQHDgwb91yJwERCQ3A6p9PYXhVL+lkfmq7g
 ld+w==
X-Gm-Message-State: AOJu0YzUNF7R35ItE3UFFNHsD930w0q6xdwR/2bKcRSjaCMKQm1jd1Mn
 xUweMjl/t1y9aZCG8cRH31RYceRBeCVGM5W+qdajTmNgKmiUCPv+ZD9unvVmgliTAHobw757k/x
 Z2Fs5gYIhFLMlcdI8Tux+5374zSQTHAFsJNIYK1B7dKjF4S5DTQ//Lup2g51M4hBq6n3JGZ0pj8
 7nP8M2TQ==
X-Gm-Gg: Acq92OGojYwXOLx8z3S6gDlqadxNK2F7lYlenkRNoGTaIn2fc7bpVb7hBKpXLjgNUum
 QyyclzvoZ8QMaKBc/UYpb8wR0MKR+PcAO+HBi895WjLVTwOPL8oHKPSLM8u3zAqH5TP+t3Ac0ME
 UZ1HL+HYGv+7OLXRNywUSyCBtHxZPmxWgE/fZXejeyx+E3tZiPcr4X7afZLWsYnCZHl6U7RdA9m
 O3dHj180VzPWvdnsHgOhLhs23a0SSRsXvYLLsRErtYRBxHoV67RWMV6VcsfAK+rYfMJn06NEHSz
 H2Q1uZyOzgN1dMgOTrgoji0VkE1CDU4iIvQtb5+p9zXe/awohkb4LHoO91Y6vSPm1M28QTNzzNu
 ifYne7k4bcLptJYZGf886Zkm4NwnMfgnNeyVRNpK98kEVZrZZp3Nab9uX6x+nkkQpC0hrIvJLEp
 Dnp7hgfKz37yieIAUYXOQ0coy00lJ+p3yvIi2vDKLAjDJrp9u7YJBe7krzvqRss2WAdMEesOLNx
 7ixWhus7hRXIZ59sdXtuBBbuPFuDIxvGdRYOCm1ARqBYxliGe2RHUXRDDHji3PxSnV/lIehruCV
 oWHISEI1Ztey9B2tKnuoCTXi
X-Received: by 2002:a17:906:a34b:20b0:bcc:9130:69ee with SMTP id
 a640c23a62f3a-bd517950661mr638371766b.32.1779110233538; 
 Mon, 18 May 2026 06:17:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17ec2sm34459051f8f.24.2026.05.18.06.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 06:17:12 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 18 May 2026 13:17:08 +0000
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 417fd4e20465e3d6692640ceaf38f567ac0f9a1c
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a516e8bacb9d5168f39154b1eab67fa9ed1c6f9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wOxxo-0000Cu-OH
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============8724471943319361939=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8724471943319361939==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M6+tFKSccEE="; charset=UTF-8

--M6+tFKSccEE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#3)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1679?usp=3Demail )


Change subject: Replace strtok with st=
rtok_r
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Repl=
ace strtok with strtok_r

This dos not change anything in our source code b=
ut makes compiling
with newer Android NDKs (version 30 pre release) -Werror=
 safe again
as it has started throwing warning on this=2E

The compat versi=
on is taken from current FreeBSD (commit dc36d6f9bb1)
src/lib/libc/string/s=
trtok=2Ec and reformatted to our clang standard=2E

Change-Id: I70560efd113=
308b7377424127eb2c1da4266371a
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eo=
rg>
---
M CMakeLists=2Etxt
M configure=2Eac
M src/compat/Makefile=2Eam
A sr=
c/compat/compat-strtok_r=2Ec
M src/compat/compat=2Eh
M src/openvpn/options_=
util=2Ec
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/open=
vpn/ssl_verify=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
10 files change=
d, 130 insertions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/79/1679/3

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 715d02c=2E=2E6ab7c10 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -248,6 +248,7 @@
 check_symbol_exists(chsize io=
=2Eh HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource=2Eh HAVE_GETR=
LIMIT)
 check_symbol_exists(strsep string=2Eh HAVE_STRSEP)
+check_symbol_ex=
ists(strtok_r string=2Eh HAVE_STRTOK_R)
 
 # Some OS (e=2Eg=2E FreeBSD) nee=
d some basic headers to allow
 # including network headers
@@ -413,6 +414,7=
 @@
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
@@ -733,7 +735,8 @@
             src/openvpn/platform=2Ec
            =
 src/openvpn/win32-util=2Ec
             src/compat/compat-gettimeofday=2Ec=

-            )
+            src/compat/compat-strsep=2Ec
+        )
 
    =
     add_library_deps(${test_name})
         target_link_libraries(${test_n=
ame} PUBLIC ${CMOCKA_LIBRARIES})
diff --git a/configure=2Eac b/configure=2E=
ac
index e19d651=2E=2E188f8fa 100644
--- a/configure=2Eac
+++ b/configure=
=2Eac
@@ -568,7 +568,7 @@
 	setgroups flock gettimeofday \
 	setsid chdir \=

 	chsize ftruncate execve getpeereid basename dirname \
-	epoll_create str=
sep \
+	epoll_create strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff --git a/sr=
c/compat/Makefile=2Eam b/src/compat/Makefile=2Eam
index 69b2990=2E=2E22867b=
3 100644
--- a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefile=2Eam
@@ -=
20,4 +20,5 @@
 	compat-basename=2Ec \
 	compat-gettimeofday=2Ec \
 	compat-=
daemon=2Ec \
-	compat-strsep=2Ec
\ No newline at end of file
+	compat-strse=
p=2Ec \
+	compat-strtok_r=2Ec
\ No newline at end of file
diff --git a/src/=
compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=2Ec
new file mode 1=
00644
index 0000000=2E=2Edebcdd3
--- /dev/null
+++ b/src/compat/compat-strt=
ok_r=2Ec
@@ -0,0 +1,101 @@
+/*-
+ * SPDX-License-Identifier: BSD-3-Clause
+=
 *
+ * Copyright (c) 1998 Softweyr LLC=2E  All rights reserved=2E
+ *
+ * s=
trtok_r, from Berkeley strtok
+ * Oct 13, 1998 by Wes Peters <wes@softweyr=
=2Ecom>
+ *
+ * Copyright (c) 1988, 1993
+ *      The Regents of the Univer=
sity of California=2E  All rights reserved=2E
+ *
+ * Redistribution and us=
e in source and binary forms, with or without
+ * modification, are permitt=
ed provided that the following conditions
+ * are met:
+ * 1=2E Redistribut=
ions of source code must retain the above copyright
+ *    notices, this li=
st of conditions and the following disclaimer=2E
+ * 2=2E Redistributions i=
n binary form must reproduce the above copyright
+ *    notices, this list =
of conditions and the following disclaimer in the
+ *    documentation and/=
or other materials provided with the distribution=2E
+ * 3=2E Neither the n=
ame of the University nor the names of its contributors
+ *    may be used =
to endorse or promote products derived from this software
+ *    without sp=
ecific prior written permission=2E
+ *
+ * THIS SOFTWARE IS PROVIDED BY SOF=
TWEYR LLC, THE REGENTS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IM=
PLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES=
 OF MERCHANTABILITY AND FITNESS FOR A
+ * PARTICULAR PURPOSE ARE DISCLAIMED=
=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE
+ * REGENTS, OR CONTRIBUTORS BE LI=
ABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSE=
QUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
+ * TO, PROCUREMENT OF SUBSTIT=
UTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTER=
RUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONT=
RACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARI=
SING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE=
 POSSIBILITY OF SUCH DAMAGE=2E
+ */
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#ifndef HAVE_STRTOK_R
+#include <string=2Eh>
+
+char *
+st=
rtok_r(char *s, const char *delim, char **last)
+{
+    char *spanp, *tok;
=
+    int c, sc;
+
+    if (s =3D=3D NULL && (s =3D *last) =3D=3D NULL)
+   =
 {
+        return (NULL);
+    }
+
+/*
+ * Skip (span) leading delimiters =
(s +=3D strspn(s, delim), sort of)=2E
+ */
+cont:
+    c =3D *s++;
+    for=
 (spanp =3D (char *)delim; (sc =3D *spanp++) !=3D 0;)
+    {
+        if (c=
 =3D=3D sc)
+        {
+            goto cont;
+        }
+    }
+
+    if =
(c =3D=3D 0)
+    { /* no non-delimiter characters */
+        *last =3D NU=
LL;
+        return (NULL);
+    }
+    tok =3D s - 1;
+
+    /*
+     * Sc=
an token (scan for delimiters: s +=3D strcspn(s, delim), sort of)=2E
+     =
* Note that delim must have one NUL; we stop if we see that, too=2E
+     *=
/
+    for (;;)
+    {
+        c =3D *s++;
+        spanp =3D (char *)deli=
m;
+        do
+        {
+            if ((sc =3D *spanp++) =3D=3D c)
+   =
         {
+                if (c =3D=3D 0)
+                {
+           =
         s =3D NULL;
+                }
+                else
+            =
    {
+                    s[-1] =3D '\0';
+                }
+            =
    *last =3D s;
+                return (tok);
+            }
+        } w=
hile (sc !=3D 0);
+    }
+    /* NOTREACHED */
+}
+#endif
\ No newline at e=
nd of file
diff --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh
index=
 6532b86=2E=2E9e6f95c 100644
--- a/src/compat/compat=2Eh
+++ b/src/compat/c=
ompat=2Eh
@@ -61,4 +61,9 @@
 
 #endif
 
+#ifndef HAVE_STRTOK_R
+char *
+str=
tok_r(char *s, const char *delim, char **last);
+#endif
+
 #endif /* COMPAT=
_H */
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=
=2Ec
index 47fe0bc=2E=2Efbc64fa 100644
--- a/src/openvpn/options_util=2Ec
+=
++ b/src/openvpn/options_util=2Ec
@@ -48,7 +48,8 @@
         message =3D st=
rstr(reason, "]") + 1;
         /* null terminate the substring to only loo=
ks for flags between [ and ] */
         *endofflags =3D '\x00';
-        c=
onst char *token =3D strtok(m, "[,");
+        char *lasts;
+        const =
char *token =3D strtok_r(m, "[,", &lasts);
         while (token)
         =
{
             if (!strncmp(token, "backoff ", strlen("backoff ")))
@@ -81,=
7 +82,7 @@
             {
                 msg(D_PUSH_ERRORS, "WARNING: unk=
nown AUTH_FAIL,TEMP flag: %s", token);
             }
-            token =
=3D strtok(NULL, "[,");
+            token =3D strtok_r(NULL, "[,", &lasts)=
;
         }
     }
 
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvp=
n/ssl_mbedtls=2Ec
index 8a0f7d2=2E=2E7f0af3f 100644
--- a/src/openvpn/ssl_m=
bedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -318,9 +318,10 @@
 
     /*=
 Parse allowed ciphers, getting IDs */
     int i =3D 0;
+    char *lasts;
=
     tmp_ciphers_orig =3D tmp_ciphers =3D string_alloc(ciphers, NULL);
 
- =
   token =3D strtok(tmp_ciphers, ":");
+    token =3D strtok_r(tmp_ciphers,=
 ":", &lasts);
     while (token)
     {
         ctx->allowed_ciphers[i] =
=3D mbedtls_ssl_get_ciphersuite_id(tls_translate_cipher_name(token));
@@ -3=
28,7 +329,7 @@
         {
             i++;
         }
-        token =3D s=
trtok(NULL, ":");
+        token =3D strtok_r(NULL, ":", &lasts);
     }
  =
   free(tmp_ciphers_orig);
 }
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/op=
envpn/ssl_ncp=2Ec
index 649665a=2E=2E33f33ef 100644
--- a/src/openvpn/ssl_n=
cp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -100,7 +100,8 @@
     struct buffer=
 new_list =3D alloc_buf(MAX_NCP_CIPHERS_LENGTH);
 
     char *const tmp_cip=
hers =3D string_alloc(list, NULL);
-    const char *token =3D strtok(tmp_ci=
phers, ":");
+    char *lasts;
+    const char *token =3D strtok_r(tmp_ciph=
ers, ":", &lasts);
     while (token)
     {
         /*
@@ -174,7 +175,7 @=
@
                 buf_puts(&new_list, ovpn_cipher_name);
             }
  =
       }
-        token =3D strtok(NULL, ":");
+        token =3D strtok_r(=
NULL, ":", &lasts);
     }
 
 
@@ -207,15 +208,16 @@
 {
     char *tmp_ciph=
ers =3D string_alloc(list, NULL);
     char *tmp_ciphers_orig =3D tmp_ciphe=
rs;
+    char *lasts;
 
-    const char *token =3D strtok(tmp_ciphers, ":")=
;
+    const char *token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while=
 (token)
     {
         if (0 =3D=3D strcmp(token, item))
         {
     =
        break;
         }
-        token =3D strtok(NULL, ":");
+        to=
ken =3D strtok_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 
=
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index =
0804d2d=2E=2E8c6e2bc 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/open=
vpn/ssl_verify=2Ec
@@ -868,7 +868,8 @@
         return false;
     }
 
-   =
 const char *client_method =3D strtok(iv_sso, ",");
+    char *lasts;
+    =
const char *client_method =3D strtok_r(iv_sso, ",", &lasts);
     bool supp=
orted =3D false;
 
     while (client_method)
@@ -878,7 +879,7 @@
         =
    supported =3D true;
             break;
         }
-        client_meth=
od =3D strtok(NULL, ",");
+        client_method =3D strtok_r(NULL, ",", &l=
asts);
     }
 
     gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/Ma=
kefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 1128eb4=2E=2Ed86=
1ef9 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_t=
ests/openvpn/Makefile=2Eam
@@ -107,6 +107,7 @@
 	$(top_srcdir)/src/openvpn/=
base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/c=
ompat/compat-strsep=2Ec \
+	$(top_srcdir)/src/compat/compat-strtok_r=2Ec \
=
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=
api=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
@@ -345,6 +346,7 @=
@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/wi=
n32-util=2Ec \
 	$(top_srcdir)/src/compat/compat-strsep=2Ec \
+	$(top_srcdi=
r)/src/compat/compat-strtok_r=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2E=
c
 
 mbuf_testdriver_CFLAGS  =3D \

-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1679?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
Gerrit-Change-N=
umber: 1679
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=


--M6+tFKSccEE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Replace strtok with strtok_r<br><br>This dos not change anything =
in our source code but makes compiling<br>with newer Android NDKs (version =
30 pre release) -Werror safe again<br>as it has started throwing warning on=
 this=2E<br><br>The compat version is taken from current FreeBSD (commit dc=
36d6f9bb1)<br>src/lib/libc/string/strtok=2Ec and reformatted to our clang s=
tandard=2E<br><br>Change-Id: I70560efd113308b7377424127eb2c1da4266371a<br>S=
igned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeList=
s=2Etxt<br>M configure=2Eac<br>M src/compat/Makefile=2Eam<br>A src/compat/c=
ompat-strtok_r=2Ec<br>M src/compat/compat=2Eh<br>M src/openvpn/options_util=
=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src=
/openvpn/ssl_verify=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>10 f=
iles changed, 130 insertions(+), 13 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/1679/3=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>i=
ndex 715d02c=2E=2E6ab7c10 100644</span><br><span>--- a/CMakeLists=2Etxt</sp=
an><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -248,6 +248,7 @@</sp=
an><br><span> check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)</span><br><spa=
n> check_symbol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)</span><br=
><span> check_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(strtok_r string=
=2Eh HAVE_STRTOK_R)</span><br><span> </span><br><span> # Some OS (e=2Eg=2E =
FreeBSD) need some basic headers to allow</span><br><span> # including netw=
ork headers</span><br><span>@@ -413,6 +414,7 @@</span><br><span>     src/co=
mpat/compat-dirname=2Ec</span><br><span>     src/compat/compat-gettimeofday=
=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    src/compat/compat-strtok_r=2Ec</span=
><br><span>     src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=
=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><span>@@ -733,7 =
+735,8 @@</span><br><span>             src/openvpn/platform=2Ec</span><br><=
span>             src/openvpn/win32-util=2Ec</span><br><span>             s=
rc/compat/compat-gettimeofday=2Ec</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            )</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            src/compat/compat-strsep=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        )</span><br><span> </span><br><span>    =
     add_library_deps(${test_name})</span><br><span>         target_link_li=
braries(${test_name} PUBLIC ${CMOCKA_LIBRARIES})</span><br><span>diff --git=
 a/configure=2Eac b/configure=2Eac</span><br><span>index e19d651=2E=2E188f8=
fa 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/config=
ure=2Eac</span><br><span>@@ -568,7 +568,7 @@</span><br><span> 	setgroups fl=
ock gettimeofday \</span><br><span> 	setsid chdir \</span><br><span> 	chsiz=
e ftruncate execve getpeereid basename dirname \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	epoll_create strsep \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	epoll_create strsep strtok_r \</span><br><sp=
an> ])</span><br><span> </span><br><span> AC_CHECK_LIB(</span><br><span>dif=
f --git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam</span><br><sp=
an>index 69b2990=2E=2E22867b3 100644</span><br><span>--- a/src/compat/Makef=
ile=2Eam</span><br><span>+++ b/src/compat/Makefile=2Eam</span><br><span>@@ =
-20,4 +20,5 @@</span><br><span> 	compat-basename=2Ec \</span><br><span> 	co=
mpat-gettimeofday=2Ec \</span><br><span> 	compat-daemon=2Ec \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	compat-strsep=2Ec</span><br><span>=
\ No newline at end of file</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	compat-strsep=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	compat-strtok_r=2Ec</span><br><span>\ No newline at end of file</=
span><br><span>diff --git a/src/compat/compat-strtok_r=2Ec b/src/compat/com=
pat-strtok_r=2Ec</span><br><span>new file mode 100644</span><br><span>index=
 0000000=2E=2Edebcdd3</span><br><span>--- /dev/null</span><br><span>+++ b/s=
rc/compat/compat-strtok_r=2Ec</span><br><span>@@ -0,0 +1,101 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*-</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * SPDX-License-Identifier: BSD-3-Clause</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c) 1998 Softweyr LLC=2E  Al=
l rights reserved=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * strtok_r, fro=
m Berkeley strtok</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Oct 13, 1998 by Wes Peters &lt;wes@softweyr=2Ecom&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Copyright (c) 1988, 1993</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *      The Regents of the University of Californ=
ia=2E  All rights reserved=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Redi=
stribution and use in source and binary forms, with or without</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * modification, are permitted p=
rovided that the following conditions</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * are met:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * 1=2E Redistributions of source code must retain the above copy=
right</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    notices,=
 this list of conditions and the following disclaimer=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * 2=2E Redistributions in binary form=
 must reproduce the above copyright</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *    notices, this list of conditions and the following di=
sclaimer in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
  documentation and/or other materials provided with the distribution=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 3=2E Neither the na=
me of the University nor the names of its contributors</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *    may be used to endorse or promote =
products derived from this software</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *    without specific prior written permission=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * THIS SOFTWARE IS PROVIDED BY SOFTWEYR LLC,=
 THE REGENTS AND CONTRIBUTORS</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * ``AS IS&#39;&#39; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLU=
DING, BUT NOT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * LIM=
ITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * PARTICULAR PURPOSE ARE =
DISCLAIMED=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * REGENTS, OR CONTRIBUTORS BE LIABLE FOR AN=
Y DIRECT, INDIRECT, INCIDENTAL,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT=
 NOT LIMITED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TO, =
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * PROFITS; OR BUSINESS INTE=
RRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILI=
TY, OR TORT (INCLUDING</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SOFTWARE, EVEN IF A=
DVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAV=
E_STRTOK_R</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+strtok_r(char *s, const char *del=
im, char **last)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *spanp, *tok=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int c, sc;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (s =3D=3D NULL &amp;&amp; (s =3D *=
last) =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
(NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Skip (span) leading delimiters (s +=3D strspn(s, delim), so=
rt of)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+cont:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    c =3D *s++;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (spanp =3D (char *)delim; (sc =3D *s=
panp++) !=3D 0;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c =3D=
=3D sc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto cont;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (c =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    { /* no non-delimiter characters */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        *last =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return (NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tok =3D s - 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* Scan token (scan for delimiters: s +=3D strcspn(s, delim), sort of)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Note that delim=
 must have one NUL; we stop if we see that, too=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (;;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      c =3D *s++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      spanp =3D (char *)delim;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        do</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if ((sc =3D *spanp++) =3D=3D c)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (c =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    s =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    s[-1] =3D &#39;\0&#39=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                *la=
st =3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      return (tok);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  } while (sc !=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* NOTR=
EACHED */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>\ No =
newline at end of file</span><br><span>diff --git a/src/compat/compat=2Eh b=
/src/compat/compat=2Eh</span><br><span>index 6532b86=2E=2E9e6f95c 100644</s=
pan><br><span>--- a/src/compat/compat=2Eh</span><br><span>+++ b/src/compat/=
compat=2Eh</span><br><span>@@ -61,4 +61,9 @@</span><br><span> </span><br><s=
pan> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifndef HAVE_STRTOK_R</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
trtok_r(char *s, const char *delim, char **last);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> #endif /* COMPAT_H */</span><br><span>di=
ff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</spa=
n><br><span>index 47fe0bc=2E=2Efbc64fa 100644</span><br><span>--- a/src/ope=
nvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</s=
pan><br><span>@@ -48,7 +48,8 @@</span><br><span>         message =3D strstr=
(reason, &quot;]&quot;) + 1;</span><br><span>         /* null terminate the=
 substring to only looks for flags between [ and ] */</span><br><span>     =
    *endofflags =3D &#39;\x00&#39;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        const char *token =3D strtok(m, &quot;[,&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *lasts;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *tok=
en =3D strtok_r(m, &quot;[,&quot;, &amp;lasts);</span><br><span>         wh=
ile (token)</span><br><span>         {</span><br><span>             if (!st=
rncmp(token, &quot;backoff &quot;, strlen(&quot;backoff &quot;)))</span><br=
><span>@@ -81,7 +82,7 @@</span><br><span>             {</span><br><span>   =
              msg(D_PUSH_ERRORS, &quot;WARNING: unknown AUTH_FAIL,TEMP flag=
: %s&quot;, token);</span><br><span>             }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            token =3D strtok(NULL, &quot;[,&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            to=
ken =3D strtok_r(NULL, &quot;[,&quot;, &amp;lasts);</span><br><span>       =
  }</span><br><span>     }</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>in=
dex 8a0f7d2=2E=2E7f0af3f 100644</span><br><span>--- a/src/openvpn/ssl_mbedt=
ls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@=
 -318,9 +318,10 @@</span><br><span> </span><br><span>     /* Parse allowed =
ciphers, getting IDs */</span><br><span>     int i =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    char *lasts;</span><br><span>    =
 tmp_ciphers_orig =3D tmp_ciphers =3D string_alloc(ciphers, NULL);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    token =
=3D strtok(tmp_ciphers, &quot;:&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp=
;lasts);</span><br><span>     while (token)</span><br><span>     {</span><b=
r><span>         ctx-&gt;allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite=
_id(tls_translate_cipher_name(token));</span><br><span>@@ -328,7 +329,7 @@<=
/span><br><span>         {</span><br><span>             i++;</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t=
oken =3D strtok(NULL, &quot;:&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;last=
s);</span><br><span>     }</span><br><span>     free(tmp_ciphers_orig);</sp=
an><br><span> }</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/=
openvpn/ssl_ncp=2Ec</span><br><span>index 649665a=2E=2E33f33ef 100644</span=
><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/=
ssl_ncp=2Ec</span><br><span>@@ -100,7 +100,8 @@</span><br><span>     struct=
 buffer new_list =3D alloc_buf(MAX_NCP_CIPHERS_LENGTH);</span><br><span> </=
span><br><span>     char *const tmp_ciphers =3D string_alloc(list, NULL);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *token =
=3D strtok(tmp_ciphers, &quot;:&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    char *lasts;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const char *token =3D strtok_r(tmp_ciphers, &quot;:&qu=
ot;, &amp;lasts);</span><br><span>     while (token)</span><br><span>     {=
</span><br><span>         /*</span><br><span>@@ -174,7 +175,7 @@</span><br>=
<span>                 buf_puts(&amp;new_list, ovpn_cipher_name);</span><br=
><span>             }</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        token =3D strtok(NULL, &quot;:&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D str=
tok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span>     }</span><br><s=
pan> </span><br><span> </span><br><span>@@ -207,15 +208,16 @@</span><br><sp=
an> {</span><br><span>     char *tmp_ciphers =3D string_alloc(list, NULL);<=
/span><br><span>     char *tmp_ciphers_orig =3D tmp_ciphers;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char *lasts;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *token=
 =3D strtok(tmp_ciphers, &quot;:&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_ciphers, &quot;=
:&quot;, &amp;lasts);</span><br><span>     while (token)</span><br><span>  =
   {</span><br><span>         if (0 =3D=3D strcmp(token, item))</span><br><=
span>         {</span><br><span>             break;</span><br><span>       =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        token =3D =
strtok(NULL, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span=
><br><span>     }</span><br><span>     free(tmp_ciphers_orig);</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn=
/ssl_verify=2Ec</span><br><span>index 0804d2d=2E=2E8c6e2bc 100644</span><br=
><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/s=
sl_verify=2Ec</span><br><span>@@ -868,7 +868,8 @@</span><br><span>         =
return false;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const char *client_method =3D strtok(i=
v_sso, &quot;,&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *lasts;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *client_method =3D strtok_r(iv_sso, &quot;,&quot;, &amp;last=
s);</span><br><span>     bool supported =3D false;</span><br><span> </span>=
<br><span>     while (client_method)</span><br><span>@@ -878,7 +879,7 @@</s=
pan><br><span>             supported =3D true;</span><br><span>            =
 break;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        client_method =3D strtok(NULL, &quot;,&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        client_method =3D s=
trtok_r(NULL, &quot;,&quot;, &amp;lasts);</span><br><span>     }</span><br>=
<span> </span><br><span>     gc_free(&amp;gc);</span><br><span>diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 1128eb4=2E=2Ed861ef9 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -107,6 +107,7 @@</span><br><=
span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/comp=
at-strsep=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/compat/compat-strtok_r=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypt=
oapi=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</=
span><br><span>@@ -345,6 +346,7 @@</span><br><span> 	$(top_srcdir)/src/open=
vpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=
=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strsep=2Ec \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat=
/compat-strtok_r=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=
=2Ec</span><br><span> </span><br><span> mbuf_testdriver_CFLAGS  =3D \</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1679?usp=3Demail">change 1679</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I70560efd113308b7377424=
127eb2c1da4266371a </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1679 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--M6+tFKSccEE=--


--===============8724471943319361939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8724471943319361939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8724471943319361939==--

