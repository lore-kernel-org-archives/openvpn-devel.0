Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168AEC79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HJ52WlkC5/EXC11up9Wqgey5c2BYK5Nj8Y6/M1gJIho=; b=Wz7Cm0DVWHMfF1z8LFa3bjqDXG
	Lu20BXb/cHjKJ2EVl4OU3FFzeadsW8D7x2Q12v3/wvuaWxQnFswVOI9uZ+RGevClCCflDjuGs1XMn
	cJbDKFQTBkQ5znQ6FAxrFwwobOS8SyVWBltD+2FrLErPfRRWClRc+nFlY2TWANslg9ps=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3VJM-0007oC-0x;
	Mon, 07 Sep 2026 09:06:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3VJK-0007o5-IZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8g90cvWBmBSkCd5c5Px7V3DGeyy/KXjslR1VvESaSV0=; b=OiroVgHcBkO+Mtb2snq6jHskaO
 O8+GZsw/rKrQvptS0TAL9nD4ArZExO/otPetViJ0lZ1q9lNu8COccCb02DRI9TFx9H0LjWOVRq1ts
 WYYK8nraXg+wnvnT6W/KIFhBvwQkE83WZkM4rfwonhyTMd5tUVAFgjULaXIsEYsqXNgQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8g90cvWBmBSkCd5c5Px7V3DGeyy/KXjslR1VvESaSV0=; b=S
 esP/gUlyCdob013LFv0N+wfN4zSKX01Z32ioF3Dv/O+SqA6W72ZRKEkXpy1bMrrM6erx0840fjaJy
 TRtNcsxoTj0lFH7X3lEhFU7kcjcHnIjiVaRdPxZwgUv8lYVMpGFws0gH0h7h59AyezFi6i8qahHtn
 sGLVyo4mOu2S9Ec8=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3VJH-0003fe-9e for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 09:06:42 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b96837ca3so25990805e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788771993; x=1789376793; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8g90cvWBmBSkCd5c5Px7V3DGeyy/KXjslR1VvESaSV0=;
 b=Bp/VvbYjVPjpg0CONwxLfhArax8YXUQNT0o/LbL+mnf1cEbYaS6nVIAy3xhSgNIj9e
 7uh3pJIGT4WbI2+4TTW3skz1DMd/EOm1obmd5IRHmEqfHwpCfV/2uOuLxMmq1C71DjFH
 RWVT4eW05Qht9mhf1P2sSCm9AaHRiB5uP94GBeBgs9sL68JrKcjxc/NRgnH+Lw9Pc200
 MAS1jcvcGQtc+198zkDz9jFIdQhl858ltqjxFWwef+VAJPNx7syBBSCgEWDRV47Rr3H3
 lyi+PruITLebAbJHR06O5YPhuZ+ppJVlI0by4TS7w43P2clVtqZIcvT1nBSHgOyQhMQ+
 BIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788771993; x=1789376793;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8g90cvWBmBSkCd5c5Px7V3DGeyy/KXjslR1VvESaSV0=;
 b=HT64bH4oj9DFJ4soG32y7+lB975TDGd7fb6tmFDW5BNnAox/ZcnT9jPBwIIxBMUAOc
 aiVLeYaKA7vAb/oQiorToxpbjv9DicRJQvLSyrSllHjFQNMGtROAT44BGpltlU+8Fb+2
 qT9VsNMCvE7GNCYY7rY/E7QU0qwwglJgmpd01SAIgvSgX/8lB6/iPI6TtDVUlaQM8scY
 tYV6e0zMtOMw/qe1grQm95pg4oGxJ4V4nWcfa1E4R+8NXpDnWP7BBjt60GpRue4Jep8I
 k+XsMHh7ugqZ5m4W/b9Q6qBRAY5/VbhIYATJxC4olA6kJlKQeIQJEnXRBoaUP7TvFqFy
 1hEg==
X-Gm-Message-State: AFuF++kwJpg40NCqCE4G+A7OaduCRCawf244UZEHvuEEQ8NDavEG+lfD
 jDS1MBtiTljGYNi1Ss4FFh9ep+LrWyZoaFnuMqSO0pCzIm27gX2TkFezgTlk3Pe54L4RBkjcD5i
 wQyuVNh8of1p/3uVHjdgpsLJQnCj1OmMUxMsdQbO6kdkIMWS7snUA/ydQu+HJgYBdSPdw
