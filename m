Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5379FCC6B2A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=99RpENWIoWJs0T/31W9c3Hr4aDrQuvIV4HeNpJfTMAQ=; b=i7bknEAgNTjB03+DL3xN8AehMO
	PUKexmfng31Dd5Ui+uPIV+lc75kS8izGAuG+pNJwoDA1fXtRrX2VmGJMOLd19KGJiT4pzxWzQ7hg9
	g62fbr0NWGZFlAXbtikOpslVImI3Y7lr8mcD1Qlcr7ioxgvX62Feqpa5sh2H1F9n1aeM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxbd-0007km-4K;
	Wed, 14 Oct 2026 11:57:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxbc-0007kg-1l
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=exJzSU/CH2h74P1MtRnVmL94kC/UuZ04GWwidTT4GU0=; b=U3XBFQfImE1ojda1cA+r9uNoPe
 3NADYxwJGx/IQyyPxIUR/pV6+07rTiZstmbirWwU2yUTugV5SJ5nahW9zOqIskSMhcNvGa5V/7tYx
 IUi0BaSpJvXwB9VciyQThmZfs/1absoZhXjrGzHHTfPRunqU+SD4uOeqZ8C5h9PzaRgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=exJzSU/CH2h74P1MtRnVmL94kC/UuZ04GWwidTT4GU0=; b=I
 In5ZaMAlRg+EZx+9A/kLeIoJS0VnbBUgxnB7wJt3SEJZFFWUMDqE8AH9fj3b5DyGFMw3PEWex17Wi
 3V2SusUARhEGNPC3tBbMd1SUbM5YU893VwHOX0teeh3vozqmHfvWqaV9ihgmM6w/bcWyKjd/B/g2D
 m5Jxkl7jgSkYNXzs=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxbZ-0008Ir-8I for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:57:11 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so33825765e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791979023; x=1792583823; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=exJzSU/CH2h74P1MtRnVmL94kC/UuZ04GWwidTT4GU0=;
 b=TANIwqOvJYatOGP7KLnFsZevZyOjlPB9J7ZfX3lm6PCemrlSYq74N3+u66KcDpgvUX
 mLkLgdKsa3bKDo+tGyKSfNAPhmPlBqxGO886WXZOHjVvFKzsEAIa7kO9FIKJhkfiqQUh
 ioD+ouaRTH6yuCCMmTnZUo7145AWFlP4PBLBZUTpsVtqqTK09KWHgilxX3mgLUBtSk7F
 LOnVldSdeowwPOOrhJp0KYV6HfoDIcYHKTMDlO+GJQ+M1f09w8FIT3+hCod8fH0CSGwA
 mpes6EbiDlTGzlEe/84ASSB9hCA9+E1IO2wH53uhr3NocInRvmV5RV9XdGx0GS9mQ+Jp
 sUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791979023; x=1792583823;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=exJzSU/CH2h74P1MtRnVmL94kC/UuZ04GWwidTT4GU0=;
 b=kO11YlgDXjUb0AEUXlKvoONGHkzEG4NP57HJtt8NaCFYLoWrSyDMGpHNyh8qKTqNrA
 KHCRlXPzI5U0QE8K3nLIAXrGZrzk/ao4J2NzbxOfcfAqInFbvIX7ZCW1/AIVH2NIfr4X
 6za+PTrHIXwXOaVqLO3fjACrQuTceGSZFCnjHZHQHbe/V44IP9hOw7pbgMn40m/EbPzH
 10zoZg0ee9xbU7bSSwDsLCLytqoc8ORCNclv8gD1LoMBNBZIbh+njRXcmVKfRH2H7q5Y
 vOkfsc3e1lLNDCROXaKDYEcjG1R64TKt65jHz3jQDyBxTlEbI+yrvOdEG8nWIWh1WGQ+
 al/Q==
X-Gm-Message-State: AFq9FYI/3yrrnMHP0KWjfrHlPOLT/r3fehCT0knZmnE6q6IoyeTnrWfJ
 HdwyoPxVuwN57Y93YAWpgoF0V3dSFSxJHGO3X+U72CDupnAemNkuz39EZ32EnKnl8ypeAJmqqF9
 4TBQTBFJ3JMku43hXKaCpNMSAQFYfiZ34uPYFt2iFdBLaMS+IVSS7sQV/eh3QBEVTo8KE
