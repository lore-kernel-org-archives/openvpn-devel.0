Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CF606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZFuohMrQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dRXShf/a;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PbnTxIT3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UZiVVU7v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eojRwZiSYLgR1AXd9+5rtGiAM9FPIXg3pRF2fSlcxrY=; b=ZFuohMrQkMaSjIYmzpVI69hU/X
	vUNb3lZQlYGrbP80oaI/+DLsHSCfTvb3jnoRgS3Y7pTq+5ld+l2KaG+QnObWuv2PWI5SVuRCILatA
	/oCgTrIClJCo8G0le/CAsdclnozd+K35TF2EfesO63kX6QTDxrAfXaGZziCNCfoFgbGA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsR0-000000006vj-319Y;
	Mon, 02 Nov 2026 13:50:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNsQz-000000006va-15dH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8F24NOf8PZL0HZB3LUfQ6jAqZbrO/6gftKAv78e/+mc=; b=dRXShf/aVQTzxxlWkxbf73fVbh
 oSGp0E4h8GNdFzFYDx5tGdBcN194qB5JnCMXOtALh1v8PiMhZHzTcvdvy5WavpFjAK8tZKlglNetn
 dMmie5EehpkrSAl3rBVmSsyjJyEOhB4dNMbz2+nqZ1Ji9JNvFn0S0ftx3ljD58bL8ynU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8F24NOf8PZL0HZB3LUfQ6jAqZbrO/6gftKAv78e/+mc=; b=PbnTxIT3ahVlvkHeT0GRitNCfp
 PocUycYd3gkkss0DYrrwxdXOyFGHeGkGEw0v9rhh0Kgf25PhwYpRt6mzGdLGSoAa2/AT2xAmapqm5
 LyG9GWH3C5n+dgJsaukPp5NPZiT8tonjOXqvDHJmgfqIj/0nNYcm9Zdz2clZZ69sOb+I=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNsQv-000000000Z1-1OZn for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:50:49 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so26412665e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793627439; x=1794232239; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8F24NOf8PZL0HZB3LUfQ6jAqZbrO/6gftKAv78e/+mc=;
 b=UZiVVU7v/1Iud4U0q1nmg+9zXLZW5MqIfEwKEsd6AQpskL3waijccyadzanYTvdbDG
 CSU2NZ8CGjnvKEUvRW7PxIM3NVBF7CJOK043E4uZsQ8xWJOU9bpp8n9LvlxXvYYIgYpT
 X9tF5EHuWD5lzY3hYICGH4uRfr7jlYyQwhonet63rrkevZX//0TtX9Kn9u+5tw1AYC80
 Wbq+mId1483rOJVAkxK1VoVDZ6TWGu27vj3uKNYJv+z6j0foHcvA2EvR0fhvKhgP37Kd
 jVsehp/tYpmiJJSusxY23SsiZkCAkuy/+eC4YcL/C0SZHYwAye23o8+is54ywh0YrQRN
 LS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627439; x=1794232239;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8F24NOf8PZL0HZB3LUfQ6jAqZbrO/6gftKAv78e/+mc=;
 b=NNrSy7mDcgtJqazy69e8K06Cvq4IXe3dBhsvLo5kJon3SqzdIm0wc7CI+ea7Cq7LHg
 S7PCWRvacH0t1gduQHbGDO6CuLKBhSFMHrINRvAc+PXY0tzAxrR75P0GcjQUqpZzWh6f
 8SvijiblfN4yG/9OBj0apwMuxhjjfk2XqsG/C92SgXhV0k+WcdI3XLA6YFeGiAYZrNkL
 bWM5+rxZ+CJ2RrLvgNUj1MEHRJWRYNhiDjESdzYHVKtfp0bufQdCBQCLDlsvgD/LePMk
 /jhu5U6XxhDkpBpXIENTWrcyTomfZBlw3E98FqSvCsZYG86lk8KJodF5V3XI7od0QLsk
 DSIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxOQl26Ts3Ev8pK4EBTzPsUTsMO+yZSfeyMkvxsN36XZUO51t6+VgXOWsXZyA6uwQvkZ8EpGi15A9UKGQ/@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKC7hT+0V99Jlj2Gc4NNp0syD0NdQdd/K5Ppj4Yyhs9smu1TxHk
 dfPgYTInH5wRcj27IelGrQa42jRFaE0GPw0Mwsrh03UnLArdVRTqle5nbb5mVHzNpYioGjachKe
 WH2ixBi60REpaog1ct2EjtnJx7JyU0xTxFWNsWImCBraIJUmivdlbqRSEAaEt97LSS7Am
