Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5944EC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=RDDDMU6T5Ta/kvt/rM10obQ2VVO+Yp562P1EpTVfmWo=; b=AF1L0XY9oICxJM
	jGbK6IFhGUU3pIPaDWxgG+ZjM2GTkP7dEI8cq44bq6el4XLg9IcUTHCJjOUdXrV5QrSlZL7FqWDv4
	o67RXC37j9UqfdVhfSLJA45rJLFIFRDvb5Hiuxe6MqtdqYNxv8qt2cisFzeKk7gxPvubmbUzyjFoX
	1oM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqbb-0004Wk-Kl;
	Thu, 09 Jul 2026 15:24:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whqbM-0004Vv-S9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:23:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q3xq4MDyF+r8fQjqWInH+t0A1T/aiAcFfg7BN5b8rR4=; b=LKZvLx/XUldr2FK8qOfxbK+8V3
 fDQIrB+Usve3B/CmHQd9BFKDu/OCPN8aPx1ASFrUIN8Ryc1aDgw65ZS/fH2yhZjcxNoa9uBk2pweA
 SdZvo/7h7ENmQdJF1wuFvurKsc4lWoqWW2p1GfAQ+F76hftyF8zuT/rC7fbNdoiTJNg0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q3xq4MDyF+r8fQjqWInH+t0A1T/aiAcFfg7BN5b8rR4=; b=l
 X3f5Ipfx/ydhYCr3FW4vkeXpV16UbaG9twMfa3NCmHP2FmmreNoCTwL4k6tl58W90jS6ilfftryUq
 lDmtAOfv3P1jloh/sAMHU94qenM1mdHsmKsbdUaAg/QDkwMgBqanu5SbWkaAAoBaThoCfSRtZTezN
 5/t70kPYzvrGdn3s=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whqbC-0007rP-2r for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:23:42 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c15bf399d3bso1425766b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 09 Jul 2026 08:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783610606; x=1784215406; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q3xq4MDyF+r8fQjqWInH+t0A1T/aiAcFfg7BN5b8rR4=;
 b=a4uQuy76yy2gVUOxEynVAGVFjQFw+Tn7Yfp5As5rzAu2rLO772pdmJjj4tjPrLjp0y
 NOKRyLgJc7if0rXWKCQe2AdzfZ4iktNDOHvQVZV59tspNw0sKfdi2egExM9HRGD/zgO8
 kqGIopDC7Lsq1ap4HErIhxHwHoJbg79+18qsd4cw/LjtssE6SnVFfiuQb1244F154W7W
 1ztXE9LsaoYvFq1d0KiNTjEfttwbabX1UIK3FcKB/0HFMSlH6IuRiolpzZNfvtJXRBUu
 aPVmpxyrHcQlzq+aV51yQTRhKeJnfbjLqASaoPPfxt2JIM1pjcZyZHR5J/J3I6Zu2OP0
 vSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610606; x=1784215406;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q3xq4MDyF+r8fQjqWInH+t0A1T/aiAcFfg7BN5b8rR4=;
 b=HoeLx7HswutQWg8IF/sA8DqOEs5Ub4KrZW9y47J5ZCeJeck5j8GOgaKCk7wkooErmp
 Bm8sEhEfzs4unOZZieDV1ZXK07h/61FmwZgbl+s2NSUyeIDlZxaLKjoNI/Cg0Knyb+dF
 A9hskvodfe+ofrVIUX/kB3SRxU7v4Ncoi9bdeYgLBBbevPbI/sRthAeLJxHsXZOBKz+B
 r/uV1I2hmS4UHZSk1dIPcizIjSJBCjECgdQop59eBnw68RupTU47SOeqMo87ZPw0S3Rx
 PI+FFLbFwrWSz6yVWG1iBapCdPpZ47pR82FByMFO6Q8iKBdPt87hWEM7N5ZgJnzg+W1s
 tkgw==
X-Gm-Message-State: AOJu0Yx8iEJS9k7GSVX5FIbsD049dIpAM/ug+4FtPe7/4pcrjUOaJNnK
 GG1yqHoB6H6JFI6D5wHz3Z+pi3ugZOQnpy2C4v3k+VeQmPAbk6nqx3dEx6dy5QNGTBwXimrdIfD
 Yql2eDQjYZXfaSEPkhz427PezzjJtRIvStAZy7+MUb3ko391EW0tg0p/+1E+7EiALmT55brv7oD
 cZxuWb+A==
X-Gm-Gg: AfdE7cnHmjyXaef+SRQVeIeP29NNMlOUE7pYrRpjWRWmpr6owN54A05BK4e5mXBbJbW
 UpiHWmWQga4SXYnrPIbDRAiV6Z26Xy5YI640rPd+BzAkFWozVRRRFS18M6Ix99MkhsDouWQU+5w
 bGk6opUx2O1PrPTIEUgLSoizeye8lDWtFBVpC5rIRQgiKQQ31KCJHceplgp+xNpE+Ggc3KrW6BS
 bUV2s/aXh+dgOy+LQVXmE5W5PxqP72gr0147BZ9V2mmsFera+GkQsRlcJ8pd247JsyBku/rZ8G3
 3yj+AoJDarJNyPfvKLDJoHxKb9/6SfRu8fAjJDeF/8BCjXbBmuhG+SGXSG3NDwB3Ln48KohzblY
 Pi4RMqsUI/oyIhovIt9uXVMawjeU3fbxI34rGR8ggs3xgu/rc5z0LcWTjB6+yYnZqlkGgcSCD+X
 A/qmomvTCdqt8wKtNsVPmVOR9dE2/7CBgUkbr5j6SYpMltuXuTmlz9Yr3pzIGzXP1XCpzmpBrsw
 qQO4LMS8cn1FgcZ6uyUrPrTQh+GDEdaUwvzcHaraejBOHkupVJJyiy8aziyF6Mnm3rSP9a37bsy
 MMg=
