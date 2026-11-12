Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D9606A897
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MwXB1c41;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LbZkldXq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TxXe0fGf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TKvL0aOi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rVulKRs/CFp4lkYwFs5WBGhIVSAZUo0Hzx0c5U5IWx8=; b=MwXB1c41MvT4ib6iAtL6qLKy7o
	/2DU7iYGB0aNLZXVC7VjxDsKdrwfmswK2rJuc3S0Z2EoLY4NnQXasMcAjrofMlsoTwEF2x04LgPsw
	/bYfyRditw2RaF8NTR0E3Y/b4vHbK/y1Qb2bDUugS4a7IPiB+A5+sY/3JcnCtYMtIZoU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRUww-000000000IH-1UDD;
	Thu, 12 Nov 2026 13:34:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRUwv-000000000IB-04Uj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUpvIlvBrEGpcABVfOGG8grURYl8m1G5QNbH/CEptUc=; b=LbZkldXqYA39x724vuDgwZHmyu
 Pe/HMvk826PGppOB0B6DY+VaLjSALja1amZnqk3Qx8gWplputYIz4BaLlHeiMRvOpLIAACYnxeytd
 LgEVxXu7+fqq3Vv8P2X1hQiFP3fs2ifYxDV59B1Rr/ahYmzg+KZGkvg7s2FGEI2Gr1Hs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jUpvIlvBrEGpcABVfOGG8grURYl8m1G5QNbH/CEptUc=; b=TxXe0fGfxc5A8EOvNUSc1sn4q8
 tKYF0li7yzHcsRtv8TNUllRqDrdwtPhWdxcBE9wQdpuLJmUXJ/Knb9bcce1jvJPUrPGjCNVOYcFxa
 bL4nbtVqal3jjiVGE2O3FYx1xSnMsoDC3H7i/oHakNdjrluMaxPUZF0YkNokIjQPpsS4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRUwt-000000001cu-1kyy for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:34:44 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso3117485f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 05:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794490477; x=1795095277; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jUpvIlvBrEGpcABVfOGG8grURYl8m1G5QNbH/CEptUc=;
 b=TKvL0aOieZlWGwgFB8oIBgw6CMQ8qUweb7bZJfgqYFAoTRpCI3i1Puwf2whM9Ra3IM
 Sri3yilSPpLW6GwqGaX/7BK5XtTgatnrotpxGDc++T/2VG/tA4emO4qvQCcZB5bumf6b
 mFg2QoR+sn2FecguofQlwhTv1wMM4y/khAqZD/WwbBgMYa5aPoZBR0PqXqfJZQnsymCI
 VBv9tVymBc+1iOCsq+nQ8DL8H+Hi/bDD4IzcpuqcXiQe3aurOE9gqCQ9+ttFfMCHBWvj
 RCdnXw6znNK+DWWAByNPXZgH5hYwl1yJu93KFr6Ji71nltMRXjAETGcvDBDok8jy0yrQ
 kgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490477; x=1795095277;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jUpvIlvBrEGpcABVfOGG8grURYl8m1G5QNbH/CEptUc=;
 b=SzLTzqmg4jBW6cRfeIoo2PSUsIrjxBaDjJ6ROZ/el61mQJ98tBRTo8ZZCPd/x4Puoj
 mUFmombcuec3fuiYLi+1w4KL1x5al1FHJANWkLqHvUL6yR7v7ShVbmmzJgC8XSWU2QdC
 9anb08QysBkKabwGpIfq6irwvZmYcLB2uDiQWVrwmatk248xxQXmczKE2Mb+SMSuHZ88
 Mf3Xu3iJ94oDUtangGo8OrYF4E2QrTIWsF6ioS6lZVEG6CPovvh+XCW+D5RUv1Mwnjbo
 DhAdebLmtPrLqzzZgPjiMuaheQjY04pNv3Rkk25ObzNEp77fvp5BS6t1Kd6icC/rGFf1
 H+zw==
