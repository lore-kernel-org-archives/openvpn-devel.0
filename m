Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F051CDB475
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bNgOB4CZlqbrki2RyLPlh9ThVKQ8LHTqfD5v1A8CCHQ=; b=R0NOjujvYUDwog8YX6JvRDe0SS
	sNCP4dxmfAOBlUll+D5pZhJv9cvk1tFwSr9pe4TEbOPuTT4I0i6hAusAKrsdriRSFG4OoTiBA363o
	SuQJ/FPIM2RbsO/XVk70YBPG3rf0AOpxEtisDZoaw2o8yRzt6KfQgnqweQ0mHbe1dSE0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgca-0002uE-2v;
	Mon, 22 Jun 2026 15:31:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgcW-0002tq-Mf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=D6oZyMehzGC4ZdM6GS3cVG0ZeZv4fwXHADzBKngRSo0=; b=HE4KSgdoLaKJ9A0D8MzMpuYeKb
 drUsU5tMjgIy7kleJnQ1iFCg0swd338RBO0/9Z1aPNCL7XfsBADlYqYp1qy2SUc8EdRf7gWcxNPWY
 f2b2okgzdF7OyljYL8T/05e3irjPhzfRt9GvCy+w6F9RDKIXlJVGj72m4ggi94PLvmFU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D6oZyMehzGC4ZdM6GS3cVG0ZeZv4fwXHADzBKngRSo0=; b=W
 m5denPFYat8rZbR6guHCw5aDzpqBkKvdzYmmadP0Xt4R+8FkfRDIWwGD2J2snpVvoM5DK+8CDSGdW
 xA4Hie4y2Txq9ieI8NMBy/T/YKF4l4pSvT3sDd7wxIfaUxAbrlZgppu/fhlj222xXSLO2AZGA2IUG
 sMheTYhd459IjG0E=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgcV-0007nY-Bd for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:31:33 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c074142cf6dso966866b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142280; x=1782747080; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6oZyMehzGC4ZdM6GS3cVG0ZeZv4fwXHADzBKngRSo0=;
 b=Qzve/eCkBzM4M71gJqxZ4+MsYRMXy223RayZtdD6tKiCaZG5rD2jGUpXzH7QcA4px6
 yMOPHRLdUtOxQ4l+7VALypW6qvIFA3uV8kx3KX9sV5zSbTkWpM9I9CDJQ4NR0kxfCgXp
 TDMhEDFhbww3BVSUUvItQyCfXYSzFXgmD6c7i0C3gCpPB2nB2jlnxHt95/LRl9tC5kPm
 1KIId2e8rrlGVoFEIwas/s0Y/O5pqHzJokc8URlRy3nyZNNN0QFX1R3dw2gX5WwCw8rk
 RK9OcMAmTTG25+wZ0wd7RWNXsuppEna8QQCYOpU16yG69NKmYwEPokxD25QNnMr1VWH2
 xHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142280; x=1782747080;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6oZyMehzGC4ZdM6GS3cVG0ZeZv4fwXHADzBKngRSo0=;
 b=Jnl5+P/JogMlFjJgCoXk7bId+yC54EFuGdzOB6j9W5EBsbCk62cxipzBLUfMH2UyRK
 M1wLfoVkiStBFWwYYF5PPVeji35M7Z9x2dsb9+1pwlDmC0UiPOxFFUkpDLFJnFUhmZ0A
 ZmUY5cmU+XuheWmZGZsFlbEnuK/IZBFPycOreMZGjt/bdUsVy0IySWhPqtiu8KvuB6+B
 F35MWULID0mAwvvVwIxIJ5PGHObvu7cmZwp1co+3mkzca01j9Erq6Wh/PQdChuGURsqD
 Z8PxqGlDOffrfy18Ae2x2+f/f9C1ZJTQWLUMv00aHv9l4edNjr6s35YpGJzORgql0hRC
 aMuQ==
X-Gm-Message-State: AOJu0YyUKRVKyJn6d+Gifkt4pC5Os8bTewlzWI1BbXjY4GTh4E2nZwIy
 NDvDstrLv435Pm3VPeoKa9ekv6JXHX9HjmzwXBfV50ZWb/9+rMJOromhCp50vr0DSTdA8oI9c+Q
 E24OF91VpHI1lIR+jBEQfmIdSLujL4VkmxAm8kz3LYErV3h3o1i9yex+PbOzsH94Ye1YJJo7luu
 EWhqLABw==
