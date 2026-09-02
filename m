Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021ADC624D4
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l4zQEF3RMX7/J6M69Cw5u7xCJuy8JoSOaEHLi9Ottdc=; b=GnUo7RBQfYzz8pr2UxPLR4sVLv
	3qdufeUNB8xP96Mr7YGziFC1I7M0Jjgpx8T7R379SpSh+y9gLzNG2Oypkmmxo1TXA+ZR0r4tDB6OC
	sWnHnG1DirewtHCu108kXC3/1oRPcuWpLfnocnN264SOHnQow7cbBQ0+5AyvRsaiDld4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1n9R-0004xQ-Mt;
	Wed, 02 Sep 2026 15:45:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1n9P-0004xK-Th
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YZRPkc3gOxfERzWeDooOr03PL2YTOMNMF1Xc8XMf8R0=; b=hXyy039sufepvnK0txDYFtUuUu
 NoTetRK64509cPWCcAO89AyOYpqqvb/EFvGbUDed46nY0Gf43+alKs+vvl+RRJKtk5j5YyUiG1FUq
 o+TJzYxf0jccKm7uM2Z28/Sc/ivMUnLHzlglSpslf06d+mb1OqVC22LBNMBLEjOeFb48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YZRPkc3gOxfERzWeDooOr03PL2YTOMNMF1Xc8XMf8R0=; b=d
 jcxky14S4KA748eVznunBfKMcZ+OKlG9FldbLn8ZiX4ANEpF0yhLWpupHJXroWCqAYZs8nf+FNKyN
 uHJ2mJQJlKdq+dWTQild5/cENq9H/UdCqFYoh2knEYhwKNYUkswzPEDLsPLh/8Qbc0UMuw3jVtqS8
 mE+XdTtgavcYptGU=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1n9L-0005if-I6 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:45:21 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so12840635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788363913; x=1788968713; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YZRPkc3gOxfERzWeDooOr03PL2YTOMNMF1Xc8XMf8R0=;
 b=WfltGLbeUoY3pLcTsh0h4vf4FxGiQyVJV5Q2h3Nfvkn0b0YNJ8X/8n19oZrdYqgqkK
 A4GTpxcY4Fp95F/TDpaIAbgjCiFt63hU1iu3jg+0xBqp8u4Da59jVUTatvpy5nmvPjPr
 OumZAHeF/XJ5rB84Mzuz6EBkyudsrVpDfwSlXXCcWw2VZDXlibvdPWcJOZwZ9TY3Wgdd
 ymRFnOU6A0SOgapDkcoVUg2Gbi6smzJyiGjajWtIrGMl84NybPRL3X4TSJKly7j0O1dE
 pa5vhS431Dq88v3/ar7yXYRXYDcdRY/JY+BiJFpfwkI1wccslV6bmLGeaBDY572GuDmk
 zvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788363913; x=1788968713;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YZRPkc3gOxfERzWeDooOr03PL2YTOMNMF1Xc8XMf8R0=;
 b=Q7cm0NjBA5A2CdNILzAZ2RSflEJnuZ/UaYvHqpTItWXE4OKqFBGk2dKAV/HoAzKwt7
 ANHvWAEFe6nQFyfBMikYi7gc3pZlncl0hIf13Gb8+7OAEDcIeZyCSx+yhPioVTAHAmUC
 bQa25q2azt5ndAkHq64JyWM2sJIOJL6pGhe5PYPonxumpBaRBRcG/B6oGZQa0BmciyKD
 yaWMLc6nuxjNJqnVJqOgGqxY8Ogpp6u8W/HSUTONwxeusiIdYKtGe5zHZMcrnGjfLZbA
 H5cZzD1Nf9wX6JmShw6FF3xiwKS33GJUjvcMnqo4TrL2Rmvb7smMgnlPRMrDkDaCsirj
 WHYA==
