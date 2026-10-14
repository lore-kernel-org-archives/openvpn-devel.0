Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FA9CC6B30
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h8X+SGIYsGl9KCwHuEbDqKR0SccPj4KnQ15A5/qAw6g=; b=Rn/34WZA9sYVplVWsxYsx3Qql0
	HGHaTK2naJTlnKK2PetSLKx3Ry2rC8JZBgqvBAjA4zDyi9cV94+d8gFEs2txDC/y0iUtRrszPAei8
	GFo6fRikOIaIILXAHuH85WbqBzCbv2+nOqaF1m3FaGI3UWrUBvZEKj2Ht3romfqz9We8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxAd-00008s-5P;
	Wed, 14 Oct 2026 11:29:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxAc-00008V-Bw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sbHhVAASnxiI01aRa31i/Qu2srcH3z6hZYaHSUEpV2E=; b=HVrcdkPsOZDhI1FBDJPXsxdlIv
 TzaVKrGAmj931cTMGIKlNcDQ+N1LK7kTdRNIdPYBewEwjsF5vxkc2ZMNdC5zC9OlSNfILnbLM0uMV
 /IvY+guoS+3dkZdjdeE4qFyTvRckc4W98LN4+pkkM8Y93FUTTsNHufTy6QbStv/tG+uM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sbHhVAASnxiI01aRa31i/Qu2srcH3z6hZYaHSUEpV2E=; b=m
 gQtEpuCHGIeWVkgZsuVabqfSzUyA+9fRy8yn/5mRPBpURCzNbzdHvG4JyXnrWHTMWnYYeS64IEa0r
 eU7kuZG3Z+JOwmX6ayv9iDEnpc6C4AUBImxziWhvQGTO8CO7pD8S6TaKAaIll2jZdrfIj5umnBWN8
 ODVC6m9jmkwXLOps=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxAa-0004Bt-U1 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:19 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso8477975e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977350; x=1792582150; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sbHhVAASnxiI01aRa31i/Qu2srcH3z6hZYaHSUEpV2E=;
 b=BuXdC2lX2hZf+y1W6ovf5i2ugC5DzmWMCeVIHTAW/TZYXktPw8eIqGw1FF4x2Dq4mQ
 OSm/pwriHGKgIJamnJHOCAWiFGBW54vItWk8Jlwe9gc78upQu+t6zVSzMyQQO+a2s1tr
 7NBvTiCTAoWZ6Wv7qKe9ifNJhDku/HKiYZ5l5mGIDQtZDkPdLRnAvWgXN60/hDSaDaDX
 xmj0wNsfQCQaqrjUxZ/YnTlhtnZUeEZVw+xRsqYC6WWz1sMnyKv+n8SNMqaArnjT7p6w
 jo7RZZKeJ81EwvpI5IXQdtn/eDcTWqyRlaHc+Rov3GwxfLL72vOUDe29buGi79dkWdJd
 ogzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977350; x=1792582150;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sbHhVAASnxiI01aRa31i/Qu2srcH3z6hZYaHSUEpV2E=;
 b=XGVje2dnWdH/Dwpluy4Cpk9Qa1JEPJ9EJKKJydHB15L4OFs5mvCecSOIzPpUrSH9LL
 8YV1PJCqYoBxzY6TfhPzdOO75tLvNU4JkfAvRSxijqaP2FYoCewSsZUGqLSvOorMk7ag
 QtD2vP2fXlygBqR7YBLOsRSt2opetuGlbKjRAVc5dInOV9Wgjgrjcbf9UopOaPFzHLuX
 bjkmYfGVVLc3HvY6EbqVVgFVuAj7AoG6coThIF4rt7zJ2EhEmufGrmH+OEs4VN1EKNbS
 iKqftOM+JPyJNYKTrcblGlq5CCCuwoSQOc4DsZ9sdhjxyHwPzMu6LYtkPJgUKNRtQgAH
 m/jw==
X-Gm-Message-State: AFq9FYLRhxnLjqexTGCRB+2FzPvdrrCghVvdMENNcSmC9e6izQsjpryc
 aiztJmkIjuowmZGSfG7dGC3o1Lycew+8oHjdcv1+CztIXpkzSQMdy+tK8m/9ZUftlAvd+3gvIe0
 XIYLyJ9TIFvts76J9yPT3ZQevxp3/fDgYs6kIRWCoouCHg1/NW+hWkob5yTQY9gOJrGTRkCWURR
 2q+hCXxw==
