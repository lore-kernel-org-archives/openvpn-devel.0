Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D312C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L2xgc0lmF1qdHIOeinzSGq51OWwsJzx/BQsbM980Nas=; b=jnjW/PdRkjaW3UNyk5+H7ls705
	moRTMF6DOYuw2xZhJvPZ69wkFqiIXw4SBpaWkz6XNZYk4V+jRvh79rLJGjBuaWqRnSQO599+X0Cue
	nIqVhdvlF4qhQWEuz50iEISC0TMG7G4ELaueq3msBhERNgBHy5fv2E8SBPypfB+qnfwA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvw94-0001x6-Ku;
	Mon, 17 Aug 2026 12:08:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvw93-0001x0-SN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rwVCH8xE+Y1pzZRJ0D35gxojadOQ3mu56Nx+4BibS84=; b=SKSrntfTXhMCliyChzZsyXQJdb
 hQx/OLALykiaDi11cw5acV2uuT9i1fEpQcJ4EguY1sQtvj/LT3RDwKAY2VPZJmiZ6i6HntlsidIdz
 XGiK7Tb6c7n1L+imAFxfwGJB7QJfZItqWEu8tMttbB4ZlO/m/xcLD6YhY5SLFwMI9vT8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rwVCH8xE+Y1pzZRJ0D35gxojadOQ3mu56Nx+4BibS84=; b=I
 6SIz691TS9xIlbZi6hblBIHMfnmhtpo6QJyxzWLkOKB6FqGvJRCeIjCa61XS7oCOITOmWNZRa9m2E
 SOEA3yR/WrwMBu4ti7pPm2xzqQR4K+43Ldhveb/jfpFt1PWqawhfJ/mP9hMX82fzHV1q/VmZ+CRX2
 GEdA+saWxFV7HK0Q=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvw93-0001pH-BA for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:08:49 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso28716815e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968519; x=1787573319; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rwVCH8xE+Y1pzZRJ0D35gxojadOQ3mu56Nx+4BibS84=;
 b=QLWzzh0ntUOeJp50G5IiSGK4wl/MBF8af2qmInyGfe7IGaMZ5ff+8jpDCeU5/2smAQ
 nqGRmu1KM5Mgd5jOqWQ30OMI/HusebLbAP6wlWN/aRy166TLpY686k8xhca4ZYstuMRp
 tr4FIrgeYfJQNsbY6rHiQhD633XENatE8I185fCIbbo02YSS4/kEKFtbP05y/GZAORTz
 wC1lfk8+vlpMVvzFJ1dwaLLQF//CL2ACxXgf0S41P4lvh6GtmK01hPCb659Vzs1tdAqg
 lRDuucI4vkZvdbYxODLI6S1xekd2S71QG94dU54M1UEmcHfAeXaoGsson7sUrygcKO8l
 JbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968519; x=1787573319;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rwVCH8xE+Y1pzZRJ0D35gxojadOQ3mu56Nx+4BibS84=;
 b=MZkcGy3iUkJPHwqM81vDGNKQ/EvDSBJP8bp3hhiVVZrji7UPPct7WwycxGe7wufbJc
 6p3Jqgy9+KozrE9VvLunRYbUYdHtWgcP8QCzMRFRP+Rck3EbHawd8U97q1F0UyG1+WTI
 rywmIpH0u11JOd4il6ObYrVySxSbq5mPVFN6MumDOYm4O1iyFVxu4XYEIWHf9T3iHcu5
 uER8v4tQJfPJH9ZSGqvechY2pRszLqXTOUJwhUbmDTHPzqAVGTc/qy2WEpRp+Yhar1uK
 6+5SJhuJgvpToKlC56+aqCCxDRwBT30YAuHmAkQ3kvEDfmXurNlvD71Gk1Drl104S+xA
 g3Sw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0hD/u6xEWHx55VW8aj2b4vJKJ66eSt/zQXe3puTdarcL60Tp7GV0ID4GHNkVWM/LKVxzup0WoMNkK3BWB@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzS3A5T/65Z8evZGrOFhePgsIajDpb7DyGrhsd3jtUvLgpTGa2B
 epoIbteidjYxb4fX3ZRWpfYWrJ2Bp8ncfsqYtiLa1DY6hUqzy8hnw3DY1h0Z0snz/nug4lMnAk7
 H+m344fRVkND8qfyE2eZTtBrJETebVhtM41iAWdDvCGiRA2DSkFTfM/5UP4fmQqJknxhY
