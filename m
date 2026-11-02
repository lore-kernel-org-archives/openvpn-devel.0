Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152E606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=edMrByeK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TYbUr1t1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bqqfq1Lp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SD1Lmvpt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6GbFMNgPl9FpBTqHKhx45mrHn4lv+FXdPoYY0bvue+c=; b=edMrByeKXa9pIhcKsUzYb9j0v1
	+LZfMg+lwJYK3lqnrZV/quwvgq2VKzINCTZZUHkSFgoXuLTZDqfiz0TuHHFoEHONcm0HB7ZbdbE9l
	lc0hNwo/alE/F5C8/fDGGZteec5ICrgHA9bnrnCUT0T/TCafKgJP8RM9CHULNs1zaBcs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNsQy-000000004YS-0zQ8;
	Mon, 02 Nov 2026 13:50:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNsQw-000000004YL-06qC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xFCphusj1heT4hciiSWzz3GeiIaczTht7lIm2WjDwkw=; b=TYbUr1t1W/r8vFL0k7bZ8QwUQs
 sl+R+Qpzhj2PSuVloDKUjvv0sTTbaAm1zmT2Gf5qnbi9JdNs2cD/Ap3DvdteOPI5QkhKV5yDZnkcl
 KtaoEy7ueBpIEUnuiUFpJmk2kVIvla7/rFnnEo/N0OF6lw9hllludiOV2+zuGhtV4Skk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xFCphusj1heT4hciiSWzz3GeiIaczTht7lIm2WjDwkw=; b=bqqfq1LpI3xvsJTgKmCacIUMI1
 WHWQRvIxZIrE+IIZtn44HjUv9KeDQy5cCmPx9iX0vcfQGT8zs2RODCo7lM7bZkYzR4dljwGNsi2T4
 ke62kkpYRzTpKeoH3ygEh3ZunmL2BBj1DLapCROs39QyJAeS7xWjTQkdBEcMX20sfcn0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNsQu-000000000Z0-1X1N for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:50:45 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so39794805e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793627438; x=1794232238; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xFCphusj1heT4hciiSWzz3GeiIaczTht7lIm2WjDwkw=;
 b=SD1LmvptR0X24xcUekFyhS2nEmnKqAA9Lj8aehACl2m7ZcDIfwJK6PQfdi6a0OqIuZ
 Vijf47UZNZ74dxhn+pzy/+ua/FtXJYjkLCV6Expm2fseiwRD9VFg1AJIahx6joDm3XKg
 PPZeezmBKQmlIkny8E1TtJLUDbnTQ7MOckENWK2RfMKTJsqlhapfafcaVI66fwMjwzrY
 sQZw9yIDDL3L4mcL92iMvJx1QlEcCt3m/jwT0TILTx1oMWAbsT77g38ZfGPsFbjjlogC
 LVWa2nBlF8zU6zcZSuWlwZfmjVU6thAM9zUoiIEl0iaB7VjSngDZaeY9xW3EI3Y79Px4
 ZaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793627438; x=1794232238;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xFCphusj1heT4hciiSWzz3GeiIaczTht7lIm2WjDwkw=;
 b=NQVAHm+XmiCgJZNzOJSvogGJrYi7EUyfdqqCJeMAYxyxVajH8LFb+ZKURY41rBLE1r
 xgCdh8O3hnZRS9pu3eT/aBQoOEGY1P7eLAL5d8zdHunMo7FT52ugQyWsMFteXkXhFXOc
 QSOPGV4stbLYn0Rm7IVnYRZI5CFod1aOXXuHZSN7TQje4lOcnTNFJrxZm2J5yvFjdzMi
 63qmvUhVAaKf0mZDbrO3n/lReqiUec3CxpPUVZ+ih4Do4ekLXyF/oKDMVYaKlQ6AER7U
 KqX6bzwrwsj4hJ67e//0VZ8AHNK4PDnK7J2GvtSYEZ5ydXUtcISjun3jual7wpJuMbtc
 CpGA==
X-Gm-Message-State: AFq9FYL5Tfmtt39uFTeqZeJ4JercBacS0EscyU1+ZDlg+kQlZ8HuXUBV
 a+t5Xc6jox84WfFImy1hWDFujWZ125x2ml64+HfMYIQ7Vdc0emWTozD4/xIQKDcmuRsNfoWwWPh
 vphTrFfpUrPQ3G0MNrkvMIMa/rJCZgD7XbAbKFHQZ2OdGoCePiUCi9xoJuJYaUm3w/xul