X-Gm-Gg: AYBFou0nUx9Ie7ZUTmyqKtwE1P7VdP8wN3P7jbAhHzY/RbDWMUFMP8tq4453WGbfHQ1
 vFy+OXuEtPuiqhv74hyQB8oTIvIROwaTqHaz7rPLT94JyJbz5NDC9IebFg4uXw3TMTKYu9bO1Yp
 ACiCTYYilz1Rv3DIasU8xVMjLaH5QTCIMSDDQYlAxaN7ZLHCO9VRKIXeP/bnw4E5d5pG1RMz9Db
 G46ml/Z3x6h9VqVSD0de1JuKmIjXtTuRV3XDOlyysVt54FNlkSBsl4fZSi957bckCzsZJ94RQeC
 VgVmD7UR4jlUB6osJOprkwpvFixZh/ZYfC3a+FvrY3AW2aNU2GKzkaWaP5gErEhUyGKxQyVfosK
 0vnTywIKOpnWz6RnOjY+luUeTvJxvjOvPX8uMr+lXDZNTG2/fINSBq2tF8oIGJN0c+5qr7VmowA
 ZcyU30sf5HmwEnkuN6l7oJwPwwzUjnZwBICqmaeyY0JnX4zK5LhlwEhNtd5pOiPL9VTRk08ecmU
 cf1ssvQOcJT9/zW/juzQEJx9/bW/Z33SfeILTkVKgaRfSTCugNXuH3ur5CRWy3fDOF4Zr5AlpH4
 XAiQKjh3kTfv4XU4vBaHlEE7igegDPHhDpQdWf2egNyfskExS10ynrNejxRE
X-Received: by 2002:a05:600c:6749:b0:4a0:1a7f:2abf with SMTP id
 5b1f17b1804b1-4a18e49d633mr300299105e9.7.1791979022453; 
 Wed, 14 Oct 2026 04:57:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b482b3e4sm43704975e9.4.2026.10.14.04.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:57:02 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:56:59 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: 40b3358be44d109b52f0c2beb4c57bb0ee4e7e2d
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1a5f78f7dea6b6763b812849d90977f90bff354b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxbZ-0008Ir-8I
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Fix small
 issues in buf_printf and buf_puts
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3876916785051705653=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3876916785051705653==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9fYcme8sziY="; charset=UTF-8

--9fYcme8sziY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=
=3Demail

