Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B13606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Me5m5ND6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kHZJf3FM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cXnBLhsD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Shh0UU7F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=GZ209x8dZ+co9nItKOQvrdxxVvV6qtjGF/aSzxileI4=; b=Me5m5ND6QgP9PvqeQ4omlIc+XC
	6Bwu9hIgUCRnSlMQZR/zBut2iNqUX0qHEhbwu8JZAmDArtfeNXul1fDbNjVICUFQh3sJt7usrdYZu
	2qaRgBXMpIsZZ04lkFwADXLF/9nnJ4mHhsNZ5iCgGKh5Dmz1jfhc2A3L1ER6jw9NCWkY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL3V7-000000004Zn-1G0a;
	Sun, 25 Oct 2026 19:03:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL3V5-000000004Zf-1wFh
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 19:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5zn1MDo46ma5A9R6+8BXqbaF4uYbsbPSiBhIrswkhBY=; b=kHZJf3FMeQsFxkVu9yy9r5ml4i
 FnvYnTQx1sFYfZ4W2x0XZiF7eCh84Uxa6w4920Et16gOLYBNJsywlfVzzMJq0gsbCtNi0fdeOP1Rn
 rngd9V1NimhZKubadbijQf2gtjBuBHSUG+NWdTXnIx1EiA8/omBpYMzS66p2PRbIoGak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5zn1MDo46ma5A9R6+8BXqbaF4uYbsbPSiBhIrswkhBY=; b=cXnBLhsDirNZo0ObVC+2OWygh2
 kLk4fMZZc7SHH2nB64R/nE0vz/EICJtNV2DksI+GShGc9ctd72oraGj2tKOZhVrineZHs9gPvYJDX
 5DT+Xr2M8jGalZcwoIyRcBgSQfgn04ciaPGhuRvcRxKh6VdKSYnF9wY0JaqtELagvT9Y=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL3V3-000000000XP-1pnT for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 19:03:22 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so10833595e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 12:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792954995; x=1793559795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5zn1MDo46ma5A9R6+8BXqbaF4uYbsbPSiBhIrswkhBY=;
 b=Shh0UU7FgsQI2HeePt1gObi1UxBkLu5npO6ZiwCEcaOebYY5pHHiRBEeMYKkPL/JuN
 LP56gvQ5zybTcwPPUeUCWcwXvRPK1FVi+FmhMuqpW2xjoYmK/lk1wn4R51SpFSIshnsU
 2KvFT6vmJ3sMIPTlH+PJ09c1XSSDQrkmC4IWxvm2w7fNEtBSOYXAwjtVvnJSj+Pfo5z9
 /QP0Do5ilFs5KEWAIzLRFZ2eDVno8hg6Nr3nktih6vftNPjzXwbWi6b09k5yB8ciKY0L
 NED5taaDe7fiMC6G4UplbTkEl0R10j/5Tgd8Euz2ZjWUKCR5IoCO2p+WjgwX0ruYEW1C
 GX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792954995; x=1793559795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5zn1MDo46ma5A9R6+8BXqbaF4uYbsbPSiBhIrswkhBY=;
 b=b1OYgJAJMoIJQKQZRLpq0ZjAkwn4jmEcCU38LmwLMTnLCzVMxAyBriTG3p9eU1dp79
 2njz/Yw4D1FQ2WQnvhUrJYPHZkEmPqCDlEWVwmuz38ViFCm/YCHTPy0fr2zapZxP7hlT
 NLmlhPka1aT1CFMmkcas86k/qcy3VwPBpgCsXzVtBMb5jy5NhbvlFOJNNDjGS4DMXiEO
 Qd8w96NBO/HRnE5K4rJ0CRRLy+Crku+sJzLtoUSvO+rQZc8i6iaYvvFkvFNQBDDdN8gO
 j0Iv99ATQLb2qk/MH4TTaonW/NgeJUUZ1awb2mqrhpX5hKW9qhZpCgqsPCoJHPK+mXh2
 XC4A==
X-Gm-Message-State: AFq9FYKTKoU2EL1KrY4p1XZAVdjClVXdHoc1F2ERZCohxCVDnyS3n8ai
 B+o1pxuBWXUcE7FTpp7qFH4+FvGC3M2KDRYcl1Hfx3SUOxhAptR/zbzGZFciNMrIQWZPhSD50X7
 rQ/HWsXidr8psNBGPU7Na+dxQMboduAabVtoEZlacspmG+8ybcQrb3PD8xG4qvAEhHAL5316IZR
 JeavojJg==
