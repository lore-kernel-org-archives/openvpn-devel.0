Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F663C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ozbRxkFPYB72Plk+dUOh/EstD4SOY6lBMGMqBo8YWJI=; b=Z0LutCUyFGokNr1cFJ2t4exnsJ
	HuV5L9ynV+biRruYKUYR+B7MHENQUxFT3GdaufjhZwRJjYLw25r7tay0CRT5lxQaAMg0+uV82b837
	/7pSgx/O25eh0I/8PiZwoSwfmVIei4+XeB4LaQZytd8TQ5YBT+uAYB050x401X8PlozY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7ALJ-0004QZ-PM;
	Thu, 17 Sep 2026 11:31:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7ALI-0004QO-6y
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 11:31:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K2w3kU61Ucxx74AhbhOiXVMdr/YqMSmu/GYNDPEFxRk=; b=SNnWO7MD2zQYCAXf1EkeO9jxtu
 PFHOgkV1B+BrDvmm/oQhNqXH3XyWZO3BD/CGLtB4S6I3U1ZiaVbXsPamBaaPU8SvKizGL30BFHuW4
 EDts588XwmvcsN5Dpv5VEGW6logU1qpxIEC+MDQDzSf//luhLtWZNeCh/Gt9Ecqbuu4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K2w3kU61Ucxx74AhbhOiXVMdr/YqMSmu/GYNDPEFxRk=; b=Z
 BMWjlvBObAdapLuZyjNCgHgRyaU7aGnJUiCoGcOPTa26YOpyuapgpyWhPoEeId+50YFFmCO4kJqW/
 9QA0VBZWgCCO2yFRp9xI4TaDvjQo7ZwNPFAgJ/iEZCOhUD0FiuM20ZHWZWiKqJseeEpTz0Hy+0cK1
 M6gAhgJFNw0XXFJg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7ALF-0004Bd-2f for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 11:31:52 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so5094975e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789644702; x=1790249502; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K2w3kU61Ucxx74AhbhOiXVMdr/YqMSmu/GYNDPEFxRk=;
 b=Emcqs1pgfelq50LpXirIcHXrBVaVxGHUG49iiiE89eMAXWXYXYroxgwGt5FFdVp/pQ
 h5PX6oSawg7slC2MrzY2S/q5fhFr5wLAr5Y9PQEi9mF/yrY9RCYU8d50Yq+zEsaMGfHH
 +8DdpT2V47ydk/4mFjF4KN7KYVB+ob4x7xlPPo2DD7jPA+jgvsafTDX/P9c8kiq73vYx
 EDxmB04G3Lm77y1T451vQtdOLlVEAVsD8Gp5by0ETY9aY1qMMnEClWThaYnulGUIkCEV
 dBHlnzILv9JLsr/zZD0psMNYQOoTATjfdTdL5g3x167ZQ/fXkLTD+2lA/RGcgRoVXEoF
 cGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789644702; x=1790249502;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K2w3kU61Ucxx74AhbhOiXVMdr/YqMSmu/GYNDPEFxRk=;
 b=Lpjgt00S2Vy2xZ7EwjOlntU0P6sLqPBcu82AdmGcfN+240O7uBdxjobRtIljt2n/Un
 gdC5u8ksduj6yzMlIsM6b7FNpVdodHWAHcs/899B/AuwW/IYJutQHh/R0DGH0pjcHob7
 R6fsGi9QTOfgmIRDkQUr7f9fkuIA0g2JQJlLf2F6TATmQ9zOaic6Win8iArSzOulYEru
 GQk4y0SCVJsqfi/XjvEvxSndOKjBJ5RY+u3C9lDMvFM8EEzxHP7F9RK36jmIQdxAhRQY
 gWWKBqx3IFEzEt93NgM4dzIZycbZ4eBxeOgEAJIqXDJzWNFGAGGIfGEn7jvrUqLZF9cC
 oVZQ==
X-Gm-Message-State: AFuF++kfGQzjfyWrpEAOON9S1Cfh97WJBZ6D4HG64GWom3pRPxPgOpas
 o/5RIJ7t+WPzEAjvOhdaRRYafGaiH45f3lDbzTkwLEexuJUehyF/bFt07Yp0ZOoh6uZ3EMymQ9v
 mqoC2DqakNF7iAfJb34CpGEAYFzDXODyvyulSFzjgB/TJfMtuwpZtbFC2Im+I8L17xNqaSY4Jr0
 QPgKtT9A==
