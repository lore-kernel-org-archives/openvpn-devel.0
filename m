Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FA7CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMq/cYlrUuUpt4HhQBKRJA5oOmWEmT47mXXWb2vMFOc=; b=irIzPFeK7GyxMtYAjI7QAQZqjQ
	ZwyHfWII9OCUYKETjB1Vw7QuiPyTigmXi0/Bzf5etC2SccUrvXJ0W3IziG03ks2SvzPcTNiJE6eGI
	iNMRUPX9vCQbvQkR92T0/LvXgBV0Y8m5foG1eAnBTCll7LxBFJ3YARgqaSX0aLyrvT9A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPjVr-0005lu-Oj;
	Wed, 20 May 2026 16:11:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPjVq-0005lo-Cr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:11:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rwaPrVRIdlyBIr/XnKLlKQnlZtok3nujvNYyw6NejlM=; b=ZdGFsvO7a8DkpY7fXQrIOAKYL2
 Cw6GLs+kyv29KIJtSCLW9a0Z3Gjgbn3iZpdcoCqvwpsGfUVKZL5idF736UXSWtrSM5Ml3ntOJFjrF
 /7WhsYVjHk3yzXTAnscU1VPPxPfavbMd48QoqnEplaqL01k/oTaZOl9smloURIhKj2p0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rwaPrVRIdlyBIr/XnKLlKQnlZtok3nujvNYyw6NejlM=; b=S
 vQqhDdPOY8X1hEr7hIqyrf9FkRJbwwGDvCIJVaCiRnBy/bve2AOvVMOVWKZEUaoyI0W3y8ZodM3/l
 ietKFTHykQsFT389i9AqMzd6lHjjyVM42kB1X0qgpYg/UPTgWurYws2/YVu3LGUJ/XSvQ7AQ3y9AW
 HltE1UmiZcUUghQk=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPjVl-0007iZ-Cj for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:11:11 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488b0046078so45010335e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779293463; x=1779898263; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rwaPrVRIdlyBIr/XnKLlKQnlZtok3nujvNYyw6NejlM=;
 b=cLeZUm97yMrpW0h5crK3HUkJxzxcJj9NAY6zIbnsX1KbZdc/+oHexdZP4zwdjZopCc
 aNbnbviA/UFNiovLpavxhhexgHpKAUXrL53IlNDEbEitz/KBx4rfLMOqsKdThGc1ieh+
 RQZ4k+4RiU+whgaE6kbts/Y6Fewk1SKzqwJb1pr7o6f8VbHOfWlTxg8WxmXeUvdXHzEz
 NjSKdUMqFmEg7e2nRjLkVq9UVKUUlvrSIFJFCvskbba+clQ6Q3oz/WcWoZ2GhJ5rcJDO
 3Swqh8UM2dzt2/yBnPE2Ing/qnOxNLjo38aPayErfjSeVve4cE4eRgUt4irGz/RzUicB
 Gq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779293463; x=1779898263;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rwaPrVRIdlyBIr/XnKLlKQnlZtok3nujvNYyw6NejlM=;
 b=VXefAuVJZcxt5UFLbWvmnczWNsRMk81QOgphhgz0Fcag9MyRp0mtcvCIECk6u0lzhd
 PNgBDYYNeoUezXHllcXWqWd9EK+FO4RxEIqsd1T5ywwrkYOHXr0f6vZiF7t6jPJU40gp
 w8t4ETTZz/nyX/l7T29AOR3hac/ebxtgEaCQ4sZEN1sBqUwOJKIaHi3wncQwDy8BuxX8
 r18hSEsCzADLbORHJ8/Tiw2XrFGck7UkH68TpzJDYY/9ErEyHQdjbM8DKe9rBZN3cTMr
 yMAc2qy7NCv8an79rt507PAfVsfAhekdvELKc591sWNyPZ18kI85UWhuWqboec4wKVY+
 9r9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9n71/CZnOj4BvBskRUmeDRGAAsSdHT8zXQN1aEE8+Pn6m4QKs6KOdqw/XHpTeUUW9VkSTLH91r+3DVOmJj@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz696APa95IiLjgenMBdIIImUiisssr0X2LBj81qjXrW21baA9a
 YwW5hOWHIkqVBQ9F7Rmlgls0T7sosXic1xjWo03WzXYPpPHtHRVVwwjYvLYZG9+stx9zXBjc49Y
 h5hNC0gd6oow33Ka0W0a9Aj29h13P+tw/DuGaGCSIPuEO9NsUHbosPtTDlmUbGE8b1igfMHdiiJ
 XDrE3+Pw==
