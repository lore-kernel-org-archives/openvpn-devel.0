Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C52C61DBD
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0/3ftMVLDFYFTcqbbzTpLr7u0nqXifKta0llyYUmeJQ=; b=Eci1xoC7CvD2MFtPsQP05Bvwgi
	Mo9p56Sq8aou16FNdMJfURNfGbVqiCTOukzgYdan3IKvBpXuXMiRP6XHpAYNxMXoVED1yJCZr0970
	siK1xytCRv+zIlj4iopeePbhIvw308/nn9R1hEZabWuIZ2gXsv6jKN4qTsdwiKrWZ9GY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyzvw-0004Qs-3y;
	Tue, 25 Aug 2026 22:47:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyzvv-0004Qm-0W
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 22:47:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hbicvPQm1u3ybw3S2n/J/1346J28RN9rt9nTg0Lmpd4=; b=VewRoRYNvfG6sAr2dzyQ8GZ23b
 iPMz8CfQ6EmFvdXdBc0iNF99jRnjWuh3suUMND0lp06qgOCc/pXvECdf+8mpb2X3YlmShu0rxHc50
 /u9wpAu44UsgzBif8oXn/HPjQsueHYiYXWy/jPteAM+HJjtuNv1fOZgS6yytiHCKsdEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hbicvPQm1u3ybw3S2n/J/1346J28RN9rt9nTg0Lmpd4=; b=W
 Al3EdSlHI6ltH5iIZHs5wW8As8iNMT52uVmAY5C0J2QEribcUAdyHSA9bpIK4ySl0NBPozIOue0yB
 Y8VmKyNB18pzxiNVkZ+W119AFQYqWBQYx+arS5o/WH+aZKcSKHY4HCwMNne4hN1zQMBvPmIROxHH5
 C2AL5sfAZ1syWzkE=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyzvq-0004v9-Tp for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 22:47:52 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c1677c91969so25843066b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787698064; x=1788302864; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hbicvPQm1u3ybw3S2n/J/1346J28RN9rt9nTg0Lmpd4=;
 b=SrOulMqyJm9gL+xocM/8tXBROH60VYytLCbNf1M475HlAybQCMK7v3/R+GSinqdFHI
 VYRS1ddM7UhN+5Hb1HF0XxWssEIuY68nEa7gi22klMTs9CdfJHEhVcCUCftGfT3g/mf9
 s/dG0u6RuHd/fHU9RgNIs6kVQb5t1wSTCpHax0U6Ni+L8IZWqAYRYaS066TUwj3nzMUG
 SGwAsjOV8ejY/amGILUkhwx9QB0hsm8EjDihpmihVyKeyeecrKjYQBRiXPZJUpuDB/is
 txOlerifHzjipsMEHHM8mNBfj152ld6RzPxfvNFh6ak+q+9KU6PngOlpIeBytuA8DUnY
 5Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698064; x=1788302864;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hbicvPQm1u3ybw3S2n/J/1346J28RN9rt9nTg0Lmpd4=;
 b=nsM51sWfV6hHeFj/EcRXBB1jkWwCsKksW1XCHJK8UAMIs0uHibFcV9kWAbr/FGS9Ic
 /wg0HNtVEFnxtM0gSuKQOo2xKxK8648TYfFlR+vR/xR+EWZr09Qp7APvjVbCs8AiRf97
 CiUClkKqiq+ryLr/jNSnpUi/sP7ZO7Q31On3I1c5g83nDzOgDSyLA3SFhABS6TBKdNa8
 iDmMOlvzqp7NP57NmwyXaQGyI7fkPGhFxGFKhAunUGDCO67rCfmhIek3jhN0qGEsUqAq
 NZxhL3mBsbe1vj6lUMw4UubEmNdnnSo4jI7hcdZpyM20iCFEyGPJaoE3jCDdBbfg//oG
 jzTg==
X-Gm-Message-State: AFuF++mz980qxWROZdt6LW4L5DIbw8/X0+II4uYTJ8q38ZpF1DPm0MRI
 1wUmuuCT35PZPFgEB25jJtr2yqmPlzehp0tgzOMLu2THjfHK0qiRx/40VOWllbYzaXEszOnFu6A
 UFtVZc4QpJxJVvT7P1jbfdHk6PasXePgD5UjyhrF7l6hrZO03QtxfvIDUKtvaOx7Gd+FB15/zLh
 izc0i3ww==