X-Gm-Gg: AYBFou1MXK6SzbcvMTYZ6eEEjAGjRyaX9nWhWTfq0PLokNE87PioUlnxF2wuANDrN3n
 jtTSgh925KdK3uNaai31Hb9ki5bIdagJh5rGpJlrO7CGmC7QQFeJX96KAGqLuLTqx/tQcwIrchL
 LuDS4ys5lkS3vN/wKakEITPFd4DPcjCy0WnXMML1Se6Vdt+8sUunZwU7yekZzVvn3MBJnXSOXQG
 T4n0Oshen31h+L8XlA31l85k/LDeyWat6MCfdvShkEdJd2X0aUHAYgaRTDApMNSLaPLWXoKlRNr
 mQVQ7b5hNv+7e2sIWuc7pNqkz2lZ1Q7HVl2efMiQPQFpOuB5VqviA+sMZsicmjZCOcl5oQYBNth
 2NWGRDZyDeWt91tbc/tTS1SVAPzYnJeqzudIjHUtuqnQpeC5Zh8YfEp5B+Zv0QKcuvqiLmjzHZj
 MTAoc0Q3L31o2v4/QttkHXfSfDQRsaOfA3decSK8sYQjAEoh3QrVYgXktXQSg1+b/rCS3fDNG/Q
 spFTGZnPAwr7kKXfcpVvmVfauT5t+LIOCjO2HnjBrRXwHnCeF7hCOiR6htZd0XVOQGQYpe1mKeE
 iKHYjWUnRcAcOyoobhbJujPzb9tlAySeYcIrRBGL+1FuuGy+uekRzNuiHhRXQg==
X-Received: by 2002:a05:600c:1907:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-49eb73143c7mr74147625e9.1.1789644702327; 
 Thu, 17 Sep 2026 04:31:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd23a815sm75222045e9.14.2026.09.17.04.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 04:31:41 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 11:31:39 +0000
To: syzzer <steffan@karger.me>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: ed00063229719e8056263c1b2fbf05ccf7aaae19
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d67ee37740f8fa0dda410993ef1977291a31db5f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7ALF-0004Bd-2f
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4913709149217786254=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4913709149217786254==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UwKEMRKezuU="; charset=UTF-8

--UwKEMRKezuU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos, syzzer=2E

Hello pla=
isthos, syzzer, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail

to look at the n=
ew patch set (#3)=2E


Change subject: Check for null-bytes in certificate =
subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Chec=
k for null-bytes in certificate subjects

When using the OpenSSL library, w=
e escaped embedded null-bytes in a
certificate's subject in x509_get_subjec=
t(), but in
extract_x509_field_ssl(), we copied any null-bytes that are con=
tained in
the field value=2E When using the option --verify-x509-name, this=
 could
lead to an incorrect name being accepted=2E For example, the common =
name
"admin\0impersonator" would be accepted when running with
--verify-x50=
9-name admin name=2E

To fix this, this commit makes x509_get_subject() ret=
urn an error if the
subject contains an embedded null-byte=2E This way, Ope=
nVPN won't connect
with peers that present such certificates=2E

As a defen=
se-in-depth measure, we also check for null-bytes in
extract_x509_field_ssl=
() in case a future version of OpenVPN has a code
path that avoids x509_get=
_subject()=2E

With Mbed TLS, the x509_get_subject() function already retur=
ned an error
when there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=
=2E) Here too, we
added a check for null-bytes to the function where we ext=
ract individual
fields from the subject=2E

Also, backend_x509_get_username=
() is changed so that it returns the
value of the *last* matching field, to=
 be consistent with the behavior
of the OpenSSL backend=2E

This is a parti=
al backport of the commit
"Check for \0 and RFC 2253 chars in cert subjects=
" from the master
branch but skipping the part about escaping RFC 2253 char=
acters to avoid
user-visible changes in a patch release=2E We do not consid=
er the
null-byte check "user-visible" because we don't expect users to put
=
null-bytes into the common name=2E

