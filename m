Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C1606A328
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ffwr6IBl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V4ttODnQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F4nepCl/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dLjNQkUY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3wS/pQd11oBkVEGhKzH38VqhfJ0aAkZiIOzvx234z84=; b=Ffwr6IBlh+GAnPbAmIeZe32rv0
	hWWuzh5923zK5oMsFBF6E+KdmQdhFLC2jdsuAhy9R5s7WpYZCU3iK+H/VWJV/1E/6EJTNvJrMV0F7
	k9xbP0dcLyahe1QdePuFgfq5eeHEoHItgB+diOdirhdjWlGkjrM9ep+9mnlsd4vgdyXo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHYl-000000001Q3-1cES;
	Tue, 03 Nov 2026 16:40:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHYY-000000001OP-09Ue
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eiR8TGhEtzZc1nz1O+/6YmZeOApsgIOtiS7BLbC1q2k=; b=V4ttODnQIc5psR5jtOyapaPPuf
 nBQwaTbn/NQtPKSQeZk7SJMqk/PxtfUM1Bq+T82Ojo+3Ps8ePdnxk19+FThPQ+GumNZ6mgaFq3Jj4
 Gq25L8chKvMbgbPN/osJ46u9M5mi1HhOL2lrsukEkYlomWWAXWjVBzyoHvNQfC3WYlOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eiR8TGhEtzZc1nz1O+/6YmZeOApsgIOtiS7BLbC1q2k=; b=F4nepCl/7Rn1EZkJIfZqSZYV9P
 u2MQl8p3wsTJvmEeLDHRmcG+IlRbc4nGhBpofhXzlRAqiEMSznr3We1VFee/sT5oYiGUnTxN1q7YI
 GBVoTRIL0s0wLeKYof63r6gw5MHNQK6w/t9N3JSuYkoy8ZHKYaisnQ/EVkljBEBOEdM0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHYW-000000001o6-1GCm for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:40:17 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so33456215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793724010; x=1794328810; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eiR8TGhEtzZc1nz1O+/6YmZeOApsgIOtiS7BLbC1q2k=;
 b=dLjNQkUYlu7Y2yi3PvSFSYBHIbgPJv1n9z2yU9ZxHvUG7CVcGkqctqnH5aumoQGM8f
 bfzXTQzJxK+nsDTjhfkTSLxHgdEn/58tfavwOXAZj8DoIn6MUl6qjjLlvDxuwsSVTpiU
 duIqprtixmbGkKltoIEUA3jzOLDKNFuvVb+8qKYjxzreiPz9cqKl+wBMn69E16q8A+Vg
 5RXlY9SxGchy2iUJLl4xr3W2DZAIQpSAJ7oFj9ws85XEUfKc6kMuEPdXpsVhVaZQ6vsu
 jAhEP9qsu08rm+1NV8PGlsSIFBe5thSy/5wFPtLZt8fPpQZnRE2Jz/sa4J+PyLCoRArS
 1J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724010; x=1794328810;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eiR8TGhEtzZc1nz1O+/6YmZeOApsgIOtiS7BLbC1q2k=;
 b=Uk5VUn0zaoG+b6zZOa1ojwYDcxjqbdV12w90HYwGLQr8JKR5yGpvD+lA3H4F+AGgNn
 9YDUDXMYPFP05ilvETnJj2i5rJnBC9095YyQDXskXndiPNsdibPY+jQgH6mYsAl8BSBQ
 VbjmdRImCpoB92ri4/HCtR50lwQd0Np23KfisPECrx62i8bzvazJaAwAyfdASy0S+LWh
 qhvFmCiXIn+0bNQ/NFCA7y/k7uU6K31hHBQEqiOOmr8W0Glv12VDtRqFR6JGyMjSerHP
 6mjvMANrCIPX5jI4DO+nlW6an+wXdBQZSWzuxL1BjMxKLPK/naGeV1DeslYvxtbcKh4C
 +hLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ4RMqLkC7bDGWG42WlWPlh5c+hf6MYGwr0018eR75l1/SpaEdXXWj/0kxNmDsdTqq9HyLnkC/yZguAqCO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+9RC0LjvHnRwFgUAe7s6GWZvqUfo6QVtoOkQsoYI5pJhzXmgxN
 Hkrimx7nrtuFXbIngJw24saa9s3bFWL7HPdxovIeokKMzpS3ROWaddHjYSkw7vYwU3JH9DoQimX
 IlpSwcp9/hMyPbG3SaK8oMR8fLnks56Gt49mEqOO4bsAnHBRTmh9MQRd10aY45Ai3XoKI