X-Gm-Gg: AR+sD118LQyyCENQ1gKNecaR/WXIxBlJXf9dZ7jqy2kQNH+GsxSeffgt1ucWdYvSytj
 kU0EStKMsw6yCXqTdNQbKkzUGxuzwWIcGCfL2DIqiNy88+xyc4j1+iVQeDdCKX4ABEtucc0lYCE
 oHwmEfEvbScPELN2CTcAUY8Jc8roFo8QufDC/FcS/2vKYNqmc7vWavBQuitghjkYbCVBldy+IEt
 QrB+68bfLRCjY0mxWcWM8uqTJ/glEwc0XYxfKhbrdYl900r+IJ89do6mZlbVdBkjY+4IcxLnpo4
 Djd7gaOtRXs4Gha6zV5yv4NgbbyALwT4ywI2+D7x3knLbpjxPrHPHpmGo23lxWrag2rTgwG94P7
 2RGzp0XJBVofKREHCfHGyOwhRJ7QHksOc6QezeHEcjqjqK6VqApR3VWUT8+Fw4deh/S+tlhoSbf
 40gqkttbWha0mgubTsXqsz0EDzOMqBnEjPx4vvsRG+0vd/eFTnqG57+/5OEbA4902bPTgI6Pz3w
 3tQWgrGVpsCWLaCw4EHWsGPqHY/7PfvCmKOn/1uqw2TSfPBGS5DuPSAwtf1NutwkFyjn+3yivnT
 q+FIKNbZKAuNvjrXJ6KdNQt5WLye7COm23yX7u978fScm1tioJY=
X-Received: by 2002:a17:907:1807:b0:c1c:5aa1:de57 with SMTP id
 a640c23a62f3a-c250c307d84mr282874566b.13.1787698064104; 
 Tue, 25 Aug 2026 15:47:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fda4fsm189218666b.16.2026.08.25.15.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:47:43 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 22:47:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08cb2cfb4ab730666449ca39581a1abf4224d568
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d2e530907a60855a2226b8659b89908d1c401cb8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyzvq-0004v9-Tp
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
Content-Type: multipart/mixed; boundary="===============5822872281154959075=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5822872281154959075==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SejLzzprVFg="; charset=UTF-8

--SejLzzprVFg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#5)=2E ( http://gerrit=2Eopenvpn=2E=
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
3 files changed, 151 insertions(=
+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/55/1855/5

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/bu=
ffer=2Ec
index 046e231=2E=2E5bf1de8 100644
--- a/src/openvpn/buffer=2Ec
+++=
 b/src/openvpn/buffer=2Ec
@@ -1384,3 +1384,57 @@
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
+    /* Use an int64 here as ot=
herwise we easily trigger ASAN integer
+     * overflow warnings */
+    in=
t64_t tmp =3D 0;
+    while (buf_len(buf))
+    {
+        uint8_t c =3D *B=
PTR(buf);
+        if (c >=3D '0' && c <=3D '9')
+        {
+            tm=
p =3D tmp * 10;
+            /* lower nibble of ascii digits is their value=
 */
+            tmp +=3D (c & 0x0f);
+            buf_advance(buf, 1);
+  =
          ret =3D true;
+            if (tmp > INT_MAX)
+            {
+   =
             /* integer overflow */
+                return false;
+       =
     }
+        }
+        else
+        {
+            *result =3D (int)tm=
p;
+            return ret;
+        }
+    }
+    *result =3D (int)tmp;
+ =
   return ret;
+}
+
+char *
+extract_field(struct buffer *buf, char sep, st=
ruct gc_arena *gc)
+{
+    const uint8_t *seppos =3D memchr(BPTR(buf), sep,=
 buf_len(buf));
+    if (!seppos)
+    {
+        return NULL;
+    }
+    =
size_t field_len =3D seppos - BPTR(buf);
+
+    char *field =3D gc_malloc(f=
ield_len + 1, false, gc);
+
+    strncpy(field, BSTR(buf), field_len);
+   =
 field[field_len] =3D 0;
+
+    buf_advance(buf, (int)field_len + 1);
+    =
return field;
+}
\ No newline at end of file
diff --git a/src/openvpn/buffe=
r=2Eh b/src/openvpn/buffer=2Eh
index bc5cffb=2E=2E871332d 100644
--- a/src/=
openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -2243,4 +2243,26 @@
 /**=
@}*/
 /* End of Buffer Lists */
 
+/**
+ * will read a decimal integer from=
 a buffer until the next non-decimal
+ * character=2E If successful the met=
hod will return true and the integer
+ * in \c result=2E The buffer will be=
 advanced to the next character after
+ * the integer=2E  This function als=
o ensures to not advance beyond the end
+ * of the buffer=2E
+ *
+ * If the=
 result is larger than INT_MAX or the integer cannot be parsed the
+ * func=
tion returns false
+ */
+bool
+buffer_read_int(struct buffer *buf, int *res=
ult);
+
+/**
+ * Extract a field from buf that end with the \c sep characte=
r=2E The
+ * returned string is allocated in the gc_arena=2E If the seperat=
or character
+ * is not found, the function returns the nullptr=2E
+ *
+ * =
The buffer is also forward to the point after the seperator character=2E
+ =
*/
+char *
+extract_field(struct buffer *buf, char sep, struct gc_arena *gc=
);
 #endif /* BUFFER_H */