v2: The previous version of the commit =
unescaped control characters in
the subject, so it had user-visible changes=
 after all=2E This version
escapes any control characters in the subject=2E=


Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=
=2E
Contributing Researcher: Vivek Parikh=2E

CVE: 2026-84790
Reported-by: =
Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn-private-=
issues#163

Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Signed-off=
-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
---
M src/openvp=
n/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M tests/unit_=
tests/openvpn/test_ssl=2Ec
3 files changed, 155 insertions(+), 29 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02=
/1902/3

diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_=
verify_mbedtls=2Ec
index 66cc66e=2E=2E1319c07 100644
--- a/src/openvpn/ssl_=
verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -214,6 +214,=
24 @@
     }
 }
 
+static bool
+asn1_buf_is_cstr_compatible(const mbedtls_a=
sn1_buf *asn1_buf)
+{
+    if (!(asn1_buf->tag =3D=3D MBEDTLS_ASN1_UTF8_STR=
ING || asn1_buf->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING
+          || asn=
1_buf->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    {
+        return false;
+=
    }
+    for (size_t i =3D 0; i < asn1_buf->len; i++)
+    {
+        if =
(asn1_buf->p[i] =3D=3D '\0')
+        {
+            return false;
+       =
 }
+    }
+    return true;
+}
+
 result_t
 backend_x509_get_username(char =
*cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
@=
@ -259,16 +277,17 @@
     }
 
     /* Find field_oid in the subject name=2E=
 */
-    mbedtls_x509_name *name =3D &cert->subject;
-    while (name !=3D =
NULL)
+    mbedtls_x509_name *name =3D NULL;
+    mbedtls_x509_name *next =
=3D &cert->subject;
+    while (next !=3D NULL)
     {
-        if (strlen(=
field_oid) =3D=3D name->oid=2Elen
-            && 0 =3D=3D memcmp(name->oid=
=2Ep, field_oid, name->oid=2Elen))
+        if (strlen(field_oid) =3D=3D ne=
xt->oid=2Elen
+            && 0 =3D=3D memcmp(next->oid=2Ep, field_oid, nex=
t->oid=2Elen))
         {
-            break;
+            name =3D next;
 =
        }
 
-        name =3D name->next;
+        next =3D next->next;
   =
  }
 
     /* Not found, return an error if this is the peer's certificate =
*/
@@ -277,6 +296,11 @@
         goto fail;
     }
 
+    if (!asn1_buf_is_=
cstr_compatible(&name->val))
+    {
+        goto fail;
+    }
+
     /* Ch=
eck that we have room in the buffer, including the terminating '/0' byte=2E=
 */
     if (cn_len <=3D name->val=2Elen)
     {
@@ -586,22 +610,11 @@
 sta=
tic char *
 asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_ar=
ena *gc)
 {
-    size_t i;
     char *val;
 
-    if (!(orig->tag =3D=3D MB=
EDTLS_ASN1_UTF8_STRING || orig->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING
- =
         || orig->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    if (!asn1_buf_i=
s_cstr_compatible(orig))
     {
-        /* Only support C-string compatibl=
e types */
-        return string_alloc("ERROR: unsupported ASN=2E1 string =
type", gc);
-    }
-
-    for (i =3D 0; i < orig->len; ++i)
-    {
-       =
 if (orig->p[i] =3D=3D '\0')
-        {
-            return string_alloc("E=
RROR: embedded null value", gc);
-        }
+        return string_alloc("E=
RROR: Unsupported string type or embedded null bytes=2E", gc);
     }
     =
val =3D gc_malloc(orig->len + 1, false, gc);
     memcpy(val, orig->p, orig=
->len);
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_v=
erify_openssl=2Ec
index a30099d=2E=2E1f2804f 100644
--- a/src/openvpn/ssl_v=
erify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -196,12 +196,=
13 @@
     int lastpos =3D -1;
     int tmp =3D -1;
     unsigned char *buf=
 =3D NULL;
+    result_t ret =3D FAILURE;
 
     ASN1_OBJECT *field_name_ob=
j =3D OBJ_txt2obj(field_name, 0);
     if (field_name_obj =3D=3D NULL)
    =
 {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_nam=
e);
-        return FAILURE;
+        goto exit;
     }
 
     ASSERT(size =
> 0);
@@ -222,28 +223,31 @@
     /* Nothing found */
     if (lastpos =3D=
=3D -1)
     {
-        return FAILURE;
+        goto exit;
     }
 
     c=
onst X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entry(x509, lastpos);
     i=
f (!x509ne)
     {
-        return FAILURE;
+        goto exit;
     }
 
  =
   const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);
     if (!=
asn1)
     {
-        return FAILURE;
+        goto exit;
     }
-    if (A=
SN1_STRING_to_UTF8(&buf, asn1) < 0)
+    int length =3D ASN1_STRING_to_UTF8=
(&buf, asn1);
+    if (length < 0 || (size_t)length !=3D strlen((char *)buf=
))
     {
-        return FAILURE;
+        goto exit;
     }
 
     strncp=
ynt(out, (char *)buf, size);
 
-    const result_t ret =3D (strlen((char *)=
buf) < size) ? SUCCESS : FAILURE;
+    ret =3D (strlen((char *)buf) < size)=
 ? SUCCESS : FAILURE;
+
+exit:
     OPENSSL_free(buf);
     return ret;
 }
=
@@ -384,9 +388,9 @@
         goto err;
     }
 
+    /* Get the subject wit=
h unescaped control characters so that we can check for null bytes=2E */
  =
   X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
-       =
                XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_C=
ONVERT
-                           | ASN1_STRFLGS_ESC_CTRL);
+             =
          XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT=
);
 
     if (BIO_eof(subject_bio))
     {
@@ -394,6 +398,25 @@
     }
 
  =
   BIO_get_mem_ptr(subject_bio, &subject_mem);
+    if (memchr(subject_mem-=
>data, 0, subject_mem->length) !=3D NULL)
+    {
+        msg(M_WARN, "ERRO=
R: Certificate subject contains a '\\0' byte=2E");
+        goto err;
+    =
}
+
+    /* Now output the subject with escaped control characters=2E */
+ =
   if (BIO_reset(subject_bio) !=3D 1)
+    {
+        goto err;
+    }
+   =
 X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
+         =
              XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CON=
VERT
+                           | ASN1_STRFLGS_ESC_CTRL);
+    if (BIO_eof=
(subject_bio))
+    {
+        goto err;
+    }
+    BIO_get_mem_ptr(subjec=
t_bio, &subject_mem);
 
     subject =3D gc_malloc(subject_mem->length + 1,=
 false, gc);
 
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/u=
nit_tests/openvpn/test_ssl=2Ec
index 7e7679c=2E=2Eadfc07a 100644
--- a/test=
s/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=
=2Ec
@@ -884,6 +884,94 @@
     free_certificate(cert);
 }
 
