Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE18DC5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFprIx0x4ArJtWwEU7cAx8DhzdYKqQdGczYMQpEtJbg=; b=C0GTbNZ5b993n2XsneWxdm9XVw
	sOhsL+z2Baa7BhcBBjSKToalIihVpaeSHug+Q310jpePcJfq4GSoQDFr4vqQ5sisElbmJ1rYipPux
	IGeVnxSZ5q6LGLj+ojEvilA5mmGsgsYJbAWeLHjkhmpOswGpMcyQbAvbcYXR0XkjRt+U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwnWy-00046O-Al;
	Wed, 19 Aug 2026 21:09:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwnWv-00046G-Ei
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:09:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TuYiZznRMZWjBv5vxlCDhe/m5+PGtcMSUTHx+/G50jw=; b=IjBZfih6F+FxE1IK35va9qvMfj
 Vz9k8FcS+WSDPAKtZFG4Bypy1SAiAJ6qab2jFALHd+hByUJNl6FfS8cM9G69FhVg1YuprDHOhwLQw
 Gbp5OqRyWuyiqrBTFH0j4ngJ9+Gu3y/1Xf0Q+4ffApcHO+rfSQzLjWCRO65boUU6RMXY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TuYiZznRMZWjBv5vxlCDhe/m5+PGtcMSUTHx+/G50jw=; b=l
 KfTZGwPPgfE57SylFn3cj9RgwzENTZY/7snkY4NtxXAQGo/rpYxKVLSCEJAsYxJfzObd6ZnE5T0Ls
 MjqAe/24GT7/d2h28DVRglCySuzQO0TQHpqfe6VXFPux3F+r9mo1+w0QpfuQ+YGvxx4zkMaLy1haG
 u1OhIDWxstu6kgTU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwnWr-00007g-JE for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:09:02 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so13067415e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 14:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787173731; x=1787778531; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TuYiZznRMZWjBv5vxlCDhe/m5+PGtcMSUTHx+/G50jw=;
 b=THDi1u3xPBaaQtStLatJLAfp5cF/xw6Vc33OjqH5caHq3iLutJC3YxPsNRFZ8izZ9O
 ZJxaKksI7vNGTyvofBU7lf3be4Dmu94E2ff3IzvF3e4D247FK3l7+bpl6bK5lpmpmDA1
 S0L2sBvY9WV3bijaPWqPTq1TQFGIEu+/YpuJQ/X4ySHqTWbBz5ue/JPSIO4mFAjcWuia
 Qp/5kUsESUcE/YLDLJJpaWDdf7xHB0Tq/r47XHYNOu96LbLz41/GKeY37ToiocrXDEXU
 Ym1oQgFFj3xe9D7vWOzBGYoylKwlkPrAC0FtkvxP8yHSX71P6YH235lkwInQFXxa1nSm
 rIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787173731; x=1787778531;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TuYiZznRMZWjBv5vxlCDhe/m5+PGtcMSUTHx+/G50jw=;
 b=fyNX0KDsCO/1lzO53D2WrXxM0CbhjVr6zKBvoS/aE9s2RMqKlzSJWOBfhIINb2Jd9Z
 zbW26a+qUDbN6WQ2xW5luq998RkVB106wGmz9M7THPyzUPydZcedkNoK1RYIF3S8LkER
 CrVMAbRRP1ercC1CHxj2Ktuq5+X7q2XUbTzkLfRogZNW6dFQofwsNQvgox9m8ncVjzOO
 Xy5tsUP6RVdI25KKiZhlP/BLF9hI10g7bLu8VqbG/EB4BBUoJ37JVzHxIi8kGF9hMqWq
 NsBfjwtkC4W7m4YQllORitaIDgFTsTAcwgcoYSWl/logYuAOUC451VJyxC5XMPR/uQOM
 ujyw==
X-Gm-Message-State: AOJu0Yy+EYDn6seYPaw9VvwFParuWRAQ3rsIJv0a9ekg+tkr4RQkaq8N
 1BoxPNrT3U+LSm/F2wnt/sI5RF5TAf19aBy9Xtp6j7xtGeix2GmlkXdy1Y1kdovBMwr267o7xAI
 yxLY+NHkzHZXfqTk7aG1ScqxXH6fguWIdVZM4og8jbS3nps7W7Mo1Q+YSnJWt1+k7Hgg/
X-Gm-Gg: AR+sD13Bf38+kWDApLgI5v5jklrz/WvjqDjLa9Xt5tiylEiC5QTYf5kboZ+wD62Gp+P
 YGxwzM/NklDVy8FZ1XsqBJ4YALN/mTQ2LY+RvASi2LV3/W68R+4iLH6y3eJO1XzLYfVVDMnsro4
 sZ2qhwCXXeYvDBrzNwG6th8lxT17rBg9Di1sS9S3pupX/y/jHsGISrLB4IZRt2uJH29JqfCL0Hk
 AK3s/QTcUYymBmkKJj3b6K/CrGsA2FoeoZ8Hwe173DBdgsQ1+KnSqz6xF4qoc/0CyQFhb9S/Hoy
 tcii4M+2hQictulM0US+NK+xPM0YLXavGCeJX/eyTLzXcR6yRpcZqGin+PJnP/BTqj78tF/szCi
 M/4fFWQSrCkcG/CNDGzVNZrESSAQDZl0lqaaTfqglBFvMmgmQHNJO7OnBAmptQ5J1lH+yfP/tkp
 Xw4w7fwgEMLnqUMXnLq+N5kXewt/Y9JanMLNAcr8zFnmQ7LZ3tEilZ0BCmJfnCHgEgc33dZAi6Z
 1Lcn/4kRDn0rRJCfCf/BkhGu9pRmJIx1uEuGZxOGUDTw7uxtM+VeUthFMRH7l9KFOChVbA82W3D
 gDLuZ5K2ELPjPn2IohtrM/I56C3f+PCibRfZcTzVVT6w9bmFSgg=
X-Received: by 2002:a05:600c:34d1:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499aa14a6a6mr142203675e9.3.1787173730485; 
 Wed, 19 Aug 2026 14:08:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa09b199sm76860935e9.0.2026.08.19.14.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 14:08:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 21:08:45 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: 6334d3d188437ea392faac4ed3283b61e7a51e54
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d01bdb3d196575e3f619a39aaa05719220f4c27-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwnWr-00007g-JE
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6401484371174434649=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6401484371174434649==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2BZxPpBJDEc="; charset=UTF-8

--2BZxPpBJDEc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: options: Factor out file access code from opti=
ons=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

opti=
ons: Factor out file access code from options=2Ec

options=2Ec is a huge, u=
nwieldly file=2E So remove some
closely related code that has no direct dep=
endencies
with the other functions in the file=2E

This time it is the code=
 that checks file accessibility=2E

Change-Id: I6dafab74b82fbf770c1798b4851=
a0fd5e4b5d81e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ac=
ked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1774
Message-Id: <20260819160522=2E6662-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg38535=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src=
/openvpn/check_file_access=2Ec
A src/openvpn/check_file_access=2Eh
M src/op=
envpn/options=2Ec
5 files changed, 418 insertions(+), 334 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/6
=

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 9af7870=2E=2E886652=
0 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -431,6 +431,8 @@
=
     src/openvpn/basic=2Eh
     src/openvpn/buffer=2Ec
     src/openvpn/buf=
