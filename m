Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F2AC43458
	for <openvpn-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pupozacXS8IcBPTkuj6tlW5peo+d5k4F5lhmIwDhfAM=; b=dGTWr5aIGr+QwZaeaxE3ngGN/R
	Pa/dDdvLfeYiIkaBgtEl4TMsie3I+4+nrsqanLlpe6l0Gq9vQy3FvD70TSBE/zt1LRQV6XNv2wCmO
	Tl9bJSJzOdnPFPzP0jkhWN9D8QHKUQXGu6hQg53VHs6dAW9ESBaB+B0Xl8a+sq9mgAZc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wh8F8-00020j-BE;
	Tue, 07 Jul 2026 16:01:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wh8Eu-00020W-Sg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 16:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ASwtjYJLwO8dJ/wopANQm8tU3/9ypuzE84LOmpEUXpc=; b=MAh9OCZX63tYzerGUFPB0+u1JY
 QqAM8odqILdDC36zf75r+70jsByCvPI8PG65+eflmPQnd/9KA/D8P8AvFlDSkseiIYpcqxIwjYEO4
 bRD6AmVfh31M0PeSBwIxyXu7/ykEE1tffPZafNqPjMQJ1y05HhyKtnJBd+5OBIsE6dFE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ASwtjYJLwO8dJ/wopANQm8tU3/9ypuzE84LOmpEUXpc=; b=K
 cL4OgFv8ndilS0pLdIgx34fWy1w9y9f4Jg2Ceu3NS9dzA5KTyyIoy7rMmjYTEnpIFseIt+PEFsm8D
 OFMu78xotQVyliMqBXgbcIWAiyimJuKBvRSwW483eDxhRUaTissl7UrcH8VQzFyPJPeNIRFi6+Yxa
 2qp0N5Hj2MV1egbQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wh8Ej-0002W6-QR for openvpn-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 16:01:34 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-470174001a0so2434042f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 07 Jul 2026 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783440079; x=1784044879; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ASwtjYJLwO8dJ/wopANQm8tU3/9ypuzE84LOmpEUXpc=;
 b=S89s1abRyWlZfp5qkddx0C1QyH/0nJ0O66JIhO2fjeoOsjy5c7X63y3tn+6uMc08Xo
 hVzzj+jmOYyhzHw5Xn+5iZNG8ftv9k58QaiqVs/lGpmERoOss6mSjy4Yd0DE5IwIJS66
 zGNVab9PEHGDqbiN8aQfZXTLfVi1KOaHDZBApBdshERawvwz6ehJ1UgyNrKv5OxYLfxe
 ILwBYatWv3d40azFUy8oj6O+2bAkju6JtkP4XW5UBXqKPPAFlOKopXeRWEZ+Bg+k6nPl
 qgzWzJRj7t/QP3ZiHow58Y2NNYIgHg+DtsZin23+Ojq+Jr0ZDRvldBbttZdigpbKqCSD
 YZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783440079; x=1784044879;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ASwtjYJLwO8dJ/wopANQm8tU3/9ypuzE84LOmpEUXpc=;
 b=PhomG+3kBEJ0wpz841e1Iw0AM3+62Lc1bF3+mjXaz5clQ8midA89igs0iQZEPIrBn1
 4YVHnJw+8oS0ORnpo76hEs/6m2dUNKQA/sxJVFXUD8603fOde+WR1thhoK8+B8dOhhr8
 2YD6ryPqga6v6OWclJosH4ss7RYMjw2RzC88fHKjUNzFkUIidJ4Y/IhpN0oOssaQcc7h
 Ysplyo4AD1VRYcuNAQYUDloPczvNXiD942DlAbkjsuoZ9Rj7V0lMvG8e9Rv3YM70xKrD
 JORkwOEQdOeN+vy73YTJ+UqJDv246CP4TmBPHdPD/oOpVHWmGBxj/UokxI3Vs9CzFuJ1
 7NGw==
X-Gm-Message-State: AOJu0YxHX/WnU0buk2r3CHDY1UHp33GmAdYXQSnSBkuu0zsoGnmyPgKp
 GsFkNkPgxNvil8OPvdJ/ADdXAriv5Kb/1P/1IU1OMIXQuYA1nHNKUJ1CIOEqcZqKNOf+858UDjB
 nKG+9NE5CEILPi0O1Lo0JUGtS0nONkPkNogKQ4xs6WJRcC4S/XW+GVhr/oTgkE9DpZbW/b48w+I
 ETbpR9XQ==
