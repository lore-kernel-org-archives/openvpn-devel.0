Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EA7CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 00:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Cc:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nFxfjb6tvfSMNvXkeeQUhr63pvDxw6YWTahkWEmV15o=; b=AfbVHJyIdb9EjXpIlyxD3iVQ2u
	cSXBRBZ9Qq2lWTOWuyta5Ro9CmGJ7OgIFPiHeug4fQ9F5jeFrqSuXyE3pHtrF6gBfA6UV5Eu/5PFH
	w/DjYNXtnUP0IQEv0mn+zaFWeDlM5TvZ7gdxIJtIW6p+SmIfbuct7KNxmpQs6KdEEgMQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOlvP-000465-Mp;
	Mon, 18 May 2026 00:33:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wOlvO-00045t-Jw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 00:33:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dOlx8RtU2IZGkTaYuCNBdAR209Ba0QWi+/KAMbUBuo0=; b=GC8y/l3Pxlp2m4QVt39ECyAsWb
 kKCIDJTCGjHmfSno1vuPOH/kgsP3q8sIGGY2sbUi3ODeqBFnE0mSTXKy/yQbXqyPkLc1HFbv7Zye9
 OneGmIDSXiQzQA9LJpJ1D9KPONyOwiRqfS6rQ51P85CE/RQ1iRS+244GzLEkwwqXw6RE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dOlx8RtU2IZGkTaYuCNBdAR209Ba0QWi+/KAMbUBuo0=; b=J
 nh+9vUGbK+x8OllmFnAPO9Kd+4mcraCcgF3Xxhj4ETzy0i5Bnr8MMmDh+yQqVEQC8VkUB7D2J2zhh
 X7bJX4gpUETJ7XrX4e7xV4OW/qdxlfXe+Nv8kpy7mSOz09uk/I8N34kI0NuiwXZUO7YTPBH8S+9J2
 Sge3/07OzkeFFjnM=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wOlvN-00038h-4D for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 00:33:39 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso20752905e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 17 May 2026 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779064406; x=1779669206; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dOlx8RtU2IZGkTaYuCNBdAR209Ba0QWi+/KAMbUBuo0=;
 b=KzQl2Law7waCsqpBAGZOFU2xedMp2yT1lN+Dsx6y0/Qbv0+wqYEMjMFPs2WFqdT0v0
 r47t0fpCZzaWlZSNaLhmGQvOsPaGYPgMou6oCSjJU5HbbaTajjWCdXuwDfsSmKRROoeT
 kbqIH0zWxQGpCqSS+kgJ0yMSiwKc9MyA3UMtjHepSlaU2Jvoi/yqWI6PPAD0A/Ozsz4+
 Qsw2EIk9LxXAx1IEr3YkOJ0xIahGrZbIQ3q30S9Lmo0MwoTqSIcLM3HIQpKHpxkC6Ah0
 8LORk0G5TohL5KD+6osL81CF4Odr1J0D2RPUq3UNLnyXVNYhHDOZ7+t6dXqaGilM+v2D
 f0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064406; x=1779669206;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dOlx8RtU2IZGkTaYuCNBdAR209Ba0QWi+/KAMbUBuo0=;
 b=TZV9wf4XdiWlTG9I0mAzKdsAwykI/uFY+q+R07ciaINxxgJGymd2rBKfaFohP0ahDS
 HhPddBLLs7xSVOoLB/MiTQmv76GgNW7xNPB8RY7hueL9MtLNuCziQfyPAe65EguwDuFN
 pG8PRX1RLPvhrGgRyihpT6X/arIsf2H7kOCz625O2Ll6jNrZW1tFQfKJdUJ3hvTwF1LO
 mkXlayhBqBf2hnXDAo1l+b4+nY68TTUvJO4VdhPX/zEoGfW46wIdsolAreGtMJmHw6Iv
 PWYE4BVKuzerjyxryzSC15xf4rf/t1N8/uuBHarTGyGl9mGf/hJ5e75tLE31Mlw2PL9e
 ZlPw==
X-Gm-Message-State: AOJu0YxD7PX7giHJypeCYIjhaix3I94ruOQy+5qijZireGYAY8caXbCZ
 pO9VhltlXiHUX8HkYhlMdlg/boMFjYtrq2OMKSRK+KJUDYQH3cQFlzlxX3uxty/hN73hLT80b21
 uFZHN8I4Mv4jbD5pmLe7qpHT6TX5sS8+x3TUSRduk01S6plEnWG76WNsBN8nzPimvnowHCP1rSW
 WkC37YTQ==