X-Gm-Gg: AYBFou1iaVXqEewFPbHeCEzqAnOKrWuSM38Vtm/YaaiWdrs0SCMTdQ8508lrS5PccKq
 UWX8zmIfNzfyHiij1fQdG290Mpdl7vFcVUOoam/QbL1k1az5qBzsW+PtryIf8ZuhvJMGQSY3Wxq
 aeOqNC/L9uOo+ccW7oiSyKDFbieK8yvSGA/+s92HYgKtLixyFXL+a9gNHlKfmOrATxPmPekMKMI
 LwhhnuX6GPjoj14CA8HSELCXSuMjdlZGEmRaK+DqZqKYOlKjJZSGjLc8wsxRY2D+CTevSlADpS1
 /bNkjiYjEicOKwVgrZeUELYAac2Lsa1+9Lu3VmoQEMQPJ7LiVAyXnkFEZt5TMk7nHBdtjHu/gvv
 7WV64eravd6bHhsxHCTH1Ift+kkKefX4w0GS/i/sWxi2//KZ02B/hRDNIEh7rurkaLK6hTYj9sn
 GRssMIk00YrYbCg+TnsFd1XreFtHBPuPqvAW4TYc9wI5zrM6zuZ50F6Ns5cbo4RvK0tP50KbwbH
 069AnSbYsovRSWlHa7tg4jfZHVtO1ssl8h7O2DAzQM2yHAnRbjBjdh6jNu+lW+SRZ8SKvIbLgpg
 B/MzQFLKIPToOe2W0EJTDPX5HFfvRhGujbWwosaFte1WBOVmXmY1A2+MPYE8zF1s/7H/4o569WO
 O7JjV+qQjEJo1Nbb2GAFxfQpsIkN3jxCy9LJ7QTsozA==
X-Received: by 2002:a05:600c:3114:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a35acc7716mr78550185e9.20.1792954994540; 
 Sun, 25 Oct 2026 12:03:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbd830sm72447555e9.1.2026.10.25.12.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:03:14 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 19:03:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
X-Gerrit-Change-Number: 1998
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1998?usp=email>
X-Gerrit-Commit: ededb5b3b364d350fbe8fbe023eaf33d42ca4c29
References: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDU5NjEwMDAwLkk4OGIxN2FmOTk4OGFhNjQwY2EwNGM3NjViNmU3OWRkMWM4ZjgyMmM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3e13843a70596ac041409ee338b6c0cef8fe522-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xL3V3-000000000XP-1pnT
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2400176019452287573=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2400176019452287573==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OKLfRjREld4="; charset=UTF-8

--OKLfRjREld4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1998?usp=3Demail

to review the following change=2E
=


Change subject: Check for null-bytes in certificate subjects
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Check for null-bytes in c=
ertificate subjects

This is a partial backport of commit cf4384ee "Check f=
or null-bytes in
certificate subjects" from the release/2=2E7 branch=2E

Wh=
en using the OpenSSL library, we escaped embedded null-bytes in a
certifica=
te's subject in x509_get_subject(), but in
extract_x509_field_ssl(), we cop=
ied any null-bytes that are contained in
the field value=2E When using the =
option --verify-x509-name, this could
lead to an incorrect name being accep=
ted=2E For example, the common name
"admin\0impersonator" would be accepted=
 when running with
--verify-x509-name admin name=2E

To fix this, this comm=
it makes x509_get_subject() return an error if the
subject contains an embe=
dded null-byte=2E This way, OpenVPN won't connect
with peers that present s=
uch certificates=2E

As a defense-in-depth measure, we also check for null-=
bytes in
extract_x509_field_ssl() in case a future version of OpenVPN has a=
 code
path that avoids x509_get_subject()=2E

With Mbed TLS, the x509_get_s=
ubject() function already returned an error
when there is an embedded null-=
byte=2E (As of Mbed TLS 3=2E5=2E) Since the
mbedtls backend code changed si=
gnificantly between 2=2E6 and 2=2E7 and 2=2E6
is in maintenance mode, we're=
 not backporting the Mbed TLS defense in
depth measure back to the ssl_veri=
fy_mbedtls=2Ec=2E

Discovered and reported by BreachX Zero Day Labs, using =
Typhon AI Mil v2=2E
Contributing Researcher: Vivek Parikh=2E

CVE: 2026-847=
90
Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Github: OpenVPN/=
openvpn-private-issues#163

Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f=
822c7
Signed-off-by: Steffan Karger <steffan=2Ekarger@sentyron=2Ecom>
---
M=
 src/openvpn/ssl_verify_openssl=2Ec
1 file changed, 36 insertions(+), 14 de=
letions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/98/1998/2

diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/open=
vpn/ssl_verify_openssl=2Ec
index ec3a7cf=2E=2Eead961f 100644
--- a/src/open=
vpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -206=
,12 +206,14 @@
     X509_NAME_ENTRY *x509ne =3D NULL;
     ASN1_STRING *asn=
