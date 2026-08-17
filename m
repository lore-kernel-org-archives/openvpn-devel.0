Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA43FC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xCybpWRj+0pBYDu6wGorXdmr4EqSmQOCVfTn6R2v9Es=; b=aRxIRQ03AFwhfCUM75q1QLJSUi
	489huba6WNtfGXYL9TTYOuwLFSrYG6/IiEBYd7pq1hSVEN5b5750RmtfGRJwEzSj7kt2WrSqwGH1w
	m6n0qmMOTMOzmuGe86f9GHnE6jp7+mZZazXhQihqIpeROBdtxe9p5mFekfesABtYYsD0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvy5u-0007f4-2Z;
	Mon, 17 Aug 2026 14:13:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvy5s-0007ex-NU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tdElDkjQ0/4mY7qkqnnIRQj1pu7737eABvqzvZayriQ=; b=WqKME4g8OYvpAK/1LeeBt1yHRx
 IAQnM4o8E6RLouXlaoV6UW05+1Y+mN7Br+WwOsXOODWCGJLG0w71yNMMAkm05/Y/Qb2bXJGgJi9gF
 tLofebqaCVdhyyAs9dRMWAtZIShUGqf5fbLYbHY1GhU568gHu4Fwgy+JKVMN2cfHZx54=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tdElDkjQ0/4mY7qkqnnIRQj1pu7737eABvqzvZayriQ=; b=c
 xmNCGL3o4AaMl4b9MX63hRUU/FLvEsgj3JrM2+BQUHcRriTbI+xgQrazFuzJqoWhDFSa37BGHXHwo
 0UuBhKAuwAILp2beS9NHjJodXrhA54FMu4ROwyJnu0apBrsVokxgiTUCkbtfXq338zIAqHjpEpZYn
 tO5Iy1hgKRJXwS88=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvy5p-0007yy-Dp for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:13:41 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso24223115e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786976007; x=1787580807; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tdElDkjQ0/4mY7qkqnnIRQj1pu7737eABvqzvZayriQ=;
 b=HtjdElxxFKLhQMFHkPQHO5dJrf98a2ChYLhY+dbcRHcj3dmKigfoKExFGQH5QG5+eX
 rHWPEjOwWEcH+pG8NN5VK2mD6/grUl0ve36gJBAbCUC4d83LNHqgpTGHqC/mmV6EvTi4
 KODiu1/yjXIH6CeMJ/dOBXi1OnWqaX9FPBLp2ZfKAmGaUzVwQhTF3xL4BHU8tZQkrs1L
 Kwlp2JsxoVpj76zIyDLo2FLstHAGuWKB7JPvRsQ0O3Jsot4ph6+TNJAyMqlleiW7KkDx
 sMicst69viL5PTuoQBENOBgqinW2NEquk/7U0pn+p9G6aKcKPRax722ibbWtDEXuU14X
 7T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976007; x=1787580807;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tdElDkjQ0/4mY7qkqnnIRQj1pu7737eABvqzvZayriQ=;
 b=VaWzT9P273AzMtFRDn7dGCjP1uo9lhjACfzFVEgdqpV7OLPTUEA21eWpg/DaKfMeQW
 rRy8HgRF2GNFGzyG5tb3M1OR67h8f26557kFM5oNKqZqxaGY7poqMMD4O+DBCi3sJ6oh
 fNjLvaiutpNid9qgN74vahdIsnk+JBudcO+15mTTd5Y9327dO8mdQVWwIly10jp5103W
 EMgWCnbmsvTd87+/wVoLBe17PmWuzIP9QSHd/mhcdzVbFX6rDbL30A88qbXTDuuB+vBy
 pH3rgwKbvyF3KhXLJVHlovrSvxuwnXjVXmqd0/2t9Y2m4wk4yGAzuW32tv4zIc7286ya
 sddw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnxQsOI9po4YlLmk8WVsofVAUtISKZRY4LOEST88uDQ6+LX3It13fehyusdysPy/x5juvRoUl8hsiVYlb/@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyLg5yW1pnyAEGgoHtdpovth3q8XUK20fkfLKWkmtC3IjYa8eko
 QC0zJ+t0UK16QmbdUdtISb4fNijAf9bNZ88KQivsjE6t58H0LPpfwuZVLpAhK9n5PtEfhJnIJb1
 ohoixVtY0aHyn1MV9cOxUV/vjFYF6TFIjMCsLNw2GEbQA5/yHihd5mMU81j0UqQTdWTuB
X-Gm-Gg: AR+sD137F6DYgHbBY3PybwzBMWobqYGyWiXfkcFGmrH116SzzGGtJxBe6LX66a1iT0O
 HqqJC84U6liiuo6145B+ktIXDvFrEXW8gbK5qTMQPSP2EABBZw5Y5SuFGlx8zeitor5iAHTfNyb
 JxVUlTRrlAgf9dGaj7cop+df1SWEQi90YS1lPV18cT29aUtXrxZzvvPgQrurEgI3ZTBred+B1ou
 F1oqOvuok6Vh3UbV/QbtASkuV04RFDhEwxYHhsyjZSHybSRsxPyLFvp6oOYfJLS+mjD+A+wodWG
 58D7pabFnjYnkpi7bauW4RyaVxFm8InMQlCypp7qQ7z8KJFm/YIynlph1QicjAlOHnY+jfObfvf
 AdZ/56ONphkAvKr0VosXEsrjTg+jb0X5Q/gtl5lz5AWXMatAPjFaEbCjDnvxmlO94w5bvMN2p3V
 xnRXIM7p8rKXbIcKGG8R5mv4K+iB1D6CkZ+PPwyrsMUu6CU2QYr6mXdSkr1fUw75unFW522Ri1Y
 D1kEplBmhx8xx+6uyRVMAaW2xOwmuqZF53zVkOIH1nh3FBOsL2TZsHS5dMfitk9fwx3NtNT1TnQ
 nGDywjWhn441/domzmreFnDBniGlGMeH3SGTUueZM4K2vrBmm8k=
X-Received: by 2002:a05:600c:19ca:b0:499:7ce1:d8a2 with SMTP id
 5b1f17b1804b1-499879426e9mr324945495e9.8.1786976006610; 
 Mon, 17 Aug 2026 07:13:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c568sm4403702f8f.18.2026.08.17.07.13.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:13:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:13:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: d5d0abe957c657b7bb21aa21e063358af4ba5112
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c1319b4602c008fa6e36af7f86f8b8147892850-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvy5p-0007yy-Dp
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2368414287383781258=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2368414287383781258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3BnVzR2cB7c="; charset=UTF-8

--3BnVzR2cB7c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail

