Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4BCC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8DRZxw6OzFW6nbj82dOYIFmJRGFdJ+r+Xs85doyKIw=; b=hh2UFPIxz6D0CwOeQcHIVuC+2H
	lgI3wx5Hzj5Q3DPBXMQNcgulYkCWTWR2n9B63Ra+G6mXkdiYhz34l4t6KHhK7vWo6U3a7xJULOSJS
	N1VDD0ZZjaKVdb9F7kqbRU1/bI+u08Bfl85AuvInCLyup0D+Hqjqy32Y66KlCMRrr+sc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqKo-00062M-V7;
	Thu, 09 Jul 2026 15:06:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqKn-00062E-Qj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:06:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+0cZ6/V2nIt+tk6RkSFhhF39lu/3PWyxO6utf5wB8R4=; b=LxosJ+88QM+FtUgeMcpmgOS/oM
 kvb4eFZj0OOtw61jaaOhAVVpdw2SRPSj/jPUlm9PVv2Ku5zg/0KfV2I2m0Zk20gydPvqKBc+Lm8qr
 I788B7UY5Z2qovAJQmxIL48nzuV4JTesHESYVmsPDZIzA//g+S/d3YIP10NCxWgoXOmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+0cZ6/V2nIt+tk6RkSFhhF39lu/3PWyxO6utf5wB8R4=; b=m
 NKaEBPC8uuxgQHSo/wJv65e2Xk+0OQ6fABTBbUDVNRsQkeNGaBnyz7D6HYncrbXaRAs8xqCj7F5Hw
 iPCiewiZcesHirjBSBjWmux4iytIvnCcE/+v8geQpbBDqpKSMR9OSEwBUbkKSlOApd9bwebu7z12J
 n9vflmilT1LLdfWk=;
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqKe-0006NH-Vb for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:06:39 +0000
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c15c257a488so267999766b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783609581; x=1784214381; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+0cZ6/V2nIt+tk6RkSFhhF39lu/3PWyxO6utf5wB8R4=;
 b=QNGAmuTjReCIlyqAw0HWSTlZoe0kA4nEqxsUNCjrClwA9CiiDIgfNvtiqr3viTFrEp
 qgP1A8zs4LSMhSNWbKJbOr2HFRHnGl4XnIsH4hmL1fjTvKgYWfkb8w7zbTFLYs9xnbLO
 Nc5bJg4wM+2sxbA1/EFpcWB1+8zj4PDQ4mR52xA4X4GorZRrBeSxXzchfidKydlxy2H8
 0KKaz+iMPj04XPgTn+9tPGi032IT76eASC0O67q/soL6zPFocwHXqDWxBy4iSlpKcAPD
 uNyYpLfVXxDMg4zXco3rfy7uyhxnhmJ/fEGUPkmyjXSWa5JDSOPAEhUUng/4OfWH09/e
 Uk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783609581; x=1784214381;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+0cZ6/V2nIt+tk6RkSFhhF39lu/3PWyxO6utf5wB8R4=;
 b=fd4fSvzKIyG7YcR42AwmDuGI8AOMaBm9UNiy5MBic952MDAC3kgjih3uY+icq7Xzd5
 1Wf9tr7F9iDHRjuFBLiidJEWehmvSkorVVWxNBGpYctz2yw6SWbwZ3rPMAfnxJNyVkDW
 HHHViWMj9fINNLp6Jr8DXkTaF1OkqkYUE13X/e76PKXmxzz7SZMKuiuSMXyUL8+pindI
 voc27CIIRWyUhFsz+NT6Mp37khcsVX27+wAH59yrPMieO4rfsxHfzEK5ERz+EvLZVbaL
 jhfERw0ALCAL941K0aehGrsTWlgEKsRhxE8JBs1fKHBbaUsKYHoLjUUomacCjwGspaPA
 Urwg==
X-Gm-Message-State: AOJu0Ywrggu2a76C5buI4gEREW/MiP+h6wKYHmTngKXgZPYeNycy8epB
 pHySxodGTTFAfA58BI8hoeUjgIpDS8DD9e2dL6qyt/hg+I81YLYZjKx0hWtKouMSUbSopLJPRAf
 m7NsvhXb/jwf9I4MYwEjTqr8K8HTPnpwhxzdggG+mP7eNXhOwiXt7laqRjDcQ0jOg/XXO9d7H9P
 q+3mqUQg==
X-Gm-Gg: AfdE7cl9JMqlT6wS+FgRfWAY4JGMZgpPid5WzwRgj7krcg5X9nKPV5Owbo/XQr975IA
 NOD2baMGhSgacFefhsKBJp/OlkoFNGQyge7fgnkB/yO9fhah54+nyv4bm8aXrNh/kOQ3+a0p9Uy
 JQctPHkHoK3h8vLxDdFdQw9Q89/UWntCE3YqfUFASl1nlTkI84e+3BWK4K3/Pyez2KJ+12CjFvF
 ib8/bX+QwyLoGz4LrCpOo346uY5+lqvtz+mXKGET3ojAdpxx9xtgAPU+6pLE0YNqai//j1aDi3y
 FmZ1pIMWdUbafzFteqRx5pNEEXWs5gsSZkBW0kqk1SDxqThWhzC2oJrQzzjsEOsSEyI7zyfsKkb
 +Z20cXYBPhVogMRUmmUL1+SAf3cG/8XbYKww74KuySkMj0HllK90jKFtwMD3gwvRsRZwwG8WbzO
 13DWEbGGx7F42844nk9uhgxh5c7f9GUAFoIiq9bc0nseUGpkLU9c0IlRDbUmEDeyFLhSDPQQiEk
 XWiP5Ust3DGlal/kFGy+dRXjtLcWTqSQAs66rHd0paWVTvVo2nyeaRhlLAp6pv+7PbLcOdwt0Q4
 elk=
X-Received: by 2002:a05:600c:3f0a:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-493e9838135mr38480285e9.3.1783602954603; 
 Thu, 09 Jul 2026 06:15:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74b3edsm68442825e9.15.2026.07.09.06.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:15:54 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 13:15:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: d7db979d9a871573dd8a4f14fa9e51358e0ff666
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <65e04ffc59e9302e08b8238d0bafdd77f5c9d7ea-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqKe-0006NH-Vb
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 file access code from options.c
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1662105080141944989=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1662105080141944989==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RMIBoPJxctE="; charset=UTF-8

--RMIBoPJxctE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1774?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: options: Factor out file access code from options=2Ec
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: Factor =
out file access code from options=2Ec

options=2Ec is a huge, unwieldly fil=
e=2E So remove some
closely related code that has no direct dependencies
wi=
th the other functions in the file=2E

This time it is the code that checks=
 file accessibility=2E

Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81=
e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M CMakeLis=
ts=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/check_file_access=2Ec
A =
src/openvpn/check_file_access=2Eh
M src/openvpn/options=2Ec
5 files changed=
, 412 insertions(+), 334 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/74/1774/2

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 3981bae=2E=2Ea4f20c9 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -422,6 +422,8 @@
     src/openvpn/basic=2Eh
    =
 src/openvpn/buffer=2Ec
     src/openvpn/buffer=2Eh
+    src/openvpn/check_=
file_access=2Ec
+    src/openvpn/check_file_access=2Eh
     src/openvpn/cir=
c_list=2Eh
     src/openvpn/clinat=2Ec
     src/openvpn/clinat=2Eh
