Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725E5CD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FAG2tMkmvRanuWseA6XduZ+iT8UlmIbgPZUbxk7pUNo=; b=hIZXPUSEmZZrzR4N/4JuhUzvYw
	BszhujMFy9hNCbKglw9XcUIelZ+qTJKwLauxZkyf44z8eJywgWCcvKgfydINjz6yEp5ss0x37uYRg
	WtApun8AvqNhmHYWUekckaVgidAUGfXd/VehEhHu6FwLB+N9vfSo23WprbEnYE/tbSdM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXxVC-0006hP-2T;
	Fri, 12 Jun 2026 08:44:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXxVA-0006hG-D8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:44:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DOdSXrG0YgpxD/zztUPlf/zYAnGgmv/vm11sEVEDV/s=; b=A/enBYGMtSV7vcHEwN22L6N0s1
 onJiSjy+UzXwq8clmEtZ0lEVNHKWXwIIDyP3FeLmfLRknLIXW1s3nQxOG7uX9gIH+ASLTRd9xOSFe
 qRJ5NmKX1qnE9fGR+eZ/lI1p68mLCjvaEsHfYhrcCIn2tQGOajmVOHLwJNbAEVSo0elQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DOdSXrG0YgpxD/zztUPlf/zYAnGgmv/vm11sEVEDV/s=; b=G
 12TpBtfH+HGMrV9KaIYubHQObxgwKxQZirCyJqf5yKtt/2bWp86AhccOh2nKOti8sX1RlhYyxtszL
 Xm3RErpepf5tQWKz6K07O5RDVuGgaaxZzRvDOXU972iObTnMLX9I5iTsw7QNEEydScsgQsfzVKYFP
 dc2cC3sDYFEImEqA=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXxV8-0006Xz-To for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:44:33 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so6096375e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781253865; x=1781858665; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DOdSXrG0YgpxD/zztUPlf/zYAnGgmv/vm11sEVEDV/s=;
 b=g2w5jLmS+uTJZkmxRkKEXLr4nHkuUG1PMoF0+ONUk8ARsYEitQPZs1JEkmnJEyrDSq
 8Hbz00Gyzpj2J8WlcbiuDCC0DpcLOVWl1poRJQYiH8gJrZL1Z+7GHx4SDaCrY9d94h94
 cjo4UIkYLhTKiaEV2oZKWseUc3fE+hWnBbcv3sG+23PD70SpU5WGNPj8WHQnLK4+1FIs
 ub7V9e0yThsne6Jjz2Eqk2iz16bAZdRlMCYVYiZZGSSbUkmLwFrEj9LjyUdf4AZdxc6y
 /3vEqwHCDJCP7Jl+oyxxDBBX/hneDDvcrLoTs1HBZib33+MWf6IYu43z9T+Bu046/3Pz
 X1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781253865; x=1781858665;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DOdSXrG0YgpxD/zztUPlf/zYAnGgmv/vm11sEVEDV/s=;
 b=AIFCajZ/ZMcqIAiiaUknW1blDiGKFK2iQFOPXxdoTTetYQ/q+Ad+4zzGhFSGbQArpy
 PikRHaLOgDbmOBs0raO0+BO4Q+xP+gAs29yx0ka99g5S3GnlN9E0fwzLVNwyh6MjH9+0
 L2NNo3A0i8Vl+6mJwmULzGGE0JAAEVKuPcxT/BQ1GiLffo8toJk+Wex4CX3eh0Rw92c/
 hvGm5YllPDT4/88YIbP5eeUjsUjyG+LYRWIHt1sfsUDbokmpw3Lg+ebudLWAo/sTcNKo
 5JzXr7AsaXc5LUZ4Tigavf4RnqFcg58vKTOhbEMh9ccp+77wzM7RdxWlK99mQOH5HhJN
 jqxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/du/p8xLqHF9a4QOftAjfQYZmQ3hp6PXfSSodeIx8wdqnIQAfB1/HtAx4M8oYhuPcpUWaRHFgCHZvfb2SB@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzD2WKdNZWEFiMKNfAimIDCw7V2NkGKreLlFRzelPpuvz229Lih
 HPQpFbPkBkWjlIIxBTnFXn4Faq9C1hUwPfUKZ1msgSGUxi6Hs9KdYciU+NOKhi1yRqeDaWTp7JJ
 Tdl1TkpVNp0YFcGoUgTusUzNs0owcGeKnYKQN65AWmdjoseGhzMc+AQRWHTyspt63nanZ
