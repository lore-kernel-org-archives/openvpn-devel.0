Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BB8C79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Lr2TXQAP1BQX4wRUhr3T3cpyXy9CW2m7izDAyIH0azc=; b=QkUY/XU8aalWCQ
	pwE86ggxZ9lpsMDH91MSEzrcVgdvAreg3rjry33rneayOpWgS2cyoPvUZwr7rfoooDKyOisOghS1e
	7DYgzk9hZIh4jKvLRoQft4e6/QzprhlAQm2nduoQIFgnic5qwjLEQL+Mp/qZgop0Zv4IybXnSYbvh
	5HY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3XkJ-00044w-4N;
	Mon, 07 Sep 2026 11:42:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3XkI-00044m-3t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CvhfvFjwc2Jna+EFZvC+/lA773qMmVjuTvnoSlAQ9n0=; b=CC6SmieAB5b1AfCI1hCavY5e/L
 sHGSs6zUEGf9dM6oVdW0luMdCtnNhYkbbnukY9+/ChNfppEc5A4c5sh6sk76+xKvC5zffnpXjkHgL
 rVVIkVSBa+W/zboTOGnYq0FUkWlI2uMnR0uUq8KrzsKJ0RYc1TUIFTQt9JFv0JxgiU+s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CvhfvFjwc2Jna+EFZvC+/lA773qMmVjuTvnoSlAQ9n0=; b=O
 n1BK1NiMgeu61zGtZdPtPlymdK0V3F68ycRRZwm8jwuPha0wJ+sqM9Ecf5S1gRmN08MRhsQZKSyro
 at8SFewcE6EiT7u24HVuSdO28FaT7Mql6iO1Cm4mXdGph8qna8mNUeNGlk5zwYQTFGRRk0krygpAc
 ms2QU684QiLom9ks=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3XkG-00078Q-JH for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:42:42 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4858269e3d9so252309f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 04:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788781354; x=1789386154; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CvhfvFjwc2Jna+EFZvC+/lA773qMmVjuTvnoSlAQ9n0=;
 b=g+/jYkwe9KRLcNWyxtyrTfS7eSV52CBlGZ8sqkRmbjMmztyn+JmXUcWgIVluQAfhIq
 l2620tfHQZSX7xYaPPJ3Nt+wdv9zsK5HoEPNYqtuumEP3Ttueab59zLxjWgVAvdtWdEm
 hn/oeNuMvjnrPujVwJHW08dTfjOa5dDkQZRrM0StkNLtKyl1ILSEP0+0tFz87bE04ho6
 NvNPkJCnnhuS0rzDsiL5swY9NFj5L92BY8iSO8spMxA0UI4Idr2PteDILejCc6aF8SZe
 ZQ09GH8BdAlp2SxZUtrb02bk6LCM0wxNHYjB6I4Kp+Y2lKT6tlDYnKO1IbEP8ld7thnD
 vGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781354; x=1789386154;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CvhfvFjwc2Jna+EFZvC+/lA773qMmVjuTvnoSlAQ9n0=;
 b=GWxpHWg74fGFmolXUuASZ8uT3Bj6npXpD5E81BXHkmzDusJLIlgOBjQv35r58QTQz5
 pppUW68TgEjRVQXix8rdNSd+o33AFr/hvqUvpNw/Wz0XM38uDP6+jZm7yLQPwcyuXRXk
 iRWq1S77DWgOziRhRjMjr17hIvhPE+DNR3RwiB8pD8eY44lj/wJUAWO9ALmBoGXJUv11
 nECHojUaf6IY6+bTTCGa+LAw7+pFjuS+E6K0VuR1ZFpLEfmtm/FXNSfMw4K07/QRxSut
 yTjqsMLMl2bHrjo/R4ivKq4X1/TkETVKnldInWDEFe6CJd3vpc4ygbn9Bgt2VGhmSSeD
 REGg==
