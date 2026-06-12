Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F07CD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8kXROIo791XafiEP/4J00Gi9WKx4EKsW9iqEWBl418=; b=bbFBn0YwnZemVkEJGNISgmTSeS
	LVIcXKmOl2SAWw41rJhyyH+UZMt5KGoz43BrhiMsPxwqnv1u6c0qra5IA+7F4bjtRBr97jUInNupX
	HSQOrDbBmRAh2h87B1jrxkSlg/otggyuieMRwomCss4TMcDHSqjuPYm0fF3vzkStAnQc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXxVO-0005RB-BZ;
	Fri, 12 Jun 2026 08:44:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXxVC-0005MD-VY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q/gh8yStmJaaN81eUE3FoKJkvNdebWlOv6DE+5Jodk0=; b=BZ8aThdMlBLpnOXPc2WD8qxht8
 ieu2uxJrRCRU5oYhoQKGYTfo3kaLmE+CWhXDWjZ3zknLxumIvjxkbSDlU/br6bs+ak37VgPj9Tb7i
 0IpiJwP2OsMVvQNnYE/JWxrB8BK6M9neiHOgicvkgvtUNmmdOL+61sJ6phe3Z2Nf5jo4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q/gh8yStmJaaN81eUE3FoKJkvNdebWlOv6DE+5Jodk0=; b=F
 VLo+LD5bh5yDyLoWeGQVCheVSBHZ8y3XHs6LbcZuUzc/MWCLI4rsnF/+Ez1eYzFsuBODRYJoenGpi
 LuRdNm0N8dw09UliYPaKgPwfgDy6u6zrM5G4AEvyYpllzshMvtivZTHWQxI4OgoKRrG7CIMpn65Lp
 COR0rNkHkyPGwJoc=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXxV8-0006Xi-3w for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:44:32 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so360427f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 01:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781253864; x=1781858664; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q/gh8yStmJaaN81eUE3FoKJkvNdebWlOv6DE+5Jodk0=;
 b=bmIrfsKTPrOX3xuJhh0H0jCOmKIWdH6DADn3iB88/cjw5pxsJZd5r3bhOH5OifXONg
 QeI2XP6YKmqdwCarX33j0UQ/ZNrI8txakWt6RnQW7WpuXrwMJDXtK7VM3RLugoKALXdr
 QYLNOE4fdlr8k27P+X4HbPA5U/hleK0WQaDbdPmjShGRJu6QgPGZKQKg40nEflzMoCeU
 qSC2q+EVdmyC93OePVBSwEIH8h4+fW30OSEDmxgD+3mA22EYqqmfV/HJ4mHua1Zap+Xn
 56E9hG9rZ4UJYAFc1CWsIn7ipLmxRxXprKU1+2M4nKTwyUUTBZ074rBBXz43eOgZVSyu
 Otqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781253864; x=1781858664;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/gh8yStmJaaN81eUE3FoKJkvNdebWlOv6DE+5Jodk0=;
 b=IwDLxxukqkInoDXORDw28GHW4JyfLdp09tB8H1mLr7wASuud8ZOKJz2F835DvvTc7a
 LRXRyDKU/GFCYIVRS5sm6A+g6KOjhNgkIxPdj4fhkBcKuhYmhdXdBOtQ2SLdiWzPcXm1
 PzRMbaBRaip775NSqePfUClz4+J4kGWbGR3O6201wVLtl6tIy9IEO4x7o9Fjq7sX9EJc
 ECkbEjULqk5mNlaqIb+RtWV/6eF6IpSCf14nAFLxS5J/7AgHXqF19DOjX4NNEn5rdu0a
 qbIo4vFz5c8DEmEOR/mwZUmcXnDSfZvAwZi6YBpCb4uB6Mz5+1E07+JFXMTDi79FyJ1r
 JJSQ==
X-Gm-Message-State: AOJu0YxApm8jX4ygyDsumZwKfTXr+ahcF5BhyFyNNF9qydZqgZJx6n7c
 GOxdkgdJCnpwoHe30NzFuK+p/Z8jXUpZdmaXOr8W5tVK7x2rL0VPTQwr50Qyo5CB0zfUx1+xWjv
 Et6HemOw3BBlfHTm69bE5H33NGvidYD3A2EAJZhz7PjcR5T2Hq1K31gosknoE+nrvLbJ1