X-Gm-Gg: AR+sD12iVCbjbgFeWedITFErjnnOCh/NGLmT4PDPabucov8PyTUHh8DChXTekkFLVaN
 7J9JEpD1BIJJXnqRsfrxcfkqoe7BxOb+wLqWiQun7nMvIzBAkNEz++EtUn5+WxCGwgzoI821WVc
 apIMLQH+Ar+rpbgIXaOksevjt+fc/i8keNdyAe+Nm6eaJRF9JFJJkWMM0IWsI1P9MTRVeMwgpbO
 DnaL/2WjYcM8U0Me4XeI5KihdNGWKWbgjhqN/uF29z4rn9jA9UVjvUJaA2Gzrn2p8GCmPATnB4C
 tPJ5DpEtV5WQxYdNlT5XJtiyc8kajw/u/8kP+9qG5d7wDYvGkT3Smh4z/NxaQIM8oFUPnfGZWFs
 W7kLSPIRzq6yn/gMF4VaN1es++M8l16HueeM/coC/wwALBxhghn3YUqF0lIq2pUP45RvQB87Szp
 twdtDjqd/EsWNflwjGcexJHolITCR847ZlvZQDOC3dIcwlb5MASw9BRpqnCRZlbX8Q+zEOKJbGV
 zJFudTSQWUYOpdJMncnEf6mfFH6VfGxgKU9DRHW0c5O2dI53n1SZ3nHEJyvOixsQmgLqsGrhBwc
 P9pAzPhuUXR82kuzQmcmcBlvlgZ64dZwvmXfL8OXUMh1PlZW9Cw=
X-Received: by 2002:a05:600d:117:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-49987ab4e1bmr244594365e9.7.1786968518757; 
 Mon, 17 Aug 2026 05:08:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996176b8asm119533035e9.11.2026.08.17.05.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:08:37 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:08:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: e63a56cc61447adbed04e4059e7f16c3eeb690ff
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7d8582236f1d8cf5a2a884bec6eca28dbdb90c6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvw93-0001pH-BA
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
Content-Type: multipart/mixed; boundary="===============9102007658574090014=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9102007658574090014==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jb8MjhkNl7U="; charset=UTF-8

--Jb8MjhkNl7U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail

to look at the new patch=
 set (#3)=2E


Change subject: options: Factor out file access code from op=
tions=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ptions: Factor out file access code from options=2Ec

options=2Ec is a huge=
, unwieldly file=2E So remove some
closely related code that has no direct =
dependencies
with the other functions in the file=2E

This time it is the c=
ode that checks file accessibility=2E

Change-Id: I6dafab74b82fbf770c1798b4=
851a0fd5e4b5d81e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/check_fil=
e_access=2Ec
A src/openvpn/check_file_access=2Eh
M src/openvpn/options=2Ec
=
5 files changed, 416 insertions(+), 334 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/3

diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt
index d7a5e08=2E=2E6c66ebd 100644
--- a/CMa=
keLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -431,6 +431,8 @@
     src/openvpn/b=
asic=2Eh
     src/openvpn/buffer=2Ec
     src/openvpn/buffer=2Eh
+    src/o=
penvpn/check_file_access=2Ec
+    src/openvpn/check_file_access=2Eh
     sr=
c/openvpn/circ_list=2Eh
     src/openvpn/clinat=2Ec
     src/openvpn/clinat=
=2Eh
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
ind=
ex 4650ddd=2E=2E182d732 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/op=
envpn/Makefile=2Eam
@@ -47,6 +47,7 @@
 	base64=2Ec base64=2Eh \
 	basic=2Eh=
 \
 	buffer=2Ec buffer=2Eh \
+	check_file_access=2Ec check_file_access=2Eh =
\
 	circ_list=2Eh \
 	clinat=2Ec clinat=2Eh \
 	common=2Eh \
diff --git a/s=
rc/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec
new fi=
le mode 100644
index 0000000=2E=2E08515ea
--- /dev/null
+++ b/src/openvpn/c=
heck_file_access=2Ec
@@ -0,0 +1,372 @@
+/*
+ *  OpenVPN -- An application t=
o securely tunnel IP networks
+ *             over a single UDP port, with =
support for SSL/TLS-based
+ *             session authentication and key ex=
change,
+ *             packet encryption, packet authentication, and
+ *  =
           packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN I=
nc <sales@openvpn=2Enet>
+ *  Copyright (C) 2008-2026 David Sommerseth <daz=
o@eurephia=2Eorg>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*
+ *  Check file/directory san=
ity
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+/* Exp=
ect people using the stripped down version to know what they do */
+#ifndef=
 ENABLE_SMALL
+
+#include "syshead=2Eh"
+
+#include "argv=2Eh"
+#include "b=
uffer=2Eh"
+#include "error=2Eh"
+#include "options=2Eh"
+#include "platfor=
m=2Eh"
+#include "ssl_common=2Eh"
+
+#include <string=2Eh>
+
+#define CHKAC=
C_FILE       (1 << 0) /**< Check for a file/directory presence */
+#define =
CHKACC_DIRPATH    (1 << 1) /**< Check for directory presence where a file s=
hould reside */
+#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is=
 it writable? */
+#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is st=
din, it's allowed and "exists" */
+#define CHKACC_PRIVATE    (1 << 4) /**< =
Warn if this (private) file is group/others accessible */
+#define CHKACC_A=
CCEPT_URI (1 << 5) /**< Do not check URIs, unless they start with file: */
=
+
+static bool
+check_file_access(const int type, const char *file, const i=
nt mode, const char *opt)
+{
+    int errcode =3D 0;
+
+    /* If no file c=
onfigured, no errors to look for */
+    if (!file)
+    {
+        return =
false;
+    }
+
+    /* If stdin is allowed and the file name is 'stdin', t=
hen do no
+     * further checks as stdin is always available
+     */
+   =
 if ((type & CHKACC_ACPTSTDIN) && streq(file, "stdin"))
+    {
+        ret=
urn false;
+    }
+
+    /* file name is a URI if its first segment  has ":=
" (i=2Ee=2E, before any "/")
+     * Then no checks done if CHKACC_ACCEPT_U=
RI is set and the URI does not start with "file:"
+     */
+    if ((type &=
 CHKACC_ACCEPT_URI) && strchr(file, ':'))
+    {
+        if (!strncmp(file=
, "file:", 5))
+        {
+            file +=3D 5;
+        }
+        els=
e if (!strchr(file, '/') || strchr(file, '/') > strchr(file, ':'))
+       =
 {
+            return false;
+        }
+    }
+
+    /* Is the directory =
path leading to the given file accessible? */
+    if (type & CHKACC_DIRPAT=
H)
+    {
+        char *fullpath =3D
+            string_alloc(file, NULL)=
; /* POSIX dirname() implementation may modify its arguments */
+        co=
nst char *dirpath =3D dirname(fullpath);
+
+        if (platform_access(dir=
path, mode | X_OK) !=3D 0)
+        {
+            errcode =3D errno;
+    =
    }
+        free(fullpath);
+    }
+
+    /* Is the file itself accessib=
le? */
+    if (!errcode && (type & CHKACC_FILE) && (platform_access(file, =
mode) !=3D 0))
+    {
+        errcode =3D errno;
+    }
+
+    /* If the f=
ile exists and is accessible, is it writable? */
+    if (!errcode && (type=
 & CHKACC_FILEXSTWR) && (platform_access(file, F_OK) =3D=3D 0))
+    {
+   =
     if (platform_access(file, W_OK) !=3D 0)
+        {
+            errcod=
e =3D errno;
+        }
+    }
+
+    /* Warn if a given private file is gr=
oup/others accessible=2E */
+    if (type & CHKACC_PRIVATE)
+    {
+       =
 platform_stat_t st;
+        if (platform_stat(file, &st))
+        {
+   =
         msg(M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
+  =
      }
+#ifndef _WIN32
+        else
+        {
+            if (st=2Est_m=
ode & (S_IRWXG | S_IRWXO))
+            {
+                msg(M_WARN, "WAR=
NING: file '%s' is group or others accessible", file);
+            }
+    =
    }
+#endif
+    }
+
+    /* Scream if an error is found */
+    if (errc=
ode > 0)
+    {
+        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails wit=
h '%s'", opt, file);
+    }
+
+    /* Return true if an error occurred */
+=
    return (errcode !=3D 0 ? true : false);
+}
+
+/** A wrapper for check_f=
ile_access() which also takes a chroot directory=2E
+ * If chroot is NULL, =
behaviour is exactly the same as calling check_file_access() directly,
+ * =
otherwise it will look for the file inside the given chroot directory inste=
ad=2E
+ */
+static bool
+check_file_access_chroot(const char *chroot, const=
 int type, const char *file, const int mode,
+                         cons=
t char *opt)
+{
+    bool ret =3D false;
+
+    /* If no file configured, n=
o errors to look for */
+    if (!file)
+    {
+        return false;
+    =
}
+
+    /* If chroot is set, look for the file/directory inside the chroot=
 */
+    if (chroot)
+    {
+        struct gc_arena gc =3D gc_new();
+    =
    struct buffer chroot_file;
+
+        chroot_file =3D prepend_dir(chroo=
t, file, &gc);
+        ret =3D check_file_access(type, BSTR(&chroot_file),=
 mode, opt);
+        gc_free(&gc);
+    }
+    else
+    {
+        /* No =
chroot in play, just call core file check function */
+        ret =3D chec=
k_file_access(type, file, mode, opt);
+    }
+    return ret;
+}
+
+/**
+ *=
 A wrapper for check_file_access_chroot() that returns false immediately if=

+ * the file is inline (and therefore there is no access to check)
+ */
+s=
tatic bool
+check_file_access_chroot_inline(bool is_inline, const char *chr=
oot, const int type,
+                                const char *file, con=
st int mode, const char *opt)
+{
+    if (is_inline)
+    {
+        return=
 false;
+    }
+
+    return check_file_access_chroot(chroot, type, file, m=
ode, opt);
+}
+
+/**
+ * A wrapper for check_file_access() that returns fal=
se immediately if the file
+ * is inline (and therefore there is no access =
to check)
+ */
+static bool
+check_file_access_inline(bool is_inline, const=
 int type, const char *file, const int mode,
+                         cons=
t char *opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
=
+    return check_file_access(type, file, mode, opt);
+}
+
+/**
+ * Verifie=
s that the path in the "command" that comes after certain script options (e=
=2Eg=2E, --up) is a
+ * valid file with appropriate permissions=2E
+ *
+ * =
"command" consists of a path, optionally followed by a space, which may be
=
+ * followed by arbitrary arguments=2E It is NOT a full shell command line =
-- shell expansion is not
+ * performed=2E
+ *
+ * The path and arguments i=
n "command" may be single- or double-quoted or escaped=2E
+ *
+ * The path =
is extracted from "command", then check_file_access() is called to check it=
=2E The
+ * arguments, if any, are ignored=2E
+ *
+ * Note that the type, m=
ode, and opt arguments to this routine are the same as the corresponding
+ =
* check_file_access() arguments=2E
+ */
+bool
+check_cmd_access(const char =
*command, const char *opt, const char *chroot)
+{
+    struct argv argv;
+ =
   bool return_code;
+
+    /* If no command was set, there are no errors t=
o look for */
+    if (!command)
+    {
+        return false;
+    }
+
+  =
  /* Extract executable path and arguments */
+    argv =3D argv_new();
+  =
  argv_parse_cmd(&argv, command);
+
+    /* if an executable is specified t=
hen check it; otherwise, complain */
+    if (argv=2Eargv[0])
+    {
+     =
   /* Scripts requires R_OK as well, but that might fail on binaries which
=
+         * only requires X_OK to function on Unix - a scenario not unlikel=
y to
+         * be seen on suid binaries=2E
+         */
+        return_c=
ode =3D check_file_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK,=
 opt);
+    }
+    else
+    {
+        msg(M_NOPREFIX | M_OPTERR, "%s fail=
s with '%s': No path to executable=2E", opt, command);
+        return_code=
 =3D true;
+    }
+
+    argv_free(&argv);
+
+    return return_code;
+}
+
=
+/**
+ * Sanity check of all file/dir options=2E  Checks that file/dir
+ * =
is accessible by OpenVPN
+ */
+void
+options_postprocess_filechecks(struct =
options *options)
+{
+    bool errs =3D false;
+
+    /* ** SSL/TLS/crypto =
related files ** */
+    errs |=3D check_file_access_inline(options->dh_fil=
e_inline, CHKACC_FILE, options->dh_file, R_OK,
+                           =
          "--dh");
+
+    if (!options->verify_hash_no_ca)
+    {
+        =
errs |=3D check_file_access_inline(options->ca_file_inline, CHKACC_FILE, op=
tions->ca_file,
+                                         R_OK, "--ca");
+ =
   }
+
+    errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_=
FILE, options->ca_path, R_OK,
+                                     "--capa=
th");
+
+    errs |=3D check_file_access_inline(options->cert_file_inline, =
CHKACC_FILE | CHKACC_ACCEPT_URI,
+                                     opti=
ons->cert_file, R_OK, "--cert");
+
+    errs |=3D check_file_access_inline(=
options->extra_certs_file, CHKACC_FILE,
+                                  =
   options->extra_certs_file, R_OK, "--extra-certs");
+
+    if (!(options-=
>management_flags & MF_EXTERNAL_KEY))
+    {
+        errs |=3D check_file_=
access_inline(options->priv_key_file_inline,
+                             =
            CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
+            =
                             options->priv_key_file, R_OK, "--key");
+    }=

+
+    errs |=3D check_file_access_inline(options->pkcs12_file_inline, CHK=
ACC_FILE | CHKACC_PRIVATE,
+                                     options->p=
kcs12_file, R_OK, "--pkcs12");
+
+    if (options->ssl_flags & SSLF_CRL_VER=
IFY_DIR)
+    {
+        errs |=3D check_file_access_chroot(options->chroot=
_dir, CHKACC_FILE, options->crl_file,
+                                    =
     R_OK | X_OK, "--crl-verify directory");
+    }
+    else
+    {
+     =
   errs |=3D
+            check_file_access_chroot_inline(options->crl_file=
_inline, options->chroot_dir,
+                                            =
CHKACC_FILE, options->crl_file, R_OK, "--crl-verify");
+    }
+
+    if (op=
tions->tls_export_peer_cert_dir)
+    {
+        errs |=3D
+            che=
ck_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                  =
                   options->tls_export_peer_cert_dir, W_OK, "--tls-export-c=
ert");
+    }
+
+    ASSERT(options->connection_list);
+    for (int i =3D =
0; i < options->connection_list->len; ++i)
+    {
+        const struct con=
nection_entry *ce =3D options->connection_list->array[i];
+
+        errs |=
=3D check_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC=
_PRIVATE,
+                                         ce->tls_auth_file, R_OK=
, "--tls-auth");
+        errs |=3D check_file_access_inline(ce->tls_crypt_=
file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                               =
          ce->tls_crypt_file, R_OK, "--tls-crypt");
+        errs |=3D chec=
k_file_access_inline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRI=
VATE,
+                                         ce->tls_crypt_v2_file, R_OK=
, "--tls-crypt-v2");
+    }
+
+    errs |=3D
+        check_file_access_inl=
ine(options->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+    =
                             options->shared_secret_file, R_OK, "--secret")=
;
+
+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, opt=
ions->packet_id_file,
+                              R_OK | W_OK, "--replay=
-persist");
+
+    /* ** Password files ** */
+    errs |=3D check_file_acc=
ess(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                     =
         options->key_pass_file, R_OK, "--askpass");
+#ifdef ENABLE_MANAGEM=
ENT
+    errs |=3D
+        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDI=
N | CHKACC_PRIVATE,
+                          options->management_user_pas=
s, R_OK, "--management user/password file");
+#endif /* ENABLE_MANAGEMENT *=
/
+    errs |=3D check_file_access_inline(options->auth_user_pass_file_inli=
ne,
+                                     CHKACC_FILE | CHKACC_ACPTSTDIN | =
CHKACC_PRIVATE,
+                                     options->auth_user_pa=
ss_file, R_OK, "--auth-user-pass");
+    /* ** System related ** */
+    er=
rs |=3D check_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "-=
-chroot directory");
+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKA=
CC_FILEXSTWR, options->writepid, R_OK | W_OK,
+                            =
  "--writepid");
