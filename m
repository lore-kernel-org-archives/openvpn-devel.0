Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033ADC624D3
	for <openvpn-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=fExqJ4hd5QGglsD/pRwVDPgUPINTbppMicieSuR15Ys=; b=OA38ALZQGx5Vzd
	kh7ez8ZUxNoEzHP7gknZt714uqNBGz4rgj3F6txsHculzMb/zYQsbRmZf+G1ssZ9DkilrpsknmHNW
	4AGnQGnwq0bBrL5i7BJZtYWoi9n63CLj1C/gDe3jNRtTx7K3fjPbAcFR2UVgezBQuAQpgvGaKW+ej
	b1g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2Rfv-00011j-AI;
	Fri, 04 Sep 2026 11:01:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2Rft-00011Z-Na
 for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 11:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u8Eda7xhHM4z1m+XSc6r8db/btGIw7lUNgDyFVkWJZY=; b=dM23V3Zl8N9dEZrtAeFhrVNafz
 PfKAOtxJLodlgDVPMXUXeDj2mf+wC1tJT01KCkPUIvd1hPxu6KOwXo8l/hzjfBXar2SQ8GJ6YdM3E
 Vmr6yINPMwH1BVmA0zEDlXzhvbZTUwBdBdKQ2n/Pw/1MyeXY51aaqPHH6ycOVT5gGUOo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u8Eda7xhHM4z1m+XSc6r8db/btGIw7lUNgDyFVkWJZY=; b=G
 fN6HXXva8nLfHZ7r32sifL7bAwwcg26e44swRV/QWoL3+Wm2rHgzSmc6corQRb/wQDJ4e8HbrbI2p
 aYrcGXMwf0mHsmBx+R86X2cOchoMq+RfbiLybYDftwJ9uxaElW6z6Tjx+8HDlH+huQppL2W8ilZST
 kHhx/lPn6T3F8CSY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2Rfr-0001pF-8i for openvpn-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 11:01:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so9754045e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 04 Sep 2026 04:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788519689; x=1789124489; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u8Eda7xhHM4z1m+XSc6r8db/btGIw7lUNgDyFVkWJZY=;
 b=LRJfRRzrdz3jk+oQ29OqDkZcOC4wHl1dWWbaB7NS7fUiYKQyuA20EZIHLQYUguJYSV
 yqWRdUDjuu75DcTKsukBfSsxNJO5qwAtaBGY8oN1R+zwMzXWI6gH9w5HOX/zUjbtNoep
 7cmx9RWZXRm7uVHQFsoRRmQDRGiV58eN4rcRvKZDGx0xZFzCO8UIFSMnDoEGd6ew8lKp
 UnAzYG72l9wbbP3YcN2um8R4I8K6g2/zdxkFeQM4beEPd/Q7TvYukLhnUnTztGzfRfzR
 2AsuMifZA7JgjwfNQthCGm0cOhEwhv/yKab7G1g4b2wCUnKwGmbRdz3g0mXQ1+FLbE1K
 gFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788519689; x=1789124489;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u8Eda7xhHM4z1m+XSc6r8db/btGIw7lUNgDyFVkWJZY=;
 b=FnJRz3j0ODoGASbDK4PqxJw7rLiEESpk5/Zp0zsfFTx+jks7yX/TCXCFgDgeGRqWnF
 fzI5uiSl/aoyDBinWzUDed9V7+16VEH4xGMLZkZ1h/w6LxNtv+DuX3pyVKyCtQs4KNE4
 cCUsZs8Fe+vuDiOHkRERT/ZK8tV1llnaMfPLixThOgOf21pxnzxRZxz8Imcz3sesvwlv
 0rScTTbPzlP888ExQ0NuMuBrb0uGAVfDhJqMXl451+Xe5T5XPWtlNFUNPihk9Utc9VF6
 bGI2DBc6iRXz+7dr4iHyQ/KY6N0AIHgZ33oEeQcK/X5boaedDo9OmxKbVaKJmc2/tkyD
 ddAg==
X-Gm-Message-State: AFuF++lRCzY0ezHiffSBN7tmSoJa34r9DAcjG4SVpHzuylTTxz3/ZKHc
 /IhTRFNljpnMYGIvYU+YghrBy980a5nfkfqGaYxCnFMUBbahzHr4NwOjWQkPBFAwFSJWNwKzoQc
 nnRkTkI+IXxw5NlnYRUv1GyMD81idEku0bfwUt44gcTG3UWcjaUHfZnH/N/P7HL/xcRl43xt3Bw
 TP3ldOhg==
