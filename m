Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ED7C4453A
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UzMbaHmKze/75nbohTILL9Zjr7WEQQInKwkdrAig12o=; b=cS5FQ9dc5CpdMpwn5BuZ2z+cWY
	Sj5GRwa5Rz5nPujphrpxBg5PlcTSs0yy3F/P/s+FpYHnkcrJczP9BLnBo7iWTF/9ttBTyXUVCT0wo
	lTrkiDDFf2NMFt9pZO7nUvE0w5Lcq15xWC5nWxdcTsHaz2o7aTtY1JI5mUgMdffF1UJA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmUCd-0004To-QO;
	Wed, 22 Jul 2026 10:29:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmUCc-0004Ti-Uy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=12B0bbvtXHTWyqLxJWEZfp/lBL7IlklypK9sb51wlWY=; b=OCylh0ijzjSLHMERjRoMD0JKSp
 Dbe8SOzsVv23WtFvW+V/48h7flYgwxTuq6WZRojw6c1woUIjbLtTVixeHQjYaJZRE7H0fFUxBBzKo
 c9Egch9PUpbgRkTIvRGPSzh5p6oN8KOE/3EJEK+l8UiiS1HVwxTLpckBu+JkEmX4HFwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=12B0bbvtXHTWyqLxJWEZfp/lBL7IlklypK9sb51wlWY=; b=T
 7jPZERB6WaLlAJUnGASDJHZbtmJVqCPiXtpriwZnRKHZKawIDPFIiS4Syk8U215+6t/g7PgcQaORV
 f4tpc/ublOnjDAuyfJRCq9on7ZAfCXYq8/xRCwxOhWIPluGA0+AcbQoE3KvhsYsecRDeZMwPbzEtx
 masmJZTsTXVWi6pY=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmUCb-0007ma-4O for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:29:26 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso24818975e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784716158; x=1785320958; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=12B0bbvtXHTWyqLxJWEZfp/lBL7IlklypK9sb51wlWY=;
 b=BHxeIXZ1TN6aTGkW1cIup8nFYgEhiFLRNRmFi/nI7KA3aWCMoLYl+KU1Is38n/vVlt
 yjZ904WSYpokLDB3X7ecLSQAiBcCVXkhcgYHXDjHyoiLwoOuPsRdoWNS/koo5gkFMDH0
 WUHknCigtXXlPYktS5mbWRuB26em5CbugMjo3io84QW+mghrlbRIErgGk+KS5EiX+Vt4
 BIMDpRUlvi3JZXFVkfp27hkEPsvMLYM3yVo/livqX+7u99jnL8kRwKchzWzk8P/o8Pds
 hDoLA5LnjceqhVgd6KlSkQLxHaQBdq3tX7t1mn2RgPbTt8zL6YCDHdqEu0oE4NO3fCfT
 rnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784716158; x=1785320958;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=12B0bbvtXHTWyqLxJWEZfp/lBL7IlklypK9sb51wlWY=;
 b=CRB+94wStFj+Aiox3LJqFGAsAjoeDzkwpxvIBorqrRBYdllNughYB/YqmuHDyqI94M
 LmReubOqa47Aip+lkqvFzNysljlzA0EqpbxC7N7eYgLpbNgSK+sf7t+17dFwzsovzJwz
 C+8j92ynDK6pHUQRrURJPF0ayu7dlLxCnrAxKOnSstbyI5KapEnG+y1qvBTuc5vZdAwB
 azDqQFkHPFEVjuXMMXbSAki1oUO4u0Vcr9ftjhNIU1R+Iy9LEh7ul1TB1QHnGbCYqOIu
 NEInQVdmW2Zg+jZC90CL0n2vHTpUPQwz1lUxkpwrxiZCg+xX3OLUD8KY0TsVc/FvvWL7
 XyiA==
X-Gm-Message-State: AOJu0Yz7Lai2Ob39mYCMAYxJqC9f8jtb+El3z069795DZekWkUKAFUdJ
 23vrv1A0aIhnr36cmsEHFUaS8KZrBaUecz2g7Ee6EVDcGXdsY2DRkTP+u9i1gqFjLNa8O7stvrJ
 RRJ8Ut/0ZO01q/n9chmDxhzi273pQW4XetfCX1ZmqY2QTmIONQZP0bDfwcfcwnsg1SlWElTP1RH
 XaMdT/hA==