X-Gm-Gg: Acq92OEeVYKWQmW8hNHS/a8e9gMJHLzh8mRW2Yx+5zK2AJCjSlm2ZIuZFSjj91HQYnh
 uXbB7zT5Lc8Pyomq9B9f6sPBfS8erxweZdQqR6+ZYgS73lrW2TmNfDlbB7PiMWIvikYlPqE8B0J
 iTQPHrhoq0csmY+UDvWz4hbv2gw5+YR3EdErkNjHKL90/domMIhLjcYMMyK2Tc45ENUWVfxU4TF
 YqTz6MjquweekFeoWVAVtxsqo+Wt5L0tTi2Fvpsq7DuUTPCJ1lNLLeb/Ez4Wm/jdXb39GNu04SX
 YhdpB+B/n6wDx5WvsOsFibNTIdYZKsFl0+hIhHWon0gflw1Sl+MJqRk4rGxxtt15PcBTARC1dQ4
 0wc4JWh+zsMmau44Vs3+WtN8k2wOjz9G1vNuba5SMl8bDbs3wYuyj4/tRucl19DOS6/1r6VjEQz
 /qfS28i0XwLZpEpu+xP181BSu2MAN4kCRKzGnSesxCHs3+DNTg1bReQHMZ7iViGrqVzPZJEWT2g
 3pOlYgTeVGPNyeehlBaTZp3UMSxy4FfKKjr31V+lsPFmUjV3+7rjGkIiPlf8MJYZRgcc7uEF6KT
 Z5VzklmUOMBivw==
X-Received: by 2002:a05:600c:3209:b0:490:b115:e03f with SMTP id
 5b1f17b1804b1-490ec4d65b4mr13384665e9.8.1781253863827; 
 Fri, 12 Jun 2026 01:44:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2cf5537sm159160215e9.9.2026.06.12.01.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:44:23 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 08:44:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88254e985d67234d827b92908079795df23daf20
X-Gerrit-Change-Number: 1637
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1637?usp=email>
X-Gerrit-Commit: fe72bbec92decbf15984163bc7852f8e6dab7de7
In-Reply-To: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
References: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2ODY0MDY1MDAwLkk4ODI1NGU5ODVkNjcyMzRkODI3YjkyOTA4MDc5Nzk1ZGYyM2RhZjIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d29d412a0a5c451cfd50d05b59f03f55c87f8d8d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXxV8-0006Xi-3w
Subject: [Openvpn-devel] [S] Change in openvpn[master]: AWS-LC: Add casts
 and openssl_opt_t typdef to allow AWS-LC with -Werror
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1787817461512126444=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1787817461512126444==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="paTXb/1FQao="; charset=UTF-8

--paTXb/1FQao=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: AWS-LC: Add casts and openssl_opt_t typdef t=
o allow AWS-LC with -Werror
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

AWS-LC: Add casts and openssl_opt_t typdef to allow AWS-LC=
 with -Werror

Change-Id: I88254e985d67234d827b92908079795df23daf20
Signed-=
off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1637
Message-Id: <20260609155226=2E30827-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg37145=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M =2Egithub/workflows/build=2Eyaml
M src/openvpn/crypto_openssl=2Ec
M=
 src/openvpn/openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
M src/openvpn=
/ssl_verify_openssl=2Ec
5 files changed, 16 insertions(+), 12 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/163=
7/2

diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/bu=
ild=2Eyaml
index 4cab0ac=2E=2E29e8be2a 100644
--- a/=2Egithub/workflows/bui=
ld=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -381,6 +381,4 @@
      =
 gitref: v5=2E0=2E0
       libconfigure: cmake -B build -GNinja -DCMAKE_BUI=
LD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=
=3D1
       libmake: cmake --build build
-      libinstall: sudo cmake --in=
stall build
-      # not ready for --enable-werror
-      ovpnconfigureflag=
s:
+      libinstall: sudo cmake --install build
\ No newline at end of fil=
e
diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=
=2Ec
index c11cfd8=2E=2Efa9eb67 100644
--- a/src/openvpn/crypto_openssl=2Ec=

