Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C254C61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=uVE0dfC7VIGfrAcuFQ2WB+LEaWC3pEFcr16htipGJLc=; b=fNgHLhl1ylXV6K
	gEPX1n3xYX5wbHFLAjEsmKa8LuKFaL/ZYh6o+eBMJtbmZvuHPlM1kJxfU5J3tKzrzrpkBiaY3q+HA
	QOYK8wz6y4mRCxAfZ1bUqEUlWXdWmiXNK8aqz5Lfm6P2ItEMbPNxYoul84HBwOcR9Nh+yLjx4FsjZ
	QI0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x24i8-0003ue-B1;
	Thu, 03 Sep 2026 10:30:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x24i7-0003uX-9R
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 10:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cm4RPNgUwtTO5cWzY3FATW1yEABURZQdvtbR8kldsFk=; b=Rqhwu+00bd2aJK4otvSp2oZ1yU
 VqMpcb7rRke/dNwxlnzsw3t7ZGO1bBu/qOATgOIWmiDqrlDEtX40oj2makm6li4eAyeK9qCKlz8Z8
 qgG5mk1KsHIb+wZrDcVEcAd9uBS32iCWdhNonrrOpIK48KIvWxc0px4nUzxbA7FjEEDU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Cm4RPNgUwtTO5cWzY3FATW1yEABURZQdvtbR8kldsFk=; b=Y
 //OHLH4a1SD9/rXjFaTG1epWfSmXzwNBIfVXR6sdMgxtgD3qClIMcqoiXm2N75e5KVzNemTIFKZDM
 r28SYPwFZwDavC8k5ljsa/Wbw4ICxCl1lyxGMECUvvUUhZORKS3vKlLFX/feolT7mgFsi45JVjcmD
 9f1IhL5S3ksN2yfM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x24i5-0002yZ-52 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 10:30:23 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4956869750eso15198835e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788431414; x=1789036214; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cm4RPNgUwtTO5cWzY3FATW1yEABURZQdvtbR8kldsFk=;
 b=Z8Q8u5ldzsLKAOvXpC8coPzUUvSA2q5EEozl4lzTjj/SLRNoAM1Fd6YokP9n4gOky/
 L6xCGO4xffmCJDQh6h+CfJb45ml/tOcrRV+FdywaY18BBHEfdMetpGvz+g02MnPmZX7k
 xm1lDacoK4fNDo5XwwK7EWSskjWh/ICxvLrhwgrQjhslwqh4G8xKviQIdaY01EPW5sOa
 dnWR5REj0WIZyOw365G+kkbNwPj+KMsTPAwtMGcdst4SggK2Q7UlErfHEnmPT62ISGAW
 s79DzPje+bPvpAMLN0yB25kpmklbN+Utymb6NJxpH1Vc/qNsvZ77kQQQEmczEc+pkvWK
 g5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788431414; x=1789036214;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cm4RPNgUwtTO5cWzY3FATW1yEABURZQdvtbR8kldsFk=;
 b=mXV4mBtcWL/dv1PKQGlJBH7Yvs6OXlbO+K8nqdks2ztmvSOUTpRGxnDSfsmyJwqkpZ
 deUR4YpEYLFJjicxKmLVX2IWQlu8289NtiS15jZG5b16OrKOpRwj7M2EmkXzlNIy6Wnj
 b6NQh4zHpRxmxtQdNk/bm/YaQ7EaGargNRwlTaGvF6EIh8efEIiy3LVatIwLkw4SMaKC
 UdhAvpbkuxCK1USdnrl6G0W6eqwXEX0ATGOWcHFw3gF2NdhqGknIV+Ob8XkE5vxwOk6A
 cScB4HJNY0aAwcj4z+XwzxIgf6MJ/Bo5UepzgbFFVKutjyzTiileF/WG8usowDC7ICeu
 qooQ==
X-Gm-Message-State: AFuF++mLtjQwkpK0opttdWW3kzUteMQSibvqZ0kOA+fdwn/Om7WaPsvN
 16/1kuYqAB7gejL7/CZYlKQ2KkKqtfepkOBZrNyM39A5JA8wdiXEPmTVm/zB+LhJcfhk1UyxGwB
 WJjwlmNMwbhUyxHpL0IOm/N0ZuuAS9ZQR5ZuliW0vi4+DB3yGn2woZzR9AlIIcEBGtz3z