diff --g=
it a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 9778f32=2E=
=2E1fbcad4 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefil=
e=2Eam
@@ -47,6 +47,7 @@
 	base64=2Ec base64=2Eh \
 	basic=2Eh \
 	buffer=
=2Ec buffer=2Eh \
+	check_file_access=2Ec check_file_access=2Eh \
 	circ_li=
st=2Eh \
 	clinat=2Ec clinat=2Eh \
 	common=2Eh \
diff --git a/src/openvpn/=
check_file_access=2Ec b/src/openvpn/check_file_access=2Ec
new file mode 100=
644
index 0000000=2E=2Efceb851
--- /dev/null
+++ b/src/openvpn/check_file_a=
ccess=2Ec
@@ -0,0 +1,372 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single UDP port, with support for=
 SSL/TLS-based
+ *             session authentication and key exchange,
+ *=
             packet encryption, packet authentication, and
+ *             =
packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@eurephia=
=2Eorg>
+ *
+ *  This program is free software; you can redistribute it and=
/or modify
+ *  it under the terms of the GNU General Public License versio=
n 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This prog=
ram is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License f=
or more details=2E
+ *
+ *  You should have received a copy of the GNU Gene=
ral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*
+ *  Check file/directory sanity
+ *
=
+ */
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+/* Expect peop=
le using the stripped down version to know what they do */
+#ifndef ENABLE_=
SMALL
+
+#include "syshead=2Eh"
+
+#include "argv=2Eh"
+#include "buffer=2E=
h"
+#include "error=2Eh"
+#include "options=2Eh"
+#include "platform=2Eh"
+=
#include "ssl_common=2Eh"
+
+#include <string=2Eh>
+
+#define CHKACC_FILE  =
     (1 << 0) /**< Check for a file/directory presence */
+#define CHKACC_D=
IRPATH    (1 << 1) /**< Check for directory presence where a file should re=
side */
+#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writ=
able? */
+#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it'=
s allowed and "exists" */
+#define CHKACC_PRIVATE    (1 << 4) /**< Warn if =
this (private) file is group/others accessible */
+#define CHKACC_ACCEPT_UR=
I (1 << 5) /**< Do not check URIs, unless they start with file: */
+
+stati=
c bool
+check_file_access(const int type, const char *file, const int mode,=
 const char *opt)
