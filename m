Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B556CC6B0F
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=T/H5I+RNBGMOnR4xsaRYErdwKv6asc3azYSHC8Haslw=; b=muNX/mXlc9EpQ1
	E+ZHsi8NKVVhpodu32kfKsO06q2qHFGx5m6uJRnncU+CeTsJjtH6EztuO6D3uZ4ByNOxMm1vieqY7
	ancp07WLOc9Na96QdbD0m0wpIrq/xjQAms4Zmdv2AiBo0v26zZHKebZdV6SvNU6jC3GcNfO6qXmS7
	Okk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGdPk-0005gk-Mh;
	Tue, 13 Oct 2026 14:23:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGdPj-0005gc-1s
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2pGye2MoZPhTCdMuUd83ix7gSfNhl7i2dM6SR/aTbag=; b=JifTb4XUXTtWMymdi3utRi/fKF
 esvARUHFh9+XPl+gd7BRuCseUOo8syeh9C3kErQMN4+rp3XBtuvXfuC+pOjYz2VYmvot5hvX1BlEO
 YFbm+XNIhKC0Ws6seGEX0HpAvLnnMVQ24XleJn6HsAJaw7+eJ4eK3WjwhOCMnjIe2dig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2pGye2MoZPhTCdMuUd83ix7gSfNhl7i2dM6SR/aTbag=; b=b
 Gr0i6XT35NH+Dqz2XpwVBLjIA/DPRKjuZhtvS3D6h7N++lcIOeI/r62andtHdFDhJlS/WbN+IurxP
 Cn67EBF/9OHT8T3yRndOQoyentvI/4nvyCb2+QIhVqoGS/JRAtIawEaPJCuvRL/Mw4LvhKHJ8/AZM
 7Y3ToVgoFdwNubuE=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGdPg-0001Tn-Ik for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:34 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a17baef589so26123575e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791901406; x=1792506206; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2pGye2MoZPhTCdMuUd83ix7gSfNhl7i2dM6SR/aTbag=;
 b=KtCEeiFgL5RxI/QNVQFB2wiKb6GUiP/t3X61mw9oyzBQB11DSYmbwCWPMLXI5T65Zq
 C0kUiflT39NNGRzV1A+n9A/ufFkjBZubu6X/AEOLEBXv4JTlkKPio5cDhPtoBycl8Agf
 vfu1DV0N6zjdCfYhD+kfYI1aRjdipZVM++I5Ja7MVh4o6CebWNVAHIkeP6ij/VppNWkW
 a7KFBYbOuXnbSwFOyBF8FRQMX1OQTV6W+LG9A5yY8Pp19kpI8n5CW0wzi8HsJ84FPcvE
 grM3xeyO/j5UAlx+vR72qJBs0WTg3+/jFi+zZnIr+NoatXxI0yvNXGylkAwNfj7rlJNy
 vjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901406; x=1792506206;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2pGye2MoZPhTCdMuUd83ix7gSfNhl7i2dM6SR/aTbag=;
 b=ZLOrPFQSdQQIlI+Q2ITJ4Lk3CC1hLi/sKtjfDOMs2Bv8jxTb/gKGjSJ0Zz4Q6BVYal
 m3OUj+Q1nhyYrMEYr32ZfKSfoRbCox3y+GN4hD2AAATgsgzx0PiextNPe4mujLFSPeQn
 Tl4M0UA1POazWAcXN/Shhn1BKtdy8COW+Yg32zyZ1kAuXjmklMeEdVRuz7I3laxLcA6J
 Ar7f/a1zw8gdyTkcqXpn7e6LQ73U0aGLG9cPQvmc3uGXP/DDw1L9F05DokNmdEBlxvc5
 Sfkm4Rb0lVQBfuIM1rFo8b77DEvIzOd0JAEe06aR84e3V4IBKKfvRKB9T6GnMt07nEXM
 49zA==
