Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C65C79FA1
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXAFJ2ZMUr+OOAnN/1BbCMWRk7jRMJEO8XURlgvTRGE=; b=lxAgs9FBIcePEgKjgIjoXpAepP
	POV0OrCrCThJ0KxvkVaOQXbj+WOMmo9qyjvPFpOvOhmbpy+nDNi4OHno5zYXEwv2UF2C309HsJMpj
	baNHcB0R0V4RVzFfjQ+6TILzFxDDRhcrt7GyKY4J4EwS6gybCNMsBKByEt+3Kq+Durb4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bpV-0004Og-9d;
	Mon, 07 Sep 2026 16:04:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3bpT-0004OS-Nx
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=M8FuANChzNerHQNizHYAe/3QCGaTfTQPS4GT9IZ+Xoc=; b=mCTQUnOPRx0mhWwHthGPaNSeZv
 WsQOzjJWd2lmiV5hCXO/ZpXNBM7ljFoVuH7A33hB54jjw9sXA1mAZOuJLGEzZtoHl7owjZS5i5zBt
 pmWLrF/I/Ozawk5yxipaaPPXtdatosMvQLTh8EnJWKS9o57HXHU1e3eqrSGBqU5LVM4I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M8FuANChzNerHQNizHYAe/3QCGaTfTQPS4GT9IZ+Xoc=; b=R
 S4l7ZNJflvdLk88ZOdPNV7yqt/MkYni4VPPfS1bec/HN8ayODnaFwE4qi4bgYKyUhJK15x+DhxuSl
 SrhcOKIyJ1bXAFRia0LadjEgtcFu04KQwrdvTRurQFRlpk1G4ybe1VHrNALlf9kdIpLRq4OGgTQT/
 TslB7+TpKcLzVJn4=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3bpS-0001YM-Uf for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:04:20 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so2391074f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788797052; x=1789401852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M8FuANChzNerHQNizHYAe/3QCGaTfTQPS4GT9IZ+Xoc=;
 b=a68M/KIXVpXNBzwVGmhWNiEQXSihWPQccyObk7SSWPZOhYCNsjICetz+IkIgSBqsoz
 z/Ua01yGM6+15y6xAuZ20E70n3pP98FADx+rILB20qMwr3PYYiwunnfa2W+UJlj6Xl6d
 FPmmNYYEv5tniUcOIAODaL7pTS8BPkYzsPQdaPoqmYwrT9bOOXPP2ziPPtTfBvlOlbiK
 83+6r96d5mRm/9RVK/4kRiqm/tlCOt/XvCPmGTVPOzC1tkns2iGW7Ge8gFwjuo2zDID8
 cDTIuMT/pwPHAp/+S+ODY7kW3YdV21bVLj3e/r0YluwweEKn3Ftm8VE/OA9aR4vRUo/X
 OJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788797052; x=1789401852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=M8FuANChzNerHQNizHYAe/3QCGaTfTQPS4GT9IZ+Xoc=;
 b=V3W8MAdA5XTVsKQcWhn7LmXQdyhIiISKvLz3u7ZgD4N9CrxyLOMJDgr54/7Uz9iSUL
 xoMjLkpshPO9uu/FUTN3Fwx8YA7L3dVK1w8yn3+QaUg8cyJ0HGXooBHIXJx9+R+IwSVZ
 WCk2CuXYjcnerxaqLy3ZELpUK4DseoAb0dy/XwbK3f7mF/YKck+NCNXvpkGcRJGQFc/j
 GIPt5bcyNANMzjp7WnYrf50mprpX99D3+m3mZTjY5aqSh/liAXsFr6/2id8WskPYZJkg
 ck820RIIPG4ZKDMlcidv1tSdo7NnzQ9VHKEknqbA+j2HOR9fA6Hnno80xTltMerfb++a
 99yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMNC49HJtuqnBEefupCgXQmllWnOI78TO4iloVfGmG6HkFYwz6nqwh3DkX1dn1YXQ10XIvlFWYNc53B1XV@lists.sourceforge.net
X-Gm-Message-State: AFuF++llaa/Y0NHL97DfLENLAhPv82WOZaQ6dXeOQi1zf3lvkrWF1rpx
 MA0HnkoAWcdum79NNdk2fjQolmmqe+MNdNjXhicNc5mtnLx26sb/AvFn6cUCXww6hxdhob+vyF0
 eSQSx2hz7mUum6Qn28JZV0ZjYlfnG0yzayUE6FBJj0Y4nRswyrzjzCojcCqFbKkTGfFWa