X-Gm-Gg: Acq92OHGdGj2zWn5C1YFxj3+PtnMHNLNO/KIVtQTlJsUwbkiplNHxohjl97E8/4eqwa
 0P1PJZmlmwies4B6FymsTWKG+/MK2egNnvvFd5ncI/rwuXVja8Ro/477gEAhlSKLck+biQV0aF+
 ACF5tn8UoF9UVFe2z2k6Fk3e1Z1dcbmcny2lBAbuV5LZN+aCJGbThVs/rCFkp5nWRL8i7mUEXZ5
 mQOSgYyzI9dvYa47464hFpBW5AraSAqXhSLsQYyW66Z0HpqlUnEIk0Y1btqIEplJqH2x7xWilNq
 kK5AW4N9REvAqsfaaGZsH0b6y3TQYqk8dLG+tcH0yJAxzlhj2TJqERn1EfhohS8NDzRYYqPWe0f
 lDFBTR0bt2UtszE4rhDWRmg8MIljEii86IWCWE81g9bZsnxOE7IvCBeMHP0k/kw2w0+KMpX+N7A
 UPfdGPDm1JCxMr14qgTbHiRGzT552XGlUaTSAmHr+XdyFnuvlVv4nZlxSV3tXfE8MlHMxq9ohzV
 VHaNTJH+cNd7dp7u0hx9+BaqPBHNnd0dplysHX6diGeptCaB+cBfOEVYy4fx3X/hKJxZnACz3hk
 oKU1vNNT2PkHww==
X-Received: by 2002:a05:600c:3e1b:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-48fe60da647mr405412565e9.12.1779293462678; 
 Wed, 20 May 2026 09:11:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3f0d1sm2438125e9.5.2026.05.20.09.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:11:02 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 16:10:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 96d7c0ec791afbd3c412969bab407ac1a37314df
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a26e521cc46142dbf64dfa6d931d89f3ffdccc3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPjVl-0007iZ-Cj
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6302754606148782471=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6302754606148782471==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QofoFERRCTs="; charset=UTF-8

--QofoFERRCTs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has upload=
ed a new patch set (#5)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679=
?usp=3Demail )


Change subject: Replace strtok with strtok_r
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace strtok with strto=
k_r

This dos not change anything in our source code but makes compiling
wi=
th newer Android NDKs (version 30 pre release) -Werror safe again
as it has=
 started throwing warning on this=2E

The compat version is taken from curr=
ent FreeBSD (commit dc36d6f9bb1)
src/lib/libc/string/strtok=2Ec and reforma=
tted to our clang standard=2E

Change-Id: I70560efd113308b7377424127eb2c1da=
4266371a
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=
=2Etxt
M configure=2Eac
M src/compat/Makefile=2Eam
A src/compat/compat-strt=
ok_r=2Ec
M src/compat/compat=2Eh
M src/openvpn/options_util=2Ec
M src/openv=
pn/ssl_mbedtls=2Ec
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_verify=2Ec
M=
 tests/unit_tests/openvpn/Makefile=2Eam
10 files changed, 130 insertions(+)=
, 12 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/79/1679/5

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
ind=
ex 715d02c=2E=2Eceafbb4 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etx=
t
@@ -248,6 +248,7 @@
 check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)
 chec=
k_symbol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)
 check_symbol_ex=
ists(strsep string=2Eh HAVE_STRSEP)
+check_symbol_exists(strtok_r string=2E=
h HAVE_STRTOK_R)
 
 # Some OS (e=2Eg=2E FreeBSD) need some basic headers to=
 allow
 # including network headers