X-Gm-Message-State: AFq9FYI1DBFSbFQYfSyNH02kSo1zAO83yXj4nk7zW8/HuNIJxj7uxHU/
 4NEvivApyDXfozlaso3Pv5gEtLvPrJvqZ8WbiBPwhf5b5pq1UTmXkJGnlEZT2mTqylgFDPKtwuA
 u5gL6C8+S3MwPFWPAC+PYrjXsphwWTOpAlE20SVF34stcmCpLgcD0lnQ3VcHMYkuMo5SA/FjNI3
 yOT6qBRQ==
X-Gm-Gg: AYBFou0mcnmDBD6ZM4BHxMoD7n9dtdEEVrsnVzxuTuBnTwZwVOyJUgMpTm63QzwHip+
 C4kVMfoke3em0s0XdauTGwuOWp/sl8ppi2D69pNc4FzrgQ9VDwp2nf5P/XuSx9Asfp5x8nYp4bU
 Y/nAjFGxq+mV7tQCuXWSHGa0fXWlJGctPHF+WbO338+2XNa4xfRBdPne2PlL+pkT+s19H0w26hm
 uXRxDQn2tUrEsqTLZutgM11WK5QfYiB9mon1CIzAzqSABrgj90QzPvT6bdIHNyE88MW6smzZ0CO
 GWdH7OSGs7WqEPfV10V7vCl7uI3NNrZ8i7b7KYkt1cEUJm/jW9bkOO9XX7Q1+oPe7GGFJsLLnJH
 XGFhDDDRSoQRgjV5a4Zkt2olpucpDcCYyIJiTEJTzY3h213vvSGeBW3rzsXLTEDRKyaiZ2Kqmbh
 urjHglZPdIR5lQHVaKNl8zHQeDHiujwc/FMnYbZ/5RYsqp3lR2ZatC7HSDyjqzyzH5PFMgeciWf
 xnGEtNph0ITDt4GznNnjfFQPAklXBwU3GLiiV9wR8M9Clk147AsjeJ3FCVX1ZOiwKSV9FlywY9z
 DbA/ggfj30MFIOpRKJZt4E/9ci2GV3ki40jjKXMXCINzhGSIRTsXlxN2RZ3w
X-Received: by 2002:a05:600c:8208:b0:4a0:1b14:d00c with SMTP id
 5b1f17b1804b1-4a18e446f55mr244778745e9.3.1791901405627; 
 Tue, 13 Oct 2026 07:23:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c1e33d2sm518499215e9.0.2026.10.13.07.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:23:25 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 14:23:24 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e
X-Gerrit-Change-Number: 1994
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1994?usp=email>
X-Gerrit-Commit: a1e4dc7faf428088cc26e0a6191e08361b5eeaac
References: <gerrit.1791901394000.I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk5MDZiM2ZhZDVkNTIxZTFlNGIwZjE1YWZmNzYzY2Y0ZDRkOGJjMzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c359e546e4e63186fb9cbbe339f629c22ac797f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGdPg-0001Tn-Ik
Subject: [Openvpn-devel] [M] Change in openvpn[master]: compat: Add strlcpy
 and strlcat
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0905880762434762045=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0905880762434762045==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HN2HILqH0OY="; charset=UTF-8

--HN2HILqH0OY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1994?usp=3Demail

to review the following change=2E
=


Change subject: compat: Add strlcpy and strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

compat: Add strlcpy and strlcat

Avai=
bable on most systems (Linux since
glibc 2=2E38), but not all=2E We already=

have strncpynt, but switching to the
standard strlcpy makes the code more
=
accessible for both humans and tools=2E

This commit only introduces the
po=
ssibility to use strlcpy in general
code (we already have one usage in
BSD-=
specific code)=2E No users are
introduced, yet=2E

Change-Id: I906b3fad5d52=
1e1e4b0f15aff763cf4d4d8bc35e
Signed-off-by: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
---
M CMakeLists=2Etxt
M config=2Eh=2Ecmake=2Ein
M configure=
=2Eac
A src/compat/compat-strlcpy=2Ec
M src/compat/compat=2Eh
5 files chang=
ed, 66 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/94/1994/1

