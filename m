Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E030C61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NySKGHJwPE+EO1Pm/7ARoH8O42aAcx5Q26Ph1qXXI6s=; b=A2k8zSKwOwxczijcZZprp1YsMw
	WqPtMtGKKa2Rzlu9vGTb8vpYWLw5TTydE4r3Nkm4o5ZrRCU/In/iIhhJLekKhDPsqHGaon1Wtgkyr
	8cilFZiNfeNllKMF5RjD+orpM++k5yLxPyOobtgPY6+0xCIedmIbf4/p9w1fokd0bwG4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyuRd-0000qr-GF;
	Tue, 25 Aug 2026 16:56:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyuRb-0000qj-Dy
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:56:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uX6roPZb7N4YKXnAqSMafxB1ShqEdv1FWi/iiTCVstA=; b=Xv4XX8WwCDKf/6WMzFL0Vnhh4h
 rQgI9sBSSmaNUo3RV17r/m/cPz040LC8A6Zsby78qUycQUwqbXVQzcqddQ9PQzMBDkvwEWF2WAao6
 vieOayiv0uEJIgv8a/74z3gJSn0NtDL5AUuk0+0SI9Jsagc0Qpi+M1v+M9CAMsX1VdVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uX6roPZb7N4YKXnAqSMafxB1ShqEdv1FWi/iiTCVstA=; b=h
 VCB2oZLKzAzuK5mPQTS1Q3EcpmjJG9OtMa6D9gBAL6K5TDMRueZJdjen1objFH6xv+2ZKQclIP99M
 fXsEleXT63kHXg4mJ0/Xwej3unz9IpvKCdc5goaUEtteHq9DeU8otCwvPKYPFgBo1soDNqNzI/Nyw
 u9kSrNcX+96Eih/E=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyuRa-0004Nc-B7 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 16:56:16 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c20fb91ed0fso781401566b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787676968; x=1788281768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uX6roPZb7N4YKXnAqSMafxB1ShqEdv1FWi/iiTCVstA=;
 b=FDIJmLIEUP+htAuKbhkMlBJCTnqibC3tcjNZzqLSf1SMljDJkQZz8ctDc9Py1P5bws
 5JiHDecByur08dZ8ZmvMJ01uUuAnguxRwi1g1e1I2UnirIRcDYa8fvNWBFqRsgzJ56hf
 6Igo2EY54edj189HVJzhTYPGvRT9ylLbmWIOUpy7amu9bclA5gAudqwSYZpx19CfSPza
 0zvLc43xGsssQ1c45AvrfQrAVmYsjtmZeL7AN7TdlfDo51nkl533aP4KFMO7fYBbFKsE
 LpnFtAIvsXR1bKg10BGa5tQasPzvLI78GqW06ZLe4zZ1k2KWRHydVLT0lYCdXbGjd0ju
 rBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787676968; x=1788281768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uX6roPZb7N4YKXnAqSMafxB1ShqEdv1FWi/iiTCVstA=;
 b=jYU+r5Ea8kI3IZ138YsjOnfIFTi6nkLloK/Hqm8zBhZr88ANeJxFrkAEbDgZSBHiP4
 w7Z8JVvsV1lKd4CHAKphCKXK0oNHINY5qcVCzCDYaZoAwfait5k1wrr7qz3mK6eMtkhW
 GYN7hKRCY2coQlqPoKtjYnMBwMVxhxj/9tR3FghWRE0JHG4+mLws8LmUsccwCfCtgarm
 ugYDI/xF3gtTr66JWq/O2m/XGHh+54N+itS23CR1BCgI2XRFOZTL4O18qtKrEKq4Ch0D
 1v7/hgWCZWLIutU4QfVY+6/3+0212VJolZ4SlUUweFJhzhKBoA93D/QWFkouxV3uSm6C
 fKww==
X-Gm-Message-State: AFuF++mOAnFYoF05tFDlASuiQBfLXO/e+kRzQ0EmjVPUqDp4PFXQwhOQ
 3jUciSrhBlgFoZCmMyD7fooPnEX5qRskl0SG5z1MzBhXbLebTzPIn+DndOKn7nd6SBKqnSNyOIh
 kB4XqlhwL9ajM/4LaskgKW5FB4oXkXmZRL3fYc27JlRf5FaJ911IPOaNNCfIWb448y0gEvKoNIk
 LEXFLRLw==
