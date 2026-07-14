Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDAEC44508
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYMzIOUw8FApcQrlyMTYDdqTKr414zdyoI7jFMsnjJw=; b=abvHVP6qXP3p8B98byL2wdnDhx
	VQgE1Wm95u3bNOcKEmLqE1JqVt4Pg0WUHxovKe9PG2Z4b9sLMp3gLKV4V6oH0ThpIGvMi2rubAva8
	0ECre26nScsDSehBjr8gcoAotVk/6sgEXCugZTF0CIGG5r29bAo4T6Ck36O4kHDIKXCs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclO-0000pa-PE;
	Tue, 14 Jul 2026 13:01:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclL-0000pS-Uo
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FuAHN/nmbRQx4okGF5Mr2qjdeNYE80G0GivB3iqtB7M=; b=jfIBx7Wutc7fgRSXqY6MPZKaJK
 5J4WGwL6VWHKT9BYikivqjYGHYUztmCVHDy2QJLkzHCwUIcPmucsgTplHoggOzPSoYKM+Eu9y3+yO
 e1LMMyFHL/1XTFEzp3odZ8bRuai17prBc4qgwQ0U8gelETD7EpY6Wl5cVD6Jj5l7P1WE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FuAHN/nmbRQx4okGF5Mr2qjdeNYE80G0GivB3iqtB7M=; b=Q
 Yjvdt7rT4/658+2a3pMgTbR7C7SDupSYl63mLQNQ0qD3q9H7RXosTNyx636ZtOpvA/s72rKgEVRii
 5G4mFY/fGy4gv8vH30lIvTi/doyVXtdmUNOU430PYyQKzk8ZLJfByJLC15mND6jSnpoYvls01Mgzw
 xjbgkxb0BwGKOazI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclH-00027n-PE for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:25 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so38783885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034077; x=1784638877; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FuAHN/nmbRQx4okGF5Mr2qjdeNYE80G0GivB3iqtB7M=;
 b=Ik5Mgi89WhR/K7+U6jGpLfbnDA/syeDdCS5ftTRMyqa+LZROsW8gLWbmfeSej1icSE
 VI3QE5DtPp57OV26k4IG0jNLrX/Q0mHNyNelChsSKGo3rLpoi9J6rjU3O+fSVRay6w5D
 u91ErksJ/iECH1EzZpzkoDiMY3j/1BGdkBlslaxQFNEM3sOClWMDEM/+ZshJbn0hb1e/
 0zxBmV5/HBN/mZQ3tj0iJiKQ0/PjHsb6uoR7n8qgdvYoJht5+uDWR2A0Nh4Y+JkAOkj5
 BA5KnR/nh5UufUfYK7ntCM1wKXy15JlYWPLQkkAy+TqPCWE/r3oHJoRFFn5+biyrifnH
 eOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034077; x=1784638877;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FuAHN/nmbRQx4okGF5Mr2qjdeNYE80G0GivB3iqtB7M=;
 b=U2z5okHGE/VLhyWABmaICBuqhMFQevIa/yJ6ANzSZ/mqXTx61s/HYUr6JMoWNboCjt
 qwUJ4zZloTS81ZUeUmykGfYkuC71ye3LBpyx8etxcenmXCFa8l53zzTukaW1DOa9O0rf
 oo/x7riq8/nvyANksA7mvqdebUOm3HjZxzdvu8e5fY8RpMiodzLbgTO7aFhD22OfdP8p
 LRLHqsF+9vK4nfESv5GJSnlCkAar4AvOEZuQAYKpTSWQWbEsE44KZ4NYVqGYHd65YO76
 zo/T7kFzV9kcW3pHdo0F4OFR9Kh8cTJ8RfLHMj62aiZ08SiVPjuyNIZMbnjNjU6/2Jaw
 h9Zw==
X-Gm-Message-State: AOJu0YwTXxQSS+EZTffrynk1iumViD9+mCMv8Fe1cnm8eCXkMSnrWNRJ
 wAAW7CJ9544dJeNZrM/3AA8eZjsrJ0uPaGJ6OgfgIrazklQEMHb98P6SN6Eg1/jAlgKP8JMjpAp
 bHlXqK+mZNWSgU6nsKYarAXcsaw9Pjlhv59ZBWq+OZIufOc89JNb8GlMg1uLLZynNRPVKSspQa2
 mNQEgRcQ==