X-Received: by 2002:a05:6000:1a86:b0:478:65a8:2635 with SMTP id
 ffacd0b85a97d-47df0714967mr7998136f8f.11.1783600915214; 
 Thu, 09 Jul 2026 05:41:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47df6a31dd5sm6266858f8f.16.2026.07.09.05.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:41:54 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 9 Jul 2026 12:41:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: c7b94deb19d36d526a169bb5d35eedbcfceab590
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0853f4bc7a6be1a3b3b70c8259a73b236baa5076-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whqbC-0007rP-2r
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
Content-Type: multipart/mixed; boundary="===============2744508258088250748=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2744508258088250748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4tNnHTmB6Qo="; charset=UTF-8

--4tNnHTmB6Qo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1774?usp=3Demail

to review the following change=2E


Chang=
e subject: options: Factor out file access code from options=2Ec
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: Factor out fi=
le access code from options=2Ec

options=2Ec is a huge, unwieldly file=2E S=
o remove some
closely related code that has no direct dependencies
with the=
 other functions in the file=2E

This time it is the code that checks file =
accessibility=2E

Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M CMakeLists=2Et=
xt
M src/openvpn/Makefile=2Eam
A src/openvpn/check_file_access=2Ec
A src/op=
envpn/check_file_access=2Eh
M src/openvpn/options=2Ec
5 files changed, 412 =
insertions(+), 334 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/74/1774/1

diff --git a/CMakeLists=2Etxt b/CMake=
Lists=2Etxt
index 3981bae=2E=2Ea4f20c9 100644
--- a/CMakeLists=2Etxt
+++ b/=
CMakeLists=2Etxt
@@ -422,6 +422,8 @@
     src/openvpn/basic=2Eh
     src/op=
envpn/buffer=2Ec
     src/openvpn/buffer=2Eh
+    src/openvpn/check_file_ac=
cess=2Ec
+    src/openvpn/check_file_access=2Eh
     src/openvpn/circ_list=
=2Eh
     src/openvpn/clinat=2Ec
     src/openvpn/clinat=2Eh
diff --git a/s=
rc/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 9778f32=2E=2E1fb=
cad4 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam=

@@ -47,6 +47,7 @@
 	base64=2Ec base64=2Eh \
 	basic=2Eh \
 	buffer=2Ec buf=
fer=2Eh \
+	check_file_access=2Ec check_file_access=2Eh \
 	circ_list=2Eh \=

 	clinat=2Ec clinat=2Eh \
 	common=2Eh \
diff --git a/src/openvpn/check_fi=
le_access=2Ec b/src/openvpn/check_file_access=2Ec
new file mode 100644
inde=
x 0000000=2E=2Ec86cc97
--- /dev/null
+++ b/src/openvpn/check_file_access=2E=
c
@@ -0,0 +1,372 @@
+/*
+ *  OpenVPN -- An application to securely tunnel I=
P networks
+ *             over a single UDP port, with support for SSL/TLS=
-based
+ *             session authentication and key exchange,
+ *        =
     packet encryption, packet authentication, and
+ *             packet c=
ompression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@eurephia=2Eorg>=

+ *
+ *  This program is free software; you can redistribute it and/or mod=
ify
+ *  it under the terms of the GNU General Public License version 2
+ *=
  as published by the Free Software Foundation=2E
+ *
+ *  This program is =
distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more=
 details=2E
+ *
+ *  You should have received a copy of the GNU General Pub=
lic License along
+ *  with this program; if not, see <https://www=2Egnu=2E=
org/licenses/>=2E
+ */
+
+/*
+ *  Check file/directory sanity
+ *
+ */
+/* =
Expect people using the stripped down version to know what they do */
+#ifn=
def ENABLE_SMALL
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+=
#include "syshead=2Eh"
+
+#include "argv=2Eh"
+#include "buffer=2Eh"
+#incl=
ude "error=2Eh"
+#include "options=2Eh"
+#include "platform=2Eh"
+#include =
"ssl_common=2Eh"
+
+#include <string=2Eh>
+
+#define CHKACC_FILE       (1 <=
< 0) /**< Check for a file/directory presence */
+#define CHKACC_DIRPATH   =
 (1 << 1) /**< Check for directory presence where a file should reside */
+=
#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writable? */
=
+#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed=
 and "exists" */
