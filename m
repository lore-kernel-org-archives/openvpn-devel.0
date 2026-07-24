Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E6C53216
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UASWZO7OleG7RtJw2Qx05cPKQW2pdl1jdCj6RDTTEGg=; b=WePlxvyaafzterNyw9wBQhZvTY
	JGlaHpEqVyQo12WIiLUAiC078KcJEiF9nUVms4TTyBqZeXJTldNQ0caf2fFrHXvx5+f2JlISIhSYJ
	d+Kxp/Wn7ZK3DFZwws+CqVs+9VP+uSp4NRGRvPrFTFCKt9x6Li9fQZc0RV+9xJ6g8aBE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIKt-00063v-VK;
	Fri, 24 Jul 2026 16:01:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIKj-00063j-TD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8RY8rlgXwOXKnT0Ck79bsMsdYLpjePghArRntsZE3Cw=; b=i5aiU7ncVVB+Gv6ws9qeScx0PH
 NDC1t2JHRjH3XQo3jSoTiMYmPU1tweKYPuY0BqYeKQvjqiC++erpFPMxHu9ETGkukEAcwGlwu0QwI
 OFOPhupb3AWZsQZmVLPI26uN41dwODHnD8jg0j9R6/WQ02zuhpcFi+WYbuxUzW0rAXIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8RY8rlgXwOXKnT0Ck79bsMsdYLpjePghArRntsZE3Cw=; b=E
 cxoCC+lvu4yuZ1jmiaouRCH8VpZ6S45QbFvE0K5ChGTXZTk0gSNCa6d0r6mxDHk8UehKuhKHPJCEQ
 2rp82hBbfmgUGJXc8M1sDYj4QHHinXjGww2nIf2ekfITm+75w1yx7CE6EfM1yHnuXLCRWeIYPoNuV
 bZA6iVn6OLhIvGbY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIKh-0005aH-Kt for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:06 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso4711045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784908857; x=1785513657; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8RY8rlgXwOXKnT0Ck79bsMsdYLpjePghArRntsZE3Cw=;
 b=eUTBbt2cqj6V32dFr9pilV/px4XqsbgN61YC8QPgDV1OS76qzxdiuuj1mGUgLVUb1K
 0wvEJPrXx8pVak/n6yok1AJEk99O5cemwm1stWAs98ErdZzCx3eQ8RME50IEo3bvW4Ni
 v1tY5YoKf3k50z7iO6g5yzHbUIPnEh5Id/9DiX0WcgYfzufL3YlbSP/Em5nXb1ZtN3wy
 zn1rXu6ljCwIos0NS9u5BS8KJwxDtn9XJLfjHtX5HmKEVn3xhKF2fbfXtXBn9CkqT/Af
 vN5GN0fyh+W4mhW1UfFFgVFzh2iTSGGvuVvTYrvfuEkAu91o6KJhzaX4AakEz77+e7RL
 +QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908857; x=1785513657;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8RY8rlgXwOXKnT0Ck79bsMsdYLpjePghArRntsZE3Cw=;
 b=LOrFeXl9HGSqodDI8tqeVQzOFBis+6j4MedU5NM+oVtJ7tlEK8N9eXfDuRE4FJ2f2f
 xMuMzb0D4XAvfx6IzWlRRXDnivL1UPL2zX6aVullndCMWpGqprGqTlrWPcak0da0E6UB
 77IiB3+UO6a3A3QM1G5OXuhE2/LJxeEjf/Ae5vg7EgodiznYSQvssOgMgm5YhauSDH0O
 aas/7q321IHKnjmTiFgw3hxotz37SwMzWBVIDJSvP6mMcgNCPfjuDmlAG0XmMKjMvft+
 teuU0FdCDQftMS/LFVY9P5u/zRyhzGhNBMDevtW+6Rm6I0lmQidfJFootmsNBEW/Wic+
 6jsg==
X-Gm-Message-State: AOJu0Yy6ciSxXpBhsQESbC8POov6ksa9YYIuhuhWDiSWZj0N5SJX3Gki
 0cKGNHOkahP5zuL4A6k4IiCm4XKamdNr8SXulgIxpzDU9aur9YxAnOBWmplfPM9uNIsopjkJJuP
 ZkRerR7aQrbz6bNJOLSDcA3Ma6oZRvvPV+DjMVeSD6zxO6YtLhVdC5xESj1oW1kVnVVwdQRGkap
 /EcsG1aA==
