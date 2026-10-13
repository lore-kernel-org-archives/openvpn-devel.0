Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9804CC6B15
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=KmMviyfU0OgMChjLgcAKxdFJRI6YYp6NtgTkjsCde3I=; b=cVamhETyRe+Mhw
	vBeeLbrAxgvtSYjl/lc1rQ2yiGG0epQL/Wzsu2/lgvrpcH7unkUkpoAuMjkYxZjVCOftvSwkzh89S
	0gS5MA8U5gBSyf+mYyaA+sIudydrwCGGrKT9oKHaLr/zFuYCrSaPxhCbx1r40MT5PXimU6NTJqYgN
	F4k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGdPu-0001jZ-59;
	Tue, 13 Oct 2026 14:23:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGdPs-0001jP-3J
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Gesn7x1dTVhpBrY0FE4AoJJB469SX4hzyhpFDLrJFXc=; b=Uh44fW/ZC816wq7745b2YGSTAE
 L5q5cpVOX/CfJKnTBhN6uYaXiZb5kbphgTdrav1HyHexaUjmu03BmhxdysOXCMV0BOQ4s3vAM/Cfg
 QpuUa1o70HXbgH8ihXGVxSBFrlrsn6BQuf22BHTm6kmiWtpWgAcMKZrf6MetBa8Ja5xw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Gesn7x1dTVhpBrY0FE4AoJJB469SX4hzyhpFDLrJFXc=; b=l
 8Aw8fKgmYlRM2MDxyLU6x+foxmBU6B4jD08GrF/YVpk8q5JEC+6n6LzEE3k/cMitUB0IVjdGvamuX
 Cf6rURFoYUP7L2jJwazdmztvSsr/8/OfsXm8gzs+gF5lmjBiDcZZv28JH9sX2Q02VMqMzLFUH6uqh
 OArhHbTzvZSv9CDA=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGdPl-0005ki-Uk for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:41 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so25607725e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791901411; x=1792506211; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gesn7x1dTVhpBrY0FE4AoJJB469SX4hzyhpFDLrJFXc=;
 b=JOPW6y1AJuesUcMEzil3bC0lqnUZcGkvv2Zj2wcanBMkc+452hrllbS7/Uk8EcHHyy
 sSM5vBpdHjA5cSn0pvKbO9YNwH4LE7ANZSoUmeZIGwQGzbkWvGxbuAhbPzF+1Mj4hzAB
 sCumcuYsz3CZMmRvwhymP+GXFz3XCmbr/MAPeltee1hcSHNtJlwMhjsQL1luqrVtg6zW
 O4Ydf7f+jbsBnvXmWm2Ob6lE8LbDDI19OwxkaS5uiG3i+Bm1XZdYw74mD1k7TYIze/si
 jyi+gjeGLFIvxL7MjuUC5/sXK9jMv799NnRJMCsvYRPn0TwWwLDXf3suTDbcHr5H4Naz
 m1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901411; x=1792506211;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gesn7x1dTVhpBrY0FE4AoJJB469SX4hzyhpFDLrJFXc=;
 b=G93Qswao1xdVGq1/6hcyzbyQTS3CBABThbBAhEPgdWqt5993XLi7Rk5nekBKvHjGdR
 TwivzSoWoHb0527fkoYlJAGI0QxK4m4VHPXrh0Aj6GjWne/vPB0J6vVZ+vr+MmK8A4ko
 90U8P/a2ACULfM6gNB817rme4sFIZOSjMQQvdKDrzpcNPSPuvDCuQLX1yX9H+1fc1xAr
 pVJZfO6oNtySDyz39t1IftX6C5rXrYgUKRK6qyYX+Gy4o5VrJUpjDpSkPZ0J90m4vP0h
 xfAxHaMUo9QSJVDhoafH4FJmbrt8HCwKq8PcPc0eCJtRuo3eUhbvGgKrJ2sCF9Z0nm4Y
 YCMw==
X-Gm-Message-State: AFq9FYKKOC2uUDl/8PPHITYq7SObtkjJ37f/zzXCftt7msBhayEfhoCH
 7xPhbInifO6DluwdGeXkglg5HUl0I7cU7l0/ZPORg2HPvR9y7aANAVIXXSqtA7QEImtEw1zp+xd
 ZpSnyaV/kPvPN002ylNBmN4GjOOQovYvLkmKs3I02mwIKnwXL8cgZ8DOjJCKjtYiB31uGs25FAk
 yRrLrsNA==
