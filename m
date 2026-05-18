Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DD5CD4F50
	for <openvpn-devel@archiver.kernel.org>; Mon, 18 May 2026 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Cc:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lt3QcyvfaclOWMNTIZpxudhRY1mDYz0EaMN9xhbbc8g=; b=Mh1X981a0JTclr3tKj7NhqoB+S
	9izp7aYn6gtUkDHDE2DL6YXxoJI9GRKq6GOaTMIJcPHHdO+Gx182HATrWF0CQoJkyXSfe5Cdcuv+c
	g8OM/jWrTr7U4jusU5F/gc+OA8FaqVl2W+Ff8wn+doPyQC96D4DuS5Az7cu4bfJAK9Ko=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wOyCM-0004Mi-Ri;
	Mon, 18 May 2026 13:39:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wOyC2-0004MJ-4q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 13:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Aq2NwpRG1nA02UNaxPhG+8dg5CLuWUaxHgb58+BoPH4=; b=kdUsSwkpt3ISqkcEEniBgMrJTh
 sf2jVVE7+ajPhhR7chgiABbiZv8izBCALzv1TQN9VQJrXIK2dIP3jm2PEJxSjSb2tVY550zYrqn0X
 zkY39e8MdYqq6D5pLBVfkbiJXoBi/7djsgJQEkuHpZP37NGOXhCdJySp9HUy87h8Zh9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Aq2NwpRG1nA02UNaxPhG+8dg5CLuWUaxHgb58+BoPH4=; b=d
 ukGAf/CkOZYgpscxbjxfDbS8dsIxzswE1BlhM2JCw8EooAj0Zc3rBWyR5ClLAEwQgOjYrn/01hFAp
 xljaK2owEJAZ2SmXsTDn1bkC9obqzJ6Mp4veWG7vSQ23SydlcE8vA8RjAbrjbKjjMKzm+JlTawPPh
 nAiCFDoIgM/WSptg=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wOyC0-0000sj-6K for openvpn-devel@lists.sourceforge.net;
 Mon, 18 May 2026 13:39:38 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso25949225e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 18 May 2026 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779111565; x=1779716365; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aq2NwpRG1nA02UNaxPhG+8dg5CLuWUaxHgb58+BoPH4=;
 b=DHBZhA1hqjO/goy5sM8iUJg3Ed1LwyMLwxL9cjHZuFhzHQxaANjUt+/XVv54kDWOtf
 Ie4dMT2qHiKANVCAUaJoaDSuHFqEcg+XdgrVLyW/FhreLf9IaDFipPj1Q8ke9lc3SrBn
 wPL6a/gJYgzYNybmZ5NGv0avpHxYrgi2sLKKjAPB6q61dgQjgbi/rolVoc2hvR/vo0DX
 DTm/Pg5e1ABbH41N2WuTZAZ3YMM06fQwVVAa5Li8ZN1oTBiyXvC8HUrTtzKMq9rojVRW
 SlDPH7xiIh4lDlCC9NxJx67mo6tpqPQGg87Cnvt2cGvsq6AfpkUeJ/MlNiM6imushwOe
 4z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779111565; x=1779716365;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aq2NwpRG1nA02UNaxPhG+8dg5CLuWUaxHgb58+BoPH4=;
 b=c9WD/lec3yTMpI8vlsPf9Jis/edg7Mvr344SdjhhX6zLkz7tqg934BYWHxA1g9u1yq
 lzsRR91uT+b7UnBpdPeuBPmbs3Ic9sfIgTFyOsVajMcLxXfm3rkfbkJkg7jQErDFSSfa
 ObHZEmBRMAYwupksZOatcrbrh/tFC3idv+7I9oqgZUB4JFIIqZMTuVx+5eiYlqAPjTje
 YQELTCzOSaGg3YQj1OYDHSSszjhrRKMdhl+kTZ9gZSaSDbfoeZKi6R1EeNYnzDlhyzam
 AxtF6jtm+SlA6OG6fplpvteZkB8uapVb9zhdB16nNuoK49UR6j3cBWkcdJe2k0ANmGD7
 rQXA==
