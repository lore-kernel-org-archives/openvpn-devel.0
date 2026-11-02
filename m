Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B974606A335
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WyrM1htK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i6rRV3vt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WkuNtn1a;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RpQ3bmAa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s8yxw9j0kvdBUoXFJ7B0/UATT5JAoF+94UVLD/aX8Po=; b=WyrM1htKF2imuYkHMABPUUTgjx
	Xz43H0gT/JQf8F6//68GpFx3JeA5FMsNYnzneQQCJA79xzJM69bV4vEqUTHqVtcc13HKPlEHuSihT
	0+/jlv7Ag3XTldgV3mXOh0GU7esiutaubbMnmEyJF/l4s7OOArtZ7XvGG2+ZU9EcnuOg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqhV-000000005ru-3Qtp;
	Mon, 02 Nov 2026 11:59:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqhU-000000005rl-3di7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:59:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TDB/qCcm0QqJNS1soBMa6mgOy0T+ZQV8i1Y/s+g/Sc=; b=i6rRV3vt6g8inp4pnUvDfNphQi
 eoVCtnW7rgaUcm+lLLJ5TwLUbbyduk9GYsdkaCKFfggSabhmclCFMAzzAuA4engq994lsMeSf2Y9M
 qLFtlxnyIo5+Hpskgm9bIlWKtTRWRIpG+Fw4ChLFlGmkGgVadcT57qyG6k+aziFwTeJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TDB/qCcm0QqJNS1soBMa6mgOy0T+ZQV8i1Y/s+g/Sc=; b=WkuNtn1aUuzlQqCc2ZTdogqar7
 mTQEdkPcqXBM8zXHwwtti9m06btr0Pck8Ko55Ylq3FboEa5Io82WvgjC0mKQQZA2mEheVvXCZopz6
 A99FvDsDtcoou2tommOJgNwF6rrBRsQG4UlYgBsouy84a/tcYQ4DIvkwSQDdzi/DAHh0=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqhT-0000000068R-1tSb for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:59:44 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so3053078f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620777; x=1794225577; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4TDB/qCcm0QqJNS1soBMa6mgOy0T+ZQV8i1Y/s+g/Sc=;
 b=RpQ3bmAaoZO6XWIHV28Ux/lw5dg9DMApRNAaPT2GBTL12sU0JsWzoDOHiOPITwpu3J
 iR+gNF2jI66y+gvT4/P/YgmiD7wZzan0G+qLMtgafcOgPMBBWgSITA2wiOhMjYwQCkfQ
 gvxb3+/KlRVTb5sQi2B4vxb2yg6YEIpZpZRHtyuaqpCqXrKkjKW9GV9rXau6QKF64HSO
 Ocv5SN2B6Y3EIqXvFGRI6a5gtMqlFBZw88BkzkcuSTIDr9W4C9l3BaB7AePBytRLtbce
 PzxCbjGqIoL9lkNsVf9bUG31aLmu5hXnxdDsDGeoRG/emmfKTZ0GD7aoON1UIwRtbyx9
 8Ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620777; x=1794225577;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4TDB/qCcm0QqJNS1soBMa6mgOy0T+ZQV8i1Y/s+g/Sc=;
 b=zOnDnl3RRb8H8tdiU3R+reYrgZR0AQE9arVOQmmQkIROgYLlbgOgkREBGvBr63oKDs
 17FgcJS2+VG9An80Huwf1i2mHky7ARAqmEIs5hecVBWiUMpJ0uhs1hwWJ+MqZs/voOM/
 aPAIKyhsX6NsqAuEOSBpnFZcfqSPQg19ckS72WZYR96qy2Toxrft0yq8g6pND7ZwhE/d
 9Dun1P+SKi3cKeg5XGUt8BGcvK4c4KAvrddZAyLVdd9sF99EYKVGjSKg+iXYgZ4mP1Ul
 y/JR8OHOQJHsMcKjkSiFNTesKsZhr30vcukKv6AkV48g9W4RMGwUAm7BCUMom+NToGMv
 ymdA==