X-Gm-Message-State: AFuF++lHMCqaOJ15EkqxX1yYAA7f3MsKS3j6/OVRYhTpPBmuUXkBY5Ox
 jeD+5pwuUmihkxKXaCSUNY3ORg1nViWqS6k6Opq+vXLteoQQ90U+k9DVmwfOoqFo0pI9mp7Ius3
 mpUVHq2+aWpKn+FD7pghFUhOA9FYz4LCC3HhKqZP/Q3bHhVjwoNFmFs22r52nPPJHPr9E
X-Gm-Gg: AR+sD101vgUGGX4TV9yS1BpaFQ1d0QFlpb+jU9tibK2QfxgETTgvZmfzf6/EbdXSgpM
 cklb/Ik7sbFHyGi13pcLXlFpuLMSbAt9l0riwzj9QYXZj4Z09uE97nnknr1h99TfepAjecuhQN8
 bZHMwVmsjfnnuhiP0ok+FoyWUncw4lV1I5mN7tn8tIlYiivIfp4gNl5u8ERS8oLxVhPmqmTGTS9
 W/wzcZsNMXN9cTxHGc6BeU31WAWPqfgjwMcXl/ish0UeSm1nMp0K7liQk86mabRBNZItCl4m1X2
 UCoTg/pc/7nSS2u1fR/04Kb4C72RnKiy5rcHFCbrjy1D1KtTecsYejuwsGgaVhuLFEE+ZRDMcgw
 lJuvrkB/Ju/dMVuD7AvCG+wuJH3yvtYR88T9pH5ZXrElhvzc4Vig52xeQC8aiSChqpzkL1PnTiP
 n7SNqNv2PPtT9sWOrzE7wyPZPLfqBGWgia1BPYyhhCOKc8b6KvwdAxmdSId7YLwFAMkT/FYX/Y2
 DB+QzdXG8Dlz6Ajya2t1t5ixxDxSCOgEyvvY8CHLsHMSA35+itWM9TKT0FnW1iEcVMXCkvjlxjQ
 d/U7D4k0OYtPV6X34P+fIx5DJXSPEzSf1MHgrz0JEKncySYYjbs=
X-Received: by 2002:a05:600c:1f92:b0:49c:dada:30b7 with SMTP id
 5b1f17b1804b1-49ce5816440mr92867545e9.2.1788363912624; 
 Wed, 02 Sep 2026 08:45:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm130540515e9.0.2026.09.02.08.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:45:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 15:45:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
X-Gerrit-Change-Number: 1892
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1892?usp=email>
X-Gerrit-Commit: 3496ee3fb3d21ec8790abd2ebee6e5b15e7dc5d7
In-Reply-To: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
References: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkliYTY2MjM1Y2JhZDUyNjkyZGE1NDJhYmQ0N2U5ZjUxODEwYjBlZDY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a235b069c8c982c70bba22af32cd6314354d15d8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1n9L-0005if-I6
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7230591506901717067=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7230591506901717067==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LcPZ59ttSuE="; charset=UTF-8

--LcPZ59ttSuE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, 

I'd like you to reexamine a change=2E Please visi=
t

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail

to look =
at the new patch set (#2)=2E

The following approvals got outdated and were=
 removed:
Code-Review+2 by d12fk


Change subject: win32: unit-test the Cre=
ateProcess() command line quoting
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

win32: unit-test the CreateProcess() command line qu=
oting

Cover which argument shapes wide_cmd_line() quotes: plain arguments =
and
the batch delimiters , ; =3D stay bare, a space or a cmd=2Eexe metachar=
acter
forces quotes, and an embedded double quote is replaced so quoting ca=
nnot
be broken out of=2E The first two cases pin the compatibility guarante=
e -
they are what a later "just quote everything" simplification would brea=
k=2E

Move wide_cmd_line() to win32-util=2Ec next to wide_string(), which i=
t
calls=2E The unit tests already link that file, so nothing else needs to
=
change to reach it=2E

Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66=

Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Heiko Hund <heik=
o@openvpn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/189=
2
Message-Id: <20260902141002=2E16513-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3889=
9=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/op=
envpn/win32-util=2Ec
M src/openvpn/win32-util=2Eh
M src/openvpn/win32=2Ec
M=
 tests/unit_tests/openvpn/test_argv=2Ec
4 files changed, 128 insertions(+),=
 67 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/92/1892/2

diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn=
/win32-util=2Ec
index 209e34e=2E=2E4e3819c 100644
--- a/src/openvpn/win32-u=
til=2Ec
+++ b/src/openvpn/win32-util=2Ec
@@ -45,6 +45,73 @@
     return ucs=
16;
 }
 