+
+    /* ** Log related ** */
+    errs |=3D check_file_a=
ccess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,=

+                              "--status");
+
+    /* ** Config related **=
 */
+    errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FIL=
E, options->client_config_dir,
+                                     R_OK |=
 X_OK, "--client-config-dir");
+    errs |=3D check_file_access_chroot(opti=
ons->chroot_dir, CHKACC_FILE, options->tmp_dir,
+                          =
           R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
+
+    i=
f (errs)
+    {
+        msg(M_USAGE, "Please correct these errors=2E");
+ =
   }
+}
+
+#endif /* !ENABLE_SMALL */
diff --git a/src/openvpn/check_file_a=
ccess=2Eh b/src/openvpn/check_file_access=2Eh
new file mode 100644
index 00=
00000=2E=2E7e56536
--- /dev/null
+++ b/src/openvpn/check_file_access=2Eh
@@=
 -0,0 +1,40 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP net=
works
+ *             over a single UDP port, with support for SSL/TLS-base=
d
+ *             session authentication and key exchange,
+ *             =
packet encryption, packet authentication, and
+ *             packet compre=
ssion=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>=

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
+#ifndef CHECK_FILE_ACCESS_H
+#define CHECK_FILE_A=
CCESS_H
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#ifndef E=
NABLE_SMALL
+
+#include "options=2Eh"
+
+bool check_cmd_access(const char *=
command, const char *opt, const char *chroot);
+
+void options_postprocess_=
filechecks(struct options *options);
+
+#endif /* !ENABLE_SMALL */
+
+#endi=
f
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 30a1=
029=2E=2E3382138 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opt=
ions=2Ec
@@ -63,6 +63,7 @@
 #include "tun_afunix=2Eh"
 #include "domain_hel=
