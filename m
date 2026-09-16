Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B8AC982C9
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78R8RTj6rbEwgGl5fxvacuLLn5MFoBfLEZ7qlclc4bY=; b=TSXZgelz+9HKMsHaI+EJtpqya9
	y+fetP04BnUjaFTgjypA7vxnV+UvGZ2Kg1BxEVJdA4bZcZT1xmWnayA1V/8hYsV+2vetMPr5Km8JJ
	x5lyLI/5krQrYhYVJ0UqqSKr8p26kxVrKG5G3XQXA1+ehYsBnN687AnwPbV/bDli4m58=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6xOe-0002K3-Gb;
	Wed, 16 Sep 2026 21:42:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6xOd-0002Jw-Er
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 21:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8BqGKMvzVuzWXPpO/XYcbueqApP58lN8UB0Z94g800c=; b=EWYtNJaIdHaQ8RBj3PunQA2wt4
 PgLEksjnOXUCO2wQA51H4m5lRt/JAJn5mWqiyO8IISi+xa597V98BNKO9PQjpCZk34+XMSdRIAZ1o
 ulDniFtw98GuSG7o4E1R9KvKnsmFYuCScHO8rHyXEfPpFB0R9SHQXHtFvTk8eEgSZTPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8BqGKMvzVuzWXPpO/XYcbueqApP58lN8UB0Z94g800c=; b=D
 Zo8umrd3sGPDuy6/Y5jBM6RjrOG3r+GNah2q2kwA18Yvw6zNmueKEv5sczWFbRoqxtqPOEYq8MGGx
 p7Ne4tR9+lUGygQzLbiFaV+43C13Y97I9FK+mNdLkdHttmf+HtwkyTw3IxThTd5iTTeE/leNy8fzp
 Mr5xIK2PQStYvsZ0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6xOa-000183-MA for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 21:42:27 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so1435505e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 14:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789594938; x=1790199738; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8BqGKMvzVuzWXPpO/XYcbueqApP58lN8UB0Z94g800c=;
 b=V0EnEC+zR5u6VMDhBqua2AQEUJONh2tuwMxwdFwwSY2zwiR68DlXSqv/CbUz+DNnkP
 LdaQ5BBbe1kytwSCXlmmXwSqNiFB6BtNXxeFNmVz8Un9HEz1NLZjCBaNOw1jumQaqevw
 9u2yO3k4kgyGJFRxfWchapmIKR6bVaimJ8fup5VLUM2T0pnn8W4vUyXzX5QobXSdrVei
 VyfKVK/T3lcHwIqKbf/7TlwxdxWIuDw8jfNhoZskV4KmTfy9jRJs388gPKzFGMSKMJI7
 nHrSGPJSGkh72Z5xpN8JG6bGLZkKSQSIvG3o+qRWTUkP2OMxLghqlA4Lmd3YZlA7mbPh
 jS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594938; x=1790199738;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8BqGKMvzVuzWXPpO/XYcbueqApP58lN8UB0Z94g800c=;
 b=RDU/1vfpharq+yTpf42OSGqMo7nCByvwC3w1TkboQskGQ6vg4q78GkZgNLb97c2/gu
 V/tt6JuOfDGSKG5MU0FtgGieg0iArfdqudfayvN/J/IOxK6Drgwei6Q6KhVsv02K70RS
 sz9X8Jv6jOYeXF1rGUI0UOhu8zVAHwafEXNsxbOmSNFejAw23GREOEVdrBtdvj7YOt3b
 ex43+NqpDpXe0IGWTbGIJej5WvzfSCCDSBHAs5l2qq0ycdFWzp2wmvhpjyvp4LkKzuIv
 EwpoPNtdi6VFhfRTCqtcuOBn40s+htHThBSEXOVefxNrQQeXBwXM8i6468s86xRJhjAi
 ssfg==
X-Gm-Message-State: AFuF++kX5dp98BElEi8UxUHPi97qf8TRzXZFm+qly+BH02TZF7xKRimm
 Pf1gsC27rzDCXAB+BOVCmxnE14HtAw26gJnzZGivW8XOD+RJRBblClpwXhsCrL/yCOAxNskXzBQ
 2BeyO7wY41s4YBKj7V6SZpytniG4SezQZAtLsYusSgO9Bct0rfkmzXrPM63ZtnoC7h3N6
