Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6E0C79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pxk+XNLp6VuLWtcSn4sNfb2qtn/djJZ1LAA5cYAx8XM=; b=U2V6ybetZWEaDlCzEITj354LlN
	EFv29E9i9mvgZcTV2p/e+6f2xHmweRJDftU5kKbkLIDovbsMEyC6h5eO/MVpS2lQRu8m38mb4tAVo
	jJZ8rIitEQAKwHe1U8gbUBmg+KJ9egR5mlCRRfmpzu6dmxvuGCaUTz+L8uuVVRG7NHws=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bpY-0006GM-DM;
	Mon, 07 Sep 2026 16:04:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3bpW-0006GA-F6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4wVPspVLEMPN7tFUkAjyq6rOtlhpIyJKqrtXyM2kciA=; b=nWO5dF7G0qQxtHXstDIWPp5pXV
 6C6WPuc+h70xcPuMLrE+UipJQLrwJCW5zFcumeXoOS89xO01GB4OxFz1npXDD8fXZ8DDhgm+ykbeV
 MuFnaMB+sM0fnJ0WxitZigkFwlcd+dck/rcooIpqS3YdYh9JBDmyzHA/WjF6l2i6W2co=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4wVPspVLEMPN7tFUkAjyq6rOtlhpIyJKqrtXyM2kciA=; b=b
 kGNQp2jG4XtvebtIqPamkqfHGmCSXG796wb3koQrJA3whV4yPHQIH9xae6D9KULT+P1ZZ6ZRwywGr
 3BV3KQbFRZV/A8ha3po6ogJ3DrVcwv4pCP+u8qkogpWBSut4TypLH9s5cEdRTkqYu0KnYvHhpeUb6
 qjJccetRmHamlR7Q=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3bpS-0001YK-6p for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:04:19 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so29272225e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788797052; x=1789401852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4wVPspVLEMPN7tFUkAjyq6rOtlhpIyJKqrtXyM2kciA=;
 b=WfDeexr98hcV2UOeqDkVsPN5XFQxL0q1fLnWAEUOhlu1r0YdmSMYSOlj0SdntZqeN7
 SudlmZsHrVXHMeVbtqoTM3z8GnZ8doikYCv8KQu7su2b3kAGVr/P0GwVNVpCqUBC6AoP
 s4i4JGsDL6kbFwWc8ig6S8FIJjaZLYkctIOfuuWzULTxExNV0PdABSsn1qt4cRN6TkFz
 nC33vmiAw8n5EEx2ddY0N6i/jybrXBsnQw0E5Kw70a7AhFFZV+aMn9miR6JHlQsJXGv3
 U7/00UFjf72yRzR0vs5JkKNOsOIUUGiPisAqJH4KF8Sfcel9agdP4dWB2+lQ9SPAyFM4
 nTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788797052; x=1789401852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4wVPspVLEMPN7tFUkAjyq6rOtlhpIyJKqrtXyM2kciA=;
 b=QKMcOdOTJblhoy/Yz2w69sqBbLJF2eKiJm9oc8nmf5VIZaWNGxs78zo6K2P5XBEWta
 btJjLs5n1ZWyxk/0ygEZ4MuYLx3SL1QxhR0CKiYNglLc54RQx3E9hCXO09k8QrP5VCfi
 wP5YpCzo4KKDcnbcoonZhYX6kPAK/3ena4c9U5qaV8J6GK7Op4Ki88wb98Pye4GcJVOr
 SLXRPkPPvcCdNovWjWAuQp5e2hufNnNKQDbWL3h9mRY7xLpkeTBYs9o9cbzpK4ehTZij
 6V01zQk5S/8KyCnoRLEYBH1dZi9+gYxPswIp+HeDiDo7+y3W8GyqnfHwtsUZobGtCHSk
 G6SQ==
X-Gm-Message-State: AFuF++nK0tKbEyDsw17M6c/Th+NaYcgk9ZEp4hSJVVSMf3oYSbPTZ2h3
 QPikHqKwDL0g5699fNKSp/rMaWKABwsKdBEwol1yju+7nxWP2u6GT5xWy6npsVxlceaueaiqWjn
 oMyJ/tuFxX/RsEQReLfmCDX4NEgzebJ7OLIfhgs4B1cSFeumTgdaBLRCVWnZGzBY1IINy