X-Gm-Gg: AYBFou2CXZ5qX0C8wc0/ELEtb6UCTO/UjK13b1W47xRQUpR940U66glSpgPbaMldUrv
 L464jSw/c5UtxcxDQqsGVVVKi5atYJB8ym8uiCc63HvYzo/QXHkzcfc0APTCa8NIe5OED8hQDfU
 ThIEsy641NxnjttWd6/PuwbZeTnKAH7ORi8qe9vFGADwNeHpoi5xDL7G0iIKRxmb2R9/O6OgTT1
 UIk7Z2DptEVtzFYDQLDtJpiqCk3qRmasdSSSfSW6GogCYStzJDXj5phNIk/P4uBjn9N6jQKUE2u
 15KJD252rdV4oxcy4W/IhaPEOhU4kRN3ImFrZY+Lp0Y0/a+GnAMbMGaHhoB6uGSmRcivVjAlDTs
 RIKrVN0tiMx4BQhqaJl2MKP8aXtOb7LFEccUf2Kpe01cb84YF8ZEwAh7YVhAk5o/b5g2XJa5tvD
 F6sGQqAhBSRsKoQQ2L56bexIs3Rl9co84LgRP86VAQj7DoHkK7/XbTwK77Utrm8oJpsq1hvEfzA
 Wh5JVua34puUeXYEwaIUsCsJ419vQf/WFIU+SrFDBc4uI4EKuoUSsQsZlDGR7GrsWZ2VMX9pePS
 Mg5V0w5gcTC3iDtXy2IBUCjAagyBdi78aRYY1MAz9OzpgyYBu924xDfCZcZI1abaqwQLpsmxavg
 8ttO1ogNlv/DuNBK7AqApZhMjEzdd3AcG4ac8Jr2w1US7wBQmE7vxf5aEayxFKoTt4AlY/UD2DG
 3neWxgWy4Z02zvfdC/XsPCw06Nu1qY0iWUAJ4=
X-Received: by 2002:a05:600c:19d3:b0:4a2:a3b:7aa8 with SMTP id
 5b1f17b1804b1-4ac14fbdd29mr230075215e9.3.1793627438637; 
 Mon, 02 Nov 2026 05:50:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm517385575e9.15.2026.11.02.05.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:50:38 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:50:37 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
X-Gerrit-Change-Number: 1998
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1998?usp=email>
X-Gerrit-Commit: e47a507ce3787037ea761f1d56610d829439fdb4
In-Reply-To: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
References: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDU5NjEwMDAwLkk4OGIxN2FmOTk4OGFhNjQwY2EwNGM3NjViNmU3OWRkMWM4ZjgyMmM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5a6b5d3ca277a88173b8e7892bbd14b1ec3e1d1-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNsQv-000000000Z1-1OZn
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Check for
 null-bytes in certificate subjects
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8394476464250980188=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8394476464250980188==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SLIrMk9LwwE="; charset=UTF-8

--SLIrMk9LwwE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1998?usp=3Demail )

Change subject: Check for null-bytes in cer=
tificate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Check for null-bytes in certificate subjects

This is a partial backpo=
rt of commit cf4384ee "Check for null-bytes in
certificate subjects" from t=
he release/2=2E7 branch=2E

When using the OpenSSL library, we escaped embe=
dded null-bytes in a
certificate's subject in x509_get_subject(), but in
ex=
tract_x509_field_ssl(), we copied any null-bytes that are contained in
the =
field value=2E When using the option --verify-x509-name, this could
lead to=
 an incorrect name being accepted=2E For example, the common name
"admin\0i=
mpersonator" would be accepted when running with
--verify-x509-name admin n=
ame=2E

To fix this, this commit makes x509_get_subject() return an error i=
f the
subject contains an embedded null-byte=2E This way, OpenVPN won't con=
nect
with peers that present such certificates=2E

As a defense-in-depth me=
asure, we also check for null-bytes in
extract_x509_field_ssl() in case a f=
uture version of OpenVPN has a code
path that avoids x509_get_subject()=2E
=

With Mbed TLS, the x509_get_subject() function already returned an error
w=
hen there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Since the
m=
bedtls backend code changed significantly between 2=2E6 and 2=2E7 and 2=2E6=

is in maintenance mode, we're not backporting the Mbed TLS defense in
dept=
h measure back to the ssl_verify_mbedtls=2Ec=2E

Discovered and reported by=
 BreachX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: =
Vivek Parikh=2E

