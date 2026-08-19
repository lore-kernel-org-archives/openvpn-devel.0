Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9D1C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OdfbPIwIafbO3oe3wPnlmkUTVsLNTtq9zBpmWhjBjtY=; b=jsL6dC5sjAmEnH75WKxKs/dhXc
	NY3HQVKkjeX5G/cSyFg20ksVqAyu6V5abBXsmaLqWpokYhGzGIN8ionslzUCkVh2oeF4jDzK9cOxQ
	GIEtp85ZqJD8tfDlSZrHr09R9jPh/UrnQTRkv0emmlTnK5I+GEywtL/hVVJ54s9CqKpE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwnWx-0001tI-Di;
	Wed, 19 Aug 2026 21:09:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwnWw-0001tC-9i
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:09:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=B4LX/g1EEOnDWbQICgNHNNYSjmTjevs+9/FSVH4TuFU=; b=fXtJr6Y5lHSV5OsNVI9q18Lv7R
 c7/HOGUI8ZsothNmz3DXpxGDNJD23XLzjQNUUjT67eyhEQasbV44bGZsvUj7Kv1px+1FpLRIr++vL
 BcPP0l9jewtdWsJx3K31JjmgYAynGO1c+EHQu42/Xl0XHyw35v/CIAngbmo4gb4zYIx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=B4LX/g1EEOnDWbQICgNHNNYSjmTjevs+9/FSVH4TuFU=; b=b
 kqLZNPi/zceop5qiodKu1k/gcl+NoV+QV6llDb5MIlP+Lmv48Yab0Foq5UaFVraRzvgf5k352WsQr
 6W13pD35c2ad6fuftDZLjQ9ChmLaUZwDxntf0LrDtDKcm36tclle/pzsDrZ6eximEy4bffVH6Bl6q
 3vMRIAAc0N+TG/yA=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwnWs-00007i-LS for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 21:09:02 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so976028f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787173732; x=1787778532; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B4LX/g1EEOnDWbQICgNHNNYSjmTjevs+9/FSVH4TuFU=;
 b=QZIhaG/ou1HomAMvE60J1Au4IvDzYZBZPtUzJnm/NOl9zOxhVBuQOGejWypjz+4+MB
 m+JRewad33cUwLK1739Q7oZa9jHZzaXwrCLEgwembN52XcEyyelpgqibLMu5UG1su8CE
 hBWlQfCzBjh1V1k1xQzInT6uTRMLjZsUH66xvSh85ybaqh17ujaerlz1NsOqDIHfGudL
 vt7PhuTkOND7nHf8xz7m7NsoA648SbgI7C0jaul/xhbuTV0cPPD/cZnfh9+cmZUVnePu
 gB3qgrY28SU01P8A6YciH9Ao+o8F6X2zoUhkUMvtwYUCuxG1TX3SRJ8cDvAtKfUkPkFB
 cSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787173732; x=1787778532;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B4LX/g1EEOnDWbQICgNHNNYSjmTjevs+9/FSVH4TuFU=;
 b=K+f1WlUq9oUMLEh93ArEFQIapeNMOxvHxrvC2BrHMLCjuU56rAnxWfi+9XeZf4ren4
 jv9qutRTa/d6aLUs63N4u/MGm/QOAYfdB5U4WokOI4dmqgMP1NqDobwly4FmeS5mScxr
 AV8eTtuCkDOaSWiXAgYU8lHhAsq4JrriShP5VXjfrDGJgW7IRDWHVtCkXYgSUqwXDDgP
 mnBIOFeSUNk12wCCQtTl/OPFYlVMjqpAZuixgcj6K5h0SpB2urKPRhpljRQJYcHWcyg8
 bkAIhb4SczPxwKFKqhzRXl6d7V3QrxKfVbVJevdp2SKue9A2Jb1yCQbGATnEMJvPm5xd
 O0bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoInbWiFjEfJjWSIXkpGqQZ2R1dpGNt475Z2So1gcyZvpkKD1QjRsbGjurfwFAfK/E8cxHitwDoT6BBBh9x@lists.sourceforge.net
X-Gm-Message-State: AFuF++nYl2bYS87neqEeBFfXBdBVHoOLdODSmqlmQ56jWc5Q2704+oz7
 fd27xB1hyRDQdPpnnY34eDdQgEPDBQin+goikDAEibdLPVp3sR/KHUE7IF31sAj7WHY1SJXsAlp
 A8TSDWIH022JsYQRvWwsaJputFfkrPxhNTUevKnq1ZkhKseQ0q06ttvMzDFlEA6WXfpzrknYG20
 U4PW20Gg==
X-Gm-Gg: AR+sD11afwcUDm+6SgqPHhX+35RKknyEFgtYbxq5ekmBKEXLWyrgedcV/Q80WXxFnt5
 1phMxFDxMYr/W8807Nj98NRwiGmLpIl+V6Dg4CxdW2qrMDVjzNtlyouLFibJPwkzJ7gNkcdvpv2
 t/R9JQatfx4vy1tdoIVWK0buUHj8HIqzZj5Q72Em8c+jpdZ+A0Our1XYbc8uZaTxIpmuN1YNxcx
 zzGhYqGl7HwdYxuM3hOUEVJ4/zv+nCYJfMy72QMyAqpsYr2N0d9Kd1VmYdkw/NEPkdP+Hs/m+Gq
 T0fydjXlhptq3Y6zEYy7sqxSCQOedae/5nwanO53hg67RUSDBNGesNlQAGeHTxr3RS8P73rLR4r
 dfA7mwh0BFQduapepjJlO7a/gbGKHbTjAPgtiMCBCGTRqPTeSjW9hEZbh++xfDqeQv+yoqrtlkU
 LlEMeCb7rrgwZirSuoDZ4OBi92a8A+Igv0+PHk+J3SSqBxdMHYkYkT6b8ikGYJSvhqpPwXyp+lc
 oAmT8i3/7kXwf6b6CVwu5wOGhWfbC9c8rAKCbpClvm7fjuETcz1b10eqnKmC68dTD/By/eViITX
 bs+3kCAiqXfEOrDk1MmalcwBGzsPIvcSCId8OCuse0hglWhRMTc=