X-Gm-Gg: AYBFou3PIVAi5NDymq9hwgESqS1g9zsvVriI39aV+S9ZgsQ0KkoCoVnCxibi7c3/Iv5
 NiIfZ1eImaEUVcPsFmo2jRdOSJeAD9+5joOsEenvBfZUU2qLTtHFuFHD9zw2yaZmJvgY+HSXk2h
 jIWSrFYBpKuzQmDWq/jZhQSfG55HHgn4++DDXLYEDdXx52m9r7RMSWPc5c18BJUeO2gP4vrPx2n
 J2OkL/MNLiqAvcaX6k1aMrdh0WvwwK7zLfSDxkIfNroPh3wJ2ESFr9YjG0fS/j3SrS8EdkzekCP
 6dbrFKoqLVu/4V9k3EVOXlHeur26VMq9N3mV91HtSIGWYx6iO9S6pxYYtiz+LMJKOnGyt+V0XOq
 JZLwmq1jRoe9YxaKxbvvUIyQZjG1lCc5HlwbxJCzYsRY1fD1sATtQvw82p6VqKZS0+YI1DofYh1
 uR1tSqM1Sq5lZ/N0k8UOy1v7n8TMzTotE461h3UNKMaR5acmoBoqaLnA/VCC3mO4vRBPi7NgLdF
 Karv9tdBS/1OM0R6fvMk2o9HuEhyVgOJWPzCtnR1kEctTxDxu12jsh4vby1ARYXuHx42p1e6lHi
 rESha+Vr/gPiBVZ3KQKzkFGnBi0ZRtxlJLXC96J0QKferwCgSXk=
X-Received: by 2002:a05:600c:474a:b0:49c:e42b:a4ac with SMTP id
 5b1f17b1804b1-49cf823f60amr189334705e9.11.1788771992251; 
 Mon, 07 Sep 2026 02:06:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm293770885e9.0.2026.09.07.02.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:06:31 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 09:06:30 +0000
To: syzzer <steffan@karger.me>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: 590a76643df65c4fc73a696a83d58b90ded32af7
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d2bbc13c6e2ff397ba4de614c72f78b16105d5bb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3VJH-0003fe-9e
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5721277011923044112=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5721277011923044112==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eOu2PzvqnzQ="; charset=UTF-8

--eOu2PzvqnzQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos, syzzer=2E

He=
llo cron2, plaisthos, syzzer, 

I'd like you to reexamine a change=2E Pleas=
e visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail

to=
 look at the new patch set (#2)=2E

The following approvals got outdated an=
d were removed:
Code-Review+2 by syzzer, Code-Review-1 by cron2


Change su=
bject: Check for \0 and RFC 2253 chars in cert subjects
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Check for \0 and RFC 2253 chars=
 in cert subjects

When using the OpenSSL library, we escaped embedded null=
-bytes in a
certificate's subject in x509_get_subject(), but in
extract_x50=
9_field_ssl(), we copied any null-bytes that are contained in
the field val=
ue=2E When using the option --verify-x509-name, this could
lead to an incor=
rect name being accepted=2E For example, the common name
"admin\0impersonat=
or" would be accepted when running with
--verify-x509-name admin name=2E

T=
o fix this, this commit makes x509_get_subject() return an error if the
sub=
ject contains an embedded null-byte=2E This way, OpenVPN won't connect
with=
 peers that present such certificates=2E

As a defense-in-depth measure, we=
 also check for null-bytes in
extract_x509_field_ssl() in case a future ver=
sion of OpenVPN has a code
path that avoids x509_get_subject()=2E

Addition=
ally, we escape RFC 2253 characters in the subject that would
make parsing =
of the resulting string ambiguous=2E For example, if the
Common Name is "na=
me, O=3DInjectedOrg", and the Organization is "RealOrg",
this will now be c=
onverted to "CN=3Dname\, O=3DInjectedOrg, O=3DRealOrg" to
make it clear whi=
ch "O" field is legitimate=2E

With Mbed TLS, the x509_get_subject() functi=
on already returned an error
when there is an embedded null-byte=2E (As of =
Mbed TLS 3=2E5=2E) Here too, we
added a check for null-bytes to the functio=
n where we extract individual
fields from the subject=2E

Also, backend_x50=
9_get_username() is changed so that it returns the
value of the *last* matc=
hing field, to be consistent with the behavior
of the OpenSSL backend=2E

D=
iscovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E
=
Contributing Researcher: Vivek Parikh=2E

CVE: 2026-84790
Reported-by: Vive=
k Parikh <vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn-private-issu=
es#163

Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
Signed-off-by:=
 Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
---
M Changes=2Erst
=
M src/openvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M=
 tests/unit_tests/openvpn/test_ssl=2Ec
4 files changed, 228 insertions(+), =
28 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/98/1898/2

diff --git a/Changes=2Erst b/Changes=2Erst
index 1f992=
b2=2E=2Efe81909 100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -1,5 +1,2=
5 @@
 Overview of changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+User-visible Changes
+------------=
--------
+Parsing Distinguished Names in certificates
+    (OpenSSL backend=
:) OpenVPN now rejects certificates that have a null-byte
+    inside any o=
f the field values of their subject=2E To avoid ambiguity in the
+    parse=
d subject, OpenVPN escapes the following characters by prefixing them with
=
+    a backslash:
+     * " " (space) at the start or end of a field,
+    =
 * "#" at the start of a field,
+     * ",", "+", """, "\", "<", ">" and ";=
" anywhere=2E
+
+    As a result, if you use the option ``--verify-x509-nam=
e <expected subject>``,
+    you need to prefix these characters with a bac=
kslash in your configuration=2E
+    The subject passed to a ``--tls-verify=
`` script is escaped in the same way and
+    you may need to adjust your s=
cript=2E
+
+    (Mbed TLS backend:) The behavior has not changed=2E Subject=
s with null-bytes were
+    already rejected (assuming OpenVPN was built wi=
th Mbed TLS 3=2E5 or later) and
+    the characters mentioned above were al=
ready escaped=2E However, the behavior of
+    Mbed TLS is slightly differe=
nt from OpenSSL in that it also escapes "=3D"=2E
 
 
 Overview of changes i=
n 2=2E7
diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_v=
erify_mbedtls=2Ec
index 2a09e86=2E=2E9f676ed 100644
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
index b8648fd=2E=2Ea6307f6 100644
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
@@ -385,8 +389,7 @@
     }
 
     X509_NAME_print_ex(subject_bio, X509_get_=
subject_name(cert), 0,
-                       XN_FLAG_SEP_CPLUS_SPC | XN_F=
LAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
-                           | ASN1_ST=
RFLGS_ESC_CTRL);
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN=
_SN | ASN1_STRFLGS_ESC_2253 | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eo=
f(subject_bio))
     {
@@ -395,6 +398,16 @@
 
     BIO_get_mem_ptr(subject_=
bio, &subject_mem);
 
+    /* Check subject for '\0' bytes=2E */
+    for (=
size_t i =3D 0; i < subject_mem->length; i++)
+    {
+        if (subject_m=
em->data[i] =3D=3D 0)
+        {
+            msg(M_WARN, "ERROR: Certifica=
te subject contains a '\\0' byte=2E");
+            goto err;
+        }
+ =
   }
+
     subject =3D gc_malloc(subject_mem->length + 1, false, gc);
 
  =
   memcpy(subject, subject_mem->data, subject_mem->length);
diff --git a/te=
sts/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec=

index 887c492=2E=2Efcebcdb 100644
--- a/tests/unit_tests/openvpn/test_ssl=
=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -873,6 +873,157 @@
    =
 free_certificate(cert);
 }
 
+/* Certificate with two CNs, "foo" and "bar"=
=2E
+ *
+ * Generated with:
+ * openssl req -x509 -newkey ec -pkeyopt ec_pa=
ramgen_curve:secp384r1 -subj "/CN=3Dfoo/CN=3Dbar" \
+ * -noenc -out two_cns=
=2Ecrt -keyout two_cns=2Ekey
+ */
+static const char *cert_with_two_cns =3D=

+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5j=
eRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n"
+    "HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQD=
DANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n"
+    "MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDD=
ANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n"
+    "ByqGSM49AgEGBSuBBAAiA2IABERAfb210N=
OACy+QVYAu3EXrcGhTJpZDfhpDnE/h\n"
+    "PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjG=
GsgN9ypZ5oQugQlB/NrVRCJIuHSGA\n"
+    "hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYD=
VR0OBBYEFPwnD+wK9R81Syk0qyTI\n"
+    "dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81S=
yk0qyTIdFT/BNoJMA8GA1UdEwEB\n"
+    "/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGx=
azGb6RRQtXzOWCPLRKId4e+E88\n"
+    "cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjB=
pT/JqF41uK57H+8i/16oZkBcm\n"
+    "OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=
=3D\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_extract_last_m=
atching_field(void **state)
+{
+    /* When there are multiple fields of th=
e same type in the certificate's subject, OpenVPN
+     * should extract th=
e value of the last matching field=2E This is essentially arbitrary and the=
re
+     * is no correct choice here, but this test exists to make sure tha=
t the behavior is consistent
+     * between different backends=2E
+     */=

+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with_two_cns);
+
+=
    char username[TLS_USERNAME_LEN + 1] =3D { 0 };
+    assert_int_equal(ba=
ckend_x509_get_username(username, sizeof(username), "CN", cert), SUCCESS);
=
+    assert_string_equal(username, "bar");
+    free_certificate(cert);
+}
=
+
+/* Certificate with a null-byte embedded in the CN=2E
+ *
+ * Generated =
with the following Python script:
+ *
+ * from cryptography import x509
+ *=
 from cryptography=2Ex509=2Eoid import NameOID, ExtensionOID, ExtendedKeyUs=
ageOID
+ * from cryptography=2Ehazmat=2Eprimitives import hashes, serializa=
tion
+ * from cryptography=2Ehazmat=2Eprimitives=2Easymmetric import ec
+ *=
 import datetime
+ *
+ * private_key =3D ec=2Egenerate_private_key(ec=2ESEC=
P384R1())
+ * now =3D datetime=2Edatetime=2Enow(datetime=2Etimezone=2Eutc)
=
+ * name =3D "with\x00null"
+ *
+ * cert =3D (x509=2ECertificateBuilder()
+=
 *             =2Esubject_name(x509=2EName([x509=2ENameAttribute(NameOID=2E=
COMMON_NAME, name)]))
+ *             =2Eissuer_name(x509=2EName([x509=2ENa=
meAttribute(NameOID=2ECOMMON_NAME, name)]))
+ *             =2Epublic_key(p=
rivate_key=2Epublic_key())
+ *             =2Eserial_number(x509=2Erandom_s=
erial_number())
+ *             =2Enot_valid_before(now)
+ *             =
=2Enot_valid_after(now + datetime=2Etimedelta(days=3D10 * 365))
+ *        =
     =2Esign(private_key, hashes=2ESHA256()))
+ *
+ * print(str(cert=2Epubl=
ic_bytes(serialization=2EEncoding=2EPEM), encoding=3D'utf-8'))
+ **/
+stati=
c const char *cert_with_null =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    =
"MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n"
+    "=
MRIwEAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n"
+    "M=
DA4WjAUMRIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n"
+    "AA=
T7PE+vJCBiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n"
+    "Ywh=
3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n"
+    "GuEw=
CgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n"
+    "k099b=
UFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n"
+    "EzZyRy=
PM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n"
+    "-----END CERTIFICATE-----\n";
+=

+void
+ssl_test_reject_null_in_cert_subject(void **state)
+{
+    openvpn_=
x509_cert_t *cert =3D get_certificate(cert_with_null);
+    struct gc_arena=
 gc =3D gc_new();
+
+    /* Trying to get the subject as a whole should fai=
l=2E */
+    assert_ptr_equal(x509_get_subject(cert, &gc), NULL);
+
+    /*=
 Trying to extract the common name should fail=2E */
+    char username[TLS=
_USERNAME_LEN + 1] =3D { 0 };
+    assert_int_equal(backend_x509_get_userna=
me(username, sizeof(username), "CN", cert), FAILURE);
+    gc_free(&gc);
+ =
   free_certificate(cert);
+}
+
+/* Cert with CN=3D"name, O=3DInjectedOrg" =
and O=3DRealOrg=2E
+ *
+ * Generated with the following Python script:
+ *
=
+ * from cryptography import x509
+ * from cryptography=2Ex509=2Eoid import=
 NameOID, ExtensionOID, ExtendedKeyUsageOID
+ * from cryptography=2Ehazmat=
=2Eprimitives import hashes, serialization
+ * from cryptography=2Ehazmat=
=2Eprimitives=2Easymmetric import ec
+ * import datetime
+ *
+ * private_ke=
y =3D ec=2Egenerate_private_key(ec=2ESECP384R1())
+ * now =3D datetime=2Eda=
tetime=2Enow(datetime=2Etimezone=2Eutc)
+ * name =3D "name, O=3DInjectedOrg=
"
+ * org =3D "RealOrg"
+ *
+ * distinguished_name =3D x509=2EName([
+ *   =
  x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name),
+ *     x509=2ENameAtt=
ribute(NameOID=2EORGANIZATION_NAME, org)
+ * ])
+ *
+ * cert =3D (x509=2ECe=
rtificateBuilder()
+ *             =2Esubject_name(distinguished_name)
+ * =
            =2Eissuer_name(distinguished_name)
+ *             =2Epublic_ke=
y(private_key=2Epublic_key())
+ *             =2Eserial_number(x509=2Erando=
m_serial_number())
+ *             =2Enot_valid_before(now)
+ *            =
 =2Enot_valid_after(now + datetime=2Etimedelta(days=3D10 * 365))
+ *       =
      =2Esign(private_key, hashes=2ESHA256()))
+ *
+ * print(str(cert=2Epub=
lic_bytes(serialization=2EEncoding=2EPEM), encoding=3D'utf-8'))
+ */
+stati=
c const char *cert_with_rfc_2253_chars =3D
+    "-----BEGIN CERTIFICATE----=
-\n"
+    "MIIBnTCCASOgAwIBAgIUR1IGc6A800U14v/ykZNR21aVubowCgYIKoZIzj0EAwIw=
\n"
+    "MDEcMBoGA1UEAwwTbmFtZSwgTz1JbmplY3RlZE9yZzEQMA4GA1UECgwHUmVhbE9y\=
n"
+    "ZzAeFw0yNjA4MjgxNTQ3NDdaFw0zNjA4MjUxNTQ3NDdaMDAxHDAaBgNVBAMME25h\n=
"
+    "bWUsIE89SW5qZWN0ZWRPcmcxEDAOBgNVBAoMB1JlYWxPcmcwdjAQBgcqhkjOPQIB\n"=

+    "BgUrgQQAIgNiAAR6zl9QPAbAnHWN//MRdowuhu0Sol6N+lqB/qk+D+2NHCd/t4H9\n"
=
+    "cJlswUh6EPsmLxgfMYgO2QwClFWEFWvtXQs8BggoidY6i9pmAPhs8+9fmIyuNVpG\n"
+=
    "3vUWZrUBRgylwaIwCgYIKoZIzj0EAwIDaAAwZQIwKzXmR8YPQZ1pratM9meVmGkH\n"
+ =
   "1rpHgV3U8oeg+jXmfVcZJTpDeDz4yBl4V3KBKT7HAjEAj2qkaTz7fiSwBKsxJQWH\n"
+  =
  "dQFPBCAYU9zZJvlNnEPtmHIwaD/qHXDeClr/HRItU3B9\n"
+    "-----END CERTIFICA=
TE-----\n";
+
+void
+ssl_test_escape_rfc_2253_chars_in_subject(void **state=
)
+{
+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with_rfc_2253_=
chars);
+    struct gc_arena gc =3D gc_new();
+
+    char *subject =3D x509=
_get_subject(cert, &gc);
+    assert_non_null(subject);
+
+    /* Mbed TLS =
escapes the '=3D' character but OpenSSL does not=2E */
+    const char *exp=
ected_subject_openssl =3D "CN=3Dname\\, O=3DInjectedOrg, O=3DRealOrg";
+   =
 const char *expected_subject_mbedtls =3D "CN=3Dname\\, O\\=3DInjectedOrg, =
O=3DRealOrg";
+
+    assert_true(strcmp(subject, expected_subject_openssl) =
=3D=3D 0 || strcmp(subject, expected_subject_mbedtls) =3D=3D 0);
+    gc_fr=
ee(&gc);
+    free_certificate(cert);
+}
+
 void
 ssl_test_extract_peer_inf=
o(void **state)
 {
@@ -960,6 +1111,9 @@
         cmocka_unit_test(test_data=
_channel_known_vectors_epoch),
         cmocka_unit_test(test_data_channel_=
known_vectors_shortpktid),
         cmocka_unit_test(crypto_test_print_cert=
_details),
+        cmocka_unit_test(ssl_test_extract_last_matching_field),=

+        cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
+        =
cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
         cmock=
a_unit_test(ssl_test_extract_peer_info)
 
     };

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
=
Gerrit-Change-Number: 1898
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-f=
illinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <stef=
fan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: syzzer <steffan@karger=2Eme>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--eOu2PzvqnzQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, plaisthos, syzzer=2E </p>
<p>MaxF <stron=
g>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p><p>=
The following approvals got outdated and were removed:
Code-Review+2 by syz=
zer, Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">Check for \0 and RFC 2253 char=
s in cert subjects<br><br>When using the OpenSSL library, we escaped embedd=
ed null-bytes in a<br>certificate&#39;s subject in x509_get_subject(), but =
in<br>extract_x509_field_ssl(), we copied any null-bytes that are contained=
 in<br>the field value=2E When using the option --verify-x509-name, this co=
uld<br>lead to an incorrect name being accepted=2E For example, the common =
name<br>&quot;admin\0impersonator&quot; would be accepted when running with=
<br>--verify-x509-name admin name=2E<br><br>To fix this, this commit makes =
x509_get_subject() return an error if the<br>subject contains an embedded n=
ull-byte=2E This way, OpenVPN won&#39;t connect<br>with peers that present =
such certificates=2E<br><br>As a defense-in-depth measure, we also check fo=
r null-bytes in<br>extract_x509_field_ssl() in case a future version of Ope=
nVPN has a code<br>path that avoids x509_get_subject()=2E<br><br>Additional=
ly, we escape RFC 2253 characters in the subject that would<br>make parsing=
 of the resulting string ambiguous=2E For example, if the<br>Common Name is=
 &quot;name, O=3DInjectedOrg&quot;, and the Organization is &quot;RealOrg&q=
uot;,<br>this will now be converted to &quot;CN=3Dname\, O=3DInjectedOrg, O=
=3DRealOrg&quot; to<br>make it clear which &quot;O&quot; field is legitimat=
e=2E<br><br>With Mbed TLS, the x509_get_subject() function already returned=
 an error<br>when there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=
=2E) Here too, we<br>added a check for null-bytes to the function where we =
extract individual<br>fields from the subject=2E<br><br>Also, backend_x509_=
get_username() is changed so that it returns the<br>value of the *last* mat=
ching field, to be consistent with the behavior<br>of the OpenSSL backend=
=2E<br><br>Discovered and reported by BreachX Zero Day Labs, using Typhon A=
I Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>CVE: 2026-84=
790<br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Git=
hub: OpenVPN/openvpn-private-issues#163<br><br>Change-Id: Ic334518048d6ca57=
a504257e210467f9c451d268<br>Signed-off-by: Max Fillinger &lt;maximilian=2Ef=
illinger@sentyron=2Ecom&gt;<br>---<br>M Changes=2Erst<br>M src/openvpn/ssl_=
verify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>M tests/unit_=
tests/openvpn/test_ssl=2Ec<br>4 files changed, 228 insertions(+), 28 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/98/1898/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/Changes=2Erst b/Chan=
ges=2Erst</span><br><span>index 1f992b2=2E=2Efe81909 100644</span><br><span=
>--- a/Changes=2Erst</span><br><span>+++ b/Changes=2Erst</span><br><span>@@=
 -1,5 +1,25 @@</span><br><span> Overview of changes in 2=2E8</span><br><spa=
n> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+User-visible =
Changes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+------------=
--------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Parsing Dis=
tinguished Names in certificates</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    (OpenSSL backend:) OpenVPN now rejects certificates that h=
ave a null-byte</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
inside any of the field values of their subject=2E To avoid ambiguity in th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    parsed subject=
, OpenVPN escapes the following characters by prefixing them with</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    a backslash:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * &quot; &quot; (space) at =
the start or end of a field,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * &quot;#&quot; at the start of a field,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * &quot;,&quot;, &quot;+&quot;, &qu=
ot;&quot;&quot;, &quot;\&quot;, &quot;&lt;&quot;, &quot;&gt;&quot; and &quo=
t;;&quot; anywhere=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    As a result, =
if you use the option ``--verify-x509-name &lt;expected subject&gt;``,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    you need to prefix t=
hese characters with a backslash in your configuration=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    The subject passed to a ``--tls-v=
erify`` script is escaped in the same way and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    you may need to adjust your script=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    (Mbed TLS backend:) The behavior has not c=
hanged=2E Subjects with null-bytes were</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    already rejected (assuming OpenVPN was built with M=
bed TLS 3=2E5 or later) and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    the characters mentioned above were already escaped=2E However,=
 the behavior of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 Mbed TLS is slightly different from OpenSSL in that it also escapes &quot;=
=3D&quot;=2E</span><br><span> </span><br><span> </span><br><span> Overview =
of changes in 2=2E7</span><br><span>diff --git a/src/openvpn/ssl_verify_mbe=
dtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>index 2a09e86=
=2E=2E9f676ed 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><sp=
an>@@ -214,6 +214,24 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+asn1_buf_is_cstr_co=
mpatible(const mbedtls_asn1_buf *asn1_buf)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!(asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1_UTF8_STRING || asn1_buf=
-&gt;tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+          || asn1_buf-&gt;tag =3D=3D MBEDTLS_ASN1=
_IA5_STRING))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; =
asn1_buf-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(asn1_buf-&gt;p[i] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> result_t</s=
pan><br><span> backend_x509_get_username(char *cn, size_t cn_len, char *x50=
9_username_field, mbedtls_x509_crt *cert)</span><br><span> {</span><br><spa=
n>@@ -259,16 +277,17 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     /* Find field_oid in the subject name=2E */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    mbedtls_x509_name *name =3D &amp;cert-=
&gt;subject;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while=
 (name !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  mbedtls_x509_name *name =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    mbedtls_x509_name *next =3D &amp;cert-&gt;subject;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (next !=3D NUL=
L)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (strlen(field_oid) =3D=3D name-&gt;oid=2Elen</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; 0 =3D=3D memcm=
p(name-&gt;oid=2Ep, field_oid, name-&gt;oid=2Elen))</span><br><span style=
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
rc/openvpn/ssl_verify_openssl=2Ec</span><br><span>index b8648fd=2E=2Ea6307f=
6 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br=
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
<br><span>     return ret;</span><br><span> }</span><br><span>@@ -385,8 +38=
9,7 @@</span><br><span>     }</span><br><span> </span><br><span>     X509_N=
AME_print_ex(subject_bio, X509_get_subject_name(cert), 0,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                       XN_FLAG_SEP_CPLU=
S_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                           | ASN1_STRFLGS_ESC_C=
TRL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
         XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_ESC_2253 | AS=
N1_STRFLGS_UTF8_CONVERT);</span><br><span> </span><br><span>     if (BIO_eo=
f(subject_bio))</span><br><span>     {</span><br><span>@@ -395,6 +398,16 @@=
</span><br><span> </span><br><span>     BIO_get_mem_ptr(subject_bio, &amp;s=
ubject_mem);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Check subject for &#39;\0&#39; bytes=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; su=
bject_mem-&gt;length; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (subject_mem-&gt;data[i] =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(M_WARN, &quot;ERROR: Certificate subject contains =
a &#39;\\0&#39; byte=2E&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     subject =3D gc_malloc(subject_mem-&gt;length + 1, false, gc);</=
span><br><span> </span><br><span>     memcpy(subject, subject_mem-&gt;data,=
 subject_mem-&gt;length);</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>i=
ndex 887c492=2E=2Efcebcdb 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>@@ -873,6 +873,157 @@</span><br><span>     free_certif=
icate(cert);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Certificate with two CNs, &quot;foo&quot; =
and &quot;bar&quot;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Generated w=
ith:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * openssl req =
-x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -subj &quot;/CN=3Dfoo=
/CN=3Dbar&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 -noenc -out two_cns=2Ecrt -keyout two_cns=2Ekey</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static const char *cert_with_two_cns =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MIIBy=
TCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3ohoJ/Vza54wQwCgYIKoZIzj0EAwIw\n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;HDEMMAoGA1UEAwwDZ=
m9vMQwwCgYDVQQDDANiYXIwHhcNMjYwODI4MTU1NjAwWhcN\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;MjYwOTI3MTU1NjAwWjAcMQwwCgYDV=
QQDDANmb28xDDAKBgNVBAMMA2JhcjB2MBAG\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &quot;ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+QV=
YAu3EXrcGhTJpZDfhpDnE/h\n&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &quot;PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9ypZ5oQugQlB/N=
rVRCJIuHSGA\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OBBYEFPwnD+wK9R81Syk0qyTI\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;dF=
T/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qyTIdFT/BNoJMA8GA1UdEwEB\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;/wQFMAMBAf8wCg=
YIKoZIzj0EAwIDZwAwZAIwGxazGb6RRQtXzOWCPLRKId4e+E88\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;cwoCK3UwzEr8+Ddf54w5cEZC54=
f5J6AKFUJjAjBpT/JqF41uK57H+8i/16oZkBcm\n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &quot;OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pS=
k=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;-----END CERTIFICATE-----\n&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_test_extract=
_last_matching_field(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* When there are multiple fields of the same type in the certificate&#39;=
s subject, OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * should extract the value of the last matching field=2E This is essent=
ially arbitrary and there</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * is no correct choice here, but this test exists to make sure t=
hat the behavior is consistent</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * between different backends=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with=
_two_cns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char username[TLS_USERNA=
ME_LEN + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(backend_x509_get_username(username, sizeof(username=
), &quot;CN&quot;, cert), SUCCESS);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_string_equal(username, &quot;bar&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Certificate with a null-byte embedded in the CN=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Generated with the following Python =
script:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * from cryptography import x=
509</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from cryptogr=
aphy=2Ex509=2Eoid import NameOID, ExtensionOID, ExtendedKeyUsageOID</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * from cryptography=2Ehazm=
at=2Eprimitives import hashes, serialization</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * from cryptography=2Ehazmat=2Eprimitives=2Easymm=
etric import ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * i=
mport datetime</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * private_key =3D ec=
=2Egenerate_private_key(ec=2ESECP384R1())</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * now =3D datetime=2Edatetime=2Enow(datetime=2Etimez=
one=2Eutc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * name =
=3D &quot;with\x00null&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cert =
=3D (x509=2ECertificateBuilder()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             =2Esubject_name(x509=2EName([x509=2ENameAttribu=
te(NameOID=2ECOMMON_NAME, name)]))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             =2Eissuer_name(x509=2EName([x509=2ENameAttrib=
ute(NameOID=2ECOMMON_NAME, name)]))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             =2Epublic_key(private_key=2Epublic_key())</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =2Eseri=
al_number(x509=2Erandom_serial_number())</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             =2Enot_valid_before(now)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             =2Enot_valid_after(=
now + datetime=2Etimedelta(days=3D10 * 365))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             =2Esign(private_key, hashes=2ESHA25=
6()))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * print(str(cert=2Epublic_byte=
s(serialization=2EEncoding=2EPEM), encoding=3D&#39;utf-8&#39;))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ **/</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static const char *cert_with_null =3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFI=
CATE-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;MIIBZTCB66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MRIw=
EAYDVQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDA4WjAUMRIwEAYD=
VQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;AAT7PE+vJCBiB4CVHBcvJVF9n5n/=
dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;Ywh3pa8zhto1+aczbJKTvLgRwXn6N5vNpME1c5iW=
MzY0WHe1dJyVtoRBvkNvy5+k\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;GuEwCgYIKoZIzj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0Cq=
iaSNByGiP75i\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;k099bUFvHp/3LSp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;E=
zZyRyPM3PGR83ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;-----END CERTIFICATE-----\n&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ssl_test_reject_null_in_cert_subject(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_cer=
tificate(cert_with_null);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Trying to get the subject as a whole should fail=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(x509_get=
_subject(cert, &amp;gc), NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Trying to extract the common name should fail=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char username[TLS_USERNAME_LEN + 1] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(backend_x509_get_username(username, sizeof(username), &quot;CN&=
quot;, cert), FAILURE);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    free_certificate(cert);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Cert with CN=3D&quot=
;name, O=3DInjectedOrg&quot; and O=3DRealOrg=2E</span><br><span style=3D"co=
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
 style=3D"color: hsl(120, 100%, 40%);">+ * name =3D &quot;name, O=3DInjecte=
dOrg&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * org =
=3D &quot;RealOrg&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * distinguis=
hed_name =3D x509=2EName([</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *     x509=2ENameAttribute(NameOID=2ECOMMON_NAME, name),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *     x509=2ENameAttribute(Na=
meOID=2EORGANIZATION_NAME, org)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * ])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cert =3D (x509=
=2ECertificateBuilder()</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             =2Esubject_name(distinguished_name)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             =2Eissuer_name(distinguis=
hed_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     =2Epublic_key(private_key=2Epublic_key())</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             =2Eserial_number(x509=2Erandom_se=
rial_number())</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          =2Enot_valid_before(now)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             =2Enot_valid_after(now + datetime=2Etimedelta=
(days=3D10 * 365))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             =2Esign(private_key, hashes=2ESHA256()))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * print(str(cert=2Epublic_bytes(serialization=2EEncoding=
=2EPEM), encoding=3D&#39;utf-8&#39;))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static const char *cert_with_rfc_2253_chars =3D</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN CERTIFICATE-----\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MIIBnTCCA=
SOgAwIBAgIUR1IGc6A800U14v/ykZNR21aVubowCgYIKoZIzj0EAwIw\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDEcMBoGA1UEAwwTbmFtZ=
SwgTz1JbmplY3RlZE9yZzEQMA4GA1UECgwHUmVhbE9y\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;ZzAeFw0yNjA4MjgxNTQ3NDdaFw0zNjA=
4MjUxNTQ3NDdaMDAxHDAaBgNVBAMME25h\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;bWUsIE89SW5qZWN0ZWRPcmcxEDAOBgNVBAoMB1JlYWx=
PcmcwdjAQBgcqhkjOPQIB\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;BgUrgQQAIgNiAAR6zl9QPAbAnHWN//MRdowuhu0Sol6N+lqB/qk+D+2=
NHCd/t4H9\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;cJlswUh6EPsmLxgfMYgO2QwClFWEFWvtXQs8BggoidY6i9pmAPhs8+9fmIyuNVpG\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;3vUW=
ZrUBRgylwaIwCgYIKoZIzj0EAwIDaAAwZQIwKzXmR8YPQZ1pratM9meVmGkH\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;1rpHgV3U8oeg+jXm=
fVcZJTpDeDz4yBl4V3KBKT7HAjEAj2qkaTz7fiSwBKsxJQWH\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;dQFPBCAYU9zZJvlNnEPtmHIwaD/q=
HXDeClr/HRItU3B9\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;-----END CERTIFICATE-----\n&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_=
test_escape_rfc_2253_chars_in_subject(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    openvpn_x509_cert_t *cert =3D get_certificate(cert_with=
_rfc_2253_chars);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char *subject =3D x509_get_subject(cert, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_non_null(subject);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Mbed TLS escapes the &#39;=3D&#39; character b=
ut OpenSSL does not=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *expected_subject_openssl =3D &quot;CN=3Dname\\, O=3DI=
njectedOrg, O=3DRealOrg&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *expected_subject_mbedtls =3D &quot;CN=3Dname\\, =
O\\=3DInjectedOrg, O=3DRealOrg&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(strcmp(subject, expected_subject_openssl) =3D=3D 0 || strcmp=
(subject, expected_subject_mbedtls) =3D=3D 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free_certificate(cert);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> void</span><br><span> ssl_test_extract=
_peer_info(void **state)</span><br><span> {</span><br><span>@@ -960,6 +1111=
,9 @@</span><br><span>         cmocka_unit_test(test_data_channel_known_vec=
tors_epoch),</span><br><span>         cmocka_unit_test(test_data_channel_kn=
own_vectors_shortpktid),</span><br><span>         cmocka_unit_test(crypto_t=
est_print_cert_details),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(ssl_test_extract_last_matching_field),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(s=
sl_test_reject_null_in_cert_subject),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(ssl_test_escape_rfc_2253_chars_i=
n_subject),</span><br><span>         cmocka_unit_test(ssl_test_extract_peer=
_info)</span><br><span> </span><br><span>     };</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1898?usp=3Demail">change 1898</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1898?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1898 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@karger=
=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

=
</body></html>
--eOu2PzvqnzQ=--


--===============5721277011923044112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5721277011923044112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5721277011923044112==--