+#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (pri=
vate) file is group/others accessible */
+#define CHKACC_ACCEPT_URI (1 << 5=
) /**< Do not check URIs, unless they start with file: */
+
+static bool
+c=
heck_file_access(const int type, const char *file, const int mode, const ch=
ar *opt)
+{
+    int errcode =3D 0;
+
+    /* If no file configured, no err=
ors to look for */
+    if (!file)
+    {
+        return false;
+    }
+
+=
    /* If stdin is allowed and the file name is 'stdin', then do no
+     *=
 further checks as stdin is always available
+     */
+    if ((type & CHKA=
CC_ACPTSTDIN) && streq(file, "stdin"))
+    {
+        return false;
+    }=

+
+    /* file name is a URI if its first segment  has ":" (i=2Ee=2E, befo=
re any "/")
+     * Then no checks done if CHKACC_ACCEPT_URI is set and the=
 URI does not start with "file:"
+     */
+    if ((type & CHKACC_ACCEPT_UR=
I) && strchr(file, ':'))
+    {
+        if (!strncmp(file, "file:", 5))
+ =
       {
+            file +=3D 5;
+        }
+        else if (!strchr(fil=
e, '/') || strchr(file, '/') > strchr(file, ':'))
+        {
+            r=
eturn false;
+        }
+    }
+
+    /* Is the directory path leading to t=
he given file accessible? */
+    if (type & CHKACC_DIRPATH)
+    {
+      =
  char *fullpath =3D
+            string_alloc(file, NULL); /* POSIX dirnam=
e() implementation may modify its arguments */
+        const char *dirpath=
 =3D dirname(fullpath);
+
+        if (platform_access(dirpath, mode | X_OK=
) !=3D 0)
+        {
+            errcode =3D errno;
+        }
+        fr=
ee(fullpath);
+    }
+
+    /* Is the file itself accessible? */
+    if (!=
errcode && (type & CHKACC_FILE) && (platform_access(file, mode) !=3D 0))
+ =
   {
+        errcode =3D errno;
+    }
+
+    /* If the file exists and is=
 accessible, is it writable? */
+    if (!errcode && (type & CHKACC_FILEXST=
WR) && (platform_access(file, F_OK) =3D=3D 0))
+    {
+        if (platform=
_access(file, W_OK) !=3D 0)
+        {
+            errcode =3D errno;
+   =
     }
+    }
+
+    /* Warn if a given private file is group/others access=
ible=2E */
+    if (type & CHKACC_PRIVATE)
+    {
+        platform_stat_t =
st;
+        if (platform_stat(file, &st))
+        {
+            msg(M_WA=
RN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
+        }
+#ifndef =
_WIN32
+        else
+        {
+            if (st=2Est_mode & (S_IRWXG | =
S_IRWXO))
+            {
+                msg(M_WARN, "WARNING: file '%s' i=
s group or others accessible", file);
+            }
+        }
+#endif
+  =
  }
+
+    /* Scream if an error is found */
+    if (errcode > 0)
+    {
+=
        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, fil=
e);
+    }
+
+    /* Return true if an error occurred */
+    return (errco=
de !=3D 0 ? true : false);
+}
+
+/* A wrapper for check_file_access() which=
 also takes a chroot directory=2E
+ * If chroot is NULL, behaviour is exact=
ly the same as calling check_file_access() directly,
+ * otherwise it will =
look for the file inside the given chroot directory instead=2E
+ */
+static=
 bool
+check_file_access_chroot(const char *chroot, const int type, const c=
har *file, const int mode,
+                         const char *opt)
+{
+ =
   bool ret =3D false;
+
+    /* If no file configured, no errors to look f=
or */
+    if (!file)
+    {
+        return false;
+    }
+
+    /* If chr=
oot is set, look for the file/directory inside the chroot */
+    if (chroo=
t)
+    {
+        struct gc_arena gc =3D gc_new();
+        struct buffer =
chroot_file;
+
+        chroot_file =3D prepend_dir(chroot, file, &gc);
+  =
      ret =3D check_file_access(type, BSTR(&chroot_file), mode, opt);
+    =
    gc_free(&gc);
+    }
+    else
+    {
+        /* No chroot in play, ju=
st call core file check function */
+        ret =3D check_file_access(type=
, file, mode, opt);
+    }
+    return ret;
+}
+
+/**
+ * A wrapper for che=
ck_file_access_chroot() that returns false immediately if
+ * the file is i=
nline (and therefore there is no access to check)
+ */
+static bool
+check_=
file_access_chroot_inline(bool is_inline, const char *chroot, const int typ=
e,
+                                const char *file, const int mode, const=
 char *opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+=
    return check_file_access_chroot(chroot, type, file, mode, opt);
+}
+
+/=
**
+ * A wrapper for check_file_access() that returns false immediately if =
the file
+ * is inline (and therefore there is no access to check)
+ */
+st=
atic bool
+check_file_access_inline(bool is_inline, const int type, const c=
har *file, const int mode,
+                         const char *opt)
+{
+ =
   if (is_inline)
+    {
+        return false;
+    }
+
+    return check_=
file_access(type, file, mode, opt);
+}
+
+/*
+ * Verifies that the path in =
the "command" that comes after certain script options (e=2Eg=2E, --up) is a=

+ * valid file with appropriate permissions=2E
+ *
+ * "command" consists =
of a path, optionally followed by a space, which may be
+ * followed by arb=
itrary arguments=2E It is NOT a full shell command line -- shell expansion =
is not
+ * performed=2E
+ *
+ * The path and arguments in "command" may be =
single- or double-quoted or escaped=2E
+ *
+ * The path is extracted from "=
command", then check_file_access() is called to check it=2E The
+ * argumen=
ts, if any, are ignored=2E
+ *
+ * Note that the type, mode, and opt argume=
nts to this routine are the same as the corresponding
+ * check_file_access=
() arguments=2E
+ */
+bool
+check_cmd_access(const char *command, const cha=
r *opt, const char *chroot)
+{
+    struct argv argv;
+    bool return_code=
;
+
+    /* If no command was set, there are no errors to look for */
+    =
if (!command)
+    {
+        return false;
+    }
+
+    /* Extract execut=
able path and arguments */
+    argv =3D argv_new();
+    argv_parse_cmd(&a=
rgv, command);
+
+    /* if an executable is specified then check it; other=
wise, complain */
+    if (argv=2Eargv[0])
+    {
+        /* Scripts requi=
res R_OK as well, but that might fail on binaries which
+         * only re=
quires X_OK to function on Unix - a scenario not unlikely to
+         * be=
 seen on suid binaries=2E
+         */
+        return_code =3D check_file_=
access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);
+    }
+    =
else
+    {
+        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No pat=
h to executable=2E", opt, command);
+        return_code =3D true;
+    }
+=

+    argv_free(&argv);
+
+    return return_code;
+}
+
+/*
+ * Sanity chec=
k of all file/dir options=2E  Checks that file/dir
+ * is accessible by Ope=
nVPN
+ */
+void
+options_postprocess_filechecks(struct options *options)
+{=

+    bool errs =3D false;
+
+    /* ** SSL/TLS/crypto related files ** */
=
+    errs |=3D check_file_access_inline(options->dh_file_inline, CHKACC_FIL=
E, options->dh_file, R_OK,
+                                     "--dh");
+=

+    if (!options->verify_hash_no_ca)
+    {
+        errs |=3D check_file=
_access_inline(options->ca_file_inline, CHKACC_FILE, options->ca_file,
+   =
                                      R_OK, "--ca");
+    }
+
+    errs |=
=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_=
path, R_OK,
+                                     "--capath");
+
+    errs =
|=3D check_file_access_inline(options->cert_file_inline, CHKACC_FILE | CHKA=
CC_ACCEPT_URI,
+                                     options->cert_file, R_=
OK, "--cert");
+
+    errs |=3D check_file_access_inline(options->extra_cer=
ts_file, CHKACC_FILE,
+                                     options->extra_=
certs_file, R_OK, "--extra-certs");
+
+    if (!(options->management_flags =
& MF_EXTERNAL_KEY))
+    {
+        errs |=3D check_file_access_inline(opti=
ons->priv_key_file_inline,
+                                         CHKACC=
_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
+                              =
           options->priv_key_file, R_OK, "--key");
+    }
+
+    errs |=3D =
check_file_access_inline(options->pkcs12_file_inline, CHKACC_FILE | CHKACC_=
PRIVATE,
+                                     options->pkcs12_file, R_OK, =
"--pkcs12");
+
+    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
+    {
+ =
       errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE,=
 options->crl_file,
+                                         R_OK | X_OK, =
"--crl-verify directory");
+    }
+    else
+    {
+        errs |=3D
+    =
        check_file_access_chroot_inline(options->crl_file_inline, options->=
chroot_dir,
+                                            CHKACC_FILE, optio=
ns->crl_file, R_OK, "--crl-verify");
+    }
+
+    if (options->tls_export_=
peer_cert_dir)
+    {
+        errs |=3D
+            check_file_access_chr=
oot(options->chroot_dir, CHKACC_FILE,
+                                    =
 options->tls_export_peer_cert_dir, W_OK, "--tls-export-cert");
+    }
+
+ =
   ASSERT(options->connection_list);
