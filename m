Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E09C531FC
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVIMemVdlqYaotBWHQ7S7HRPQPiLJFezlq6l2APLQws=; b=eqjRoeGXaSnxcKkLTYo86c/tf1
	GMC3g8HW6HqDTs4RvOSUqlG1BJrxwLLASaZrHNB3fyrsTSi11WyY4BedbM+mx8z/zT8nioMQD37+U
	mQQa3Ry9AyBQA9XT8ctUD/Wu7Ntyb+s3rf/ZRDCFmKLZIcPCqX/lVGSqP66gwwG/n1oY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woMRW-0002Tp-Vo;
	Mon, 27 Jul 2026 14:36:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woMRV-0002Tj-3S
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0SGhFPgq1RmD3k5dBQOUoujqlJ9BBuCcY2cOAIOylOw=; b=CirjsqzqYa7+UiUV3vUPkDqFgV
 Nq5y/LOzgcjQu/k/g6FJvr6NEGI1UreZp1uuSkPBNd89TmxxlM7M2CWUngtfppXYwGkDrl1tgeweq
 XPZBmo0MiPR6GW8KaWafq929QCSDgNaHXAlpy+fiDALtyNj7z2HlUH7gbYOvP4wceHVo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0SGhFPgq1RmD3k5dBQOUoujqlJ9BBuCcY2cOAIOylOw=; b=D
 xfpd42cjy8si7+Y33SDMJj0W6c01pSc7/VBN1Xtic1lllaGgSoyzANK5r/FUU4BUiQceg8k+/DQvU
 BbudvTTdh6sM44qybuFaPrIZXHwrBlXS+rBhmME5O0WcEAKpIQLx4tzm+HDNZPoOuvcoJJC7h9mxi
 eLq6gOvGWanSYlyk=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woMRP-000086-8Y for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:36:30 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so25788755e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785162981; x=1785767781; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0SGhFPgq1RmD3k5dBQOUoujqlJ9BBuCcY2cOAIOylOw=;
 b=OPJfXJ/qpG6u0YkUHTCds4bg/ralwpjdEAugI50Xz+oq9MI9UcxOK1tJaFhVnzRYL+
 Uv0cyHmge2HWX1uaRMEoomEExMUPGMi0RWU0QYMOyh62ypNKop+DQ53UMaHLChwZmx4i
 9TGbxG3MNTktj3Pol8TJTnQriWz7Ke+cr3d6AxOfFKeKlIi9ZOwOQCYRHFGuehGq/Swo
 6BPclZckx+Ww4emGZCtt5RTkbf+7iB/6uUe8L7rBH8q26eSfNTNm4mNn4NZpcOX3I51Q
 dlP23nnRVeAHYERhCbFuG3g38q0VvpRxv3M70/ieKBbYVguki5j+to7RX8W4kkM1OZXr
 aMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785162981; x=1785767781;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0SGhFPgq1RmD3k5dBQOUoujqlJ9BBuCcY2cOAIOylOw=;
 b=UvGnqEXGrtpX9ChdhW44qGJLNv9GY1xnWa4CPrqDV8osrivmas2haxvogm9opv/KA+
 tgZh2tjR5h9Xk3MQXnxxdsjm44pxjkMGdgkqtkW36TLwrfy6S3lflBhbP2XvheljI9hE
 qzePoFnidBFSxxWGBBeUrKHI8zZug8Lu23ynaQUl+NkrqAx37AKyBhbw45cDjJrF31YO
 s57qxGiSMELiQlWFU0nGsd1LBK3LWobKl0STmReAZeKJc4TF9/Ay6+v2neGvYe0IpX6P
 kV3MyDHj55SJM9PfNK7RqleMx6mvrJfRJqoltiBifJtD/LyZOeOXytV8eKIOW8eAu8Bv
 Ie5g==
X-Gm-Message-State: AOJu0YzJ9K8pkwAM7/DYIEOZL/b5JSnVn7kobicDmUGJt3Zlz7KfJ5dO
 Sy+MfcJS2w7rHbMav8tIXCLoFYcaLxxOuRLoTLB4Jj4SykcQL8mFvBuLrO7kqLRBf7atJZbDPkW
 TVTVmxRKpEhmy46YVe++gQhg49teboS6p371C0RaF9TSA5hak4TBrCH2vbjfdC2z/+mCo