X-Gm-Gg: AYBFou2YbIFkeZJxWIz1rcA12VRxXPl6M2URbnl/5a8EzEIVgj2o5GXYbNGxsbMFXRo
 yqnB9Mws55UYNy3ACsXP5Ev0jY6SvnyZBM82wFCyZRkIBb1Zl5dCMymolIBLD9khMtRtilj09U1
 rkwa0rkKgHbLtm2USgo/wzV2w3CKU0Li+L3Mnn8v56VoeulltQ8aCOJLWIPiJ9l4bgqQSMTPYZS
 aSq4upc4Wj//YFxeVgpqTxNkRaeqsvysCMiwW7Ti9w0xuML8++oMfuoGFtXqaBFoyyyW0fSv3js
 If5KtPASQhzPrv+nfw2PRh8gKDfTKLBj1JAf6U0+UJoIy9Elpb7FcFtql8HHzxwY6UNGcTASb/v
 VQ+X9CeMOjTCFaF8Xotb8Ucs1G4ha3YjiJTHZ6kKf7oxMTdN3VTKaw6EXMZZilhZpY7xYKl6rYe
 FkSGAV2aezPpYUTJLLW6UH7yKqZ2IvyO5kzGAgqn3IardIK0ycsm+vbq4UXufFT9PI+omj6i3nc
 tfPJsZOlVxsFh76ImH/qbJGpnIM3gdqPNkI34vTqmCQ6MwMZSuXJ/8ZooQmG+8wXLX96AuKCBHD
 8HbP0z89nV8OYfTYxixkpqVXIWeC0QTViZjY48nw3/+V1wOSaT0=
X-Received: by 2002:a05:600c:3b25:b0:49c:cfae:34d2 with SMTP id
 5b1f17b1804b1-49ce55fb5f7mr193706715e9.4.1788431409585; 
 Thu, 03 Sep 2026 03:30:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm117444835e9.1.2026.09.03.03.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 03:30:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 10:30:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
X-Gerrit-Change-Number: 1895
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1895?usp=email>
X-Gerrit-Commit: a7ec3039f051c7664d7d004a1fea2a301d4b639f
References: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDMxNDA2MDAwLkk3MGRmZGM3MDc3ODQ1OGI3OGY4MGI4ZDBiMGI3ODZmMThmZTRmYzc2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cc51f38a06fd84847f61320b04bcf3f9b0198e35-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x24i5-0002yZ-52
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: stop cmd.exe
 from expanding variables in quoted arguments
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7258031384468934816=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7258031384468934816==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xsL/TrPqjcQ="; charset=UTF-8

--xsL/TrPqjcQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1895?usp=3Demail

to review the following change=2E


Chang=
e subject: win32: stop cmd=2Eexe from expanding variables in quoted argumen=
ts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32: sto=
p cmd=2Eexe from expanding variables in quoted arguments

Commit cf08504 qu=
otes arguments that contain cmd=2Eexe metacharacters, so a
certificate subj=
ect passed to --tls-verify cannot start a second command
when CreateProcess=
() runs a =2Ebat or =2Ecmd hook=2E

Quoting is not enough for %VAR% and !VA=
R!: cmd=2Eexe expands those even
inside double quotes, and OpenVPN exports =
peer-controlled certificate
fields into the child environment=2E A subject =
that puts a quote and an
operator in one field (O=3DBREAK"&whoami&") and re=
ferences it from another
(CN=3D%X509_0_O%) expands back into a quote and co=
mmand operator after
wide_cmd_line() has already replaced the direct quotes=
, running a command
before the hook can reject the peer=2E

Replace % and !=
 in wide_cmd_line() along with the double quotes and CRLF,
so no argument c=
an expand=2E This reuses two character classes that had no
users, CC_AT and=
 CC_EQUAL, renamed to CC_PERCENT and CC_EXCLAMATION=2E Add
regression tests=
 for a bare percent or bang, a closed expansion token, and
the reported sub=
ject=2E

This completes the CVE-2026-84256 fix for Windows batch hooks=2E

