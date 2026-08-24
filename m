Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55074C5DF81
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MyEihGX4B25ngiLgvYvswZxvM9jywYfS4CFPSvMnqO0=; b=lf70Wjb3Q4mP526AMMN0MJqy1y
	t7hsEjo5bUy4hpHFviPFONgnP3eCYFyaZIFbWSK74vcjm5A3LqU4UvrImphIwPCXvY0t2uf/6Mnpt
	cXOtt0njmhst8zO3MrvKrG5/CCz6KuyRHYAIMq6Hvyyvp4tsczdMUZse72hmwp5D2EXM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySls-0001Ki-RA;
	Mon, 24 Aug 2026 11:23:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySlc-0001JM-NI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=O5vXwAnsTgzwYexgzxnDFEqqahCYCl4G8q1n3JFnMEE=; b=LhZ7d6Lr9U1eZ7aONpw8JKOYMH
 7FVQV0lPdeewp+uSqSChiv5J43tWhxMLtmDi5oQ6iIfjPKzuKeSdG8e5a4ndhUfCHjS3/N9IH7+RO
 6ubxOGpyLfZYFSrQBxjyAnfsU+d79MJ+zKaMdKvlWG9o/eytSCd9uqx79Fu74n2YSIP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O5vXwAnsTgzwYexgzxnDFEqqahCYCl4G8q1n3JFnMEE=; b=L
 An9h1225uikwluqXsz9MknzD++d8uUZ2ueRYdc4AKapmfCTF0L0HyBFOp3OLGgd/hV2DR2+FkKSMA
 +UDSrBM+mXJtbWaYflZYv+SHFFwgEdGt62m2wFWIHzfqaV/rH/REncRdPRWk/n9QQzUNFC75CAamx
 2qloqEG3LYgkYHKY=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySlb-0006yD-A1 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:05 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a20319d030so4979244a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570576; x=1788175376; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O5vXwAnsTgzwYexgzxnDFEqqahCYCl4G8q1n3JFnMEE=;
 b=OYeek4dOPXdzad4sChKjz0V14JBwLQyXrQtKLydnx4+SGbSXZMbXGHfmJuXGB05T4S
 Rrt6vNYs/FRAUgZCjVoI9HQXPSZBtFJu4qaSlIg9VYWqbSMTwcoNkprVueaOEmUOS9t1
 uRYAfW7AFEljv4378I6UqlxpeMjDFWZgc8XgM51rYa7YVuXP4Gpo4n0QQ8O3/KYCaS0S
 UBzoTfbDSJAquWobE6YQZtJ/ySWqh108xOEyEnBBjxnD90IoQmrMW2L0uWbOEaTv7gCG
 5cwkxfnWx8yc0oL/MCmtdMTy2deyla8+iNFuAxYsci6PBJ8113N0fK8NJvSlIKQxgs8S
 +ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570576; x=1788175376;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=O5vXwAnsTgzwYexgzxnDFEqqahCYCl4G8q1n3JFnMEE=;
 b=n2Ga3gRd2fSUqnK7h+mOgWqr8tH5mxsJ+GR/tmr9ISC6HL+eaUObIhv8Iw3bZKTfi8
 wO5DPnbSXVBAE6Yx4YT3KSUx7Hf76lKUZQKRUJnzuQSy72NAAwN9SfCdnsnnRql8Z88s
 ++2l+jWY73Jgwh4yHhX0AECxCAPk2StiXy2gYwmgnKOwJeTATg/3QmHlfzj3+h940Auy
 k56FWRpltyjqDYf4tf+cb8Y3Tf6k6BaJBcO+SDLrZc4SIbjf42VRWc9ARbrbBEZMA/Rb
 hNecPWF3phDmu7RPcJUMscHlCRzNTlM8p81JvxmRTxxA2XMugch0JO6c2gCOKYwqaWmS
 TNzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RquM0AEtA5MtVykUrBrmLynr+NTwJQ65TednJ2BJ2tfOMXxRsiTNs1lJVUnOofdzTWqGJ5HtX5hibDUZ2QE@lists.sourceforge.net