X-Gm-Gg: AYBFou0QiqFG5AFbb8uKFMfhEKZyvOoRriMs231kvCNOSbWnd7A4jnM7GPRUh+oJbN8
 WkpCecPu9PXRo0FWjGFzLsAdX9voTlWqML4qX2fyUey43zRydzcGeiUNtKxBYpOLtkMm5Ecvs4b
 06+OZ5Bfc/PV/N6K8ah18eR8qQkrlN2VVKlILCOtcG+I9XHoGpUMCVssvN8JFmSPaGLcpvEA41S
 VU5NpJAZcPEWlkxipxMRNPEFAJr69MF7d2qduqCXmhtX29pSt3OibK2fSL++NVMCrd41YK0rh8h
 +7E7krs3Fu4NpSFxLADIeuuylT9AXiXbnT9wiOJcYBoSevRUMKP8x4CW+bXEySd6Jvkn9AS2Mcv
 zSQakZ+st5FlBhCTisEB4S/ZlxVIkuMGLhuRBewPS4aKH1CiLzys3FoKVHIpKo5WnmllYMtbp8i
 waAJanPktJ/M0z1EFMu0YrLY/mMCsuXY02956hSb8zu3ALpZXfhXgFIOF9RrcIiZQ0lh7BEIp/O
 EE8QNtgwxW0QEJOUp4Xf3yckXNU84xfNYYysMUQE+ccy+wVO8aVvrAEl/nhf4Ux97lYL8WVe5u5
 RxQ14NzKXaH1639LqO9qyk7DL7oCUtFJ7AGeDMt+b+XI5EQ63CQXI9X2Pg14jd+4aqdVYpSIL4O
 J8M/hgdPidLvQejNAkupQIIPYki0HkXdPzAKoi4KieExb1Su20r196264Wd4JSDi7NeY5yS+wxU
 lXVHXLzgaTj42j5w==
X-Received: by 2002:a05:600c:46d2:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4ac1980118cmr299938025e9.33.1793724009571; 
 Tue, 03 Nov 2026 08:40:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9faff90sm80648775e9.5.2026.11.03.08.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:40:09 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:40:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
X-Gerrit-Change-Number: 2087
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2087?usp=email>
X-Gerrit-Commit: 238274cb2139615379fe8300462b38c8ce096d07
In-Reply-To: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
References: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIwNTY1MDAwLkkxYmZmMzEwN2Y5NWI0MDNkNTU0YmVhNDI2MmMyZGRhMjcwYTFmYzc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <acb67a134af1de0af75c987898076d04c64c9fc9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHYW-000000001o6-1GCm
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use
 ASN1_STRING_get_length instead of ASN1_STRING_length
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3164914470132273545=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3164914470132273545==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bdDBc+0DM+s="; charset=UTF-8

--bdDBc+0DM+s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2087?usp=3Demail )

Change subject: Use ASN1_STRING_get_length =
instead of ASN1_STRING_length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Use ASN1_STRING_get_length instead of ASN1_STRING_length

=
OpenSSL 4=2E1 introduced ASN1_STRING_get_length and at the same
time deprec=
ated the ASN1_STRING_length method=2E Use the
new method and add a compat m=
acro for older versions and
other OpenSSL like libraries=2E

