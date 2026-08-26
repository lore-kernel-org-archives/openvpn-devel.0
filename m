Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C685CC61DC4
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAA/kH7CKiR+pKjlXwkd2maD+m+S/mAiqaNdZViJsHw=; b=iuj3/si84wMOWOnJVxIriZYU7z
	FzEbJBB2mnAiEbNV6ysdVn/fQt6cMAleXOFCB3SOmvkqvXNrA+PY8THDuWC0wCdolbxpnoGKBPYFB
	sDKuByNribK4PwEgTgXk67nTPfU5STYVHt1pzFYe6iBQM3/fuxlLX0eBKtN4iv9giJD0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGhv-0004dV-KP;
	Wed, 26 Aug 2026 16:42:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGhr-0004dL-Ja
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3+D6Ofmd0FbaIsa4ln4CTcnEdVIxMzRVPoLrZuMpbVs=; b=PKCqSGVqj3+zaqtvNLy4NEPunZ
 GpgXz1bll4Vf/cI7P9jgvBzcor77PCLoTRnvDQ/pf8GwaQfu08+JP+yt3g27KGV5IvAGPGqXyTEuw
 Ujj4FKKch6uB8b/OKTPZEXxSPRR9l5rbti9sJGc0MlLSQE6EZZiAGzrhjMd6kD+EqdJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3+D6Ofmd0FbaIsa4ln4CTcnEdVIxMzRVPoLrZuMpbVs=; b=g
 UFRt+M5zpIq2ndRjU4UmE+VIfjelfcHiviSeMWWz3NBfEi4MUl0bvRBgDhBt8mHgqqN5QsbLO70/X
 rzzzz+0JUpMR4+y23b+12MyZpZNiEM//39Iwjsdd1hoz5AzBAEqN9172EOcEODBL+yDUhUPxaTJKh
 SoSCX1uIUN/LgNhQ=;
