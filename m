Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FED5C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Lk5a003RjQMS4JxnmfNPht+pVAuOfcYrMQzV+3iBMXg=; b=X6TZAYfGFopVc8
	9lecQfYxGBvBvlJPhedPX59HD1igXHUBHtgcMC4RTHdDC1JYzSDK4aQmKGBts7c906c1Iv6qwGTOS
	w9JRMbq4C35miya/a5wGL9acYCxuh0CTWHzCCWafBs3pO+S4BjJnWk7UwCsuqcUMKDsI3AhBcTWoo
	Sgs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1VPO-0008CP-KR;
	Tue, 01 Sep 2026 20:48:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1VPM-0008CJ-Is
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:48:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ntdnP8a/FstjfeWu9Ke+DRGGN4ZCqMiqE57/N1e9odY=; b=UXBulDLEVMTPn0++lX/b8JN4fp
 dk0favr5EfxNPP3SU6zlqUljz8YUB4DH4o/5lwIdJJbNbFmhrwzR02mGrgHjPLa8GCu9tzfClqr+J
 NRNK+LTMTgsKXFy9jdMJRZUUxR2fMXIL2olHccAVyMT+fyncw9KXwAkt7vPjLKoGcebU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ntdnP8a/FstjfeWu9Ke+DRGGN4ZCqMiqE57/N1e9odY=; b=e
 TbCqka6iup3PLlV1lVsivKdqR7QAyxvIDbXIp+bsT3x3hRf61A9Db5z+cuev/2xyG9V2DU8+NDMiQ
 r/xOmyIPhzMK+DcAppQaCpUvo76LmBgW7ob8f/fdqdhxk4qDmZcK6mzsyigh4y7LkZmkh6eVAFOIv
 1HafYGhSm2kGQWac=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1VPL-00065F-HH for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:48:41 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495437bb891so1603655e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788295713; x=1788900513; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ntdnP8a/FstjfeWu9Ke+DRGGN4ZCqMiqE57/N1e9odY=;
 b=Bx1tUel57rLsigfYpQzttTuMW8hD3I5U8liwcfkuQHiX2dl9x2zZ/2k7N3NEBwcJXi
 aNuxM4Vb9JsGm1AyboueFlA+H69En6u1DsZBXGt466undeG3hXsTXq9ssIzYi0onKJnS
 qBFw5Ce/v68Z1NBLlL7BD2T5NDl+ZPSbYAHtTbB6si3PQe/UvZrJfQuUlhyoS75Fhyna
 lwtWuB/vCVygGqQtDcBY0drobWTBPRUa8n6kG3NLPElrZIWN7zeqhq9/6Obn38TD15e0
 UKtW4bdLhFH0CsYgWMhtKidQ6AzaC1UdtnlJQ8B2wjkUOCLC6GTLJ2fvCWRyQM1oEY5r
 eHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788295713; x=1788900513;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntdnP8a/FstjfeWu9Ke+DRGGN4ZCqMiqE57/N1e9odY=;
 b=hAbnAKDiyVrpkbEPXq+zjtbd9FRxFwBqb0h3ofAvANDu3zAL1iOORsEfz52WmiPTk3
 t/tcNrICgyLGI4wTXTsNWudDcEl4QsAleGCvAtN1Ga0QVjgP/CKv8/VGVQqw6/zxJDnR
 WppD6l8IQ2YFINuCzUXuvD0s3Pi1hAO5arzCZRvFf+WE5tHi77bcsUqNNsO97lS4tIgE
 IEjwJNRfTYe+rKWEAeMreZxsjSzcCJgrUueRUTAbIZ1LXiJ39vhPxc70RHiZg8VbCtUp
 gA0K8lUOsS2F/4/v1RFZ8uU3uehZ1lfzmXHz7Ft318UzVCXHCyPCAdbt9YvjcpePPg2J
 KmGQ==