X-Gm-Message-State: APuU4Z/sRC6TNliE+sTE0iPKTrw/3fa2YS/+3YgEnpiM3LDA/PYrFLex
 8dyu5Y1pePqln9Z55lvTLWMYfAA2KsMSKePL6F3Hw+YZyCFvXw2vJq2PfKpSLSd5nHdBxS9Npnh
 4EWjroy3COGJ0Krmt+YNZxmWoPQHu2WbOFmln66lcDYvdIRLEpknrk0oYAN1mXsNxj7iL
X-Gm-Gg: AYBFou0yeqj4rTw1nScqAA9yru9xSzNqo6ugk1Vkt3PioEZWzCuHgtvJDz2A0PvuFLx
 w2YMGGLN8by3Twa6vliJ0fTLGI/VYs8rWNZi19cKLECJIns8rTtbo2xh5T6Zir05YG65l+T55y2
 zGQZ6W3aqZ1KDwFcIsMhbMbqVjq2+bRr5OdRdR8lBlCr3SRiCF8S/V+8ofj/QfvKdtFIQtk2AOQ
 jUuQtFduknK9lOxaF4tqATo9yymit3Xzrx2KQxHHVAZRfkElG15sdim7FtIO4FbN3s4DeFwcd+9
 HTh9YDirBICevyu/FN1sLKvYOlmzd9KYZdkgYAIk3VyqWm1Tlt7H5EjVLKDuTqrC9njfRb7Uxyk
 FEdPrVh+yrkBS8rm0lWpzQVvGjT7qDj/WA90hHpCnT8SgO77ruRuXpp8x6GqRSrT0OnbplpWU0k
 BPF2IMPPeplPKZLkqROlR7/tds/f/kS0TcSDSczZ9ALxEFJw9irD7G8+L4EdBFP3dGseupPKr+F
 QdfSoWL7tZRlG8Q8N59mPmTBaOc0r9/pWyYHWqbMqVHAS7PYvZz+yW4HNwYzgnsJbZX+bjr3ybH
 k7BRXv0BlARLhF39RY2C/WykVVwI2bJ77dTnyygM6n/ZEFwOEUTaL25/+c1NY1dyc67JMsTvjVs
 WDfSF62jzwEtAQA9fw0KoUl08Vgy8sfM9xWVQGz7UQI/2UEP5ZD06wU/NdUAmhfsyXS2Xd0Om1/
 sSkl+qnqYFOSLGWuyn
X-Received: by 2002:a05:6000:98c:b0:48b:4a2:8175 with SMTP id
 ffacd0b85a97d-499c7271245mr10382221f8f.43.1794490476355; 
 Thu, 12 Nov 2026 05:34:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c4e07sm16015969f8f.49.2026.11.12.05.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 05:34:35 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 13:34:34 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448
X-Gerrit-Change-Number: 2182
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2182?usp=email>
X-Gerrit-Commit: 0a9a9b27bc1a2477fa608774c78096ac787ffaea
In-Reply-To: <gerrit.1794490356000.Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448@gerrit.openvpn.net>
References: <gerrit.1794490356000.Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDkwMzU2MDAwLkllZmNmZDlmMjkyNDRkOWFlNmE1YTY4YjZlOWI1MDdiNTVlM2JmNDQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <02aca49059ff9fa99019c7f1b4d721df67ce27f7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRUwt-000000001cu-1kyy
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbedtls: print peer
 certificate details like the OpenSSL backend
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
Content-Type: multipart/mixed; boundary="===============8407940557660182538=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8407940557660182538==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HqKlelE9Ds8="; charset=UTF-8

--HqKlelE9Ds8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2182?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: mbedtls: print peer certificate details like the Op=
enSSL backend
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


mbedtls: print peer certificate details like the OpenSSL backend

The Ope=
nSSL backend logs the type, size and curve of the peer's
certificate key, a=
nd the certificate signature algorithm=2E The mbed TLS
backend only logged =
the key size, which makes it harder to compare logs
of the two backends=2E
=

Print the key type, curve and signature algorithm for mbed TLS too, using
=
the OpenSSL short names for the signature algorithms=2E

