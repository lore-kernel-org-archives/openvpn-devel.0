Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A96CA600B
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wc0WQE0BPDTcNAZjNgdWgWN0mANTN1KZll21kkLfLkg=; b=AIjcBKgFGFjo95
	ScWIlCHGomYBHjAqmLBkWYHw6UglmoWNO/imoveQUqRB5sHLVsma5NbjQrEQUIZuOAHyURUnOLtpq
	bjr5FiDyAid4ON/Ui+IVNXSaxSzk5rrMdU4Swng9UbYDo5rtNjlXg/o2OqS95bTulxsGcKgF1Iv/N
	Xk4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEpEJ-0005go-Bn;
	Thu, 08 Oct 2026 14:36:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEpEH-0005gg-MK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lw7Xx7sfCrTZ2KWZzFkBb2GsElbxJE37kNNg4dXxMKs=; b=VZ3Ou5JRwumBmDc+MLJLMA2oU9
 R2v9BPgN9ByhE/FKn0I8zF7CtO6ozY3ui3MA19g7ZVQ/4umQ85o9+vqUfWaPX4QxSK/C7NgtcOCo2
 fQX+s0qy6P7/meDUfA9WKoIn6kEuqv1OEolNEJz2Jvxnul2qkR5oIx+LD9Rx4yAqv9RI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lw7Xx7sfCrTZ2KWZzFkBb2GsElbxJE37kNNg4dXxMKs=; b=c
 /rMCLOhz/jfH2Bv7GDpKW0BFajC01KzB60COiJRXfKBtAwZ2zwwzDq/T5OupBMPhR/8++lD4WuR/F
 Y2H+hSUmuoaXhxAkIrjT6oYZzbTlMlHd2ZxYkwSRX6zUaqQZHQdDqz15lVzUt3XTPdhsNj6DrtiXk
 1M0xhD7vMOTfh4Uk=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEpEG-0004RP-RK for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 14:36:18 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so28480015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791470170; x=1792074970; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lw7Xx7sfCrTZ2KWZzFkBb2GsElbxJE37kNNg4dXxMKs=;
 b=UyuzEfXBeYQI2ucUV/ptblxP5PyEMYF3re4OO4XYFxFCCFJmZnN6FZABUTME0CYbDi
 SlK6xNLcaX4to7XF4EogFooombRDDf9BGcvXbz5msolfKcdb8Hk9/UKuMiEncNjntRdP
 JMGs7efu1lla4+c808j1Py6wWgkQvWrfRG5vdagTK2cNFf2+wZ6Auu1YBj+JicUE1sKb
 27CgsdreXQswJLXzA177EUCXTPRcEv55RcD72ef+o4hR9sTXVowfPb2Y4zBhY2Jwfgbn
 ocDqUXGvo1lQ0cKTLMvPyHJNrjMLGfCKIurdJSXWbx7mp81PT8AhhzI9gpwfaVv+6r+y
 XQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791470170; x=1792074970;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lw7Xx7sfCrTZ2KWZzFkBb2GsElbxJE37kNNg4dXxMKs=;
 b=Ck69B3pbGfw+dgnasduBiHHfQr796juwgJeA7etM9M0lqCPUlIHnX5yDj8g4bwibZ1
 mjyv2YbB9fGXG0649wL2uLZo9xXHHTuFpH6sntiyhkQMCjpNoba7VGfqMSY4rdqJ45XV
 HxgrY4uSRnAVB4CJqiE8uHxvKvc8vCyqejSugTmdcKkTlgsqCmq5ZfKnIdIQFuTCFrEF
 jDAwdlwuLGRe6fI+Olb1x6k8CVuWXgzH6fBVX8oKX+MakwWJftpxsAFxer/6q4SQcM+7
 Ycgb1AAReondJckwZUihN4U3xkTPkaO/jNvRuQqYgIR315n2DxBaD6mCp4yOq/DmBfHN
 ucyQ==
X-Gm-Message-State: AFuF++nNVHsoWuRVOYiJDmCe5CGXeJ5sReb+U+2Us+lO313yLktbfl7N
 R+2HYB793DFeVDL7u9HSODbOQHwwrVaxrteJkggysxg91Ati0J/jI6NJX2giVKs8bks/AI0occF
 Ym/bwA7/bYI1TCAroHxkDgpqCEIq9tS4XEBioB/qtfpnsGNize/yFFMQz7eZDhyUgTboF