X-Gm-Gg: AR+sD11n1yclEIJJrEEMXCNaaNl8v03YDGeJSQhegcVZ/x0cdFY67uGahQyPpRuQtCM
 DLiayHCbtJ0Caf65gJtIcXZu96KiPlJ5aRFJo8HggDjslj8EY9XObpdSm3UPMxZDHO17W8SL498
 3dWHa7zLVN85fAQAKnA4douiZMmkkm7+EHXOY+RMN0JjOIVs3ohoiX3XGcf1q+XH/mxhClxYMyA
 otFlWd7qb+dcBQPzluvvOMvjufaJCnawVf2ESD8VyqlUV+MpmhsTS5AWj9Q3OCjCj0Yw5kMFDz/
 50z1OY5mucqJUPpPheIlxABkba2JPZvUZr68nxMbP5872lm5Flh5J1mMQAV4iLJ13b9wCSh9zzS
 NYr8Gi9gXm9Dy5k8MvNkDkA48xhT4PRaYvabhrKeGOFrGt8r+obiLOJjnkAZug6NoA9SuQuJhRC
 Y1pefswSxIoyWdQtT+LCgT35/9MW5SrUJCprcWw0vP9gFwzMRQ2hug3t9d4hdBoH9V/I3mtJfl5
 vQqv7MEiHtRPclZv6iepmrqYu8mAAJjbIyMAM7wR9t0jYSTgz3eSV1YMCz78IVHchAf
X-Received: by 2002:a05:600c:b99:b0:495:4cba:e288 with SMTP id
 5b1f17b1804b1-4954cbae4cdmr236445915e9.15.1784716158415; 
 Wed, 22 Jul 2026 03:29:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfed7sm148109215e9.11.2026.07.22.03.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:29:18 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:29:13 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 6a05e204529f98fe625f740faa5173b1901e2065
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <23633be71bdeb5b25aaabb8daf4822048e1ea8ae-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmUCb-0007ma-4O
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
Content-Type: multipart/mixed; boundary="===============0792940762181723829=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0792940762181723829==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oh21JKPaNfg="; charset=UTF-8

--oh21JKPaNfg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1571?usp=3Demail

to look at the new patch set (#1=
1)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by flichtenheld


Change subject: Change hash iv to a dynamically allocate=
d ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change =
hash iv to a dynamically allocated ctx

While for our own hash function, al=
ways using an uint32_t works well, it does
not work very well if we move to=
 another hash function=2E Move the context of
a hardcoded uint32_t iv to a =
void pointer to a real ctx=2E

Change-Id: If47c7d920b2fa4047b7db03fcde82189=
9839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn=
/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M src/openvpn/mro=
ute=2Eh
M src/openvpn/multi=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
6 =
files changed, 48 insertions(+), 23 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/11

diff --git a/src/op=
envpn/list=2Ec b/src/openvpn/list=2Ec
index c07e764=2E=2E83b42b6 100644
---=
 a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -29,13 +29,16 @@
 
 #=
include "integer=2Eh"
 #include "list=2Eh"
+
+#include "crypto=2Eh"
 #inclu=
de "misc=2Eh"
 
 #include "memdbg=2Eh"
 
 struct hash *
-hash_init(const ui=
nt32_t n_buckets, const uint32_t iv,
-          uint64_t (*hash_function)(c=
onst void *key, uint32_t iv),
+hash_init(const uint32_t n_buckets, void *ct=
x,
+          void (*free_hash_ctx)(void *ctx),
+          uint64_t (*hash_=
function)(const void *key, void *ctx),
           bool (*compare_function)(=
const void *key1, const void *key2))
 {
     struct hash *h;
@@ -46,7 +49,8=
 @@
     h->mask =3D h->n_buckets - 1;
     h->hash_function =3D hash_funct=
ion;
     h->compare_function =3D compare_function;
-    h->iv =3D iv;
+   =
 h->free_ctx =3D free_hash_ctx;
+    h->ctx =3D ctx;
     ALLOC_ARRAY(h->bu=
ckets, struct hash_bucket, h->n_buckets);
     for (uint32_t i =3D 0; i < h=
->n_buckets; ++i)
     {
@@ -71,6 +75,7 @@
             he =3D next;
      =
   }
     }
+    hash->free_ctx(hash->ctx);
     free(hash->buckets);
     =
free(hash);
 }