to look at the new patch set=
 (#4)=2E


Change subject: options: Factor out file access code from option=
s=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options=
: Factor out file access code from options=2Ec

options=2Ec is a huge, unwi=
eldly file=2E So remove some
closely related code that has no direct depend=
encies
with the other functions in the file=2E

This time it is the code th=
at checks file accessibility=2E

Change-Id: I6dafab74b82fbf770c1798b4851a0f=
d5e4b5d81e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M=
 CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/check_file_acce=
ss=2Ec
A src/openvpn/check_file_access=2Eh
M src/openvpn/options=2Ec
5 file=
s changed, 418 insertions(+), 334 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/74/1774/4

diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt
index 0b07718=2E=2E2b0adff 100644
--- a/CMakeList=
s=2Etxt
+++ b/CMakeLists=2Etxt
@@ -431,6 +431,8 @@
     src/openvpn/basic=
=2Eh
     src/openvpn/buffer=2Ec
     src/openvpn/buffer=2Eh
+    src/openv=
pn/check_file_access=2Ec
+    src/openvpn/check_file_access=2Eh
     src/op=
envpn/circ_list=2Eh
     src/openvpn/clinat=2Ec
     src/openvpn/clinat=2Eh=

diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 4=
650ddd=2E=2E182d732 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvp=
n/Makefile=2Eam
@@ -47,6 +47,7 @@
 	base64=2Ec base64=2Eh \
 	basic=2Eh \
 =
	buffer=2Ec buffer=2Eh \
+	check_file_access=2Ec check_file_access=2Eh \
 	=
circ_list=2Eh \
 	clinat=2Ec clinat=2Eh \
 	common=2Eh \
diff --git a/src/o=
penvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec
new file m=
ode 100644
index 0000000=2E=2E665ae34
--- /dev/null
+++ b/src/openvpn/check=
_file_access=2Ec
@@ -0,0 +1,374 @@
+/*
+ *  OpenVPN -- An application to se=
curely tunnel IP networks
+ *             over a single UDP port, with supp=
ort for SSL/TLS-based
+ *             session authentication and key exchan=
ge,
+ *             packet encryption, packet authentication, and
+ *      =
       packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <=
sales@openvpn=2Enet>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@eu=
rephia=2Eorg>
+ *
+ *  This program is free software; you can redistribute =
it and/or modify
+ *  it under the terms of the GNU General Public License =
version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Thi=
s program is distributed in the hope that it will be useful,
+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lic=
ense for more details=2E
+ *
+ *  You should have received a copy of the GN=
U General Public License along
+ *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*
+ *  Check file/directory sanity
=
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+/* Expect =
people using the stripped down version to know what they do */
+#ifndef ENA=
BLE_SMALL
+
+#include "syshead=2Eh"
+
+#include "check_file_access=2Eh"
+
+=
#include "argv=2Eh"
+#include "buffer=2Eh"
+#include "error=2Eh"
+#include =
"options=2Eh"
+#include "platform=2Eh"
+#include "ssl_common=2Eh"
+
+#inclu=
de <string=2Eh>
+
+#define CHKACC_FILE       (1 << 0) /**< Check for a file=
/directory presence */
+#define CHKACC_DIRPATH    (1 << 1) /**< Check for d=
irectory presence where a file should reside */
+#define CHKACC_FILEXSTWR  =
(1 << 2) /**< If file exists, is it writable? */
+#define CHKACC_ACPTSTDIN =
 (1 << 3) /**< If filename is stdin, it's allowed and "exists" */
+#define =
CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private) file is group/others=
 accessible */
+#define CHKACC_ACCEPT_URI (1 << 5) /**< Do not check URIs, =
unless they start with file: */
+
+static bool
+check_file_access(const int=
 type, const char *file, const int mode, const char *opt)