per=2Eh"
 #include "mbuf=2Eh"
+#include "check_file_access=2Eh"
 
 #include=
 <ctype=2Eh>
 
@@ -3344,340 +3345,6 @@
 }
 
 /*
- *  Check file/directory s=
anity
- *
- */
-/* Expect people using the stripped down version to know wh=
at they do */
-#ifndef ENABLE_SMALL
-
-#define CHKACC_FILE       (1 << 0) /=
**< Check for a file/directory presence */
-#define CHKACC_DIRPATH    (1 <<=
 1) /**< Check for directory presence where a file should reside */
-#defin=
e CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writable? */
-#defi=
ne CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed and "=
exists" */
-#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private) =
file is group/others accessible */
-#define CHKACC_ACCEPT_URI (1 << 5) /**<=
 Do not check URIs, unless they start with file: */
-
-static bool
-check_f=
ile_access(const int type, const char *file, const int mode, const char *op=
t)
-{
-    int errcode =3D 0;
-
-    /* If no file configured, no errors to=
 look for */
-    if (!file)
-    {
-        return false;
-    }
-
-    /*=
 If stdin is allowed and the file name is 'stdin', then do no
-     * furth=
er checks as stdin is always available
-     */
-    if ((type & CHKACC_ACP=
TSTDIN) && streq(file, "stdin"))
-    {
-        return false;
-    }
-
-  =
  /* file name is a URI if its first segment  has ":" (i=2Ee=2E, before any=
 "/")
-     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI d=
oes not start with "file:"
-     */
-    if ((type & CHKACC_ACCEPT_URI) && =
strchr(file, ':'))
-    {
-        if (!strncmp(file, "file:", 5))
-       =
 {
-            file +=3D 5;
-        }
-        else if (!strchr(file, '/'=
) || strchr(file, '/') > strchr(file, ':'))
-        {
-            return =
false;
-        }
-    }
-
-    /* Is the directory path leading to the giv=
en file accessible? */
-    if (type & CHKACC_DIRPATH)
-    {
-        char=
 *fullpath =3D
-            string_alloc(file, NULL); /* POSIX dirname() im=
plementation may modify its arguments */
-        const char *dirpath =3D d=
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerri=
t-Change-Number: 1774
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-C=
C: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--Jb8MjhkNl7U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">options: Factor out file access code from options=2Ec<br><br>op=
tions=2Ec is a huge, unwieldly file=2E So remove some<br>closely related co=
de that has no direct dependencies<br>with the other functions in the file=
=2E<br><br>This time it is the code that checks file accessibility=2E<br><b=
r>Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e<br>Signed-off-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etx=
t<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/check_file_access=2Ec<br>=
A src/openvpn/check_file_access=2Eh<br>M src/openvpn/options=2Ec<br>5 files=
 changed, 416 insertions(+), 334 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>inde=
x d7a5e08=2E=2E6c66ebd 100644</span><br><span>--- a/CMakeLists=2Etxt</span>=
<br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -431,6 +431,8 @@</span>=
<br><span>     src/openvpn/basic=2Eh</span><br><span>     src/openvpn/buffe=
r=2Ec</span><br><span>     src/openvpn/buffer=2Eh</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_=
access=2Eh</span><br><span>     src/openvpn/circ_list=2Eh</span><br><span> =
    src/openvpn/clinat=2Ec</span><br><span>     src/openvpn/clinat=2Eh</spa=
n><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam</span><br><span>index 4650ddd=2E=2E182d732 100644</span><br><span>---=
 a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Ea=
m</span><br><span>@@ -47,6 +47,7 @@</span><br><span> 	base64=2Ec base64=2Eh=
 \</span><br><span> 	basic=2Eh \</span><br><span> 	buffer=2Ec buffer=2Eh \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	check_file_access=
=2Ec check_file_access=2Eh \</span><br><span> 	circ_list=2Eh \</span><br><s=
pan> 	clinat=2Ec clinat=2Eh \</span><br><span> 	common=2Eh \</span><br><spa=
n>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_a=
ccess=2Ec</span><br><span>new file mode 100644</span><br><span>index 000000=
0=2E=2E08515ea</span><br><span>--- /dev/null</span><br><span>+++ b/src/open=
vpn/check_file_access=2Ec</span><br><span>@@ -0,0 +1,372 @@</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP =
networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    over a single UDP port, with support for SSL/TLS-based</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticatio=
n and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet encryption, packet authentication, and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  Copyright (C) 2008-2026 David Sommerseth &lt;dazo@eureph=
ia=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free=
 software; you can redistribute it and/or modify</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publ=
ic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  as published by the Free Software Foundation=2E</span><br><span style=
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
color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  Check file/directory sanity</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Expect people using the =
stripped down version to know what they do */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;argv=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;ssl_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;str=
ing=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILE       (=
1 &lt;&lt; 0) /**&lt; Check for a file/directory presence */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_DIRPATH    (1 &lt;&=
lt; 1) /**&lt; Check for directory presence where a file should reside */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILEXS=
TWR  (1 &lt;&lt; 2) /**&lt; If file exists, is it writable? */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN  (1 &lt=
;&lt; 3) /**&lt; If filename is stdin, it&#39;s allowed and &quot;exists&qu=
ot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKAC=
C_PRIVATE    (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is group/ot=
hers accessible */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless t=
hey start with file: */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_file_access(const=
 int type, const char *file, const int mode, const char *opt)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int errcode =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* If no file configured, no errors to look for */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!file)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
If stdin is allowed and the file name is &#39;stdin&#39;, then do no</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * further checks as s=
tdin is always available</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
((type &amp; CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* file name is a URI if its first segment  has &quot;:&quot; =
(i=2Ee=2E, before any &quot;/&quot;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * Then no checks done if CHKACC_ACCEPT_URI is set and=
 the URI does not start with &quot;file:&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&amp; strchr(fil=
e, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strn=
cmp(file, &quot;file:&quot;, 5))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            file +=3D 5;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else if (!strchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39;) &gt;=
 strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Is the directory path leading to=
 the given file accessible? */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (type &amp; CHKACC_DIRPATH)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        char *fullpath =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            string_alloc(file, NULL); /* POSIX dirname()=
 implementation may modify its arguments */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const char *dirpath =3D dirname(fullpath);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (platform_access(dirpath, mo=
de | X_OK) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 errcode =3D errno;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fr=
ee(fullpath);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Is the file itself accessible? *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!errcode &=
amp;&amp; (type &amp; CHKACC_FILE) &amp;&amp; (platform_access(file, mode) =
!=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        errcode =3D errno=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* If the file exists and is accessible, is it =
writable? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!errcode &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (platform_acc=
ess(file, F_OK) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (platform_access(file, W_OK) !=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            errcode =3D errno;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Warn if a give=
n private file is group/others accessible=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (type &amp; CHKACC_PRIVATE)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        platform_stat_t st;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (platform_stat(file, &amp;s=
t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M=
_ERRNO, &quot;WARNING: cannot stat file &#39;%s&#39;&quot;, file);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (st=2Est_mode &amp; (S_IRWXG | S_IRWXO))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN, =
&quot;WARNING: file &#39;%s&#39; is group or others accessible&quot;, file)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Scream if an error is found */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (errcode &gt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, &quot;%s fails with &#39;%s=
&#39;&quot;, opt, file);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Return true if an err=
or occurred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn (errcode !=3D 0 ? true : false);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** A wrapper for =
check_file_access() which also takes a chroot directory=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * If chroot is NULL, behaviour is e=
xactly the same as calling check_file_access() directly,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * otherwise it will look for the file=
 inside the given chroot directory instead=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+check_file_access_chroot(const char *chroot, const int type, const char *=
file, const int mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                         const char *opt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If=
 no file configured, no errors to look for */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!file)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If chroot is set,=
 look for the file/directory inside the chroot */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (chroot)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer chroot_file;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        chroot_file =3D prepend_dir(chroot, f=
ile, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ret =3D check_file_access(type, BSTR(&amp;chroot_file), mode, opt);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* No chroot in play, just call core file check=
 function */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 ret =3D check_file_access(type, file, mode, opt);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * A wrapper for check_file_access_chroo=
t() that returns false immediately if</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * the file is inline (and therefore there is no access t=
o check)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+check_file_access_chroot_inline(boo=
l is_inline, const char *chroot, const int type,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                const char *fi=
le, const int mode, const char *opt)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return check_file_access_chroot(chroot, typ=
e, file, mode, opt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * A wrapper for check_file_access() that returns fa=
lse immediately if the file</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * is inline (and therefore there is no access to check)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+check_file_access_inline(bool is_inline, const int typ=
e, const char *file, const int mode,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                         const char *opt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (is_inline)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return check_file_acc=
ess(type, file, mode, opt);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Verifies that the path in the &quot;comman=
d&quot; that comes after certain script options (e=2Eg=2E, --up) is a</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * valid file with approp=
riate permissions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * &quot;command=
&quot; consists of a path, optionally followed by a space, which may be</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * followed by arbitrar=
y arguments=2E It is NOT a full shell command line -- shell expansion is no=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * performed=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * The path and arguments in &quot;comm=
and&quot; may be single- or double-quoted or escaped=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * The path is extracted from &quot;command&quot;, then =
check_file_access() is called to check it=2E The</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * arguments, if any, are ignored=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Note that the type, mode, and opt arguments=
 to this routine are the same as the corresponding</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * check_file_access() arguments=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+check_cmd_access(const char *command, const char *opt, cons=
t char *chroot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv argv;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool return_code=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* If no command was set, there a=
re no errors to look for */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!command)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Extract executable path and argu=
ments */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv =
=3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
argv_parse_cmd(&amp;argv, command);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* if an executable is specified then check it; otherwise, complain */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (argv=2Eargv[0])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* Scripts requires R_OK =
as well, but that might fail on binaries which</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * only requires X_OK to function on Uni=
x - a scenario not unlikely to</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * be seen on suid binaries=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return_code =3D check_file_access_chroot(chro=
ot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
NOPREFIX | M_OPTERR, &quot;%s fails with &#39;%s&#39;: No path to executabl=
e=2E&quot;, opt, command);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return_code =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&a=
mp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return return_code;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Sanity check of all file/dir options=2E  Checks that file/dir</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * is accessible by OpenVPN</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+options_postprocess_filechecks(struct options *options=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool errs =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* ** SSL/TLS/crypto related files ** */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_=
access_inline(options-&gt;dh_file_inline, CHKACC_FILE, options-&gt;dh_file,=
 R_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                        &quot;--dh&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!options-&gt;verify_hash_no_ca)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        errs |=3D check_file_access_inline(options-&gt;ca_file_in=
line, CHKACC_FILE, options-&gt;ca_file,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                         R_OK, &quot;--=
ca&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(op=
tions-&gt;chroot_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
    &quot;--capath&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=
=3D check_file_access_inline(options-&gt;cert_file_inline, CHKACC_FILE | CH=
KACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                  options-&gt;cert_file, R_OK, &quot;--cert=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acces=
s_inline(options-&gt;extra_certs_file, CHKACC_FILE,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                     opti=
ons-&gt;extra_certs_file, R_OK, &quot;--extra-certs&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!(options-&gt;management_flags &amp; MF_EXTERN=
AL_KEY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_f=
ile_access_inline(options-&gt;priv_key_file_inline,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                         opti=
ons-&gt;priv_key_file, R_OK, &quot;--key&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
errs |=3D check_file_access_inline(options-&gt;pkcs12_file_inline, CHKACC_F=
ILE | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                     options-&gt;pkcs12_file, R_OK, &quot=
;--pkcs12&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;s=
sl_flags &amp; SSLF_CRL_VERIFY_DIR)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        errs |=3D check_file_access_chroot(options-&gt;chroot_dir, CHKACC=
_FILE, options-&gt;crl_file,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                         R_OK | X_OK, &quot;--crl-=
verify directory&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            check_file_access_chroot=
_inline(options-&gt;crl_file_inline, options-&gt;chroot_dir,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
          CHKACC_FILE, options-&gt;crl_file, R_OK, &quot;--crl-verify&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (options-&gt;tls_export_peer_cert_dir)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        errs |=3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            check_file_access_chroot(opt=
ions-&gt;chroot_dir, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                     options-&gt;tls_export_p=
eer_cert_dir, W_OK, &quot;--tls-export-cert&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(options-&gt;connection_list);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; options-&gt;connection_l=
ist-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const st=
ruct connection_entry *ce =3D options-&gt;connection_list-&gt;array[i];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inlin=
e(ce-&gt;tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
       ce-&gt;tls_auth_file, R_OK, &quot;--tls-auth&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access=
_inline(ce-&gt;tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
              ce-&gt;tls_crypt_file, R_OK, &quot;--tls-crypt&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_fi=
le_access_inline(ce-&gt;tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIV=
ATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                          ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt=
-v2&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    errs |=3D</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        check_file_access_inline(options-&gt;sh=
ared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                 options=
-&gt;shared_secret_file, R_OK, &quot;--secret&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILE=
XSTWR, options-&gt;packet_id_file,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                              R_OK | W_OK, &quot;--replay-pe=
rsist&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** Password files =
** */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D =
check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  options-&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        check_file_access(CHKACC_FILE=
 | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                          options-&gt;management_user_pas=
s, R_OK, &quot;--management user/password file&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acce=
ss_inline(options-&gt;auth_user_pass_file_inline,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                     CHKACC_F=
ILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                     options-&gt;auth_=
user_pass_file, R_OK, &quot;--auth-user-pass&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* ** System related ** */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_acces=
s(CHKACC_FILE, options-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot director=
y&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=
=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writep=
id, R_OK | W_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                           &quot;--writepid&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* ** Log related ** */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_DIRPATH | CHK=
ACC_FILEXSTWR, options-&gt;status_file, R_OK | W_OK,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              &quot;--sta=
tus&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** Config related **=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D ch=
eck_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;cli=
ent_config_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                 R_OK | X_OK, &quot;--client-config-dir&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D c=
heck_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;tm=
p_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                        R_OK | W_OK | X_OK, &quot;Temporary directory (--tm=
p-dir)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (errs)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Please correct th=
ese errors=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif /* !ENABLE_SMALL */</span><br><span>diff -=
-git a/src/openvpn/check_file_access=2Eh b/src/openvpn/check_file_access=2E=
h</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E7=
e56536</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/chec=
k_file_access=2Eh</span><br><span>@@ -0,0 +1,40 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single UDP port, with support for SSL/TLS-based</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             session authentication and key=
 exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope t=
hat it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=
=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CHECK_FILE_ACCESS_H</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHECK_FILE_ACCE=
SS_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol check_cmd_access(const char *command, const char *opt, const char *chroo=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void options_postprocess_filechecks=
(struct options *options);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !E=
NABLE_SMALL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>d=
iff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><sp=
an>index 30a1029=2E=2E3382138 100644</span><br><span>--- a/src/openvpn/opti=
ons=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -6=
3,6 +63,7 @@</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br=
><span> #include &quot;domain_helper=2Eh&quot;</span><br><span> #include &q=
uot;mbuf=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;check_file_access=2Eh&quot;</span><br><span> </span><br><span=
> #include &lt;ctype=2Eh&gt;</span><br><span> </span><br><span>@@ -3344,340=
 +3345,6 @@</span><br><span> }</span><br><span> </span><br><span> /*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  Check file/directory san=
ity</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/* Expect people using the stripped down version to kno=
w what they do */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifn=
def ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILE       =
(1 &lt;&lt; 0) /**&lt; Check for a file/directory presence */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_DIRPATH    (1 &lt;&l=
t; 1) /**&lt; Check for directory presence where a file should reside */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_FILEXSTWR=
  (1 &lt;&lt; 2) /**&lt; If file exists, is it writable? */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_ACPTSTDIN  (1 &lt;&lt;=
 3) /**&lt; If filename is stdin, it&#39;s allowed and &quot;exists&quot; *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CHKACC_PRIVA=
TE    (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is group/others ac=
cessible */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CH=
KACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unless they start=
 with file: */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-check_file_access(const int type, cons=
t char *file, const int mode, const char *opt)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int errcode =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If no fi=
le configured, no errors to look for */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!file)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* If stdin is allowed and the file na=
me is &#39;stdin&#39;, then do no</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * further checks as stdin is always available</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_ACPTSTDIN) &amp;&amp;=
 streq(file, &quot;stdin&quot;))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* file name is a URI if its first seg=
ment  has &quot;:&quot; (i=2Ee=2E, before any &quot;/&quot;)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     * Then no checks done if CHKACC=
_ACCEPT_URI is set and the URI does not start with &quot;file:&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if ((type &amp; CHKACC_ACCEPT_URI) &am=
p;&amp; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (!strncmp(file, &quot;file:&quot;, 5))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            file +=3D 5;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        else if (!strchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39;=
) &gt; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            return false;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Is the directory path leading to the=
 given file accessible? */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (type &amp; CHKACC_DIRPATH)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        char *fullpath =3D</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            string_alloc(file, NULL); /* POSIX dirname() implementat=
ion may modify its arguments */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        const char *dirpath =3D dirname(fullpath);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (platform_access(dirpath, mode | X_OK) !=3D 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            errcode =3D errno;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        free(fullpath);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* Is the file itself accessible? */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHKACC_FILE)=
 &amp;&amp; (platform_access(file, mode) !=3D 0))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        errcode =3D errno;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If the file e=
xists and is accessible, is it writable? */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (type &amp; CHKACC_FILEXS=
TWR) &amp;&amp; (platform_access(file, F_OK) =3D=3D 0))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (platform_access(file, W_OK) !=3D 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
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
"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerr=
it-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>

</body></html>
--Jb8MjhkNl7U=--


--===============9102007658574090014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9102007658574090014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9102007658574090014==--