X-Gm-Gg: AR+sD10Dpb8FsFBl8xzV6dwcQ7ewkIbjPuiZMllFEw/bUsicsa0x9zGSCulpPKZtjIJ
 /il/ddGd/+ZfSKtB31OG9Wj1nwcQsItLKCHNM1aPyt9QmZ3l3DqZxTNUkdoOAYIN7ZNp2u8ruom
 8kmiOP5edMVyakntHohO3p26RxCZZLg/83dulyGK1q2x7Gh7jsjwTtCZXJrbYdudJPXz/rrHUbi
 TcpSAI074JNNcVBpGJt8pGcguzxGYhMSJS5X/aJT7VV7iDk1I+E0MQAbwl4vUNg2z6USbI6sHt6
 6VfiT7pg67sNUjXs6jJa5CStfdmqv5JmmCJXS7j+QO0CQ1ptDLu+iYjeHwqS2QbkYMXN1OZGxcF
 XkBcoiPGNPK28dGenqQP6JkpNoiFp25NuzzXAoPacheo18/c0ASZqaqRUBnOQwvwVo0CSyu1yVH
 nRJdN65TSIQDL2A/b6v9r/lJpTe1eOn12ul5kEAJjfRHAEdWRwwiEIeoMIWZWZVURTo3f199tYG
 Z4AiMEJicnlRBOuctiX/36+WgmnYqNpfxISK23MkoGf2AHmgrFhCkSV38RYB/cyDdQS
X-Received: by 2002:a05:600c:524e:b0:492:7142:f46e with SMTP id
 5b1f17b1804b1-49573c8d44fmr92486635e9.2.1784908856945; 
 Fri, 24 Jul 2026 09:00:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5ed646sm57120715e9.0.2026.07.24.09.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:00:56 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:00:47 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: a41696a9d994655d92a30267be8d8b15e039f437
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <819cb113e4399351a8b2f16fba58ea1de57f8666-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIKh-0005aH-Kt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be an uint64_t
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
Content-Type: multipart/mixed; boundary="===============6904770844704983014=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6904770844704983014==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4FErcDMfKOE="; charset=UTF-8

--4FErcDMfKOE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail

to look at the new pa=
tch set (#14)=2E

The following approvals got outdated and were removed:
Co=
de-Review+2 by flichtenheld

The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now=2E


Change subject: Cha=
nge hash iv to a be an uint64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Change hash iv to a be an uint64_t

While for our own h=
ash function, always using an uint32_t works well, it does
not work very we=
ll if we move to another hash function like siphash that
requires a larger =
key=2E

To avoid allocating a specific context, increase the size of iv to =
64 bit
and give it a better name=2E

Change-Id: If47c7d920b2fa4047b7db03fcd=
e821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/o=
penvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M src/openv=
pn/mroute=2Eh
M src/openvpn/multi=2Ec
M tests/unit_tests/openvpn/test_misc=
=2Ec
6 files changed, 44 insertions(+), 23 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/14

diff --git a/=
src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index c07e764=2E=2E8e5d419 1006=
44
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -29,13 +29,15 @=
@
 
 #include "integer=2Eh"
 #include "list=2Eh"
+
+#include "crypto=2Eh"
 =
#include "misc=2Eh"
 
 #include "memdbg=2Eh"
 
 struct hash *
-hash_init(co=
nst uint32_t n_buckets, const uint32_t iv,
-          uint64_t (*hash_funct=
ion)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_buckets,
+ =
         uint64_t (*hash_function)(const void *key, uint64_t hash_key),
   =
        bool (*compare_function)(const void *key1, const void *key2))
 {
  =
   struct hash *h;
@@ -46,7 +48,10 @@
     h->mask =3D h->n_buckets - 1;
  =
   h->hash_function =3D hash_function;
     h->compare_function =3D compare=
_function;
-    h->iv =3D iv;
+
+    /* create random hash key */
+    prng=
_bytes((uint8_t *)&h->hash_key, sizeof(h->hash_key));
+
     ALLOC_ARRAY(h-=
>buckets, struct hash_bucket, h->n_buckets);
     for (uint32_t i =3D 0; i =
< h->n_buckets; ++i)
     {
@@ -412,6 +417,18 @@
         c ^=3D (b >> 15);=
 \
     }
 
+/**
+ * Creates a context that allows to use the hash function=
 (hash_func) and
+ * @return a new context for the use with hash_func
+ */
=
+void *
+hash_func_new_ctx(void)
+{
+    uint32_t *ctx =3D malloc(sizeof(ui=
nt32_t));
+    *ctx =3D (uint32_t)get_random();
+    return ctx;
+}
+
 uint=
64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
 {
dif=
f --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 06377c6=2E=2E63=
3f646 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -54,1=
4 +54,16 @@
     uint32_t n_buckets;
     uint32_t n_elements;
     uint32_=
t mask;
-    uint32_t iv;
-    uint64_t (*hash_function)(const void *key, u=
int32_t iv);
+    /** key used for the hash function=2E No to be confused w=
ith the (key, value)
+     * keys for the actual hash map entries */
+    u=
int64_t hash_key;
+    uint64_t (*hash_function)(const void *key, uint64_t =
hash_key);
     bool (*compare_function)(const void *key1, const void *key2=
); /* return true if equal */
     struct hash_bucket *buckets;
 };
 
-stru=
ct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-          =
             uint64_t (*hash_function)(const void *key, uint32_t iv),
+stru=
ct hash *hash_init(const uint32_t n_buckets,
+                       uint64=
_t (*hash_function)(const void *key, uint64_t hash_key),
                  =
      bool (*compare_function)(const void *key1, const void *key2));
 
 voi=
d hash_free(struct hash *hash);
@@ -103,7 +105,7 @@
 static inline uint64_t=

 hash_value(const struct hash *hash, const void *key)
 {
-    return (*has=
h->hash_function)(key, hash->iv);
+    return (*hash->hash_function)(key, h=
ash->hash_key);
 }
 
 static inline uint32_t
diff --git a/src/openvpn/mrout=
e=2Ec b/src/openvpn/mroute=2Ec
index 78c689e=2E=2Edd845bd 100644
--- a/src/=
openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -355,10 +355,10 @@
  * a=
nd the actual address=2E
  */
 uint64_t
-mroute_addr_hash_function(const vo=
id *key, uint32_t iv)
+mroute_addr_hash_function(const void *key, uint64_t =
hash_key)
 {
     return hash_func(mroute_addr_hash_ptr((const struct mrout=
e_addr *)key),
-                     mroute_addr_hash_len((const struct mro=
ute_addr *)key), iv);
+                     mroute_addr_hash_len((const str=
uct mroute_addr *)key), (int32_t)hash_key);
 }
 
 bool
diff --git a/src/ope=
nvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2f5d019=2E=2Efdfe6a2 100644
=
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +144,7 =
@@
 
 bool mroute_learnable_address(const struct mroute_addr *addr, struct =
gc_arena *gc);
 
-uint64_t mroute_addr_hash_function(const void *key, uint3=
2_t iv);
+uint64_t mroute_addr_hash_function(const void *key, uint64_t hash=
_key);
 
 bool mroute_addr_compare_function(const void *key1, const void *k=
ey2);
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index f8=
23f5b=2E=2E6ff72b3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mul=
ti=2Ec
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEMENT
 
 static uint64_t
-ci=
d_hash_function(const void *key, uint32_t iv)
+cid_hash_function(const void=
 *key, uint64_t hash_key)
 {
     const unsigned long *k =3D (const unsigne=
d long *)key;
     return (uint64_t)*k;
@@ -250,7 +250,7 @@
 /*
  * inotify=
 watcher descriptors are used as hash value
  */
-int_hash_function(const v=
oid *key, uint32_t iv)
+int_hash_function(const void *key, void *ctx)
 {
  =
   return (uintptr_t)key;
 }
@@ -290,27 +290,30 @@
      * to determine whi=
ch client sent an incoming packet
      * which is seen on the TCP/UDP sock=
et=2E
      */
-    m->hash =3D hash_init(t->options=2Ereal_hash_size, (uin=
t32_t)get_random(),
+    m->hash =3D hash_init(t->options=2Ereal_hash_size,=

                         mroute_addr_hash_function, mroute_addr_compare_fu=
nction);
 
     /*
      * Virtual address hash table=2E  Used to determine=

      * which client to route a packet to=2E
      */
-    m->vhash =3D ha=
sh_init(t->options=2Evirtual_hash_size, (uint32_t)get_random(),
+    m->vha=
sh =3D hash_init(t->options=2Evirtual_hash_size,
                          =
mroute_addr_hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_=
MANAGEMENT
-    m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, 0, c=
id_hash_function, cid_compare_function);
+    m->cid_hash =3D hash_init(t->=
options=2Ereal_hash_size, cid_hash_function, cid_compare_function);
 #endif=

 
 #ifdef ENABLE_ASYNC_PUSH
     /*
      * Mapping between inotify watch =
descriptors and
      * multi_instances=2E
+     *
+     * Note we use a cu=
stom hash function here so we use dummy
+     * value and function for the =
context parameters=2E
      */
-    m->inotify_watchers =3D hash_init(t->op=
tions=2Ereal_hash_size, (uint32_t)get_random(),
-                          =
          int_hash_function, int_compare_function);
+    m->inotify_watcher=
s =3D
+        hash_init(t->options=2Ereal_hash_size, NULL, free, int_hash_=
function, int_compare_function);
 #endif
 
     /*
diff --git a/tests/unit_=
tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index =
fc9840a=2E=2E199e36a 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
++=
+ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -128,11 +128,11 @@
 
 
 stati=
c uint64_t
-word_hash_function(const void *key, uint32_t iv)
+word_hash_fun=
ction(const void *key, uint64_t hash_key)
 {
     const char *str =3D (cons=
t char *)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-    retur=
n hash_func((const uint8_t *)str, len, iv);
+    return hash_func((const ui=
nt8_t *)str, len, (int32_t)hash_key);
 }
 
 static bool
@@ -174,10 +174,9 @=
@
      * Test the hash code by implementing a simple
      * word frequenc=
y algorithm=2E
      */
-
     struct gc_arena gc =3D gc_new();
-    struct=
 hash *hash =3D hash_init(10000, get_random(), word_hash_function, word_com=
pare_function);
-    struct hash *nhash =3D hash_init(256, get_random(), wo=
rd_hash_function, word_compare_function);
+    struct hash *hash =3D hash_i=
nit(10000, word_hash_function, word_compare_function);
+    struct hash *nh=
ash =3D hash_init(256, word_hash_function, word_compare_function);
 
     p=
rintf("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, hash->ma=
sk);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920=
b2fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet:=
 14
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--4FErcDMfKOE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #14</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld</p><p>The change is no longer submittable: Code-Review and checks~=
ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">Change hash iv to =
a be an uint64_t<br><br>While for our own hash function, always using an ui=
nt32_t works well, it does<br>not work very well if we move to another hash=
 function like siphash that<br>requires a larger key=2E<br><br>To avoid all=
ocating a specific context, increase the size of iv to 64 bit<br>and give i=
t a better name=2E<br><br>Change-Id: If47c7d920b2fa4047b7db03fcde8218998393=
24d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M s=
rc/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<b=
r>M src/openvpn/mroute=2Eh<br>M src/openvpn/multi=2Ec<br>M tests/unit_tests=
/openvpn/test_misc=2Ec<br>6 files changed, 44 insertions(+), 23 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/71/1571/14</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/s=
rc/openvpn/list=2Ec</span><br><span>index c07e764=2E=2E8e5d419 100644</span=
><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/lis=
t=2Ec</span><br><span>@@ -29,13 +29,15 @@</span><br><span> </span><br><span=
> #include &quot;integer=2Eh&quot;</span><br><span> #include &quot;list=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;<=
/span><br><span> #include &quot;misc=2Eh&quot;</span><br><span> </span><br>=
<span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span> s=
truct hash *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_init=
(const uint32_t n_buckets, const uint32_t iv,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-          uint64_t (*hash_function)(const void *key=
, uint32_t iv),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash=
_init(const uint32_t n_buckets,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+          uint64_t (*hash_function)(const void *key, uint64_t h=
ash_key),</span><br><span>           bool (*compare_function)(const void *k=
ey1, const void *key2))</span><br><span> {</span><br><span>     struct hash=
 *h;</span><br><span>@@ -46,7 +48,10 @@</span><br><span>     h-&gt;mask =3D=
 h-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_function =3D hash_fun=
ction;</span><br><span>     h-&gt;compare_function =3D compare_function;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv =3D iv;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* create random hash key */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    prng_bytes((uint8_t *)&a=
mp;h-&gt;hash_key, sizeof(h-&gt;hash_key));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     ALLOC_ARRAY(h-&gt;buckets, st=
ruct hash_bucket, h-&gt;n_buckets);</span><br><span>     for (uint32_t i =
=3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><span>     {</span><br><span>=
@@ -412,6 +417,18 @@</span><br><span>         c ^=3D (b &gt;&gt; 15); \</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Creates a context that allows to use the hash function (hash_func) and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return a new co=
ntext for the use with hash_func</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_func_new_ct=
x(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t *ctx =3D malloc(s=
izeof(uint32_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  *ctx =3D (uint32_t)get_random();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return ctx;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> uint64_t</span><br><span> hash_func(const uint8_t *k, uint32_t l=
ength, uint32_t initval)</span><br><span> {</span><br><span>diff --git a/sr=
c/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 06377c6=2E=
=2E633f646 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><spa=
n>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -54,14 +54,16 @@</span><br>=
<span>     uint32_t n_buckets;</span><br><span>     uint32_t n_elements;</s=
pan><br><span>     uint32_t mask;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    uint32_t iv;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    uint64_t (*hash_function)(const void *key, uint32_t iv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /** key used for the ha=
sh function=2E No to be confused with the (key, value)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * keys for the actual hash map entr=
ies */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t =
hash_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64=
_t (*hash_function)(const void *key, uint64_t hash_key);</span><br><span>  =
   bool (*compare_function)(const void *key1, const void *key2); /* return =
true if equal */</span><br><span>     struct hash_bucket *buckets;</span><b=
r><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
  uint64_t (*hash_function)(const void *key, uint32_t iv),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+struct hash *hash_init(const uint32_=
t n_buckets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                uint64_t (*hash_function)(const void *key, uint64_t hash_ke=
y),</span><br><span>                        bool (*compare_function)(const =
void *key1, const void *key2));</span><br><span> </span><br><span> void has=
h_free(struct hash *hash);</span><br><span>@@ -103,7 +105,7 @@</span><br><s=
pan> static inline uint64_t</span><br><span> hash_value(const struct hash *=
hash, const void *key)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return (*hash-&gt;hash_function)(key, hash-&gt;iv);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (*hash-&=
gt;hash_function)(key, hash-&gt;hash_key);</span><br><span> }</span><br><sp=
an> </span><br><span> static inline uint32_t</span><br><span>diff --git a/s=
rc/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 78c689=
e=2E=2Edd845bd 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><b=
r><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -355,10 +355,10 @@<=
/span><br><span>  * and the actual address=2E</span><br><span>  */</span><b=
r><span> uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mrou=
te_addr_hash_function(const void *key, uint32_t iv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+mroute_addr_hash_function(const void *key=
, uint64_t hash_key)</span><br><span> {</span><br><span>     return hash_fu=
nc(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     mroute_addr_hash_l=
en((const struct mroute_addr *)key), iv);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     mroute_addr_hash_len((const stru=
ct mroute_addr *)key), (int32_t)hash_key);</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span>diff --git a/src/openvpn/mroute=
=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index 2f5d019=2E=2Efdfe6a2 10=
0644</span><br><span>--- a/src/openvpn/mroute=2Eh</span><br><span>+++ b/src=
/openvpn/mroute=2Eh</span><br><span>@@ -144,7 +144,7 @@</span><br><span> </=
span><br><span> bool mroute_learnable_address(const struct mroute_addr *add=
r, struct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-uint64_t mroute_addr_hash_function(const void *key, ui=
nt32_t iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t=
 mroute_addr_hash_function(const void *key, uint64_t hash_key);</span><br><=
span> </span><br><span> bool mroute_addr_compare_function(const void *key1,=
 const void *key2);</span><br><span> </span><br><span>diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index f823f5b=2E=2E6f=
f72b3 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>++=
+ b/src/openvpn/multi=2Ec</span><br><span>@@ -229,7 +229,7 @@</span><br><sp=
an> #ifdef ENABLE_MANAGEMENT</span><br><span> </span><br><span> static uint=
64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cid_hash_function=
(const void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+cid_hash_function(const void *key, uint64_t hash_key)</span><br>=
<span> {</span><br><span>     const unsigned long *k =3D (const unsigned lo=
ng *)key;</span><br><span>     return (uint64_t)*k;</span><br><span>@@ -250=
,7 +250,7 @@</span><br><span> /*</span><br><span>  * inotify watcher descri=
ptors are used as hash value</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int_hash_function(const void *key, uint32_t iv)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int_hash_function(c=
onst void *key, void *ctx)</span><br><span> {</span><br><span>     return (=
uintptr_t)key;</span><br><span> }</span><br><span>@@ -290,27 +290,30 @@</sp=
an><br><span>      * to determine which client sent an incoming packet</spa=
n><br><span>      * which is seen on the TCP/UDP socket=2E</span><br><span>=
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;has=
h =3D hash_init(t-&gt;options=2Ereal_hash_size, (uint32_t)get_random(),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hash =3D hash=
_init(t-&gt;options=2Ereal_hash_size,</span><br><span>                     =
    mroute_addr_hash_function, mroute_addr_compare_function);</span><br><sp=
an> </span><br><span>     /*</span><br><span>      * Virtual address hash t=
able=2E  Used to determine</span><br><span>      * which client to route a =
packet to=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_=
size, (uint32_t)get_random(),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size,<=
/span><br><span>                          mroute_addr_hash_function, mroute=
_addr_compare_function);</span><br><span> </span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;ci=
d_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, 0, cid_hash_function, =
cid_compare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, cid_has=
h_function, cid_compare_function);</span><br><span> #endif</span><br><span>=
 </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>     /*</span><=
br><span>      * Mapping between inotify watch descriptors and</span><br><s=
pan>      * multi_instances=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * Note we use a custom hash function here so we use dummy</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * value and function for the =
context parameters=2E</span><br><span>      */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    m-&gt;inotify_watchers =3D hash_init(t-&gt;opt=
ions=2Ereal_hash_size, (uint32_t)get_random(),</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                    int_hash_funct=
ion, int_compare_function);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    m-&gt;inotify_watchers =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        hash_init(t-&gt;options=2Ereal_hash_size, NULL, =
free, int_hash_function, int_compare_function);</span><br><span> #endif</sp=
an><br><span> </span><br><span>     /*</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</s=
pan><br><span>index fc9840a=2E=2E199e36a 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_misc=2Ec</span><br><span>@@ -128,11 +128,11 @@</span><br><span> =
</span><br><span> </span><br><span> static uint64_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-word_hash_function(const void *key, uint32_=
t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+word_hash_func=
tion(const void *key, uint64_t hash_key)</span><br><span> {</span><br><span=
>     const char *str =3D (const char *)key;</span><br><span>     const uin=
t32_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return hash_func((const uint8_t *)str, len, iv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return hash_func((const=
 uint8_t *)str, len, (int32_t)hash_key);</span><br><span> }</span><br><span=
> </span><br><span> static bool</span><br><span>@@ -174,10 +174,9 @@</span>=
<br><span>      * Test the hash code by implementing a simple</span><br><sp=
an>      * word frequency algorithm=2E</span><br><span>      */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct hash *hash =3D hash_init(10000, get_random(), word_hash_function=
, word_compare_function);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct hash *nhash =3D hash_init(256, get_random(), word_hash_funct=
ion, word_compare_function);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct hash *hash =3D hash_init(10000, word_hash_function, wor=
d_compare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct hash *nhash =3D hash_init(256, word_hash_function, word_compare=
_function);</span><br><span> </span><br><span>     printf(&quot;hash_init n=
_buckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</s=
pan><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
f47c7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1571 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body>=
</html>
--4FErcDMfKOE=--


--===============6904770844704983014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6904770844704983014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6904770844704983014==--

