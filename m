Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94913C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9McvccGEHCPnuGaQtxR99UmpR7iUI77Mdq9e3MFaRA=; b=BYj1KzQVaKKrgPzk9fc5upkTn6
	yZzkR/HLgavLqs0/grryjaMyGJFtkOxELgWvh11Hr2A2r8ZoEESljbZTXzFulPsneP7ixkPyIX+kH
	an7uVbEsZ3J9szlSUjy7REW3cu5ut/kA1hdUz2Ie+NSIeKMgE4X54gPVY++ZgaKrS5wY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwinH-0004Kn-1q;
	Wed, 19 Aug 2026 16:05:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwinF-0004Kf-QX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 16:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=d1Fg2DNFm7FjQGzJesTU3tnbDMvpzy/sQ02/ZTdId7E=; b=R6mighFB6aK3DuUjmBdbGFUhiB
 6b5G7038ojvB+xitcADeC+1jP9V+GKpKHCI9tpbFJUw5bxEcJ72QWtePUOTdjKX6Ek46XRlBG3IRz
 xAyE5yhSX/XBJHL0d3maVHXK6kJ5MBKaHplgqcADVLmrkix+RRLxgro6VKwjw6K8Oc+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=d1Fg2DNFm7FjQGzJesTU3tnbDMvpzy/sQ02/ZTdId7E=; b=e
 VJ9Fpo9rTlUobx+tDlmO90CAKssvvwp4yExOFVmkVGAKwMDnhsZeFuTdDc7A0/POCVqWp/vYBKUEb
 RBOF/WgknGhSV0G1W66s6nzahvhqEP+mmD7BRoOtBh7q0xI62PKLcNMRM/LElTuC2cTmIwMB4u/7Z
 TBrCGeNemBqQDF8g=;