X-Gm-Gg: AYBFou0lFzgvpWno5nFKhXUmjjQs9azE1Oy0EEFQPyuIFEXOAug2/SzP1Zahn7KS/rB
 D6sSnj+RplSQ/bC8BTdlqmk7clIFNxtoLhEuVF8y+WDKR5YCH/Ju3uS5s6gyvm8DzqASrbo1soe
 RZOxSOlWGDacMw4CMzdOEe2el68EZXQ5eKZWWZ2fXjnQXOJ6hgfmNVav8qp0G/grNwZ5LW1Eyov
 l6yDGeI22jBtUjplI4x3O43thu/PgGu9QsSiIeHOovZKnY0n3iTtoTBh91sjRh0Z4j27Lp654WP
 1mFSxLQDxuTJzsnYd4t95z4xylFYLq6Qk1uQU+N719V4g4AEhnHRRPR/pe/jP8ZpIEzNbCV7r1n
 cmZYR7JGlxKGKfOLCMchnl3FdpXWQsAJ0KqdxYXna8it/fcPfmeZktn3N9v1Vh2QOgQho7LQDtt
 oXEhMwQ1KUSGA1H5+80MdL0EpKnifwK44rHYESJICPQYbVZks2Pnuyy3XCbO7migDnpWh0a88v8
 ooEedx1K7zhbqB1srL4VCSGReilAT+aHl7+qH0IIQGBQuu3QDH82z+G3SD5Ly9SYPj0eVKeyUtD
 q6s01ZJWkZZBYsqvLg1+DaWJS3MCvgJpbqBDDvaHqwxr0ut9tUguTFHkv0lKUA==
X-Received: by 2002:a05:600c:1f8f:b0:49d:1de5:ce0a with SMTP id
 5b1f17b1804b1-49eb732052amr52182515e9.13.1789594937891; 
 Wed, 16 Sep 2026 14:42:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf4161fsm8917987f8f.34.2026.09.16.14.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:42:17 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 21:42:16 +0000
To: syzzer <steffan@karger.me>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: 124c4ffe53af78ba007ffe23de2f952fadfc30ae
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <164fe1704ff097571d5cd6f9b62d9264c93e46ab-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6xOa-000183-MA
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2223029647374011971=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2223029647374011971==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="orhnkY7S5nE="; charset=UTF-8

--orhnkY7S5nE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, syzzer=2E

Hello plaisthos=
, syzzer, 

I'd like you to reexamine a change=2E Please visit

    http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail

to look at the new pat=
ch set (#2)=2E

The following approvals got outdated and were removed:
Code=
-Review-1 by syzzer


Change subject: Check for null-bytes in certificate s=
ubjects
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
3 files changed, 158 insertions(+), 29 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02=
/1902/2

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
index a30099d=2E=2E5f133bc 100644
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
@@ -394,6 +398,28 @@
     }
 
  =
   BIO_get_mem_ptr(subject_bio, &subject_mem);
+    for (size_t i =3D 0; i =
< subject_mem->length; i++)
+    {
+        if (subject_mem->data[i] =3D=3D=
 0)
+        {
+            msg(M_WARN, "ERROR: Certificate subject contain=
s a '\\0' byte=2E");
+            goto err;
+        }
+    }
+
+    /* Now=
 output the subject with escaped control characters=2E */
+    if (!BIO_res=
et(subject_bio))
+    {
+        goto err;
+    }
+    X509_NAME_print_ex(s=
ubject_bio, X509_get_subject_name(cert), 0,
+                       XN_FLAG=
_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
+               =
            | ASN1_STRFLGS_ESC_CTRL);
+    if (BIO_eof(subject_bio))
+    {=

+        goto err;
+    }
+    BIO_get_mem_ptr(subject_bio, &subject_mem);=

 
     subject =3D gc_malloc(subject_mem->length + 1, false, gc);
 
diff -=
-git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/tes=
t_ssl=2Ec
index 7e7679c=2E=2Eadfc07a 100644
--- a/tests/unit_tests/openvpn/=
test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -884,6 +884,94 =
@@
     free_certificate(cert);
 }
 