X-Gm-Gg: AYBFou3USD4Q6mVFpei2/7CyOVVpb2Z5qJB9yNWYhfD8cNWBcjvJyu4bzmr/4G2EVHz
 YcJmkLR9qR/kGcpw9jPdPNzQW1Haj1DtA3qH+6m7X2dTNI8tb6qzii1jS4njaLx0mzPQuEpFmv4
 1+D1Pa7iSmVH4HvH09KmsIf4/B9OrhgVYVXemTUR1Yzpiw/+y/KWUmHBR97nRaPxFCZ+GN7fzDi
 IXqGBer3uqR2LegcJfGaVV0AXJE96+1C7vow3/JDHZy9cdGWL6KuAisvSJC7oy9FMw95WiuMHLk
 guoSTExqvF3G1i9u/MnXWd5YKRDcgebcQ6U0qlIYmXCDGaCDMfIQlXZxy85d3TQcxGwPgp9ZHTU
 YGZxkx/WR2ro7CeGeqbh7RRPrJMdN3hJscU0uHxMDTn8CD7E4yvh48qNKVq8BKbLb4glxusUyk/
 /Z1GZqZl51QSUoDcW+KdSQ97Ye9Dn3fR8UwY6TvJsQr6x2VB8g+lCUygGxQ65fqbx3U37at1j63
 j6D2SkY7IiXjvLJSgVAQL+LokpzfRKvNYcipaeIJzPVGc0EWeY93FM+bHlFIetDKLnVZVi5UavK
 SzfexpvvtX9Zc8mKCv2aCuAQ/w5C3RjkS4Rtk0nc3LaHi6uDaXhqDHCwGztvHR/Q5gGBWuJilEz
 Xz8Mfu/Bw3vdZ/Epm+eGUUVLOVx+BhNBSL4OoWE0HfdPK82a8uyZLwp2NoCC0FnyiZ47nP0Nghr
 Cps8m8vki5iaq88A==
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr247771825e9.13.1793627437551; 
 Mon, 02 Nov 2026 05:50:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm442494195e9.3.2026.11.02.05.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:50:37 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:50:36 +0000
To: Steffan Karger <steffan@karger.me>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
X-Gerrit-Change-Number: 1998
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1998?usp=email>
X-Gerrit-Commit: e47a507ce3787037ea761f1d56610d829439fdb4
In-Reply-To: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
References: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDU5NjEwMDAwLkk4OGIxN2FmOTk4OGFhNjQwY2EwNGM3NjViNmU3OWRkMWM4ZjgyMmM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5a6b5d3ca277a88173b8e7892bbd14b1ec3e1d1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNsQu-000000000Z0-1X1N
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1390104235931499291=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1390104235931499291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BzfZ/1GjYm8="; charset=UTF-8

--BzfZ/1GjYm8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Steffan Karger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998=
?usp=3Demail )

The following approvals got outdated and were removed:
Code=
-Review+2 by Gert Doering


Change subject: Check for null-bytes in certifi=
cate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Check for null-bytes in certificate subjects

This is a partial backport =
of commit cf4384ee "Check for null-bytes in
certificate subjects" from the =
release/2=2E7 branch=2E

When using the OpenSSL library, we escaped embedde=
d null-bytes in a
certificate's subject in x509_get_subject(), but in
extra=
ct_x509_field_ssl(), we copied any null-bytes that are contained in
the fie=
ld value=2E When using the option --verify-x509-name, this could
lead to an=
 incorrect name being accepted=2E For example, the common name
"admin\0impe=
rsonator" would be accepted when running with
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
 there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Since the
mbed=
tls backend code changed significantly between 2=2E6 and 2=2E7 and 2=2E6
is=
 in maintenance mode, we're not backporting the Mbed TLS defense in
depth m=
easure back to the ssl_verify_mbedtls=2Ec=2E

Discovered and reported by Br=
eachX Zero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Viv=
ek Parikh=2E

CVE: 2026-84790
Reported-by: Vivek Parikh <vivek=2Eparikh@bre=
achx=2Eai>
Github: OpenVPN/openvpn-private-issues#163

Change-Id: I88b17af9=
988aa640ca04c765b6e79dd1c8f822c7
Signed-off-by: Steffan Karger <steffan=2Ek=
arger@sentyron=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998
Message-Id: <202611=
02130953=2E21115-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40429=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify_open=
ssl=2Ec
1 file changed, 36 insertions(+), 14 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/98/1998/3

diff --git a=
/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
in=
dex ec3a7cf=2E=2Eead961f 100644
--- a/src/openvpn/ssl_verify_openssl=2Ec
++=
+ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -206,12 +206,14 @@
     X509_NAME=
