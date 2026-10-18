Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01269CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCaWHFxcJJK9sl/shbSUhzFXf5hbAb7xp8S7hvEMam4=; b=JIfdpY6L1em5N8Cg0x0PGAKvX9
	GXEr6z2C4wL4e+8rQmentObWGoVvjC5fgKoRfm+wdid/NnZeFvBYCqBRItenT2YtP95FL+3vvIYxQ
	8mDpYPLJ6f1Doi4q7zVKU6ATwIspg8G6MlRVcV/EgtIHhEYdg7CNgOzFO3/7rzehAzS8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRBP-0002eC-FI;
	Sun, 18 Oct 2026 13:44:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIRBO-0002dz-2U
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:44:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q8nbY7FrmB/z7vJ+3wA8F1ue2XhsqLvcjEi83D8V6RQ=; b=PgwRWFOYQDyaDMCCTFKp7WTPcq
 Cj7DtMimM+YiJi16IYMxQsdPzKaZqWm6NEhIMaWAgult9kXDc7ArpYYMAfwM8wV7Zq2dHQugpx0yk
 qdwNmqyQ1IBq48p0w7GvO5gGzvSFhhLvnmgHrbpy7NH+eNMidaDYiXG0AlDQKkGIcJiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q8nbY7FrmB/z7vJ+3wA8F1ue2XhsqLvcjEi83D8V6RQ=; b=f
 7TBOMecSsL327z0IsWwERJr/gUHLnopSL/Xa88SthvNwmO2Z+/GNwB3DfPulPg6zDFTjzooseQMg9
 u+G6hUfu4Utg4uJOoL7XBXi6Kru7KtnyFpJg7UDQXr+PvQcKkJP5ZQmpqexvALHXvXXIfMX78LUZ8
 VUGY896GoAolSVlY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIRBM-00059Q-QX for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:44:14 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1e2957d7eso3574305e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792331046; x=1792935846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q8nbY7FrmB/z7vJ+3wA8F1ue2XhsqLvcjEi83D8V6RQ=;
 b=SbsUSu9e9gpzAwj6fKH7HHU9j07dIJqwiWNk2q3vV979VeNCgbLHPfRWweE7qEsEyL
 KfFZ0EQ2FKND25DPM7Jhlr5/yWHZ+OL7iE8y0K5iX1G1iAumnGbs1adhsOZUqsVyMiqn
 EEJOglqEHlaW8Nm1MxoarIXD/5te0oaPqBGm2XPdu8R9B4owo3ayDkRlQ0Wgw8n7Ri3I
 ZCT6K0qP2sEDVOrvsRwWLSZvNVc3x13H/3Pf/BDBEFMLCdu76LCQNqiEg/hC/PI+6zd5
 lzwwaOryj6KCJpJkFdgIgoe2nsb434gXn4By0oWDApGmzwDR821jfar29cM1u/W5TfVa
 7LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792331046; x=1792935846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q8nbY7FrmB/z7vJ+3wA8F1ue2XhsqLvcjEi83D8V6RQ=;
 b=s7LggYJlu9yrAkkciz9s06zrHuCI6U+Sqjeclctuu2+qHl0jhVCh+mfM0uDFSkmRmz
 X85opfrFrylASIwrfH9Zm4QgtLNCHGoqEyyz8sZS7GEjKWtdIxCi7uqqk37hiz9z4x9c
 7Y21cbUeUiG2mo25PIAdINJnIsHdKHFwSdN/xeLbTWaO0S8v57kFgbxpOJ8mUDg3pDke
 3xPkBWU9mYIFOzlQwMJok0jiMAmB3TctWHMg1NXQyDaY4t1G9vOMripPXRQNwUyERa40
 Xr17DclxEbwi9fBZD1Ggqa57zIKoeNSgQe/FP3i9wdJqXM/tzi4FFWk9byr3vYBIT/0M
 yikA==
X-Forwarded-Encrypted: i=1;
 AKwUvByFatRvLRDLSFN33HRVuUkiF9ij5DPAfRRUUtMQrq9IhQD4zw6Eh0RmhDUaIyyXyb/AE/E+UNOJTSJSpu6Q@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIQOJY+doE73cYuupiqpGO6w7nOZgVwa2FCvsWfNnrsUUyGF7XZ
 bwbHqNHxeOE1e8KBr5vB1wiVFJUo37iv/4LGf9Gqjrc9ZL7dnNUBXy63C5Arf3cexb48sJDybIX
 0ycDvg7Yp/YTGDXV2R0i11A91EeSwbGr+WEC4qrteiUJHIaz7gJhn5AXiHtlptK808MJD