X-Gm-Gg: AYBFou0rJh1grYFpDpTk3z2qokcgq2SBl1gIv6ggCUTtKVdOTGHqFFuXhM3CglsNe1B
 BgULh7DjAbDxC5QhrGIG/uBxNUZ/Rrj8UJib/v+lQe0KwRAGM52q9pIZTD4YCl6jRRJiKG0srNA
 J55QLklyavcHR83O72KILyYuX7nHr4CPBp+F4h2krOroyOrNuIVfzNMHuA7szBmzWf8x2QssVe1
 T1b8nK6GMJb8FOEHLzLpihddDT9Hixqbq5EzIQe6n2PRDVSbz4mAWzvhjdSVxmFfAHxNP8da/W/
 WWijQgPMcrk2GIagtucL4zy415owd9X4NBjcKkkpiuxItIuaD9PK5gqMG4GwB0GCRkWudOuHvf7
 vud2B3jB+mOPKopE12CjPWaEb7AXMFFYHC48sd4oIimcA0MFLmkVQ85sPxuE1w1l7Ln8DVy1tdO
 QQNTMG01kCj+O8RWFLn1PnmdNZDlTvBC4m9tEJNJXFtwskUZH+KDLgoBUiCuKVGll3G59qZcLuX
 anY/fAeDW+f6wmTIkvO23Q+UE12MO7/ESGxVUy8ZprAenZo589sUu59nkLaZ1Tbw+zkcWM9mKrH
 7MA7h5ptfSDc1kBlb5Kndv4SshHXV2OV+w+iSmvc3uaYFgW6n14=
X-Received: by 2002:a05:600c:46d1:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49cf820c992mr246977895e9.6.1788797051394; 
 Mon, 07 Sep 2026 09:04:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee80eda4sm399254595e9.15.2026.09.07.09.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:04:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 16:04:10 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
X-Gerrit-Change-Number: 1895
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1895?usp=email>
X-Gerrit-Commit: eb12c84ef08566c4d2d5f3ea1294891339a5b5e9
In-Reply-To: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
References: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDMxNDA2MDAwLkk3MGRmZGM3MDc3ODQ1OGI3OGY4MGI4ZDBiMGI3ODZmMThmZTRmYzc2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <46389cc6e6bea0b1ea88c0aaae97707f1fefb63d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3bpS-0001YK-6p
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2270275388884469709=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2270275388884469709==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WPuFCqjeLq0="; charset=UTF-8

--WPuFCqjeLq0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by razv=
anc


Change subject: win32: stop cmd=2Eexe from expanding variables in quo=
ted arguments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


win32: stop cmd=2Eexe from expanding variables in quoted arguments

Commi=
t cf08504 quotes arguments that contain cmd=2Eexe metacharacters, so a
cert=
ificate subject passed to --tls-verify cannot start a second command
when C=
reateProcess() runs a =2Ebat or =2Ecmd hook=2E

