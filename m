Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770BDC79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dktEdgs+9pUH8X68ojlBhursIfOPcoUKczQvzU+BPY0=; b=bNCZelc6Y+xIQMoiOMORc/kTR4
	fdQfNfWbsFgUqgXGEWT71+uK7DwR+ADZsH9pY77wV6mzHZ1JAbeF9yUrlS3WMpAemrAePNGutvhEZ
	18+csj/QmK7A5PQATtYFdbiC7Xxr2qRYSK5DVm4QyER4CZrX1ymuv9hJ+6GfMIKzF+Ls=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3YPP-00073I-9Q;
	Mon, 07 Sep 2026 12:25:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3YP5-000728-6a
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:24:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mpHYisZxoPlR233qIEeGG6fdrP1BTwn0IBRMhknWUEw=; b=I9njiU9N1Pwls9yXRqFSCPFMm0
 B803yTKZ2sYXYpeBWXFVgTEchW+XXFH1WBf1Ya+U7S1m0IHzTbHtTOycajHpvh2Z/wpZvmdwRC4h3
 Zgu5rcD3LbH3c9IHV4joiJDcRrzkaStELFISMfN5ez/kJsrLiFXWV7r6Ttcg7Zk5/RXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mpHYisZxoPlR233qIEeGG6fdrP1BTwn0IBRMhknWUEw=; b=K
 IZMsVQIt3wvZ35B6DAuwBgDQnEf+lz+qaotiJTnEUrE4cC8O5j2JMulxRvO7hF0UirXasZ32LsRvL
 BWkRrFUaFG29y9+9BnQxACzYfq/CgbADJkdC8gygVQ5KFzQQBvXZj5bts07bRfLvKvUb3DB+mrHcO
 pbKRMi8NipfRUBZA=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3YOz-0008Is-0W for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 12:24:48 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48436251906so3984409f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788783878; x=1789388678; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mpHYisZxoPlR233qIEeGG6fdrP1BTwn0IBRMhknWUEw=;
 b=FzCGsOYBOzudGRw44rNETwJVPzidQKZQppZc2HuS1I8Z4vklM1twLvDcnuv26+9Alz
 C/RtxJdg6w/f033lc/9qHTGi8HHmdDKUu4ey4HwsJ6oaWooyZEkq6prs1O6brS4HwA3h
 scWWpZ/w2qUk45qoZ0sm8kyBtG2bqhJ0LH+X33zAOXieunywkW0mKEg0og1tHOwNGToH
 us1zavYX4skSzTYFpj0aKR0Bg3TsH9cU72aC2KpNwm6xIVmKlW0EhhpPKpR7ncGr2g+Z
 NB5Uy8u/X42WCOCrIPMVa7ql80Pdx6zOiZxwUc7X8d+fJtAx7Jcb6PSefAwTNNIN4kdc
 VjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788783878; x=1789388678;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mpHYisZxoPlR233qIEeGG6fdrP1BTwn0IBRMhknWUEw=;
 b=k468KwG+8sa0pKLyX8sPkrWSGRJRM0KW4dfiMgs2eAy41DrqbwMnZGk/C5hsi3buW6
 5AhtVHW2ol08ZBxnlcONlYcTZu7YNkKc2eStr/4+HPj9OszEohPAMx7VOSSvlP+28A/m
 znBV410TXRwtW1/z18uORiRV2Mevl5+4pfLRGch4vj4N0E773bMHdQAAHVhnL/vAEu40
 VJwhQ/Kh5936eXQRfwY9cOSL1R/Jm3sax0DCXPnYAOrUAKA6AhqFMy0Tw5K2cKdbvQbM
 z5GMukD2MCHh+T9M6PDWkhvZ//C/UZipxssoHxXY7LkRW1FzFoCKA8xWAUe49GYAP//d
 oiHA==
X-Gm-Message-State: AFuF++naEnoVMfRbXq++d9CIavraou2WxLGeHb9HTXn9YY7cL/r1+1ro
 ffvEVeM899oX9b3osAsYycD+qXjujj+7aSgZMvlpCkrrugFAeWof8FcvbhY3G+GFn9rODsUM+f8
 v33oXTfywAwqsj5zoZjY6XuHqvxlMwGIftMIHoHo+NdoJzLtK2Mluv8t/nhogP0wa0u1P
X-Gm-Gg: AYBFou1roDhaTwcBG0m753Ky+Uhhp7meSXdkknsl8TOm4xEKiSSRAmz89XhT2e9qSqT
 YgPZiXhb0OZF7JPDomreVg5W+kOmCh4WEkQ4o7Y1rm2q11XT8RFK5m4rt8wJJcrxNVOynkuDJ0K
 nqFUhA9oKrx73I0CaGZz4+FB+cNybD5jEL699JiU4H+ZzA7/vUlF44EYQpdyKzSEkQP8JYKWVFs
 9Oq8XyvKR460g27lC6Eg7DuC+cncnVzaGmNipVOPmHKkSTqzO9eQJxqfXkoVVAeb6BWJxRCbF+H
 7xuFjevIFAbEKHBLwn2h9u1L6bBPaa75VAUb+TMSrAqnFFe4jhO9QRjVbfaast4K9CxQjgVWQna
 GgXwVEKsfVu9HxbwzkIDw5ywF2seMaP8gNmfbQ05SH2SMncKgCzeW4WLoGudwYcCNFNN4RuJxIX
 UuavddW/EP6g1B2g0sqHc+amsSU0jNHC0McbtfgMhifFD/1MmJ7jQAIJL6Pkztw1U5MDXYm33w2
 Y+8SgFubf+YeSovNqjtWeC01Gc5hvsPG7+LQoct77ZGnTSyBd0fw9iANVtzjMoG/aycKvMjm1CB
 eJi01oyxaqtNLd1mSgj/5OI6kYEJSEJyM80S8WcDd0FiNHMHTGA=