X-Gm-Gg: Acq92OE7NdI1fkjeWaJBFversEAfsYxDn0So2qLKEFIXgC8AkDhknFbI66zni9eJcY9
 PE7ZzkB76KhUfRYuPLJ3MY2UG4WqefX+AggZrt3ZEfMikfKCQSbIiO59mvrRCpXn2DzIblg08g7
 +fW61tbycZgbfBbJAoC1se3h1ISpYIyrvEkW7hK17mskrVvVWv40bTtn3GCeYT6KuBXbM5Sjjjj
 x3lptbrmSw6wd9rXi2mQ6qnLTkq8cilU2pEKJzsfOGWZCGvRqNNpbAYkL3S2YfyJtZVauhuRpTy
 eP0n7KXE6VWsLCAUT2JGynBIuWCwvLmCsFn35DM+A3BRMbY8N2EK+700XbaUCmNgEs6A9tcFQfF
 8b+bHjTVQHESopoxc0Ik/CN5UqLJ468TKRVDm9HQuJhyn3zYRkK+yQcdlPU70qFvrOPex1C0YPy
 aB5ADHsH02xVj7TR3bQJFgXKs/AF0tNiHCeBVhGcS74KgXDmvbXhpfziqTcXBQdX5Wh4/uhd6pC
 F217lvl4t61OCUo/J7gnJ6vgc0siIjbJRDMoKlr9T9N7kOceWSqGcC+iQhWhEUD0UfeQAg3zAVk
 UHp6EftyIZBgUw==
X-Received: by 2002:a05:600c:4512:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-490ec491e93mr17591055e9.5.1781253864630; 
 Fri, 12 Jun 2026 01:44:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2cf5537sm159162035e9.9.2026.06.12.01.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:44:24 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 08:44:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88254e985d67234d827b92908079795df23daf20
X-Gerrit-Change-Number: 1637
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1637?usp=email>
X-Gerrit-Commit: fe72bbec92decbf15984163bc7852f8e6dab7de7
In-Reply-To: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
References: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2ODY0MDY1MDAwLkk4ODI1NGU5ODVkNjcyMzRkODI3YjkyOTA4MDc5Nzk1ZGYyM2RhZjIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d29d412a0a5c451cfd50d05b59f03f55c87f8d8d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXxV8-0006Xz-To
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
Content-Type: multipart/mixed; boundary="===============0457879043396839016=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0457879043396839016==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YstBZ2+8NrU="; charset=UTF-8

--YstBZ2+8NrU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1637?usp=3Demail )

Change subject: AWS-LC: Add casts and openssl_opt_t=
 typdef to allow AWS-LC with -Werror
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

AWS-LC: Add casts and openssl_opt_t typdef to all=
ow AWS-LC with -Werror

Change-Id: I88254e985d67234d827b92908079795df23daf2=
0
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1637
Message-Id: <20260609155226=2E30827-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg37145=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M =2Egithub/workflows/build=2Eyaml
M src/openvpn/crypto_op=
enssl=2Ec
M src/openvpn/openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
M =
src/openvpn/ssl_verify_openssl=2Ec
5 files changed, 16 insertions(+), 12 de=
letions(-)




diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/wo=
rkflows/build=2Eyaml
index 4cab0ac=2E=2E29e8be2a 100644
--- a/=2Egithub/wor=
kflows/build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -381,6 +381,4=
 @@
       gitref: v5=2E0=2E0
       libconfigure: cmake -B build -GNinja -=
DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_S=
HARED_LIBS=3D1
       libmake: cmake --build build
-      libinstall: sudo =
cmake --install build
-      # not ready for --enable-werror
-      ovpncon=
figureflags:
+      libinstall: sudo cmake --install build
\ No newline at =
end of file
diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypt=
o_openssl=2Ec
index c11cfd8=2E=2Efa9eb67 100644
--- a/src/openvpn/crypto_op=
enssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -425,7 +425,7 @@
 print_d=
igest(EVP_MD *digest, void *unused)
 {
     printf("%s %d bit digest size\n=
", md_kt_name(EVP_MD_get0_name(digest)),
-           EVP_MD_size(digest) * =
8);
+           (int)EVP_MD_size(digest) * 8);
 }
 
 void
@@ -1025,7 +1025,=
7 @@
                    "Message hash algorithm '%s' uses a default hash "=

                    "size (%d bytes) which is larger than " PACKAGE_NAME "=