fer=2Eh
+    src/openvpn/check_file_access=2Ec
+    src/openvpn/check_file_=
access=2Eh
     src/openvpn/circ_list=2Eh
     src/openvpn/clinat=2Ec
     =
src/openvpn/clinat=2Eh
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn=
/Makefile=2Eam
index 4220d07=2E=2E42b4404 100644
--- a/src/openvpn/Makefile=
=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -47,6 +47,7 @@
 	base64=2Ec base64=
=2Eh \
 	basic=2Eh \
 	buffer=2Ec buffer=2Eh \
+	check_file_access=2Ec chec=
k_file_access=2Eh \
 	circ_list=2Eh \
 	clinat=2Ec clinat=2Eh \
 	common=2E=
h \
diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file=
_access=2Ec
new file mode 100644
index 0000000=2E=2E83654b2
--- /dev/null
+=
++ b/src/openvpn/check_file_access=2Ec
@@ -0,0 +1,354 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le UDP port, with support for SSL/TLS-based
+ *             session authent=
ication and key exchange,
+ *             packet encryption, packet authent=
ication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2=
002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2008-2026 Dav=
id Sommerseth <dazo@eurephia=2Eorg>
+ *
+ *  This program is free software;=
 you can redistribute it and/or modify
+ *  it under the terms of the GNU G=
eneral Public License version 2
+ *  as published by the Free Software Foun=
dation=2E
+ *
+ *  This program is distributed in the hope that it will be =
useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=

+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  =
GNU General Public License for more details=2E
+ *
+ *  You should have rec=
eived a copy of the GNU General Public License along
+ *  with this program=
; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*
+ *  Check =
file/directory sanity
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"=

+#endif
+
+/* Expect people using the stripped down version to know what t=
hey do */
+#ifndef ENABLE_SMALL
+
+#include "syshead=2Eh"
+
+#include "chec=
k_file_access=2Eh"
+
+#include "argv=2Eh"
+#include "buffer=2Eh"
+#include =
"error=2Eh"
+#include "options=2Eh"
+#include "platform=2Eh"
+#include "ssl=
_common=2Eh"
+
+#include <string=2Eh>
+
+#define CHKACC_FILE       (1 << 0)=
 /**< Check for a file/directory presence */
+#define CHKACC_DIRPATH    (1 =
<< 1) /**< Check for directory presence where a file should reside */
+#def=
ine CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writable? */
+#de=
fine CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed and=
 "exists" */