mbed TLS 4 no long=
er offers functions to get curve or digest names, so
add the PSA curve fami=
ly and size to our --tls-groups table, and a reverse
lookup to the digest t=
able=2E While at it, add secp256k1 to the groups table
(used by our EC samp=
le keys), which also makes it usable in --tls-groups=2E

Change-Id: Iefcfd9=
f29244d9ae6a5a68b6e9b507b55e3bf448
Signed-off-by: Steffan Karger <steffan@k=
arger=2Eme>
---
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedt=
ls=2Eh
M src/openvpn/ssl_mbedtls=2Ec
3 files changed, 104 insertions(+), 14=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/82/2182/2

diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvp=
n/crypto_mbedtls=2Ec
index 0ea2375=2E=2E46207bc 100644
--- a/src/openvpn/cr=
ypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -648,6 +648,19 @@
=
     return NULL;
 }
 
+const char *
+md_name_from_psa_alg(psa_algorithm_t =
psa_alg)
+{
+    for (size_t i =3D 0; i < md_info_table_entries; i++)
+    =
{
+        if (md_info_table[i]=2Epsa_alg =3D=3D psa_alg)
+        {
+     =
       return md_info_table[i]=2Ename;
+        }
+    }
+    return NULL;
=
+}
+
 bool
 md_valid(const char *digest)
 {
diff --git a/src/openvpn/crypto=
_mbedtls=2Eh b/src/openvpn/crypto_mbedtls=2Eh
index 5c3b670=2E=2Ee5f371a 10=
0644
--- a/src/openvpn/crypto_mbedtls=2Eh
+++ b/src/openvpn/crypto_mbedtls=
=2Eh
@@ -111,6 +111,12 @@
 } hmac_ctx_t;
 
 /**
+ * Return the OpenVPN name=
 of the message digest \p psa_alg, or NULL if the
+ * digest is not support=
ed=2E
+ */
+const char *md_name_from_psa_alg(psa_algorithm_t psa_alg);
+
+/=
**
  * Log the supplied mbed TLS error, prefixed by supplied prefix=2E
  *
=
  * @param flags         Flags to indicate error type and priority=2E
diff =
--git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 45d=
7715=2E=2Ece3b2af 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvp=
n/ssl_mbedtls=2Ec
@@ -51,6 +51,7 @@
 #include <mbedtls/net_sockets=2Eh>
 #i=
nclude <mbedtls/oid=2Eh>
 #include <mbedtls/pem=2Eh>
+#include <mbedtls/psa=
_util=2Eh>
 #include <mbedtls/version=2Eh>
 
 static const mbedtls_x509_crt=
_profile openvpn_x509_crt_profile_legacy =3D {
@@ -260,56 +261,61 @@
 {
   =
  const char *name;
     uint16_t tls_id;
+    psa_ecc_family_t ecc_family;=
 /* 0 for groups that are not elliptic curves */
+    size_t ecc_bits;
 } m=
bedtls_ecp_curve_info;
 
 static const mbedtls_ecp_curve_info ecp_curve_inf=
o_table[] =3D {
 /* secp curves=2E */
 #if defined(PSA_WANT_ECC_SECP_R1_256=
)
-    { "secp256r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1 },
+    { "secp2=
56r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1, PSA_ECC_FAMILY_SECP_R1, 256 },=

 #endif
 #if defined(PSA_WANT_ECC_SECP_R1_384)
-    { "secp384r1", MBEDTLS=
_SSL_IANA_TLS_GROUP_SECP384R1 },
+    { "secp384r1", MBEDTLS_SSL_IANA_TLS_G=
ROUP_SECP384R1, PSA_ECC_FAMILY_SECP_R1, 384 },
 #endif
 #if defined(PSA_WAN=
T_ECC_SECP_R1_521)
-    { "secp521r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP521R1=
 },
+    { "secp521r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP521R1, PSA_ECC_FAMIL=
Y_SECP_R1, 521 },
+#endif
+#if defined(PSA_WANT_ECC_SECP_K1_256)
+    { "se=
cp256k1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256K1, PSA_ECC_FAMILY_SECP_K1, 256=
 },
 #endif
 
 /* Curve25519=2E */
 #if defined(PSA_WANT_ECC_MONTGOMERY_255=
)
-    { "X25519", MBEDTLS_SSL_IANA_TLS_GROUP_X25519 },
+    { "X25519", MB=
EDTLS_SSL_IANA_TLS_GROUP_X25519, PSA_ECC_FAMILY_MONTGOMERY, 255 },
 #endif