X-Gm-Message-State: AFuF++n6jGngOQntqOkaqE43Xa9uebvvapNgDwcVRpGjdBSRmaw+ZMGi
 418AewFN+rDyITBxcIWZr4nkAy76duEzU9EXhc9TdARh4pZsV3HdhyWS9ZD1B+9TIaI5dTLl0gR
 YteRCRq9utoADdKjFhFdCPWtZrPNh1uHQUaCHGJS4AjYqFwot+O3IYqOZDC2OUoB8Ug738Hvb9H
 qD1FyeCg==
X-Gm-Gg: AR+sD13Mk6kTq/Kj5pazf+yaO9Azv82M6hibZ/w6VEOBAg6DeGPFW1axpXKubmOF17q
 QZefZ9rpB6vgWd6YZnVlCa4TObiK/cH9zM+pAA8CZJTS6T8d5d2hgASKaZdVD+dl3eiPtcFJG3b
 KaxQQDZvxV3CoPqTunwz5CCTL669CrztlnmDfhsRsGvY6CQdfgc6EQaCo5r+j9fsASftF6cE+t6
 SF3Flxldbag82om2zDg+IiwL12Mf8ZMg+BpQ4nCgNm0HXGWjCSvmkW6NqIoowjrc+axzc/mSWOo
 TiWGipkXnW0wm/cIP1I/2894ezzu0o/mLww4OScLvpWtaxLULMX2dvJb1TUwAjFrH3BQuCM+Sgf
 DZ9b7MkIAZ6h//QRIN1giR6tpnIrQjN7qL0nq/B+tUwS9dJT7mSJYsq58pC10Gflo3OXWwhFwCA
 890vtyvJY0bPuKtutTIzgEzMNn0m3TpG4hKXHuFnbH0l01b6rv5jmbGQ9nWVdq/dWK6EUegI/Ly
 UW8T0u3nUbZNHTHFzRXBwOv5ey9JBx2tXdudrPQLxMj1ow8VwAZ50SPA+h1FZGAJFzoe/KF7nn0
 CO9e+5R2xWJ4pzQ4w6GsVBJZWx4qV1ZoaHo61CES667PwTVKIKaY7A/qzTxD7g==
X-Received: by 2002:a05:600c:8a1:b0:499:d531:b584 with SMTP id
 5b1f17b1804b1-49cdd736f9fmr104918175e9.9.1788295712862; 
 Tue, 01 Sep 2026 13:48:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80020sm1734538f8f.10.2026.09.01.13.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:48:32 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 20:48:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba66235cbad52692da542abd47e9f51810b0ed66
X-Gerrit-Change-Number: 1892
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1892?usp=email>
X-Gerrit-Commit: 0bdd7a5cc6fc5939af8f269f424538aa3692c45f
References: <gerrit.1788295708000.Iba66235cbad52692da542abd47e9f51810b0ed66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkliYTY2MjM1Y2JhZDUyNjkyZGE1NDJhYmQ0N2U5ZjUxODEwYjBlZDY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e517c849cd06b75f4d64548d0aa18ba2a8a8b207-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1VPL-00065F-HH
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2029508391811277433=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2029508391811277433==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="isAFaqpG++A="; charset=UTF-8

--isAFaqpG++A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1892?usp=3Demail

to review the following change=2E


Chang=
e subject: win32: unit-test the CreateProcess() command line quoting
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32: unit-test th=
e CreateProcess() command line quoting

Cover which argument shapes wide_cm=
d_line() quotes: plain arguments and
the batch delimiters , ; =3D stay bare=
, a space or a cmd=2Eexe metacharacter
forces quotes, and an embedded doubl=
e quote is replaced so quoting cannot
be broken out of=2E The first two cas=
es pin the compatibility guarantee -
they are what a later "just quote ever=
ything" simplification would break=2E

Move wide_cmd_line() to win32-util=
=2Ec next to wide_string(), which it
calls=2E The unit tests already link t=
hat file, so nothing else needs to
change to reach it=2E