_ENTRY *x509ne =3D NULL;
     ASN1_STRING *asn1 =3D NULL;
     unsigned cha=
r *buf =3D NULL;
+    result_t ret =3D FAILURE;
+
     ASN1_OBJECT *field_n=
ame_obj =3D OBJ_txt2obj(field_name, 0);
 
     if (field_name_obj =3D=3D NU=
LL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", f=
ield_name);
-        return FAILURE;
+        goto exit;
     }
 
     ASSE=
RT(size > 0);
@@ -227,32 +229,33 @@
     /* Nothing found */
     if (lastp=
os =3D=3D -1)
     {
-        return FAILURE;
+        goto exit;
     }
 
=
     x509ne =3D X509_NAME_get_entry(x509, lastpos);
     if (!x509ne)
     =
{
-        return FAILURE;
+        goto exit;
     }
 
     asn1 =3D X509_=
NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
-        return FAILURE=
;
+        goto exit;
     }
-    if (ASN1_STRING_to_UTF8(&buf, asn1) < 0)
=
+    int length =3D ASN1_STRING_to_UTF8(&buf, asn1);
+    if (length < 0 ||=
 (size_t)length !=3D strlen((char *)buf))
     {
-        return FAILURE;
+=
        goto exit;
     }
 
     strncpynt(out, (char *)buf, size);
 
-    =
{
-        const result_t ret =3D (strlen((char *)buf) < size) ? SUCCESS : =
FAILURE;
-        OPENSSL_free(buf);
-        return ret;
-    }
+    ret =
=3D (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+
+exit:
+    OPENSSL=
_free(buf);
+    return ret;
 }
 
 result_t
@@ -376,9 +379,9 @@
         go=
to err;
     }
 
-    X509_NAME_print_ex(subject_bio, X509_get_subject_name=
(cert),
-                       0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN
- =
                      |ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);