X-Gm-Message-State: AFuF++nC2y9S8vuiQI/3U+zTWggNIuBhiqr62QyydzKXHMefpiCWKnEx
 QoAlgxEBC/NWFF2lsTuwK7XsmyNyzS5dWmz/oP5IYTATVRPoFB6b66GjUhv77zrIhMPl3tIfDO6
 UDpznznyfVbi6fu5xmR3hopn/xhoVyxbtVy8z1xMh5MzDStZOTtgt5ZFe7eSTOU5C8VS+
X-Gm-Gg: AR+sD13UCTaKZFei5YOtSRtRPPgii7iiEf536fJOisEuB7dXpNuIaGFhaiXMln4BtjS
 FNHs8my8LnBDf9Wt83pV4NJs4eN+Qb+qeJ0gdNWqZmTyOKGX+yEhyXS3L8ZuOAPF1Ra/gB9xt0x
 e9ioE1nrqtFU1FpLoqCRCXP9+cQTW593u+EyUPNjbtiyfgHMg5QXuEwzJMy2L9lQWqLRsYzVmqm
 KzJpbpuywlCH6Jf1eENgUHRFvn94uOuZ2M1W+qB+Fmzvs6wdaSUhcQjljrXukDSRKeASZoK0gc8
 cWUlo0W8Q1bIkhLFeE5L6JYm1OJGRMh+Akbfg45nOy1f3kHmfZ+fAfMyqe2rRAIOSYRRoSsat5K
 M2UigJtbOoWEunJ/PWW8JOTny48te5WEkPwLZi5uQU3rxcTwAF6mmBh99HeCAe6i78mN2/RPNwg
 jr1n+TrwHMBum+sF7EAZPVZQlXfZ+R2Zopn1u7PdICbUwFdmAZoT2QM4iFAjhIReS/lzb7ToqbI
 PIyU6qw4eIL2O+bv907LpOKQdnHZ+q8DPxjn4GSuwiD/o+FOcSU0yqn0sbQzoGLXi4LgGUmWnpM
 8WQPp0jaJVY9K16/rYLtwVPDYY9Mwdr+sPTqzou8yi/ypE9/zPQ=
X-Received: by 2002:a17:907:7b83:b0:c20:fe93:a86 with SMTP id
 a640c23a62f3a-c246a62b495mr3259654166b.18.1787570575823; 
 Mon, 24 Aug 2026 04:22:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496734bfcsm1295012466b.43.2026.08.24.04.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:22:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:22:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 580974871f6664ce68e8f5e0034a27970063d7bf
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18f07e371011d122d8e1321515e20b77bd1dda8d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySlb-0006yD-A1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8219964679444817174=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8219964679444817174==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="59JiM6imh98="; charset=UTF-8

--59JiM6imh98=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

He=
llo plaisthos, stipa, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail

