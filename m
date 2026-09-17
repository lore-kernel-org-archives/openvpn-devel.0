Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7376C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tV6yYU/n88Nz+cP/45HYlSMjAhIraeu5LHAxECJCrqY=; b=hb65ihC9dWVYQGfJW9jjAsaIPe
	utRscypWHuN688rGchq/fVHGbMS0r7CBecg0R6Z4xcv/fgznV6bCqkw3HgAFVhbPcTmGOujoV/iRj
	udXbA13kVLPDNO0DZGn9nbRrNkyEVXcxfGXZVx0XkmuHnfP/hvCgaWfpPItmzUj8qXr0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Fsh-0003rb-Ie;
	Thu, 17 Sep 2026 17:26:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Fsg-0003rU-UA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uhMopYRZqRnKa+OBxzQCyzLdp2cAVfWpuLcYFqsWuzw=; b=iNyICyBX3b6BYRbxWSebRqM4KL
 /GiqMaX378h/N3l58J3cfD0NlxrSMqXsshHy+olzLwNU7te/pWXPlkYMeB6N4Nule2jLiZ2nnWx0W
 n3w4SC9cSCACWAdyw2go4g1kR13NmjouAFrLFYe9KWvopFr5RPoHDGoy0IG5j4u39W/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uhMopYRZqRnKa+OBxzQCyzLdp2cAVfWpuLcYFqsWuzw=; b=W
 2SkfzyuMBzrdtXfIEd/cRp+svWHa9IClYNB9h6yhO+yv83Yn+i4PD/53ZMSX+899QI7MaPGFBpY9C
 7CoUI8SJHugpONpyXoIJMail/vE0NEt4uCSkihGnAERYiq7xTb0qVUg24NRI6+81Rf4XXbMvkj+BN
 1YBcQNWNsglFnI98=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Fse-0000gR-KT for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 17:26:42 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48431648f33so404284f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789665994; x=1790270794; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uhMopYRZqRnKa+OBxzQCyzLdp2cAVfWpuLcYFqsWuzw=;
 b=YiWqJowsBcdHjF7BXLvawnWHoiKzm5BcgkVhnIK3a8RvbR+1RdkPK8PYRsz1dO8UTn
 tvmTD31q2kMK0tadHIe173cca7/TshW4e50cf/FGc11VrMsahwHCTKI5blw4VvMz01ia
 FTxfovsIBrOFDZr0/F0UYsApeJsWva/MqrOidn31Y/VzuwHkFThegZbdeseHGGjtgeIx
 CmpR6giaxGNX0N+ZGZYZWHuoGBaaH5FRzi8NEcrE3QzMVMW1oVC34qcvXrD5IU7GWrYP
 W76206NvijqgR8oqyU7la80IBfzgiGWxbewOPJpbEBAErkNlSoSYCvVoxAlqOs/1XDoP
 UyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665994; x=1790270794;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uhMopYRZqRnKa+OBxzQCyzLdp2cAVfWpuLcYFqsWuzw=;
 b=woPBw91NUgChXz4XkQNMareNG9Vl1bMSMa1bUALNKXf97Nb3oA/fAKjK4/6a15Z17V
 0a/JgOpIpTumU6xExMDlWnRxLkJpl9x3YyXybFTYF4zx6BcNekL5BM/FOM+PI4TGtTUe
 vGeJSHGHQJOtq8MljU9BmLnFT/NCOzbMDsZy1wNUJxMFSVodMdshMElaLlrqpD3Ri8gs
 Ib+fLMJsl+mbURh1hs0vYSVMIYcD9sT5frJGo530uXYI427FKwXg/lCtHpW5253uszn0
 IWpwfdclTZVBvHZKHwu7xQPT3BTXFcz3DmF2pwzzSGoLxSEZHwdOmYCfa2xHtXeGFgZs
 HHwg==
