Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0852CC61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ju/BmwmN2up+SlPp9tCoMD+E/G1sBIWYEfiakPY9Pyg=; b=aZTEEd6d7gfdUa9bfiBMXQmS4o
	eIz6eMgIZ0xO1ujrqMwjYtUvdD6L3+adC69nPYlKjMlmXnLrfHn/+fOgiZdabCH5gzORhotJ9wWyf
	3C6QAp2X61tPeHL4xs2ZCgeHsTKs9Hkism2JkUkheAfxtKPBzFJtckMndzosFauGor7s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1n9a-0005bs-Id;
	Wed, 02 Sep 2026 15:45:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1n9Y-0005bN-P1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:45:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JupXOaG1Rfn/aqAUuCRx6CSYU38eyPukk7zOtZjFWM4=; b=ec0Fmlf5qI6XJ2KwctW8R8Hldk
 NUTrc6HETgWJeCTJZF936bEju+EBTrghXVbLKiOO65WAzloQArpb9NzeeMKvqYWm4Q4aQGz3Ekie3
 gGmtrteM7uWyo1PGX3/prHKgrGZWsdOztC/3oQviEDF8HqgmR3n8UBu7PU39RwQrbNRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JupXOaG1Rfn/aqAUuCRx6CSYU38eyPukk7zOtZjFWM4=; b=L
 /89A96apFbed9odRJpE3HfXoeWkixOlKvQYtTX2Kfxc8/e97L19LSuhfbnnhYart/WEWgFaySPGkx
 n59cfEebcnB7FBmvu0dPEoOqwCWgvWZjXuvpQTyj6DwkiDwscOXfpzbZOGDDP+jp9fp8ckuXniXu9
 ZIChnr6NA6P9RZ8g=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1n9Q-0000XV-S6 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:45:27 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49b0dbfbf7bso8435805e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788363918; x=1788968718; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JupXOaG1Rfn/aqAUuCRx6CSYU38eyPukk7zOtZjFWM4=;
 b=F1rByVD86MrgpAspyfZ2Z+H9K3O7ASiQoNvwl14H/Oy6ag037SCHXbN93IrjYQg82s
 gVh5ysTYAcUqFeyiuFQg03uq/9+fpt5sxEmeoGxbaB75g9HLKFKdZUpknTdVaXhxrotk
 EztkzpY1nBliL3SA2IP403tExB5nJk/v6iVWLnqe8radha5Vi08YouUlA/nR+lodubci
 Im0TVqAo+phsT7GdeOer7ub9AIIa7K+Xcv5pJ50WQxPNT8v82DXGlpDcCqbJzhzbRGmv
 yrEEDHR0MqLTek6w0dayitaIhTfNa6c4m3/cjkXn0ILc2zpUCqevUmhSCI6QnrizV2gH
 UVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788363918; x=1788968718;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JupXOaG1Rfn/aqAUuCRx6CSYU38eyPukk7zOtZjFWM4=;
 b=sRTI6ZyY+7ISIEn0pN6xqDrwFI8u7H53yEoqIf85waBCHlNgqNm3ZFKe1pmwNNtRrK
 FKRh5GfKDDPny352okRjaxf/HR8UlPXpLWtcAj3EM64VwZ5byoku8t6EoVI4iaTdnrMJ
 NNAMdHbnZ6/eMmZyPo6+B31dAdQj5w1rbusSWfFyYNWJYGcwqM3+yHpY4FRAkx4DdfYb
 hu0eANzI6uNhIYv1QE7VTDMi2Sh+hHGeezM8f0LhH4nEzSFAaizkqnPo9hd41ryNjjQw
 jCvocT96zE6XtydCkTTNTu5GqrkSZQ2ikKOsMW6vOrtdTMFh16Xbp/Ujmch6f72CfPBl
 gfoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/Fw8mHjBmvtmti/X4BEN4T3h/Jevx5eCR8E/GuHd4wcA7PqXtLkAw5gAVvdDf+zHR/+Y6CX0ZI7v+faZl@lists.sourceforge.net