X-Gm-Gg: AfdE7cmfH9XnmxJSbgboejxwqunVtF6Svg0vEqt7PpGA8ObD2cyNPIVo7QHB0n6L4yv
 Ll8aoVmgwD0yvG2M37weYslqo40Pavgy57ALsVeiH29zMwi2wPfgyI+ElNP0aijrwZsHxPfmA8g
 Whx4g2INCFo8Y5xyLrj01zgPrMhZdw2OSVrQur/v0KPxeRqVjk0DENXxM4DZdkIeiXqF7d6At6r
 eGZckG4zkx/Vp+IlrGwJT+jNP9YofSvW6yNU5yyf4fKOaO7asB3NJc31Q3w6m9DyTmUJ+Ma41bc
 vTy3EIoaenELBj2D+/jsbOcHfgmAEIFcmAswJFTqAEaSFl4r9SF4An1Wip3uD6D3mmpPF9s/Umy
 voEpIgnlUVwTAFXKuaeyNPlvqBdpHh1e1rUWdEZ1yxVg9hdb06k/i+d34jP/fDGBVFuKk8bfeen
 Nv0edoq7Dq9EtPc6sQOXa7kXnR3QOZFMOLJqZJNVUzlFciGL8/disJMv8Texu3jC7YxkkgBcUC0
 zppKlqVKmFnd9/P0NQ3F8hEinlOjt8ur3TGsyk+xXf4/EtlqxHTIFuTUW4fmETnG6B4utgszjij
 IFKS+RfZoYcvMA==
X-Received: by 2002:a05:600c:4895:b0:493:b6ee:fcb7 with SMTP id
 5b1f17b1804b1-493f87eb2bfmr82713015e9.14.1784034076945; 
 Tue, 14 Jul 2026 06:01:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7f84sm7763540f8f.27.2026.07.14.06.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 6e4746b5ad1e73d7bf95b650d780b7a07e7a7506
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0d28ad9af29b6b388b13354e154c51685ed638f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclH-00027n-PE
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4397278140355089486=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4397278140355089486==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XVNi/o0xfq8="; charset=UTF-8

--XVNi/o0xfq8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1571?usp=3Demail

to look at the new patch set (#1=
0)=2E


Change subject: Change hash iv to a dynamically allocated ctx
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change hash iv t=
o a dynamically allocated ctx

While for our own hash function, always usin=
g an uint32_t works well, it does
not work very well if we move to another =
hash function=2E Move the context of
a hardcoded uint32_t iv to a void poin=
ter to a real ctx=2E

Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
=
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/list=2Ec=

M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M src/openvpn/mroute=2Eh
M=
 src/openvpn/multi=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
6 files cha=
nged, 49 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/71/1571/10

diff --git a/src/openvpn/list=
=2Ec b/src/openvpn/list=2Ec
index c07e764=2E=2E83b42b6 100644
--- a/src/ope=
nvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -29,13 +29,16 @@
 
 #include "i=
nteger=2Eh"
 #include "list=2Eh"
+
+#include "crypto=2Eh"
 #include "misc=
=2Eh"
 
 #include "memdbg=2Eh"
 
 struct hash *
-hash_init(const uint32_t n=
_buckets, const uint32_t iv,
-          uint64_t (*hash_function)(const voi=
d *key, uint32_t iv),
+hash_init(const uint32_t n_buckets, void *ctx,
+    =
      void (*free_hash_ctx)(void *ctx),
+          uint64_t (*hash_function=
)(const void *key, void *ctx),
           bool (*compare_function)(const vo=
id *key1, const void *key2))
 {
     struct hash *h;
@@ -46,7 +49,8 @@
    =
 h->mask =3D h->n_buckets - 1;
     h->hash_function =3D hash_function;
   =
  h->compare_function =3D compare_function;
-    h->iv =3D iv;
+    h->free=
_ctx =3D free_hash_ctx;
+    h->ctx =3D ctx;
     ALLOC_ARRAY(h->buckets, s=
truct hash_bucket, h->n_buckets);
     for (uint32_t i =3D 0; i < h->n_buck=
ets; ++i)
     {
@@ -71,6 +75,7 @@
             he =3D next;
         }
   =
  }
+    hash->free_ctx(hash->ctx);
     free(hash->buckets);
     free(has=
h);
 }
@@ -412,6 +417,18 @@
         c ^=3D (b >> 15); \
     }
 
