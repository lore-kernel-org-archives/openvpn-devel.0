Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB8606A885
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dbUUrOFg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DT3QxrwP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IdH2a8Wo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VN5N0Kbq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=cvQPkFUHfu9sVOHI9FpTBVQJh9gJVtd9eYj0yIwRXfE=; b=dbUUrOFg38ulJMrQwCtjJDNFD8
	BPzzg/tRgiohEcp+zIiVyYaF+QZ65HmbeRVX+0SWVUoE7vLYnFHdE3NoGGPwnOuJx0L8fvZAbs55u
	Ktj1PM6Inf2XsZCj/mK/D/kuYrMF6jKko2c5tSdPDKtUSdJ68gJwNav9OVK6hNosNJC4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRUv3-000000000EE-0GLT;
	Thu, 12 Nov 2026 13:32:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRUv1-000000000E7-0gbk
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d0tn6KJf4/GHWcuB8AI8AFYuKF7Mvw1PP+N8E+pVpFc=; b=DT3QxrwPZSjX7ofO5KVg/luOMS
 f3X6zao/lUFaCi/QWpg7ZO5Q0DJS5L8HXMdYsMp+z7KLAar1sFEkeUrm732Hu24g2+c6LbstGFEzk
 VrhegcoyvonDAYLZ5t3DlaEG+2fiukmDzX8xQbVY+My3aOY3xRHjkoUj8qcb9LfpwLyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d0tn6KJf4/GHWcuB8AI8AFYuKF7Mvw1PP+N8E+pVpFc=; b=IdH2a8WoU2hL7dMWGs/p5FdAoB
 zAr9lj0MQmB5KvGkGgQWX3oS47j1QZROOrSxtqDtZv3WuPRT2DrDLKu2uTGGNAL80m+nZd4lPY2sH
 Y2lxvPpHzQo3dtzfweiVaaoGWIKT7/glsh+ddQfj6P0uTZPIVXWDrx4R55YLUyfh8OKk=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRUuz-000000001aF-1kh4 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 13:32:47 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so2515189f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 05:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794490359; x=1795095159; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d0tn6KJf4/GHWcuB8AI8AFYuKF7Mvw1PP+N8E+pVpFc=;
 b=VN5N0KbqPfzXCWxrAVMJryV8O1rvjJ6JrEuwspASLTHv6irKnESshI5sdq1AkLGlfP
 FDHDZQa4KuuC1isr2I59IrrKC7xDNJTQUSqgqgJByGh3ytdsFXaGHEO5gL/Uvaxx+vQP
 Exn8JvgdkTlbRTzEXdPRqMvCGeFfX4wk7wwL9j2Njm/ZOS+HxUOMhA2L+YQUBrYRA9DZ
 RVgAzfR52B3QoavP3RwJWfOJRKMqBSNG+/5BOWzByCfK6K8n/l7NrUu6UHFw26aeJm/P
 7A/h16nfEgFOwu1vUVe8L/VuMjFUqOSqjWFGyCpsDnd1TwU5KIRHffCasCCckIFwoMWX
 ZyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794490359; x=1795095159;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d0tn6KJf4/GHWcuB8AI8AFYuKF7Mvw1PP+N8E+pVpFc=;
 b=M1306yW7JmAViwwbGkGM298jsoB4tKqvxdwyEI2Gudu9jT75pfPCG8WV+nEhpZrgRn
 OqBpiZSMeYDabqV4P8mnZE65WEBeDG5BLaDSFdPrlJj/vh1RmX0zIUoPJz7Ih53oMWly
 tu77Ietl8dDLf5A9qwcX+S5a/jqkymgVQWrD1CLbD0SAvG+jCZKfsabmbC+8fzN9gL/Q
 B342I9yz/Hl+9tRgkixedl7M7SgyRUSAooSuK2wOSQXc9Eye+rSec8fAalJ2uD6Ji6I8
 6irASpj17qA/z3R11wiwu+Oydac6RoY8DlvaQ/1Ev5UJPFNal/qsvqbrMgFs7T8k16gs
 XeMw==