X-Gm-Gg: AR+sD12KiklpHma10tc+ocv2rsjlfiuDfuOmWUGtc+zuILmqpFRUKUJSC1YYJ50n194
 qWXaNH5/TnrI6ie0T8boRD11112EXqOAKYKib1/2q+BK2gokiQuljVhYKgOHmgR8jcM1F78gH8H
 +kAooJ6m6k3pjOI+jgb1hmkCQkxBV1RogQxBtWxl70tq0KJQDNKRHQmf3ID29P4EHNw/MgnvOuJ
 rWh0wm+umyLSHOOElVY7l9N/HReUduHsGQ9RadePkE035VVI6j+bjr278o4vsrjzIHxAfKsdMWc
 ut6AkTc61ofZtVoxk3qbkAAF2uWmtC4THEc22E4Lamru5qgfDDfOlMfpJcm7XpxzPWMdW+3pjul
 tvpPoMdLZNMNQpVImQkAyvCX12cOzzxLhL4oDjdunRWiCvMpEHS9aWnVf+4r3HAqhPtNnwVt7F9
 CR1GAdbuXCBhuUtnu/sQzeKr68bs0QEjHxBDGz8KpbWR5xH5oFAl/yNRWtnBq3mYtM3A0GS/k4y
 Cbo/WN37Hx9ursrqfWlylYSKI2gLkAN4hOpYcFshifIcTikaI99Jo+DHAcSryP3+EZu
X-Received: by 2002:a05:600c:4c99:b0:495:3aac:1098 with SMTP id
 5b1f17b1804b1-496b570814fmr70730485e9.32.1785162980260; 
 Mon, 27 Jul 2026 07:36:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c7880dsm49734820f8f.37.2026.07.27.07.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:36:19 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 14:36:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: d4ac557dff6eade0e50ded1786fa181153052d4e
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a14c76ae224354ac5814cdb1f1bcd03189b96769-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woMRP-000086-8Y
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
Content-Type: multipart/mixed; boundary="===============4453013400482995832=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4453013400482995832==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0GY/ciy2O1o="; charset=UTF-8

--0GY/ciy2O1o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610?usp=3Demail

to look at the new patch set (#11)=2E
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
18 files changed, 1 insertion(+), 272 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/1610/11

diff --git=
 a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 1db9367=2E=2E833ae=
6f 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -813=
,30 +813,8 @@
     return ntohs(ret);
 }
 