X-Gm-Message-State: AFuF++mE4jXKOpaKkrj41IJeghWeiGR74cONBWcotaJGsZSAb5MrxDsx
 c0xEGxhZ3FAkwJSwYtYBO4v412bGp7sOYzAur33Vs7V2aQpCc+KgawjrJrYG+Q1seX3YXZqoTCX
 CbBJR7B24DXIzUt8H1kyYJEF4WDAXdAmMCDuDOJ1zbDkayZjsWJpuwbqxS8z7ZADRwv5b2huobw
 +Mrct/WA==
X-Gm-Gg: AR+sD12Wjp0I1B1ify4cSuXhpagU5cs5tg605/MrwALF58iy8p7nrnQgiOzt1bq9P6G
 Yr/wAlwi7w/aoOoIpoQPb0pljr8esfNtF8I1x6Smgbx17k7DSJ86hjBI7Q66SagOGJU43jyMBlu
 mmyy6xQ0tBGZ8m7LJnLkb48aMaA2RscQkZj4ZO3NbQ4eMx5cr3Bi3zZsEnwDy27oJ1B0oaIJlzO
 U4xUj5ExyWlzAKx4HQZzy58I8zQAG4qtP1RG/1JCInzr6PcuFjf3daLWB79z1QIFZgDh12WAn0H
 s8VrVE/XZbcNVkQPgGok9qOXlI8NL58JPN1CeQ4Hr1/haq4PBBM2M+1CdQCur+RgGwkktbB/slh
 KAiGm195xHWQT1sMUL+KZ1fRCnEXg75UJYjMgKrZHPxldJ5pGvovm+22+HXV5JQyIEGMqK06HR1
 3xOStcXDLpdGpLs8u/lzMkgQUNfX6xWTt/n/x1Dgf7r4/a+tOKuLHFo8hknL/LDslJfUlrjT2RK
 b3oBrk0UwiJ1fc2r1h+i1bQUYbk4D6lmhvVk2mKJPDvQtuMNKOdqZtGJN2TGAif7xpqRs80ltor
 zlglRkq4/87w0ORgklVjv4F20uHJX0T+tqJYl3pvcTQak4PYvV7w
X-Received: by 2002:a05:600c:4eca:b0:49c:e1f1:3dd5 with SMTP id
 5b1f17b1804b1-49ce5816892mr88486595e9.4.1788363917875; 
 Wed, 02 Sep 2026 08:45:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f914bsm295995e9.3.2026.09.02.08.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:45:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 15:45:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
X-Gerrit-Change-Number: 1892
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1892?usp=email>
X-Gerrit-Commit: 3496ee3fb3d21ec8790abd2ebee6e5b15e7dc5d7
In-Reply-To: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
References: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkliYTY2MjM1Y2JhZDUyNjkyZGE1NDJhYmQ0N2U5ZjUxODEwYjBlZDY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a235b069c8c982c70bba22af32cd6314354d15d8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1n9Q-0000XV-S6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: unit-test the
 CreateProcess() command line quoting
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@openvpn.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7295000452269292690=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7295000452269292690==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DH+KIJCXalE="; charset=UTF-8

--DH+KIJCXalE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1892?usp=3Demail )

Change subject: win32: unit-test the CreateProcess(=
) command line quoting
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

win32: unit-test the CreateProcess() command line quoting

Cover=
 which argument shapes wide_cmd_line() quotes: plain arguments and
the batc=
h delimiters , ; =3D stay bare, a space or a cmd=2Eexe metacharacter
forces=
 quotes, and an embedded double quote is replaced so quoting cannot
be brok=
en out of=2E The first two cases pin the compatibility guarantee -
they are=
 what a later "just quote everything" simplification would break=2E