X-Received: by 2002:a05:600d:6450:10b0:49c:ffaf:95a1 with SMTP id
 5b1f17b1804b1-49cffaf95c3mr250345445e9.1.1788783877995; 
 Mon, 07 Sep 2026 05:24:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm26608521f8f.36.2026.09.07.05.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:24:37 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 12:24:36 +0000
To: MaxF <max@max-fillinger.net>, syzzer <steffan@karger.me>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: 22a24132da88b6be9f121e4c6e74c18a46e7741f
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ca00630047fb678ffa6cfc723271473ed620b96-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3YOz-0008Is-0W
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0359410111622124567=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0359410111622124567==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WQPwj5MwlX8="; charset=UTF-8

--WQPwj5MwlX8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by syzze=
r


Change subject: Check for \0 and RFC 2253 chars in cert subjects
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Check for \0 and RF=
C 2253 chars in cert subjects

When using the OpenSSL library, we escaped e=
mbedded null-bytes in a
certificate's subject in x509_get_subject(), but in=

extract_x509_field_ssl(), we copied any null-bytes that are contained in
t=
he field value=2E When using the option --verify-x509-name, this could
lead=
 to an incorrect name being accepted=2E For example, the common name
"admin=
\0impersonator" would be accepted when running with
--verify-x509-name admi=
n name=2E

To fix this, this commit makes x509_get_subject() return an erro=
r if the
subject contains an embedded null-byte=2E This way, OpenVPN won't =
connect
with peers that present such certificates=2E

As a defense-in-depth=
 measure, we also check for null-bytes in
extract_x509_field_ssl() in case =
a future version of OpenVPN has a code
path that avoids x509_get_subject()=
=2E

Additionally, we escape RFC 2253 characters in the subject that would
=
make parsing of the resulting string ambiguous=2E For example, if the
Commo=
n Name is "name, O=3DInjectedOrg", and the Organization is "RealOrg",
this =
will now be converted to "CN=3Dname\, O=3DInjectedOrg, O=3DRealOrg" to
make=
 it clear which "O" field is legitimate=2E

With Mbed TLS, the x509_get_sub=
ject() function already returned an error
when there is an embedded null-by=
te=2E (As of Mbed TLS 3=2E5=2E) Here too, we
added a check for null-bytes t=
o the function where we extract individual
fields from the subject=2E

Also=
, backend_x509_get_username() is changed so that it returns the
value of th=
e *last* matching field, to be consistent with the behavior
of the OpenSSL =
backend=2E

Discovered and reported by BreachX Zero Day Labs, using Typhon =
AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

CVE: 2026-84790
Repo=
rted-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn=
-private-issues#163

Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
S=
igned-off-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
Acked-b=
y: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1898
Message-Id: <20260907100947=2E25255-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38973=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M Changes=2Erst
M src/openvpn/ssl_verify_mbedtls=2Ec
M src=
/openvpn/ssl_verify_openssl=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
4 f=
iles changed, 228 insertions(+), 28 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/1898/3

diff --git a/Changes=
=2Erst b/Changes=2Erst
index 1f992b2=2E=2Efe81909 100644
--- a/Changes=2Ers=
t
+++ b/Changes=2Erst
@@ -1,5 +1,25 @@
 Overview of changes in 2=2E8
 =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