+#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private=
) file is group/others accessible */
+#define CHKACC_ACCEPT_URI (1 << 5) /*=
*< Do not check URIs, unless they start with file: */
+
+static bool
+check=
_file_access(const int type, const char *file, const int mode, const char *=
opt)
+{
+    int errcode =3D 0;
+
+    /* If no file configured, no errors =
to look for */
+    if (!file)
+    {
+        return false;
+    }
+
+    =
/* If stdin is allowed and the file name is 'stdin', then do no
+     * fur=
ther checks as stdin is always available
+     */
+    if ((type & CHKACC_A=
CPTSTDIN) && streq(file, "stdin"))
+    {
+        return false;
+    }
+
+=
    /* file name is a URI if its first segment  has ":" (i=2Ee=2E, before a=
ny "/")
+     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI=
 does not start with "file:"
+     */
+    if ((type & CHKACC_ACCEPT_URI) &=
& strchr(file, ':'))
+    {
+        if (!strncmp(file, "file:", 5))
+     =
   {
+            file +=3D 5;
+        }
+        else if (!strchr(file, '=
/') || strchr(file, '/') > strchr(file, ':'))
+        {
+            retur=
n false;
+        }
+    }
+
+    /* Is the directory path leading to the g=
iven file accessible? */
+    if (type & CHKACC_DIRPATH)
+    {
+        ch=
ar *fullpath =3D
+            string_alloc(file, NULL); /* POSIX dirname() =
implementation may modify its arguments */
+        const char *dirpath =3D=
 dirname(fullpath);
+
+        if (platform_access(dirpath, mode | X_OK) !=
=3D 0)
+        {
+            errcode =3D errno;
+        }
+        free(=
fullpath);
+    }
+
+    /* Is the file itself accessible? */
+    if (!err=
code && (type & CHKACC_FILE) && (platform_access(file, mode) !=3D 0))
+    =
{
+        errcode =3D errno;
+    }
+
+    /* If the file exists and is ac=
cessible, is it writable? */
+    if (!errcode && (type & CHKACC_FILEXSTWR)=
 && (platform_access(file, F_OK) =3D=3D 0))
+    {
+        if (platform_ac=
cess(file, W_OK) !=3D 0)
+        {
+            errcode =3D errno;
+      =
  }
+    }
+
+    /* Warn if a given private file is group/others accessibl=
e=2E */
+    if (type & CHKACC_PRIVATE)
+    {
+        platform_stat_t st;=

+        if (platform_stat(file, &st))
+        {
+            msg(M_WARN =
| M_ERRNO, "WARNING: cannot stat file '%s'", file);
+        }
+#ifndef _WI=
N32
+        else
+        {
+            if (st=2Est_mode & (S_IRWXG | S_I=
RWXO))
+            {
+                msg(M_WARN, "WARNING: file '%s' is g=
roup or others accessible", file);
+            }
+        }
+#endif
+    }=

+
+    /* Scream if an error is found */
+    if (errcode > 0)
+    {
+   =
     msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);=

+    }
+
+    /* Return true if an error occurred */
+    return (errcode =
!=3D 0 ? true : false);
+}
+
+/** A wrapper for check_file_access() which a=
lso takes a chroot directory=2E
+ * If chroot is NULL, behaviour is exactly=
 the same as calling check_file_access() directly,
+ * otherwise it will lo=
ok for the file inside the given chroot directory instead=2E
+ */
+static b=
ool
+check_file_access_chroot(const char *chroot, const int type, const cha=
r *file, const int mode,
+                         const char *opt)
+{
+   =
 bool ret =3D false;
+
+    /* If no file configured, no errors to look for=
 */
+    if (!file)
+    {
+        return false;
+    }
+
+    /* If chroo=
t is set, look for the file/directory inside the chroot */
+    if (chroot)=

+    {
+        struct gc_arena gc =3D gc_new();
+        struct buffer ch=
root_file;
+
+        chroot_file =3D prepend_dir(chroot, file, &gc);
+    =
    ret =3D check_file_access(type, BSTR(&chroot_file), mode, opt);
+      =
  gc_free(&gc);
+    }
+    else
+    {
+        /* No chroot in play, just=
 call core file check function */
+        ret =3D check_file_access(type, =
file, mode, opt);
+    }
+    return ret;
+}
+
+/**
+ * A wrapper for check=
_file_access_chroot() that returns false immediately if
+ * the file is inl=
ine (and therefore there is no access to check)
+ */
+static bool
+check_fi=
le_access_chroot_inline(bool is_inline, const char *chroot, const int type,=

+                                const char *file, const int mode, const c=
har *opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+  =
  return check_file_access_chroot(chroot, type, file, mode, opt);
+}
+
+/**=

+ * A wrapper for check_file_access() that returns false immediately if th=
e file
+ * is inline (and therefore there is no access to check)
+ */
+stat=
ic bool
+check_file_access_inline(bool is_inline, const int type, const cha=
r *file, const int mode,
+                         const char *opt)
+{
+   =
 if (is_inline)
+    {
+        return false;
+    }
+
+    return check_fi=
le_access(type, file, mode, opt);
+}
+
+bool
+check_cmd_access(const char *=
command, const char *opt, const char *chroot)
+{
+    struct argv argv;
+  =
  bool return_code;
+
+    /* If no command was set, there are no errors to=
 look for */
+    if (!command)
+    {
+        return false;
+    }
+
+   =
 /* Extract executable path and arguments */
+    argv =3D argv_new();
+   =
 argv_parse_cmd(&argv, command);
+
+    /* if an executable is specified th=
en check it; otherwise, complain */
+    if (argv=2Eargv[0])
+    {
+      =
  /* Scripts requires R_OK as well, but that might fail on binaries which
+=
         * only requires X_OK to function on Unix - a scenario not unlikely=
 to
+         * be seen on suid binaries=2E
+         */
+        return_co=
de =3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, =
opt);
+    }
+    else
+    {
+        msg(M_NOPREFIX | M_OPTERR, "%s fails=
 with '%s': No path to executable=2E", opt, command);
+        return_code =
=3D true;
+    }
+
+    argv_free(&argv);
+
+    return return_code;
+}
+
+=
void
+options_postprocess_filechecks(struct options *options)
+{
+    bool =
errs =3D false;
+
+    /* ** SSL/TLS/crypto related files ** */
+    errs |=
=3D check_file_access_inline(options->dh_file_inline, CHKACC_FILE, options-=
>dh_file, R_OK,
+                                     "--dh");
+
+    if (!=
options->verify_hash_no_ca)
+    {
+        errs |=3D check_file_access_inl=
ine(options->ca_file_inline, CHKACC_FILE, options->ca_file,
+              =
                           R_OK, "--ca");
+    }
+
+    errs |=3D check_fil=
e_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK,
+=
                                     "--capath");
+
+    errs |=3D check_fi=
le_access_inline(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI=
,
+                                     options->cert_file, R_OK, "--cert")=
;
+
+    errs |=3D check_file_access_inline(options->extra_certs_file, CHKA=
CC_FILE,
+                                     options->extra_certs_file, R=
_OK, "--extra-certs");
+
+    if (!(options->management_flags & MF_EXTERNAL=
_KEY))
+    {
+        errs |=3D check_file_access_inline(options->priv_key=
_file_inline,
+                                         CHKACC_FILE | CHKAC=
C_PRIVATE | CHKACC_ACCEPT_URI,
+                                         op=
tions->priv_key_file, R_OK, "--key");
+    }
+
+    errs |=3D check_file_ac=
cess_inline(options->pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+   =
                                  options->pkcs12_file, R_OK, "--pkcs12");
=
+
+    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
+    {
+        errs |=
=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->crl=
_file,
+                                         R_OK | X_OK, "--crl-verify=
 directory");
+    }
+    else
+    {
+        errs |=3D
+            check=
_file_access_chroot_inline(options->crl_file_inline, options->chroot_dir,
+=
                                            CHKACC_FILE, options->crl_file,=
 R_OK, "--crl-verify");
+    }
+
+    if (options->tls_export_peer_cert_dir=
)
+    {
+        errs |=3D
+            check_file_access_chroot(options->=
chroot_dir, CHKACC_FILE,
+                                     options->tls=
_export_peer_cert_dir, W_OK, "--tls-export-cert");
+    }
+
+    ASSERT(opt=
ions->connection_list);
+    for (int i =3D 0; i < options->connection_list=
->len; ++i)
+    {
+        const struct connection_entry *ce =3D options->=
connection_list->array[i];
+
+        errs |=3D check_file_access_inline(ce=
->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                    =
                     ce->tls_auth_file, R_OK, "--tls-auth");
+        errs =
|=3D check_file_access_inline(ce->tls_crypt_file_inline, CHKACC_FILE | CHKA=
CC_PRIVATE,
+                                         ce->tls_crypt_file, R=
_OK, "--tls-crypt");
+        errs |=3D check_file_access_inline(ce->tls_cr=
ypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                        =
                 ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
+    }
+
+=
    errs |=3D
+        check_file_access_inline(options->shared_secret_file=
_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                                 op=
tions->shared_secret_file, R_OK, "--secret");
+
+    errs |=3D check_file_a=
ccess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
+        =
                      R_OK | W_OK, "--replay-persist");
+
+    /* ** Passwo=
rd files ** */
+    errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTST=
DIN | CHKACC_PRIVATE,
+                              options->key_pass_file=
, R_OK, "--askpass");
+#ifdef ENABLE_MANAGEMENT
+    errs |=3D
+        che=
ck_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+          =
                options->management_user_pass, R_OK, "--management user/pas=
sword file");
+#endif /* ENABLE_MANAGEMENT */
+    errs |=3D check_file_acc=
ess_inline(options->auth_user_pass_file_inline,
+                          =
           CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+              =
                       options->auth_user_pass_file, R_OK, "--auth-user-pas=
s");
+    /* ** System related ** */
+    errs |=3D check_file_access(CHKAC=
C_FILE, options->chroot_dir, R_OK | X_OK, "--chroot directory");
+    errs =
|=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid=
, R_OK | W_OK,
+                              "--writepid");
+
+    /* ** L=
og related ** */
+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_F=
ILEXSTWR, options->status_file, R_OK | W_OK,
+                             =
 "--status");
+
+    /* ** Config related ** */
+    errs |=3D check_file_a=
ccess_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
=
+                                     R_OK | X_OK, "--client-config-dir");
=
+    errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, o=
ptions->tmp_dir,
+                                     R_OK | W_OK | X_OK, =
"Temporary directory (--tmp-dir)");
+
+    if (errs)
+    {
+        msg(M_=
USAGE, "Please correct these errors=2E");
+    }
+}
+
+#endif /* !ENABLE_SM=
ALL */
diff --git a/src/openvpn/check_file_access=2Eh b/src/openvpn/check_f=
ile_access=2Eh
new file mode 100644
index 0000000=2E=2Eb3ed886
--- /dev/nul=
l
+++ b/src/openvpn/check_file_access=2Eh
@@ -0,0 +1,60 @@
+/*
+ *  OpenVPN=
 -- An application to securely tunnel IP networks
+ *             over a si=
ngle UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free =
software; you can redistribute it and/or modify
+ *  it under the terms of =
the GNU General Public License version 2
+ *  as published by the Free Soft=
ware Foundation=2E
+ *
+ *  This program is distributed in the hope that it=
 will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See =
the
+ *  GNU General Public License for more details=2E
+ *
+ *  You should=
 have received a copy of the GNU General Public License along
+ *  with thi=
s program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifnd=
ef CHECK_FILE_ACCESS_H
+#define CHECK_FILE_ACCESS_H
+
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#ifndef ENABLE_SMALL
+
+#include "option=
s=2Eh"
+
+/**
+ * Verifies that the path in the "command" that comes after =
certain script options (e=2Eg=2E, --up) is a
+ * valid file with appropriat=
e permissions=2E
+ *
+ * "command" consists of a path, optionally followed =
by a space, which may be
+ * followed by arbitrary arguments=2E It is NOT a=
 full shell command line -- shell expansion is not
+ * performed=2E
+ *
+ *=
 The path and arguments in "command" may be single- or double-quoted or esc=
aped=2E
+ *
+ * The path is extracted from "command", then check_file_acces=
s() is called to check it=2E The
+ * arguments, if any, are ignored=2E
+ *
=
+ * Note that the type, mode, and opt arguments to this routine are the sam=
e as the corresponding
+ * check_file_access() arguments=2E
+ */
+bool chec=
k_cmd_access(const char *command, const char *opt, const char *chroot);
+
+=
/**
+ * Sanity check of all file/dir options=2E  Checks that file/dir
+ * i=
s accessible by OpenVPN
+ */
+void options_postprocess_filechecks(struct op=
tions *options);
+
+#endif /* !ENABLE_SMALL */
+
+#endif /* CHECK_FILE_ACCE=
SS_H */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
inde=
x e899fa6=2E=2E317ce44 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openv=
pn/options=2Ec
@@ -63,6 +63,7 @@
 #include "tun_afunix=2Eh"
 #include "doma=
