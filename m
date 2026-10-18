Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBFFCCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKXcfzxcNc3c3VteKHCVceaAB2gjLlMDprUY8Hg2clk=; b=l0Bt9RdVoxfNx2fzziuCGmym0q
	cWm9k1svvW4RijpFuuduRFGizDYuddEjXC4r2Fc8I9sLjYJasFTtAlXl0NrXYVBCZNt6KE5diQC6r
	/1YFXwiOVT4iIb5+YzyN9cbOU/0AB6x9LRzay8zV5GoT5A9c4VcLJ45E5ftZwN70bx/E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRBS-0008HI-Ga;
	Sun, 18 Oct 2026 13:44:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIRBQ-0008HB-KK
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ctIFsagj2albhqwF7uJztCqLAJNPIxXOWOB7UQ0M80Y=; b=b9UsvCRLtWvX/4xGXm4ZbM6cE5
 NF2Jrvc9PlnaETIvNuaAIRbM6DQqAE681TaKY3lZ866JpOyM3X0ujHlXCFhPiUbJcNjy5dvT/gYNp
 qOlYilIaJ7Xk1ovwqDol/5UfoPxBrVc/6wLU0y83CDcoIWlEac8IeAl+fo1E3IWRANgA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ctIFsagj2albhqwF7uJztCqLAJNPIxXOWOB7UQ0M80Y=; b=B
 EvqwX/NfWLIXW4T3rhCJeWZ3rRtTRnc6w0QL4H0Ej08P+ZG+ivH7BG/2H+aZ9qHybVfjqijCYtCwR
 UVZTzLr715DguCd1wS4fUV0N8b+1BUL3BBLuByij/+gh0cMWLgX6Je2YigJw1ItV3zI6GIZJOLram
 MYCBz4nX5wUIImf0=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIRBM-0007Cc-9O for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:44:14 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso700321f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792331046; x=1792935846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ctIFsagj2albhqwF7uJztCqLAJNPIxXOWOB7UQ0M80Y=;
 b=FDEhbi4JCVE2EA2dkzPEXkh2NphiyTqg4p38zVou9/LWOT8mYFAbD9TkustXuv6Dw9
 x+sVlQ0W8TmezNItg5Ml2Si5JiBnKNQLPKC8o3qr024z2OOyZhw2KnVS8vL6kO+Ni6VK
 7QMp8oIHP0mLanib6tXiGGK7pou/yUxJOzUuzkiPjWkzwQ4GV4YeyDOe7Z05iRifSrZP
 pDdMKKmywRi2BNtZPxt6h9OCubTHRRhsdNSU9nZvF4nAfodjw72eQGuVsiajDCQ4NSc7
 9LASYWu0U7oKG0MTrsEQ9TxB2hVTdAkUBJhw0eQfY+y9mN3P72lu9543zaGHI0cTW1rC
 STng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792331046; x=1792935846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ctIFsagj2albhqwF7uJztCqLAJNPIxXOWOB7UQ0M80Y=;
 b=MDe4YQmFPwbSrgTWfwNxia9sa06TN48qt5PzCQMW3slXfibqZjxDjVXSITWix4MB/a
 cPmQJLic1xnkX9BM0h5q5mS2f2KLEAwReDXNd4mzXRkEoGG8eoLzPIPxFAR1/+hQuCpE
 QiJffxUnNiKU154fn2XJ5aEvebCatD1GM6vOV49KrI6vVM2YVRqyrP4h0Xn8eONQxr4O
 aB8/eZw38somd12/kWBwkOWgJg8ZUGeZiEcANM+lLeK+8MgJviQZImeAcogXvW9xuPvL
 ESYl9CYpKp3/N+kau+eWP8750McnKRi4z292mDO9/+thZN14PtUkNIviJMSsoD6kYL87
 B61A==
X-Gm-Message-State: AFq9FYKqciwr1MrGsVv1Dp8XFAdszVWN+XtbCeFJKYtB73MRDjCkI7z8
 5NPChGZHQ8TIS/+EPgx1Fj0NDxK7SUkl0fW6beZbMIusueIVhNsDEYGrK0HZ4zV99TFdUmH3PVW
 zJuWPZ+ZzZuWIQFjgcyQ0CJRNJKDe2YOruXgn7c1LXcWNEu8LjKBFU4TfAVePmx9zdIQN