Received: from mail-lf1-f45.google.com ([209.85.167.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwinB-0000mU-DW for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 16:05:33 +0000
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b29599b81cso1685717e87.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787155523; x=1787760323; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d1Fg2DNFm7FjQGzJesTU3tnbDMvpzy/sQ02/ZTdId7E=;
 b=c81pMpUfJ/t/fhZZk36OmeBoVhMz60An2LhUi6SYkIkFkkA/MYrqWre0nr51omEIPN
 Wu+hQaHcgZLZ3r32Vj4B3FX5dtHl3ChuNUj05R2yN+D/t1RXde3JUo/wW86YH38s1uhG
 QMfCYwahEii/iLOLDURY9sq2M9IkBxW+xkFjaqleSzvyaeUNoulwCU/FNXnTIkl9sXAk
 dKQXG+h+hmOyXOoky8tDCmmjM1T1ZWOU9eMygVP7Q5kspWY/W6CsmE4EdUImSdKtXhXZ
 gRtzNSpZ6z4/U9T9sGmzGXIwrVgbyPzO9U7y2h3r1NYS26JFQg1ZrmXFM3XoxWXF3Jkp
 1s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787155523; x=1787760323;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=d1Fg2DNFm7FjQGzJesTU3tnbDMvpzy/sQ02/ZTdId7E=;
 b=IRhbcixcRLvgEE6vG+roe+xLVVp2Ad4IlO478jF6MaRfocbpE8jHqXqfpX8EBnZ5wO
 LkVpnqtOjFfaG/yD2CScn6nqmDuGD0wLi6HpxjjRN/jgs8v0TKfS2QsL3lHnj+BWRsVl
 xBPBNb3aeSvJ6AWSqa8VY9sP184PwhgluDCESGBCYp3wvcMoiKZsxpWgTnA/UdPKKdC4
 b3ZrxFoukgt/cm/qE1NF8u1p5eRt1HjLXTj0kjiBdy438cpqxOZObCFX9uaOchxklnJP
 t4Op4l8o2hbJOqe/G6EVG69GPSGTpUHa7xrdCnny6xCcsN7odGVUEyEhnIvl/J55DL7C
 tGjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpbk1rR+5LFDXdBIYQmnlA43qzQ0rs6rTaP9DIMkVRZC6D5NIj0ytTlbNYBjIQBAZ2/9sc7nkrIR97JsVg1@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxhSGRqZW6jvfCb4jMzJIuDatpa6QgT/Kj2EBahQnxq9qdfHK8Y
 tKDc3LLv3vOs4RGyl5U5PRmZ8/Okc3lCc6VmUQeQXzFJ+lQFRS3Ep7Bwfg4GsJgKLsVoUCmlaM2
 EtlU8WxSJD+FyKe+wWjD3NUzYBC5qwM20m1Ugr615d1fcFR2iCnKtgjCRSJ4KIjiQ+WMDV0fAZt
 RM1d6WHg==
X-Gm-Gg: AR+sD11dOTfSEgj7mTWyXJlS9tKMPlq7lCySBvNTMOOfttMo1q8T86gDzjP1+Yl+dBw
 ZVARwBRj6W2VCUBqkRV0/rQLjOy8aCIltAKz7RBRl4tCTWG9PP4IGFxBmiotja3WJe4GNhbmtZs
 y4ogqJaUG1GAD+T7syZLpSLDEEFW1Rhdms6sCf7pdtTswM4X92OMPQ5O3gTWYsz4Sw0CEri0XpF
 UYhVsgv+pa9q3d2ebbZyGvJEpaEXuSrYaOQJfyh08paHTIImJHVw/Vqgr+HZMZjSKtCSj7s7g0x
 i/0XgmAwcs7FDQW6bwurgXAlWpasuIW8Ek55uws1wvENja7062/Utv+Lk8EKoy5J5/5QTvyxy4/
 w3/eAWMiM4so2iXOTl50JTLknqruh6RXJAlCGI9KSuCvSNdLkifW+L0KbzhQzPnEOblg9gyp7vR
 Z7wJ8k4W4mLeW8qYz2CaW4LtzLnOf/Iy6TmPm3N4kdqrouo655w1f646gM8ve/IOFvykl7oqNh1
 j4fb3nSUMH0YUGUYxXe5EVkOVeJsTgkccLM0HGNX3a0NbxqApG3T06UoTNcrJ+Vq9Y0G89zdsR9
 Y88V0t8suPgEZ1F25ppYvGG05JfAEFI7F7+TOfO1G3OGmfMXCfE=
X-Received: by 2002:a05:6000:144d:b0:47f:9486:810b with SMTP id
 ffacd0b85a97d-482b1e91d3emr9186266f8f.7.1787153957225; 
 Wed, 19 Aug 2026 08:39:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c3775sm5501788f8f.26.2026.08.19.08.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:39:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:39:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: 3e9ac12d79222f17b2911a834dd5c473ec6578cb
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f272c7dce86784546b3b30baca60bdb6ba8651a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwinB-0000mU-DW
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
Content-Type: multipart/mixed; boundary="===============0567652003377111455=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0567652003377111455==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cbHx53mt0iU="; charset=UTF-8

--cbHx53mt0iU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail

to look at the new patch=
 set (#5)=2E


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
5 files changed, 418 insertions(+), 334 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/5

diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt
index 4375090=2E=2E2c3324d 100644
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
ex d607f80=2E=2E7fd12b4 100644
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
index 0000000=2E=2E83654b2
--- /dev/null
+++ b/src/openvpn/c=
heck_file_access=2Ec
@@ -0,0 +1,354 @@
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
+#include "check_file_access=2Eh"=

+
+#include "argv=2Eh"
+#include "buffer=2Eh"
+#include "error=2Eh"
+#incl=
ude "options=2Eh"
+#include "platform=2Eh"
+#include "ssl_common=2Eh"
+
+#i=
nclude <string=2Eh>
+
+#define CHKACC_FILE       (1 << 0) /**< Check for a =
file/directory presence */
+#define CHKACC_DIRPATH    (1 << 1) /**< Check f=
or directory presence where a file should reside */
+#define CHKACC_FILEXST=
WR  (1 << 2) /**< If file exists, is it writable? */
+#define CHKACC_ACPTST=
DIN  (1 << 3) /**< If filename is stdin, it's allowed and "exists" */
+#def=
ine CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private) file is group/ot=
hers accessible */
+#define CHKACC_ACCEPT_URI (1 << 5) /**< Do not check UR=
Is, unless they start with file: */
+
+static bool
+check_file_access(const=
 int type, const char *file, const int mode, const char *opt)
+{
+    int e=
rrcode =3D 0;
+
+    /* If no file configured, no errors to look for */
+  =
  if (!file)
+    {
+        return false;
+    }
+
+    /* If stdin is all=
owed and the file name is 'stdin', then do no
+     * further checks as std=
in is always available
+     */
+    if ((type & CHKACC_ACPTSTDIN) && streq=
(file, "stdin"))
+    {
+        return false;
+    }
+
+    /* file name i=
s a URI if its first segment  has ":" (i=2Ee=2E, before any "/")
+     * Th=
en no checks done if CHKACC_ACCEPT_URI is set and the URI does not start wi=
th "file:"
+     */
+    if ((type & CHKACC_ACCEPT_URI) && strchr(file, ':'=
))
+    {
+        if (!strncmp(file, "file:", 5))
+        {
+            =
file +=3D 5;
+        }
+        else if (!strchr(file, '/') || strchr(file=
, '/') > strchr(file, ':'))
+        {
+            return false;
+        =
}
+    }
+
+    /* Is the directory path leading to the given file accessib=
le? */
+    if (type & CHKACC_DIRPATH)
+    {
+        char *fullpath =3D
+=
            string_alloc(file, NULL); /* POSIX dirname() implementation may=
 modify its arguments */
+        const char *dirpath =3D dirname(fullpath)=
;
+
+        if (platform_access(dirpath, mode | X_OK) !=3D 0)
+        {
+=
            errcode =3D errno;
+        }
+        free(fullpath);
+    }
+=

+    /* Is the file itself accessible? */
+    if (!errcode && (type & CHK=
ACC_FILE) && (platform_access(file, mode) !=3D 0))
+    {
+        errcode =
=3D errno;
+    }
+
+    /* If the file exists and is accessible, is it wri=
table? */
+    if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_acces=
s(file, F_OK) =3D=3D 0))
+    {
+        if (platform_access(file, W_OK) !=
=3D 0)
+        {
+            errcode =3D errno;
+        }
+    }
+
+    =
/* Warn if a given private file is group/others accessible=2E */
+    if (t=
ype & CHKACC_PRIVATE)
+    {
+        platform_stat_t st;
+        if (plat=
form_stat(file, &st))
+        {
+            msg(M_WARN | M_ERRNO, "WARNIN=
G: cannot stat file '%s'", file);
+        }
+#ifndef _WIN32
+        else
=
+        {
+            if (st=2Est_mode & (S_IRWXG | S_IRWXO))
+          =
  {
+                msg(M_WARN, "WARNING: file '%s' is group or others acc=
essible", file);
+            }
+        }
+#endif
+    }
+
+    /* Scream =
if an error is found */
+    if (errcode > 0)
+    {
+        msg(M_NOPREFI=
X | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
+    }
+
+    /* =
Return true if an error occurred */
+    return (errcode !=3D 0 ? true : fa=
lse);
+}
+
+/** A wrapper for check_file_access() which also takes a chroot=
 directory=2E
+ * If chroot is NULL, behaviour is exactly the same as calli=
ng check_file_access() directly,
+ * otherwise it will look for the file in=
side the given chroot directory instead=2E
+ */
+static bool
+check_file_ac=
cess_chroot(const char *chroot, const int type, const char *file, const int=
 mode,
+                         const char *opt)
+{
+    bool ret =3D fals=
e;
+
+    /* If no file configured, no errors to look for */
+    if (!file=
)
+    {
+        return false;
+    }
+
+    /* If chroot is set, look for=
 the file/directory inside the chroot */
+    if (chroot)
+    {
+        s=
truct gc_arena gc =3D gc_new();
+        struct buffer chroot_file;
+
+    =
    chroot_file =3D prepend_dir(chroot, file, &gc);
+        ret =3D check_=
file_access(type, BSTR(&chroot_file), mode, opt);
+        gc_free(&gc);
+ =
   }
+    else
+    {
+        /* No chroot in play, just call core file ch=
eck function */
+        ret =3D check_file_access(type, file, mode, opt);
=
+    }
+    return ret;
+}
+
+/**
+ * A wrapper for check_file_access_chroo=
t() that returns false immediately if
+ * the file is inline (and therefore=
 there is no access to check)
+ */
+static bool
+check_file_access_chroot_i=
nline(bool is_inline, const char *chroot, const int type,
+                =
                const char *file, const int mode, const char *opt)
+{
+    =
if (is_inline)
+    {
+        return false;
+    }
+
+    return check_fil=
e_access_chroot(chroot, type, file, mode, opt);
+}
+
+/**
+ * A wrapper for=
 check_file_access() that returns false immediately if the file
+ * is inli=
ne (and therefore there is no access to check)
+ */
+static bool
+check_fil=
e_access_inline(bool is_inline, const int type, const char *file, const int=
 mode,
+                         const char *opt)
+{
+    if (is_inline)
+ =
   {
+        return false;
+    }
+
+    return check_file_access(type, fi=
le, mode, opt);
+}
+
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
+void
+options_post=
process_filechecks(struct options *options)
+{
+    bool errs =3D false;
+
=
+    /* ** SSL/TLS/crypto related files ** */
+    errs |=3D check_file_acc=
ess_inline(options->dh_file_inline, CHKACC_FILE, options->dh_file, R_OK,
+ =
                                    "--dh");
+
+    if (!options->verify_ha=
sh_no_ca)
+    {
+        errs |=3D check_file_access_inline(options->ca_fi=
le_inline, CHKACC_FILE, options->ca_file,
+                                =
         R_OK, "--ca");
+    }
+
+    errs |=3D check_file_access_chroot(op=
tions->chroot_dir, CHKACC_FILE, options->ca_path, R_OK,
+                  =
                   "--capath");
+
+    errs |=3D check_file_access_inline(o=
ptions->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
+               =
                      options->cert_file, R_OK, "--cert");
+
+    errs |=3D=
 check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
+        =
                             options->extra_certs_file, R_OK, "--extra-cert=
s");
+
+    if (!(options->management_flags & MF_EXTERNAL_KEY))
+    {
+   =
     errs |=3D check_file_access_inline(options->priv_key_file_inline,
+   =
                                      CHKACC_FILE | CHKACC_PRIVATE | CHKACC=
_ACCEPT_URI,
+                                         options->priv_key_fi=
le, R_OK, "--key");
+    }
+
+    errs |=3D check_file_access_inline(option=
s->pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                     =
                options->pkcs12_file, R_OK, "--pkcs12");
+
+    if (options=
->ssl_flags & SSLF_CRL_VERIFY_DIR)
+    {
+        errs |=3D check_file_acc=
ess_chroot(options->chroot_dir, CHKACC_FILE, options->crl_file,
+          =
                               R_OK | X_OK, "--crl-verify directory");
+   =
 }
+    else
+    {
+        errs |=3D
+            check_file_access_chroo=
t_inline(options->crl_file_inline, options->chroot_dir,
+                  =
                          CHKACC_FILE, options->crl_file, R_OK, "--crl-veri=
fy");
+    }
+
+    if (options->tls_export_peer_cert_dir)
+    {
+        =
errs |=3D
+            check_file_access_chroot(options->chroot_dir, CHKACC=
_FILE,
+                                     options->tls_export_peer_cert_=
dir, W_OK, "--tls-export-cert");
+    }
+
+    ASSERT(options->connection_l=
ist);
+    for (int i =3D 0; i < options->connection_list->len; ++i)
+    {=

+        const struct connection_entry *ce =3D options->connection_list->a=
rray[i];
+
+        errs |=3D check_file_access_inline(ce->tls_auth_file_in=
line, CHKACC_FILE | CHKACC_PRIVATE,
+                                      =
   ce->tls_auth_file, R_OK, "--tls-auth");
+        errs |=3D check_file_ac=
cess_inline(ce->tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+     =
                                    ce->tls_crypt_file, R_OK, "--tls-crypt"=
);
+        errs |=3D check_file_access_inline(ce->tls_crypt_v2_file_inline=
, CHKACC_FILE | CHKACC_PRIVATE,
+                                         c=
e->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
+    }
+
+    errs |=3D
+   =
     check_file_access_inline(options->shared_secret_file_inline, CHKACC_FI=
LE | CHKACC_PRIVATE,
+                                 options->shared_secr=
et_file, R_OK, "--secret");
+
+    errs |=3D check_file_access(CHKACC_DIRPA=
TH | CHKACC_FILEXSTWR, options->packet_id_file,
+                          =
    R_OK | W_OK, "--replay-persist");
+
+    /* ** Password files ** */
+  =
  errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVA=
TE,
+                              options->key_pass_file, R_OK, "--askpass=
");
+#ifdef ENABLE_MANAGEMENT
+    errs |=3D
+        check_file_access(CHK=
ACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                          op=
tions->management_user_pass, R_OK, "--management user/password file");
+#en=
dif /* ENABLE_MANAGEMENT */
+    errs |=3D check_file_access_inline(options=
->auth_user_pass_file_inline,
+                                     CHKACC_=
FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                                =
     options->auth_user_pass_file, R_OK, "--auth-user-pass");
+    /* ** Sy=
stem related ** */
+    errs |=3D check_file_access(CHKACC_FILE, options->c=
hroot_dir, R_OK | X_OK, "--chroot directory");
+    errs |=3D check_file_ac=
cess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid, R_OK | W_OK,
+  =
                            "--writepid");
+
+    /* ** Log related ** */
+=
    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-=
>status_file, R_OK | W_OK,
+                              "--status");
+
+ =
   /* ** Config related ** */
+    errs |=3D check_file_access_chroot(optio=
ns->chroot_dir, CHKACC_FILE, options->client_config_dir,
+                 =
                    R_OK | X_OK, "--client-config-dir");
+    errs |=3D che=
ck_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
+=
                                     R_OK | W_OK | X_OK, "Temporary directo=
ry (--tmp-dir)");
+
+    if (errs)
+    {
+        msg(M_USAGE, "Please cor=
rect these errors=2E");
+    }
+}
+
+#endif /* !ENABLE_SMALL */
diff --git =
a/src/openvpn/check_file_access=2Eh b/src/openvpn/check_file_access=2Eh
new=
 file mode 100644
index 0000000=2E=2Eb3ed886
--- /dev/null
+++ b/src/openvp=
n/check_file_access=2Eh
@@ -0,0 +1,60 @@
+/*
+ *  OpenVPN -- An application=
 to securely tunnel IP networks
+ *             over a single UDP port, wit=
h support for SSL/TLS-based
+ *             session authentication and key =
exchange,
+ *             packet encryption, packet authentication, and
+ *=
             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN=
 Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can =
redistribute it and/or modify
+ *  it under the terms of the GNU General Pu=
blic License version 2
+ *  as published by the Free Software Foundation=2E=

+ *
+ *  This program is distributed in the hope that it will be useful,
+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Gener=
al Public License for more details=2E
+ *
+ *  You should have received a c=
opy of the GNU General Public License along
+ *  with this program; if not,=
 see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef CHECK_FILE_ACCE=
SS_H
+#define CHECK_FILE_ACCESS_H
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#ifndef ENABLE_SMALL
+
+#include "options=2Eh"
+
+/**
+ * =
Verifies that the path in the "command" that comes after certain script opt=
ions (e=2Eg=2E, --up) is a
+ * valid file with appropriate permissions=2E
+=
 *
+ * "command" consists of a path, optionally followed by a space, which =
may be
+ * followed by arbitrary arguments=2E It is NOT a full shell comman=
d line -- shell expansion is not
+ * performed=2E
+ *
+ * The path and argu=
ments in "command" may be single- or double-quoted or escaped=2E
+ *
+ * Th=
e path is extracted from "command", then check_file_access() is called to c=
heck it=2E The
+ * arguments, if any, are ignored=2E
+ *
+ * Note that the =
type, mode, and opt arguments to this routine are the same as the correspon=
ding
+ * check_file_access() arguments=2E
+ */
+bool check_cmd_access(const=
 char *command, const char *opt, const char *chroot);
+
+/**
+ * Sanity che=
ck of all file/dir options=2E  Checks that file/dir
+ * is accessible by Op=
enVPN
+ */
+void options_postprocess_filechecks(struct options *options);
+=

+#endif /* !ENABLE_SMALL */
+
+#endif /* CHECK_FILE_ACCESS_H */
diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index f5163d6=2E=2E9f0=
60e3 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ =
-63,6 +63,7 @@
 #include "tun_afunix=2Eh"
 #include "domain_helper=2Eh"
 #i=
nclude "mbuf=2Eh"
+#include "check_file_access=2Eh"
 
 #include <ctype=2Eh>=

 
@@ -3328,340 +3329,6 @@
 }
 
 /*
- *  Check file/directory sanity
- *
- =
*/
-/* Expect people using the stripped down version to know what they do *=
/
-#ifndef ENABLE_SMALL
-
-#define CHKACC_FILE       (1 << 0) /**< Check fo=
r a file/directory presence */
-#define CHKACC_DIRPATH    (1 << 1) /**< Che=
ck for directory presence where a file should reside */
-#define CHKACC_FIL=
EXSTWR  (1 << 2) /**< If file exists, is it writable? */
-#define CHKACC_AC=
PTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed and "exists" */
-=
#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private) file is grou=
p/others accessible */
-#define CHKACC_ACCEPT_URI (1 << 5) /**< Do not chec=
k URIs, unless they start with file: */
-
-static bool
-check_file_access(c=
onst int type, const char *file, const int mode, const char *opt)
-{
-    i=
nt errcode =3D 0;
-
-    /* If no file configured, no errors to look for */=

-    if (!file)
-    {
-        return false;
-    }
-
-    /* If stdin is=
 allowed and the file name is 'stdin', then do no
-     * further checks as=
 stdin is always available
-     */
-    if ((type & CHKACC_ACPTSTDIN) && s=
treq(file, "stdin"))
-    {
-        return false;
-    }
-
-    /* file na=
me is a URI if its first segment  has ":" (i=2Ee=2E, before any "/")
-     =
* Then no checks done if CHKACC_ACCEPT_URI is set and the URI does not star=
t with "file:"
-     */
-    if ((type & CHKACC_ACCEPT_URI) && strchr(file,=
 ':'))
-    {
-        if (!strncmp(file, "file:", 5))
-        {
-        =
    file +=3D 5;
-        }
-        else if (!strchr(file, '/') || strchr(=
file, '/') > strchr(file, ':'))
-        {
-            return false;
-    =
    }
-    }
-
-    /* Is the directory path leading to the given file acce=
ssible? */
-    if (type & CHKACC_DIRPATH)
-    {
-        char *fullpath =
=3D
-            string_alloc(file, NULL); /* POSIX dirname() implementatio=
n may modify its arguments */
-        char *dirpath =3D dirname(fullpath);=

-
-        if (platform_access(dirpath, mode | X_OK) !=3D 0)
-        {
- =
           errcode =3D errno;
-        }
-        free(fullpath);
-    }
-
=
-    /* Is the file itself accessible? */
-    if (!errcode && (type & CHKA=
CC_FILE) && (platform_access(file, mode) !=3D 0))
-    {
-        errcode =
=3D errno;
-    }
-
-    /* If the file exists and is accessible, is it wri=
table? */
-    if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_acces=
s(file, F_OK) =3D=3D 0))
-    {
-        if (platform_access(file, W_OK) !=
=3D 0)
-        {
-            errcode =3D errno;
-        }
-    }
-
-    =
/* Warn if a given private file is group/others accessible=2E */
-    if (t=
ype & CHKACC_PRIVATE)
-    {
-        platform_stat_t st;
-        if (plat=
form_stat(file, &st))
-        {
-            msg(M_WARN | M_ERRNO, "WARNIN=
G: cannot stat file '%s'", file);
-        }
-#ifndef _WIN32
-        else
=
-        {
-            if (st=2Est_mode & (S_IRWXG | S_IRWXO))
-          =
  {
-                msg(M_WARN, "WARNING: file '%s' is group or others acc=
essible", file);
-            }
-        }
-#endif
-    }
-
-    /* Scream =
if an error is found */
-    if (errcode > 0)
-    {
-        msg(M_NOPREFI=
X | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
-    }
-
-    /* =
Return true if an error occurred */
-    return (errcode !=3D 0 ? true : fa=
lse);
-}
-
-/* A wrapper for check_file_access() which also takes a chroot =
directory=2E
- * If chroot is NULL, behaviour is exactly the same as callin=
g check_file_access() directly,
- * otherwise it will look for the file ins=
ide the given chroot directory instead=2E
- */
-static bool
-check_file_acc=
ess_chroot(const char *chroot, const int type, const char *file, const int =
mode,
-                         const char *opt)
-{
-    bool ret =3D false=
;
-
-    /* If no file configured, no errors to look for */
-    if (!file)=

-    {
-        return false;
-    }
-
-    /* If chroot is set, look for =
the file/directory inside the chroot */
-    if (chroot)
-    {
-        st=
ruct gc_arena gc =3D gc_new();
-        struct buffer chroot_file;
-
-     =
   chroot_file =3D prepend_dir(chroot, file, &gc);
-        ret =3D check_f=
ile_access(type, BSTR(&chroot_file), mode, opt);
-        gc_free(&gc);
-  =
  }
-    else
-    {
-        /* No chroot in play, just call core file che=
ck function */
-        ret =3D check_file_access(type, file, mode, opt);
-=
    }
-    return ret;
-}
-
-/**
- * A wrapper for check_file_access_chroot=
() that returns false immediately if
- * the file is inline (and therefore =
there is no access to check)
- */
-static bool
-check_file_access_chroot_in=
line(bool is_inline, const char *chroot, const int type,
-                 =
               const char *file, const int mode, const char *opt)
-{
-    i=
f (is_inline)
-    {
-        return false;
-    }
-
-    return check_file=
_access_chroot(chroot, type, file, mode, opt);
-}
-
-/**
- * A wrapper for =
check_file_access() that returns false immediately if the file
- * is inlin=
e (and therefore there is no access to check)
- */
-static bool
-check_file=
_access_inline(bool is_inline, const int type, const char *file, const int =
mode,
-                         const char *opt)
-{
-    if (is_inline)
-  =
  {
-        return false;
-    }
-
-    return check_file_access(type, fil=
e, mode, opt);
-}
-
-/*
- * Verifies that the path in the "command" that co=
mes after certain script options (e=2Eg=2E, --up) is a
- * valid file with =
appropriate permissions=2E
- *
- * "command" consists of a path, optionally=
 followed by a space, which may be
- * followed by arbitrary arguments=2E I=
t is NOT a full shell command line -- shell expansion is not
- * performed=
=2E
- *
- * The path and arguments in "command" may be single- or double-qu=
oted or escaped=2E
- *
- * The path is extracted from "command", then check=
_file_access() is called to check it=2E The
- * arguments, if any, are igno=
red=2E
- *
- * Note that the type, mode, and opt arguments to this routine =
are the same as the corresponding
- * check_file_access() arguments=2E
- */=

-static bool
-check_cmd_access(const char *command, const char *opt, const=
 char *chroot)
-{
-    struct argv argv;
-    bool return_code;
-
-    /* I=
f no command was set, there are no errors to look for */
-    if (!command)=

-    {
-        return false;
-    }
-
-    /* Extract executable path and=
 arguments */
-    argv =3D argv_new();
-    argv_parse_cmd(&argv, command)=
;
-
-    /* if an executable is specified then check it; otherwise, complai=
n */
-    if (argv=2Eargv[0])
-    {
-        /* Scripts requires R_OK as w=
ell, but that might fail on binaries which
-         * only requires X_OK t=
o function on Unix - a scenario not unlikely to
-         * be seen on suid=
 binaries=2E
-         */
-        return_code =3D check_file_access_chroot=
(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);
-    }
-    else
-    {
-=
        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No path to executab=
le=2E", opt, command);
-        return_code =3D true;
-    }
-
-    argv_fr=
ee(&argv);
-
-    return return_code;
-}
-
-/*
- * Sanity check of all file=
/dir options=2E  Checks that file/dir
- * is accessible by OpenVPN
- */
-st=
atic void
-options_postprocess_filechecks(struct options *options)
-{
-    =
bool errs =3D false;
-
-    /* ** SSL/TLS/crypto related files ** */
-    e=
rrs |=3D check_file_access_inline(options->dh_file_inline, CHKACC_FILE, opt=
ions->dh_file, R_OK,
-                                     "--dh");
-
-    =
if (!options->verify_hash_no_ca)
-    {
-        errs |=3D check_file_acces=
s_inline(options->ca_file_inline, CHKACC_FILE, options->ca_file,
-         =
                                R_OK, "--ca");
-    }
-
-    errs |=3D chec=
k_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_=
OK,
-                                     "--capath");
-
-    errs |=3D che=
ck_file_access_inline(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEP=
T_URI,
-                                     options->cert_file, R_OK, "--c=
ert");
-
-    errs |=3D check_file_access_inline(options->extra_certs_file,=
 CHKACC_FILE,
-                                     options->extra_certs_fi=
le, R_OK, "--extra-certs");
-
-    if (!(options->management_flags & MF_EXT=
ERNAL_KEY))
-    {
-        errs |=3D check_file_access_inline(options->pri=
v_key_file_inline,
-                                         CHKACC_FILE | =
CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
-                                      =
   options->priv_key_file, R_OK, "--key");
-    }
-
-    errs |=3D check_fi=
le_access_inline(options->pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,=

-                                     options->pkcs12_file, R_OK, "--pkcs1=
2");
-
-    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-    {
-        e=
rrs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options=
->crl_file,
-                                         R_OK | X_OK, "--crl-v=
erify directory");
-    }
-    else
-    {
-        errs |=3D
-            =
check_file_access_chroot_inline(options->crl_file_inline, options->chroot_d=
ir,
-                                            CHKACC_FILE, options->crl_=
file, R_OK, "--crl-verify");
-    }
-
-    if (options->tls_export_peer_cer=
t_dir)
-    {
-        errs |=3D
-            check_file_access_chroot(opti=
ons->chroot_dir, CHKACC_FILE,
-                                     options=
->tls_export_peer_cert_dir, W_OK, "--tls-export-cert");
-    }
-
-    ASSER=
T(options->connection_list);
-    for (int i =3D 0; i < options->connection=
_list->len; ++i)
-    {
-        struct connection_entry *ce =3D options->c=
onnection_list->array[i];
-
-        errs |=3D check_file_access_inline(ce-=
>tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                     =
                    ce->tls_auth_file, R_OK, "--tls-auth");
-        errs |=
=3D check_file_access_inline(ce->tls_crypt_file_inline, CHKACC_FILE | CHKAC=
C_PRIVATE,
-                                         ce->tls_crypt_file, R_=
OK, "--tls-crypt");
-        errs |=3D check_file_access_inline(ce->tls_cry=
pt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                         =
                ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
-    }
-
- =
   errs |=3D
-        check_file_access_inline(options->shared_secret_file_=
inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                 opt=
ions->shared_secret_file, R_OK, "--secret");
-
-    errs |=3D check_file_ac=
cess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
-         =
                     R_OK | W_OK, "--replay-persist");
-
-    /* ** Passwor=
d files ** */
-    errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTD=
IN | CHKACC_PRIVATE,
-                              options->key_pass_file,=
 R_OK, "--askpass");
-#ifdef ENABLE_MANAGEMENT
-    errs |=3D
-        chec=
k_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-           =
               options->management_user_pass, R_OK, "--management user/pass=
word file");
-#endif /* ENABLE_MANAGEMENT */
-    errs |=3D check_file_acce=
ss_inline(options->auth_user_pass_file_inline,
-                           =
          CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-               =
                      options->auth_user_pass_file, R_OK, "--auth-user-pass=
");
-    /* ** System related ** */
-    errs |=3D check_file_access(CHKACC=
_FILE, options->chroot_dir, R_OK | X_OK, "--chroot directory");
-    errs |=
=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid,=
 R_OK | W_OK,
-                              "--writepid");
-
-    /* ** Lo=
g related ** */
-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FI=
LEXSTWR, options->status_file, R_OK | W_OK,
-                              =
"--status");
-
-    /* ** Config related ** */
-    errs |=3D check_file_ac=
cess_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
-=
                                     R_OK | X_OK, "--client-config-dir");
-=
    errs |=3D check_file_access_chroot(options->chroot_dir, CHKACC_FILE, op=
tions->tmp_dir,
-                                     R_OK | W_OK | X_OK, "=
Temporary directory (--tmp-dir)");
-
-    if (errs)
-    {
-        msg(M_U=
SAGE, "Please correct these errors=2E");
-    }
-}
-#endif /* !ENABLE_SMALL=
 */
-
-/*
  * Sanity check on options=2E
  * Also set some options based on=
 other
  * options=2E

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1774?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerrit-Change-Number: 1774
G=
errit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--cbHx53mt0iU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http:/=
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
 changed, 418 insertions(+), 334 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/74/1774/5</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>inde=
x 4375090=2E=2E2c3324d 100644</span><br><span>--- a/CMakeLists=2Etxt</span>=
<br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -431,6 +431,8 @@</span>=
<br><span>     src/openvpn/basic=2Eh</span><br><span>     src/openvpn/buffe=
r=2Ec</span><br><span>     src/openvpn/buffer=2Eh</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_access=2Ec</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/check_file_=
access=2Eh</span><br><span>     src/openvpn/circ_list=2Eh</span><br><span> =
    src/openvpn/clinat=2Ec</span><br><span>     src/openvpn/clinat=2Eh</spa=
n><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam</span><br><span>index d607f80=2E=2E7fd12b4 100644</span><br><span>---=
 a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Ea=
m</span><br><span>@@ -47,6 +47,7 @@</span><br><span> 	base64=2Ec base64=2Eh=
 \</span><br><span> 	basic=2Eh \</span><br><span> 	buffer=2Ec buffer=2Eh \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	check_file_access=
=2Ec check_file_access=2Eh \</span><br><span> 	circ_list=2Eh \</span><br><s=
pan> 	clinat=2Ec clinat=2Eh \</span><br><span> 	common=2Eh \</span><br><spa=
n>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_a=
ccess=2Ec</span><br><span>new file mode 100644</span><br><span>index 000000=
0=2E=2E83654b2</span><br><span>--- /dev/null</span><br><span>+++ b/src/open=
vpn/check_file_access=2Ec</span><br><span>@@ -0,0 +1,354 @@</span><br><span=
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
>+#include &quot;check_file_access=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;argv=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;ssl_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt=
;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FILE    =
   (1 &lt;&lt; 0) /**&lt; Check for a file/directory presence */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_DIRPATH    (1 &=
lt;&lt; 1) /**&lt; Check for directory presence where a file should reside =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_FI=
LEXSTWR  (1 &lt;&lt; 2) /**&lt; If file exists, is it writable? */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define CHKACC_ACPTSTDIN  (1=
 &lt;&lt; 3) /**&lt; If filename is stdin, it&#39;s allowed and &quot;exist=
s&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define C=
HKACC_PRIVATE    (1 &lt;&lt; 4) /**&lt; Warn if this (private) file is grou=
p/others accessible */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not check URIs, unle=
ss they start with file: */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_file_access(c=
onst int type, const char *file, const int mode, const char *opt)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int errcode =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* If no file configured, no errors to look for */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!file)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* If stdin is allowed and the file name is &#39;stdin&#39;, then do no</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * further checks =
as stdin is always available</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if ((type &amp; CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* file name is a URI if its first segment  has &quot;:&=
quot; (i=2Ee=2E, before any &quot;/&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * Then no checks done if CHKACC_ACCEPT_URI is s=
et and the URI does not start with &quot;file:&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if ((type &amp; CHKACC_ACCEPT_URI) &amp;&amp; str=
chr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!strncmp(file, &quot;file:&quot;, 5))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            file +=3D 5;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else if (!strchr(file, &#39;/&#39;) || strchr(file, &#39;/&#39=
;) &gt; strchr(file, &#39;:&#39;))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Is the directory path lea=
ding to the given file accessible? */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (type &amp; CHKACC_DIRPATH)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char *fullpath =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            string_alloc(file, NULL); /* POSIX d=
irname() implementation may modify its arguments */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char *dirpath =3D dirname(f=
ullpath);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (platform_access(d=
irpath, mode | X_OK) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           errcode =3D errno;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        free(fullpath);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Is the file itself acc=
essible? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!errcode &amp;&amp; (type &amp; CHKACC_FILE) &amp;&amp; (platform_access(fi=
le, mode) !=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        errcode=
 =3D errno;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* If the file exists and is accessib=
le, is it writable? */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!errcode &amp;&amp; (type &amp; CHKACC_FILEXSTWR) &amp;&amp; (pl=
atform_access(file, F_OK) =3D=3D 0))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (platform_access(file, W_OK) !=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            errcode =3D errno;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wa=
rn if a given private file is group/others accessible=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (type &amp; CHKACC_PRIVATE)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        platform_stat_t st;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (platform_stat(=
file, &amp;st))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(M_WARN | M_ERRNO, &quot;WARNING: cannot stat file &#39;%s&#39;&quot;, fil=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (st=2Est_mode &amp; (S_IRWXG | S_=
IRWXO))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
g(M_WARN, &quot;WARNING: file &#39;%s&#39; is group or others accessible&qu=
ot;, file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Scream if an error is found */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (errcode &gt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, &quot;%s fails wi=
th &#39;%s&#39;&quot;, opt, file);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Return true=
 if an error occurred */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return (errcode !=3D 0 ? true : false);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** A wr=
apper for check_file_access() which also takes a chroot directory=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * If chroot is NULL, beha=
viour is exactly the same as calling check_file_access() directly,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * otherwise it will look fo=
r the file inside the given chroot directory instead=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check_file_access_chroot(const char *chroot, const int type, co=
nst char *file, const int mode,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         const char *opt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* If no file configured, no errors to look for */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!file)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If chro=
ot is set, look for the file/directory inside the chroot */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (chroot)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct buffer chroot_fil=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        chroot_file =3D prepend_dir(=
chroot, file, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ret =3D check_file_access(type, BSTR(&amp;chroot_file), mode, o=
pt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* No chroot in play, just call core fil=
e check function */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ret =3D check_file_access(type, file, mode, opt);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * A wrapper for check_file_acces=
s_chroot() that returns false immediately if</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * the file is inline (and therefore there is no a=
ccess to check)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+check_file_access_chroot_inl=
ine(bool is_inline, const char *chroot, const int type,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                const c=
har *file, const int mode, const char *opt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (is_inline)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return check_file_access_chroot(chro=
ot, type, file, mode, opt);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * A wrapper for check_file_access() that ret=
urns false immediately if the file</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * is inline (and therefore there is no access to check)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+check_file_access_inline(bool is_inline, const =
int type, const char *file, const int mode,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                         const char *opt)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (is_inline)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return check_f=
ile_access(type, file, mode, opt);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+check_cmd_access(const char *command,=
 const char *opt, const char *chroot)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct argv argv;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool return_code;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If no co=
mmand was set, there are no errors to look for */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!command)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Extract ex=
ecutable path and arguments */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    argv =3D argv_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    argv_parse_cmd(&amp;argv, command);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* if an executable is specified then check it; otherw=
ise, complain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (argv=2Eargv[0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Sc=
ripts requires R_OK as well, but that might fail on binaries which</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * only requires X_O=
K to function on Unix - a scenario not unlikely to</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * be seen on suid binaries=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return_code =3D check_fil=
e_access_chroot(chroot, CHKACC_FILE, argv=2Eargv[0], X_OK, opt);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_NOPREFIX | M_OPTERR, &quot;%s fails with &#39;%s&#39;: =
No path to executable=2E&quot;, opt, command);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return_code =3D true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    argv_free(&amp;argv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n return_code;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+options_postprocess_filechecks(struct options *options)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool errs =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* ** SSL/TLS/crypto related files ** */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_ac=
cess_inline(options-&gt;dh_file_inline, CHKACC_FILE, options-&gt;dh_file, R=
_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                      &quot;--dh&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!options-&gt;verify_hash_no_ca)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        errs |=3D check_file_access_inline(options-&gt;ca_file_inli=
ne, CHKACC_FILE, options-&gt;ca_file,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                         R_OK, &quot;--ca=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_chroot(optio=
ns-&gt;chroot_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
 &quot;--capath&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D c=
heck_file_access_inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_=
ACCEPT_URI,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                             options-&gt;cert_file, R_OK, &quot;--cert&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inl=
ine(options-&gt;extra_certs_file, CHKACC_FILE,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                     options-&gt=
;extra_certs_file, R_OK, &quot;--extra-certs&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_ac=
cess_inline(options-&gt;priv_key_file_inline,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                         CHKACC_F=
ILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                         options-&gt;=
priv_key_file, R_OK, &quot;--key&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=
=3D check_file_access_inline(options-&gt;pkcs12_file_inline, CHKACC_FILE | =
CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                 options-&gt;pkcs12_file, R_OK, &quot;--pkc=
s12&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;ssl_fla=
gs &amp; SSLF_CRL_VERIFY_DIR)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    errs |=3D check_file_access_chroot(options-&gt;chroot_dir, CHKACC_FILE,=
 options-&gt;crl_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                         R_OK | X_OK, &quot;--crl-verify=
 directory&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        errs |=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            check_file_access_chroot_inli=
ne(options-&gt;crl_file_inline, options-&gt;chroot_dir,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
     CHKACC_FILE, options-&gt;crl_file, R_OK, &quot;--crl-verify&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (options-&gt;tls_export_peer_cert_dir)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        errs |=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            check_file_access_chroot(opti=
ons-&gt;chroot_dir, CHKACC_FILE,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                     options-&gt;tls_export_pe=
er_cert_dir, W_OK, &quot;--tls-export-cert&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(options-&gt;connection_list);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (int i =3D 0; i &lt; options-&gt;connection_list=
-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struc=
t connection_entry *ce =3D options-&gt;connection_list-&gt;array[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inline(ce=
-&gt;tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
   ce-&gt;tls_auth_file, R_OK, &quot;--tls-auth&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_access_inl=
ine(ce-&gt;tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
          ce-&gt;tls_crypt_file, R_OK, &quot;--tls-crypt&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        errs |=3D check_file_a=
ccess_inline(ce-&gt;tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                      ce-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    errs |=3D</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        check_file_access_inline(options-&gt;shared=
_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 options-&gt=
;shared_secret_file, R_OK, &quot;--secret&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTW=
R, options-&gt;packet_id_file,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                              R_OK | W_OK, &quot;--replay-persis=
t&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* ** Password files ** *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D chec=
k_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                              op=
tions-&gt;key_pass_file, R_OK, &quot;--askpass&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        check_file_access(CHKACC_FILE | C=
HKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                          options-&gt;management_user_pass, R=
_OK, &quot;--management user/password file&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_i=
nline(options-&gt;auth_user_pass_file_inline,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                     CHKACC_FILE =
| CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                     options-&gt;auth_user=
_pass_file, R_OK, &quot;--auth-user-pass&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* ** System related ** */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access(CHK=
ACC_FILE, options-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot directory&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D c=
heck_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;writepid, R=
_OK | W_OK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                      &quot;--writepid&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* ** Log related ** */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FIL=
EXSTWR, options-&gt;status_file, R_OK | W_OK,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                              &quot;--status&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* ** Config related ** */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file=
_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_conf=
ig_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                         R_OK | X_OK, &quot;--client-config-dir&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_fil=
e_access_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                R_OK | W_OK | X_OK, &quot;Temporary directory (--tmp-dir)&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (errs)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Please correct these erro=
rs=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif /* !ENABLE_SMALL */</span><br><span>diff --git a/s=
rc/openvpn/check_file_access=2Eh b/src/openvpn/check_file_access=2Eh</span>=
<br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eb3ed886</=
span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/check_file_a=
ccess=2Eh</span><br><span>@@ -0,0 +1,60 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single=
 UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef CHECK_FILE_ACCESS_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define CHECK_FILE_ACCESS_H</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Verifies that the path=
 in the &quot;command&quot; that comes after certain script options (e=2Eg=
=2E, --up) is a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * v=
alid file with appropriate permissions=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * &quot;command&quot; consists of a path, optionally followed by a sp=
ace, which may be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 followed by arbitrary arguments=2E It is NOT a full shell command line -- =
shell expansion is not</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * performed=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The path and ar=
guments in &quot;command&quot; may be single- or double-quoted or escaped=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * The path is extracted from &qu=
ot;command&quot;, then check_file_access() is called to check it=2E The</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * arguments, if any, a=
re ignored=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Note that the type, =
mode, and opt arguments to this routine are the same as the corresponding</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * check_file_access(=
) arguments=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_cmd_access=
(const char *command, const char *opt, const char *chroot);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Sanity check of all file/dir options=2E  Checks that file/dir</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is accessible by OpenV=
PN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void options_postprocess_filechec=
ks(struct options *options);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
!ENABLE_SMALL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* CHECK_FILE_A=
CCESS_H */</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec</span><br><span>index f5163d6=2E=2E9f060e3 100644</span><br>=
<span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns=2Ec</span><br><span>@@ -63,6 +63,7 @@</span><br><span> #include &quot;tu=
n_afunix=2Eh&quot;</span><br><span> #include &quot;domain_helper=2Eh&quot;<=
/span><br><span> #include &quot;mbuf=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;check_file_access=2Eh&quot;</span=
><br><span> </span><br><span> #include &lt;ctype=2Eh&gt;</span><br><span> <=
/span><br><span>@@ -3328,340 +3329,6 @@</span><br><span> }</span><br><span>=
 </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  Check file/directory sanity</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Expect people using the =
stripped down version to know what they do */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define CHKACC_FILE       (1 &lt;&lt; 0) /**&lt; Check for a file/directo=
ry presence */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 CHKACC_DIRPATH    (1 &lt;&lt; 1) /**&lt; Check for directory presence wher=
e a file should reside */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define CHKACC_FILEXSTWR  (1 &lt;&lt; 2) /**&lt; If file exists, is it =
writable? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define C=
HKACC_ACPTSTDIN  (1 &lt;&lt; 3) /**&lt; If filename is stdin, it&#39;s allo=
wed and &quot;exists&quot; */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define CHKACC_PRIVATE    (1 &lt;&lt; 4) /**&lt; Warn if this (priv=
ate) file is group/others accessible */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define CHKACC_ACCEPT_URI (1 &lt;&lt; 5) /**&lt; Do not c=
heck URIs, unless they start with file: */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_file=
_access(const int type, const char *file, const int mode, const char *opt)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int errcode =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* If no file configured, no errors to look for */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!file)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If stdi=
n is allowed and the file name is &#39;stdin&#39;, then do no</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * further checks as stdin is a=
lways available</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((type &amp; =
CHKACC_ACPTSTDIN) &amp;&amp; streq(file, &quot;stdin&quot;))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* file na=
me is a URI if its first segment  has &quot;:&quot; (i=2Ee=2E, before any &=
quot;/&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * T=
hen no checks done if CHKACC_ACCEPT_URI is set and the URI does not start w=
ith &quot;file:&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((type =
&amp; CHKACC_ACCEPT_URI) &amp;&amp; strchr(file, &#39;:&#39;))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (!strncmp(file, &quot;file:&quot;, 5))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            file +=3D 5;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else if (!strchr(file, &#39;/&#39;)=
 || strchr(file, &#39;/&#39;) &gt; strchr(file, &#39;:&#39;))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Is the dir=
ectory path leading to the given file accessible? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (type &amp; CHKACC_DIRPATH)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        char *fullpath =3D</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            string_alloc(file, NULL); /* =
POSIX dirname() implementation may modify its arguments */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        char *dirpath =3D dirname(full=
path);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (platform_access(dirpath,=
 mode | X_OK) !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
errcode =3D errno;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(fu=
llpath);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* Is the file itself accessible? */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (ty=
pe &amp; CHKACC_FILE) &amp;&amp; (platform_access(file, mode) !=3D 0))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        errcode =3D errno;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* If the file exists and is accessible, is it writable? */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!errcode &amp;&amp; (typ=
e &amp; CHKACC_FILEXSTWR) &amp;&amp; (platform_access(file, F_OK) =3D=3D 0)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (platform_access(file, W_=
OK) !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            errcode =
=3D errno;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* Warn if a given private file is group/others accessib=
le=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (type =
&amp; CHKACC_PRIVATE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        platform=
_stat_t st;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (platform_stat(file, &amp;st))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_WARN | M_ERRNO, &quot;WARNING: cannot stat file &#39;%s&#39=
;&quot;, file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if (st=2Est_mode &amp; (S_IRWXG | =
S_IRWXO))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
M_WARN, &quot;WARNING: file &#39;%s&#39; is group or others accessible&quot=
;, file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Sc=
ream if an error is found */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (errcode &gt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_NOPREFIX | M_OPTERR | M_ERRNO, &quot;%s fails with &#39;%s&#39;&quot=
;, opt, file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* Return true if an error occurred */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (errcode !=
=3D 0 ? true : false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/* A wrapper for check_file_access() whi=
ch also takes a chroot directory=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * If chroot is NULL, behaviour is exactly the same as callin=
g check_file_access() directly,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * otherwise it will look for the file inside the given chroot di=
rectory instead=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-check_file_access_chroot(const =
char *chroot, const int type, const char *file, const int mode,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                         const ch=
ar *opt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* If no file configured, no errors to look for =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!file)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* If chroot is set, look for the file/directory inside the chroot */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (chroot)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer chroot_f=
ile;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        chroot_file =3D prepend_dir(ch=
root, file, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ret =3D check_file_access(type, BSTR(&amp;chroot_file), mode, opt);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* No chroot in play, just call core file check functi=
on */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D =
check_file_access(type, file, mode, opt);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * A wrapper for check_file_access_chroot() that returns fals=
e immediately if</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * th=
e file is inline (and therefore there is no access to check)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-check_file_access_chroot_inline(bool is_inline, const char *chro=
ot, const int type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                              const char *file, const int mode, const char =
*opt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (is_inline)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return check_=
file_access_chroot(chroot, type, file, mode, opt);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * A wrapper for check_file_ac=
cess() that returns false immediately if the file</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * is inline (and therefore there is no access =
to check)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-check_file_access_inline(bool is_inline,=
 const int type, const char *file, const int mode,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                         const char *opt)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (is_inline)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return check_file_acces=
s(type, file, mode, opt);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Verifies that the path in the &quot;command&quot; tha=
t comes after certain script options (e=2Eg=2E, --up) is a</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * valid file with appropriate permiss=
ions=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * &quot;command&quot; consists o=
f a path, optionally followed by a space, which may be</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * followed by arbitrary arguments=2E It i=
s NOT a full shell command line -- shell expansion is not</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * performed=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * The path and arguments in &quot;command&quot; may be single=
- or double-quoted or escaped=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The p=
ath is extracted from &quot;command&quot;, then check_file_access() is call=
ed to check it=2E The</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * arguments, if any, are ignored=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * N=
ote that the type, mode, and opt arguments to this routine are the same as =
the corresponding</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * c=
heck_file_access() arguments=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_cmd_access(c=
onst char *command, const char *opt, const char *chroot)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct argv argv;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    bool return_code;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 If no command was set, there are no errors to look for */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!command)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Extract execu=
table path and arguments */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    argv_parse_cmd(&amp;argv, command);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* if an executable is specified then check it; otherwise, compla=
in */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (argv=2Ea=
rgv[0])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* Scripts requires R_=
OK as well, but that might fail on binaries which</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * only requires X_OK to function on Un=
ix - a scenario not unlikely to</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         * be seen on suid binaries=2E</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return_code =3D check_file_access_chroot(chroot, C=
HKACC_FILE, argv=2Eargv[0], X_OK, opt);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NOPREFIX | M_=
OPTERR, &quot;%s fails with &#39;%s&#39;: No path to executable=2E&quot;, o=
pt, command);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return_code =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    argv_free(&amp;argv);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return return_code;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Sanity check of all file/dir optio=
ns=2E  Checks that file/dir</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * is accessible by OpenVPN</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_postproc=
ess_filechecks(struct options *options)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  bool errs =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ** SSL/TLS/cr=
ypto related files ** */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    errs |=3D check_file_access_inline(options-&gt;dh_file_inline, CHKAC=
C_FILE, options-&gt;dh_file, R_OK,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                     &quot;--dh&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!options-&gt;verify_hash_no_ca)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_inline(opti=
ons-&gt;ca_file_inline, CHKACC_FILE, options-&gt;ca_file,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                       =
  R_OK, &quot;--ca&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_=
chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;ca_path, R_OK,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
           &quot;--capath&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs =
|=3D check_file_access_inline(options-&gt;cert_file_inline, CHKACC_FILE | C=
HKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                                 options-&gt;cert_file, R_OK, &quot;--cert&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_inl=
ine(options-&gt;extra_certs_file, CHKACC_FILE,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                     options-&gt;e=
xtra_certs_file, R_OK, &quot;--extra-certs&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_inline=
(options-&gt;priv_key_file_inline,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                         CHKACC_FILE | CHKACC_=
PRIVATE | CHKACC_ACCEPT_URI,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                         options-&gt;priv_key_file, =
R_OK, &quot;--key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_i=
nline(options-&gt;pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
        options-&gt;pkcs12_file, R_OK, &quot;--pkcs12&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (options-&gt;ssl_flags &amp; SSLF_CRL_VERIFY_DIR)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_c=
hroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;crl_file,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
         R_OK | X_OK, &quot;--crl-verify directory&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
errs |=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
check_file_access_chroot_inline(options-&gt;crl_file_inline, options-&gt;ch=
root_dir,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                                CHKACC_FILE, options-&gt;crl_file, R_OK, &q=
uot;--crl-verify&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_export_pee=
r_cert_dir)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        errs |=3D</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            check_file_access_=
chroot(options-&gt;chroot_dir, CHKACC_FILE,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                     options-&gt;tls_=
export_peer_cert_dir, W_OK, &quot;--tls-export-cert&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ASSERT(options-&gt;connection_list);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; options-&gt;connection_lis=
t-&gt;len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct connect=
ion_entry *ce =3D options-&gt;connection_list-&gt;array[i];</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        errs |=3D check_file_access_inline(ce-&gt;tls_auth=
_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                         ce-&gt;tls_a=
uth_file, R_OK, &quot;--tls-auth&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        errs |=3D check_file_access_inline(ce-&gt;tls_cr=
ypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                         ce-&gt;tl=
s_crypt_file, R_OK, &quot;--tls-crypt&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        errs |=3D check_file_access_inline(ce-&gt;t=
ls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                         c=
e-&gt;tls_crypt_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    errs |=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 check_file_access_inline(options-&gt;shared_secret_file_inline, CHKACC_FIL=
E | CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                               options-&gt;shared_secret_file, R_OK, &quot;=
--secret&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_a=
ccess(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
  R_OK | W_OK, &quot;--replay-persist&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* ** Password files ** */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    errs |=3D check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN =
| CHKACC_PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                          options-&gt;key_pass_file, R_OK, &quot;--askpass&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_file=
_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                          options-&gt;ma=
nagement_user_pass, R_OK, &quot;--management user/password file&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_MANAGEME=
NT */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D ch=
eck_file_access_inline(options-&gt;auth_user_pass_file_inline,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
   CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                     option=
s-&gt;auth_user_pass_file, R_OK, &quot;--auth-user-pass&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* ** System related ** */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file=
_access(CHKACC_FILE, options-&gt;chroot_dir, R_OK | X_OK, &quot;--chroot di=
rectory&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    er=
rs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;wr=
itepid, R_OK | W_OK,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                             &quot;--writepid&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* ** Log related ** */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FI=
LEXSTWR, options-&gt;status_file, R_OK | W_OK,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                              &quot;--status&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* ** Config related ** */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access=
_chroot(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;client_config_dir,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
                R_OK | X_OK, &quot;--client-config-dir&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_ch=
root(options-&gt;chroot_dir, CHKACC_FILE, options-&gt;tmp_dir,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
   R_OK | W_OK | X_OK, &quot;Temporary directory (--tmp-dir)&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (errs)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_USAGE, &quot;Please correct these errors=2E&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif /* !ENABLE_SMALL */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</=
span><br><span>  * Sanity check on options=2E</span><br><span>  * Also set =
some options based on other</span><br><span>  * options=2E</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1774?usp=3Demail">change 1774</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1774?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e=
4b5d81e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1774 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--cbHx53mt0iU=--


--===============0567652003377111455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0567652003377111455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0567652003377111455==--