+/**
+ * =
Creates a context that allows to use the hash function (hash_func) and
+ * =
@return a new context for the use with hash_func
+ */
+void *
+hash_func_ne=
w_ctx(void)
+{
+    uint32_t *ctx =3D malloc(sizeof(uint32_t));
+    *ctx =
=3D (uint32_t)get_random();
+    return ctx;
+}
+
 uint64_t
 hash_func(cons=
t uint8_t *k, uint32_t length, uint32_t initval)
 {
diff --git a/src/openvp=
n/list=2Eh b/src/openvpn/list=2Eh
index 06377c6=2E=2Eea6f47a 100644
--- a/s=
rc/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -54,14 +54,17 @@
     uin=
t32_t n_buckets;
     uint32_t n_elements;
     uint32_t mask;
-    uint32_=
t iv;
-    uint64_t (*hash_function)(const void *key, uint32_t iv);
+    vo=
id *ctx;
+    uint64_t (*hash_function)(const void *key, void *ctx);
     b=
ool (*compare_function)(const void *key1, const void *key2); /* return true=
 if equal */
+    void (*free_ctx)(void *ctx);
+    void *free_ctx_arg;
   =
  struct hash_bucket *buckets;
 };
 
-struct hash *hash_init(const uint32_t=
 n_buckets, const uint32_t iv,
-                       uint64_t (*hash_func=
tion)(const void *key, uint32_t iv),
+struct hash *hash_init(const uint32_t=
 n_buckets, void *ctx,
+                       void (*free_hash_ctx)(void *=
ctx),
+                       uint64_t (*hash_function)(const void *key, vo=
id *ctx),
                        bool (*compare_function)(const void *key1=
, const void *key2));
 
 void hash_free(struct hash *hash);
@@ -100,10 +103=
,12 @@
 
 uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t in=
itval);
 
+void *hash_func_new_ctx(void);
+
 static inline uint64_t
 hash_v=
alue(const struct hash *hash, const void *key)
 {
-    return (*hash->hash_=
function)(key, hash->iv);
+    return (*hash->hash_function)(key, hash->ctx=
);
 }
 
 static inline uint32_t
diff --git a/src/openvpn/mroute=2Ec b/src/o=
penvpn/mroute=2Ec
index 78c689e=2E=2E89b3ecc 100644
--- a/src/openvpn/mrout=
e=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -355,10 +355,11 @@
  * and the actual=
 address=2E
  */
 uint64_t
-mroute_addr_hash_function(const void *key, uint=
32_t iv)
+mroute_addr_hash_function(const void *key, void *ctx)
 {
+    uin=
t32_t *iv =3D ctx;
     return hash_func(mroute_addr_hash_ptr((const struct=
 mroute_addr *)key),
-                     mroute_addr_hash_len((const stru=
ct mroute_addr *)key), iv);
+                     mroute_addr_hash_len((con=
st struct mroute_addr *)key), *iv);
 }
 
 bool
diff --git a/src/openvpn/mro=
ute=2Eh b/src/openvpn/mroute=2Eh
index 2f5d019=2E=2E51b62d2 100644
--- a/sr=
c/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +144,7 @@
 
 bo=
ol mroute_learnable_address(const struct mroute_addr *addr, struct gc_arena=
 *gc);
 
-uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);=

+uint64_t mroute_addr_hash_function(const void *key, void *ctx);
 
 bool m=
route_addr_compare_function(const void *key1, const void *key2);
 
diff --g=
it a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 841affe=2E=2E0eede=
a3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -229,7=
 +229,7 @@
 #ifdef ENABLE_MANAGEMENT
 
 static uint64_t