=
GitHub: OpenVPN/openvpn-private-issues#176
Reported-By: Darren Carreras
CVE=
: 2026-84256
Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
Signed-of=
f-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/buffer=2Ec
M src/o=
penvpn/buffer=2Eh
M src/openvpn/win32-util=2Ec
M tests/unit_tests/openvpn/t=
est_argv=2Ec
4 files changed, 53 insertions(+), 8 deletions(-)



  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/1895/1

diff -=
-git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 5ce2e39=2E=2E5=
d00415 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ =
-943,11 +943,11 @@
     {
         return true;
     }
-    if ((flags & CC=
_AT) && c =3D=3D '@')
+    if ((flags & CC_PERCENT) && c =3D=3D '%')
     {=

         return true;
     }
-    if ((flags & CC_EQUAL) && c =3D=3D '=3D'=
)
+    if ((flags & CC_EXCLAMATION) && c =3D=3D '!')
     {
         return=
 true;
     }
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
=
index 4471697=2E=2E0a02e94 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/op=
envpn/buffer=2Eh
@@ -1660,8 +1660,8 @@
 #define CC_SINGLE_QUOTE  (1 << 21) =
/**< single quote */
 #define CC_DOUBLE_QUOTE  (1 << 22) /**< double quote =
*/
 #define CC_REVERSE_QUOTE (1 << 23) /**< reverse quote */
-#define CC_AT=
            (1 << 24) /**< at sign */
-#define CC_EQUAL         (1 << 25) /=
**< equal sign */
+#define CC_PERCENT       (1 << 24) /**< percent sign */
=
+#define CC_EXCLAMATION   (1 << 25) /**< exclamation mark */
 #define CC_LE=
SS_THAN     (1 << 26) /**< less than sign */
 #define CC_GREATER_THAN  (1 <=
< 27) /**< greater than sign */
 #define CC_PIPE          (1 << 28) /**< pi=
pe */
diff --git a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-util=2Ec
=
index 4e3819c=2E=2Ee2c8810 100644
--- a/src/openvpn/win32-util=2Ec
+++ b/sr=
c/openvpn/win32-util=2Ec
@@ -94,7 +94,10 @@
     {
         const char *arg=
 =3D a->argv[i];
         strcpy(work, arg);
-        string_mod(work, CC_P=
RINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
+        /* cmd=2Eexe expands %VAR% =
and !VAR! even inside quotes, so a value like
+         * %X509_0_O% could =
turn back into a quote and start a new command=2E
+         * Replace those=
 along with the double quotes and CRLF=2E */
+        string_mod(work, CC_P=
RINT, CC_DOUBLE_QUOTE | CC_CRLF | CC_PERCENT | CC_EXCLAMATION, '_');
      =
   if (i)
         {
             buf_printf(&buf, " ");
diff --git a/tests=
/unit_tests/openvpn/test_argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec
=
index 5b6e26e=2E=2E1fc73d8 100644
--- a/tests/unit_tests/openvpn/test_argv=
=2Ec
+++ b/tests/unit_tests/openvpn/test_argv=2Ec
@@ -271,15 +271,13 @@
   =
      { "CN=3Da,b;c=3Dd", L"script=2Ebat 0 CN=3Da,b;c=3Dd" },
         /* a=
 space has always forced quoting */
         { "O=3DCtrl, CN=3Dy", L"script=
=2Ebat 0 \"O=3DCtrl, CN=3Dy\"" },
-        /* cmd=2Eexe operators */
+     =
   /* cmd=2Eexe operators that quoting neutralizes */
         { "CN=3Dx&ve=
r", L"script=2Ebat 0 \"CN=3Dx&ver\"" },
         { "CN=3Dx|ver", L"script=
=2Ebat 0 \"CN=3Dx|ver\"" },
         { "CN=3Dx>f", L"script=2Ebat 0 \"CN=3D=
x>f\"" },
         { "CN=3Dx<f", L"script=2Ebat 0 \"CN=3Dx<f\"" },
        =
 { "CN=3Dx^f", L"script=2Ebat 0 \"CN=3Dx^f\"" },
-        { "CN=3Dx%f", L"s=
cript=2Ebat 0 \"CN=3Dx%f\"" },
         { "CN=3Dx(f)", L"script=2Ebat 0 \"C=
N=3Dx(f)\"" },
-        { "CN=3Dx!f", L"script=2Ebat 0 \"CN=3Dx!f\"" },
   =
      /* a double quote is replaced, so quoting cannot be broken out of */
=
         { "CN=3Da\"b", L"script=2Ebat 0 CN=3Da_b" },
     };
@@ -300,6 +29=
8,49 @@
         gc_free(&gc);
     }
 }