X-Gm-Gg: AR+sD12yDnMjTWPEwdeH/lf5+lHC8F9Z40eJ1Atagmw5iSl7nRW3UdJRp0Mra53HPvJ
 c2q//Z2whZ/n2D25CwdB4ccNlH3PLTnlJVCdwr0g+xCoCCf37rajQvzqP0hoyGBOOzIWTcvClW1
 CtucW2pWUZoJgMYQhOj3K2C3Imwp/3oTkhV5Kdkazmn/3dj62dlBjDqnUFMQIqPG78vq7QKv/ki
 PfJQb7on5MmrCeYJrCW5WT2phQc0XQptqDjyC1gter8SnLhH5PzPK9EErDo7gdIXWINRX397Iuw
 Y6gy6FnhfNWyd+gwlJ8kw8OjYmpvjBJ7+GevNhM3qUOPR+L4zyX3P2gRo1Tn/n6HkWifWSHG0W7
 7v8MKPtJwtHVdOrHgSXvfIjLhnSoirowFYTHEZ8QN8PcmikTVESuFpXoZV5UIja9ckSHjIKOkYI
 nqL7Rl0irPHApqrGmw5cs73geXrN/BMrHoygIRuRdQEcw6XCS0mgqPFPUv9cIttseOsddfoVsMa
 XkrHkE7V+jR0BCQVeuF6QR9i4NzKHWl0YxEjV0630t6xhJ3OMbHhIubQ62CMwIGsJ/TybxhWfDH
 FjeTuGVV+NrfUI1ArWyk/r9lWMA6YonvjYzqaQMj9keiUcEH7b4=
X-Received: by 2002:a17:906:9fc4:b0:c16:101d:7afa with SMTP id
 a640c23a62f3a-c246a6266aemr3826176966b.16.1787676967448; 
 Tue, 25 Aug 2026 09:56:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ab82sm51576266b.31.2026.08.25.09.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 09:56:06 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 16:55:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 2a0b3d5a5c32a5b341c7cbc7c406336a0da15588
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2de0fe30f0d5aaf190dfe4eccc15165113393384-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyuRa-0004Nc-B7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 read an integer from a buffer
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6797640376102670420=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6797640376102670420==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zbRBXsFWgGw="; charset=UTF-8

--zbRBXsFWgGw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#4)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1855?usp=3Demail )


Change subject: Add helper method to r=
ead an integer from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Add helper method to read an integer from a buffer

Change=
-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Signed-off-by: Arne Schwabe =
<arne@rfc2549=2Eorg>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
=
M tests/unit_tests/openvpn/test_buffer=2Ec
3 files changed, 147 insertions(=
+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/55/1855/4

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/bu=
ffer=2Ec
index 046e231=2E=2Ed678f55 100644
--- a/src/openvpn/buffer=2Ec
+++=
 b/src/openvpn/buffer=2Ec
@@ -1384,3 +1384,53 @@
     fclose(fp);
     retu=
rn ret;
 }
+
+bool
+buffer_read_int(struct buffer *buf, int *result)
+{
+  =
  *result =3D 0;
+    bool ret =3D false;
+
+    while (buf_len(buf))
+    =
{
+        uint8_t c =3D *BPTR(buf);
+        if (c >=3D '0' && c <=3D '9')=

+        {
+            *result =3D *result * 10;
+            /* lower ni=
bble of ascii digits is their value */
+            *result +=3D (c & 0x0f)=
;
+            buf_advance(buf, 1);
+            ret =3D true;
+           =
 if (*result < 0)
+            {
+                /* integer overflow */
+ =
               *result =3D 0;
+                return false;
+            }=

+        }
+        else
+        {
+            return ret;
+        }
+ =
   }
+    return ret;
+}
+
+char *
+extract_field(struct buffer *buf, char =
sep, struct gc_arena *gc)
+{
+    const uint8_t *seppos =3D memchr(BPTR(buf=
), sep, buf_len(buf));
+    if (!seppos)
+    {
+        return NULL;
+    =
}
+    size_t field_len =3D seppos - BPTR(buf);
+
+    char *field =3D gc_m=
alloc(field_len + 1, false, gc);
+
+    strncpy(field, BSTR(buf), field_len=
);
+    field[field_len] =3D 0;
+
+    buf_advance(buf, (int)field_len + 1)=
;
+    return field;
+}
\ No newline at end of file
diff --git a/src/openvp=
n/buffer=2Eh b/src/openvpn/buffer=2Eh
index bc5cffb=2E=2E871332d 100644
---=
 a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -2243,4 +2243,26 =
@@
 /**@}*/
 /* End of Buffer Lists */
 