-cid_hash_function(=
const void *key, uint32_t iv)
+cid_hash_function(const void *key, void *ctx=
)
 {
     const unsigned long *k =3D (const unsigned long *)key;
     retur=
n (uint64_t)*k;
@@ -250,7 +250,7 @@
 /*
  * inotify watcher descriptors are=
 used as hash value
  */
-int_hash_function(const void *key, uint32_t iv)
+=
int_hash_function(const void *key, void *ctx)
 {
     return (uintptr_t)key=
;
 }
@@ -290,27 +290,30 @@
      * to determine which client sent an incomi=
ng packet
      * which is seen on the TCP/UDP socket=2E
      */
-    m->h=
ash =3D hash_init(t->options=2Ereal_hash_size, (uint32_t)get_random(),
+   =
 m->hash =3D hash_init(t->options=2Ereal_hash_size, hash_func_new_ctx(), fr=
ee,
                         mroute_addr_hash_function, mroute_addr_compare=
_function);
 
     /*
      * Virtual address hash table=2E  Used to determ=
ine
      * which client to route a packet to=2E
      */
-    m->vhash =3D=
 hash_init(t->options=2Evirtual_hash_size, (uint32_t)get_random(),
+    m->=
vhash =3D hash_init(t->options=2Evirtual_hash_size, hash_func_new_ctx(), fr=
ee,
                          mroute_addr_hash_function, mroute_addr_compar=
e_function);
 
 #ifdef ENABLE_MANAGEMENT
-    m->cid_hash =3D hash_init(t->=
options=2Ereal_hash_size, 0, cid_hash_function, cid_compare_function);
+   =
 m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, NULL, free, cid_has=
h_function, cid_compare_function);
 #endif
 
 #ifdef ENABLE_ASYNC_PUSH
    =
 /*
      * Mapping between inotify watch descriptors and
      * multi_ins=
tances=2E
+     *
+     * Note we use a custom hash function here so we use=
 dummy
+     * value and function for the context parameters=2E
      */
- =
   m->inotify_watchers =3D hash_init(t->options=2Ereal_hash_size, (uint32_t=
)get_random(),
-                                    int_hash_function, int_=
compare_function);
+    m->inotify_watchers =3D
+        hash_init(t->optio=
ns=2Ereal_hash_size, NULL, free, int_hash_function, int_compare_function);
=
 #endif
 
     /*
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tes=
ts/unit_tests/openvpn/test_misc=2Ec
index fc9840a=2E=2E7f22ad2 100644
--- a=
/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec
@@ -128,11 +128,12 @@
 
 
 static uint64_t
-word_hash_function(co=
nst void *key, uint32_t iv)
+word_hash_function(const void *key, void *ctx)=

 {
+    uint32_t *iv =3D (uint32_t *)ctx;
     const char *str =3D (const =
char *)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-    return =
hash_func((const uint8_t *)str, len, iv);
+    return hash_func((const uint=
8_t *)str, len, *iv);
 }
 
 static bool
@@ -174,10 +175,9 @@
      * Test t=
he hash code by implementing a simple
      * word frequency algorithm=2E
 =
     */
-
     struct gc_arena gc =3D gc_new();
-    struct hash *hash =3D =
hash_init(10000, get_random(), word_hash_function, word_compare_function);
=
-    struct hash *nhash =3D hash_init(256, get_random(), word_hash_function=
, word_compare_function);
+    struct hash *hash =3D hash_init(10000, hash_=
func_new_ctx(), free, word_hash_function, word_compare_function);
+    stru=
ct hash *nhash =3D hash_init(256, hash_func_new_ctx(), free, word_hash_func=
tion, word_compare_function);
 
     printf("hash_init n_buckets=3D%u mask=
=3D0x%08x\n", hash->n_buckets, hash->mask);
 

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Ge=
rrit-Change-Number: 1571
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--XVNi/o0xfq8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #10</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">C=
hange hash iv to a dynamically allocated ctx<br><br>While for our own hash =
function, always using an uint32_t works well, it does<br>not work very wel=
l if we move to another hash function=2E Move the context of<br>a hardcoded=
 uint32_t iv to a void pointer to a real ctx=2E<br><br>Change-Id: If47c7d92=
0b2fa4047b7db03fcde821899839324d<br>Signed-off-by: Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;<br>---<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<=
br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mroute=2Eh<br>M src/openvpn/mu=
lti=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>6 files changed, 49 =
insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/10</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index c07=
e764=2E=2E83b42b6 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><=
br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -29,13 +29,16 @@</sp=
an><br><span> </span><br><span> #include &quot;integer=2Eh&quot;</span><br>=
<span> #include &quot;list=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;crypto=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot=
;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span>=
<br><span> </span><br><span> struct hash *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-hash_init(const uint32_t n_buckets, const uint32_t iv,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          uint64_t (*=
hash_function)(const void *key, uint32_t iv),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+hash_init(const uint32_t n_buckets, void *ctx,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          void (*free_=
hash_ctx)(void *ctx),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+          uint64_t (*hash_function)(const void *key, void *ctx),</span><b=
r><span>           bool (*compare_function)(const void *key1, const void *k=
ey2))</span><br><span> {</span><br><span>     struct hash *h;</span><br><sp=
an>@@ -46,7 +49,8 @@</span><br><span>     h-&gt;mask =3D h-&gt;n_buckets - =
1;</span><br><span>     h-&gt;hash_function =3D hash_function;</span><br><s=
pan>     h-&gt;compare_function =3D compare_function;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv =3D iv;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    h-&gt;free_ctx =3D free_hash_ctx;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    h-&gt;ctx =3D ctx;<=
/span><br><span>     ALLOC_ARRAY(h-&gt;buckets, struct hash_bucket, h-&gt;n=
_buckets);</span><br><span>     for (uint32_t i =3D 0; i &lt; h-&gt;n_bucke=
ts; ++i)</span><br><span>     {</span><br><span>@@ -71,6 +75,7 @@</span><br=
><span>             he =3D next;</span><br><span>         }</span><br><span=
>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash-&gt=
;free_ctx(hash-&gt;ctx);</span><br><span>     free(hash-&gt;buckets);</span=
><br><span>     free(hash);</span><br><span> }</span><br><span>@@ -412,6 +4=
17,18 @@</span><br><span>         c ^=3D (b &gt;&gt; 15); \</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Creates=
 a context that allows to use the hash function (hash_func) and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return a new context for th=
e use with hash_func</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+hash_func_new_ctx(void)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t *ctx =3D malloc(sizeof(uint3=
2_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *ctx =3D =
(uint32_t)get_random();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
uint64_t</span><br><span> hash_func(const uint8_t *k, uint32_t length, uint=
32_t initval)</span><br><span> {</span><br><span>diff --git a/src/openvpn/l=
ist=2Eh b/src/openvpn/list=2Eh</span><br><span>index 06377c6=2E=2Eea6f47a 1=
00644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/=
openvpn/list=2Eh</span><br><span>@@ -54,14 +54,17 @@</span><br><span>     u=
int32_t n_buckets;</span><br><span>     uint32_t n_elements;</span><br><spa=
n>     uint32_t mask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    uint32_t iv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
int64_t (*hash_function)(const void *key, uint32_t iv);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    void *ctx;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)(const void *ke=
y, void *ctx);</span><br><span>     bool (*compare_function)(const void *ke=
y1, const void *key2); /* return true if equal */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    void (*free_ctx)(void *ctx);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    void *free_ctx_arg;</span><b=
r><span>     struct hash_bucket *buckets;</span><br><span> };</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct hash *hash=
_init(const uint32_t n_buckets, const uint32_t iv,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                       uint64_t (*hash_functio=
n)(const void *key, uint32_t iv),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+struct hash *hash_init(const uint32_t n_buckets, void *ctx,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
  void (*free_hash_ctx)(void *ctx),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       uint64_t (*hash_function)(const void=
 *key, void *ctx),</span><br><span>                        bool (*compare_f=
unction)(const void *key1, const void *key2));</span><br><span> </span><br>=
<span> void hash_free(struct hash *hash);</span><br><span>@@ -100,10 +103,1=
2 @@</span><br><span> </span><br><span> uint64_t hash_func(const uint8_t *k=
, uint32_t length, uint32_t initval);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void *hash_func_new_ctx(void);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inl=
ine uint64_t</span><br><span> hash_value(const struct hash *hash, const voi=
d *key)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return (*hash-&gt;hash_function)(key, hash-&gt;iv);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return (*hash-&gt;hash_functio=
n)(key, hash-&gt;ctx);</span><br><span> }</span><br><span> </span><br><span=
> static inline uint32_t</span><br><span>diff --git a/src/openvpn/mroute=2E=
c b/src/openvpn/mroute=2Ec</span><br><span>index 78c689e=2E=2E89b3ecc 10064=
4</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/op=
envpn/mroute=2Ec</span><br><span>@@ -355,10 +355,11 @@</span><br><span>  * =
and the actual address=2E</span><br><span>  */</span><br><span> uint64_t</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-mroute_addr_hash_functio=
n(const void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+mroute_addr_hash_function(const void *key, void *ctx)</span><br=
><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32=
_t *iv =3D ctx;</span><br><span>     return hash_func(mroute_addr_hash_ptr(=
(const struct mroute_addr *)key),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                     mroute_addr_hash_len((const struct mroute_=
addr *)key), iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   mroute_addr_hash_len((const struct mroute_addr *)key), *=
iv);</span><br><span> }</span><br><span> </span><br><span> bool</span><br><=
span>diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br=
><span>index 2f5d019=2E=2E51b62d2 100644</span><br><span>--- a/src/openvpn/=
mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ =
-144,7 +144,7 @@</span><br><span> </span><br><span> bool mroute_learnable_a=
ddress(const struct mroute_addr *addr, struct gc_arena *gc);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t mroute_ad=
dr_hash_function(const void *key, uint32_t iv);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function(const void *=
key, void *ctx);</span><br><span> </span><br><span> bool mroute_addr_compar=
e_function(const void *key1, const void *key2);</span><br><span> </span><br=
><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br=
><span>index 841affe=2E=2E0eedea3 100644</span><br><span>--- a/src/openvpn/=
multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -2=
29,7 +229,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> <=
/span><br><span> static uint64_t</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-cid_hash_function(const void *key, uint32_t iv)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+cid_hash_function(const void *key, v=
oid *ctx)</span><br><span> {</span><br><span>     const unsigned long *k =
=3D (const unsigned long *)key;</span><br><span>     return (uint64_t)*k;</=
span><br><span>@@ -250,7 +250,7 @@</span><br><span> /*</span><br><span>  * =
inotify watcher descriptors are used as hash value</span><br><span>  */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int_hash_function(const v=
oid *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int_hash_function(const void *key, void *ctx)</span><br><span> {</span><=
br><span>     return (uintptr_t)key;</span><br><span> }</span><br><span>@@ =
-290,27 +290,30 @@</span><br><span>      * to determine which client sent a=
n incoming packet</span><br><span>      * which is seen on the TCP/UDP sock=
et=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size, (uint=
32_t)get_random(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size, hash_func_new_c=
tx(), free,</span><br><span>                         mroute_addr_hash_funct=
ion, mroute_addr_compare_function);</span><br><span> </span><br><span>     =
/*</span><br><span>      * Virtual address hash table=2E  Used to determine=
</span><br><span>      * which client to route a packet to=2E</span><br><sp=
an>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;=
vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size, (uint32_t)get_random=
(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =
=3D hash_init(t-&gt;options=2Evirtual_hash_size, hash_func_new_ctx(), free,=
</span><br><span>                          mroute_addr_hash_function, mrout=
e_addr_compare_function);</span><br><span> </span><br><span> #ifdef ENABLE_=
MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;c=
id_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, 0, cid_hash_function,=
 cid_compare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, NULL, =
free, cid_hash_function, cid_compare_function);</span><br><span> #endif</sp=
an><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>  =
   /*</span><br><span>      * Mapping between inotify watch descriptors and=
</span><br><span>      * multi_instances=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * Note we use a custom hash function here so we use dummy</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * value and func=
tion for the context parameters=2E</span><br><span>      */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;inotify_watchers =3D hash_i=
nit(t-&gt;options=2Ereal_hash_size, (uint32_t)get_random(),</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                    i=
nt_hash_function, int_compare_function);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    m-&gt;inotify_watchers =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hash_init(t-&gt;options=2Ereal_ha=
sh_size, NULL, free, int_hash_function, int_compare_function);</span><br><s=
pan> #endif</span><br><span> </span><br><span>     /*</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/t=
est_misc=2Ec</span><br><span>index fc9840a=2E=2E7f22ad2 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -128,11 +128,12 @@</s=
pan><br><span> </span><br><span> </span><br><span> static uint64_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-word_hash_function(const void =
*key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+w=
ord_hash_function(const void *key, void *ctx)</span><br><span> {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t *iv =3D (uint32_t=
 *)ctx;</span><br><span>     const char *str =3D (const char *)key;</span><=
br><span>     const uint32_t len =3D (uint32_t)strlen(str);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return hash_func((const uint8_t *=
)str, len, iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return hash_func((const uint8_t *)str, len, *iv);</span><br><span> }</span>=
<br><span> </span><br><span> static bool</span><br><span>@@ -174,10 +175,9 =
@@</span><br><span>      * Test the hash code by implementing a simple</spa=
n><br><span>      * word frequency algorithm=2E</span><br><span>      */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct hash *hash =3D hash_init(10000, get_random(), word_hash=
_function, word_compare_function);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct hash *nhash =3D hash_init(256, get_random(), word_h=
ash_function, word_compare_function);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, hash_func_new_=
ctx(), free, word_hash_function, word_compare_function);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash =3D hash_init(2=
56, hash_func_new_ctx(), free, word_hash_function, word_compare_function);<=
/span><br><span> </span><br><span>     printf(&quot;hash_init n_buckets=3D%=
u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><spa=
n> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa=
4047b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--XVNi/o0xfq8=--


--===============4397278140355089486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4397278140355089486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4397278140355089486==--