Change-Id: Iba662=
35cbad52692da542abd47e9f51810b0ed66
Signed-off-by: Lev Stipakov <lev@openvp=
n=2Enet>
---
M src/openvpn/win32-util=2Ec
M src/openvpn/win32-util=2Eh
M sr=
c/openvpn/win32=2Ec
M tests/unit_tests/openvpn/test_argv=2Ec
4 files change=
d, 128 insertions(+), 67 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/92/1892/1

diff --git a/src/openvpn/win32=
-util=2Ec b/src/openvpn/win32-util=2Ec
index 209e34e=2E=2E4e3819c 100644
--=
- a/src/openvpn/win32-util=2Ec
+++ b/src/openvpn/win32-util=2Ec
@@ -45,6 +4=
5,73 @@
     return ucs16;
 }
 
+/* special to cmd=2Eexe, which CreateProce=
ss() uses to run =2Ebat/=2Ecmd (VU#123335) */
+#define CMD_QUOTE_TRIGGERS "=
 &|<>^%()!"
+
+static bool
+argv_element_needs_quotes(const char *str)
+{
+=
    for (const char *c =3D str; *c !=3D '\0'; ++c)
+    {
+        if (strc=
hr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)
+        {
+            return true;
=
+        }
+    }
+    return false;
+}
+
+WCHAR *
+wide_cmd_line(const str=
uct argv *a, struct gc_arena *gc)
+{
+    size_t nchars =3D 1;
+    size_t =
maxlen =3D 0;
+    size_t i;
+    struct buffer buf;
+    char *work =3D NU=
LL;
+
+    if (!a)
+    {
+        return NULL;
+    }
+
+    for (i =3D 0;=
 i < a->argc; ++i)
+    {
+        const char *arg =3D a->argv[i];
+       =
 const size_t len =3D strlen(arg);
+        nchars +=3D len + 3;
+        i=
f (len > maxlen)
+        {
+            maxlen =3D len;
+        }
+    }
=
+
+    work =3D gc_malloc(maxlen + 1, false, gc);
+    check_malloc_return(=
work);
+    buf =3D alloc_buf_gc(nchars, gc);
+
+    for (i =3D 0; i < a->a=
rgc; ++i)
+    {
+        const char *arg =3D a->argv[i];
+        strcpy(w=
ork, arg);
+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '=
_');
+        if (i)
+        {
+            buf_printf(&buf, " ");
+      =
  }
+        if (argv_element_needs_quotes(work))
+        {
+            b=
uf_printf(&buf, "\"%s\"", work);
+        }
+        else
+        {
+     =
       buf_printf(&buf, "%s", work);
+        }
+    }
+
+    return wide_s=
tring(BSTR(&buf), gc);
+}
+
 char *
 utf16to8(const wchar_t *utf16, struct =
gc_arena *gc)
 {
diff --git a/src/openvpn/win32-util=2Eh b/src/openvpn/win3=
2-util=2Eh
index fb83762=2E=2Ec2ad64b 100644
--- a/src/openvpn/win32-util=
=2Eh
+++ b/src/openvpn/win32-util=2Eh
@@ -24,11 +24,15 @@
 #ifndef OPENVPN_=
WIN32_UTIL_H
 #define OPENVPN_WIN32_UTIL_H
 
+#include "argv=2Eh"
 #include=
 "buffer=2Eh"
 
 /* Convert a string from UTF-8 to UCS-2 */
 WCHAR *wide_st=
ring(const char *utf8, struct gc_arena *gc);
 
+/* Build a CreateProcess() =
command line from argv */
+WCHAR *wide_cmd_line(const struct argv *a, struc=
t gc_arena *gc);
+
 /* Convert a string from UTF-16 to UTF-8 */
 char *utf1=
6to8(const wchar_t *utf16, struct gc_arena *gc);
 
diff --git a/src/openvpn=
/win32=2Ec b/src/openvpn/win32=2Ec
index d527160=2E=2E80ec7e8 100644
--- a/=
src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -936,73 +936,6 @@
    =
 }
 }
 