X-Gm-Gg: Acq92OHbfpT05Pa855mtC3oqadUXtQVJjBnaeAYRxjdH2Kl4XwHn5CpP9D0+y5MOycZ
 dM9wb10WOw/NzPpDewOn0pmczy5JdA6Pxlh4IJupPMAilIJVW/m3Jsyp87Y6qNd9nd5EYv6+7IR
 lpbAKpsOG79Z1YV2YYWVrxHCJJo0B9FBdxrdC3NH7UT6hO6kkgsSRrUd2IqrvRzOsrGBlC/Xkzx
 1pdz3pIOGi4bp/1NiSqOjSIC2a6WOWFtOMhVsxj5Xv3BTvIbbVGNWJkK4RCVljd4Rn3UaUFMZ8o
 NfZPdUFuFr2RfBtPuLf3hL89IQW2lb451HGk7KlpR1oS6+MXCIOkPq3/vEVZTlDDhNfadLfhHia
 acLrSsogHn8oDuOYKsh+ZaHoI7SlO7gHFRV2/fdkm25bgEZh6neuEfR9tUMF5UoTaMQA2vx0Wbj
 mYzAykQMSQ8crSsA8AhrBIuOQ5JqZLaQ3hH8TZHSLlcP7LD/ldpwmML5Bf69PskAz1SH0Ky3hit
 lYlvQPFxUocNlnwjESQnD8LXFVAcBJ+7CKF1Ns/359RdoXqnL/yRlb9ApIgUHL+KsATDbGoXWiv
 r4LywYO53MXXrwr1bYFkLH0m
X-Received: by 2002:a05:600d:8:b0:48f:e6b9:c740 with SMTP id
 5b1f17b1804b1-48fe6b9c811mr167146565e9.30.1779064405858; 
 Sun, 17 May 2026 17:33:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8344asm373341825e9.1.2026.05.17.17.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 17:33:25 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 18 May 2026 00:33:22 +0000
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 8292afaa7b96c0b8b5b80b5592829fec3a460ada
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb60480fdf88a0066c4775ca8aa208b216eaa444-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wOlvN-00038h-4D
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
Content-Type: multipart/mixed; boundary="===============5732258983685223441=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5732258983685223441==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RR3t7PZVpHs="; charset=UTF-8

--RR3t7PZVpHs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
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
A src/compat/compat-strtok_r=2E=
c
M src/compat/compat=2Eh
M src/openvpn/options_util=2Ec
M src/openvpn/ssl_=
mbedtls=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_verify=2Ec
8 files =
changed, 123 insertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/79/1679/2

diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt
index 715d02c=2E=2Edde7dc7 100644
--- a/CMakeLists=
=2Etxt
+++ b/CMakeLists=2Etxt
@@ -248,6 +248,7 @@
 check_symbol_exists(chsi=
ze io=2Eh HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource=2Eh HAVE=
_GETRLIMIT)
 check_symbol_exists(strsep string=2Eh HAVE_STRSEP)
+check_symb=
ol_exists(strtok_r string=2Eh HAVE_STRTOK_R)
 
 # Some OS (e=2Eg=2E FreeBSD=
) need some basic headers to allow
 # including network headers
diff --git =
a/configure=2Eac b/configure=2Eac
index e19d651=2E=2E188f8fa 100644
--- a/c=
onfigure=2Eac
+++ b/configure=2Eac
@@ -568,7 +568,7 @@
 	setgroups flock ge=
ttimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeereid basename=
 dirname \
-	epoll_create strsep \
+	epoll_create strsep strtok_r \
 ])
 
 =