+{
+    int errco=
de =3D 0;
+
+    /* If no file configured, no errors to look for */
+    if=
 (!file)
+    {
+        return false;
+    }
+
+    /* If stdin is allowed=
 and the file name is 'stdin', then do no
+     * further checks as stdin i=
s always available
+     */
+    if ((type & CHKACC_ACPTSTDIN) && streq(fil=
e, "stdin"))
+    {
+        return false;
+    }
+
+    /* file name is a =
URI if its first segment  has ":" (i=2Ee=2E, before any "/")
+     * Then n=
o checks done if CHKACC_ACCEPT_URI is set and the URI does not start with "=
file:"
+     */
+    if ((type & CHKACC_ACCEPT_URI) && strchr(file, ':'))
+=
    {
+        if (!strncmp(file, "file:", 5))
+        {
+            file=
 +=3D 5;
+        }
+        else if (!strchr(file, '/') || strchr(file, '/=
') > strchr(file, ':'))
+        {
+            return false;
+        }
+ =
   }
+
+    /* Is the directory path leading to the given file accessible? =
*/
+    if (type & CHKACC_DIRPATH)
+    {
+        char *fullpath =3D
+    =
        string_alloc(file, NULL); /* POSIX dirname() implementation may mod=
ify its arguments */
+        const char *dirpath =3D dirname(fullpath);
+
=
+        if (platform_access(dirpath, mode | X_OK) !=3D 0)
+        {
+    =
        errcode =3D errno;
+        }
+        free(fullpath);
+    }
+
+  =
  /* Is the file itself accessible? */
+    if (!errcode && (type & CHKACC_=
FILE) && (platform_access(file, mode) !=3D 0))
+    {
+        errcode =3D =
errno;
+    }
+
+    /* If the file exists and is accessible, is it writabl=
e? */
+    if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access(fi=
le, F_OK) =3D=3D 0))
+    {
+        if (platform_access(file, W_OK) !=3D 0=
)
+        {
+            errcode =3D errno;
+        }
+    }
+
+    /* Wa=
rn if a given private file is group/others accessible=2E */
+    if (type &=
 CHKACC_PRIVATE)
+    {
+        platform_stat_t st;
+        if (platform_=
stat(file, &st))
+        {
+            msg(M_WARN | M_ERRNO, "WARNING: ca=
nnot stat file '%s'", file);
+        }
+#ifndef _WIN32
+        else
+    =
    {
+            if (st=2Est_mode & (S_IRWXG | S_IRWXO))
+            {
+=
                msg(M_WARN, "WARNING: file '%s' is group or others accessib=
le", file);
+            }
+        }
+#endif
+    }
+
+    /* Scream if an=
 error is found */
+    if (errcode > 0)
+    {
+        msg(M_NOPREFIX | M=
_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
+    }
+
+    /* Retur=
n true if an error occurred */
+    return (errcode !=3D 0 ? true : false);=

+}
+
+/** A wrapper for check_file_access() which also takes a chroot dire=
ctory=2E
+ * If chroot is NULL, behaviour is exactly the same as calling ch=
eck_file_access() directly,
+ * otherwise it will look for the file inside =
the given chroot directory instead=2E
+ */
+static bool
+check_file_access_=
chroot(const char *chroot, const int type, const char *file, const int mode=
,
+                         const char *opt)
+{
+    bool ret =3D false;
+
=
+    /* If no file configured, no errors to look for */
+    if (!file)
+  =
  {
+        return false;
+    }
+
+    /* If chroot is set, look for the =
file/directory inside the chroot */
+    if (chroot)
+    {
+        struct=
 gc_arena gc =3D gc_new();
+        struct buffer chroot_file;
+
+        c=
hroot_file =3D prepend_dir(chroot, file, &gc);
+        ret =3D check_file_=
access(type, BSTR(&chroot_file), mode, opt);
+        gc_free(&gc);
+    }
=
+    else
+    {
+        /* No chroot in play, just call core file check f=
unction */
+        ret =3D check_file_access(type, file, mode, opt);
+    =
}
+    return ret;
+}
+
+/**
+ * A wrapper for check_file_access_chroot() t=
hat returns false immediately if
+ * the file is inline (and therefore ther=
e is no access to check)
+ */
+static bool
+check_file_access_chroot_inline=
(bool is_inline, const char *chroot, const int type,
+                     =
           const char *file, const int mode, const char *opt)
+{
+    if (i=
s_inline)
+    {
+        return false;
+    }
+
+    return check_file_acc=
ess_chroot(chroot, type, file, mode, opt);
+}
+
+/**
+ * A wrapper for chec=
k_file_access() that returns false immediately if the file
+ * is inline (a=
nd therefore there is no access to check)
+ */
+static bool
+check_file_acc=
ess_inline(bool is_inline, const int type, const char *file, const int mode=
,
+                         const char *opt)
+{
+    if (is_inline)
+    {
=
+        return false;
+    }
+
+    return check_file_access(type, file, m=
ode, opt);
+}
+
+/**
+ * Verifies that the path in the "command" that comes=
 after certain script options (e=2Eg=2E, --up) is a
+ * valid file with app=
ropriate permissions=2E
+ *
+ * "command" consists of a path, optionally fo=
llowed by a space, which may be
+ * followed by arbitrary arguments=2E It i=
s NOT a full shell command line -- shell expansion is not
+ * performed=2E
=
+ *
+ * The path and arguments in "command" may be single- or double-quoted=
 or escaped=2E
+ *
+ * The path is extracted from "command", then check_fil=
e_access() is called to check it=2E The
+ * arguments, if any, are ignored=
=2E
+ *
+ * Note that the type, mode, and opt arguments to this routine are=
 the same as the corresponding
+ * check_file_access() arguments=2E
+ */
+b=
ool
+check_cmd_access(const char *command, const char *opt, const char *chr=
oot)
+{
+    struct argv argv;
+    bool return_code;
+
+    /* If no comma=
nd was set, there are no errors to look for */
+    if (!command)
+    {
+ =
       return false;
+    }
+
+    /* Extract executable path and arguments=
 */
+    argv =3D argv_new();
+    argv_parse_cmd(&argv, command);
+
+    /=
* if an executable is specified then check it; otherwise, complain */
+    =
if (argv=2Eargv[0])
+    {
+        /* Scripts requires R_OK as well, but t=
hat might fail on binaries which
+         * only requires X_OK to function=
 on Unix - a scenario not unlikely to
+         * be seen on suid binaries=
=2E
+         */
+        return_code =3D check_file_access_chroot(chroot, =
CHKACC_FILE, argv=2Eargv[0], X_OK, opt);
+    }
+    else
+    {
+        m=
sg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No path to executable=2E", o=
pt, command);
+        return_code =3D true;
+    }
+
+    argv_free(&argv)=
;
+
+    return return_code;
+}
+
+/**
+ * Sanity check of all file/dir opt=
ions=2E  Checks that file/dir
+ * is accessible by OpenVPN
+ */
+void
+opti=
ons_postprocess_filechecks(struct options *options)
+{
+    bool errs =3D f=
alse;
+
+    /* ** SSL/TLS/crypto related files ** */
+    errs |=3D check_=
file_access_inline(options->dh_file_inline, CHKACC_FILE, options->dh_file, =
R_OK,
+                                     "--dh");
+
+    if (!options->v=
erify_hash_no_ca)
+    {
+        errs |=3D check_file_access_inline(option=
s->ca_file_inline, CHKACC_FILE, options->ca_file,
+                        =
                 R_OK, "--ca");
+    }
+
+    errs |=3D check_file_access_c=
hroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK,
+          =
                           "--capath");
+
+    errs |=3D check_file_access_=
inline(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
+       =
                              options->cert_file, R_OK, "--cert");
+
+    e=
rrs |=3D check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
+=
                                     options->extra_certs_file, R_OK, "--ex=
tra-certs");
+
+    if (!(options->management_flags & MF_EXTERNAL_KEY))
+  =
  {
+        errs |=3D check_file_access_inline(options->priv_key_file_inli=
ne,
+                                         CHKACC_FILE | CHKACC_PRIVATE =
| CHKACC_ACCEPT_URI,
+                                         options->pri=
v_key_file, R_OK, "--key");
+    }
+
+    errs |=3D check_file_access_inlin=
e(options->pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+             =
                        options->pkcs12_file, R_OK, "--pkcs12");
+
+    if =
(options->ssl_flags & SSLF_CRL_VERIFY_DIR)
+    {
+        errs |=3D check_=
file_access_chroot(options->chroot_dir, CHKACC_FILE, options->crl_file,
+  =
                                       R_OK | X_OK, "--crl-verify directory=
");
+    }
+    else
+    {
+        errs |=3D
+            check_file_acce=
ss_chroot_inline(options->crl_file_inline, options->chroot_dir,
+          =
                                  CHKACC_FILE, options->crl_file, R_OK, "--=
crl-verify");
+    }
+
+    if (options->tls_export_peer_cert_dir)
+    {
+=
        errs |=3D
+            check_file_access_chroot(options->chroot_dir=
, CHKACC_FILE,
+                                     options->tls_export_pe=
er_cert_dir, W_OK, "--tls-export-cert");
+    }
+
+    ASSERT(options->conn=
ection_list);
+    for (int i =3D 0; i < options->connection_list->len; ++i=
)
+    {
+        const struct connection_entry *ce =3D options->connection=
_list->array[i];
+
+        errs |=3D check_file_access_inline(ce->tls_auth=
_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                              =
           ce->tls_auth_file, R_OK, "--tls-auth");
+        errs |=3D check=
_file_access_inline(ce->tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE=
,
+                                         ce->tls_crypt_file, R_OK, "--tl=
s-crypt");
+        errs |=3D check_file_access_inline(ce->tls_crypt_v2_fil=
e_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                                  =
       ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
+    }
+
+    errs |=
=3D
+        check_file_access_inline(options->shared_secret_file_inline, C=
HKACC_FILE | CHKACC_PRIVATE,
+                                 options->sha=
red_secret_file, R_OK, "--secret");
+
+    errs |=3D check_file_access(CHKA=
CC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
+                  =
            R_OK | W_OK, "--replay-persist");
+
+    /* ** Password files *=
* */
+    errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKA=
CC_PRIVATE,
+                              options->key_pass_file, R_OK, "-=
-askpass");
+#ifdef ENABLE_MANAGEMENT
+    errs |=3D
+        check_file_ac=
cess(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                    =
      options->management_user_pass, R_OK, "--management user/password file=
");
+#endif /* ENABLE_MANAGEMENT */
+    errs |=3D check_file_access_inline=
(options->auth_user_pass_file_inline,
+                                    =
 CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                        =
             options->auth_user_pass_file, R_OK, "--auth-user-pass");
+    =
/* ** System related ** */
+    errs |=3D check_file_access(CHKACC_FILE, op=
tions->chroot_dir, R_OK | X_OK, "--chroot directory");
+    errs |=3D check=
_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid, R_OK | W=
_OK,
+                              "--writepid");
+
+    /* ** Log related=
 ** */
+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, =
options->status_file, R_OK | W_OK,
+                              "--status=
");
+
+    /* ** Config related ** */
+    errs |=3D check_file_access_chro=
ot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
+         =
                            R_OK | X_OK, "--client-config-dir");
+    errs =
|=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tm=
p_dir,
+                                     R_OK | W_OK | X_OK, "Temporary=
 directory (--tmp-dir)");
+
+    if (errs)
+    {
+        msg(M_USAGE, "Pl=
ease correct these errors=2E");
+    }
+}
+
+#endif /* !ENABLE_SMALL */
dif=
f --git a/src/openvpn/check_file_access=2Eh b/src/openvpn/check_file_access=
=2Eh
new file mode 100644
index 0000000=2E=2E2152ef9
--- /dev/null
+++ b/sr=
c/openvpn/check_file_access=2Eh
@@ -0,0 +1,40 @@
+/*
+ *  OpenVPN -- An app=
lication to securely tunnel IP networks
+ *             over a single UDP p=
ort, with support for SSL/TLS-based
+ *             session authentication =
and key exchange,
+ *             packet encryption, packet authentication,=
 and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026=
 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; =
you can redistribute it and/or modify
+ *  it under the terms of the GNU Ge=
neral Public License version 2
+ *  as published by the Free Software Found=
ation=2E
+ *
+ *  This program is distributed in the hope that it will be u=
seful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  G=
NU General Public License for more details=2E
+ *
+ *  You should have rece=
ived a copy of the GNU General Public License along
+ *  with this program;=
 if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef CHECK_F=
ILE_ACCESS_H
+#define CHECK_FILE_ACCESS_H
+
+#ifdef HAVE_CONFIG_H
+#include=
 "config=2Eh"
+#endif
+
+#ifndef ENABLE_SMALL
+
+#include "options=2Eh"
+
+=
bool check_cmd_access(const char *command, const char *opt, const char *chr=
oot);
+
+void options_postprocess_filechecks(struct options *options);
+
+#=
endif /* !ENABLE_SMALL */
+
+#endif /* CHECK_FILE_ACCESS_H */
diff --git a/=
src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index f5163d6=2E=2E9f060e=
3 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -63=
,6 +63,7 @@
 #include "tun_afunix=2Eh"
 #include "domain_helper=2Eh"
 #incl=
ude "mbuf=2Eh"
+#include "check_file_access=2Eh"
 
 #include <ctype=2Eh>
 
=
@@ -3328,340 +3329,6 @@
 }
 
 /*
- *  Check file/directory sanity
- *
- */
=
-/* Expect people using the stripped down version to know what they do */
-=
#ifndef ENABLE_SMALL
-
-#define CHKACC_FILE       (1 << 0) /**< Check for a=
 file/directory presence */
-#define CHKACC_DIRPATH    (1 << 1) /**< Check =
for directory presence where a file should reside */
-#define CHKACC_FILEXS=
TWR  (1 << 2) /**< If file exists, is it writable? */
-#define CHKACC_ACPTS=
TDIN  (1 << 3) /**< If filename is stdin, it's allowed and "exists" */
-#de=
fine CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private) file is group/o=
thers accessible */
-#define CHKACC_ACCEPT_URI (1 << 5) /**< Do not check U=
RIs, unless they start with file: */
-
-static bool
-check_file_access(cons=
t int type, const char *file, const int mode, const char *opt)
-{
-    int =
errcode =3D 0;
-
-    /* If no file configured, no errors to look for */
- =
   if (!file)
-    {
-        return false;
-    }
-
-    /* If stdin is al=
lowed and the file name is 'stdin', then do no
-     * further checks as st=
din is always available
-     */
-    if ((type & CHKACC_ACPTSTDIN) && stre=
q(file, "stdin"))
-    {
-        return false;
-    }
-
-    /* file name =
is a URI if its first segment  has ":" (i=2Ee=2E, before any "/")
-     * T=
hen no checks done if CHKACC_ACCEPT_URI is set and the URI does not start w=
ith "file:"
-     */
-    if ((type & CHKACC_ACCEPT_URI) && strchr(file, ':=
'))
-    {
-        if (!strncmp(file, "file:", 5))
-        {
-           =
 file +=3D 5;
-        }
-        else if (!strchr(file, '/') || strchr(fil=
e, '/') > strchr(file, ':'))
-        {
-            return false;
-       =
 }
-    }
-
-    /* Is the directory path leading to the given file accessi=
ble? */
-    if (type & CHKACC_DIRPATH)
-    {
-        char *fullpath =3D
=
-            string_alloc(file, NULL); /* POSIX dirname() implementation ma=
y modify its arguments */
-        char *dirpath =3D dirname(fullpath);
-
-=
        if (platform_access(dirpath, mode | X_OK) !=3D 0)
-        {
-     =
       errcode =3D errno;
-        }
-        free(fullpath);
-    }
-
-   =
 /* Is the file itself accessible? */
-    if (!errcode && (type & CHKACC_F=
ILE) && (platform_access(file, mode) !=3D 0))
-    {
-        errcode =3D e=
rrno;
-    }
-
-    /* If the file exists and is accessible, is it writable=
? */
-    if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access(fil=
e, F_OK) =3D=3D 0))
-    {
-        if (platform_access(file, W_OK) !=3D 0)=

-        {
-            errcode =3D errno;
-        }
-    }
-
-    /* War=
n if a given private file is group/others accessible=2E */
-    if (type & =
CHKACC_PRIVATE)
-    {
-        platform_stat_t st;
-        if (platform_s=
tat(file, &st))
-        {
-            msg(M_WARN | M_ERRNO, "WARNING: can=
not stat file '%s'", file);
-        }
-#ifndef _WIN32
-        else
-     =
   {
-            if (st=2Est_mode & (S_IRWXG | S_IRWXO))
-            {
- =
               msg(M_WARN, "WARNING: file '%s' is group or others accessibl=
e", file);
-            }
-        }
-#endif
-    }
-
-    /* Scream if an =
error is found */
-    if (errcode > 0)
-    {
-        msg(M_NOPREFIX | M_=
OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
-    }
-
-    /* Return=
 true if an error occurred */
-    return (errcode !=3D 0 ? true : false);
=
-}
-
-/* A wrapper for check_file_access() which also takes a chroot direct=
ory=2E
- * If chroot is NULL, behaviour is exactly the same as calling chec=
k_file_access() directly,
- * otherwise it will look for the file inside th=
e given chroot directory instead=2E
- */
-static bool
-check_file_access_ch=
root(const char *chroot, const int type, const char *file, const int mode,
=
-                         const char *opt)
-{
-    bool ret =3D false;
-
- =
   /* If no file configured, no errors to look for */
-    if (!file)
-    =
{
-        return false;
-    }
-
-    /* If chroot is set, look for the fi=
le/directory inside the chroot */
-    if (chroot)
-    {
-        struct g=
c_arena gc =3D gc_new();
-        struct buffer chroot_file;
-
-        chr=
oot_file =3D prepend_dir(chroot, file, &gc);
-        ret =3D check_file_ac=
cess(type, BSTR(&chroot_file), mode, opt);
-        gc_free(&gc);
-    }
- =
   else
-    {
-        /* No chroot in play, just call core file check fun=
ction */
-        ret =3D check_file_access(type, file, mode, opt);
-    }
=
-    return ret;
-}
-
-/**
- * A wrapper for check_file_access_chroot() tha=
t returns false immediately if
- * the file is inline (and therefore there =
is no access to check)
- */
-static bool
-check_file_access_chroot_inline(b=
ool is_inline, const char *chroot, const int type,
-                       =
         const char *file, const int mode, const char *opt)
-{
-    if (is_=
inline)
-    {
-        return false;
-    }
-
-    return check_file_acces=
s_chroot(chroot, type, file, mode, opt);
-}
-
-/**
- * A wrapper for check_=
file_access() that returns false immediately if the file
- * is inline (and=
 therefore there is no access to check)
- */
-static bool
-check_file_acces=
s_inline(bool is_inline, const int type, const char *file, const int mode,
=
-                         const char *opt)
-{
-    if (is_inline)
-    {
- =
       return false;
-    }
-
-    return check_file_access(type, file, mod=
e, opt);
-}
-
-/*
- * Verifies that the path in the "command" that comes af=
ter certain script options (e=2Eg=2E, --up) is a
- * valid file with approp=
riate permissions=2E
- *
- * "command" consists of a path, optionally follo=
wed by a space, which may be
- * followed by arbitrary arguments=2E It is N=
OT a full shell command line -- shell expansion is not
- * performed=2E
- *=

- * The path and arguments in "command" may be single- or double-quoted or=
 escaped=2E
- *
- * The path is extracted from "command", then check_file_a=
ccess() is called to check it=2E The
- * arguments, if any, are ignored=2E
=
- *
- * Note that the type, mode, and opt arguments to this routine are the=
 same as the corresponding
- * check_file_access() arguments=2E
- */
-stati=
c bool
-check_cmd_access(const char *command, const char *opt, const char *=
chroot)
-{
-    struct argv argv;
-    bool return_code;
-
-    /* If no co=
mmand was set, there are no errors to look for */
-    if (!command)
-    {=

-        return false;
-    }
-
-    /* Extract executable path and argume=
nts */
-    argv =3D argv_new();
-    argv_parse_cmd(&argv, command);
-
-  =
  /* if an executable is specified then check it; otherwise, complain */
- =
   if (argv=2Eargv[0])
-    {
-        /* Scripts requires R_OK as well, bu=
t that might fail on binaries which
-         * only requires X_OK to funct=
ion on Unix - a scenario not unlikely to
-         * be seen on suid binari=
es=2E
-         */
-        return_code =3D check_file_access_chroot(chroot=
, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);
-    }
-    else
-    {
-       =
 msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No path to executable=2E",=
 opt, command);
-        return_code =3D true;
-    }
-
-    argv_free(&arg=
v);
-
-    return return_code;
-}
-
-/*
- * Sanity check of all file/dir op=
tions=2E  Checks that file/dir
- * is accessible by OpenVPN
- */
-static vo=
id
-options_postprocess_filechecks(struct options *options)
-{
-    bool er=
rs =3D false;
-
-    /* ** SSL/TLS/crypto related files ** */
-    errs |=
=3D check_file_access_inline(options->dh_file_inline, CHKACC_FILE, options-=
>dh_file, R_OK,
-                                     "--dh");
-
-    if (!=
options->verify_hash_no_ca)
-    {
-        errs |=3D check_file_access_inl=
ine(options->ca_file_inline, CHKACC_FILE, options->ca_file,
-              =
                           R_OK, "--ca");
-    }
-
-    errs |=3D check_fil=
e_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK,
-=
                                     "--capath");
-
-    errs |=3D check_fi=
le_access_inline(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI=
,
-                                     options->cert_file, R_OK, "--cert")=
;
-
-    errs |=3D check_file_access_inline(options->extra_certs_file, CHKA=
CC_FILE,
-                                     options->extra_certs_file, R=
_OK, "--extra-certs");
-
-    if (!(options->management_flags & MF_EXTERNAL=
_KEY))
-    {
-        errs |=3D check_file_access_inline(options->priv_key=
_file_inline,
-                                         CHKACC_FILE | CHKAC=
C_PRIVATE | CHKACC_ACCEPT_URI,
-                                         op=
tions->priv_key_file, R_OK, "--key");
-    }
-
-    errs |=3D check_file_ac=
cess_inline(options->pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-   =
                                  options->pkcs12_file, R_OK, "--pkcs12");
=
-
-    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-    {
-        errs |=
=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->crl=
_file,
-                                         R_OK | X_OK, "--crl-verify=
 directory");
-    }
-    else
-    {
-        errs |=3D
-            check=
_file_access_chroot_inline(options->crl_file_inline, options->chroot_dir,
-=
                                            CHKACC_FILE, options->crl_file,=
 R_OK, "--crl-verify");
-    }
-
-    if (options->tls_export_peer_cert_dir=
)
-    {
-        errs |=3D
-            check_file_access_chroot(options->=
chroot_dir, CHKACC_FILE,
-                                     options->tls=
_export_peer_cert_dir, W_OK, "--tls-export-cert");
-    }
-
-    ASSERT(opt=
ions->connection_list);
-    for (int i =3D 0; i < options->connection_list=
->len; ++i)
-    {
-        struct connection_entry *ce =3D options->connec=
tion_list->array[i];
-
-        errs |=3D check_file_access_inline(ce->tls_=
auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                          =
               ce->tls_auth_file, R_OK, "--tls-auth");
-        errs |=3D c=
heck_file_access_inline(ce->tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRI=
VATE,
-                                         ce->tls_crypt_file, R_OK, "=
--tls-crypt");
-        errs |=3D check_file_access_inline(ce->tls_crypt_v2=
_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                              =
           ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
-    }
-
-    er=
rs |=3D
-        check_file_access_inline(options->shared_secret_file_inlin=
e, CHKACC_FILE | CHKACC_PRIVATE,
-                                 options-=
>shared_secret_file, R_OK, "--secret");
-
-    errs |=3D check_file_access(=
CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
-              =
                R_OK | W_OK, "--replay-persist");
-
-    /* ** Password fil=
es ** */
-    errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | =
CHKACC_PRIVATE,
-                              options->key_pass_file, R_OK=
, "--askpass");
-#ifdef ENABLE_MANAGEMENT
-    errs |=3D
-        check_fil=
e_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                =
          options->management_user_pass, R_OK, "--management user/password =
file");
-#endif /* ENABLE_MANAGEMENT */
-    errs |=3D check_file_access_in=
line(options->auth_user_pass_file_inline,
-                                =
     CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                    =
                 options->auth_user_pass_file, R_OK, "--auth-user-pass");
-=
    /* ** System related ** */
-    errs |=3D check_file_access(CHKACC_FILE=
, options->chroot_dir, R_OK | X_OK, "--chroot directory");
-    errs |=3D c=
heck_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid, R_OK=
 | W_OK,
-                              "--writepid");
-
-    /* ** Log rel=
ated ** */
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXST=
WR, options->status_file, R_OK | W_OK,
-                              "--st=
atus");
-
-    /* ** Config related ** */
-    errs |=3D check_file_access_=
chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
-     =
                                R_OK | X_OK, "--client-config-dir");
-    e=
rrs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options=
->tmp_dir,
-                                     R_OK | W_OK | X_OK, "Tempo=
rary directory (--tmp-dir)");
-
-    if (errs)
-    {
-        msg(M_USAGE,=
 "Please correct these errors=2E");
-    }
-}
-#endif /* !ENABLE_SMALL */
-=

-/*
  * Sanity check on options=2E
  * Also set some options based on othe=
r
  * options=2E

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1774?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerrit-Change-Number: 1774
Gerrit=
-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: razvanc <razvanc@mailbox=2Eorg>

--3BnVzR2cB7c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">options: Factor out file access code from options=2Ec<br><br>options=
=2Ec is a huge, unwieldly file=2E So remove some<br>closely related code th=
at has no direct dependencies<br>with the other functions in the file=2E<br=
><br>This time it is the code that checks file accessibility=2E<br><br>Chan=
ge-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M=
 src/openvpn/Makefile=2Eam<br>A src/openvpn/check_file_access=2Ec<br>A src/=
openvpn/check_file_access=2Eh<br>M src/openvpn/options=2Ec<br>5 files chang=
ed, 418 insertions(+), 334 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/4</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 0b07=
718=2E=2E2b0adff 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><s=
pan>+++ b/CMakeLists=2Etxt</span><br><span>@@ -431,6 +431,8 @@</span><br><s=
pan>     src/openvpn/basic=2Eh</span><br><span>     src/openvpn/buffer=2Ec<=
/span><br><span>     src/openvpn/buffer=2Eh</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=
=2Eh</span><br><span>     src/openvpn/circ_list=2Eh</span><br><span>     sr=
c/openvpn/clinat=2Ec</span><br><span>     src/openvpn/clinat=2Eh</span><br>=
<span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</s=
pan><br><span>index 4650ddd=2E=2E182d732 100644</span><br><span>--- a/src/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span>=
<br><span>@@ -47,6 +47,7 @@</span><br><span> 	base64=2Ec base64=2Eh \</span=
><br><span> 	basic=2Eh \</span><br><span> 	buffer=2Ec buffer=2Eh \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	check_file_access=2Ec check=
_file_access=2Eh \</span><br><span> 	circ_list=2Eh \</span><br><span> 	clin=
at=2Ec clinat=2Eh \</span><br><span> 	common=2Eh \</span><br><span>diff --g=
it a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec<=
/span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E665=
ae34</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/check_=
file_access=2Ec</span><br><span>@@ -0,0 +1,374 @@</span><br><span style=3D"=
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
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Expect people using the stripped dow=
n version to know what they do */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;check_file_access=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;argv=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_co=
mmon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILE       (1 &lt;&l=
t; 0) /**&lt; Check for a file/directory presence */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_DIRPATH    (1 &lt;&lt; 1) =
/**&lt; Check for directory presence where a file should reside */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILEXSTWR  (1=
 &lt;&lt; 2) /**&lt; If file exists, is it writable? */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN  (1 &lt;&lt; 3=
) /**&lt; If filename is stdin, it&#39;s allowed and &quot;exists&quot; */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_PRIVA=
TE    (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is group/others ac=
cessible */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless they sta=
rt with file: */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+check_file_access(const int ty=
pe, const char *file, const int mode, const char *opt)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int errcode =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* If no file configured, no errors to look for */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!file)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If stdi=
n is allowed and the file name is &#39;stdin&#39;, then do no</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * further checks as stdin is=
 always available</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((type =
&amp; CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
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
><br><span style=3D"color: hsl(120, 100%, 40%);">+/** A wrapper for check_f=
ile_access() which also takes a chroot directory=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * If chroot is NULL, behaviour is exactl=
y the same as calling check_file_access() directly,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * otherwise it will look for the file in=
side the given chroot directory instead=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
heck_file_access_chroot(const char *chroot, const int type, const char *fil=
e, const int mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        const char *opt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If no=
 file configured, no errors to look for */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!file)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If chroot is set, lo=
ok for the file/directory inside the chroot */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (chroot)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer chroot_file;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        chroot_file =3D prepend_dir(chroot, file,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
et =3D check_file_access(type, BSTR(&amp;chroot_file), mode, opt);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* No chroot in play, just call core file check funct=
ion */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =
=3D check_file_access(type, file, mode, opt);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * A wrapper for check_file_access_chroot() t=
hat returns false immediately if</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * the file is inline (and therefore there is no access to che=
ck)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+check_file_access_chroot_inline(bool is_=
inline, const char *chroot, const int type,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                const char *file, c=
onst int mode, const char *opt)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return check_file_access_chroot(chroot, type, fi=
le, mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * A wrapper for check_file_access() that returns false i=
mmediately if the file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * is inline (and therefore there is no access to check)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+check_file_access_inline(bool is_inline, const int type, co=
nst char *file, const int mode,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         const char *opt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (is_inline)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return check_file_access(t=
ype, file, mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Verifies that the path in the &quot;command&quo=
t; that comes after certain script options (e=2Eg=2E, --up) is a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * valid file with appropriate=
 permissions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * &quot;command&quot=
; consists of a path, optionally followed by a space, which may be</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * followed by arbitrary arg=
uments=2E It is NOT a full shell command line -- shell expansion is not</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * performed=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * The path and arguments in &quot;command&q=
uot; may be single- or double-quoted or escaped=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * The path is extracted from &quot;command&quot;, then check=
_file_access() is called to check it=2E The</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * arguments, if any, are ignored=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Note that the type, mode, and opt arguments to t=
his routine are the same as the corresponding</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * check_file_access() arguments=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_cmd_access(const char *command, const char *opt, const cha=
r *chroot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool return_code;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* If no command was set, there are n=
o errors to look for */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!command)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Extract executable path and argume=
nts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv =3D =
argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv=
_parse_cmd(&amp;argv, command);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
if an executable is specified then check it; otherwise, complain */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (argv=2Eargv[0])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* Scripts requires R_OK as w=
ell, but that might fail on binaries which</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * only requires X_OK to function on Unix - =
a scenario not unlikely to</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * be seen on suid binaries=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return_code =3D check_file_access_chroot(chroot, =
CHKACC_FILE, argv=2Eargv[0], X_OK, opt);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NOPR=
EFIX | M_OPTERR, &quot;%s fails with &#39;%s&#39;: No path to executable=2E=
&quot;, opt, command);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return_code =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;a=
rgv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return return_code;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sani=
ty check of all file/dir options=2E  Checks that file/dir</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * is accessible by OpenVPN</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+options_postprocess_filechecks(struct options *options)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool errs =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* ** SSL/TLS/crypto related files ** */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acces=
s_inline(options-&gt;dh_file_inline, CHKACC_FILE, options-&gt;dh_file, R_OK=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                   &quot;--dh&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!options-&gt;verify_hash_no_ca)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        errs |=3D check_file_access_inline(options-&gt;ca_file_inline,=
 CHKACC_FILE, options-&gt;ca_file,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                         R_OK, &quot;--ca&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(options-=
&gt;chroot_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                     &q=
uot;--capath&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D chec=
k_file_access_inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_ACC=
EPT_URI,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                          options-&gt;cert_file, R_OK, &quot;--cert&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline=
(options-&gt;extra_certs_file, CHKACC_FILE,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                     options-&gt;ex=
tra_certs_file, R_OK, &quot;--extra-certs&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access=
_inline(options-&gt;priv_key_file_inline,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                         CHKACC_FILE =
| CHKACC_PRIVATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                         options-&gt;priv=
_key_file, R_OK, &quot;--key&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D ch=
eck_file_access_inline(options-&gt;pkcs12_file_inline, CHKACC_FILE | CHKACC=
_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                           options-&gt;pkcs12_file, R_OK, &quot;--pkcs12&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;ssl_flags &am=
p; SSLF_CRL_VERIFY_DIR)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        er=
rs |=3D check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, optio=
ns-&gt;crl_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                      R_OK | X_OK, &quot;--crl-verify direc=
tory&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        errs |=3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            check_file_access_chroot_inline(opti=
ons-&gt;crl_file_inline, options-&gt;chroot_dir,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                            CH=
KACC_FILE, options-&gt;crl_file, R_OK, &quot;--crl-verify&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (options-&gt;tls_export_peer_cert_dir)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        errs |=3D</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            check_file_access_chroot(options-&gt;c=
hroot_dir, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                     options-&gt;tls_export_peer_cert_d=
ir, W_OK, &quot;--tls-export-cert&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
options-&gt;connection_list);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 0; i &lt; options-&gt;connection_list-&gt;len;=
 ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const struct connect=
ion_entry *ce =3D options-&gt;connection_list-&gt;array[i];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;tls_=
auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                         ce-&gt=
;tls_auth_file, R_OK, &quot;--tls-auth&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(ce-&g=
t;tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
 ce-&gt;tls_crypt_file, R_OK, &quot;--tls-crypt&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inl=
ine(ce-&gt;tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
             ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    errs |=3D</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        check_file_access_inline(options-&gt;shared_secret_f=
ile_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                 options-&gt;shared_s=
ecret_file, R_OK, &quot;--secret&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, option=
s-&gt;packet_id_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              R_OK | W_OK, &quot;--replay-persist&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* ** Password files ** */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_ac=
cess(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              options-&gt=
;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    errs |=3D</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        check_file_access(CHKACC_FILE | CHKACC_ACP=
TSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                          options-&gt;management_user_pass, R_OK, &quo=
t;--management user/password file&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(op=
tions-&gt;auth_user_pass_file_inline,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                     CHKACC_FILE | CHKACC=
_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                     options-&gt;auth_user_pass_fi=
le, R_OK, &quot;--auth-user-pass&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* ** System related ** */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_FI=
LE, options-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot directory&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_f=
ile_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, R_OK | =
W_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                &quot;--writepid&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* ** Log related ** */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR=
, options-&gt;status_file, R_OK | W_OK,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                              &quot;--status&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* ** Config related ** */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acces=
s_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                   R_OK | X_OK, &quot;--client-config-dir&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acce=
ss_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
          R_OK | W_OK | X_OK, &quot;Temporary directory (--tmp-dir)&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (errs)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_USAGE, &quot;Please correct these errors=2E&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* !ENABLE_SMALL */</span><br><span>diff --git a/src/ope=
nvpn/check_file_access=2Eh b/src/openvpn/check_file_access=2Eh</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E2152ef9</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/check_file_access=
=2Eh</span><br><span>@@ -0,0 +1,40 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifndef CHECK_FILE_ACCESS_H</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define CHECK_FILE_ACCESS_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_cmd_a=
ccess(const char *command, const char *opt, const char *chroot);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void options_postprocess_filechecks(struct option=
s *options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !ENABLE_SMALL */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* CHECK_FILE_ACCESS_H */</span=
><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</=
span><br><span>index f5163d6=2E=2E9f060e3 100644</span><br><span>--- a/src/=
openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br=
><span>@@ -63,6 +63,7 @@</span><br><span> #include &quot;tun_afunix=2Eh&quo=
t;</span><br><span> #include &quot;domain_helper=2Eh&quot;</span><br><span>=
 #include &quot;mbuf=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;check_file_access=2Eh&quot;</span><br><span> </sp=
an><br><span> #include &lt;ctype=2Eh&gt;</span><br><span> </span><br><span>=
@@ -3328,340 +3329,6 @@</span><br><span> }</span><br><span> </span><br><spa=
n> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Check file/d=
irectory sanity</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* Expect people using the stripped down ve=
rsion to know what they do */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC=
_FILE       (1 &lt;&lt; 0) /**&lt; Check for a file/directory presence */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_DIRPATH =
   (1 &lt;&lt; 1) /**&lt; Check for directory presence where a file should =
reside */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKA=
CC_FILEXSTWR  (1 &lt;&lt; 2) /**&lt; If file exists, is it writable? */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_ACPTSTDIN =
 (1 &lt;&lt; 3) /**&lt; If filename is stdin, it&#39;s allowed and &quot;ex=
ists&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
CHKACC_PRIVATE    (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is gro=
up/others accessible */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unles=
s they start with file: */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-check_file_access(const in=
t type, const char *file, const int mode, const char *opt)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int errcode =3D 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* If no file configured, no errors to look for */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!file)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If stdin is allowed a=
nd the file name is &#39;stdin&#39;, then do no</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * further checks as stdin is always availabl=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_ACPTSTD=
IN) &amp;&amp; streq(file, &quot;stdin&quot;))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* file name is a URI if=
 its first segment  has &quot;:&quot; (i=2Ee=2E, before any &quot;/&quot;)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * Then no checks =
done if CHKACC_ACCEPT_URI is set and the URI does not start with &quot;file=
:&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_A=
CCEPT_URI) &amp;&amp; strchr(file, &#39;:&#39;))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!strncmp(file, &quot;file:&quot;, 5))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            file +=3D 5;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else if (!strchr(file, &#39;/&#39;) || strchr(f=
ile, &#39;/&#39;) &gt; strchr(file, &#39;:&#39;))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return false;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Is the directory path =
leading to the given file accessible? */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (type &amp; CHKACC_DIRPATH)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        char *fullpath =3D</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            string_alloc(file, NULL); /* POSIX dirname=
() implementation may modify its arguments */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        char *dirpath =3D dirname(fullpath);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (platform_access(dirpath, mode | X_OK)=
 !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            errcode =3D e=
rrno;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        free(fullpath);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* Is the file itself accessible? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHK=
ACC_FILE) &amp;&amp; (platform_access(file, mode) !=3D 0))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        errcode =3D errno;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If t=
he file exists and is accessible, is it writable? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHK=
ACC_FILEXSTWR) &amp;&amp; (platform_access(file, F_OK) =3D=3D 0))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (platform_access(file, W_OK) !=3D 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            errcode =3D errno;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* Warn if a given private file is group/others accessible=2E */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (type &amp; CHKACC_=
PRIVATE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        platform_stat_t st;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (platform_st=
at(file, &amp;st))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(M_WARN | M_ERRNO, &quot;WARNING: cannot stat file &#39;%s&#39;&quot;, file=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (st=2Est_mode &amp; (S_IRWXG | S_IRWXO))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot=
;WARNING: file &#39;%s&#39; is group or others accessible&quot;, file);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Scream if an =
error is found */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (errcode &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NOPR=
EFIX | M_OPTERR | M_ERRNO, &quot;%s fails with &#39;%s&#39;&quot;, opt, fil=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Return true if an error occurred */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return (errcode !=3D 0 ? true =
: false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* A wrapper for check_file_access() which also takes=
 a chroot directory=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * If chroot is NULL, behaviour is exactly the same as calling check_file_=
access() directly,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
otherwise it will look for the file inside the given chroot directory inste=
ad=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-check_file_access_chroot(const char *chroot=
, const int type, const char *file, const int mode,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         const char *opt)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* If no file configured, no errors to look for */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!file)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If chro=
ot is set, look for the file/directory inside the chroot */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (chroot)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        struct buffer chroot_file;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        chroot_file =3D prepend_dir(chroot, file=
, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
t =3D check_file_access(type, BSTR(&amp;chroot_file), mode, opt);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* No chroot in play, just call core file check function */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D check_file=
_access(type, file, mode, opt);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * A wrapper for check_file_access_chroot() that returns false immediat=
ely if</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the file is =
inline (and therefore there is no access to check)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-check_file_access_chroot_inline(bool is_inline, const char *chroot, const =
int type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                    const char *file, const int mode, const char *opt)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (is_inline)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return check_file_acces=
s_chroot(chroot, type, file, mode, opt);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * A wrapper for check_file_access() tha=
t returns false immediately if the file</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * is inline (and therefore there is no access to check)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-check_file_access_inline(bool is_inline, const int=
 type, const char *file, const int mode,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                         const char *opt)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (is_inline)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return check_file_access(type, fi=
le, mode, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Verifies that the path in the &quot;command&quot; that comes af=
ter certain script options (e=2Eg=2E, --up) is a</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * valid file with appropriate permissions=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * &quot;command&quot; consists of a path, =
optionally followed by a space, which may be</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * followed by arbitrary arguments=2E It is NOT a fu=
ll shell command line -- shell expansion is not</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * performed=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * The path and arguments in &quot;command&quot; may be single- or double-=
quoted or escaped=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The path is extra=
cted from &quot;command&quot;, then check_file_access() is called to check =
it=2E The</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * arguments=
, if any, are ignored=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Note that the=
 type, mode, and opt arguments to this routine are the same as the correspo=
nding</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * check_file_ac=
cess() arguments=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-check_cmd_access(const char *c=
ommand, const char *opt, const char *chroot)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct argv argv;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    bool return_code;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If no comma=
nd was set, there are no errors to look for */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!command)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* Extract executable path a=
nd arguments */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ar=
gv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 argv_parse_cmd(&amp;argv, command);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 if an executable is specified then check it; otherwise, complain */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (argv=2Eargv[0])</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Scripts requires R_OK as well, =
but that might fail on binaries which</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         * only requires X_OK to function on Unix - a scena=
rio not unlikely to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       * be seen on suid binaries=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return_code =3D check_file_access_chroot(chroot, CHKACC_FILE, =
argv=2Eargv[0], X_OK, opt);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        msg(M_NOPREFIX | M_OPTERR, &quo=
t;%s fails with &#39;%s&#39;: No path to executable=2E&quot;, opt, command)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return_code =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    argv_free(&amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return return_code;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Sanity check of all file/dir options=2E  Che=
cks that file/dir</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * i=
s accessible by OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-options_postprocess_filech=
ecks(struct options *options)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool err=
s =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /* ** SSL/TLS/crypto relat=
ed files ** */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err=
s |=3D check_file_access_inline(options-&gt;dh_file_inline, CHKACC_FILE, op=
tions-&gt;dh_file, R_OK,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     &quot;--dh&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!options-&gt;verify_hash_no_ca)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        errs |=3D check_file_access_inline(options-&gt;ca=
_file_inline, CHKACC_FILE, options-&gt;ca_file,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                         R_OK, &q=
uot;--ca&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(opt=
ions-&gt;chroot_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
 &quot;--capath&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check=
_file_access_inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_ACCE=
PT_URI,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                       options-&gt;cert_file, R_OK, &quot;--cert&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_inline(opti=
ons-&gt;extra_certs_file, CHKACC_FILE,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                     options-&gt;extra_cer=
ts_file, R_OK, &quot;--extra-certs&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_inline(options=
-&gt;priv_key_file_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                         CHKACC_FILE | CHKACC_PRIVATE =
| CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                        options-&gt;priv_key_file, R_OK, &q=
uot;--key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_inline(op=
tions-&gt;pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
options-&gt;pkcs12_file, R_OK, &quot;--pkcs12&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (options-&gt;ssl_flags &amp; SSLF_CRL_VERIFY_DIR)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_chroot(=
options-&gt;chroot_dir, CHKACC_FILE, options-&gt;crl_file,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                      =
   R_OK | X_OK, &quot;--crl-verify directory&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        errs =
|=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            check=
_file_access_chroot_inline(options-&gt;crl_file_inline, options-&gt;chroot_=
dir,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                           CHKACC_FILE, options-&gt;crl_file, R_OK, &quot;-=
-crl-verify&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_export_peer_cer=
t_dir)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            check_file_access_chroo=
t(options-&gt;chroot_dir, CHKACC_FILE,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                     options-&gt;tls_expor=
t_peer_cert_dir, W_OK, &quot;--tls-export-cert&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(options-&gt;connection_list);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    for (int i =3D 0; i &lt; options-&gt;connection_list-&gt=
;len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct connection_e=
ntry *ce =3D options-&gt;connection_list-&gt;array[i];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        errs |=3D check_file_access_inline(ce-&gt;tls_auth_file=
_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                         ce-&gt;tls_auth_f=
ile, R_OK, &quot;--tls-auth&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        errs |=3D check_file_access_inline(ce-&gt;tls_crypt_f=
ile_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                         ce-&gt;tls_cry=
pt_file, R_OK, &quot;--tls-crypt&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        errs |=3D check_file_access_inline(ce-&gt;tls_cr=
ypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                         ce-&gt=
;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
errs |=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        chec=
k_file_access_inline(options-&gt;shared_secret_file_inline, CHKACC_FILE | C=
HKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                          options-&gt;shared_secret_file, R_OK, &quot;--sec=
ret&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access=
(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                              R_O=
K | W_OK, &quot;--replay-persist&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  /* ** Password files ** */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHK=
ACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                     options-&gt;key_pass_file, R_OK, &quot;--askpass&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAG=
EMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_file_acces=
s(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                          options-&gt;manageme=
nt_user_pass, R_OK, &quot;--management user/password file&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_MANAGEMENT */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_fi=
le_access_inline(options-&gt;auth_user_pass_file_inline,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                     CHK=
ACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                     options-&gt;au=
th_user_pass_file, R_OK, &quot;--auth-user-pass&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* ** System related ** */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(=
CHKACC_FILE, options-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot directory&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D =
check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, =
R_OK | W_OK,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                     &quot;--writepid&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* ** Log related ** */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR,=
 options-&gt;status_file, R_OK | W_OK,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                              &quot;--status&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* ** Config related ** */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(=
options-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
        R_OK | X_OK, &quot;--client-config-dir&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(opt=
ions-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                     R_OK =
| W_OK | X_OK, &quot;Temporary directory (--tmp-dir)&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (errs)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(M_USAGE, &quot;Please correct these errors=2E&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif /* !ENABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><=
span>  * Sanity check on options=2E</span><br><span>  * Also set some optio=
ns based on other</span><br><span>  * options=2E</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1774?usp=3Demail">change 1774</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1774?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1774 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>

</body></html>
--3BnVzR2cB7c=--


--===============2368414287383781258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2368414287383781258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2368414287383781258==--