Move w=
ide_cmd_line() to win32-util=2Ec next to wide_string(), which it
calls=2E T=
he unit tests already link that file, so nothing else needs to
change to re=
ach it=2E

Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
Signed-off-=
by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Heiko Hund <heiko@openvpn=2E=
net>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892
Message-Id=
: <20260902141002=2E16513-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38899=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/win32-=
util=2Ec
M src/openvpn/win32-util=2Eh
M src/openvpn/win32=2Ec
M tests/unit_=
tests/openvpn/test_argv=2Ec
4 files changed, 128 insertions(+), 67 deletion=
s(-)




diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-util=
=2Ec
index 209e34e=2E=2E4e3819c 100644
--- a/src/openvpn/win32-util=2Ec
+++=
 b/src/openvpn/win32-util=2Ec
@@ -45,6 +45,73 @@
     return ucs16;
 }
 
+/=
* special to cmd=2Eexe, which CreateProcess() uses to run =2Ebat/=2Ecmd (VU=
#123335) */
+#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
+
+static bool
+argv_e=
lement_needs_quotes(const char *str)
+{
+    for (const char *c =3D str; *c=
 !=3D '\0'; ++c)
+    {
+        if (strchr(CMD_QUOTE_TRIGGERS, *c) !=3D NU=
LL)
+        {
+            return true;
+        }
+    }
+    return fals=
e;
+}
+
+WCHAR *
+wide_cmd_line(const struct argv *a, struct gc_arena *gc)
=
+{
+    size_t nchars =3D 1;
+    size_t maxlen =3D 0;
+    size_t i;
+    =
struct buffer buf;
+    char *work =3D NULL;
+
+    if (!a)
+    {
+       =
 return NULL;
+    }
+
+    for (i =3D 0; i < a->argc; ++i)
+    {
+       =
 const char *arg =3D a->argv[i];
+        const size_t len =3D strlen(arg);=

+        nchars +=3D len + 3;
+        if (len > maxlen)
+        {
+     =
       maxlen =3D len;
+        }
+    }
+
+    work =3D gc_malloc(maxlen +=
 1, false, gc);
+    check_malloc_return(work);
+    buf =3D alloc_buf_gc(n=
chars, gc);
+
+    for (i =3D 0; i < a->argc; ++i)
+    {
+        const ch=
ar *arg =3D a->argv[i];
+        strcpy(work, arg);
+        string_mod(wor=
k, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
+        if (i)
+        {
+ =
           buf_printf(&buf, " ");
+        }
+        if (argv_element_need=
s_quotes(work))
+        {
+            buf_printf(&buf, "\"%s\"", work);
+=
        }
+        else
+        {
+            buf_printf(&buf, "%s", work=
);
+        }
+    }
+
+    return wide_string(BSTR(&buf), gc);
+}
+
 char =
*
 utf16to8(const wchar_t *utf16, struct gc_arena *gc)
 {
diff --git a/src/=
openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh
index fb83762=2E=2Ec2ad=
64b 100644
--- a/src/openvpn/win32-util=2Eh
+++ b/src/openvpn/win32-util=2E=
h
@@ -24,11 +24,15 @@
 #ifndef OPENVPN_WIN32_UTIL_H
 #define OPENVPN_WIN32_=
UTIL_H
 
+#include "argv=2Eh"
 #include "buffer=2Eh"
 
 /* Convert a string=
 from UTF-8 to UCS-2 */
 WCHAR *wide_string(const char *utf8, struct gc_are=
na *gc);
 
+/* Build a CreateProcess() command line from argv */
+WCHAR *wi=
de_cmd_line(const struct argv *a, struct gc_arena *gc);
+
 /* Convert a str=
ing from UTF-16 to UTF-8 */
 char *utf16to8(const wchar_t *utf16, struct gc=
_arena *gc);
 
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
i=
ndex a9990b5=2E=2E94e79d5e 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/ope=
nvpn/win32=2Ec
@@ -1034,73 +1034,6 @@
     }
 }
 
-/* special to cmd=2Eexe,=
 which CreateProcess() uses to run =2Ebat/=2Ecmd (VU#123335) */
-#define CM=
D_QUOTE_TRIGGERS " &|<>^%()!"
-
-static bool
-argv_element_needs_quotes(con=
st char *str)
-{
-    for (const char *c =3D str; *c !=3D '\0'; ++c)
-    {=

-        if (strchr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)
-        {
-       =
     return true;
-        }
-    }
-    return false;
-}
-
-static WCHAR *=

-wide_cmd_line(const struct argv *a, struct gc_arena *gc)
-{
-    size_t n=
chars =3D 1;
-    size_t maxlen =3D 0;
-    size_t i;
-    struct buffer bu=
f;
-    char *work =3D NULL;
-
-    if (!a)
-    {
-        return NULL;
- =
   }
-
-    for (i =3D 0; i < a->argc; ++i)
-    {
-        const char *arg=
 =3D a->argv[i];
-        const size_t len =3D strlen(arg);
-        nchars=
 +=3D len + 3;
-        if (len > maxlen)
-        {
-            maxlen =
=3D len;
-        }
-    }
-
-    work =3D gc_malloc(maxlen + 1, false, gc)=
;
-    check_malloc_return(work);
-    buf =3D alloc_buf_gc(nchars, gc);
-
=
-    for (i =3D 0; i < a->argc; ++i)
-    {
-        const char *arg =3D a-=
>argv[i];
-        strcpy(work, arg);
-        string_mod(work, CC_PRINT, C=
C_DOUBLE_QUOTE | CC_CRLF, '_');
-        if (i)
-        {
-            buf=
_printf(&buf, " ");
-        }
-        if (argv_element_needs_quotes(work)=
)
-        {
-            buf_printf(&buf, "\"%s\"", work);
-        }
-   =
     else
-        {
-            buf_printf(&buf, "%s", work);
-        }
=
-    }
-
-    return wide_string(BSTR(&buf), gc);
-}
-
 /*
  * Attempt to s=
imulate fork/execve on Windows
  */
diff --git a/tests/unit_tests/openvpn/t=
est_argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec
index b1e3261=2E=2E5b=
6e26e 100644
--- a/tests/unit_tests/openvpn/test_argv=2Ec
+++ b/tests/unit_=
tests/openvpn/test_argv=2Ec
@@ -14,6 +14,10 @@
 #include "buffer=2Eh"
 #inc=
lude "test_common=2Eh"
 
+#ifdef _WIN32
+#include "win32-util=2Eh"
+#endif
=
+
 /* Defines for use in the tests and the mock parse_line() */
 #define PA=
TH1      "/s p a c e"
 #define PATH2      "/foo bar/baz"
@@ -248,6 +252,56 =
@@
     argv_free(&a);
 }
 