in_helper=2Eh"
 #include "mbuf=2Eh"
+#include "check_file_access=2Eh"
 
 #i=
nclude <ctype=2Eh>
 
@@ -3328,340 +3329,6 @@
 }
 
 /*
- *  Check file/direc=
tory sanity
- *
- */
-/* Expect people using the stripped down version to k=
now what they do */
-#ifndef ENABLE_SMALL
-
-#define CHKACC_FILE       (1 <=
< 0) /**< Check for a file/directory presence */
-#define CHKACC_DIRPATH   =
 (1 << 1) /**< Check for directory presence where a file should reside */
-=
#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writable? */
=
-#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed=
 and "exists" */
-#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (pri=
vate) file is group/others accessible */
-#define CHKACC_ACCEPT_URI (1 << 5=
) /**< Do not check URIs, unless they start with file: */
-
-static bool
-c=
heck_file_access(const int type, const char *file, const int mode, const ch=
ar *opt)
-{
-    int errcode =3D 0;
-
-    /* If no file configured, no err=
ors to look for */
-    if (!file)
-    {
-        return false;
-    }
-
-=
    /* If stdin is allowed and the file name is 'stdin', then do no
-     *=
 further checks as stdin is always available
-     */
-    if ((type & CHKA=
CC_ACPTSTDIN) && streq(file, "stdin"))
-    {
-        return false;
-    }=

-
-    /* file name is a URI if its first segment  has ":" (i=2Ee=2E, befo=
re any "/")
-     * Then no checks done if CHKACC_ACCEPT_URI is set and the=
 URI does not start with "file:"
-     */
-    if ((type & CHKACC_ACCEPT_UR=
I) && strchr(file, ':'))
-    {
-        if (!strncmp(file, "file:", 5))
- =
       {
-            file +=3D 5;
-        }
-        else if (!strchr(fil=
e, '/') || strchr(file, '/') > strchr(file, ':'))
-        {
-            r=
eturn false;
-        }
-    }
-
-    /* Is the directory path leading to t=
he given file accessible? */
-    if (type & CHKACC_DIRPATH)
-    {
-      =
  char *fullpath =3D
-            string_alloc(file, NULL); /* POSIX dirnam=
e() implementation may modify its arguments */
-        char *dirpath =3D d=
irname(fullpath);
-
-        if (platform_access(dirpath, mode | X_OK) !=3D=
 0)
-        {
-            errcode =3D errno;
-        }
-        free(ful=
lpath);
-    }
-
-    /* Is the file itself accessible? */
-    if (!errcod=
e && (type & CHKACC_FILE) && (platform_access(file, mode) !=3D 0))
-    {
-=
        errcode =3D errno;
-    }
-
-    /* If the file exists and is acces=
sible, is it writable? */
-    if (!errcode && (type & CHKACC_FILEXSTWR) &&=
 (platform_access(file, F_OK) =3D=3D 0))
-    {
-        if (platform_acces=
s(file, W_OK) !=3D 0)
-        {
-            errcode =3D errno;
-        }=

-    }
-
-    /* Warn if a given private file is group/others accessible=
=2E */
-    if (type & CHKACC_PRIVATE)
-    {
-        platform_stat_t st;
=
-        if (platform_stat(file, &st))
-        {
-            msg(M_WARN |=
 M_ERRNO, "WARNING: cannot stat file '%s'", file);
-        }
-#ifndef _WIN=
32
-        else
-        {
-            if (st=2Est_mode & (S_IRWXG | S_IR=
WXO))
-            {
-                msg(M_WARN, "WARNING: file '%s' is gr=
oup or others accessible", file);
-            }
-        }
-#endif
-    }
=
-
-    /* Scream if an error is found */
-    if (errcode > 0)
-    {
-    =
    msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
=
-    }
-
-    /* Return true if an error occurred */
-    return (errcode !=
=3D 0 ? true : false);
-}
-
-/* A wrapper for check_file_access() which als=
o takes a chroot directory=2E
- * If chroot is NULL, behaviour is exactly t=
he same as calling check_file_access() directly,
- * otherwise it will look=
 for the file inside the given chroot directory instead=2E
- */
-static boo=
l
-check_file_access_chroot(const char *chroot, const int type, const char =
*file, const int mode,
-                         const char *opt)
-{
-    b=
ool ret =3D false;
-
-    /* If no file configured, no errors to look for *=
/
-    if (!file)
-    {
-        return false;
-    }
-
-    /* If chroot =
is set, look for the file/directory inside the chroot */
-    if (chroot)
-=
    {
-        struct gc_arena gc =3D gc_new();
-        struct buffer chro=
ot_file;
-
-        chroot_file =3D prepend_dir(chroot, file, &gc);
-      =
  ret =3D check_file_access(type, BSTR(&chroot_file), mode, opt);
-        =
gc_free(&gc);
-    }
-    else
-    {
-        /* No chroot in play, just c=
all core file check function */
-        ret =3D check_file_access(type, fi=
le, mode, opt);
-    }
-    return ret;
-}
-
-/**
- * A wrapper for check_f=
ile_access_chroot() that returns false immediately if
- * the file is inlin=
e (and therefore there is no access to check)
- */
-static bool
-check_file=
_access_chroot_inline(bool is_inline, const char *chroot, const int type,
-=
                                const char *file, const int mode, const cha=
r *opt)
-{
-    if (is_inline)
-    {
-        return false;
-    }
-
-    =
return check_file_access_chroot(chroot, type, file, mode, opt);
-}
-
-/**
-=
 * A wrapper for check_file_access() that returns false immediately if the =
file
- * is inline (and therefore there is no access to check)
- */
-static=
 bool
-check_file_access_inline(bool is_inline, const int type, const char =
*file, const int mode,
-                         const char *opt)
-{
-    i=
f (is_inline)
-    {
-        return false;
-    }
-
-    return check_file=
_access(type, file, mode, opt);
-}
-
-/*
- * Verifies that the path in the =
"command" that comes after certain script options (e=2Eg=2E, --up) is a
- *=
 valid file with appropriate permissions=2E
- *
- * "command" consists of a=
 path, optionally followed by a space, which may be
- * followed by arbitra=
ry arguments=2E It is NOT a full shell command line -- shell expansion is n=
ot
- * performed=2E
- *
- * The path and arguments in "command" may be sing=
le- or double-quoted or escaped=2E
- *
- * The path is extracted from "comm=
and", then check_file_access() is called to check it=2E The
- * arguments, =
if any, are ignored=2E
- *
- * Note that the type, mode, and opt arguments =
to this routine are the same as the corresponding
- * check_file_access() a=
rguments=2E
- */
-static bool
-check_cmd_access(const char *command, const =
char *opt, const char *chroot)
-{
-    struct argv argv;
-    bool return_c=
ode;
-
-    /* If no command was set, there are no errors to look for */
- =
   if (!command)
-    {
-        return false;
-    }
-
-    /* Extract exe=
cutable path and arguments */
-    argv =3D argv_new();
-    argv_parse_cmd=
(&argv, command);
-
-    /* if an executable is specified then check it; ot=
herwise, complain */
-    if (argv=2Eargv[0])
-    {
-        /* Scripts re=
quires R_OK as well, but that might fail on binaries which
-         * only=
 requires X_OK to function on Unix - a scenario not unlikely to
-         *=
 be seen on suid binaries=2E
-         */
-        return_code =3D check_fi=
le_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);
-    }
- =
   else
-    {
-        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No =
path to executable=2E", opt, command);
-        return_code =3D true;
-    =
}
-
-    argv_free(&argv);
-
-    return return_code;
-}
-
-/*
- * Sanity c=
heck of all file/dir options=2E  Checks that file/dir
- * is accessible by =
OpenVPN
- */
-static void
-options_postprocess_filechecks(struct options *o=
ptions)
-{
-    bool errs =3D false;
-
-    /* ** SSL/TLS/crypto related fi=
les ** */
-    errs |=3D check_file_access_inline(options->dh_file_inline, =
CHKACC_FILE, options->dh_file, R_OK,
-                                     =
"--dh");
-
-    if (!options->verify_hash_no_ca)
-    {
-        errs |=3D =
check_file_access_inline(options->ca_file_inline, CHKACC_FILE, options->ca_=
file,
-                                         R_OK, "--ca");
-    }
-
-  =
  errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, opti=
ons->ca_path, R_OK,
-                                     "--capath");
-
- =
   errs |=3D check_file_access_inline(options->cert_file_inline, CHKACC_FIL=
E | CHKACC_ACCEPT_URI,
-                                     options->cert_=
file, R_OK, "--cert");
-
-    errs |=3D check_file_access_inline(options->e=
xtra_certs_file, CHKACC_FILE,
-                                     options=
->extra_certs_file, R_OK, "--extra-certs");
-
-    if (!(options->managemen=
t_flags & MF_EXTERNAL_KEY))
-    {
-        errs |=3D check_file_access_inl=
ine(options->priv_key_file_inline,
-                                       =
  CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
-                      =
                   options->priv_key_file, R_OK, "--key");
-    }
-
-    er=
rs |=3D check_file_access_inline(options->pkcs12_file_inline, CHKACC_FILE |=
 CHKACC_PRIVATE,
-                                     options->pkcs12_file=
, R_OK, "--pkcs12");
-
-    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-=
    {
-        errs |=3D check_file_access_chroot(options->chroot_dir, CHKA=
CC_FILE, options->crl_file,
-                                         R_OK =
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
-        struct connection_entry *=
ce =3D options->connection_list->array[i];
-
-        errs |=3D check_file_=
access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-    =
                                     ce->tls_auth_file, R_OK, "--tls-auth")=
;
-        errs |=3D check_file_access_inline(ce->tls_crypt_file_inline, CH=
KACC_FILE | CHKACC_PRIVATE,
-                                         ce->t=
ls_crypt_file, R_OK, "--tls-crypt");
-        errs |=3D check_file_access_i=
nline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-        =
                                 ce->tls_crypt_v2_file, R_OK, "--tls-crypt-=
v2");
-    }
-
-    errs |=3D
-        check_file_access_inline(options->sh=
ared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                   =
              options->shared_secret_file, R_OK, "--secret");