X-Gm-Gg: AYBFou1+Rv+zIDO9xwYYZd3wUqx0Tepgxh7kIvvKEjFVQZaYwDNB72MfZbcRn2aKpAd
 4RhxaxhJJpA3EBUxnRQC4cj8sGLzEoUuxYM/RTFie+yesMkQw3OUAqXDvIaKiHzHF4mSYkt+YGc
 fWIZiv4QOcfAbZNK7PctOe94hjpNEpKIV0GnAlt1HAkYNyKVwCVykku/pnLn1R7fL6aHDljYPsQ
 +P5wID+toeMu6I0xIaHp7U1EDRpzvCMWV3orYfQuUFwA2A1zHoZowdVmFhwSyvgW5iTubPmeHNe
 2BVWavLP0NwMYmV7dNoGIh+UKLQMkrfXq9jpu+pcmY9pXMxcwcTRlbXIhWTOb+p7u8/5NMwE63Y
 /VfXv7e5zJi2VjFU1+WtOzXlwIdpI0/zQAUJqC+U+Ul9GRSecBBsxyIApDTc8G11DAsYzR7la5C
 CUB+QO5u9BXQyidfk0JvbtlpuBBmD6aRKKe6C8R6UrfFPI+DvUbYa9UiD9vi8x3VvOcvZ1PvDqC
 /cNOE1q04vgfudIV5Fy+0gMj7eep5o00GR5ikuflHH6+XRoTK14WZd1T9PneRN1g+P2Rppwzj3M
 /wC44lWWFag4zF3CERi+4MaAK+OsDHxJMq8jSY4tSmQvPPAiLKsir4xH6EFE
X-Received: by 2002:a05:600c:8b28:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a1d7634d5dmr108598705e9.28.1792331046074; 
 Sun, 18 Oct 2026 06:44:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cf05009csm176298555e9.10.2026.10.18.06.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:44:05 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:44:05 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: 7d326e6c34b7e2ab70a94224580aa7b7b694d64d
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7233e27f45aaa59be6c4009407148fe62d5d38e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIRBM-00059Q-QX
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3548186648208258144=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3548186648208258144==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8/AKev1JWF4="; charset=UTF-8

--8/AKev1JWF4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1997?usp=3Demail )

Change subject: buffer: Fix small issues in=
 buf_printf and buf_puts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

buffer: Fix small issues in buf_printf and buf_puts

- Remove=
 unused and wrongly document return value
  of buf_puts
- Add UTs for buf_p=
uts
Both of these changes based on a PR by
cuishuang <imcusg@gmail=2Ecom>=
=2E

In both functions:
- Remove obsolete manual adding of \0
- Do not try =
to append if we can only overwrite
  the trailing \0 byte

Change-Id: I1d6e=
d5d40910359b65b9f5c5d8f56ad3d3bc827a
Signed-off-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997
Message-Id: <202610=
17171858=2E16208-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39947=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M sr=
c/openvpn/buffer=2Eh
M tests/unit_tests/openvpn/test_buffer=2Ec
3 files cha=
nged, 39 insertions(+), 16 deletions(-)




diff --git a/src/openvpn/buffer=
=2Ec b/src/openvpn/buffer=2Ec
index cc1b300=2E=2E3599cc9 100644
--- a/src/o=
penvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -225,21 +225,20 @@
 bool