@@ -413,6 +414,7 @@
     src/compat/com=
pat-dirname=2Ec
     src/compat/compat-gettimeofday=2Ec
     src/compat/com=
pat-strsep=2Ec
+    src/compat/compat-strtok_r=2Ec
     src/openvpn/argv=2E=
c
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -733,6 +735,8 @@=

             src/openvpn/platform=2Ec
             src/openvpn/win32-util=
=2Ec
             src/compat/compat-gettimeofday=2Ec
+            src/compa=
t/compat-strsep=2Ec
+            src/compat/compat-strtok_r=2Ec
           =
  )
 
         add_library_deps(${test_name})
diff --git a/configure=2Eac b=
/configure=2Eac
index e19d651=2E=2E188f8fa 100644
--- a/configure=2Eac
+++ =
b/configure=2Eac
@@ -568,7 +568,7 @@
 	setgroups flock gettimeofday \
 	set=
sid chdir \
 	chsize ftruncate execve getpeereid basename dirname \
-	epoll=
_create strsep \
+	epoll_create strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff=
 --git a/src/compat/Makefile=2Eam b/src/compat/Makefile=2Eam
index 69b2990=
=2E=2E22867b3 100644
--- a/src/compat/Makefile=2Eam
+++ b/src/compat/Makefi=
le=2Eam
@@ -20,4 +20,5 @@
 	compat-basename=2Ec \
 	compat-gettimeofday=2Ec=
 \
 	compat-daemon=2Ec \
-	compat-strsep=2Ec
\ No newline at end of file
+	=
compat-strsep=2Ec \
+	compat-strtok_r=2Ec
\ No newline at end of file
diff =
--git a/src/compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=2Ec
new=
 file mode 100644
index 0000000=2E=2Edebcdd3
--- /dev/null
+++ b/src/compat=
/compat-strtok_r=2Ec
@@ -0,0 +1,101 @@
+/*-
+ * SPDX-License-Identifier: BS=
D-3-Clause
+ *
+ * Copyright (c) 1998 Softweyr LLC=2E  All rights reserved=
=2E
+ *
+ * strtok_r, from Berkeley strtok
+ * Oct 13, 1998 by Wes Peters <=
wes@softweyr=2Ecom>
+ *
+ * Copyright (c) 1988, 1993
+ *      The Regents o=
f the University of California=2E  All rights reserved=2E
+ *
+ * Redistrib=
ution and use in source and binary forms, with or without
+ * modification,=
 are permitted provided that the following conditions
+ * are met:
+ * 1=2E=
 Redistributions of source code must retain the above copyright
+ *    noti=
ces, this list of conditions and the following disclaimer=2E
+ * 2=2E Redis=
tributions in binary form must reproduce the above copyright
+ *    notices=
, this list of conditions and the following disclaimer in the
+ *    docume=
ntation and/or other materials provided with the distribution=2E
+ * 3=2E N=
either the name of the University nor the names of its contributors
+ *    =
may be used to endorse or promote products derived from this software
+ *  =
  without specific prior written permission=2E
+ *
+ * THIS SOFTWARE IS PRO=
VIDED BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY E=
XPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIE=
D WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ * PARTICULAR PURPOSE AR=
E DISCLAIMED=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE
+ * REGENTS, OR CONTRI=
BUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLA=
RY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
+ * TO, PROCUREMEN=
T OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BU=
SINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHE=
THER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OT=
HERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF AD=
VISED OF THE POSSIBILITY OF SUCH DAMAGE=2E
+ */
+#ifdef HAVE_CONFIG_H
+#inc=
lude "config=2Eh"
+#endif
+
+#ifndef HAVE_STRTOK_R
+#include <string=2Eh>
+=