X-Gm-Gg: AfdE7cmdeZcBH55bTyiy4fZyAiByPuLMl5lQTfGhushx3qNjBk64YPzHI5l2BkiuZmf
 RUflQ51KXjhcyntJQWDw9VxkbzeC0M2WtKD2srl6tUPozOWL1Pfm1B84kFHT3cybywjx/VihVvc
 t/mHNxez9ijr+T6qFfHKOfySsuTKf/MGGuSkkdPL+2kG80Jvw5UY5Huqz9fi1wgbbt6EF3db/SL
 NUb6QpLUoLsjE/vCjpgdnj51o6MfTNX/jt+vE72ULAarS5S3GGC1aOo268KIaNwTEAaFamCH/Rj
 HSsJZQePCVDiV+p8yuSJi2XOOGwFLAUQ8NZb71dugpJk9rqY69fVj3wy4REgzsgXquRH4o3UfuC
 0CIQDWahWt4ahrV3bmKktyiajOwQfzF4XldD41P1FpNV++nLDxmNZh4x9pP2c6szEy2VdowSqif
 kTmOcJk128WiqAZ1Mdt3MxkhSxU2CpVOpvFqZ3dvBFlQVbebUWtgP5dSHoWDd4g1/2G+9s0OeuI
 H1UCyVPLD8eOsJ6QrrO2pheQ9aOcU6jFj6P9T3ucCzTd5a5jL0Q9IZHId/0Uircb1jGDEtSznuO
 Q3s=
X-Received: by 2002:a17:906:2091:b0:bec:5264:e527 with SMTP id
 a640c23a62f3a-c09b9681a69mr410885866b.26.1782142278851; 
 Mon, 22 Jun 2026 08:31:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f56aasm26863882f8f.6.2026.06.22.08.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:31:18 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:31:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 2d8cf123844fdee5854b3d0fe82abd0747dc3662
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7435e3cd6ea86b18c1ecc4748c5a592ce51c0cad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgcV-0007nY-Bd
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5422056581226935025=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5422056581226935025==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j8yPtYV2LlQ="; charset=UTF-8

--j8yPtYV2LlQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#6)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1571?usp=3Demail )


Change subject: Change hash iv to a dy=
namically allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Change hash iv to a dynamically allocated ctx

While for our own=
 hash function, always using an uint32_t works well, it does
not work very =
well if we move to another hash function=2E Move the context of
a hardcoded=
 uint32_t iv to a void pointer to a real ctx=2E

Change-Id: If47c7d920b2fa4=
047b7db03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>=

---
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec=

M src/openvpn/mroute=2Eh
M src/openvpn/multi=2Ec
M tests/unit_tests/openvp=
n/test_misc=2Ec
6 files changed, 42 insertions(+), 23 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/6

dif=
f --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index c07e764=2E=2E36=
d8ede 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -29,1=
3 +29,16 @@
 
 #include "integer=2Eh"
 #include "list=2Eh"
+
+#include "cry=
pto=2Eh"
 #include "misc=2Eh"
 
 #include "memdbg=2Eh"
 
 struct hash *
-ha=
sh_init(const uint32_t n_buckets, const uint32_t iv,
-          uint64_t (*=
hash_function)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_b=
uckets, void *ctx,
+          void (*free_hash_ctx)(void *ctx),
+          =
uint64_t (*hash_function)(const void *key, void *ctx),
           bool (*co=
mpare_function)(const void *key1, const void *key2))
 {
     struct hash *h=
;
@@ -46,7 +49,8 @@
     h->mask =3D h->n_buckets - 1;
     h->hash_functio=
n =3D hash_function;
     h->compare_function =3D compare_function;
-    h-=
>iv =3D iv;
+    h->free_ctx =3D free_hash_ctx;
+    h->ctx =3D ctx;
     A=
LLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
     for (uint32_=
t i =3D 0; i < h->n_buckets; ++i)
     {
@@ -71,6 +75,7 @@
             he =
=3D next;
         }
     }
+    hash->free_ctx(hash->ctx);
     free(hash-=
>buckets);
     free(hash);
 }
@@ -412,6 +417,14 @@
         c ^=3D (b >> 1=
5); \
     }
 