X-Gm-Gg: AYBFou0UOB2YcXVNXj7SZPQXEYDKm3E7PoajpqZkU/9ySRxHMVZGlMJBFN8y79Pzcy0
 e74k90b0k/1nWqCVWbrOuzL4yN4s4py54xPpk6urCWhI+QUtLv269lGash/GNMTa5LUVj2wmdGm
 u6zydkLoku3tu+8N+an39KTHAwBdSTsIvOlQoE9oQxpWZWCct2dtJjqkAIrA86mXNDeXj/+8jyT
 QTLHZuyeUxt8cGZ9E7qCFYnIBemxAMrYDWejgjmvta9EWAZnB7b8/XlX/XjEsDZUqO4zf6400QC
 wm5+pvM6WQ1bOsiOuq+zRBRLnjS0A0bi1ep6SeopurEcWJpJyhoSKAgi4d7AG4mIkH0yEUgmgr7
 lIeTpEtHhbmHbhop6kBBRAI859dkt4lV+UbczgcxjSk+14YRDbKFXyxpYDGLNXrwDVsi45yQJcT
 rhrhOpyfJwfyMteZ48ph5NhPTBWw5sq2E2RKVu+v//tbvBAPQLgw0+gnMYvimy59a9mUYnMLaLn
 ehNnKxSf14V3hJ6ojYyYNqE/ZACI1c7fGhPs8EHm8WVTsnOFP1007PenTVneqTn04rR3Vr54DZ3
 L5mELKuwc70Wf0rk0WYfpTop7uE2ZX2FfmAT/qEuRrbR4ntTe1qQY86FUBMF
X-Received: by 2002:a05:600c:c176:b0:4a0:c2a:485e with SMTP id
 5b1f17b1804b1-4a18e4dce0cmr246606095e9.33.1791901410354; 
 Tue, 13 Oct 2026 07:23:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab4e8csm5113511f8f.23.2026.10.13.07.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:23:30 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 14:23:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: a05840749fae02ea496242e2624097ed6817b9b2
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dd217eeb303c7f709b6be7252716848e5f9801eb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGdPl-0005ki-Uk
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix small
 issues buf_printf and buf_puts
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
Content-Type: multipart/mixed; boundary="===============2830263154238447525=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2830263154238447525==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lTCtkzNlzpo="; charset=UTF-8

--lTCtkzNlzpo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1997?usp=3Demail

to review the following change=2E
=


Change subject: buffer: Fix small issues buf_printf and buf_puts
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Fix small i=
ssues buf_printf and buf_puts

- Fix documentation for buf_puts
- Add UTs f=
or buf_puts
Both of these changes based on a PR by
cuishuang <imcusg@gmail=
=2Ecom>=2E

In both functions:
- Remove obsolete manual adding of \0
- Do n=
ot try to append if we can only overwrite
  the trailing \0 byte

Change-Id=
: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
Signed-off-by: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buff=
er=2Eh
M tests/unit_tests/openvpn/test_buffer=2Ec
3 files changed, 33 inser=
tions(+), 9 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/97/1997/1

diff --git a/src/openvpn/buffer=2Ec b/src/op=
envpn/buffer=2Ec
index cc1b300=2E=2Ed5ee9f2 100644
--- a/src/openvpn/buffer=
=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -228,18 +228,17 @@
     int ret =3D fa=