X-Gm-Message-State: AOJu0Yz+saLhom3bgyijDNs/NpCOwd7s3+JHrfjZQSj8bpPNwPqwbk6E
 LZfCvJwoyLN/9h03kYAC/8997SRL5xDEWuq29oAEb9+RZGR+OdLKmjscF1NR7nNTfSeGz0NstWX
 nxRgVa9xLnL+Nudzzjh5ifiYkNlY62CLUUMx0/lfctZ3GcHW9v6cyQBl7c8dVcKv3JtjHEXXvi4
 3rGnsoSg==
X-Gm-Gg: Acq92OHWCYRoJ9QF4q9BOP8GT+0i31KKNjKRXE3nHupRpo5XlKsYKE7jlLBZsDJwfTw
 34ki1k/FTnukOY+luw6737nFOCVT54vLGLTuYmwkG4WMzTe3IVIDb0qQvy8s+hSsZobgeayGkGp
 6TUDKbRSKqFoJFYmUGqhn1rEnKDnS/taVNM7bxsUqFO9MDuqKFyU5RmykWtJcvwZeyz6g6qb/fq
 Ri27KqFWoDPUZPIYeCpfASyZgACeoXbtmOUos3PXPk2rcfo8h2qZOzwV6aMMNCtQW+x8YlXKvyF
 PEm2J6cHlfNxb7hI3kD8CgvTIeYHg/BxIvNpGYw5lLfQuJ8I0tjClshv7oZduva1E0bT6wCwH4f
 sdrb3doTh1VZsQRDZUgceav7KUgUdfGZO3p+kHHvXee458fDD0t5ASx6GfRN1imyCiFlHZXb5XI
 NRlGa/dNkl1e1Wdfe3zoScgvoaeenoLtYbj9lU7Vn8oJtuc92GcBn0SxSBzKhyzmnWC3sa8R/JR
 qXxBxAOR9DHgwluyGdIDTs/OHusuYbg/e/LQqySjwfPYiQFu7woYOSo+6KxnQnAqrjzeqRT+s2S
 6pjB8yOBo3XedQ==
X-Received: by 2002:a05:600c:c4a7:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48fe539519dmr222291615e9.14.1779111564352; 
 Mon, 18 May 2026 06:39:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab671sm256619935e9.1.2026.05.18.06.39.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 06:39:23 -0700 (PDT)
From: "plaisthos (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 18 May 2026 13:39:21 +0000
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: c2db2045f18ba56609fadd81e23bf1bbd5830f11
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6aa8f392b60fe34f2400543c7273533df38228ae-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wOyC0-0000sj-6K
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
Content-Type: multipart/mixed; boundary="===============5810373519601498796=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5810373519601498796==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XozEXjIq+sQ="; charset=UTF-8

--XozEXjIq+sQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#4)=2E ( http://gerrit=2Eopenvpn=2E=
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
d, 130 insertions(+), 12 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/79/1679/4

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 715d02c=2E=2Eceafbb4 100644
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
@@ -733,6 +735,8 @@
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
index 47fe0bc=2E=2Efbc64fa 100644
---=
 a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -48,7=
 +48,8 @@
         message =3D strstr(reason, "]") + 1;
         /* null te=
rminate the substring to only looks for flags between [ and ] */
         *=
endofflags =3D '\x00';
-        const char *token =3D strtok(m, "[,");
+   =
     char *lasts;