+/* special to cmd=2Eexe, which CreateProcess() uses to run =2Ebat=
/=2Ecmd (VU#123335) */
+#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
+
+static b=
ool
+argv_element_needs_quotes(const char *str)
+{
+    for (const char *c =
=3D str; *c !=3D '\0'; ++c)
+    {
+        if (strchr(CMD_QUOTE_TRIGGERS, =
*c) !=3D NULL)
+        {
+            return true;
+        }
+    }
+    =
return false;
+}
+
+WCHAR *
+wide_cmd_line(const struct argv *a, struct gc_=
arena *gc)
+{
+    size_t nchars =3D 1;
+    size_t maxlen =3D 0;
+    size=
_t i;
+    struct buffer buf;
+    char *work =3D NULL;
+
+    if (!a)
+   =
 {
+        return NULL;
+    }
+
+    for (i =3D 0; i < a->argc; ++i)
+   =
 {
+        const char *arg =3D a->argv[i];
+        const size_t len =3D s=
trlen(arg);
+        nchars +=3D len + 3;
+        if (len > maxlen)
+     =
   {
+            maxlen =3D len;
+        }
+    }
+
+    work =3D gc_mall=
oc(maxlen + 1, false, gc);
+    check_malloc_return(work);
+    buf =3D all=
oc_buf_gc(nchars, gc);
+
+    for (i =3D 0; i < a->argc; ++i)
+    {
+     =
   const char *arg =3D a->argv[i];
+        strcpy(work, arg);
+        str=
ing_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
+        if (i)
+ =
       {
+            buf_printf(&buf, " ");
+        }
+        if (argv_e=
lement_needs_quotes(work))
+        {
+            buf_printf(&buf, "\"%s\"=
", work);
+        }
+        else
+        {
+            buf_printf(&buf,=
 "%s", work);
+        }
+    }
+
+    return wide_string(BSTR(&buf), gc);
=
+}
+
 char *
 utf16to8(const wchar_t *utf16, struct gc_arena *gc)
 {
diff -=
-git a/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh
index fb8376=
2=2E=2Ec2ad64b 100644
--- a/src/openvpn/win32-util=2Eh
+++ b/src/openvpn/wi=
n32-util=2Eh
@@ -24,11 +24,15 @@
 #ifndef OPENVPN_WIN32_UTIL_H
 #define OPE=
NVPN_WIN32_UTIL_H
 
+#include "argv=2Eh"
 #include "buffer=2Eh"
 
 /* Conve=
rt a string from UTF-8 to UCS-2 */
 WCHAR *wide_string(const char *utf8, st=
ruct gc_arena *gc);
 
+/* Build a CreateProcess() command line from argv */=

+WCHAR *wide_cmd_line(const struct argv *a, struct gc_arena *gc);
+
 /* Co=
nvert a string from UTF-16 to UTF-8 */
 char *utf16to8(const wchar_t *utf16=
, struct gc_arena *gc);
 
diff --git a/src/openvpn/win32=2Ec b/src/openvpn/=
win32=2Ec
index a9990b5=2E=2E94e79d5e 100644
--- a/src/openvpn/win32=2Ec
++=
+ b/src/openvpn/win32=2Ec
@@ -1034,73 +1034,6 @@
     }
 }
 
-/* special to=
 cmd=2Eexe, which CreateProcess() uses to run =2Ebat/=2Ecmd (VU#123335) */