X-Received: by 2002:a05:6000:4012:b0:47f:4fa9:ae42 with SMTP id
 ffacd0b85a97d-482b1fd3990mr12515536f8f.11.1787173731714; 
 Wed, 19 Aug 2026 14:08:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c45d1sm6775749f8f.30.2026.08.19.14.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 14:08:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 21:08:50 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: 6334d3d188437ea392faac4ed3283b61e7a51e54
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d01bdb3d196575e3f619a39aaa05719220f4c27-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwnWs-00007i-LS
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0514050821110048673=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0514050821110048673==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BuNoNyQvwrs="; charset=UTF-8

--BuNoNyQvwrs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1774?usp=3Demail )

Change subject: options: Factor out file access cod=
e from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

options: Factor out file access code from options=2Ec

options=2Ec =
is a huge, unwieldly file=2E So remove some
closely related code that has n=
o direct dependencies
with the other functions in the file=2E

This time it=
 is the code that checks file accessibility=2E

Change-Id: I6dafab74b82fbf7=
70c1798b4851a0fd5e4b5d81e
Signed-off-by: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774
Message-Id: <20260819160522=2E=
6662-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg38535=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=
=2Eam
A src/openvpn/check_file_access=2Ec
A src/openvpn/check_file_access=
=2Eh
M src/openvpn/options=2Ec
5 files changed, 418 insertions(+), 334 dele=
tions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 9af7870=
=2E=2E8866520 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -431,=
6 +431,8 @@
     src/openvpn/basic=2Eh
     src/openvpn/buffer=2Ec
     src=
/openvpn/buffer=2Eh
+    src/openvpn/check_file_access=2Ec
+    src/openvpn=
/check_file_access=2Eh
     src/openvpn/circ_list=2Eh
     src/openvpn/clin=
at=2Ec
     src/openvpn/clinat=2Eh
diff --git a/src/openvpn/Makefile=2Eam b=
/src/openvpn/Makefile=2Eam
index 4220d07=2E=2E42b4404 100644
--- a/src/open=
vpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -47,6 +47,7 @@
 	base6=
4=2Ec base64=2Eh \
 	basic=2Eh \
 	buffer=2Ec buffer=2Eh \
+	check_file_acc=
ess=2Ec check_file_access=2Eh \
 	circ_list=2Eh \
 	clinat=2Ec clinat=2Eh \=

 	common=2Eh \
diff --git a/src/openvpn/check_file_access=2Ec b/src/openvp=
n/check_file_access=2Ec
new file mode 100644
index 0000000=2E=2E83654b2
---=
 /dev/null
+++ b/src/openvpn/check_file_access=2Ec
@@ -0,0 +1,354 @@
+/*
+ =
*  OpenVPN -- An application to securely tunnel IP networks
+ *            =
 over a single UDP port, with support for SSL/TLS-based
+ *             ses=
sion authentication and key exchange,
+ *             packet encryption, pa=
cket authentication, and
+ *             packet compression=2E
+ *
+ *  Cop=
yright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2=
008-2026 David Sommerseth <dazo@eurephia=2Eorg>
+ *
+ *  This program is fr=
ee software; you can redistribute it and/or modify
+ *  it under the terms =
of the GNU General Public License version 2
+ *  as published by the Free S=
oftware Foundation=2E
+ *
+ *  This program is distributed in the hope that=
 it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  S=
ee the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sho=
uld have received a copy of the GNU General Public License along
+ *  with =
this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*=

+ *  Check file/directory sanity
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include =
"config=2Eh"
+#endif
+
+/* Expect people using the stripped down version to=
 know what they do */
+#ifndef ENABLE_SMALL
+
+#include "syshead=2Eh"
+
+#i=
nclude "check_file_access=2Eh"
+
+#include "argv=2Eh"
+#include "buffer=2Eh=
"
+#include "error=2Eh"
+#include "options=2Eh"
+#include "platform=2Eh"
+#=
include "ssl_common=2Eh"
+
+#include <string=2Eh>
+
+#define CHKACC_FILE   =
    (1 << 0) /**< Check for a file/directory presence */
+#define CHKACC_DI=
RPATH    (1 << 1) /**< Check for directory presence where a file should res=
ide */
+#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writa=
ble? */
+#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's=
 allowed and "exists" */
+#define CHKACC_PRIVATE    (1 << 4) /**< Warn if t=
his (private) file is group/others accessible */
+#define CHKACC_ACCEPT_URI=
 (1 << 5) /**< Do not check URIs, unless they start with file: */
+
+static=
 bool