+++ b/src/openvpn/crypto_openssl=2Ec
@@ -425,7 +425,7 @@
 print_digest(EVP=
_MD *digest, void *unused)
 {
     printf("%s %d bit digest size\n", md_kt_=
name(EVP_MD_get0_name(digest)),
-           EVP_MD_size(digest) * 8);
+    =
       (int)EVP_MD_size(digest) * 8);
 }
 
 void
@@ -1025,7 +1025,7 @@
    =
                "Message hash algorithm '%s' uses a default hash "
        =
            "size (%d bytes) which is larger than " PACKAGE_NAME "'s curren=
t "
                    "maximum hash size (%d bytes)",
-                  =
 digest, EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
+                   digest,=
 (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
     }
     return md;
 }
@@ -=
1144,7 +1144,7 @@
 int
 md_ctx_size(const EVP_MD_CTX *ctx)
 {
-    return E=
VP_MD_CTX_size(ctx);
+    return (int)EVP_MD_CTX_size(ctx);
 }
 
 void
@@ -=
1188,7 +1188,7 @@
     evp_md_type *kt =3D md_get(mdname);
     ASSERT(NULL=
 !=3D kt && NULL !=3D ctx);
 
-    int key_len =3D EVP_MD_size(kt);
+    in=
t key_len =3D (int)EVP_MD_size(kt);
     HMAC_CTX_reset(ctx);
     if (!HMA=
C_Init_ex(ctx, key, key_len, kt, NULL))
     {
diff --git a/src/openvpn/ope=
nssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index ec059ac=2E=2Eb61bcbf=
 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_comp=
at=2Eh
@@ -51,10 +51,14 @@
 typedef uint32_t openssl_err_t;
 typedef size_t=
 openssl_stack_size_t;
 #define PRI_OPENSSL_STACK "zu"
+typedef uint32_t op=
enssl_opt_t;
 #else
 typedef unsigned long openssl_err_t;
 typedef int open=
ssl_stack_size_t;
 #define PRI_OPENSSL_STACK "d"
+/* OpenSSL 4=2E0 actually=
 uses bits in the upper half of the uint64_t (e=2Eg=2E
+ * SSL_OP_PREFER_NO=
_DHE_KEX), so we really should use an uint64_t here */
+typedef uint64_t op=
enssl_opt_t;
 #endif
 
 
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/ope=
nvpn/ssl_openssl=2Ec
index 6ce5f3f=2E=2Eef99b22 100644
--- a/src/openvpn/ss=
l_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -328,7 +328,7 @@
     AS=
SERT(NULL !=3D ctx);
 
     /* process SSL options */
-    uint64_t sslopt =
=3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
+    openssl_opt_t sslopt =3D =
SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SERVER_PREFE=
RENCE
     sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif
@@ -1656,7 =
+1656,7 @@
 ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, un=
signed char *sig,
            unsigned int *siglen, const BIGNUM *kinv, con=
st BIGNUM *r, EC_KEY *ec)
 {
-    int capacity =3D ECDSA_size(ec);
+    int=
 capacity =3D (int)ECDSA_size(ec);
     /*
      * ECDSA does not seem to h=
ave proper constants for paddings since
      * there are only signatures w=
ithout padding at the moment, use
@@ -1672,12 +1672,14 @@
     return 0;
 }=

 
+#ifndef OPENSSL_IS_AWSLC
 /* EC_KEY_METHOD callback: sign_setup()=2E We=
 do no precomputations */
 static int
 ecdsa_sign_setup(EC_KEY *ec, BN_CTX =
*ctx_in, BIGNUM **kinvp, BIGNUM **rp)
 {
     return 1;
 }
+#endif
 
 /* EC=
_KEY_METHOD callback: sign_sig()=2E
  * Sign the hash and return the result=
 as a newly allocated ECDS_SIG
@@ -1688,7 +1690,7 @@
                EC_KEY=
 *ec)
 {
     ECDSA_SIG *ecsig =3D NULL;
-    unsigned int len =3D ECDSA_si=
ze(ec);
+    unsigned int len =3D (unsigned int)ECDSA_size(ec);
     struct=
 gc_arena gc =3D gc_new();
 
     unsigned char *buf =3D gc_malloc(len, fal=
se, &gc);
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl=
_verify_openssl=2Ec
index 6bb61b6=2E=2Eb8648fd 100644
--- a/src/openvpn/ssl=
_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@ -357,7 +357=
,7 @@
     const EVP_MD *sha1 =3D EVP_sha1();
     struct buffer hash =3D a=
lloc_buf_gc((size_t)EVP_MD_size(sha1), gc);
     X509_digest(cert, EVP_sha1=
(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_size(sha1)));=

+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha1)));
     return hash;=

 }
 
@@ -367,7 +367,7 @@
     const EVP_MD *sha256 =3D EVP_sha256();
     =
struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256), gc);
     =
X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len=
(&hash, EVP_MD_size(sha256)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_s=
ize(sha256)));
     return hash;
 }
 

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1637?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I88254e985d67234d827b92908079795df23daf20
Gerrit-Chang=
e-Number: 1637
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--paTXb/1FQao=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">AWS-LC: Add casts an=
d openssl_opt_t typdef to allow AWS-LC with -Werror<br><br>Change-Id: I8825=
4e985d67234d827b92908079795df23daf20<br>Signed-off-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
637<br>Message-Id: &lt;20260609155226=2E30827-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg37145=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M =2Egithub/workflows/build=2Eyaml<br>M src/openvpn/cr=
ypto_openssl=2Ec<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/ssl_o=
penssl=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>5 files changed, 16 i=
nsertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1637/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml</spa=
n><br><span>index 4cab0ac=2E=2E29e8be2a 100644</span><br><span>--- a/=2Egit=
hub/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/build=
=2Eyaml</span><br><span>@@ -381,6 +381,4 @@</span><br><span>       gitref: =
v5=2E0=2E0</span><br><span>       libconfigure: cmake -B build -GNinja -DCM=
AKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot;$LIBPREFIX&quot; -D=
BUILD_SHARED_LIBS=3D1</span><br><span>       libmake: cmake --build build</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      libinstall: sudo =
cmake --install build</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
      # not ready for --enable-werror</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-      ovpnconfigureflags:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      libinstall: sudo cmake --install build</span><b=
r><span>\ No newline at end of file</span><br><span>diff --git a/src/openvp=
n/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index=
 c11cfd8=2E=2Efa9eb67 100644</span><br><span>--- a/src/openvpn/crypto_opens=
sl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span=
>@@ -425,7 +425,7 @@</span><br><span> print_digest(EVP_MD *digest, void *un=
used)</span><br><span> {</span><br><span>     printf(&quot;%s %d bit digest=
 size\n&quot;, md_kt_name(EVP_MD_get0_name(digest)),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           EVP_MD_size(digest) * 8);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           (int)EVP_MD_siz=
e(digest) * 8);</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span>@@ -1025,7 +1025,7 @@</span><br><span>                    &=
quot;Message hash algorithm &#39;%s&#39; uses a default hash &quot;</span><=
br><span>                    &quot;size (%d bytes) which is larger than &qu=
ot; PACKAGE_NAME &quot;&#39;s current &quot;</span><br><span>              =
      &quot;maximum hash size (%d bytes)&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                   digest, EVP_MD_size(md), MAX_H=
MAC_KEY_LENGTH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                digest, (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);</span><=
br><span>     }</span><br><span>     return md;</span><br><span> }</span><b=
r><span>@@ -1144,7 +1144,7 @@</span><br><span> int</span><br><span> md_ctx_=
size(const EVP_MD_CTX *ctx)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return EVP_MD_CTX_size(ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return (int)EVP_MD_CTX_size(ctx);=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
>@@ -1188,7 +1188,7 @@</span><br><span>     evp_md_type *kt =3D md_get(mdna=
me);</span><br><span>     ASSERT(NULL !=3D kt &amp;&amp; NULL !=3D ctx);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t key_len =3D EVP_MD_size(kt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int key_len =3D (int)EVP_MD_size(kt);</span><br><span>     H=
MAC_CTX_reset(ctx);</span><br><span>     if (!HMAC_Init_ex(ctx, key, key_le=
n, kt, NULL))</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><span>inde=
x ec059ac=2E=2Eb61bcbf 100644</span><br><span>--- a/src/openvpn/openssl_com=
pat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span><br><spa=
n>@@ -51,10 +51,14 @@</span><br><span> typedef uint32_t openssl_err_t;</spa=
n><br><span> typedef size_t openssl_stack_size_t;</span><br><span> #define =
PRI_OPENSSL_STACK &quot;zu&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+typedef uint32_t openssl_opt_t;</span><br><span> #else</span><=
br><span> typedef unsigned long openssl_err_t;</span><br><span> typedef int=
 openssl_stack_size_t;</span><br><span> #define PRI_OPENSSL_STACK &quot;d&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* OpenSSL 4=2E=
0 actually uses bits in the upper half of the uint64_t (e=2Eg=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * SSL_OP_PREFER_NO_DHE_KEX), =
so we really should use an uint64_t here */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+typedef uint64_t openssl_opt_t;</span><br><span> #e=
ndif</span><br><span> </span><br><span> </span><br><span>diff --git a/src/o=
penvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index =
6ce5f3f=2E=2Eef99b22 100644</span><br><span>--- a/src/openvpn/ssl_openssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -=
328,7 +328,7 @@</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span=
> </span><br><span>     /* process SSL options */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    uint64_t sslopt =3D SSL_OP_SINGLE_DH_USE | =
SSL_OP_NO_TICKET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  openssl_opt_t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;</span><=
br><span> #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE</span><br><span>     sslop=
t |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;</span><br><span> #endif</span><br><=
span>@@ -1656,7 +1656,7 @@</span><br><span> ecdsa_sign(int type, const unsi=
gned char *dgst, int dgstlen, unsigned char *sig,</span><br><span>         =
   unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int capacity =3D ECDSA_size(ec);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int capacity =3D (int)ECDSA_size(ec);</span><br><span>    =
 /*</span><br><span>      * ECDSA does not seem to have proper constants fo=
r paddings since</span><br><span>      * there are only signatures without =
padding at the moment, use</span><br><span>@@ -1672,12 +1672,14 @@</span><b=
r><span>     return 0;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef OPENSSL_IS_AWSLC</span><br>=
<span> /* EC_KEY_METHOD callback: sign_setup()=2E We do no precomputations =
*/</span><br><span> static int</span><br><span> ecdsa_sign_setup(EC_KEY *ec=
, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)</span><br><span> {</span><br=
><span>     return 1;</span><br><span> }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* EC_KEY_ME=
THOD callback: sign_sig()=2E</span><br><span>  * Sign the hash and return t=
he result as a newly allocated ECDS_SIG</span><br><span>@@ -1688,7 +1690,7 =
@@</span><br><span>                EC_KEY *ec)</span><br><span> {</span><br=
><span>     ECDSA_SIG *ecsig =3D NULL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned int len =3D ECDSA_size(ec);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    unsigned int len =3D (unsigned in=
t)ECDSA_size(ec);</span><br><span>     struct gc_arena gc =3D gc_new();</sp=
an><br><span> </span><br><span>     unsigned char *buf =3D gc_malloc(len, f=
alse, &amp;gc);</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=
=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index 6bb61b6=2E=
=2Eb8648fd 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@=
 -357,7 +357,7 @@</span><br><span>     const EVP_MD *sha1 =3D EVP_sha1();</=
span><br><span>     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size=
(sha1), gc);</span><br><span>     X509_digest(cert, EVP_sha1(), BPTR(&amp;h=
ash), NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSER=
T(buf_inc_len(&amp;hash, EVP_MD_size(sha1)));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(buf_inc_len(&amp;hash, (int)EVP_MD_siz=
e(sha1)));</span><br><span>     return hash;</span><br><span> }</span><br><=
span> </span><br><span>@@ -367,7 +367,7 @@</span><br><span>     const EVP_M=
D *sha256 =3D EVP_sha256();</span><br><span>     struct buffer hash =3D all=
oc_buf_gc((size_t)EVP_MD_size(sha256), gc);</span><br><span>     X509_diges=
t(cert, EVP_sha256(), BPTR(&amp;hash), NULL);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;hash, EVP_MD_size(sha25=
6)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf=
_inc_len(&amp;hash, (int)EVP_MD_size(sha256)));</span><br><span>     return=
 hash;</span><br><span> }</span><br><span> </span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
37?usp=3Demail">change 1637</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1637?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatch=
set </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I88254e985d67234d827b92908079795df23daf20 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1637 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--paTXb/1FQao=--


--===============1787817461512126444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1787817461512126444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1787817461512126444==--