X-Gm-Gg: AYBFou2MF3nrIJ/Kt/9jnTaAghpORx5+5SCk3+yPt421gFYvKjkypGh80j8YQnfu3xi
 8Vjcc72vqck0Aznr3d9JAJsuSH7wLV4PoeAEe8M0uZpqnMRy7qmRxnrOlfSSfS0KC7zqKDAlwNr
 HPdc2pNXkS8N6tXdkT1lWuPrA/H8gd3t5uoEpkIP+joIlbfQZnWjhF4ZOkzu9MXM5zLHTHlD2t9
 pECbEV2qfRV97U5dKdfeSuuzJ27E4ugBxNN2O/3pBp3b7OKWhYcyPUqUdD62QO8ImEyEGyGenOH
 lkoTRKXhWzV5rVOPR2/YBPb3Wu7VsiUZLeG0Gp/11d41oxb5QpjRMGLKDbgU4o97ic8/GD7znmN
 PDCk/pNZurQdOpXRTHg4AWa3HLNTVjE3gl+FHxLvXqQzjMcul241gcLEBKXCOvxLvvJHsvx7RMB
 sKCNrR8BeoSRCbngf3mkZAZRGSv/UAYsg7hWfBxS9XjuAdRFENsU8dQBDr8kAHnglpMHnMK7BBp
 pgdgOjNvhrc0waIPNwwfmN4yngENN6oDbafe7/M0JRAPeQjy5WmSoKU45Oavu1BSaZev8euduDg
 4c27CfYGD6qBhr99oMSLZAtXqye4/jaFMZIm0gd+0JSxqLfQeIcHTvoJqCGzeWqUctHaeoQ=
X-Received: by 2002:a05:600c:3b91:b0:4a1:e0b7:ff09 with SMTP id
 5b1f17b1804b1-4a1e0b80060mr59051005e9.33.1792331045148; 
 Sun, 18 Oct 2026 06:44:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9a88bbsm298029505e9.3.2026.10.18.06.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:44:04 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:44:02 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: 7d326e6c34b7e2ab70a94224580aa7b7b694d64d
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7233e27f45aaa59be6c4009407148fe62d5d38e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIRBM-0007Cc-9O
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3069959547964003373=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3069959547964003373==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XeXwdN7ca4k="; charset=UTF-8

--XeXwdN7ca4k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
997?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: buffer: Fix small is=
sues in buf_printf and buf_puts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

buffer: Fix small issues in buf_printf and buf_puts

- =
Remove unused and wrongly document return value
  of buf_puts
- Add UTs for=
 buf_puts
Both of these changes based on a PR by
cuishuang <imcusg@gmail=2E=
com>=2E

In both functions:
- Remove obsolete manual adding of \0
- Do not =
try to append if we can only overwrite
  the trailing \0 byte

Change-Id: I=
1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
Signed-off-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997
Message-Id: <20=
261017171858=2E16208-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39947=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
=
M src/openvpn/buffer=2Eh
M tests/unit_tests/openvpn/test_buffer=2Ec
3 files=
 changed, 39 insertions(+), 16 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/97/1997/4

diff --git a/src/openvpn/b=
uffer=2Ec b/src/openvpn/buffer=2Ec
index cc1b300=2E=2E3599cc9 100644
--- a/=
src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -225,21 +225,20 @@
 =