=
 
 /* Curve448=2E */
 #if defined(PSA_WANT_ECC_MONTGOMERY_448)
-    { "X448=
", MBEDTLS_SSL_IANA_TLS_GROUP_X448 },
+    { "X448", MBEDTLS_SSL_IANA_TLS_G=
ROUP_X448, PSA_ECC_FAMILY_MONTGOMERY, 448 },
 #endif
 
 /* Brainpool curves=
=2E */
 #if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_256)
-    { "brainpoolP256r=
1", MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1 },
+    { "brainpoolP256r1", MBEDTLS=
_SSL_IANA_TLS_GROUP_BP256R1, PSA_ECC_FAMILY_BRAINPOOL_P_R1, 256 },
 #endif
=
 #if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_384)
-    { "brainpoolP384r1", MBE=
DTLS_SSL_IANA_TLS_GROUP_BP384R1 },
+    { "brainpoolP384r1", MBEDTLS_SSL_IA=
NA_TLS_GROUP_BP384R1, PSA_ECC_FAMILY_BRAINPOOL_P_R1, 384 },
 #endif
 #if de=
fined(PSA_WANT_ECC_BRAINPOOL_P_R1_512)
-    { "brainpoolP512r1", MBEDTLS_SS=
L_IANA_TLS_GROUP_BP512R1 },
+    { "brainpoolP512r1", MBEDTLS_SSL_IANA_TLS_=
GROUP_BP512R1, PSA_ECC_FAMILY_BRAINPOOL_P_R1, 512 },
 #endif
 
 /* Named Di=
ffie-Hellman groups=2E */
 #if defined(PSA_WANT_DH_RFC7919_2048)
-    { "ff=
dhe2048", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048 },
+    { "ffdhe2048", MBEDT=
LS_SSL_IANA_TLS_GROUP_FFDHE2048, 0, 0 },
 #endif
 #if defined(PSA_WANT_DH_R=
FC7919_3072)
-    { "ffdhe3072", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072 },
+ =
   { "ffdhe3072", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072, 0, 0 },
 #endif
 #i=
f defined(PSA_WANT_DH_RFC7919_4096)
-    { "ffdhe4096", MBEDTLS_SSL_IANA_TL=
S_GROUP_FFDHE4096 },
+    { "ffdhe4096", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE40=
96, 0, 0 },
 #endif
 #if defined(PSA_WANT_DH_RFC7919_6144)
-    { "ffdhe614=
4", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144 },
+    { "ffdhe6144", MBEDTLS_SSL=
_IANA_TLS_GROUP_FFDHE6144, 0, 0 },
 #endif
 #if defined(PSA_WANT_DH_RFC7919=
_8192)
-    { "ffdhe8192", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192 },
+    { "=
ffdhe8192", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192, 0, 0 },
 #endif
 };
 stat=
ic const size_t ecp_curve_info_table_items =3D sizeof(ecp_curve_info_table)=
 / sizeof(mbedtls_ecp_curve_info);
@@ -1194,6 +1200,71 @@
  * Print informa=
tion for the end user=2E
  *
  ***************************************/
+/*=
*
+ * Return the name of the elliptic curve identified by \p family and \p =
bits,
+ * or NULL if the curve is unknown=2E
+ */
+static const char *
+get=
_ecc_curve_name(psa_ecc_family_t family, size_t bits)
+{
+    for (size_t i=
 =3D 0; i < ecp_curve_info_table_items; i++)
+    {
+        if (ecp_curve_=
info_table[i]=2Eecc_family =3D=3D family
+            && ecp_curve_info_tab=
le[i]=2Eecc_bits =3D=3D bits)
+        {
+            return ecp_curve_info=
_table[i]=2Ename;
+        }
+    }
+    return NULL;
+}
+
+/**
+ * Print h=
uman readable information about the public key of \p cert into
+ * \p buf, =
in the same format as the OpenSSL backend=2E
+ */
+static void
+print_cert_=
details(const mbedtls_x509_crt *cert, char *buf, size_t buflen)
+{
+    siz=
e_t bits =3D mbedtls_pk_get_bitlen(&cert->pk);
+    psa_key_type_t key_type=
 =3D mbedtls_pk_get_key_type(&cert->pk);
+
+    char type[64] =3D "(error g=
etting type)";
+    if (PSA_KEY_TYPE_IS_RSA(key_type))
+    {
+        snpr=
intf(type, sizeof(type), "RSA");
+    }
+    else if (PSA_KEY_TYPE_IS_ECC(k=
ey_type))
+    {
+        const char *curve =3D get_ecc_curve_name(PSA_KEY_=
TYPE_ECC_GET_FAMILY(key_type), bits);
+        snprintf(type, sizeof(type),=
 "EC, curve %s", curve ? curve : "(unknown)");
+    }
+
+    /* Use the Ope=
nSSL short names, to have the same output for both backends */
+    char si=
g[64] =3D { 0 };
+    const mbedtls_x509_buf no_sig_params =3D { 0 };
+    =
mbedtls_md_type_t sig_md;
+    mbedtls_pk_sigalg_t sig_pk;
+    if (MBEDTLS=
_OID_CMP(MBEDTLS_OID_RSASSA_PSS, &cert->sig_oid) =3D=3D 0)
+    {
+        =
/* PSS parameters are not exposed, but OpenSSL omits the hash too */
+     =
   snprintf(sig, sizeof(sig), ", signature: RSASSA-PSS");
+    }
+    else =
if (mbedtls_x509_get_sig_alg(&cert->sig_oid, &no_sig_params, &sig_md, &sig_=
pk) =3D=3D 0)
+    {
+        const char *md_name =3D md_name_from_psa_alg(=
mbedtls_md_psa_alg_from_type(sig_md));
+        if (sig_pk =3D=3D MBEDTLS_P=
K_SIGALG_RSA_PKCS1V15 && md_name)
+        {
+            snprintf(sig, siz=
eof(sig), ", signature: RSA-%s", md_name);
+        }
+        else if (sig=
_pk =3D=3D MBEDTLS_PK_SIGALG_ECDSA && md_name)
+        {
+            snpr=
intf(sig, sizeof(sig), ", signature: ecdsa-with-%s", md_name);
+        }
+=
    }
+
+    snprintf(buf, buflen, ", peer certificate: %zu bits %s%s", bit=
s, type, sig);
+}
+
 void
 print_details(struct key_state_ssl *ks_ssl, cons=
t char *prefix)
 {
@@ -1208,7 +1279,7 @@
     cert =3D mbedtls_ssl_get_peer=
_cert(ks_ssl->ctx);
     if (cert !=3D NULL)
     {
-        snprintf(s2, s=
izeof(s2), ", %u bit key", (unsigned int)mbedtls_pk_get_bitlen(&cert->pk));=

+        print_cert_details(cert, s2, sizeof(s2));
     }
 
     msg(D_HAN=
DSHAKE, "%s%s", s1, s2);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2182?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448
Gerrit-Change-Number: 2=
182
Gerrit-PatchSet: 2
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>

--HqKlelE9Ds8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger <strong>upload=
ed patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">mbedtls: print peer certificate details like the OpenSSL backend<br><b=
r>The OpenSSL backend logs the type, size and curve of the peer&#39;s<br>ce=
rtificate key, and the certificate signature algorithm=2E The mbed TLS<br>b=
ackend only logged the key size, which makes it harder to compare logs<br>o=
f the two backends=2E<br><br>Print the key type, curve and signature algori=
thm for mbed TLS too, using<br>the OpenSSL short names for the signature al=
gorithms=2E<br><br>mbed TLS 4 no longer offers functions to get curve or di=
gest names, so<br>add the PSA curve family and size to our --tls-groups tab=
le, and a reverse<br>lookup to the digest table=2E While at it, add secp256=
k1 to the groups table<br>(used by our EC sample keys), which also makes it=
 usable in --tls-groups=2E<br><br>Change-Id: Iefcfd9f29244d9ae6a5a68b6e9b50=
7b55e3bf448<br>Signed-off-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br=
>---<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls=2E=
h<br>M src/openvpn/ssl_mbedtls=2Ec<br>3 files changed, 104 insertions(+), 1=
4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/82/2182/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index=
 0ea2375=2E=2E46207bc 100644</span><br><span>--- a/src/openvpn/crypto_mbedt=
ls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span=
>@@ -648,6 +648,19 @@</span><br><span>     return NULL;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+md_name_f=
rom_psa_alg(psa_algorithm_t psa_alg)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (size_t i =3D 0; i &lt; md_info_table_entries; i++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (md_info_table[i]=2Epsa_alg =3D=3D psa_=
alg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return md_inf=
o_table[i]=2Ename;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> md_val=
id(const char *digest)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/crypto_mbedtls=2Eh b/src/openvpn/crypto_mbedtls=2Eh</span><br><span=
>index 5c3b670=2E=2Ee5f371a 100644</span><br><span>--- a/src/openvpn/crypto=
_mbedtls=2Eh</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Eh</span><br=
><span>@@ -111,6 +111,12 @@</span><br><span> } hmac_ctx_t;</span><br><span>=
 </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Return the OpenVPN name of the message digest \p psa_alg, or NULL if =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * digest is not=
 supported=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *md_name_fr=
om_psa_alg(psa_algorithm_t psa_alg);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span>  * Log the supplied mbed TLS error, prefixed by supplied=
 prefix=2E</span><br><span>  *</span><br><span>  * @param flags         Fla=
gs to indicate error type and priority=2E</span><br><span>diff --git a/src/=
openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index=
 45d7715=2E=2Ece3b2af 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -=
51,6 +51,7 @@</span><br><span> #include &lt;mbedtls/net_sockets=2Eh&gt;</sp=
an><br><span> #include &lt;mbedtls/oid=2Eh&gt;</span><br><span> #include &l=
t;mbedtls/pem=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;mbedtls/psa_util=2Eh&gt;</span><br><span> #include &lt;mbedt=
ls/version=2Eh&gt;</span><br><span> </span><br><span> static const mbedtls_=
x509_crt_profile openvpn_x509_crt_profile_legacy =3D {</span><br><span>@@ -=
260,56 +261,61 @@</span><br><span> {</span><br><span>     const char *name;=
</span><br><span>     uint16_t tls_id;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    psa_ecc_family_t ecc_family; /* 0 for groups that ar=
e not elliptic curves */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    size_t ecc_bits;</span><br><span> } mbedtls_ecp_curve_info;</span>=
<br><span> </span><br><span> static const mbedtls_ecp_curve_info ecp_curve_=
info_table[] =3D {</span><br><span> /* secp curves=2E */</span><br><span> #=
if defined(PSA_WANT_ECC_SECP_R1_256)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    { &quot;secp256r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP=
256R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot=
;secp256r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1, PSA_ECC_FAMILY_SECP=
_R1, 256 },</span><br><span> #endif</span><br><span> #if defined(PSA_WANT_E=
CC_SECP_R1_384)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { =
&quot;secp384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1 },</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    { &quot;secp384r1&quot;, MBE=
DTLS_SSL_IANA_TLS_GROUP_SECP384R1, PSA_ECC_FAMILY_SECP_R1, 384 },</span><br=
><span> #endif</span><br><span> #if defined(PSA_WANT_ECC_SECP_R1_521)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;secp521r1&quot;=
, MBEDTLS_SSL_IANA_TLS_GROUP_SECP521R1 },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    { &quot;secp521r1&quot;, MBEDTLS_SSL_IANA_TLS_GRO=
UP_SECP521R1, PSA_ECC_FAMILY_SECP_R1, 521 },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(PSA_WANT_ECC_SECP_K1_256)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    { &quot;secp256k1&quot;, MBEDTLS_SSL_IANA=
_TLS_GROUP_SECP256K1, PSA_ECC_FAMILY_SECP_K1, 256 },</span><br><span> #endi=
f</span><br><span> </span><br><span> /* Curve25519=2E */</span><br><span> #=
if defined(PSA_WANT_ECC_MONTGOMERY_255)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    { &quot;X25519&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X255=
19 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;X2=
5519&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X25519, PSA_ECC_FAMILY_MONTGOMERY, 2=
55 },</span><br><span> #endif</span><br><span> </span><br><span> /* Curve44=
8=2E */</span><br><span> #if defined(PSA_WANT_ECC_MONTGOMERY_448)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;X448&quot;, MBEDTLS=
_SSL_IANA_TLS_GROUP_X448 },</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    { &quot;X448&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X448, PSA_ECC_FA=
MILY_MONTGOMERY, 448 },</span><br><span> #endif</span><br><span> </span><br=
><span> /* Brainpool curves=2E */</span><br><span> #if defined(PSA_WANT_ECC=
_BRAINPOOL_P_R1_256)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   { &quot;brainpoolP256r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1 },</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;brainpoolP2=
56r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1, PSA_ECC_FAMILY_BRAINPOOL_P_=
R1, 256 },</span><br><span> #endif</span><br><span> #if defined(PSA_WANT_EC=
C_BRAINPOOL_P_R1_384)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    { &quot;brainpoolP384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP384R1 },</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;brainpoolP=
384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP384R1, PSA_ECC_FAMILY_BRAINPOOL_P=
_R1, 384 },</span><br><span> #endif</span><br><span> #if defined(PSA_WANT_E=
CC_BRAINPOOL_P_R1_512)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    { &quot;brainpoolP512r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP512R1 },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;brainpool=
P512r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP512R1, PSA_ECC_FAMILY_BRAINPOOL_=
P_R1, 512 },</span><br><span> #endif</span><br><span> </span><br><span> /* =
Named Diffie-Hellman groups=2E */</span><br><span> #if defined(PSA_WANT_DH_=
RFC7919_2048)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &q=
uot;ffdhe2048&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048 },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdhe2048&quot;, MBEDT=
LS_SSL_IANA_TLS_GROUP_FFDHE2048, 0, 0 },</span><br><span> #endif</span><br>=
<span> #if defined(PSA_WANT_DH_RFC7919_3072)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    { &quot;ffdhe3072&quot;, MBEDTLS_SSL_IANA_TLS_GR=
OUP_FFDHE3072 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 { &quot;ffdhe3072&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072, 0, 0 },</sp=
an><br><span> #endif</span><br><span> #if defined(PSA_WANT_DH_RFC7919_4096)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;ffdhe4096=
&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    { &quot;ffdhe4096&quot;, MBEDTLS_SSL_IANA_T=
LS_GROUP_FFDHE4096, 0, 0 },</span><br><span> #endif</span><br><span> #if de=
fined(PSA_WANT_DH_RFC7919_6144)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    { &quot;ffdhe6144&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144=
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdh=
e6144&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144, 0, 0 },</span><br><span>=
 #endif</span><br><span> #if defined(PSA_WANT_DH_RFC7919_8192)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    { &quot;ffdhe8192&quot;, MBEDT=