+/* Certificate=
 with two CNs, "foo" and "bar"=2E
+ *
+ * Generated with:
+ * openssl req -=
x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -subj "/CN=3Dfoo/CN=3D=
bar" \
+ * -noenc -out two_cns=2Ecrt -keyout two_cns=2Ekey
+ */
+static con=
st char *cert_with_two_cns =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "M=
IIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n"
+    "HD=
EMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n"
+    "MjY=
wOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n"
+    "ByqG=
SM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n"
+    "PvPMW=
GWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n"
+    "hGBWFv=
nUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n"
+    "dFT/BNo=
JMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n"
+    "/wQFMAMB=
Af8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E88\n"
+    "cwoCK3Uwz=
Er8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\n"
+    "OyQnlH8W/U=
zZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n"
+    "-----END CERTIFICATE-----\n";
+
+=
void
+ssl_test_extract_last_matching_field(void **state)
+{
+    /* When th=
ere are multiple fields of the same type in the certificate's subject, Open=
VPN
+     * should extract the value of the last matching field=2E This is =
essentially arbitrary and there
+     * is no correct choice here, but this=
 test exists to make sure that the behavior is consistent
+     * between d=
ifferent backends=2E
+     */
+    openvpn_x509_cert_t *cert =3D get_certif=
icate(cert_with_two_cns);
+
+    char username[TLS_USERNAME_LEN + 1] =3D { =
0 };
+    assert_int_equal(backend_x509_get_username(username, sizeof(usern=
ame), "CN", cert), SUCCESS);
+    assert_string_equal(username, "bar");
+  =
  free_certificate(cert);
+}
+
+/* Certificate with a null-byte embedded in=
 the CN=2E
+ *
+ * Generated with the following Python script:
+ *
+ * from=
 cryptography import x509
+ * from cryptography=2Ex509=2Eoid import NameOID=
, ExtensionOID, ExtendedKeyUsageOID
+ * from cryptography=2Ehazmat=2Eprimit=
ives import hashes, serialization
+ * from cryptography=2Ehazmat=2Eprimitiv=
es=2Easymmetric import ec
+ * import datetime
+ *
+ * private_key =3D ec=2E=
generate_private_key(ec=2ESECP384R1())
+ * now =3D datetime=2Edatetime=2Eno=
w(datetime=2Etimezone=2Eutc)
+ * name =3D "with\x00null"
+ *
+ * cert =3D (=
x509=2ECertificateBuilder()
+ *             =2Esubject_name(x509=2EName([x5=
09=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))
+ *             =2Eissue=
r_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))
+ =
*             =2Epublic_key(private_key=2Epublic_key())
+ *             =2E=
serial_number(x509=2Erandom_serial_number())
+ *             =2Enot_valid_b=
efore(now)
+ *             =2Enot_valid_after(now + datetime=2Etimedelta(da=
ys=3D10 * 365))
+ *             =2Esign(private_key, hashes=2ESHA256()))
+ =
*
+ * print(str(cert=2Epublic_bytes(serialization=2EEncoding=2EPEM), encodi=
ng=3D'utf-8'))
+ **/
+static const char *cert_with_null =3D
+    "-----BEGI=
N CERTIFICATE-----\n"
+    "MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzA=
KBggqhkjOPQQDAjAU\n"
+    "MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4=
WhcNMzYwODI1MTQz\n"
+    "MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOP=
QIBBgUrgQQAIgNi\n"
+    "AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW=
5wg6/mlPaeiJY/\n"
+    "Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJy=
VtoRBvkNvy5+k\n"
+    "GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0Cq=
iaSNByGiP75i\n"
+    "k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9=
qQqaM3d92Mp\n"
+    "EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n"
+    "----=
-END CERTIFICATE-----\n";
+
+void
+ssl_test_reject_null_in_cert_subject(voi=
d **state)
+{
+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with_=
null);
+    struct gc_arena gc =3D gc_new();
+
+    /* Trying to get the su=
bject as a whole should fail=2E */
+    assert_ptr_equal(x509_get_subject(c=
ert, &gc), NULL);
+
+    /* Trying to extract the common name should fail=
=2E */
+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };
+    assert_int_=
equal(backend_x509_get_username(username, sizeof(username), "CN", cert), FA=
ILURE);
+    gc_free(&gc);
+    free_certificate(cert);
+}
 
 int
 main(voi=
d)
@@ -908,7 +996,9 @@
         cmocka_unit_test(test_data_channel_roundtri=
p_bf_cbc),
         cmocka_unit_test(test_data_channel_known_vectors_epoch)=
