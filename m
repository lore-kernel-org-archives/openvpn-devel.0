Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA6CC982D6
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6oTzi7xDUbIv6dKwbogj0PshTF3FykzJ4qk/SE429M8=; b=N0Alg3MB2POIr8kY+DJxzi9SM6
	3gmA3Z/dqjPCko2wTFNsdYBBiBSCMtn8VypAzQ6og4q3TuT7fwjybJbCt2+KCAQ0ZvuN08rzxomIp
	Hr/AE5gFfmzUmXo9VpAcz6y/SJfoD2HuqbWLCqMo9lNxQtpHhACseEGfQJJ4fr6G4GGA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Fsl-0003mb-93;
	Thu, 17 Sep 2026 17:26:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Fsk-0003mU-1z
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:26:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5v4LdoT7pWbfLTqJ1x0cWufCM9e1MQVZDXwtlRU6of4=; b=SG466QLpPoAPaucQbUBzTdkhom
 DS7W31gwrdgonQGaCqgyxqF/014kdf+PpjnuneqtCWk3xu7eBmWWeY2asgP5qAC1yzunNQRvxzQ2S
 m8MLOhSRcFqrF9wVGxZAShZCGLMQWkUF7Q80xlX4Mh/PPwPz857/4m6W9GgDpdAMlGgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5v4LdoT7pWbfLTqJ1x0cWufCM9e1MQVZDXwtlRU6of4=; b=k
 g+FdZv4PGFM2UI2HZF6l5GzmjFwTVjh1IgOyd51yjvIwg2TjmteAAznwMeFfjHfbxWBSYP4HxY5BK
 hz4U4kUP1nHdfVoa2jb65n8OBfTasTWHiuR0o+4r54CAyLmZgzQHNOUroRMWtWbtq1V4jxdM3eG+7
 FQsyZ+aWie6qvllg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Fsf-0007Bz-If for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:26:43 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so8612155e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789665995; x=1790270795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5v4LdoT7pWbfLTqJ1x0cWufCM9e1MQVZDXwtlRU6of4=;
 b=JrPgG4mgyIExkS/sVJelZgzCUmqVB+3kT5Sxn50VSLgPifRQRsU1KndoMAUda7vT7I
 8z6RiwHHO4THct/YJYzx6sJMGdaEg2YQEfd6alD/i1L/E52dWWUxLPXsooxLvSZWa3nn
 qqvyEDqILmX6guFk18MKDTF01gj9g11/lXiDLA7J2xBnnprW6QAaQnLbW109n0cgnXz0
 c7Lx3kU8DlIfOj01bXe2wyXqqmKsay0NYbuAOPbBhyhPxknFcJP5vNoG2pBehCAR7fo9
 5RaUgS2VhuaO5fz5ZOUz1iAxc7GIy2rX7J/mYQ2jrM+0s8kN91BKoB4OvxsaSkLuxQqh
 AL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665995; x=1790270795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5v4LdoT7pWbfLTqJ1x0cWufCM9e1MQVZDXwtlRU6of4=;
 b=dtK16CklzaJvF253f8dzV0jV6Xdb0fwH02dvKNPxR7jIZ7U2endfwssIDiUtRYJsW4
 aoPsT78VJUMdU0QzWCbZIquDMdxnG2rF5JYhT3EAO6eoUMYgN3ui0haBWNne2/HyEShn
 mRnKbgOS2C1BURCZDUiVNyT80Wg2fDTV4us26pZYecU51pUFBXO0/n8RkoU6b7mUSTiT
 mJ/RJbOwacYXltA8+Cu9owEffG80doBmv0VSl6sL1pIBjzigFBrH0V+bSzE3VhruzqsF
 fpwstOHG5odLT3I2qy3ANGlZ420ABcq/UHdEwZyNxi7T+yh1+bzIH6YTdj8k8Jfn7VuD
 RrRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWiOkt/jBNr32NdBFZ5FQFpGZ+4JZoXuzVPLW9P9A6GcCHL31GaBdrvPlExR6mkVm8+UezNSERz8LEvfuX@lists.sourceforge.net
X-Gm-Message-State: AFuF++lnkicyWcCIilwirBZsUxEQyg7aJKSZXC9/8v8o0TOF5G6TCs1H
 AWHjCay2ct/wfwZGz+UHtTFzqsRDZDY7alf4I/Wp4Ffx858qVNoNtTk2oRsWCMkQe+P0Yn+Dct7
 Qi44FHQ+CjFnvD1Aw8OXfES6opMtfXEspgXsyFf9k2RjtCBg7QJUIOZnmVW4EJ9j/p3/x