X-Gm-Message-State: AFuF++kqS+PVFIcTp9xP4BietGQyPWGkkWTkZ/G9kCf7NYja/dJYRK1+
 lIc+Vl5u1GG0W9rku75Tqej0IYkHOgD5yUvs0PJU6x0So4NjyYnxGXFAdC41l4KT4LO53wukc0n
 +CE/aYnICxK4v/TeGEnGb6OjVCo17iLrt2jXQ6fh9FJ1G/obTYzLXHrQwZizbGOd9kT+RVWMibN
 8iHsNtAQ==
X-Gm-Gg: AYBFou2dhgjuccv/02wfOBtsaYQWRHpUvWTBoPHsc8YCmIYCULRBudZnXByuzQcZa5c
 819h7Q7Vc40v7DKr/2wnGieZG9ThTX8ZoJgOLtp7TN/ekkXr0zB/0Y2rpiGp/z1wG18WtPujaDv
 52K1e+rc7oxIPQbgKzq8BIwaLEJm+VXg0VUQdVyYYJysn5gZx+WCRXUmCFtwRIiYt3g6/8caG3V
 FXXMJco1pGAjLSbeLvL1O8FqLEYCWj6HTWt2xdZucMI/t276aNPmqEZ3gHzshfSHc0Rmdh002xd
 OKwO9xRKC1wafvnl6/f1+mNP0+i3h8XAQa2jtnlIE06M3saGT7hdPFyBMLDXoC0hcjUUm6qWAnT
 cgoJqTVHOjBqPsTRkFzk72OZpx7pFIsn0DufkBZnG6Ai00FqB5iE32qbY5lBN2HB+SAdzi+ma5i
 PE3e4Q56u3pnI8c4JoTKx/vkgemMoPUrXbHfSfN38ieewd+waChChmmvCrYeeOBLy3//R4qnIsZ
 xEtZm7c/r8cUsvUCukz+YCwl0GY+grcygkM23BdiEab82Z53iaWCUcbHBonXqLNdI3tb+aWdBfa
 RI5XA779OEWlxqqo77Xs86BKrezEBG72gjc8Mm9B5yNR4Huja7Y=
X-Received: by 2002:a05:600c:a00a:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49cf81f6736mr455019365e9.6.1788781353285; 
 Mon, 07 Sep 2026 04:42:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d03543064sm213444055e9.13.2026.09.07.04.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:42:32 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 11:42:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: efb1f77d28be164260bf4235949ee81f9aff5124
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3689bfa1cffc45fe95b61bbc06456771fed9479a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3XkG-00078Q-JH
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
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2489186032993509359=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2489186032993509359==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ur744OS47GM="; charset=UTF-8

--ur744OS47GM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1902?usp=3Demail

to review the following change=2E


Chang=
e subject: Check for null-bytes in certificate subjects
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Check for null-bytes in certifi=
cate subjects

When using the OpenSSL library, we escaped embedded null-byt=
es in a
certificate's subject in x509_get_subject(), but in
extract_x509_fi=
eld_ssl(), we copied any null-bytes that are contained in
the field value=
=2E When using the option --verify-x509-name, this could
lead to an incorre=
ct name being accepted=2E For example, the common name
"admin\0impersonator=
" would be accepted when running with
--verify-x509-name admin name=2E

To =
fix this, this commit makes x509_get_subject() return an error if the
subje=
ct contains an embedded null-byte=2E This way, OpenVPN won't connect
with p=
eers that present such certificates=2E

As a defense-in-depth measure, we a=
lso check for null-bytes in
extract_x509_field_ssl() in case a future versi=
on of OpenVPN has a code
path that avoids x509_get_subject()=2E

With Mbed =
TLS, the x509_get_subject() function already returned an error
when there i=
s an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Here too, we
added a c=
heck for null-bytes to the function where we extract individual
fields from=
 the subject=2E

Also, backend_x509_get_username() is changed so that it re=
turns the
value of the *last* matching field, to be consistent with the beh=
avior
of the OpenSSL backend=2E