diff --git a/CMakeLists=2Etxt b/C=
MakeLists=2Etxt
index bac4dd4=2E=2E825f8b3 100644
--- a/CMakeLists=2Etxt
++=
+ b/CMakeLists=2Etxt
@@ -248,6 +248,7 @@
 
 check_symbol_exists(chsize io=
=2Eh HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource=2Eh HAVE_GETR=
LIMIT)
+check_symbol_exists(strlcpy string=2Eh HAVE_STRLCPY)
 check_symbol_=
exists(strsep string=2Eh HAVE_STRSEP)
 check_symbol_exists(strtok_r string=
=2Eh HAVE_STRTOK_R)
 
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ec=
make=2Ein
index 8c3088e=2E=2E483de45 100644
--- a/config=2Eh=2Ecmake=2Ein
+=
++ b/config=2Eh=2Ecmake=2Ein
@@ -267,6 +267,9 @@
 /* Define to 1 if you hav=
e the <string=2Eh> header file=2E */
 #define HAVE_STRING_H 1
 
+/* Define =
to 1 if you have the `strlcpy' function=2E */
+#cmakedefine HAVE_STRLCPY
+
=
 /* Define to 1 if you have the `strsep' function=2E */
 #cmakedefine HAVE_=
STRSEP
 
diff --git a/configure=2Eac b/configure=2Eac
index 56109af=2E=2Ead=
3f8f1 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -568,7 +568,7 @@
=
 	setgroups flock gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve=
 getpeereid basename dirname \