-/* special to cmd=2Eexe, which CreateProcess() uses to run =2Ebat/=
=2Ecmd (VU#123335) */
-#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
-
-static bo=
ol
-argv_element_needs_quotes(const char *str)
-{
-    for (const char *c =
=3D str; *c !=3D '\0'; ++c)
-    {
-        if (strchr(CMD_QUOTE_TRIGGERS, =
*c) !=3D NULL)
-        {
-            return true;
-        }
-    }
-    =
return false;
-}
-
-static WCHAR *
-wide_cmd_line(const struct argv *a, str=
uct gc_arena *gc)
-{
-    size_t nchars =3D 1;
-    size_t maxlen =3D 0;
- =
   size_t i;
-    struct buffer buf;
-    char *work =3D NULL;
-
-    if (!=
a)
-    {
-        return NULL;
-    }
-
-    for (i =3D 0; i < a->argc; ++=
i)
-    {
-        const char *arg =3D a->argv[i];
-        const size_t le=
n =3D strlen(arg);
-        nchars +=3D len + 3;
-        if (len > maxlen)=

-        {
-            maxlen =3D len;
-        }
-    }
-
-    work =3D =
gc_malloc(maxlen + 1, false, gc);
-    check_malloc_return(work);
-    buf =
=3D alloc_buf_gc(nchars, gc);
-
-    for (i =3D 0; i < a->argc; ++i)
-    {=

-        const char *arg =3D a->argv[i];
-        strcpy(work, arg);
-    =
    string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
-        if=
 (i)
-        {
-            buf_printf(&buf, " ");
-        }
-        if =
(argv_element_needs_quotes(work))
-        {
-            buf_printf(&buf, =
"\"%s\"", work);
-        }
-        else
-        {
-            buf_print=
f(&buf, "%s", work);
-        }
-    }
-
-    return wide_string(BSTR(&buf)=
, gc);
-}
-
 /*
  * Attempt to simulate fork/execve on Windows
  */
diff --=
git a/tests/unit_tests/openvpn/test_argv=2Ec b/tests/unit_tests/openvpn/tes=
t_argv=2Ec
index b1e3261=2E=2E5b6e26e 100644
--- a/tests/unit_tests/openvpn=
/test_argv=2Ec
+++ b/tests/unit_tests/openvpn/test_argv=2Ec
@@ -14,6 +14,10=
 @@
 #include "buffer=2Eh"
 #include "test_common=2Eh"
 
+#ifdef _WIN32
+#i=
nclude "win32-util=2Eh"
+#endif
+
 /* Defines for use in the tests and the =
mock parse_line() */
 #define PATH1      "/s p a c e"
 #define PATH2      "=
/foo bar/baz"
@@ -248,6 +252,56 @@
     argv_free(&a);
 }
 