X-Gm-Message-State: AFuF++lEQRLpjjVSlJx3iN4gFd5ckydsb/UIWTToGa5n+cPkqp7nLKNU
 TVXonp7DoaGv8W1+IW0FltNNvbEpD0i06UxkRNFTEP+rAImQcUL+itPzLtthBZJKR56mmxEbYYj
 8JJHcc0eHek4Gsp+vCOLHRDubAgWqwl3PqVKiyiEkcnyBr8Xg3/M+Mkcom/t+jd3vZNwT2gi87Z
 4tKouodg==
X-Gm-Gg: AYBFou28rvHqP9DhwDKRmxsb1ibgXgU5R7HKhiURTOO2bH4xH/UKcisRM9Xzbdae/Zu
 mt/biAgTQz4geweTl5YgUBsKu7rBN9VBRhpqME2sG9CRDRNPyJBBmNl3BP1lIdwiflWulB982Av
 YGXpW8cfEjGqf9FncJKYcyrq5j4I6arCmC6Exme1VOKH+iAvnfvO1aWwfc/coIDR8GztgWfqFqX
 vA6rO7hh7TCDJvDmr3AAyilqA0MA+e2MB0wc8gkhOvASb8AKQiIsty8RrMPfbO0qxbF/XKPebti
 uasSe/zSQE7a6DS5fNJ16VBmKJ1ZnJrQPuCLuzgqGQWJW68RK5C1QLxSKGC0uAL6tpNQqUuilp2
 KDRSmtT1GOZSauGDFEcCKyViBxG3InzWTehCZs2SWp/v/f7R98ztLU9wT1RRG1wMxPOlBI7h7q3
 f9QiPhrDx6TblYZH0P6y8ACIDMNtjWCzVUIC924aQrvE/mcmOZ7j0tDaPXaq9bVnidBFvW+zLYN
 /Nag44fL8TsyVDb9gQzRUTDKb64zTuT6MMuVqhlSEWWNhTzIo46xiL60ev5tD+IIINYj+vYmMSs
 jQHkZPnZDA+rqN9uWWD36Wj4Bs4NiTY7nTH/8HpirBycntVaPhVAUcZ4H8IVnFU=
X-Received: by 2002:a05:6000:4696:b0:486:fe83:4a52 with SMTP id
 ffacd0b85a97d-48713aff8d0mr4898010f8f.2.1789665993868; 
 Thu, 17 Sep 2026 10:26:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27198sm17237925f8f.15.2026.09.17.10.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:26:33 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 17:26:32 +0000
To: MaxF <max@max-fillinger.net>, syzzer <steffan@karger.me>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: cf4384eef4676a01bd3ee98fa602f7b2af8079ea
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <50e920b40f81d613d5f5e5ad46a5a725917c312b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Fse-0000gR-KT
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3385500907588604534=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3385500907588604534==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IwNeU1bbwUc="; charset=UTF-8

--IwNeU1bbwUc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by syzze=
r


Change subject: Check for null-bytes in certificate subjects
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Check for null-bytes i=
n certificate subjects

When using the OpenSSL library, we escaped embedded=
 null-bytes in a
certificate's subject in x509_get_subject(), but in
extrac=
t_x509_field_ssl(), we copied any null-bytes that are contained in
the fiel=
d value=2E When using the option --verify-x509-name, this could
lead to an =
incorrect name being accepted=2E For example, the common name
"admin\0imper=
sonator" would be accepted when running with
--verify-x509-name admin name=
=2E

To fix this, this commit makes x509_get_subject() return an error if t=
he
subject contains an embedded null-byte=2E This way, OpenVPN won't connec=
t
with peers that present such certificates=2E

As a defense-in-depth measu=
re, we also check for null-bytes in
extract_x509_field_ssl() in case a futu=
re version of OpenVPN has a code
path that avoids x509_get_subject()=2E

Wi=
th Mbed TLS, the x509_get_subject() function already returned an error
when=
 there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Here too, we
a=
dded a check for null-bytes to the function where we extract individual
fie=
lds from the subject=2E