+    for (int i =3D 0; i < options->co=
nnection_list->len; ++i)
+    {
+        const struct connection_entry *ce =
=3D options->connection_list->array[i];
+
+        errs |=3D check_file_acc=
ess_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+       =
                                  ce->tls_auth_file, R_OK, "--tls-auth");
+=
        errs |=3D check_file_access_inline(ce->tls_crypt_file_inline, CHKAC=
C_FILE | CHKACC_PRIVATE,
+                                         ce->tls_=
crypt_file, R_OK, "--tls-crypt");
+        errs |=3D check_file_access_inli=
ne(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+           =
                              ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2"=
);
+    }
+
+    errs |=3D
+        check_file_access_inline(options->share=
d_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                      =
           options->shared_secret_file, R_OK, "--secret");
+
+    errs |=3D=
 check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_fi=
le,
+                              R_OK | W_OK, "--replay-persist");
+
+   =
 /* ** Password files ** */
+    errs |=3D check_file_access(CHKACC_FILE | =
CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                              options->=
key_pass_file, R_OK, "--askpass");
+#ifdef ENABLE_MANAGEMENT
+    errs |=3D=

+        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE=
,
+                          options->management_user_pass, R_OK, "--manage=
ment user/password file");
+#endif /* ENABLE_MANAGEMENT */
+    errs |=3D c=
heck_file_access_inline(options->auth_user_pass_file_inline,
+             =
                        CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+ =
                                    options->auth_user_pass_file, R_OK, "--=
auth-user-pass");
+    /* ** System related ** */
+    errs |=3D check_file=
_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "--chroot directory"=
);
+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, opti=
ons->writepid, R_OK | W_OK,
+                              "--writepid");
+=

+    /* ** Log related ** */
+    errs |=3D check_file_access(CHKACC_DIRPA=
TH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,
+                =
              "--status");
+
+    /* ** Config related ** */
+    errs |=3D=
 check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client=
_config_dir,
+                                     R_OK | X_OK, "--client-c=
onfig-dir");
+    errs |=3D check_file_access_chroot(options->chroot_dir, C=
HKACC_FILE, options->tmp_dir,
+                                     R_OK | =
W_OK | X_OK, "Temporary directory (--tmp-dir)");
+
+    if (errs)
+    {
+ =
       msg(M_USAGE, "Please correct these errors=2E");
+    }
+}
+
+#endif =
/* !ENABLE_SMALL */
diff --git a/src/openvpn/check_file_access=2Eh b/src/op=
envpn/check_file_access=2Eh
new file mode 100644
index 0000000=2E=2Eaf057bc=

--- /dev/null
+++ b/src/openvpn/check_file_access=2Eh
@@ -0,0 +1,36 @@
+/*=

+ *  OpenVPN -- An application to securely tunnel IP networks
+ *         =
    over a single UDP port, with support for SSL/TLS-based
+ *             =
session authentication and key exchange,
+ *             packet encryption,=
 packet authentication, and
+ *             packet compression=2E
+ *
+ *  =
Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This pro=
gram is free software; you can redistribute it and/or modify
+ *  it under =
the terms of the GNU General Public License version 2
+ *  as published by =
the Free Software Foundation=2E
+ *
+ *  This program is distributed in the=
 hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ =
*  You should have received a copy of the GNU General Public License along
=
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
=
+ */
+
+#ifndef CHECK_FILE_ACCESS_H
+#define CHECK_FILE_ACCESS_H
+
+#ifndef=
 ENABLE_SMALL
+
+#include "options=2Eh"
+
+bool check_cmd_access(const char=
 *command, const char *opt, const char *chroot);
+
+void options_postproces=
s_filechecks(struct options *options);
+
+#endif /* !ENABLE_SMALL */
+
+#en=
dif
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 6e=
314a1=2E=2E03cda5a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/o=
ptions=2Ec
@@ -63,6 +63,7 @@
 #include "tun_afunix=2Eh"
 #include "domain_h=
elper=2Eh"
 #include "mbuf=2Eh"
+#include "check_file_access=2Eh"
 
 #inclu=
de <ctype=2Eh>
 
@@ -3336,340 +3337,6 @@
 }
 
 /*
- *  Check file/directory=
 sanity
- *
- */
-/* Expect people using the stripped down version to know =
what they do */
-#ifndef ENABLE_SMALL
-
-#define CHKACC_FILE       (1 << 0)=
 /**< Check for a file/directory presence */
-#define CHKACC_DIRPATH    (1 =
<< 1) /**< Check for directory presence where a file should reside */
-#def=
ine CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writable? */
-#de=
fine CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed and=
 "exists" */