+check_file_access(const int type, const char *file, const int mode, =
const char *opt)
+{
+    int errcode =3D 0;
+
+    /* If no file configured=
, no errors to look for */
+    if (!file)
+    {
+        return false;
+ =
   }
+
+    /* If stdin is allowed and the file name is 'stdin', then do no=

+     * further checks as stdin is always available
+     */
+    if ((typ=
e & CHKACC_ACPTSTDIN) && streq(file, "stdin"))
+    {
+        return false=
;
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
+/** A wrapper for check_file_acc=
ess() which also takes a chroot directory=2E
+ * If chroot is NULL, behavio=
ur is exactly the same as calling check_file_access() directly,
+ * otherwi=
se it will look for the file inside the given chroot directory instead=2E
+=
 */
+static bool
+check_file_access_chroot(const char *chroot, const int ty=
pe, const char *file, const int mode,
+                         const char =
*opt)
+{
+    bool ret =3D false;
+
+    /* If no file configured, no error=
s to look for */
+    if (!file)
+    {
+        return false;
+    }
+
+  =
  /* If chroot is set, look for the file/directory inside the chroot */
+  =
  if (chroot)
+    {
+        struct gc_arena gc =3D gc_new();
+        str=
uct buffer chroot_file;
+
+        chroot_file =3D prepend_dir(chroot, file=
, &gc);
+        ret =3D check_file_access(type, BSTR(&chroot_file), mode, =
opt);
+        gc_free(&gc);
+    }
+    else
+    {
+        /* No chroot =
in play, just call core file check function */
+        ret =3D check_file_=
access(type, file, mode, opt);
+    }
+    return ret;
+}
+
+/**
+ * A wrap=
per for check_file_access_chroot() that returns false immediately if
+ * th=
e file is inline (and therefore there is no access to check)
+ */
+static b=
ool
+check_file_access_chroot_inline(bool is_inline, const char *chroot, co=
nst int type,
+                                const char *file, const int =
mode, const char *opt)
+{
+    if (is_inline)
+    {
+        return false;=

+    }
+
+    return check_file_access_chroot(chroot, type, file, mode, op=
t);
+}
+
+/**
+ * A wrapper for check_file_access() that returns false imme=
diately if the file
+ * is inline (and therefore there is no access to chec=
k)
+ */
+static bool
+check_file_access_inline(bool is_inline, const int ty=
pe, const char *file, const int mode,
+                         const char =
*opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+    re=
turn check_file_access(type, file, mode, opt);
+}
+
+bool
+check_cmd_access=
(const char *command, const char *opt, const char *chroot)
+{
+    struct a=
rgv argv;
+    bool return_code;
+
+    /* If no command was set, there are=
 no errors to look for */
+    if (!command)
+    {
+        return false;
=
+    }
+
+    /* Extract executable path and arguments */
+    argv =3D arg=
v_new();
+    argv_parse_cmd(&argv, command);
+
+    /* if an executable is=
 specified then check it; otherwise, complain */
+    if (argv=2Eargv[0])
+=
    {
+        /* Scripts requires R_OK as well, but that might fail on bin=
aries which
+         * only requires X_OK to function on Unix - a scenario=
 not unlikely to
+         * be seen on suid binaries=2E
+         */
+    =
    return_code =3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Ear=
gv[0], X_OK, opt);
+    }
+    else
+    {
+        msg(M_NOPREFIX | M_OPTE=
RR, "%s fails with '%s': No path to executable=2E", opt, command);
+       =
 return_code =3D true;
+    }
+
+    argv_free(&argv);
+
+    return return=
_code;
+}
+
+void
+options_postprocess_filechecks(struct options *options)
=
+{
+    bool errs =3D false;
+
+    /* ** SSL/TLS/crypto related files ** *=
/
+    errs |=3D check_file_access_inline(options->dh_file_inline, CHKACC_F=
ILE, options->dh_file, R_OK,
+                                     "--dh");=

+
+    if (!options->verify_hash_no_ca)
+    {
+        errs |=3D check_fi=
le_access_inline(options->ca_file_inline, CHKACC_FILE, options->ca_file,
+ =
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
index 0000000=2E=2Eb3ed886=

--- /dev/null
+++ b/src/openvpn/check_file_access=2Eh
@@ -0,0 +1,60 @@
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
+#ifdef =
HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef ENABLE_SMALL
+
+#in=
clude "options=2Eh"
+
+/**
+ * Verifies that the path in the "command" that=
 comes after certain script options (e=2Eg=2E, --up) is a
+ * valid file wi=
th appropriate permissions=2E
+ *
+ * "command" consists of a path, optiona=
lly followed by a space, which may be
+ * followed by arbitrary arguments=
=2E It is NOT a full shell command line -- shell expansion is not
+ * perfo=
rmed=2E
+ *
+ * The path and arguments in "command" may be single- or doubl=
e-quoted or escaped=2E
+ *
+ * The path is extracted from "command", then c=
heck_file_access() is called to check it=2E The
+ * arguments, if any, are =
ignored=2E
+ *
+ * Note that the type, mode, and opt arguments to this rout=
ine are the same as the corresponding
+ * check_file_access() arguments=2E
=
+ */
+bool check_cmd_access(const char *command, const char *opt, const cha=
r *chroot);
+
+/**
+ * Sanity check of all file/dir options=2E  Checks that=
 file/dir
+ * is accessible by OpenVPN
+ */
+void options_postprocess_filec=
hecks(struct options *options);
+
+#endif /* !ENABLE_SMALL */
+
+#endif /* =
CHECK_FILE_ACCESS_H */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/o=
ptions=2Ec
index e899fa6=2E=2E317ce44 100644
--- a/src/openvpn/options=2Ec
=
+++ b/src/openvpn/options=2Ec
@@ -63,6 +63,7 @@
 #include "tun_afunix=2Eh"
=
 #include "domain_helper=2Eh"
 #include "mbuf=2Eh"
+#include "check_file_ac=
cess=2Eh"
 
 #include <ctype=2Eh>
 
@@ -3328,340 +3329,6 @@
 }
 
 /*
- *  C=
heck file/directory sanity
- *
- */
-/* Expect people using the stripped do=
wn version to know what they do */
-#ifndef ENABLE_SMALL
-
-#define CHKACC_=
FILE       (1 << 0) /**< Check for a file/directory presence */
-#define CH=
KACC_DIRPATH    (1 << 1) /**< Check for directory presence where a file sho=
uld reside */
-#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is i=
t writable? */
-#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdi=
n, it's allowed and "exists" */
-#define CHKACC_PRIVATE    (1 << 4) /**< Wa=
rn if this (private) file is group/others accessible */
-#define CHKACC_ACC=
EPT_URI (1 << 5) /**< Do not check URIs, unless they start with file: */
-
=
-static bool
-check_file_access(const int type, const char *file, const int=
 mode, const char *opt)
-{
-    int errcode =3D 0;
-
-    /* If no file con=
figured, no errors to look for */
-    if (!file)
-    {
-        return fa=
lse;
-    }
-
-    /* If stdin is allowed and the file name is 'stdin', the=
n do no
-     * further checks as stdin is always available
-     */
-    i=
f ((type & CHKACC_ACPTSTDIN) && streq(file, "stdin"))
-    {
-        retur=
n false;
-    }
-
-    /* file name is a URI if its first segment  has ":" =
(i=2Ee=2E, before any "/")
-     * Then no checks done if CHKACC_ACCEPT_URI=
 is set and the URI does not start with "file:"
-     */
-    if ((type & C=
HKACC_ACCEPT_URI) && strchr(file, ':'))
-    {
-        if (!strncmp(file, =
"file:", 5))
-        {
-            file +=3D 5;
-        }
-        else =
if (!strchr(file, '/') || strchr(file, '/') > strchr(file, ':'))
-        {=

-            return false;
-        }
-    }
-
-    /* Is the directory pa=
th leading to the given file accessible? */
-    if (type & CHKACC_DIRPATH)=

-    {
-        char *fullpath =3D
-            string_alloc(file, NULL); =
/* POSIX dirname() implementation may modify its arguments */
-        char=
 *dirpath =3D dirname(fullpath);
-
-        if (platform_access(dirpath, mo=
de | X_OK) !=3D 0)
-        {
-            errcode =3D errno;
-        }
- =
       free(fullpath);
-    }
-
-    /* Is the file itself accessible? */
-=
    if (!errcode && (type & CHKACC_FILE) && (platform_access(file, mode) !=
=3D 0))
-    {
-        errcode =3D errno;
-    }
-
-    /* If the file exi=
sts and is accessible, is it writable? */
-    if (!errcode && (type & CHKA=
CC_FILEXSTWR) && (platform_access(file, F_OK) =3D=3D 0))
-    {
-        if=
 (platform_access(file, W_OK) !=3D 0)
-        {
-            errcode =3D e=
rrno;
-        }
-    }
-
-    /* Warn if a given private file is group/oth=
ers accessible=2E */
-    if (type & CHKACC_PRIVATE)
-    {
-        platfo=
rm_stat_t st;
-        if (platform_stat(file, &st))
-        {
-          =
  msg(M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
-        }=

-#ifndef _WIN32
-        else
-        {
-            if (st=2Est_mode & (=
S_IRWXG | S_IRWXO))
-            {
-                msg(M_WARN, "WARNING: f=
ile '%s' is group or others accessible", file);
-            }
-        }
-=
#endif
-    }
-
-    /* Scream if an error is found */
-    if (errcode > 0=
)
-    {
-        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'"=
, opt, file);
-    }
-
-    /* Return true if an error occurred */
-    ret=
urn (errcode !=3D 0 ? true : false);
-}
-
-/* A wrapper for check_file_acce=
ss() which also takes a chroot directory=2E
- * If chroot is NULL, behaviou=
r is exactly the same as calling check_file_access() directly,
- * otherwis=
e it will look for the file inside the given chroot directory instead=2E
- =
*/
-static bool
-check_file_access_chroot(const char *chroot, const int typ=
e, const char *file, const int mode,
-                         const char *=
opt)
-{
-    bool ret =3D false;
-
-    /* If no file configured, no errors=
 to look for */
-    if (!file)
-    {
-        return false;
-    }
-
-   =
 /* If chroot is set, look for the file/directory inside the chroot */
-   =
 if (chroot)
-    {
-        struct gc_arena gc =3D gc_new();
-        stru=
ct buffer chroot_file;
-
-        chroot_file =3D prepend_dir(chroot, file,=
 &gc);
-        ret =3D check_file_access(type, BSTR(&chroot_file), mode, o=
pt);
-        gc_free(&gc);
-    }
-    else
-    {
-        /* No chroot i=
n play, just call core file check function */
-        ret =3D check_file_a=
ccess(type, file, mode, opt);
-    }
-    return ret;
-}
-
-/**
- * A wrapp=
er for check_file_access_chroot() that returns false immediately if
- * the=
 file is inline (and therefore there is no access to check)
- */
-static bo=
ol
-check_file_access_chroot_inline(bool is_inline, const char *chroot, con=
st int type,
-                                const char *file, const int m=
ode, const char *opt)
-{
-    if (is_inline)
-    {
-        return false;
=
-    }
-
-    return check_file_access_chroot(chroot, type, file, mode, opt=
);
-}
-
-/**
- * A wrapper for check_file_access() that returns false immed=
iately if the file
- * is inline (and therefore there is no access to check=
)
- */
-static bool
-check_file_access_inline(bool is_inline, const int typ=
e, const char *file, const int mode,
-                         const char *=
opt)
-{
-    if (is_inline)
-    {
-        return false;
-    }
-
-    ret=
urn check_file_access(type, file, mode, opt);
-}
-
-/*
- * Verifies that th=
e path in the "command" that comes after certain script options (e=2Eg=2E, =
--up) is a
- * valid file with appropriate permissions=2E
- *
- * "command"=
 consists of a path, optionally followed by a space, which may be
- * follo=
wed by arbitrary arguments=2E It is NOT a full shell command line -- shell =
expansion is not
- * performed=2E
- *
- * The path and arguments in "comman=
d" may be single- or double-quoted or escaped=2E
- *
- * The path is extrac=
ted from "command", then check_file_access() is called to check it=2E The
-=
 * arguments, if any, are ignored=2E
- *
- * Note that the type, mode, and =
opt arguments to this routine are the same as the corresponding
- * check_f=
ile_access() arguments=2E
- */
-static bool
-check_cmd_access(const char *c=
ommand, const char *opt, const char *chroot)
-{
-    struct argv argv;
-   =
 bool return_code;
-
-    /* If no command was set, there are no errors to =
look for */
-    if (!command)
-    {
-        return false;
-    }
-
-    =
/* Extract executable path and arguments */
-    argv =3D argv_new();
-    =
argv_parse_cmd(&argv, command);
-
-    /* if an executable is specified the=
n check it; otherwise, complain */
-    if (argv=2Eargv[0])
-    {
-       =
 /* Scripts requires R_OK as well, but that might fail on binaries which
- =
        * only requires X_OK to function on Unix - a scenario not unlikely =
to
-         * be seen on suid binaries=2E
-         */
-        return_cod=
e =3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, o=
pt);
-    }
-    else
-    {
-        msg(M_NOPREFIX | M_OPTERR, "%s fails =
with '%s': No path to executable=2E", opt, command);
-        return_code =
=3D true;
-    }
-
-    argv_free(&argv);
-
-    return return_code;
-}
-
-=
/*
- * Sanity check of all file/dir options=2E  Checks that file/dir
- * is=
 accessible by OpenVPN
- */
-static void
-options_postprocess_filechecks(st=
ruct options *options)
-{
-    bool errs =3D false;
-
-    /* ** SSL/TLS/cr=
ypto related files ** */
-    errs |=3D check_file_access_inline(options->d=
h_file_inline, CHKACC_FILE, options->dh_file, R_OK,
-                      =
               "--dh");
-
-    if (!options->verify_hash_no_ca)
-    {
-   =
     errs |=3D check_file_access_inline(options->ca_file_inline, CHKACC_FIL=
E, options->ca_file,
-                                         R_OK, "--ca"=
);
-    }
-
-    errs |=3D check_file_access_chroot(options->chroot_dir, CH=
KACC_FILE, options->ca_path, R_OK,
-                                     "-=
-capath");
-
-    errs |=3D check_file_access_inline(options->cert_file_inl=
ine, CHKACC_FILE | CHKACC_ACCEPT_URI,
-                                    =
 options->cert_file, R_OK, "--cert");
-
-    errs |=3D check_file_access_in=
line(options->extra_certs_file, CHKACC_FILE,
-                             =
        options->extra_certs_file, R_OK, "--extra-certs");
-
-    if (!(opt=
ions->management_flags & MF_EXTERNAL_KEY))
-    {
-        errs |=3D check_=
file_access_inline(options->priv_key_file_inline,
-                        =
                 CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
-       =
                                  options->priv_key_file, R_OK, "--key");
-=
    }
-
-    errs |=3D check_file_access_inline(options->pkcs12_file_inline=
, CHKACC_FILE | CHKACC_PRIVATE,
-                                     optio=
ns->pkcs12_file, R_OK, "--pkcs12");
-
-    if (options->ssl_flags & SSLF_CR=
L_VERIFY_DIR)
-    {
-        errs |=3D check_file_access_chroot(options->c=
hroot_dir, CHKACC_FILE, options->crl_file,
-                               =
          R_OK | X_OK, "--crl-verify directory");
-    }
-    else
-    {
-=
        errs |=3D
-            check_file_access_chroot_inline(options->crl=
_file_inline, options->chroot_dir,
-                                       =
     CHKACC_FILE, options->crl_file, R_OK, "--crl-verify");
-    }
-
-    i=
f (options->tls_export_peer_cert_dir)
-    {
-        errs |=3D
-          =
  check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
-             =
                        options->tls_export_peer_cert_dir, W_OK, "--tls-exp=
ort-cert");
-    }
-
-    ASSERT(options->connection_list);
-    for (int i=
 =3D 0; i < options->connection_list->len; ++i)
-    {
-        struct conn=
ection_entry *ce =3D options->connection_list->array[i];
-
-        errs |=
=3D check_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC=
_PRIVATE,
-                                         ce->tls_auth_file, R_OK=
, "--tls-auth");
-        errs |=3D check_file_access_inline(ce->tls_crypt_=
file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                               =
          ce->tls_crypt_file, R_OK, "--tls-crypt");
-        errs |=3D chec=
k_file_access_inline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRI=
VATE,
-                                         ce->tls_crypt_v2_file, R_OK=
, "--tls-crypt-v2");
-    }
-
-    errs |=3D
-        check_file_access_inl=
ine(options->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-    =
                             options->shared_secret_file, R_OK, "--secret")=
;
-
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, opt=
ions->packet_id_file,
-                              R_OK | W_OK, "--replay=
-persist");
-
-    /* ** Password files ** */
-    errs |=3D check_file_acc=
ess(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                     =
         options->key_pass_file, R_OK, "--askpass");
-#ifdef ENABLE_MANAGEM=
ENT
-    errs |=3D
-        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDI=
N | CHKACC_PRIVATE,
-                          options->management_user_pas=
s, R_OK, "--management user/password file");
-#endif /* ENABLE_MANAGEMENT *=
/
-    errs |=3D check_file_access_inline(options->auth_user_pass_file_inli=
ne,
-                                     CHKACC_FILE | CHKACC_ACPTSTDIN | =
CHKACC_PRIVATE,
-                                     options->auth_user_pa=
ss_file, R_OK, "--auth-user-pass");
-    /* ** System related ** */
-    er=
rs |=3D check_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "-=
-chroot directory");
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKA=
CC_FILEXSTWR, options->writepid, R_OK | W_OK,
-                            =
  "--writepid");