X-Gm-Message-State: APuU4Z/tcXLoUd+5BVYUV1Z2gQQVjiJivy44s3Emc1KO9oU4yvYyDGxb
 mLAb6Ns9T+ENMxcYNIkDo+UWk2qqe4LtI4xIzq75v+hOTxnB/eFvpAVStvWKAi1HTeE76qBqrx/
 UvAdqcQE/dLXGw7bb0TDjY627r6Qu9iyM9FMNxKmfWejJHwAsKl3ufOrCuX0wlE6+A7tzezxJIx
 mMDrYukw==
X-Gm-Gg: AYBFou2jQj35aUZwuw2rRs6TRCkbvUPevMzK8PLfNvKjRAoB0R4aKi2fBvcR5p4EWvp
 FAXGVYXZazj269G6LDOND+AxeqIN9D3k2vpuLEzwjDOmOUS99VVjCC9HD08nZFbRZk3NZkycFWM
 +anlL/goV/iAf7QNFoiTkwtRACFLSZFlRDqouaGf1K0/+tAl5VSxFQA/3USiCEBd++yuqpJ5PiT
 CCxVk6YoheF6jThthpPh8EaQMHkaahKKkah+GhyWhgnCzhFDe1KtyXLhzwdHdqoY2hQkPAF5CX9
 KpGumjHWMJ61kC704oFpGguHMWZurrmT16vhPhVAm2qO2Pkqi4EUcZKoMAmXn3rH24NKOGbjPv9
 0McyLEnaBCpjB8+0fVVN+AvyFYBo7MrW4mZhTKyocwJDSM2MD+8zGcUB+RVCRjEDLzwenlrU6+Z
 wCku1u9L/EPiayDHDEA0vzUOHAhGsnowzjVYyqze2yDefAlGsSdD0gGUx2yn/ZyLVBY1cSQGTG+
 DHHTG3wgVBOMQMlqD7axxNKMCWXqxLdBY4O4ZW0WZXPaLV2MY8Ipjp/E1DOD7uel+NaEv0nnMzR
 MUjkqU5aS9+Ac3D4vb6kOle/aYiYU3bu7J24l+AY5TWYIr9X5yG2tzuFYC4rs5reS4IzYJTdjvV
 Hl/vDyhAZXxLd+gPppQpRm2YbzsJlT1dTxoV3gzwYaMq9vc+1OzOlk52ej4TxK+9KSeIoCszY7b
 NeWihHflufpvAXxsOFUcaIA5l0ZmKqSwTkNhY=
X-Received: by 2002:a05:6000:4b05:b0:48e:2948:6fe3 with SMTP id
 ffacd0b85a97d-48e6e500957mr21843944f8f.39.1793620776781; 
 Mon, 02 Nov 2026 03:59:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8e5f4sm20220997f8f.40.2026.11.02.03.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:59:36 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:59:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
X-Gerrit-Change-Number: 2087
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2087?usp=email>
X-Gerrit-Commit: a040c414a2b6d67b7195bad487a0e08f3376ab7c
In-Reply-To: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
References: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIwNTY1MDAwLkkxYmZmMzEwN2Y5NWI0MDNkNTU0YmVhNDI2MmMyZGRhMjcwYTFmYzc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e887daed30ef66dc381da666167d481a72adf53-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNqhT-0000000068R-1tSb
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3444168184296182095=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3444168184296182095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8YuzBYk1bkg="; charset=UTF-8