@@ -412,6 +417,18 @@
         c ^=3D (b >> 15); \
     }
 
+=
/**
+ * Creates a context that allows to use the hash function (hash_func) =
and
+ * @return a new context for the use with hash_func
+ */
+void *
+hash=
_func_new_ctx(void)
+{
+    uint32_t *ctx =3D malloc(sizeof(uint32_t));
+  =
  *ctx =3D (uint32_t)get_random();
+    return ctx;
+}
+
 uint64_t
 hash_fu=
nc(const uint8_t *k, uint32_t length, uint32_t initval)
 {
diff --git a/src=
/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 06377c6=2E=2E5835b87 100644
=
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -54,14 +54,16 @@
 =
    uint32_t n_buckets;
     uint32_t n_elements;
     uint32_t mask;
-    =
uint32_t iv;
-    uint64_t (*hash_function)(const void *key, uint32_t iv);
=
+    void *ctx;
+    uint64_t (*hash_function)(const void *key, void *ctx);=

     bool (*compare_function)(const void *key1, const void *key2); /* retu=
rn true if equal */
+    void (*free_ctx)(void *ctx);
     struct hash_buck=
et *buckets;
 };
 
-struct hash *hash_init(const uint32_t n_buckets, const =
uint32_t iv,
-                       uint64_t (*hash_function)(const void *=
key, uint32_t iv),
+struct hash *hash_init(const uint32_t n_buckets, void *=
ctx,
+                       void (*free_hash_ctx)(void *ctx),
+           =
            uint64_t (*hash_function)(const void *key, void *ctx),
        =
                bool (*compare_function)(const void *key1, const void *key2=
));
 
 void hash_free(struct hash *hash);
@@ -100,10 +102,12 @@
 
 uint64_t=
 hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
 
+void *h=
ash_func_new_ctx(void);
+
 static inline uint64_t
 hash_value(const struct =
hash *hash, const void *key)
 {
-    return (*hash->hash_function)(key, has=
h->iv);
+    return (*hash->hash_function)(key, hash->ctx);
 }
 
 static in=
line uint32_t
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
=
index 78c689e=2E=2E89b3ecc 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/op=
envpn/mroute=2Ec
@@ -355,10 +355,11 @@
  * and the actual address=2E
  */
 =
uint64_t
-mroute_addr_hash_function(const void *key, uint32_t iv)
+mroute_a=
ddr_hash_function(const void *key, void *ctx)
 {
+    uint32_t *iv =3D ctx;=

     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key=
),
-                     mroute_addr_hash_len((const struct mroute_addr *)k=
ey), iv);
+                     mroute_addr_hash_len((const struct mroute_a=
ddr *)key), *iv);
 }
 
 bool
diff --git a/src/openvpn/mroute=2Eh b/src/open=
vpn/mroute=2Eh
index 2f5d019=2E=2E51b62d2 100644
--- a/src/openvpn/mroute=
=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +144,7 @@
 
 bool mroute_learna=
ble_address(const struct mroute_addr *addr, struct gc_arena *gc);
 
-uint64=
_t mroute_addr_hash_function(const void *key, uint32_t iv);
+uint64_t mrout=
e_addr_hash_function(const void *key, void *ctx);
 
 bool mroute_addr_compa=
re_function(const void *key1, const void *key2);
 
diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec
index fe2badb=2E=2E002293b 100644
--- a/=
src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -229,7 +229,7 @@
 #ifd=
ef ENABLE_MANAGEMENT
 
 static uint64_t
-cid_hash_function(const void *key,=
 uint32_t iv)