to look at=
 the new patch set (#15)=2E


Change subject: Remove various unused functio=
ns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove var=
ious unused functions

Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5=

Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openv=
pn/buffer=2Eh
M src/openvpn/crypto_backend=2Eh
M src/openvpn/crypto_mbedtls=
=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/crypto_openssl=
=2Ec
M src/openvpn/env_set=2Ec
M src/openvpn/env_set=2Eh
M src/openvpn/mana=
ge=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
M src/openvpn/=
openvpn=2Ec
M src/openvpn/plugin=2Ec
M src/openvpn/plugin=2Eh
13 files chan=
ged, 0 insertions(+), 128 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/10/1610/15

diff --git a/src/openvpn/buff=
er=2Eh b/src/openvpn/buffer=2Eh
index 651aaed=2E=2Ee48a793 100644
--- a/src=
/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1851,17 +1851,6 @@
 vo=
id x_gc_freespecial(struct gc_arena *a);
 
 /**
- * Return true iff the are=
na contains at least one allocation=2E
- *
- * @param a  The arena to test=
=2E
- */
-static inline bool
-gc_defined(struct gc_arena *a)
-{
-    return=
 a->list !=3D NULL;
-}
-
-/**
  * Initialise a garbage collection arena to =
an empty state=2E
  *
  * @param a  The arena to initialise=2E
diff --git a=
/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh
index 1708=
5d6=2E=2Eb7f820d 100644
--- a/src/openvpn/crypto_backend=2Eh
+++ b/src/open=
vpn/crypto_backend=2Eh
@@ -569,15 +569,6 @@
 void md_ctx_cleanup(md_ctx_t *=
ctx);
 
 /*
- * Returns the size of the message digest output by the given =
context
- *
- * @param ctx           Message digest context=2E
- *
- * @ret=
urn              Size of the message digest, or \0 if ctx is NULL=2E
- */
-=
int md_ctx_size(const md_ctx_t *ctx);
-
-/*
  * Process the given data for =
use in the message digest=2E
  *
  * @param ctx           Message digest co=
ntext=2E May not be NULL=2E
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/s=
rc/openvpn/crypto_mbedtls=2Ec
index 6662def=2E=2E665257c0 100644
--- a/src/=
openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -718,16 =
+718,6 @@
     ASSERT(psa_hash_abort(&ctx->operation) =3D=3D PSA_SUCCESS);
=
 }
 
-int
-md_ctx_size(const md_ctx_t *ctx)
-{
-    if (ctx =3D=3D NULL)
- =
   {
-        return 0;
-    }
-    return (int)PSA_HASH_LENGTH(ctx->md_inf=
o->psa_alg);
-}
-
 void
 md_ctx_update(md_ctx_t *ctx, const uint8_t *src, s=
ize_t src_len)
 {
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/=
openvpn/crypto_mbedtls_legacy=2Ec
index 9e47c26=2E=2E8b187bf 100644
--- a/s=
rc/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legac=
y=2Ec
@@ -848,16 +848,6 @@
     mbedtls_md_free(ctx);
 }
 
-int
-md_ctx_siz=
e(const mbedtls_md_context_t *ctx)
-{
-    if (NULL =3D=3D ctx)
-    {
-   =
     return 0;
-    }
-    return (int)mbedtls_md_get_size(mbedtls_md_info_=
from_ctx(ctx));
-}
-
 void
 md_ctx_update(mbedtls_md_context_t *ctx, const =
uint8_t *src, size_t src_len)
 {
diff --git a/src/openvpn/crypto_openssl=2E=
c b/src/openvpn/crypto_openssl=2Ec
index 2019280=2E=2E0be87e4 100644
--- a/=
src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -110=
8,12 +1108,6 @@
     EVP_MD_CTX_reset(ctx);
 }
 
-int
-md_ctx_size(const EV=
P_MD_CTX *ctx)
-{
-    return (int)EVP_MD_CTX_size(ctx);
-}
-
 void
 md_ctx=
_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)
 {
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
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 27d3=
b60=2E=2E1be3549 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/mana=
ge=2Eh
@@ -158,12 +158,6 @@
     return h->size;
 }
 
-static inline int
-l=
og_history_capacity(const struct log_history *h)
-{
-    return h->capacity=
;
-}
-
 /*
  * Callbacks for 'status' and 'kill' commands=2E
  * Also for m=
anagement-based deferred authentication and packet filter=2E
diff --git a/s=
rc/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index d8cc708=2E=2Ebb1fb=
ce 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ =
-661,12 +661,3 @@
 
     } while (action !=3D TA_UNDEF);
 }
-
-void
-multi_=
io_delete_event(struct multi_io *multi_io, event_t event)
-{
-    if (multi=
_io && multi_io->es)
-    {
-        event_del(multi_io->es, event);
-    }=

-}
diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index =
d6734bd=2E=2E38825ab 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvp=
n/multi_io=2Eh
@@ -72,6 +72,4 @@
 
 void multi_io_action(struct multi_conte=
xt *m, struct multi_instance *mi, int action, bool poll);
 
-void multi_io_=
delete_event(struct multi_io *multi_io, event_t event);
-
 #endif /* ifndef=
 MULTI_IO_H */
diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=
=2Ec
index 7d35195=2E=2E24d6bb6 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/=
src/openvpn/openvpn=2Ec
@@ -32,7 +32,6 @@
 #include "win32=2Eh"
 #include "=
options_show=2Eh"
 #include "platform=2Eh"
-#include "string=2Eh"
 
 #inclu=
de "memdbg=2Eh"
 
diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=
=2Ec
index f8adde5=2E=2E29f9327 100644
--- a/src/openvpn/plugin=2Ec
+++ b/s=
rc/openvpn/plugin=2Ec
@@ -993,24 +993,4 @@
     pr->n =3D 0;
 }
 