X-Gm-Gg: AYBFou3SqeK5icUCdeof9fZwWYgtbMBXICduqby8mte9IxCgWvn8UeMzKLB+PyR6+qU
 la3DBgP+/YO+9azCgLGOOPivfgTMy79K68rrZ335XN+5JhJ0p0fiQIl1ZqfTxpFHhHE5bJc5cgQ
 JLss8/we88ctJXG/B55/6dc/DfrecGROclGUyCjTnkPPQOOh9UyeGXZbOa29FTyrIP247Lj0Z/s
 2r2IhR/YwqkyK1MVCfkZ8iVnw/irhx1kylU5msvM9sEekoTCeufpqe6nMsUIFgQwxR59Or2tt3U
 EC3ePi8QfEauhdKHVz0aFwQrraesN9h4PbAFY81DSAhnzLm2rokrBWM41LHQfD4CwAhWMz4I29T
 n75YOc49gNkpt6WjYM2s/N1wOr7tOd7Z8os6UL9P5Tx6sqaYg/oP4/q12sA0cD+0EPf+2n+qp7I
 VQmEdgiqnvnDm417hybGbj/AigkxHl0itHJYQkdfYiP+fPQ3bEvIjmqyTMqpxMLsudF5xbDMT4Y
 Npf/IfeqZgtzm4SY2CCf1hqXxTGHyd5KDj3BdFAgl1p4nx+M820Wb1l76jGvB4Ph7h5GBzHOi3Q
 VMrcwiZqGu3YTWrEVSNRFMLehGuEGFs9WRZJKoKiboAXwWkPa3Y=
X-Received: by 2002:a05:600d:4447:20b0:49c:fc6e:8cbc with SMTP id
 5b1f17b1804b1-49cfc6e8e40mr17846125e9.32.1788519688174; 
 Fri, 04 Sep 2026 04:01:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7740d44sm132692775e9.15.2026.09.04.04.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 04:01:27 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 4 Sep 2026 11:01:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: eda13e5920b005cb50abb11bf776bb8e7cc32fe7
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47beba2f71f2e7f9d5006c0728cb297fa86ef1e8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2Rfr-0001pF-8i
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for null-bytes
 in certificate subjects
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
Content-Type: multipart/mixed; boundary="===============3191435867089965876=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3191435867089965876==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8ovISFfcv2k="; charset=UTF-8

--8ovISFfcv2k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1898?usp=3Demail

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

Additional=
ly, we also escape characters in the subject that would make
parsing of the=
 resulting string ambiguous=2E For example, if the Common
Name is "name, O=
=3DInjectedOrg", and the Organization is "RealOrg",
this will now be conver=
ted to "CN=3Dname\, O=3DInjectedOrg, O=3DRealOrg" to
make it clear which "O=
" field is legitimate=2E

With Mbed TLS, the x509_get_subject() function al=
ready returned an error
when there is an embedded null-byte=2E (As of Mbed =
TLS 3=2E5=2E) Here too, we
added a check for null-bytes to the function whe=
re we extract individual
fields from the subject=2E

Also, backend_x509_get=
_username() is changed so that it returns the
value of the *last* matching =
field, to be consistent with the behavior
of the OpenSSL backend=2E

We dec=
ided to publish this commit without embargo even though it fixes a
CVE, bec=
ause exploiting it requires a malicious or very negligent CA=2E

Discovered=
 and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E
Contribut=
ing Researcher: Vivek Parikh=2E

CVE: 2026-84790
Reported-by: Vivek Parikh =
<vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/openvpn-private-issues#163

C=
hange-Id: Ic334518048d6ca57a504257e210467f9c451d268
Signed-off-by: Max Fill=
inger <maximilian=2Efillinger@sentyron=2Ecom>
---
M Changes=2Erst
M src/ope=
nvpn/ssl_verify_mbedtls=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
M tests/un=
it_tests/openvpn/test_ssl=2Ec
4 files changed, 228 insertions(+), 28 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/98/1898/1

diff --git a/Changes=2Erst b/Changes=2Erst
index 1f992b2=2E=2E=
fe81909 100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -1,5 +1,25 @@
 Ov=