,
         cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
- =
       cmocka_unit_test(crypto_test_print_cert_details)
+        cmocka_uni=
t_test(crypto_test_print_cert_details),
+        cmocka_unit_test(ssl_test_=
extract_last_matching_field),
+        cmocka_unit_test(ssl_test_reject_nul=
l_in_cert_subject)
 
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1902?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=
=2E7
Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Gerrit-Cha=
nge-Number: 1902
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: syzzer <steffan@karger=2Eme>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--UwKEMRKezuU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos, syzzer=2E </p>
<p>MaxF <strong>uploa=
ded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Check for null-bytes in certificate subjects<br><br>When using the Ope=
nSSL library, we escaped embedded null-bytes in a<br>certificate&#39;s subj=
ect in x509_get_subject(), but in<br>extract_x509_field_ssl(), we copied an=
y null-bytes that are contained in<br>the field value=2E When using the opt=
ion --verify-x509-name, this could<br>lead to an incorrect name being accep=
ted=2E For example, the common name<br>&quot;admin\0impersonator&quot; woul=
d be accepted when running with<br>--verify-x509-name admin name=2E<br><br>=
To fix this, this commit makes x509_get_subject() return an error if the<br=
>subject contains an embedded null-byte=2E This way, OpenVPN won&#39;t conn=
ect<br>with peers that present such certificates=2E<br><br>As a defense-in-=
depth measure, we also check for null-bytes in<br>extract_x509_field_ssl() =
in case a future version of OpenVPN has a code<br>path that avoids x509_get=
_subject()=2E<br><br>With Mbed TLS, the x509_get_subject() function already=
 returned an error<br>when there is an embedded null-byte=2E (As of Mbed TL=
S 3=2E5=2E) Here too, we<br>added a check for null-bytes to the function wh=
ere we extract individual<br>fields from the subject=2E<br><br>Also, backen=
d_x509_get_username() is changed so that it returns the<br>value of the *la=
st* matching field, to be consistent with the behavior<br>of the OpenSSL ba=
ckend=2E<br><br>This is a partial backport of the commit<br>&quot;Check for=
 \0 and RFC 2253 chars in cert subjects&quot; from the master<br>branch but=
 skipping the part about escaping RFC 2253 characters to avoid<br>user-visi=