diff --git a/tests/unit_tests/openvpn/test_buffer=
=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index ce38bbe=2E=2E190807a =
100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_test=
s/openvpn/test_buffer=2Ec
@@ -456,6 +456,78 @@
     /* Check that our own m=
ethod agrees */
     assert_true(string_check_buf(&buf2, CC_PRINT | CC_NULL=
, CC_CRLF));
     assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+  =
  gc_free(&gc);
+}
+
+static void
+test_buffer_read_int(void **state)
+{
+ =
   struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc=
(1000, &gc);
+
+    buf_printf(&buf, "72732,1234");
+
+    int tmp =3D -1;
=
+    assert_true(buffer_read_int(&buf, &tmp));
+    assert_int_equal(tmp, 7=
2732);
+    assert_int_equal(*BPTR(&buf), ',');
+
+    buf_advance(&buf, 1)=
;
+
+    assert_true(buffer_read_int(&buf, &tmp));
+    assert_int_equal(tm=
p, 1234);
+    assert_int_equal(buf_len(&buf), 0);
+
+    buf =3D alloc_buf=
_gc(1000, &gc);
+    buf_printf(&buf, "fo42,7777");
+
+    assert_false(buf=
fer_read_int(&buf, &tmp));
+
+    /* empty buffer */
+    buf =3D alloc_buf=
_gc(1000, &gc);
+    assert_false(buffer_read_int(&buf, &tmp));
+
+    /* i=
nteger overflow */
+    uint64_t int_max_plus_one =3D INT_MAX + 1ull;
+    =
buf =3D alloc_buf_gc(1000, &gc);
+    buf_printf(&buf, "%" PRIu64, int_max_=
plus_one);
+    assert_false(buffer_read_int(&buf, &tmp));
+
+    /* INT MA=
X  */
+    buf =3D alloc_buf_gc(1000, &gc);
+    buf_printf(&buf, "%d", INT=
_MAX);
+    assert_true(buffer_read_int(&buf, &tmp));
+    assert_int_equal=
(tmp, INT_MAX);
+
+    gc_free(&gc);
+}
+
+static void
+test_buffer_extract=
_field(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct b=
uffer buf =3D alloc_buf_gc(1000, &gc);
+    assert_null(extract_field(&buf,=
 ',', &gc));
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "123=
45", 5);
+    const char *ret =3D extract_field(&buf, '5', &gc);
+    asser=
t_string_equal(ret, "1234");
+    /* nothing left after the 5 */
+    asser=
t_int_equal(buf_len(&buf), 0);
+
+    buf =3D alloc_buf_gc(5, &gc);
+    bu=
f_write(&buf, "12345", 5);
+    ret =3D extract_field(&buf, '4', &gc);
+   =
 assert_string_equal(ret, "123");
+
+    /* 5 should be left */
+    assert=
_int_equal(buf_len(&buf), 1);
+    assert_memory_equal(buf_bptr(&buf), "5",=
 1);
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);=

+    assert_null(extract_field(&buf, '6', &gc));
 
     gc_free(&gc);
 }
@=
@ -567,7 +639,9 @@
         cmocka_unit_test(test_checked_snprintf),
      =
   cmocka_unit_test(test_buffer_chomp),
         cmocka_unit_test(test_buff=
er_null_terminate),
-        cmocka_unit_test(test_buffer_parse)
+        c=
mocka_unit_test(test_buffer_parse),
+        cmocka_unit_test(test_buffer_r=
ead_int),
+        cmocka_unit_test(test_buffer_extract_field)
     };
 
  =
   return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df6=
