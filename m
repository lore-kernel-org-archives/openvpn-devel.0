Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326BAC5DF93
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WOPKnObaoN2YOVvOctEQWvyWzEcZwPIsp+b3oNE9My8=; b=EM9Z0V+MfoLyZk
	zwPLuML/3nwBl2Tsavq1czgAr568NcqhCNahGbk3bBmD2k4zVj4SDO0DMEVXWa3QLLim4cgr2+TMD
	kGk0HT635eFb4JdRR8DHdLsL6LlN+BI8iq/9z/mvBaRPJG5tkEXNm45bwz7zasxFHoMf3oo1g5d7M
	53A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRUn-0003wY-2q;
	Fri, 21 Aug 2026 15:49:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRUl-0003wM-EX
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x8wKLmax2q2svknHpzb2dLqMnHC9oCmVlMQDXc8Jq60=; b=jWE/UVJtPkV3cu+xa/fSpnmeNM
 PPP8W2uZozsyPF8EwOt2M+ajrgi/6eh+5mr6S7OvHhCC4yPndzY311EwncB4xh5JctBQcwnDSVO77
 vlN9O5As5uPwHMuQDAVDehLpC06PX4DA6GhCZJDHFn6STfUGuEwMJm1fWPbkKl+495yY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=x8wKLmax2q2svknHpzb2dLqMnHC9oCmVlMQDXc8Jq60=; b=d
 EcE3jgeHybwT0HF5mSM4UJpY62FIIlLpZ8roKRnxNoYL93RAew4vCzj1xYAnpfj1iNBtNBAu4aNaa
 WKsASUb2DZf4Slx/x+BTfjD7mFonh2pxflUo8okYbAj5n+EF+Mf9zhhsvTceUkg6ufcwKqQu7PNmN
 NlF7dZItY1qKcoFc=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUl-000596-3W for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:28 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c15b1da6b82so130429366b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327360; x=1787932160; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x8wKLmax2q2svknHpzb2dLqMnHC9oCmVlMQDXc8Jq60=;
 b=bZNrep4P2KgOBr+UFtybqUvXkJCwIlt2tqPhN/YjmGN2vsLkw0JDw0RqKRbUmEXmob
 Z3kRdldIYNDkKV1MwwkGRLN5oevmhGO2b5KKnTp4LuCrXyequITPneW5JKXzRaQaZS8Y
 jE+pPLQtVsbPmhj2epSKz1DUc7swZHSguCb8e+iIOCo8ciR9U9HUApNslTzVsP72YL9i
 PKFYtx4qFICMdFfVYjRBRBMMOXmVf5Ygq9LMVVQ5Bay8yNilykslDsipfJXvdTgeKy6i
 Sp926Foz9Rr0v7sg2srNxDe/PtvbpzDASlFYuisKiYBdT23mqYJtsxLes8bkPV08Tz+K
 b+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327360; x=1787932160;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x8wKLmax2q2svknHpzb2dLqMnHC9oCmVlMQDXc8Jq60=;
 b=bKbqwCAbAIgPP8t1wV5Dqd+eRabbs87V3mGMmS61O1AJRfY+SkdvJnmFImgUeutSRd
 pKYCAAmm0Pko7sDFpr2RmM86ClwNlt+/WvbRrweLIRJ1rh0awzrvlWiNEb1ZXWrD9JnV
 5K6kCKRxGYm+N//CCFsM1scki4a3n0B8Fizc7xtf3wmwGfhKb8p2zPMoM+xr6uXy+uPb
 apgMRFhHkWy9CkyW4TaXuqtJwWdNJ5jMBOVX6p/Tl8cuPOVSo66IJfliR9na3rJZWbDo
 fU2z6os2dcINO9UEJBHhDFiZyrKFHce+K0eftMFNAm1eXHMTRmaZBh8rYZvnu/LS6/Ba
 zfuQ==