CVE: 2026-84790
Reported-by: Vivek Parikh <vivek=2Eparikh@=
breachx=2Eai>
Github: OpenVPN/openvpn-private-issues#163

Change-Id: I88b17=
af9988aa640ca04c765b6e79dd1c8f822c7
Signed-off-by: Steffan Karger <steffan=
=2Ekarger@sentyron=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998
Message-Id: <20=
261102130953=2E21115-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40429=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify_=
openssl=2Ec
1 file changed, 36 insertions(+), 14 deletions(-)




diff --gi=
t a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec=

index ec3a7cf=2E=2Eead961f 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec=

+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -206,12 +206,14 @@
     X509_N=
AME_ENTRY *x509ne =3D NULL;
     ASN1_STRING *asn1 =3D NULL;
     unsigned =
char *buf =3D NULL;
+    result_t ret =3D FAILURE;
+
     ASN1_OBJECT *fiel=
d_name_obj =3D OBJ_txt2obj(field_name, 0);
 
     if (field_name_obj =3D=3D=
 NULL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'"=
, field_name);
-        return FAILURE;
+        goto exit;
     }
 
     A=
SSERT(size > 0);
@@ -227,32 +229,33 @@
     /* Nothing found */
     if (la=
stpos =3D=3D -1)
     {
-        return FAILURE;
+        goto exit;
     }=

 
     x509ne =3D X509_NAME_get_entry(x509, lastpos);
     if (!x509ne)
  =
   {
-        return FAILURE;
+        goto exit;
     }
 
     asn1 =3D X5=
09_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
-        return FAIL=
URE;
+        goto exit;
     }
-    if (ASN1_STRING_to_UTF8(&buf, asn1) < =
0)
+    int length =3D ASN1_STRING_to_UTF8(&buf, asn1);
+    if (length < 0=
 || (size_t)length !=3D strlen((char *)buf))
     {
-        return FAILURE=
;
+        goto exit;
     }
 
     strncpynt(out, (char *)buf, size);
 
- =
   {
-        const result_t ret =3D (strlen((char *)buf) < size) ? SUCCESS=
 : FAILURE;
-        OPENSSL_free(buf);
-        return ret;
-    }
+    re=
t =3D (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+
+exit:
+    OPENS=
SL_free(buf);
+    return ret;
 }
 
 result_t
@@ -376,9 +379,9 @@
         =
goto err;
     }
 