lse;
     if (buf_defined(buf))
     {
-        uint8_t *ptr =3D BEND(buf);=

+        char *ptr =3D (char *)BEND(buf);
         int cap =3D buf_forward=
_capacity(buf);
 
-        if (cap > 0)
+        if (cap > 1) /* can write =
more than \0 */
         {
             int stat;
             va_list argl=
ist;
             va_start(arglist, format);
-            stat =3D vsnprint=
f((char *)ptr, cap, format, arglist);
+            stat =3D vsnprintf(ptr, =
cap, format, arglist);
             va_end(arglist);
-            *(buf->da=
ta + buf->capacity - 1) =3D 0; /* windows vsnprintf needs this */
-        =
    buf->len +=3D (int)strlen((char *)ptr);
+            buf->len +=3D (int=
)strlen(ptr);
             if (stat >=3D 0 && stat < cap)
             {
  =
               ret =3D true;
@@ -253,11 +252,11 @@
 buf_puts(struct buffer =
*buf, const char *str)
 {
     int ret =3D false;
-    uint8_t *ptr =3D BEN=
D(buf);
+    char *ptr =3D (char *)BEND(buf);
     int cap =3D buf_forward_=
capacity(buf);
-    if (cap > 0)
+    if (cap > 1) /* can write more than \=
0 */
     {
-        int str_len =3D (int)strlcpy((char *)ptr, str, cap);
+=
        int str_len =3D (int)strlcpy(ptr, str, cap);
         buf->len +=3D=
 (str_len < cap) ? str_len : cap - 1;
         ret =3D true;
     }
diff --=
git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index c66ed1a=2E=2Ea4=
d4783 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -=
792,7 +792,7 @@
  * @param buf   The buffer to append to=2E
  * @param str =
  The null-terminated string to append=2E
  *
- * @return true if the strin=
g fit in the buffer, false if it was truncated=2E
+ * @return true if the b=
uffer was changed, i=2Ee=2E at least one character was appended=2E
  */
 bo=
ol buf_puts(struct buffer *buf, const char *str);
 
diff --git a/tests/unit=
_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
i=
ndex bf486e0=2E=2E9cdee3e 100644
--- a/tests/unit_tests/openvpn/test_buffer=
=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -62,6 +62,10 @@
    =
 buf_printf(&buf, "%d", 123);
     buf_printf(&buf, "%s", "some text, too l=
ong to fit");
     assert_buf_equals_str(&buf, "123some text, t");
+    ass=
ert_int_equal(BCAP(&buf), 1); /* \0 byte not part of len */
+
+    buf_prin=
tf(&buf, "%s", "more");
+    assert_buf_equals_str(&buf, "123some text, t")=
;
 
     buf_catrunc(&buf, "=2E=2E=2E");
     assert_buf_equals_str(&buf, "=
123some text=2E=2E=2E");
@@ -79,6 +83,26 @@
 }
 
 static void
+test_buffer_=
puts(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buf=
fer buf =3D alloc_buf_gc(5, &gc);
+
+    assert_true(buf_puts(&buf, "1234")=
);
+    assert_string_equal(BSTR(&buf), "1234");
+
+    buf_reset_len(&buf)=
;
+    assert_true(buf_puts(&buf, "12345"));
+    assert_string_equal(BSTR(=
&buf), "1234");
+
+    struct buffer one_byte_buf =3D alloc_buf_gc(1, &gc);=

+    assert_false(buf_puts(&one_byte_buf, "x"));
+    assert_string_equal(=
BSTR(&one_byte_buf), "");
+
+    gc_free(&gc);
+}
+
+static void
 test_buff=
er_format_hex_ex(void **state)
 {
     const int input_size =3D 10;
@@ -632=
,6 +656,7 @@
     const struct CMUnitTest tests[] =3D {
         cmocka_uni=
t_test(test_buffer_strprefix),
         cmocka_unit_test(test_buffer_printf=
_catrunc),
+        cmocka_unit_test(test_buffer_puts),
         cmocka_uni=
t_test(test_buffer_format_hex_ex),
         cmocka_unit_test_setup_teardown=
(test_buffer_list_aggregate_separator_empty,
                              =
           test_buffer_list_setup, test_buffer_list_teardown),

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8=
f56ad3d3bc827a
Gerrit-Change-Number: 1997
Gerrit-PatchSet: 1
Gerrit-Owner: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--lTCtkzNlzpo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">buffer: Fix small issues buf_printf and buf_puts<br><br>- =
Fix documentation for buf_puts<br>- Add UTs for buf_puts<br>Both of these c=
hanges based on a PR by<br>cuishuang &lt;imcusg@gmail=2Ecom&gt;=2E<br><br>I=
n both functions:<br>- Remove obsolete manual adding of \0<br>- Do not try =
to append if we can only overwrite<br>  the trailing \0 byte<br><br>Change-=
Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a<br>Signed-off-by: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<b=
r>M src/openvpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br=
>3 files changed, 33 insertions(+), 9 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/199=
7/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</s=
pan><br><span>index cc1b300=2E=2Ed5ee9f2 100644</span><br><span>--- a/src/o=
penvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><s=
pan>@@ -228,18 +228,17 @@</span><br><span>     int ret =3D false;</span><br=
><span>     if (buf_defined(buf))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        uint8_t *ptr =3D BEND(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *ptr =3D (c=
har *)BEND(buf);</span><br><span>         int cap =3D buf_forward_capacity(=
buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (cap &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (cap &gt; 1) /* can write more than \0 */</span><br><span>=
         {</span><br><span>             int stat;</span><br><span>         =
    va_list arglist;</span><br><span>             va_start(arglist, format)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stat =3D=
 vsnprintf((char *)ptr, cap, format, arglist);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            stat =3D vsnprintf(ptr, cap, format,=
 arglist);</span><br><span>             va_end(arglist);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            *(buf-&gt;data + buf-&gt;cap=
acity - 1) =3D 0; /* windows vsnprintf needs this */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf-&gt;len +=3D (int)strlen((c=
har *)ptr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    buf-&gt;len +=3D (int)strlen(ptr);</span><br><span>             if (sta=
t &gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br><span>             {</span>=
<br><span>                 ret =3D true;</span><br><span>@@ -253,11 +252,11=
 @@</span><br><span> buf_puts(struct buffer *buf, const char *str)</span><b=
r><span> {</span><br><span>     int ret =3D false;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    uint8_t *ptr =3D BEND(buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char *ptr =3D (char *)BEND(buf=
);</span><br><span>     int cap =3D buf_forward_capacity(buf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (cap &gt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (cap &gt; 1) /* can write m=
ore than \0 */</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        int str_len =3D (int)strlcpy((char *)ptr, str, cap)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int str_le=
n =3D (int)strlcpy(ptr, str, cap);</span><br><span>         buf-&gt;len +=
=3D (str_len &lt; cap) ? str_len : cap - 1;</span><br><span>         ret =
=3D true;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/b=
uffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index c66ed1a=2E=2Ea4d47=
83 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ =
b/src/openvpn/buffer=2Eh</span><br><span>@@ -792,7 +792,7 @@</span><br><spa=
n>  * @param buf   The buffer to append to=2E</span><br><span>  * @param st=
r   The null-terminated string to append=2E</span><br><span>  *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @return true if the string fit=
 in the buffer, false if it was truncated=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return true if the buffer was changed, i=2Ee=
=2E at least one character was appended=2E</span><br><span>  */</span><br><=
span> bool buf_puts(struct buffer *buf, const char *str);</span><br><span> =
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/te=
sts/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index bf486e0=2E=2E9=
cdee3e 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br>=
<span>@@ -62,6 +62,10 @@</span><br><span>     buf_printf(&amp;buf, &quot;%d=
&quot;, 123);</span><br><span>     buf_printf(&amp;buf, &quot;%s&quot;, &qu=
ot;some text, too long to fit&quot;);</span><br><span>     assert_buf_equal=
s_str(&amp;buf, &quot;123some text, t&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BCAP(&amp;buf), 1); /* \0 by=
te not part of len */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&a=
mp;buf, &quot;%s&quot;, &quot;more&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_buf_equals_str(&amp;buf, &quot;123some te=
xt, t&quot;);</span><br><span> </span><br><span>     buf_catrunc(&amp;buf, =
&quot;=2E=2E=2E&quot;);</span><br><span>     assert_buf_equals_str(&amp;buf=
, &quot;123some text=2E=2E=2E&quot;);</span><br><span>@@ -79,6 +83,26 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_buffer_puts(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(buf_puts(&amp;buf, &quot;1234&quot;));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;buf), &quot;12=
34&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf_reset_len(&amp;buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf=
_puts(&amp;buf, &quot;12345&quot;));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(BSTR(&amp;buf), &quot;1234&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer one_byte_buf =3D all=
oc_buf_gc(1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_false(buf_puts(&amp;one_byte_buf, &quot;x&quot;));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&=
amp;one_byte_buf), &quot;&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> test_buffer=
_format_hex_ex(void **state)</span><br><span> {</span><br><span>     const =
int input_size =3D 10;</span><br><span>@@ -632,6 +656,7 @@</span><br><span>=
     const struct CMUnitTest tests[] =3D {</span><br><span>         cmocka_=
unit_test(test_buffer_strprefix),</span><br><span>         cmocka_unit_test=
(test_buffer_printf_catrunc),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_buffer_puts),</span><br><span>     =
    cmocka_unit_test(test_buffer_format_hex_ex),</span><br><span>         c=
mocka_unit_test_setup_teardown(test_buffer_list_aggregate_separator_empty,<=
/span><br><span>                                         test_buffer_list_s=
etup, test_buffer_list_teardown),</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">change 199=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1997 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--lTCtkzNlzpo=--


--===============2830263154238447525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2830263154238447525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2830263154238447525==--