+#ifdef _WIN32
=
+/*
+ * An argument is quoted if and only if it holds a space or a characte=
r that
+ * cmd=2Eexe would act on when CreateProcess() runs a =2Ebat/=2Ecmd=
 target=2E
+ */
+static void
+wide_cmd_line__quotes_only_what_cmd_would_rei=
nterpret(void **state)
+{
+    static const struct
+    {
+        const ch=
ar *arg;
+        const WCHAR *expected;
+    } cases[] =3D {
+        /* n=
othing special - must stay unquoted, or existing scripts break */
+        =
{ "CN=3Duser1", L"script=2Ebat 0 CN=3Duser1" },
+        /* the batch delim=
iters are deliberately not triggers */
+        { "CN=3Da,b;c=3Dd", L"scrip=
t=2Ebat 0 CN=3Da,b;c=3Dd" },
+        /* a space has always forced quoting =
*/
+        { "O=3DCtrl, CN=3Dy", L"script=2Ebat 0 \"O=3DCtrl, CN=3Dy\"" },=

+        /* cmd=2Eexe operators */
+        { "CN=3Dx&ver", L"script=2Ebat=
 0 \"CN=3Dx&ver\"" },
+        { "CN=3Dx|ver", L"script=2Ebat 0 \"CN=3Dx|ve=
r\"" },
+        { "CN=3Dx>f", L"script=2Ebat 0 \"CN=3Dx>f\"" },
+        {=
 "CN=3Dx<f", L"script=2Ebat 0 \"CN=3Dx<f\"" },
+        { "CN=3Dx^f", L"scr=
ipt=2Ebat 0 \"CN=3Dx^f\"" },
+        { "CN=3Dx%f", L"script=2Ebat 0 \"CN=
=3Dx%f\"" },
+        { "CN=3Dx(f)", L"script=2Ebat 0 \"CN=3Dx(f)\"" },
+  =
      { "CN=3Dx!f", L"script=2Ebat 0 \"CN=3Dx!f\"" },
+        /* a double =
quote is replaced, so quoting cannot be broken out of */
+        { "CN=3Da=
\"b", L"script=2Ebat 0 CN=3Da_b" },
+    };
+
+    for (size_t i =3D 0; i <=
 SIZE(cases); i++)
+    {
+        struct gc_arena gc =3D gc_new();
+      =
  struct argv a =3D argv_new();
+
+        argv_printf(&a, "%s %d %s", "scr=
ipt=2Ebat", 0, cases[i]=2Earg);
+        assert_int_equal(a=2Eargc, 3);
+
+=
        WCHAR *cmd_line =3D wide_cmd_line(&a, &gc);
+        assert_non_nul=
l(cmd_line);
+        assert_int_equal(wcscmp(cmd_line, cases[i]=2Eexpected=
), 0);
+
+        argv_free(&a);
+        gc_free(&gc);
+    }
+}
+#endif /=
* _WIN32 */
+
 int
 main(void)
 {
@@ -267,6 +321,9 @@
         cmocka_unit_=
test(argv_str__multiple_argv__correct_output),
         cmocka_unit_test(ar=
gv_insert_head__non_empty_argv__head_added),
         cmocka_unit_test(argv=
_insert_head__empty_argv__head_only),
+#ifdef _WIN32
+        cmocka_unit_t=
est(wide_cmd_line__quotes_only_what_cmd_would_reinterpret),
+#endif
     };=

 
     return cmocka_run_group_tests_name("argv", tests, NULL, NULL);

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iba66235cbad52692da542a=
bd47e9f51810b0ed66
Gerrit-Change-Number: 1892
Gerrit-PatchSet: 1
Gerrit-Own=
er: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--isAFaqpG++A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1892?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">wi=
n32: unit-test the CreateProcess() command line quoting<br><br>Cover which =
argument shapes wide_cmd_line() quotes: plain arguments and<br>the batch de=
limiters , ; =3D stay bare, a space or a cmd=2Eexe metacharacter<br>forces =
quotes, and an embedded double quote is replaced so quoting cannot<br>be br=
oken out of=2E The first two cases pin the compatibility guarantee -<br>the=
y are what a later &quot;just quote everything&quot; simplification would b=
reak=2E<br><br>Move wide_cmd_line() to win32-util=2Ec next to wide_string()=
, which it<br>calls=2E The unit tests already link that file, so nothing el=
se needs to<br>change to reach it=2E<br><br>Change-Id: Iba66235cbad52692da5=
42abd47e9f51810b0ed66<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&=
gt;<br>---<br>M src/openvpn/win32-util=2Ec<br>M src/openvpn/win32-util=2Eh<=
br>M src/openvpn/win32=2Ec<br>M tests/unit_tests/openvpn/test_argv=2Ec<br>4=
 files changed, 128 insertions(+), 67 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/189=
2/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-uti=
l=2Ec</span><br><span>index 209e34e=2E=2E4e3819c 100644</span><br><span>---=
 a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/src/openvpn/win32-util=
=2Ec</span><br><span>@@ -45,6 +45,73 @@</span><br><span>     return ucs16;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* special to cmd=2Eexe, which CreateProcess() uses to run=
 =2Ebat/=2Ecmd (VU#123335) */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define CMD_QUOTE_TRIGGERS &quot; &amp;|&lt;&gt;^%()!&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+argv_element_needs_quotes(const char *str)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (const char *c =3D str; *c !=3D &#39;\0=
&#39;; ++c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strchr(CMD=
_QUOTE_TRIGGERS, *c) !=3D NULL)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+WCHAR *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+wide_cmd_line(const struct argv *a, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    size_t nchars =3D 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t maxlen =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    size_t i;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *work =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!a)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; a-&gt;arg=
c; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *arg =
=3D a-&gt;argv[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const size_t len =3D strlen(arg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        nchars +=3D len + 3;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (len &gt; maxlen)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            maxlen =3D len;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wo=
rk =3D gc_malloc(maxlen + 1, false, gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    check_malloc_return(work);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(nchars, gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; a-&gt;argc; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        const char *arg =3D a-&gt=
;argv[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
rcpy(work, arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, &#39;_&#39;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;buf, &quo=
t; &quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (argv_e=
lement_needs_quotes(work))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         buf_printf(&amp;buf, &quot;\&quot;%s\&quot;&quot;, work);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            buf_printf(&amp;buf, &quot;%s&quot;, work);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return wide_string(BSTR(&amp;buf), gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> char *</span><br><span> utf16to8(con=
st wchar_t *utf16, struct gc_arena *gc)</span><br><span> {</span><br><span>=
diff --git a/src/openvpn/win32-util=2Eh b/src/openvpn/win32-util=2Eh</span>=
<br><span>index fb83762=2E=2Ec2ad64b 100644</span><br><span>--- a/src/openv=
pn/win32-util=2Eh</span><br><span>+++ b/src/openvpn/win32-util=2Eh</span><b=
r><span>@@ -24,11 +24,15 @@</span><br><span> #ifndef OPENVPN_WIN32_UTIL_H</=
span><br><span> #define OPENVPN_WIN32_UTIL_H</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;argv=2Eh&quot;</s=
pan><br><span> #include &quot;buffer=2Eh&quot;</span><br><span> </span><br>=
<span> /* Convert a string from UTF-8 to UCS-2 */</span><br><span> WCHAR *w=
ide_string(const char *utf8, struct gc_arena *gc);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Build a CreateProcess()=
 command line from argv */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+WCHAR *wide_cmd_line(const struct argv *a, struct gc_arena *gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Co=
nvert a string from UTF-16 to UTF-8 */</span><br><span> char *utf16to8(cons=
t wchar_t *utf16, struct gc_arena *gc);</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>i=
ndex d527160=2E=2E80ec7e8 100644</span><br><span>--- a/src/openvpn/win32=2E=
c</span><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -936,73 +9=
36,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/* special to cmd=2Eexe, whic=
h CreateProcess() uses to run =2Ebat/=2Ecmd (VU#123335) */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define CMD_QUOTE_TRIGGERS &quot; &amp=
;|&lt;&gt;^%()!&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-argv_element_needs_quotes(const=
 char *str)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (const char *c =3D str=
; *c !=3D &#39;\0&#39;; ++c)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (strchr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            return true;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return fal=
se;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static WCHAR *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-wide_cmd_line(const struct argv *a, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    size_t nchars =3D 1;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    size_t maxlen =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size_t i;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct buffer buf;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    char *work =3D NULL;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return NULL=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (i =3D 0; i &lt; a-&gt;argc; ++i)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const char *arg =3D a-&gt;argv[i];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        const size_t len =3D str=
len(arg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ncha=
rs +=3D len + 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (len &gt; maxlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  maxlen =3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    work =3D gc_malloc(maxlen + 1, false, gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    check_malloc_return(work=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D alloc_b=
uf_gc(nchars, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt;=
 a-&gt;argc; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *=
arg =3D a-&gt;argv[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        strcpy(work, arg);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, &#39;_&=
#39;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (i)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;buf, &=
quot; &quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (argv_el=
ement_needs_quotes(work))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    buf_printf(&amp;buf, &quot;\&quot;%s\&quot;&quot;, work);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            buf_printf(&amp;buf, &quot;%s&quot;, work);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn wide_string(BSTR(&amp;buf), gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /*</span><br><span>  * Attempt to simulate fork/execve on Windo=
ws</span><br><span>  */</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec</span><br><span>i=
ndex b1e3261=2E=2E5b6e26e 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_argv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_argv=
=2Ec</span><br><span>@@ -14,6 +14,10 @@</span><br><span> #include &quot;buf=
fer=2Eh&quot;</span><br><span> #include &quot;test_common=2Eh&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _W=
IN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
win32-util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /* Defines for use in the tests and the mock parse_line() */</span><b=
r><span> #define PATH1      &quot;/s p a c e&quot;</span><br><span> #define=
 PATH2      &quot;/foo bar/baz&quot;</span><br><span>@@ -248,6 +252,56 @@</=
span><br><span>     argv_free(&amp;a);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * An argument is quoted if and only if i=
t holds a space or a character that</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * cmd=2Eexe would act on when CreateProcess() runs a =2Eba=
t/=2Ecmd target=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+wide_cmd_line__quotes_onl=
y_what_cmd_would_reinterpret(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    static const struct</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const char *arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const WCHAR *expected;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    } cases[] =3D {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* nothing special - must stay unquoted, or existing scr=
ipts break */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  { &quot;CN=3Duser1&quot;, L&quot;script=2Ebat 0 CN=3Duser1&quot; },</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the batch deli=
miters are deliberately not triggers */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        { &quot;CN=3Da,b;c=3Dd&quot;, L&quot;script=2Eb=
at 0 CN=3Da,b;c=3Dd&quot; },</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* a space has always forced quoting */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        { &quot;O=3DCtrl, CN=3Dy&quot;=
, L&quot;script=2Ebat 0 \&quot;O=3DCtrl, CN=3Dy\&quot;&quot; },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* cmd=2Eexe operators =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;C=
N=3Dx&amp;ver&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&amp;ver\&quot;&quo=
t; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quo=
t;CN=3Dx|ver&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx|ver\&quot;&quot; },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=
=3Dx&gt;f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&gt;f\&quot;&quot; },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3D=
x&lt;f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&lt;f\&quot;&quot; },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx^f=
&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx^f\&quot;&quot; },</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx%f&quot;, L=
&quot;script=2Ebat 0 \&quot;CN=3Dx%f\&quot;&quot; },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx(f)&quot;, L&quot;s=
cript=2Ebat 0 \&quot;CN=3Dx(f)\&quot;&quot; },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx!f&quot;, L&quot;script=2E=
bat 0 \&quot;CN=3Dx!f\&quot;&quot; },</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* a double quote is replaced, so quoting cannot =
be broken out of */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        { &quot;CN=3Da\&quot;b&quot;, L&quot;script=2Ebat 0 CN=3Da_b&quot; =
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(cases); i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct argv a =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_=
printf(&amp;a, &quot;%s %d %s&quot;, &quot;script=2Ebat&quot;, 0, cases[i]=
=2Earg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ass=
ert_int_equal(a=2Eargc, 3);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WCH=
AR *cmd_line =3D wide_cmd_line(&amp;a, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        assert_non_null(cmd_line);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(wcscmp=
(cmd_line, cases[i]=2Eexpected), 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      argv_free(&amp;a);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* _WIN32 */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int=
</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -267,6 +=
321,9 @@</span><br><span>         cmocka_unit_test(argv_str__multiple_argv_=
_correct_output),</span><br><span>         cmocka_unit_test(argv_insert_hea=
d__non_empty_argv__head_added),</span><br><span>         cmocka_unit_test(a=
rgv_insert_head__empty_argv__head_only),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(wide_cmd_line__quotes_only_what_cmd=
_would_reinterpret),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>     };</span><br><span> </span><br><span>     retu=
rn cmocka_run_group_tests_name(&quot;argv&quot;, tests, NULL, NULL);</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1892?usp=3Demail">change 1892</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1892?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iba66235cbad52692da542abd4=
7e9f51810b0ed66 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
892 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--isAFaqpG++A=--


--===============2029508391811277433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2029508391811277433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2029508391811277433==--