+{
+    int errcode =3D 0;
+
+    /* If no file configure=
d, no errors to look for */
+    if (!file)
+    {
+        return false;
+=
    }
+
+    /* If stdin is allowed and the file name is 'stdin', then do n=
o
+     * further checks as stdin is always available
+     */
+    if ((ty=
pe & CHKACC_ACPTSTDIN) && streq(file, "stdin"))
+    {
+        return fals=
e;
+    }
+
+    /* file name is a URI if its first segment  has ":" (i=2Ee=
=2E, before any "/")
+     * Then no checks done if CHKACC_ACCEPT_URI is se=
t and the URI does not start with "file:"
+     */
+    if ((type & CHKACC_=
ACCEPT_URI) && strchr(file, ':'))
+    {
+        if (!strncmp(file, "file:=
", 5))
+        {
+            file +=3D 5;
+        }
+        else if (!s=
trchr(file, '/') || strchr(file, '/') > strchr(file, ':'))
+        {
+    =
        return false;
+        }
+    }
+
+    /* Is the directory path lea=
ding to the given file accessible? */
+    if (type & CHKACC_DIRPATH)
+    =
{
+        char *fullpath =3D
+            string_alloc(file, NULL); /* POS=
IX dirname() implementation may modify its arguments */
+        const char=
 *dirpath =3D dirname(fullpath);
+
+        if (platform_access(dirpath, mo=
de | X_OK) !=3D 0)
+        {
+            errcode =3D errno;
+        }
+ =
       free(fullpath);
+    }
+
+    /* Is the file itself accessible? */
+=
    if (!errcode && (type & CHKACC_FILE) && (platform_access(file, mode) !=
=3D 0))
+    {
+        errcode =3D errno;
+    }
+
+    /* If the file exi=
sts and is accessible, is it writable? */
+    if (!errcode && (type & CHKA=
CC_FILEXSTWR) && (platform_access(file, F_OK) =3D=3D 0))
+    {
+        if=
 (platform_access(file, W_OK) !=3D 0)
+        {
+            errcode =3D e=
rrno;
+        }
+    }
+
+    /* Warn if a given private file is group/oth=
ers accessible=2E */
+    if (type & CHKACC_PRIVATE)
+    {
+        platfo=
rm_stat_t st;
+        if (platform_stat(file, &st))
+        {
+          =
  msg(M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
+        }=

+#ifndef _WIN32
+        else
+        {
+            if (st=2Est_mode & (=
S_IRWXG | S_IRWXO))
+            {
+                msg(M_WARN, "WARNING: f=
ile '%s' is group or others accessible", file);
+            }
+        }
+=
#endif
+    }
+
+    /* Scream if an error is found */
+    if (errcode > 0=
)
+    {
+        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'"=
, opt, file);
+    }
+
+    /* Return true if an error occurred */
+    ret=
urn (errcode !=3D 0 ? true : false);
+}
+
+/* A wrapper for check_file_acce=
ss() which also takes a chroot directory=2E
+ * If chroot is NULL, behaviou=
r is exactly the same as calling check_file_access() directly,
+ * otherwis=
e it will look for the file inside the given chroot directory instead=2E
+ =
*/
+static bool
+check_file_access_chroot(const char *chroot, const int typ=
e, const char *file, const int mode,
+                         const char *=
opt)
+{
+    bool ret =3D false;
+
+    /* If no file configured, no errors=
 to look for */
+    if (!file)
+    {
+        return false;
+    }
+
+   =
 /* If chroot is set, look for the file/directory inside the chroot */
+   =
 if (chroot)
+    {
+        struct gc_arena gc =3D gc_new();
+        stru=
ct buffer chroot_file;
+
+        chroot_file =3D prepend_dir(chroot, file,=
 &gc);
+        ret =3D check_file_access(type, BSTR(&chroot_file), mode, o=
pt);
+        gc_free(&gc);
+    }
+    else
+    {
+        /* No chroot i=
n play, just call core file check function */
+        ret =3D check_file_a=
ccess(type, file, mode, opt);
+    }
+    return ret;
+}
+
+/**
+ * A wrapp=
er for check_file_access_chroot() that returns false immediately if
+ * the=
 file is inline (and therefore there is no access to check)
+ */
+static bo=
ol
+check_file_access_chroot_inline(bool is_inline, const char *chroot, con=
st int type,
+                                const char *file, const int m=
ode, const char *opt)
+{
+    if (is_inline)
+    {
+        return false;
=
+    }
+
+    return check_file_access_chroot(chroot, type, file, mode, opt=
);
+}
+
+/**
+ * A wrapper for check_file_access() that returns false immed=
iately if the file
+ * is inline (and therefore there is no access to check=
)
+ */
+static bool
+check_file_access_inline(bool is_inline, const int typ=
e, const char *file, const int mode,
+                         const char *=
opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+    ret=
urn check_file_access(type, file, mode, opt);
+}
+
+/*
+ * Verifies that th=
e path in the "command" that comes after certain script options (e=2Eg=2E, =
--up) is a
+ * valid file with appropriate permissions=2E
+ *
+ * "command"=
 consists of a path, optionally followed by a space, which may be
+ * follo=
wed by arbitrary arguments=2E It is NOT a full shell command line -- shell =
expansion is not
+ * performed=2E
+ *
+ * The path and arguments in "comman=
d" may be single- or double-quoted or escaped=2E
+ *
+ * The path is extrac=
ted from "command", then check_file_access() is called to check it=2E The
+=
 * arguments, if any, are ignored=2E
+ *
+ * Note that the type, mode, and =
opt arguments to this routine are the same as the corresponding
+ * check_f=
ile_access() arguments=2E
+ */
+bool
+check_cmd_access(const char *command,=
 const char *opt, const char *chroot)
+{
+    struct argv argv;
+    bool r=
eturn_code;
+
+    /* If no command was set, there are no errors to look fo=
r */
+    if (!command)
+    {
+        return false;
+    }
+
+    /* Extr=
act executable path and arguments */
+    argv =3D argv_new();
+    argv_pa=
rse_cmd(&argv, command);
+
+    /* if an executable is specified then check=
 it; otherwise, complain */
+    if (argv=2Eargv[0])
+    {
+        /* Scr=
ipts requires R_OK as well, but that might fail on binaries which
+        =
 * only requires X_OK to function on Unix - a scenario not unlikely to
+   =
      * be seen on suid binaries=2E
+         */
+        return_code =3D c=
heck_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);
+ =
   }
+    else
+    {
+        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%=
s': No path to executable=2E", opt, command);
+        return_code =3D true=
;
+    }
+
+    argv_free(&argv);
+
+    return return_code;
+}
+
+/*
+ * S=
anity check of all file/dir options=2E  Checks that file/dir
+ * is accessi=
ble by OpenVPN
+ */
+void
+options_postprocess_filechecks(struct options *o=
ptions)
+{
+    bool errs =3D false;
+
+    /* ** SSL/TLS/crypto related fi=
les ** */
+    errs |=3D check_file_access_inline(options->dh_file_inline, =
CHKACC_FILE, options->dh_file, R_OK,
+                                     =
"--dh");
+
+    if (!options->verify_hash_no_ca)
+    {
+        errs |=3D =
check_file_access_inline(options->ca_file_inline, CHKACC_FILE, options->ca_=
file,
+                                         R_OK, "--ca");
+    }
+
+  =
  errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, opti=
ons->ca_path, R_OK,
+                                     "--capath");
+
+ =
   errs |=3D check_file_access_inline(options->cert_file_inline, CHKACC_FIL=
E | CHKACC_ACCEPT_URI,
+                                     options->cert_=
file, R_OK, "--cert");
+
+    errs |=3D check_file_access_inline(options->e=
xtra_certs_file, CHKACC_FILE,
+                                     options=
->extra_certs_file, R_OK, "--extra-certs");
+
+    if (!(options->managemen=
t_flags & MF_EXTERNAL_KEY))
+    {
+        errs |=3D check_file_access_inl=
ine(options->priv_key_file_inline,
+                                       =
  CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
+                      =
                   options->priv_key_file, R_OK, "--key");
+    }
+
+    er=
rs |=3D check_file_access_inline(options->pkcs12_file_inline, CHKACC_FILE |=
 CHKACC_PRIVATE,
+                                     options->pkcs12_file=
, R_OK, "--pkcs12");
+
+    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
+=
    {
+        errs |=3D check_file_access_chroot(options->chroot_dir, CHKA=
CC_FILE, options->crl_file,
+                                         R_OK =
| X_OK, "--crl-verify directory");
+    }
+    else
+    {
+        errs |=
=3D
+            check_file_access_chroot_inline(options->crl_file_inline, =
options->chroot_dir,
+                                            CHKACC_FI=
LE, options->crl_file, R_OK, "--crl-verify");
+    }
+
+    if (options->tl=
s_export_peer_cert_dir)
+    {
+        errs |=3D
+            check_file_a=
ccess_chroot(options->chroot_dir, CHKACC_FILE,
+                           =
          options->tls_export_peer_cert_dir, W_OK, "--tls-export-cert");
+ =
   }
+
+    ASSERT(options->connection_list);
+    for (int i =3D 0; i < op=
tions->connection_list->len; ++i)
+    {
+        const struct connection_e=
ntry *ce =3D options->connection_list->array[i];
+
+        errs |=3D check=
_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,=

+                                         ce->tls_auth_file, R_OK, "--tls-=
auth");
+        errs |=3D check_file_access_inline(ce->tls_crypt_file_inli=
ne, CHKACC_FILE | CHKACC_PRIVATE,
+                                        =
 ce->tls_crypt_file, R_OK, "--tls-crypt");
+        errs |=3D check_file_ac=
cess_inline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+  =
                                       ce->tls_crypt_v2_file, R_OK, "--tls-=
crypt-v2");
+    }
+
+    errs |=3D
+        check_file_access_inline(optio=
ns->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+             =
                    options->shared_secret_file, R_OK, "--secret");
+
+    =
errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->pac=
ket_id_file,
+                              R_OK | W_OK, "--replay-persist"=
);
+
+    /* ** Password files ** */
+    errs |=3D check_file_access(CHKAC=
C_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                              =
options->key_pass_file, R_OK, "--askpass");
+#ifdef ENABLE_MANAGEMENT
+    =
errs |=3D
+        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKAC=
C_PRIVATE,
+                          options->management_user_pass, R_OK, =
"--management user/password file");
+#endif /* ENABLE_MANAGEMENT */
+    er=
rs |=3D check_file_access_inline(options->auth_user_pass_file_inline,
+    =
                                 CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PR=
IVATE,
+                                     options->auth_user_pass_file, =
R_OK, "--auth-user-pass");
+    /* ** System related ** */
+    errs |=3D c=
heck_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "--chroot d=
irectory");
+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXS=
TWR, options->writepid, R_OK | W_OK,
+                              "--writ=
epid");
+
+    /* ** Log related ** */
+    errs |=3D check_file_access(CHK=
ACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,
+       =
                       "--status");
+
+    /* ** Config related ** */
+    =
errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, option=
s->client_config_dir,
+                                     R_OK | X_OK, "-=
-client-config-dir");
+    errs |=3D check_file_access_chroot(options->chro=
ot_dir, CHKACC_FILE, options->tmp_dir,
+                                   =
  R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
+
+    if (errs)
=
+    {
+        msg(M_USAGE, "Please correct these errors=2E");
+    }
+}
+=

+#endif /* !ENABLE_SMALL */
diff --git a/src/openvpn/check_file_access=2Eh=
 b/src/openvpn/check_file_access=2Eh
new file mode 100644
index 0000000=2E=
=2Eaf057bc
--- /dev/null
+++ b/src/openvpn/check_file_access=2Eh
@@ -0,0 +1=
,36 @@
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
+#ifndef CHECK_FILE_ACCESS_H
+#define CHECK_FILE_ACCESS_H
=
+
+#ifndef ENABLE_SMALL
+
+#include "options=2Eh"
+
+bool check_cmd_access(=
const char *command, const char *opt, const char *chroot);
+
+void options_=
postprocess_filechecks(struct options *options);
+
+#endif /* !ENABLE_SMALL=
 */