X-Gm-Gg: AfdE7ck2n2MjqZCAMrlIQdxuhUdHEihsrnuJEPT1Y+AGSzQTrA5Jp9rD/bXA4UMPzRZ
 4IUBmTgz6VORgP18S+PNgFTCV+woqO2yqaoNZLM5n2h1m2QrDV/U2Kn/vMPWl0SrP+SEwhNgXhx
 syRsnb4ljTigQk/yGSWjbJ6UziS0DSBpfDm2ffo0yWNV5vb9298QzpT1hUYq4yA/y0uZRgozoyE
 MQ5xj9kxc8WSi0LxikSbhyaXjcVpxRrHeqcl5Mc4c95fobhee+uQupiSatVQXQjXl9JHlLkcyT1
 nGEuCFYbDWQiO7ixi3J1vhAikmtLMwJivzIrqonxjivXQOm8KB2jVZEuJIJX7aTHUAHL7UvbRVv
 Hsx1a7pqKEXBGEsi81OTwmM2nK6brTIS6IgiNneGZ6HazmSq+HmeVG3tJ/bY0IgpxvLz8uDWKF0
 VH5gTxPX/q3KR+jzCauyad8MbF0ENOLdLV7JuQ9wRm+N0J2d0Fqyna5svVwv0s6E6AkSp5FqVig
 GKQ/f+wwoq+xcMZK3kD8xZNbARiZmpZFeGbXTPFsaK5KKq6U/dJYHr6+AF54lgYxvBgUSPf/hzM
 vTs=
X-Received: by 2002:a05:600c:3e0d:b0:493:bd4f:510 with SMTP id
 5b1f17b1804b1-493df065fd0mr63212895e9.19.1783440077766; 
 Tue, 07 Jul 2026 09:01:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f36786sm60219915e9.6.2026.07.07.09.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 09:01:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 7 Jul 2026 16:01:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: b87deda948f83ab8d01871fea6eb13c125e52b09
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <172e5ce1505714baa090cc45e6c6dd88f95836ac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wh8Ej-0002W6-QR
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
 unused functions
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5507865299433432755=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5507865299433432755==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xtvygbqlsk4="; charset=UTF-8

--Xtvygbqlsk4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610?usp=3Demail

to look at the new patch set (#10)=2E
=


Change subject: Remove various unused functions
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove various unused functions

Chan=
ge-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Eh
M src/openvpn=
/crypto_backend=2Eh
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/crypto_m=
bedtls_legacy=2Ec
M src/openvpn/crypto_openssl=2Ec
M src/openvpn/dco_win=2E=
h
M src/openvpn/env_set=2Ec
M src/openvpn/env_set=2Eh
M src/openvpn/event=
=2Eh
M src/openvpn/interval=2Eh
M src/openvpn/manage=2Eh
M src/openvpn/mrou=
te=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/openvpn=2Ec
M src/openvpn/p=
lugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/route=2Ec
M src/openvpn/ro=
ute=2Eh
18 files changed, 0 insertions(+), 271 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/1610/10

diff --gi=
t a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index fcc923b=2E=2Eaef2=
9de 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -80=
5,28 +805,6 @@
     return ntohs(ret);
 }
 
-static inline uint32_t
-buf_re=
ad_u32(struct buffer *buf, bool *good)
-{
-    uint32_t ret;
-    if (!buf_=
read(buf, &ret, sizeof(uint32_t)))
-    {
-        if (good)
-        {
-  =
          *good =3D false;
-        }
-        return 0;
-    }
-    else
-=
    {
-        if (good)
-        {
-            *good =3D true;
-        }=

-        return ntohl(ret);
-    }
-}
-
 /** Return true if buffer content=
s are equal */
 static inline bool
 buf_equal(const struct buffer *a, const=
 struct buffer *b)
@@ -1018,12 +996,6 @@
 
 void x_gc_freespecial(struct gc=
_arena *a);
 