X-Gm-Gg: AYBFou1pngf1FC94v/R67mHrIbWqUYtq98r7d+sBPgYEBrxY+aMSB+qyZ5qADnphkKe
 PW1uE9hesIEfIBESV2+X23CKFWci4VtW33I8LANUBI7W7hvm0wtQ1qtNP54zMaajzW8KitHT0Gg
 b7MI8KkHqPzyF/WKvEC1lXzg3+JlwH/Y3JHk97JJqKAd3HbG8zA0M6As843JZCfr2F4mk/1ht5W
 017ZEwpgdnqOVy9QgjARFzI3v9Hig8b39KztN5QRpbmh9E51tnBV3WR0qadls7HTjOSJcq9eoIq
 fmqefUqLVc/SZgtlCzQ/mF0zRMrB5ZLiLPx+hmlMv7p0teavSTADgO986ViFz+DRy7LEg3M7SSx
 2Vz9ht8QLBEY2OG1SCtEIpk1Kd5i57G7RYJMRc/4vYNx8udSrLSt3mxed1Yi9ylm33Qdg5N2MzI
 sMLMIwPApgF74tyB6zi0Hqn+zHtA6TL+ExWMkVccGcCtKM/3zFMEzxc0bkwGgxsGCooVrQmrjM3
 KaDqQmB9R90Y92ZkxRQV3ZY6Dt2s74rqfCai9iyUPJyc3g7NQr9wXGy8TTGVZGMzdFvYWM+aFor
 0KKZFT4UNoarSSXFEvwJrDLgO88HVBDGw+8vob5AmKLXyfwSh/ylIb7KN4InlekxC4nzBf+j
X-Received: by 2002:a05:600c:350d:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49eac463a22mr94996565e9.3.1789665994709; 
 Thu, 17 Sep 2026 10:26:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc47cdf39sm3081265e9.2.2026.09.17.10.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:26:34 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 17:26:34 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: cf4384eef4676a01bd3ee98fa602f7b2af8079ea
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <50e920b40f81d613d5f5e5ad46a5a725917c312b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Fsf-0007Bz-If
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8596018119609344910=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8596018119609344910==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jDFYC9AXl6Y="; charset=UTF-8

--jDFYC9AXl6Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1902?usp=3Demail )

Change subject: Check for null-bytes in certificate=
 subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

C=
heck for null-bytes in certificate subjects

When using the OpenSSL library=
, we escaped embedded null-bytes in a
certificate's subject in x509_get_sub=
ject(), but in
extract_x509_field_ssl(), we copied any null-bytes that are =
contained in
the field value=2E When using the option --verify-x509-name, t=
his could
lead to an incorrect name being accepted=2E For example, the comm=
on name
"admin\0impersonator" would be accepted when running with
--verify-=
x509-name admin name=2E

To fix this, this commit makes x509_get_subject() =
return an error if the
subject contains an embedded null-byte=2E This way, =
OpenVPN won't connect
with peers that present such certificates=2E

As a de=
fense-in-depth measure, we also check for null-bytes in
extract_x509_field_=
ssl() in case a future version of OpenVPN has a code
path that avoids x509_=
get_subject()=2E

With Mbed TLS, the x509_get_subject() function already re=
turned an error
when there is an embedded null-byte=2E (As of Mbed TLS 3=2E=
5=2E) Here too, we
added a check for null-bytes to the function where we ex=
tract individual
fields from the subject=2E

Also, backend_x509_get_usernam=
e() is changed so that it returns the
value of the *last* matching field, t=
o be consistent with the behavior
of the OpenSSL backend=2E

This is a part=
ial backport of the commit
"Check for \0 and RFC 2253 chars in cert subject=
s" from the master
branch but skipping the part about escaping RFC 2253 cha=
racters to avoid
user-visible changes in a patch release=2E We do not consi=
der the
null-byte check "user-visible" because we don't expect users to put=

null-bytes into the common name=2E

v2: The previous version of the commit=
 unescaped control characters in
the subject, so it had user-visible change=
s after all=2E This version
escapes any control characters in the subject=
=2E

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil =
v2=2E
Contributing Researcher: Vivek Parikh=2E