+/* Certificate with two CNs, "foo" an=
d "bar"=2E
+ *
+ * Generated with:
+ * openssl req -x509 -newkey ec -pkeyop=
t ec_paramgen_curve:secp384r1 -subj "/CN=3Dfoo/CN=3Dbar" \
+ * -noenc -out =
two_cns=2Ecrt -keyout two_cns=2Ekey
+ */
+static const char *cert_with_two_=
cns =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIByTCCAVCgAwIBAgIUZuvd=
8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n"
+    "HDEMMAoGA1UEAwwDZm9vMQwwC=
gYDVQQDDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n"
+    "MjYwOTI3MTU1NjAwWjAcMQwwCg=
YDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n"
+    "ByqGSM49AgEGBSuBBAAiA2IABER=
Afb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n"
+    "PvPMWGWzqecTYdseArxZc0T/5Xma=
36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n"
+    "hGBWFvnUsqdNo765lGwVdBwhY6NTM=
FEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n"
+    "dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+=
wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n"
+    "/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwA=
wZAIwGxazGb6RRQtXzOWCPLRKId4e+E88\n"
+    "cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AK=
FUJjAjBpT/JqF41uK57H+8i/16oZkBcm\n"
+    "OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6=
im8pSk=3D\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_extract_=
last_matching_field(void **state)
+{
+    /* When there are multiple fields=
 of the same type in the certificate's subject, OpenVPN
+     * should extr=
act the value of the last matching field=2E This is essentially arbitrary a=
nd there
+     * is no correct choice here, but this test exists to make su=
re that the behavior is consistent
+     * between different backends=2E
+ =
    */
+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with_two_cns=
);
+
+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };
+    assert_int_eq=
ual(backend_x509_get_username(username, sizeof(username), "CN", cert), SUCC=
ESS);
+    assert_string_equal(username, "bar");
+    free_certificate(cert=
);
+}
+
+/* Certificate with a null-byte embedded in the CN=2E
+ *
+ * Gene=
rated with the following Python script:
+ *
+ * from cryptography import x5=
09
+ * from cryptography=2Ex509=2Eoid import NameOID, ExtensionOID, Extende=
dKeyUsageOID
+ * from cryptography=2Ehazmat=2Eprimitives import hashes, ser=
ialization
+ * from cryptography=2Ehazmat=2Eprimitives=2Easymmetric import =
ec
+ * import datetime
+ *
+ * private_key =3D ec=2Egenerate_private_key(ec=
=2ESECP384R1())
+ * now =3D datetime=2Edatetime=2Enow(datetime=2Etimezone=
=2Eutc)
+ * name =3D "with\x00null"
+ *
+ * cert =3D (x509=2ECertificateBui=
lder()
+ *             =2Esubject_name(x509=2EName([x509=2ENameAttribute(Na=
meOID=2ECOMMON_NAME, name)]))
+ *             =2Eissuer_name(x509=2EName([x=
509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))
+ *             =2Epubl=
ic_key(private_key=2Epublic_key())
+ *             =2Eserial_number(x509=2E=
random_serial_number())
+ *             =2Enot_valid_before(now)
+ *       =
      =2Enot_valid_after(now + datetime=2Etimedelta(days=3D10 * 365))
+ *  =
           =2Esign(private_key, hashes=2ESHA256()))
+ *
+ * print(str(cert=
=2Epublic_bytes(serialization=2EEncoding=2EPEM), encoding=3D'utf-8'))
+ **/=

+static const char *cert_with_null =3D
+    "-----BEGIN CERTIFICATE-----\n=
"
+    "MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n"=

+    "MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n"
=
+    "MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n"
+=
    "AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n"
+ =
   "Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n"
+  =
  "GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n"
+   =
 "k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n"
+    =
"EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n"
+    "-----END CERTIFICATE----=
-\n";
+
+void
+ssl_test_reject_null_in_cert_subject(void **state)
+{
+    o=
penvpn_x509_cert_t *cert =3D get_certificate(cert_with_null);
+    struct g=
c_arena gc =3D gc_new();
+
+    /* Trying to get the subject as a whole sho=
uld fail=2E */
+    assert_ptr_equal(x509_get_subject(cert, &gc), NULL);
+
=
+    /* Trying to extract the common name should fail=2E */
+    char usern=
ame[TLS_USERNAME_LEN + 1] =3D { 0 };
+    assert_int_equal(backend_x509_get=
_username(username, sizeof(username), "CN", cert), FAILURE);
+    gc_free(&=
gc);
+    free_certificate(cert);
+}
 
 int
 main(void)