+
+/*
+ * cmd=2Eexe expands %VAR% =
and !VAR! even inside quotes, and OpenVPN puts
+ * peer-controlled data (e=
=2Eg=2E certificate subject fields) on the command line,
+ * so these chara=
cters are replaced to stop a value from expanding back into a
+ * quote and=
 command operator=2E
+ */
+static void
+wide_cmd_line__replaces_cmd_expansi=
on(void **state)
+{
+    static const struct
+    {
+        const char *ar=
g;
+        const WCHAR *expected;
+    } cases[] =3D {
+        /* a bare =
percent or bang is replaced */
+        { "CN=3Dx%f", L"script=2Ebat 0 CN=
=3Dx_f" },
+        { "CN=3Dx!f", L"script=2Ebat 0 CN=3Dx_f" },
+        /*=
 a closed expansion token is replaced, so nothing expands */
+        { "CN=
=3D%X509_0_O%", L"script=2Ebat 0 CN=3D_X509_0_O_" },
+        { "CN=3D!X509=
_0_O!", L"script=2Ebat 0 CN=3D_X509_0_O_" },
+        /* the reported bypas=
s: quotes in one field are already replaced, and
+         * neutralizing %=
 stops %X509_0_O% from re-injecting them */
+        { "O=3DBREAK\"&whoami&=
\", CN=3D%X509_0_O%",
+          L"script=2Ebat 0 \"O=3DBREAK_&whoami&_, CN=
=3D_X509_0_O_\"" },
+    };
+
+    for (size_t i =3D 0; i < SIZE(cases); i+=
+)
+    {
+        struct gc_arena gc =3D gc_new();
+        struct argv a =
=3D argv_new();
+
+        argv_printf(&a, "%s %d %s", "script=2Ebat", 0, c=
ases[i]=2Earg);
+        assert_int_equal(a=2Eargc, 3);
+
+        WCHAR *c=
md_line =3D wide_cmd_line(&a, &gc);
+        assert_non_null(cmd_line);
+  =
      assert_int_equal(wcscmp(cmd_line, cases[i]=2Eexpected), 0);
+
+      =
  argv_free(&a);
+        gc_free(&gc);
+    }
+}
 #endif /* _WIN32 */
 
 i=
nt
@@ -323,6 +364,7 @@
         cmocka_unit_test(argv_insert_head__empty_ar=
gv__head_only),
 #ifdef _WIN32
         cmocka_unit_test(wide_cmd_line__quo=
tes_only_what_cmd_would_reinterpret),
+        cmocka_unit_test(wide_cmd_li=
ne__replaces_cmd_expansion),
 #endif
     };
 

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
Gerr=
it-Change-Number: 1895
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--xsL/TrPqjcQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1895?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">wi=
n32: stop cmd=2Eexe from expanding variables in quoted arguments<br><br>Com=
mit cf08504 quotes arguments that contain cmd=2Eexe metacharacters, so a<br=
>certificate subject passed to --tls-verify cannot start a second command<b=
r>when CreateProcess() runs a =2Ebat or =2Ecmd hook=2E<br><br>Quoting is no=
t enough for %VAR% and !VAR!: cmd=2Eexe expands those even<br>inside double=
 quotes, and OpenVPN exports peer-controlled certificate<br>fields into the=
 child environment=2E A subject that puts a quote and an<br>operator in one=
 field (O=3DBREAK&quot;&amp;whoami&amp;&quot;) and references it from anoth=
er<br>(CN=3D%X509_0_O%) expands back into a quote and command operator afte=
r<br>wide_cmd_line() has already replaced the direct quotes, running a comm=
and<br>before the hook can reject the peer=2E<br><br>Replace % and ! in wid=
e_cmd_line() along with the double quotes and CRLF,<br>so no argument can e=
xpand=2E This reuses two character classes that had no<br>users, CC_AT and =
CC_EQUAL, renamed to CC_PERCENT and CC_EXCLAMATION=2E Add<br>regression tes=
ts for a bare percent or bang, a closed expansion token, and<br>the reporte=
d subject=2E<br><br>This completes the CVE-2026-84256 fix for Windows batch=
 hooks=2E<br><br>GitHub: OpenVPN/openvpn-private-issues#176<br>Reported-By:=
 Darren Carreras<br>CVE: 2026-84256<br>Change-Id: I70dfdc70778458b78f80b8d0=
b0b786f18fe4fc76<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<b=
r>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M src/open=
vpn/win32-util=2Ec<br>M tests/unit_tests/openvpn/test_argv=2Ec<br>4 files c=
hanged, 53 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/1895/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><sp=
an>index 5ce2e39=2E=2E5d00415 100644</span><br><span>--- a/src/openvpn/buff=
er=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -943=
,11 +943,11 @@</span><br><span>     {</span><br><span>         return true;=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if ((flags &amp; CC_AT) &amp;&amp; c =3D=3D &#39;@&#39;)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; CC_PERCENT)=
 &amp;&amp; c =3D=3D &#39;%&#39;)</span><br><span>     {</span><br><span>  =
       return true;</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if ((flags &amp; CC_EQUAL) &amp;&amp; c =3D=3D &#3=
9;=3D&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
(flags &amp; CC_EXCLAMATION) &amp;&amp; c =3D=3D &#39;!&#39;)</span><br><sp=
an>     {</span><br><span>         return true;</span><br><span>     }</spa=
n><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</s=
pan><br><span>index 4471697=2E=2E0a02e94 100644</span><br><span>--- a/src/o=
penvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><s=
pan>@@ -1660,8 +1660,8 @@</span><br><span> #define CC_SINGLE_QUOTE  (1 &lt;=
&lt; 21) /**&lt; single quote */</span><br><span> #define CC_DOUBLE_QUOTE  =
(1 &lt;&lt; 22) /**&lt; double quote */</span><br><span> #define CC_REVERSE=
_QUOTE (1 &lt;&lt; 23) /**&lt; reverse quote */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define CC_AT            (1 &lt;&lt; 24) /**&lt; =
at sign */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_=
EQUAL         (1 &lt;&lt; 25) /**&lt; equal sign */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CC_PERCENT       (1 &lt;&lt; 24) =
/**&lt; percent sign */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define CC_EXCLAMATION   (1 &lt;&lt; 25) /**&lt; exclamation mark */</s=
pan><br><span> #define CC_LESS_THAN     (1 &lt;&lt; 26) /**&lt; less than s=
ign */</span><br><span> #define CC_GREATER_THAN  (1 &lt;&lt; 27) /**&lt; gr=
eater than sign */</span><br><span> #define CC_PIPE          (1 &lt;&lt; 28=
) /**&lt; pipe */</span><br><span>diff --git a/src/openvpn/win32-util=2Ec b=
/src/openvpn/win32-util=2Ec</span><br><span>index 4e3819c=2E=2Ee2c8810 1006=
44</span><br><span>--- a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/s=
rc/openvpn/win32-util=2Ec</span><br><span>@@ -94,7 +94,10 @@</span><br><spa=
n>     {</span><br><span>         const char *arg =3D a-&gt;argv[i];</span>=
<br><span>         strcpy(work, arg);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRL=
F, &#39;_&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* cmd=2Eexe expands %VAR% and !VAR! even inside quotes, so a value li=
ke</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * %X509_=
0_O% could turn back into a quote and start a new command=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * Replace those along wit=
h the double quotes and CRLF=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF=
 | CC_PERCENT | CC_EXCLAMATION, &#39;_&#39;);</span><br><span>         if (=
i)</span><br><span>         {</span><br><span>             buf_printf(&amp;=
buf, &quot; &quot;);</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec</span><br><span>inde=
x 5b6e26e=2E=2E1fc73d8 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_argv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_argv=2E=
c</span><br><span>@@ -271,15 +271,13 @@</span><br><span>         { &quot;CN=
=3Da,b;c=3Dd&quot;, L&quot;script=2Ebat 0 CN=3Da,b;c=3Dd&quot; },</span><br=
><span>         /* a space has always forced quoting */</span><br><span>   =
      { &quot;O=3DCtrl, CN=3Dy&quot;, L&quot;script=2Ebat 0 \&quot;O=3DCtrl=
, CN=3Dy\&quot;&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        /* cmd=2Eexe operators */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* cmd=2Eexe operators that quoting neutralizes */=
</span><br><span>         { &quot;CN=3Dx&amp;ver&quot;, L&quot;script=2Ebat=
 0 \&quot;CN=3Dx&amp;ver\&quot;&quot; },</span><br><span>         { &quot;C=
N=3Dx|ver&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx|ver\&quot;&quot; },</s=
pan><br><span>         { &quot;CN=3Dx&gt;f&quot;, L&quot;script=2Ebat 0 \&q=
uot;CN=3Dx&gt;f\&quot;&quot; },</span><br><span>         { &quot;CN=3Dx&lt;=
f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&lt;f\&quot;&quot; },</span><br=
><span>         { &quot;CN=3Dx^f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx=
^f\&quot;&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     { &quot;CN=3Dx%f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx%f\&quot;&q=
uot; },</span><br><span>         { &quot;CN=3Dx(f)&quot;, L&quot;script=2Eb=
at 0 \&quot;CN=3Dx(f)\&quot;&quot; },</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        { &quot;CN=3Dx!f&quot;, L&quot;script=2Ebat 0 \&quo=
t;CN=3Dx!f\&quot;&quot; },</span><br><span>         /* a double quote is re=
placed, so quoting cannot be broken out of */</span><br><span>         { &q=
uot;CN=3Da\&quot;b&quot;, L&quot;script=2Ebat 0 CN=3Da_b&quot; },</span><br=
><span>     };</span><br><span>@@ -300,6 +298,49 @@</span><br><span>       =
  gc_free(&amp;gc);</span><br><span>     }</span><br><span> }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * cmd=2Eexe expands %VAR% and !VAR! even inside quotes, and OpenVPN =
puts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * peer-control=
led data (e=2Eg=2E certificate subject fields) on the command line,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * so these characters are =
replaced to stop a value from expanding back into a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * quote and command operator=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+wide_cmd_line__replaces_cmd_expansion(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    static const struct</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const char *arg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const WCHAR *expected;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    } cases[] =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* a bare percent or b=
ang is replaced */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       { &quot;CN=3Dx%f&quot;, L&quot;script=2Ebat 0 CN=3Dx_f&quot; },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx!f=
&quot;, L&quot;script=2Ebat 0 CN=3Dx_f&quot; },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* a closed expansion token is replaced=
, so nothing expands */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        { &quot;CN=3D%X509_0_O%&quot;, L&quot;script=2Ebat 0 CN=3D_X509=
_0_O_&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   { &quot;CN=3D!X509_0_O!&quot;, L&quot;script=2Ebat 0 CN=3D_X509_0_O_&quo=
t; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the=
 reported bypass: quotes in one field are already replaced, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * neutralizing % stops=
 %X509_0_O% from re-injecting them */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        { &quot;O=3DBREAK\&quot;&amp;whoami&amp;\&quot;, =
CN=3D%X509_0_O%&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          L&quot;script=2Ebat 0 \&quot;O=3DBREAK_&amp;whoami&amp;_, CN=
=3D_X509_0_O_\&quot;&quot; },</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D =
0; i &lt; SIZE(cases); i++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct argv a =3D argv_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        argv_printf(&amp;a, &quot;%s %d %s&quot;, &quot;scri=
pt=2Ebat&quot;, 0, cases[i]=2Earg);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        assert_int_equal(a=2Eargc, 3);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        WCHAR *cmd_line =3D wide_cmd_line(&amp;a, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_non_=
null(cmd_line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    assert_int_equal(wcscmp(cmd_line, cases[i]=2Eexpected), 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        argv_free(&amp;a);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* _WIN32 */</span><br>=
<span> </span><br><span> int</span><br><span>@@ -323,6 +364,7 @@</span><br>=
<span>         cmocka_unit_test(argv_insert_head__empty_argv__head_only),</=
span><br><span> #ifdef _WIN32</span><br><span>         cmocka_unit_test(wid=
e_cmd_line__quotes_only_what_cmd_would_reinterpret),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(wide_cmd_line__r=
eplaces_cmd_expansion),</span><br><span> #endif</span><br><span>     };</sp=
an><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail">change 1895=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70=
dfdc70778458b78f80b8d0b0b786f18fe4fc76 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1895 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipako=
v@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--xsL/TrPqjcQ=--


--===============7258031384468934816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7258031384468934816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7258031384468934816==--