-static inline uint32_t
-buf_rea=
d_u32(struct buffer *buf, bool *good)
-{
-    uint32_t ret;
-    if (!buf_r=
ead(buf, &ret, sizeof(uint32_t)))
-    {
-        if (good)
-        {
-   =
         *good =3D false;
-        }
-        return 0;
-    }
-    else
- =
   {
-        if (good)
-        {
-            *good =3D true;
-        }
=
-        return ntohl(ret);
-    }
-}
-
 /* Read a 64-bit big-endian value =
(see buf_write_u64())=2E Sets *good to indicate
- * success, like buf_read_=
u32()=2E */
+ * success=2E */
 static inline uint64_t
 buf_read_u64(struct =
buffer *buf, bool *good)
 {
@@ -1050,12 +1028,6 @@
 
 void x_gc_freespecial=
(struct gc_arena *a);
 
-static inline bool
-gc_defined(struct gc_arena *a)=

-{
-    return a->list !=3D NULL;
-}
-
 static inline void
 gc_init(struct=
 gc_arena *a)
 {
diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/=
crypto_backend=2Eh
index b602ba1=2E=2E360abbe 100644
--- a/src/openvpn/cryp=
to_backend=2Eh
+++ b/src/openvpn/crypto_backend=2Eh
@@ -579,15 +579,6 @@
 v=
oid md_ctx_cleanup(md_ctx_t *ctx);
 
 /*
- * Returns the size of the messag=
e digest output by the given context
- *
- * @param ctx           Message d=
igest context=2E
- *
- * @return              Size of the message digest, o=
r \0 if ctx is NULL=2E
- */
-int md_ctx_size(const md_ctx_t *ctx);
-
-/*
  =
* Process the given data for use in the message digest=2E
  *
  * @param ct=
x           Message digest context=2E May not be NULL=2E
diff --git a/src/o=
penvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 6662def=2E=
=2E665257c0 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/c=
rypto_mbedtls=2Ec
@@ -718,16 +718,6 @@
     ASSERT(psa_hash_abort(&ctx->ope=
ration) =3D=3D PSA_SUCCESS);
 }
 
-int
-md_ctx_size(const md_ctx_t *ctx)
-{=

-    if (ctx =3D=3D NULL)
-    {
-        return 0;
-    }
-    return (in=
t)PSA_HASH_LENGTH(ctx->md_info->psa_alg);
-}
-
 void
 md_ctx_update(md_ctx_=
t *ctx, const uint8_t *src, size_t src_len)
 {
diff --git a/src/openvpn/cry=
pto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
index debd53=
d=2E=2E6556358 100644
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src=
/openvpn/crypto_mbedtls_legacy=2Ec
@@ -856,16 +856,6 @@
     mbedtls_md_fre=
e(ctx);
 }
 
-int
-md_ctx_size(const mbedtls_md_context_t *ctx)
-{
-    if =
(NULL =3D=3D ctx)
-    {
-        return 0;
-    }
-    return (int)mbedtls=
_md_get_size(mbedtls_md_info_from_ctx(ctx));
-}
-
 void
 md_ctx_update(mbed=
tls_md_context_t *ctx, const uint8_t *src, size_t src_len)
 {
diff --git a/=
src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index fa9eb=
67=2E=2E57d51f4 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openv=
pn/crypto_openssl=2Ec
@@ -1141,12 +1141,6 @@
     EVP_MD_CTX_reset(ctx);
 }=

 
-int
-md_ctx_size(const EVP_MD_CTX *ctx)
-{
-    return (int)EVP_MD_CTX_=
size(ctx);
-}
-
 void
 md_ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, s=
ize_t src_len)
 {
diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_wi=
n=2Eh
index ac3ce33=2E=2Ea92e5ad 100644
--- a/src/openvpn/dco_win=2Eh
+++ b=
/src/openvpn/dco_win=2Eh
@@ -65,8 +65,6 @@
 void dco_p2p_new_peer(HANDLE ha=
ndle, OVERLAPPED *ov, struct link_socket *sock,
                       stru=
ct signal_info *sig_info);
 
-void dco_start_tun(struct tuntap *tt);
-
 boo=
l dco_win_supports_multipeer(void);
 
 void dco_win_add_iroute_ipv4(dco_con=
text_t *dco, in_addr_t dst, unsigned int netbits,
@@ -79,13 +77,5 @@
 
 voi=
d dco_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned=
 int netbits);
 
-#else  /* if defined(ENABLE_DCO) && defined(_WIN32) */
-
=
-static inline void
-dco_start_tun(struct tuntap *tt)
-{
-    ASSERT(false)=
;
-}
-
 #endif /* defined(_WIN32) */
 #endif /* ifndef DCO_H */
diff --git =
a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index d992097=2E=2Ee147=
913 100644
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/env_set=2Ec
@@ -=
209,32 +209,6 @@
 }
 
 void
-env_set_print(msglvl_t msglevel, const struct =
env_set *es)
-{
-    if (check_debug_level(msglevel))
-    {
-        const=
 struct env_item *e;
-        int i;
-
-        if (es)
-        {
-       =
     e =3D es->list;
-            i =3D 0;
-
-            while (e)
-      =
      {
-                if (env_safe_to_print(e->string))
-               =
 {
-                    msg(msglevel, "ENV [%d] '%s'", i, e->string);
-    =
            }
-                ++i;
-                e =3D e->next;
-      =
      }
-        }
-    }
-}
-
-void
 env_set_write_file(const char *path, =
const struct env_set *es)
 {
     FILE *fp =3D platform_fopen(path, "w");
@=
@ -411,15 +385,6 @@
 }
 
 void
-setenv_int_i(struct env_set *es, const char=
 *name, const int value, const int i)
-{
-    struct gc_arena gc =3D gc_new=
();
-    const char *name_str =3D setenv_format_indexed_name(name, i, &gc);=

-    setenv_int(es, name_str, value);
-    gc_free(&gc);
-}
-
-void
 seten=
v_str_i(struct env_set *es, const char *name, const char *value, const int =
i)
 {
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/env_se=
t=2Eh b/src/openvpn/env_set=2Eh
index fcfc3ca=2E=2E9b4a1e7 100644
--- a/src=
/openvpn/env_set=2Eh
+++ b/src/openvpn/env_set=2Eh
@@ -69,8 +69,6 @@
  */
 =
void setenv_str_incr(struct env_set *es, const char *name, const char *valu=
e);
 
-void setenv_int_i(struct env_set *es, const char *name, const int va=
lue, const int i);
-
 void setenv_str_i(struct env_set *es, const char *nam=
e, const char *value, const int i);
 
 /* struct env_set functions */
@@ -8=
5,8 +83,6 @@
 
 const char *env_set_get(const struct env_set *es, const cha=
r *name);
 
-void env_set_print(msglvl_t msglevel, const struct env_set *es=
);
-
 /**
  * Write a struct env_set to a file=2E Each item on one line=2E
=
  *
diff --git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh
index 40ed16=
1=2E=2Eb784dfe 100644
--- a/src/openvpn/event=2Eh
+++ b/src/openvpn/event=
=2Eh
@@ -190,13 +190,6 @@
     return ret;
 }
 
-static inline void
-event_=
set_return_init(struct event_set_return *esr)
-{
-    esr->rwflags =3D 0;
-=
    esr->arg =3D NULL;
-}
-
 #ifdef _WIN32
 
 static inline void
diff --git=
 a/src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh
index f6d3503=2E=2E5=
9051bd 100644
--- a/src/openvpn/interval=2Eh
+++ b/src/openvpn/interval=2Eh=

@@ -255,47 +255,4 @@
  */
 bool event_timeout_trigger(struct event_timeout=
 *et, struct timeval *tv, int et_const_retry);
 
-/*
- * Measure time inter=
vals in microseconds
- */
-
-#define USEC_TIMER_MAX 60 /* maximum interval =
size in seconds */
-
-#define USEC_TIMER_MAX_USEC (USEC_TIMER_MAX * 1000000=
)
-
-struct usec_timer
-{
-    struct timeval start;
-    struct timeval en=
d;
-};
-
-#ifdef HAVE_GETTIMEOFDAY
-
-static inline void
-usec_timer_start(=
struct usec_timer *obj)
-{
-    CLEAR(*obj);
-    openvpn_gettimeofday(&obj=
->start, NULL);
-}
-
-static inline void
-usec_timer_end(struct usec_timer =
*obj)
-{
-    openvpn_gettimeofday(&obj->end, NULL);
-}
-
-#endif /* HAVE_G=
ETTIMEOFDAY */
-
-static inline bool
-usec_timer_interval_defined(struct us=
ec_timer *obj)
-{
-    return obj->start=2Etv_sec && obj->end=2Etv_sec;
-}
=
-
-static inline int
-usec_timer_interval(struct usec_timer *obj)
-{
-    r=
eturn tv_subtract(&obj->end, &obj->start, USEC_TIMER_MAX);
-}
-
 #endif /* =
INTERVAL_H */
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
=
index 27d3b60=2E=2E1be3549 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/op=
envpn/manage=2Eh
@@ -158,12 +158,6 @@
     return h->size;
 }
 