-static inline bool
-gc_defined(struct gc_arena *a)
-{
-    r=
eturn a->list !=3D NULL;
-}
-
 static inline void
 gc_init(struct gc_arena =
*a)
 {
diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_bac=
kend=2Eh
index b602ba1=2E=2E360abbe 100644
--- a/src/openvpn/crypto_backend=
=2Eh
+++ b/src/openvpn/crypto_backend=2Eh
@@ -579,15 +579,6 @@
 void md_ctx=
_cleanup(md_ctx_t *ctx);
 
 /*
- * Returns the size of the message digest o=
utput by the given context
- *
- * @param ctx           Message digest cont=
ext=2E
- *
- * @return              Size of the message digest, or \0 if ct=
x is NULL=2E
- */
-int md_ctx_size(const md_ctx_t *ctx);
-
-/*
  * Process =
the given data for use in the message digest=2E
  *
  * @param ctx         =
  Message digest context=2E May not be NULL=2E
diff --git a/src/openvpn/cry=
pto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 6662def=2E=2E665257c=
0 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbed=
tls=2Ec
@@ -718,16 +718,6 @@
     ASSERT(psa_hash_abort(&ctx->operation) =
=3D=3D PSA_SUCCESS);
 }
 
-int
-md_ctx_size(const md_ctx_t *ctx)
-{
-    if=
 (ctx =3D=3D NULL)
-    {
-        return 0;
-    }
-    return (int)PSA_HA=
SH_LENGTH(ctx->md_info->psa_alg);
-}
-
 void
 md_ctx_update(md_ctx_t *ctx, =
const uint8_t *src, size_t src_len)
 {
diff --git a/src/openvpn/crypto_mbed=
tls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
index debd53d=2E=2E6=
556358 100644
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn=
/crypto_mbedtls_legacy=2Ec
@@ -856,16 +856,6 @@
     mbedtls_md_free(ctx);
=
 }
 
-int
-md_ctx_size(const mbedtls_md_context_t *ctx)
-{
-    if (NULL =
=3D=3D ctx)
-    {
-        return 0;
-    }
-    return (int)mbedtls_md_ge=
t_size(mbedtls_md_info_from_ctx(ctx));
-}
-
 void
 md_ctx_update(mbedtls_md=
_context_t *ctx, const uint8_t *src, size_t src_len)
 {
diff --git a/src/op=
envpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index fa9eb67=2E=
=2E57d51f4 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/cr=
ypto_openssl=2Ec
@@ -1141,12 +1141,6 @@
     EVP_MD_CTX_reset(ctx);
 }
 
-i=
nt
-md_ctx_size(const EVP_MD_CTX *ctx)
-{
-    return (int)EVP_MD_CTX_size(=
ctx);
-}
-
 void
 md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t=
 src_len)
 {
diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh=

index ac3ce33=2E=2Ea92e5ad 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/=
openvpn/dco_win=2Eh
@@ -65,8 +65,6 @@
 void dco_p2p_new_peer(HANDLE handle,=
 OVERLAPPED *ov, struct link_socket *sock,
                       struct si=
gnal_info *sig_info);
 
-void dco_start_tun(struct tuntap *tt);
-
 bool dco=
_win_supports_multipeer(void);
 
 void dco_win_add_iroute_ipv4(dco_context_=
t *dco, in_addr_t dst, unsigned int netbits,
@@ -79,13 +77,5 @@
 
 void dco=
_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int =
netbits);
 
-#else  /* if defined(ENABLE_DCO) && defined(_WIN32) */
-
-stat=
ic inline void
-dco_start_tun(struct tuntap *tt)
-{
-    ASSERT(false);
-}
=
-
 #endif /* defined(_WIN32) */
 #endif /* ifndef DCO_H */
diff --git a/src=
/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index d992097=2E=2Ee147913 1=
00644
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/env_set=2Ec
@@ -209,3=
2 +209,6 @@
 }
 
 void
-env_set_print(msglvl_t msglevel, const struct env_s=
et *es)
-{
-    if (check_debug_level(msglevel))
-    {
-        const stru=
ct env_item *e;
-        int i;
-
-        if (es)
-        {
-            =
e =3D es->list;
-            i =3D 0;
-
-            while (e)
-           =
 {
-                if (env_safe_to_print(e->string))
-                {
- =
                   msg(msglevel, "ENV [%d] '%s'", i, e->string);
-         =
       }
-                ++i;
-                e =3D e->next;
-           =
 }
-        }
-    }
-}
-
-void
 env_set_write_file(const char *path, const=
 struct env_set *es)
 {
     FILE *fp =3D platform_fopen(path, "w");
@@ -41=
1,15 +385,6 @@
 }
 
 void
-setenv_int_i(struct env_set *es, const char *nam=
e, const int value, const int i)
-{
-    struct gc_arena gc =3D gc_new();
-=
    const char *name_str =3D setenv_format_indexed_name(name, i, &gc);
-   =
 setenv_int(es, name_str, value);
-    gc_free(&gc);
-}
-
-void
 setenv_str=
