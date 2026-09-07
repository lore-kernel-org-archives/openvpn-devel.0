Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE052C79F89
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LgMTzo7R+Qz4WUPoq+9SP+ZjdBRa48b6Uu3oI/KRKxA=; b=X37Dv+09kpajyExHStzAHbJS6+
	igo42Xzn7DFLJ6guLUXcWlpsz2v6rg/Xkhy9jAZ7G7nOOcuBPpLdTPU0t/tEZc81jePA3zRW2E7sT
	lpFwOzEbBu9m6bOVmy42tMhmnj6JDsz5znxAJ6B4iMGGwDaYjyUMzCohuxebkePr8ifQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3YPN-0003OM-L8;
	Mon, 07 Sep 2026 12:25:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3YP2-0003M8-Bz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:24:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sZiGMgJysFeM0VE9xIuPMfw5st+vhkEon8LWhwpxeD8=; b=jATRdPi+KzSdiPZS/aVPVheIR6
 1Q0deGbbftwO7EyGGJOIXGk4sxscXx/LalVs8ioTjP1tTaQjdyBTRhWQmvfouam0prYlS6H1X4x5O
 qwY+ZhNmKQ/70ofMhMpS2gAmeks54Fn564OCT++hMtjRdaUTnIuVwTJNr0u/G6t12LCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sZiGMgJysFeM0VE9xIuPMfw5st+vhkEon8LWhwpxeD8=; b=Y
 yrWK3zoBu3WH/YDDF73AkdZha0G0v3W0aoyJBmYmYVpYRluQO3rqegg2VGcv/Qb9PiyTbs+EA7hS6
 F41wcUGtqtCg4V/jt5+X7ZUgQ7uR5RzuWCY8gH0MzZCgnbyeEcYCXsXrD2gCi9vxhgmSfh3mQoIUG
 oLYNtRkNmnAvhCFw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3YOz-0008It-Tg for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:24:48 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso33045765e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788783879; x=1789388679; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sZiGMgJysFeM0VE9xIuPMfw5st+vhkEon8LWhwpxeD8=;
 b=I+uw/SnfHKfLJEEU0+a08H/mHV5Kdu0hcX/tHHYo0qB0mvnlT6/gzvB7PRb+dYUG7O
 8JtSS0kkdFnRis9iZlC+N+2fCQTwnf5dPQmHImQK2+IZlaSb+ypRS7pSju5+fjjudWEE
 i2+qD9TYHdtWOYCUrGtmloq1UskKiaUjk2Ivim/wINbe93kSO7l3jvW7Va2Y9RrLTT+C
 RIgAHQ8I1Iafd4ASO0SVClW1Gkic6pTn+j1U6ta20n6g4DozFKmnseZEImNoDOZlcdfw
 8XMYD/CM8Tn2bWRz1AR6CCv+TxW/D4iYaXNd4dbfo4kNw72tnWEl2d34b9QikyhWTi8d
 J8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788783879; x=1789388679;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sZiGMgJysFeM0VE9xIuPMfw5st+vhkEon8LWhwpxeD8=;
 b=hDMtZbExLC8vvhaEwFM0wcW+ICS9SBDZwrvmZWlYf8atPmVBde4cakb//m0gKxADSQ
 OKsVmaH0nywKT4Mv46blM/YyVLsG9+JwnNi3kOBhfWl4OsFigrX6mzYQMt5NhTabwYUg
 w19BRCUWrDkSDFV6ylzkDaUd6s81EYGPVruAWP4CqIYFdZ0nyJNCkv9fDbpQxZpl+JcV
 dES/FQdU4gPNFhwGVO1FttkxqKVpFQbLNYjfsxgVDpp8cDCPuSeeVkvKW2PG+mqlVjIk
 aN8y1fRsB4W1i033hdrQN33QDJSuwDu2xieHpUg0MfOXcenQM89tgbVKHT8w1B+ajL0D
 EApQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLyZ/GMNpoxUBRoGuUd4Wzgpt+DHJSIyJqfWc7m3TmbHWBaQSEpbJooMOyXIueQcaRuOPW69YgLED+60nY@lists.sourceforge.net
X-Gm-Message-State: AFuF++mMQdeW4EYN5s/pEql7XTnn5SAzE5+O759uLsToW497tDnXFDtQ
 WfzmbTdflzSLavCppK6irwGM4lV1gqhaI2rdfkiksdp6cx0wQG3ZSrmx8E2Lfm2zHPezlOTje8T
 dYznJsUUIcPoYYlDXBEChyjlJb/U2rRxDWcOfbVzp8m134sH7IJciNQpyBuO0qU7+CWUu
X-Gm-Gg: AYBFou3RBAEt8deErPopojbpjafG42b4ETv8eXP7deYQjq8/xd0ox63qmj9SfL4e6Cn
 itw30Ji/sf80S/8GMiHUaMFUZc1+c2nacf9G0YlhsY2qOwFvOKqGmyIJK76WcnDqT7Wy+BSyraj
 HjgWBI61kEBLYLA1211EnsIWUZcJBB3KXWVm0TKz0Mj/a48FruOKS/HCnZWwWMnQY8NfMzCo7Ja
 F6kgR2Lhy99nceuuXoBA22Tq6He9MtB93fkKe9xPvVZs7G0UAionmS4h5HVq9bocOrydHF7jgBq
 x5QrY+SlPQXdNdHjtdDqoLtcdq+cCj8O6/4l8OwhpqJ0D/aOtxxcu2IqTU1QdNiCQoOSotRuuBe
 QWXG1WhrOdVsM3FssM0E77+HrDBqTu10WODN46ufL35dOG8E0SsK25+o7xkhO2wHoriF0Mf5wCW
 NmD9nrxg0BbcpUkv+D/MOm0m/Ua38A5fQkppblJqhuI7jArALO8JRSz10DOueHrSeYuRqqid9t1
 qWYCS2vDspmQr9mGj4kogKcZPprRtm50BAgdoQ5u4lZjM6f4wSSihvN5xyEAcWeLCg0RhOY6UEQ
 sPqcf9Qy+8sBhX4srFsOlnlprla7iLR9pRNptMe9M86oTmwk8Xg=