X-Gm-Message-State: APuU4Z+HmkFUt+l0XwLzPZ0ER6dHHWuvxJWAIVCLRazZphZRX8Z86OAV
 7iVekMurHRfK/qM6hPmvtRgAo+xB+tECFJ+JUE+5uzX2K75QfCmy26BnSdH3tAgHo0uOOw5g5NW
 fL3P1LI0YnozhjcWL3ZopLBgylzOyUJB5yNTnybnRz4DodHaJLIKK0LyxN/9ADdp9K6Wqwz76MU
 eOMip8ig==
X-Gm-Gg: AYBFou2NZdyg8vITaX7A/lsOGdDoAzKqMnuvkLCfsV2SCxy006Ku5I5Bxh/XRoUx5ce
 uUzbCjQuEP161KYLIbbV6iROu3cb7RSHRUSD+FmvKOvrI4nzSlSKlw98chjD+NxIkbKqDteoIps
 gatuutqAs9SZ2Kx8rk4gdbhA3KGON2m7V92bPZsHDS5ckJ7Q/dXEk/ACImWfTQIacjVMwKN8Bbm
 N8f5hHCI0WAriSnXwq/7q1slnS+Dh/xaDtjl6BOHkdTo32uOG/ZriKQ/gbdEXQvhlPg4iKMebOL
 /tO3TQN5gy6ke73jrX9rMVdeBv663w7YOGQT1UGjUexqgu4bLJ9qAQWg/HMgmz4rxttY218PlXK
 JE5HZkvVbd483Y20NCiDzVZJsQBfXGxnGVmgZjD3HLwkyb/DZXwDuv9S+9diJEharoMINpFsGNR
 a7iy8hT2vK+ftS42aDjIjXChS9lm4kzFkZ2EpZsLSzFMgsEEmDMP8SRtu7uavLVLzXohjiW52aK
 hfB8SzwDFCu5cL0XCB1+8ZgpzMKkabylYKnOB0qBvSumtJxwQF9zt3ykRLgeZVYgt1P2Xpmicya
 r0qMm59h8zCT56KU3ulMrC0PmnTIq7rLsKWftntqGFUtr+Wz5dW40aluC/OhBH5prijaWNMlDAJ
 nfcPETm9c95+NwydBr0vx8VhJ3OZv7rQhx+Ho0i0ejP0dSzUxK8e7S9MSpKAe8qUyHzzZJj5l/2
 taJNPf4Af253iU4U4=
X-Received: by 2002:adf:e184:0:b0:491:d3b4:4e42 with SMTP id
 ffacd0b85a97d-499c8d5c362mr9435848f8f.52.1794490358672; 
 Thu, 12 Nov 2026 05:32:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4989a2a505asm14919203f8f.13.2026.11.12.05.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 05:32:38 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 13:32:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448
X-Gerrit-Change-Number: 2182
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2182?usp=email>
X-Gerrit-Commit: a315869e791d8c7063a885b93d8d03379792ea76
References: <gerrit.1794490356000.Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDkwMzU2MDAwLkllZmNmZDlmMjkyNDRkOWFlNmE1YTY4YjZlOWI1MDdiNTVlM2JmNDQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e5f8909618cf9b8cde7b84cba2ba4bd64b13f3d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRUuz-000000001aF-1kh4
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
Content-Type: multipart/mixed; boundary="===============5138921899389036739=="
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5138921899389036739==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1e6XqE3hY9o="; charset=UTF-8

--1e6XqE3hY9o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2182?usp=3Demail

to review the following change=2E
=


Change subject: mbedtls: print peer certificate details like the OpenSSL =
backend
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mbed=
tls: print peer certificate details like the OpenSSL backend

The OpenSSL b=
ackend logs the type, size and curve of the peer's
certificate key, and the=
 certificate signature algorithm=2E The mbed TLS
backend only logged the ke=
y size, which makes it harder to compare logs
of the two backends=2E

Print=
 the key type, curve and signature algorithm for mbed TLS too, using
the Op=
enSSL short names for the signature algorithms=2E