@@ -908,7 +996,9 @@=

         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),
         cm=
ocka_unit_test(test_data_channel_known_vectors_epoch),
         cmocka_unit=
_test(test_data_channel_known_vectors_shortpktid),
-        cmocka_unit_tes=
t(crypto_test_print_cert_details)
+        cmocka_unit_test(crypto_test_pri=
nt_cert_details),
+        cmocka_unit_test(ssl_test_extract_last_matching_=
field),
+        cmocka_unit_test(ssl_test_reject_null_in_cert_subject)
 
 =
    };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: I=
ea1481e94ba1abe18c39d81cd797187c88427571
Gerrit-Change-Number: 1902
Gerrit-=
PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karg=
er=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: syzzer <steffan@karger=2Eme>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--orhnkY7S5nE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, syzzer=2E </p>
<p>MaxF <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by syzzer</p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Check for null-bytes in certificate subjects<br><br>When using the =
OpenSSL library, we escaped embedded null-bytes in a<br>certificate&#39;s s=
ubject in x509_get_subject(), but in<br>extract_x509_field_ssl(), we copied=
 any null-bytes that are contained in<br>the field value=2E When using the =
option --verify-x509-name, this could<br>lead to an incorrect name being ac=
cepted=2E For example, the common name<br>&quot;admin\0impersonator&quot; w=
ould be accepted when running with<br>--verify-x509-name admin name=2E<br><=
br>To fix this, this commit makes x509_get_subject() return an error if the=
<br>subject contains an embedded null-byte=2E This way, OpenVPN won&#39;t c=
onnect<br>with peers that present such certificates=2E<br><br>As a defense-=
in-depth measure, we also check for null-bytes in<br>extract_x509_field_ssl=
() in case a future version of OpenVPN has a code<br>path that avoids x509_=
get_subject()=2E<br><br>With Mbed TLS, the x509_get_subject() function alre=
ady returned an error<br>when there is an embedded null-byte=2E (As of Mbed=
 TLS 3=2E5=2E) Here too, we<br>added a check for null-bytes to the function=
 where we extract individual<br>fields from the subject=2E<br><br>Also, bac=
kend_x509_get_username() is changed so that it returns the<br>value of the =
*last* matching field, to be consistent with the behavior<br>of the OpenSSL=
 backend=2E<br><br>This is a partial backport of the commit<br>&quot;Check =
for \0 and RFC 2253 chars in cert subjects&quot; from the master<br>branch =
but skipping the part about escaping RFC 2253 characters to avoid<br>user-v=
isible changes in a patch release=2E We do not consider the<br>null-byte ch=
eck &quot;user-visible&quot; because we don&#39;t expect users to put<br>nu=
ll-bytes into the common name=2E<br><br>v2: The previous version of the com=
mit unescaped control characters in<br>the subject, so it had user-visible =
changes after all=2E This version<br>escapes any control characters in the =
subject=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using T=
yphon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>CVE: =
2026-84790<br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;=
<br>Github: OpenVPN/openvpn-private-issues#163<br><br>Change-Id: Iea1481e94=
ba1abe18c39d81cd797187c88427571<br>Signed-off-by: Max Fillinger &lt;maximil=
ian=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M src/openvpn/ssl_verify_mbedt=
ls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M tests/unit_tests/openvp=
n/test_ssl=2Ec<br>3 files changed, 158 insertions(+), 29 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/02/1902/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_mbedtls=
=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index 66cc66e=2E=
=2E1319c07 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@=
 -214,6 +214,24 @@</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+asn1_buf_is_cstr_compati=