7570ab5628bfcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet: 5
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--SejLzzprVFg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Add helper method to read an integer from a buffer<br><br>Change-=
Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea<br>Signed-off-by: Arne Schwab=
e &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/op=
envpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>3 files c=
hanged, 151 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1855/5</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><sp=
an>index 046e231=2E=2E5bf1de8 100644</span><br><span>--- a/src/openvpn/buff=
er=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -138=
4,3 +1384,57 @@</span><br><span>     fclose(fp);</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+buffer_read_int(struct buffe=
r *buf, int *result)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *result =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Use an int64 here as other=
wise we easily trigger ASAN integer</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * overflow warnings */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int64_t tmp =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    while (buf_len(buf))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        uint8_t c =3D *BPTR(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c &gt;=3D &#39;0&#39; &amp;&a=
mp; c &lt;=3D &#39;9&#39;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         tmp =3D tmp * 10;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            /* lower nibble of ascii digits is their value */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            tmp +=3D (c &a=
mp; 0x0f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   buf_advance(buf, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            ret =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (tmp &gt; INT_MAX)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                /* integer overflow */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            *result =3D (int)tmp;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    *result =3D (int)tmp;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+extract_field(struct buffer *buf, char=
 sep, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!seppos)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    size_t field_len =3D seppos - BPTR(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *field =3D gc_malloc(field_len + 1, false, gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    strncpy(field, BSTR(buf), field_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    field[field_len=
] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, (int)fiel=
d_len + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn field;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span>\ No newline at end of file</span><br><span>diff --git a/src/openvp=
n/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index bc5cffb=2E=2E87=
1332d 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+=
++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -2243,4 +2243,26 @@</span><b=
r><span> /**@}*/</span><br><span> /* End of Buffer Lists */</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * will read a decimal integer fr=
om a buffer until the next non-decimal</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * character=2E If successful the method will return tru=
e and the integer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 in \c result=2E The buffer will be advanced to the next character after</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the integer=2E  Thi=
s function also ensures to not advance beyond the end</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * of the buffer=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * If the result is larger than INT_MAX or the integer can=
not be parsed the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 function returns false</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+buffer_read_int(struct buff=
er *buf, int *result);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Extract a field from buf that=
 end with the \c sep character=2E The</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * returned string is allocated in the gc_arena=2E If the=
 seperator character</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * is not found, the function returns the nullptr=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * The buffer is also forward to the point after the seper=
ator character=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+extract_field(struct buffer *bu=
f, char sep, struct gc_arena *gc);</span><br><span> #endif /* BUFFER_H */</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/test=
s/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index ce38bbe=2E=2E190=
807a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><s=
pan>@@ -456,6 +456,78 @@</span><br><span>     /* Check that our own method =
agrees */</span><br><span>     assert_true(string_check_buf(&amp;buf2, CC_P=
RINT | CC_NULL, CC_CRLF));</span><br><span>     assert_string_equal(BSTR(&a=
mp;buf2), &quot;CR_RESPONSE,MTIx&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_buffer_read_int(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(1000, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf_printf(&amp;buf, &quot;72732,1234&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int tmp =3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(buffer_read_int(&amp;buf, &amp;tmp));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(tmp, 72732);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(*BPTR(&amp;buf), &#39;,&#39;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_advance(&amp;buf, 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(buffer_read_int(&amp;buf, &amp;tmp));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(tmp, 1234);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len=
(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_g=
c(1000, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_printf(&amp;buf, &quot;fo42,7777&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(buffer_read_int(&amp;buf, &amp;tmp));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* empty buffer */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(1000, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(buffer_rea=
d_int(&amp;buf, &amp;tmp));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* inte=
ger overflow */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint64_t int_max_plus_one =3D INT_MAX + 1ull;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(1000, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &qu=
ot;%&quot; PRIu64, int_max_plus_one);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(buffer_read_int(&amp;buf, &amp;tmp));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* INT MAX  */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(1000, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;=
buf, &quot;%d&quot;, INT_MAX);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(buffer_read_int(&amp;buf, &amp;tmp));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(tmp, INT_=
MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_buffer_extract_field(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1000, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(extrac=
t_field(&amp;buf, &#39;,&#39;, &amp;gc));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ret =3D ext=
ract_field(&amp;buf, &#39;5&#39;, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(ret, &quot;1234&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* nothing left aft=
er the 5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(buf_len(&amp;buf), 0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D extract_field(&amp;bu=
f, &#39;4&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(ret, &quot;123&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* 5 should be left */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;buf), 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(buf_b=
ptr(&amp;buf), &quot;5&quot;, 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;, 5);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_null(extract_field(&amp;=
buf, &#39;6&#39;, &amp;gc));</span><br><span> </span><br><span>     gc_free=
(&amp;gc);</span><br><span> }</span><br><span>@@ -567,7 +639,9 @@</span><br=
><span>         cmocka_unit_test(test_checked_snprintf),</span><br><span>  =
       cmocka_unit_test(test_buffer_chomp),</span><br><span>         cmocka=
_unit_test(test_buffer_null_terminate),</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        cmocka_unit_test(test_buffer_parse)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_buf=
fer_parse),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_buffer_read_int),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        cmocka_unit_test(test_buffer_extract_field)</sp=
an><br><span>     };</span><br><span> </span><br><span>     return cmocka_r=
un_group_tests_name(&quot;buffer&quot;, tests, NULL, NULL);</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1855?usp=3Demail">change 1855</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5=
628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1855 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"=
display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--SejLzzprVFg=--


--===============5822872281154959075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5822872281154959075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5822872281154959075==--

