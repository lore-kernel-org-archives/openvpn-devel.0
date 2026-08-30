Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7758C61DE1
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bYcv//slyMn94DaTHsA9u1AANiHViWAwNl/YGZ74eU=; b=NQ8043iZ7xydGV9s1ZRKjrJMsf
	jOGEy37FaBURHMpExESaVVCgQC2CrpgaAVBZxJZ7HM+7B8BYqE2+GBDbYivE8tUIlUKMWkWGQlijJ
	y0ic35Lj0PCtcAkvqKIgpYuQcf/WzOvAmxWEY46mjT24k5QN+N3CGL1SEWcq7uAT3sj0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0ihF-0004WH-D5;
	Sun, 30 Aug 2026 16:47:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0ihD-0004W9-F2
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:47:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zCk+95fXWSNoIDYhYE68yCbEre3MMPH5M74k2BpIMl4=; b=KWsiIaufb07M+B6ph5lL5xvHP0
 UkV3+VHmBCcHjrdXFXg5LApfti3pBYMobWsK1GWk/t6gN7n6TOQCdDJWpCVGI8jOd9w2D78Vgpy+Y
 ou2wC2jn9fpGyKwb2R4cwPfPIdz7+/hDH9tT35+W2rSGtChXG1S5EVxSXmbu50RMEfhk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zCk+95fXWSNoIDYhYE68yCbEre3MMPH5M74k2BpIMl4=; b=g
 47u9rlChbLLuabsZUQIiDVkPQ3IytGQ8aS8Zu9bFjQx4kxZH473cnWerziVZU5CH4KR1ejkoDAEqK
 FJx/yhELQg0mnkzuUROqurrKvG1PJMWMfkwQKgiYzjduE0woNrDAGGQFQ0CrnldxQD1ksxeJ02Ntk
 isgOUGAU3EbSFnZU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0ihC-0003IK-GG for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:47:51 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-480001972b8so1289199f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788108464; x=1788713264; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zCk+95fXWSNoIDYhYE68yCbEre3MMPH5M74k2BpIMl4=;
 b=FYm5cAe65aB/kAFeQT2PVavuIAbd9SBVFj50nLNI/pSrsyMih2PPncgAPX+AQVf5IJ
 MmEKB99CAK5uuOULhUioPQamhDuBabQ94iZUgMTSIhI695+TdsoigT7hc84qetG0h+yN
 V0srlY9q2bsoxlHOp58GEEkcFuYIR0yGQfspE+iAPlI76eEVLOE971NLB0R/W9MsMxYy
 BbbZS3r5//I3rzVwYv8lmyxUj7qjsGFbbnRx8BU056B8HGxQfmBW6IsfqW1GMQbjbsj6
 yvZaVFtZMl9faXg2kJrW8I3f4KHP7pmwIdIXLTt2577qRS2HgKOgZM0r5Jw7oaGgCHUV
 Tftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788108464; x=1788713264;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zCk+95fXWSNoIDYhYE68yCbEre3MMPH5M74k2BpIMl4=;
 b=rd0e0nEpuXwIo8lBO3E8eeNWhF7yw27gVKPc56aHIRm5Mt5z5JKkkDzHUeCaDs3ZXH
 Q9qcKBrGP1e36VucyaSIs8lykboYSoOlhSCMeuVAz575GS/lWWU+de9ScIa5ytpZ97ey
 IzBwqj7siT1t+SR2rHPkw581ibKDh7u6Gzi7+wlFUJaWCSm+I/jrdUAkSs42z24woRNu
 gFcY31NrG9PJ76PUNi4ZHh/S9NTAH3mXxr94Rc3cio/3p75vnf0Org3wkaTdbx/MfNYA
 Y+8NipVHnBR3c3eNb6RWaCgSAgGrRazPAL9aaafcdXHo9g+seAtZlMQpHkWAjlAtQ2hM
 ez8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJwKCciFwQ5Ai8DIt4D2UwHFp9Eo5Vjx03YmlI7oUvnea8QznN2IZljFoLaEci/DhKPA7qNSGq+B2FVzYY@lists.sourceforge.net
X-Gm-Message-State: AFuF++kLsf5hifQihd+A8s7rf9/qSwpQx3wAaAaZrMbVDZQVOQXuiSdt
 LnKb0ghvAKBMpa1fm2fCyEIOSI9njNYIjzyhJNdREiQ7fulekOSq5hyI6NjacThTowvTPen9fBB
 W+1MEw4m7rhq2bYAJoWmKR+1xhFRfR2IQXcAGhLTO2iCni/YIQ/B3tBg0TNIZz7XO0NGB