X-Gm-Gg: AYBFou2+FbYYaR0nGvQK2les0MndMlypJl68UeGoP/rCeSyuYb/1MC3DyGd13Yv8l9l
 Y07PSOcgTWJXut4zLL00cRopON/zL12V9ImvPrggHa/WsIFa0/gxi/TJwvXEjS0pgCoJUBCiHh2
 t1il6XZpBqIvPRK+KUEpkzcdJOGUWHOXWi7sz7XR/SutjcJ8J1D9uT9plUEzM7XyP4aqbvE3rlV
 bQMVK1n0M1cD+8pXorrjxy03K4Wj/Pt1n3HiqpPlUGTXNswIqQlIzQPfm+qL4bRxn9XUJ9PeGM5
 fZi1SAlyB+yXo6YM3FaXAhKwzQaRYwRVSichxQ/xZkTF/LLM6enD0q/m3uL9ssBXYhM63ZmILbr
 rPjEDh4Xaf4kN97901UWvwDhLMiweXh2qmyl345Aftib3iTE3kBAZrckW2lrzyJVOeZRc28z4sM
 1Ytt28fjA5oduPdgoSa1aLEOZh4/MmNs6htlivRkO0p9NQJICpbxHBNICn79v9DHAwUOfd3OMKU
 BoE0IXsEEgZdUrRQMAE/zQGZb/A7Or4AunV2sjD98QoGUws4NIRoR2nAx4m+qr3ZIM489M/pNlk
 inze8+LF7uPKVOQ/VZaqKVojMnaoqJEAF9rQ53JbbfAcrQ7aS0OYduxF6m3E
X-Received: by 2002:a05:600c:810c:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a180420274mr103986455e9.18.1791470169275; 
 Thu, 08 Oct 2026 07:36:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f4482c4sm267700275e9.0.2026.10.08.07.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 07:36:08 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 14:36:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: f4ece820dcfb9a84c3ba309abf687f1990e98f59
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <156cec3eec9f475d1b1ee98c5181a6023d6a13c4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEpEG-0004RP-RK
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Clean up
 rm_trailing_chars
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
Content-Type: multipart/mixed; boundary="===============7847513709359305788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7847513709359305788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gGOfprLA6ao="; charset=UTF-8

--gGOfprLA6ao=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1987?usp=3Demail

to review the following change=2E
=


Change subject: buffer: Clean up rm_trailing_chars
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Clean up rm_trailing_chars=


This is very weird code=2E We re-run strlen for
every char that we delete=
, even though we actually
know which char to test next=2E Avoid this=2E

Al=
so add unit tests to make sure I did not break it=2E

Change-Id: I47e0741c7=
5832a8f3fe161769feb27ddbfba3cdd
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M tests/unit_tests/openvpn/tes=
t_buffer=2Ec
2 files changed, 48 insertions(+), 12 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/1987/1

diff =
--git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 8f558b1=2E=2E=
9b87f42 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@=
 -592,21 +592,18 @@
 void
 rm_trailing_chars(char *str, const char *what_to=
_delete)
 {
-    bool modified;
-    do
+    size_t len =3D strlen(str);
+ =
   while (len > 0)
     {
-        const size_t len =3D strlen(str);
-     =
   modified =3D false;
-        if (len > 0)
+        if (strchr(what_to_de=
lete, str[len - 1]) !=3D NULL)
         {
-            char *cp =3D str + (=
len - 1);
-            if (strchr(what_to_delete, *cp) !=3D NULL)
-        =
    {
-                *cp =3D '\0';
-                modified =3D true;
- =
           }
+            str[--len] =3D '\0';
         }
-    } while (mod=
ified);
+        else
+        {
+            return;
+        }
+    }
 }