+/**
+ * will read a decimal integ=
er from a buffer until the next non-decimal
+ * character=2E If successful =
the method will return true and the integer
+ * in \c result=2E The buffer =
will be advanced to the next character after
+ * the integer=2E  This funct=
ion also ensures to not advance beyond the end
+ * of the buffer=2E
+ *
+ *=
 If the result is larger than INT_MAX or the integer cannot be parsed the
+=
 * function returns false
+ */
+bool
+buffer_read_int(struct buffer *buf, i=
nt *result);
+
+/**
+ * Extract a field from buf that end with the \c sep c=
haracter=2E The
+ * returned string is allocated in the gc_arena=2E If the =
seperator character
+ * is not found, the function returns the nullptr=2E
+=
 *
+ * The buffer is also forward to the point after the seperator characte=
r=2E
+ */
+char *
+extract_field(struct buffer *buf, char sep, struct gc_ar=
ena *gc);
 #endif /* BUFFER_H */
diff --git a/tests/unit_tests/openvpn/test=
_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index ce38bbe=2E=2E1=
90807a 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/un=
it_tests/openvpn/test_buffer=2Ec
@@ -456,6 +456,78 @@
     /* Check that ou=
r own method agrees */
     assert_true(string_check_buf(&buf2, CC_PRINT | =
CC_NULL, CC_CRLF));
     assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx=
");
+    gc_free(&gc);
+}
+
+static void
+test_buffer_read_int(void **state=
)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc=
_buf_gc(1000, &gc);
+
+    buf_printf(&buf, "72732,1234");
+
+    int tmp =
=3D -1;
+    assert_true(buffer_read_int(&buf, &tmp));
+    assert_int_equa=
l(tmp, 72732);
+    assert_int_equal(*BPTR(&buf), ',');
+
+    buf_advance(=
&buf, 1);
+
+    assert_true(buffer_read_int(&buf, &tmp));
+    assert_int_=
equal(tmp, 1234);
+    assert_int_equal(buf_len(&buf), 0);
+
+    buf =3D a=
lloc_buf_gc(1000, &gc);
+    buf_printf(&buf, "fo42,7777");
+
+    assert_f=
alse(buffer_read_int(&buf, &tmp));
+
+    /* empty buffer */
+    buf =3D a=
lloc_buf_gc(1000, &gc);
+    assert_false(buffer_read_int(&buf, &tmp));
+
+=
    /* integer overflow */
+    uint64_t int_max_plus_one =3D INT_MAX + 1ul=
l;
+    buf =3D alloc_buf_gc(1000, &gc);
+    buf_printf(&buf, "%" PRIu64, =
int_max_plus_one);
+    assert_false(buffer_read_int(&buf, &tmp));
+
+    /=
* INT MAX  */
+    buf =3D alloc_buf_gc(1000, &gc);
+    buf_printf(&buf, "=
%d", INT_MAX);
+    assert_true(buffer_read_int(&buf, &tmp));
+    assert_i=
nt_equal(tmp, INT_MAX);
+
+    gc_free(&gc);
+}
+
+static void
+test_buffer=
_extract_field(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    =
struct buffer buf =3D alloc_buf_gc(1000, &gc);
+    assert_null(extract_fie=
ld(&buf, ',', &gc));
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&b=
uf, "12345", 5);
+    const char *ret =3D extract_field(&buf, '5', &gc);
+ =
   assert_string_equal(ret, "1234");
+    /* nothing left after the 5 */
+ =
   assert_int_equal(buf_len(&buf), 0);
+
+    buf =3D alloc_buf_gc(5, &gc);=

+    buf_write(&buf, "12345", 5);
+    ret =3D extract_field(&buf, '4', &g=
c);
+    assert_string_equal(ret, "123");
+
+    /* 5 should be left */
+  =
  assert_int_equal(buf_len(&buf), 1);
+    assert_memory_equal(buf_bptr(&bu=
f), "5", 1);
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "123=
45", 5);
+    assert_null(extract_field(&buf, '6', &gc));
 
     gc_free(&g=
c);
 }
@@ -567,7 +639,9 @@
         cmocka_unit_test(test_checked_snprintf)=
,
         cmocka_unit_test(test_buffer_chomp),
         cmocka_unit_test(t=
est_buffer_null_terminate),
-        cmocka_unit_test(test_buffer_parse)
+ =
       cmocka_unit_test(test_buffer_parse),
+        cmocka_unit_test(test_=
buffer_read_int),
+        cmocka_unit_test(test_buffer_extract_field)
    =
 };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a3e60cd=
b11cc9df67570ab5628bfcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet: 4
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>