-static inl=
ine int
-log_history_capacity(const struct log_history *h)
-{
-    return h=
->capacity;
-}
-
 /*
  * Callbacks for 'status' and 'kill' commands=2E
  * =
Also for management-based deferred authentication and packet filter=2E
diff=
 --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2f5d019=2E=
=2E8d437c6 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh=

@@ -249,24 +249,4 @@
     dest->v4=2Eaddr =3D htonl(src);
 }
 
-static inl=
ine in_addr_t
-in_addr_t_from_mroute_addr(const struct mroute_addr *addr)
-=
{
-    if ((addr->type & MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 && addr->netbits=
 =3D=3D 0 && addr->len =3D=3D 4)
-    {
-        return ntohl(addr->v4=2Ead=
dr);
-    }
-    else
-    {
-        return 0;
-    }
-}
-
-static inline =
void
-mroute_addr_reset(struct mroute_addr *ma)
-{
-    ma->len =3D 0;
-   =
 ma->type =3D MR_ADDR_NONE;
-}
-
 #endif /* MROUTE_H */
diff --git a/src/op=
envpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index d8cc708=2E=2Ebb1fbce 10=
0644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -661,=
12 +661,3 @@
 
     } while (action !=3D TA_UNDEF);
 }
-
-void
-multi_io_de=
lete_event(struct multi_io *multi_io, event_t event)
-{
-    if (multi_io &=
& multi_io->es)
-    {
-        event_del(multi_io->es, event);
-    }
-}
d=
iff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index f38660f=
=2E=2E5e1f680 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvp=
n=2Ec
@@ -31,7 +31,6 @@
 #include "multi=2Eh"
 #include "win32=2Eh"
 #inclu=
de "platform=2Eh"
-#include "string=2Eh"
 
 #include "memdbg=2Eh"
 
diff --=
git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index f8adde5=2E=2E29=
f9327 100644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -=
993,24 +993,4 @@
     pr->n =3D 0;
 }
 
-#ifdef ENABLE_DEBUG
-void
-plugin_=
return_print(const msglvl_t msglevel, const char *prefix, const struct plug=
in_return *pr)
-{
-    int i;
-    msg(msglevel, "PLUGIN_RETURN_PRINT %s", =
prefix);
-    for (i =3D 0; i < pr->n; ++i)
-    {
-        struct openvpn_=
plugin_string_list *l =3D pr->list[i];
-        int count =3D 0;
-
-       =
 msg(msglevel, "PLUGIN #%d (%s)", i, prefix);
-        while (l)
-        {=

-            msg(msglevel, "[%d] '%s' -> '%s'", ++count, l->name, l->value=
);
-            l =3D l->next;
-        }
-    }
-}
-#endif /* ifdef ENABLE=
_DEBUG */
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvpn/plugin=2Eh b=
/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2Eb5fb916 100644
--- a/src/openvpn=
/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,10 +135,6 @@
 
 void plugi=