Change-Id: I1b=
ff3107f95b403d554bea4262c2dda270a1fc79
Signed-off-by: Arne Schwabe <arne@rf=
c2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087
Message-Id: <20261102141709=
=2E30018-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40439=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/openssl_compat=2Eh
M sr=
c/openvpn/ssl_verify_openssl=2Ec
2 files changed, 6 insertions(+), 1 deleti=
on(-)




diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl=
_compat=2Eh
index 4305fea=2E=2E8309cee 100644
--- a/src/openvpn/openssl_com=
pat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -204,4 +204,9 @@
 #define E=
VP_CIPH_FLAG_ENC_THEN_MAC 0x10000000
 #endif
 
+/* Introduced in OpenSSL 4=
=2E1=2E0 */
+#if OPENSSL_VERSION_NUMBER < 0x40100000
+#define ASN1_STRING_g=
et_length (size_t)ASN1_STRING_length
+#endif
+
 #endif /* OPENSSL_COMPAT_H_=
 */
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verif=
y_openssl=2Ec
index 146a384=2E=2E0c36cf2 100644
--- a/src/openvpn/ssl_verif=
y_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -154,7 +154,7 @@
=
                     {
                         continue;
                 =
    }
-                    if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length=
(name->d=2Erfc822Name))
+                    if (strlen(buf) !=3D ASN1_STRI=
NG_get_length(name->d=2Erfc822Name))
                     {
               =
          msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero"=
);
                     }

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2087?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
Gerrit-Change-Number: 2087
=
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--bdDBc+0DM+s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2087?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Use ASN1_STRING_get_length instead=
 of ASN1_STRING_length<br><br>OpenSSL 4=2E1 introduced ASN1_STRING_get_leng=
th and at the same<br>time deprecated the ASN1_STRING_length method=2E Use =
the<br>new method and add a compat macro for older versions and<br>other Op=
enSSL like libraries=2E<br><br>Change-Id: I1bff3107f95b403d554bea4262c2dda2=
70a1fc79<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked=
-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2087<br>Message-Id: &lt;20261102141709=2E=
30018-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg40439=2Ehtml<br>Signed-off-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/opens=
sl_compat=2Eh<br>M src/openvpn/ssl_verify_openssl=2Ec<br>2 files changed, 6=
 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ope=
nssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><span>index 4305=
fea=2E=2E8309cee 100644</span><br><span>--- a/src/openvpn/openssl_compat=2E=
h</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span><br><span>@@ -=
204,4 +204,9 @@</span><br><span> #define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000=
000</span><br><span> #endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Introduced in OpenSSL 4=2E1=2E0 */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt;=
 0x40100000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
ASN1_STRING_get_length (size_t)ASN1_STRING_length</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> #endif /* OPENSSL_COMPAT_H_ */</span><br=
><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_ve=
rify_openssl=2Ec</span><br><span>index 146a384=2E=2E0c36cf2 100644</span><b=
r><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -154,7 +154,7 @@</span><b=
r><span>                     {</span><br><span>                         con=
tinue;</span><br><span>                     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    if ((ssize_t)strlen(buf) !=3D A=
SN1_STRING_length(name-&gt;d=2Erfc822Name))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    if (strlen(buf) !=3D ASN1_STRIN=
G_get_length(name-&gt;d=2Erfc822Name))</span><br><span>                    =
 {</span><br><span>                         msg(D_TLS_ERRORS, &quot;ASN1 ER=
ROR: string contained terminating zero&quot;);</span><br><span>            =
         }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2087?usp=3Demail">change 2087</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I1bff3107f95b403d554bea=
4262c2dda270a1fc79 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2087 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>

</body></html>
--bdDBc+0DM+s=--


--===============3164914470132273545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3164914470132273545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3164914470132273545==--