+User-visible Changes
+--------------------
+Parsing Distinguished Names i=
n certificates
+    (OpenSSL backend:) OpenVPN now rejects certificates tha=
t have a null-byte
+    inside any of the field values of their subject=2E =
To avoid ambiguity in the
+    parsed subject, OpenVPN escapes the followin=
g characters by prefixing them with
+    a backslash:
+     * " " (space) a=
t the start or end of a field,
+     * "#" at the start of a field,
+     *=
 ",", "+", """, "\", "<", ">" and ";" anywhere=2E
+
+    As a result, if yo=
u use the option ``--verify-x509-name <expected subject>``,
+    you need t=
o prefix these characters with a backslash in your configuration=2E
+    Th=
e subject passed to a ``--tls-verify`` script is escaped in the same way an=
d
+    you may need to adjust your script=2E
+
+    (Mbed TLS backend:) The=
 behavior has not changed=2E Subjects with null-bytes were
+    already rej=
ected (assuming OpenVPN was built with Mbed TLS 3=2E5 or later) and
+    th=
e characters mentioned above were already escaped=2E However, the behavior =
of
+    Mbed TLS is slightly different from OpenSSL in that it also escapes=
 "=3D"=2E
 
 
 Overview of changes in 2=2E7
diff --git a/src/openvpn/ssl_ve=
rify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index 2a09e86=2E=2E9f=
676ed 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl=
_verify_mbedtls=2Ec
@@ -214,6 +214,24 @@
     }
 }
 
+static bool
+asn1_buf=
_is_cstr_compatible(const mbedtls_asn1_buf *asn1_buf)
+{
+    if (!(asn1_bu=
f->tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf->tag =3D=3D MBEDTLS_ASN1=
_PRINTABLE_STRING
+          || asn1_buf->tag =3D=3D MBEDTLS_ASN1_IA5_STRIN=
G))
+    {
+        return false;
+    }
+    for (size_t i =3D 0; i < asn1=
_buf->len; i++)
+    {
+        if (asn1_buf->p[i] =3D=3D '\0')
+        {
=
+            return false;
+        }
+    }
+    return true;
+}
+
 result=
_t
 backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_=
field, mbedtls_x509_crt *cert)
 {
@@ -259,16 +277,17 @@
     }
 
     /* Fi=
nd field_oid in the subject name=2E */
-    mbedtls_x509_name *name =3D &ce=
rt->subject;
-    while (name !=3D NULL)
+    mbedtls_x509_name *name =3D N=
ULL;
+    mbedtls_x509_name *next =3D &cert->subject;
+    while (next !=3D=
 NULL)
     {
-        if (strlen(field_oid) =3D=3D name->oid=2Elen
-      =
      && 0 =3D=3D memcmp(name->oid=2Ep, field_oid, name->oid=2Elen))
+     =
   if (strlen(field_oid) =3D=3D next->oid=2Elen
+            && 0 =3D=3D me=
mcmp(next->oid=2Ep, field_oid, next->oid=2Elen))
         {
-            br=
eak;
+            name =3D next;
         }
 
-        name =3D name->next;=

+        next =3D next->next;
     }
 
     /* Not found, return an error =
if this is the peer's certificate */
@@ -277,6 +296,11 @@
         goto fai=
l;
     }
 
+    if (!asn1_buf_is_cstr_compatible(&name->val))
+    {
+    =
    goto fail;
+    }
+
     /* Check that we have room in the buffer, incl=
uding the terminating '/0' byte=2E */
     if (cn_len <=3D name->val=2Elen)=

     {
@@ -586,22 +610,11 @@
 static char *
 asn1_buf_to_c_string(const mb=
edtls_asn1_buf *orig, struct gc_arena *gc)
 {
-    size_t i;
     char *val=
;
 
-    if (!(orig->tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || orig->tag =3D=
=3D MBEDTLS_ASN1_PRINTABLE_STRING
-          || orig->tag =3D=3D MBEDTLS_AS=
N1_IA5_STRING))
+    if (!asn1_buf_is_cstr_compatible(orig))
     {
-      =
  /* Only support C-string compatible types */
-        return string_alloc=
("ERROR: unsupported ASN=2E1 string type", gc);
-    }
-
-    for (i =3D 0;=
 i < orig->len; ++i)
-    {
-        if (orig->p[i] =3D=3D '\0')
-        {=

-            return string_alloc("ERROR: embedded null value", gc);
-     =
   }
+        return string_alloc("ERROR: Unsupported string type or embedd=
ed null bytes=2E", gc);
     }
     val =3D gc_malloc(orig->len + 1, false,=
 gc);
     memcpy(val, orig->p, orig->len);
diff --git a/src/openvpn/ssl_ve=
rify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index b8648fd=2E=2Ea6=
307f6 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl=
_verify_openssl=2Ec
@@ -196,12 +196,13 @@
     int lastpos =3D -1;
     int=
 tmp =3D -1;
     unsigned char *buf =3D NULL;
+    result_t ret =3D FAILUR=
E;
 
     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
     =
if (field_name_obj =3D=3D NULL)
     {
         msg(D_TLS_ERRORS, "Invalid =
X509 attribute name '%s'", field_name);
-        return FAILURE;
+        g=
oto exit;
     }
 
     ASSERT(size > 0);
@@ -222,28 +223,31 @@
     /* Not=
hing found */
     if (lastpos =3D=3D -1)
     {
-        return FAILURE;
+=
        goto exit;
     }
 
     const X509_NAME_ENTRY *x509ne =3D X509_NAM=
E_get_entry(x509, lastpos);
     if (!x509ne)
     {
-        return FAILUR=
E;
+        goto exit;
     }
 
     const ASN1_STRING *asn1 =3D X509_NAME_=
ENTRY_get_data(x509ne);
     if (!asn1)
     {
-        return FAILURE;
+  =
      goto exit;
     }
-    if (ASN1_STRING_to_UTF8(&buf, asn1) < 0)
+    =
int length =3D ASN1_STRING_to_UTF8(&buf, asn1);
+    if (length < 0 || (siz=
e_t)length !=3D strlen((char *)buf))
     {
-        return FAILURE;
+     =
   goto exit;
     }
 
     strncpynt(out, (char *)buf, size);
 
-    const=
 result_t ret =3D (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+    re=
t =3D (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+
+exit:
     OPENS=
SL_free(buf);
     return ret;
 }
@@ -385,8 +389,7 @@
     }
 
     X509_NA=
ME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
-                 =
      XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
-  =
                         | ASN1_STRFLGS_ESC_CTRL);
+                       =
XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_ESC_2253 | ASN1_STRFLG=
S_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
     {
@@ -395,6 +398,16 =
@@
 
     BIO_get_mem_ptr(subject_bio, &subject_mem);
 
+    /* Check subje=
ct for '\0' bytes=2E */
+    for (size_t i =3D 0; i < subject_mem->length; =
i++)
+    {
+        if (subject_mem->data[i] =3D=3D 0)
+        {
+       =
     msg(M_WARN, "ERROR: Certificate subject contains a '\\0' byte=2E");
+ =
           goto err;
+        }
+    }
+
     subject =3D gc_malloc(subject=
_mem->length + 1, false, gc);
 
     memcpy(subject, subject_mem->data, sub=
ject_mem->length);
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tes=
ts/unit_tests/openvpn/test_ssl=2Ec
index 887c492=2E=2Efcebcdb 100644
--- a/=
tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_s=
sl=2Ec
@@ -873,6 +873,157 @@
     free_certificate(cert);
 }
 
+/* Certific=
ate with two CNs, "foo" and "bar"=2E
+ *
+ * Generated with:
+ * openssl re=
q -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -subj "/CN=3Dfoo/CN=
=3Dbar" \
+ * -noenc -out two_cns=2Ecrt -keyout two_cns=2Ekey
+ */
+static =
const char *cert_with_two_cns =3D
+    "-----BEGIN CERTIFICATE-----\n"
+   =
 "MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n"
+    =
"HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n"
+    "=
MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n"
+    "B=
yqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n"
+    "Pv=
PMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n"
+    "hGB=
WFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n"
+    "dFT/=
BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n"
+    "/wQFM=
AMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E88\n"
+    "cwoCK3=
UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\n"
+    "OyQnlH8=
W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n"
+    "-----END CERTIFICATE-----\n";
=
+
+void
+ssl_test_extract_last_matching_field(void **state)
+{
+    /* When=
 there are multiple fields of the same type in the certificate's subject, O=
penVPN
+     * should extract the value of the last matching field=2E This =
is essentially arbitrary and there
+     * is no correct choice here, but t=
his test exists to make sure that the behavior is consistent
+     * betwee=
n different backends=2E
+     */
+    openvpn_x509_cert_t *cert =3D get_cer=
tificate(cert_with_two_cns);
+
+    char username[TLS_USERNAME_LEN + 1] =3D=
 { 0 };
+    assert_int_equal(backend_x509_get_username(username, sizeof(us=
ername), "CN", cert), SUCCESS);
+    assert_string_equal(username, "bar");
=
+    free_certificate(cert);
+}
+
+/* Certificate with a null-byte embedded=
 in the CN=2E
+ *
+ * Generated with the following Python script:
+ *
+ * f=
rom cryptography import x509
+ * from cryptography=2Ex509=2Eoid import Name=
OID, ExtensionOID, ExtendedKeyUsageOID
+ * from cryptography=2Ehazmat=2Epri=
mitives import hashes, serialization
+ * from cryptography=2Ehazmat=2Eprimi=
tives=2Easymmetric import ec
+ * import datetime
+ *
+ * private_key =3D ec=
=2Egenerate_private_key(ec=2ESECP384R1())
+ * now =3D datetime=2Edatetime=
=2Enow(datetime=2Etimezone=2Eutc)
+ * name =3D "with\x00null"
+ *
+ * cert =
=3D (x509=2ECertificateBuilder()
+ *             =2Esubject_name(x509=2ENam=
e([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]))
+ *             =2E=
issuer_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name)]=
))
+ *             =2Epublic_key(private_key=2Epublic_key())
+ *           =
  =2Eserial_number(x509=2Erandom_serial_number())
+ *             =2Enot_va=
lid_before(now)
+ *             =2Enot_valid_after(now + datetime=2Etimedel=
ta(days=3D10 * 365))
+ *             =2Esign(private_key, hashes=2ESHA256()=
))
+ *
+ * print(str(cert=2Epublic_bytes(serialization=2EEncoding=2EPEM), e=
ncoding=3D'utf-8'))
+ **/
+static const char *cert_with_null =3D
+    "----=
-BEGIN CERTIFICATE-----\n"
+    "MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWl=
OtBzAKBggqhkjOPQQDAjAU\n"
+    "MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQ=
zMDA4WhcNMzYwODI1MTQz\n"
+    "MDA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcq=
hkjOPQIBBgUrgQQAIgNi\n"
+    "AAT7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iX=
YCIRW5wg6/mlPaeiJY/\n"
+    "Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WH=
e1dJyVtoRBvkNvy5+k\n"
+    "GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3Ps=
Bp0CqiaSNByGiP75i\n"
+    "k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXx=
ROKA9qQqaM3d92Mp\n"
+    "EzZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n"
+    =
"-----END CERTIFICATE-----\n";
+
+void
+ssl_test_reject_null_in_cert_subjec=
t(void **state)
+{
+    openvpn_x509_cert_t *cert =3D get_certificate(cert_=
with_null);
+    struct gc_arena gc =3D gc_new();
+
+    /* Trying to get t=
he subject as a whole should fail=2E */
+    assert_ptr_equal(x509_get_subj=
ect(cert, &gc), NULL);
+
+    /* Trying to extract the common name should f=
ail=2E */
+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };
+    assert_i=
nt_equal(backend_x509_get_username(username, sizeof(username), "CN", cert),=
 FAILURE);
+    gc_free(&gc);
+    free_certificate(cert);
+}
+
+/* Cert wi=
th CN=3D"name, O=3DInjectedOrg" and O=3DRealOrg=2E
+ *
+ * Generated with t=
he following Python script:
+ *
+ * from cryptography import x509
+ * from =
cryptography=2Ex509=2Eoid import NameOID, ExtensionOID, ExtendedKeyUsageOID=

+ * from cryptography=2Ehazmat=2Eprimitives import hashes, serialization
+=
 * from cryptography=2Ehazmat=2Eprimitives=2Easymmetric import ec
+ * impor=
t datetime
+ *
+ * private_key =3D ec=2Egenerate_private_key(ec=2ESECP384R1=
())
+ * now =3D datetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)
+ * na=
me =3D "name, O=3DInjectedOrg"
+ * org =3D "RealOrg"
+ *
+ * distinguished_=
name =3D x509=2EName([
+ *     x509=2ENameAttribute(NameOID=2ECOMMON_NAME, =
name),
+ *     x509=2ENameAttribute(NameOID=2EORGANIZATION_NAME, org)
+ * ]=
)
+ *
+ * cert =3D (x509=2ECertificateBuilder()
+ *             =2Esubject_=
name(distinguished_name)
+ *             =2Eissuer_name(distinguished_name)=

+ *             =2Epublic_key(private_key=2Epublic_key())
+ *             =
=2Eserial_number(x509=2Erandom_serial_number())
+ *             =2Enot_vali=
d_before(now)
+ *             =2Enot_valid_after(now + datetime=2Etimedelta=
(days=3D10 * 365))
+ *             =2Esign(private_key, hashes=2ESHA256()))=

+ *
+ * print(str(cert=2Epublic_bytes(serialization=2EEncoding=2EPEM), enc=
oding=3D'utf-8'))
+ */
+static const char *cert_with_rfc_2253_chars =3D
+  =
  "-----BEGIN CERTIFICATE-----\n"
+    "MIIBnTCCASOgAwIBAgIUR1IGc6A800U14v/=
ykZNR21aVubowCgYIKoZIzj0EAwIw\n"
+    "MDEcMBoGA1UEAwwTbmFtZSwgTz1JbmplY3Rl=
ZE9yZzEQMA4GA1UECgwHUmVhbE9y\n"
+    "ZzAeFw0yNjA4MjgxNTQ3NDdaFw0zNjA4MjUxN=
TQ3NDdaMDAxHDAaBgNVBAMME25h\n"
+    "bWUsIE89SW5qZWN0ZWRPcmcxEDAOBgNVBAoMB1=
JlYWxPcmcwdjAQBgcqhkjOPQIB\n"
+    "BgUrgQQAIgNiAAR6zl9QPAbAnHWN//MRdowuhu0=
Sol6N+lqB/qk+D+2NHCd/t4H9\n"
+    "cJlswUh6EPsmLxgfMYgO2QwClFWEFWvtXQs8Bggo=
idY6i9pmAPhs8+9fmIyuNVpG\n"
+    "3vUWZrUBRgylwaIwCgYIKoZIzj0EAwIDaAAwZQIwK=
zXmR8YPQZ1pratM9meVmGkH\n"
+    "1rpHgV3U8oeg+jXmfVcZJTpDeDz4yBl4V3KBKT7HAj=
EAj2qkaTz7fiSwBKsxJQWH\n"
+    "dQFPBCAYU9zZJvlNnEPtmHIwaD/qHXDeClr/HRItU3B=
9\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_escape_rfc_2253_=
chars_in_subject(void **state)
+{
+    openvpn_x509_cert_t *cert =3D get_ce=
rtificate(cert_with_rfc_2253_chars);
+    struct gc_arena gc =3D gc_new();
=
+
+    char *subject =3D x509_get_subject(cert, &gc);
+    assert_non_null(=
subject);
+
+    /* Mbed TLS escapes the '=3D' character but OpenSSL does n=
ot=2E */
+    const char *expected_subject_openssl =3D "CN=3Dname\\, O=3DIn=
jectedOrg, O=3DRealOrg";
+    const char *expected_subject_mbedtls =3D "CN=
=3Dname\\, O\\=3DInjectedOrg, O=3DRealOrg";
+
+    assert_true(strcmp(subje=
ct, expected_subject_openssl) =3D=3D 0 || strcmp(subject, expected_subject_=
mbedtls) =3D=3D 0);
+    gc_free(&gc);
+    free_certificate(cert);
+}
+
 v=
oid
 ssl_test_extract_peer_info(void **state)
 {
@@ -960,6 +1111,9 @@
     =
    cmocka_unit_test(test_data_channel_known_vectors_epoch),
         cmock=
a_unit_test(test_data_channel_known_vectors_shortpktid),
         cmocka_un=
it_test(crypto_test_print_cert_details),
+        cmocka_unit_test(ssl_test=
_extract_last_matching_field),
+        cmocka_unit_test(ssl_test_reject_nu=
ll_in_cert_subject),
+        cmocka_unit_test(ssl_test_escape_rfc_2253_cha=
rs_in_subject),
         cmocka_unit_test(ssl_test_extract_peer_info)
 
   =
  };

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic334518048d=
6ca57a504257e210467f9c451d268
Gerrit-Change-Number: 1898
Gerrit-PatchSet: 3=

Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@=
greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: syzzer <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--WQPwj5MwlX8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by syzzer</p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">Check for \0 and RFC 2253 chars i=
n cert subjects<br><br>When using the OpenSSL library, we escaped embedded =
null-bytes in a<br>certificate&#39;s subject in x509_get_subject(), but in<=
br>extract_x509_field_ssl(), we copied any null-bytes that are contained in=
<br>the field value=2E When using the option --verify-x509-name, this could=
<br>lead to an incorrect name being accepted=2E For example, the common nam=
e<br>&quot;admin\0impersonator&quot; would be accepted when running with<br=
>--verify-x509-name admin name=2E<br><br>To fix this, this commit makes x50=
9_get_subject() return an error if the<br>subject contains an embedded null=
-byte=2E This way, OpenVPN won&#39;t connect<br>with peers that present suc=
h certificates=2E<br><br>As a defense-in-depth measure, we also check for n=
ull-bytes in<br>extract_x509_field_ssl() in case a future version of OpenVP=
N has a code<br>path that avoids x509_get_subject()=2E<br><br>Additionally,=
 we escape RFC 2253 characters in the subject that would<br>make parsing of=
 the resulting string ambiguous=2E For example, if the<br>Common Name is &q=
uot;name, O=3DInjectedOrg&quot;, and the Organization is &quot;RealOrg&quot=
;,<br>this will now be converted to &quot;CN=3Dname\, O=3DInjectedOrg, O=3D=
RealOrg&quot; to<br>make it clear which &quot;O&quot; field is legitimate=
=2E<br><br>With Mbed TLS, the x509_get_subject() function already returned =
an error<br>when there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E=
) Here too, we<br>added a check for null-bytes to the function where we ext=
ract individual<br>fields from the subject=2E<br><br>Also, backend_x509_get=
_username() is changed so that it returns the<br>value of the *last* matchi=
ng field, to be consistent with the behavior<br>of the OpenSSL backend=2E<b=
r><br>Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil=
 v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>CVE: 2026-84790<b=
r>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Github: =
OpenVPN/openvpn-private-issues#163<br><br>Change-Id: Ic334518048d6ca57a5042=
57e210467f9c451d268<br>Signed-off-by: Max Fillinger &lt;maximilian=2Efillin=
ger@sentyron=2Ecom&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898<br>Messa=
ge-Id: &lt;20260907100947=2E25255-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38=
973=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M Changes=2Erst<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/o=
penvpn/ssl_verify_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br=
>4 files changed, 228 insertions(+), 28 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/18=
98/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/Changes=2Erst b/Changes=2Erst</span><br><span>ind=
ex 1f992b2=2E=2Efe81909 100644</span><br><span>--- a/Changes=2Erst</span><b=
r><span>+++ b/Changes=2Erst</span><br><span>@@ -1,5 +1,25 @@</span><br><spa=
n> Overview of changes in 2=2E8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+User-visible Changes</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+--------------------</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+Parsing Distinguished Names in certifi=
cates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (OpenSSL b=
ackend:) OpenVPN now rejects certificates that have a null-byte</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    inside any of the field val=
ues of their subject=2E To avoid ambiguity in the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    parsed subject, OpenVPN escapes the follo=
wing characters by prefixing them with</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    a backslash:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * &quot; &quot; (space) at the start or end of a field=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * &quot;#&quo=
t; at the start of a field,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * &quot;,&quot;, &quot;+&quot;, &quot;&quot;&quot;, &quot;\&qu=
ot;, &quot;&lt;&quot;, &quot;&gt;&quot; and &quot;;&quot; anywhere=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    As a result, if you use the option ``--v=
erify-x509-name &lt;expected subject&gt;``,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    you need to prefix these characters with a back=
slash in your configuration=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    The subject passed to a ``--tls-verify`` script is escaped i=
n the same way and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   you may need to adjust your script=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    (Mbed TLS backend:) The behavior has not changed=2E Subjects with nul=
l-bytes were</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    alr=
eady rejected (assuming OpenVPN was built with Mbed TLS 3=2E5 or later) and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    the characters =
mentioned above were already escaped=2E However, the behavior of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    Mbed TLS is slightly diffe=
rent from OpenSSL in that it also escapes &quot;=3D&quot;=2E</span><br><spa=
n> </span><br><span> </span><br><span> Overview of changes in 2=2E7</span><=
br><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_=
verify_mbedtls=2Ec</span><br><span>index 2a09e86=2E=2E9f676ed 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -214,6 +214,24 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+asn1_buf_is_cstr_compatible(const mbedtls_asn1_b=
uf *asn1_buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!(asn1_buf-&gt;t=
ag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_=
PRINTABLE_STRING</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       || asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_IA5_STRING))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (size_t i =3D 0; i &lt; asn1_buf-&gt;len; i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (asn1_buf-&gt;p[i] =3D=3D &#3=
9;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> result_t</span><br><span> backend_x509_g=
et_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x50=
9_crt *cert)</span><br><span> {</span><br><span>@@ -259,16 +277,17 @@</span=
><br><span>     }</span><br><span> </span><br><span>     /* Find field_oid =
in the subject name=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mbedtls_x509_name *name =3D &amp;cert-&gt;subject;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    while (name !=3D NULL)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_x509_name *name =3D=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_x=
509_name *next =3D &amp;cert-&gt;subject;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    while (next !=3D NULL)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (strlen(field_=
oid) =3D=3D name-&gt;oid=2Elen</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            &amp;&amp; 0 =3D=3D memcmp(name-&gt;oid=2Ep, field_oid=
, name-&gt;oid=2Elen))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (strlen(field_oid) =3D=3D next-&gt;oid=2Elen</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; 0 =3D=3D memc=
mp(next-&gt;oid=2Ep, field_oid, next-&gt;oid=2Elen))</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            name =
=3D next;</span><br><span>         }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        name =3D name-&gt;next;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        next =3D next-&gt;next=
;</span><br><span>     }</span><br><span> </span><br><span>     /* Not foun=
d, return an error if this is the peer&#39;s certificate */</span><br><span=
>@@ -277,6 +296,11 @@</span><br><span>         goto fail;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!asn1_buf_is_cstr_compatible(&amp;name-&gt;val))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto fail;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     /* Check that we have room in the buffer,=
 including the terminating &#39;/0&#39; byte=2E */</span><br><span>     if =
(cn_len &lt;=3D name-&gt;val=2Elen)</span><br><span>     {</span><br><span>=
@@ -586,22 +610,11 @@</span><br><span> static char *</span><br><span> asn1_=
buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *gc)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t =
i;</span><br><span>     char *val;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!(orig-&gt;tag =3D=3D MBEDTLS_ASN1_=
UTF8_STRING || orig-&gt;tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-          || orig-&gt;tag =3D=3D=
 MBEDTLS_ASN1_IA5_STRING))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!asn1_buf_is_cstr_compatible(orig))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Only support=
 C-string compatible types */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return string_alloc(&quot;ERROR: unsupported ASN=2E1 string=
 type&quot;, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; orig-&gt;len; ++=
i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (orig-&gt;p[i] =3D=3D &#=
39;\0&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return str=
ing_alloc(&quot;ERROR: embedded null value&quot;, gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return string_alloc(&quot;ERROR: Unsupported=
 string type or embedded null bytes=2E&quot;, gc);</span><br><span>     }</=
span><br><span>     val =3D gc_malloc(orig-&gt;len + 1, false, gc);</span><=
br><span>     memcpy(val, orig-&gt;p, orig-&gt;len);</span><br><span>diff -=
-git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>index b8648fd=2E=2Ea6307f6 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
verify_openssl=2Ec</span><br><span>@@ -196,12 +196,13 @@</span><br><span>  =
   int lastpos =3D -1;</span><br><span>     int tmp =3D -1;</span><br><span=
>     unsigned char *buf =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    result_t ret =3D FAILURE;</span><br><span> </span><br><s=
pan>     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);</span>=
<br><span>     if (field_name_obj =3D=3D NULL)</span><br><span>     {</span=
><br><span>         msg(D_TLS_ERRORS, &quot;Invalid X509 attribute name &#3=
9;%s&#39;&quot;, field_name);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return FAILURE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto exit;</span><br><span>     }</span><br><span> </sp=
an><br><span>     ASSERT(size &gt; 0);</span><br><span>@@ -222,28 +223,31 @=
@</span><br><span>     /* Nothing found */</span><br><span>     if (lastpos=
 =3D=3D -1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return FAILURE;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br><span>=
 </span><br><span>     const X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entr=
y(x509, lastpos);</span><br><span>     if (!x509ne)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;=
</span><br><span>     }</span><br><span> </span><br><span>     const ASN1_S=
TRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);</span><br><span>     if (=
!asn1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return FAILURE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto exit;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ASN1_STRING_to_UTF8(&amp;buf, asn1)=
 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len=
gth =3D ASN1_STRING_to_UTF8(&amp;buf, asn1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (length &lt; 0 || (size_t)length !=3D strle=
n((char *)buf))</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br><s=
pan> </span><br><span>     strncpynt(out, (char *)buf, size);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const result_=
t ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ret =3D (strlen((char *)buf)=
 &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exit:<=
/span><br><span>     OPENSSL_free(buf);</span><br><span>     return ret;</s=
pan><br><span> }</span><br><span>@@ -385,8 +389,7 @@</span><br><span>     }=
</span><br><span> </span><br><span>     X509_NAME_print_ex(subject_bio, X50=
9_get_subject_name(cert), 0,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_=
STRFLGS_UTF8_CONVERT</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                          | ASN1_STRFLGS_ESC_CTRL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       XN_FLAG_SEP_CPLUS_=
SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_ESC_2253 | ASN1_STRFLGS_UTF8_CONVERT);</=
span><br><span> </span><br><span>     if (BIO_eof(subject_bio))</span><br><=
span>     {</span><br><span>@@ -395,6 +398,16 @@</span><br><span> </span><b=
r><span>     BIO_get_mem_ptr(subject_bio, &amp;subject_mem);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check sub=
ject for &#39;\0&#39; bytes=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (size_t i =3D 0; i &lt; subject_mem-&gt;length; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (subject_mem-&gt;data[i=
] =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
WARN, &quot;ERROR: Certificate subject contains a &#39;\\0&#39; byte=2E&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            got=
o err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     subject =3D gc_=
malloc(subject_mem-&gt;length + 1, false, gc);</span><br><span> </span><br>=
<span>     memcpy(subject, subject_mem-&gt;data, subject_mem-&gt;length);</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/u=
nit_tests/openvpn/test_ssl=2Ec</span><br><span>index 887c492=2E=2Efcebcdb 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -873,=
6 +873,157 @@</span><br><span>     free_certificate(cert);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Certificate with two CNs, &quot;foo&quot; and &quot;bar&quot;=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Generated with:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * openssl req -x509 -newkey ec -pkeyopt =
ec_paramgen_curve:secp384r1 -subj &quot;/CN=3Dfoo/CN=3Dbar&quot; \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * -noenc -out two_cns=2Ecrt=
 -keyout two_cns=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const =
char *cert_with_two_cns =3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5j=
eRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiYXIwHhc=
NMjYwODI4MTU1NjAwWhcN\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb28xDDAKBgNVBAMMA2J=
hcjB2MBAG\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;PvPM=
WGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;hGBWFvnUsqdNo765=
lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;dFT/BNoJMB8GA1UdIwQYMBaAFPwn=
D+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxaz=
Gb6RRQtXzOWCPLRKId4e+E88\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/JqF41uK57H=
+8i/16oZkBcm\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFICATE---=
--\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssl_test_extract_last_matching_field(void=
 **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* When there are multip=
le fields of the same type in the certificate&#39;s subject, OpenVPN</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * should extract the =
value of the last matching field=2E This is essentially arbitrary and there=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * is no correc=
t choice here, but this test exists to make sure that the behavior is consi=
stent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * between=
 different backends=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openv=
pn_x509_cert_t *cert =3D get_certificate(cert_with_two_cns);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    char username[TLS_USERNAME_LEN + 1] =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(b=
ackend_x509_get_username(username, sizeof(username), &quot;CN&quot;, cert),=
 SUCCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_string_equal(username, &quot;bar&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    free_certificate(cert);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Cer=
tificate with a null-byte embedded in the CN=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Generated with the following Python script:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * from cryptography import x509</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ex509=2Eoid import =
NameOID, ExtensionOID, ExtendedKeyUsageOID</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * from cryptography=2Ehazmat=2Eprimitives import ha=
shes, serialization</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * from cryptography=2Ehazmat=2Eprimitives=2Easymmetric import ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * import datetime</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * private_key =3D ec=2Egenerate_private_key(ec=
=2ESECP384R1())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * n=
ow =3D datetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * name =3D &quot;with\x00null&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * cert =3D (x509=2ECertificateBuil=
der()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 =2Esubject_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, n=
ame)]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   =2Eissuer_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON_NAME, =
name)]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    =2Epublic_key(private_key=2Epublic_key())</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             =2Eserial_number(x509=2Erandom_ser=
ial_number())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         =2Enot_valid_before(now)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             =2Enot_valid_after(now + datetime=2Etimedelta(=
days=3D10 * 365))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
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
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Cert with CN=3D&quot;name, O=3DInjectedOrg&quot; an=
d O=3DRealOrg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generated with th=
e following Python script:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from cr=
yptography import x509</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * from cryptography=2Ex509=2Eoid import NameOID, ExtensionOID, Extended=
KeyUsageOID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from =
cryptography=2Ehazmat=2Eprimitives import hashes, serialization</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ehazmat=
=2Eprimitives=2Easymmetric import ec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * import datetime</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* private_key =3D ec=2Egenerate_private_key(ec=2ESECP384R1())</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * now =3D datetime=2Edatetime=2E=
now(datetime=2Etimezone=2Eutc)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * name =3D &quot;name, O=3DInjectedOrg&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * org =3D &quot;RealOrg&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * distinguished_name =3D x509=2EName([</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     x509=2ENameAttrib=
ute(NameOID=2ECOMMON_NAME, name),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *     x509=2ENameAttribute(NameOID=2EORGANIZATION_NAME, org)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * cert =3D (x509=2ECertificateBuilder()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Esubject_nam=
e(distinguished_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             =2Eissuer_name(distinguished_name)</span><br><span style=
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
&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static const char *cert_with=
_rfc_2253_chars =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;-----BEGIN CERTIFICATE-----\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;MIIBnTCCASOgAwIBAgIUR1IGc6A800U14v/ykZN=
R21aVubowCgYIKoZIzj0EAwIw\n&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &quot;MDEcMBoGA1UEAwwTbmFtZSwgTz1JbmplY3RlZE9yZzEQMA4GA1U=
ECgwHUmVhbE9y\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;ZzAeFw0yNjA4MjgxNTQ3NDdaFw0zNjA4MjUxNTQ3NDdaMDAxHDAaBgNVBAMME25=
h\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
bWUsIE89SW5qZWN0ZWRPcmcxEDAOBgNVBAoMB1JlYWxPcmcwdjAQBgcqhkjOPQIB\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;BgUrgQQAIgNi=
AAR6zl9QPAbAnHWN//MRdowuhu0Sol6N+lqB/qk+D+2NHCd/t4H9\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;cJlswUh6EPsmLxgfMYgO2QwC=
lFWEFWvtXQs8BggoidY6i9pmAPhs8+9fmIyuNVpG\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;3vUWZrUBRgylwaIwCgYIKoZIzj0EAwIDaAAw=
ZQIwKzXmR8YPQZ1pratM9meVmGkH\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;1rpHgV3U8oeg+jXmfVcZJTpDeDz4yBl4V3KBKT7HAjEAj2qk=
aTz7fiSwBKsxJQWH\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;dQFPBCAYU9zZJvlNnEPtmHIwaD/qHXDeClr/HRItU3B9\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFIC=
ATE-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ssl_test_escape_rfc_2253_chars_in_su=
bject(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_c=
ert_t *cert =3D get_certificate(cert_with_rfc_2253_chars);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *subject =3D x509_get_subject=
(cert, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_non_null(subject);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Mbed =
TLS escapes the &#39;=3D&#39; character but OpenSSL does not=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *expected_sub=
ject_openssl =3D &quot;CN=3Dname\\, O=3DInjectedOrg, O=3DRealOrg&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *expecte=
d_subject_mbedtls =3D &quot;CN=3Dname\\, O\\=3DInjectedOrg, O=3DRealOrg&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(strcmp(subject, exp=
ected_subject_openssl) =3D=3D 0 || strcmp(subject, expected_subject_mbedtls=
) =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
ree_certificate(cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> void</span><br><span> ssl_test_extract_peer_info(void **state)</span><br=
><span> {</span><br><span>@@ -960,6 +1111,9 @@</span><br><span>         cmo=
cka_unit_test(test_data_channel_known_vectors_epoch),</span><br><span>     =
    cmocka_unit_test(test_data_channel_known_vectors_shortpktid),</span><br=
><span>         cmocka_unit_test(crypto_test_print_cert_details),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_=
test_extract_last_matching_field),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(ssl_test_reject_null_in_cert_subjec=
t),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_u=
nit_test(ssl_test_escape_rfc_2253_chars_in_subject),</span><br><span>      =
   cmocka_unit_test(ssl_test_extract_peer_info)</span><br><span> </span><br=
><span>     };</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">change 1898=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
c334518048d6ca57a504257e210467f9c451d268 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1898 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max=
-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: c=
ron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--WQPwj5MwlX8=--


--===============0359410111622124567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0359410111622124567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0359410111622124567==--