1 =3D NULL;
     unsigned char *buf =3D NULL;
+    result_t ret =3D FAILURE=
;
+
     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
 
    =
 if (field_name_obj =3D=3D NULL)
     {
         msg(D_TLS_ERRORS, "Invalid=
 X509 attribute name '%s'", field_name);
-        return FAILURE;
+        =
goto exit;
     }
 
     ASSERT(size > 0);
@@ -227,32 +229,33 @@
     /* No=
thing found */
     if (lastpos =3D=3D -1)
     {
-        return FAILURE;
=
+        goto exit;
     }
 
     x509ne =3D X509_NAME_get_entry(x509, last=
pos);
     if (!x509ne)
     {
-        return FAILURE;
+        goto exit;=

     }
 
     asn1 =3D X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
 =
    {
-        return FAILURE;
+        goto exit;
     }
-    if (ASN1_STR=
ING_to_UTF8(&buf, asn1) < 0)
+    int length =3D ASN1_STRING_to_UTF8(&buf, =
asn1);
+    if (length < 0 || (size_t)length !=3D strlen((char *)buf))
    =
 {
-        return FAILURE;
+        goto exit;
     }
 
     strncpynt(out=
, (char *)buf, size);
 
-    {
-        const result_t ret =3D (strlen((cha=
r *)buf) < size) ? SUCCESS : FAILURE;
-        OPENSSL_free(buf);
-        =
return ret;
-    }
+    ret =3D (strlen((char *)buf) < size) ? SUCCESS : FA=
ILURE;
+
+exit:
+    OPENSSL_free(buf);
+    return ret;
 }
 
 result_t
@@ =
-376,9 +379,9 @@
         goto err;
     }
 