X-Received: by 2002:a05:600c:1986:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49cf825cef5mr192640015e9.14.1788783878845; 
 Mon, 07 Sep 2026 05:24:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f8192sm267865545e9.3.2026.09.07.05.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:24:38 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 12:24:38 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: 22a24132da88b6be9f121e4c6e74c18a46e7741f
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ca00630047fb678ffa6cfc723271473ed620b96-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3YOz-0008It-Tg
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for \0 and RFC
 2253 chars in cert subjects
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
Content-Type: multipart/mixed; boundary="===============2536031291738492152=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2536031291738492152==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DoXTshm98+Q="; charset=UTF-8

--DoXTshm98+Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1898?usp=3Demail )

Change subject: Check for \0 and RFC 2253 chars in =
cert subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Check for \0 and RFC 2253 chars in cert subjects

When using the OpenSSL =
library, we escaped embedded null-bytes in a
certificate's subject in x509_=
get_subject(), but in
extract_x509_field_ssl(), we copied any null-bytes th=
at are contained in
the field value=2E When using the option --verify-x509-=
name, this could
lead to an incorrect name being accepted=2E For example, t=
he common name
"admin\0impersonator" would be accepted when running with
--=
verify-x509-name admin name=2E

To fix this, this commit makes x509_get_sub=
ject() return an error if the
subject contains an embedded null-byte=2E Thi=
s way, OpenVPN won't connect
with peers that present such certificates=2E

=
As a defense-in-depth measure, we also check for null-bytes in
extract_x509=
_field_ssl() in case a future version of OpenVPN has a code
path that avoid=
s x509_get_subject()=2E

Additionally, we escape RFC 2253 characters in the=
 subject that would
make parsing of the resulting string ambiguous=2E For e=
xample, if the
Common Name is "name, O=3DInjectedOrg", and the Organization=
 is "RealOrg",
this will now be converted to "CN=3Dname\, O=3DInjectedOrg, =
O=3DRealOrg" to
make it clear which "O" field is legitimate=2E

With Mbed T=
LS, the x509_get_subject() function already returned an error
when there is=
 an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Here too, we
added a ch=
eck for null-bytes to the function where we extract individual
fields from =
the subject=2E

Also, backend_x509_get_username() is changed so that it ret=
urns the
value of the *last* matching field, to be consistent with the beha=
vior
of the OpenSSL backend=2E

Discovered and reported by BreachX Zero Day=
 Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

=
CVE: 2026-84790
Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Git=
hub: OpenVPN/openvpn-private-issues#163

Change-Id: Ic334518048d6ca57a50425=
7e210467f9c451d268
Signed-off-by: Max Fillinger <maximilian=2Efillinger@sen=
tyron=2Ecom>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898
Message-Id: <20260907100947=2E=
25255-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg38973=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M Changes=2Erst
M src/openvpn/ssl_verify=
_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M tests/unit_tests/openvp=
n/test_ssl=2Ec
4 files changed, 228 insertions(+), 28 deletions(-)




diff=
 --git a/Changes=2Erst b/Changes=2Erst
index 1f992b2=2E=2Efe81909 100644
--=
- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -1,5 +1,25 @@
 Overview of changes=
 in 2=2E8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+User-visible Changes
+--------------------
+Parsing Distin=
guished Names in certificates
+    (OpenSSL backend:) OpenVPN now rejects c=
ertificates that have a null-byte
+    inside any of the field values of th=
eir subject=2E To avoid ambiguity in the
+    parsed subject, OpenVPN escap=
es the following characters by prefixing them with
+    a backslash:
+     =
* " " (space) at the start or end of a field,
+     * "#" at the start of a=
 field,