AC_CHECK_LIB(
diff --git a/src/compat/compat-strtok_r=2Ec b/src/compat/comp=
at-strtok_r=2Ec
new file mode 100644
index 0000000=2E=2Edebcdd3
--- /dev/nu=
ll
+++ b/src/compat/compat-strtok_r=2Ec
@@ -0,0 +1,101 @@
+/*-
+ * SPDX-Lic=
ense-Identifier: BSD-3-Clause
+ *
+ * Copyright (c) 1998 Softweyr LLC=2E  A=
ll rights reserved=2E
+ *
+ * strtok_r, from Berkeley strtok
+ * Oct 13, 19=
98 by Wes Peters <wes@softweyr=2Ecom>
+ *
+ * Copyright (c) 1988, 1993
+ * =
     The Regents of the University of California=2E  All rights reserved=2E=

+ *
+ * Redistribution and use in source and binary forms, with or without=

+ * modification, are permitted provided that the following conditions
+ *=
 are met:
+ * 1=2E Redistributions of source code must retain the above cop=
yright
+ *    notices, this list of conditions and the following disclaimer=
=2E
+ * 2=2E Redistributions in binary form must reproduce the above copyri=
ght
+ *    notices, this list of conditions and the following disclaimer in=
 the
+ *    documentation and/or other materials provided with the distribu=
tion=2E
+ * 3=2E Neither the name of the University nor the names of its co=
ntributors
+ *    may be used to endorse or promote products derived from t=
his software
+ *    without specific prior written permission=2E
+ *
+ * TH=
IS SOFTWARE IS PROVIDED BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS
+ * `=
`AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMI=
TED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ * PAR=
TICULAR PURPOSE ARE DISCLAIMED=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE
+ * =
REGENTS, OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ =
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
=
+ * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
=
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
=
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ =
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SO=
FTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E
+ */
+#ifdef H=
AVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef HAVE_STRTOK_R
+#incl=
ude <string=2Eh>
+
+char *
+strtok_r(char *s, const char *delim, char **las=
t)
+{
+    char *spanp, *tok;
+    int c, sc;
+
+    if (s =3D=3D NULL && (=
s =3D *last) =3D=3D NULL)
+    {
+        return (NULL);
+    }
+
+/*
+ * S=
kip (span) leading delimiters (s +=3D strspn(s, delim), sort of)=2E
+ */
+c=
ont:
+    c =3D *s++;
+    for (spanp =3D (char *)delim; (sc =3D *spanp++) =
!=3D 0;)
+    {
+        if (c =3D=3D sc)
+        {
+            goto cont=
;
+        }
+    }
+
+    if (c =3D=3D 0)
+    { /* no non-delimiter chara=
cters */
+        *last =3D NULL;
+        return (NULL);
+    }
+    tok =
=3D s - 1;
+
+    /*
+     * Scan token (scan for delimiters: s +=3D strcsp=
n(s, delim), sort of)=2E
+     * Note that delim must have one NUL; we stop=
 if we see that, too=2E
+     */
+    for (;;)
+    {
+        c =3D *s++;
=
+        spanp =3D (char *)delim;
+        do
+        {
+            if ((=
sc =3D *spanp++) =3D=3D c)
+            {
+                if (c =3D=3D 0)
=
+                {
+                    s =3D NULL;
+                }
+   =
             else
+                {
+                    s[-1] =3D '\0';
+=
                }
+                *last =3D s;
+                return (to=
k);
+            }
+        } while (sc !=3D 0);
+    }
+    /* NOTREACHED =
*/
+}
+#endif
\ No newline at end of file
diff --git a/src/compat/compat=2E=
h b/src/compat/compat=2Eh
index 6532b86=2E=2E9e6f95c 100644
--- a/src/compa=
t/compat=2Eh
+++ b/src/compat/compat=2Eh
@@ -61,4 +61,9 @@
 
 #endif
 
+#if=
ndef HAVE_STRTOK_R
+char *
+strtok_r(char *s, const char *delim, char **las=
t);
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/openvpn/options_util=
=2Ec b/src/openvpn/options_util=2Ec
index 47fe0bc=2E=2Efbc64fa 100644
--- a=
/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -48,7 +=
48,8 @@
         message =3D strstr(reason, "]") + 1;
         /* null term=
inate the substring to only looks for flags between [ and ] */
         *en=
dofflags =3D '\x00';
-        const char *token =3D strtok(m, "[,");
+     =
   char *lasts;
+        const char *token =3D strtok_r(m, "[,", &lasts);
 =
        while (token)
         {
             if (!strncmp(token, "backoff =
", strlen("backoff ")))
@@ -81,7 +82,7 @@
             {
                 m=
sg(D_PUSH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP flag: %s", token);
     =
        }
-            token =3D strtok(NULL, "[,");
+            token =3D=
 strtok_r(NULL, "[,", &lasts);
         }
     }
 
diff --git a/src/openvpn=
/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 8a0f7d2=2E=2E7f0af3f 1=
00644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@=
@ -318,9 +318,10 @@
 
     /* Parse allowed ciphers, getting IDs */
     in=
t i =3D 0;
+    char *lasts;
     tmp_ciphers_orig =3D tmp_ciphers =3D stri=
ng_alloc(ciphers, NULL);
 
-    token =3D strtok(tmp_ciphers, ":");
+    to=
ken =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
     =
    ctx->allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_translat=
e_cipher_name(token));
@@ -328,7 +329,7 @@
         {
             i++;
   =
      }
-        token =3D strtok(NULL, ":");
+        token =3D strtok_r(N=
ULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 }
diff --git a/src/=
openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index 649665a=2E=2E33f33ef 10=
0644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -100,7 =
+100,8 @@
     struct buffer new_list =3D alloc_buf(MAX_NCP_CIPHERS_LENGTH)=
;
 
     char *const tmp_ciphers =3D string_alloc(list, NULL);
-    const c=
har *token =3D strtok(tmp_ciphers, ":");
+    char *lasts;
+    const char =
*token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
  =
       /*
@@ -174,7 +175,7 @@
                 buf_puts(&new_list, ovpn_cip=
her_name);
             }
         }
-        token =3D strtok(NULL, ":");
=
+        token =3D strtok_r(NULL, ":", &lasts);
     }
 
 
@@ -207,15 +208,=
16 @@
 {
     char *tmp_ciphers =3D string_alloc(list, NULL);
     char *tm=
p_ciphers_orig =3D tmp_ciphers;
+    char *lasts;
 
-    const char *token =
=3D strtok(tmp_ciphers, ":");
+    const char *token =3D strtok_r(tmp_ciphe=
rs, ":", &lasts);
     while (token)
     {
         if (0 =3D=3D strcmp(to=
ken, item))
         {
             break;
         }
-        token =3D st=
rtok(NULL, ":");
+        token =3D strtok_r(NULL, ":", &lasts);
     }
   =
  free(tmp_ciphers_orig);
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/o=
penvpn/ssl_verify=2Ec
index 0804d2d=2E=2E8c6e2bc 100644
--- a/src/openvpn/s=
sl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -868,7 +868,8 @@
        =
 return false;
     }
 
-    const char *client_method =3D strtok(iv_sso, "=
,");
+    char *lasts;
+    const char *client_method =3D strtok_r(iv_sso, =
",", &lasts);
     bool supported =3D false;
 
     while (client_method)
@=
@ -878,7 +879,7 @@
             supported =3D true;
             break;
   =
      }
-        client_method =3D strtok(NULL, ",");
+        client_metho=
d =3D strtok_r(NULL, ",", &lasts);
     }
 
     gc_free(&gc);

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I70560efd113308b7377424127eb2=
c1da4266371a
Gerrit-Change-Number: 1679
Gerrit-PatchSet: 2
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--RR3t7PZVpHs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Replace strtok with strtok_r<br><br>This dos not change anything =
in our source code but makes compiling<br>with newer Android NDKs (version =
30 pre release) -Werror safe again<br>as it has started throwing warning on=
 this=2E<br><br>The compat version is taken from current FreeBSD (commit dc=
36d6f9bb1)<br>src/lib/libc/string/strtok=2Ec and reformatted to our clang s=
tandard=2E<br><br>Change-Id: I70560efd113308b7377424127eb2c1da4266371a<br>S=
igned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeList=
s=2Etxt<br>M configure=2Eac<br>A src/compat/compat-strtok_r=2Ec<br>M src/co=
mpat/compat=2Eh<br>M src/openvpn/options_util=2Ec<br>M src/openvpn/ssl_mbed=
tls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>8 f=
iles changed, 123 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/1679/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>i=
ndex 715d02c=2E=2Edde7dc7 100644</span><br><span>--- a/CMakeLists=2Etxt</sp=
an><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -248,6 +248,7 @@</sp=
an><br><span> check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)</span><br><spa=
n> check_symbol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)</span><br=
><span> check_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(strtok_r string=
=2Eh HAVE_STRTOK_R)</span><br><span> </span><br><span> # Some OS (e=2Eg=2E =
FreeBSD) need some basic headers to allow</span><br><span> # including netw=
ork headers</span><br><span>diff --git a/configure=2Eac b/configure=2Eac</s=
pan><br><span>index e19d651=2E=2E188f8fa 100644</span><br><span>--- a/confi=
gure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -568,7 +5=
68,7 @@</span><br><span> 	setgroups flock gettimeofday \</span><br><span> 	=
setsid chdir \</span><br><span> 	chsize ftruncate execve getpeereid basenam=
e dirname \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	epoll_cre=
ate strsep \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	epoll_=
create strsep strtok_r \</span><br><span> ])</span><br><span> </span><br><s=
pan> AC_CHECK_LIB(</span><br><span>diff --git a/src/compat/compat-strtok_r=
=2Ec b/src/compat/compat-strtok_r=2Ec</span><br><span>new file mode 100644<=
/span><br><span>index 0000000=2E=2Edebcdd3</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/src/compat/compat-strtok_r=2Ec</span><br><span>@@ -0,0 =
+1,101 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*-</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * SPDX-License-Identifier=
: BSD-3-Clause</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c) 1998 =
Softweyr LLC=2E  All rights reserved=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * strtok_r, from Berkeley strtok</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Oct 13, 1998 by Wes Peters &lt;wes@softweyr=2Ecom&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Copyright (c) 1988, 1993</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *      The Regents of the Uni=
versity of California=2E  All rights reserved=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Redistribution and use in source and binary forms, with or w=
ithout</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * modificati=
on, are permitted provided that the following conditions</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * are met:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * 1=2E Redistributions of source code must re=
tain the above copyright</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *    notices, this list of conditions and the following disclaimer=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 2=2E Redistribut=
ions in binary form must reproduce the above copyright</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *    notices, this list of conditions a=
nd the following disclaimer in the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *    documentation and/or other materials provided with the=
 distribution=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
3=2E Neither the name of the University nor the names of its contributors</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    may be used to =
endorse or promote products derived from this software</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *    without specific prior written per=
mission=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * THIS SOFTWARE IS PROVID=
ED BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * ``AS IS&#39;&#39; AND ANY EXPRESS OR IMPLIE=
D WARRANTIES, INCLUDING, BUT NOT</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND F=
ITNESS FOR A</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * PART=
ICULAR PURPOSE ARE DISCLAIMED=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * REGENTS, OR CONTRIBUTO=
RS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMA=
GES (INCLUDING, BUT NOT LIMITED</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE=
, DATA, OR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * PROFIT=
S; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * LIABILITY, WHETHER IN CONTR=
ACT, STRICT LIABILITY, OR TORT (INCLUDING</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF=
 THE USE OF THIS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef HAVE_STRTOK_R</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
har *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strtok_r(char =
*s, const char *delim, char **last)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char *spanp, *tok;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int c, sc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s =3D=3D NULL &=
amp;&amp; (s =3D *last) =3D=3D NULL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return (NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Skip (span) leading delimiters (s +=3D st=
rspn(s, delim), sort of)=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cont:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    c =3D *s++;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (spanp =3D (char *=
)delim; (sc =3D *spanp++) !=3D 0;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (c =3D=3D sc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        goto cont;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (c =3D=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    { /* no non-delimiter characters */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        *last =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    tok =3D s - 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * Scan token (scan for delimiters: s +=3D strcspn(s, delim)=
, sort of)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 Note that delim must have one NUL; we stop if we see that, too=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (;;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        c =3D *s++;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        spanp =3D (char *)delim;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        do</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if ((sc =3D *spanp++) =3D=3D c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                if (c =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    s =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    s[-1] =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            *last =3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                return (tok);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        } while (sc !=3D 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* NOTREACHED */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span>\ No newline at end of file</span><br><span>diff --git a/src/comp=
at/compat=2Eh b/src/compat/compat=2Eh</span><br><span>index 6532b86=2E=2E9e=
6f95c 100644</span><br><span>--- a/src/compat/compat=2Eh</span><br><span>++=
+ b/src/compat/compat=2Eh</span><br><span>@@ -61,4 +61,9 @@</span><br><span=
> </span><br><span> #endif</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef HAVE_STRTOK_R</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+strtok_r(char *s, const char *delim, char **last);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* COMPAT_H */</=
span><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/opti=
ons_util=2Ec</span><br><span>index 47fe0bc=2E=2Efbc64fa 100644</span><br><s=
pan>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/op=
tions_util=2Ec</span><br><span>@@ -48,7 +48,8 @@</span><br><span>         m=
essage =3D strstr(reason, &quot;]&quot;) + 1;</span><br><span>         /* n=
ull terminate the substring to only looks for flags between [ and ] */</spa=
n><br><span>         *endofflags =3D &#39;\x00&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const char *token =3D strtok(m, &qu=
ot;[,&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  char *lasts;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const char *token =3D strtok_r(m, &quot;[,&quot;, &amp;lasts);</span><br=
><span>         while (token)</span><br><span>         {</span><br><span>  =
           if (!strncmp(token, &quot;backoff &quot;, strlen(&quot;backoff &=
quot;)))</span><br><span>@@ -81,7 +82,7 @@</span><br><span>             {</=
span><br><span>                 msg(D_PUSH_ERRORS, &quot;WARNING: unknown A=
UTH_FAIL,TEMP flag: %s&quot;, token);</span><br><span>             }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            token =3D strtok=
(NULL, &quot;[,&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            token =3D strtok_r(NULL, &quot;[,&quot;, &amp;lasts);</span=
><br><span>         }</span><br><span>     }</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec<=
/span><br><span>index 8a0f7d2=2E=2E7f0af3f 100644</span><br><span>--- a/src=
/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec<=
/span><br><span>@@ -318,9 +318,10 @@</span><br><span> </span><br><span>    =
 /* Parse allowed ciphers, getting IDs */</span><br><span>     int i =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts;</s=
pan><br><span>     tmp_ciphers_orig =3D tmp_ciphers =3D string_alloc(cipher=
s, NULL);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    token =3D strtok(tmp_ciphers, &quot;:&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    token =3D strtok_r(tmp_ciphers, &qu=
ot;:&quot;, &amp;lasts);</span><br><span>     while (token)</span><br><span=
>     {</span><br><span>         ctx-&gt;allowed_ciphers[i] =3D mbedtls_ssl=
_get_ciphersuite_id(tls_translate_cipher_name(token));</span><br><span>@@ -=
328,7 +329,7 @@</span><br><span>         {</span><br><span>             i++=
;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        token =3D strtok(NULL, &quot;:&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&=
quot;, &amp;lasts);</span><br><span>     }</span><br><span>     free(tmp_ci=
phers_orig);</span><br><span> }</span><br><span>diff --git a/src/openvpn/ss=
l_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index 649665a=2E=2E33f3=
3ef 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>++=
+ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -100,7 +100,8 @@</span><br><=
span>     struct buffer new_list =3D alloc_buf(MAX_NCP_CIPHERS_LENGTH);</sp=
an><br><span> </span><br><span>     char *const tmp_ciphers =3D string_allo=
c(list, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st char *token =3D strtok(tmp_ciphers, &quot;:&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *lasts;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_ci=
phers, &quot;:&quot;, &amp;lasts);</span><br><span>     while (token)</span=
><br><span>     {</span><br><span>         /*</span><br><span>@@ -174,7 +17=
5,7 @@</span><br><span>                 buf_puts(&amp;new_list, ovpn_cipher=
_name);</span><br><span>             }</span><br><span>         }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        token =3D strtok(NULL, =
&quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span>  =
   }</span><br><span> </span><br><span> </span><br><span>@@ -207,15 +208,16=
 @@</span><br><span> {</span><br><span>     char *tmp_ciphers =3D string_al=
loc(list, NULL);</span><br><span>     char *tmp_ciphers_orig =3D tmp_cipher=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const char *token =3D strtok(tmp_ciphers, &quot;:&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tm=
p_ciphers, &quot;:&quot;, &amp;lasts);</span><br><span>     while (token)</=
span><br><span>     {</span><br><span>         if (0 =3D=3D strcmp(token, i=
tem))</span><br><span>         {</span><br><span>             break;</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       token =3D strtok(NULL, &quot;:&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, &quot;:&quot;, &=
amp;lasts);</span><br><span>     }</span><br><span>     free(tmp_ciphers_or=
ig);</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify=
=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 0804d2d=2E=2E8c6e2b=
c 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+=
++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -868,7 +868,8 @@</span><=
br><span>         return false;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *client_m=
ethod =3D strtok(iv_sso, &quot;,&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *lasts;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *client_method =3D strtok_r(iv_sso, &quot;=
,&quot;, &amp;lasts);</span><br><span>     bool supported =3D false;</span>=
<br><span> </span><br><span>     while (client_method)</span><br><span>@@ -=
878,7 +879,7 @@</span><br><span>             supported =3D true;</span><br>=
<span>             break;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        client_method =3D strtok(NULL, &quo=
t;,&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
client_method =3D strtok_r(NULL, &quot;,&quot;, &amp;lasts);</span><br><spa=
n>     }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1679?usp=3Demail">change 1679</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I70560efd113308b7377424127=
eb2c1da4266371a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
679 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--RR3t7PZVpHs=--


--===============5732258983685223441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5732258983685223441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5732258983685223441==--