X-Gm-Message-State: AFuF++nz4Bb+Tf5gtik6PJS3zYNjgRfB/sfFqTbZDqb8jbBHbvwxSCO6
 D0HBLg6EnECa1cWcYT1iy0t0UXb1+uNThjGrmF/5SJ+ELO8sN0vketl5GMllSrYBTkJyd3OzwQA
 pKZnYyXB1bsGbU5aRprOOodDquD+75wo03jeQZMphk0Ug6w5VRQh/JaU19EcJzeObaucu4wWP1Q
 nBgoyMGw==
X-Gm-Gg: AR+sD139ZVamsRvvQAJgczZpXT/6zZML7NKOYUX3WSnvLYKvuCtNzDHmah0OLojyUn+
 E+WhEp2PkVEOSD1v6w7fdT2JjB+JTAjj1p5HAgkO/Ed6bzJtJWyyH0XBmPuoo590LTcVETradNt
 zPQ/XI5AmSX0oa250WwkishkUKCapkmRTd55OcM0dLOd2Ehz1S5hLfawa6TxjOE/rYm+GPV2AV0
 YNXbHQ8tenogwiO8sjUMG5C+vwFLho4i3uURsOgNYMnOm+Qihn+jPAIt2kikH9HkmQuhseNnmXO
 AS37SiBVaUWtr+9WiXkkbnsyg3fuR/OrsSdMbcQbZZ0eogwu+LzTTKL2eVC+5yLpRGL1aMFQC9M
 Fo0vGwxiY+7ocA9yqgouLSVb3iKtCosh7PsCjWqMA4tDdmRpx6S76obsO9+a6Wu7pjIloBmQRBh
 F6a2PF+Va9/ZcpAbLrfFEsls4W38uz2ZYP6k+DjIwOJYWlbmkUg206tRjn9TJ7P7lK6x9S6zamN
 X/iRCrNB2xJPRraN+v/kPTC0r87JTzjxSpoosnMB8vxMDFK10ZID3jMREFrpx4L2wVMGfJUXIu8
 ngYKPINvSuINrs/GQx7QDhQ0xVAo1IT/QaPCWCse1BZDsfxki/w=
X-Received: by 2002:a17:907:3c83:b0:c21:7584:fc58 with SMTP id
 a640c23a62f3a-c246a60cd41mr759103066b.12.1787327360322; 
 Fri, 21 Aug 2026 08:49:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b0933csm553368566b.18.2026.08.21.08.49.19
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:19 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:19 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 8bca2970f7a913787d554ecf2ed9036a8de39d4a
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6274346bb49accf6a6f8b2a9fb9a0a85582457e9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUl-000596-3W
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
Content-Type: multipart/mixed; boundary="===============3182662372774027294=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3182662372774027294==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="axNLA+HIyl4="; charset=UTF-8

--axNLA+HIyl4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1855?usp=3Demail )


Change subject: Add helper method t=
o read an integer from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Add helper method to read an integer from a buffer

Cha=
nge-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Signed-off-by: Arne Schwa=
be <arne@rfc2549=2Eorg>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=
=2Eh
M tests/unit_tests/openvpn/test_buffer=2Ec
3 files changed, 126 insert=
ions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/55/1855/1

diff --git a/src/openvpn/buffer=2Ec b/src/open=
vpn/buffer=2Ec
index f14caa2=2E=2Edee0906 100644
--- a/src/openvpn/buffer=
=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -1352,3 +1352,47 @@
     fclose(fp);
 =
    return ret;
 }