CVE: 2026-84790
Reported-by=
: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn-privat=
e-issues#163

Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Signed-o=
ff-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
Acked-by: Stef=
fan Karger <steffan@karger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1902
Message-Id: <20260917124610=2E14291-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg39304=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_op=
enssl=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
3 files changed, 155 inse=
rtions(+), 29 deletions(-)




diff --git a/src/openvpn/ssl_verify_mbedtls=
=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index 66cc66e=2E=2E1319c07 100644=

--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbed=
tls=2Ec
@@ -214,6 +214,24 @@
     }
 }
 
+static bool
+asn1_buf_is_cstr_com=
patible(const mbedtls_asn1_buf *asn1_buf)
+{
+    if (!(asn1_buf->tag =3D=
=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf->tag =3D=3D MBEDTLS_ASN1_PRINTABLE=
_STRING
+          || asn1_buf->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    {=

+        return false;
+    }
+    for (size_t i =3D 0; i < asn1_buf->len;=
 i++)
+    {
+        if (asn1_buf->p[i] =3D=3D '\0')
+        {
+         =
   return false;
+        }
+    }
+    return true;
+}
+
 result_t
 backen=
d_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, mbe=
dtls_x509_crt *cert)
 {
@@ -259,16 +277,17 @@
     }
 
     /* Find field_o=
id in the subject name=2E */
-    mbedtls_x509_name *name =3D &cert->subjec=
t;
-    while (name !=3D NULL)
+    mbedtls_x509_name *name =3D NULL;
+    =
mbedtls_x509_name *next =3D &cert->subject;
+    while (next !=3D NULL)
   =
  {
-        if (strlen(field_oid) =3D=3D name->oid=2Elen
-            && 0=
 =3D=3D memcmp(name->oid=2Ep, field_oid, name->oid=2Elen))
+        if (str=
len(field_oid) =3D=3D next->oid=2Elen
+            && 0 =3D=3D memcmp(next-=
>oid=2Ep, field_oid, next->oid=2Elen))
         {
-            break;
+    =
        name =3D next;
         }
 
-        name =3D name->next;
+        =
next =3D next->next;
     }
 
     /* Not found, return an error if this is=
 the peer's certificate */
@@ -277,6 +296,11 @@
         goto fail;
     }
=
 