X-Gm-Gg: AYBFou240PGxp6oTcIyrR1H1/ZuHiuQZl/VpqmewvUIZ+ygfYBvGNr1yd8cboJtMk/M
 ise51bRTeceGeoRl8QrCNqWE09brfaioa4X44HFiJLLHurZvDf50Y5WvFKtKVH+Yw0/PRLnOnS6
 Fvnn8wVjlIG/RnE7tlYgNF5OxchiCFzdqSuAWgXLyaBpCQ5qfQRenyag2Q18WmVVLDzwIfbwYKb
 BZkYsSsIVcOq7jFwGlg6NH0gDYzCjc7uv99mwldrBW2E5kiwOG4Z9uM8nuwaClGcAz6xHjsyH2Y
 aP7Ba32tn198JpRU/wDrwgd1LYsw5fmWVwOcW5ow7AXQEUZP0SYbFSicQIT5L5lmyI5o+FUa8gt
 ynzEFox/CN9i4ZJNecQERhof78HcWTNTImiRUD/Fe9U1+JeIt39CsRZe8+1MzytQntUTY6FpgPl
 LcmLE1ebjcZKM64Z746T/DjIryY+vh5Rq15dlEJ90hRsvMxkUw3fERYEpn9XvCllsoX4Z4rWHVB
 lNXDu0O+IsxpYnkideVFXz/9vi3N5OYyfTuoxqrvXP6kZla036HYpglqK+EUgU8zNzKOudXrra1
 HATsup7UNQ29nAlxPjAeUFXh8BCdG9AKfwAJusADZy0dgzy7o9Ya7+Ot2m5/4g==
X-Received: by 2002:a05:6000:24c6:b0:47f:4919:d5b2 with SMTP id
 ffacd0b85a97d-482f79870bemr30093723f8f.1.1788108463774; 
 Sun, 30 Aug 2026 09:47:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb32d30sm17890576f8f.34.2026.08.30.09.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:47:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 16:47:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 37527755efdcfd7d7b2d2092f6a5fda6143ae332
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc84139f1e9945c29ebb308e23b05cc16e2c84a3-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0ihC-0003IK-GG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 extract a field from a buffer
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5204325407398520321=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5204325407398520321==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="373BfasyyBY="; charset=UTF-8

--373BfasyyBY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1855?usp=3Demail )

Change subject: Add helper method to extract a fiel=
d from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add helper method to extract a field from a buffer

Change-Id: Ifdd212=
2a3e60cdb11cc9df67570ab5628bfcdeea
Signed-off-by: Arne Schwabe <arne@rfc254=
9=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855
Message-Id: <20260828103517=2E1=
3327-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg38770=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
M src/openvpn/bu=
ffer=2Eh
M tests/unit_tests/openvpn/test_buffer=2Ec
3 files changed, 65 ins=
ertions(+), 1 deletion(-)




diff --git a/src/openvpn/buffer=2Ec b/src/ope=
nvpn/buffer=2Ec
index 046e231=2E=2E5ce2e39 100644
--- a/src/openvpn/buffer=
=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -1384,3 +1384,27 @@
     fclose(fp);
 =
    return ret;
 }
+
+char *
+buf_extract_field(struct buffer *buf, char se=
p, struct gc_arena *gc)
+{
+    if (!buf_valid(buf))
+    {
+        return=
 NULL;
+    }
+
+    const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_l=
en(buf));
+    if (!seppos)
+    {
+        return NULL;
+    }
+    size_t=
 field_len =3D seppos - BPTR(buf);
+
+    char *field =3D gc_malloc(field_l=
en + 1, false, gc);
+
+    memcpy(field, BPTR(buf), field_len);
+    field[=
field_len] =3D 0;
+
+    buf_advance(buf, field_len + 1);
+    return field=
;
+}
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index bc5=
cffb=2E=2E4471697 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buf=
fer=2Eh
@@ -2243,4 +2243,14 @@
 /**@}*/
 /* End of Buffer Lists */
 
+/**
+=
 * Extract a field from buf that ends with the \c sep character=2E The
+ * =
returned string is allocated in the gc_arena=2E If the separator character
=
+ * is not found, the function returns the nullptr=2E
+ *
+ * The buffer is=
 also forwarded to the point after the separator character=2E
+ */
+char *
=
+buf_extract_field(struct buffer *buf, char sep, struct gc_arena *gc);
+
 #=
endif /* BUFFER_H */
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec =
b/tests/unit_tests/openvpn/test_buffer=2Ec
index ce38bbe=2E=2E7fb9162 10064=
4
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/ope=
nvpn/test_buffer=2Ec
@@ -456,6 +456,35 @@
     /* Check that our own method=
 agrees */
     assert_true(string_check_buf(&buf2, CC_PRINT | CC_NULL, CC_=
CRLF));
     assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+    gc_=