-
-    errs |=
=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id=
_file,
-                              R_OK | W_OK, "--replay-persist");
-
-=
    /* ** Password files ** */
-    errs |=3D check_file_access(CHKACC_FILE=
 | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                              option=
s->key_pass_file, R_OK, "--askpass");
-#ifdef ENABLE_MANAGEMENT
-    errs |=
=3D
-        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIV=
ATE,
-                          options->management_user_pass, R_OK, "--man=
agement user/password file");
-#endif /* ENABLE_MANAGEMENT */
-    errs |=
=3D check_file_access_inline(options->auth_user_pass_file_inline,
-        =
                             CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVAT=
E,
-                                     options->auth_user_pass_file, R_OK=
, "--auth-user-pass");
-    /* ** System related ** */
-    errs |=3D check=
_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "--chroot direc=
tory");
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR,=
 options->writepid, R_OK | W_OK,
-                              "--writepid=
");
-
-    /* ** Log related ** */
-    errs |=3D check_file_access(CHKACC_=
DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,
-           =
                   "--status");
-
-    /* ** Config related ** */
-    errs=
 |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->c=
lient_config_dir,
-                                     R_OK | X_OK, "--cli=
ent-config-dir");
-    errs |=3D check_file_access_chroot(options->chroot_d=
ir, CHKACC_FILE, options->tmp_dir,
-                                     R_=
OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
-
-    if (errs)
-   =
 {
-        msg(M_USAGE, "Please correct these errors=2E");
-    }
-}
-#end=
if /* !ENABLE_SMALL */
-
-/*
  * Sanity check on options=2E
  * Also set so=
me options based on other
  * options=2E

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerrit-C=
hange-Number: 1774
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--2BZxPpBJDEc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">options: Factor out file=
 access code from options=2Ec<br><br>options=2Ec is a huge, unwieldly file=
=2E So remove some<br>closely related code that has no direct dependencies<=
br>with the other functions in the file=2E<br><br>This time it is the code =
that checks file accessibility=2E<br><br>Change-Id: I6dafab74b82fbf770c1798=
b4851a0fd5e4b5d81e<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774<br>Message-Id: &=
lt;20260819160522=2E6662-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38535=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/check_f=
ile_access=2Ec<br>A src/openvpn/check_file_access=2Eh<br>M src/openvpn/opti=
ons=2Ec<br>5 files changed, 418 insertions(+), 334 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/74/1774/6</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</s=
pan><br><span>index 9af7870=2E=2E8866520 100644</span><br><span>--- a/CMake=
Lists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -431,=
6 +431,8 @@</span><br><span>     src/openvpn/basic=2Eh</span><br><span>    =
 src/openvpn/buffer=2Ec</span><br><span>     src/openvpn/buffer=2Eh</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_=
access=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/check_file_access=2Eh</span><br><span>     src/openvpn/circ_list=2Eh=
</span><br><span>     src/openvpn/clinat=2Ec</span><br><span>     src/openv=
pn/clinat=2Eh</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/=
openvpn/Makefile=2Eam</span><br><span>index 4220d07=2E=2E42b4404 100644</sp=
an><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/open=
vpn/Makefile=2Eam</span><br><span>@@ -47,6 +47,7 @@</span><br><span> 	base6=
4=2Ec base64=2Eh \</span><br><span> 	basic=2Eh \</span><br><span> 	buffer=
=2Ec buffer=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	c=
heck_file_access=2Ec check_file_access=2Eh \</span><br><span> 	circ_list=2E=
h \</span><br><span> 	clinat=2Ec clinat=2Eh \</span><br><span> 	common=2Eh =
\</span><br><span>diff --git a/src/openvpn/check_file_access=2Ec b/src/open=
vpn/check_file_access=2Ec</span><br><span>new file mode 100644</span><br><s=
pan>index 0000000=2E=2E83654b2</span><br><span>--- /dev/null</span><br><spa=
n>+++ b/src/openvpn/check_file_access=2Ec</span><br><span>@@ -0,0 +1,354 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to sec=
urely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             over a single UDP port, with support for SSL/TLS-based<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessi=
on authentication and key exchange,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet encryption, packet authentication, an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) =
2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2008-2026 David Sommerseth =
&lt;dazo@eurephia=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This =
program is free software; you can redistribute it and/or modify</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the G=
NU General Public License version 2</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope =
that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy o=
f the GNU General Public License along</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=
=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Check file/directory sanity</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Expect peo=
ple using the stripped down version to know what they do */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;check_file_access=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;argv=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;platform=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;ssl_common=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define C=
HKACC_FILE       (1 &lt;&lt; 0) /**&lt; Check for a file/directory presence=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_D=
IRPATH    (1 &lt;&lt; 1) /**&lt; Check for directory presence where a file =
should reside */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine CHKACC_FILEXSTWR  (1 &lt;&lt; 2) /**&lt; If file exists, is it writabl=
e? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC=
_ACPTSTDIN  (1 &lt;&lt; 3) /**&lt; If filename is stdin, it&#39;s allowed a=
nd &quot;exists&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define CHKACC_PRIVATE    (1 &lt;&lt; 4) /**&lt; Warn if this (private=
) file is group/others accessible */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not ch=
eck URIs, unless they start with file: */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check=
_file_access(const int type, const char *file, const int mode, const char *=
opt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int errcode =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* If no file configured, no errors to look f=
or */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!file)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* If stdin is allowed and the file name is &#39;stdin&#39;,=
 then do no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * f=