-	epoll_create strsep strtok_r \
+	epoll_cre=
ate strlcpy strsep strtok_r \
 ])
 
 AC_CHECK_LIB(
diff --git a/src/compat/=
compat-strlcpy=2Ec b/src/compat/compat-strlcpy=2Ec
new file mode 100644
ind=
ex 0000000=2E=2E8c1e80a
--- /dev/null
+++ b/src/compat/compat-strlcpy=2Ec
@=
@ -0,0 +1,52 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks
+ *             over a single UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet=
>
+ *
+ *  This program is free software; you can redistribute it and/or mo=
dify
+ *  it under the terms of the GNU General Public License version 2
+ =
*  as published by the Free Software Foundation=2E
+ *
+ *  This program is=
 distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for mor=
e details=2E
+ *
+ *  You should have received a copy of the GNU General Pu=
blic License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#=
endif
+
+#ifndef HAVE_STRLCPY
+#include <string=2Eh>
+
+size_t
+strlcpy(cha=
r *dest, const char *src, size_t maxlen)
+{
+    if (maxlen > 0)
+    {
+  =
      strncpy(dest, src, maxlen - 1);
+        dest[maxlen - 1] =3D 0;
+   =
 }
+    return strlen(src);
+}
+
+size_t
+strlcat(char *dest, const char *s=
rc, size_t maxlen)
+{
+    size_t dest_len =3D strnlen(dest, maxlen);
+    =
if (maxlen > dest_len)
+    {
+        strncat(dest, src, maxlen - dest_len=
 - 1);
+    }
+    return dest_len + strlen(src);
+}
+
+#endif /* ifndef HA=
VE_STRLCPY */
diff --git a/src/compat/compat=2Eh b/src/compat/compat=2Eh
in=
dex 9e6f95c=2E=2E4ee9141 100644
--- a/src/compat/compat=2Eh
+++ b/src/compa=
t/compat=2Eh
@@ -56,6 +56,15 @@
 
 #endif
 
+#ifndef HAVE_STRLCPY
+size_t
+=
strlcpy(char *dest, const char *src, size_t maxlen);
+
+size_t
+strlcat(cha=
r *dest, const char *src, size_t maxlen);
+
+#endif
+
 #ifndef HAVE_STRSEP
=
 char *strsep(char **stringp, const char *delim);
 

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35=
e
Gerrit-Change-Number: 1994
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--HN2HILqH0OY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1994?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">compat: Add strlcpy and strlcat<br><br>Avaibable on most s=
ystems (Linux since<br>glibc 2=2E38), but not all=2E We already<br>have str=
ncpynt, but switching to the<br>standard strlcpy makes the code more<br>acc=
essible for both humans and tools=2E<br><br>This commit only introduces the=
<br>possibility to use strlcpy in general<br>code (we already have one usag=
e in<br>BSD-specific code)=2E No users are<br>introduced, yet=2E<br><br>Cha=
nge-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>=
M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>A src/compat/compat-strlcp=
y=2Ec<br>M src/compat/compat=2Eh<br>5 files changed, 66 insertions(+), 1 de=
letion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/94/1994/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt</span><br><span>index bac4dd4=2E=2E825f8b3 100644</span>=
<br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</sp=
an><br><span>@@ -248,6 +248,7 @@</span><br><span> </span><br><span> check_s=
ymbol_exists(chsize io=2Eh HAVE_CHSIZE)</span><br><span> check_symbol_exist=
s(getrlimit sys/resource=2Eh HAVE_GETRLIMIT)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+check_symbol_exists(strlcpy string=2Eh HAVE_STRLCP=
Y)</span><br><span> check_symbol_exists(strsep string=2Eh HAVE_STRSEP)</spa=
n><br><span> check_symbol_exists(strtok_r string=2Eh HAVE_STRTOK_R)</span><=
br><span> </span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2E=
h=2Ecmake=2Ein</span><br><span>index 8c3088e=2E=2E483de45 100644</span><br>=
<span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmak=
e=2Ein</span><br><span>@@ -267,6 +267,9 @@</span><br><span> /* Define to 1 =
if you have the &lt;string=2Eh&gt; header file=2E */</span><br><span> #defi=
ne HAVE_STRING_H 1</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Define to 1 if you have the `strlcpy&#39; function=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_=
STRLCPY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /* Define to 1 if you have the `strsep&#39; function=2E */</span><br>=
<span> #cmakedefine HAVE_STRSEP</span><br><span> </span><br><span>diff --gi=
t a/configure=2Eac b/configure=2Eac</span><br><span>index 56109af=2E=2Ead3f=
8f1 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/confi=
gure=2Eac</span><br><span>@@ -568,7 +568,7 @@</span><br><span> 	setgroups f=
lock gettimeofday \</span><br><span> 	setsid chdir \</span><br><span> 	chsi=
ze ftruncate execve getpeereid basename dirname \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	epoll_create strsep strtok_r \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	epoll_create strlcpy strsep strtok=
_r \</span><br><span> ])</span><br><span> </span><br><span> AC_CHECK_LIB(</=
span><br><span>diff --git a/src/compat/compat-strlcpy=2Ec b/src/compat/comp=
at-strlcpy=2Ec</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E8c1e80a</span><br><span>--- /dev/null</span><br><span>+++ b/src=
/compat/compat-strlcpy=2Ec</span><br><span>@@ -0,0 +1,52 @@</span><br><span=
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
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more deta=
ils=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_STRLCPY</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+size_t</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+strlcpy(char *dest, const char *src, size_t maxlen)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (maxlen &gt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        strncpy(dest, src, maxlen - 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dest[maxlen - 1] =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return strlen(src);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strlcat(char=
 *dest, const char *src, size_t maxlen)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t dest_len =3D strnlen(dest, maxlen);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (maxlen &gt; dest_len)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        strncat(dest, src, maxlen - dest_len - 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return dest_len + strlen(src)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif /* ifndef HAVE_STRLCPY */</span><br><span>diff -=
-git a/src/compat/compat=2Eh b/src/compat/compat=2Eh</span><br><span>index =
9e6f95c=2E=2E4ee9141 100644</span><br><span>--- a/src/compat/compat=2Eh</sp=
an><br><span>+++ b/src/compat/compat=2Eh</span><br><span>@@ -56,6 +56,15 @@=
</span><br><span> </span><br><span> #endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_STRLCPY</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+strlcpy(char *dest, const char *src, size_t ma=
xlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+size_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+strlcat(char *dest, const char *src, size_t m=
axlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #ifndef HAVE_STRSEP</span>=
<br><span> char *strsep(char **stringp, const char *delim);</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
94?usp=3Demail">change 1994</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1994?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I906b3fad5d521e1e4b0f15aff763cf4d4d8bc35e </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1994 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>

</body></html>
--HN2HILqH0OY=--


--===============0905880762434762045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0905880762434762045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0905880762434762045==--