+cid_hash_function(const void *key, void *ctx)
 {
     const =
unsigned long *k =3D (const unsigned long *)key;
     return (uint64_t)*k;
=
@@ -250,7 +250,7 @@
 /*
  * inotify watcher descriptors are used as hash va=
lue
  */
-int_hash_function(const void *key, uint32_t iv)
+int_hash_functio=
n(const void *key, void *ctx)
 {
     return (uintptr_t)key;
 }
@@ -290,27 =
+290,30 @@
      * to determine which client sent an incoming packet
      =
* which is seen on the TCP/UDP socket=2E
      */
-    m->hash =3D hash_ini=
t(t->options=2Ereal_hash_size, (uint32_t)get_random(),
+    m->hash =3D has=
h_init(t->options=2Ereal_hash_size, hash_func_new_ctx(), free,
            =
             mroute_addr_hash_function, mroute_addr_compare_function);
 
  =
   /*
      * Virtual address hash table=2E  Used to determine
      * whic=
h client to route a packet to=2E
      */
-    m->vhash =3D hash_init(t->op=
tions=2Evirtual_hash_size, (uint32_t)get_random(),
+    m->vhash =3D hash_i=
nit(t->options=2Evirtual_hash_size, hash_func_new_ctx(), free,
            =
              mroute_addr_hash_function, mroute_addr_compare_function);
 
 =
#ifdef ENABLE_MANAGEMENT
-    m->cid_hash =3D hash_init(t->options=2Ereal_h=
ash_size, 0, cid_hash_function, cid_compare_function);
+    m->cid_hash =3D=
 hash_init(t->options=2Ereal_hash_size, NULL, free, cid_hash_function, cid_=
compare_function);
 #endif
 
 #ifdef ENABLE_ASYNC_PUSH
     /*
      * Mapp=
ing between inotify watch descriptors and
      * multi_instances=2E
+     =
*
+     * Note we use a custom hash function here so we use dummy
+     * v=
alue and function for the context parameters=2E
      */
-    m->inotify_wa=
tchers =3D hash_init(t->options=2Ereal_hash_size, (uint32_t)get_random(),
-=
                                    int_hash_function, int_compare_function=
);
+    m->inotify_watchers =3D
+        hash_init(t->options=2Ereal_hash_s=
ize, NULL, free, int_hash_function, int_compare_function);
 #endif
 
     /=
*
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec
index fc9840a=2E=2E7f22ad2 100644
--- a/tests/unit_test=
s/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -12=
8,11 +128,12 @@
 
 
 static uint64_t
-word_hash_function(const void *key, u=
int32_t iv)
+word_hash_function(const void *key, void *ctx)
 {
+    uint32_=
t *iv =3D (uint32_t *)ctx;
     const char *str =3D (const char *)key;
    =
 const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_func((const=
 uint8_t *)str, len, iv);
+    return hash_func((const uint8_t *)str, len, =
*iv);
 }
 
 static bool
@@ -174,10 +175,9 @@
      * Test the hash code by =
implementing a simple
      * word frequency algorithm=2E
      */
-
     s=
truct gc_arena gc =3D gc_new();
-    struct hash *hash =3D hash_init(10000,=
 get_random(), word_hash_function, word_compare_function);
-    struct hash=
 *nhash =3D hash_init(256, get_random(), word_hash_function, word_compare_f=
unction);
+    struct hash *hash =3D hash_init(10000, hash_func_new_ctx(), =
free, word_hash_function, word_compare_function);
+    struct hash *nhash =
=3D hash_init(256, hash_func_new_ctx(), free, word_hash_function, word_comp=
are_function);
 
     printf("hash_init n_buckets=3D%u mask=3D0x%08x\n", ha=
sh->n_buckets, hash->mask);
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Numb=
er: 1571
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>

--oh21JKPaNfg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #11</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>The followin=
g approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Change hash iv to a dynamically allocated ctx<br><br>While f=
or our own hash function, always using an uint32_t works well, it does<br>n=
ot work very well if we move to another hash function=2E Move the context o=
f<br>a hardcoded uint32_t iv to a void pointer to a real ctx=2E<br><br>Chan=
ge-Id: If47c7d920b2fa4047b7db03fcde821899839324d<br>Signed-off-by: Arne Sch=
wabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/list=2Ec<br>M src/o=
penvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br>M src/openvpn/mroute=2Eh<br>=
M src/openvpn/multi=2Ec<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>6 fi=
les changed, 48 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/11<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br>=
<span>index c07e764=2E=2E83b42b6 100644</span><br><span>--- a/src/openvpn/l=
ist=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -29,1=
3 +29,16 @@</span><br><span> </span><br><span> #include &quot;integer=2Eh&q=
uot;</span><br><span> #include &quot;list=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span> #include &q=
uot;misc=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=
=2Eh&quot;</span><br><span> </span><br><span> struct hash *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-hash_init(const uint32_t n_buckets, c=
onst uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
      uint64_t (*hash_function)(const void *key, uint32_t iv),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+hash_init(const uint32_t n_bucke=
ts, void *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
     void (*free_hash_ctx)(void *ctx),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          uint64_t (*hash_function)(const void *key, voi=
d *ctx),</span><br><span>           bool (*compare_function)(const void *ke=
y1, const void *key2))</span><br><span> {</span><br><span>     struct hash =
*h;</span><br><span>@@ -46,7 +49,8 @@</span><br><span>     h-&gt;mask =3D h=
-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_function =3D hash_funct=
ion;</span><br><span>     h-&gt;compare_function =3D compare_function;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv =3D iv;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    h-&gt;free_ctx =3D fr=
ee_hash_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    h-&=
gt;ctx =3D ctx;</span><br><span>     ALLOC_ARRAY(h-&gt;buckets, struct hash=
_bucket, h-&gt;n_buckets);</span><br><span>     for (uint32_t i =3D 0; i &l=
t; h-&gt;n_buckets; ++i)</span><br><span>     {</span><br><span>@@ -71,6 +7=
5,7 @@</span><br><span>             he =3D next;</span><br><span>         }=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    hash-&gt;free_ctx(hash-&gt;ctx);</span><br><span>     free(hash-&gt=
;buckets);</span><br><span>     free(hash);</span><br><span> }</span><br><s=
pan>@@ -412,6 +417,18 @@</span><br><span>         c ^=3D (b &gt;&gt; 15); \=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Creates a context that allows to use the hash function (hash_func)=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return a ne=
w context for the use with hash_func</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_func_ne=
w_ctx(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t *ctx =3D mall=
oc(sizeof(uint32_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *ctx =3D (uint32_t)get_random();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ctx;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> uint64_t</span><br><span> hash_func(const uint8_t *k, uint32=
_t length, uint32_t initval)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 06377c6=
=2E=2E5835b87 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><=
span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -54,14 +54,16 @@</span><=
br><span>     uint32_t n_buckets;</span><br><span>     uint32_t n_elements;=
</span><br><span>     uint32_t mask;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint32_t iv;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    uint64_t (*hash_function)(const void *key, uint32_t iv);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *ctx;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)=
(const void *key, void *ctx);</span><br><span>     bool (*compare_function)=
(const void *key1, const void *key2); /* return true if equal */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    void (*free_ctx)(void *ctx=
);</span><br><span>     struct hash_bucket *buckets;</span><br><span> };</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct=
 hash *hash_init(const uint32_t n_buckets, const uint32_t iv,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                       uint64_t (*h=
ash_function)(const void *key, uint32_t iv),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct hash *hash_init(const uint32_t n_buckets, v=
oid *ctx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
             void (*free_hash_ctx)(void *ctx),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                       uint64_t (*hash_function)=
(const void *key, void *ctx),</span><br><span>                        bool =
(*compare_function)(const void *key1, const void *key2));</span><br><span> =
</span><br><span> void hash_free(struct hash *hash);</span><br><span>@@ -10=
0,10 +102,12 @@</span><br><span> </span><br><span> uint64_t hash_func(const=
 uint8_t *k, uint32_t length, uint32_t initval);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void *hash_func_new_ctx(void=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 static inline uint64_t</span><br><span> hash_value(const struct hash *hash=
, const void *key)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return (*hash-&gt;hash_function)(key, hash-&gt;iv);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (*hash-&gt;h=
ash_function)(key, hash-&gt;ctx);</span><br><span> }</span><br><span> </spa=
n><br><span> static inline uint32_t</span><br><span>diff --git a/src/openvp=
n/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 78c689e=2E=2E89=
b3ecc 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+=
++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -355,10 +355,11 @@</span><br=
><span>  * and the actual address=2E</span><br><span>  */</span><br><span> =
uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mroute_addr_h=
ash_function(const void *key, uint32_t iv)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+mroute_addr_hash_function(const void *key, void *ctx=
)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint32_t *iv =3D ctx;</span><br><span>     return hash_func(mroute_add=
r_hash_ptr((const struct mroute_addr *)key),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                     mroute_addr_hash_len((const str=
uct mroute_addr *)key), iv);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                     mroute_addr_hash_len((const struct mroute_add=
r *)key), *iv);</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span>diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2E=
h</span><br><span>index 2f5d019=2E=2E51b62d2 100644</span><br><span>--- a/s=
rc/openvpn/mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh</span><b=
r><span>@@ -144,7 +144,7 @@</span><br><span> </span><br><span> bool mroute_=
learnable_address(const struct mroute_addr *addr, struct gc_arena *gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_=
t mroute_addr_hash_function(const void *key, uint32_t iv);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function(c=
onst void *key, void *ctx);</span><br><span> </span><br><span> bool mroute_=
addr_compare_function(const void *key1, const void *key2);</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c</span><br><span>index fe2badb=2E=2E002293b 100644</span><br><span>--- a/s=
rc/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br>=
<span>@@ -229,7 +229,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><=
br><span> </span><br><span> static uint64_t</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-cid_hash_function(const void *key, uint32_t iv)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+cid_hash_function(const v=
oid *key, void *ctx)</span><br><span> {</span><br><span>     const unsigned=
 long *k =3D (const unsigned long *)key;</span><br><span>     return (uint6=
4_t)*k;</span><br><span>@@ -250,7 +250,7 @@</span><br><span> /*</span><br><=
span>  * inotify watcher descriptors are used as hash value</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int_hash_functio=
n(const void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int_hash_function(const void *key, void *ctx)</span><br><span> =
{</span><br><span>     return (uintptr_t)key;</span><br><span> }</span><br>=
<span>@@ -290,27 +290,30 @@</span><br><span>      * to determine which clie=
nt sent an incoming packet</span><br><span>      * which is seen on the TCP=
/UDP socket=2E</span><br><span>      */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_si=
ze, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size, hash_f=
unc_new_ctx(), free,</span><br><span>                         mroute_addr_h=
ash_function, mroute_addr_compare_function);</span><br><span> </span><br><s=
pan>     /*</span><br><span>      * Virtual address hash table=2E  Used to =
determine</span><br><span>      * which client to route a packet to=2E</spa=
n><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size, (uint32_t)g=
et_random(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&=
gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size, hash_func_new_ctx=
(), free,</span><br><span>                          mroute_addr_hash_functi=
on, mroute_addr_compare_function);</span><br><span> </span><br><span> #ifde=
f ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, 0, cid_hash_=
function, cid_compare_function);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_siz=
e, NULL, free, cid_hash_function, cid_compare_function);</span><br><span> #=
endif</span><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br=
><span>     /*</span><br><span>      * Mapping between inotify watch descri=
ptors and</span><br><span>      * multi_instances=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * Note we use a custom hash function here so we u=
se dummy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * valu=
e and function for the context parameters=2E</span><br><span>      */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;inotify_watchers =
=3D hash_init(t-&gt;options=2Ereal_hash_size, (uint32_t)get_random(),</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
         int_hash_function, int_compare_function);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    m-&gt;inotify_watchers =3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        hash_init(t-&gt;options=
=2Ereal_hash_size, NULL, free, int_hash_function, int_compare_function);</s=
pan><br><span> #endif</span><br><span> </span><br><span>     /*</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests=
/openvpn/test_misc=2Ec</span><br><span>index fc9840a=2E=2E7f22ad2 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -128,11 +12=
8,12 @@</span><br><span> </span><br><span> </span><br><span> static uint64_=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-word_hash_function(c=
onst void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+word_hash_function(const void *key, void *ctx)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t *iv =3D=
 (uint32_t *)ctx;</span><br><span>     const char *str =3D (const char *)ke=
y;</span><br><span>     const uint32_t len =3D (uint32_t)strlen(str);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hash_func((const=
 uint8_t *)str, len, iv);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return hash_func((const uint8_t *)str, len, *iv);</span><br><span=
> }</span><br><span> </span><br><span> static bool</span><br><span>@@ -174,=
10 +175,9 @@</span><br><span>      * Test the hash code by implementing a s=
imple</span><br><span>      * word frequency algorithm=2E</span><br><span> =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct hash *hash =3D hash_init(10000, get_random(),=
 word_hash_function, word_compare_function);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct hash *nhash =3D hash_init(256, get_random=
(), word_hash_function, word_compare_function);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, hash=
_func_new_ctx(), free, word_hash_function, word_compare_function);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash =3D h=
ash_init(256, hash_func_new_ctx(), free, word_hash_function, word_compare_f=
unction);</span><br><span> </span><br><span>     printf(&quot;hash_init n_b=
uckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</spa=
n><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If=
47c7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1571 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--oh21JKPaNfg=--


--===============0792940762181723829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0792940762181723829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0792940762181723829==--