bool
 buf_printf(struct buffer *buf, const char *format, =2E=2E=2E)
 {
-   =
 int ret =3D false;
+    bool ret =3D false;
     if (buf_defined(buf))
   =
  {
-        uint8_t *ptr =3D BEND(buf);
+        char *ptr =3D (char *)BEN=
D(buf);
         int cap =3D buf_forward_capacity(buf);
 
-        if (cap =
> 0)
+        if (cap > 1) /* can write more than \0 */
         {
        =
     int stat;
             va_list arglist;
             va_start(arglist,=
 format);
-            stat =3D vsnprintf((char *)ptr, cap, format, arglist=
);
+            stat =3D vsnprintf(ptr, cap, format, arglist);
            =
 va_end(arglist);
-            *(buf->data + buf->capacity - 1) =3D 0; /* w=
indows vsnprintf needs this */
-            buf->len +=3D (int)strlen((char=
 *)ptr);
+            buf->len +=3D (int)strlen(ptr);
             if (stat=
 >=3D 0 && stat < cap)
             {
                 ret =3D true;
@@ -24=
9,19 +248,16 @@
     return ret;
 }
 
-bool
+void
 buf_puts(struct buffer *=
buf, const char *str)
 {
-    int ret =3D false;
-    uint8_t *ptr =3D BEND=
(buf);
+    char *ptr =3D (char *)BEND(buf);
     int cap =3D buf_forward_c=
apacity(buf);
-    if (cap > 0)
+    if (cap > 1) /* can write more than \0=
 */
     {
-        int str_len =3D (int)strlcpy((char *)ptr, str, cap);
+ =
       int str_len =3D (int)strlcpy(ptr, str, cap);
         buf->len +=3D =
(str_len < cap) ? str_len : cap - 1;
-        ret =3D true;
     }
-    ret=
urn ret;
 }
 
 /*
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh
index 74e166c=2E=2E74233c57 100644
--- a/src/openvpn/buffer=2Eh
+++ b/=
src/openvpn/buffer=2Eh
@@ -791,10 +791,8 @@
  *
  * @param buf   The buffer=
 to append to=2E
  * @param str   The null-terminated string to append=2E
-=
 *
- * @return true if the string fit in the buffer, false if it was trunca=
ted=2E
  */
-bool buf_puts(struct buffer *buf, const char *str);
+void buf_=
puts(struct buffer *buf, const char *str);
 
 
 /*
diff --git a/tests/unit_=
tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
in=
dex bf486e0=2E=2E338265d 100644
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
@@ -79,6 +83,30 @@
 }
 
 static void
+test_buffer_=
puts(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buf=
fer buf =3D alloc_buf_gc(5, &gc);
+
+    buf_puts(&buf, "1234");
+    asser=
t_string_equal(BSTR(&buf), "1234");
+
+    buf_reset_len(&buf);
+    buf_pu=
ts(&buf, "12345");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    /* =
buf already full */
+    buf_puts(&buf, "12345");
+    assert_string_equal(=
BSTR(&buf), "1234");
+
+    struct buffer one_byte_buf =3D alloc_buf_gc(1, =
&gc);
+    buf_puts(&one_byte_buf, "x");
+    assert_string_equal(BSTR(&one=
_byte_buf), "");
+
+    gc_free(&gc);
+}
+
+static void
 test_buffer_format=
_hex_ex(void **state)
 {
     const int input_size =3D 10;
@@ -632,6 +660,7=
 @@
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(te=
st_buffer_strprefix),
         cmocka_unit_test(test_buffer_printf_catrunc)=
,
+        cmocka_unit_test(test_buffer_puts),
         cmocka_unit_test(te=
st_buffer_format_hex_ex),
         cmocka_unit_test_setup_teardown(test_buf=
fer_list_aggregate_separator_empty,
                                       =
  test_buffer_list_setup, test_buffer_list_teardown),

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3b=
c827a
Gerrit-Change-Number: 1997
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--XeXwdN7ca4k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1997?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">buffer: Fix small issues in buf_printf and buf_puts<br><br>- Remove unu=
sed and wrongly document return value<br>  of buf_puts<br>- Add UTs for buf=
_puts<br>Both of these changes based on a PR by<br>cuishuang &lt;imcusg@gma=
il=2Ecom&gt;=2E<br><br>In both functions:<br>- Remove obsolete manual addin=
g of \0<br>- Do not try to append if we can only overwrite<br>  the trailin=
g \0 byte<br><br>Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1997<br>Message-Id: &lt;20261017171858=2E1620=
8-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg39947=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2E=
c<br>M src/openvpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec=
<br>3 files changed, 39 insertions(+), 16 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/=
1997/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec=
</span><br><span>index cc1b300=2E=2E3599cc9 100644</span><br><span>--- a/sr=
c/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br=
><span>@@ -225,21 +225,20 @@</span><br><span> bool</span><br><span> buf_pri=
ntf(struct buffer *buf, const char *format, =2E=2E=2E)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D fal=
se;</span><br><span>     if (buf_defined(buf))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t *ptr =3D BE=
ND(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cha=
r *ptr =3D (char *)BEND(buf);</span><br><span>         int cap =3D buf_forw=
ard_capacity(buf);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (cap &gt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (cap &gt; 1) /* can write more than \0 */</sp=
an><br><span>         {</span><br><span>             int stat;</span><br><s=
pan>             va_list arglist;</span><br><span>             va_start(arg=
list, format);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     stat =3D vsnprintf((char *)ptr, cap, format, arglist);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            stat =3D vsnprintf(ptr,=
 cap, format, arglist);</span><br><span>             va_end(arglist);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            *(buf-&gt;data =
+ buf-&gt;capacity - 1) =3D 0; /* windows vsnprintf needs this */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            buf-&gt;len +=3D (i=
nt)strlen((char *)ptr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            buf-&gt;len +=3D (int)strlen(ptr);</span><br><span>        =
     if (stat &gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br><span>         =
    {</span><br><span>                 ret =3D true;</span><br><span>@@ -24=
9,19 +248,16 @@</span><br><span>     return ret;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> buf_=
puts(struct buffer *buf, const char *str)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D false;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *ptr =3D BEND(buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ptr =3D (char=
 *)BEND(buf);</span><br><span>     int cap =3D buf_forward_capacity(buf);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (cap &gt; 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cap &gt; 1) /* =
can write more than \0 */</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int str_len =3D (int)strlcpy((char *)ptr=
, str, cap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 int str_len =3D (int)strlcpy(ptr, str, cap);</span><br><span>         buf-=
&gt;len +=3D (str_len &lt; cap) ? str_len : cap - 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ret =3D true;</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</spa=
n><br><span> }</span><br><span> </span><br><span> /*</span><br><span>diff -=
-git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>inde=
x 74e166c=2E=2E74233c57 100644</span><br><span>--- a/src/openvpn/buffer=2Eh=
</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -791,10 +7=
91,8 @@</span><br><span>  *</span><br><span>  * @param buf   The buffer to =
append to=2E</span><br><span>  * @param str   The null-terminated string to=
 append=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @return true if the string =
fit in the buffer, false if it was truncated=2E</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool buf_puts(struct buffer =
*buf, const char *str);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void buf_puts(struct buffer *buf, const char *str);</span><br><span> </=
span><br><span> </span><br><span> /*</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec<=
/span><br><span>index bf486e0=2E=2E338265d 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/unit_test=
s/openvpn/test_buffer=2Ec</span><br><span>@@ -62,6 +62,10 @@</span><br><spa=
n>     buf_printf(&amp;buf, &quot;%d&quot;, 123);</span><br><span>     buf_=
printf(&amp;buf, &quot;%s&quot;, &quot;some text, too long to fit&quot;);</=
span><br><span>     assert_buf_equals_str(&amp;buf, &quot;123some text, t&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(BCAP(&amp;buf), 1); /* \0 byte not part of len */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;%s&quot;, &quot;more&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_buf_e=
quals_str(&amp;buf, &quot;123some text, t&quot;);</span><br><span> </span><=
br><span>     buf_catrunc(&amp;buf, &quot;=2E=2E=2E&quot;);</span><br><span=
>     assert_buf_equals_str(&amp;buf, &quot;123some text=2E=2E=2E&quot;);</=
span><br><span>@@ -79,6 +83,30 @@</span><br><span> }</span><br><span> </spa=
n><br><span> static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_buffer_puts(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(5, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf_puts(&amp;buf, &quot;1234&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(B=
STR(&amp;buf), &quot;1234&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_reset_len(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    buf_puts(&amp;buf, &quot;12345&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;buf), &quot;12=
34&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* buf already full */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_puts(&amp;buf=
, &quot;12345&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(BSTR(&amp;buf), &quot;1234&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer one_byte_buf =3D alloc_buf_gc(1, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_puts=
(&amp;one_byte_buf, &quot;x&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_string_equal(BSTR(&amp;one_byte_buf), &quot;&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span> test_buffer_format_hex_ex(void **state)<=
/span><br><span> {</span><br><span>     const int input_size =3D 10;</span>=
<br><span>@@ -632,6 +660,7 @@</span><br><span>     const struct CMUnitTest =
tests[] =3D {</span><br><span>         cmocka_unit_test(test_buffer_strpref=
ix),</span><br><span>         cmocka_unit_test(test_buffer_printf_catrunc),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(test_buffer_puts),</span><br><span>         cmocka_unit_test(test_buf=
fer_format_hex_ex),</span><br><span>         cmocka_unit_test_setup_teardow=
n(test_buffer_list_aggregate_separator_empty,</span><br><span>             =
                            test_buffer_list_setup, test_buffer_list_teardo=
wn),</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1997?usp=3Demail">change 1997</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5=
d8f56ad3d3bc827a </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1997 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--XeXwdN7ca4k=--


--===============3069959547964003373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3069959547964003373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3069959547964003373==--