ble(const mbedtls_asn1_buf *asn1_buf)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!(asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf-&gt;=
tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+          || asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_=
STRING))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; asn1_=
buf-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (asn1=
_buf-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> result_t</span><=
br><span> backend_x509_get_username(char *cn, size_t cn_len, char *x509_use=
rname_field, mbedtls_x509_crt *cert)</span><br><span> {</span><br><span>@@ =
-259,16 +277,17 @@</span><br><span>     }</span><br><span> </span><br><span=
>     /* Find field_oid in the subject name=2E */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    mbedtls_x509_name *name =3D &amp;cert-&gt;s=
ubject;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (nam=
e !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbe=
dtls_x509_name *name =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mbedtls_x509_name *next =3D &amp;cert-&gt;subject;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    while (next !=3D NULL)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (strlen(field_oid) =3D=3D name-&gt;oid=2Elen</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; 0 =3D=3D memcmp(nam=
e-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (strlen(field_oid) =3D=3D next-&gt;oi=
d=2Elen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&amp;&amp; 0 =3D=3D memcmp(next-&gt;oid=2Ep, field_oid, next-&gt;oid=2Elen)=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            name =3D next;</span><br><span>         }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name =3D na=
me-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 next =3D next-&gt;next;</span><br><span>     }</span><br><span> </span><br=
><span>     /* Not found, return an error if this is the peer&#39;s certifi=
cate */</span><br><span>@@ -277,6 +296,11 @@</span><br><span>         goto =
fail;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(&amp;name-&=
gt;val))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto fail;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Check that we h=
ave room in the buffer, including the terminating &#39;/0&#39; byte=2E */</=
span><br><span>     if (cn_len &lt;=3D name-&gt;val=2Elen)</span><br><span>=
     {</span><br><span>@@ -586,22 +610,11 @@</span><br><span> static char *=
</span><br><span> asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct=
 gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    size_t i;</span><br><span>     char *val;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(orig-&gt;ta=
g =3D=3D MBEDTLS_ASN1_UTF8_STRING || orig-&gt;tag =3D=3D MBEDTLS_ASN1_PRINT=
ABLE_STRING</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
|| orig-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(orig))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* Only support C-string compatible types */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return string_alloc(&quot;ERROR: un=
supported ASN=2E1 string type&quot;, gc);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0;=
 i &lt; orig-&gt;len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(orig-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            return string_alloc(&quot;ERROR: embedded null value&quot;, g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return string_alloc(=
&quot;ERROR: Unsupported string type or embedded null bytes=2E&quot;, gc);<=
/span><br><span>     }</span><br><span>     val =3D gc_malloc(orig-&gt;len =
+ 1, false, gc);</span><br><span>     memcpy(val, orig-&gt;p, orig-&gt;len)=
;</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/ope=
nvpn/ssl_verify_openssl=2Ec</span><br><span>index a30099d=2E=2E5f133bc 1006=
44</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -196,12 +196,1=
3 @@</span><br><span>     int lastpos =3D -1;</span><br><span>     int tmp =
=3D -1;</span><br><span>     unsigned char *buf =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    result_t ret =3D FAILURE;</span><=
br><span> </span><br><span>     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj=
(field_name, 0);</span><br><span>     if (field_name_obj =3D=3D NULL)</span=
><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;Invalid =
X509 attribute name &#39;%s&#39;&quot;, field_name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>    =
 }</span><br><span> </span><br><span>     ASSERT(size &gt; 0);</span><br><s=
pan>@@ -222,28 +223,31 @@</span><br><span>     /* Nothing found */</span><b=
r><span>     if (lastpos =3D=3D -1)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span=
>     }</span><br><span> </span><br><span>     const X509_NAME_ENTRY *x509n=
e =3D X509_NAME_get_entry(x509, lastpos);</span><br><span>     if (!x509ne)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        goto exit;</span><br><span>     }</span><br><span> </span><br=
><span>     const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);</=
span><br><span>     if (!asn1)</span><br><span>     {</span><br><span style=
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
+398,28 @@</span><br><span>     }</span><br><span> </span><br><span>     BI=
O_get_mem_ptr(subject_bio, &amp;subject_mem);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; subject_mem-&gt;l=
ength; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (subject_me=
m-&gt;data[i] =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_WARN, &quot;ERROR: Certificate subject contains a &#39;\\0&#39;=
 byte=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Now output the subject with escaped c=
ontrol characters=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!BIO_reset(subject_bio))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_NAME=
_print_ex(subject_bio, X509_get_subject_name(cert), 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       XN_FLAG_SEP_CPLUS=
_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                           | ASN1_STRFLGS_ESC_=
CTRL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BIO_e=
of(subject_bio))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    BIO_get_mem_ptr(subject_bio, =
&amp;subject_mem);</span><br><span> </span><br><span>     subject =3D gc_ma=
lloc(subject_mem-&gt;length + 1, false, gc);</span><br><span> </span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/o=
penvpn/test_ssl=2Ec</span><br><span>index 7e7679c=2E=2Eadfc07a 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -884,6 +884,94 @=
@</span><br><span>     free_certificate(cert);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Certific=
ate with two CNs, &quot;foo&quot; and &quot;bar&quot;=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Generated with:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_cur=
ve:secp384r1 -subj &quot;/CN=3Dfoo/CN=3Dbar&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * -noenc -out two_cns=2Ecrt -keyout two_=
cns=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *cert_wi=
th_two_cns =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza5=
4wQwCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &quot;HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1=
NjAwWhcN\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;ByqGS=
M49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PvPMWGWzqecTYdseA=
rxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;hGBWFvnUsqdNo765lGwVdBwhY6NTM=
FEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &quot;dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0q=
yTIdFT/BNoJMA8GA1UdEwEB\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &quot;/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCP=
LRKId4e+E88\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;Oy=
QnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFICATE-----\n&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ssl_test_extract_last_matching_field(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* When there are multiple fields of =
the same type in the certificate&#39;s subject, OpenVPN</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * should extract the value of the =
last matching field=2E This is essentially arbitrary and there</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * is no correct choice here=
, but this test exists to make sure that the behavior is consistent</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * between different ba=
ckends=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_cert_=
t *cert =3D get_certificate(cert_with_two_cns);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(backend_x509_g=
et_username(username, sizeof(username), &quot;CN&quot;, cert), SUCCESS);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(username, &quot;bar&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    free_certificate(cert);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Certificate with=
 a null-byte embedded in the CN=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Generated with the following Python script:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * from cryptography import x509</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * from cryptography=2Ex509=2Eoid import NameOID, Exte=
nsionOID, ExtendedKeyUsageOID</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * from cryptography=2Ehazmat=2Eprimitives import hashes, seriali=
zation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from crypt=
ography=2Ehazmat=2Eprimitives=2Easymmetric import ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * import datetime</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * private_key =3D ec=2Egenerate_private_key(ec=2ESECP384R=
1())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * now =3D date=
time=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * name =3D &quot;with\x00null&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * cert =3D (x509=2ECertificateBuilder()</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Esubject=
_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Eissue=
r_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Epubl=
ic_key(private_key=2Epublic_key())</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             =2Eserial_number(x509=2Erandom_serial_number(=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
=2Enot_valid_before(now)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             =2Enot_valid_after(now + datetime=2Etimedelta(days=3D10=
 * 365))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    =2Esign(private_key, hashes=2ESHA256()))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * print(str(cert=2Epublic_bytes(serialization=2EEncoding=2EPEM), e=
ncoding=3D&#39;utf-8&#39;))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ **/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
const char *cert_with_null =3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;MIIBZTCB66ADAgECAhRLWdNRl+C2=
0KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4=
MTQzMDA4WhcNMzYwODI1MTQz\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIB=
BgUrgQQAIgNi\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;Y=
wh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;GuEwCgYIKoZIz=
j0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;k099bUFvHp/3LSp8Wf4JK2iWz=
c5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=
=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quo=
t;-----END CERTIFICATE-----\n&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_test_reject_n=
ull_in_cert_subject(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
openvpn_x509_cert_t *cert =3D get_certificate(cert_with_null);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Trying to get the subject a=
s a whole should fail=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_ptr_equal(x509_get_subject(cert, &amp;gc), NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Trying to extract the common name shou=
ld fail=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar username[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(backend_x509_get_username(use=
rname, sizeof(username), &quot;CN&quot;, cert), FAILURE);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><=
br><span> int</span><br><span> main(void)</span><br><span>@@ -908,7 +996,9 =
@@</span><br><span>         cmocka_unit_test(test_data_channel_roundtrip_bf=
_cbc),</span><br><span>         cmocka_unit_test(test_data_channel_known_ve=
ctors_epoch),</span><br><span>         cmocka_unit_test(test_data_channel_k=
nown_vectors_shortpktid),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        cmocka_unit_test(crypto_test_print_cert_details)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(crypto_te=
st_print_cert_details),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(ssl_test_extract_last_matching_field),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ss=
l_test_reject_null_in_cert_subject)</span><br><span> </span><br><span>     =
};</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change =
1902</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1902 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Max=
F &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=

</body></html>
--orhnkY7S5nE=--


--===============2223029647374011971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2223029647374011971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2223029647374011971==--