mbed TLS 4 no longer off=
ers functions to get curve or digest names, so
add the PSA curve family and=
 size to our --tls-groups table, and a reverse
lookup to the digest table=
=2E While at it, add secp256k1 to the groups table
(used by our EC sample k=
eys), which also makes it usable in --tls-groups=2E

Change-Id: Iefcfd9f292=
44d9ae6a5a68b6e9b507b55e3bf448
---
M src/openvpn/crypto_mbedtls=2Ec
M src/o=
penvpn/crypto_mbedtls=2Eh
M src/openvpn/ssl_mbedtls=2Ec
3 files changed, 10=
4 insertions(+), 14 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/82/2182/1

diff --git a/src/openvpn/crypto_mbed=
tls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0ea2375=2E=2E46207bc 100644
=
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@=
@ -648,6 +648,19 @@
     return NULL;
 }
 
+const char *
+md_name_from_psa_=
alg(psa_algorithm_t psa_alg)
+{
+    for (size_t i =3D 0; i < md_info_table=
_entries; i++)
+    {
+        if (md_info_table[i]=2Epsa_alg =3D=3D psa_al=
g)
+        {
+            return md_info_table[i]=2Ename;
+        }
+    =
}
+    return NULL;
+}
+
 bool
 md_valid(const char *digest)
 {
diff --git =
a/src/openvpn/crypto_mbedtls=2Eh b/src/openvpn/crypto_mbedtls=2Eh
index 5c3=
b670=2E=2Ee5f371a 100644
--- a/src/openvpn/crypto_mbedtls=2Eh
+++ b/src/ope=
nvpn/crypto_mbedtls=2Eh
@@ -111,6 +111,12 @@
 } hmac_ctx_t;
 
 /**
+ * Retu=
rn the OpenVPN name of the message digest \p psa_alg, or NULL if the
+ * di=
gest is not supported=2E
+ */
+const char *md_name_from_psa_alg(psa_algorit=
hm_t psa_alg);
+
+/**
  * Log the supplied mbed TLS error, prefixed by supp=
lied prefix=2E
  *
  * @param flags         Flags to indicate error type an=
d priority=2E
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mb=
edtls=2Ec
index 45d7715=2E=2Ece3b2af 100644
--- a/src/openvpn/ssl_mbedtls=
=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -51,6 +51,7 @@
 #include <mbedtls=
/net_sockets=2Eh>
 #include <mbedtls/oid=2Eh>
 #include <mbedtls/pem=2Eh>
+=
#include <mbedtls/psa_util=2Eh>
 #include <mbedtls/version=2Eh>
 
 static c=
onst mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =3D {
@@ -260=
,56 +261,61 @@
 {
     const char *name;
     uint16_t tls_id;
+    psa_ecc=
_family_t ecc_family; /* 0 for groups that are not elliptic curves */
+    =
size_t ecc_bits;
 } mbedtls_ecp_curve_info;
 
 static const mbedtls_ecp_cur=
ve_info ecp_curve_info_table[] =3D {
 /* secp curves=2E */
 #if defined(PSA=
_WANT_ECC_SECP_R1_256)
-    { "secp256r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP2=
56R1 },
+    { "secp256r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1, PSA_ECC_F=
AMILY_SECP_R1, 256 },
 #endif
 #if defined(PSA_WANT_ECC_SECP_R1_384)
-    {=
 "secp384r1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1 },
+    { "secp384r1", M=
BEDTLS_SSL_IANA_TLS_GROUP_SECP384R1, PSA_ECC_FAMILY_SECP_R1, 384 },
 #endif=

 #if defined(PSA_WANT_ECC_SECP_R1_521)
-    { "secp521r1", MBEDTLS_SSL_IAN=
A_TLS_GROUP_SECP521R1 },
+    { "secp521r1", MBEDTLS_SSL_IANA_TLS_GROUP_SEC=
P521R1, PSA_ECC_FAMILY_SECP_R1, 521 },
+#endif
+#if defined(PSA_WANT_ECC_SE=
CP_K1_256)
+    { "secp256k1", MBEDTLS_SSL_IANA_TLS_GROUP_SECP256K1, PSA_EC=
C_FAMILY_SECP_K1, 256 },
 #endif
 
 /* Curve25519=2E */
 #if defined(PSA_WA=