Quoting is not enough for %=
VAR% and !VAR!: cmd=2Eexe expands those even
inside double quotes, and Open=
VPN exports peer-controlled certificate
fields into the child environment=
=2E A subject that puts a quote and an
operator in one field (O=3DBREAK"&wh=
oami&") and references it from another
(CN=3D%X509_0_O%) expands back into =
a quote and command operator after
wide_cmd_line() has already replaced the=
 direct quotes, running a command
before the hook can reject the peer=2E

R=
eplace % and ! in wide_cmd_line() along with the double quotes and CRLF,
so=
 no argument can expand=2E This reuses two character classes that had no
us=
ers, CC_AT and CC_EQUAL, renamed to CC_PERCENT and CC_EXCLAMATION=2E Add
re=
gression tests for a bare percent or bang, a closed expansion token, and
th=
e reported subject=2E

This completes the CVE-2026-84256 fix for Windows ba=
tch hooks=2E

GitHub: OpenVPN/openvpn-private-issues#176
Reported-By: Darre=
n Carreras
CVE: 2026-84256
Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4=
fc76
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1895
Message-Id: <20260907144351=2E22085-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38985=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/win32-ut=
il=2Ec
M tests/unit_tests/openvpn/test_argv=2Ec
4 files changed, 53 inserti=
ons(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/95/1895/2

diff --git a/src/openvpn/buffer=2Ec b/src/openv=
pn/buffer=2Ec
index 5ce2e39=2E=2E5d00415 100644
--- a/src/openvpn/buffer=2E=
c
+++ b/src/openvpn/buffer=2Ec
@@ -943,11 +943,11 @@
     {
         return=
 true;
     }
-    if ((flags & CC_AT) && c =3D=3D '@')
+    if ((flags & C=
C_PERCENT) && c =3D=3D '%')
     {
         return true;
     }
-    if ((f=
lags & CC_EQUAL) && c =3D=3D '=3D')
+    if ((flags & CC_EXCLAMATION) && c =
=3D=3D '!')
     {
         return true;
     }
diff --git a/src/openvpn/bu=
ffer=2Eh b/src/openvpn/buffer=2Eh
index 4471697=2E=2E0a02e94 100644
--- a/s=
rc/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1660,8 +1660,8 @@
 #=
define CC_SINGLE_QUOTE  (1 << 21) /**< single quote */
 #define CC_DOUBLE_Q=
UOTE  (1 << 22) /**< double quote */
 #define CC_REVERSE_QUOTE (1 << 23) /*=
*< reverse quote */
-#define CC_AT            (1 << 24) /**< at sign */
-#d=
efine CC_EQUAL         (1 << 25) /**< equal sign */
+#define CC_PERCENT    =
   (1 << 24) /**< percent sign */
+#define CC_EXCLAMATION   (1 << 25) /**< =
exclamation mark */
 #define CC_LESS_THAN     (1 << 26) /**< less than sign=
 */
 #define CC_GREATER_THAN  (1 << 27) /**< greater than sign */
 #define =
CC_PIPE          (1 << 28) /**< pipe */
diff --git a/src/openvpn/win32-util=
=2Ec b/src/openvpn/win32-util=2Ec
index 4e3819c=2E=2Ee2c8810 100644
--- a/s=
rc/openvpn/win32-util=2Ec
+++ b/src/openvpn/win32-util=2Ec
@@ -94,7 +94,10 =
@@
     {
         const char *arg =3D a->argv[i];
         strcpy(work, ar=
g);
-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
+ =
       /* cmd=2Eexe expands %VAR% and !VAR! even inside quotes, so a value =
like
+         * %X509_0_O% could turn back into a quote and start a new co=
mmand=2E
+         * Replace those along with the double quotes and CRLF=2E=
 */
+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF | CC_PERC=
ENT | CC_EXCLAMATION, '_');
         if (i)
         {
             buf_pri=
ntf(&buf, " ");
diff --git a/tests/unit_tests/openvpn/test_argv=2Ec b/tests=
/unit_tests/openvpn/test_argv=2Ec
index 5b6e26e=2E=2E1fc73d8 100644
--- a/t=
ests/unit_tests/openvpn/test_argv=2Ec
+++ b/tests/unit_tests/openvpn/test_a=
rgv=2Ec
@@ -271,15 +271,13 @@
         { "CN=3Da,b;c=3Dd", L"script=2Ebat 0=
 CN=3Da,b;c=3Dd" },
         /* a space has always forced quoting */
      =
   { "O=3DCtrl, CN=3Dy", L"script=2Ebat 0 \"O=3DCtrl, CN=3Dy\"" },
-       =
 /* cmd=2Eexe operators */
+        /* cmd=2Eexe operators that quoting neu=
tralizes */
         { "CN=3Dx&ver", L"script=2Ebat 0 \"CN=3Dx&ver\"" },
  =
       { "CN=3Dx|ver", L"script=2Ebat 0 \"CN=3Dx|ver\"" },
         { "CN=
=3Dx>f", L"script=2Ebat 0 \"CN=3Dx>f\"" },
         { "CN=3Dx<f", L"script=
=2Ebat 0 \"CN=3Dx<f\"" },
         { "CN=3Dx^f", L"script=2Ebat 0 \"CN=3Dx^=
f\"" },
-        { "CN=3Dx%f", L"script=2Ebat 0 \"CN=3Dx%f\"" },
         {=
 "CN=3Dx(f)", L"script=2Ebat 0 \"CN=3Dx(f)\"" },
-        { "CN=3Dx!f", L"s=
cript=2Ebat 0 \"CN=3Dx!f\"" },
         /* a double quote is replaced, so q=
uoting cannot be broken out of */
         { "CN=3Da\"b", L"script=2Ebat 0 =
CN=3Da_b" },
     };
@@ -300,6 +298,49 @@
         gc_free(&gc);
     }
 }
=
+
+/*
+ * cmd=2Eexe expands %VAR% and !VAR! even inside quotes, and OpenVPN=
 puts
+ * peer-controlled data (e=2Eg=2E certificate subject fields) on the=
 command line,
+ * so these characters are replaced to stop a value from ex=
panding back into a
+ * quote and command operator=2E
+ */
+static void
+wi=
de_cmd_line__replaces_cmd_expansion(void **state)
+{
+    static const stru=
ct
+    {
+        const char *arg;
+        const WCHAR *expected;
+    } =
cases[] =3D {
+        /* a bare percent or bang is replaced */
+        { =
"CN=3Dx%f", L"script=2Ebat 0 CN=3Dx_f" },
+        { "CN=3Dx!f", L"script=
=2Ebat 0 CN=3Dx_f" },
+        /* a closed expansion token is replaced, so =
nothing expands */
+        { "CN=3D%X509_0_O%", L"script=2Ebat 0 CN=3D_X50=
9_0_O_" },
+        { "CN=3D!X509_0_O!", L"script=2Ebat 0 CN=3D_X509_0_O_" =
},
+        /* the reported bypass: quotes in one field are already replace=
d, and
+         * neutralizing % stops %X509_0_O% from re-injecting them *=
/
+        { "O=3DBREAK\"&whoami&\", CN=3D%X509_0_O%",
+          L"script=
=2Ebat 0 \"O=3DBREAK_&whoami&_, CN=3D_X509_0_O_\"" },
+    };
+
+    for (s=
ize_t i =3D 0; i < SIZE(cases); i++)
+    {
+        struct gc_arena gc =3D=
 gc_new();
+        struct argv a =3D argv_new();
+
+        argv_printf(&a=
, "%s %d %s", "script=2Ebat", 0, cases[i]=2Earg);
+        assert_int_equal=
(a=2Eargc, 3);
+
+        WCHAR *cmd_line =3D wide_cmd_line(&a, &gc);
+    =
    assert_non_null(cmd_line);
+        assert_int_equal(wcscmp(cmd_line, c=
ases[i]=2Eexpected), 0);
+
+        argv_free(&a);
+        gc_free(&gc);
+=
    }
+}
 #endif /* _WIN32 */
 
 int
@@ -323,6 +364,7 @@
         cmocka_un=
it_test(argv_insert_head__empty_argv__head_only),
 #ifdef _WIN32
         c=
mocka_unit_test(wide_cmd_line__quotes_only_what_cmd_would_reinterpret),
+  =
      cmocka_unit_test(wide_cmd_line__replaces_cmd_expansion),
 #endif
    =
 };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I70dfdc7077=
8458b78f80b8d0b0b786f18fe4fc76
Gerrit-Change-Number: 1895
Gerrit-PatchSet: =
2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--WPuFCqjeLq0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">win32: stop cmd=2Eexe from expa=
nding variables in quoted arguments<br><br>Commit cf08504 quotes arguments =
that contain cmd=2Eexe metacharacters, so a<br>certificate subject passed t=
o --tls-verify cannot start a second command<br>when CreateProcess() runs a=
 =2Ebat or =2Ecmd hook=2E<br><br>Quoting is not enough for %VAR% and !VAR!:=
 cmd=2Eexe expands those even<br>inside double quotes, and OpenVPN exports =
peer-controlled certificate<br>fields into the child environment=2E A subje=
ct that puts a quote and an<br>operator in one field (O=3DBREAK&quot;&amp;w=
hoami&amp;&quot;) and references it from another<br>(CN=3D%X509_0_O%) expan=
ds back into a quote and command operator after<br>wide_cmd_line() has alre=
ady replaced the direct quotes, running a command<br>before the hook can re=
ject the peer=2E<br><br>Replace % and ! in wide_cmd_line() along with the d=
ouble quotes and CRLF,<br>so no argument can expand=2E This reuses two char=
acter classes that had no<br>users, CC_AT and CC_EQUAL, renamed to CC_PERCE=
NT and CC_EXCLAMATION=2E Add<br>regression tests for a bare percent or bang=
, a closed expansion token, and<br>the reported subject=2E<br><br>This comp=
letes the CVE-2026-84256 fix for Windows batch hooks=2E<br><br>GitHub: Open=
VPN/openvpn-private-issues#176<br>Reported-By: Darren Carreras<br>CVE: 2026=
-84256<br>Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76<br>Signed-of=
f-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Razvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1895<br>Message-Id: &lt;20260907144351=2E22085-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38985=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openv=
pn/buffer=2Eh<br>M src/openvpn/win32-util=2Ec<br>M tests/unit_tests/openvpn=
/test_argv=2Ec<br>4 files changed, 53 insertions(+), 8 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/95/1895/2</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openv=
pn/buffer=2Ec</span><br><span>index 5ce2e39=2E=2E5d00415 100644</span><br><=
span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=
=2Ec</span><br><span>@@ -943,11 +943,11 @@</span><br><span>     {</span><br=
><span>         return true;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if ((flags &amp; CC_AT) &amp;&amp; c =
=3D=3D &#39;@&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if ((flags &amp; CC_PERCENT) &amp;&amp; c =3D=3D &#39;%&#39;)</span><br=
><span>     {</span><br><span>         return true;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((flags &amp; C=
C_EQUAL) &amp;&amp; c =3D=3D &#39;=3D&#39;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if ((flags &amp; CC_EXCLAMATION) &amp;&amp; c =
=3D=3D &#39;!&#39;)</span><br><span>     {</span><br><span>         return =
true;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/buffe=
r=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 4471697=2E=2E0a02e94 1=
00644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/sr=
c/openvpn/buffer=2Eh</span><br><span>@@ -1660,8 +1660,8 @@</span><br><span>=
 #define CC_SINGLE_QUOTE  (1 &lt;&lt; 21) /**&lt; single quote */</span><br=
><span> #define CC_DOUBLE_QUOTE  (1 &lt;&lt; 22) /**&lt; double quote */</s=
pan><br><span> #define CC_REVERSE_QUOTE (1 &lt;&lt; 23) /**&lt; reverse quo=
te */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CC_AT   =
         (1 &lt;&lt; 24) /**&lt; at sign */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define CC_EQUAL         (1 &lt;&lt; 25) /**&lt; equa=
l sign */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CC=
_PERCENT       (1 &lt;&lt; 24) /**&lt; percent sign */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define CC_EXCLAMATION   (1 &lt;&lt; 25)=
 /**&lt; exclamation mark */</span><br><span> #define CC_LESS_THAN     (1 &=
lt;&lt; 26) /**&lt; less than sign */</span><br><span> #define CC_GREATER_T=
HAN  (1 &lt;&lt; 27) /**&lt; greater than sign */</span><br><span> #define =
CC_PIPE          (1 &lt;&lt; 28) /**&lt; pipe */</span><br><span>diff --git=
 a/src/openvpn/win32-util=2Ec b/src/openvpn/win32-util=2Ec</span><br><span>=
index 4e3819c=2E=2Ee2c8810 100644</span><br><span>--- a/src/openvpn/win32-u=
til=2Ec</span><br><span>+++ b/src/openvpn/win32-util=2Ec</span><br><span>@@=
 -94,7 +94,10 @@</span><br><span>     {</span><br><span>         const char=
 *arg =3D a-&gt;argv[i];</span><br><span>         strcpy(work, arg);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        string_mod(work, CC_=
PRINT, CC_DOUBLE_QUOTE | CC_CRLF, &#39;_&#39;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* cmd=2Eexe expands %VAR% and !VAR! ev=
en inside quotes, so a value like</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * %X509_0_O% could turn back into a quote and start =
a new command=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * Replace those along with the double quotes and CRLF=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        string_mod(work, CC_P=
RINT, CC_DOUBLE_QUOTE | CC_CRLF | CC_PERCENT | CC_EXCLAMATION, &#39;_&#39;)=
;</span><br><span>         if (i)</span><br><span>         {</span><br><spa=
n>             buf_printf(&amp;buf, &quot; &quot;);</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_argv=2Ec b/tests/unit_tests/openvpn/tes=
t_argv=2Ec</span><br><span>index 5b6e26e=2E=2E1fc73d8 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_argv=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_argv=2Ec</span><br><span>@@ -271,15 +271,13 @@</spa=
n><br><span>         { &quot;CN=3Da,b;c=3Dd&quot;, L&quot;script=2Ebat 0 CN=
=3Da,b;c=3Dd&quot; },</span><br><span>         /* a space has always forced=
 quoting */</span><br><span>         { &quot;O=3DCtrl, CN=3Dy&quot;, L&quot=
;script=2Ebat 0 \&quot;O=3DCtrl, CN=3Dy\&quot;&quot; },</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* cmd=2Eexe operators */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* cmd=2Eexe operat=
ors that quoting neutralizes */</span><br><span>         { &quot;CN=3Dx&amp=
;ver&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&amp;ver\&quot;&quot; },</sp=
an><br><span>         { &quot;CN=3Dx|ver&quot;, L&quot;script=2Ebat 0 \&quo=
t;CN=3Dx|ver\&quot;&quot; },</span><br><span>         { &quot;CN=3Dx&gt;f&q=
uot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx&gt;f\&quot;&quot; },</span><br><s=
pan>         { &quot;CN=3Dx&lt;f&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx=
&lt;f\&quot;&quot; },</span><br><span>         { &quot;CN=3Dx^f&quot;, L&qu=
ot;script=2Ebat 0 \&quot;CN=3Dx^f\&quot;&quot; },</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        { &quot;CN=3Dx%f&quot;, L&quot;script=
=2Ebat 0 \&quot;CN=3Dx%f\&quot;&quot; },</span><br><span>         { &quot;C=
N=3Dx(f)&quot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx(f)\&quot;&quot; },</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        { &quot;CN=3Dx!f&q=
uot;, L&quot;script=2Ebat 0 \&quot;CN=3Dx!f\&quot;&quot; },</span><br><span=
>         /* a double quote is replaced, so quoting cannot be broken out of=
 */</span><br><span>         { &quot;CN=3Da\&quot;b&quot;, L&quot;script=2E=
bat 0 CN=3Da_b&quot; },</span><br><span>     };</span><br><span>@@ -300,6 +=
298,49 @@</span><br><span>         gc_free(&amp;gc);</span><br><span>     }=
</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * cmd=2Eexe expands %VAR% and !VAR!=
 even inside quotes, and OpenVPN puts</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * peer-controlled data (e=2Eg=2E certificate subject fie=
lds) on the command line,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * so these characters are replaced to stop a value from expanding ba=
ck into a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * quote a=
nd command operator=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+wide_cmd_line__replac=
es_cmd_expansion(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sta=
tic const struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const cha=
r *arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t WCHAR *expected;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   } cases[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* a bare percent or bang is replaced */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        { &quot;CN=3Dx%f&quot;, L&quot;script=
=2Ebat 0 CN=3Dx_f&quot; },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        { &quot;CN=3Dx!f&quot;, L&quot;script=2Ebat 0 CN=3Dx_f&quot;=
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* a clo=
sed expansion token is replaced, so nothing expands */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        { &quot;CN=3D%X509_0_O%&quot;, L=
&quot;script=2Ebat 0 CN=3D_X509_0_O_&quot; },</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        { &quot;CN=3D!X509_0_O!&quot;, L&quot;scr=
ipt=2Ebat 0 CN=3D_X509_0_O_&quot; },</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* the reported bypass: quotes in one field are al=
ready replaced, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * neutralizing % stops %X509_0_O% from re-injecting them */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        { &quot;O=3DBREAK\=
&quot;&amp;whoami&amp;\&quot;, CN=3D%X509_0_O%&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          L&quot;script=2Ebat 0 \&quot;O=
=3DBREAK_&amp;whoami&amp;_, CN=3D_X509_0_O_\&quot;&quot; },</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (size_t i =3D 0; i &lt; SIZE(cases); i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct argv a =3D argv=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;a, &qu=
ot;%s %d %s&quot;, &quot;script=2Ebat&quot;, 0, cases[i]=2Earg);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(a=2Ea=
rgc, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        WCHAR *cmd_line =3D wi=
de_cmd_line(&amp;a, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        assert_non_null(cmd_line);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        assert_int_equal(wcscmp(cmd_line, cases[i]=
=2Eexpected), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_free(&am=
p;a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #en=
dif /* _WIN32 */</span><br><span> </span><br><span> int</span><br><span>@@ =
-323,6 +364,7 @@</span><br><span>         cmocka_unit_test(argv_insert_head=
__empty_argv__head_only),</span><br><span> #ifdef _WIN32</span><br><span>  =
       cmocka_unit_test(wide_cmd_line__quotes_only_what_cmd_would_reinterpr=
et),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(wide_cmd_line__replaces_cmd_expansion),</span><br><span> #endif</=
span><br><span>     };</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?=
usp=3Demail">change 1895</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1895?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1895 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--WPuFCqjeLq0=--


--===============2270275388884469709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2270275388884469709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2270275388884469709==--