X-Gm-Gg: AYBFou1UsU8BW/vHGgvZs02NMtukKtIkngEg79K8PsDB6VM0s4vDZe3fYrn7Ksmkmzu
 DkjP4ZpR3gr45oL8d5hmg0k/4XfjeKnVTotMm2Goq4lM0BZVBhYqCxZX9/ExGtM/Z4RK1oIZyiX
 vEZUKxrWsp7hn6zwCIjY/+wZqTOVYB/t2WPbbBJj10wgYDP83cKBY9yT9Rs9lWP2T+fWgO8ZxA/
 WTR2NZ79HgcOKwqyAXJtr6iC61eusHqWYyRApmkZ+pMbQQu+i0QwuIkkdtxIHX5VmiksMKUzhhs
 FjhTo075hj5Ic+Krs8YJq/Rr7Dv7Mb7pMN7E60mbw4M5booxGQVeEyrPj8x1vfQMBtgc598kxdy
 zxYbZef12ha8fNGezeYpp+kRNb0cYBP0XXYZFimmfmuxDFRBg1n93jB8G86KsM7DwI68fJiZanp
 Zz+C3WqcACvD9YNxOmpzrjK0qRZ9STxTaDRfMigjwN2bGUGJqinZLg51NeHppWYMzUHSLlgj5/o
 gpCTYQdQ54lFxYPvg5OJ/WxE/cn4K39/lTaF0HLM+Pmgqvvi8bvrE/QYsmJkLu+Z/u/CiHaA0sc
 Y0DMpInQjdcB+Us3U8XuoGo8FKEBc3IB4cvQ2Agl1rHBDtBUoqI=
X-Received: by 2002:a05:6000:29c9:b0:485:8e80:40c with SMTP id
 ffacd0b85a97d-4858e80051emr15005307f8f.48.1788797052271; 
 Mon, 07 Sep 2026 09:04:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm22834890f8f.11.2026.09.07.09.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:04:11 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 16:04:11 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
X-Gerrit-Change-Number: 1895
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1895?usp=email>
X-Gerrit-Commit: eb12c84ef08566c4d2d5f3ea1294891339a5b5e9
In-Reply-To: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
References: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDMxNDA2MDAwLkk3MGRmZGM3MDc3ODQ1OGI3OGY4MGI4ZDBiMGI3ODZmMThmZTRmYzc2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46389cc6e6bea0b1ea88c0aaae97707f1fefb63d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3bpS-0001YM-Uf
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6520008315061496068=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6520008315061496068==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KDl8j8ZK7Dk="; charset=UTF-8

--KDl8j8ZK7Dk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1895?usp=3Demail )

Change subject: win32: stop cmd=2Eexe from expandin=
g variables in quoted arguments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

win32: stop cmd=2Eexe from expanding variables in quote=
d arguments

Commit cf08504 quotes arguments that contain cmd=2Eexe metacha=
racters, so a
certificate subject passed to --tls-verify cannot start a sec=
ond command
when CreateProcess() runs a =2Ebat or =2Ecmd hook=2E

Quoting i=
s not enough for %VAR% and !VAR!: cmd=2Eexe expands those even
inside doubl=
e quotes, and OpenVPN exports peer-controlled certificate
fields into the c=
hild environment=2E A subject that puts a quote and an
operator in one fiel=
d (O=3DBREAK"&whoami&") and references it from another
(CN=3D%X509_0_O%) ex=
pands back into a quote and command operator after
wide_cmd_line() has alre=
ady replaced the direct quotes, running a command
before the hook can rejec=
t the peer=2E

Replace % and ! in wide_cmd_line() along with the double quo=
tes and CRLF,
so no argument can expand=2E This reuses two character classe=
s that had no
users, CC_AT and CC_EQUAL, renamed to CC_PERCENT and CC_EXCLA=
MATION=2E Add
regression tests for a bare percent or bang, a closed expansi=
on token, and
the reported subject=2E

This completes the CVE-2026-84256 fi=
x for Windows batch hooks=2E