+void *
+hash_func_new_ctx(void)
+{
+    uint32_t *ctx =3D m=
alloc(sizeof(uint32_t));
+    *ctx =3D (uint32_t)get_random();
+    return =
ctx;
+}
+
 uint64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t =
initval)
 {
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index =
06377c6=2E=2Eea6f47a 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/li=
st=2Eh
@@ -54,14 +54,17 @@
     uint32_t n_buckets;
     uint32_t n_element=
s;
     uint32_t mask;
-    uint32_t iv;
-    uint64_t (*hash_function)(con=
st void *key, uint32_t iv);
+    void *ctx;
+    uint64_t (*hash_function)(=
const void *key, void *ctx);
     bool (*compare_function)(const void *key1=
, const void *key2); /* return true if equal */
+    void (*free_ctx)(void =
*ctx);
+    void *free_ctx_arg;
     struct hash_bucket *buckets;
 };
 
-st=
ruct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-        =
               uint64_t (*hash_function)(const void *key, uint32_t iv),
+st=
ruct hash *hash_init(const uint32_t n_buckets, void *ctx,
+                =
       void (*free_hash_ctx)(void *ctx),
+                       uint64_t (=
*hash_function)(const void *key, void *ctx),
                        bool (=
*compare_function)(const void *key1, const void *key2));
 
 void hash_free(=
struct hash *hash);
@@ -100,10 +103,12 @@
 
 uint64_t hash_func(const uint8=
_t *k, uint32_t length, uint32_t initval);
 
+void *hash_func_new_ctx(void)=
;
+
 static inline uint64_t
 hash_value(const struct hash *hash, const void=
 *key)
 {
-    return (*hash->hash_function)(key, hash->iv);
+    return (*=
hash->hash_function)(key, hash->ctx);
 }
 
 static inline uint32_t
diff --g=
it a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 78c689e=2E=2E89b=
3ecc 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -3=
55,10 +355,11 @@
  * and the actual address=2E
  */
 uint64_t
-mroute_addr_=
hash_function(const void *key, uint32_t iv)
+mroute_addr_hash_function(cons=
t void *key, void *ctx)
 {
+    uint32_t *iv =3D ctx;
     return hash_func=
(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-                  =
   mroute_addr_hash_len((const struct mroute_addr *)key), iv);
+           =
          mroute_addr_hash_len((const struct mroute_addr *)key), *iv);
 }
 =

 bool
diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2=
f5d019=2E=2E51b62d2 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/m=
route=2Eh
@@ -144,7 +144,7 @@
 
 bool mroute_learnable_address(const struct=
 mroute_addr *addr, struct gc_arena *gc);
 