erview of changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+User-visible Changes
+------------------=
--
+Parsing Distinguished Names in certificates
+    (OpenSSL backend:) Ope=
nVPN now rejects certificates that have a null-byte
+    inside any of the =
field values of their subject=2E To avoid ambiguity in the
+    parsed subj=
ect, OpenVPN escapes the following characters by prefixing them with
+    a=
 backslash:
+     * " " (space) at the start or end of a field,
+     * "#"=
 at the start of a field,
+     * ",", "+", """, "\", "<", ">" and ";" anyw=
here=2E
+
+    As a result, if you use the option ``--verify-x509-name <exp=
ected subject>``,
+    you need to prefix these characters with a backslash=
 in your configuration=2E
+    The subject passed to a ``--tls-verify`` scr=
ipt is escaped in the same way and
+    you may need to adjust your script=
=2E
+
+    (Mbed TLS backend:) The behavior has not changed=2E Subjects wit=
h null-bytes were
+    already rejected (assuming OpenVPN was built with Mb=
ed TLS 3=2E5 or later) and
+    the characters mentioned above were already=
 escaped=2E However, the behavior of
+    Mbed TLS is slightly different fr=
om OpenSSL in that it also escapes "=3D"=2E
 
 
 Overview of changes in 2=
=2E7
diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_veri=
fy_mbedtls=2Ec
index 2a09e86=2E=2E9f676ed 100644
--- a/src/openvpn/ssl_veri=
fy_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -214,6 +214,24 @=
@
     }
 }
 
+static bool
+asn1_buf_is_cstr_compatible(const mbedtls_asn1_=
buf *asn1_buf)
+{
+    if (!(asn1_buf->tag =3D=3D MBEDTLS_ASN1_UTF8_STRING =
|| asn1_buf->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING
+          || asn1_bu=
f->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    {
+        return false;
+    =
}
+    for (size_t i =3D 0; i < asn1_buf->len; i++)
+    {
+        if (asn=
1_buf->p[i] =3D=3D '\0')
+        {
+            return false;
+        }
+=
    }
+    return true;
+}
+
 result_t
 backend_x509_get_username(char *cn,=
 size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
 {
@@ -2=
59,16 +277,17 @@
     }
 
     /* Find field_oid in the subject name=2E */
=
-    mbedtls_x509_name *name =3D &cert->subject;
-    while (name !=3D NULL=
)
+    mbedtls_x509_name *name =3D NULL;
+    mbedtls_x509_name *next =3D &=
cert->subject;
+    while (next !=3D NULL)
     {
-        if (strlen(field=
_oid) =3D=3D name->oid=2Elen
-            && 0 =3D=3D memcmp(name->oid=2Ep,=
 field_oid, name->oid=2Elen))
+        if (strlen(field_oid) =3D=3D next->o=
id=2Elen
+            && 0 =3D=3D memcmp(next->oid=2Ep, field_oid, next->oi=
d=2Elen))
         {
-            break;
+            name =3D next;
      =
   }
 
-        name =3D name->next;
+        next =3D next->next;
     }
 =

     /* Not found, return an error if this is the peer's certificate */
@@=
 -277,6 +296,11 @@
         goto fail;
     }
 
+    if (!asn1_buf_is_cstr_=
compatible(&name->val))
+    {
+        goto fail;
+    }
+
     /* Check t=
hat we have room in the buffer, including the terminating '/0' byte=2E */
 =
    if (cn_len <=3D name->val=2Elen)
     {
@@ -586,22 +610,11 @@
 static c=
har *
 asn1_buf_to_c_string(const mbedtls_asn1_buf *orig, struct gc_arena *=
gc)
 {
-    size_t i;
     char *val;
 
-    if (!(orig->tag =3D=3D MBEDTLS=
_ASN1_UTF8_STRING || orig->tag =3D=3D MBEDTLS_ASN1_PRINTABLE_STRING
-      =
    || orig->tag =3D=3D MBEDTLS_ASN1_IA5_STRING))
+    if (!asn1_buf_is_cst=
r_compatible(orig))
     {
-        /* Only support C-string compatible typ=
es */
-        return string_alloc("ERROR: unsupported ASN=2E1 string type"=
, gc);
-    }
-
-    for (i =3D 0; i < orig->len; ++i)
-    {
-        if (=
orig->p[i] =3D=3D '\0')
-        {
-            return string_alloc("ERROR:=
 embedded null value", gc);
-        }
+        return string_alloc("ERROR:=
 Unsupported string type or embedded null bytes=2E", gc);
     }
     val =
=3D gc_malloc(orig->len + 1, false, gc);
     memcpy(val, orig->p, orig->le=
n);
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verif=
y_openssl=2Ec
index b8648fd=2E=2Ea6307f6 100644
--- a/src/openvpn/ssl_verif=
y_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -196,12 +196,13 @=
@
     int lastpos =3D -1;
     int tmp =3D -1;
     unsigned char *buf =3D=
 NULL;
+    result_t ret =3D FAILURE;
 
     ASN1_OBJECT *field_name_obj =
=3D OBJ_txt2obj(field_name, 0);
     if (field_name_obj =3D=3D NULL)
     {=

         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name)=
;
-        return FAILURE;
+        goto exit;
     }
 
     ASSERT(size > =
0);
@@ -222,28 +223,31 @@
     /* Nothing found */
     if (lastpos =3D=3D =
-1)
     {
-        return FAILURE;
+        goto exit;
     }
 
     const=
 X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entry(x509, lastpos);
     if (!=
x509ne)
     {
-        return FAILURE;
+        goto exit;
     }
 
     c=
onst ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1=
)
     {
-        return FAILURE;
+        goto exit;
     }
-    if (ASN1_=
STRING_to_UTF8(&buf, asn1) < 0)
+    int length =3D ASN1_STRING_to_UTF8(&bu=
f, asn1);
+    if (length < 0 || (size_t)length !=3D strlen((char *)buf))
 =
    {
-        return FAILURE;
+        goto exit;
     }
 
     strncpynt(=
out, (char *)buf, size);
 
-    const result_t ret =3D (strlen((char *)buf)=
 < size) ? SUCCESS : FAILURE;
+    ret =3D (strlen((char *)buf) < size) ? S=
UCCESS : FAILURE;
+
+exit:
     OPENSSL_free(buf);
     return ret;
 }
@@ -=
385,8 +389,7 @@
     }
 
     X509_NAME_print_ex(subject_bio, X509_get_subj=
ect_name(cert), 0,
-                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_=
FN_SN | ASN1_STRFLGS_UTF8_CONVERT
-                           | ASN1_STRFLG=
S_ESC_CTRL);
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN =
| ASN1_STRFLGS_ESC_2253 | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(su=
bject_bio))
     {
@@ -395,6 +398,16 @@
 
     BIO_get_mem_ptr(subject_bio,=
 &subject_mem);
 
+    /* Check subject for '\0' bytes=2E */
+    for (size=
_t i =3D 0; i < subject_mem->length; i++)
+    {
+        if (subject_mem->=
data[i] =3D=3D 0)
+        {
+            msg(M_WARN, "ERROR: Certificate s=
ubject contains a '\\0' byte=2E");
+            goto err;
+        }
+    }=

+
     subject =3D gc_malloc(subject_mem->length + 1, false, gc);
 
     m=
emcpy(subject, subject_mem->data, subject_mem->length);
diff --git a/tests/=
unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
ind=
ex 887c492=2E=2Eb07ff2b 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
=
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -873,6 +873,157 @@
     free=
_certificate(cert);
 }
 
+/* Certificate with two CNs, "foo" and "bar"=2E
+=
 *
+ * Generated with:
+ * openssl req -x509 -newkey ec -pkeyopt ec_paramge=
n_curve:secp384r1 -subj "/CN=3Dfoo/CN=3Dbar" \
+ * -noenc -out two_cns=2Ecr=
t -keyout two_cns=2Ekey
+ */
+static const char *cert_with_two_cns =3D
+   =
 "-----BEGIN CERTIFICATE-----\n"
+    "MIIByTCCAVCgAwIBAgIUZuvd8Wfnq5jeRc3o=
hoJ/Vza54wQwCgYIKoZIzj0EAwIw\n"
+    "HDEMMAoGA1UEAwwDZm9vMQwwCgYDVQQDDANiY=
XIwHhcNMjYwODI4MTU1NjAwWhcN\n"
+    "MjYwOTI3MTU1NjAwWjAcMQwwCgYDVQQDDANmb2=
8xDDAKBgNVBAMMA2JhcjB2MBAG\n"
+    "ByqGSM49AgEGBSuBBAAiA2IABERAfb210NOACy+=
QVYAu3EXrcGhTJpZDfhpDnE/h\n"
+    "PvPMWGWzqecTYdseArxZc0T/5Xma36IKCjGGsgN9=
ypZ5oQugQlB/NrVRCJIuHSGA\n"
+    "hGBWFvnUsqdNo765lGwVdBwhY6NTMFEwHQYDVR0OB=
BYEFPwnD+wK9R81Syk0qyTI\n"
+    "dFT/BNoJMB8GA1UdIwQYMBaAFPwnD+wK9R81Syk0qy=
TIdFT/BNoJMA8GA1UdEwEB\n"
+    "/wQFMAMBAf8wCgYIKoZIzj0EAwIDZwAwZAIwGxazGb6=
RRQtXzOWCPLRKId4e+E88\n"
+    "cwoCK3UwzEr8+Ddf54w5cEZC54f5J6AKFUJjAjBpT/Jq=
F41uK57H+8i/16oZkBcm\n"
+    "OyQnlH8W/UzZo3/weTEBTcNW0iuCpIrS6im8pSk=3D\n"=

+    "-----END CERTIFICATE-----\n";
+
+void
+ssl_test_extract_last_matchin=
g_field(void **state)
+{
+    /* When there are multiple fields of the same=
 type in the certificate's subject, OpenVPN
+     * should extract the valu=
e of the last matching field=2E This is essentially arbitrary and there
+  =
   * is no correct choice here, but this test exists to make sure that the =
behavior is consistent
+     * between different backends=2E
+     */
+    =
openvpn_x509_cert_t *cert =3D get_certificate(cert_with_two_cns);
+
+    ch=
ar username[TLS_USERNAME_LEN + 1] =3D { 0 };
+    assert_int_equal(backend_=
x509_get_username(username, sizeof(username), "CN", cert), SUCCESS);
+    a=
ssert_string_equal(username, "bar");
+    free_certificate(cert);
+}
+
+/* =
Certificate with a null-byte embedded in the CN=2E
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
me =3D "with\x00null"
+ *
+ * cert =3D (x509=2ECertificateBuilder()
+ *    =
         =2Esubject_name(x509=2EName([x509=2ENameAttribute(NameOID=2ECOMMON=
_NAME, name)]))
+ *             =2Eissuer_name(x509=2EName([x509=2ENameAttr=
ibute(NameOID=2ECOMMON_NAME, name)]))
+ *             =2Epublic_key(private=
_key=2Epublic_key())
+ *             =2Eserial_number(x509=2Erandom_serial_=
number())
+ *             =2Enot_valid_before(now)
+ *             =2Enot_v=
alid_after(now + datetime=2Etimedelta(days=3D10 * 365))
+ *             =2E=
sign(private_key, hashes=2ESHA256()))
+ *
+ * print(str(cert=2Epublic_bytes=
(serialization=2EEncoding=2EPEM), encoding=3D'utf-8'))
+ **/
+static const =
char *cert_with_null =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    "MIIBZTC=
B66ADAgECAhRLWdNRl+C20KKBG4QC9HFPWlOtBzAKBggqhkjOPQQDAjAU\n"
+    "MRIwEAYD=
VQQDDAl3aXRoAG51bGwwHhcNMjYwODI4MTQzMDA4WhcNMzYwODI1MTQz\n"
+    "MDA4WjAUM=
RIwEAYDVQQDDAl3aXRoAG51bGwwdjAQBgcqhkjOPQIBBgUrgQQAIgNi\n"
+    "AAT7PE+vJC=
BiB4CVHBcvJVF9n5n/dGQIn4C8HeYE8M2iXYCIRW5wg6/mlPaeiJY/\n"
+    "Ywh3pa8zhto=
1+aczbJKTvLgRwXn6N5vNpME1c5iWMzY0WHe1dJyVtoRBvkNvy5+k\n"
+    "GuEwCgYIKoZI=
zj0EAwIDaQAwZgIxAP2ekdQ8muG8Nv2o3PsBp0CqiaSNByGiP75i\n"
+    "k099bUFvHp/3L=
Sp8Wf4JK2iWzc5h6gIxAINBGg2xjlmMgpXxROKA9qQqaM3d92Mp\n"
+    "EzZyRyPM3PGR83=
ZPbIaYDq8lCVxVlbYr/Q=3D=3D\n"
+    "-----END CERTIFICATE-----\n";
+
+void
+=
ssl_test_reject_null_in_cert_subject(void **state)
+{
+    openvpn_x509_cer=
t_t *cert =3D get_certificate(cert_with_null);
+    struct gc_arena gc =3D =
gc_new();
+
+    /* Trying to get the subject as a whole should fail=2E */
=
+    assert_ptr_equal(x509_get_subject(cert, &gc), NULL);
+
+    /* Trying =
to extract the common name should fail=2E */
+    char username[TLS_USERNAM=
E_LEN + 1] =3D { 0 };
+    assert_int_equal(backend_x509_get_username(usern=
ame, sizeof(username), "CN", cert), FAILURE);
+    gc_free(&gc);
+    free_=
certificate(cert);
+}
+
+/* Cert with CN=3D"name, O=3DInjectedOrg" and O=3D=
RealOrg=2E
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
+ * name =3D "name, O=3DInjectedOrg"
+ * org =
=3D "RealOrg"
+ *
+ * distinguished_name =3D x509=2EName([
+ *     x509=2EN=
ameAttribute(NameOID=2ECOMMON_NAME, name),
+ *     x509=2ENameAttribute(Nam=
eOID=2EORGANIZATION_NAME, org)
+ * ])
+ *
+ * cert =3D (x509=2ECertificateB=
uilder()
+ *             =2Esubject_name(distinguished_name)
+ *           =
  =2Eissuer_name(distinguished_name)
+ *             =2Epublic_key(private_=
key=2Epublic_key())
+ *             =2Eserial_number(x509=2Erandom_serial_n=
umber())
+ *             =2Enot_valid_before(now)
+ *             =2Enot_va=
lid_after(now + datetime=2Etimedelta(days=3D10 * 365))
+ *             =2Es=
ign(private_key, hashes=2ESHA256()))
+ *
+ * print(str(cert=2Epublic_bytes(=
serialization=2EEncoding=2EPEM), encoding=3D'utf-8'))
+ */
+static const ch=
ar *cert_with_rfc_2253_chars =3D
+    "-----BEGIN CERTIFICATE-----\n"
+    =
"MIIBnTCCASOgAwIBAgIUR1IGc6A800U14v/ykZNR21aVubowCgYIKoZIzj0EAwIw\n"
+    "=
MDEcMBoGA1UEAwwTbmFtZSwgTz1JbmplY3RlZE9yZzEQMA4GA1UECgwHUmVhbE9y\n"
+    "Z=
zAeFw0yNjA4MjgxNTQ3NDdaFw0zNjA4MjUxNTQ3NDdaMDAxHDAaBgNVBAMME25h\n"
+    "bW=
UsIE89SW5qZWN0ZWRPcmcxEDAOBgNVBAoMB1JlYWxPcmcwdjAQBgcqhkjOPQIB\n"
+    "BgU=
rgQQAIgNiAAR6zl9QPAbAnHWN//MRdowuhu0Sol6N+lqB/qk+D+2NHCd/t4H9\n"
+    "cJls=
wUh6EPsmLxgfMYgO2QwClFWEFWvtXQs8BggoidY6i9pmAPhs8+9fmIyuNVpG\n"
+    "3vUWZ=
rUBRgylwaIwCgYIKoZIzj0EAwIDaAAwZQIwKzXmR8YPQZ1pratM9meVmGkH\n"
+    "1rpHgV=
3U8oeg+jXmfVcZJTpDeDz4yBl4V3KBKT7HAjEAj2qkaTz7fiSwBKsxJQWH\n"
+    "dQFPBCA=
YU9zZJvlNnEPtmHIwaD/qHXDeClr/HRItU3B9\n"
+    "-----END CERTIFICATE-----\n"=
;
+
+void
+ssl_test_escape_rfc_2253_chars_in_subject(void **state)
+{
+    =
openvpn_x509_cert_t *cert =3D get_certificate(cert_with_rfc_2253_chars);
+ =
   struct gc_arena gc =3D gc_new();
+
+    char *subject =3D x509_get_subje=
ct(cert, &gc);
+    assert_non_null(subject);
+
+    /* Mbed TLS escapes th=
e '=3D' character but OpenSSL does not=2E */
+    const char *expected_subj=
ect_openssl =3D "CN=3Dname\\, O=3DInjectedOrg, O=3DRealOrg";
+    const cha=
r *expected_subject_mbedtls =3D "CN=3Dname\\, O\\=3DInjectedOrg, O=3DRealOr=
g";
+
+    assert(strcmp(subject, expected_subject_openssl) =3D=3D 0 || str=
cmp(subject, expected_subject_mbedtls) =3D=3D 0);
+    gc_free(&gc);
+    f=
ree_certificate(cert);
+}
+
 void
 ssl_test_extract_peer_info(void **state)=

 {
@@ -960,6 +1111,9 @@
         cmocka_unit_test(test_data_channel_known_=
vectors_epoch),
         cmocka_unit_test(test_data_channel_known_vectors_s=
hortpktid),
         cmocka_unit_test(crypto_test_print_cert_details),
+   =
     cmocka_unit_test(ssl_test_extract_last_matching_field),
+        cmock=
a_unit_test(ssl_test_reject_null_in_cert_subject),
+        cmocka_unit_tes=
t(ssl_test_escape_rfc_2253_chars_in_subject),
         cmocka_unit_test(ssl=
_test_extract_peer_info)
 
     };

-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1898?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
Gerrit-Change-Num=
ber: 1898
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>

--8ovISFfcv2k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>MaxF would like plaisthos to <st=
rong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p><pre class=3D"blo=
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
()=2E<br><br>Additionally, we also escape characters in the subject that wo=
uld make<br>parsing of the resulting string ambiguous=2E For example, if th=
e Common<br>Name is &quot;name, O=3DInjectedOrg&quot;, and the Organization=
 is &quot;RealOrg&quot;,<br>this will now be converted to &quot;CN=3Dname\,=
 O=3DInjectedOrg, O=3DRealOrg&quot; to<br>make it clear which &quot;O&quot;=
 field is legitimate=2E<br><br>With Mbed TLS, the x509_get_subject() functi=
on already returned an error<br>when there is an embedded null-byte=2E (As =
of Mbed TLS 3=2E5=2E) Here too, we<br>added a check for null-bytes to the f=
unction where we extract individual<br>fields from the subject=2E<br><br>Al=
so, backend_x509_get_username() is changed so that it returns the<br>value =
of the *last* matching field, to be consistent with the behavior<br>of the =
OpenSSL backend=2E<br><br>We decided to publish this commit without embargo=
 even though it fixes a<br>CVE, because exploiting it requires a malicious =
or very negligent CA=2E<br><br>Discovered and reported by BreachX Zero Day =
Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E=
<br><br>CVE: 2026-84790<br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@bre=
achx=2Eai&gt;<br>Github: OpenVPN/openvpn-private-issues#163<br><br>Change-I=
d: Ic334518048d6ca57a504257e210467f9c451d268<br>Signed-off-by: Max Fillinge=
r &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M Changes=2Erst<b=
r>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M src/openvpn/ssl_verify_openssl=
=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>4 files changed, 228 ins=
ertions(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/1898/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/Changes=2Erst b/Changes=2Erst</span><br><span>index 1f992b2=2E=2Efe81909 1=
00644</span><br><span>--- a/Changes=2Erst</span><br><span>+++ b/Changes=2Er=
st</span><br><span>@@ -1,5 +1,25 @@</span><br><span> Overview of changes in=
 2=2E8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
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
/span><br><span>index 887c492=2E=2Eb07ff2b 100644</span><br><span>--- a/tes=
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
%, 40%);">+    assert(strcmp(subject, expected_subject_openssl) =3D=3D 0 ||=
 strcmp(subject, expected_subject_mbedtls) =3D=3D 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free_certificate(cert);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> ssl_test_=
extract_peer_info(void **state)</span><br><span> {</span><br><span>@@ -960,=
6 +1111,9 @@</span><br><span>         cmocka_unit_test(test_data_channel_kn=
own_vectors_epoch),</span><br><span>         cmocka_unit_test(test_data_cha=
nnel_known_vectors_shortpktid),</span><br><span>         cmocka_unit_test(c=
rypto_test_print_cert_details),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cmocka_unit_test(ssl_test_extract_last_matching_field),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit=
_test(ssl_test_reject_null_in_cert_subject),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_escape_rfc_2253_=
chars_in_subject),</span><br><span>         cmocka_unit_test(ssl_test_extra=
ct_peer_info)</span><br><span> </span><br><span>     };</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1898?usp=3Demail">change 1898</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1898?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451=
d268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1898 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

<=
/body></html>
--8ovISFfcv2k=--


--===============3191435867089965876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3191435867089965876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3191435867089965876==--