GitHub: OpenVPN/openvpn-private-issues#176
Re=
ported-By: Darren Carreras
CVE: 2026-84256
Change-Id: I70dfdc70778458b78f80=
b8d0b0b786f18fe4fc76
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1895
Message-Id: <20260907144351=2E22085-1-gert@gre=
enie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38985=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src=
/openvpn/win32-util=2Ec
M tests/unit_tests/openvpn/test_argv=2Ec
4 files ch=
anged, 53 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/buffer=
=2Ec b/src/openvpn/buffer=2Ec
index 5ce2e39=2E=2E5d00415 100644
--- a/src/o=
penvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -943,11 +943,11 @@
     {=

         return true;
     }
-    if ((flags & CC_AT) && c =3D=3D '@')
+  =
  if ((flags & CC_PERCENT) && c =3D=3D '%')
     {
         return true;
  =
   }
-    if ((flags & CC_EQUAL) && c =3D=3D '=3D')
+    if ((flags & CC_EX=
CLAMATION) && c =3D=3D '!')
     {
         return true;
     }
diff --git =
a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 4471697=2E=2E0a02e9=
4 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1660=
,8 +1660,8 @@
 #define CC_SINGLE_QUOTE  (1 << 21) /**< single quote */
 #de=
fine CC_DOUBLE_QUOTE  (1 << 22) /**< double quote */
 #define CC_REVERSE_QU=
OTE (1 << 23) /**< reverse quote */
-#define CC_AT            (1 << 24) /**=
< at sign */
-#define CC_EQUAL         (1 << 25) /**< equal sign */
+#defin=
e CC_PERCENT       (1 << 24) /**< percent sign */
+#define CC_EXCLAMATION  =
 (1 << 25) /**< exclamation mark */
 #define CC_LESS_THAN     (1 << 26) /**=
< less than sign */
 #define CC_GREATER_THAN  (1 << 27) /**< greater than s=
ign */
 #define CC_PIPE          (1 << 28) /**< pipe */
diff --git a/src/op=
envpn/win32-util=2Ec b/src/openvpn/win32-util=2Ec
index 4e3819c=2E=2Ee2c881=
0 100644
--- a/src/openvpn/win32-util=2Ec
+++ b/src/openvpn/win32-util=2Ec
=
@@ -94,7 +94,10 @@
     {
         const char *arg =3D a->argv[i];
        =
 strcpy(work, arg);
-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | C=
C_CRLF, '_');
+        /* cmd=2Eexe expands %VAR% and !VAR! even inside quo=
tes, so a value like
+         * %X509_0_O% could turn back into a quote an=
d start a new command=2E
+         * Replace those along with the double qu=
otes and CRLF=2E */
+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | C=
C_CRLF | CC_PERCENT | CC_EXCLAMATION, '_');
         if (i)
         {
    =
         buf_printf(&buf, " ");
diff --git a/tests/unit_tests/openvpn/test_=
argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec
index 5b6e26e=2E=2E1fc73d=
8 100644
--- a/tests/unit_tests/openvpn/test_argv=2Ec
+++ b/tests/unit_test=
s/openvpn/test_argv=2Ec
@@ -271,15 +271,13 @@
         { "CN=3Da,b;c=3Dd", =
L"script=2Ebat 0 CN=3Da,b;c=3Dd" },
         /* a space has always forced q=
uoting */
         { "O=3DCtrl, CN=3Dy", L"script=2Ebat 0 \"O=3DCtrl, CN=3D=
y\"" },
-        /* cmd=2Eexe operators */
+        /* cmd=2Eexe operators =
that quoting neutralizes */
         { "CN=3Dx&ver", L"script=2Ebat 0 \"CN=
=3Dx&ver\"" },
         { "CN=3Dx|ver", L"script=2Ebat 0 \"CN=3Dx|ver\"" },=

         { "CN=3Dx>f", L"script=2Ebat 0 \"CN=3Dx>f\"" },
         { "CN=3D=
x<f", L"script=2Ebat 0 \"CN=3Dx<f\"" },
         { "CN=3Dx^f", L"script=2Eb=
at 0 \"CN=3Dx^f\"" },
-        { "CN=3Dx%f", L"script=2Ebat 0 \"CN=3Dx%f\""=
 },
         { "CN=3Dx(f)", L"script=2Ebat 0 \"CN=3Dx(f)\"" },
-        { "=
CN=3Dx!f", L"script=2Ebat 0 \"CN=3Dx!f\"" },
         /* a double quote is =
replaced, so quoting cannot be broken out of */
         { "CN=3Da\"b", L"s=
cript=2Ebat 0 CN=3Da_b" },
     };
@@ -300,6 +298,49 @@
         gc_free(&g=
c);
     }
 }