Also, backend_x509_get_username() is changed so th=
at it returns the
value of the *last* matching field, to be consistent with=
 the behavior
of the OpenSSL backend=2E

This is a partial backport of the =
commit
"Check for \0 and RFC 2253 chars in cert subjects" from the master
b=
ranch but skipping the part about escaping RFC 2253 characters to avoid
use=
r-visible changes in a patch release=2E We do not consider the
null-byte ch=
eck "user-visible" because we don't expect users to put
null-bytes into the=
 common name=2E

v2: The previous version of the commit unescaped control c=
haracters in
the subject, so it had user-visible changes after all=2E This =
version
escapes any control characters in the subject=2E

Discovered and re=
ported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Res=
earcher: Vivek Parikh=2E

CVE: 2026-84790
Reported-by: Vivek Parikh <vivek=
=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn-private-issues#163

Change-=
Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Signed-off-by: Max Fillinger =
<maximilian=2Efillinger@sentyron=2Ecom>
Acked-by: Steffan Karger <steffan@k=
arger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902
Mes=
sage-Id: <20260917124610=2E14291-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39304=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M tests/unit_t=
ests/openvpn/test_ssl=2Ec
3 files changed, 155 insertions(+), 29 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/=
1902/4

diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_v=
erify_mbedtls=2Ec
index 66cc66e=2E=2E1319c07 100644
--- a/src/openvpn/ssl_v=
erify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -214,6 +214,2=
4 @@
     }
 }
 