+
+bool
+buffer_read_int(struct buffer *buf, int *result=
)
+{
+    *result =3D 0;
+    bool ret =3D false;
+
+    while (buf_len(buf=
))
+    {
+        uint8_t c =3D *BPTR(buf);
+        if (c >=3D '0' && c <=
=3D '9')
+        {
+            *result =3D *result * 10;
+            /* =
lower nibble of ascii digits is their value */
+            *result +=3D (c=
 & 0x0f);
+            buf_advance(buf, 1);
+            ret =3D true;
+   =
     }
+        else
+        {
+            return ret;
+        }
+    }
=
+    return ret;
+}
+
+char *
+extract_field(struct buffer *buf, char sep, =
struct gc_arena *gc)
+{
+    const uint8_t *seppos =3D memchr(BPTR(buf), se=
p, buf_len(buf));
+    if (!seppos)
+    {
+        return NULL;
+    }
+  =
  size_t field_len =3D seppos - BPTR(buf);
+
+    char *field =3D gc_malloc=
(field_len + 1, false, gc);
+
+    strncpy(field, BSTR(buf), field_len);
+ =
   field[field_len] =3D 0;
+
+    buf_advance(buf, (int)field_len + 1);
+  =
  return field;
+}
\ No newline at end of file
diff --git a/src/openvpn/buf=
fer=2Eh b/src/openvpn/buffer=2Eh
index 85277ff=2E=2Ec3202fa 100644
--- a/sr=
c/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -2240,4 +2240,23 @@
 /=
**@}*/
 /* End of Buffer Lists */
 
+/**
+ * will read a decimal integer fr=
om a buffer until the next non-decimal
+ * character=2E If successful the m=
ethod will return true and the integer
+ * in \c result=2E The buffer will =
be advanced to the next character after
+ * the integer=2E  This function a=
lso ensures to not advance beyond the end
+ * of the buffer=2E
+ */
+bool
+=
buffer_read_int(struct buffer *buf, int *result);
+
+/**
+ * Extract a fiel=
d from buf that end with the \c sep character=2E The
+ * returned string is=
 allocated in the gc_arena=2E If the seperator character
+ * is not found, =
the function returns the nullptr=2E
+ *
+ * The buffer is also forward to t=
he point after the seperator character=2E
+ */
+char *
+extract_field(struc=
t buffer *buf, char sep, struct gc_arena *gc);
 #endif /* BUFFER_H */
diff =
--git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn=
/test_buffer=2Ec
index 326de40=2E=2E3575357 100644
--- a/tests/unit_tests/o=
penvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -4=
56,6 +456,66 @@
     /* Check that our own method agrees */
     assert_tru=
e(string_check_buf(&buf2, CC_PRINT | CC_NULL, CC_CRLF));
     assert_string=
_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+    gc_free(&gc);
+}
+
+static vo=
id
+test_buffer_read_int(void **state)
+{
+    struct gc_arena gc =3D gc_ne=
w();
+    struct buffer buf =3D alloc_buf_gc(1000, &gc);
+
+    buf_printf(=
&buf, "72732,1234");
+
+    int tmp =3D -1;
+    assert_true(buffer_read_in=
t(&buf, &tmp));
+    assert_int_equal(tmp, 72732);
+    assert_int_equal(*B=
PTR(&buf), ',');
+
+    buf_advance(&buf, 1);
+
+    assert_true(buffer_rea=
d_int(&buf, &tmp));
+    assert_int_equal(tmp, 1234);
+    assert_int_equal=
(buf_len(&buf), 0);
+
+    buf =3D alloc_buf_gc(1000, &gc);
+    buf_printf=
(&buf, "fo42,7777");
+
+    assert_false(buffer_read_int(&buf, &tmp));
+
+ =
   /* empty buffer */
+    buf =3D alloc_buf_gc(1000, &gc);
+    assert_fal=
se(buffer_read_int(&buf, &tmp));
+
+    gc_free(&gc);
+}
+
+static void
+te=
st_buffer_extract_field(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(1000, &gc);
+    assert_null(ex=
tract_field(&buf, ',', &gc));
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf=
_write(&buf, "12345", 5);
+    const char *ret =3D extract_field(&buf, '5',=
 &gc);
+    assert_string_equal(ret, "1234");
+    /* nothing left after th=
e 5 */
+    assert_int_equal(buf_len(&buf), 0);
+
+    buf =3D alloc_buf_gc=
(5, &gc);
+    buf_write(&buf, "12345", 5);
+    ret =3D extract_field(&buf=
, '4', &gc);
+    assert_string_equal(ret, "123");
+
+    /* 5 should be le=
ft */
+    assert_int_equal(buf_len(&buf), 1);
+    assert_memory_equal(buf=
_bptr(&buf), "5", 1);
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&=
buf, "12345", 5);
+    assert_null(extract_field(&buf, '6', &gc));
 
     g=