--8YuzBYk1bkg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded a new patch set (#2)=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2087?usp=3Demail )


Change subject: Use ASN1_STRING_ge=
t_length instead of ASN1_STRING_length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Use ASN1_STRING_get_length instead of ASN1_STRING=
_length

OpenSSL 4=2E1 introduced ASN1_STRING_get_length and at the same
ti=
me deprecated the ASN1_STRING_length method=2E Use the
new method and keep =
and compat macro for older versions and
other OpenSSL like libraries=2E

Ch=
ange-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
Signed-off-by: Arne Schw=
abe <arne@rfc2549=2Eorg>
---
M src/openvpn/openssl_compat=2Eh
M src/openvpn=
/ssl_verify_openssl=2Ec
2 files changed, 6 insertions(+), 1 deletion(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/2087/2=


diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=
=2Eh
index 4305fea=2E=2E8309cee 100644
--- a/src/openvpn/openssl_compat=2Eh=

+++ b/src/openvpn/openssl_compat=2Eh
@@ -204,4 +204,9 @@
 #define EVP_CIPH=
_FLAG_ENC_THEN_MAC 0x10000000
 #endif
 
+/* Introduced in OpenSSL 4=2E1=2E0=
 */
+#if OPENSSL_VERSION_NUMBER < 0x40100000
+#define ASN1_STRING_get_lengt=
h (size_t)ASN1_STRING_length
+#endif
+
 #endif /* OPENSSL_COMPAT_H_ */
diff=
 --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openss=
l=2Ec
index 146a384=2E=2E0c36cf2 100644
--- a/src/openvpn/ssl_verify_openss=
l=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -154,7 +154,7 @@
        =
             {
                         continue;
                     }
- =
                   if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name->d=
=2Erfc822Name))
+                    if (strlen(buf) !=3D ASN1_STRING_get_l=
ength(name->d=2Erfc822Name))
                     {
                       =
  msg(D_TLS_ERRORS, "ASN1 ERROR: string contained terminating zero");
     =
                }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2087?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I1bff3107f95b403d554bea4262c2dda270a1fc79
Gerrit-Change-Number: 2087
Ger=
rit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8YuzBYk1bkg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Use ASN1_STRING_get_length instead of ASN1_STRING_length<br><=
br>OpenSSL 4=2E1 introduced ASN1_STRING_get_length and at the same<br>time =
deprecated the ASN1_STRING_length method=2E Use the<br>new method and keep =
and compat macro for older versions and<br>other OpenSSL like libraries=2E<=
br><br>Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79<br>Signed-off-b=
y: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/openssl_=
compat=2Eh<br>M src/openvpn/ssl_verify_openssl=2Ec<br>2 files changed, 6 in=
sertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/2087/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><=
span>index 4305fea=2E=2E8309cee 100644</span><br><span>--- a/src/openvpn/op=
enssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span=
><br><span>@@ -204,4 +204,9 @@</span><br><span> #define EVP_CIPH_FLAG_ENC_T=
HEN_MAC 0x10000000</span><br><span> #endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* Introduced in OpenSSL 4=2E1=2E0=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VERS=
ION_NUMBER &lt; 0x40100000</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define ASN1_STRING_get_length (size_t)ASN1_STRING_length</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* OPENSSL_COMPA=
T_H_ */</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/s=
rc/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 146a384=2E=2E0c36cf=
2 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec</span><br=
><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@ -154,7 +=
154,7 @@</span><br><span>                     {</span><br><span>           =
              continue;</span><br><span>                     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    if ((ssize_t)s=
trlen(buf) !=3D ASN1_STRING_length(name-&gt;d=2Erfc822Name))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    if (strlen(buf=
) !=3D ASN1_STRING_get_length(name-&gt;d=2Erfc822Name))</span><br><span>   =
                  {</span><br><span>                         msg(D_TLS_ERRO=
RS, &quot;ASN1 ERROR: string contained terminating zero&quot;);</span><br><=
span>                     }</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail">change 2087</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
bff3107f95b403d554bea4262c2dda270a1fc79 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2087 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--8YuzBYk1bkg=--


--===============3444168184296182095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3444168184296182095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3444168184296182095==--