Received: from mail-ed1-f52.google.com ([209.85.208.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGhr-0002JQ-2q for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:42:32 +0000
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so1814657a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787762544; x=1788367344; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3+D6Ofmd0FbaIsa4ln4CTcnEdVIxMzRVPoLrZuMpbVs=;
 b=Ob6yp42/bq1yP6FMUIjBFU3Y+ExjlhnN/SCEHgD6eD9Xx65aMiCWekATj7ppQ4WxUD
 8qLht+XKQa2P111HKvdZpuvKiUYg3ashr5oND6YnOVi0QJqgvj7LkNebvQNykk1gPPE0
 4FnLUxhYvjyomPxHwAogcbnRb/WgccF7NmYekTNjsBPVIsrgqNrLgdFou9OjJLCX59FR
 yQvA5WFKFCL7doZyl4BglGn2Sc/CZiL3zzI1xjDCAW+qqW8/3a6lSfWfbulj3RJ7fx7t
 481WvM7qz4mIyDezUrdS/veBUAUU616dBElUJeAVw21zkwkTKM406xRUmAXbIajzzdSE
 nvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762544; x=1788367344;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3+D6Ofmd0FbaIsa4ln4CTcnEdVIxMzRVPoLrZuMpbVs=;
 b=LsLFL38qNBl4Ciw2QKRj1KcyP2qP5qGQS+xwnveoLN9zIsluuwFsEB7cZDIv/ktMS+
 +0IjroOA/OKCWgDuUi9h4oLeeVgmOKhUI1jjAYyFDjpKRLXpbgyABggfYMcF0RHzUv5E
 weXZE+iLkgfnXf6nxgE5CGOTr35ey7rbdh+W8jwpXfSqSKx2otgzkBl57OwhXEW7qpzr
 LTYG7syG8iBlHrsWLSo+MvEz/FtuoLgKU1vioUeV2XDHsbTyEtx2kRrgJBXAO4SCMeUR
 4D2oyGeLVrt1kZzbFxxPQZbhTcFlm7z03xamWq8xjxJkkfE/msy0RWJcmrY1b3p9ubEl
 tCyA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoP1xCSGPFcb444Ksl+0S2eCFVcogOeWC1+Yc7V99bnSggQ2nV3uuQuI1h8zuNLcvnniAIO6zLbsevZ1Ix4@lists.sourceforge.net
X-Gm-Message-State: AFuF++l932Ct2eCvpOm+X4VhFet85XlhiBRH9Nqz5gYyDhK7/RYVRjmI
 TeNAfSMMWRfSPVZs6gUPLuS5lJjDOdJgNnBiUs7R3qhU280ROUy3dqGFm9vmvpyY5AsyLgt5fqC
 qGYV7BeKVpulANoLwS0GUfDzuonTFUrokvizMjirLa+pNF39w51X+LKQTC5j8DLOdiDQv
X-Gm-Gg: AR+sD13aK3roxMeYLQRtFTS5AQRfbxVJf5l/J4luImNXjX00RwiQJQbHMYNgBYjmyxA
 9KE8xlLAFsiKpQWCTBKfkdxJy1N3ampgo3wTid0OcWeHhrQ1gTSM7NllEjhbNOCOF1ZHosB7nOO
 u3/Z/ex5RFJsAotblpsaTZUQTT3cj/IzujngJapn85kabR7iGHC/N0NL903b+Y05W1nTYhPqaGJ
 DxpKO9YK4WpLFKhclS/FM7Zeq0FQDnq+0lW74BYJMdFa06MbbUr6Ig59PW27CILyHidlmkqeJJE
 EVi03pJkmYIgQUOictL4Vk1QqiT1jvHRVDmH5UIuv3EiYVmn5h7x7P+y6qQEmjU0tBGZzAyqYe3
 qitU6gOZaM8bdRliL+/GwveZyiQ9K1jBBnez0QRq/R6DK0CPfE3pphqKjSeosNBJXLoRZM8ziRA
 A6SQHwKwuCQHnMP8kEEyeIOGRdVwCF5e2cXxrB9bQkG3oj4i/1WUdk+KF5GzOXMCZQuBIm/3HkS
 X3YWVeUkBV39C0guqhg8eCnV62QAgfOiy7rhEGcvH7BvK3qU8eq4cWuQzmALTTks8ENS5mZYroo
 Z55sZOAzs8enG1le32klMQiFmVjOTadImi8nf2sF/3Qgh/YQpKM=
X-Received: by 2002:a05:6402:21d9:b0:698:be4d:ca2a with SMTP id
 4fb4d7f45d1cf-6a5df6621f1mr9782433a12.15.1787762544260; 
 Wed, 26 Aug 2026 09:42:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5dea83babsm5333496a12.16.2026.08.26.09.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:42:23 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:42:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 33918e36eeecb15d723666909c3a168ee96ff67a
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d225c09c6aafa72ee467af566cbf12761a853695-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGhr-0002JQ-2q
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8652567224731918456=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8652567224731918456==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nztnFE5X6h0="; charset=UTF-8

--nztnFE5X6h0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, razvanc=2E

plaisthos has uplo=
aded a new patch set (#7)=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
55?usp=3Demail )


Change subject: Add helper method to extract a field fro=
m a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

A=
dd helper method to extract a field from a buffer

Change-Id: Ifdd2122a3e60=
cdb11cc9df67570ab5628bfcdeea
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=2Eh
M tests/unit_tests=
/openvpn/test_buffer=2Ec
3 files changed, 65 insertions(+), 1 deletion(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1855=
/7

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
index 046e=
231=2E=2E5ce2e39 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buff=
er=2Ec
@@ -1384,3 +1384,27 @@
     fclose(fp);
     return ret;
 }
+
+char =
*
+buf_extract_field(struct buffer *buf, char sep, struct gc_arena *gc)
+{
=
+    if (!buf_valid(buf))
+    {
+        return NULL;
+    }
+
+    const =
uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_len(buf));
+    if (!seppos)=

+    {
+        return NULL;
+    }
+    size_t field_len =3D seppos - BPT=
R(buf);
+
+    char *field =3D gc_malloc(field_len + 1, false, gc);
+
+    =
memcpy(field, BPTR(buf), field_len);
+    field[field_len] =3D 0;
+
+    bu=
f_advance(buf, field_len + 1);
+    return field;
+}
diff --git a/src/openv=
pn/buffer=2Eh b/src/openvpn/buffer=2Eh
index bc5cffb=2E=2E4471697 100644
--=
- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -2243,4 +2243,14=
 @@
 /**@}*/
 /* End of Buffer Lists */
 
+/**
+ * Extract a field from buf=
 that ends with the \c sep character=2E The
+ * returned string is allocate=
d in the gc_arena=2E If the separator character
+ * is not found, the funct=
ion returns the nullptr=2E
+ *
+ * The buffer is also forwarded to the poin=
t after the separator character=2E
+ */
+char *
+buf_extract_field(struct b=
uffer *buf, char sep, struct gc_arena *gc);
+
 #endif /* BUFFER_H */
diff -=
-git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/=
test_buffer=2Ec
index ce38bbe=2E=2E7fb9162 100644
--- a/tests/unit_tests/op=
envpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -45=
6,6 +456,35 @@
     /* Check that our own method agrees */
     assert_true=
(string_check_buf(&buf2, CC_PRINT | CC_NULL, CC_CRLF));
     assert_string_=
equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+    gc_free(&gc);
+}
+
+static voi=
d
+test_buffer_extract_field(void **state)
+{
+    struct gc_arena gc =3D g=
c_new();
+    struct buffer buf =3D alloc_buf_gc(1000, &gc);
+    assert_nu=
ll(buf_extract_field(&buf, ',', &gc));
+
+    buf =3D alloc_buf_gc(5, &gc);=

+    buf_write(&buf, "12345", 5);
+    const char *ret =3D buf_extract_fie=
ld(&buf, '5', &gc);
+    assert_string_equal(ret, "1234");
+    /* nothing =
left after the 5 */
+    assert_int_equal(buf_len(&buf), 0);
+
+    buf =3D=
 alloc_buf_gc(5, &gc);
+    buf_write(&buf, "12345", 5);
+    ret =3D buf_e=
xtract_field(&buf, '4', &gc);
+    assert_string_equal(ret, "123");
+
+    =
/* 5 should be left */
+    assert_int_equal(buf_len(&buf), 1);
+    assert=
_memory_equal(buf_bptr(&buf), "5", 1);
+
+    buf =3D alloc_buf_gc(5, &gc);=

+    buf_write(&buf, "12345", 5);
+    assert_null(buf_extract_field(&buf,=
 '6', &gc));
 
     gc_free(&gc);
 }