_i(struct env_set *es, const char *name, const char *value, const int i)
 {=

     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/env_set=2Eh=
 b/src/openvpn/env_set=2Eh
index fcfc3ca=2E=2E9b4a1e7 100644
--- a/src/open=
vpn/env_set=2Eh
+++ b/src/openvpn/env_set=2Eh
@@ -69,8 +69,6 @@
  */
 void =
setenv_str_incr(struct env_set *es, const char *name, const char *value);
 =

-void setenv_int_i(struct env_set *es, const char *name, const int value, =
const int i);
-
 void setenv_str_i(struct env_set *es, const char *name, co=
nst char *value, const int i);
 
 /* struct env_set functions */
@@ -85,8 +=
83,6 @@
 
 const char *env_set_get(const struct env_set *es, const char *na=
me);
 
-void env_set_print(msglvl_t msglevel, const struct env_set *es);
-
=
 /**
  * Write a struct env_set to a file=2E Each item on one line=2E
  *
d=
iff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
index 40ed161=2E=
=2Eb784dfe 100644
--- a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=2Eh
@=
@ -190,13 +190,6 @@
     return ret;
 }
 
-static inline void
-event_set_re=
turn_init(struct event_set_return *esr)
-{
-    esr->rwflags =3D 0;
-    es=
r->arg =3D NULL;
-}
-
 #ifdef _WIN32
 
 static inline void
diff --git a/src=
/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index f6d3503=2E=2E59051bd=
 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -2=
55,47 +255,4 @@
  */
 bool event_timeout_trigger(struct event_timeout *et, =
struct timeval *tv, int et_const_retry);
 
-/*
- * Measure time intervals i=
n microseconds
- */
-
-#define USEC_TIMER_MAX 60 /* maximum interval size i=
n seconds */
-
-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000)
-
-s=
truct usec_timer
-{
-    struct timeval start;
-    struct timeval end;
-};=

-
-#ifdef HAVE_GETTIMEOFDAY
-
-static inline void
-usec_timer_start(struct=
 usec_timer *obj)
-{
-    CLEAR(*obj);
-    openvpn_gettimeofday(&obj->star=
t, NULL);
-}
-
-static inline void
-usec_timer_end(struct usec_timer *obj)
=
-{
-    openvpn_gettimeofday(&obj->end, NULL);
-}
-
-#endif /* HAVE_GETTIME=
OFDAY */
-
-static inline bool
-usec_timer_interval_defined(struct usec_tim=
er *obj)
-{
-    return obj->start=2Etv_sec && obj->end=2Etv_sec;
-}
-
-sta=
tic inline int
-usec_timer_interval(struct usec_timer *obj)
-{
-    return =
tv_subtract(&obj->end, &obj->start, USEC_TIMER_MAX);
-}
-
 #endif /* INTERV=
AL_H */
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index =
27d3b60=2E=2E1be3549 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/=
manage=2Eh
@@ -158,12 +158,6 @@
     return h->size;
 }
 
-static inline in=
t
-log_history_capacity(const struct log_history *h)
-{
-    return h->capa=
city;
-}
-
 /*
  * Callbacks for 'status' and 'kill' commands=2E
  * Also f=
or management-based deferred authentication and packet filter=2E
diff --git=
 a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2f5d019=2E=2E8d437=
c6 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -249=
,24 +249,4 @@
     dest->v4=2Eaddr =3D htonl(src);
 }
 
-static inline in_a=
ddr_t
-in_addr_t_from_mroute_addr(const struct mroute_addr *addr)
-{
-    i=
f ((addr->type & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 && addr->netbits =3D=3D =
0 && addr->len =3D=3D 4)
-    {
-        return ntohl(addr->v4=2Eaddr);
-  =
  }
-    else
-    {
-        return 0;
-    }
-}
-
-static inline void
-mr=
oute_addr_reset(struct mroute_addr *ma)
-{
-    ma->len =3D 0;
-    ma->typ=
e =3D MR_ADDR_NONE;
-}
-
 #endif /* MROUTE_H */
diff --git a/src/openvpn/mu=
lti_io=2Ec b/src/openvpn/multi_io=2Ec
index d8cc708=2E=2Ebb1fbce 100644
---=
 a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -661,12 +661,=
3 @@
 
     } while (action !=3D TA_UNDEF);
 }
-
-void
-multi_io_delete_eve=
nt(struct multi_io *multi_io, event_t event)
-{
-    if (multi_io && multi_=
io->es)
-    {
-        event_del(multi_io->es, event);
-    }
-}
diff --gi=
t a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index f38660f=2E=2E5e=
1f680 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@=
 -31,7 +31,6 @@
 #include "multi=2Eh"
 #include "win32=2Eh"
 #include "plat=
form=2Eh"
-#include "string=2Eh"
 
 #include "memdbg=2Eh"
 
diff --git a/sr=
c/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index f8adde5=2E=2E29f9327 10=
0644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,24 +=
993,4 @@
     pr->n =3D 0;
 }
 
-#ifdef ENABLE_DEBUG
-void
-plugin_return_p=
rint(const msglvl_t msglevel, const char *prefix, const struct plugin_retur=
n *pr)
-{
-    int i;
-    msg(msglevel, "PLUGIN_RETURN_PRINT %s", prefix);=

-    for (i =3D 0; i < pr->n; ++i)
-    {
-        struct openvpn_plugin_s=
tring_list *l =3D pr->list[i];
-        int count =3D 0;
-
-        msg(msg=
level, "PLUGIN #%d (%s)", i, prefix);
-        while (l)
-        {
-      =
      msg(msglevel, "[%d] '%s' -> '%s'", ++count, l->name, l->value);
-    =
        l =3D l->next;
-        }
-    }
-}
-#endif /* ifdef ENABLE_DEBUG *=
/
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvpn/plugin=2Eh b/src/ope=
nvpn/plugin=2Eh
index 7e9faf3=2E=2Eb5fb916 100644
--- a/src/openvpn/plugin=
=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,10 +135,6 @@
 
 void plugin_retur=