n_return_free(struct plugin_return *pr);
 
-#ifdef ENABLE_DEBUG
-void plugi=
n_return_print(const msglvl_t msglevel, const char *prefix, const struct pl=
ugin_return *pr);
-
-#endif
 
 static inline int
 plugin_n(const struct plu=
gin_list *pl)
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
in=
dex 8ea745d=2E=2E6dbe3ec 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openv=
pn/route=2Ec
@@ -185,19 +185,6 @@
     dest->gc =3D a;
 }
 
-static const c=
har *
-route_string(const struct route_ipv4 *r, struct gc_arena *gc)
-{
-  =
  struct buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&out, "ROUTE=
 network %s netmask %s gateway %s", print_in_addr_t(r->network, 0, gc),
-  =
             print_in_addr_t(r->netmask, 0, gc), print_in_addr_t(r->gateway=
, 0, gc));
-    if (r->flags & RT_METRIC_DEFINED)
-    {
-        buf_print=
f(&out, " metric %d", r->metric);
-    }
-    return BSTR(&out);
-}
-
 stat=
ic bool
 is_route_parm_defined(const char *parm)
 {
@@ -1325,27 +1312,6 @@
=
 #endif /* ifndef ENABLE_SMALL */
 
 static void
-print_route(const struct =
route_ipv4 *r, msglvl_t msglevel)
-{
-    struct gc_arena gc =3D gc_new();
=
-    if (r->flags & RT_DEFINED)
-    {
-        msg(msglevel, "%s", route_s=
tring(r, &gc));
-    }
-    gc_free(&gc);
-}
-
-void
-print_routes(const st=
ruct route_list *rl, msglvl_t msglevel)
-{
-    struct route_ipv4 *r;
-    =
for (r =3D rl->routes; r; r =3D r->next)
-    {
-        print_route(r, msg=
level);
-    }
-}
-
-static void
 setenv_route(struct env_set *es, const st=
ruct route_ipv4 *r, int i)
 {
     struct gc_arena gc =3D gc_new();
diff --=
git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh
index 88107e9=2E=2E0d33=
d36 100644
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -377,=
8 +377,6 @@
 
 #endif
 
-void print_routes(const struct route_list *rl, msg=
lvl_t msglevel);
-
 #ifdef _WIN32
 
 void show_routes(msglvl_t msglevel);
@=
@ -409,19 +407,6 @@
     return mask;
 }
 
-static inline bool
-route_list_=
vpn_gateway_needed(const struct route_list *rl)
-{
-    if (!rl)
-    {
-  =
      return false;
-    }
-    else
-    {
-        return !(rl->spec=2Efl=
ags & RTSA_REMOTE_ENDPOINT);
-    }
-}
-
 static inline int
 route_did_redi=
rect_default_gateway(const struct route_list *rl)
 {

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360=
b5
Gerrit-Change-Number: 1610
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--0GY/ciy2O1o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #11</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
vpn/route=2Ec<br>M src/openvpn/route=2Eh<br>18 files changed, 1 insertion(+=
), 272 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/10/1610/11</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 1db9367=2E=
=2E833ae6f 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br><s=
pan>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -813,30 +813,8 @@</span=
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
, 100%, 40%);">-</span><br><span> /* Read a 64-bit big-endian value (see bu=
f_write_u64())=2E Sets *good to indicate</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * success, like buf_read_u32()=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * success=2E */</span><br><span> stat=
ic inline uint64_t</span><br><span> buf_read_u64(struct buffer *buf, bool *=
good)</span><br><span> {</span><br><span>@@ -1050,12 +1028,6 @@</span><br><=
span> </span><br><span> void x_gc_freespecial(struct gc_arena *a);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inlin=
e bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined(stru=
ct gc_arena *a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return a-&gt;list !=3D=
 NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline voi=
d</span><br><span> gc_init(struct gc_arena *a)</span><br><span> {</span><br=
><span>diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_bac=
kend=2Eh</span><br><span>index b602ba1=2E=2E360abbe 100644</span><br><span>=
--- a/src/openvpn/crypto_backend=2Eh</span><br><span>+++ b/src/openvpn/cryp=
to_backend=2Eh</span><br><span>@@ -579,15 +579,6 @@</span><br><span> void m=
d_ctx_cleanup(md_ctx_t *ctx);</span><br><span> </span><br><span> /*</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns the size of the me=
ssage digest output by the given context</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param ctx           Message digest context=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @return              Size of the message digest, or \0 if ctx i=
s NULL=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int md_ctx_size(const md_ctx_t=
 *ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Process the =
given data for use in the message digest=2E</span><br><span>  *</span><br><=
span>  * @param ctx           Message digest context=2E May not be NULL=2E<=
/span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/c=
rypto_mbedtls=2Ec</span><br><span>index 6662def=2E=2E665257c0 100644</span>=
<br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/op=
envpn/crypto_mbedtls=2Ec</span><br><span>@@ -718,16 +718,6 @@</span><br><sp=
an>     ASSERT(psa_hash_abort(&amp;ctx-&gt;operation) =3D=3D PSA_SUCCESS);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_=
ctx_size(const md_ctx_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ctx =
=3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return (int)PSA_HASH_LENGTH(ctx-&gt;md_=
info-&gt;psa_alg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void<=
/span><br><span> md_ctx_update(md_ctx_t *ctx, const uint8_t *src, size_t sr=
c_len)</span><br><span> {</span><br><span>diff --git a/src/openvpn/crypto_m=
bedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>i=
ndex debd53d=2E=2E6556358 100644</span><br><span>--- a/src/openvpn/crypto_m=
bedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=
=2Ec</span><br><span>@@ -856,16 +856,6 @@</span><br><span>     mbedtls_md_f=
ree(ctx);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-md_ctx_size(const mbedtls_md_context_t *ctx)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (NULL =3D=3D ctx)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)mbedt=
ls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> void</span><br><span> md_ctx_update(mbedtls_md_conte=
xt_t *ctx, const uint8_t *src, size_t src_len)</span><br><span> {</span><br=
><span>diff --git a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_ope=
nssl=2Ec</span><br><span>index fa9eb67=2E=2E57d51f4 100644</span><br><span>=
--- a/src/openvpn/crypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/cryp=
to_openssl=2Ec</span><br><span>@@ -1141,12 +1141,6 @@</span><br><span>     =
EVP_MD_CTX_reset(ctx);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-md_ctx_size(const EVP_MD_CTX *ctx)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return (int)EVP_MD_CTX_size(ctx);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void</span><br><span> md_ctx_update(EVP_MD_CTX *=
ctx, const uint8_t *src, size_t src_len)</span><br><span> {</span><br><span=
>diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh</span><br><=
span>index ac3ce33=2E=2Ea92e5ad 100644</span><br><span>--- a/src/openvpn/dc=
o_win=2Eh</span><br><span>+++ b/src/openvpn/dco_win=2Eh</span><br><span>@@ =
-65,8 +65,6 @@</span><br><span> void dco_p2p_new_peer(HANDLE handle, OVERLA=
PPED *ov, struct link_socket *sock,</span><br><span>                       =
struct signal_info *sig_info);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void dco_start_tun(struct tuntap *tt);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool dco_win_=
supports_multipeer(void);</span><br><span> </span><br><span> void dco_win_a=
dd_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,</sp=
an><br><span>@@ -79,13 +77,5 @@</span><br><span> </span><br><span> void dco=
_win_del_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsigned int =
netbits);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#else  /* if defined(ENABLE_DCO) &amp;&amp; defined(_WIN32) */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-dco_start_tun(struct tuntap *tt)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(false);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> #endif /* defined(_WIN32) */</span><br><span> #endif /* ifndef DCO=
_H */</span><br><span>diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/en=
v_set=2Ec</span><br><span>index d992097=2E=2Ee147913 100644</span><br><span=
>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/openvpn/env_set=2E=
c</span><br><span>@@ -209,32 +209,6 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-env_set_print(msglvl_t msglevel, const struct env_set *es)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (check_debug_level(msglevel))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        const struct env_item *e;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e =3D=
 es-&gt;list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            while (e)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                if (env_safe_to_print(=
e-&gt;string))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         msg(msglevel, &quot;ENV [%d] &#39;%s&#39;&quot;, i, e-&gt;string);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                ++i;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                e =3D e-&g=
t;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><=
span> env_set_write_file(const char *path, const struct env_set *es)</span>=
<br><span> {</span><br><span>     FILE *fp =3D platform_fopen(path, &quot;w=
&quot;);</span><br><span>@@ -411,15 +385,6 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-setenv_int_i(struct env_set *es, const char *name, const int value,=
 const int i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *name_str =3D setenv_format_indexed_name(name, i, &amp;gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    setenv_int(es, name_str, value)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void</span><br><span> setenv_str_i(struct env_set *es, const =
char *name, const char *value, const int i)</span><br><span> {</span><br><s=
pan>     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/=
openvpn/env_set=2Eh b/src/openvpn/env_set=2Eh</span><br><span>index fcfc3ca=
=2E=2E9b4a1e7 100644</span><br><span>--- a/src/openvpn/env_set=2Eh</span><b=
r><span>+++ b/src/openvpn/env_set=2Eh</span><br><span>@@ -69,8 +69,6 @@</sp=
an><br><span>  */</span><br><span> void setenv_str_incr(struct env_set *es,=
 const char *name, const char *value);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void setenv_int_i(struct env_set *es, co=
nst char *name, const int value, const int i);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> void setenv_str_i(struct env_set=
 *es, const char *name, const char *value, const int i);</span><br><span> <=
/span><br><span> /* struct env_set functions */</span><br><span>@@ -85,8 +8=
3,6 @@</span><br><span> </span><br><span> const char *env_set_get(const str=
uct env_set *es, const char *name);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void env_set_print(msglvl_t msglevel, const=
 struct env_set *es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /**</span><br><span>  * Write a struct env_set to a file=
=2E Each item on one line=2E</span><br><span>  *</span><br><span>diff --git=
 a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh</span><br><span>index 40ed=
161=2E=2Eb784dfe 100644</span><br><span>--- a/src/openvpn/event=2Eh</span><=
br><span>+++ b/src/openvpn/event=2Eh</span><br><span>@@ -190,13 +190,6 @@</=
span><br><span>     return ret;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-event_set_return_init(struct ev=
ent_set_return *esr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    esr-&gt;rwflags =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    esr-&gt;arg=
 =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32=
</span><br><span> </span><br><span> static inline void</span><br><span>diff=
 --git a/src/openvpn/interval=2Eh b/src/openvpn/interval=2Eh</span><br><spa=
n>index f6d3503=2E=2E59051bd 100644</span><br><span>--- a/src/openvpn/inter=
val=2Eh</span><br><span>+++ b/src/openvpn/interval=2Eh</span><br><span>@@ -=
255,47 +255,4 @@</span><br><span>  */</span><br><span> bool event_timeout_t=
rigger(struct event_timeout *et, struct timeval *tv, int et_const_retry);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Measure time interval=
s in microseconds</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX 60 /* maximum interv=
al size in seconds */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define USEC_TIMER_MA=
X_USEC (USEC_TIMER_MAX * 1000000)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct us=
ec_timer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval start;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval end;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef HAVE_GETTIMEOFDAY</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inl=
ine void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_st=
art(struct usec_timer *obj)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*obj=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_gettime=
ofday(&amp;obj-&gt;start, NULL);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_end(struct usec_timer =
*obj)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp;obj-&g=
t;end, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif /* HAVE_GETTIMEOFDAY */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-usec_timer_interval_defined(struct usec_timer *obj)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return obj-&gt;start=2Etv_sec &amp;&amp; obj-&gt;e=
nd=2Etv_sec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-usec_timer_interval(struct usec_timer *obj)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return tv_subtract(&amp;obj-&gt;end, &amp;obj-&g=
t;start, USEC_TIMER_MAX);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> #endif /* INTERVAL_H */</span><br><span>diff --git a/src/openvpn/manage=
=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 27d3b60=2E=2E1be3549 10=
0644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src=
/openvpn/manage=2Eh</span><br><span>@@ -158,12 +158,6 @@</span><br><span>  =
   return h-&gt;size;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-log_history_capacity(const struct log_hist=
ory *h)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return h-&gt;capacity;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Callback=
s for &#39;status&#39; and &#39;kill&#39; commands=2E</span><br><span>  * A=
lso for management-based deferred authentication and packet filter=2E</span=
><br><span>diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</sp=
an><br><span>index 2f5d019=2E=2E8d437c6 100644</span><br><span>--- a/src/op=
envpn/mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh</span><br><sp=
an>@@ -249,24 +249,4 @@</span><br><span>     dest-&gt;v4=2Eaddr =3D htonl(s=
rc);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline in_addr_t</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-in_addr_t_from_mroute_addr(const struct mroute_addr *=
addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if ((addr-&gt;type &amp; MR_ADDR=
_MASK) =3D=3D MR_ADDR_IPV4 &amp;&amp; addr-&gt;netbits =3D=3D 0 &amp;&amp; =
addr-&gt;len =3D=3D 4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
ntohl(addr-&gt;v4=2Eaddr);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-mroute_addr_reset(struct mro=
ute_addr *ma)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ma-&gt;len =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ma-&gt;type =3D MR_ADDR_=
NONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* MROUTE_H=
 */</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/mul=
ti_io=2Ec</span><br><span>index d8cc708=2E=2Ebb1fbce 100644</span><br><span=
>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=
=2Ec</span><br><span>@@ -661,12 +661,3 @@</span><br><span> </span><br><span=
>     } while (action !=3D TA_UNDEF);</span><br><span> }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mul=
ti_io_delete_event(struct multi_io *multi_io, event_t event)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (multi_io &amp;&amp; multi_io-&gt;es)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        event_del(multi_io-&gt;es, event);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/openvpn/=
openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index f38660f=2E=2E5e=
1f680 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><span>=
+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -31,7 +31,6 @@</span><br><=
span> #include &quot;multi=2Eh&quot;</span><br><span> #include &quot;win32=
=2Eh&quot;</span><br><span> #include &quot;platform=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#include &quot;string=2Eh&quot;</sp=
an><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><=
span> </span><br><span>diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/pl=
ugin=2Ec</span><br><span>index f8adde5=2E=2E29f9327 100644</span><br><span>=
--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</=
span><br><span>@@ -993,24 +993,4 @@</span><br><span>     pr-&gt;n =3D 0;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin=
_return_print(const msglvl_t msglevel, const char *prefix, const struct plu=
gin_return *pr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg(msglevel, &quot;PLUGIN_RETURN=
_PRINT %s&quot;, prefix);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    for (i =3D 0; i &lt; pr-&gt;n; ++i)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        struct openvpn_plugin_string_list *l =3D pr-&gt;list[i];</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        int count =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;PLUGIN #%d (%s)=
&quot;, i, prefix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      while (l)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(ms=
glevel, &quot;[%d] &#39;%s&#39; -&gt; &#39;%s&#39;&quot;, ++count, l-&gt;na=
me, l-&gt;value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        l =3D l-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><=
span> #endif /* ENABLE_PLUGIN */</span><br><span>diff --git a/src/openvpn/p=
lugin=2Eh b/src/openvpn/plugin=2Eh</span><br><span>index 7e9faf3=2E=2Eb5fb9=
16 100644</span><br><span>--- a/src/openvpn/plugin=2Eh</span><br><span>+++ =
b/src/openvpn/plugin=2Eh</span><br><span>@@ -135,10 +135,6 @@</span><br><sp=
an> </span><br><span> void plugin_return_free(struct plugin_return *pr);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void plu=
gin_return_print(const msglvl_t msglevel, const char *prefix, const struct =
plugin_return *pr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>=
 </span><br><span> static inline int</span><br><span> plugin_n(const struct=
 plugin_list *pl)</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/=
openvpn/route=2Ec</span><br><span>index 8ea745d=2E=2E6dbe3ec 100644</span><=
br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/rout=
e=2Ec</span><br><span>@@ -185,19 +185,6 @@</span><br><span>     dest-&gt;gc=
 =3D a;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static const char *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-route_string(const struct route_ipv4 *r, struct gc_are=
na *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct buffer out =3D alloc_bu=
f_gc(256, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=
_printf(&amp;out, &quot;ROUTE network %s netmask %s gateway %s&quot;, print=
_in_addr_t(r-&gt;network, 0, gc),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-               print_in_addr_t(r-&gt;netmask, 0, gc), print_in_=
addr_t(r-&gt;gateway, 0, gc));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        buf_printf(&amp;out, &quot; metric %d&quot;, r-&gt;=
metric);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br><sp=
an> is_route_parm_defined(const char *parm)</span><br><span> {</span><br><s=
pan>@@ -1325,27 +1312,6 @@</span><br><span> #endif /* ifndef ENABLE_SMALL *=
/</span><br><span> </span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-print_route(const struct route_ipv4 *r, msglvl_t=
 msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (r-&gt;fl=
ags &amp; RT_DEFINED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msgl=
evel, &quot;%s&quot;, route_string(r, &amp;gc));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-print_routes(const struct route_list *rl, msglv=
l_t msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct route_ipv4 *r;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (r =3D rl-&gt;ro=
utes; r; r =3D r-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pri=
nt_route(r, msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static void</span><br><span> setenv_route(struct env_set=
 *es, const struct route_ipv4 *r, int i)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/ope=
nvpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 88107e9=2E=2E0=
d33d36 100644</span><br><span>--- a/src/openvpn/route=2Eh</span><br><span>+=
++ b/src/openvpn/route=2Eh</span><br><span>@@ -377,8 +377,6 @@</span><br><s=
pan> </span><br><span> #endif</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void print_routes(const struct route_list *rl, ms=
glvl_t msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> #ifdef _WIN32</span><br><span> </span><br><span> void show_ro=
utes(msglvl_t msglevel);</span><br><span>@@ -409,19 +407,6 @@</span><br><sp=
an>     return mask;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-route_list_vpn_gateway_needed(const struct=
 route_list *rl)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!rl)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return !(rl-=
&gt;spec=2Eflags &amp; RTSA_REMOTE_ENDPOINT);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> static inline int</span><br><span> route_did_redirect_default_gateway=
(const struct route_list *rl)</span><br><span> {</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>

</body></html>
--0GY/ciy2O1o=--


--===============4453013400482995832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4453013400482995832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4453013400482995832==--