's current "
                    "maximum hash size (%d bytes)",
-         =
          digest, EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
+                 =
  digest, (int)EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);
     }
     return md=
;
 }
@@ -1144,7 +1144,7 @@
 int
 md_ctx_size(const EVP_MD_CTX *ctx)
 {
-   =
 return EVP_MD_CTX_size(ctx);
+    return (int)EVP_MD_CTX_size(ctx);
 }
 
 =
void
@@ -1188,7 +1188,7 @@
     evp_md_type *kt =3D md_get(mdname);
     AS=
SERT(NULL !=3D kt && NULL !=3D ctx);
 
-    int key_len =3D EVP_MD_size(kt)=
;
+    int key_len =3D (int)EVP_MD_size(kt);
     HMAC_CTX_reset(ctx);
    =
 if (!HMAC_Init_ex(ctx, key, key_len, kt, NULL))
     {
diff --git a/src/op=
envpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh
index ec059ac=2E=
=2Eb61bcbf 100644
--- a/src/openvpn/openssl_compat=2Eh
+++ b/src/openvpn/op=
enssl_compat=2Eh
@@ -51,10 +51,14 @@
 typedef uint32_t openssl_err_t;
 type=
def size_t openssl_stack_size_t;
 #define PRI_OPENSSL_STACK "zu"
+typedef u=
int32_t openssl_opt_t;
 #else
 typedef unsigned long openssl_err_t;
 typede=
f int openssl_stack_size_t;
 #define PRI_OPENSSL_STACK "d"
+/* OpenSSL 4=2E=
0 actually uses bits in the upper half of the uint64_t (e=2Eg=2E
+ * SSL_OP=
_PREFER_NO_DHE_KEX), so we really should use an uint64_t here */
+typedef u=
int64_t openssl_opt_t;
 #endif
 
 
diff --git a/src/openvpn/ssl_openssl=2Ec=
 b/src/openvpn/ssl_openssl=2Ec
index 6ce5f3f=2E=2Eef99b22 100644
--- a/src/=
openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -328,7 +328,7 =
@@
     ASSERT(NULL !=3D ctx);
 
     /* process SSL options */
-    uint64=
_t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
+    openssl_opt_t s=
slopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SE=
RVER_PREFERENCE
     sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif
@=
@ -1656,7 +1656,7 @@
 ecdsa_sign(int type, const unsigned char *dgst, int d=
gstlen, unsigned char *sig,
            unsigned int *siglen, const BIGNUM =
*kinv, const BIGNUM *r, EC_KEY *ec)
 {
-    int capacity =3D ECDSA_size(ec)=
;
+    int capacity =3D (int)ECDSA_size(ec);
     /*
      * ECDSA does not=
 seem to have proper constants for paddings since
      * there are only si=
gnatures without padding at the moment, use
@@ -1672,12 +1672,14 @@
     re=
turn 0;
 }
 
+#ifndef OPENSSL_IS_AWSLC
 /* EC_KEY_METHOD callback: sign_set=
up()=2E We do no precomputations */
 static int
 ecdsa_sign_setup(EC_KEY *e=
c, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
 {
     return 1;
 }
+#endi=
f
 
 /* EC_KEY_METHOD callback: sign_sig()=2E
  * Sign the hash and return =
the result as a newly allocated ECDS_SIG
@@ -1688,7 +1690,7 @@
            =
    EC_KEY *ec)
 {
     ECDSA_SIG *ecsig =3D NULL;
-    unsigned int len =
=3D ECDSA_size(ec);
+    unsigned int len =3D (unsigned int)ECDSA_size(ec);=

     struct gc_arena gc =3D gc_new();
 
     unsigned char *buf =3D gc_mal=
loc(len, false, &gc);
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/src=
/openvpn/ssl_verify_openssl=2Ec
index 6bb61b6=2E=2Eb8648fd 100644
--- a/src=
/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
@@=
 -357,7 +357,7 @@
     const EVP_MD *sha1 =3D EVP_sha1();
     struct buffe=
r hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);
     X509_digest(ce=
rt, EVP_sha1(), BPTR(&hash), NULL);
-    ASSERT(buf_inc_len(&hash, EVP_MD_s=
ize(sha1)));
+    ASSERT(buf_inc_len(&hash, (int)EVP_MD_size(sha1)));
     =
return hash;
 }
 
@@ -367,7 +367,7 @@
     const EVP_MD *sha256 =3D EVP_sha=
256();
     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256)=
, gc);
     X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
-    ASSERT=
(buf_inc_len(&hash, EVP_MD_size(sha256)));
+    ASSERT(buf_inc_len(&hash, (=
int)EVP_MD_size(sha256)));
     return hash;
 }
 

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I88254e985d67234d827b92908079795df23daf20
Gerri=
t-Change-Number: 1637
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--YstBZ2+8NrU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1637?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">AWS-LC: Add casts and openssl_opt_t typdef=
 to allow AWS-LC with -Werror<br><br>Change-Id: I88254e985d67234d827b929080=
79795df23daf20<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637<br>Message-Id: &lt=
;20260609155226=2E30827-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37145=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M =2Egithub/workflows/build=2Eyaml<br>M src/openvpn/crypto_openssl=2Ec<br>=
M src/openvpn/openssl_compat=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>M src/=
openvpn/ssl_verify_openssl=2Ec<br>5 files changed, 16 insertions(+), 12 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/=2Egithub/workflows/build=2Eyaml b/=
=2Egithub/workflows/build=2Eyaml</span><br><span>index 4cab0ac=2E=2E29e8be2=
a 100644</span><br><span>--- a/=2Egithub/workflows/build=2Eyaml</span><br><=
span>+++ b/=2Egithub/workflows/build=2Eyaml</span><br><span>@@ -381,6 +381,=
4 @@</span><br><span>       gitref: v5=2E0=2E0</span><br><span>       libco=
nfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTAL=
L_PREFIX=3D&quot;$LIBPREFIX&quot; -DBUILD_SHARED_LIBS=3D1</span><br><span> =
      libmake: cmake --build build</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      libinstall: sudo cmake --install build</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      # not ready for --enable-werror</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-      ovpnconfigureflag=
s:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      libinstall:=
 sudo cmake --install build</span><br><span>\ No newline at end of file</sp=
an><br><span>diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/cryp=
to_openssl=2Ec</span><br><span>index c11cfd8=2E=2Efa9eb67 100644</span><br>=
<span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvp=
n/crypto_openssl=2Ec</span><br><span>@@ -425,7 +425,7 @@</span><br><span> p=
rint_digest(EVP_MD *digest, void *unused)</span><br><span> {</span><br><spa=
n>     printf(&quot;%s %d bit digest size\n&quot;, md_kt_name(EVP_MD_get0_n=
ame(digest)),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
   EVP_MD_size(digest) * 8);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+           (int)EVP_MD_size(digest) * 8);</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span>@@ -1025,7 +1025,7 @@</s=
pan><br><span>                    &quot;Message hash algorithm &#39;%s&#39;=
 uses a default hash &quot;</span><br><span>                    &quot;size =
(%d bytes) which is larger than &quot; PACKAGE_NAME &quot;&#39;s current &q=
uot;</span><br><span>                    &quot;maximum hash size (%d bytes)=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
     digest, EVP_MD_size(md), MAX_HMAC_KEY_LENGTH);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   digest, (int)EVP_MD_si=
ze(md), MAX_HMAC_KEY_LENGTH);</span><br><span>     }</span><br><span>     r=
eturn md;</span><br><span> }</span><br><span>@@ -1144,7 +1144,7 @@</span><b=
r><span> int</span><br><span> md_ctx_size(const EVP_MD_CTX *ctx)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return EV=
P_MD_CTX_size(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return (int)EVP_MD_CTX_size(ctx);</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span>@@ -1188,7 +1188,7 @@</span><br><span=
>     evp_md_type *kt =3D md_get(mdname);</span><br><span>     ASSERT(NULL =
!=3D kt &amp;&amp; NULL !=3D ctx);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int key_len =3D EVP_MD_size(kt);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int key_len =3D (int)E=
VP_MD_size(kt);</span><br><span>     HMAC_CTX_reset(ctx);</span><br><span> =
    if (!HMAC_Init_ex(ctx, key, key_len, kt, NULL))</span><br><span>     {<=
/span><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/o=
penssl_compat=2Eh</span><br><span>index ec059ac=2E=2Eb61bcbf 100644</span><=
br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/src/ope=
nvpn/openssl_compat=2Eh</span><br><span>@@ -51,10 +51,14 @@</span><br><span=
> typedef uint32_t openssl_err_t;</span><br><span> typedef size_t openssl_s=
tack_size_t;</span><br><span> #define PRI_OPENSSL_STACK &quot;zu&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint32_t openssl=
_opt_t;</span><br><span> #else</span><br><span> typedef unsigned long opens=
sl_err_t;</span><br><span> typedef int openssl_stack_size_t;</span><br><spa=
n> #define PRI_OPENSSL_STACK &quot;d&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* OpenSSL 4=2E0 actually uses bits in the upper hal=
f of the uint64_t (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * SSL_OP_PREFER_NO_DHE_KEX), so we really should use an uint64_t h=
ere */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint6=
4_t openssl_opt_t;</span><br><span> #endif</span><br><span> </span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/=
ssl_openssl=2Ec</span><br><span>index 6ce5f3f=2E=2Eef99b22 100644</span><br=
><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl_openssl=2Ec</span><br><span>@@ -328,7 +328,7 @@</span><br><span>     AS=
SERT(NULL !=3D ctx);</span><br><span> </span><br><span>     /* process SSL =
options */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_=
t sslopt =3D SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openssl_opt_t sslopt =3D SSL_OP_SINGL=
E_DH_USE | SSL_OP_NO_TICKET;</span><br><span> #ifdef SSL_OP_CIPHER_SERVER_P=
REFERENCE</span><br><span>     sslopt |=3D SSL_OP_CIPHER_SERVER_PREFERENCE;=
</span><br><span> #endif</span><br><span>@@ -1656,7 +1656,7 @@</span><br><s=
pan> ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned =
char *sig,</span><br><span>            unsigned int *siglen, const BIGNUM *=
kinv, const BIGNUM *r, EC_KEY *ec)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int capacity =3D ECDSA_size(ec);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int capacity =3D (int)=
ECDSA_size(ec);</span><br><span>     /*</span><br><span>      * ECDSA does =
not seem to have proper constants for paddings since</span><br><span>      =
* there are only signatures without padding at the moment, use</span><br><s=
pan>@@ -1672,12 +1672,14 @@</span><br><span>     return 0;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef OPENSSL_IS_AWSLC</span><br><span> /* EC_KEY_METHOD callback: sign_=
setup()=2E We do no precomputations */</span><br><span> static int</span><b=
r><span> ecdsa_sign_setup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNU=
M **rp)</span><br><span> {</span><br><span>     return 1;</span><br><span> =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span> </span><br><span> /* EC_KEY_METHOD callback: sign_sig()=2E</span><br>=
<span>  * Sign the hash and return the result as a newly allocated ECDS_SIG=
</span><br><span>@@ -1688,7 +1690,7 @@</span><br><span>                EC_K=
EY *ec)</span><br><span> {</span><br><span>     ECDSA_SIG *ecsig =3D NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int len =
=3D ECDSA_size(ec);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    unsigned int len =3D (unsigned int)ECDSA_size(ec);</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     un=
signed char *buf =3D gc_malloc(len, false, &amp;gc);</span><br><span>diff -=
-git a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=
=2Ec</span><br><span>index 6bb61b6=2E=2Eb8648fd 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_=
verify_openssl=2Ec</span><br><span>@@ -357,7 +357,7 @@</span><br><span>    =
 const EVP_MD *sha1 =3D EVP_sha1();</span><br><span>     struct buffer hash=
 =3D alloc_buf_gc((size_t)EVP_MD_size(sha1), gc);</span><br><span>     X509=
_digest(cert, EVP_sha1(), BPTR(&amp;hash), NULL);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ASSERT(buf_inc_len(&amp;hash, EVP_MD_size(s=
ha1)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(b=
uf_inc_len(&amp;hash, (int)EVP_MD_size(sha1)));</span><br><span>     return=
 hash;</span><br><span> }</span><br><span> </span><br><span>@@ -367,7 +367,=
7 @@</span><br><span>     const EVP_MD *sha256 =3D EVP_sha256();</span><br>=
<span>     struct buffer hash =3D alloc_buf_gc((size_t)EVP_MD_size(sha256),=
 gc);</span><br><span>     X509_digest(cert, EVP_sha256(), BPTR(&amp;hash),=
 NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf=
_inc_len(&amp;hash, EVP_MD_size(sha256)));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(buf_inc_len(&amp;hash, (int)EVP_MD_size(s=
ha256)));</span><br><span>     return hash;</span><br><span> }</span><br><s=
pan> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3Demail">change 1637</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88254e985d67234d=
827b92908079795df23daf20 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1637 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--YstBZ2+8NrU=--


--===============0457879043396839016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0457879043396839016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0457879043396839016==--