+        const char *token =3D strtok_r(m, "[,", &lasts);=

         while (token)
         {
             if (!strncmp(token, "backof=
f ", strlen("backoff ")))
@@ -81,7 +82,7 @@
             {
                =
 msg(D_PUSH_ERRORS, "WARNING: unknown AUTH_FAIL,TEMP flag: %s", token);
   =
          }
-            token =3D strtok(NULL, "[,");
+            token =
=3D strtok_r(NULL, "[,", &lasts);
         }
     }
 
diff --git a/src/open=
vpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 8a0f7d2=2E=2E7f0af3=
f 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2E=
c
@@ -318,9 +318,10 @@
 
     /* Parse allowed ciphers, getting IDs */
    =
 int i =3D 0;
+    char *lasts;
     tmp_ciphers_orig =3D tmp_ciphers =3D s=
tring_alloc(ciphers, NULL);
 
-    token =3D strtok(tmp_ciphers, ":");
+   =
 token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
  =
       ctx->allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_trans=
late_cipher_name(token));
@@ -328,7 +329,7 @@
         {
             i++;
=
         }
-        token =3D strtok(NULL, ":");
+        token =3D strtok_=
r(NULL, ":", &lasts);
     }
     free(tmp_ciphers_orig);
 }
diff --git a/s=
rc/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index 649665a=2E=2E33f33ef=
 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -100=
,7 +100,8 @@
     struct buffer new_list =3D alloc_buf(MAX_NCP_CIPHERS_LENG=
TH);
 
     char *const tmp_ciphers =3D string_alloc(list, NULL);