+char *
+strtok_r(char *s, const char *delim, char **last)
+{
+    char *s=
panp, *tok;
+    int c, sc;
+
+    if (s =3D=3D NULL && (s =3D *last) =3D=
=3D NULL)
+    {
+        return (NULL);
+    }
+
+/*
+ * Skip (span) leadi=
ng delimiters (s +=3D strspn(s, delim), sort of)=2E
+ */
+cont:
+    c =3D =
*s++;
+    for (spanp =3D (char *)delim; (sc =3D *spanp++) !=3D 0;)
+    {
=
+        if (c =3D=3D sc)
+        {
+            goto cont;
+        }
+  =
  }
+
+    if (c =3D=3D 0)
+    { /* no non-delimiter characters */
+      =
  *last =3D NULL;
+        return (NULL);
+    }
+    tok =3D s - 1;
+
+   =
 /*
+     * Scan token (scan for delimiters: s +=3D strcspn(s, delim), sort=
 of)=2E
+     * Note that delim must have one NUL; we stop if we see that, =
too=2E
+     */
+    for (;;)
+    {
+        c =3D *s++;
+        spanp =
=3D (char *)delim;
+        do
+        {
+            if ((sc =3D *spanp++=
) =3D=3D c)
+            {
+                if (c =3D=3D 0)
+              =
  {
+                    s =3D NULL;
+                }
+                el=
se
+                {
+                    s[-1] =3D '\0';
+               =
 }
+                *last =3D s;
+                return (tok);
+          =
  }
+        } while (sc !=3D 0);
+    }
+    /* NOTREACHED */
+}
+#endif
\=
 No newline at end of file
diff --git a/src/compat/compat=2Eh b/src/compat/=
compat=2Eh
index 6532b86=2E=2E9e6f95c 100644
--- a/src/compat/compat=2Eh
++=
+ b/src/compat/compat=2Eh
@@ -61,4 +61,9 @@
 
 #endif
 
+#ifndef HAVE_STRTO=
K_R
+char *
+strtok_r(char *s, const char *delim, char **last);
+#endif
+
 =
#endif /* COMPAT_H */
diff --git a/src/openvpn/options_util=2Ec b/src/openv=
pn/options_util=2Ec
index 47fe0bc=2E=2Ed72ea25c 100644
--- a/src/openvpn/op=
tions_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -48,7 +48,8 @@
       =
  message =3D strstr(reason, "]") + 1;
         /* null terminate the subst=
ring to only looks for flags between [ and ] */
         *endofflags =3D '\=
x00';
-        const char *token =3D strtok(m, "[,");
+        char *lasts =
=3D NULL;
+        const char *token =3D strtok_r(m, "[,", &lasts);
       =
  while (token)
         {
             if (!strncmp(token, "backoff ", str=
len("backoff ")))
@@ -81,7 +82,7 @@
             {
                 msg(D_P=
USH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP flag: %s", token);
           =
  }
-            token =3D strtok(NULL, "[,");
+            token =3D strto=
k_r(NULL, "[,", &lasts);
         }
     }
 
diff --git a/src/openvpn/ssl_m=
bedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 8a0f7d2=2E=2E07caf08 100644
=
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -318=
,9 +318,10 @@
 
     /* Parse allowed ciphers, getting IDs */
     int i =
=3D 0;
+    char *lasts =3D NULL;
     tmp_ciphers_orig =3D tmp_ciphers =3D=
 string_alloc(ciphers, NULL);
 
-    token =3D strtok(tmp_ciphers, ":");
+ =
   token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
=
         ctx->allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_tra=
nslate_cipher_name(token));
@@ -328,7 +329,7 @@
         {
             i++=
;
         }
-        token =3D strtok(NULL, ":");
+        token =3D strto=
k_r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 }
diff --git a=
/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index 649665a=2E=2Ebaf5a=
95 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -1=
00,7 +100,8 @@
     struct buffer new_list =3D alloc_buf(MAX_NCP_CIPHERS_LE=
NGTH);
 
     char *const tmp_ciphers =3D string_alloc(list, NULL);