+static bool
+asn1_buf_is_cstr_compatible(const mbedtls_as=
n1_buf *asn1_buf)
+{
+    if (!(asn1_buf->tag =3D=3D MBEDTLS_ASN1_UTF8_STRI=
NG || asn1_buf->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING
+          || asn1=
_buf->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    {
+        return false;
+ =
   }
+    for (size_t i =3D 0; i < asn1_buf->len; i++)
+    {
+        if (=
asn1_buf->p[i] =3D=3D '\0')
+        {
+            return false;
+        =
}
+    }
+    return true;
+}
+
 result_t
 backend_x509_get_username(char *=
cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
@@=
 -259,16 +277,17 @@
     }
 
     /* Find field_oid in the subject name=2E =
*/
-    mbedtls_x509_name *name =3D &cert->subject;
-    while (name !=3D N=
ULL)
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
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--IwNeU1bbwUc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by syzzer</p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">Check for null-bytes in certifica=
te subjects<br><br>When using the OpenSSL library, we escaped embedded null=
-bytes in a<br>certificate&#39;s subject in x509_get_subject(), but in<br>e=
xtract_x509_field_ssl(), we copied any null-bytes that are contained in<br>=
the field value=2E When using the option --verify-x509-name, this could<br>=
lead to an incorrect name being accepted=2E For example, the common name<br=
>&quot;admin\0impersonator&quot; would be accepted when running with<br>--v=
erify-x509-name admin name=2E<br><br>To fix this, this commit makes x509_ge=
t_subject() return an error if the<br>subject contains an embedded null-byt=
e=2E This way, OpenVPN won&#39;t connect<br>with peers that present such ce=
rtificates=2E<br><br>As a defense-in-depth measure, we also check for null-=
bytes in<br>extract_x509_field_ssl() in case a future version of OpenVPN ha=
s a code<br>path that avoids x509_get_subject()=2E<br><br>With Mbed TLS, th=
e x509_get_subject() function already returned an error<br>when there is an=
 embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Here too, we<br>added a ch=
eck for null-bytes to the function where we extract individual<br>fields fr=
om the subject=2E<br><br>Also, backend_x509_get_username() is changed so th=
at it returns the<br>value of the *last* matching field, to be consistent w=
ith the behavior<br>of the OpenSSL backend=2E<br><br>This is a partial back=
port of the commit<br>&quot;Check for \0 and RFC 2253 chars in cert subject=
s&quot; from the master<br>branch but skipping the part about escaping RFC =
2253 characters to avoid<br>user-visible changes in a patch release=2E We d=
o not consider the<br>null-byte check &quot;user-visible&quot; because we d=
on&#39;t expect users to put<br>null-bytes into the common name=2E<br><br>v=
2: The previous version of the commit unescaped control characters in<br>th=
e subject, so it had user-visible changes after all=2E This version<br>esca=
pes any control characters in the subject=2E<br><br>Discovered and reported=
 by BreachX Zero Day Labs, using Typhon AI Mil v2=2E<br>Contributing Resear=
cher: Vivek Parikh=2E<br><br>CVE: 2026-84790<br>Reported-by: Vivek Parikh &=
lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Github: OpenVPN/openvpn-private-issue=
s#163<br><br>Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571<br>Signed=
-off-by: Max Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>Ack=
ed-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1902<br>Message-Id: &lt;20260917124610=2E1=
4291-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg39304=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_ve=
rify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M tests/unit_te=
sts/openvpn/test_ssl=2Ec<br>3 files changed, 155 insertions(+), 29 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/02/1902/4</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify=
_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index 66c=
c66e=2E=2E1319c07 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedt=
ls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><=
span>@@ -214,6 +214,24 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+asn1_buf_is_cstr_=
compatible(const mbedtls_asn1_buf *asn1_buf)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!(asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_b=
uf-&gt;tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          || asn1_buf-&gt;tag =3D=3D MBEDTLS_AS=
N1_IA5_STRING))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt=
; asn1_buf-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (asn1_buf-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> result_t<=
/span><br><span> backend_x509_get_username(char *cn, size_t cn_len, char *x=
509_username_field, mbedtls_x509_crt *cert)</span><br><span> {</span><br><s=
pan>@@ -259,16 +277,17 @@</span><br><span>     }</span><br><span> </span><b=
r><span>     /* Find field_oid in the subject name=2E */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    mbedtls_x509_name *name =3D &amp;cer=
t-&gt;subject;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    whi=
le (name !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mbedtls_x509_name *name =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    mbedtls_x509_name *next =3D &amp;cert-&gt;subject;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (next !=3D N=
ULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (strlen(field_oid) =3D=3D name-&gt;oid=2Elen</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; 0 =3D=3D mem=
cmp(name-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (strlen(field_oid) =3D=3D next=
-&gt;oid=2Elen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &amp;&amp; 0 =3D=3D memcmp(next-&gt;oid=2Ep, field_oid, next-&gt;oid=
=2Elen))</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            name =3D next;</span><br><span>         }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name=
 =3D name-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        next =3D next-&gt;next;</span><br><span>     }</span><br><span> </s=
pan><br><span>     /* Not found, return an error if this is the peer&#39;s =
certificate */</span><br><span>@@ -277,6 +296,11 @@</span><br><span>       =
  goto fail;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(&amp=
;name-&gt;val))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto fail;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Check th=
at we have room in the buffer, including the terminating &#39;/0&#39; byte=
=2E */</span><br><span>     if (cn_len &lt;=3D name-&gt;val=2Elen)</span><b=
r><span>     {</span><br><span>@@ -586,22 +610,11 @@</span><br><span> stati=
c char *</span><br><span> asn1_buf_to_c_string(const mbedtls_asn1_buf *orig=
, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    size_t i;</span><br><span>     char *val;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(ori=
g-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || orig-&gt;tag =3D=3D MBEDTLS_AS=
N1_PRINTABLE_STRING</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
        || orig-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cstr_compatible(o=
rig))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* Only support C-string compatible types */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return string_alloc(&quot;ERR=
OR: unsupported ASN=2E1 string type&quot;, gc);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; orig-&gt;len; ++i)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (orig-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            return string_alloc(&quot;ERROR: embedded null value&qu=
ot;, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return string_=
alloc(&quot;ERROR: Unsupported string type or embedded null bytes=2E&quot;,=
 gc);</span><br><span>     }</span><br><span>     val =3D gc_malloc(orig-&g=
t;len + 1, false, gc);</span><br><span>     memcpy(val, orig-&gt;p, orig-&g=
t;len);</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/s=
rc/openvpn/ssl_verify_openssl=2Ec</span><br><span>index a30099d=2E=2E1f2804=
f 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br=
><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -196,12 =
+196,13 @@</span><br><span>     int lastpos =3D -1;</span><br><span>     in=
t tmp =3D -1;</span><br><span>     unsigned char *buf =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    result_t ret =3D FAILURE;</=
span><br><span> </span><br><span>     ASN1_OBJECT *field_name_obj =3D OBJ_t=
xt2obj(field_name, 0);</span><br><span>     if (field_name_obj =3D=3D NULL)=
</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;In=
valid X509 attribute name &#39;%s&#39;&quot;, field_name);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span=
>     }</span><br><span> </span><br><span>     ASSERT(size &gt; 0);</span><=
br><span>@@ -222,28 +223,31 @@</span><br><span>     /* Nothing found */</sp=
an><br><span>     if (lastpos =3D=3D -1)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br>=
<span>     }</span><br><span> </span><br><span>     const X509_NAME_ENTRY *=
x509ne =3D X509_NAME_get_entry(x509, lastpos);</span><br><span>     if (!x5=
09ne)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return FAILURE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto exit;</span><br><span>     }</span><br><span> </spa=
n><br><span>     const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509n=
e);</span><br><span>     if (!asn1)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ASN1_S=
TRING_to_UTF8(&amp;buf, asn1) &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int length =3D ASN1_STRING_to_UTF8(&amp;buf, asn1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (length &lt; 0=
 || (size_t)length !=3D strlen((char *)buf))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span>=
<br><span>     }</span><br><span> </span><br><span>     strncpynt(out, (cha=
r *)buf, size);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const result_t ret =3D (strlen((char *)buf) &lt; size) ? SU=
CCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+exit:</span><br><span>     OPENSSL_free(buf);</span>=
<br><span>     return ret;</span><br><span> }</span><br><span>@@ -384,9 +38=
8,9 @@</span><br><span>         goto err;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Get t=
he subject with unescaped control characters so that we can check for null =
bytes=2E */</span><br><span>     X509_NAME_print_ex(subject_bio, X509_get_s=
ubject_name(cert), 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS=
_UTF8_CONVERT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                   | ASN1_STRFLGS_ESC_CTRL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                       XN_FLAG_SEP_CPLUS_SPC | XN_=
FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT);</span><br><span> </span><br><span>=
     if (BIO_eof(subject_bio))</span><br><span>     {</span><br><span>@@ -3=
94,6 +398,25 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   BIO_get_mem_ptr(subject_bio, &amp;subject_mem);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (memchr(subject_mem-&gt;data, 0, subj=
ect_mem-&gt;length) !=3D NULL)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_WARN, &quot;ERROR: Certificate subject contains a &#39;\\0&#39; =
byte=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Now output the subject with esca=
ped control characters=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (BIO_reset(subject_bio) !=3D 1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       XN_FLA=
G_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                           | ASN1_S=
TRFLGS_ESC_CTRL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (BIO_eof(subject_bio))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO_get_mem_ptr(su=
bject_bio, &amp;subject_mem);</span><br><span> </span><br><span>     subjec=
t =3D gc_malloc(subject_mem-&gt;length + 1, false, gc);</span><br><span> </=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/u=
nit_tests/openvpn/test_ssl=2Ec</span><br><span>index 7e7679c=2E=2Eadfc07a 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -884,=
6 +884,94 @@</span><br><span>     free_certificate(cert);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Certificate with two CNs, &quot;foo&quot; and &quot;bar&quot;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Generated with:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * openssl req -x509 -newkey ec -pkeyopt ec_p=
aramgen_curve:secp384r1 -subj &quot;/CN=3Dfoo/CN=3Dbar&quot; \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * -noenc -out two_cns=2Ecrt -ke=
yout two_cns=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char=
 *cert_with_two_cns =3D</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3=
ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjY=
wODI4MTU1NjAwWhcN\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB=
2MBAG\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &q=
uot;ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PvPMWGWz=
qecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;hGBWFvnUsqdNo765lGwV=
dBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+w=
K9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6=
RRQtXzOWCPLRKId4e+E88\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i=
/16oZkBcm\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFICATE-----\=
n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ssl_test_extract_last_matching_field(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* When there are multiple f=
ields of the same type in the certificate&#39;s subject, OpenVPN</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * should extract the valu=
e of the last matching field=2E This is essentially arbitrary and there</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * is no correct ch=
oice here, but this test exists to make sure that the behavior is consisten=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * between dif=
ferent backends=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x=
509_cert_t *cert =3D get_certificate(cert_with_two_cns);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(backe=
nd_x509_get_username(username, sizeof(username), &quot;CN&quot;, cert), SUC=
CESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(username, &quot;bar&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    free_certificate(cert);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Certifi=
cate with a null-byte embedded in the CN=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Generated with the following Python script:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * from cryptography import x509</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * from cryptography=2Ex509=2Eoid import Name=
OID, ExtensionOID, ExtendedKeyUsageOID</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * from cryptography=2Ehazmat=2Eprimitives import hashes=
, serialization</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * f=
rom cryptography=2Ehazmat=2Eprimitives=2Easymmetric import ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * import datetime</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * private_key =3D ec=2Egenerate_private_key(ec=2ES=
ECP384R1())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * now =
=3D datetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * name =3D &quot;with\x00null&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * cert =3D (x509=2ECertificateBuilder=
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
=2Esubject_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, na=
me)]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  =2Eissuer_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, n=
ame)]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   =2Epublic_key(private_key=2Epublic_key())</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             =2Eserial_number(x509=2Erandom_seri=
al_number())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        =2Enot_valid_before(now)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             =2Enot_valid_after(now + datetime=2Etimedelta(d=
ays=3D10 * 365))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            =2Esign(private_key, hashes=2ESHA256()))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * print(str(cert=2Epublic_bytes(serialization=2EEncoding=
=2EPEM), encoding=3D&#39;utf-8&#39;))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ **/</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static const char *cert_with_null =3D</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MIIBZTCB66ADAgECAh=
RLWdNRl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &quot;MRIwEAYDVQQDDAl3aXRoAG51bGwwHh=
cNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &quot;MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBg=
cqhkjOPQIBBgUrgQQAIgNi\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6=
/mlPaeiJY/\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;GuE=
wCgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;k099bUFvHp/3LSp=
8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;EzZyRyPM3PGR83ZPbIaYDq8lCVx=
VlbYr/Q=3D=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_tes=
t_reject_null_in_cert_subject(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with_null);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Trying to get the=
 subject as a whole should fail=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_ptr_equal(x509_get_subject(cert, &amp;gc), NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Trying to extract the common=
 name should fail=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(backend_x509_get_us=
ername(username, sizeof(username), &quot;CN&quot;, cert), FAILURE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
> </span><br><span> int</span><br><span> main(void)</span><br><span>@@ -908=
,7 +996,9 @@</span><br><span>         cmocka_unit_test(test_data_channel_ro=
undtrip_bf_cbc),</span><br><span>         cmocka_unit_test(test_data_channe=
l_known_vectors_epoch),</span><br><span>         cmocka_unit_test(test_data=
_channel_known_vectors_shortpktid),</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        cmocka_unit_test(crypto_test_print_cert_details)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(crypto_test_print_cert_details),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(ssl_test_extract_last_matching_field=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(ssl_test_reject_null_in_cert_subject)</span><br><span> </span><br><=
span>     };</span><br><span> </span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demai=
l">change 1902</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
02?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1902 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--IwNeU1bbwUc=--


--===============3385500907588604534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3385500907588604534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3385500907588604534==--