LS_SSL_IANA_TLS_GROUP_FFDHE8192 },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    { &quot;ffdhe8192&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDH=
E8192, 0, 0 },</span><br><span> #endif</span><br><span> };</span><br><span>=
 static const size_t ecp_curve_info_table_items =3D sizeof(ecp_curve_info_t=
able) / sizeof(mbedtls_ecp_curve_info);</span><br><span>@@ -1194,6 +1200,71=
 @@</span><br><span>  * Print information for the end user=2E</span><br><sp=
an>  *</span><br><span>  ***************************************/</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Return the name of the elliptic curve iden=
tified by \p family and \p bits,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * or NULL if the curve is unknown=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+get_ecc_curve_name(psa_ecc_family_t family, size_t bits)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; ecp_curve=
_info_table_items; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (ecp_curve_info_table[i]=2Eecc_family =3D=3D family</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; ecp_curve_info_tab=
le[i]=2Eecc_bits =3D=3D bits)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return ecp_curve_info_table[i]=2Ename;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Print human readable information about the pub=
lic key of \p cert into</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * \p buf, in the same format as the OpenSSL backend=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+print_cert_details(const mbedtls_x509_crt *cert, char *buf,=
 size_t buflen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t bits =3D mb=
edtls_pk_get_bitlen(&amp;cert-&gt;pk);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    psa_key_type_t key_type =3D mbedtls_pk_get_key_type(=
&amp;cert-&gt;pk);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char type[64] =
=3D &quot;(error getting type)&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (PSA_KEY_TYPE_IS_RSA(key_type))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        snprintf(type, sizeof(type), &quot;RSA&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (PSA_KEY_TYPE_IS_EC=
C(key_type))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *c=
urve =3D get_ecc_curve_name(PSA_KEY_TYPE_ECC_GET_FAMILY(key_type), bits);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(type=
, sizeof(type), &quot;EC, curve %s&quot;, curve ? curve : &quot;(unknown)&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* Use the OpenSSL short names, to have th=
e same output for both backends */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char sig[64] =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const mbedtls_x509_buf no_sig_params =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_md_type_=
t sig_md;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtl=
s_pk_sigalg_t sig_pk;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (MBEDTLS_OID_CMP(MBEDTLS_OID_RSASSA_PSS, &amp;cert-&gt;sig_oid) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* PSS parameter=
s are not exposed, but OpenSSL omits the hash too */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        snprintf(sig, sizeof(sig), &quot;=
, signature: RSASSA-PSS&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (mbedtls_x509_get_sig_alg(&amp;cert-&gt;sig_oid, &amp;no_sig_para=
ms, &amp;sig_md, &amp;sig_pk) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const char *md_name =3D md_name_from_psa_alg(mbedtls_md_psa_a=
lg_from_type(sig_md));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (sig_pk =3D=3D MBEDTLS_PK_SIGALG_RSA_PKCS1V15 &amp;&amp; md_n=
ame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            snprintf(sig,=
 sizeof(sig), &quot;, signature: RSA-%s&quot;, md_name);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        else if (sig_pk =3D=3D MBEDTLS_PK_SIGALG=
_ECDSA &amp;&amp; md_name)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         snprintf(sig, sizeof(sig), &quot;, signature: ecdsa-with-%s&quot;,=
 md_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    snprintf(buf, buflen, &quot;, peer certificate: =
%zu bits %s%s&quot;, bits, type, sig);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> void</span><br><span> print_details(struct key_state_ssl=
 *ks_ssl, const char *prefix)</span><br><span> {</span><br><span>@@ -1208,7=
 +1279,7 @@</span><br><span>     cert =3D mbedtls_ssl_get_peer_cert(ks_ssl-=
&gt;ctx);</span><br><span>     if (cert !=3D NULL)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        snprintf(s2, si=
zeof(s2), &quot;, %u bit key&quot;, (unsigned int)mbedtls_pk_get_bitlen(&am=
p;cert-&gt;pk));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     print_cert_details(cert, s2, sizeof(s2));</span><br><span>     }</span=
><br><span> </span><br><span>     msg(D_HANDSHAKE, &quot;%s%s&quot;, s1, s2=
);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2182?usp=3Demail">change 2182</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Iefcfd9f29244d9ae6a5a68b6e9b5=
07b55e3bf448 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2182=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=2Eme&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>

</body></html>
--HqKlelE9Ds8=--


--===============8407940557660182538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8407940557660182538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8407940557660182538==--