=
 
 /*
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_te=
sts/openvpn/test_buffer=2Ec
index 2945e8a=2E=2Ebf486e0 100644
--- a/tests/u=
nit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffe=
r=2Ec
@@ -435,6 +435,44 @@
 }
 
 void
+test_string_chomp(void **state)
+{
+=
    char string[10];
+
+    strcpy(string, "Foo\n");
+    chomp(string);
+ =
   assert_string_equal(string, "Foo");
+
+    strcpy(string, "Foo\r\n\n\r")=
;
+    chomp(string);
+    assert_string_equal(string, "Foo");
+
+    strcp=
y(string, "Foo");
+    chomp(string);
+    assert_string_equal(string, "Foo=
");
+
+    strcpy(string, "F\ro\no");
+    chomp(string);
+    assert_strin=
g_equal(string, "F\ro\no");
+
+    string[2] =3D '\0';
+    chomp(string);
=
+    assert_string_equal(string, "F");
+
+    strcpy(string, "");
+    chom=
p(string);
+    assert_string_equal(string, "");
+
+    strcpy(string, "Foo=
");
+    rm_trailing_chars(string, "o");
+    assert_string_equal(string, "=
F");
+
+    strcpy(string, "Foo");
+    rm_trailing_chars(string, "oF");
+ =
   assert_string_equal(string, "");
+}
+
+void
 test_buffer_chomp(void **st=
ate)
 {
     struct gc_arena gc =3D gc_new();
@@ -616,6 +654,7 @@
         =
cmocka_unit_test(test_character_string_mod_buf),
         cmocka_unit_test(=
test_snprintf),
         cmocka_unit_test(test_checked_snprintf),
+        =
cmocka_unit_test(test_string_chomp),
         cmocka_unit_test(test_buffer_=
chomp),
         cmocka_unit_test(test_buffer_null_terminate),
         cmo=
cka_unit_test(test_buffer_null_predicates),

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
Gerr=
it-Change-Number: 1987
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--gGOfprLA6ao=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">buffer: Clean up rm_trailing_chars<br><br>This is very wei=
rd code=2E We re-run strlen for<br>every char that we delete, even though w=
e actually<br>know which char to test next=2E Avoid this=2E<br><br>Also add=
 unit tests to make sure I did not break it=2E<br><br>Change-Id: I47e0741c7=
5832a8f3fe161769feb27ddbfba3cdd<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M tests/unit=
_tests/openvpn/test_buffer=2Ec<br>2 files changed, 48 insertions(+), 12 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/87/1987/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffe=
r=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 8f558b1=2E=2E9b87f42 1=
00644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/sr=
c/openvpn/buffer=2Ec</span><br><span>@@ -592,21 +592,18 @@</span><br><span>=
 void</span><br><span> rm_trailing_chars(char *str, const char *what_to_del=
ete)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    bool modified;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len=
 =3D strlen(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  while (len &gt; 0)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const size_t len =3D strlen(str);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        modified =3D false;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (len &gt; 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strchr(what=
_to_delete, str[len - 1]) !=3D NULL)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            char *cp =3D str + (l=
en - 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (strchr(what_to_delete, *cp) !=3D NULL)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                *cp =3D &#39;\0&#39;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                modified =3D true;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            str[--len] =3D &#39;\0&#39;;=
</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    } while (modified);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span> }</span><br><span> </span><br><span> /*</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_bu=
ffer=2Ec</span><br><span>index 2945e8a=2E=2Ebf486e0 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -435,6 +435,44 @@</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+test_string_chomp(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char string[10];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    strcpy(string, &quot;Foo\n&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    chomp(string);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(string, &quot;Foo&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo\r\n\n=
\r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    chomp=
(string);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(string, &quot;Foo&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    strcpy(string, &quot;Foo&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    chomp(string);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(string, &quot;Foo&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    strcpy(string, &quot;F\ro\no&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(str=
ing, &quot;F\ro\no&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    string[2=
] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    chomp(string);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(string, &quot;F&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    strcpy(string, &quot;&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    chomp(string);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(string, &quot;&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    rm_trailing_chars(string,=
 &quot;o&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_string_equal(string, &quot;F&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    strcpy(string, &quot;Foo&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    rm_trailing_chars(string, &quot;oF&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(s=
tring, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> test_buffer_c=
homp(void **state)</span><br><span> {</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>@@ -616,6 +654,7 @@</span><br><span>      =
   cmocka_unit_test(test_character_string_mod_buf),</span><br><span>       =
  cmocka_unit_test(test_snprintf),</span><br><span>         cmocka_unit_tes=
t(test_checked_snprintf),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_string_chomp),</span><br><span>        =
 cmocka_unit_test(test_buffer_chomp),</span><br><span>         cmocka_unit_=
test(test_buffer_null_terminate),</span><br><span>         cmocka_unit_test=
(test_buffer_null_predicates),</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail">change 1987</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
7e0741c75832a8f3fe161769feb27ddbfba3cdd </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1987 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--gGOfprLA6ao=--


--===============7847513709359305788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7847513709359305788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7847513709359305788==--