X-Gm-Gg: AYBFou1SPGxrwaUwg89Imj8EN5l3g5x+aNJaHCnkXoS2MUVVdDSa38bxp/wP/L9oq8D
 TH1SwIMFk8pCoAL8qxccB69CFdqtxqqbTtlY2GJQ4iTceUeislTbxG3xl/984dQag65ci8ISz0N
 xdTX/HCVWinyVOLGYDqDOh7e/2xzO2NtY/t6xi4tbRoviGS8cBAkpLFD6CDvKrUVu8RObAnzVc0
 hCUaXyf3ZtCROIwCbicdINfD33UNztGYkR84S5owiYihroshUPdHH8/pCGAl0jGJ17Vc16i2MWV
 xKIrHXVya79mQeots0AjBp0SKT2SLdVtuaOR6ozfnTuRtNVRfxL268XDVji8FHnpR22p8NjsBK7
 ORA0cGT9JeIJ4RazRx5NXSJ0NVUC/kjzT31punLcOOUbqNbXzV8wSeNyKoO+DQAkp3hzRv6Q69i
 DYVbObfB/XYXcsqDSa73Igq92O+iwrbsNZR0n80UTVDLk5CrSDTyVmd4NVw6eDCYHqlW6SfLXJX
 W6sYoBKPPbKyLg6NEsJW4i8GCdR+FDA2F9ZXDvI0uGAnudMk5+7EQGZGEznbpHJ6ChxLdDuk1zD
 +vZCJyB89rG/jDzFIO832aT4ZZUfPX9TWgjcgQRVP7dcBSbePh/zwV9OfZ1xhRF7fpuslPE=
X-Received: by 2002:a05:600c:4e43:b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a18e4b67e1mr297397395e9.22.1791977350235; 
 Wed, 14 Oct 2026 04:29:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bea0f1csm627945215e9.9.2026.10.14.04.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:29:05 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:28:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: 512103d0b5776e82beaeca0b200bc992b27f09c1
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <20bc601508bb09412921052adb8fc15a9b25e346-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxAa-0004Bt-U1
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
Content-Type: multipart/mixed; boundary="===============0732215962200458619=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0732215962200458619==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xewt2kpNqX4="; charset=UTF-8

--Xewt2kpNqX4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1997?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: buffer: Fix small issues in buf_printf and b=
uf_puts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buff=
er: Fix small issues in buf_printf and buf_puts

- Remove unused and wrongl=
y document return value
  of buf_puts
- Add UTs for buf_puts
Both of these =
changes based on a PR by
cuishuang <imcusg@gmail=2Ecom>=2E

In both functio=
ns:
- Remove obsolete manual adding of \0
- Do not try to append if we can =
only overwrite
  the trailing \0 byte