This is a partial backport of the commit
"=
Check for \0 and RFC 2253 chars in cert subjects" from the master
branch bu=
t skipping the part about escaping RFC 2253 characters to avoid
user-visibl=
e changes in a patch release=2E We do not consider the
null-byte check "use=
r-visible" because we don't expect users to put
null-bytes into the common =
name=2E

Discovered and reported by BreachX Zero Day Labs, using Typhon AI =
Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

CVE: 2026-84790
Reporte=
d-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn-pr=
ivate-issues#163

Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Sign=
ed-off-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
---
M src/=
openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M tests=
/unit_tests/openvpn/test_ssl=2Ec
3 files changed, 145 insertions(+), 29 del=
etions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/02/1902/1

diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openv=
pn/ssl_verify_mbedtls=2Ec
index 66cc66e=2E=2E1319c07 100644
--- a/src/openv=
pn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -214,=
6 +214,24 @@
     }
 }
 
+static bool
+asn1_buf_is_cstr_compatible(const mb=
edtls_asn1_buf *asn1_buf)
+{
+    if (!(asn1_buf->tag =3D=3D MBEDTLS_ASN1_U=
TF8_STRING || asn1_buf->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING
+         =
 || asn1_buf->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    {
+        return f=
alse;
+    }
+    for (size_t i =3D 0; i < asn1_buf->len; i++)
+    {
+    =
    if (asn1_buf->p[i] =3D=3D '\0')
+        {
+            return false;
+=
        }
+    }
+    return true;
+}
+
 result_t
 backend_x509_get_usernam=
e(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cer=
t)
 {
@@ -259,16 +277,17 @@
     }
 
     /* Find field_oid in the subject =
name=2E */
-    mbedtls_x509_name *name =3D &cert->subject;
-    while (nam=
e !=3D NULL)
+    mbedtls_x509_name *name =3D NULL;
+    mbedtls_x509_name =
*next =3D &cert->subject;
+    while (next !=3D NULL)
     {
-        if (s=
trlen(field_oid) =3D=3D name->oid=2Elen
-            && 0 =3D=3D memcmp(nam=
e->oid=2Ep, field_oid, name->oid=2Elen))
+        if (strlen(field_oid) =3D=
=3D next->oid=2Elen
+            && 0 =3D=3D memcmp(next->oid=2Ep, field_oi=
d, next->oid=2Elen))
         {
-            break;
+            name =3D n=
ext;
         }
 
-        name =3D name->next;
+        next =3D next->nex=
t;
     }
 
     /* Not found, return an error if this is the peer's certif=
icate */
@@ -277,6 +296,11 @@
         goto fail;
     }
 
+    if (!asn1_b=
uf_is_cstr_compatible(&name->val))
+    {
+        goto fail;
+    }
+
    =
 /* Check that we have room in the buffer, including the terminating '/0' b=
yte=2E */
     if (cn_len <=3D name->val=2Elen)
     {
@@ -586,22 +610,11 @=
@
 static char *
 asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct=
 gc_arena *gc)
 {
-    size_t i;
     char *val;
 
-    if (!(orig->tag =3D=
=3D MBEDTLS_ASN1_UTF8_STRING || orig->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STR=
ING
-          || orig->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    if (!asn1=
_buf_is_cstr_compatible(orig))
     {
-        /* Only support C-string com=
patible types */
-        return string_alloc("ERROR: unsupported ASN=2E1 s=
tring type", gc);
-    }
-
-    for (i =3D 0; i < orig->len; ++i)
-    {
- =
       if (orig->p[i] =3D=3D '\0')
-        {
-            return string_al=
loc("ERROR: embedded null value", gc);
-        }
+        return string_al=
loc("ERROR: Unsupported string type or embedded null bytes=2E", gc);
     }=

     val =3D gc_malloc(orig->len + 1, false, gc);
     memcpy(val, orig->p=
, orig->len);
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn=
/ssl_verify_openssl=2Ec
index a30099d=2E=2E1d1dcde 100644
--- a/src/openvpn=
/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -196,12=
 +196,13 @@
     int lastpos =3D -1;
     int tmp =3D -1;
     unsigned cha=
r *buf =3D NULL;
+    result_t ret =3D FAILURE;
 
     ASN1_OBJECT *field_n=
ame_obj =3D OBJ_txt2obj(field_name, 0);
     if (field_name_obj =3D=3D NULL=
)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", fie=
ld_name);
-        return FAILURE;
+        goto exit;
     }
 
     ASSERT=
(size > 0);
@@ -222,28 +223,31 @@
     /* Nothing found */
     if (lastpos=
 =3D=3D -1)
     {
-        return FAILURE;
+        goto exit;
     }
 
  =
   const X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entry(x509, lastpos);
  =
   if (!x509ne)
     {
-        return FAILURE;
+        goto exit;
     }
=
 
     const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);
     i=
f (!asn1)
     {
-        return FAILURE;
+        goto exit;
     }
-    i=
f (ASN1_STRING_to_UTF8(&buf, asn1) < 0)
+    int length =3D ASN1_STRING_to_=
UTF8(&buf, asn1);
+    if (length < 0 || (size_t)length !=3D strlen((char *=
)buf))
     {
-        return FAILURE;
+        goto exit;
     }
 
     st=
rncpynt(out, (char *)buf, size);
 
-    const result_t ret =3D (strlen((cha=
r *)buf) < size) ? SUCCESS : FAILURE;
+    ret =3D (strlen((char *)buf) < s=
ize) ? SUCCESS : FAILURE;
+
+exit:
     OPENSSL_free(buf);
     return ret;=

 }
@@ -385,8 +389,7 @@
     }
 
     X509_NAME_print_ex(subject_bio, X509_=
get_subject_name(cert), 0,
-                       XN_FLAG_SEP_CPLUS_SPC | =
XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
-                           | ASN=
1_STRFLGS_ESC_CTRL);
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLA=
G_FN_SN | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
    =
 {
@@ -395,6 +398,16 @@
 
     BIO_get_mem_ptr(subject_bio, &subject_mem);
=
 
+    /* Check subject for '\0' bytes=2E */
+    for (size_t i =3D 0; i < =
subject_mem->length; i++)
+    {
+        if (subject_mem->data[i] =3D=3D 0=
)
+        {
+            msg(M_WARN, "ERROR: Certificate subject contains =
a '\\0' byte=2E");
+            goto err;
+        }
+    }
+
     subject =
=3D gc_malloc(subject_mem->length + 1, false, gc);
 
     memcpy(subject, s=
ubject_mem->data, subject_mem->length);
diff --git a/tests/unit_tests/openv=
pn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 7e7679c=2E=2E=
adfc07a 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit=
_tests/openvpn/test_ssl=2Ec
@@ -884,6 +884,94 @@
     free_certificate(cert=
);
 }
 
+/* Certificate with two CNs, "foo" and "bar"=2E
+ *
+ * Generated =
with:
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1=
 -subj "/CN=3Dfoo/CN=3Dbar" \
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: release/2=2E7
Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88=
427571
Gerrit-Change-Number: 1902
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <ma=
x@max-fillinger=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ur744OS47GM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>MaxF would like plaisthos to <st=
rong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Che=
ck for null-bytes in certificate subjects<br><br>When using the OpenSSL lib=
rary, we escaped embedded null-bytes in a<br>certificate&#39;s subject in x=
509_get_subject(), but in<br>extract_x509_field_ssl(), we copied any null-b=
ytes that are contained in<br>the field value=2E When using the option --ve=
rify-x509-name, this could<br>lead to an incorrect name being accepted=2E F=
or example, the common name<br>&quot;admin\0impersonator&quot; would be acc=
epted when running with<br>--verify-x509-name admin name=2E<br><br>To fix t=
his, this commit makes x509_get_subject() return an error if the<br>subject=
 contains an embedded null-byte=2E This way, OpenVPN won&#39;t connect<br>w=
ith peers that present such certificates=2E<br><br>As a defense-in-depth me=
asure, we also check for null-bytes in<br>extract_x509_field_ssl() in case =
a future version of OpenVPN has a code<br>path that avoids x509_get_subject=
()=2E<br><br>With Mbed TLS, the x509_get_subject() function already returne=
d an error<br>when there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=
=2E) Here too, we<br>added a check for null-bytes to the function where we =
extract individual<br>fields from the subject=2E<br><br>Also, backend_x509_=
get_username() is changed so that it returns the<br>value of the *last* mat=
ching field, to be consistent with the behavior<br>of the OpenSSL backend=
=2E<br><br>This is a partial backport of the commit<br>&quot;Check for \0 a=
nd RFC 2253 chars in cert subjects&quot; from the master<br>branch but skip=
ping the part about escaping RFC 2253 characters to avoid<br>user-visible c=
hanges in a patch release=2E We do not consider the<br>null-byte check &quo=
t;user-visible&quot; because we don&#39;t expect users to put<br>null-bytes=
 into the common name=2E<br><br>Discovered and reported by BreachX Zero Day=
 Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=
=2E<br><br>CVE: 2026-84790<br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@=
breachx=2Eai&gt;<br>Github: OpenVPN/openvpn-private-issues#163<br><br>Chang=
e-Id: Iea1481e94ba1abe18c39d81cd797187c88427571<br>Signed-off-by: Max Filli=
nger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M src/openvpn/=
ssl_verify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M tests/u=
nit_tests/openvpn/test_ssl=2Ec<br>3 files changed, 145 insertions(+), 29 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/02/1902/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_=
verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>ind=
ex 66cc66e=2E=2E1319c07 100644</span><br><span>--- a/src/openvpn/ssl_verify=
_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span=
><br><span>@@ -214,6 +214,24 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+asn1_buf_is=
_cstr_compatible(const mbedtls_asn1_buf *asn1_buf)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!(asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || =
asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          || asn1_buf-&gt;tag =3D=3D MBED=
TLS_ASN1_IA5_STRING))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0;=
 i &lt; asn1_buf-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (asn1_buf-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> res=
ult_t</span><br><span> backend_x509_get_username(char *cn, size_t cn_len, c=
har *x509_username_field, mbedtls_x509_crt *cert)</span><br><span> {</span>=
<br><span>@@ -259,16 +277,17 @@</span><br><span>     }</span><br><span> </s=
pan><br><span>     /* Find field_oid in the subject name=2E */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_x509_name *name =3D &a=
mp;cert-&gt;subject;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   while (name !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    mbedtls_x509_name *name =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    mbedtls_x509_name *next =3D &amp;cert-&gt;subje=
ct;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (next =
!=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (strlen(field_oid) =3D=3D name-&gt;oid=2Elen</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; 0 =3D=
=3D memcmp(name-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(field_oid) =3D=
=3D next-&gt;oid=2Elen</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &amp;&amp; 0 =3D=3D memcmp(next-&gt;oid=2Ep, field_oid, next=
-&gt;oid=2Elen))</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            name =3D next;</span><br><span>         }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    name =3D name-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        next =3D next-&gt;next;</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* Not found, return an error if this is the pee=
r&#39;s certificate */</span><br><span>@@ -277,6 +296,11 @@</span><br><span=
>         goto fail;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compati=
ble(&amp;name-&gt;val))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        go=
to fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* =
Check that we have room in the buffer, including the terminating &#39;/0&#3=
9; byte=2E */</span><br><span>     if (cn_len &lt;=3D name-&gt;val=2Elen)</=
span><br><span>     {</span><br><span>@@ -586,22 +610,11 @@</span><br><span=
> static char *</span><br><span> asn1_buf_to_c_string(const mbedtls_asn1_bu=
f *orig, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    size_t i;</span><br><span>     char *val;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!(orig-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || orig-&gt;tag =3D=3D MBE=
DTLS_ASN1_PRINTABLE_STRING</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-          || orig-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compa=
tible(orig))</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /* Only support C-string compatible types */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return string_alloc(&q=
uot;ERROR: unsupported ASN=2E1 string type&quot;, gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (i =3D 0; i &lt; orig-&gt;len; ++i)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (orig-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            return string_alloc(&quot;ERROR: embedded null v=
alue&quot;, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
string_alloc(&quot;ERROR: Unsupported string type or embedded null bytes=2E=
&quot;, gc);</span><br><span>     }</span><br><span>     val =3D gc_malloc(=
orig-&gt;len + 1, false, gc);</span><br><span>     memcpy(val, orig-&gt;p, =
orig-&gt;len);</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=
=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index a30099d=2E=
=2E1d1dcde 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@=
 -196,12 +196,13 @@</span><br><span>     int lastpos =3D -1;</span><br><spa=
n>     int tmp =3D -1;</span><br><span>     unsigned char *buf =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    result_t ret =3D F=
AILURE;</span><br><span> </span><br><span>     ASN1_OBJECT *field_name_obj =
=3D OBJ_txt2obj(field_name, 0);</span><br><span>     if (field_name_obj =3D=
=3D NULL)</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS,=
 &quot;Invalid X509 attribute name &#39;%s&#39;&quot;, field_name);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span>=
<br><span>     }</span><br><span> </span><br><span>     ASSERT(size &gt; 0)=
;</span><br><span>@@ -222,28 +223,31 @@</span><br><span>     /* Nothing fou=
nd */</span><br><span>     if (lastpos =3D=3D -1)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</=
span><br><span>     }</span><br><span> </span><br><span>     const X509_NAM=
E_ENTRY *x509ne =3D X509_NAME_get_entry(x509, lastpos);</span><br><span>   =
  if (!x509ne)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br><sp=
an> </span><br><span>     const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_d=
ata(x509ne);</span><br><span>     if (!asn1)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (ASN1_STRING_to_UTF8(&amp;buf, asn1) &lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int length =3D ASN1_STRING_to_UTF8(&amp;buf,=
 asn1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (leng=
th &lt; 0 || (size_t)length !=3D strlen((char *)buf))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILU=
RE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exi=
t;</span><br><span>     }</span><br><span> </span><br><span>     strncpynt(=
out, (char *)buf, size);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const result_t ret =3D (strlen((char *)buf) &lt; s=
ize) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+exit:</span><br><span>     OPENSSL_free(b=
uf);</span><br><span>     return ret;</span><br><span> }</span><br><span>@@=
 -385,8 +389,7 @@</span><br><span>     }</span><br><span> </span><br><span>=
     X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                       XN_FL=
AG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                           | ASN1_ST=
RFLGS_ESC_CTRL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UT=
F8_CONVERT);</span><br><span> </span><br><span>     if (BIO_eof(subject_bio=
))</span><br><span>     {</span><br><span>@@ -395,6 +398,16 @@</span><br><s=
pan> </span><br><span>     BIO_get_mem_ptr(subject_bio, &amp;subject_mem);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Check subject for &#39;\0&#39; bytes=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; subject_mem-&gt=
;length; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (subject_=
mem-&gt;data[i] =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_WARN, &quot;ERROR: Certificate subject contains a &#39;\\0&#3=
9; byte=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     s=
ubject =3D gc_malloc(subject_mem-&gt;length + 1, false, gc);</span><br><spa=
n> </span><br><span>     memcpy(subject, subject_mem-&gt;data, subject_mem-=
&gt;length);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=
=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>index 7e7679c=
=2E=2Eadfc07a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ss=
l=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>@@ -884,6 +884,94 @@</span><br><span>     free_certificate(cert);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Certificate with two CNs, &quot;foo&quot; and &quot;bar&q=
uot;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Generated with:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * openssl req -x509 -newkey e=
c -pkeyopt ec_paramgen_curve:secp384r1 -subj &quot;/CN=3Dfoo/CN=3Dbar&quot;=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * -noenc -out tw=
o_cns=2Ecrt -keyout two_cns=2Ekey</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic const char *cert_with_two_cns =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MIIByTCCAVCgAwIBAgIU=
Zuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQ=
DDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDA=
KBgNVBAMMA2JhcjB2MBAG\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZ=
DfhpDnE/h\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;hGBW=
FvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;dFT/BNoJMB8GA1Ud=
IwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;/wQFMAMBAf8wCgYIKoZIzj0EAwID=
ZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E88\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBp=
T/JqF41uK57H+8i/16oZkBcm\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CE=
RTIFICATE-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ssl_test_extract_last_matching=
_field(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* When there=
 are multiple fields of the same type in the certificate&#39;s subject, Ope=
nVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * should e=
xtract the value of the last matching field=2E This is essentially arbitrar=
y and there</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * i=
s no correct choice here, but this test exists to make sure that the behavi=
or is consistent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * between different backends=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with_two_cns);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char username[TLS_USERNAME_LEN + 1] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(backend_x509_get_username(username, sizeof(username), &quot;CN&=
quot;, cert), SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(username, &quot;bar&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Certificate with a null-byte embedded in the CN=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Generated with the following Python script:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * from cryptography import x509</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ex509=
=2Eoid import NameOID, ExtensionOID, ExtendedKeyUsageOID</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ehazmat=2Eprimit=
ives import hashes, serialization</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * from cryptography=2Ehazmat=2Eprimitives=2Easymmetric impor=
t ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * import datet=
ime</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * private_key =3D ec=2Egenerate_=
private_key(ec=2ESECP384R1())</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * now =3D datetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * name =3D &quot;wit=
h\x00null&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cert =3D (x509=2EC=
ertificateBuilder()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             =2Esubject_name(x509=2EName([x509=2ENameAttribute(NameOID=2E=
COMMON_NAME, name)]))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             =2Eissuer_name(x509=2EName([x509=2ENameAttribute(NameOID=
=2ECOMMON_NAME, name)]))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             =2Epublic_key(private_key=2Epublic_key())</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             =2Eserial_number(x=
509=2Erandom_serial_number())</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             =2Enot_valid_before(now)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             =2Enot_valid_after(now + datet=
ime=2Etimedelta(days=3D10 * 365))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             =2Esign(private_key, hashes=2ESHA256()))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * print(str(cert=2Epublic_bytes(serializ=
ation=2EEncoding=2EPEM), encoding=3D&#39;utf-8&#39;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ **/</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static const char *cert_with_null =3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MI=
IBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MRIwEAYDVQQDDA=
l3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDA4WjAUMRIwEAYDVQQDDAl3aX=
RoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8He=
YE8M2iXYCIRW5wg6/mlPaeiJY/\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJ=
yVtoRBvkNvy5+k\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP7=
5i\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;EzZyRyPM3PG=
R83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ssl_test_reject_null_in_cert_subject(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_certificate(cer=
t_with_null);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* T=
rying to get the subject as a whole should fail=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(x509_get_subject(cer=
t, &amp;gc), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Trying to ex=
tract the common name should fail=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(bac=
kend_x509_get_username(username, sizeof(username), &quot;CN&quot;, cert), F=
AILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_=
certificate(cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span> </span><br><span> int</span><br><span> main(void)</span><=
br><span>@@ -908,7 +996,9 @@</span><br><span>         cmocka_unit_test(test=
_data_channel_roundtrip_bf_cbc),</span><br><span>         cmocka_unit_test(=
test_data_channel_known_vectors_epoch),</span><br><span>         cmocka_uni=
t_test(test_data_channel_known_vectors_shortpktid),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(crypto_test_print_=
cert_details)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(crypto_test_print_cert_details),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract=
_last_matching_field),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(ssl_test_reject_null_in_cert_subject)</span><br=
><span> </span><br><span>     };</span><br><span> </span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1902?usp=3Demail">change 1902</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1902?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c884=
27571 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1902 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--ur744OS47GM=--


--===============2489186032993509359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2489186032993509359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2489186032993509359==--