NT_ECC_MONTGOMERY_255)
-    { "X25519", MBEDTLS_SSL_IANA_TLS_GROUP_X25519 }=
,
+    { "X25519", MBEDTLS_SSL_IANA_TLS_GROUP_X25519, PSA_ECC_FAMILY_MONTGO=
MERY, 255 },
 #endif
 
 /* Curve448=2E */
 #if defined(PSA_WANT_ECC_MONTGOM=
ERY_448)
-    { "X448", MBEDTLS_SSL_IANA_TLS_GROUP_X448 },
+    { "X448", M=
BEDTLS_SSL_IANA_TLS_GROUP_X448, PSA_ECC_FAMILY_MONTGOMERY, 448 },
 #endif
 =

 /* Brainpool curves=2E */
 #if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_256)
-=
    { "brainpoolP256r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1 },
+    { "brai=
npoolP256r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1, PSA_ECC_FAMILY_BRAINPOOL_=
P_R1, 256 },
 #endif
 #if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_384)
-    { "=
brainpoolP384r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP384R1 },
+    { "brainpoolP3=
84r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP384R1, PSA_ECC_FAMILY_BRAINPOOL_P_R1, 3=
84 },
 #endif
 #if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_512)
-    { "brainpo=
olP512r1", MBEDTLS_SSL_IANA_TLS_GROUP_BP512R1 },
+    { "brainpoolP512r1", =
MBEDTLS_SSL_IANA_TLS_GROUP_BP512R1, PSA_ECC_FAMILY_BRAINPOOL_P_R1, 512 },
 =
#endif
 
 /* Named Diffie-Hellman groups=2E */
 #if defined(PSA_WANT_DH_RFC=
7919_2048)
-    { "ffdhe2048", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048 },
+   =
 { "ffdhe2048", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048, 0, 0 },
 #endif
 #if =
defined(PSA_WANT_DH_RFC7919_3072)
-    { "ffdhe3072", MBEDTLS_SSL_IANA_TLS_=
GROUP_FFDHE3072 },
+    { "ffdhe3072", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072=
, 0, 0 },
 #endif
 #if defined(PSA_WANT_DH_RFC7919_4096)
-    { "ffdhe4096"=
, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },
+    { "ffdhe4096", MBEDTLS_SSL_I=
ANA_TLS_GROUP_FFDHE4096, 0, 0 },
 #endif
 #if defined(PSA_WANT_DH_RFC7919_6=
144)
-    { "ffdhe6144", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144 },
+    { "ff=
dhe6144", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144, 0, 0 },
 #endif
 #if define=
d(PSA_WANT_DH_RFC7919_8192)
-    { "ffdhe8192", MBEDTLS_SSL_IANA_TLS_GROUP_=
FFDHE8192 },
+    { "ffdhe8192", MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192, 0, 0=
 },
 #endif
 };
 static const size_t ecp_curve_info_table_items =3D sizeof(=
ecp_curve_info_table) / sizeof(mbedtls_ecp_curve_info);
@@ -1194,6 +1200,71=
 @@
  * Print information for the end user=2E
  *
  ***********************=