--zbRBXsFWgGw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add helper method to read an integer from a buffer<br><br>Change-=
Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea<br>Signed-off-by: Arne Schwab=
e &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/op=
envpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>3 files c=
hanged, 147 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1855/4</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><sp=
an>index 046e231=2E=2Ed678f55 100644</span><br><span>--- a/src/openvpn/buff=
er=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -138=
4,3 +1384,53 @@</span><br><span>     fclose(fp);</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+buffer_read_int(struct buffe=
r *buf, int *result)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *result =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    while (buf_len(buf))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uint8_t c =3D *BPTR(buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c &gt;=3D &#39;=
0&#39; &amp;&amp; c &lt;=3D &#39;9&#39;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            *result =3D *result * 10;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            /* lower nibble of ascii digits is=
 their value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        *result +=3D (c &amp; 0x0f);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            buf_advance(buf, 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            ret =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (*result &lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                /* integer overfl=
ow */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  *result =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return ret;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_field(struct buff=
er *buf, char sep, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!seppos)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t field_len =3D seppos - BPTR(buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *field =3D gc_malloc(field_len + 1, fal=
se, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    strncpy(field, BSTR(buf), =
field_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fiel=
d[field_len] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf=
, (int)field_len + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return field;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span>\ No newline at end of file</span><br><span>diff --git a=
/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index bc5c=
ffb=2E=2E871332d 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span>=
<br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -2243,4 +2243,26 =
@@</span><br><span> /**@}*/</span><br><span> /* End of Buffer Lists */</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * will read a decimal=
 integer from a buffer until the next non-decimal</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * character=2E If successful the method will=
 return true and the integer</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * in \c result=2E The buffer will be advanced to the next charact=
er after</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the inte=
ger=2E  This function also ensures to not advance beyond the end</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * of the buffer=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * If the result is larger than INT_MAX or the =
integer cannot be parsed the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * function returns false</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buffer_read_int(=
struct buffer *buf, int *result);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extract a field fr=
om buf that end with the \c sep character=2E The</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * returned string is allocated in the gc_aren=
a=2E If the seperator character</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * is not found, the function returns the nullptr=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * The buffer is also forward to the point afte=
r the seperator character=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_field(struct=
 buffer *buf, char sep, struct gc_arena *gc);</span><br><span> #endif /* BU=
FFER_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=
=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index ce38b=
be=2E=2E190807a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
buffer=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</=
span><br><span>@@ -456,6 +456,78 @@</span><br><span>     /* Check that our =
own method agrees */</span><br><span>     assert_true(string_check_buf(&amp=
;buf2, CC_PRINT | CC_NULL, CC_CRLF));</span><br><span>     assert_string_eq=
ual(BSTR(&amp;buf2), &quot;CR_RESPONSE,MTIx&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_buff=
er_read_int(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(1000, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;72732,1234&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int tmp =3D -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buffer_read_int(&amp;buf,=
 &amp;tmp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(tmp, 72732);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(*BPTR(&amp;buf), &#39;,&#39;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buf_advance(&amp;buf, 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(buffer_read_int(&amp;buf, &amp;tmp));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(tmp, 1234=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(buf_len(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D =
alloc_buf_gc(1000, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_printf(&amp;buf, &quot;fo42,7777&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(buffer_read_int(&amp;buf, &amp;tmp));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* empty buffer */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(1000, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(buffer_read_int(&amp;buf, &amp;tmp));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* integer overflow */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint64_t int_max_plus_one =3D INT_MAX + 1ull;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(1000, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&a=
mp;buf, &quot;%&quot; PRIu64, int_max_plus_one);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(buffer_read_int(&amp;buf, &am=
p;tmp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* INT MAX  */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(1000, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_pr=
intf(&amp;buf, &quot;%d&quot;, INT_MAX);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(buffer_read_int(&amp;buf, &amp;tmp));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(tmp, INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_buffer_extract_field(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1000, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_n=
ull(extract_field(&amp;buf, &#39;,&#39;, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;=
, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *ret =3D extract_field(&amp;buf, &#39;5&#39;, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(ret, &quot;123=
4&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* not=
hing left after the 5 */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(buf_len(&amp;buf), 0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D extract_=
field(&amp;buf, &#39;4&#39;, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(ret, &quot;123&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* 5 should be left */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;buf), 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory=
_equal(buf_bptr(&amp;buf), &quot;5&quot;, 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(extract=
_field(&amp;buf, &#39;6&#39;, &amp;gc));</span><br><span> </span><br><span>=
     gc_free(&amp;gc);</span><br><span> }</span><br><span>@@ -567,7 +639,9 =
@@</span><br><span>         cmocka_unit_test(test_checked_snprintf),</span>=
<br><span>         cmocka_unit_test(test_buffer_chomp),</span><br><span>   =
      cmocka_unit_test(test_buffer_null_terminate),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_buffer_parse)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(test_buffer_parse),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_buffer_read_int),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_buffer_extr=
act_field)</span><br><span>     };</span><br><span> </span><br><span>     r=
eturn cmocka_run_group_tests_name(&quot;buffer&quot;, tests, NULL, NULL);</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60cdb11=
cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--zbRBXsFWgGw=--


--===============6797640376102670420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6797640376102670420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6797640376102670420==--