-uint64_t mroute_addr_hash_func=
tion(const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(con=
st void *key, void *ctx);
 
 bool mroute_addr_compare_function(const void *=
key1, const void *key2);
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec
index e1c9c80=2E=2Eda19183 100644
--- a/src/openvpn/multi=2Ec
++=
+ b/src/openvpn/multi=2Ec
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEMENT
 
 =
static uint64_t
-cid_hash_function(const void *key, uint32_t iv)
+cid_hash_=
function(const void *key, void *ctx)
 {
     const unsigned long *k =3D (co=
nst unsigned long *)key;
     return (uint64_t)*k;
@@ -250,7 +250,7 @@
 /*
=
  * inotify watcher descriptors are used as hash value
  */
-int_hash_funct=
ion(const void *key, uint32_t iv)
+int_hash_function(const void *key, void =
*ctx)
 {
     return (uintptr_t)key;
 }
@@ -290,18 +290,18 @@
      * to de=
termine which client sent an incoming packet
      * which is seen on the T=
CP/UDP socket=2E
      */
-    m->hash =3D hash_init(t->options=2Ereal_hash=
_size, (uint32_t)get_random(),
+    m->hash =3D hash_init(t->options=2Ereal=
_hash_size, hash_func_new_ctx(), free,
                         mroute_addr=
_hash_function, mroute_addr_compare_function);
 
     /*
      * Virtual ad=
dress hash table=2E  Used to determine
      * which client to route a pack=
et to=2E
      */
-    m->vhash =3D hash_init(t->options=2Evirtual_hash_siz=
e, (uint32_t)get_random(),
+    m->vhash =3D hash_init(t->options=2Evirtual=
_hash_size, hash_func_new_ctx(), free,
                          mroute_add=
r_hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_MANAGEMENT=

-    m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, 0, cid_hash_fu=
nction, cid_compare_function);
+    m->cid_hash =3D hash_init(t->options=2E=
real_hash_size, NULL, free, cid_hash_function, cid_compare_function);
 #end=
if
 
 #ifdef ENABLE_ASYNC_PUSH
@@ -309,8 +309,8 @@
      * Mapping between =
inotify watch descriptors and
      * multi_instances=2E
      */
-    m->i=
notify_watchers =3D hash_init(t->options=2Ereal_hash_size, (uint32_t)get_ra=
ndom(),
-                                    int_hash_function, int_compare=
_function);
+    m->inotify_watchers =3D
+        hash_init(t->options=2Ere=
al_hash_size, NULL, free, int_hash_function, int_compare_function);
 #endif=

 
     /*
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit=
_tests/openvpn/test_misc=2Ec
index ccdfdee=2E=2E24bf22d 100644
--- a/tests/=
unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=
=2Ec
@@ -125,11 +125,12 @@
 
 
 static uint64_t
-word_hash_function(const v=
oid *key, uint32_t iv)
+word_hash_function(const void *key, void *ctx)
 {
+=
    uint32_t *iv =3D (uint32_t *)ctx;
     const char *str =3D (const char =
*)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_=
func((const uint8_t *)str, len, iv);
+    return hash_func((const uint8_t *=
)str, len, *iv);
 }
 
 static bool
@@ -171,10 +172,9 @@
      * Test the ha=
sh code by implementing a simple
      * word frequency algorithm=2E
      =
*/
-
     struct gc_arena gc =3D gc_new();
-    struct hash *hash =3D hash_=
init(10000, get_random(), word_hash_function, word_compare_function);
-    =
struct hash *nhash =3D hash_init(256, get_random(), word_hash_function, wor=
d_compare_function);
+    struct hash *hash =3D hash_init(10000, hash_func_=
new_ctx(), free, word_hash_function, word_compare_function);
+    struct ha=
sh *nhash =3D hash_init(256, hash_func_new_ctx(), free, word_hash_function,=
 word_compare_function);
 
     printf("hash_init n_buckets=3D%u mask=3D0x%=
08x\n", hash->n_buckets, hash->mask);
 

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-C=
hange-Number: 1571
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--j8yPtYV2LlQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #6</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Change hash iv to a dynamically allocated ctx<br><br>While for ou=
r own hash function, always using an uint32_t works well, it does<br>not wo=
rk very well if we move to another hash function=2E Move the context of<br>=
a hardcoded uint32_t iv to a void pointer to a real ctx=2E<br><br>Change-Id=
: If47c7d920b2fa4047b7db03fcde821899839324d<br>Signed-off-by: Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/list=2Ec<br>M src/openvp=
n/list=2Eh<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mroute=2Eh<br>M src=
/openvpn/multi=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>6 files c=
hanged, 42 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/6</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>=
index c07e764=2E=2E36d8ede 100644</span><br><span>--- a/src/openvpn/list=2E=
c</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -29,13 +29,=
16 @@</span><br><span> </span><br><span> #include &quot;integer=2Eh&quot;</=
span><br><span> #include &quot;list=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;crypto=2Eh&quot;</span><br><span> #include &quot;misc=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quo=
t;</span><br><span> </span><br><span> struct hash *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-hash_init(const uint32_t n_buckets, const u=
int32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
uint64_t (*hash_function)(const void *key, uint32_t iv),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+hash_init(const uint32_t n_buckets, vo=
id *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          v=
oid (*free_hash_ctx)(void *ctx),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+          uint64_t (*hash_function)(const void *key, void *ctx=
),</span><br><span>           bool (*compare_function)(const void *key1, co=
nst void *key2))</span><br><span> {</span><br><span>     struct hash *h;</s=
pan><br><span>@@ -46,7 +49,8 @@</span><br><span>     h-&gt;mask =3D h-&gt;n=
_buckets - 1;</span><br><span>     h-&gt;hash_function =3D hash_function;</=
span><br><span>     h-&gt;compare_function =3D compare_function;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv =3D iv;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    h-&gt;free_ctx =3D free_has=
h_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    h-&gt;ctx=
 =3D ctx;</span><br><span>     ALLOC_ARRAY(h-&gt;buckets, struct hash_bucke=
t, h-&gt;n_buckets);</span><br><span>     for (uint32_t i =3D 0; i &lt; h-&=
gt;n_buckets; ++i)</span><br><span>     {</span><br><span>@@ -71,6 +75,7 @@=
</span><br><span>             he =3D next;</span><br><span>         }</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  hash-&gt;free_ctx(hash-&gt;ctx);</span><br><span>     free(hash-&gt;bucke=
ts);</span><br><span>     free(hash);</span><br><span> }</span><br><span>@@=
 -412,6 +417,14 @@</span><br><span>         c ^=3D (b &gt;&gt; 15); \</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+hash_func_new_ctx(void)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_=
t *ctx =3D malloc(sizeof(uint32_t));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    *ctx =3D (uint32_t)get_random();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> uint64_t</span><br><span> hash_func(const uin=
t8_t *k, uint32_t length, uint32_t initval)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><spa=
n>index 06377c6=2E=2Eea6f47a 100644</span><br><span>--- a/src/openvpn/list=
=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -54,14 +=
54,17 @@</span><br><span>     uint32_t n_buckets;</span><br><span>     uint=
32_t n_elements;</span><br><span>     uint32_t mask;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t iv;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint64_t (*hash_function)(const void *key, u=
int32_t iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    voi=
d *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t=
 (*hash_function)(const void *key, void *ctx);</span><br><span>     bool (*=
compare_function)(const void *key1, const void *key2); /* return true if eq=
ual */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void (*fr=
ee_ctx)(void *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    void *free_ctx_arg;</span><br><span>     struct hash_bucket *buckets;</=
span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-struct hash *hash_init(const uint32_t n_buckets, const uint3=
2_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
         uint64_t (*hash_function)(const void *key, uint32_t iv),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+struct hash *hash_init(const =
uint32_t n_buckets, void *ctx,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       void (*free_hash_ctx)(void *ctx),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                       uint=
64_t (*hash_function)(const void *key, void *ctx),</span><br><span>        =
                bool (*compare_function)(const void *key1, const void *key2=
));</span><br><span> </span><br><span> void hash_free(struct hash *hash);</=
span><br><span>@@ -100,10 +103,12 @@</span><br><span> </span><br><span> uin=
t64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *h=
ash_func_new_ctx(void);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> static inline uint64_t</span><br><span> hash_value(co=
nst struct hash *hash, const void *key)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return (*hash-&gt;hash_function)(k=
ey, hash-&gt;iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return (*hash-&gt;hash_function)(key, hash-&gt;ctx);</span><br><span> }</=
span><br><span> </span><br><span> static inline uint32_t</span><br><span>di=
ff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>=
index 78c689e=2E=2E89b3ecc 100644</span><br><span>--- a/src/openvpn/mroute=
=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -355,1=
0 +355,11 @@</span><br><span>  * and the actual address=2E</span><br><span>=
  */</span><br><span> uint64_t</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-mroute_addr_hash_function(const void *key, uint32_t iv)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+mroute_addr_hash_function(cons=
t void *key, void *ctx)</span><br><span> {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    uint32_t *iv =3D ctx;</span><br><span>     retur=
n hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                     mroute_ad=
dr_hash_len((const struct mroute_addr *)key), iv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     mroute_addr_hash_len((c=
onst struct mroute_addr *)key), *iv);</span><br><span> }</span><br><span> <=
/span><br><span> bool</span><br><span>diff --git a/src/openvpn/mroute=2Eh b=
/src/openvpn/mroute=2Eh</span><br><span>index 2f5d019=2E=2E51b62d2 100644</=
span><br><span>--- a/src/openvpn/mroute=2Eh</span><br><span>+++ b/src/openv=
pn/mroute=2Eh</span><br><span>@@ -144,7 +144,7 @@</span><br><span> </span><=
br><span> bool mroute_learnable_address(const struct mroute_addr *addr, str=
uct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-uint64_t mroute_addr_hash_function(const void *key, uint32_t=
 iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t mrout=
e_addr_hash_function(const void *key, void *ctx);</span><br><span> </span><=
br><span> bool mroute_addr_compare_function(const void *key1, const void *k=
ey2);</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec</span><br><span>index e1c9c80=2E=2Eda19183 100644</=
span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvp=
n/multi=2Ec</span><br><span>@@ -229,7 +229,7 @@</span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span> </span><br><span> static uint64_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-cid_hash_function(const void *k=
ey, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cid=
_hash_function(const void *key, void *ctx)</span><br><span> {</span><br><sp=
an>     const unsigned long *k =3D (const unsigned long *)key;</span><br><s=
pan>     return (uint64_t)*k;</span><br><span>@@ -250,7 +250,7 @@</span><br=
><span> /*</span><br><span>  * inotify watcher descriptors are used as hash=
 value</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-int_hash_function(const void *key, uint32_t iv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int_hash_function(const void *key, void *=
ctx)</span><br><span> {</span><br><span>     return (uintptr_t)key;</span><=
br><span> }</span><br><span>@@ -290,18 +290,18 @@</span><br><span>      * t=
o determine which client sent an incoming packet</span><br><span>      * wh=
ich is seen on the TCP/UDP socket=2E</span><br><span>      */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;=
options=2Ereal_hash_size, (uint32_t)get_random(),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    m-&gt;hash =3D hash_init(t-&gt;options=2E=
real_hash_size, hash_func_new_ctx(), free,</span><br><span>                =
         mroute_addr_hash_function, mroute_addr_compare_function);</span><b=
r><span> </span><br><span>     /*</span><br><span>      * Virtual address h=
ash table=2E  Used to determine</span><br><span>      * which client to rou=
te a packet to=2E</span><br><span>      */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_=
hash_size, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_s=
ize, hash_func_new_ctx(), free,</span><br><span>                          m=
route_addr_hash_function, mroute_addr_compare_function);</span><br><span> <=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_h=
ash_size, 0, cid_hash_function, cid_compare_function);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    m-&gt;cid_hash =3D hash_init(t-&gt;o=
ptions=2Ereal_hash_size, NULL, free, cid_hash_function, cid_compare_functio=
n);</span><br><span> #endif</span><br><span> </span><br><span> #ifdef ENABL=
E_ASYNC_PUSH</span><br><span>@@ -309,8 +309,8 @@</span><br><span>      * Ma=
pping between inotify watch descriptors and</span><br><span>      * multi_i=
nstances=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    m-&gt;inotify_watchers =3D hash_init(t-&gt;options=2Erea=
l_hash_size, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                    int_hash_function, int_c=
ompare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  m-&gt;inotify_watchers =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        hash_init(t-&gt;options=2Ereal_hash_size, NULL, free, int_=
hash_function, int_compare_function);</span><br><span> #endif</span><br><sp=
an> </span><br><span>     /*</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><s=
pan>index ccdfdee=2E=2E24bf22d 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec</span><br><span>@@ -125,11 +125,12 @@</span><br><span> </span><br=
><span> </span><br><span> static uint64_t</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-word_hash_function(const void *key, uint32_t iv)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+word_hash_function(const v=
oid *key, void *ctx)</span><br><span> {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint32_t *iv =3D (uint32_t *)ctx;</span><br><span> =
    const char *str =3D (const char *)key;</span><br><span>     const uint3=
2_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return hash_func((const uint8_t *)str, len, iv);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return hash_func((const u=
int8_t *)str, len, *iv);</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span>@@ -171,10 +172,9 @@</span><br><span>      =
* Test the hash code by implementing a simple</span><br><span>      * word =
frequency algorithm=2E</span><br><span>      */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash =
*hash =3D hash_init(10000, get_random(), word_hash_function, word_compare_f=
unction);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct h=
ash *nhash =3D hash_init(256, get_random(), word_hash_function, word_compar=
e_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct hash *hash =3D hash_init(10000, hash_func_new_ctx(), free, word_hash_fu=
nction, word_compare_function);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct hash *nhash =3D hash_init(256, hash_func_new_ctx(), =
free, word_hash_function, word_compare_function);</span><br><span> </span><=
br><span>     printf(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\n&quot;, =
hash-&gt;n_buckets, hash-&gt;mask);</span><br><span> </span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1571?usp=3Demail">change 1571</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde8218998=
39324d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1571 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--j8yPtYV2LlQ=--


--===============5422056581226935025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5422056581226935025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5422056581226935025==--