-
-    /* ** Log related ** */
-    errs |=3D check_file_a=
ccess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,=

-                              "--status");
-
-    /* ** Config related **=
 */
-    errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FIL=
E, options->client_config_dir,
-                                     R_OK |=
 X_OK, "--client-config-dir");
-    errs |=3D check_file_access_chroot(opti=
ons->chroot_dir, CHKACC_FILE, options->tmp_dir,
-                          =
           R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
-
-    i=
f (errs)
-    {
-        msg(M_USAGE, "Please correct these errors=2E");
- =
   }
-}
-#endif /* !ENABLE_SMALL */
-
-/*
  * Sanity check on options=2E
  =
* Also set some options based on other
  * options=2E

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
G=
errit-Change-Number: 1774
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--BuNoNyQvwrs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1774?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: Factor out file access code from =
options=2Ec<br><br>options=2Ec is a huge, unwieldly file=2E So remove some<=
br>closely related code that has no direct dependencies<br>with the other f=
unctions in the file=2E<br><br>This time it is the code that checks file ac=
cessibility=2E<br><br>Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acke=
d-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774<br>Message-Id: &lt;20260819160522=
=2E6662-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38535=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etx=
t<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/check_file_access=2Ec<br>=
A src/openvpn/check_file_access=2Eh<br>M src/openvpn/options=2Ec<br>5 files=
 changed, 418 insertions(+), 334 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 9af7870=2E=2E886=
6520 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CM=
akeLists=2Etxt</span><br><span>@@ -431,6 +431,8 @@</span><br><span>     src=
/openvpn/basic=2Eh</span><br><span>     src/openvpn/buffer=2Ec</span><br><s=
pan>     src/openvpn/buffer=2Eh</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    src/openvpn/check_file_access=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=2Eh</span><=
br><span>     src/openvpn/circ_list=2Eh</span><br><span>     src/openvpn/cl=
inat=2Ec</span><br><span>     src/openvpn/clinat=2Eh</span><br><span>diff -=
-git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><spa=
n>index 4220d07=2E=2E42b4404 100644</span><br><span>--- a/src/openvpn/Makef=
ile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@=
 -47,6 +47,7 @@</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span> =
	basic=2Eh \</span><br><span> 	buffer=2Ec buffer=2Eh \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	check_file_access=2Ec check_file_access=
=2Eh \</span><br><span> 	circ_list=2Eh \</span><br><span> 	clinat=2Ec clina=
t=2Eh \</span><br><span> 	common=2Eh \</span><br><span>diff --git a/src/ope=
nvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E83654b2</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/check_file_access=
=2Ec</span><br><span>@@ -0,0 +1,354 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP=
 port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             session authentication and key exchange,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet=
 encryption, packet authentication, and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet compression=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openv=
pn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2008-2026 David Sommerseth &lt;dazo@eurephia=2Eorg&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  This program is free software; you can red=
istribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  it under the terms of the GNU General Public License version 2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by t=
he Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is distributed in the hope that it will be useful,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; wit=
hout even the implied warranty of</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  S=
ee the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gener=
al Public License for more details=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Check =
file/directory sanity</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Expect people using the stripped down version t=
o know what they do */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;check_=
file_access=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ar=
gv=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;platform=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_common=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define CHKACC_FILE       (1 &lt;&lt; 0) /**&l=
t; Check for a file/directory presence */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CHKACC_DIRPATH    (1 &lt;&lt; 1) /**&lt; Chec=
k for directory presence where a file should reside */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILEXSTWR  (1 &lt;&lt; 2)=
 /**&lt; If file exists, is it writable? */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN  (1 &lt;&lt; 3) /**&lt; If=
 filename is stdin, it&#39;s allowed and &quot;exists&quot; */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_PRIVATE    (1 &lt=
;&lt; 4) /**&lt; Warn if this (private) file is group/others accessible */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACCEP=
T_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless they start with file=
: */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_file_access(const int type, const c=
har *file, const int mode, const char *opt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int errcode =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If =
no file configured, no errors to look for */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!file)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If stdin is allowe=
d and the file name is &#39;stdin&#39;, then do no</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * further checks as stdin is always ava=
ilable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((type &amp; CHKAC=
C_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* fi=
le name is a URI if its first segment  has &quot;:&quot; (i=2Ee=2E, before =
any &quot;/&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * Then no checks done if CHKACC_ACCEPT_URI is set and the URI does not =
start with &quot;file:&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if ((type &amp; CHKACC_ACCEPT_URI) &amp;&amp; strchr(file, &#39;:&#39;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!strncmp(file, &quot;fi=
le:&quot;, 5))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fil=
e +=3D 5;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!st=
rchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39;) &gt; strchr(file, &#39=
;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Is the directory path leading to the given file ac=
cessible? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(type &amp; CHKACC_DIRPATH)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  char *fullpath =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            string_alloc(file, NULL); /* POSIX dirname() implementation ma=
y modify its arguments */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const char *dirpath =3D dirname(fullpath);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (platform_access(dirpath, mode | X_OK) !=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            errcode =3D errno=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        free(fullpath);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Is the file itself accessible? */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!errcode &amp;&amp; (type &a=
mp; CHKACC_FILE) &amp;&amp; (platform_access(file, mode) !=3D 0))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        errcode =3D errno;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* If the file exists and is accessible, is it writable? */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!errcode &amp;&=
amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (platform_access(file, F_OK) =
=3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (platform_ac=
cess(file, W_OK) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       errcode =3D errno;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Warn if a given private file i=
s group/others accessible=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (type &amp; CHKACC_PRIVATE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        platform_stat_t st;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (platform_stat(file, &amp;st))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_ERRNO, &quot;W=
ARNING: cannot stat file &#39;%s&#39;&quot;, file);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (st=2Est_mode &amp; (S_IRWXG | S_IRWXO))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
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
span style=3D"color: hsl(120, 100%, 40%);">+/** A wrapper for check_file_ac=
cess() which also takes a chroot directory=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * If chroot is NULL, behaviour is exactly the sa=
me as calling check_file_access() directly,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * otherwise it will look for the file inside the g=
iven chroot directory instead=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_file_=
access_chroot(const char *chroot, const int type, const char *file, const i=
nt mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              const char *opt)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If no file conf=
igured, no errors to look for */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!file)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* If chroot is set, look for the=
 file/directory inside the chroot */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (chroot)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct buffer chroot_file;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        chroot_file =3D prepend_dir(chroot, file, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D che=
ck_file_access(type, BSTR(&amp;chroot_file), mode, opt);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* No chroot in play, just call core file check function */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D check_f=
ile_access(type, file, mode, opt);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * A wrapper for check_file_access_chroot() that returns=
 false immediately if</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * the file is inline (and therefore there is no access to check)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+check_file_access_chroot_inline(bool is_inline, c=
onst char *chroot, const int type,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                const char *file, const int =
mode, const char *opt)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_inli=
ne)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return check_file_access_chroot(chroot, type, file, mode=
, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * A wrapper for check_file_access() that returns false immediate=
ly if the file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is=
 inline (and therefore there is no access to check)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+check_file_access_inline(bool is_inline, const int type, const ch=
ar *file, const int mode,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                         const char *opt)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (is_inline)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return check_file_access(type, f=
ile, mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+check_cmd_access(const char *command, const char *opt, =
const char *chroot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv ar=
gv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool return_=
code;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* If no command was set, the=
re are no errors to look for */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!command)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Extract executable path and =
arguments */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    arg=
v =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  argv_parse_cmd(&amp;argv, command);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* if an executable is specified then check it; otherwise, complain */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (argv=2Eargv[0=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* Scripts requires R_O=
K as well, but that might fail on binaries which</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * only requires X_OK to function on U=
nix - a scenario not unlikely to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * be seen on suid binaries=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return_code =3D check_file_access_chroot(=
chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_NOPREFIX | M_OPTERR, &quot;%s fails with &#39;%s&#39;: No path to execu=
table=2E&quot;, opt, command);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return_code =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_fre=
e(&amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return return_code;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+options_postprocess_filechecks(struct options *options)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool errs =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* ** SSL/TLS/crypto related files ** */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(optio=
ns-&gt;dh_file_inline, CHKACC_FILE, options-&gt;dh_file, R_OK,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
     &quot;--dh&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!option=
s-&gt;verify_hash_no_ca)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
rrs |=3D check_file_access_inline(options-&gt;ca_file_inline, CHKACC_FILE, =
options-&gt;ca_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                         R_OK, &quot;--ca&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    errs |=3D check_file_access_chroot(options-&gt;chroot_di=
r, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                     &quot;--capath&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access=
_inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
             options-&gt;cert_file, R_OK, &quot;--cert&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(options-&gt;=
extra_certs_file, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                     options-&gt;extra_certs_fil=
e, R_OK, &quot;--extra-certs&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(optio=
ns-&gt;priv_key_file_inline,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                         CHKACC_FILE | CHKACC_PRIV=
ATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                         options-&gt;priv_key_file, R_=
OK, &quot;--key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acce=
ss_inline(options-&gt;pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
              options-&gt;pkcs12_file, R_OK, &quot;--pkcs12&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (options-&gt;ssl_flags &amp; SSLF_CRL_V=
ERIFY_DIR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check=
_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;crl_fi=
le,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                         R_OK | X_OK, &quot;--crl-verify directory&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        errs |=3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            check_file_access_chroot_inline(options-&gt;crl_f=
ile_inline, options-&gt;chroot_dir,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                            CHKACC_FILE, op=
tions-&gt;crl_file, R_OK, &quot;--crl-verify&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (options-&gt;tls_export_peer_cert_dir)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        errs |=3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            check_file_access_chroot(options-&gt;chroot_dir, CHK=
ACC_FILE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                           options-&gt;tls_export_peer_cert_dir, W_OK, &quo=
t;--tls-export-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(options-&gt;co=
nnection_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int i =3D 0; i &lt; options-&gt;connection_list-&gt;len; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct connection_entry *ce=
 =3D options-&gt;connection_list-&gt;array[i];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        errs |=3D check_file_access_inline(ce-&gt;tls_auth_file_inl=
ine, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                         ce-&gt;tls_auth_fil=
e, R_OK, &quot;--tls-auth&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;tls_crypt_f=
ile_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                         ce-&gt;tls_c=
rypt_file, R_OK, &quot;--tls-crypt&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(ce-&gt;tl=
s_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    errs |=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        check_file_access_inline(options-&gt;shared_secret_file_inline, C=
HKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                 options-&gt;shared_secret_file, R=
_OK, &quot;--secret&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=
=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet=
_id_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                    R_OK | W_OK, &quot;--replay-persist&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* ** Password files ** */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_=
FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              options-&gt;key_pass_fi=
le, R_OK, &quot;--askpass&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    errs |=3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHK=
ACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                   options-&gt;management_user_pass, R_OK, &quot;--manageme=
nt user/password file&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    errs |=3D check_file_access_inline(options-&gt;aut=
h_user_pass_file_inline,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                     CHKACC_FILE | CHKACC_ACPTSTDIN | =
CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                 options-&gt;auth_user_pass_file, R_OK, &qu=
ot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* ** System related ** */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_FILE, options-&gt=
;chroot_dir, R_OK | X_OK, &quot;--chroot directory&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHKA=
CC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, R_OK | W_OK,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 &quot;--writepid&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** Log=
 related ** */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
rrs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;s=
tatus_file, R_OK | W_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                              &quot;--status&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* ** Config related ** */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(option=
s-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
    R_OK | X_OK, &quot;--client-config-dir&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(optio=
ns-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                     R_OK=
 | W_OK | X_OK, &quot;Temporary directory (--tmp-dir)&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (errs)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_USAGE, &quot;Please correct these errors=2E&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif /* !ENABLE_SMALL */</span><br><span>diff --git a/src/openvpn/check_fil=
e_access=2Eh b/src/openvpn/check_file_access=2Eh</span><br><span>new file m=
ode 100644</span><br><span>index 0000000=2E=2Eb3ed886</span><br><span>--- /=
dev/null</span><br><span>+++ b/src/openvpn/check_file_access=2Eh</span><br>=
<span>@@ -0,0 +1,60 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN --=
 An application to securely tunnel IP networks</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             over a single UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef CHECK_FILE_ACCESS_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define CHECK_FILE_ACCESS_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Verifies that the path in the &quot;command&=
quot; that comes after certain script options (e=2Eg=2E, --up) is a</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * valid file with appropri=
ate permissions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * &quot;command&q=
uot; consists of a path, optionally followed by a space, which may be</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * followed by arbitrary =
arguments=2E It is NOT a full shell command line -- shell expansion is not<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * performed=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The path and arguments in &quot;comman=
d&quot; may be single- or double-quoted or escaped=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * The path is extracted from &quot;command&quot;, then ch=
eck_file_access() is called to check it=2E The</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * arguments, if any, are ignored=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Note that the type, mode, and opt arguments t=
o this routine are the same as the corresponding</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * check_file_access() arguments=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool check_cmd_access(const char *command, con=
st char *opt, const char *chroot);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sanity check of a=
ll file/dir options=2E  Checks that file/dir</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * is accessible by OpenVPN</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void options_postprocess_filechecks(struct options *optio=
ns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* !ENABLE_SMALL */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* CHECK_FILE_ACCESS_H */</span><br><sp=
an>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br=
><span>index e899fa6=2E=2E317ce44 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -63,6 +63,7 @@</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span=
><br><span> #include &quot;domain_helper=2Eh&quot;</span><br><span> #includ=
e &quot;mbuf=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;check_file_access=2Eh&quot;</span><br><span> </span><br><=
span> #include &lt;ctype=2Eh&gt;</span><br><span> </span><br><span>@@ -3328=
,340 +3329,6 @@</span><br><span> }</span><br><span> </span><br><span> /*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Check file/directory=
 sanity</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/* Expect people using the stripped down version to=
 know what they do */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILE   =
    (1 &lt;&lt; 0) /**&lt; Check for a file/directory presence */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_DIRPATH    (1 &l=
t;&lt; 1) /**&lt; Check for directory presence where a file should reside *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILEX=
STWR  (1 &lt;&lt; 2) /**&lt; If file exists, is it writable? */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_ACPTSTDIN  (1 &lt;=
&lt; 3) /**&lt; If filename is stdin, it&#39;s allowed and &quot;exists&quo=
t; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_P=
RIVATE    (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is group/other=
s accessible */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless they s=
tart with file: */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-check_file_access(const int type, =
const char *file, const int mode, const char *opt)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int errcode =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If n=
o file configured, no errors to look for */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!file)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* If stdin is allowed and the fil=
e name is &#39;stdin&#39;, then do no</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * further checks as stdin is always available</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_ACPTSTDIN) &amp;=
&amp; streq(file, &quot;stdin&quot;))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* file name is a URI if its firs=
t segment  has &quot;:&quot; (i=2Ee=2E, before any &quot;/&quot;)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * Then no checks done if C=
HKACC_ACCEPT_URI is set and the URI does not start with &quot;file:&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_ACCEPT_URI=
) &amp;&amp; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (!strncmp(file, &quot;file:&quot;, 5))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            file +=3D 5;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        else if (!strchr(file, &#39;/&#39;) || strchr(file, &#39=
;/&#39;) &gt; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            return false;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* Is the directory path leading t=
o the given file accessible? */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (type &amp; CHKACC_DIRPATH)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        char *fullpath =3D</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            string_alloc(file, NULL); /* POSIX dirname() implem=
entation may modify its arguments */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        char *dirpath =3D dirname(fullpath);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (platform_access(dirpath, mode | X_OK) !=3D 0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            errcode =3D errno;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        free(fullpath);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* Is the file itself accessible? */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHKACC_FILE) =
&amp;&amp; (platform_access(file, mode) !=3D 0))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        errcode =3D errno;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If the file ex=
ists and is accessible, is it writable? */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHKACC_FILEXST=
WR) &amp;&amp; (platform_access(file, F_OK) =3D=3D 0))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (platform_access(file, W_OK) !=3D 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            errcode =3D errno;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* W=
arn if a given private file is group/others accessible=2E */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (type &amp; CHKACC_PRIVATE)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        platform_stat_t st;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (platform_stat(file, &=
amp;st))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | =
M_ERRNO, &quot;WARNING: cannot stat file &#39;%s&#39;&quot;, file);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (st=2Est_mode &amp; (S_IRWXG | S_IRWXO))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot;WARNING: =
file &#39;%s&#39; is group or others accessible&quot;, file);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* Scream if an error is fou=
nd */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (errcode =
&gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NOPREFIX | M_OPT=
ERR | M_ERRNO, &quot;%s fails with &#39;%s&#39;&quot;, opt, file);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* Return true if an error occurred */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return (errcode !=3D 0 ? true : false);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* A wrapper for check_file_access() which also takes a chroot d=
irectory=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If chro=
ot is NULL, behaviour is exactly the same as calling check_file_access() di=
rectly,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * otherwise i=
t will look for the file inside the given chroot directory instead=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-check_file_access_chroot(const char *chroot, const in=
t type, const char *file, const int mode,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                         const char *opt)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* If no file configured, no errors to look for */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!file)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If chroot is set, l=
ook for the file/directory inside the chroot */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (chroot)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        struct buffer chroot_file;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        chroot_file =3D prepend_dir(chroot, file, &amp;gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D check_=
file_access(type, BSTR(&amp;chroot_file), mode, opt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* No chroot in play, just call core file check function */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        ret =3D check_file_access(type=
, file, mode, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * A wr=
apper for check_file_access_chroot() that returns false immediately if</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * the file is inline (and=
 therefore there is no access to check)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_file=
_access_chroot_inline(bool is_inline, const char *chroot, const int type,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
         const char *file, const int mode, const char *opt)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (is_inline)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return check_file_access_chroot(ch=
root, type, file, mode, opt);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * A wrapper for check_file_access() that returns f=
alse immediately if the file</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * is inline (and therefore there is no access to check)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-check_file_access_inline(bool is_inline, const int type, cons=
t char *file, const int mode,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         const char *opt)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (is_inline)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return check_file_access(type, file, mode, o=
pt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Verifies that the path in the &quot;command&quot; that comes after certain=
 script options (e=2Eg=2E, --up) is a</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * valid file with appropriate permissions=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * &quot;command&quot; consists of a path, optionally =
followed by a space, which may be</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * followed by arbitrary arguments=2E It is NOT a full shell co=
mmand line -- shell expansion is not</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * performed=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The pat=
h and arguments in &quot;command&quot; may be single- or double-quoted or e=
scaped=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * The path is extracted from &=
quot;command&quot;, then check_file_access() is called to check it=2E The</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * arguments, if any, a=
re ignored=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Note that the type, mode=
, and opt arguments to this routine are the same as the corresponding</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * check_file_access() argu=
ments=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-check_cmd_access(const char *command, con=
st char *opt, const char *chroot)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct argv argv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool=
 return_code;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If no command was set,=
 there are no errors to look for */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (!command)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Extract executable path and argument=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv =3D argv=
_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_parse=
_cmd(&amp;argv, command);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* if an exec=
utable is specified then check it; otherwise, complain */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (argv=2Eargv[0])</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /* Scripts requires R_OK as well, but that mi=
ght fail on binaries which</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-         * only requires X_OK to function on Unix - a scenario not unl=
ikely to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * be=
 seen on suid binaries=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return_code =3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv=
[0], X_OK, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(M_NOPREFIX | M_OPTERR, &quot;%s fails =
with &#39;%s&#39;: No path to executable=2E&quot;, opt, command);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return_code =3D true;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    argv_free(&amp;argv);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return return_code;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Sanity check of all file/dir options=2E  Checks that file=
/dir</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is accessible =
by OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-options_postprocess_filechecks(struct o=
ptions *options)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool errs =3D false;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
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
=3D"color: hsl(0, 100%, 40%);">-        struct connection_entry *ce =3D opt=
ions-&gt;connection_list-&gt;array[i];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    errs |=3D check_file_access_inline(ce-&gt;tls_auth_file_inline, CHKACC_=
FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                         ce-&gt;tls_auth_file, R_OK, &quot=
;--tls-auth&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      errs |=3D check_file_access_inline(ce-&gt;tls_crypt_file_inline, CHKA=
CC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                         ce-&gt;tls_crypt_file, R_OK, &=
quot;--tls-crypt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        errs |=3D check_file_access_inline(ce-&gt;tls_crypt_v2_file_inli=
ne, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                         ce-&gt;tls_crypt_v2_fi=
le, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        check_file_access_in=
line(options-&gt;shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
          options-&gt;shared_secret_file, R_OK, &quot;--secret&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_DIRPATH =
| CHKACC_FILEXSTWR, options-&gt;packet_id_file,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                              R_OK | W_OK, &quot;=
--replay-persist&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ** Password=
 files ** */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs =
|=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
     options-&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        check_file_access(CHKACC_FILE | =
CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                          options-&gt;management_user_pass, R_=
OK, &quot;--management user/password file&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* ENABLE_MANAGEMENT */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_inline=
(options-&gt;auth_user_pass_file_inline,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                     CHKACC_FILE | CHKAC=
C_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                     options-&gt;auth_user_pass_fil=
e, R_OK, &quot;--auth-user-pass&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* ** System related ** */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_FILE, opt=
ions-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot directory&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_acces=
s(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, R_OK | W_OK,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
     &quot;--writepid&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ** Log=
 related ** */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    err=
s |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;sta=
tus_file, R_OK | W_OK,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                              &quot;--status&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* ** Config related ** */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(options-&gt;chro=
ot_dir, CHKACC_FILE, options-&gt;client_config_dir,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                     R_OK |=
 X_OK, &quot;--client-config-dir&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    errs |=3D check_file_access_chroot(options-&gt;chroo=
t_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                     R_OK | W_OK | X_OK,=
 &quot;Temporary directory (--tmp-dir)&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (errs)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE,=
 &quot;Please correct these errors=2E&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* !E=
NABLE_SMALL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Sanit=
y check on options=2E</span><br><span>  * Also set some options based on ot=
her</span><br><span>  * options=2E</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3D=
email">change 1774</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1774?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1774 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--BuNoNyQvwrs=--


--===============0514050821110048673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0514050821110048673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0514050821110048673==--