-    X509_NAME_print_ex(subject_bio, X509_get_subject_na=
me(cert),
-                       0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN
=
-                       |ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL)=
;
+    /* Get the subject with unescaped control characters so that we can =
check for null bytes=2E */
+    X509_NAME_print_ex(subject_bio, X509_get_su=
bject_name(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLA=
G_FN_SN | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
    =
 {
@@ -386,6 +389,25 @@
     }
 
     BIO_get_mem_ptr(subject_bio, &subject=
_mem);
+    if (memchr(subject_mem->data, 0, subject_mem->length) !=3D NULL=
)
+    {
+        msg(M_WARN, "ERROR: Certificate subject contains a '\\0' =
byte=2E");
+        goto err;
+    }
+
+    /* Now output the subject with =
escaped control characters=2E */
+    if (BIO_reset(subject_bio) !=3D 1)
+ =
   {
+        goto err;
+    }
+    X509_NAME_print_ex(subject_bio, X509_ge=
t_subject_name(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN=
_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
+                       | ASN1_STRF=
LGS_ESC_CTRL);
+    if (BIO_eof(subject_bio))
+    {
+        goto err;
+  =
  }
+    BIO_get_mem_ptr(subject_bio, &subject_mem);
 
     subject =3D gc_=
malloc(subject_mem->length + 1, false, gc);
 

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 release/2=2E6
Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
=
Gerrit-Change-Number: 1998
Gerrit-PatchSet: 3
Gerrit-Owner: Steffan Karger =
<steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--SLIrMk9LwwE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1998?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Check for null-bytes in certificat=
e subjects<br><br>This is a partial backport of commit cf4384ee &quot;Check=
 for null-bytes in<br>certificate subjects&quot; from the release/2=2E7 bra=
nch=2E<br><br>When using the OpenSSL library, we escaped embedded null-byte=
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
ode<br>path that avoids x509_get_subject()=2E<br><br>With Mbed TLS, the x50=
9_get_subject() function already returned an error<br>when there is an embe=
dded null-byte=2E (As of Mbed TLS 3=2E5=2E) Since the<br>mbedtls backend co=
de changed significantly between 2=2E6 and 2=2E7 and 2=2E6<br>is in mainten=
ance mode, we&#39;re not backporting the Mbed TLS defense in<br>depth measu=
re back to the ssl_verify_mbedtls=2Ec=2E<br><br>Discovered and reported by =
BreachX Zero Day Labs, using Typhon AI Mil v2=2E<br>Contributing Researcher=
: Vivek Parikh=2E<br><br>CVE: 2026-84790<br>Reported-by: Vivek Parikh &lt;v=
ivek=2Eparikh@breachx=2Eai&gt;<br>Github: OpenVPN/openvpn-private-issues#16=
3<br><br>Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7<br>Signed-off=
-by: Steffan Karger &lt;steffan=2Ekarger@sentyron=2Ecom&gt;<br>Acked-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1998<br>Message-Id: &lt;20261102130953=2E21115-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg40429=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify_op=
enssl=2Ec<br>1 file changed, 36 insertions(+), 14 deletions(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_veri=
fy_openssl=2Ec</span><br><span>index ec3a7cf=2E=2Eead961f 100644</span><br>=
<span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_verify_openssl=2Ec</span><br><span>@@ -206,12 +206,14 @@</span><b=
r><span>     X509_NAME_ENTRY *x509ne =3D NULL;</span><br><span>     ASN1_ST=
RING *asn1 =3D NULL;</span><br><span>     unsigned char *buf =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    result_t ret =3D FAI=
LURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);</span><=
br><span> </span><br><span>     if (field_name_obj =3D=3D NULL)</span><br><=
span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;Invalid X509 a=
ttribute name &#39;%s&#39;&quot;, field_name);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</spa=
n><br><span> </span><br><span>     ASSERT(size &gt; 0);</span><br><span>@@ =
-227,32 +229,33 @@</span><br><span>     /* Nothing found */</span><br><span=
>     if (lastpos =3D=3D -1)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><span>    =
 }</span><br><span> </span><br><span>     x509ne =3D X509_NAME_get_entry(x5=
09, lastpos);</span><br><span>     if (!x509ne)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</sp=
an><br><span>     }</span><br><span> </span><br><span>     asn1 =3D X509_NA=
ME_ENTRY_get_data(x509ne);</span><br><span>     if (!asn1)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o exit;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (ASN1_STRING_to_UTF8(&amp;buf, asn1) &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int length =3D ASN1_STRING_to_=
UTF8(&amp;buf, asn1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (length &lt; 0 || (size_t)length !=3D strlen((char *)buf))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      goto exit;</span><br><span>     }</span><br><span> </span><br><span> =
    strncpynt(out, (char *)buf, size);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        const result_t ret =3D (strlen((char *)buf) &lt;=
 size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        OPENSSL_free(buf);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return ret;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
et =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+exit:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OPENSSL_free(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return ret;</span><br><span> }</span><br><span> </span><br><s=
pan> result_t</span><br><span>@@ -376,9 +379,9 @@</span><br><span>         =
goto err;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    X509_NAME_print_ex(subject_bio, X509_get_s=
ubject_name(cert),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                    0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                       |ASN1_STRFLGS=
_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Get the subject with unescaped control character=
s so that we can check for null bytes=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    X509_NAME_print_ex(subject_bio, X509_get_subjec=
t_name(cert), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                    XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UT=
F8_CONVERT);</span><br><span> </span><br><span>     if (BIO_eof(subject_bio=
))</span><br><span>     {</span><br><span>@@ -386,6 +389,25 @@</span><br><s=
pan>     }</span><br><span> </span><br><span>     BIO_get_mem_ptr(subject_b=
io, &amp;subject_mem);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (memchr(subject_mem-&gt;data, 0, subject_mem-&gt;length) !=3D NUL=
L)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ERROR=
: Certificate subject contains a &#39;\\0&#39; byte=2E&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Now output the subject with escaped control characters=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BIO_reset(s=
ubject_bio) !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    X509_NAME_print_ex(subject=
_bio, X509_get_subject_name(cert), 0,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN=
_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                       | ASN1_STRFLGS_ESC_CTRL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (BIO_eof(subject_bio))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    BIO_get_mem_ptr(subject_bio, &amp;subject_mem);</s=
pan><br><span> </span><br><span>     subject =3D gc_malloc(subject_mem-&gt;=
length + 1, false, gc);</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">change 1998</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88b17=
af9988aa640ca04c765b6e79dd1c8f822c7 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1998 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;st=
effan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--SLIrMk9LwwE=--


--===============8394476464250980188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8394476464250980188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8394476464250980188==--