+     * ",", "+", """, "\", "<", ">" and ";" anywhere=2E
+
+    As =
a result, if you use the option ``--verify-x509-name <expected subject>``,
=
+    you need to prefix these characters with a backslash in your configura=
tion=2E
+    The subject passed to a ``--tls-verify`` script is escaped in =
the same way and
+    you may need to adjust your script=2E
+
+    (Mbed TL=
S backend:) The behavior has not changed=2E Subjects with null-bytes were
+=
    already rejected (assuming OpenVPN was built with Mbed TLS 3=2E5 or lat=
er) and
+    the characters mentioned above were already escaped=2E However=
, the behavior of
+    Mbed TLS is slightly different from OpenSSL in that =
it also escapes "=3D"=2E
 
 
 Overview of changes in 2=2E7
diff --git a/src=
/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index =
2a09e86=2E=2E9f676ed 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/=
src/openvpn/ssl_verify_mbedtls=2Ec
@@ -214,6 +214,24 @@
     }
 }
 
+static=
 bool
+asn1_buf_is_cstr_compatible(const mbedtls_asn1_buf *asn1_buf)
+{
+  =
  if (!(asn1_buf->tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf->tag =3D=
=3D MBEDTLS_ASN1_PRINTABLE_STRING
+          || asn1_buf->tag =3D=3D MBEDTL=
S_ASN1_IA5_STRING))
+    {
+        return false;
+    }
+    for (size_t i=
 =3D 0; i < asn1_buf->len; i++)
+    {
+        if (asn1_buf->p[i] =3D=3D '=
\0')
+        {
+            return false;
+        }
+    }
+    return tr=
ue;
+}
+
 result_t
 backend_x509_get_username(char *cn, size_t cn_len, char=
 *x509_username_field, mbedtls_x509_crt *cert)
 {
@@ -259,16 +277,17 @@
   =
  }
 
     /* Find field_oid in the subject name=2E */
-    mbedtls_x509_na=
me *name =3D &cert->subject;
-    while (name !=3D NULL)
+    mbedtls_x509_=
name *name =3D NULL;
+    mbedtls_x509_name *next =3D &cert->subject;
+    =
while (next !=3D NULL)
     {
-        if (strlen(field_oid) =3D=3D name->o=
id=2Elen
-            && 0 =3D=3D memcmp(name->oid=2Ep, field_oid, name->oi=
d=2Elen))
+        if (strlen(field_oid) =3D=3D next->oid=2Elen
+          =
  && 0 =3D=3D memcmp(next->oid=2Ep, field_oid, next->oid=2Elen))
         {=

-            break;
+            name =3D next;
         }
 
-        name=
 =3D name->next;
+        next =3D next->next;
     }
 
     /* Not found, =
return an error if this is the peer's certificate */
@@ -277,6 +296,11 @@
 =
        goto fail;
     }
 
+    if (!asn1_buf_is_cstr_compatible(&name->va=
l))
+    {
+        goto fail;
+    }
+
     /* Check that we have room in =
the buffer, including the terminating '/0' byte=2E */
     if (cn_len <=3D =
name->val=2Elen)
     {
@@ -586,22 +610,11 @@
 static char *
 asn1_buf_to_c=
_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)
 {
-    size_t i=
;
     char *val;
 
-    if (!(orig->tag =3D=3D MBEDTLS_ASN1_UTF8_STRING ||=
 orig->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING
-          || orig->tag =3D=
=3D MBEDTLS_ASN1_IA5_STRING))
+    if (!asn1_buf_is_cstr_compatible(orig))
=
     {
-        /* Only support C-string compatible types */
-        retur=
n string_alloc("ERROR: unsupported ASN=2E1 string type", gc);
-    }
-
-   =
 for (i =3D 0; i < orig->len; ++i)
-    {
-        if (orig->p[i] =3D=3D '\=
0')
-        {
-            return string_alloc("ERROR: embedded null value=
", gc);
-        }
+        return string_alloc("ERROR: Unsupported string =
type or embedded null bytes=2E", gc);
     }
     val =3D gc_malloc(orig->l=
en + 1, false, gc);
     memcpy(val, orig->p, orig->len);
diff --git a/src/=
openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index b=
8648fd=2E=2Ea6307f6 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/s=
rc/openvpn/ssl_verify_openssl=2Ec
@@ -196,12 +196,13 @@
     int lastpos =
=3D -1;
     int tmp =3D -1;
     unsigned char *buf =3D NULL;
+    result_=
t ret =3D FAILURE;
 
     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field=
_name, 0);
     if (field_name_obj =3D=3D NULL)
     {
         msg(D_TLS_E=
RRORS, "Invalid X509 attribute name '%s'", field_name);
-        return FAI=
LURE;
+        goto exit;
     }
 
     ASSERT(size > 0);
@@ -222,28 +223,3=
1 @@
     /* Nothing found */
     if (lastpos =3D=3D -1)
     {
-        r=
eturn FAILURE;
+        goto exit;
     }
 
     const X509_NAME_ENTRY *x50=
9ne =3D X509_NAME_get_entry(x509, lastpos);
     if (!x509ne)
     {
-     =
   return FAILURE;
+        goto exit;
     }
 
     const ASN1_STRING *asn=
1 =3D X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
-        ret=
urn FAILURE;
+        goto exit;
     }
-    if (ASN1_STRING_to_UTF8(&buf, =
asn1) < 0)
+    int length =3D ASN1_STRING_to_UTF8(&buf, asn1);
+    if (le=
ngth < 0 || (size_t)length !=3D strlen((char *)buf))
     {
-        return=
 FAILURE;
+        goto exit;
     }
 
     strncpynt(out, (char *)buf, siz=
e);
 
-    const result_t ret =3D (strlen((char *)buf) < size) ? SUCCESS : =
FAILURE;
+    ret =3D (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+
+=
exit:
     OPENSSL_free(buf);
     return ret;
 }
@@ -385,8 +389,7 @@
     =
}
 
     X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
- =
                      XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_=
UTF8_CONVERT
-                           | ASN1_STRFLGS_ESC_CTRL);
+       =
                XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_ESC_22=
53 | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
     {
@@=
 -395,6 +398,16 @@
 
     BIO_get_mem_ptr(subject_bio, &subject_mem);
 
+  =
  /* Check subject for '\0' bytes=2E */
+    for (size_t i =3D 0; i < subje=
ct_mem->length; i++)
+    {
+        if (subject_mem->data[i] =3D=3D 0)
+  =
      {
+            msg(M_WARN, "ERROR: Certificate subject contains a '\\=
0' byte=2E");
+            goto err;
+        }
+    }
+
     subject =3D g=
c_malloc(subject_mem->length + 1, false, gc);
 
     memcpy(subject, subjec=
t_mem->data, subject_mem->length);
diff --git a/tests/unit_tests/openvpn/te=
st_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 887c492=2E=2Efcebc=
db 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_test=
s/openvpn/test_ssl=2Ec
@@ -873,6 +873,157 @@
     free_certificate(cert);
 =
}
 
+/* Certificate with two CNs, "foo" and "bar"=2E
+ *
+ * Generated with=
:
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -su=
bj "/CN=3Dfoo/CN=3Dbar" \
+ * -noenc -out two_cns=2Ecrt -keyout two_cns=2Ek=
ey
+ */
+static const char *cert_with_two_cns =3D
+    "-----BEGIN CERTIFIC=
ATE-----\n"
+    "MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIz=
j0EAwIw\n"
+    "HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1Nj=
AwWhcN\n"
+    "MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB=
2MBAG\n"
+    "ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpD=
nE/h\n"
+    "PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuH=
SGA\n"
+    "hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qy=
TI\n"
+    "dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwE=
B\n"
+    "/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E88=
\n"
+    "cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\=
n"
+    "OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n"
+    "-----END CERTI=
FICATE-----\n";
+
+void
+ssl_test_extract_last_matching_field(void **state)=

+{
+    /* When there are multiple fields of the same type in the certific=
ate's subject, OpenVPN
+     * should extract the value of the last matchin=
g field=2E This is essentially arbitrary and there
+     * is no correct ch=
oice here, but this test exists to make sure that the behavior is consisten=
t
+     * between different backends=2E
+     */
+    openvpn_x509_cert_t *=
cert =3D get_certificate(cert_with_two_cns);
+
+    char username[TLS_USERN=
AME_LEN + 1] =3D { 0 };
+    assert_int_equal(backend_x509_get_username(use=
rname, sizeof(username), "CN", cert), SUCCESS);
+    assert_string_equal(us=
ername, "bar");
+    free_certificate(cert);
+}
+
+/* Certificate with a nu=
ll-byte embedded in the CN=2E
+ *
+ * Generated with the following Python s=
cript:
+ *
+ * from cryptography import x509
+ * from cryptography=2Ex509=
=2Eoid import NameOID, ExtensionOID, ExtendedKeyUsageOID
+ * from cryptogra=
phy=2Ehazmat=2Eprimitives import hashes, serialization
+ * from cryptograph=
y=2Ehazmat=2Eprimitives=2Easymmetric import ec
+ * import datetime
+ *
+ * =
private_key =3D ec=2Egenerate_private_key(ec=2ESECP384R1())
+ * now =3D dat=
etime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)
+ * name =3D "with\x00nul=
l"
+ *
+ * cert =3D (x509=2ECertificateBuilder()
+ *             =2Esubject=
_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))
+ *=
             =2Eissuer_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOM=
MON_NAME, name)]))
+ *             =2Epublic_key(private_key=2Epublic_key()=
)
+ *             =2Eserial_number(x509=2Erandom_serial_number())
+ *      =
       =2Enot_valid_before(now)
+ *             =2Enot_valid_after(now + da=
tetime=2Etimedelta(days=3D10 * 365))
+ *             =2Esign(private_key, h=
ashes=2ESHA256()))
+ *
+ * print(str(cert=2Epublic_bytes(serialization=2EEn=
coding=2EPEM), encoding=3D'utf-8'))
+ **/
+static const char *cert_with_nul=
l =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIBZTCB66ADAgECAhRLWdNRl+=
C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n"
+    "MRIwEAYDVQQDDAl3aXRoAG51bGw=
wHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n"
+    "MDA4WjAUMRIwEAYDVQQDDAl3aXRo=
AG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n"
+    "AAT7PE+vJCBiB4CVHBcvJVF9n5n/d=
GQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n"
+    "Ywh3pa8zhto1+aczbJKTvLgRwXn6N5=
vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n"
+    "GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2=
ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n"
+    "k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIx=
AINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n"
+    "EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/=
Q=3D=3D\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_reject_nul=
l_in_cert_subject(void **state)
+{
+    openvpn_x509_cert_t *cert =3D get_c=
ertificate(cert_with_null);
+    struct gc_arena gc =3D gc_new();
+
+    /*=
 Trying to get the subject as a whole should fail=2E */
+    assert_ptr_equ=
al(x509_get_subject(cert, &gc), NULL);
+
+    /* Trying to extract the comm=
on name should fail=2E */
+    char username[TLS_USERNAME_LEN + 1] =3D { 0 =
};
+    assert_int_equal(backend_x509_get_username(username, sizeof(usernam=
e), "CN", cert), FAILURE);
+    gc_free(&gc);
+    free_certificate(cert);
=
+}
+
+/* Cert with CN=3D"name, O=3DInjectedOrg" and O=3DRealOrg=2E
+ *
+ * =
Generated with the following Python script:
+ *
+ * from cryptography impor=
t x509
+ * from cryptography=2Ex509=2Eoid import NameOID, ExtensionOID, Ext=
endedKeyUsageOID
+ * from cryptography=2Ehazmat=2Eprimitives import hashes,=
 serialization
+ * from cryptography=2Ehazmat=2Eprimitives=2Easymmetric imp=
ort ec
+ * import datetime
+ *
+ * private_key =3D ec=2Egenerate_private_ke=
y(ec=2ESECP384R1())
+ * now =3D datetime=2Edatetime=2Enow(datetime=2Etimezo=
ne=2Eutc)
+ * name =3D "name, O=3DInjectedOrg"
+ * org =3D "RealOrg"
+ *
+ =
* distinguished_name =3D x509=2EName([
+ *     x509=2ENameAttribute(NameOID=
=2ECOMMON_NAME, name),
+ *     x509=2ENameAttribute(NameOID=2EORGANIZATION_=
NAME, org)
+ * ])
+ *
+ * cert =3D (x509=2ECertificateBuilder()
+ *        =
     =2Esubject_name(distinguished_name)
+ *             =2Eissuer_name(dis=
tinguished_name)
+ *             =2Epublic_key(private_key=2Epublic_key())
=
+ *             =2Eserial_number(x509=2Erandom_serial_number())
+ *        =
     =2Enot_valid_before(now)
+ *             =2Enot_valid_after(now + date=
time=2Etimedelta(days=3D10 * 365))
+ *             =2Esign(private_key, has=
hes=2ESHA256()))
+ *
+ * print(str(cert=2Epublic_bytes(serialization=2EEnco=
ding=2EPEM), encoding=3D'utf-8'))
+ */
+static const char *cert_with_rfc_22=
53_chars =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIBnTCCASOgAwIBAgI=
UR1IGc6A800U14v/ykZNR21aVubowCgYIKoZIzj0EAwIw\n"
+    "MDEcMBoGA1UEAwwTbmFt=
ZSwgTz1JbmplY3RlZE9yZzEQMA4GA1UECgwHUmVhbE9y\n"
+    "ZzAeFw0yNjA4MjgxNTQ3N=
DdaFw0zNjA4MjUxNTQ3NDdaMDAxHDAaBgNVBAMME25h\n"
+    "bWUsIE89SW5qZWN0ZWRPcm=
cxEDAOBgNVBAoMB1JlYWxPcmcwdjAQBgcqhkjOPQIB\n"
+    "BgUrgQQAIgNiAAR6zl9QPAb=
AnHWN//MRdowuhu0Sol6N+lqB/qk+D+2NHCd/t4H9\n"
+    "cJlswUh6EPsmLxgfMYgO2QwC=
lFWEFWvtXQs8BggoidY6i9pmAPhs8+9fmIyuNVpG\n"
+    "3vUWZrUBRgylwaIwCgYIKoZIz=
j0EAwIDaAAwZQIwKzXmR8YPQZ1pratM9meVmGkH\n"
+    "1rpHgV3U8oeg+jXmfVcZJTpDeD=
z4yBl4V3KBKT7HAjEAj2qkaTz7fiSwBKsxJQWH\n"
+    "dQFPBCAYU9zZJvlNnEPtmHIwaD/=
qHXDeClr/HRItU3B9\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_=
escape_rfc_2253_chars_in_subject(void **state)
+{
+    openvpn_x509_cert_t =
*cert =3D get_certificate(cert_with_rfc_2253_chars);
+    struct gc_arena g=
c =3D gc_new();
+
+    char *subject =3D x509_get_subject(cert, &gc);
+    =
assert_non_null(subject);
+
+    /* Mbed TLS escapes the '=3D' character bu=
t OpenSSL does not=2E */
+    const char *expected_subject_openssl =3D "CN=
=3Dname\\, O=3DInjectedOrg, O=3DRealOrg";
+    const char *expected_subject=
_mbedtls =3D "CN=3Dname\\, O\\=3DInjectedOrg, O=3DRealOrg";
+
+    assert_t=
rue(strcmp(subject, expected_subject_openssl) =3D=3D 0 || strcmp(subject, e=
xpected_subject_mbedtls) =3D=3D 0);
+    gc_free(&gc);
+    free_certificat=
e(cert);
+}
+
 void
 ssl_test_extract_peer_info(void **state)
 {
@@ -960,6 =
+1111,9 @@
         cmocka_unit_test(test_data_channel_known_vectors_epoch)=
,
         cmocka_unit_test(test_data_channel_known_vectors_shortpktid),
  =
       cmocka_unit_test(crypto_test_print_cert_details),
+        cmocka_un=
it_test(ssl_test_extract_last_matching_field),
+        cmocka_unit_test(ss=
l_test_reject_null_in_cert_subject),
+        cmocka_unit_test(ssl_test_esc=
ape_rfc_2253_chars_in_subject),
         cmocka_unit_test(ssl_test_extract_=
peer_info)
 
     };

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1898?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
c334518048d6ca57a504257e210467f9c451d268
Gerrit-Change-Number: 1898
Gerrit-=
PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: c=
ron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--DoXTshm98+Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1898?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Check for \0 and RFC 2253 chars in cert su=
bjects<br><br>When using the OpenSSL library, we escaped embedded null-byte=
s in a<br>certificate&#39;s subject in x509_get_subject(), but in<br>extrac=
t_x509_field_ssl(), we copied any null-bytes that are contained in<br>the f=
ield value=2E When using the option --verify-x509-name, this could<br>lead =
to an incorrect name being accepted=2E For example, the common name<br>&quo=
t;admin\0impersonator&quot; would be accepted when running with<br>--verify=
-x509-name admin name=2E<br><br>To fix this, this commit makes x509_get_sub=
ject() return an error if the<br>subject contains an embedded null-byte=2E =
This way, OpenVPN won&#39;t connect<br>with peers that present such certifi=
cates=2E<br><br>As a defense-in-depth measure, we also check for null-bytes=
 in<br>extract_x509_field_ssl() in case a future version of OpenVPN has a c=
ode<br>path that avoids x509_get_subject()=2E<br><br>Additionally, we escap=
e RFC 2253 characters in the subject that would<br>make parsing of the resu=
lting string ambiguous=2E For example, if the<br>Common Name is &quot;name,=
 O=3DInjectedOrg&quot;, and the Organization is &quot;RealOrg&quot;,<br>thi=
s will now be converted to &quot;CN=3Dname\, O=3DInjectedOrg, O=3DRealOrg&q=
uot; to<br>make it clear which &quot;O&quot; field is legitimate=2E<br><br>=
With Mbed TLS, the x509_get_subject() function already returned an error<br=
>when there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Here too,=
 we<br>added a check for null-bytes to the function where we extract indivi=
dual<br>fields from the subject=2E<br><br>Also, backend_x509_get_username()=
 is changed so that it returns the<br>value of the *last* matching field, t=
o be consistent with the behavior<br>of the OpenSSL backend=2E<br><br>Disco=
vered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E<br>C=
ontributing Researcher: Vivek Parikh=2E<br><br>CVE: 2026-84790<br>Reported-=
by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Github: OpenVPN/ope=
nvpn-private-issues#163<br><br>Change-Id: Ic334518048d6ca57a504257e210467f9=
c451d268<br>Signed-off-by: Max Fillinger &lt;maximilian=2Efillinger@sentyro=
n=2Ecom&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898<br>Message-Id: &lt;=
20260907100947=2E25255-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38973=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
Changes=2Erst<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/openvpn/ssl_=
verify_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>4 files ch=
anged, 228 insertions(+), 28 deletions(-)<br><br></pre>
<pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Cha=
nges=2Erst b/Changes=2Erst</span><br><span>index 1f992b2=2E=2Efe81909 10064=
4</span><br><span>--- a/Changes=2Erst</span><br><span>+++ b/Changes=2Erst</=
span><br><span>@@ -1,5 +1,25 @@</span><br><span> Overview of changes in 2=
=2E8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+User-visible Changes</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+--------------------</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+Parsing Distinguished Names in certificates</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    (OpenSSL backend:) OpenVPN now reject=
s certificates that have a null-byte</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    inside any of the field values of their subject=2E To =
avoid ambiguity in the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    parsed subject, OpenVPN escapes the following characters by prefixin=
g them with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a ba=
ckslash:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * &quo=
t; &quot; (space) at the start or end of a field,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * &quot;#&quot; at the start of a field,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * &quot;,&quot=
;, &quot;+&quot;, &quot;&quot;&quot;, &quot;\&quot;, &quot;&lt;&quot;, &quo=
t;&gt;&quot; and &quot;;&quot; anywhere=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    As a result, if you use the option ``--verify-x509-name &lt;expecte=
d subject&gt;``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 you need to prefix these characters with a backslash in your configuration=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The subject =
passed to a ``--tls-verify`` script is escaped in the same way and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    you may need to adjust y=
our script=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    (Mbed TLS backend:) T=
he behavior has not changed=2E Subjects with null-bytes were</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    already rejected (assuming Ope=
nVPN was built with Mbed TLS 3=2E5 or later) and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    the characters mentioned above were alread=
y escaped=2E However, the behavior of</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    Mbed TLS is slightly different from OpenSSL in that i=
t also escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span> </span=
><br><span> Overview of changes in 2=2E7</span><br><span>diff --git a/src/o=
penvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><b=
r><span>index 2a09e86=2E=2E9f676ed 100644</span><br><span>--- a/src/openvpn=
/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtl=
s=2Ec</span><br><span>@@ -214,6 +214,24 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
asn1_buf_is_cstr_compatible(const mbedtls_asn1_buf *asn1_buf)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!(asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8=
_STRING || asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          || asn1_buf-&gt;tag =
=3D=3D MBEDTLS_ASN1_IA5_STRING))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size=
_t i =3D 0; i &lt; asn1_buf-&gt;len; i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (asn1_buf-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> result_t</span><br><span> backend_x509_get_username(char *cn, size_=
t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)</span><br><spa=
n> {</span><br><span>@@ -259,16 +277,17 @@</span><br><span>     }</span><br=
><span> </span><br><span>     /* Find field_oid in the subject name=2E */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_x509_name *=
name =3D &amp;cert-&gt;subject;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    while (name !=3D NULL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mbedtls_x509_name *name =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mbedtls_x509_name *next =3D &amp;cer=
t-&gt;subject;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
hile (next !=3D NULL)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (strlen(field_oid) =3D=3D name-&gt;oid=2E=
len</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&=
amp; 0 =3D=3D memcmp(name-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(field=
_oid) =3D=3D next-&gt;oid=2Elen</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &amp;&amp; 0 =3D=3D memcmp(next-&gt;oid=2Ep, field_=
oid, next-&gt;oid=2Elen))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            name =3D next;</span><br><span> =
        }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        name =3D name-&gt;next;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        next =3D next-&gt;next;</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* Not found, return an error if this =
is the peer&#39;s certificate */</span><br><span>@@ -277,6 +296,11 @@</span=
><br><span>         goto fail;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_cs=
tr_compatible(&amp;name-&gt;val))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto fail;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>     /* Check that we have room in the buffer, including the terminating =
&#39;/0&#39; byte=2E */</span><br><span>     if (cn_len &lt;=3D name-&gt;va=
l=2Elen)</span><br><span>     {</span><br><span>@@ -586,22 +610,11 @@</span=
><br><span> static char *</span><br><span> asn1_buf_to_c_string(const mbedt=
ls_asn1_buf *orig, struct gc_arena *gc)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    size_t i;</span><br><span>     cha=
r *val;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (!(orig-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || orig-&gt;tag =
=3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-          || orig-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!asn1_buf_is_=
cstr_compatible(orig))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        /* Only support C-string compatible types *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return strin=
g_alloc(&quot;ERROR: unsupported ASN=2E1 string type&quot;, gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    for (i =3D 0; i &lt; orig-&gt;len; ++i)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (orig-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return string_alloc(&quot;ERROR: embed=
ded null value&quot;, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return string_alloc(&quot;ERROR: Unsupported string type or embedded nul=
l bytes=2E&quot;, gc);</span><br><span>     }</span><br><span>     val =3D =
gc_malloc(orig-&gt;len + 1, false, gc);</span><br><span>     memcpy(val, or=
ig-&gt;p, orig-&gt;len);</span><br><span>diff --git a/src/openvpn/ssl_verif=
y_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index b8=
648fd=2E=2Ea6307f6 100644</span><br><span>--- a/src/openvpn/ssl_verify_open=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br>=
<span>@@ -196,12 +196,13 @@</span><br><span>     int lastpos =3D -1;</span>=
<br><span>     int tmp =3D -1;</span><br><span>     unsigned char *buf =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    result_t r=
et =3D FAILURE;</span><br><span> </span><br><span>     ASN1_OBJECT *field_n=
ame_obj =3D OBJ_txt2obj(field_name, 0);</span><br><span>     if (field_name=
_obj =3D=3D NULL)</span><br><span>     {</span><br><span>         msg(D_TLS=
_ERRORS, &quot;Invalid X509 attribute name &#39;%s&#39;&quot;, field_name);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILUR=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit=
;</span><br><span>     }</span><br><span> </span><br><span>     ASSERT(size=
 &gt; 0);</span><br><span>@@ -222,28 +223,31 @@</span><br><span>     /* Not=
hing found */</span><br><span>     if (lastpos =3D=3D -1)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return F=
AILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 exit;</span><br><span>     }</span><br><span> </span><br><span>     const =
X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entry(x509, lastpos);</span><br><=
span>     if (!x509ne)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span=
><br><span> </span><br><span>     const ASN1_STRING *asn1 =3D X509_NAME_ENT=
RY_get_data(x509ne);</span><br><span>     if (!asn1)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILUR=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit=
;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (ASN1_STRING_to_UTF8(&amp;buf, asn1) &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int length =3D ASN1_STRING_to_UTF8(&=
amp;buf, asn1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (length &lt; 0 || (size_t)length !=3D strlen((char *)buf))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto exit;</span><br><span>     }</span><br><span> </span><br><span>     st=
rncpynt(out, (char *)buf, size);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const result_t ret =3D (strlen((char *)buf=
) &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILU=
RE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+exit:</span><br><span>     OPENSSL_=
free(buf);</span><br><span>     return ret;</span><br><span> }</span><br><s=
pan>@@ -385,8 +389,7 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
 XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                           | A=
SN1_STRFLGS_ESC_CTRL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRF=
LGS_ESC_2253 | ASN1_STRFLGS_UTF8_CONVERT);</span><br><span> </span><br><spa=
n>     if (BIO_eof(subject_bio))</span><br><span>     {</span><br><span>@@ =
-395,6 +398,16 @@</span><br><span> </span><br><span>     BIO_get_mem_ptr(su=
bject_bio, &amp;subject_mem);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Check subject for &#39;\0&#39; bytes=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i=
 =3D 0; i &lt; subject_mem-&gt;length; i++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (subject_mem-&gt;data[i] =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;ERROR: Certificate =
subject contains a &#39;\\0&#39; byte=2E&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     subject =3D gc_malloc(subject_mem-&gt;length +=
 1, false, gc);</span><br><span> </span><br><span>     memcpy(subject, subj=
ect_mem-&gt;data, subject_mem-&gt;length);</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec<=
/span><br><span>index 887c492=2E=2Efcebcdb 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_ssl=2Ec</span><br><span>@@ -873,6 +873,157 @@</span><br><span> =
    free_certificate(cert);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Certificate with two CNs, &=
quot;foo&quot; and &quot;bar&quot;=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Generated with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -subj =
&quot;/CN=3Dfoo/CN=3Dbar&quot; \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * -noenc -out two_cns=2Ecrt -keyout two_cns=2Ekey</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static const char *cert_with_two_cns =3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTI=
FICATE-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;HD=
EMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MjYwOTI3MTU1Nj=
AwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;ByqGSM49AgEGBSuBBAAiA2IABE=
RAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsg=
N9ypZ5oQugQlB/NrVRCJIuHSGA\n&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &quot;hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+=
wK9R81Syk0qyTI\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEw=
EB\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E88\n&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;cwoCK3UwzEr=
8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\n&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;OyQnlH8W/UzZo3/weTEBTcN=
W0iuCpIrS6im8pSk=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ssl_test_extract_last_matching_field(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* When there are multiple fields of the same type in the =
certificate&#39;s subject, OpenVPN</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * should extract the value of the last matching field=
=2E This is essentially arbitrary and there</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * is no correct choice here, but this test exi=
sts to make sure that the behavior is consistent</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * between different backends=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_cer=
tificate(cert_with_two_cns);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char u=
sername[TLS_USERNAME_LEN + 1] =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(backend_x509_get_username(usernam=
e, sizeof(username), &quot;CN&quot;, cert), SUCCESS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(username, &quot;b=
ar&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_=
certificate(cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Certificate with a null-byte embedd=
ed in the CN=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generated with the=
 following Python script:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from cry=
ptography import x509</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * from cryptography=2Ex509=2Eoid import NameOID, ExtensionOID, ExtendedK=
eyUsageOID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from c=
ryptography=2Ehazmat=2Eprimitives import hashes, serialization</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ehazmat=2E=
primitives=2Easymmetric import ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * import datetime</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * p=
rivate_key =3D ec=2Egenerate_private_key(ec=2ESECP384R1())</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * now =3D datetime=2Edatetime=2Enow=
(datetime=2Etimezone=2Eutc)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * name =3D &quot;with\x00null&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * cert =3D (x509=2ECertificateBuilder()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             =2Esubject_name(x509=2EName([x5=
09=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             =2Eissuer_name(x509=2EName([x=
509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             =2Epublic_key(private_key=
=2Epublic_key())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            =2Eserial_number(x509=2Erandom_serial_number())</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             =2Enot_valid_before(=
now)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
=2Enot_valid_after(now + datetime=2Etimedelta(days=3D10 * 365))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Esign(private_=
key, hashes=2ESHA256()))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * print(str=
(cert=2Epublic_bytes(serialization=2EEncoding=2EPEM), encoding=3D&#39;utf-8=
&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ **/</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *cert_wit=
h_null =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot=
;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzAK=
BggqhkjOPQQDAjAU\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1=
MTQz\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAT7PE+vJ=
CBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;Ywh3pa8zhto1+aczbJKTv=
LgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2=
ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlm=
MgpXxROKA9qQqaM3d92Mp\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFI=
CATE-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ssl_test_reject_null_in_cert_subjec=
t(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_cert_=
t *cert =3D get_certificate(cert_with_null);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Trying to get the subject as a whole should f=
ail=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_ptr_equal(x509_get_subject(cert, &amp;gc), NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Trying to extract the common name should fail=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char username[TLS_US=
ERNAME_LEN + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(backend_x509_get_username(username, sizeof(user=
name), &quot;CN&quot;, cert), FAILURE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    free_certificate(cert);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Cert=
 with CN=3D&quot;name, O=3DInjectedOrg&quot; and O=3DRealOrg=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Generated with the following Python script:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * from cryptography import x509</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ex5=
09=2Eoid import NameOID, ExtensionOID, ExtendedKeyUsageOID</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ehazmat=2Eprim=
itives import hashes, serialization</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * from cryptography=2Ehazmat=2Eprimitives=2Easymmetric imp=
ort ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * import dat=
etime</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * private_key =3D ec=2Egenerat=
e_private_key(ec=2ESECP384R1())</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * now =3D datetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * name =3D &quot;n=
ame, O=3DInjectedOrg&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * org =3D &quot;RealOrg&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * distinguished_name =3D x509=2EName([</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *     x509=2ENameAttribute(NameOID=2ECOMMON_NAME, nam=
e),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     x509=2ENa=
meAttribute(NameOID=2EORGANIZATION_NAME, org)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * ])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ce=
rt =3D (x509=2ECertificateBuilder()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             =2Esubject_name(distinguished_name)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Eissuer_nam=
e(distinguished_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             =2Epublic_key(private_key=2Epublic_key())</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             =2Eserial_number(x509=
=2Erandom_serial_number())</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             =2Enot_valid_before(now)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             =2Enot_valid_after(now + datetime=
=2Etimedelta(days=3D10 * 365))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             =2Esign(private_key, hashes=2ESHA256()))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * print(str(cert=2Epublic_bytes(serializatio=
n=2EEncoding=2EPEM), encoding=3D&#39;utf-8&#39;))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static const char *cert_with_rfc_2253_chars =3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-=
----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;MIIBnTCCASOgAwIBAgIUR1IGc6A800U14v/ykZNR21aVubowCgYIKoZIzj0EAwIw\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDEcMBoGA=
1UEAwwTbmFtZSwgTz1JbmplY3RlZE9yZzEQMA4GA1UECgwHUmVhbE9y\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;ZzAeFw0yNjA4MjgxNTQ3N=
DdaFw0zNjA4MjUxNTQ3NDdaMDAxHDAaBgNVBAMME25h\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;bWUsIE89SW5qZWN0ZWRPcmcxEDAOBgN=
VBAoMB1JlYWxPcmcwdjAQBgcqhkjOPQIB\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;BgUrgQQAIgNiAAR6zl9QPAbAnHWN//MRdowuhu0Sol6=
N+lqB/qk+D+2NHCd/t4H9\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;cJlswUh6EPsmLxgfMYgO2QwClFWEFWvtXQs8BggoidY6i9pmAPhs8+9=
fmIyuNVpG\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;3vUWZrUBRgylwaIwCgYIKoZIzj0EAwIDaAAwZQIwKzXmR8YPQZ1pratM9meVmGkH\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;1rpH=
gV3U8oeg+jXmfVcZJTpDeDz4yBl4V3KBKT7HAjEAj2qkaTz7fiSwBKsxJQWH\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;dQFPBCAYU9zZJvlN=
nEPtmHIwaD/qHXDeClr/HRItU3B9\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ssl_test_escape_rfc_2253_chars_in_subject(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_certificate=
(cert_with_rfc_2253_chars);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *subject =3D x509_get_subject(cert, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(subject);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Mbed TLS escapes the &#39;=3D&#39;=
 character but OpenSSL does not=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *expected_subject_openssl =3D &quot;CN=3Dn=
ame\\, O=3DInjectedOrg, O=3DRealOrg&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *expected_subject_mbedtls =3D &quot;C=
N=3Dname\\, O\\=3DInjectedOrg, O=3DRealOrg&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(strcmp(subject, expected_subject_openssl) =3D=3D=
 0 || strcmp(subject, expected_subject_mbedtls) =3D=3D 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> ssl_=
test_extract_peer_info(void **state)</span><br><span> {</span><br><span>@@ =
-960,6 +1111,9 @@</span><br><span>         cmocka_unit_test(test_data_chann=
el_known_vectors_epoch),</span><br><span>         cmocka_unit_test(test_dat=
a_channel_known_vectors_shortpktid),</span><br><span>         cmocka_unit_t=
est(crypto_test_print_cert_details),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract_last_matching_fi=
eld),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(ssl_test_reject_null_in_cert_subject),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_escape_rfc_=
2253_chars_in_subject),</span><br><span>         cmocka_unit_test(ssl_test_=
extract_peer_info)</span><br><span> </span><br><span>     };</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1898?usp=3Demail">change 1898</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c45=
1d268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1898 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--DoXTshm98+Q=--


--===============2536031291738492152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2536031291738492152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2536031291738492152==--