ble changes in a patch release=2E We do not consider the<br>null-byte check=
 &quot;user-visible&quot; because we don&#39;t expect users to put<br>null-=
bytes into the common name=2E<br><br>v2: The previous version of the commit=
 unescaped control characters in<br>the subject, so it had user-visible cha=
nges after all=2E This version<br>escapes any control characters in the sub=
ject=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using Typh=
on AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>CVE: 202=
6-84790<br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br=
>Github: OpenVPN/openvpn-private-issues#163<br><br>Change-Id: Iea1481e94ba1=
abe18c39d81cd797187c88427571<br>Signed-off-by: Max Fillinger &lt;maximilian=
=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M src/openvpn/ssl_verify_mbedtls=
=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M tests/unit_tests/openvpn/=
test_ssl=2Ec<br>3 files changed, 155 insertions(+), 29 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/02/1902/3</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec=
 b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index 66cc66e=2E=2E13=
19c07 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span=
><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -214=
,6 +214,24 @@</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+asn1_buf_is_cstr_compatible(c=
onst mbedtls_asn1_buf *asn1_buf)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!(asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf-&gt;tag =
=3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+          || asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRI=
NG))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; asn1_buf-=
&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (asn1_buf=
-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> result_t</span><br><=
span> backend_x509_get_username(char *cn, size_t cn_len, char *x509_usernam=
e_field, mbedtls_x509_crt *cert)</span><br><span> {</span><br><span>@@ -259=
,16 +277,17 @@</span><br><span>     }</span><br><span> </span><br><span>   =
  /* Find field_oid in the subject name=2E */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    mbedtls_x509_name *name =3D &amp;cert-&gt;subje=
ct;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (name !=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtl=
s_x509_name *name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    mbedtls_x509_name *next =3D &amp;cert-&gt;subject;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    while (next !=3D NULL)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (strlen(field_oid) =3D=3D name-&gt;oid=2Elen</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; 0 =3D=3D memcmp(name=
-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (strlen(field_oid) =3D=3D next-&gt;oid=
=2Elen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
amp;&amp; 0 =3D=3D memcmp(next-&gt;oid=2Ep, field_oid, next-&gt;oid=2Elen))=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            break;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            name =3D next;</span><br><span>         }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name =3D nam=
e-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
next =3D next-&gt;next;</span><br><span>     }</span><br><span> </span><br>=
<span>     /* Not found, return an error if this is the peer&#39;s certific=
ate */</span><br><span>@@ -277,6 +296,11 @@</span><br><span>         goto f=
ail;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(&amp;name-&g=
t;val))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        goto fail;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Check that we ha=
ve room in the buffer, including the terminating &#39;/0&#39; byte=2E */</s=
pan><br><span>     if (cn_len &lt;=3D name-&gt;val=2Elen)</span><br><span> =
    {</span><br><span>@@ -586,22 +610,11 @@</span><br><span> static char *<=
/span><br><span> asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct =
gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    size_t i;</span><br><span>     char *val;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(orig-&gt;tag=
 =3D=3D MBEDTLS_ASN1_UTF8_STRING || orig-&gt;tag =3D=3D MBEDTLS_ASN1_PRINTA=
BLE_STRING</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          |=
| orig-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(orig))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* Only support C-string compatible types */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return string_alloc(&quot;ERROR: unsup=
ported ASN=2E1 string type&quot;, gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i =
&lt; orig-&gt;len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (or=
ig-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           return string_alloc(&quot;ERROR: embedded null value&quot;, gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return string_alloc(&qu=
ot;ERROR: Unsupported string type or embedded null bytes=2E&quot;, gc);</sp=
an><br><span>     }</span><br><span>     val =3D gc_malloc(orig-&gt;len + 1=
, false, gc);</span><br><span>     memcpy(val, orig-&gt;p, orig-&gt;len);</=
span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvp=
n/ssl_verify_openssl=2Ec</span><br><span>index a30099d=2E=2E1f2804f 100644<=
/span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>++=
+ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -196,12 +196,13 @=
@</span><br><span>     int lastpos =3D -1;</span><br><span>     int tmp =3D=
 -1;</span><br><span>     unsigned char *buf =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    result_t ret =3D FAILURE;</span><br>=
<span> </span><br><span>     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(fi=
eld_name, 0);</span><br><span>     if (field_name_obj =3D=3D NULL)</span><b=
r><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;Invalid X50=
9 attribute name &#39;%s&#39;&quot;, field_name);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>     }=
</span><br><span> </span><br><span>     ASSERT(size &gt; 0);</span><br><spa=
n>@@ -222,28 +223,31 @@</span><br><span>     /* Nothing found */</span><br>=
<span>     if (lastpos =3D=3D -1)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span> =
    }</span><br><span> </span><br><span>     const X509_NAME_ENTRY *x509ne =
=3D X509_NAME_get_entry(x509, lastpos);</span><br><span>     if (!x509ne)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto exit;</span><br><span>     }</span><br><span> </span><br><=
span>     const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);</sp=
an><br><span>     if (!asn1)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ASN1_STRING=
_to_UTF8(&amp;buf, asn1) &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int length =3D ASN1_STRING_to_UTF8(&amp;buf, asn1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (length &lt; 0 || (=
size_t)length !=3D strlen((char *)buf))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><=
span>     }</span><br><span> </span><br><span>     strncpynt(out, (char *)b=
uf, size);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const result_t ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS=
 : FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+exit:</span><br><span>     OPENSSL_free(buf);</span><br><=
span>     return ret;</span><br><span> }</span><br><span>@@ -384,9 +388,9 @=
@</span><br><span>         goto err;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Get the su=
bject with unescaped control characters so that we can check for null bytes=
=2E */</span><br><span>     X509_NAME_print_ex(subject_bio, X509_get_subjec=
t_name(cert), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                  XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8=
_CONVERT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
              | ASN1_STRFLGS_ESC_CTRL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_=
FN_SN | ASN1_STRFLGS_UTF8_CONVERT);</span><br><span> </span><br><span>     =
if (BIO_eof(subject_bio))</span><br><span>     {</span><br><span>@@ -394,6 =
+398,25 @@</span><br><span>     }</span><br><span> </span><br><span>     BI=
O_get_mem_ptr(subject_bio, &amp;subject_mem);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (memchr(subject_mem-&gt;data, 0, subject_m=
em-&gt;length) !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(M_WARN, &quot;ERROR: Certificate subject contains a &#39;\\0&#39; byte=
=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Now output the subject with escape=
d control characters=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (BIO_reset(subject_bio) !=3D 1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                       XN_FLAG_=
SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                           | ASN1_STR=
FLGS_ESC_CTRL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (BIO_eof(subject_bio))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO_get_mem_ptr(subj=
ect_bio, &amp;subject_mem);</span><br><span> </span><br><span>     subject =
=3D gc_malloc(subject_mem-&gt;length + 1, false, gc);</span><br><span> </sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/uni=
t_tests/openvpn/test_ssl=2Ec</span><br><span>index 7e7679c=2E=2Eadfc07a 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -884,6 =
+884,94 @@</span><br><span>     free_certificate(cert);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Certificate with two CNs, &quot;foo&quot; and &quot;bar&quot;=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Generated with:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * openssl req -x509 -newkey ec -pkeyopt ec_par=
amgen_curve:secp384r1 -subj &quot;/CN=3Dfoo/CN=3Dbar&quot; \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * -noenc -out two_cns=2Ecrt -keyo=
ut two_cns=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *=
cert_with_two_cns =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3oh=
oJ/Vza54wQwCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwO=
DI4MTU1NjAwWhcN\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2M=
BAG\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quo=
t;ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PvPMWGWzqe=
cTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &quot;hGBWFvnUsqdNo765lGwVdB=
whY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R=
81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQ=
tXzOWCPLRKId4e+E88\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16=
oZkBcm\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFICATE-----\n&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ssl_test_extract_last_matching_field(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* When there are multiple fiel=
ds of the same type in the certificate&#39;s subject, OpenVPN</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * should extract the value o=
f the last matching field=2E This is essentially arbitrary and there</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * is no correct choic=
e here, but this test exists to make sure that the behavior is consistent</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * between differ=
ent backends=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509=
_cert_t *cert =3D get_certificate(cert_with_two_cns);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(backend_=
x509_get_username(username, sizeof(username), &quot;CN&quot;, cert), SUCCES=
S);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(username, &quot;bar&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    free_certificate(cert);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Certificat=
e with a null-byte embedded in the CN=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Generated with the following Python script:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * from cryptography import x509</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * from cryptography=2Ex509=2Eoid import NameOID=
, ExtensionOID, ExtendedKeyUsageOID</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * from cryptography=2Ehazmat=2Eprimitives import hashes, s=
erialization</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from=
 cryptography=2Ehazmat=2Eprimitives=2Easymmetric import ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * import datetime</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * private_key =3D ec=2Egenerate_private_key(ec=2ESECP=
384R1())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * now =3D =
datetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * name =3D &quot;with\x00null&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * cert =3D (x509=2ECertificateBuilder()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Esu=
bject_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)])=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2E=
issuer_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
=2Epublic_key(private_key=2Epublic_key())</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             =2Eserial_number(x509=2Erandom_serial_=
number())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     =2Enot_valid_before(now)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             =2Enot_valid_after(now + datetime=2Etimedelta(days=
=3D10 * 365))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         =2Esign(private_key, hashes=2ESHA256()))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * print(str(cert=2Epublic_bytes(serialization=2EEncoding=2EPE=
M), encoding=3D&#39;utf-8&#39;))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ **/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic const char *cert_with_null =3D</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;MIIBZTCB66ADAgECAhRLWdN=
Rl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjY=
wODI4MTQzMDA4WhcNMzYwODI1MTQz\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkj=
OPQIBBgUrgQQAIgNi\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPa=
eiJY/\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &q=
uot;Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;GuEwCgYI=
KoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;k099bUFvHp/3LSp8Wf4J=
K2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbY=
r/Q=3D=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_test_re=
ject_null_in_cert_subject(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with_null);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Trying to get the sub=
ject as a whole should fail=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_ptr_equal(x509_get_subject(cert, &amp;gc), NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Trying to extract the common nam=
e should fail=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(backend_x509_get_userna=
me(username, sizeof(username), &quot;CN&quot;, cert), FAILURE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </=
span><br><span> int</span><br><span> main(void)</span><br><span>@@ -908,7 +=
996,9 @@</span><br><span>         cmocka_unit_test(test_data_channel_roundt=
rip_bf_cbc),</span><br><span>         cmocka_unit_test(test_data_channel_kn=
own_vectors_epoch),</span><br><span>         cmocka_unit_test(test_data_cha=
nnel_known_vectors_shortpktid),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        cmocka_unit_test(crypto_test_print_cert_details)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(cry=
pto_test_print_cert_details),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(ssl_test_extract_last_matching_field),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(ssl_test_reject_null_in_cert_subject)</span><br><span> </span><br><span=
>     };</span><br><span> </span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">c=
hange 1902</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> G=
errit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1902 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;=
openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@m=
ax-fillinger=2Enet&gt; </div>

</body></html>
--UwKEMRKezuU=--


--===============4913709149217786254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4913709149217786254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4913709149217786254==--