n_free(struct plugin_return *pr);
 
-#ifdef ENABLE_DEBUG
-void plugin_retur=
n_print(const msglvl_t msglevel, const char *prefix, const struct plugin_re=
turn *pr);
-
-#endif
 
 static inline int
 plugin_n(const struct plugin_lis=
t *pl)
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 81c=
e867=2E=2E1e0f0b3 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rout=
e=2Ec
@@ -185,19 +185,6 @@
     dest->gc =3D a;
 }
 
-static const char *
-=
route_string(const struct route_ipv4 *r, struct gc_arena *gc)
-{
-    struc=
t buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&out, "ROUTE networ=
k %s netmask %s gateway %s", print_in_addr_t(r->network, 0, gc),
-         =
      print_in_addr_t(r->netmask, 0, gc), print_in_addr_t(r->gateway, 0, gc=
));
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        buf_printf(&out,=
 " metric %d", r->metric);
-    }
-    return BSTR(&out);
-}
-
 static bool=

 is_route_parm_defined(const char *parm)
 {
@@ -1325,27 +1312,6 @@
 #endif=
 /* ifndef ENABLE_SMALL */
 
 static void
-print_route(const struct route_i=
pv4 *r, msglvl_t msglevel)
-{
-    struct gc_arena gc =3D gc_new();
-    if=
 (r->flags & RT_DEFINED)
-    {
-        msg(msglevel, "%s", route_string(r=
, &gc));
-    }
-    gc_free(&gc);
-}
-
-void
-print_routes(const struct ro=
ute_list *rl, msglvl_t msglevel)
-{
-    struct route_ipv4 *r;
-    for (r =
=3D rl->routes; r; r =3D r->next)
-    {
-        print_route(r, msglevel);=

-    }
-}
-
-static void
 setenv_route(struct env_set *es, const struct ro=
ute_ipv4 *r, int i)
 {
     struct gc_arena gc =3D gc_new();
diff --git a/s=
rc/openvpn/route=2Eh b/src/openvpn/route=2Eh
index 88107e9=2E=2E0d33d36 100=
644
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -377,8 +377,=
6 @@
 
 #endif
 
-void print_routes(const struct route_list *rl, msglvl_t m=
sglevel);
-
 #ifdef _WIN32
 
 void show_routes(msglvl_t msglevel);
@@ -409,=
19 +407,6 @@
     return mask;
 }
 
-static inline bool
-route_list_vpn_gat=
eway_needed(const struct route_list *rl)
-{
-    if (!rl)
-    {
-        r=
eturn false;
-    }
-    else
-    {
-        return !(rl->spec=2Eflags & R=
TSA_REMOTE_ENDPOINT);
-    }
-}
-
 static inline int
 route_did_redirect_de=
fault_gateway(const struct route_list *rl)
 {

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Ge=
rrit-Change-Number: 1610
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Xtvygbqlsk4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #10</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">R=
emove various unused functions<br><br>Change-Id: I82a4e82ff876fab715e052de1=
903c65b835360b5<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Eh<br>M src/openvpn/crypto_backe=
nd=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/crypto_mbedtls_=
legacy=2Ec<br>M src/openvpn/crypto_openssl=2Ec<br>M src/openvpn/dco_win=2Eh=
<br>M src/openvpn/env_set=2Ec<br>M src/openvpn/env_set=2Eh<br>M src/openvpn=
/event=2Eh<br>M src/openvpn/interval=2Eh<br>M src/openvpn/manage=2Eh<br>M s=
rc/openvpn/mroute=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/openvp=
n=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M src/open=
vpn/route=2Ec<br>M src/openvpn/route=2Eh<br>18 files changed, 0 insertions(=
+), 271 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/10/1610/10</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index fcc923b=2E=
=2Eaef29de 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -805,28 +805,6 @@</span=
><br><span>     return ntohs(ret);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline uint32_t</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_read_u32(struct buff=
er *buf, bool *good)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t ret;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!buf_read(buf, &a=
mp;ret, sizeof(uint32_t)))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(good)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            *good =3D false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (good)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *good =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return ntohl(ret);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> /** Return true if buffer contents are eq=
ual */</span><br><span> static inline bool</span><br><span> buf_equal(const=
 struct buffer *a, const struct buffer *b)</span><br><span>@@ -1018,12 +996=
,6 @@</span><br><span> </span><br><span> void x_gc_freespecial(struct gc_ar=
ena *a);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-gc_defined(struct gc_arena *a)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n a-&gt;list !=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
static inline void</span><br><span> gc_init(struct gc_arena *a)</span><br><=
span> {</span><br><span>diff --git a/src/openvpn/crypto_backend=2Eh b/src/o=
penvpn/crypto_backend=2Eh</span><br><span>index b602ba1=2E=2E360abbe 100644=
</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><br><span>+++ b=
/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -579,15 +579,6 @@</span>=
<br><span> void md_ctx_cleanup(md_ctx_t *ctx);</span><br><span> </span><br>=
<span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns t=
he size of the message digest output by the given context</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param ctx           Message digest context=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @return              Size of the message diges=
t, or \0 if ctx is NULL=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int md_ctx_si=
ze(const md_ctx_t *ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span=
>  * Process the given data for use in the message digest=2E</span><br><spa=
n>  *</span><br><span>  * @param ctx           Message digest context=2E Ma=
y not be NULL=2E</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2E=
c b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 6662def=2E=2E66525=
7c0 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><=
span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -718,16 +718,6=
 @@</span><br><span>     ASSERT(psa_hash_abort(&amp;ctx-&gt;operation) =3D=
=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-md_ctx_size(const md_ctx_t *ctx)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (ctx =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)PSA_HASH_LE=
NGTH(ctx-&gt;md_info-&gt;psa_alg);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> void</span><br><span> md_ctx_update(md_ctx_t *ctx, const uint8_t=
 *src, size_t src_len)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</=
span><br><span>index debd53d=2E=2E6556358 100644</span><br><span>--- a/src/=
openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_=
mbedtls_legacy=2Ec</span><br><span>@@ -856,16 +856,6 @@</span><br><span>   =
  mbedtls_md_free(ctx);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-md_ctx_size(const mbedtls_md_context_t *ctx)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retur=
n (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span> md_ctx_update(mbed=
tls_md_context_t *ctx, const uint8_t *src, size_t src_len)</span><br><span>=
 {</span><br><span>diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvp=
n/crypto_openssl=2Ec</span><br><span>index fa9eb67=2E=2E57d51f4 100644</spa=
n><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/=
openvpn/crypto_openssl=2Ec</span><br><span>@@ -1141,12 +1141,6 @@</span><br=
><span>     EVP_MD_CTX_reset(ctx);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const EVP_MD_CTX *ctx)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return (int)EVP_MD_CTX_size(ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> md_ctx_update(=
EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)</span><br><span> {</sp=
an><br><span>diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh=
</span><br><span>index ac3ce33=2E=2Ea92e5ad 100644</span><br><span>--- a/sr=
c/openvpn/dco_win=2Eh</span><br><span>+++ b/src/openvpn/dco_win=2Eh</span><=
br><span>@@ -65,8 +65,6 @@</span><br><span> void dco_p2p_new_peer(HANDLE ha=
ndle, OVERLAPPED *ov, struct link_socket *sock,</span><br><span>           =
            struct signal_info *sig_info);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void dco_start_tun(struct tuntap *tt=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> b=
ool dco_win_supports_multipeer(void);</span><br><span> </span><br><span> vo=
id dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int =
netbits,</span><br><span>@@ -79,13 +77,5 @@</span><br><span> </span><br><sp=
an> void dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, u=
nsigned int netbits);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#else  /* if defined(ENABLE_DCO) &amp;&amp; defined(_WIN3=
2) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-dco_start_tun(struct tuntap *tt)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(false);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> #endif /* defined(_WIN32) */</span><br><span> #endif /=
* ifndef DCO_H */</span><br><span>diff --git a/src/openvpn/env_set=2Ec b/sr=
c/openvpn/env_set=2Ec</span><br><span>index d992097=2E=2Ee147913 100644</sp=
an><br><span>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/openvp=
n/env_set=2Ec</span><br><span>@@ -209,32 +209,6 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-env_set_print(msglvl_t msglevel, const struct env_set *es)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (check_debug_level(msglevel))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const struct env_item *e;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (es)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          e =3D es-&gt;list;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            whi=
le (e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (env=
_safe_to_print(e-&gt;string))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    msg(msglevel, &quot;ENV [%d] &#39;%s&#39;&quot;, i,=
 e-&gt;string);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      ++i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     e =3D e-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span> env_set_write_file(const char *path, const struct env_=
set *es)</span><br><span> {</span><br><span>     FILE *fp =3D platform_fope=
n(path, &quot;w&quot;);</span><br><span>@@ -411,15 +385,6 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-setenv_int_i(struct env_set *es, const char *name, c=
onst int value, const int i)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const char *name_str =3D setenv_format_indexed_name(name, i, &amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_int(es, n=
ame_str, value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-void</span><br><span> setenv_str_i(struct env_=
set *es, const char *name, const char *value, const int i)</span><br><span>=
 {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>di=
ff --git a/src/openvpn/env_set=2Eh b/src/openvpn/env_set=2Eh</span><br><spa=
n>index fcfc3ca=2E=2E9b4a1e7 100644</span><br><span>--- a/src/openvpn/env_s=
et=2Eh</span><br><span>+++ b/src/openvpn/env_set=2Eh</span><br><span>@@ -69=
,8 +69,6 @@</span><br><span>  */</span><br><span> void setenv_str_incr(stru=
ct env_set *es, const char *name, const char *value);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void setenv_int_i(struct =
env_set *es, const char *name, const int value, const int i);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void setenv_str_i=
(struct env_set *es, const char *name, const char *value, const int i);</sp=
an><br><span> </span><br><span> /* struct env_set functions */</span><br><s=
pan>@@ -85,8 +83,6 @@</span><br><span> </span><br><span> const char *env_se=
t_get(const struct env_set *es, const char *name);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void env_set_print(msglvl_t =
msglevel, const struct env_set *es);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> /**</span><br><span>  * Write a struct env=
_set to a file=2E Each item on one line=2E</span><br><span>  *</span><br><s=
pan>diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh</span><br><s=
pan>index 40ed161=2E=2Eb784dfe 100644</span><br><span>--- a/src/openvpn/eve=
nt=2Eh</span><br><span>+++ b/src/openvpn/event=2Eh</span><br><span>@@ -190,=
13 +190,6 @@</span><br><span>     return ret;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-event_set_return_=
init(struct event_set_return *esr)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    esr=
-&gt;rwflags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  esr-&gt;arg =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
#ifdef _WIN32</span><br><span> </span><br><span> static inline void</span><=
br><span>diff --git a/src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh</=
span><br><span>index f6d3503=2E=2E59051bd 100644</span><br><span>--- a/src/=
openvpn/interval=2Eh</span><br><span>+++ b/src/openvpn/interval=2Eh</span><=
br><span>@@ -255,47 +255,4 @@</span><br><span>  */</span><br><span> bool ev=
ent_timeout_trigger(struct event_timeout *et, struct timeval *tv, int et_co=
nst_retry);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Measure =
time intervals in microseconds</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX 60 /* m=
aximum interval size in seconds */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-struct usec_timer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval s=
tart;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timev=
al end;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef HAVE_GETTIMEOFDAY</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
usec_timer_start(struct usec_timer *obj)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   CLEAR(*obj);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    op=
envpn_gettimeofday(&amp;obj-&gt;start, NULL);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_end(struc=
t usec_timer *obj)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_gettimeofda=
y(&amp;obj-&gt;end, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_GETTIMEOFDAY */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-usec_timer_interval_defined(struct usec_timer *obj)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return obj-&gt;start=2Etv_sec &amp;&a=
mp; obj-&gt;end=2Etv_sec;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-usec_timer_interval(struct usec_timer *ob=
j)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return tv_subtract(&amp;obj-&gt;end=
, &amp;obj-&gt;start, USEC_TIMER_MAX);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> #endif /* INTERVAL_H */</span><br><span>diff --git a/src/ope=
nvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 27d3b60=2E=
=2E1be3549 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><s=
pan>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -158,12 +158,6 @@</span=
><br><span>     return h-&gt;size;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-log_history_capacity(const st=
ruct log_history *h)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return h-&gt;capa=
city;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span=
>  * Callbacks for &#39;status&#39; and &#39;kill&#39; commands=2E</span><b=
r><span>  * Also for management-based deferred authentication and packet fi=
lter=2E</span><br><span>diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/m=
route=2Eh</span><br><span>index 2f5d019=2E=2E8d437c6 100644</span><br><span=
>--- a/src/openvpn/mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh<=
/span><br><span>@@ -249,24 +249,4 @@</span><br><span>     dest-&gt;v4=2Eadd=
r =3D htonl(src);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static inline in_addr_t</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-in_addr_t_from_mroute_addr(const struct =
mroute_addr *addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((addr-&gt;type =
&amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 &amp;&amp; addr-&gt;netbits =3D=3D =
0 &amp;&amp; addr-&gt;len =3D=3D 4)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return ntohl(addr-&gt;v4=2Eaddr);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mroute_addr_rese=
t(struct mroute_addr *ma)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ma-&gt;len =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ma-&gt;type=
 =3D MR_ADDR_NONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endi=
f /* MROUTE_H */</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/sr=
c/openvpn/multi_io=2Ec</span><br><span>index d8cc708=2E=2Ebb1fbce 100644</s=
pan><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/open=
vpn/multi_io=2Ec</span><br><span>@@ -661,12 +661,3 @@</span><br><span> </sp=
an><br><span>     } while (action !=3D TA_UNDEF);</span><br><span> }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-multi_io_delete_event(struct multi_io *multi_io, event_t event)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (multi_io &amp;&amp; multi_io-&gt;es=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        event_del(multi_io-&gt;es, e=
vent);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/=
src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index f38=
660f=2E=2E5e1f680 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</spa=
n><br><span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -31,7 +31,6 @@=
</span><br><span> #include &quot;multi=2Eh&quot;</span><br><span> #include =
&quot;win32=2Eh&quot;</span><br><span> #include &quot;platform=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;string=2E=
h&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/plugin=2Ec b/src=
/openvpn/plugin=2Ec</span><br><span>index f8adde5=2E=2E29f9327 100644</span=
><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/p=
lugin=2Ec</span><br><span>@@ -993,24 +993,4 @@</span><br><span>     pr-&gt;=
n =3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-plugin_return_print(const msglvl_t msglevel, const char *prefix, const=
 struct plugin_return *pr)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglevel, &quot;PL=
UGIN_RETURN_PRINT %s&quot;, prefix);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    for (i =3D 0; i &lt; pr-&gt;n; ++i)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct openvpn_plugin_string_list *l =3D pr-&gt;li=
st[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int cou=
nt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;PLUGI=
N #%d (%s)&quot;, i, prefix);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        while (l)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(msglevel, &quot;[%d] &#39;%s&#39; -&gt; &#39;%s&#39;&quot;, ++count=
, l-&gt;name, l-&gt;value);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            l =3D l-&gt;next;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</s=
pan><br><span> #endif /* ENABLE_PLUGIN */</span><br><span>diff --git a/src/=
openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><span>index 7e9faf3=
=2E=2Eb5fb916 100644</span><br><span>--- a/src/openvpn/plugin=2Eh</span><br=
><span>+++ b/src/openvpn/plugin=2Eh</span><br><span>@@ -135,10 +135,6 @@</s=
pan><br><span> </span><br><span> void plugin_return_free(struct plugin_retu=
rn *pr);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void plugin_return_print(const msglvl_t msglevel, const char *prefix, co=
nst struct plugin_return *pr);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span> </span><br><span> static inline int</span><br><span> plugin_n(c=
onst struct plugin_list *pl)</span><br><span>diff --git a/src/openvpn/route=
=2Ec b/src/openvpn/route=2Ec</span><br><span>index 81ce867=2E=2E1e0f0b3 100=
644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/o=
penvpn/route=2Ec</span><br><span>@@ -185,19 +185,6 @@</span><br><span>     =
dest-&gt;gc =3D a;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-route_string(const struct route_ipv4 *r, st=
ruct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =
=3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    buf_printf(&amp;out, &quot;ROUTE network %s netmask %s gateway %s&=
quot;, print_in_addr_t(r-&gt;network, 0, gc),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               print_in_addr_t(r-&gt;netmask, 0, gc=
), print_in_addr_t(r-&gt;gateway, 0, gc));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot; metric %d&q=
uot;, r-&gt;metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&=
amp;out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</s=
pan><br><span> is_route_parm_defined(const char *parm)</span><br><span> {</=
span><br><span>@@ -1325,27 +1312,6 @@</span><br><span> #endif /* ifndef ENA=
BLE_SMALL */</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-print_route(const struct route_ipv4 *=
r, msglvl_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (r-&gt;flags &amp; RT_DEFINED)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   msg(msglevel, &quot;%s&quot;, route_string(r, &amp;gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-print_routes(const struct route_list=
 *rl, msglvl_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct route_=
ipv4 *r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (r =
=3D rl-&gt;routes; r; r =3D r-&gt;next)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        print_route(r, msglevel);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span> setenv_route(s=
truct env_set *es, const struct route_ipv4 *r, int i)</span><br><span> {</s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>diff --=
git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 8=
8107e9=2E=2E0d33d36 100644</span><br><span>--- a/src/openvpn/route=2Eh</spa=
n><br><span>+++ b/src/openvpn/route=2Eh</span><br><span>@@ -377,8 +377,6 @@=
</span><br><span> </span><br><span> #endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void print_routes(const struct route=
_list *rl, msglvl_t msglevel);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> </span><br><span>=
 void show_routes(msglvl_t msglevel);</span><br><span>@@ -409,19 +407,6 @@<=
/span><br><span>     return mask;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-route_list_vpn_gateway_needed=
(const struct route_list *rl)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!rl)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return !(rl-&gt;spec=2Eflags &amp; RTSA_REMOTE_ENDPOINT);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static inline int</span><br><span> route_did_redirect_de=
fault_gateway(const struct route_list *rl)</span><br><span> {</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c6=
5b835360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--Xtvygbqlsk4=--


--===============5507865299433432755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5507865299433432755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5507865299433432755==--