c_free(&gc);
 }
@@ -567,7 +627,9 @@
         cmocka_unit_test(test_checked_=
snprintf),
         cmocka_unit_test(test_buffer_chomp),
         cmocka_un=
it_test(test_buffer_null_terminate),
-        cmocka_unit_test(test_buffer_=
parse)
+        cmocka_unit_test(test_buffer_parse),
+        cmocka_unit_t=
est(test_buffer_read_int),
+        cmocka_unit_test(test_buffer_extract_fi=
eld)
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NUL=
L, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
5?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchang=
e
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a=
3e60cdb11cc9df67570ab5628bfcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet=
: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--axNLA+HIyl4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add helper method to read an integer from a buffer<br><br>Change-I=
d: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea<br>Signed-off-by: Arne Schwabe=
 &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/ope=
nvpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>3 files ch=
anged, 126 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1855/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><spa=
n>index f14caa2=2E=2Edee0906 100644</span><br><span>--- a/src/openvpn/buffe=
r=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -1352=
,3 +1352,47 @@</span><br><span>     fclose(fp);</span><br><span>     return=
 ret;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+buffer_read_int(struct buffer=
 *buf, int *result)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *result =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    while (buf_len(buf))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
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
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return ret;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+extract_field(struct buffer *buf, char sep, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *seppos =3D memchr(B=
PTR(buf), sep, buf_len(buf));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!seppos)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t field_len=
 =3D seppos - BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *fiel=
d =3D gc_malloc(field_len + 1, false, gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    strncpy(field, BSTR(buf), field_len);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    field[field_len] =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_advance(buf, (int)field_len + 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return field;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of=
 file</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buf=
fer=2Eh</span><br><span>index 85277ff=2E=2Ec3202fa 100644</span><br><span>-=
-- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</s=
pan><br><span>@@ -2240,4 +2240,23 @@</span><br><span> /**@}*/</span><br><sp=
an> /* End of Buffer Lists */</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * will read a decimal integer from a buffer until the next non=
-decimal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * characte=
r=2E If successful the method will return true and the integer</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * in \c result=2E The buffer wi=
ll be advanced to the next character after</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * the integer=2E  This function also ensures to not=
 advance beyond the end</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * of the buffer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
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
s/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index 326de40=2E=2E357=
5357 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><s=
pan>@@ -456,6 +456,66 @@</span><br><span>     /* Check that our own method =
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
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_buffer_extract_field(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf=
_gc(1000, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_null(extract_field(&amp;buf, &#39;,&#39;, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, &quot;12=
345&quot;, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *ret =3D extract_field(&amp;buf, &#39;5&#39;, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(ret, =
&quot;1234&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* nothing left after the 5 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(buf_len(&amp;buf), 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, &quot;12345&qu=
ot;, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D=
 extract_field(&amp;buf, &#39;4&#39;, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(ret, &quot;123&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* 5 should be left */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&am=
p;buf), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_memory_equal(buf_bptr(&amp;buf), &quot;5&quot;, 1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, &quot;12345&quot;=
, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_nul=
l(extract_field(&amp;buf, &#39;6&#39;, &amp;gc));</span><br><span> </span><=
br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>@@ -567,=
7 +627,9 @@</span><br><span>         cmocka_unit_test(test_checked_snprintf=
),</span><br><span>         cmocka_unit_test(test_buffer_chomp),</span><br>=
<span>         cmocka_unit_test(test_buffer_null_terminate),</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_buffer=
_parse)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_buffer_parse),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_buffer_read_int),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_buff=
er_extract_field)</span><br><span>     };</span><br><span> </span><br><span=
>     return cmocka_run_group_tests_name(&quot;buffer&quot;, tests, NULL, N=
ULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60c=
db11cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--axNLA+HIyl4=--


--===============3182662372774027294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3182662372774027294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3182662372774027294==--