-    co=
nst char *token =3D strtok(tmp_ciphers, ":");
+    char *lasts =3D NULL;
+ =
   const char *token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (to=
ken)
     {
         /*
@@ -174,7 +175,7 @@
                 buf_puts(&new_=
list, ovpn_cipher_name);
             }
         }
-        token =3D strto=
k(NULL, ":");
+        token =3D strtok_r(NULL, ":", &lasts);
     }
 
 
@@=
 -207,15 +208,16 @@
 {
     char *tmp_ciphers =3D string_alloc(list, NULL);=

     char *tmp_ciphers_orig =3D tmp_ciphers;
+    char *lasts =3D NULL;
 
=
-    const char *token =3D strtok(tmp_ciphers, ":");
+    const char *token=
 =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
        =
 if (0 =3D=3D strcmp(token, item))
         {
             break;
         =
}
-        token =3D strtok(NULL, ":");
+        token =3D strtok_r(NULL, "=
:", &lasts);
     }
     free(tmp_ciphers_orig);
 
diff --git a/src/openvpn=
/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0804d2d=2E=2E1db7f55 100=
644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -8=
68,7 +868,8 @@
         return false;
     }
 
-    const char *client_meth=
od =3D strtok(iv_sso, ",");
+    char *lasts =3D NULL;
+    const char *cli=
ent_method =3D strtok_r(iv_sso, ",", &lasts);
     bool supported =3D false=
;
 
     while (client_method)
@@ -878,7 +879,7 @@
             supported =
=3D true;
             break;
         }
-        client_method =3D strtok(=
NULL, ",");
+        client_method =3D strtok_r(NULL, ",", &lasts);
     }
=
 
     gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam
index 1128eb4=2E=2Ed861ef9 100644
--=
- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam
@@ -107,6 +107,7 @@
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 =
	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/compat/compat-s=
trsep=2Ec \
+	$(top_srcdir)/src/compat/compat-strtok_r=2Ec \
 	$(top_srcdir=
)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/cryptoapi=2Ec \
 	$(=
top_srcdir)/src/openvpn/crypto_epoch=2Ec \
@@ -345,6 +346,7 @@
 	$(top_srcd=
ir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \=

 	$(top_srcdir)/src/compat/compat-strsep=2Ec \
+	$(top_srcdir)/src/compat/=
compat-strtok_r=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec
 
 mbuf_test=
driver_CFLAGS  =3D \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1679?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I70560efd113308b7377424127eb2c1da4266371a
Gerrit-Change-Number: 1679
Ge=
rrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>

--QofoFERRCTs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Re=
place strtok with strtok_r<br><br>This dos not change anything in our sourc=
e code but makes compiling<br>with newer Android NDKs (version 30 pre relea=
se) -Werror safe again<br>as it has started throwing warning on this=2E<br>=
<br>The compat version is taken from current FreeBSD (commit dc36d6f9bb1)<b=
r>src/lib/libc/string/strtok=2Ec and reformatted to our clang standard=2E<b=
r><br>Change-Id: I70560efd113308b7377424127eb2c1da4266371a<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M=
 configure=2Eac<br>M src/compat/Makefile=2Eam<br>A src/compat/compat-strtok=
_r=2Ec<br>M src/compat/compat=2Eh<br>M src/openvpn/options_util=2Ec<br>M sr=
c/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl=
_verify=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>10 files changed=
, 130 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/1679/5</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 715d02c=
=2E=2Eceafbb4 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -248,6 +248,7 @@</span><br><span=
> check_symbol_exists(chsize io=2Eh HAVE_CHSIZE)</span><br><span> check_sym=
bol_exists(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)</span><br><span> chec=
k_symbol_exists(strsep string=2Eh HAVE_STRSEP)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+check_symbol_exists(strtok_r string=2Eh HAVE_STR=
TOK_R)</span><br><span> </span><br><span> # Some OS (e=2Eg=2E FreeBSD) need=
 some basic headers to allow</span><br><span> # including network headers</=
span><br><span>@@ -413,6 +414,7 @@</span><br><span>     src/compat/compat-d=
irname=2Ec</span><br><span>     src/compat/compat-gettimeofday=2Ec</span><b=
r><span>     src/compat/compat-strsep=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    src/compat/compat-strtok_r=2Ec</span><br><span>  =
   src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br=
><span>     src/openvpn/base64=2Ec</span><br><span>@@ -733,6 +735,8 @@</spa=
n><br><span>             src/openvpn/platform=2Ec</span><br><span>         =
    src/openvpn/win32-util=2Ec</span><br><span>             src/compat/comp=
at-gettimeofday=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            src/compat/compat-strsep=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            src/compat/compat-strtok_r=2Ec</span><br><=
span>             )</span><br><span> </span><br><span>         add_library_=
deps(${test_name})</span><br><span>diff --git a/configure=2Eac b/configure=
=2Eac</span><br><span>index e19d651=2E=2E188f8fa 100644</span><br><span>---=
 a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -=
568,7 +568,7 @@</span><br><span> 	setgroups flock gettimeofday \</span><br>=
<span> 	setsid chdir \</span><br><span> 	chsize ftruncate execve getpeereid=
 basename dirname \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	e=
poll_create strsep \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	epoll_create strsep strtok_r \</span><br><span> ])</span><br><span> </spa=
n><br><span> AC_CHECK_LIB(</span><br><span>diff --git a/src/compat/Makefile=
=2Eam b/src/compat/Makefile=2Eam</span><br><span>index 69b2990=2E=2E22867b3=
 100644</span><br><span>--- a/src/compat/Makefile=2Eam</span><br><span>+++ =
b/src/compat/Makefile=2Eam</span><br><span>@@ -20,4 +20,5 @@</span><br><spa=
n> 	compat-basename=2Ec \</span><br><span> 	compat-gettimeofday=2Ec \</span=
><br><span> 	compat-daemon=2Ec \</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	compat-strsep=2Ec</span><br><span>\ No newline at end of file</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	compat-strsep=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	compat-strtok_r=2Ec=
</span><br><span>\ No newline at end of file</span><br><span>diff --git a/s=
rc/compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=2Ec</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2Edebcdd3</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/compat/compat-strtok_r=2Ec=
</span><br><span>@@ -0,0 +1,101 @@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* SPDX-License-Identifier: BSD-3-Clause</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Copyright (c) 1998 Softweyr LLC=2E  All rights reserved=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * strtok_r, from Berkeley strtok</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Oct 13, 1998 by Wes Peters &lt=
;wes@softweyr=2Ecom&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copyright =
(c) 1988, 1993</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
   The Regents of the University of California=2E  All rights reserved=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Redistribution and use in source an=
d binary forms, with or without</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * modification, are permitted provided that the following cond=
itions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are met:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 1=2E Redistributio=
ns of source code must retain the above copyright</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *    notices, this list of conditions and th=
e following disclaimer=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * 2=2E Redistributions in binary form must reproduce the above copyr=
ight</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    notices, =
this list of conditions and the following disclaimer in the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *    documentation and/or other ma=
terials provided with the distribution=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * 3=2E Neither the name of the University nor the na=
mes of its contributors</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *    may be used to endorse or promote products derived from this soft=
ware</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    without s=
pecific prior written permission=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* THIS SOFTWARE IS PROVIDED BY SOFTWEYR LLC, THE REGENTS AND CONTRIBUTORS</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ``AS IS&#39;&#39; =
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * LIMITED TO, THE IMPLIED WARRANTIES=
 OF MERCHANTABILITY AND FITNESS FOR A</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * PARTICULAR PURPOSE ARE DISCLAIMED=2E  IN NO EVENT SHAL=
L SOFTWEYR LLC, THE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * REGENTS, OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SPECIAL, EXEMPLA=
RY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * TO, PROCUREMENT OF SUBSTITUTE GOODS=
 OR SERVICES; LOSS OF USE, DATA, OR</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON=
 ANY THEORY OF</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * LI=
ABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * NEGLIGENCE OR OTHERWISE) =
ARISING IN ANY WAY OUT OF THE USE OF THIS</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SU=
CH DAMAGE=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
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
nvpn/ssl_verify=2Ec</span><br><span>index 0804d2d=2E=2E1db7f55 100644</span=
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
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70560efd11=
3308b7377424127eb2c1da4266371a </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1679 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>

</body></html>
--QofoFERRCTs=--


--===============6302754606148782471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6302754606148782471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6302754606148782471==--