urther checks as stdin is always available</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if ((type &amp; CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &qu=
ot;stdin&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* file name is a URI if its first segment  =
has &quot;:&quot; (i=2Ee=2E, before any &quot;/&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * Then no checks done if CHKACC_ACC=
EPT_URI is set and the URI does not start with &quot;file:&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if ((type &amp; CHKACC_ACCEPT_URI) &a=
mp;&amp; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!strncmp(file, &quot;file:&quot;, 5))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            file +=3D 5;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else if (!strchr(file, &#39;/&#39;) || strchr(fi=
le, &#39;/&#39;) &gt; strchr(file, &#39;:&#39;))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Is the dire=
ctory path leading to the given file accessible? */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (type &amp; CHKACC_DIRPATH)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        char *fullpath =3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            string_alloc(file, NU=
LL); /* POSIX dirname() implementation may modify its arguments */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const char *dirpath =
=3D dirname(fullpath);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (plat=
form_access(dirpath, mode | X_OK) !=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            errcode =3D errno;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        free(fullpath);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Is the fi=
le itself accessible? */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!errcode &amp;&amp; (type &amp; CHKACC_FILE) &amp;&amp; (platf=
orm_access(file, mode) !=3D 0))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      errcode =3D errno;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* If the file exists an=
d is accessible, is it writable? */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!errcode &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &=
amp;&amp; (platform_access(file, F_OK) =3D=3D 0))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (platform_access(file, W_OK) !=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            errcode =3D errno;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Warn if a given private file is group/others accessible=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (type &amp; CHKAC=
C_PRIVATE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        platform_stat_t=
 st;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (pla=
tform_stat(file, &amp;st))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(M_WARN | M_ERRNO, &quot;WARNING: cannot stat file &#39;%s&#39;=
&quot;, file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (st=2Est_mode &amp; (S=
_IRWXG | S_IRWXO))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         msg(M_WARN, &quot;WARNING: file &#39;%s&#39; is group or others ac=
cessible&quot;, file);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Scream if an error is found */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (errcode &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, &quot;=
%s fails with &#39;%s&#39;&quot;, opt, file);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Return true if an error occurred */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return (errcode !=3D 0 ? true : false);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/** A wrapper for check_file_access() which also takes a chroot director=
y=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If chroot is=
 NULL, behaviour is exactly the same as calling check_file_access() directl=
y,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * otherwise it w=
ill look for the file inside the given chroot directory instead=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_file_access_chroot(const char *chroot, const i=
nt type, const char *file, const int mode,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         const char *opt)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* If no file configured, no errors to look for */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!file)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* If chroot is set, look for the file/directory inside the chroot */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (chroot)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffe=
r chroot_file;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        chroot_file =3D =
prepend_dir(chroot, file, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ret =3D check_file_access(type, BSTR(&amp;chroot_fi=
le), mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* No chroot in play, just c=
all core file check function */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ret =3D check_file_access(type, file, mode, opt);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A wrapper for ch=
eck_file_access_chroot() that returns false immediately if</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * the file is inline (and therefore=
 there is no access to check)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_file_acc=
ess_chroot_inline(bool is_inline, const char *chroot, const int type,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
       const char *file, const int mode, const char *opt)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (is_inline)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return check_file_acce=
ss_chroot(chroot, type, file, mode, opt);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * A wrapper for check_file_acc=
ess() that returns false immediately if the file</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * is inline (and therefore there is no access=
 to check)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+check_file_access_inline(bool is_=
inline, const int type, const char *file, const int mode,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                         const char *=
opt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (is_inline)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return check_file_access(type, file, mode, opt);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_cmd_access(const =
char *command, const char *opt, const char *chroot)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct argv argv;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool return_code;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* If no command was set, there are no errors to look for */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!command)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Extract executable path and arguments */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    argv =3D argv_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    argv_parse_cmd(&amp;argv, command);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* if an executable is specified the=
n check it; otherwise, complain */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (argv=2Eargv[0])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Scripts requires R_OK as well, but that might fail on binar=
ies which</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 only requires X_OK to function on Unix - a scenario not unlikely to</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * be seen on suid=
 binaries=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return_=
code =3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK=
, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_NOPREFIX | M_OPTERR, &quot;%s fails w=
ith &#39;%s&#39;: No path to executable=2E&quot;, opt, command);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return_code =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return return_code;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+options_postprocess_filechecks(struct o=
ptions *options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool errs =3D fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* ** SSL/TLS/crypto related fi=
les ** */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=
=3D check_file_access_inline(options-&gt;dh_file_inline, CHKACC_FILE, optio=
ns-&gt;dh_file, R_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                     &quot;--dh&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!options-&gt;verify_hash_no_ca)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(options=
-&gt;ca_file_inline, CHKACC_FILE, options-&gt;ca_file,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
 R_OK, &quot;--ca&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_ac=
cess_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                  &quot;--capath&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    errs |=3D check_file_access_inline(options-&gt;cert_file_inline, CHKA=
CC_FILE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                     options-&gt;cert_file, R_OK, =
&quot;--cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D chec=
k_file_access_inline(options-&gt;extra_certs_file, CHKACC_FILE,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
      options-&gt;extra_certs_file, R_OK, &quot;--extra-certs&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!(options-&gt;management_flags &amp;=
 MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=
=3D check_file_access_inline(options-&gt;priv_key_file_inline,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
         CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
     options-&gt;priv_key_file, R_OK, &quot;--key&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    errs |=3D check_file_access_inline(options-&gt;pkcs12_file_inline,=
 CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                     options-&gt;pkcs12_file, R_=
OK, &quot;--pkcs12&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opti=
ons-&gt;ssl_flags &amp; SSLF_CRL_VERIFY_DIR)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        errs |=3D check_file_access_chroot(options-&gt;chroot_di=
r, CHKACC_FILE, options-&gt;crl_file,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                         R_OK | X_OK, &qu=
ot;--crl-verify directory&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            check_file_acce=
ss_chroot_inline(options-&gt;crl_file_inline, options-&gt;chroot_dir,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
                   CHKACC_FILE, options-&gt;crl_file, R_OK, &quot;--crl-ver=
ify&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_export_peer_cert_=
dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            check_file_access_c=
hroot(options-&gt;chroot_dir, CHKACC_FILE,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                     options-&gt;tls=
_export_peer_cert_dir, W_OK, &quot;--tls-export-cert&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(options-&gt;connection_list);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; options-&gt;conne=
ction_list-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst struct connection_entry *ce =3D options-&gt;connection_list-&gt;array[=
i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access=
_inline(ce-&gt;tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
             ce-&gt;tls_auth_file, R_OK, &quot;--tls-auth&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_=
access_inline(ce-&gt;tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                    ce-&gt;tls_crypt_file, R_OK, &quot;--tls-crypt&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D ch=
eck_file_access_inline(ce-&gt;tls_crypt_v2_file_inline, CHKACC_FILE | CHKAC=
C_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls=
-crypt-v2&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        check_file_access_inline(options-=
&gt;shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                 o=
ptions-&gt;shared_secret_file, R_OK, &quot;--secret&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKAC=
C_FILEXSTWR, options-&gt;packet_id_file,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              R_OK | W_OK, &quot;--rep=
lay-persist&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** Password =
files ** */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs=
 |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
        options-&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        check_file_access(CHKAC=
C_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                          options-&gt;management_us=
er_pass, R_OK, &quot;--management user/password file&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_fil=
e_access_inline(options-&gt;auth_user_pass_file_inline,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                     CH=
KACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                     options-&gt=
;auth_user_pass_file, R_OK, &quot;--auth-user-pass&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* ** System related ** */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_=
access(CHKACC_FILE, options-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot dir=
ectory&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
rrs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;w=
ritepid, R_OK | W_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              &quot;--writepid&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* ** Log related ** */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_DIRPATH | =
CHKACC_FILEXSTWR, options-&gt;status_file, R_OK | W_OK,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                              &quot;--s=
tatus&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** Config related =
** */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D =
check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;c=
lient_config_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                   R_OK | X_OK, &quot;--client-config-dir&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D=
 check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;=
tmp_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                          R_OK | W_OK | X_OK, &quot;Temporary directory (--=
tmp-dir)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (errs)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Please correct=
 these errors=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* !ENABLE_SMALL */</span><br><span>dif=
f --git a/src/openvpn/check_file_access=2Eh b/src/openvpn/check_file_access=
=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Eb3ed886</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
check_file_access=2Eh</span><br><span>@@ -0,0 +1,60 @@</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             o=
ver a single UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CHECK_FILE_ACCESS=
_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHECK_FIL=
E_ACCESS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;options=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Verifies =
that the path in the &quot;command&quot; that comes after certain script op=
tions (e=2Eg=2E, --up) is a</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * valid file with appropriate permissions=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * &quot;command&quot; consists of a path, optionally foll=
owed by a space, which may be</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * followed by arbitrary arguments=2E It is NOT a full shell comm=
and line -- shell expansion is not</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * performed=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The=
 path and arguments in &quot;command&quot; may be single- or double-quoted =
or escaped=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The path is extracte=
d from &quot;command&quot;, then check_file_access() is called to check it=
=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * arguments=
, if any, are ignored=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Note that=
 the type, mode, and opt arguments to this routine are the same as the corr=
esponding</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * check_f=
ile_access() arguments=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check=
_cmd_access(const char *command, const char *opt, const char *chroot);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Sanity check of all file/dir options=2E  Checks that f=
ile/dir</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is access=
ible by OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void options_postpro=
cess_filechecks(struct options *options);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* !ENABLE_SMALL */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 CHECK_FILE_ACCESS_H */</span><br><span>diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec</span><br><span>index e899fa6=2E=2E317ce44 1006=
44</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/=
openvpn/options=2Ec</span><br><span>@@ -63,6 +63,7 @@</span><br><span> #inc=
lude &quot;tun_afunix=2Eh&quot;</span><br><span> #include &quot;domain_help=
er=2Eh&quot;</span><br><span> #include &quot;mbuf=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;check_file_access=2E=
h&quot;</span><br><span> </span><br><span> #include &lt;ctype=2Eh&gt;</span=
><br><span> </span><br><span>@@ -3328,340 +3329,6 @@</span><br><span> }</sp=
an><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  Check file/directory sanity</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Expect peop=
le using the stripped down version to know what they do */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define CHKACC_FILE       (1 &lt;&lt; 0) /**&lt; Check for a=
 file/directory presence */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define CHKACC_DIRPATH    (1 &lt;&lt; 1) /**&lt; Check for directory =
presence where a file should reside */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define CHKACC_FILEXSTWR  (1 &lt;&lt; 2) /**&lt; If file e=
xists, is it writable? */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define CHKACC_ACPTSTDIN  (1 &lt;&lt; 3) /**&lt; If filename is stdin, =
it&#39;s allowed and &quot;exists&quot; */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define CHKACC_PRIVATE    (1 &lt;&lt; 4) /**&lt; Warn =
if this (private) file is group/others accessible */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /*=
*&lt; Do not check URIs, unless they start with file: */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-check_file_access(const int type, const char *file, const int mode, con=
st char *opt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int errcode =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* If no file configured, no errors to look =
for */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!file)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* If stdin is allowed and the file name is &#39;stdin&#39;, then do no=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * further checks=
 as stdin is always available</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 ((type &amp; CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* file name is a URI if its first segment  has &quot;:&quot; (i=2Ee=2E=
, before any &quot;/&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI do=
es not start with &quot;file:&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&amp; strchr(file, &#39;:&#39;)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (!strncmp(file, &quot;fil=
e:&quot;, 5))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            file +=
=3D 5;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (!strchr(fi=
le, &#39;/&#39;) || strchr(file, &#39;/&#39;) &gt; strchr(file, &#39;:&#39;=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* Is the directory path leading to the given file accessible? */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (type &amp; CHKACC_DI=
RPATH)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        char *fullpath =3D</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            string_alloc(f=
ile, NULL); /* POSIX dirname() implementation may modify its arguments */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *dirpath =
=3D dirname(fullpath);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (platform=
_access(dirpath, mode | X_OK) !=3D 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            errcode =3D errno;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        free(fullpath);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Is the file itself accessib=
le? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!errcod=
e &amp;&amp; (type &amp; CHKACC_FILE) &amp;&amp; (platform_access(file, mod=
e) !=3D 0))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        errcode =3D errno;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* If the file exists and is accessible, is it writabl=
e? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!errcode=
 &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (platform_access(file,=
 F_OK) =3D=3D 0))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (platform=
_access(file, W_OK) !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      errcode =3D errno;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* Warn if a given private file is group/o=
thers accessible=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (type &amp; CHKACC_PRIVATE)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      platform_stat_t st;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (platform_stat(file, &amp;st))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;WARNING: cannot stat fi=
le &#39;%s&#39;&quot;, file);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifn=
def _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (st=2Est_mode &am=
p; (S_IRWXG | S_IRWXO))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          msg(M_WARN, &quot;WARNING: file &#39;%s&#39; is group or others a=
ccessible&quot;, file);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* Scream if an error is found */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (errcode &gt; 0)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, &quot;%s fails with &#3=
9;%s&#39;&quot;, opt, file);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* Return true if an error=
 occurred */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n (errcode !=3D 0 ? true : false);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/* A wrapper for check_file_=
access() which also takes a chroot directory=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * If chroot is NULL, behaviour is exactly the sa=
me as calling check_file_access() directly,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * otherwise it will look for the file inside the giv=
en chroot directory instead=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_file_access_c=
hroot(const char *chroot, const int type, const char *file, const int mode,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
    const char *opt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D fals=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* If no file configured, no errors =
to look for */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* If chroot is set, look for the file/directory inside the chr=
oot */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (chroot)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buf=
fer chroot_file;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        chroot_file =3D pr=
epend_dir(chroot, file, &amp;gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        ret =3D check_file_access(type, BSTR(&amp;chroot_file),=
 mode, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* No chroot in play, just call core file =
check function */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ret =3D check_file_access(type, file, mode, opt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * A wrapper for check_file_access_chroot() that =
returns false immediately if</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * the file is inline (and therefore there is no access to check)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-check_file_access_chroot_inline(bool is_inline, cons=
t char *chroot, const int type,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                const char *file, const int mode,=
 const char *opt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_inline)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn check_file_access_chroot(chroot, type, file, mode, opt);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * A wrapper for c=
heck_file_access() that returns false immediately if the file</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * is inline (and therefore there i=
s no access to check)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-check_file_access_inline(boo=
l is_inline, const int type, const char *file, const int mode,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                         const cha=
r *opt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (is_inline)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return chec=
k_file_access(type, file, mode, opt);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Verifies that the path in the &quot;comm=
and&quot; that comes after certain script options (e=2Eg=2E, --up) is a</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * valid file with approp=
riate permissions=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &quot;command&quo=
t; consists of a path, optionally followed by a space, which may be</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * followed by arbitrary argu=
ments=2E It is NOT a full shell command line -- shell expansion is not</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * performed=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * The path and arguments in &quot;command&quot; ma=
y be single- or double-quoted or escaped=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * The path is extracted from &quot;command&quot;, then check_file_acces=
s() is called to check it=2E The</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * arguments, if any, are ignored=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Note that the type, mode, and opt arguments to this routine are t=
he same as the corresponding</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * check_file_access() arguments=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_c=
md_access(const char *command, const char *opt, const char *chroot)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct argv argv;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    bool return_code;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* If no command was set, there are no errors to look for */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!command)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Ex=
tract executable path and arguments */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    argv =3D argv_new();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    argv_parse_cmd(&amp;argv, command);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* if an executable is specified then check it; otherw=
ise, complain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (argv=2Eargv[0])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Scripts =
requires R_OK as well, but that might fail on binaries which</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-         * only requires X_OK to fun=
ction on Unix - a scenario not unlikely to</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * be seen on suid binaries=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return_code =3D check_file_access_chroo=
t(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NO=
PREFIX | M_OPTERR, &quot;%s fails with &#39;%s&#39;: No path to executable=
=2E&quot;, opt, command);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return_code =3D true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_free(&amp;argv);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return return_code;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Sanity check of all fi=
le/dir options=2E  Checks that file/dir</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * is accessible by OpenVPN</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-opti=
ons_postprocess_filechecks(struct options *options)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool errs =3D false;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 ** SSL/TLS/crypto related files ** */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    errs |=3D check_file_access_inline(options-&gt;dh_file=
_inline, CHKACC_FILE, options-&gt;dh_file, R_OK,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                     &quot;--dh&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;verify_hash_no=
_ca)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file_acce=
ss_inline(options-&gt;ca_file_inline, CHKACC_FILE, options-&gt;ca_file,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                R_OK, &quot;--ca&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D chec=
k_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;ca_pa=
th, R_OK,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                         &quot;--capath&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    errs |=3D check_file_access_inline(options-&gt;cert_file_inline, C=
HKACC_FILE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                     options-&gt;cert_file, R_OK,=
 &quot;--cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_f=
ile_access_inline(options-&gt;extra_certs_file, CHKACC_FILE,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
 options-&gt;extra_certs_file, R_OK, &quot;--extra-certs&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!(options-&gt;management_flags &amp; MF_EXTER=
NAL_KEY))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file=
_access_inline(options-&gt;priv_key_file_inline,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                         CHKACC_=
FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                         options-&gt;p=
riv_key_file, R_OK, &quot;--key&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check=
_file_access_inline(options-&gt;pkcs12_file_inline, CHKACC_FILE | CHKACC_PR=
IVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                      options-&gt;pkcs12_file, R_OK, &quot;--pkcs12&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;ssl_flags &amp; SSLF_C=
RL_VERIFY_DIR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check=
_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;crl_fi=
le,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                       R_OK | X_OK, &quot;--crl-verify directory&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        errs |=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            check_file_access_chroot_inline(options-&gt;crl_file_inline, =
options-&gt;chroot_dir,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                            CHKACC_FILE, options-&gt;crl_=
file, R_OK, &quot;--crl-verify&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;=
tls_export_peer_cert_dir)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        errs=
 |=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            chec=
k_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                     op=
tions-&gt;tls_export_peer_cert_dir, W_OK, &quot;--tls-export-cert&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(options-&gt;connection_list);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; options-&gt;=
connection_list-&gt;len; ++i)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
struct connection_entry *ce =3D options-&gt;connection_list-&gt;array[i];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_inline(=
ce-&gt;tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                      =
   ce-&gt;tls_auth_file, R_OK, &quot;--tls-auth&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_inlin=
e(ce-&gt;tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
      ce-&gt;tls_crypt_file, R_OK, &quot;--tls-crypt&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_=
inline(ce-&gt;tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
              ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    errs |=3D</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        check_file_access_inline(options-&gt;shared_secret_file_inl=
ine, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                 options-&gt;shared_secret_fil=
e, R_OK, &quot;--secret&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=
=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet=
_id_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                  R_OK | W_OK, &quot;--replay-persist&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* ** Password files ** */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_FILE | C=
HKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                              options-&gt;key_pass_file, R_OK, =
&quot;--askpass&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    errs |=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
 options-&gt;management_user_pass, R_OK, &quot;--management user/password f=
ile&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   errs |=3D check_file_access_inline(options-&gt;auth_user_pass_file_inlin=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                  CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
       options-&gt;auth_user_pass_file, R_OK, &quot;--auth-user-pass&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ** System rel=
ated ** */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=
=3D check_file_access(CHKACC_FILE, options-&gt;chroot_dir, R_OK | X_OK, &qu=
ot;--chroot directory&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, =
options-&gt;writepid, R_OK | W_OK,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                              &quot;--writepid&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* ** Log related ** */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_DIRP=
ATH | CHKACC_FILEXSTWR, options-&gt;status_file, R_OK | W_OK,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                              &quot=
;--status&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ** Config related =
** */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D ch=
eck_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;cli=
ent_config_dir,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                               R_OK | X_OK, &quot;--client-config-dir&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check=
_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_di=
r,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                  R_OK | W_OK | X_OK, &quot;Temporary directory (--tmp-dir)=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (errs)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(M_USAGE, &quot;Please correct these errors=2E&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* !ENABLE_SMALL */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span>  * Sanity check on options=2E</span><br><spa=
n>  * Also set some options based on other</span><br><span>  * options=2E</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">change 1774</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6dafab74b82fbf770=
c1798b4851a0fd5e4b5d81e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1774 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--2BZxPpBJDEc=--


--===============6401484371174434649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6401484371174434649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6401484371174434649==--