=
+    /* Get the subject with unescaped control characters so that we can ch=
eck for null bytes=2E */
+    X509_NAME_print_ex(subject_bio, X509_get_subj=
ect_name(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_=
FN_SN | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
     {=

@@ -386,6 +389,25 @@
     }
 
     BIO_get_mem_ptr(subject_bio, &subject_m=
em);
+    if (memchr(subject_mem->data, 0, subject_mem->length) !=3D NULL)
=
+    {
+        msg(M_WARN, "ERROR: Certificate subject contains a '\\0' by=
te=2E");
+        goto err;
+    }
+
+    /* Now output the subject with es=
caped control characters=2E */
+    if (BIO_reset(subject_bio) !=3D 1)
+   =
 {
+        goto err;
+    }
+    X509_NAME_print_ex(subject_bio, X509_get_=
subject_name(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN_F=
LAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
+                       | ASN1_STRFLG=
S_ESC_CTRL);
+    if (BIO_eof(subject_bio))
+    {
+        goto err;
+    =
}
+    BIO_get_mem_ptr(subject_bio, &subject_mem);
 
     subject =3D gc_ma=
lloc(subject_mem->length + 1, false, gc);
 

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: release/2=2E6
Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f8=
22c7
Gerrit-Change-Number: 1998
Gerrit-PatchSet: 3
Gerrit-Owner: Steffan Ka=
rger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--BzfZ/1GjYm8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Stef=
fan Karger=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
998?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">Check for=
 null-bytes in certificate subjects<br><br>This is a partial backport of co=
mmit cf4384ee &quot;Check for null-bytes in<br>certificate subjects&quot; f=
rom the release/2=2E7 branch=2E<br><br>When using the OpenSSL library, we e=
scaped embedded null-bytes in a<br>certificate&#39;s subject in x509_get_su=
bject(), but in<br>extract_x509_field_ssl(), we copied any null-bytes that =
are contained in<br>the field value=2E When using the option --verify-x509-=
name, this could<br>lead to an incorrect name being accepted=2E For example=
, the common name<br>&quot;admin\0impersonator&quot; would be accepted when=
 running with<br>--verify-x509-name admin name=2E<br><br>To fix this, this =
commit makes x509_get_subject() return an error if the<br>subject contains =
an embedded null-byte=2E This way, OpenVPN won&#39;t connect<br>with peers =
that present such certificates=2E<br><br>As a defense-in-depth measure, we =
also check for null-bytes in<br>extract_x509_field_ssl() in case a future v=
ersion of OpenVPN has a code<br>path that avoids x509_get_subject()=2E<br><=
br>With Mbed TLS, the x509_get_subject() function already returned an error=
<br>when there is an embedded null-byte=2E (As of Mbed TLS 3=2E5=2E) Since =
the<br>mbedtls backend code changed significantly between 2=2E6 and 2=2E7 a=
nd 2=2E6<br>is in maintenance mode, we&#39;re not backporting the Mbed TLS =
defense in<br>depth measure back to the ssl_verify_mbedtls=2Ec=2E<br><br>Di=
scovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E<b=
r>Contributing Researcher: Vivek Parikh=2E<br><br>CVE: 2026-84790<br>Report=
ed-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Github: OpenVPN/=
openvpn-private-issues#163<br><br>Change-Id: I88b17af9988aa640ca04c765b6e79=
dd1c8f822c7<br>Signed-off-by: Steffan Karger &lt;steffan=2Ekarger@sentyron=
=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998<br>Message-Id: &lt=
;20261102130953=2E21115-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40429=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/ssl_verify_openssl=2Ec<br>1 file changed, 36 insertions(+), =
14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/98/1998/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><sp=
an>index ec3a7cf=2E=2Eead961f 100644</span><br><span>--- a/src/openvpn/ssl_=
verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec=
</span><br><span>@@ -206,12 +206,14 @@</span><br><span>     X509_NAME_ENTRY=
 *x509ne =3D NULL;</span><br><span>     ASN1_STRING *asn1 =3D NULL;</span><=
br><span>     unsigned char *buf =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    result_t ret =3D FAILURE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ASN1_OBJECT *field_=
name_obj =3D OBJ_txt2obj(field_name, 0);</span><br><span> </span><br><span>=
     if (field_name_obj =3D=3D NULL)</span><br><span>     {</span><br><span=
>         msg(D_TLS_ERRORS, &quot;Invalid X509 attribute name &#39;%s&#39;&=
quot;, field_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto exit;</span><br><span>     }</span><br><span> </span><br><sp=
an>     ASSERT(size &gt; 0);</span><br><span>@@ -227,32 +229,33 @@</span><b=
r><span>     /* Nothing found */</span><br><span>     if (lastpos =3D=3D -1=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        goto exit;</span><br><span>     }</span><br><span> </span><b=
r><span>     x509ne =3D X509_NAME_get_entry(x509, lastpos);</span><br><span=
>     if (!x509ne)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return FAILURE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        goto exit;</span><br><span>     }</span><br=
><span> </span><br><span>     asn1 =3D X509_NAME_ENTRY_get_data(x509ne);</s=
pan><br><span>     if (!asn1)</span><br><span>     {</span><br><span style=
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
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
onst result_t ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        OPENSSL_free(b=
uf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return re=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D (strlen((char *)buf) =
&lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exit:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OPENSSL_free(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</s=
pan><br><span> }</span><br><span> </span><br><span> result_t</span><br><spa=
n>@@ -376,9 +379,9 @@</span><br><span>         goto err;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                       0, XN_FL=
AG_SEP_CPLUS_SPC | XN_FLAG_FN_SN</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       |ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS=
_ESC_CTRL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* G=
et the subject with unescaped control characters so that we can check for n=
ull bytes=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                       XN_FLAG_=
SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT);</span><br><span=
> </span><br><span>     if (BIO_eof(subject_bio))</span><br><span>     {</s=
pan><br><span>@@ -386,6 +389,25 @@</span><br><span>     }</span><br><span> =
</span><br><span>     BIO_get_mem_ptr(subject_bio, &amp;subject_mem);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (memchr(subject_me=
m-&gt;data, 0, subject_mem-&gt;length) !=3D NULL)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(M_WARN, &quot;ERROR: Certificate subject contai=
ns a &#39;\\0&#39; byte=2E&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Now output th=
e subject with escaped control characters=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (BIO_reset(subject_bio) !=3D 1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    X509_NAME_print_ex(subject_bio, X509_get_subject_na=
me(cert), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_C=
ONVERT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
          | ASN1_STRFLGS_ESC_CTRL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (BIO_eof(subject_bio))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
BIO_get_mem_ptr(subject_bio, &amp;subject_mem);</span><br><span> </span><br=
><span>     subject =3D gc_malloc(subject_mem-&gt;length + 1, false, gc);</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1998?usp=3Demail">change 1998</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E6 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I88b17af9988aa640ca04c76=
5b6e79dd1c8f822c7 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1998 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=2Eme&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--BzfZ/1GjYm8=--


--===============1390104235931499291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1390104235931499291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1390104235931499291==--