=
-#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
-
-static bool
-argv_element_needs=
_quotes(const char *str)
-{
-    for (const char *c =3D str; *c !=3D '\0'; =
++c)
-    {
-        if (strchr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)
-       =
 {
-            return true;
-        }
-    }
-    return false;
-}
-
-sta=
tic WCHAR *
-wide_cmd_line(const struct argv *a, struct gc_arena *gc)
-{
- =
   size_t nchars =3D 1;
-    size_t maxlen =3D 0;
-    size_t i;
-    struc=
t buffer buf;
-    char *work =3D NULL;
-
-    if (!a)
-    {
-        retu=
rn NULL;
-    }
-
-    for (i =3D 0; i < a->argc; ++i)
-    {
-        cons=
t char *arg =3D a->argv[i];
-        const size_t len =3D strlen(arg);
-   =
     nchars +=3D len + 3;
-        if (len > maxlen)
-        {
-          =
  maxlen =3D len;
-        }
-    }
-
-    work =3D gc_malloc(maxlen + 1, f=
alse, gc);
-    check_malloc_return(work);
-    buf =3D alloc_buf_gc(nchars=
, gc);
-
-    for (i =3D 0; i < a->argc; ++i)
-    {
-        const char *a=
rg =3D a->argv[i];
-        strcpy(work, arg);
-        string_mod(work, CC=
_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
-        if (i)
-        {
-      =
      buf_printf(&buf, " ");
-        }
-        if (argv_element_needs_quo=
tes(work))
-        {
-            buf_printf(&buf, "\"%s\"", work);
-     =
   }
-        else
-        {
-            buf_printf(&buf, "%s", work);
- =
       }
-    }
-
-    return wide_string(BSTR(&buf), gc);
-}
-
 /*
  * Att=
empt to simulate fork/execve on Windows
  */
diff --git a/tests/unit_tests/=
openvpn/test_argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec
index b1e326=
1=2E=2E5b6e26e 100644
--- a/tests/unit_tests/openvpn/test_argv=2Ec
+++ b/te=
sts/unit_tests/openvpn/test_argv=2Ec
@@ -14,6 +14,10 @@
 #include "buffer=
=2Eh"
 #include "test_common=2Eh"
 
+#ifdef _WIN32
+#include "win32-util=2E=
h"
+#endif
+
 /* Defines for use in the tests and the mock parse_line() */
=
 #define PATH1      "/s p a c e"
 #define PATH2      "/foo bar/baz"
@@ -248=
,6 +252,56 @@
     argv_free(&a);
 }
 