-#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private=
) file is group/others accessible */
-#define CHKACC_ACCEPT_URI (1 << 5) /*=
*< Do not check URIs, unless they start with file: */
-
-static bool
-check=
_file_access(const int type, const char *file, const int mode, const char *=
opt)
-{
-    int errcode =3D 0;
-
-    /* If no file configured, no errors =
to look for */
-    if (!file)
-    {
-        return false;
-    }
-
-    =
/* If stdin is allowed and the file name is 'stdin', then do no
-     * fur=
ther checks as stdin is always available
-     */
-    if ((type & CHKACC_A=
CPTSTDIN) && streq(file, "stdin"))
-    {
-        return false;
-    }
-
-=
    /* file name is a URI if its first segment  has ":" (i=2Ee=2E, before a=
ny "/")
-     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI=
 does not start with "file:"
-     */
-    if ((type & CHKACC_ACCEPT_URI) &=
& strchr(file, ':'))
-    {
-        if (!strncmp(file, "file:", 5))
-     =
   {
-            file +=3D 5;
-        }
-        else if (!strchr(file, '=
/') || strchr(file, '/') > strchr(file, ':'))
-        {
-            retur=
n false;
-        }
-    }
-
-    /* Is the directory path leading to the g=
iven file accessible? */
-    if (type & CHKACC_DIRPATH)
-    {
-        ch=
ar *fullpath =3D
-            string_alloc(file, NULL); /* POSIX dirname() =
implementation may modify its arguments */
-        const char *dirpath =3D=
 dirname(fullpath);
-
-        if (platform_access(dirpath, mode | X_OK) !=
=3D 0)
-        {
-            errcode =3D errno;
-        }
-        free(=
fullpath);
-    }
-
-    /* Is the file itself accessible? */
-    if (!err=
code && (type & CHKACC_FILE) && (platform_access(file, mode) !=3D 0))
-    =
{
-        errcode =3D errno;
-    }
-
-    /* If the file exists and is ac=
cessible, is it writable? */
-    if (!errcode && (type & CHKACC_FILEXSTWR)=
 && (platform_access(file, F_OK) =3D=3D 0))
-    {
-        if (platform_ac=
cess(file, W_OK) !=3D 0)
-        {
-            errcode =3D errno;
-      =
  }
-    }
-
-    /* Warn if a given private file is group/others accessibl=
e=2E */
-    if (type & CHKACC_PRIVATE)
-    {
-        platform_stat_t st;=

-        if (platform_stat(file, &st))
-        {
-            msg(M_WARN =
| M_ERRNO, "WARNING: cannot stat file '%s'", file);
-        }
-#ifndef _WI=
N32
-        else
-        {
-            if (st=2Est_mode & (S_IRWXG | S_I=
RWXO))
-            {
-                msg(M_WARN, "WARNING: file '%s' is g=
roup or others accessible", file);
-            }
-        }
-#endif
-    }=

-
-    /* Scream if an error is found */
-    if (errcode > 0)
-    {
-   =
     msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);=

-    }
-
-    /* Return true if an error occurred */
-    return (errcode =
!=3D 0 ? true : false);
-}
-
-/* A wrapper for check_file_access() which al=
so takes a chroot directory=2E
- * If chroot is NULL, behaviour is exactly =
the same as calling check_file_access() directly,
- * otherwise it will loo=
k for the file inside the given chroot directory instead=2E
- */
-static bo=
ol
-check_file_access_chroot(const char *chroot, const int type, const char=
 *file, const int mode,
-                         const char *opt)
-{
-    =
bool ret =3D false;
-
-    /* If no file configured, no errors to look for =
*/
-    if (!file)
-    {
-        return false;
-    }
-
-    /* If chroot=
 is set, look for the file/directory inside the chroot */
-    if (chroot)
=
-    {
-        struct gc_arena gc =3D gc_new();
-        struct buffer chr=
oot_file;
-
-        chroot_file =3D prepend_dir(chroot, file, &gc);
-     =
   ret =3D check_file_access(type, BSTR(&chroot_file), mode, opt);
-       =
 gc_free(&gc);
-    }
-    else
-    {
-        /* No chroot in play, just =
call core file check function */
-        ret =3D check_file_access(type, f=
ile, mode, opt);
-    }
-    return ret;
-}
-
-/**
- * A wrapper for check_=
file_access_chroot() that returns false immediately if
- * the file is inli=
ne (and therefore there is no access to check)
- */
-static bool
-check_fil=
e_access_chroot_inline(bool is_inline, const char *chroot, const int type,
=
-                                const char *file, const int mode, const ch=
ar *opt)
-{
-    if (is_inline)
-    {
-        return false;
-    }
-
-   =
 return check_file_access_chroot(chroot, type, file, mode, opt);
-}
-
-/**
=
- * A wrapper for check_file_access() that returns false immediately if the=
 file
- * is inline (and therefore there is no access to check)
- */
-stati=
c bool
-check_file_access_inline(bool is_inline, const int type, const char=
 *file, const int mode,
-                         const char *opt)
-{
-    =
if (is_inline)
-    {
-        return false;
-    }
-
-    return check_fil=
e_access(type, file, mode, opt);
-}
-
-/*
- * Verifies that the path in the=
 "command" that comes after certain script options (e=2Eg=2E, --up) is a
- =
* valid file with appropriate permissions=2E
- *
- * "command" consists of =
a path, optionally followed by a space, which may be
- * followed by arbitr=
ary arguments=2E It is NOT a full shell command line -- shell expansion is =
not
- * performed=2E
- *
- * The path and arguments in "command" may be sin=
gle- or double-quoted or escaped=2E
- *
- * The path is extracted from "com=
mand", then check_file_access() is called to check it=2E The
- * arguments,=
 if any, are ignored=2E
- *
- * Note that the type, mode, and opt arguments=
 to this routine are the same as the corresponding
- * check_file_access() =
arguments=2E
- */
-static bool
-check_cmd_access(const char *command, const=
 char *opt, const char *chroot)
-{
-    struct argv argv;
-    bool return_=
code;
-
-    /* If no command was set, there are no errors to look for */
-=
    if (!command)
-    {
-        return false;
-    }
-
-    /* Extract ex=
ecutable path and arguments */
-    argv =3D argv_new();
-    argv_parse_cm=
d(&argv, command);
-
-    /* if an executable is specified then check it; o=
therwise, complain */
-    if (argv=2Eargv[0])
-    {
-        /* Scripts r=
equires R_OK as well, but that might fail on binaries which
-         * onl=
y requires X_OK to function on Unix - a scenario not unlikely to
-         =
* be seen on suid binaries=2E
-         */
-        return_code =3D check_f=
ile_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);
-    }
-=
    else
-    {
-        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No=
 path to executable=2E", opt, command);
-        return_code =3D true;
-   =
 }
-
-    argv_free(&argv);
-
-    return return_code;
-}
-
-/*
- * Sanity =
check of all file/dir options=2E  Checks that file/dir
- * is accessible by=
 OpenVPN
- */
-static void
-options_postprocess_filechecks(struct options *=
options)
-{
-    bool errs =3D false;
-
-    /* ** SSL/TLS/crypto related f=
iles ** */
-    errs |=3D check_file_access_inline(options->dh_file_inline,=
 CHKACC_FILE, options->dh_file, R_OK,
-                                    =
 "--dh");
-
-    if (!options->verify_hash_no_ca)
-    {
-        errs |=3D=
 check_file_access_inline(options->ca_file_inline, CHKACC_FILE, options->ca=
_file,
-                                         R_OK, "--ca");
-    }
-
- =
   errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, opt=
ions->ca_path, R_OK,
-                                     "--capath");
-
-=
    errs |=3D check_file_access_inline(options->cert_file_inline, CHKACC_FI=
LE | CHKACC_ACCEPT_URI,
-                                     options->cert=
_file, R_OK, "--cert");
-
-    errs |=3D check_file_access_inline(options->=
extra_certs_file, CHKACC_FILE,
-                                     option=
s->extra_certs_file, R_OK, "--extra-certs");
-
-    if (!(options->manageme=
nt_flags & MF_EXTERNAL_KEY))
-    {
-        errs |=3D check_file_access_in=
line(options->priv_key_file_inline,
-                                      =
   CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
-                     =
                    options->priv_key_file, R_OK, "--key");
-    }
-
-    e=
rrs |=3D check_file_access_inline(options->pkcs12_file_inline, CHKACC_FILE =
| CHKACC_PRIVATE,
-                                     options->pkcs12_fil=
e, R_OK, "--pkcs12");
-
-    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
=
-    {
-        errs |=3D check_file_access_chroot(options->chroot_dir, CHK=
ACC_FILE, options->crl_file,
-                                         R_OK=
 | X_OK, "--crl-verify directory");
-    }
-    else
-    {
-        errs |=
=3D
-            check_file_access_chroot_inline(options->crl_file_inline, =
options->chroot_dir,
-                                            CHKACC_FI=
LE, options->crl_file, R_OK, "--crl-verify");
-    }
-
-    if (options->tl=
s_export_peer_cert_dir)
-    {
-        errs |=3D
-            check_file_a=
ccess_chroot(options->chroot_dir, CHKACC_FILE,
-                           =
          options->tls_export_peer_cert_dir, W_OK, "--tls-export-cert");
- =
   }
-
-    ASSERT(options->connection_list);
-    for (int i =3D 0; i < op=
tions->connection_list->len; ++i)
-    {
-        const struct connection_e=
ntry *ce =3D options->connection_list->array[i];
-
-        errs |=3D check=
_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,=

-                                         ce->tls_auth_file, R_OK, "--tls-=
auth");
-        errs |=3D check_file_access_inline(ce->tls_crypt_file_inli=
ne, CHKACC_FILE | CHKACC_PRIVATE,
-                                        =
 ce->tls_crypt_file, R_OK, "--tls-crypt");
-        errs |=3D check_file_ac=
cess_inline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-  =
                                       ce->tls_crypt_v2_file, R_OK, "--tls-=
crypt-v2");
-    }
-
-    errs |=3D
-        check_file_access_inline(optio=
ns->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-             =
                    options->shared_secret_file, R_OK, "--secret");
-
-    =
errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->pac=
ket_id_file,
-                              R_OK | W_OK, "--replay-persist"=
);
-
-    /* ** Password files ** */
-    errs |=3D check_file_access(CHKAC=
C_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                              =
options->key_pass_file, R_OK, "--askpass");
-#ifdef ENABLE_MANAGEMENT
-    =
errs |=3D
-        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKAC=
C_PRIVATE,
-                          options->management_user_pass, R_OK, =
"--management user/password file");
-#endif /* ENABLE_MANAGEMENT */
-    er=
rs |=3D check_file_access_inline(options->auth_user_pass_file_inline,
-    =
                                 CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PR=
IVATE,
-                                     options->auth_user_pass_file, =
R_OK, "--auth-user-pass");
-    /* ** System related ** */
-    errs |=3D c=
heck_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "--chroot d=
irectory");
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXS=
TWR, options->writepid, R_OK | W_OK,
-                              "--writ=
epid");
-
-    /* ** Log related ** */
-    errs |=3D check_file_access(CHK=
ACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,
-       =
                       "--status");