****************/
+/**
+ * Return the name of the elliptic curve identified=
 by \p family and \p bits,
+ * or NULL if the curve is unknown=2E
+ */
+sta=
tic const char *
+get_ecc_curve_name(psa_ecc_family_t family, size_t bits)
=
+{
+    for (size_t i =3D 0; i < ecp_curve_info_table_items; i++)
+    {
+ =
       if (ecp_curve_info_table[i]=2Eecc_family =3D=3D family
+            =
&& ecp_curve_info_table[i]=2Eecc_bits =3D=3D bits)
+        {
+            =
return ecp_curve_info_table[i]=2Ename;
+        }
+    }
+    return NULL;
=
+}
+
+/**
+ * Print human readable information about the public key of \p c=
ert into
+ * \p buf, in the same format as the OpenSSL backend=2E
+ */
+sta=
tic void
+print_cert_details(const mbedtls_x509_crt *cert, char *buf, size_=
t buflen)
+{
+    size_t bits =3D mbedtls_pk_get_bitlen(&cert->pk);
+    ps=
a_key_type_t key_type =3D mbedtls_pk_get_key_type(&cert->pk);
+
+    char t=
ype[64] =3D "(error getting type)";
+    if (PSA_KEY_TYPE_IS_RSA(key_type))=

+    {
+        snprintf(type, sizeof(type), "RSA");
+    }
+    else if (=
PSA_KEY_TYPE_IS_ECC(key_type))
+    {
+        const char *curve =3D get_ec=
c_curve_name(PSA_KEY_TYPE_ECC_GET_FAMILY(key_type), bits);
+        snprint=
f(type, sizeof(type), "EC, curve %s", curve ? curve : "(unknown)");
+    }
=
+
+    /* Use the OpenSSL short names, to have the same output for both bac=
kends */
+    char sig[64] =3D { 0 };
+    const mbedtls_x509_buf no_sig_pa=
rams =3D { 0 };
+    mbedtls_md_type_t sig_md;
+    mbedtls_pk_sigalg_t sig=
_pk;
+    if (MBEDTLS_OID_CMP(MBEDTLS_OID_RSASSA_PSS, &cert->sig_oid) =3D=
=3D 0)
+    {
+        /* PSS parameters are not exposed, but OpenSSL omits=
 the hash too */
+        snprintf(sig, sizeof(sig), ", signature: RSASSA-P=
SS");
+    }
+    else if (mbedtls_x509_get_sig_alg(&cert->sig_oid, &no_sig=
_params, &sig_md, &sig_pk) =3D=3D 0)
+    {
+        const char *md_name =
=3D md_name_from_psa_alg(mbedtls_md_psa_alg_from_type(sig_md));
+        if=
 (sig_pk =3D=3D MBEDTLS_PK_SIGALG_RSA_PKCS1V15 && md_name)
+        {
+    =
        snprintf(sig, sizeof(sig), ", signature: RSA-%s", md_name);
+      =
  }
+        else if (sig_pk =3D=3D MBEDTLS_PK_SIGALG_ECDSA && md_name)
+  =
      {
+            snprintf(sig, sizeof(sig), ", signature: ecdsa-with-%s=
", md_name);
+        }
+    }
+
+    snprintf(buf, buflen, ", peer certifi=
cate: %zu bits %s%s", bits, type, sig);
+}
+
 void
 print_details(struct ke=
y_state_ssl *ks_ssl, const char *prefix)
 {
@@ -1208,7 +1279,7 @@
     cert=
 =3D mbedtls_ssl_get_peer_cert(ks_ssl->ctx);
     if (cert !=3D NULL)
     =
{
-        snprintf(s2, sizeof(s2), ", %u bit key", (unsigned int)mbedtls_p=
k_get_bitlen(&cert->pk));
+        print_cert_details(cert, s2, sizeof(s2))=
;
     }
 
     msg(D_HANDSHAKE, "%s%s", s1, s2);

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448
=
Gerrit-Change-Number: 2182
Gerrit-PatchSet: 1
Gerrit-Owner: Steffan Karger =
<steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--1e6XqE3hY9o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger would like Arn=
e Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">mbedtls: print peer certificate details like the OpenSSL back=
end<br><br>The OpenSSL backend logs the type, size and curve of the peer&#3=
9;s<br>certificate key, and the certificate signature algorithm=2E The mbed=
 TLS<br>backend only logged the key size, which makes it harder to compare =
logs<br>of the two backends=2E<br><br>Print the key type, curve and signatu=
re algorithm for mbed TLS too, using<br>the OpenSSL short names for the sig=
nature algorithms=2E<br><br>mbed TLS 4 no longer offers functions to get cu=
rve or digest names, so<br>add the PSA curve family and size to our --tls-g=
roups table, and a reverse<br>lookup to the digest table=2E While at it, ad=
d secp256k1 to the groups table<br>(used by our EC sample keys), which also=
 makes it usable in --tls-groups=2E<br><br>Change-Id: Iefcfd9f29244d9ae6a5a=
68b6e9b507b55e3bf448<br>---<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/op=
envpn/crypto_mbedtls=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br>3 files change=
d, 104 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/2182/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span>index 0ea2375=2E=2E46207bc 100644</span><br><span>--- a/src=
/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtl=
s=2Ec</span><br><span>@@ -648,6 +648,19 @@</span><br><span>     return NULL=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+const char *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+md_name_from_psa_alg(psa_algorithm_t psa_alg)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; md_info_table_entries; =
i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (md_info_table[i]=
=2Epsa_alg =3D=3D psa_alg)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return md_info_table[i]=2Ename;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</=
span><br><span> md_valid(const char *digest)</span><br><span> {</span><br><=
span>diff --git a/src/openvpn/crypto_mbedtls=2Eh b/src/openvpn/crypto_mbedt=
ls=2Eh</span><br><span>index 5c3b670=2E=2Ee5f371a 100644</span><br><span>--=
- a/src/openvpn/crypto_mbedtls=2Eh</span><br><span>+++ b/src/openvpn/crypto=
_mbedtls=2Eh</span><br><span>@@ -111,6 +111,12 @@</span><br><span> } hmac_c=
tx_t;</span><br><span> </span><br><span> /**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Return the OpenVPN name of the message digest \=
p psa_alg, or NULL if the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * digest is not supported=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
const char *md_name_from_psa_alg(psa_algorithm_t psa_alg);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span>  * Log the supplied mbed TLS error=
, prefixed by supplied prefix=2E</span><br><span>  *</span><br><span>  * @p=
aram flags         Flags to indicate error type and priority=2E</span><br><=
span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec=
</span><br><span>index 45d7715=2E=2Ece3b2af 100644</span><br><span>--- a/sr=
c/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec=
</span><br><span>@@ -51,6 +51,7 @@</span><br><span> #include &lt;mbedtls/ne=
t_sockets=2Eh&gt;</span><br><span> #include &lt;mbedtls/oid=2Eh&gt;</span><=
br><span> #include &lt;mbedtls/pem=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;mbedtls/psa_util=2Eh&gt;</span><br><spa=
n> #include &lt;mbedtls/version=2Eh&gt;</span><br><span> </span><br><span> =
static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =3D {=
</span><br><span>@@ -260,56 +261,61 @@</span><br><span> {</span><br><span> =
    const char *name;</span><br><span>     uint16_t tls_id;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    psa_ecc_family_t ecc_family; /*=
 0 for groups that are not elliptic curves */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    size_t ecc_bits;</span><br><span> } mbedtls_e=
cp_curve_info;</span><br><span> </span><br><span> static const mbedtls_ecp_=
curve_info ecp_curve_info_table[] =3D {</span><br><span> /* secp curves=2E =
*/</span><br><span> #if defined(PSA_WANT_ECC_SECP_R1_256)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    { &quot;secp256r1&quot;, MBEDTLS_SS=
L_IANA_TLS_GROUP_SECP256R1 },</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    { &quot;secp256r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP256R1=
, PSA_ECC_FAMILY_SECP_R1, 256 },</span><br><span> #endif</span><br><span> #=
if defined(PSA_WANT_ECC_SECP_R1_384)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    { &quot;secp384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP=
384R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot=
;secp384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP384R1, PSA_ECC_FAMILY_SECP=
_R1, 384 },</span><br><span> #endif</span><br><span> #if defined(PSA_WANT_E=
CC_SECP_R1_521)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { =
&quot;secp521r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP521R1 },</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    { &quot;secp521r1&quot;, MBE=
DTLS_SSL_IANA_TLS_GROUP_SECP521R1, PSA_ECC_FAMILY_SECP_R1, 521 },</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(PSA_WANT_ECC_SECP_K1_256)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;secp256k1&q=
uot;, MBEDTLS_SSL_IANA_TLS_GROUP_SECP256K1, PSA_ECC_FAMILY_SECP_K1, 256 },<=
/span><br><span> #endif</span><br><span> </span><br><span> /* Curve25519=2E=
 */</span><br><span> #if defined(PSA_WANT_ECC_MONTGOMERY_255)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    { &quot;X25519&quot;, MBEDTLS_S=
SL_IANA_TLS_GROUP_X25519 },</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    { &quot;X25519&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X25519, PSA_EC=
C_FAMILY_MONTGOMERY, 255 },</span><br><span> #endif</span><br><span> </span=
><br><span> /* Curve448=2E */</span><br><span> #if defined(PSA_WANT_ECC_MON=
TGOMERY_448)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &qu=
ot;X448&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_X448 },</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    { &quot;X448&quot;, MBEDTLS_SSL_IANA_TLS_=
GROUP_X448, PSA_ECC_FAMILY_MONTGOMERY, 448 },</span><br><span> #endif</span=
><br><span> </span><br><span> /* Brainpool curves=2E */</span><br><span> #i=
f defined(PSA_WANT_ECC_BRAINPOOL_P_R1_256)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    { &quot;brainpoolP256r1&quot;, MBEDTLS_SSL_IANA_TL=
S_GROUP_BP256R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   { &quot;brainpoolP256r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP256R1, PSA_E=
CC_FAMILY_BRAINPOOL_P_R1, 256 },</span><br><span> #endif</span><br><span> #=
if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_384)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    { &quot;brainpoolP384r1&quot;, MBEDTLS_SSL_IANA_T=
LS_GROUP_BP384R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    { &quot;brainpoolP384r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP384R1, PSA_=
ECC_FAMILY_BRAINPOOL_P_R1, 384 },</span><br><span> #endif</span><br><span> =
#if defined(PSA_WANT_ECC_BRAINPOOL_P_R1_512)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    { &quot;brainpoolP512r1&quot;, MBEDTLS_SSL_IANA_=
TLS_GROUP_BP512R1 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    { &quot;brainpoolP512r1&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_BP512R1, PSA=
_ECC_FAMILY_BRAINPOOL_P_R1, 512 },</span><br><span> #endif</span><br><span>=
 </span><br><span> /* Named Diffie-Hellman groups=2E */</span><br><span> #i=
f defined(PSA_WANT_DH_RFC7919_2048)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    { &quot;ffdhe2048&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE=
2048 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;=
ffdhe2048&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE2048, 0, 0 },</span><br><s=
pan> #endif</span><br><span> #if defined(PSA_WANT_DH_RFC7919_3072)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;ffdhe3072&quot;, M=
BEDTLS_SSL_IANA_TLS_GROUP_FFDHE3072 },</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    { &quot;ffdhe3072&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_=
FFDHE3072, 0, 0 },</span><br><span> #endif</span><br><span> #if defined(PSA=
_WANT_DH_RFC7919_4096)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    { &quot;ffdhe4096&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096 },</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdhe4096&quo=
t;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE4096, 0, 0 },</span><br><span> #endif</=
span><br><span> #if defined(PSA_WANT_DH_RFC7919_6144)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    { &quot;ffdhe6144&quot;, MBEDTLS_SSL_IA=
NA_TLS_GROUP_FFDHE6144 },</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    { &quot;ffdhe6144&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE6144, 0,=
 0 },</span><br><span> #endif</span><br><span> #if defined(PSA_WANT_DH_RFC7=