-#ifdef E=
NABLE_DEBUG
-void
-plugin_return_print(const msglvl_t msglevel, const char =
*prefix, const struct plugin_return *pr)
-{
-    int i;
-    msg(msglevel, =
"PLUGIN_RETURN_PRINT %s", prefix);
-    for (i =3D 0; i < pr->n; ++i)
-    =
{
-        struct openvpn_plugin_string_list *l =3D pr->list[i];
-        i=
nt count =3D 0;
-
-        msg(msglevel, "PLUGIN #%d (%s)", i, prefix);
-  =
      while (l)
-        {
-            msg(msglevel, "[%d] '%s' -> '%s'", =
++count, l->name, l->value);
-            l =3D l->next;
-        }
-    }
=
-}
-#endif /* ifdef ENABLE_DEBUG */
 #endif /* ENABLE_PLUGIN */
diff --git =
a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2Ef5c0f8=
5 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,=
11 +135,6 @@
 
 void plugin_return_free(struct plugin_return *pr);
 
-#ifde=
f ENABLE_DEBUG
-void plugin_return_print(const msglvl_t msglevel, const cha=
r *prefix, const struct plugin_return *pr);
-
-#endif
-
 static inline int
=
 plugin_n(const struct plugin_list *pl)
 {

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
Gerrit-=
Change-Number: 1610
Gerrit-PatchSet: 15
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lst=
ipakov@gmail=2Ecom>

--59JiM6imh98=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>flichtenhel=
d <strong>uploaded patch set #15</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change=
</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Remove various unused functions<br><br>Change-Id: I82=
a4e82ff876fab715e052de1903c65b835360b5<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Eh<br>M src=
/openvpn/crypto_backend=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/op=
envpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/crypto_openssl=2Ec<br>M sr=
c/openvpn/env_set=2Ec<br>M src/openvpn/env_set=2Eh<br>M src/openvpn/manage=
=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>M src/o=
penvpn/openvpn=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<=
br>13 files changed, 0 insertions(+), 128 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/=
1610/15</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2E=
h</span><br><span>index 651aaed=2E=2Ee48a793 100644</span><br><span>--- a/s=
rc/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><b=
r><span>@@ -1851,17 +1851,6 @@</span><br><span> void x_gc_freespecial(struc=
t gc_arena *a);</span><br><span> </span><br><span> /**</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Return true iff the arena contains at l=
east one allocation=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param a  The a=
rena to test=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc_arena =
*a)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return a-&gt;list !=3D NULL;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/**</span><br><span>  * Initialise a garbage collection arena to an =
empty state=2E</span><br><span>  *</span><br><span>  * @param a  The arena =
to initialise=2E</span><br><span>diff --git a/src/openvpn/crypto_backend=2E=
h b/src/openvpn/crypto_backend=2Eh</span><br><span>index 17085d6=2E=2Eb7f82=
0d 100644</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><br><s=
pan>+++ b/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -569,15 +569,6 =
@@</span><br><span> void md_ctx_cleanup(md_ctx_t *ctx);</span><br><span> </=
span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
Returns the size of the message digest output by the given context</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param ctx           Message digest context=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @return              Size of the mess=
age digest, or \0 if ctx is NULL=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int =
md_ctx_size(const md_ctx_t *ctx);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span>=
<br><span>  * Process the given data for use in the message digest=2E</span=
><br><span>  *</span><br><span>  * @param ctx           Message digest cont=
ext=2E May not be NULL=2E</span><br><span>diff --git a/src/openvpn/crypto_m=
bedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 6662def=
=2E=2E665257c0 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -71=
8,16 +718,6 @@</span><br><span>     ASSERT(psa_hash_abort(&amp;ctx-&gt;oper=
ation) =3D=3D PSA_SUCCESS);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-md_ctx_size(const md_ctx_t *ctx)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (ctx =3D=3D NULL)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (int)P=
SA_HASH_LENGTH(ctx-&gt;md_info-&gt;psa_alg);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> void</span><br><span> md_ctx_update(md_ctx_t *ctx, con=
st uint8_t *src, size_t src_len)</span><br><span> {</span><br><span>diff --=
git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_le=
gacy=2Ec</span><br><span>index 9e47c26=2E=2E8b187bf 100644</span><br><span>=
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openv=
pn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -848,16 +848,6 @@</span><br=
><span>     mbedtls_md_free(ctx);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const mbedtls_md_context_t *ctx=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> md_ctx_=
update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_len)</span=
><br><span> {</span><br><span>diff --git a/src/openvpn/crypto_openssl=2Ec b=
/src/openvpn/crypto_openssl=2Ec</span><br><span>index 2019280=2E=2E0be87e4 =
100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</span><br><span=
>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -1108,12 +1108,6 @=
@</span><br><span>     EVP_MD_CTX_reset(ctx);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const EVP_MD_CTX *ct=
x)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return (int)EVP_MD_CTX_size(ctx);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> md_=
ctx_update(EVP_MD_CTX *ctx, const uint8_t *src, size_t src_len)</span><br><=
span> {</span><br><span>diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/=
env_set=2Ec</span><br><span>index d992097=2E=2Ee147913 100644</span><br><sp=
an>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/openvpn/env_set=
=2Ec</span><br><span>@@ -209,32 +209,6 @@</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-env_set_print(msglvl_t msglevel, const struct env_set *es)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (check_debug_level(msglevel))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        const struct env_item *e;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e =
=3D es-&gt;list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            while (e)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (env_safe_to_pri=
nt(e-&gt;string))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            msg(msglevel, &quot;ENV [%d] &#39;%s&#39;&quot;, i, e-&gt;strin=
g);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ++i;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                e =3D e=
-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><b=
r><span> env_set_write_file(const char *path, const struct env_set *es)</sp=
an><br><span> {</span><br><span>     FILE *fp =3D platform_fopen(path, &quo=
t;w&quot;);</span><br><span>@@ -411,15 +385,6 @@</span><br><span> }</span><=
br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-setenv_int_i(struct env_set *es, const char *name, const int val=
ue, const int i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t char *name_str =3D setenv_format_indexed_name(name, i, &amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_int(es, name_str, v=
alue);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span> setenv_str_i(struct env_set *es, c=
onst char *name, const char *value, const int i)</span><br><span> {</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span>diff --git a=
/src/openvpn/env_set=2Eh b/src/openvpn/env_set=2Eh</span><br><span>index fc=
fc3ca=2E=2E9b4a1e7 100644</span><br><span>--- a/src/openvpn/env_set=2Eh</sp=
an><br><span>+++ b/src/openvpn/env_set=2Eh</span><br><span>@@ -69,8 +69,6 @=
@</span><br><span>  */</span><br><span> void setenv_str_incr(struct env_set=
 *es, const char *name, const char *value);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void setenv_int_i(struct env_set *e=
s, const char *name, const int value, const int i);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void setenv_str_i(struct =
env_set *es, const char *name, const char *value, const int i);</span><br><=
span> </span><br><span> /* struct env_set functions */</span><br><span>@@ -=
85,8 +83,6 @@</span><br><span> </span><br><span> const char *env_set_get(co=
nst struct env_set *es, const char *name);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void env_set_print(msglvl_t msglevel=
, const struct env_set *es);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /**</span><br><span>  * Write a struct env_set to =
a file=2E Each item on one line=2E</span><br><span>  *</span><br><span>diff=
 --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>in=
dex 27d3b60=2E=2E1be3549 100644</span><br><span>--- a/src/openvpn/manage=2E=
h</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -158,12 +=
158,6 @@</span><br><span>     return h-&gt;size;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inli=
ne int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-log_history_cap=
acity(const struct log_history *h)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn h-&gt;capacity;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</=
span><br><span>  * Callbacks for &#39;status&#39; and &#39;kill&#39; comman=
ds=2E</span><br><span>  * Also for management-based deferred authentication=
 and packet filter=2E</span><br><span>diff --git a/src/openvpn/multi_io=2Ec=
 b/src/openvpn/multi_io=2Ec</span><br><span>index d8cc708=2E=2Ebb1fbce 1006=
44</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src=
/openvpn/multi_io=2Ec</span><br><span>@@ -661,12 +661,3 @@</span><br><span>=
 </span><br><span>     } while (action !=3D TA_UNDEF);</span><br><span> }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_io_delete_event(struct multi_io *multi_io, event_t eve=
nt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (multi_io &amp;&amp; multi_io-&=
gt;es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        event_del(multi_io-&gt;=
es, event);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --g=
it a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>in=
dex d6734bd=2E=2E38825ab 100644</span><br><span>--- a/src/openvpn/multi_io=
=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -72,=
6 +72,4 @@</span><br><span> </span><br><span> void multi_io_action(struct m=
ulti_context *m, struct multi_instance *mi, int action, bool poll);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_=
io_delete_event(struct multi_io *multi_io, event_t event);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* ifndef MUL=
TI_IO_H */</span><br><span>diff --git a/src/openvpn/openvpn=2Ec b/src/openv=
pn/openvpn=2Ec</span><br><span>index 7d35195=2E=2E24d6bb6 100644</span><br>=
<span>--- a/src/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openvpn/openv=
pn=2Ec</span><br><span>@@ -32,7 +32,6 @@</span><br><span> #include &quot;wi=
n32=2Eh&quot;</span><br><span> #include &quot;options_show=2Eh&quot;</span>=
<br><span> #include &quot;platform=2Eh&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;string=2Eh&quot;</span><br><span> </s=
pan><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><b=
r><span>index f8adde5=2E=2E29f9327 100644</span><br><span>--- a/src/openvpn=
/plugin=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@=
 -993,24 +993,4 @@</span><br><span>     pr-&gt;n =3D 0;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_return_print(con=
st msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    msg(msglevel, &quot;PLUGIN_RETURN_PRINT %s&quot;, =
prefix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; pr-&gt;n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct openvpn_plugin_string_list *l =3D pr-&gt;list[i];</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        int count =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(msglevel, &quot;PLUGIN #%d (%s)&quot;, i, prefi=
x);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while (l)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;[%=
d] &#39;%s&#39; -&gt; &#39;%s&#39;&quot;, ++count, l-&gt;name, l-&gt;value)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            l =3D l-=
&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span> #endif /* E=
NABLE_PLUGIN */</span><br><span>diff --git a/src/openvpn/plugin=2Eh b/src/o=
penvpn/plugin=2Eh</span><br><span>index 7e9faf3=2E=2Ef5c0f85 100644</span><=
br><span>--- a/src/openvpn/plugin=2Eh</span><br><span>+++ b/src/openvpn/plu=
gin=2Eh</span><br><span>@@ -135,11 +135,6 @@</span><br><span> </span><br><s=
pan> void plugin_return_free(struct plugin_return *pr);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void plugin_return_print(=
const msglvl_t msglevel, const char *prefix, const struct plugin_return *pr=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> static inline int</span><br><span> pl=
ugin_n(const struct plugin_list *pl)</span><br><span> {</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b83=
5360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1610 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</=
body></html>
--59JiM6imh98=--


--===============8219964679444817174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8219964679444817174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8219964679444817174==--