+
+/*
+ * cmd=2Eexe expands %VAR% and !VAR! even inside quote=
s, and OpenVPN puts
+ * peer-controlled data (e=2Eg=2E certificate subject =
fields) on the command line,
+ * so these characters are replaced to stop a=
 value from expanding back into a
+ * quote and command operator=2E
+ */
+s=
tatic void
+wide_cmd_line__replaces_cmd_expansion(void **state)
+{
+    sta=
tic const struct
+    {
+        const char *arg;
+        const WCHAR *exp=
ected;
+    } cases[] =3D {
+        /* a bare percent or bang is replaced =
*/
+        { "CN=3Dx%f", L"script=2Ebat 0 CN=3Dx_f" },
+        { "CN=3Dx!=
f", L"script=2Ebat 0 CN=3Dx_f" },
+        /* a closed expansion token is r=
eplaced, so nothing expands */
+        { "CN=3D%X509_0_O%", L"script=2Ebat=
 0 CN=3D_X509_0_O_" },
+        { "CN=3D!X509_0_O!", L"script=2Ebat 0 CN=3D=
_X509_0_O_" },
+        /* the reported bypass: quotes in one field are alr=
eady replaced, and
+         * neutralizing % stops %X509_0_O% from re-inje=
cting them */
+        { "O=3DBREAK\"&whoami&\", CN=3D%X509_0_O%",
+       =
   L"script=2Ebat 0 \"O=3DBREAK_&whoami&_, CN=3D_X509_0_O_\"" },
+    };
+
=
+    for (size_t i =3D 0; i < SIZE(cases); i++)
+    {
+        struct gc_a=
rena gc =3D gc_new();
+        struct argv a =3D argv_new();
+
+        arg=
v_printf(&a, "%s %d %s", "script=2Ebat", 0, cases[i]=2Earg);
+        asser=
t_int_equal(a=2Eargc, 3);
+
+        WCHAR *cmd_line =3D wide_cmd_line(&a, =
&gc);
+        assert_non_null(cmd_line);
+        assert_int_equal(wcscmp(=
cmd_line, cases[i]=2Eexpected), 0);
+
+        argv_free(&a);
+        gc_f=
ree(&gc);
+    }
+}
 #endif /* _WIN32 */
 
 int
@@ -323,6 +364,7 @@
       =
  cmocka_unit_test(argv_insert_head__empty_argv__head_only),
 #ifdef _WIN32=

         cmocka_unit_test(wide_cmd_line__quotes_only_what_cmd_would_reinte=
rpret),
+        cmocka_unit_test(wide_cmd_line__replaces_cmd_expansion),
 =
#endif
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1895?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: m=
erged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70df=
dc70778458b78f80b8d0b0b786f18fe4fc76
Gerrit-Change-Number: 1895
Gerrit-Patc=
hSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--KDl8j8ZK7Dk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1895?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">win32: stop cmd=2Eexe from expanding varia=
bles in quoted arguments<br><br>Commit cf08504 quotes arguments that contai=
n cmd=2Eexe metacharacters, so a<br>certificate subject passed to --tls-ver=
ify cannot start a second command<br>when CreateProcess() runs a =2Ebat or =
=2Ecmd hook=2E<br><br>Quoting is not enough for %VAR% and !VAR!: cmd=2Eexe =
expands those even<br>inside double quotes, and OpenVPN exports peer-contro=
lled certificate<br>fields into the child environment=2E A subject that put=
s a quote and an<br>operator in one field (O=3DBREAK&quot;&amp;whoami&amp;&=
quot;) and references it from another<br>(CN=3D%X509_0_O%) expands back int=
o a quote and command operator after<br>wide_cmd_line() has already replace=
d the direct quotes, running a command<br>before the hook can reject the pe=
er=2E<br><br>Replace % and ! in wide_cmd_line() along with the double quote=
s and CRLF,<br>so no argument can expand=2E This reuses two character class=
es that had no<br>users, CC_AT and CC_EQUAL, renamed to CC_PERCENT and CC_E=
XCLAMATION=2E Add<br>regression tests for a bare percent or bang, a closed =
expansion token, and<br>the reported subject=2E<br><br>This completes the C=
VE-2026-84256 fix for Windows batch hooks=2E<br><br>GitHub: OpenVPN/openvpn=
-private-issues#176<br>Reported-By: Darren Carreras<br>CVE: 2026-84256<br>C=
hange-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76<br>Signed-off-by: Lev S=
tipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1895<br>Message-Id: &lt;20260907144351=2E22085-1-gert@greenie=2Emuc=2Ede&g=
t;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefor=
ge=2Enet/msg38985=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh=
<br>M src/openvpn/win32-util=2Ec<br>M tests/unit_tests/openvpn/test_argv=2E=
c<br>4 files changed, 53 insertions(+), 8 deletions(-)<br><br></pre>
<pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>i=
ndex 5ce2e39=2E=2E5d00415 100644</span><br><span>--- a/src/openvpn/buffer=
=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -943,1=
1 +943,11 @@</span><br><span>     {</span><br><span>         return true;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if ((flags &amp; CC_AT) &amp;&amp; c =3D=3D &#39;@&#39;)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &amp; CC_PERCENT) &=
amp;&amp; c =3D=3D &#39;%&#39;)</span><br><span>     {</span><br><span>    =
     return true;</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if ((flags &amp; CC_EQUAL) &amp;&amp; c =3D=3D &#39;=
=3D&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((f=
lags &amp; CC_EXCLAMATION) &amp;&amp; c =3D=3D &#39;!&#39;)</span><br><span=
>     {</span><br><span>         return true;</span><br><span>     }</span>=
<br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</spa=
n><br><span>index 4471697=2E=2E0a02e94 100644</span><br><span>--- a/src/ope=
nvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><spa=
n>@@ -1660,8 +1660,8 @@</span><br><span> #define CC_SINGLE_QUOTE  (1 &lt;&l=
t; 21) /**&lt; single quote */</span><br><span> #define CC_DOUBLE_QUOTE  (1=
 &lt;&lt; 22) /**&lt; double quote */</span><br><span> #define CC_REVERSE_Q=
UOTE (1 &lt;&lt; 23) /**&lt; reverse quote */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define CC_AT            (1 &lt;&lt; 24) /**&lt; at=
 sign */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_EQ=
UAL         (1 &lt;&lt; 25) /**&lt; equal sign */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define CC_PERCENT       (1 &lt;&lt; 24) /**&=
lt; percent sign */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define CC_EXCLAMATION   (1 &lt;&lt; 25) /**&lt; exclamation mark */</span>=
<br><span> #define CC_LESS_THAN     (1 &lt;&lt; 26) /**&lt; less than sign =
*/</span><br><span> #define CC_GREATER_THAN  (1 &lt;&lt; 27) /**&lt; greate=
r than sign */</span><br><span> #define CC_PIPE          (1 &lt;&lt; 28) /*=
*&lt; pipe */</span><br><span>diff --git a/src/openvpn/win32-util=2Ec b/src=
/openvpn/win32-util=2Ec</span><br><span>index 4e3819c=2E=2Ee2c8810 100644</=
span><br><span>--- a/src/openvpn/win32-util=2Ec</span><br><span>+++ b/src/o=
penvpn/win32-util=2Ec</span><br><span>@@ -94,7 +94,10 @@</span><br><span>  =
   {</span><br><span>         const char *arg =3D a-&gt;argv[i];</span><br>=
<span>         strcpy(work, arg);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, &=
#39;_&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* cmd=2Eexe expands %VAR% and !VAR! even inside quotes, so a value like</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * %X509_0_O%=
 could turn back into a quote and start a new command=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * Replace those along with th=
e double quotes and CRLF=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF | C=
C_PERCENT | CC_EXCLAMATION, &#39;_&#39;);</span><br><span>         if (i)</=
span><br><span>         {</span><br><span>             buf_printf(&amp;buf,=
 &quot; &quot;);</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_argv=2Ec b/tests/unit_tests/openvpn/test_argv=2Ec</span><br><span>index 5b=
6e26e=2E=2E1fc73d8 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_argv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_argv=2Ec</s=
pan><br><span>@@ -271,15 +271,13 @@</span><br><span>         { &quot;CN=3Da=
,b;c=3Dd&quot;, L&quot;script=2Ebat 0 CN=3Da,b;c=3Dd&quot; },</span><br><sp=
an>         /* a space has always forced quoting */</span><br><span>       =
  { &quot;O=3DCtrl, CN=3Dy&quot;, L&quot;script=2Ebat 0 \&quot;O=3DCtrl, CN=
=3Dy\&quot;&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* cmd=2Eexe operators */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* cmd=2Eexe operators that quoting neutralizes */</sp=
an><br><span>         { &quot;CN=3Dx&amp;ver&quot;, L&quot;script=2Ebat 0 \=
&quot;CN=3Dx&amp;ver\&quot;&quot; },</span><br><span>         { &quot;CN=3D=
x|ver&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx|ver\&quot;&quot; },</span>=
<br><span>         { &quot;CN=3Dx&gt;f&quot;, L&quot;script=2Ebat 0 \&quot;=
CN=3Dx&gt;f\&quot;&quot; },</span><br><span>         { &quot;CN=3Dx&lt;f&qu=
ot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&lt;f\&quot;&quot; },</span><br><sp=
an>         { &quot;CN=3Dx^f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx^f\&=
quot;&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 { &quot;CN=3Dx%f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx%f\&quot;&quot;=
 },</span><br><span>         { &quot;CN=3Dx(f)&quot;, L&quot;script=2Ebat 0=
 \&quot;CN=3Dx(f)\&quot;&quot; },</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        { &quot;CN=3Dx!f&quot;, L&quot;script=2Ebat 0 \&quot;CN=
=3Dx!f\&quot;&quot; },</span><br><span>         /* a double quote is replac=
ed, so quoting cannot be broken out of */</span><br><span>         { &quot;=
CN=3Da\&quot;b&quot;, L&quot;script=2Ebat 0 CN=3Da_b&quot; },</span><br><sp=
an>     };</span><br><span>@@ -300,6 +298,49 @@</span><br><span>         gc=
_free(&amp;gc);</span><br><span>     }</span><br><span> }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * cmd=2Eexe expands %VAR% and !VAR! even inside quotes, and OpenVPN puts=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * peer-controlled =
data (e=2Eg=2E certificate subject fields) on the command line,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * so these characters are repl=
aced to stop a value from expanding back into a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * quote and command operator=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+wide_cmd_line__replaces_cmd_expansion(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    static const struct</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const char *arg;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const WCHAR *expected;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    } cases[] =3D {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* a bare percent or bang is r=
eplaced */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
 &quot;CN=3Dx%f&quot;, L&quot;script=2Ebat 0 CN=3Dx_f&quot; },</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx!f&quot;, =
L&quot;script=2Ebat 0 CN=3Dx_f&quot; },</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* a closed expansion token is replaced, so not=
hing expands */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    { &quot;CN=3D%X509_0_O%&quot;, L&quot;script=2Ebat 0 CN=3D_X509_0_O_&qu=
ot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { &qu=
ot;CN=3D!X509_0_O!&quot;, L&quot;script=2Ebat 0 CN=3D_X509_0_O_&quot; },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the reporte=
d bypass: quotes in one field are already replaced, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * neutralizing % stops %X509_0=
_O% from re-injecting them */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        { &quot;O=3DBREAK\&quot;&amp;whoami&amp;\&quot;, CN=3D%X5=
09_0_O%&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
     L&quot;script=2Ebat 0 \&quot;O=3DBREAK_&amp;whoami&amp;_, CN=3D_X509_0=
_O_\&quot;&quot; },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; =
SIZE(cases); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct argv a =3D argv_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        argv_printf(&amp;a, &quot;%s %d %s&quot;, &quot;script=2Ebat&qu=
ot;, 0, cases[i]=2Earg);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        assert_int_equal(a=2Eargc, 3);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        WCHAR *cmd_line =3D wide_cmd_line(&amp;a, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        assert_non_null(cmd_li=
ne);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_=
int_equal(wcscmp(cmd_line, cases[i]=2Eexpected), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        argv_free(&amp;a);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span> #endif /* _WIN32 */</span><br><span> </spa=
n><br><span> int</span><br><span>@@ -323,6 +364,7 @@</span><br><span>      =
   cmocka_unit_test(argv_insert_head__empty_argv__head_only),</span><br><sp=
an> #ifdef _WIN32</span><br><span>         cmocka_unit_test(wide_cmd_line__=
quotes_only_what_cmd_would_reinterpret),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(wide_cmd_line__replaces_cmd_e=
xpansion),</span><br><span> #endif</span><br><span>     };</span><br><span>=
 </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail">change 1895</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerri=
t-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: maste=
r </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70dfdc70778458b78f=
80b8d0b0b786f18fe4fc76 </div>
<div style=3D"display:none"> Gerrit-Change-Nu=
mber: 1895 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>

</body></html>
--KDl8j8ZK7Dk=--


--===============6520008315061496068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6520008315061496068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6520008315061496068==--