=
 buf_printf(struct buffer *buf, const char *format, =2E=2E=2E)
 {
-    int =
ret =3D false;
+    bool ret =3D false;
     if (buf_defined(buf))
     {
-=
        uint8_t *ptr =3D BEND(buf);
+        char *ptr =3D (char *)BEND(buf=
);
         int cap =3D buf_forward_capacity(buf);
 
-        if (cap > 0)
=
+        if (cap > 1) /* can write more than \0 */
         {
             =
int stat;
             va_list arglist;
             va_start(arglist, form=
at);
-            stat =3D vsnprintf((char *)ptr, cap, format, arglist);
+ =
           stat =3D vsnprintf(ptr, cap, format, arglist);
             va_e=
nd(arglist);
-            *(buf->data + buf->capacity - 1) =3D 0; /* window=
s vsnprintf needs this */
-            buf->len +=3D (int)strlen((char *)pt=
r);
+            buf->len +=3D (int)strlen(ptr);
             if (stat >=3D=
 0 && stat < cap)
             {
                 ret =3D true;
@@ -249,19 =
+248,16 @@
     return ret;
 }
 
-bool
+void
 buf_puts(struct buffer *buf, =
const char *str)
 {
-    int ret =3D false;
-    uint8_t *ptr =3D BEND(buf)=
;
+    char *ptr =3D (char *)BEND(buf);
     int cap =3D buf_forward_capaci=
ty(buf);
-    if (cap > 0)
+    if (cap > 1) /* can write more than \0 */
 =
    {
-        int str_len =3D (int)strlcpy((char *)ptr, str, cap);
+      =
  int str_len =3D (int)strlcpy(ptr, str, cap);
         buf->len +=3D (str_=
len < cap) ? str_len : cap - 1;
-        ret =3D true;
     }
-    return r=
et;
 }
 
 /*
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
i=
ndex 74e166c=2E=2E74233c57 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/op=
envpn/buffer=2Eh
@@ -791,10 +791,8 @@
  *
  * @param buf   The buffer to ap=
pend to=2E
  * @param str   The null-terminated string to append=2E
- *
- *=
 @return true if the string fit in the buffer, false if it was truncated=2E=

  */
-bool buf_puts(struct buffer *buf, const char *str);
+void buf_puts(s=
truct buffer *buf, const char *str);
 
 
 /*
diff --git a/tests/unit_tests/=
openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index bf=
486e0=2E=2E338265d 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
++=
+ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -62,6 +62,10 @@
     buf_pr=
intf(&buf, "%d", 123);
     buf_printf(&buf, "%s", "some text, too long to =
fit");
     assert_buf_equals_str(&buf, "123some text, t");
+    assert_int=
_equal(BCAP(&buf), 1); /* \0 byte not part of len */
+
+    buf_printf(&buf=
, "%s", "more");
+    assert_buf_equals_str(&buf, "123some text, t");
 
   =
  buf_catrunc(&buf, "=2E=2E=2E");
     assert_buf_equals_str(&buf, "123some=
 text=2E=2E=2E");
@@ -79,6 +83,30 @@
 }
 
 static void
+test_buffer_puts(vo=
id **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf=
 =3D alloc_buf_gc(5, &gc);
+
+    buf_puts(&buf, "1234");
+    assert_strin=
g_equal(BSTR(&buf), "1234");
+
+    buf_reset_len(&buf);
+    buf_puts(&buf=
, "12345");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    /* buf alr=
eady full */
+    buf_puts(&buf, "12345");
+    assert_string_equal(BSTR(&b=
uf), "1234");
+
+    struct buffer one_byte_buf =3D alloc_buf_gc(1, &gc);
+=
    buf_puts(&one_byte_buf, "x");
+    assert_string_equal(BSTR(&one_byte_b=
uf), "");
+
+    gc_free(&gc);
+}
+
+static void
 test_buffer_format_hex_ex=
(void **state)
 {
     const int input_size =3D 10;
@@ -632,6 +660,7 @@
   =
  const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_buff=
er_strprefix),
         cmocka_unit_test(test_buffer_printf_catrunc),
+    =
    cmocka_unit_test(test_buffer_puts),
         cmocka_unit_test(test_buff=
er_format_hex_ex),
         cmocka_unit_test_setup_teardown(test_buffer_lis=
t_aggregate_separator_empty,
                                         test_=
buffer_list_setup, test_buffer_list_teardown),

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
Gerrit=
-Change-Number: 1997
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8/AKev1JWF4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1997?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">buffer: Fix small issues in buf_pr=
intf and buf_puts<br><br>- Remove unused and wrongly document return value<=
br>  of buf_puts<br>- Add UTs for buf_puts<br>Both of these changes based o=
n a PR by<br>cuishuang &lt;imcusg@gmail=2Ecom&gt;=2E<br><br>In both functio=
ns:<br>- Remove obsolete manual adding of \0<br>- Do not try to append if w=
e can only overwrite<br>  the trailing \0 byte<br><br>Change-Id: I1d6ed5d40=
910359b65b9f5c5d8f56ad3d3bc827a<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997<b=
r>Message-Id: &lt;20261017171858=2E16208-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg39947=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M t=
ests/unit_tests/openvpn/test_buffer=2Ec<br>3 files changed, 39 insertions(+=
), 16 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/s=
rc/openvpn/buffer=2Ec</span><br><span>index cc1b300=2E=2E3599cc9 100644</sp=
an><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn=
/buffer=2Ec</span><br><span>@@ -225,21 +225,20 @@</span><br><span> bool</sp=
an><br><span> buf_printf(struct buffer *buf, const char *format, =2E=2E=2E)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool ret =3D false;</span><br><span>     if (buf_defined(buf))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uint8_t *ptr =3D BEND(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        char *ptr =3D (char *)BEND(buf);</span><br><span>        =
 int cap =3D buf_forward_capacity(buf);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (cap &gt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (cap &gt; 1) /* can writ=
e more than \0 */</span><br><span>         {</span><br><span>             i=
nt stat;</span><br><span>             va_list arglist;</span><br><span>    =
         va_start(arglist, format);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            stat =3D vsnprintf((char *)ptr, cap, format, argl=
ist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            st=
at =3D vsnprintf(ptr, cap, format, arglist);</span><br><span>             v=
a_end(arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      *(buf-&gt;data + buf-&gt;capacity - 1) =3D 0; /* windows vsnprintf ne=
eds this */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  buf-&gt;len +=3D (int)strlen((char *)ptr);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            buf-&gt;len +=3D (int)strlen(ptr);</sp=
an><br><span>             if (stat &gt;=3D 0 &amp;&amp; stat &lt; cap)</spa=
n><br><span>             {</span><br><span>                 ret =3D true;</=
span><br><span>@@ -249,19 +248,16 @@</span><br><span>     return ret;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void<=
/span><br><span> buf_puts(struct buffer *buf, const char *str)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D=
 false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *p=
tr =3D BEND(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char *ptr =3D (char *)BEND(buf);</span><br><span>     int cap =3D buf_for=
ward_capacity(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (cap &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (cap &gt; 1) /* can write more than \0 */</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        int str_len =3D (in=
t)strlcpy((char *)ptr, str, cap);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int str_len =3D (int)strlcpy(ptr, str, cap);</span><b=
r><span>         buf-&gt;len +=3D (str_len &lt; cap) ? str_len : cap - 1;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D true;</=
span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return ret;</span><br><span> }</span><br><span> </span><br><span> /*</s=
pan><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh<=
/span><br><span>index 74e166c=2E=2E74233c57 100644</span><br><span>--- a/sr=
c/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br=
><span>@@ -791,10 +791,8 @@</span><br><span>  *</span><br><span>  * @param =
buf   The buffer to append to=2E</span><br><span>  * @param str   The null-=
terminated string to append=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return=
 true if the string fit in the buffer, false if it was truncated=2E</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool buf=
_puts(struct buffer *buf, const char *str);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void buf_puts(struct buffer *buf, const char *str);=
</span><br><span> </span><br><span> </span><br><span> /*</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/open=
vpn/test_buffer=2Ec</span><br><span>index bf486e0=2E=2E338265d 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+=
++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -62,6 +62,=
10 @@</span><br><span>     buf_printf(&amp;buf, &quot;%d&quot;, 123);</span=
><br><span>     buf_printf(&amp;buf, &quot;%s&quot;, &quot;some text, too l=
ong to fit&quot;);</span><br><span>     assert_buf_equals_str(&amp;buf, &qu=
ot;123some text, t&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(BCAP(&amp;buf), 1); /* \0 byte not part of len =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;%s&qu=
ot;, &quot;more&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_buf_equals_str(&amp;buf, &quot;123some text, t&quot;);</span=
><br><span> </span><br><span>     buf_catrunc(&amp;buf, &quot;=2E=2E=2E&quo=
t;);</span><br><span>     assert_buf_equals_str(&amp;buf, &quot;123some tex=
t=2E=2E=2E&quot;);</span><br><span>@@ -79,6 +83,30 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+test_buffer_puts(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(5=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_puts(&amp;buf, &quo=
t;1234&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(BSTR(&amp;buf), &quot;1234&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_reset_len(&amp;buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_puts(&amp;buf, &quot;12345&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR=
(&amp;buf), &quot;1234&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* b=
uf already full */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_puts(&amp;buf, &quot;12345&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;buf), &quot;1234&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer one_byte_buf =
=3D alloc_buf_gc(1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_puts(&amp;one_byte_buf, &quot;x&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;one=
_byte_buf), &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span> test_buffer_format=
_hex_ex(void **state)</span><br><span> {</span><br><span>     const int inp=
ut_size =3D 10;</span><br><span>@@ -632,6 +660,7 @@</span><br><span>     co=
nst struct CMUnitTest tests[] =3D {</span><br><span>         cmocka_unit_te=
st(test_buffer_strprefix),</span><br><span>         cmocka_unit_test(test_b=
uffer_printf_catrunc),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_buffer_puts),</span><br><span>         cmo=
cka_unit_test(test_buffer_format_hex_ex),</span><br><span>         cmocka_u=
nit_test_setup_teardown(test_buffer_list_aggregate_separator_empty,</span><=
br><span>                                         test_buffer_list_setup, t=
est_buffer_list_teardown),</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">change 1997</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d6ed5=
d40910359b65b9f5c5d8f56ad3d3bc827a </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1997 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--8/AKev1JWF4=--


--===============3548186648208258144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3548186648208258144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3548186648208258144==--