-
-    /* ** Config related ** */
-    =
errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, option=
s->client_config_dir,
-                                     R_OK | X_OK, "-=
-client-config-dir");
-    errs |=3D check_file_access_chroot(options->chro=
ot_dir, CHKACC_FILE, options->tmp_dir,
-                                   =
  R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
-
-    if (errs)
=
-    {
-        msg(M_USAGE, "Please correct these errors=2E");
-    }
-}
-=
#endif /* !ENABLE_SMALL */
-
-/*
  * Sanity check on options=2E
  * Also se=
t some options based on other
  * options=2E

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerrit-=
Change-Number: 1774
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--4tNnHTmB6Qo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">options: Factor out file access code from options=2Ec<br><br>options=
=2Ec is a huge, unwieldly file=2E So remove some<br>closely related code th=
at has no direct dependencies<br>with the other functions in the file=2E<br=
><br>This time it is the code that checks file accessibility=2E<br><br>Chan=
ge-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M=
 src/openvpn/Makefile=2Eam<br>A src/openvpn/check_file_access=2Ec<br>A src/=
openvpn/check_file_access=2Eh<br>M src/openvpn/options=2Ec<br>5 files chang=
ed, 412 insertions(+), 334 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 3981=
bae=2E=2Ea4f20c9 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><s=
pan>+++ b/CMakeLists=2Etxt</span><br><span>@@ -422,6 +422,8 @@</span><br><s=
pan>     src/openvpn/basic=2Eh</span><br><span>     src/openvpn/buffer=2Ec<=
/span><br><span>     src/openvpn/buffer=2Eh</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=
=2Eh</span><br><span>     src/openvpn/circ_list=2Eh</span><br><span>     sr=
c/openvpn/clinat=2Ec</span><br><span>     src/openvpn/clinat=2Eh</span><br>=
<span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</s=
pan><br><span>index 9778f32=2E=2E1fbcad4 100644</span><br><span>--- a/src/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span>=
<br><span>@@ -47,6 +47,7 @@</span><br><span> 	base64=2Ec base64=2Eh \</span=
><br><span> 	basic=2Eh \</span><br><span> 	buffer=2Ec buffer=2Eh \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	check_file_access=2Ec check=
_file_access=2Eh \</span><br><span> 	circ_list=2Eh \</span><br><span> 	clin=
at=2Ec clinat=2Eh \</span><br><span> 	common=2Eh \</span><br><span>diff --g=
it a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec<=
/span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ec86=
cc97</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/check_=
file_access=2Ec</span><br><span>@@ -0,0 +1,372 @@</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a=
 single UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2008-2026 David Sommerseth &lt;dazo@eurephia=2Eorg&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  This program is distributed in the hope that it will be useful,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  GNU General Public License for more details=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  You should have received a copy of the GNU General Public L=
icense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Check file/directory sanity</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Expect people usi=
ng the stripped down version to know what they do */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;argv=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_commo=
n=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILE       (1 &lt;&lt; =
0) /**&lt; Check for a file/directory presence */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define CHKACC_DIRPATH    (1 &lt;&lt; 1) /**&=
lt; Check for directory presence where a file should reside */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILEXSTWR  (1 &lt=
;&lt; 2) /**&lt; If file exists, is it writable? */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN  (1 &lt;&lt; 3) =
/**&lt; If filename is stdin, it&#39;s allowed and &quot;exists&quot; */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_PRIVATE=
    (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is group/others acce=
ssible */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CH=
KACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless they start=
 with file: */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+check_file_access(const int type=
, const char *file, const int mode, const char *opt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int errcode =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* If no file configured, no errors to look for */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!file)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If stdin=
 is allowed and the file name is &#39;stdin&#39;, then do no</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * further checks as stdin is =
always available</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((type &=
amp; CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* file name is a URI if its first segment  has &quot;:&quot; (i=2Ee=
=2E, before any &quot;/&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * Then no checks done if CHKACC_ACCEPT_URI is set and the U=
RI does not start with &quot;file:&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&amp; strchr(file, &#3=
9;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strncmp(fi=
le, &quot;file:&quot;, 5))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         file +=3D 5;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else if (!strchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39;) &gt; strch=
r(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Is the directory path leading to the g=
iven file accessible? */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (type &amp; CHKACC_DIRPATH)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        char *fullpath =3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            string_alloc(file, NULL); /* POSIX dirname() imple=
mentation may modify its arguments */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const char *dirpath =3D dirname(fullpath);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (platform_access(dirpath, mode | X=
_OK) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            errco=
de =3D errno;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(ful=
lpath);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Is the file itself accessible? */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!errcode &amp;&a=
mp; (type &amp; CHKACC_FILE) &amp;&amp; (platform_access(file, mode) !=3D 0=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        errcode =3D errno;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* If the file exists and is accessible, is it writab=
le? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!errc=
ode &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (platform_access(fi=
le, F_OK) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p=
latform_access(file, W_OK) !=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            errcode =3D errno;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Warn if a given priv=
ate file is group/others accessible=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (type &amp; CHKACC_PRIVATE)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        platform_stat_t st;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (platform_stat(file, &amp;st))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_ERRNO=
, &quot;WARNING: cannot stat file &#39;%s&#39;&quot;, file);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (st=2Est_mode &amp; (S_IRWXG | S_IRWXO))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, &quot;WA=
RNING: file &#39;%s&#39; is group or others accessible&quot;, file);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Screa=
m if an error is found */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (errcode &gt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_NOPREFIX | M_OPTERR | M_ERRNO, &quot;%s fails with &#39;%s&#39;&q=
uot;, opt, file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Return true if an error occu=
rred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (=
errcode !=3D 0 ? true : false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A wrapper for check_fi=
le_access() which also takes a chroot directory=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * If chroot is NULL, behaviour is exactly t=
he same as calling check_file_access() directly,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * otherwise it will look for the file inside =
the given chroot directory instead=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_=
file_access_chroot(const char *chroot, const int type, const char *file, co=
nst int mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                   const char *opt)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If no file=
 configured, no errors to look for */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!file)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* If chroot is set, look fo=
r the file/directory inside the chroot */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (chroot)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct buffer chroot_file;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        chroot_file =3D prepend_dir(chroot, file, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =
=3D check_file_access(type, BSTR(&amp;chroot_file), mode, opt);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* No chroot in play, just call core file check function=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D =
check_file_access(type, file, mode, opt);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * A wrapper for check_file_access_chroot() that =
returns false immediately if</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * the file is inline (and therefore there is no access to check)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+check_file_access_chroot_inline(bool is_inli=
ne, const char *chroot, const int type,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                const char *file, const=
 int mode, const char *opt)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is=
_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return check_file_access_chroot(chroot, type, file, =
mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * A wrapper for check_file_access() that returns false immed=
iately if the file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* is inline (and therefore there is no access to check)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check_file_access_inline(bool is_inline, const int type, const =
char *file, const int mode,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         const char *opt)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (is_inline)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return check_file_access(type,=
 file, mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Verifies that the path in the &quot;command&quot; th=
at comes after certain script options (e=2Eg=2E, --up) is a</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * valid file with appropriate perm=
issions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * &quot;command&quot; con=
sists of a path, optionally followed by a space, which may be</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * followed by arbitrary argument=
s=2E It is NOT a full shell command line -- shell expansion is not</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * performed=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * The path and arguments in &quot;command&quot; =
may be single- or double-quoted or escaped=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * The path is extracted from &quot;command&quot;, then check_file=
_access() is called to check it=2E The</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * arguments, if any, are ignored=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Note that the type, mode, and opt arguments to this r=
outine are the same as the corresponding</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * check_file_access() arguments=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+check_cmd_access(const char *command, const char *opt, const char *ch=
root)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool return_code;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* If no command was set, there are no erro=
rs to look for */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!command)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Extract executable path and arguments */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv =3D argv_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_parse_c=
md(&amp;argv, command);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if an ex=
ecutable is specified then check it; otherwise, complain */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (argv=2Eargv[0])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Scripts requires R_OK as well, but=
 that might fail on binaries which</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * only requires X_OK to function on Unix - a scenar=
io not unlikely to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * be seen on suid binaries=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return_code =3D check_file_access_chroot(chroot, CHKACC_F=
ILE, argv=2Eargv[0], X_OK, opt);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NOPREFIX | M=
_OPTERR, &quot;%s fails with &#39;%s&#39;: No path to executable=2E&quot;, =
opt, command);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return_code =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return return_code;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sanity check =
of all file/dir options=2E  Checks that file/dir</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * is accessible by OpenVPN</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+options_postprocess_filechecks(struct options *options)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    bool errs =3D false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* ** SSL/TLS/crypto related files ** */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(o=
ptions-&gt;dh_file_inline, CHKACC_FILE, options-&gt;dh_file, R_OK,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
         &quot;--dh&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!op=
tions-&gt;verify_hash_no_ca)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   errs |=3D check_file_access_inline(options-&gt;ca_file_inline, CHKACC_FI=
LE, options-&gt;ca_file,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                         R_OK, &quot;--ca&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    errs |=3D check_file_access_chroot(options-&gt;chroot=
_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                     &quot;--capa=
th&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acc=
ess_inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                options-&gt;cert_file, R_OK, &quot;--cert&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(options-&=
gt;extra_certs_file, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                     options-&gt;extra_certs_=
file, R_OK, &quot;--extra-certs&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(op=
tions-&gt;priv_key_file_inline,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                         CHKACC_FILE | CHKACC_P=
RIVATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                         options-&gt;priv_key_file,=
 R_OK, &quot;--key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_a=
ccess_inline(options-&gt;pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                 options-&gt;pkcs12_file, R_OK, &quot;--pkcs12&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;ssl_flags &amp; SSLF_=
CRL_VERIFY_DIR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D =
check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;c=
rl_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                              R_OK | X_OK, &quot;--crl-verify directory&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        errs |=3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            check_file_access_chroot_inline(options-&gt;=
crl_file_inline, options-&gt;chroot_dir,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                            CHKACC_FIL=
E, options-&gt;crl_file, R_OK, &quot;--crl-verify&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (options-&gt;tls_export_peer_cert_dir)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        errs |=3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            check_file_access_chroot(options-&gt;chroot_dir,=
 CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                               options-&gt;tls_export_peer_cert_dir, W_OK, =
&quot;--tls-export-cert&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(options-&g=
t;connection_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (int i =3D 0; i &lt; options-&gt;connection_list-&gt;len; ++i)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const struct connection_entry =
*ce =3D options-&gt;connection_list-&gt;array[i];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;tls_auth_file_=
inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                         ce-&gt;tls_auth_=
file, R_OK, &quot;--tls-auth&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;tls_cryp=
t_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                         ce-&gt;tl=
s_crypt_file, R_OK, &quot;--tls-crypt&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt=
;tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
   ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    errs |=3D</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        check_file_access_inline(options-&gt;shared_secret_file_inline=
, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                 options-&gt;shared_secret_file=
, R_OK, &quot;--secret&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs=
 |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;pack=
et_id_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                      R_OK | W_OK, &quot;--replay-persist&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* ** Password files ** */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHKAC=
C_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                              options-&gt;key_pass_=
file, R_OK, &quot;--askpass&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    errs |=3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | C=
HKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                     options-&gt;management_user_pass, R_OK, &quot;--manage=
ment user/password file&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(options-&gt;a=
uth_user_pass_file_inline,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                     CHKACC_FILE | CHKACC_ACPTSTDIN =
| CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                   options-&gt;auth_user_pass_file, R_OK, &=
quot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* ** System related ** */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_FILE, options-&=
gt;chroot_dir, R_OK | X_OK, &quot;--chroot directory&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CH=
KACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, R_OK | W_OK,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
   &quot;--writepid&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** L=
og related ** */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt=
;status_file, R_OK | W_OK,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                              &quot;--status&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* ** Config related ** */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(op=
tions-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
        R_OK | X_OK, &quot;--client-config-dir&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(o=
ptions-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                     R=
_OK | W_OK | X_OK, &quot;Temporary directory (--tmp-dir)&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (errs)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_USAGE, &quot;Please correct these errors=2E&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* !ENABLE_SMALL */</span><br><span>diff --git a/src/openvpn/check_=
file_access=2Eh b/src/openvpn/check_file_access=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2Eaf057bc</span><br><span>--=
- /dev/null</span><br><span>+++ b/src/openvpn/check_file_access=2Eh</span><=
br><span>@@ -0,0 +1,36 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN=
 -- An application to securely tunnel IP networks</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             over a single UDP port, with s=
upport for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             session authentication and key exchange,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, =
packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             packet compression=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; yo=
u can redistribute it and/or modify</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publi=
shed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
GNU General Public License for more details=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef CHECK_FILE_ACCESS_H</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define CHECK_FILE_ACCESS_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool chec=
k_cmd_access(const char *command, const char *opt, const char *chroot);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void options_postprocess_filechecks(struc=
t options *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !ENABLE_=
SMALL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>ind=
ex 6e314a1=2E=2E03cda5a 100644</span><br><span>--- a/src/openvpn/options=2E=
c</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -63,6 +6=
3,7 @@</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span=
> #include &quot;domain_helper=2Eh&quot;</span><br><span> #include &quot;mb=
uf=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;check_file_access=2Eh&quot;</span><br><span> </span><br><span> #inc=
lude &lt;ctype=2Eh&gt;</span><br><span> </span><br><span>@@ -3336,340 +3337=
,6 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  Check file/directory sanity</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
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

<div style=3D"display:none"> Gerrit-MessageType: newchange=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1774 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit=
-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--4tNnHTmB6Qo=--


--===============2744508258088250748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2744508258088250748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2744508258088250748==--