-    cons=
t char *token =3D strtok(tmp_ciphers, ":");
+    char *lasts;
+    const ch=
ar *token =3D strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {=

         /*
@@ -174,7 +175,7 @@
                 buf_puts(&new_list, ovpn_=
cipher_name);
             }
         }
-        token =3D strtok(NULL, ":"=
);
+        token =3D strtok_r(NULL, ":", &lasts);
     }
 
 
@@ -207,15 +2=
08,16 @@
 {
     char *tmp_ciphers =3D string_alloc(list, NULL);
     char =
*tmp_ciphers_orig =3D tmp_ciphers;
+    char *lasts;
 
-    const char *tok=
en =3D strtok(tmp_ciphers, ":");
+    const char *token =3D strtok_r(tmp_ci=
phers, ":", &lasts);
     while (token)
     {
         if (0 =3D=3D strcmp=
(token, item))
         {
             break;
         }
-        token =3D=
 strtok(NULL, ":");
+        token =3D strtok_r(NULL, ":", &lasts);
     }
=
     free(tmp_ciphers_orig);
 
diff --git a/src/openvpn/ssl_verify=2Ec b/sr=
c/openvpn/ssl_verify=2Ec
index 0804d2d=2E=2E8c6e2bc 100644
--- a/src/openvp=
n/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -868,7 +868,8 @@
     =
    return false;
     }
 
-    const char *client_method =3D strtok(iv_sso=
, ",");
+    char *lasts;
+    const char *client_method =3D strtok_r(iv_ss=
o, ",", &lasts);
     bool supported =3D false;
 
     while (client_method=
)
@@ -878,7 +879,7 @@
             supported =3D true;
             break;
=
         }
-        client_method =3D strtok(NULL, ",");
+        client_me=
thod =3D strtok_r(NULL, ",", &lasts);
     }
 
     gc_free(&gc);
diff --gi=
t a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makef=
ile=2Eam
index 1128eb4=2E=2Ed861ef9 100644
--- a/tests/unit_tests/openvpn/M=
akefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -107,6 +107,7 =
@@
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buf=
fer=2Ec \
 	$(top_srcdir)/src/compat/compat-strsep=2Ec \
+	$(top_srcdir)/sr=
c/compat/compat-strtok_r=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$=
(top_srcdir)/src/openvpn/cryptoapi=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=
_epoch=2Ec \
@@ -345,6 +346,7 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \=

 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/compat/co=
mpat-strsep=2Ec \
+	$(top_srcdir)/src/compat/compat-strtok_r=2Ec \
 	$(top_=
srcdir)/src/openvpn/ssl_util=2Ec
 
 mbuf_testdriver_CFLAGS  =3D \

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70560efd113308b737742412=
7eb2c1da4266371a
Gerrit-Change-Number: 1679
Gerrit-PatchSet: 4
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--XozEXjIq+sQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://g=
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
iles changed, 130 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/1679/4=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>i=
ndex 715d02c=2E=2Eceafbb4 100644</span><br><span>--- a/CMakeLists=2Etxt</sp=
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
=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><span>@@ -733,6 =
+735,8 @@</span><br><span>             src/openvpn/platform=2Ec</span><br><=
span>             src/openvpn/win32-util=2Ec</span><br><span>             s=
rc/compat/compat-gettimeofday=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            src/compat/compat-strsep=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            src/compat/compat-strtok_r=
=2Ec</span><br><span>             )</span><br><span> </span><br><span>     =
    add_library_deps(${test_name})</span><br><span>diff --git a/configure=
=2Eac b/configure=2Eac</span><br><span>index e19d651=2E=2E188f8fa 100644</s=
pan><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</sp=
an><br><span>@@ -568,7 +568,7 @@</span><br><span> 	setgroups flock gettimeo=
fday \</span><br><span> 	setsid chdir \</span><br><span> 	chsize ftruncate =
execve getpeereid basename dirname \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	epoll_create strsep \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	epoll_create strsep strtok_r \</span><br><span> ])</span=
><br><span> </span><br><span> AC_CHECK_LIB(</span><br><span>diff --git a/sr=
c/compat/Makefile=2Eam b/src/compat/Makefile=2Eam</span><br><span>index 69b=
2990=2E=2E22867b3 100644</span><br><span>--- a/src/compat/Makefile=2Eam</sp=
an><br><span>+++ b/src/compat/Makefile=2Eam</span><br><span>@@ -20,4 +20,5 =
@@</span><br><span> 	compat-basename=2Ec \</span><br><span> 	compat-gettime=
ofday=2Ec \</span><br><span> 	compat-daemon=2Ec \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	compat-strsep=2Ec</span><br><span>\ No newline=
 at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	com=
pat-strsep=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	co=
mpat-strtok_r=2Ec</span><br><span>\ No newline at end of file</span><br><sp=
an>diff --git a/src/compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Edebcdd3</span><br><span>--- /dev/null</span><br><span>+++ b/src/compat/c=
ompat-strtok_r=2Ec</span><br><span>@@ -0,0 +1,101 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*-</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * SPDX-License-Identifier: BSD-3-Clause</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Copyright (c) 1998 Softweyr LLC=2E  All rights res=
erved=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * strtok_r, from Berkeley s=
trtok</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Oct 13, 199=
8 by Wes Peters &lt;wes@softweyr=2Ecom&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Copyright (c) 1988, 1993</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *      The Regents of the University of California=2E  All r=
ights reserved=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Redistribution a=
nd use in source and binary forms, with or without</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * modification, are permitted provided that=
 the following conditions</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * are met:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 1=2E Redistributions of source code must retain the above copyright</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *    notices, this list o=
f conditions and the following disclaimer=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * 2=2E Redistributions in binary form must reprod=
uce the above copyright</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *    notices, this list of conditions and the following disclaimer in =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    documentat=
ion and/or other materials provided with the distribution=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * 3=2E Neither the name of the Un=
iversity nor the names of its contributors</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *    may be used to endorse or promote products der=
ived from this software</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *    without specific prior written permission=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * THIS SOFTWARE IS PROVIDED BY SOFTWEYR LLC, THE REGENTS=
 AND CONTRIBUTORS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 ``AS IS&#39;&#39; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NO=
T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * LIMITED TO, THE=
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * PARTICULAR PURPOSE ARE DISCLAIMED=
=2E  IN NO EVENT SHALL SOFTWEYR LLC, THE</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * REGENTS, OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, =
INDIRECT, INCIDENTAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMIT=
ED</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TO, PROCUREMEN=
T OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * PROFITS; OR BUSINESS INTERRUPTION) =
HOWEVER CAUSED AND ON ANY THEORY OF</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TOR=
T (INCLUDING</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * NEGL=
IGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * SOFTWARE, EVEN IF ADVISED OF =
THE POSSIBILITY OF SUCH DAMAGE=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_STRTOK_R=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+strtok_r(char *s, const char *delim, char=
 **last)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char *spanp, *tok;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int c, sc;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (s =3D=3D NULL &amp;&amp; (s =3D *last) =3D=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return (NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Skip (span) leading delimiters (s +=3D strspn(s, delim), sort of)=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+cont:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    c =3D *s++;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (spanp =3D (char *)delim; (sc =3D *spanp++) !=
=3D 0;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c =3D=3D sc)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            goto cont;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (c =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    { /* no non-delimiter characters */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        *last =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return (NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    tok =3D s - 1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Scan toke=
n (scan for delimiters: s +=3D strcspn(s, delim), sort of)=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * Note that delim must have =
one NUL; we stop if we see that, too=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (;;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c =3D=
 *s++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        spanp=
 =3D (char *)delim;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((sc=
 =3D *spanp++) =3D=3D c)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               if (c =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    s =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    s[-1] =3D &#39;\0&#39;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                *last =3D s;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                return (to=
k);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        } while (sc !=
=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* NOTREACHED */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>\ No newline at en=
d of file</span><br><span>diff --git a/src/compat/compat=2Eh b/src/compat/c=
ompat=2Eh</span><br><span>index 6532b86=2E=2E9e6f95c 100644</span><br><span=
>--- a/src/compat/compat=2Eh</span><br><span>+++ b/src/compat/compat=2Eh</s=
pan><br><span>@@ -61,4 +61,9 @@</span><br><span> </span><br><span> #endif</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
ndef HAVE_STRTOK_R</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
har *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strtok_r(char =
*s, const char *delim, char **last);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #endif /* COMPAT_H */</span><br><span>diff --git a/sr=
c/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>i=
ndex 47fe0bc=2E=2Efbc64fa 100644</span><br><span>--- a/src/openvpn/options_=
util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span=
>@@ -48,7 +48,8 @@</span><br><span>         message =3D strstr(reason, &quo=
t;]&quot;) + 1;</span><br><span>         /* null terminate the substring to=
 only looks for flags between [ and ] */</span><br><span>         *endoffla=
gs =3D &#39;\x00&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        const char *token =3D strtok(m, &quot;[,&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        char *lasts;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const char *token =3D strtok=
_r(m, &quot;[,&quot;, &amp;lasts);</span><br><span>         while (token)</=
span><br><span>         {</span><br><span>             if (!strncmp(token, =
&quot;backoff &quot;, strlen(&quot;backoff &quot;)))</span><br><span>@@ -81=
,7 +82,7 @@</span><br><span>             {</span><br><span>                =
 msg(D_PUSH_ERRORS, &quot;WARNING: unknown AUTH_FAIL,TEMP flag: %s&quot;, t=
oken);</span><br><span>             }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            token =3D strtok(NULL, &quot;[,&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            token =3D strto=
k_r(NULL, &quot;[,&quot;, &amp;lasts);</span><br><span>         }</span><br=
><span>     }</span><br><span> </span><br><span>diff --git a/src/openvpn/ss=
l_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index 8a0f7d2=
=2E=2E7f0af3f 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -318,9 +31=
8,10 @@</span><br><span> </span><br><span>     /* Parse allowed ciphers, ge=
tting IDs */</span><br><span>     int i =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *lasts;</span><br><span>     tmp_cipher=
s_orig =3D tmp_ciphers =3D string_alloc(ciphers, NULL);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    token =3D strtok(tm=
p_ciphers, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;lasts);</spa=
n><br><span>     while (token)</span><br><span>     {</span><br><span>     =
    ctx-&gt;allowed_ciphers[i] =3D mbedtls_ssl_get_ciphersuite_id(tls_trans=
late_cipher_name(token));</span><br><span>@@ -328,7 +329,7 @@</span><br><sp=
an>         {</span><br><span>             i++;</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        token =3D strt=
ok(NULL, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br=
><span>     }</span><br><span>     free(tmp_ciphers_orig);</span><br><span>=
 }</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_n=
cp=2Ec</span><br><span>index 649665a=2E=2E33f33ef 100644</span><br><span>--=
- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</=
span><br><span>@@ -100,7 +100,8 @@</span><br><span>     struct buffer new_l=
ist =3D alloc_buf(MAX_NCP_CIPHERS_LENGTH);</span><br><span> </span><br><spa=
n>     char *const tmp_ciphers =3D string_alloc(list, NULL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const char *token =3D strtok(tmp=
_ciphers, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *lasts;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;last=
s);</span><br><span>     while (token)</span><br><span>     {</span><br><sp=
an>         /*</span><br><span>@@ -174,7 +175,7 @@</span><br><span>        =
         buf_puts(&amp;new_list, ovpn_cipher_name);</span><br><span>       =
      }</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        token =3D strtok(NULL, &quot;:&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        token =3D strtok_r(NULL, &q=
uot;:&quot;, &amp;lasts);</span><br><span>     }</span><br><span> </span><b=
r><span> </span><br><span>@@ -207,15 +208,16 @@</span><br><span> {</span><b=
r><span>     char *tmp_ciphers =3D string_alloc(list, NULL);</span><br><spa=
n>     char *tmp_ciphers_orig =3D tmp_ciphers;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *lasts;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const char *token =3D strtok(tm=
p_ciphers, &quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *token =3D strtok_r(tmp_ciphers, &quot;:&quot;, &amp;=
lasts);</span><br><span>     while (token)</span><br><span>     {</span><br=
><span>         if (0 =3D=3D strcmp(token, item))</span><br><span>         =
{</span><br><span>             break;</span><br><span>         }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        token =3D strtok(NULL, &=
quot;:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span>   =
  }</span><br><span>     free(tmp_ciphers_orig);</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2E=
c</span><br><span>index 0804d2d=2E=2E8c6e2bc 100644</span><br><span>--- a/s=
rc/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec<=
/span><br><span>@@ -868,7 +868,8 @@</span><br><span>         return false;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const char *client_method =3D strtok(iv_sso, &quot;,=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *l=
asts;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *client_method =3D strtok_r(iv_sso, &quot;,&quot;, &amp;lasts);</span><br>=
<span>     bool supported =3D false;</span><br><span> </span><br><span>    =
 while (client_method)</span><br><span>@@ -878,7 +879,7 @@</span><br><span>=
             supported =3D true;</span><br><span>             break;</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       client_method =3D strtok(NULL, &quot;,&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        client_method =3D strtok_r(NULL, =
&quot;,&quot;, &amp;lasts);</span><br><span>     }</span><br><span> </span>=
<br><span>     gc_free(&amp;gc);</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><b=
r><span>index 1128eb4=2E=2Ed861ef9 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>@@ -107,6 +107,7 @@</span><br><span> 	$(top_s=
rcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strsep=2Ec =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src=
/compat/compat-strtok_r=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/c=
rypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/cryptoapi=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span=
>@@ -345,6 +346,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><=
br><span> 	$(top_srcdir)/src/compat/compat-strsep=2Ec \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/compat/compat-strtok=
_r=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec</span><br=
><span> </span><br><span> mbuf_testdriver_CFLAGS  =3D \</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1679?usp=3Demail">change 1679</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1679?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da42=
66371a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1679 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--XozEXjIq+sQ=--


--===============5810373519601498796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5810373519601498796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5810373519601498796==--