+#ifdef _WIN32
+/*
+ * An argument is quoted if=
 and only if it holds a space or a character that
+ * cmd=2Eexe would act o=
n when CreateProcess() runs a =2Ebat/=2Ecmd target=2E
+ */
+static void
+wi=
de_cmd_line__quotes_only_what_cmd_would_reinterpret(void **state)
+{
+    s=
tatic const struct
+    {
+        const char *arg;
+        const WCHAR *e=
xpected;
+    } cases[] =3D {
+        /* nothing special - must stay unquo=
ted, or existing scripts break */
+        { "CN=3Duser1", L"script=2Ebat 0=
 CN=3Duser1" },
+        /* the batch delimiters are deliberately not trigg=
ers */
+        { "CN=3Da,b;c=3Dd", L"script=2Ebat 0 CN=3Da,b;c=3Dd" },
+  =
      /* a space has always forced quoting */
+        { "O=3DCtrl, CN=3Dy"=
, L"script=2Ebat 0 \"O=3DCtrl, CN=3Dy\"" },
+        /* cmd=2Eexe operators=
 */
+        { "CN=3Dx&ver", L"script=2Ebat 0 \"CN=3Dx&ver\"" },
+        {=
 "CN=3Dx|ver", L"script=2Ebat 0 \"CN=3Dx|ver\"" },
+        { "CN=3Dx>f", L=
"script=2Ebat 0 \"CN=3Dx>f\"" },
+        { "CN=3Dx<f", L"script=2Ebat 0 \"=
CN=3Dx<f\"" },
+        { "CN=3Dx^f", L"script=2Ebat 0 \"CN=3Dx^f\"" },
+  =
      { "CN=3Dx%f", L"script=2Ebat 0 \"CN=3Dx%f\"" },
+        { "CN=3Dx(f)=
", L"script=2Ebat 0 \"CN=3Dx(f)\"" },
+        { "CN=3Dx!f", L"script=2Ebat=
 0 \"CN=3Dx!f\"" },
+        /* a double quote is replaced, so quoting cann=
ot be broken out of */
+        { "CN=3Da\"b", L"script=2Ebat 0 CN=3Da_b" }=
,
+    };
+
+    for (size_t i =3D 0; i < SIZE(cases); i++)
+    {
+       =
 struct gc_arena gc =3D gc_new();
+        struct argv a =3D argv_new();
+
=
+        argv_printf(&a, "%s %d %s", "script=2Ebat", 0, cases[i]=2Earg);
+ =
       assert_int_equal(a=2Eargc, 3);
+
+        WCHAR *cmd_line =3D wide_c=
md_line(&a, &gc);
+        assert_non_null(cmd_line);
+        assert_int_e=
qual(wcscmp(cmd_line, cases[i]=2Eexpected), 0);
+
+        argv_free(&a);
+=
        gc_free(&gc);
+    }
+}
+#endif /* _WIN32 */
+
 int
 main(void)
 {
=
@@ -267,6 +321,9 @@
         cmocka_unit_test(argv_str__multiple_argv__corr=
ect_output),
         cmocka_unit_test(argv_insert_head__non_empty_argv__he=
ad_added),
         cmocka_unit_test(argv_insert_head__empty_argv__head_onl=
y),
+#ifdef _WIN32
+        cmocka_unit_test(wide_cmd_line__quotes_only_wha=
t_cmd_would_reinterpret),
+#endif
     };
 
     return cmocka_run_group_te=
sts_name("argv", tests, NULL, NULL);

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1892?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
Gerrit-Change-Numb=
er: 1892
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--DH+KIJCXalE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1892?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">win32: unit-test the CreateProcess() comma=
nd line quoting<br><br>Cover which argument shapes wide_cmd_line() quotes: =
plain arguments and<br>the batch delimiters , ; =3D stay bare, a space or a=
 cmd=2Eexe metacharacter<br>forces quotes, and an embedded double quote is =
replaced so quoting cannot<br>be broken out of=2E The first two cases pin t=
he compatibility guarantee -<br>they are what a later &quot;just quote ever=
ything&quot; simplification would break=2E<br><br>Move wide_cmd_line() to w=
in32-util=2Ec next to wide_string(), which it<br>calls=2E The unit tests al=
ready link that file, so nothing else needs to<br>change to reach it=2E<br>=
<br>Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66<br>Signed-off-by: =
Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Heiko Hund &lt;heiko@op=
envpn=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
892<br>Message-Id: &lt;20260902141002=2E16513-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38899=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/win32-util=2Ec<br>M src/openvpn/win32-ut=
il=2Eh<br>M src/openvpn/win32=2Ec<br>M tests/unit_tests/openvpn/test_argv=
=2Ec<br>4 files changed, 128 insertions(+), 67 deletions(-)<br><br></pre>
<=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-util=2Ec</spa=
n><br><span>index 209e34e=2E=2E4e3819c 100644</span><br><span>--- a/src/ope=
nvpn/win32-util=2Ec</span><br><span>+++ b/src/openvpn/win32-util=2Ec</span>=
<br><span>@@ -45,6 +45,73 @@</span><br><span>     return ucs16;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* special to cmd=2Eexe, which CreateProcess() uses to run =2Ebat/=2E=
cmd (VU#123335) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define CMD_QUOTE_TRIGGERS &quot; &amp;|&lt;&gt;^%()!&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+argv_element_needs_quotes(const char *str)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (const char *c =3D str; *c !=3D &#39;\0&#39;; ++c)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (strchr(CMD_QUOTE_TRIG=
GERS, *c) !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+WCHAR *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wide=
_cmd_line(const struct argv *a, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    size_t nchars =3D 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t maxlen =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    size_t i;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char *work =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; a-&gt;argc; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const char *arg =3D a-&gt;arg=
v[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
size_t len =3D strlen(arg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        nchars +=3D len + 3;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (len &gt; maxlen)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            maxlen =3D len;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    work =3D gc_mal=
loc(maxlen + 1, false, gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    check_malloc_return(work);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf =3D alloc_buf_gc(nchars, gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (i =3D 0; i &lt; a-&gt;argc; ++i)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const char *arg =3D a-&gt;argv[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        strcpy(work, arg);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        string_mod(=
work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, &#39;_&#39;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            buf_printf(&amp;buf, &quot; &quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (argv_element_needs_q=
uotes(work))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_p=
rintf(&amp;buf, &quot;\&quot;%s\&quot;&quot;, work);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            buf_printf(&amp;buf, &quot;%s&quot;, work);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return wide_string(BSTR(&amp;buf), gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> char *</span><br><span> utf16to8(const wchar_t *ut=
f16, struct gc_arena *gc)</span><br><span> {</span><br><span>diff --git a/s=
rc/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh</span><br><span>inde=
x fb83762=2E=2Ec2ad64b 100644</span><br><span>--- a/src/openvpn/win32-util=
=2Eh</span><br><span>+++ b/src/openvpn/win32-util=2Eh</span><br><span>@@ -2=
4,11 +24,15 @@</span><br><span> #ifndef OPENVPN_WIN32_UTIL_H</span><br><spa=
n> #define OPENVPN_WIN32_UTIL_H</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;argv=2Eh&quot;</span><br><span=
> #include &quot;buffer=2Eh&quot;</span><br><span> </span><br><span> /* Con=
vert a string from UTF-8 to UCS-2 */</span><br><span> WCHAR *wide_string(co=
nst char *utf8, struct gc_arena *gc);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Build a CreateProcess() command line=
 from argv */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+WCHAR =
*wide_cmd_line(const struct argv *a, struct gc_arena *gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Convert a strin=
g from UTF-16 to UTF-8 */</span><br><span> char *utf16to8(const wchar_t *ut=
f16, struct gc_arena *gc);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index a9990b5=
=2E=2E94e79d5e 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br=
><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1034,73 +1034,6 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/* special to cmd=2Eexe, which CreateP=
rocess() uses to run =2Ebat/=2Ecmd (VU#123335) */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define CMD_QUOTE_TRIGGERS &quot; &amp;|&lt;&gt=
;^%()!&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-argv_element_needs_quotes(const char *st=
r)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (const char *c =3D str; *c !=3D=
 &#39;\0&#39;; ++c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strchr=
(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return true;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return false;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static WCHAR *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
wide_cmd_line(const struct argv *a, struct gc_arena *gc)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    size_t nchars =3D 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size_t maxlen =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    size_t i;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct buffer buf;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    char *work =3D NULL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (i =3D 0; i &lt; a-&gt;argc; ++i)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        const char *arg =3D a-&gt;argv[i];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const size_t len =3D strlen(arg);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        nchars +=3D len=
 + 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (len =
&gt; maxlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            maxlen =
=3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    work =3D gc_malloc(maxlen + 1, false, gc);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    check_malloc_return(work);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D alloc_buf_gc(nch=
ars, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; a-&gt;ar=
gc; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *arg =3D a=
-&gt;argv[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
strcpy(work, arg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, &#39;_&#39;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (i)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;buf, &quot; &qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (argv_element_nee=
ds_quotes(work))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_p=
rintf(&amp;buf, &quot;\&quot;%s\&quot;&quot;, work);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           buf_printf(&amp;buf, &quot;%s&quot;, work);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return wide_=
string(BSTR(&amp;buf), gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> /*</span><br><span>  * Attempt to simulate fork/execve on Windows</span=
><br><span>  */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec</span><br><span>index b1e=
3261=2E=2E5b6e26e 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_argv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_argv=2Ec</sp=
an><br><span>@@ -14,6 +14,10 @@</span><br><span> #include &quot;buffer=2Eh&=
quot;</span><br><span> #include &quot;test_common=2Eh&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;win32-ut=
il=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
 Defines for use in the tests and the mock parse_line() */</span><br><span>=
 #define PATH1      &quot;/s p a c e&quot;</span><br><span> #define PATH2  =
    &quot;/foo bar/baz&quot;</span><br><span>@@ -248,6 +252,56 @@</span><br=
><span>     argv_free(&amp;a);</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * An argument is quoted if and only if it holds a=
 space or a character that</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * cmd=2Eexe would act on when CreateProcess() runs a =2Ebat/=2Ecmd =
target=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+wide_cmd_line__quotes_only_what_cm=
d_would_reinterpret(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
static const struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
char *arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst WCHAR *expected;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    } cases[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* nothing special - must stay unquoted, or existing scripts brea=
k */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot=
;CN=3Duser1&quot;, L&quot;script=2Ebat 0 CN=3Duser1&quot; },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* the batch delimiters ar=
e deliberately not triggers */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        { &quot;CN=3Da,b;c=3Dd&quot;, L&quot;script=2Ebat 0 CN=
=3Da,b;c=3Dd&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* a space has always forced quoting */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        { &quot;O=3DCtrl, CN=3Dy&quot;, L&quo=
t;script=2Ebat 0 \&quot;O=3DCtrl, CN=3Dy\&quot;&quot; },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* cmd=2Eexe operators */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx&a=
mp;ver&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&amp;ver\&quot;&quot; },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3D=
x|ver&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx|ver\&quot;&quot; },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx&gt;=
f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&gt;f\&quot;&quot; },</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx&lt;f&q=
uot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&lt;f\&quot;&quot; },</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx^f&quot;, =
L&quot;script=2Ebat 0 \&quot;CN=3Dx^f\&quot;&quot; },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx%f&quot;, L&quot;sc=
ript=2Ebat 0 \&quot;CN=3Dx%f\&quot;&quot; },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx(f)&quot;, L&quot;script=2Eb=
at 0 \&quot;CN=3Dx(f)\&quot;&quot; },</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        { &quot;CN=3Dx!f&quot;, L&quot;script=2Ebat 0 \&q=
uot;CN=3Dx!f\&quot;&quot; },</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* a double quote is replaced, so quoting cannot be broken=
 out of */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
 &quot;CN=3Da\&quot;b&quot;, L&quot;script=2Ebat 0 CN=3Da_b&quot; },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(cases); i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct argv =
a =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&=
amp;a, &quot;%s %d %s&quot;, &quot;script=2Ebat&quot;, 0, cases[i]=2Earg);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_int_e=
qual(a=2Eargc, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WCHAR *cmd_l=
ine =3D wide_cmd_line(&amp;a, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        assert_non_null(cmd_line);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(wcscmp(cmd_line=
, cases[i]=2Eexpected), 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        arg=
v_free(&amp;a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif /* _WIN32 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><b=
r><span> main(void)</span><br><span> {</span><br><span>@@ -267,6 +321,9 @@<=
/span><br><span>         cmocka_unit_test(argv_str__multiple_argv__correct_=
output),</span><br><span>         cmocka_unit_test(argv_insert_head__non_em=
pty_argv__head_added),</span><br><span>         cmocka_unit_test(argv_inser=
t_head__empty_argv__head_only),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(wide_cmd_line__quotes_only_what_cmd_would_re=
interpret),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span>     };</span><br><span> </span><br><span>     return cmocka=
_run_group_tests_name(&quot;argv&quot;, tests, NULL, NULL);</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1892?usp=3Demail">change 1892</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f51810b=
0ed66 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1892 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--DH+KIJCXalE=--


--===============7295000452269292690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7295000452269292690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7295000452269292690==--