free(&gc);
+}
+
+static void
+test_buffer_extract_field(void **state)
+{
+ =
   struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc=
(1000, &gc);
+    assert_null(buf_extract_field(&buf, ',', &gc));
+
+    bu=
f =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    const ch=
ar *ret =3D buf_extract_field(&buf, '5', &gc);
+    assert_string_equal(ret=
, "1234");
+    /* nothing left after the 5 */
+    assert_int_equal(buf_le=
n(&buf), 0);
+
+    buf =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "123=
45", 5);
+    ret =3D buf_extract_field(&buf, '4', &gc);
+    assert_string=
_equal(ret, "123");
+
+    /* 5 should be left */
+    assert_int_equal(buf=
_len(&buf), 1);
+    assert_memory_equal(buf_bptr(&buf), "5", 1);
+
+    bu=
f =3D alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    assert_n=
ull(buf_extract_field(&buf, '6', &gc));
 
     gc_free(&gc);
 }
@@ -567,7 +=
596,8 @@
         cmocka_unit_test(test_checked_snprintf),
         cmocka_=
unit_test(test_buffer_chomp),
         cmocka_unit_test(test_buffer_null_te=
rminate),
-        cmocka_unit_test(test_buffer_parse)
+        cmocka_unit=
_test(test_buffer_parse),
+        cmocka_unit_test(test_buffer_extract_fie=
ld)
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL=
, NULL);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a3e60=
cdb11cc9df67570ab5628bfcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet: 9
=
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razva=
nc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--373BfasyyBY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1855?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Add helper method to extract a field from =
a buffer<br><br>Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea<br>Sig=
ned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1855<br>Message-Id: &lt;20260828103517=2E13327-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38770=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/=
openvpn/buffer=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>3 files=
 changed, 65 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 046e231=
=2E=2E5ce2e39 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br=
><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -1384,3 +1384,27 @@<=
/span><br><span>     fclose(fp);</span><br><span>     return ret;</span><br=
><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+buf_extract_field(struct buffer *buf, cha=
r sep, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!b=
uf_valid(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const uint8_t *seppos =3D memchr(BPTR(buf), sep=
, buf_len(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!seppos)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    size_t field_len =3D seppos -=
 BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char *field =3D gc_mall=
oc(field_len + 1, false, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcp=
y(field, BPTR(buf), field_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    field[field_len] =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_advance(buf, field_len + 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return field;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src=
/openvpn/buffer=2Eh</span><br><span>index bc5cffb=2E=2E4471697 100644</span=
><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/b=
uffer=2Eh</span><br><span>@@ -2243,4 +2243,14 @@</span><br><span> /**@}*/</=
span><br><span> /* End of Buffer Lists */</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Extract a field from buf that ends with the \c s=
ep character=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * returned string is allocated in the gc_arena=2E If the separator charact=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is not found, =
the function returns the nullptr=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* The buffer is also forwarded to the point after the separator character=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+buf_extract_field(struct buffer *buf, char se=
p, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #endif /* BUFFER_H */</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buf=
fer=2Ec</span><br><span>index ce38bbe=2E=2E7fb9162 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -456,6 +456,35 @@</spa=
n><br><span>     /* Check that our own method agrees */</span><br><span>   =
  assert_true(string_check_buf(&amp;buf2, CC_PRINT | CC_NULL, CC_CRLF));</s=
pan><br><span>     assert_string_equal(BSTR(&amp;buf2), &quot;CR_RESPONSE,M=
TIx&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_buffer_extract_field(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(1000, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf,=
 &quot;12345&quot;, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *ret =3D buf_extract_field(&amp;buf, &#39;5&#39;, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(ret, &quot;1234&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* nothing left after the 5 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;buf), 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf,=
 &quot;12345&quot;, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ret =3D buf_extract_field(&amp;buf, &#39;4&#39;, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(ret,=
 &quot;123&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 5 should be l=
eft */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(buf_len(&amp;buf), 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_memory_equal(buf_bptr(&amp;buf), &quot;5&quot;, 1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf=
, &quot;12345&quot;, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(buf_extract_field(&amp;buf, &#39;6&#39;, &amp;gc));</s=
pan><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</=
span><br><span>@@ -567,7 +596,8 @@</span><br><span>         cmocka_unit_tes=
t(test_checked_snprintf),</span><br><span>         cmocka_unit_test(test_bu=
ffer_chomp),</span><br><span>         cmocka_unit_test(test_buffer_null_ter=
minate),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmock=
a_unit_test(test_buffer_parse)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_buffer_parse),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_buffer_ex=
tract_field)</span><br><span>     };</span><br><span> </span><br><span>    =
 return cmocka_run_group_tests_name(&quot;buffer&quot;, tests, NULL, NULL);=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9d=
f67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--373BfasyyBY=--


--===============5204325407398520321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5204325407398520321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5204325407398520321==--