+
+#endif
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2E=
c
index 6e314a1=2E=2E03cda5a 100644
--- a/src/openvpn/options=2Ec
+++ b/src=
/openvpn/options=2Ec
@@ -63,6 +63,7 @@
 #include "tun_afunix=2Eh"
 #include=
 "domain_helper=2Eh"
 #include "mbuf=2Eh"
+#include "check_file_access=2Eh"=

 
 #include <ctype=2Eh>
 
@@ -3336,340 +3337,6 @@
 }
 
 /*
- *  Check file=
/directory sanity
- *
- */
-/* Expect people using the stripped down versio=
n to know what they do */
-#ifndef ENABLE_SMALL
-
-#define CHKACC_FILE     =
  (1 << 0) /**< Check for a file/directory presence */
-#define CHKACC_DIRP=
ATH    (1 << 1) /**< Check for directory presence where a file should resid=
e */
-#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writabl=
e? */
-#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's a=
llowed and "exists" */
-#define CHKACC_PRIVATE    (1 << 4) /**< Warn if thi=
s (private) file is group/others accessible */
-#define CHKACC_ACCEPT_URI (=
1 << 5) /**< Do not check URIs, unless they start with file: */
-
-static b=
ool
-check_file_access(const int type, const char *file, const int mode, co=
nst char *opt)
-{
-    int errcode =3D 0;
-
-    /* If no file configured, =
no errors to look for */
-    if (!file)
-    {
-        return false;
-   =
 }
-
-    /* If stdin is allowed and the file name is 'stdin', then do no
-=
     * further checks as stdin is always available
-     */
-    if ((type =
& CHKACC_ACPTSTDIN) && streq(file, "stdin"))
-    {
-        return false;
=
-    }
-
-    /* file name is a URI if its first segment  has ":" (i=2Ee=2E=
, before any "/")
-     * Then no checks done if CHKACC_ACCEPT_URI is set a=
nd the URI does not start with "file:"
-     */
-    if ((type & CHKACC_ACC=
EPT_URI) && strchr(file, ':'))
-    {
-        if (!strncmp(file, "file:", =
5))
-        {
-            file +=3D 5;
-        }
-        else if (!strc=
hr(file, '/') || strchr(file, '/') > strchr(file, ':'))
-        {
-       =
     return false;
-        }
-    }
-
-    /* Is the directory path leadin=
g to the given file accessible? */
-    if (type & CHKACC_DIRPATH)
-    {
-=
        char *fullpath =3D
-            string_alloc(file, NULL); /* POSIX =
dirname() implementation may modify its arguments */
-        const char *d=
irpath =3D dirname(fullpath);
-
-        if (platform_access(dirpath, mode =
| X_OK) !=3D 0)
-        {
-            errcode =3D errno;
-        }
-    =
    free(fullpath);
-    }
-
-    /* Is the file itself accessible? */
-   =
 if (!errcode && (type & CHKACC_FILE) && (platform_access(file, mode) !=3D =
0))
-    {
-        errcode =3D errno;
-    }
-
-    /* If the file exists =
and is accessible, is it writable? */
-    if (!errcode && (type & CHKACC_F=
ILEXSTWR) && (platform_access(file, F_OK) =3D=3D 0))
-    {
-        if (pl=
atform_access(file, W_OK) !=3D 0)
-        {
-            errcode =3D errno=
;
-        }
-    }
-
-    /* Warn if a given private file is group/others =
accessible=2E */
-    if (type & CHKACC_PRIVATE)
-    {
-        platform_s=
tat_t st;
-        if (platform_stat(file, &st))
-        {
-            ms=
g(M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
-        }
-#i=
fndef _WIN32
-        else
-        {
-            if (st=2Est_mode & (S_IR=
WXG | S_IRWXO))
-            {
-                msg(M_WARN, "WARNING: file =
'%s' is group or others accessible", file);
-            }
-        }
-#end=
if
-    }
-
-    /* Scream if an error is found */
-    if (errcode > 0)
- =
   {
-        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", op=
t, file);
-    }
-
-    /* Return true if an error occurred */
-    return =
(errcode !=3D 0 ? true : false);
-}
-
-/* A wrapper for check_file_access()=
 which also takes a chroot directory=2E
- * If chroot is NULL, behaviour is=
 exactly the same as calling check_file_access() directly,
- * otherwise it=
 will look for the file inside the given chroot directory instead=2E
- */
-=
static bool
-check_file_access_chroot(const char *chroot, const int type, c=
onst char *file, const int mode,
-                         const char *opt)=

-{
-    bool ret =3D false;
-
-    /* If no file configured, no errors to =
look for */
-    if (!file)
-    {
-        return false;
-    }
-
-    /* =
If chroot is set, look for the file/directory inside the chroot */
-    if =
(chroot)
-    {
-        struct gc_arena gc =3D gc_new();
-        struct b=
uffer chroot_file;
-
-        chroot_file =3D prepend_dir(chroot, file, &gc=
);
-        ret =3D check_file_access(type, BSTR(&chroot_file), mode, opt);=

-        gc_free(&gc);
-    }
-    else
-    {
-        /* No chroot in pl=
ay, just call core file check function */
-        ret =3D check_file_acces=
s(type, file, mode, opt);
-    }
-    return ret;
-}
-
-/**
- * A wrapper f=
or check_file_access_chroot() that returns false immediately if
- * the fil=
e is inline (and therefore there is no access to check)
- */
-static bool
-=
check_file_access_chroot_inline(bool is_inline, const char *chroot, const i=
nt type,
-                                const char *file, const int mode,=
 const char *opt)
-{
-    if (is_inline)
-    {
-        return false;
-   =
 }
-
-    return check_file_access_chroot(chroot, type, file, mode, opt);
-=
}
-
-/**
- * A wrapper for check_file_access() that returns false immediate=
ly if the file
- * is inline (and therefore there is no access to check)
- =
*/
-static bool
-check_file_access_inline(bool is_inline, const int type, c=
onst char *file, const int mode,
-                         const char *opt)=

-{
-    if (is_inline)
-    {
-        return false;
-    }
-
-    return =
check_file_access(type, file, mode, opt);
-}
-
-/*
- * Verifies that the pa=
th in the "command" that comes after certain script options (e=2Eg=2E, --up=
) is a
- * valid file with appropriate permissions=2E
- *
- * "command" con=
sists of a path, optionally followed by a space, which may be
- * followed =
by arbitrary arguments=2E It is NOT a full shell command line -- shell expa=
nsion is not
- * performed=2E
- *
- * The path and arguments in "command" m=
ay be single- or double-quoted or escaped=2E
- *
- * The path is extracted =
from "command", then check_file_access() is called to check it=2E The
- * a=
rguments, if any, are ignored=2E
- *
- * Note that the type, mode, and opt =
arguments to this routine are the same as the corresponding
- * check_file_=
access() arguments=2E
- */
-static bool
-check_cmd_access(const char *comma=
nd, const char *opt, const char *chroot)
-{
-    struct argv argv;
-    boo=
l return_code;
-
-    /* If no command was set, there are no errors to look=
 for */
-    if (!command)
-    {
-        return false;
-    }
-
-    /* E=
xtract executable path and arguments */
-    argv =3D argv_new();
-    argv=
_parse_cmd(&argv, command);
-
-    /* if an executable is specified then ch=
eck it; otherwise, complain */
-    if (argv=2Eargv[0])
-    {
-        /* =
Scripts requires R_OK as well, but that might fail on binaries which
-     =
    * only requires X_OK to function on Unix - a scenario not unlikely to
-=
         * be seen on suid binaries=2E
-         */
-        return_code =
=3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt=
);
-    }
-    else
-    {
-        msg(M_NOPREFIX | M_OPTERR, "%s fails wi=
th '%s': No path to executable=2E", opt, command);
-        return_code =3D=
 true;
-    }
-
-    argv_free(&argv);
-
-    return return_code;
-}
-
-/*
=
- * Sanity check of all file/dir options=2E  Checks that file/dir
- * is ac=
cessible by OpenVPN
- */
-static void
-options_postprocess_filechecks(struc=
t options *options)
-{
-    bool errs =3D false;
-
-    /* ** SSL/TLS/crypt=
o related files ** */
-    errs |=3D check_file_access_inline(options->dh_f=
ile_inline, CHKACC_FILE, options->dh_file, R_OK,
-                         =
            "--dh");
-
-    if (!options->verify_hash_no_ca)
-    {
-      =
  errs |=3D check_file_access_inline(options->ca_file_inline, CHKACC_FILE, =
options->ca_file,
-                                         R_OK, "--ca");
=
-    }
-
-    errs |=3D check_file_access_chroot(options->chroot_dir, CHKAC=
C_FILE, options->ca_path, R_OK,
-                                     "--ca=
path");
-
-    errs |=3D check_file_access_inline(options->cert_file_inline=
, CHKACC_FILE | CHKACC_ACCEPT_URI,
-                                     op=
tions->cert_file, R_OK, "--cert");
-
-    errs |=3D check_file_access_inlin=
e(options->extra_certs_file, CHKACC_FILE,
-                                =
     options->extra_certs_file, R_OK, "--extra-certs");
-
-    if (!(option=
s->management_flags & MF_EXTERNAL_KEY))
-    {
-        errs |=3D check_fil=
e_access_inline(options->priv_key_file_inline,
-                           =
              CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
-          =
                               options->priv_key_file, R_OK, "--key");
-   =
 }
-
-    errs |=3D check_file_access_inline(options->pkcs12_file_inline, C=
HKACC_FILE | CHKACC_PRIVATE,
-                                     options-=
>pkcs12_file, R_OK, "--pkcs12");
-
-    if (options->ssl_flags & SSLF_CRL_V=
ERIFY_DIR)
-    {
-        errs |=3D check_file_access_chroot(options->chro=
ot_dir, CHKACC_FILE, options->crl_file,
-                                  =
       R_OK | X_OK, "--crl-verify directory");
-    }
-    else
-    {
-   =
     errs |=3D
-            check_file_access_chroot_inline(options->crl_fi=
le_inline, options->chroot_dir,
-                                          =
  CHKACC_FILE, options->crl_file, R_OK, "--crl-verify");
-    }
-
-    if (=
options->tls_export_peer_cert_dir)
-    {
-        errs |=3D
-            c=
heck_file_access_chroot(options->chroot_dir, CHKACC_FILE,
-                =
                     options->tls_export_peer_cert_dir, W_OK, "--tls-export=
-cert");
-    }
-
-    ASSERT(options->connection_list);
-    for (int i =
=3D 0; i < options->connection_list->len; ++i)
-    {
-        const struct=
 connection_entry *ce =3D options->connection_list->array[i];
-
-        er=
rs |=3D check_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CH=
KACC_PRIVATE,
-                                         ce->tls_auth_file, =
R_OK, "--tls-auth");
-        errs |=3D check_file_access_inline(ce->tls_cr=
ypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                           =
              ce->tls_crypt_file, R_OK, "--tls-crypt");
-        errs |=3D =
check_file_access_inline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC=
_PRIVATE,
-                                         ce->tls_crypt_v2_file, =
R_OK, "--tls-crypt-v2");
-    }
-
-    errs |=3D
-        check_file_access=
_inline(options->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-=
                                 options->shared_secret_file, R_OK, "--secr=
et");
-
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR,=
 options->packet_id_file,
-                              R_OK | W_OK, "--re=
play-persist");
-
-    /* ** Password files ** */
-    errs |=3D check_file=
_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                 =
             options->key_pass_file, R_OK, "--askpass");
-#ifdef ENABLE_MAN=
AGEMENT
-    errs |=3D
-        check_file_access(CHKACC_FILE | CHKACC_ACPT=
STDIN | CHKACC_PRIVATE,
-                          options->management_user=
_pass, R_OK, "--management user/password file");
-#endif /* ENABLE_MANAGEME=
NT */
-    errs |=3D check_file_access_inline(options->auth_user_pass_file_=
inline,
-                                     CHKACC_FILE | CHKACC_ACPTSTDI=
N | CHKACC_PRIVATE,
-                                     options->auth_use=
r_pass_file, R_OK, "--auth-user-pass");
-    /* ** System related ** */
-  =
  errs |=3D check_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK=
, "--chroot directory");
-    errs |=3D check_file_access(CHKACC_DIRPATH | =
CHKACC_FILEXSTWR, options->writepid, R_OK | W_OK,
-                        =
      "--writepid");
-
-    /* ** Log related ** */
-    errs |=3D check_fi=
le_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W=
_OK,
-                              "--status");
-
-    /* ** Config relate=
d ** */
-    errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC=
_FILE, options->client_config_dir,
-                                     R_=
OK | X_OK, "--client-config-dir");
-    errs |=3D check_file_access_chroot(=
options->chroot_dir, CHKACC_FILE, options->tmp_dir,
-                      =
               R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
-
- =
   if (errs)
-    {
-        msg(M_USAGE, "Please correct these errors=2E")=
;
-    }
-}
-#endif /* !ENABLE_SMALL */
-
-/*
  * Sanity check on options=
=2E
  * Also set some options based on other
  * options=2E

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd=
5e4b5d81e
Gerrit-Change-Number: 1774
Gerrit-PatchSet: 2
Gerrit-Owner: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--RMIBoPJxctE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
tions: Factor out file access code from options=2Ec<br><br>options=2Ec is a=
 huge, unwieldly file=2E So remove some<br>closely related code that has no=
 direct dependencies<br>with the other functions in the file=2E<br><br>This=
 time it is the code that checks file accessibility=2E<br><br>Change-Id: I6=
dafab74b82fbf770c1798b4851a0fd5e4b5d81e<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/open=
vpn/Makefile=2Eam<br>A src/openvpn/check_file_access=2Ec<br>A src/openvpn/c=
heck_file_access=2Eh<br>M src/openvpn/options=2Ec<br>5 files changed, 412 i=
nsertions(+), 334 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 3981bae=2E=
=2Ea4f20c9 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>++=
+ b/CMakeLists=2Etxt</span><br><span>@@ -422,6 +422,8 @@</span><br><span>  =
   src/openvpn/basic=2Eh</span><br><span>     src/openvpn/buffer=2Ec</span>=
<br><span>     src/openvpn/buffer=2Eh</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    src/openvpn/check_file_access=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=2Eh</=
span><br><span>     src/openvpn/circ_list=2Eh</span><br><span>     src/open=
vpn/clinat=2Ec</span><br><span>     src/openvpn/clinat=2Eh</span><br><span>=
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><b=
r><span>index 9778f32=2E=2E1fbcad4 100644</span><br><span>--- a/src/openvpn=
/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><s=
pan>@@ -47,6 +47,7 @@</span><br><span> 	base64=2Ec base64=2Eh \</span><br><=
span> 	basic=2Eh \</span><br><span> 	buffer=2Ec buffer=2Eh \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	check_file_access=2Ec check_file_=
access=2Eh \</span><br><span> 	circ_list=2Eh \</span><br><span> 	clinat=2Ec=
 clinat=2Eh \</span><br><span> 	common=2Eh \</span><br><span>diff --git a/s=
rc/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec</span>=
<br><span>new file mode 100644</span><br><span>index 0000000=2E=2Efceb851</=
span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/check_file_a=
ccess=2Ec</span><br><span>@@ -0,0 +1,372 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             session authentication and key exchan=
ge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             p=
acket encryption, packet authentication, and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2008-2026 David Sommerseth &lt;dazo@eurephia=2Eorg&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Check file/directory sanity</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Expect people using the stripped down =
version to know what they do */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;argv=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_common=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILE       (1 &lt;&lt; 0=
) /**&lt; Check for a file/directory presence */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CHKACC_DIRPATH    (1 &lt;&lt; 1) /**&l=
t; Check for directory presence where a file should reside */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILEXSTWR  (1 &lt;=
&lt; 2) /**&lt; If file exists, is it writable? */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN  (1 &lt;&lt; 3) /**=
&lt; If filename is stdin, it&#39;s allowed and &quot;exists&quot; */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_PRIVATE   =
 (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is group/others accessi=
ble */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKAC=
C_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless they start wi=
th file: */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+check_file_access(const int type, c=
onst char *file, const int mode, const char *opt)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int errcode =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* If no file configured, no errors to look for */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!file)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If stdin is =
allowed and the file name is &#39;stdin&#39;, then do no</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * further checks as stdin is alwa=
ys available</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((type &amp;=
 CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* file name is a URI if its first segment  has &quot;:&quot; (i=2Ee=2E, b=
efore any &quot;/&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI doe=
s not start with &quot;file:&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&amp; strchr(file, &#39;:&#3=
9;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strncmp(file, &q=
uot;file:&quot;, 5))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   file +=3D 5;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else i=
f (!strchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39;) &gt; strchr(file=
, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Is the directory path leading to the given f=
ile accessible? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (type &amp; CHKACC_DIRPATH)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        char *fullpath =3D</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            string_alloc(file, NULL); /* POSIX dirname() implementat=
ion may modify its arguments */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const char *dirpath =3D dirname(fullpath);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (platform_access(dirpath, mode | X_OK) !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            errcode =3D=
 errno;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(fullpath)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Is the file itself accessible? */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!errcode &amp;&amp; (t=
ype &amp; CHKACC_FILE) &amp;&amp; (platform_access(file, mode) !=3D 0))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        errcode =3D errno;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* If the file exists and is accessible, is it writable? */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!errcode &a=
mp;&amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (platform_access(file, F_=
OK) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (platfor=
m_access(file, W_OK) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           errcode =3D errno;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Warn if a given private fi=
le is group/others accessible=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (type &amp; CHKACC_PRIVATE)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        platform_stat_t st;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (platform_stat(file, &amp;st))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_ERRNO, &quo=
t;WARNING: cannot stat file &#39;%s&#39;&quot;, file);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (st=2Est_mode &amp; (S_IRWXG | S_IRWXO))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;WARNING=
: file &#39;%s&#39; is group or others accessible&quot;, file);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Scream if a=
n error is found */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (errcode &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_NOPREFIX | M_OPTERR | M_ERRNO, &quot;%s fails with &#39;%s&#39;&quot;, =
opt, file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Return true if an error occurred *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (errcod=
e !=3D 0 ? true : false);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* A wrapper for check_file_acc=
ess() which also takes a chroot directory=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * If chroot is NULL, behaviour is exactly the sam=
e as calling check_file_access() directly,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * otherwise it will look for the file inside the gi=
ven chroot directory instead=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_file_a=
ccess_chroot(const char *chroot, const int type, const char *file, const in=
t mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
             const char *opt)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If no file confi=
gured, no errors to look for */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!file)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* If chroot is set, look for the =
file/directory inside the chroot */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (chroot)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        struct buffer chroot_file;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        chroot_file =3D prepend_dir(chroot, file, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D chec=
k_file_access(type, BSTR(&amp;chroot_file), mode, opt);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* No chroot in play, just call core file check function */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D check_fi=
le_access(type, file, mode, opt);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * A wrapper for check_file_access_chroot() that returns =
false immediately if</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * the file is inline (and therefore there is no access to check)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_file_access_chroot_inline(bool is_inline, cons=
t char *chroot, const int type,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                const char *file, const int mod=
e, const char *opt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_inline)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return check_file_access_chroot(chroot, type, file, mode, op=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * A wrapper for check_file_access() that returns false immediately i=
f the file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is inl=
ine (and therefore there is no access to check)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check_file_access_inline(bool is_inline, const int type, const char *fi=
le, const int mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                         const char *opt)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return check_file_access(type, file, =
mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Verifies that the path in the &quot;command&quot; that come=
s after certain script options (e=2Eg=2E, --up) is a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * valid file with appropriate permission=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * &quot;command&quot; consists =
of a path, optionally followed by a space, which may be</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * followed by arbitrary arguments=2E I=
t is NOT a full shell command line -- shell expansion is not</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * performed=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * The path and arguments in &quot;command&quot; may be=
 single- or double-quoted or escaped=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * The path is extracted from &quot;command&quot;, then check_file_acces=
s() is called to check it=2E The</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * arguments, if any, are ignored=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Note that the type, mode, and opt arguments to this routine=
 are the same as the corresponding</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * check_file_access() arguments=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
check_cmd_access(const char *command, const char *opt, const char *chroot)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct argv argv;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool return_code;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* If no command was set, there are no errors to =
look for */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!command)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Extract executable path and arguments */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    argv =3D argv_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_parse_cmd(&am=
p;argv, command);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if an executab=
le is specified then check it; otherwise, complain */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (argv=2Eargv[0])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Scripts requires R_OK as well, but that =
might fail on binaries which</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * only requires X_OK to function on Unix - a scenario not=
 unlikely to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * be seen on suid binaries=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return_code =3D check_file_access_chroot(chroot, CHKACC_FILE, a=
rgv=2Eargv[0], X_OK, opt);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NOPREFIX | M_OPTER=
R, &quot;%s fails with &#39;%s&#39;: No path to executable=2E&quot;, opt, c=
ommand);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn_code =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return return_code;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sanity check of a=
ll file/dir options=2E  Checks that file/dir</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * is accessible by OpenVPN</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+options_postprocess_filechecks(struct options *options)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool errs =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* ** SSL/TLS/crypto related files ** */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(op=
tions-&gt;dh_file_inline, CHKACC_FILE, options-&gt;dh_file, R_OK,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
        &quot;--dh&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!opt=
ions-&gt;verify_hash_no_ca)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  errs |=3D check_file_access_inline(options-&gt;ca_file_inline, CHKACC_FIL=
E, options-&gt;ca_file,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                         R_OK, &quot;--ca&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    errs |=3D check_file_access_chroot(options-&gt;chroot_=
dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                     &quot;--capat=
h&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acce=
ss_inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
               options-&gt;cert_file, R_OK, &quot;--cert&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(options-&g=
t;extra_certs_file, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                     options-&gt;extra_certs_f=
ile, R_OK, &quot;--extra-certs&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(opt=
ions-&gt;priv_key_file_inline,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                         CHKACC_FILE | CHKACC_PR=
IVATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                         options-&gt;priv_key_file, =
R_OK, &quot;--key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_ac=
cess_inline(options-&gt;pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                options-&gt;pkcs12_file, R_OK, &quot;--pkcs12&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (options-&gt;ssl_flags &amp; SSLF_CRL=
_VERIFY_DIR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D che=
ck_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;crl_=
file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                           R_OK | X_OK, &quot;--crl-verify directory&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        errs |=3D</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            check_file_access_chroot_inline(options-&gt;c=
rl_file_inline, options-&gt;chroot_dir,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                            CHKACC_FILE=
, options-&gt;crl_file, R_OK, &quot;--crl-verify&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (options-&gt;tls_export_peer_cert_dir)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        errs |=3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            check_file_access_chroot(options-&gt;chroot_dir, =
CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                              options-&gt;tls_export_peer_cert_dir, W_OK, &=
quot;--tls-export-cert&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(options-&gt=
;connection_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (int i =3D 0; i &lt; options-&gt;connection_list-&gt;len; ++i)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const struct connection_entry *=
ce =3D options-&gt;connection_list-&gt;array[i];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;tls_auth_file_i=
nline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                         ce-&gt;tls_auth_f=
ile, R_OK, &quot;--tls-auth&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;tls_crypt=
_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                         ce-&gt;tls=
_crypt_file, R_OK, &quot;--tls-crypt&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;=
tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
  ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    errs |=3D</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        check_file_access_inline(options-&gt;shared_secret_file_inline,=
 CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                 options-&gt;shared_secret_file,=
 R_OK, &quot;--secret&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs =
|=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packe=
t_id_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                     R_OK | W_OK, &quot;--replay-persist&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* ** Password files ** */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC=
_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                              options-&gt;key_pass_f=
ile, R_OK, &quot;--askpass&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    errs |=3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CH=
KACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                    options-&gt;management_user_pass, R_OK, &quot;--managem=
ent user/password file&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(options-&gt;au=
th_user_pass_file_inline,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                     CHKACC_FILE | CHKACC_ACPTSTDIN |=
 CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                  options-&gt;auth_user_pass_file, R_OK, &q=
uot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* ** System related ** */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_FILE, options-&g=
t;chroot_dir, R_OK | X_OK, &quot;--chroot directory&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHK=
ACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, R_OK | W_OK,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  &quot;--writepid&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** Lo=
g related ** */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;=
status_file, R_OK | W_OK,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                              &quot;--status&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* ** Config related ** */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(optio=
ns-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
     R_OK | X_OK, &quot;--client-config-dir&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(op=
tions-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                     R_=
OK | W_OK | X_OK, &quot;Temporary directory (--tmp-dir)&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (errs)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_USAGE, &quot;Please correct these errors=2E&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* !ENABLE_SMALL */</span><br><span>diff --git a/src/openvpn/check_f=
ile_access=2Eh b/src/openvpn/check_file_access=2Eh</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2Eaf057bc</span><br><span>---=
 /dev/null</span><br><span>+++ b/src/openvpn/check_file_access=2Eh</span><b=
r><span>@@ -0,0 +1,36 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             over a single UDP port, with su=
pport for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             session authentication and key exchange,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, p=
acket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet compression=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you=
 can redistribute it and/or modify</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  it under the terms of the GNU General Public License ver=
sion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publis=
hed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  This program is distributed in the hope that it will be useful,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  G=
NU General Public License for more details=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  You should have received a copy of the GNU General Public Lice=
nse along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with t=
his program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef CHECK_FILE_ACCESS_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define CHECK_FILE_ACCESS_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_c=
md_access(const char *command, const char *opt, const char *chroot);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void options_postprocess_filechecks(struct op=
tions *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !ENABLE_SMAL=
L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 6=
e314a1=2E=2E03cda5a 100644</span><br><span>--- a/src/openvpn/options=2Ec</s=
pan><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -63,6 +63,7 =
@@</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span> #i=
nclude &quot;domain_helper=2Eh&quot;</span><br><span> #include &quot;mbuf=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;check_file_access=2Eh&quot;</span><br><span> </span><br><span> #inclu=
de &lt;ctype=2Eh&gt;</span><br><span> </span><br><span>@@ -3336,340 +3337,6=
 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  Check file/directory sanity</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/* Expect people using the stripped down version to know what=
 they do */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef EN=
ABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILE       (1 &lt=
;&lt; 0) /**&lt; Check for a file/directory presence */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_DIRPATH    (1 &lt;&lt; 1) =
/**&lt; Check for directory presence where a file should reside */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILEXSTWR  (1 &=
lt;&lt; 2) /**&lt; If file exists, is it writable? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_ACPTSTDIN  (1 &lt;&lt; 3) /*=
*&lt; If filename is stdin, it&#39;s allowed and &quot;exists&quot; */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_PRIVATE    =
(1 &lt;&lt; 4) /**&lt; Warn if this (private) file is group/others accessib=
le */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_A=
CCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless they start with =
file: */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-check_file_access(const int type, const cha=
r *file, const int mode, const char *opt)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int errcode =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If no file co=
nfigured, no errors to look for */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (!file)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* If stdin is allowed and the file name is=
 &#39;stdin&#39;, then do no</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     * further checks as stdin is always available</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_ACPTSTDIN) &amp;&amp; stre=
q(file, &quot;stdin&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* file name is a URI if its first segment =
 has &quot;:&quot; (i=2Ee=2E, before any &quot;/&quot;)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * Then no checks done if CHKACC_ACCE=
PT_URI is set and the URI does not start with &quot;file:&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&am=
p; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (!strncmp(file, &quot;file:&quot;, 5))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            file +=3D 5;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       else if (!strchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39;) &gt=
; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* Is the directory path leading to the given =
file accessible? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (type &amp; CHKACC_DIRPATH)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   char *fullpath =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            string_alloc(file, NULL); /* POSIX dirname() implementation may=
 modify its arguments */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const char *dirpath =3D dirname(fullpath);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (platform_access(dirpath, mode | X_OK) !=3D 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            errcode =3D errno;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        free(fullpath);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* Is the file itself accessible? */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHKACC_FILE) &amp;&=
amp; (platform_access(file, mode) !=3D 0))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        errcode =3D errno;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If the file exists a=
nd is accessible, is it writable? */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &a=
mp;&amp; (platform_access(file, F_OK) =3D=3D 0))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (platform_access(file, W_OK) !=3D 0)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            errcode =3D errno;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Warn if =
a given private file is group/others accessible=2E */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (type &amp; CHKACC_PRIVATE)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        platform_stat_t st;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (platform_stat(file, &amp;st)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO=
, &quot;WARNING: cannot stat file &#39;%s&#39;&quot;, file);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           if (st=2Est_mode &amp; (S_IRWXG | S_IRWXO))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot;WARNING: file &#=
39;%s&#39; is group or others accessible&quot;, file);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* Scream if an error is found */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (errcode &gt; 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NOPREFIX | M_OPTERR | M=
_ERRNO, &quot;%s fails with &#39;%s&#39;&quot;, opt, file);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Return true if an error occurred */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return (errcode !=3D 0 ? true : false);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/* A wrapper for check_file_access() which also takes a chroot directory=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If chroot is NU=
LL, behaviour is exactly the same as calling check_file_access() directly,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * otherwise it will l=
ook for the file inside the given chroot directory instead=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-check_file_access_chroot(const char *chroot, const int type, co=
nst char *file, const int mode,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                         const char *opt)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
If no file configured, no errors to look for */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!file)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* If chroot is set, look for =
the file/directory inside the chroot */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (chroot)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct buffer chroot_file;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        chroot_file =3D prepend_dir(chroot, file, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D check_file_acc=
ess(type, BSTR(&amp;chroot_file), mode, opt);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* No chr=
oot in play, just call core file check function */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        ret =3D check_file_access(type, file, =
mode, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * A wrapper for=
 check_file_access_chroot() that returns false immediately if</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * the file is inline (and therefor=
e there is no access to check)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_file_access_c=
hroot_inline(bool is_inline, const char *chroot, const int type,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
const char *file, const int mode, const char *opt)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (is_inline)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return check_file_access_chroot(chroot, typ=
e, file, mode, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * A wrapper for check_file_access() that returns false imme=
diately if the file</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 is inline (and therefore there is no access to check)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-check_file_access_inline(bool is_inline, const int type, const char *f=
ile, const int mode,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                        const char *opt)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (is_inline)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return check_file_access(type, file, mode, opt);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Verifies=
 that the path in the &quot;command&quot; that comes after certain script o=
ptions (e=2Eg=2E, --up) is a</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * valid file with appropriate permissions=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * &quot;command&quot; consists of a path, optionally followed=
 by a space, which may be</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * followed by arbitrary arguments=2E It is NOT a full shell command li=
ne -- shell expansion is not</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * performed=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The path and ar=
guments in &quot;command&quot; may be single- or double-quoted or escaped=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * The path is extracted from &quot;c=
ommand&quot;, then check_file_access() is called to check it=2E The</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * arguments, if any, are ign=
ored=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Note that the type, mode, and =
opt arguments to this routine are the same as the corresponding</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * check_file_access() arguments=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-check_cmd_access(const char *command, const ch=
ar *opt, const char *chroot)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ar=
gv argv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool retu=
rn_code;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* If no command was set, ther=
e are no errors to look for */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (!command)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* Extract executable path and arguments */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv =3D argv_new(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_parse_cmd(=
&amp;argv, command);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* if an executabl=
e is specified then check it; otherwise, complain */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (argv=2Eargv[0])</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* Scripts requires R_OK as well, but that might =
fail on binaries which</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * only requires X_OK to function on Unix - a scenario not unlikel=
y to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * be see=
n on suid binaries=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn_code =3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0],=
 X_OK, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_NOPREFIX | M_OPTERR, &quot;%s fails with=
 &#39;%s&#39;: No path to executable=2E&quot;, opt, command);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return_code =3D true;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    argv_free(&amp;argv);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn return_code;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Sanity check of all file/dir options=2E  Checks that file/d=
ir</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is accessible by=
 OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-options_postprocess_filechecks(struct opt=
ions *options)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool errs =3D false;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* ** SSL/TLS/crypto related files ** *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_=
file_access_inline(options-&gt;dh_file_inline, CHKACC_FILE, options-&gt;dh_=
file, R_OK,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                           &quot;--dh&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!options-&gt;verify_hash_no_ca)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        errs |=3D check_file_access_inline(options-&gt;ca_file_inline,=
 CHKACC_FILE, options-&gt;ca_file,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                         R_OK, &quot;--ca&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(options-&gt;chro=
ot_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                     &quot;--capa=
th&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_=
inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
          options-&gt;cert_file, R_OK, &quot;--cert&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    errs |=3D check_file_access_inline(options-&gt;extra_c=
erts_file, CHKACC_FILE,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                     options-&gt;extra_certs_file, R_OK, =
&quot;--extra-certs&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(optio=
ns-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        errs |=3D check_file_access_inline(options-&gt;priv_key_f=
ile_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                               CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT=
_URI,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                         options-&gt;priv_key_file, R_OK, &quot;--key&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    errs |=3D check_file_access_inline(options-&gt;pkcs1=
2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                     options-&gt;pkc=
s12_file, R_OK, &quot;--pkcs12&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (options-&gt;ssl_flags &amp; SSLF_CRL_VERIFY_DIR)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        errs |=3D check_file_access_chroot(options-&gt;chro=
ot_dir, CHKACC_FILE, options-&gt;crl_file,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                         R_OK | X_OK, =
&quot;--crl-verify directory&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            check_file_access_chro=
ot_inline(options-&gt;crl_file_inline, options-&gt;chroot_dir,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
          CHKACC_FILE, options-&gt;crl_file, R_OK, &quot;--crl-verify&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (options-&gt;tls_export_peer_cert_dir)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        errs |=3D</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            check_file_access_chroot(options-&gt;chr=
oot_dir, CHKACC_FILE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                     options-&gt;tls_export_peer_cert_dir, =
W_OK, &quot;--tls-export-cert&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(options-&g=
t;connection_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  for (int i =3D 0; i &lt; options-&gt;connection_list-&gt;len; ++i)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const struct connection_entry *ce =
=3D options-&gt;connection_list-&gt;array[i];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        errs |=3D check_file_access_inline(ce-&gt;tls_auth_file_inline, =
CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                         ce-&gt;tls_auth_file, R_OK=
, &quot;--tls-auth&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        errs |=3D check_file_access_inline(ce-&gt;tls_crypt_file_inlin=
e, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                         ce-&gt;tls_crypt_file, =
R_OK, &quot;--tls-crypt&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        errs |=3D check_file_access_inline(ce-&gt;tls_crypt_v2_fi=
le_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                         ce-&gt;tls_cryp=
t_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_file_ac=
cess_inline(options-&gt;shared_secret_file_inline, CHKACC_FILE | CHKACC_PRI=
VATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                 options-&gt;shared_secret_file, R_OK, &quot;--secret&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_D=
IRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                              R_OK | W_OK,=
 &quot;--replay-persist&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ** P=
assword files ** */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVA=
TE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
            options-&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        check_file_access(CHKACC_=
FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                          options-&gt;management_user_p=
ass, R_OK, &quot;--management user/password file&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_MANAGEMENT */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access=
_inline(options-&gt;auth_user_pass_file_inline,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                     CHKACC_FILE =
| CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                     options-&gt;auth_user_p=
ass_file, R_OK, &quot;--auth-user-pass&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* ** System related ** */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_FI=
LE, options-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot directory&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_fil=
e_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, R_OK | W_=
OK,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
            &quot;--writepid&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 ** Log related ** */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-=
&gt;status_file, R_OK | W_OK,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                              &quot;--status&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* ** Config related ** */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(options-&=
gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                     R=
_OK | X_OK, &quot;--client-config-dir&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(options-&gt;=
chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                     R_OK | W_OK | =
X_OK, &quot;Temporary directory (--tmp-dir)&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (errs)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_USAGE, &quot;Please correct these errors=2E&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* !ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span> =
 * Sanity check on options=2E</span><br><span>  * Also set some options bas=
ed on other</span><br><span>  * options=2E</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/177=
4?usp=3Demail">change 1774</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1774?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1774 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--RMIBoPJxctE=--


--===============1662105080141944989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1662105080141944989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1662105080141944989==--