to look at the new patch set (#3)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: b=
uffer: Fix small issues in buf_printf and buf_puts
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Fix small issues in buf_print=
f and buf_puts

- Remove unused and wrongly document return value
  of buf_=
puts
- Add UTs for buf_puts
Both of these changes based on a PR by
cuishuan=
g <imcusg@gmail=2Ecom>=2E

In both functions:
- Remove obsolete manual addi=
ng of \0
- Do not try to append if we can only overwrite
  the trailing \0 =
byte

Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
Signed-off-by: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M s=
rc/openvpn/buffer=2Eh
M tests/unit_tests/openvpn/test_buffer=2Ec
3 files ch=
anged, 39 insertions(+), 16 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/97/1997/3

diff --git a/src/openvpn/buff=
er=2Ec b/src/openvpn/buffer=2Ec
index cc1b300=2E=2E3599cc9 100644
--- a/src=
/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -225,21 +225,20 @@
 boo=
l
 buf_printf(struct buffer *buf, const char *format, =2E=2E=2E)
 {
-    in=
t ret =3D false;
+    bool ret =3D false;
     if (buf_defined(buf))
     {=

-        uint8_t *ptr =3D BEND(buf);
+        char *ptr =3D (char *)BEND(b=
uf);
         int cap =3D buf_forward_capacity(buf);
 
-        if (cap > 0=
)
+        if (cap > 1) /* can write more than \0 */
         {
           =
  int stat;
             va_list arglist;
             va_start(arglist, fo=
rmat);
-            stat =3D vsnprintf((char *)ptr, cap, format, arglist);
=
+            stat =3D vsnprintf(ptr, cap, format, arglist);
             va=
_end(arglist);
-            *(buf->data + buf->capacity - 1) =3D 0; /* wind=
ows vsnprintf needs this */
-            buf->len +=3D (int)strlen((char *)=
ptr);
+            buf->len +=3D (int)strlen(ptr);
             if (stat >=
=3D 0 && stat < cap)
             {
                 ret =3D true;
@@ -249,=
19 +248,16 @@
     return ret;
 }
 
-bool
+void
 buf_puts(struct buffer *bu=
f, const char *str)
 {
-    int ret =3D false;
-    uint8_t *ptr =3D BEND(b=
uf);
+    char *ptr =3D (char *)BEND(buf);
     int cap =3D buf_forward_cap=
acity(buf);
-    if (cap > 0)
+    if (cap > 1) /* can write more than \0 *=
/
     {
-        int str_len =3D (int)strlcpy((char *)ptr, str, cap);
+   =
     int str_len =3D (int)strlcpy(ptr, str, cap);
         buf->len +=3D (s=
tr_len < cap) ? str_len : cap - 1;
-        ret =3D true;
     }
-    retur=
n ret;
 }
 
 /*
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2E=
h
index c66ed1a=2E=2Eeb64446 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/=
openvpn/buffer=2Eh
@@ -791,10 +791,8 @@
  *
  * @param buf   The buffer to =
append to=2E
  * @param str   The null-terminated string to append=2E
- *
-=
 * @return true if the string fit in the buffer, false if it was truncated=
=2E
  */
-bool buf_puts(struct buffer *buf, const char *str);
+void buf_put=
s(struct buffer *buf, const char *str);
 
 
 /*
diff --git a/tests/unit_tes=
ts/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index=
 bf486e0=2E=2E338265d 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec=

+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -62,6 +62,10 @@
     buf=
_printf(&buf, "%d", 123);
     buf_printf(&buf, "%s", "some text, too long =
to fit");
     assert_buf_equals_str(&buf, "123some text, t");
+    assert_=
int_equal(BCAP(&buf), 1); /* \0 byte not part of len */
+
+    buf_printf(&=
buf, "%s", "more");
+    assert_buf_equals_str(&buf, "123some text, t");
 
=
     buf_catrunc(&buf, "=2E=2E=2E");
     assert_buf_equals_str(&buf, "123s=
ome text=2E=2E=2E");
@@ -79,6 +83,30 @@
 }
 
 static void
+test_buffer_puts=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer =
buf =3D alloc_buf_gc(5, &gc);
+
+    buf_puts(&buf, "1234");
+    assert_st=
ring_equal(BSTR(&buf), "1234");
+
+    buf_reset_len(&buf);
+    buf_puts(&=
buf, "12345");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    /* buf =
already full */
+    buf_puts(&buf, "12345");
+    assert_string_equal(BSTR=
(&buf), "1234");
+
+    struct buffer one_byte_buf =3D alloc_buf_gc(1, &gc)=
;
+    buf_puts(&one_byte_buf, "x");
+    assert_string_equal(BSTR(&one_byt=
e_buf), "");
+
+    gc_free(&gc);
+}
+
+static void
 test_buffer_format_hex=
_ex(void **state)
 {
     const int input_size =3D 10;
@@ -632,6 +660,7 @@
=
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_b=
uffer_strprefix),
         cmocka_unit_test(test_buffer_printf_catrunc),
+ =
       cmocka_unit_test(test_buffer_puts),
         cmocka_unit_test(test_b=
uffer_format_hex_ex),
         cmocka_unit_test_setup_teardown(test_buffer_=
list_aggregate_separator_empty,
                                         te=
st_buffer_list_setup, test_buffer_list_teardown),

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827=
a
Gerrit-Change-Number: 1997
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>

--9fYcme8sziY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #3</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">buffer: Fix small issues in buf_pri=
ntf and buf_puts<br><br>- Remove unused and wrongly document return value<b=
r>  of buf_puts<br>- Add UTs for buf_puts<br>Both of these changes based on=
 a PR by<br>cuishuang &lt;imcusg@gmail=2Ecom&gt;=2E<br><br>In both function=
s:<br>- Remove obsolete manual adding of \0<br>- Do not try to append if we=
 can only overwrite<br>  the trailing \0 byte<br><br>Change-Id: I1d6ed5d409=
10359b65b9f5c5d8f56ad3d3bc827a<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn=
/buffer=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>3 files change=
d, 39 insertions(+), 16 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/1997/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>i=
ndex cc1b300=2E=2E3599cc9 100644</span><br><span>--- a/src/openvpn/buffer=
=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -225,2=
1 +225,20 @@</span><br><span> bool</span><br><span> buf_printf(struct buffe=
r *buf, const char *format, =2E=2E=2E)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><s=
pan>     if (buf_defined(buf))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uint8_t *ptr =3D BEND(buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        char *ptr =3D (char=
 *)BEND(buf);</span><br><span>         int cap =3D buf_forward_capacity(buf=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (cap &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (cap &gt; 1) /* can write more than \0 */</span><br><span>   =
      {</span><br><span>             int stat;</span><br><span>            =
 va_list arglist;</span><br><span>             va_start(arglist, format);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stat =3D vs=
nprintf((char *)ptr, cap, format, arglist);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            stat =3D vsnprintf(ptr, cap, format, ar=
glist);</span><br><span>             va_end(arglist);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            *(buf-&gt;data + buf-&gt;capaci=
ty - 1) =3D 0; /* windows vsnprintf needs this */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            buf-&gt;len +=3D (int)strlen((char =
*)ptr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
buf-&gt;len +=3D (int)strlen(ptr);</span><br><span>             if (stat &g=
t;=3D 0 &amp;&amp; stat &lt; cap)</span><br><span>             {</span><br>=
<span>                 ret =3D true;</span><br><span>@@ -249,19 +248,16 @@<=
/span><br><span>     return ret;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> buf_puts(struct buf=
fer *buf, const char *str)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int ret =3D false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    uint8_t *ptr =3D BEND(buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *ptr =3D (char *)BEND(buf);</=
span><br><span>     int cap =3D buf_forward_capacity(buf);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (cap &gt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (cap &gt; 1) /* can write more =
than \0 */</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        int str_len =3D (int)strlcpy((char *)ptr, str, cap);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        int str_len =
=3D (int)strlcpy(ptr, str, cap);</span><br><span>         buf-&gt;len +=3D =
(str_len &lt; cap) ? str_len : cap - 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ret =3D true;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span> }=
</span><br><span> </span><br><span> /*</span><br><span>diff --git a/src/ope=
nvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index c66ed1a=2E=
=2Eeb64446 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -791,10 +791,8 @@</span=
><br><span>  *</span><br><span>  * @param buf   The buffer to append to=2E<=
/span><br><span>  * @param str   The null-terminated string to append=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @return true if the string fit in the bu=
ffer, false if it was truncated=2E</span><br><span>  */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-bool buf_puts(struct buffer *buf, const c=
har *str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void buf_=
puts(struct buffer *buf, const char *str);</span><br><span> </span><br><spa=
n> </span><br><span> /*</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><sp=
an>index bf486e0=2E=2E338265d 100644</span><br><span>--- a/tests/unit_tests=
/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_buffer=2Ec</span><br><span>@@ -62,6 +62,10 @@</span><br><span>     buf_pr=
intf(&amp;buf, &quot;%d&quot;, 123);</span><br><span>     buf_printf(&amp;b=
uf, &quot;%s&quot;, &quot;some text, too long to fit&quot;);</span><br><spa=
n>     assert_buf_equals_str(&amp;buf, &quot;123some text, t&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BCAP(=
&amp;buf), 1); /* \0 byte not part of len */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_printf(&amp;buf, &quot;%s&quot;, &quot;more&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_buf_equals_str(&am=
p;buf, &quot;123some text, t&quot;);</span><br><span> </span><br><span>    =
 buf_catrunc(&amp;buf, &quot;=2E=2E=2E&quot;);</span><br><span>     assert_=
buf_equals_str(&amp;buf, &quot;123some text=2E=2E=2E&quot;);</span><br><spa=
n>@@ -79,6 +83,30 @@</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_buf=
fer_puts(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_puts(&amp;buf, &quot;1234&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;buf)=
, &quot;1234&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_reset_len(=
&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_p=
uts(&amp;buf, &quot;12345&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(BSTR(&amp;buf), &quot;1234&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* buf already full */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_puts(&amp;buf, &quot;12345=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(BSTR(&amp;buf), &quot;1234&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer one_byte_buf =3D alloc_buf_gc(1, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_puts(&amp;one_byt=
e_buf, &quot;x&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(BSTR(&amp;one_byte_buf), &quot;&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span> test_buffer_format_hex_ex(void **state)</span><br><sp=
an> {</span><br><span>     const int input_size =3D 10;</span><br><span>@@ =
-632,6 +660,7 @@</span><br><span>     const struct CMUnitTest tests[] =3D {=
</span><br><span>         cmocka_unit_test(test_buffer_strprefix),</span><b=
r><span>         cmocka_unit_test(test_buffer_printf_catrunc),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_bu=
ffer_puts),</span><br><span>         cmocka_unit_test(test_buffer_format_he=
x_ex),</span><br><span>         cmocka_unit_test_setup_teardown(test_buffer=
_list_aggregate_separator_empty,</span><br><span>                          =
               test_buffer_list_setup, test_buffer_list_teardown),</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1997?usp=3Demail">change 1997</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1997?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc8=
27a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1997 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

=
</body></html>
--9fYcme8sziY=--


--===============3876916785051705653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3876916785051705653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3876916785051705653==--