+#ifdef _WIN32
+/*
+ * An argument i=
s quoted if and only if it holds a space or a character that
+ * cmd=2Eexe =
would act on when CreateProcess() runs a =2Ebat/=2Ecmd target=2E
+ */
+stat=
ic void
+wide_cmd_line__quotes_only_what_cmd_would_reinterpret(void **state=
)
+{
+    static const struct
+    {
+        const char *arg;
+        con=
st WCHAR *expected;
+    } cases[] =3D {
+        /* nothing special - must=
 stay unquoted, or existing scripts break */
+        { "CN=3Duser1", L"scr=
ipt=2Ebat 0 CN=3Duser1" },
+        /* the batch delimiters are deliberatel=
y not triggers */
+        { "CN=3Da,b;c=3Dd", L"script=2Ebat 0 CN=3Da,b;c=
=3Dd" },
+        /* a space has always forced quoting */
+        { "O=3DC=
trl, CN=3Dy", L"script=2Ebat 0 \"O=3DCtrl, CN=3Dy\"" },
+        /* cmd=2Ee=
xe operators */
+        { "CN=3Dx&ver", L"script=2Ebat 0 \"CN=3Dx&ver\"" }=
,
+        { "CN=3Dx|ver", L"script=2Ebat 0 \"CN=3Dx|ver\"" },
+        { "=
CN=3Dx>f", L"script=2Ebat 0 \"CN=3Dx>f\"" },
+        { "CN=3Dx<f", L"scrip=
t=2Ebat 0 \"CN=3Dx<f\"" },
+        { "CN=3Dx^f", L"script=2Ebat 0 \"CN=3Dx=
^f\"" },
+        { "CN=3Dx%f", L"script=2Ebat 0 \"CN=3Dx%f\"" },
+        =
{ "CN=3Dx(f)", L"script=2Ebat 0 \"CN=3Dx(f)\"" },
+        { "CN=3Dx!f", L"=
script=2Ebat 0 \"CN=3Dx!f\"" },
+        /* a double quote is replaced, so =
quoting cannot be broken out of */
+        { "CN=3Da\"b", L"script=2Ebat 0=
 CN=3Da_b" },
+    };
+
+    for (size_t i =3D 0; i < SIZE(cases); i++)
+  =
  {
+        struct gc_arena gc =3D gc_new();
+        struct argv a =3D ar=
gv_new();
+
+        argv_printf(&a, "%s %d %s", "script=2Ebat", 0, cases[i=
]=2Earg);
+        assert_int_equal(a=2Eargc, 3);
+
+        WCHAR *cmd_lin=
e =3D wide_cmd_line(&a, &gc);
+        assert_non_null(cmd_line);
+        =
assert_int_equal(wcscmp(cmd_line, cases[i]=2Eexpected), 0);
+
+        argv=
_free(&a);
+        gc_free(&gc);
+    }
+}
+#endif /* _WIN32 */
+
 int
 ma=
in(void)
 {
@@ -267,6 +321,9 @@
         cmocka_unit_test(argv_str__multipl=
e_argv__correct_output),
         cmocka_unit_test(argv_insert_head__non_em=
pty_argv__head_added),
         cmocka_unit_test(argv_insert_head__empty_ar=
gv__head_only),
+#ifdef _WIN32
+        cmocka_unit_test(wide_cmd_line__quo=
tes_only_what_cmd_would_reinterpret),
+#endif
     };
 
     return cmocka_=
run_group_tests_name("argv", tests, NULL, NULL);

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
G=
errit-Change-Number: 1892
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--LcPZ59ttSuE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by d12fk</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">win32: unit-test the CreateProcess() command line quoting<br=
><br>Cover which argument shapes wide_cmd_line() quotes: plain arguments an=
d<br>the batch delimiters , ; =3D stay bare, a space or a cmd=2Eexe metacha=
racter<br>forces quotes, and an embedded double quote is replaced so quotin=
g cannot<br>be broken out of=2E The first two cases pin the compatibility g=
uarantee -<br>they are what a later &quot;just quote everything&quot; simpl=
ification would break=2E<br><br>Move wide_cmd_line() to win32-util=2Ec next=
 to wide_string(), which it<br>calls=2E The unit tests already link that fi=
le, so nothing else needs to<br>change to reach it=2E<br><br>Change-Id: Iba=
66235cbad52692da542abd47e9f51810b0ed66<br>Signed-off-by: Lev Stipakov &lt;l=
ev@openvpn=2Enet&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892<br>Message-Id:=
 &lt;20260902141002=2E16513-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38899=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M src/openvpn/win32-util=2Ec<br>M src/openvpn/win32-util=2Eh<br>M src/op=
envpn/win32=2Ec<br>M tests/unit_tests/openvpn/test_argv=2Ec<br>4 files chan=
ged, 128 insertions(+), 67 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/1892/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-util=2Ec</span>=
<br><span>index 209e34e=2E=2E4e3819c 100644</span><br><span>--- a/src/openv=
pn/win32-util=2Ec</span><br><span>+++ b/src/openvpn/win32-util=2Ec</span><b=
r><span>@@ -45,6 +45,73 @@</span><br><span>     return ucs16;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* special to cmd=2Eexe, which CreateProcess() uses to run =2Ebat/=2Ecm=
d (VU#123335) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine CMD_QUOTE_TRIGGERS &quot; &amp;|&lt;&gt;^%()!&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+argv_element_needs_quotes(const char *str)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (const char *c =3D str; *c !=3D &#39;\0&#39;; ++c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (strchr(CMD_QUOTE_TRIGG=
ERS, *c) !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+WCHAR *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+wide_=
cmd_line(const struct argv *a, struct gc_arena *gc)</span><br><span style=
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
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f5=
1810b0ed66 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1892 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--LcPZ59ttSuE=--


--===============7230591506901717067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7230591506901717067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7230591506901717067==--