+    if (!asn1_buf_is_cstr_compatible(&name->val))
+    {
+        goto f=
ail;
+    }
+
     /* Check that we have room in the buffer, including the =
terminating '/0' byte=2E */
     if (cn_len <=3D name->val=2Elen)
     {
@@=
 -586,22 +610,11 @@
 static char *
 asn1_buf_to_c_string(const mbedtls_asn1=
_buf *orig, struct gc_arena *gc)
 {
-    size_t i;
     char *val;
 
-    i=
f (!(orig->tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || orig->tag =3D=3D MBEDTLS_=
ASN1_PRINTABLE_STRING
-          || orig->tag =3D=3D MBEDTLS_ASN1_IA5_STRIN=
G))
+    if (!asn1_buf_is_cstr_compatible(orig))
     {
-        /* Only su=
pport C-string compatible types */
-        return string_alloc("ERROR: uns=
upported ASN=2E1 string type", gc);
-    }
-
-    for (i =3D 0; i < orig->l=
en; ++i)
-    {
-        if (orig->p[i] =3D=3D '\0')
-        {
-          =
  return string_alloc("ERROR: embedded null value", gc);
-        }
+      =
  return string_alloc("ERROR: Unsupported string type or embedded null byte=
s=2E", gc);
     }
     val =3D gc_malloc(orig->len + 1, false, gc);
     m=
emcpy(val, orig->p, orig->len);
diff --git a/src/openvpn/ssl_verify_openssl=
=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index a30099d=2E=2E1f2804f 100644=

--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_open=
ssl=2Ec
@@ -196,12 +196,13 @@
     int lastpos =3D -1;
     int tmp =3D -1;=

     unsigned char *buf =3D NULL;
+    result_t ret =3D FAILURE;
 
     AS=
N1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
     if (field_na=
me_obj =3D=3D NULL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribu=
te name '%s'", field_name);
-        return FAILURE;
+        goto exit;
  =
   }
 
     ASSERT(size > 0);
@@ -222,28 +223,31 @@
     /* Nothing found *=
/
     if (lastpos =3D=3D -1)
     {
-        return FAILURE;
+        goto=
 exit;
     }
 
     const X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entry(=
x509, lastpos);
     if (!x509ne)
     {
-        return FAILURE;
+        =
goto exit;
     }
 
     const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_da=
ta(x509ne);
     if (!asn1)
     {
-        return FAILURE;
+        goto e=
xit;
     }
-    if (ASN1_STRING_to_UTF8(&buf, asn1) < 0)
+    int length =
=3D ASN1_STRING_to_UTF8(&buf, asn1);
+    if (length < 0 || (size_t)length =
!=3D strlen((char *)buf))
     {
-        return FAILURE;
+        goto exi=
t;
     }
 
     strncpynt(out, (char *)buf, size);
 
-    const result_t r=
et =3D (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+    ret =3D (strl=
en((char *)buf) < size) ? SUCCESS : FAILURE;
+
+exit:
     OPENSSL_free(buf=
);
     return ret;
 }
@@ -384,9 +388,9 @@
         goto err;
     }
 
+   =
 /* Get the subject with unescaped control characters so that we can check =
for null bytes=2E */
     X509_NAME_print_ex(subject_bio, X509_get_subject_=
name(cert), 0,
-                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_S=
N | ASN1_STRFLGS_UTF8_CONVERT
-                           | ASN1_STRFLGS_ES=
C_CTRL);
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | AS=
N1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
     {
@@ -394,6=
 +398,25 @@
     }
 
     BIO_get_mem_ptr(subject_bio, &subject_mem);
+    =
if (memchr(subject_mem->data, 0, subject_mem->length) !=3D NULL)
+    {
+  =
      msg(M_WARN, "ERROR: Certificate subject contains a '\\0' byte=2E");
+=
        goto err;
+    }
+
+    /* Now output the subject with escaped cont=
rol characters=2E */
+    if (BIO_reset(subject_bio) !=3D 1)
+    {
+      =
  goto err;
+    }
+    X509_NAME_print_ex(subject_bio, X509_get_subject_na=
me(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN =
| ASN1_STRFLGS_UTF8_CONVERT
+                           | ASN1_STRFLGS_ESC_=
CTRL);
+    if (BIO_eof(subject_bio))
+    {
+        goto err;
+    }
+   =
 BIO_get_mem_ptr(subject_bio, &subject_mem);
 
     subject =3D gc_malloc(s=
ubject_mem->length + 1, false, gc);
 
diff --git a/tests/unit_tests/openvpn=
/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 7e7679c=2E=2Ead=
fc07a 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_t=
ests/openvpn/test_ssl=2Ec
@@ -884,6 +884,94 @@
     free_certificate(cert);=

 }
 
+/* Certificate with two CNs, "foo" and "bar"=2E
+ *
+ * Generated wi=
th:
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -=
subj "/CN=3Dfoo/CN=3Dbar" \
+ * -noenc -out two_cns=2Ecrt -keyout two_cns=
=2Ekey
+ */
+static const char *cert_with_two_cns =3D
+    "-----BEGIN CERT=
IFICATE-----\n"
+    "MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIK=
oZIzj0EAwIw\n"
+    "HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MT=
U1NjAwWhcN\n"
+    "MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2J=
hcjB2MBAG\n"
+    "ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZD=
fhpDnE/h\n"
+    "PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRC=
JIuHSGA\n"
+    "hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Sy=
k0qyTI\n"
+    "dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1U=
dEwEB\n"
+    "/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e=
+E88\n"
+    "cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZk=
Bcm\n"
+    "OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n"
+    "-----END C=
ERTIFICATE-----\n";
+
+void
+ssl_test_extract_last_matching_field(void **st=
ate)
+{
+    /* When there are multiple fields of the same type in the cert=
ificate's subject, OpenVPN
+     * should extract the value of the last mat=
ching field=2E This is essentially arbitrary and there
+     * is no correc=
t choice here, but this test exists to make sure that the behavior is consi=
stent
+     * between different backends=2E
+     */
+    openvpn_x509_cert=
_t *cert =3D get_certificate(cert_with_two_cns);
+
+    char username[TLS_U=
SERNAME_LEN + 1] =3D { 0 };
+    assert_int_equal(backend_x509_get_username=
(username, sizeof(username), "CN", cert), SUCCESS);
+    assert_string_equa=
l(username, "bar");
+    free_certificate(cert);
+}
+
+/* Certificate with =
a null-byte embedded in the CN=2E
+ *
+ * Generated with the following Pyth=
on script:
+ *
+ * from cryptography import x509
+ * from cryptography=2Ex5=
09=2Eoid import NameOID, ExtensionOID, ExtendedKeyUsageOID
+ * from cryptog=
raphy=2Ehazmat=2Eprimitives import hashes, serialization
+ * from cryptogra=
phy=2Ehazmat=2Eprimitives=2Easymmetric import ec
+ * import datetime
+ *
+ =
* private_key =3D ec=2Egenerate_private_key(ec=2ESECP384R1())
+ * now =3D d=
atetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)
+ * name =3D "with\x00n=
ull"
+ *
+ * cert =3D (x509=2ECertificateBuilder()
+ *             =2Esubje=
ct_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))
+=
 *             =2Eissuer_name(x509=2EName([x509=2ENameAttribute(NameOID=2EC=
OMMON_NAME, name)]))
+ *             =2Epublic_key(private_key=2Epublic_key=
())
+ *             =2Eserial_number(x509=2Erandom_serial_number())
+ *    =
         =2Enot_valid_before(now)
+ *             =2Enot_valid_after(now + =
datetime=2Etimedelta(days=3D10 * 365))
+ *             =2Esign(private_key,=
 hashes=2ESHA256()))
+ *
+ * print(str(cert=2Epublic_bytes(serialization=2E=
Encoding=2EPEM), encoding=3D'utf-8'))
+ **/
+static const char *cert_with_n=
ull =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIBZTCB66ADAgECAhRLWdNR=
l+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n"
+    "MRIwEAYDVQQDDAl3aXRoAG51b=
GwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n"
+    "MDA4WjAUMRIwEAYDVQQDDAl3aX=
RoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n"
+    "AAT7PE+vJCBiB4CVHBcvJVF9n5n=
/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n"
+    "Ywh3pa8zhto1+aczbJKTvLgRwXn6=
N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n"
+    "GuEwCgYIKoZIzj0EAwIDaQAwZgIxA=
P2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n"
+    "k099bUFvHp/3LSp8Wf4JK2iWzc5h6g=
IxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n"
+    "EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbY=
r/Q=3D=3D\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_reject_n=
ull_in_cert_subject(void **state)
+{
+    openvpn_x509_cert_t *cert =3D get=
_certificate(cert_with_null);
+    struct gc_arena gc =3D gc_new();
+
+    =
/* Trying to get the subject as a whole should fail=2E */
+    assert_ptr_e=
qual(x509_get_subject(cert, &gc), NULL);
+
+    /* Trying to extract the co=
mmon name should fail=2E */
+    char username[TLS_USERNAME_LEN + 1] =3D { =
0 };
+    assert_int_equal(backend_x509_get_username(username, sizeof(usern=
ame), "CN", cert), FAILURE);
+    gc_free(&gc);
+    free_certificate(cert)=
;
+}
 
 int
 main(void)
@@ -908,7 +996,9 @@
         cmocka_unit_test(test_=
data_channel_roundtrip_bf_cbc),
         cmocka_unit_test(test_data_channel=
_known_vectors_epoch),
         cmocka_unit_test(test_data_channel_known_ve=
ctors_shortpktid),
-        cmocka_unit_test(crypto_test_print_cert_details=
)
+        cmocka_unit_test(crypto_test_print_cert_details),
+        cmock=
a_unit_test(ssl_test_extract_last_matching_field),
+        cmocka_unit_tes=
t(ssl_test_reject_null_in_cert_subject)
 
     };
 

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: release/2=2E7
Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427=
571
Gerrit-Change-Number: 1902
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@m=
ax-fillinger=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--jDFYC9AXl6Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1902?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Check for null-bytes in certificate subjec=
ts<br><br>When using the OpenSSL library, we escaped embedded null-bytes in=
 a<br>certificate&#39;s subject in x509_get_subject(), but in<br>extract_x5=
09_field_ssl(), we copied any null-bytes that are contained in<br>the field=
 value=2E When using the option --verify-x509-name, this could<br>lead to a=
n incorrect name being accepted=2E For example, the common name<br>&quot;ad=
min\0impersonator&quot; would be accepted when running with<br>--verify-x50=
9-name admin name=2E<br><br>To fix this, this commit makes x509_get_subject=
() return an error if the<br>subject contains an embedded null-byte=2E This=
 way, OpenVPN won&#39;t connect<br>with peers that present such certificate=
s=2E<br><br>As a defense-in-depth measure, we also check for null-bytes in<=
br>extract_x509_field_ssl() in case a future version of OpenVPN has a code<=
br>path that avoids x509_get_subject()=2E<br><br>With Mbed TLS, the x509_ge=
t_subject() function already returned an error<br>when there is an embedded=
 null-byte=2E (As of Mbed TLS 3=2E5=2E) Here too, we<br>added a check for n=
ull-bytes to the function where we extract individual<br>fields from the su=
bject=2E<br><br>Also, backend_x509_get_username() is changed so that it ret=
urns the<br>value of the *last* matching field, to be consistent with the b=
ehavior<br>of the OpenSSL backend=2E<br><br>This is a partial backport of t=
he commit<br>&quot;Check for \0 and RFC 2253 chars in cert subjects&quot; f=
rom the master<br>branch but skipping the part about escaping RFC 2253 char=
acters to avoid<br>user-visible changes in a patch release=2E We do not con=
sider the<br>null-byte check &quot;user-visible&quot; because we don&#39;t =
expect users to put<br>null-bytes into the common name=2E<br><br>v2: The pr=
evious version of the commit unescaped control characters in<br>the subject=
, so it had user-visible changes after all=2E This version<br>escapes any c=
ontrol characters in the subject=2E<br><br>Discovered and reported by Breac=
hX Zero Day Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher: Viv=
ek Parikh=2E<br><br>CVE: 2026-84790<br>Reported-by: Vivek Parikh &lt;vivek=
=2Eparikh@breachx=2Eai&gt;<br>Github: OpenVPN/openvpn-private-issues#163<br=
><br>Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571<br>Signed-off-by:=
 Max Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>Acked-by: S=
teffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1902<br>Message-Id: &lt;20260917124610=2E14291-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg39304=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify_mbe=
dtls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M tests/unit_tests/open=
vpn/test_ssl=2Ec<br>3 files changed, 155 insertions(+), 29 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn=
/ssl_verify_mbedtls=2Ec</span><br><span>index 66cc66e=2E=2E1319c07 100644</=
span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++=
 b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -214,6 +214,24 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+asn1_buf_is_cstr_compatible(const mbedtls=
_asn1_buf *asn1_buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!(asn1_bu=
f-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf-&gt;tag =3D=3D MBEDTL=
S_ASN1_PRINTABLE_STRING</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+          || asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; asn1_buf-&gt;len; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (asn1_buf-&gt;p[i] =
=3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> result_t</span><br><span> back=
end_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, m=
bedtls_x509_crt *cert)</span><br><span> {</span><br><span>@@ -259,16 +277,1=
7 @@</span><br><span>     }</span><br><span> </span><br><span>     /* Find =
field_oid in the subject name=2E */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    mbedtls_x509_name *name =3D &amp;cert-&gt;subject;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    while (name !=3D NULL)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_x509_name=
 *name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 mbedtls_x509_name *next =3D &amp;cert-&gt;subject;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (next !=3D NULL)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (s=
trlen(field_oid) =3D=3D name-&gt;oid=2Elen</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            &amp;&amp; 0 =3D=3D memcmp(name-&gt;oid=2E=
p, field_oid, name-&gt;oid=2Elen))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (strlen(field_oid) =3D=3D next-&gt;oid=2Elen</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; 0=
 =3D=3D memcmp(next-&gt;oid=2Ep, field_oid, next-&gt;oid=2Elen))</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      name =3D next;</span><br><span>         }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        name =3D name-&gt;next;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        next =3D ne=
xt-&gt;next;</span><br><span>     }</span><br><span> </span><br><span>     =
/* Not found, return an error if this is the peer&#39;s certificate */</spa=
n><br><span>@@ -277,6 +296,11 @@</span><br><span>         goto fail;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(&amp;name-&gt;val))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        goto fail;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     /* Check that we have room in =
the buffer, including the terminating &#39;/0&#39; byte=2E */</span><br><sp=
an>     if (cn_len &lt;=3D name-&gt;val=2Elen)</span><br><span>     {</span=
><br><span>@@ -586,22 +610,11 @@</span><br><span> static char *</span><br><=
span> asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *g=
c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    size_t i;</span><br><span>     char *val;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!(orig-&gt;tag =3D=3D MBE=
DTLS_ASN1_UTF8_STRING || orig-&gt;tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-          || orig-&gt;=
tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(orig))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* On=
ly support C-string compatible types */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return string_alloc(&quot;ERROR: unsupported ASN=
=2E1 string type&quot;, gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; orig-=
&gt;len; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (orig-&gt;p[i=
] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 return string_alloc(&quot;ERROR: embedded null value&quot;, gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return string_alloc(&quot;ERROR: =
Unsupported string type or embedded null bytes=2E&quot;, gc);</span><br><sp=
an>     }</span><br><span>     val =3D gc_malloc(orig-&gt;len + 1, false, g=
c);</span><br><span>     memcpy(val, orig-&gt;p, orig-&gt;len);</span><br><=
span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_veri=
fy_openssl=2Ec</span><br><span>index a30099d=2E=2E1f2804f 100644</span><br>=
<span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_verify_openssl=2Ec</span><br><span>@@ -196,12 +196,13 @@</span><b=
r><span>     int lastpos =3D -1;</span><br><span>     int tmp =3D -1;</span=
><br><span>     unsigned char *buf =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    result_t ret =3D FAILURE;</span><br><span> </s=
pan><br><span>     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, =
0);</span><br><span>     if (field_name_obj =3D=3D NULL)</span><br><span>  =
   {</span><br><span>         msg(D_TLS_ERRORS, &quot;Invalid X509 attribut=
e name &#39;%s&#39;&quot;, field_name);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br><=
span> </span><br><span>     ASSERT(size &gt; 0);</span><br><span>@@ -222,28=
 +223,31 @@</span><br><span>     /* Nothing found */</span><br><span>     i=
f (lastpos =3D=3D -1)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span>=
<br><span> </span><br><span>     const X509_NAME_ENTRY *x509ne =3D X509_NAM=
E_get_entry(x509, lastpos);</span><br><span>     if (!x509ne)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto exit;</span><br><span>     }</span><br><span> </span><br><span>     co=
nst ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);</span><br><span=
>     if (!asn1)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (ASN1_STRING_to_UTF8(&amp;=
buf, asn1) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int length =3D ASN1_STRING_to_UTF8(&amp;buf, asn1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (length &lt; 0 || (size_t)length =
!=3D strlen((char *)buf))</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</s=
pan><br><span> </span><br><span>     strncpynt(out, (char *)buf, size);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st result_t ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D (strlen((c=
har *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+exit:</span><br><span>     OPENSSL_free(buf);</span><br><span>     retu=
rn ret;</span><br><span> }</span><br><span>@@ -384,9 +388,9 @@</span><br><s=
pan>         goto err;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Get the subject with une=
scaped control characters so that we can check for null bytes=2E */</span><=
br><span>     X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), =
0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
    XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
| ASN1_STRFLGS_ESC_CTRL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_S=
TRFLGS_UTF8_CONVERT);</span><br><span> </span><br><span>     if (BIO_eof(su=
bject_bio))</span><br><span>     {</span><br><span>@@ -394,6 +398,25 @@</sp=
an><br><span>     }</span><br><span> </span><br><span>     BIO_get_mem_ptr(=
subject_bio, &amp;subject_mem);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (memchr(subject_mem-&gt;data, 0, subject_mem-&gt;length)=
 !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &q=
uot;ERROR: Certificate subject contains a &#39;\\0&#39; byte=2E&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Now output the subject with escaped control charact=
ers=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BI=
O_reset(subject_bio) !=3D 1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_NAME_print_e=
x(subject_bio, X509_get_subject_name(cert), 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                       XN_FLAG_SEP_CPLUS_SPC | X=
N_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                           | ASN1_STRFLGS_ESC_CTRL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BIO_eof(subje=
ct_bio))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    BIO_get_mem_ptr(subject_bio, &amp;sub=
ject_mem);</span><br><span> </span><br><span>     subject =3D gc_malloc(sub=
ject_mem-&gt;length + 1, false, gc);</span><br><span> </span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/t=
est_ssl=2Ec</span><br><span>index 7e7679c=2E=2Eadfc07a 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -884,6 +884,94 @@</span>=
<br><span>     free_certificate(cert);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Certificate with=
 two CNs, &quot;foo&quot; and &quot;bar&quot;=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Generated with:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp3=
84r1 -subj &quot;/CN=3Dfoo/CN=3Dbar&quot; \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * -noenc -out two_cns=2Ecrt -keyout two_cns=2Ekey<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static const char *cert_with_two_cns=
 =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----=
BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKo=
ZIzj0EAwIw\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MjY=
wOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;ByqGSM49AgEGBSu=
BBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;PvPMWGWzqecTYdseArxZc0T/5Xm=
a36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0=
OBBYEFPwnD+wK9R81Syk0qyTI\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNo=
JMA8GA1UdEwEB\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E8=
8\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;OyQnlH8W/UzZ=
o3/weTEBTcNW0iuCpIrS6im8pSk=3D\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ssl_test_extract_last_matching_field(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* When there are multiple fields of the same ty=
pe in the certificate&#39;s subject, OpenVPN</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * should extract the value of the last matchi=
ng field=2E This is essentially arbitrary and there</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * is no correct choice here, but thi=
s test exists to make sure that the behavior is consistent</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * between different backends=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_cert_t *cert =
=3D get_certificate(cert_with_two_cns);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(backend_x509_get_use=
rname(username, sizeof(username), &quot;CN&quot;, cert), SUCCESS);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(user=
name, &quot;bar&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    free_certificate(cert);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Certificate with a nul=
l-byte embedded in the CN=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Gener=
ated with the following Python script:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * from cryptography import x509</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * from cryptography=2Ex509=2Eoid import NameOID, ExtensionO=
ID, ExtendedKeyUsageOID</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * from cryptography=2Ehazmat=2Eprimitives import hashes, serialization=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from cryptograph=
y=2Ehazmat=2Eprimitives=2Easymmetric import ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * import datetime</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * private_key =3D ec=2Egenerate_private_key(ec=2ESECP384R1())</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * now =3D datetime=2Ed=
atetime=2Enow(datetime=2Etimezone=2Eutc)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * name =3D &quot;with\x00null&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * cert =3D (x509=2ECertificateBuilder()</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             =2Esubject_name(x5=
09=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Eissuer_name(x=
509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Epublic_key(p=
rivate_key=2Epublic_key())</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             =2Eserial_number(x509=2Erandom_serial_number())</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Enot_val=
id_before(now)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          =2Enot_valid_after(now + datetime=2Etimedelta(days=3D10 * 365))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Esig=
n(private_key, hashes=2ESHA256()))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 print(str(cert=2Epublic_bytes(serialization=2EEncoding=2EPEM), encoding=3D=
&#39;utf-8&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char=
 *cert_with_null =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9H=
FPWlOtBzAKBggqhkjOPQQDAjAU\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4Wh=
cNMzYwODI1MTQz\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIg=
Ni\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;Ywh3pa8zhto=
1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;GuEwCgYIKoZIzj0EAwIDaQA=
wZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAIN=
BGg2xjlmMgpXxROKA9qQqaM3d92Mp\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END=
 CERTIFICATE-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_test_reject_null_in_cer=
t_subject(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x5=
09_cert_t *cert =3D get_certificate(cert_with_null);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Trying to get the subject as a who=
le should fail=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_ptr_equal(x509_get_subject(cert, &amp;gc), NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Trying to extract the common name should fail=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char user=
name[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(backend_x509_get_username(username, =
sizeof(username), &quot;CN&quot;, cert), FAILURE);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><sp=
an> int</span><br><span> main(void)</span><br><span>@@ -908,7 +996,9 @@</sp=
an><br><span>         cmocka_unit_test(test_data_channel_roundtrip_bf_cbc),=
</span><br><span>         cmocka_unit_test(test_data_channel_known_vectors_=
epoch),</span><br><span>         cmocka_unit_test(test_data_channel_known_v=
ectors_shortpktid),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      cmocka_unit_test(crypto_test_print_cert_details)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(crypto_test_pri=
nt_cert_details),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(ssl_test_extract_last_matching_field),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test=
_reject_null_in_cert_subject)</span><br><span> </span><br><span>     };</sp=
an><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 1902=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 Iea1481e94ba1abe18c39d81cd797187c88427571 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1902 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@m=
ax-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--jDFYC9AXl6Y=--


--===============8596018119609344910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8596018119609344910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8596018119609344910==--