@@ -567,7 +596,8 @@
         cmocka_un=
it_test(test_checked_snprintf),
         cmocka_unit_test(test_buffer_chomp=
),
         cmocka_unit_test(test_buffer_null_terminate),
-        cmocka_u=
nit_test(test_buffer_parse)
+        cmocka_unit_test(test_buffer_parse),
+=
        cmocka_unit_test(test_buffer_extract_field)
     };
 
     return c=
mocka_run_group_tests_name("buffer", tests, NULL, NULL);

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628b=
fcdeea
Gerrit-Change-Number: 1855
Gerrit-PatchSet: 7
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC=
: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Em=
uc=2Ede>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--nztnFE5X6h0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, razvanc=2E </p>
<p>plaisthos <strong>uploaded =
patch set #7</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
Add helper method to extract a field from a buffer<br><br>Change-Id: Ifdd21=
22a3e60cdb11cc9df67570ab5628bfcdeea<br>Signed-off-by: Arne Schwabe &lt;arne=
@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buff=
er=2Eh<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>3 files changed, 65=
 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1855/7</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 04=
6e231=2E=2E5ce2e39 100644</span><br><span>--- a/src/openvpn/buffer=2Ec</spa=
n><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -1384,3 +1384,2=
7 @@</span><br><span>     fclose(fp);</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+buf_extract_field(struct buffer *buf,=
 char sep, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!buf_valid(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const uint8_t *seppos =3D memchr(BPTR(buf),=
 sep, buf_len(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!seppos)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size_t field_len =3D sepp=
os - BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *field =3D gc_=
malloc(field_len + 1, false, gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
emcpy(field, BPTR(buf), field_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    field[field_len] =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_advance(buf, field_len + 1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return field;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/buffer=2Eh b=
/src/openvpn/buffer=2Eh</span><br><span>index bc5cffb=2E=2E4471697 100644</=
span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openv=
pn/buffer=2Eh</span><br><span>@@ -2243,4 +2243,14 @@</span><br><span> /**@}=
*/</span><br><span> /* End of Buffer Lists */</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Extract a field from buf that ends with the =
\c sep character=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * returned string is allocated in the gc_arena=2E If the separator cha=
racter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is not fou=
nd, the function returns the nullptr=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * The buffer is also forwarded to the point after the separator charact=
er=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+buf_extract_field(struct buffer *buf, cha=
r sep, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> #endif /* BUFFER_H */</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test=
_buffer=2Ec</span><br><span>index ce38bbe=2E=2E7fb9162 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -456,6 +456,35 @@<=
/span><br><span>     /* Check that our own method agrees */</span><br><span=
>     assert_true(string_check_buf(&amp;buf2, CC_PRINT | CC_NULL, CC_CRLF))=
;</span><br><span>     assert_string_equal(BSTR(&amp;buf2), &quot;CR_RESPON=
SE,MTIx&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_buffer_extract_field(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(1000, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_null(buf_extract_field(&amp;buf, &#39;,&#39;, &amp;gc));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;bu=
f, &quot;12345&quot;, 5);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *ret =3D buf_extract_field(&amp;buf, &#39;5&#39;, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(ret, &quot;1234&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* nothing left after the 5 */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;buf), 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a3e60cdb1=
1cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--nztnFE5X6h0=--


--===============8652567224731918456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8652567224731918456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8652567224731918456==--