Change-Id: I1d6ed5d40910359b65b9f5c5=
d8f56ad3d3bc827a
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tests/unit_tests/o=
penvpn/test_buffer=2Ec
3 files changed, 39 insertions(+), 16 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/1997=
/2

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index cc1b=
300=2E=2E3599cc9 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buff=
er=2Ec
@@ -225,21 +225,20 @@
 bool
 buf_printf(struct buffer *buf, const ch=
ar *format, =2E=2E=2E)
 {
-    int ret =3D false;
+    bool ret =3D false;
=
     if (buf_defined(buf))
     {
-        uint8_t *ptr =3D BEND(buf);
+   =
     char *ptr =3D (char *)BEND(buf);
         int cap =3D buf_forward_capa=
city(buf);
 
-        if (cap > 0)
+        if (cap > 1) /* can write more =
than \0 */
         {
             int stat;
             va_list arglist;
=
             va_start(arglist, format);
-            stat =3D vsnprintf((ch=
ar *)ptr, cap, format, arglist);
+            stat =3D vsnprintf(ptr, cap, =
format, arglist);
             va_end(arglist);
-            *(buf->data + =
buf->capacity - 1) =3D 0; /* windows vsnprintf needs this */
-            b=
uf->len +=3D (int)strlen((char *)ptr);
+            buf->len +=3D (int)strl=
en(ptr);
             if (stat >=3D 0 && stat < cap)
             {
       =
          ret =3D true;
@@ -249,19 +248,16 @@
     return ret;
 }
 
-bool
+=
void
 buf_puts(struct buffer *buf, const char *str)
 {
-    int ret =3D fal=
se;
-    uint8_t *ptr =3D BEND(buf);
+    char *ptr =3D (char *)BEND(buf);
=
     int cap =3D buf_forward_capacity(buf);
-    if (cap > 0)
+    if (cap =
> 1) /* can write more than \0 */
     {
-        int str_len =3D (int)strl=
cpy((char *)ptr, str, cap);
+        int str_len =3D (int)strlcpy(ptr, str,=
 cap);
         buf->len +=3D (str_len < cap) ? str_len : cap - 1;
-       =
 ret =3D true;
     }
-    return ret;
 }
 
 /*
diff --git a/src/openvpn/bu=
ffer=2Eh b/src/openvpn/buffer=2Eh
index c66ed1a=2E=2Eeb64446 100644
--- a/s=
rc/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -791,10 +791,8 @@
  *=

  * @param buf   The buffer to append to=2E
  * @param str   The null-term=
inated string to append=2E
- *
- * @return true if the string fit in the bu=
ffer, false if it was truncated=2E
  */
-bool buf_puts(struct buffer *buf, =
const char *str);
+void buf_puts(struct buffer *buf, const char *str);
 
 
=
 /*
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_test=
s/openvpn/test_buffer=2Ec
index bf486e0=2E=2E338265d 100644
--- a/tests/uni=
t_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=
=2Ec
@@ -62,6 +62,10 @@
     buf_printf(&buf, "%d", 123);
     buf_printf(&=
buf, "%s", "some text, too long to fit");
     assert_buf_equals_str(&buf, =
"123some text, t");
+    assert_int_equal(BCAP(&buf), 1); /* \0 byte not pa=
rt of len */
+
+    buf_printf(&buf, "%s", "more");
+    assert_buf_equals_=
str(&buf, "123some text, t");
 
     buf_catrunc(&buf, "=2E=2E=2E");
     a=
ssert_buf_equals_str(&buf, "123some text=2E=2E=2E");
@@ -79,6 +83,30 @@
 }
=
 
 static void
+test_buffer_puts(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(5, &gc);
+
+    buf_p=
uts(&buf, "1234");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    buf=
_reset_len(&buf);
+    buf_puts(&buf, "12345");
+    assert_string_equal(BS=
TR(&buf), "1234");
+
+    /* buf already full */
+    buf_puts(&buf, "12345=
");
+    assert_string_equal(BSTR(&buf), "1234");
+
+    struct buffer one_=
byte_buf =3D alloc_buf_gc(1, &gc);
+    buf_puts(&one_byte_buf, "x");
+    =
assert_string_equal(BSTR(&one_byte_buf), "");
+
+    gc_free(&gc);
+}
+
+st=
atic void
 test_buffer_format_hex_ex(void **state)
 {
     const int input_=
size =3D 10;
@@ -632,6 +660,7 @@
     const struct CMUnitTest tests[] =3D {=

         cmocka_unit_test(test_buffer_strprefix),
         cmocka_unit_tes=
t(test_buffer_printf_catrunc),
+        cmocka_unit_test(test_buffer_puts),=

         cmocka_unit_test(test_buffer_format_hex_ex),
         cmocka_unit=
_test_setup_teardown(test_buffer_list_aggregate_separator_empty,
          =
                               test_buffer_list_setup, test_buffer_list_tea=
rdown),

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatch=
set
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d6ed5=
d40910359b65b9f5c5d8f56ad3d3bc827a
Gerrit-Change-Number: 1997
Gerrit-PatchS=
et: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--Xewt2kpNqX4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/199=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">buf=
fer: Fix small issues in buf_printf and buf_puts<br><br>- Remove unused and=
 wrongly document return value<br>  of buf_puts<br>- Add UTs for buf_puts<b=
r>Both of these changes based on a PR by<br>cuishuang &lt;imcusg@gmail=2Eco=
m&gt;=2E<br><br>In both functions:<br>- Remove obsolete manual adding of \0=
<br>- Do not try to append if we can only overwrite<br>  the trailing \0 by=
te<br><br>Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/ope=
nvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M tests/unit_tests/openvpn/t=
est_buffer=2Ec<br>3 files changed, 39 insertions(+), 16 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/97/1997/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/open=
vpn/buffer=2Ec</span><br><span>index cc1b300=2E=2E3599cc9 100644</span><br>=
<span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=
=2Ec</span><br><span>@@ -225,21 +225,20 @@</span><br><span> bool</span><br>=
<span> buf_printf(struct buffer *buf, const char *format, =2E=2E=2E)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r=
et =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol ret =3D false;</span><br><span>     if (buf_defined(buf))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8=
_t *ptr =3D BEND(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        char *ptr =3D (char *)BEND(buf);</span><br><span>         int ca=
p =3D buf_forward_capacity(buf);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (cap &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (cap &gt; 1) /* can write more=
 than \0 */</span><br><span>         {</span><br><span>             int sta=
t;</span><br><span>             va_list arglist;</span><br><span>          =
   va_start(arglist, format);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            stat =3D vsnprintf((char *)ptr, cap, format, arglist);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            stat =3D=
 vsnprintf(ptr, cap, format, arglist);</span><br><span>             va_end(=
arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
*(buf-&gt;data + buf-&gt;capacity - 1) =3D 0; /* windows vsnprintf needs th=
is */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf-=
&gt;len +=3D (int)strlen((char *)ptr);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            buf-&gt;len +=3D (int)strlen(ptr);</span><br=
><span>             if (stat &gt;=3D 0 &amp;&amp; stat &lt; cap)</span><br>=
<span>             {</span><br><span>                 ret =3D true;</span><=
br><span>@@ -249,19 +248,16 @@</span><br><span>     return ret;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span> buf_puts(struct buffer *buf, const char *str)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *ptr =3D=
 BEND(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 *ptr =3D (char *)BEND(buf);</span><br><span>     int cap =3D buf_forward_c=
apacity(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
cap &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
cap &gt; 1) /* can write more than \0 */</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        int str_len =3D (int)strl=
cpy((char *)ptr, str, cap);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        int str_len =3D (int)strlcpy(ptr, str, cap);</span><br><spa=
n>         buf-&gt;len +=3D (str_len &lt; cap) ? str_len : cap - 1;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        ret =3D true;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn ret;</span><br><span> }</span><br><span> </span><br><span> /*</span><b=
r><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span>=
<br><span>index c66ed1a=2E=2Eeb64446 100644</span><br><span>--- a/src/openv=
pn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>=
@@ -791,10 +791,8 @@</span><br><span>  *</span><br><span>  * @param buf   T=
he buffer to append to=2E</span><br><span>  * @param str   The null-termina=
ted string to append=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return true i=
f the string fit in the buffer, false if it was truncated=2E</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool buf_puts(s=
truct buffer *buf, const char *str);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void buf_puts(struct buffer *buf, const char *str);</span>=
<br><span> </span><br><span> </span><br><span> /*</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/tes=
t_buffer=2Ec</span><br><span>index bf486e0=2E=2E338265d 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -62,6 +62,10 @@</=
span><br><span>     buf_printf(&amp;buf, &quot;%d&quot;, 123);</span><br><s=
pan>     buf_printf(&amp;buf, &quot;%s&quot;, &quot;some text, too long to =
fit&quot;);</span><br><span>     assert_buf_equals_str(&amp;buf, &quot;123s=
ome text, t&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(BCAP(&amp;buf), 1); /* \0 byte not part of len */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;%s&quot;, =
&quot;more&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_buf_equals_str(&amp;buf, &quot;123some text, t&quot;);</span><br>=
<span> </span><br><span>     buf_catrunc(&amp;buf, &quot;=2E=2E=2E&quot;);<=
/span><br><span>     assert_buf_equals_str(&amp;buf, &quot;123some text=2E=
=2E=2E&quot;);</span><br><span>@@ -79,6 +83,30 @@</span><br><span> }</span>=
<br><span> </span><br><span> static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_buffer_puts(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(5,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf_puts(&amp;buf, &quot=
;1234&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(BSTR(&amp;buf), &quot;1234&quot;);</span><br><span style=
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
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1997 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></=
html>
--Xewt2kpNqX4=--


--===============0732215962200458619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0732215962200458619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0732215962200458619==--