-    X509_NAME_print_ex(subjec=
t_bio, X509_get_subject_name(cert),
-                       0, XN_FLAG_SEP_=
CPLUS_SPC | XN_FLAG_FN_SN
-                       |ASN1_STRFLGS_UTF8_CONVER=
T | ASN1_STRFLGS_ESC_CTRL);
+    /* Get the subject with unescaped control =
characters so that we can check for null bytes=2E */
+    X509_NAME_print_e=
x(subject_bio, X509_get_subject_name(cert), 0,
+                       XN_F=
LAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (=
BIO_eof(subject_bio))
     {
@@ -386,6 +389,25 @@
     }
 
     BIO_get_mem=
_ptr(subject_bio, &subject_mem);
+    if (memchr(subject_mem->data, 0, subj=
ect_mem->length) !=3D NULL)
+    {
+        msg(M_WARN, "ERROR: Certificate=
 subject contains a '\\0' byte=2E");
+        goto err;
+    }
+
+    /* No=
w output the subject with escaped control characters=2E */
+    if (BIO_res=
et(subject_bio) !=3D 1)
+    {
+        goto err;
+    }
+    X509_NAME_pri=
nt_ex(subject_bio, X509_get_subject_name(cert), 0,
+                       =
XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
+        =
               | ASN1_STRFLGS_ESC_CTRL);
+    if (BIO_eof(subject_bio))
+  =
  {
+        goto err;
+    }
+    BIO_get_mem_ptr(subject_bio, &subject_me=
m);
 
     subject =3D gc_malloc(subject_mem->length + 1, false, gc);
 

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: I88b17af9988a=
a640ca04c765b6e79dd1c8f822c7
Gerrit-Change-Number: 1998
Gerrit-PatchSet: 2
=
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>

--OKLfRjREld4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger would like Arn=
e Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Check for null-bytes in certificate subjects<br><br>This is a=
 partial backport of commit cf4384ee &quot;Check for null-bytes in<br>certi=
ficate subjects&quot; from the release/2=2E7 branch=2E<br><br>When using th=
e OpenSSL library, we escaped embedded null-bytes in a<br>certificate&#39;s=
 subject in x509_get_subject(), but in<br>extract_x509_field_ssl(), we copi=
ed any null-bytes that are contained in<br>the field value=2E When using th=
e option --verify-x509-name, this could<br>lead to an incorrect name being =
accepted=2E For example, the common name<br>&quot;admin\0impersonator&quot;=
 would be accepted when running with<br>--verify-x509-name admin name=2E<br=
><br>To fix this, this commit makes x509_get_subject() return an error if t=
he<br>subject contains an embedded null-byte=2E This way, OpenVPN won&#39;t=
 connect<br>with peers that present such certificates=2E<br><br>As a defens=
e-in-depth measure, we also check for null-bytes in<br>extract_x509_field_s=
sl() in case a future version of OpenVPN has a code<br>path that avoids x50=
9_get_subject()=2E<br><br>With Mbed TLS, the x509_get_subject() function al=
ready returned an error<br>when there is an embedded null-byte=2E (As of Mb=
ed TLS 3=2E5=2E) Since the<br>mbedtls backend code changed significantly be=
tween 2=2E6 and 2=2E7 and 2=2E6<br>is in maintenance mode, we&#39;re not ba=
ckporting the Mbed TLS defense in<br>depth measure back to the ssl_verify_m=
bedtls=2Ec=2E<br><br>Discovered and reported by BreachX Zero Day Labs, usin=
g Typhon AI Mil v2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>CV=
E: 2026-84790<br>Reported-by: Vivek Parikh &lt;vivek=2Eparikh@breachx=2Eai&=
gt;<br>Github: OpenVPN/openvpn-private-issues#163<br><br>Change-Id: I88b17a=
f9988aa640ca04c765b6e79dd1c8f822c7<br>Signed-off-by: Steffan Karger &lt;ste=
ffan=2Ekarger@sentyron=2Ecom&gt;<br>---<br>M src/openvpn/ssl_verify_openssl=
=2Ec<br>1 file changed, 36 insertions(+), 14 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
98/1998/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/ope=
nvpn/ssl_verify_openssl=2Ec</span><br><span>index ec3a7cf=2E=2Eead961f 1006=
44</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -206,12 +206,1=
4 @@</span><br><span>     X509_NAME_ENTRY *x509ne =3D NULL;</span><br><span=
>     ASN1_STRING *asn1 =3D NULL;</span><br><span>     unsigned char *buf =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    result=
_t ret =3D FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_nam=
e, 0);</span><br><span> </span><br><span>     if (field_name_obj =3D=3D NUL=
L)</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;=
Invalid X509 attribute name &#39;%s&#39;&quot;, field_name);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><br><sp=
an>     }</span><br><span> </span><br><span>     ASSERT(size &gt; 0);</span=
><br><span>@@ -227,32 +229,33 @@</span><br><span>     /* Nothing found */</=
span><br><span>     if (lastpos =3D=3D -1)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return FAILURE;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto exit;</span><b=
r><span>     }</span><br><span> </span><br><span>     x509ne =3D X509_NAME_=
get_entry(x509, lastpos);</span><br><span>     if (!x509ne)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        go=
to exit;</span><br><span>     }</span><br><span> </span><br><span>     asn1=
 =3D X509_NAME_ENTRY_get_data(x509ne);</span><br><span>     if (!asn1)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        goto exit;</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (ASN1_STRING_to_UTF8(&amp;buf, asn1) &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int length =3D ASN=
1_STRING_to_UTF8(&amp;buf, asn1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (length &lt; 0 || (size_t)length !=3D strlen((char *)b=
uf))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return FAILURE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto exit;</span><br><span>     }</span><br><span> </span=
><br><span>     strncpynt(out, (char *)buf, size);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const result_t ret =3D (strlen((cha=
r *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        OPENSSL_free(buf);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return ret;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+exit:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    OPENSSL_free(buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><span> =
</span><br><span> result_t</span><br><span>@@ -376,9 +379,9 @@</span><br><s=
pan>         goto err;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_print_ex(subject_bi=
o, X509_get_subject_name(cert),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                       0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
|ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Get the subject with unescaped con=
trol characters so that we can check for null bytes=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    X509_NAME_print_ex(subject_bio, X=
509_get_subject_name(cert), 0,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | A=
SN1_STRFLGS_UTF8_CONVERT);</span><br><span> </span><br><span>     if (BIO_e=
of(subject_bio))</span><br><span>     {</span><br><span>@@ -386,6 +389,25 @=
@</span><br><span>     }</span><br><span> </span><br><span>     BIO_get_mem=
_ptr(subject_bio, &amp;subject_mem);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (memchr(subject_mem-&gt;data, 0, subject_mem-&gt;le=
ngth) !=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N, &quot;ERROR: Certificate subject contains a &#39;\\0&#39; byte=2E&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Now output the subject with escaped control ch=
aracters=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (BIO_reset(subject_bio) !=3D 1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    X509_NAME_pr=
int_ex(subject_bio, X509_get_subject_name(cert), 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       XN_FLAG_SEP_CPLUS_=
SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                       | ASN1_STRFLGS_ESC_CTRL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BIO_eof(su=
bject_bio))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    BIO_get_mem_ptr(subject_bio, &amp;=
subject_mem);</span><br><span> </span><br><span>     subject =3D gc_malloc(=
subject_mem-&gt;length + 1, false, gc);</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">chan=
ge 1998</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1998 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: St=
effan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--OKLfRjREld4=--


--===============2400176019452287573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2400176019452287573==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2400176019452287573==--