919_8192)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;=
ffdhe8192&quot;, MBEDTLS_SSL_IANA_TLS_GROUP_FFDHE8192 },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    { &quot;ffdhe8192&quot;, MBEDTLS_S=
SL_IANA_TLS_GROUP_FFDHE8192, 0, 0 },</span><br><span> #endif</span><br><spa=
n> };</span><br><span> static const size_t ecp_curve_info_table_items =3D s=
izeof(ecp_curve_info_table) / sizeof(mbedtls_ecp_curve_info);</span><br><sp=
an>@@ -1194,6 +1200,71 @@</span><br><span>  * Print information for the end=
 user=2E</span><br><span>  *</span><br><span>  ****************************=
***********/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the name of t=
he elliptic curve identified by \p family and \p bits,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * or NULL if the curve is unknown=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+get_ecc_curve_name(psa_ecc_family_t fa=
mily, size_t bits)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =
=3D 0; i &lt; ecp_curve_info_table_items; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (ecp_curve_info_table[i]=2Eecc_family =3D=3D family=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&a=
mp; ecp_curve_info_table[i]=2Eecc_bits =3D=3D bits)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return ecp_curve_info_table[i]=2Ename;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Print human readable i=
nformation about the public key of \p cert into</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * \p buf, in the same format as the OpenSSL ba=
ckend=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+print_cert_details(const mbedtls_x5=
09_crt *cert, char *buf, size_t buflen)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t bits =3D mbedtls_pk_get_bitlen(&amp;cert-&gt;pk);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    psa_key_type_t key_type =3D =
mbedtls_pk_get_key_type(&amp;cert-&gt;pk);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char type[64] =3D &quot;(error getting type)&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (PSA_KEY_TYPE_IS_RSA(key_typ=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(type, sizeof(=
type), &quot;RSA&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (PSA_KEY_TYPE_IS_ECC(key_type))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const char *curve =3D get_ecc_curve_name(PSA_KEY_TYPE_ECC_GET_FAMI=
LY(key_type), bits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        snprintf(type, sizeof(type), &quot;EC, curve %s&quot;, curve ? cur=
ve : &quot;(unknown)&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Use the OpenSSL s=
hort names, to have the same output for both backends */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char sig[64] =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const mbedtls_x509_buf no_=
sig_params =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    mbedtls_md_type_t sig_md;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mbedtls_pk_sigalg_t sig_pk;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (MBEDTLS_OID_CMP(MBEDTLS_OID_RSASSA_PSS, &am=
p;cert-&gt;sig_oid) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* PSS parameters are not exposed, but OpenSSL omits the hash too */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(sig, =
sizeof(sig), &quot;, signature: RSASSA-PSS&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (mbedtls_x509_get_sig_alg(&amp;cert-&gt;sig_oi=
d, &amp;no_sig_params, &amp;sig_md, &amp;sig_pk) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const char *md_name =3D md_name_from_psa_a=
lg(mbedtls_md_psa_alg_from_type(sig_md));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (sig_pk =3D=3D MBEDTLS_PK_SIGALG_RSA_PKCS1=
V15 &amp;&amp; md_name)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      snprintf(sig, sizeof(sig), &quot;, signature: RSA-%s&quot;, md_name);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (sig_pk =3D=
=3D MBEDTLS_PK_SIGALG_ECDSA &amp;&amp; md_name)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            snprintf(sig, sizeof(sig), &quot;, signature:=
 ecdsa-with-%s&quot;, md_name);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(buf, buflen, &quot=
;, peer certificate: %zu bits %s%s&quot;, bits, type, sig);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> void</span><br><span> print_details=
(struct key_state_ssl *ks_ssl, const char *prefix)</span><br><span> {</span=
><br><span>@@ -1208,7 +1279,7 @@</span><br><span>     cert =3D mbedtls_ssl_=
get_peer_cert(ks_ssl-&gt;ctx);</span><br><span>     if (cert !=3D NULL)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      snprintf(s2, sizeof(s2), &quot;, %u bit key&quot;, (unsigned int)mbed=
tls_pk_get_bitlen(&amp;cert-&gt;pk));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        print_cert_details(cert, s2, sizeof(s2));</span><=
br><span>     }</span><br><span> </span><br><span>     msg(D_HANDSHAKE, &qu=
ot;%s%s&quot;, s1, s2);</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail">change 2182</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefcfd9f29=
244d9ae6a5a68b6e9b507b55e3bf448 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2182 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffa=
n@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--1e6XqE3hY9o=--


--===============5138921899389036739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5138921899389036739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5138921899389036739==--

