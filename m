Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB5C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ca77NEgs6lHCg46xJtokk3kuDYNl+P3It+jdoNlASUg=; b=Re882yIx3vqviJ/KTQKWe9IZ10
	LGAn9OnZdfjOCAZ6yxP58cns8JwlA4tyaoQeEpX4ySeQc+P0Q1DU661gT7J3n3LMrJxKwiUa+fCss
	fMyZzzlR0ArXXIu3nFjReDWOcWIiyyp4RYfFdkcW2vS3E1EhVCceWQHjODCmmVffAPe4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrw2A-0000Qi-Fe;
	Thu, 06 Aug 2026 11:13:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrw29-0000Qa-MN
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KZ7oBECiHFlb//eUGhPKVTiM5iXQocicMJl0QAOu9eE=; b=ZYXB7YWfz4+s//I8tLRPoHi+Eb
 i6yUg0ZxuBzHI/Ytyiy2iUYQCQX4v3/XcsisC/gSQR3XQ+TWQ05/G1fH7atq0XbbBCU21XXe3vz9a
 KbqxzeDGHV6oyaDi6leNbWPVpMIAxVP4siHPDvKMnzBHCCQhHPU/pnpDqJY6Kj3nTIBs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KZ7oBECiHFlb//eUGhPKVTiM5iXQocicMJl0QAOu9eE=; b=M
 utPMpbwMq8j5TubdkKLJc+82moDfV6naIq42SxkuPYbPMurg8iieMiiT0cir2zDQuNK6H9Eb6FSyE
 u/bvSrnnDl3GHqJrmzLcsaWlT0JChznNgIkKQAXFVD1L2/j4UnAPQfFYlcj8nguIr6enTLpGRSn6I
 wYRxf1avFGIEhhxA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrw24-0005dW-5X for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:07 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4956242332dso16337565e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786014777; x=1786619577; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KZ7oBECiHFlb//eUGhPKVTiM5iXQocicMJl0QAOu9eE=;
 b=L0euJ4+20FFpwKp7ZpvneiREiTkSsvzFPR//V627BLvpkfuR1i0TXLu+B3vWx21NJE
 I8kYxPpMQ/KJy3Keg8/R+Dw6woP5f6p1VT7/iJ7PIGQP4L7sFMibzxqEHkr0aO+Je5l8
 HsnJOBwMAqDG8KFx7t4dosSG8gKL5BAL70LtQI9MhVP7lVTEkceatXPgujkfxxIlX2FF
 0GCx8rpmu7Y3rqm1i1Yan51wI5X1twmBjyAClgc6WQfhezPd7dFffHCxN6UYw+Ht9dRz
 /fvPIehBDRD+jMyMn43D+eiPrgRaIBXWr8KMAEOQ62b/d3j8LJSa4PjNVj0v8NlEn2Q7
 CSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786014777; x=1786619577;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KZ7oBECiHFlb//eUGhPKVTiM5iXQocicMJl0QAOu9eE=;
 b=W8mLlvsSkQMliMnEv/oecHTe8FEIqsSMFpZ7yj1g02+6dd7g6Lj1Q62/tovMbEAOeK
 eQvmOh2AgtM1evx9qcQNhgfYm0xxE5tnVVR3oY8YO3g2B3aURGKLe73zd7EVQ3fNpbG9
 gZQELMAGp4Y4xeUtWjfJFJ70PGk8Gn+LIQmTu7osjCEPPLfumy2p2Zl8GIJ+6kRR+5Xk
 tySIA2d0NhX39P2WqFmw5hHClNhVYuQusSLh6+Rb5KI1lXbyeyJy23ZXFZowUcAqePZn
 Mg3+LbGGl4yJwYq3qQ+LpOA1kf5POyzZvv6bXkqrhhfW7zLhf0l59UHtl8KrezcFAo18
 S96Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUfK954qk5Qc4GRNMongpF8ZeSMdaIKCb7fWp6xpKucAPCJGbOTDubnNoyTwQpln2R7BRYhvDLeul6DQOT@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyx7M+quZNSrDhj+3rzcnvR1kfEjkcR7nXdkprfDhpiEsDgPk5j
 DmYai7lwrAIDDbRShkPv0cwU3dSzrQIy8V6lnJUKbqYMWthxFdoA0gYWrFJZMVzyw4VOsGQILMA
 gv0F+tMpY2CZDbHRafRLj2u2qOkItNy5u4ffVkWAdM/D3RdJCV0JXLxM/WjgxwNK4IuK0
X-Gm-Gg: AR+sD13ggbAphzVDHF6SRHu8IXTRq84UZgEDgCF3yWczFQeyi4b5H/aHJRRby6Y2chL
 U70eD7Pj1cVXWAcSSSc5GwBX2ltW6u6EtvVO2Y40J0q0Ht3Zb9AAdWoQmrgE4QnSrf3yd+r+bpz
 3ndFvwKgdXjioBzCSaDsGpGZ8EgQdinYTdc+jmyStLG4Anu7aV5orKd1s1Wlr+0BP+v5aV8LEzZ
 i3f10KtX72M4llADH41gPbzSkxJOCcUxqS8a9kipWnGi7VqwtvHIo9jt2+zf67U6jOZ9CsYWBAU
 wXU5H+wVzMAFG6bDlkwuMZSrpdn7BWapKKqwg8hl6ESqBk6QwdigHfDmA4MISQH+V1nyojnIrCH
 a9f7EUGB7KBN6Mtj/t9IdfXav+Ny9aR1NAkcM0VQmHRZcISAkaXeeStct60FGNuawZWw2brIsqh
 TSS5Mj6AfoboXk8zijRLsfpfOCgEj/5XoQj60zJoXE8bdx0tTu8/E99IXUAMdlWdkiZhKKFualT
 FbIbRb+PKOSm4W5B3/S5utxx34PThDKngWitsMwtnjO1ND0mbkvzgVLNOgC/FkEVzXWOC7tXPAT
 dI/zyvaJezEL0Br0tNVPDKi4fJB8FS/n86f1p6Jz5U3h36BTR7r0
X-Received: by 2002:a05:600c:354c:b0:499:51cc:4e57 with SMTP id
 5b1f17b1804b1-49951cc6d0fmr120367045e9.0.1786014777393; 
 Thu, 06 Aug 2026 04:12:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b18086sm5855075f8f.22.2026.08.06.04.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:12:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:12:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: d1106970f76e955b0a5fa19b566e97bba98d4c9b
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6d052a113e4819574930c9161e601a7a1534c92-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrw24-0005dW-5X
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be a fixed sized array
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
Content-Type: multipart/mixed; boundary="===============0740966378002577770=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0740966378002577770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8USNxySKLno="; charset=UTF-8

--8USNxySKLno=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1571?usp=3Demail )

Change subject: Change hash iv to a be a fixed size=
d array
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Chan=
ge hash iv to a be a fixed sized array

While for our own hash function, al=
ways using an uint32_t works well, it does
not work very well if we move to=
 another hash function like siphash that
requires a larger key=2E

To avoid=
 allocating a specific context, change the API to be a fixed size
array of =
size 4=2E This define allows use to easily change it to a larger
value if w=
e use hash functions that require larger keys=2E

Change-Id: If47c7d920b2fa=
4047b7db03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg=
>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571
Message-Id: <20260806102926=2E2820=
6-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg38162=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/list=2Ec
M src/openvpn/list=2E=
h
M src/openvpn/mroute=2Ec
M src/openvpn/mroute=2Eh
M src/openvpn/multi=2Ec=

M tests/unit_tests/openvpn/test_misc=2Ec
6 files changed, 32 insertions(+)=
, 23 deletions(-)




diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=
=2Ec
index c07e764=2E=2Ee52c778 100644
--- a/src/openvpn/list=2Ec
+++ b/src=
/openvpn/list=2Ec
@@ -29,13 +29,15 @@
 
 #include "integer=2Eh"
 #include "=
list=2Eh"
+
+#include "crypto=2Eh"
 #include "misc=2Eh"
 
 #include "memdbg=
=2Eh"
 
 struct hash *
-hash_init(const uint32_t n_buckets, const uint32_t =
iv,
-          uint64_t (*hash_function)(const void *key, uint32_t iv),
+ha=
sh_init(const uint32_t n_buckets,
+          uint64_t (*hash_function)(cons=
t void *key, const uint8_t hash_key[HASH_KEY_LEN]),
           bool (*compa=
re_function)(const void *key1, const void *key2))
 {
     struct hash *h;
@=
@ -46,7 +48,10 @@
     h->mask =3D h->n_buckets - 1;
     h->hash_function =
=3D hash_function;
     h->compare_function =3D compare_function;
-    h->i=
v =3D iv;
+
+    /* create random hash key */
+    prng_bytes(h->hash_key, =
sizeof(h->hash_key));
+
     ALLOC_ARRAY(h->buckets, struct hash_bucket, h-=
>n_buckets);
     for (uint32_t i =3D 0; i < h->n_buckets; ++i)
     {
diff=
 --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 06377c6=2E=2Ecbf=
1abf 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -49,19=
 +49,24 @@
     struct hash_element *list;
 };
 
+
+#define HASH_KEY_LEN 4
=
+
 struct hash
 {
     uint32_t n_buckets;
     uint32_t n_elements;
     u=
int32_t mask;
-    uint32_t iv;
-    uint64_t (*hash_function)(const void *=
key, uint32_t iv);
+    /** key/iv used for the hash function=2E No to be c=
onfused with the (key, value)
+     * keys for the actual hash map entries =
*/
+    uint8_t hash_key[HASH_KEY_LEN];
+    uint64_t (*hash_function)(cons=
t void *key, const uint8_t hash_key[HASH_KEY_LEN]);
     bool (*compare_fun=
ction)(const void *key1, const void *key2); /* return true if equal */
    =
 struct hash_bucket *buckets;
 };
 
-struct hash *hash_init(const uint32_t =
n_buckets, const uint32_t iv,
-                       uint64_t (*hash_funct=
ion)(const void *key, uint32_t iv),
+struct hash *hash_init(const uint32_t =
n_buckets,
+                       uint64_t (*hash_function)(const void *ke=
y, const uint8_t hash_key[HASH_KEY_LEN]),
                        bool (*co=
mpare_function)(const void *key1, const void *key2));
 
 void hash_free(str=
uct hash *hash);
@@ -103,7 +108,7 @@
 static inline uint64_t
 hash_value(co=
nst struct hash *hash, const void *key)
 {
-    return (*hash->hash_functio=
n)(key, hash->iv);
+    return (*hash->hash_function)(key, hash->hash_key);=

 }
 
 static inline uint32_t
diff --git a/src/openvpn/mroute=2Ec b/src/ope=
nvpn/mroute=2Ec
index 78c689e=2E=2Ea5179d0 100644
--- a/src/openvpn/mroute=
=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -355,10 +355,10 @@
  * and the actual =
address=2E
  */
 uint64_t
-mroute_addr_hash_function(const void *key, uint3=
2_t iv)
+mroute_addr_hash_function(const void *key, const uint8_t hash_key[=
HASH_KEY_LEN])
 {
     return hash_func(mroute_addr_hash_ptr((const struct =
mroute_addr *)key),
-                     mroute_addr_hash_len((const struc=
t mroute_addr *)key), iv);
+                     mroute_addr_hash_len((cons=
t struct mroute_addr *)key), *(uint32_t *)hash_key);
 }
 
 bool
diff --git =
a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh
index 2f5d019=2E=2E639281=
b 100644
--- a/src/openvpn/mroute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,=
7 +144,7 @@
 
 bool mroute_learnable_address(const struct mroute_addr *addr=
, struct gc_arena *gc);
 
-uint64_t mroute_addr_hash_function(const void *k=
ey, uint32_t iv);
+uint64_t mroute_addr_hash_function(const void *key, cons=
t uint8_t hash_key[HASH_KEY_LEN]);
 
 bool mroute_addr_compare_function(con=
st void *key1, const void *key2);
 
diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec
index fe2badb=2E=2Ea4e9c1c 100644
--- a/src/openvpn/mul=
ti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAG=
EMENT
 
 static uint64_t
-cid_hash_function(const void *key, uint32_t iv)
+=
cid_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {=

     const unsigned long *k =3D (const unsigned long *)key;
     return (u=
int64_t)*k;
@@ -250,7 +250,7 @@
 /*
  * inotify watcher descriptors are use=
d as hash value
  */
-int_hash_function(const void *key, uint32_t iv)
+int_=
hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
   =
  return (uintptr_t)key;
 }
@@ -290,18 +290,18 @@
      * to determine whic=
h client sent an incoming packet
      * which is seen on the TCP/UDP socke=
t=2E
      */
-    m->hash =3D hash_init(t->options=2Ereal_hash_size, (uint=
32_t)get_random(),
+    m->hash =3D hash_init(t->options=2Ereal_hash_size,
=
                         mroute_addr_hash_function, mroute_addr_compare_fun=
ction);
 
     /*
      * Virtual address hash table=2E  Used to determine
=
      * which client to route a packet to=2E
      */
-    m->vhash =3D has=
h_init(t->options=2Evirtual_hash_size, (uint32_t)get_random(),
+    m->vhas=
h =3D hash_init(t->options=2Evirtual_hash_size,
                          m=
route_addr_hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_M=
ANAGEMENT
-    m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, 0, ci=
d_hash_function, cid_compare_function);
+    m->cid_hash =3D hash_init(t->o=
ptions=2Ereal_hash_size, cid_hash_function, cid_compare_function);
 #endif
=
 
 #ifdef ENABLE_ASYNC_PUSH
@@ -309,8 +309,8 @@
      * Mapping between ino=
tify watch descriptors and
      * multi_instances=2E
      */
-    m->inot=
ify_watchers =3D hash_init(t->options=2Ereal_hash_size, (uint32_t)get_rando=
m(),
-                                    int_hash_function, int_compare_fu=
nction);
+    m->inotify_watchers =3D
+        hash_init(t->options=2Ereal_=
hash_size, int_hash_function, int_compare_function);
 #endif
 
     /*
diff=
 --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/=
test_misc=2Ec
index 4d046ce=2E=2E3ebbfc1 100644
--- a/tests/unit_tests/open=
vpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -131,11 +=
131,11 @@
 
 
 static uint64_t
-word_hash_function(const void *key, uint32_=
t iv)
+word_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_=
LEN])
 {
     const char *str =3D (const char *)key;
     const uint32_t le=
n =3D (uint32_t)strlen(str);
-    return hash_func((const uint8_t *)str, le=
n, iv);
+    return hash_func((const uint8_t *)str, len, *(uint32_t *)(hash=
_key));
 }
 
 static bool
@@ -170,10 +170,9 @@
      * Test the hash code b=
y implementing a simple
      * word frequency algorithm=2E
      */
-
    =
 struct gc_arena gc =3D gc_new();
-    struct hash *hash =3D hash_init(1000=
0, get_random(), word_hash_function, word_compare_function);
-    struct ha=
sh *nhash =3D hash_init(256, get_random(), word_hash_function, word_compare=
_function);
+    struct hash *hash =3D hash_init(10000, word_hash_function,=
 word_compare_function);
+    struct hash *nhash =3D hash_init(256, word_ha=
sh_function, word_compare_function);
 
     printf("hash_init n_buckets=3D%=
u mask=3D0x%08x\n", hash->n_buckets, hash->mask);
 

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Ger=
rit-Change-Number: 1571
Gerrit-PatchSet: 22
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8USNxySKLno=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1571?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Change hash iv to a be a fixed sized array=
<br><br>While for our own hash function, always using an uint32_t works wel=
l, it does<br>not work very well if we move to another hash function like s=
iphash that<br>requires a larger key=2E<br><br>To avoid allocating a specif=
ic context, change the API to be a fixed size<br>array of size 4=2E This de=
fine allows use to easily change it to a larger<br>value if we use hash fun=
ctions that require larger keys=2E<br><br>Change-Id: If47c7d920b2fa4047b7db=
03fcde821899839324d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571<br>Message-Id: &lt;20=
260806102926=2E28206-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Ema=
il-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38162=2Ehtml<br=
>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M sr=
c/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br=
>M src/openvpn/mroute=2Eh<br>M src/openvpn/multi=2Ec<br>M tests/unit_tests/=
openvpn/test_misc=2Ec<br>6 files changed, 32 insertions(+), 23 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec<=
/span><br><span>index c07e764=2E=2Ee52c778 100644</span><br><span>--- a/src=
/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><spa=
n>@@ -29,13 +29,15 @@</span><br><span> </span><br><span> #include &quot;int=
eger=2Eh&quot;</span><br><span> #include &quot;list=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span> #in=
clude &quot;misc=2Eh&quot;</span><br><span> </span><br><span> #include &quo=
t;memdbg=2Eh&quot;</span><br><span> </span><br><span> struct hash *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-hash_init(const uint32_t n_bu=
ckets, const uint32_t iv,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          uint64_t (*hash_function)(const void *key, uint32_t iv),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_init(const uint32_t=
 n_buckets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
  uint64_t (*hash_function)(const void *key, const uint8_t hash_key[HASH_KE=
Y_LEN]),</span><br><span>           bool (*compare_function)(const void *ke=
y1, const void *key2))</span><br><span> {</span><br><span>     struct hash =
*h;</span><br><span>@@ -46,7 +48,10 @@</span><br><span>     h-&gt;mask =3D =
h-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_function =3D hash_func=
tion;</span><br><span>     h-&gt;compare_function =3D compare_function;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    h-&gt;iv =3D iv;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* create random hash key */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    prng_bytes(h-&gt;hash_ke=
y, sizeof(h-&gt;hash_key));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     ALLOC_ARRAY(h-&gt;buckets, struct hash_bucket=
, h-&gt;n_buckets);</span><br><span>     for (uint32_t i =3D 0; i &lt; h-&g=
t;n_buckets; ++i)</span><br><span>     {</span><br><span>diff --git a/src/o=
penvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 06377c6=2E=2Ec=
bf1abf 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>++=
+ b/src/openvpn/list=2Eh</span><br><span>@@ -49,19 +49,24 @@</span><br><spa=
n>     struct hash_element *list;</span><br><span> };</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define HASH_KEY_LEN 4</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct hash</span><b=
r><span> {</span><br><span>     uint32_t n_buckets;</span><br><span>     ui=
nt32_t n_elements;</span><br><span>     uint32_t mask;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    uint32_t iv;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    uint64_t (*hash_function)(const void *key, =
uint32_t iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
* key/iv used for the hash function=2E No to be confused with the (key, val=
ue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * keys for =
the actual hash map entries */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint8_t hash_key[HASH_KEY_LEN];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)(const void *key, c=
onst uint8_t hash_key[HASH_KEY_LEN]);</span><br><span>     bool (*compare_f=
unction)(const void *key1, const void *key2); /* return true if equal */</s=
pan><br><span>     struct hash_bucket *buckets;</span><br><span> };</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct hash=
 *hash_init(const uint32_t n_buckets, const uint32_t iv,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                       uint64_t (*hash_f=
unction)(const void *key, uint32_t iv),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+struct hash *hash_init(const uint32_t n_buckets,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                       uin=
t64_t (*hash_function)(const void *key, const uint8_t hash_key[HASH_KEY_LEN=
]),</span><br><span>                        bool (*compare_function)(const =
void *key1, const void *key2));</span><br><span> </span><br><span> void has=
h_free(struct hash *hash);</span><br><span>@@ -103,7 +108,7 @@</span><br><s=
pan> static inline uint64_t</span><br><span> hash_value(const struct hash *=
hash, const void *key)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return (*hash-&gt;hash_function)(key, hash-&gt;iv);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (*hash-&=
gt;hash_function)(key, hash-&gt;hash_key);</span><br><span> }</span><br><sp=
an> </span><br><span> static inline uint32_t</span><br><span>diff --git a/s=
rc/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 78c689=
e=2E=2Ea5179d0 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><b=
r><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -355,10 +355,10 @@<=
/span><br><span>  * and the actual address=2E</span><br><span>  */</span><b=
r><span> uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mrou=
te_addr_hash_function(const void *key, uint32_t iv)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+mroute_addr_hash_function(const void *key=
, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><br><span>=
     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key)=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
 mroute_addr_hash_len((const struct mroute_addr *)key), iv);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     mroute_addr_h=
ash_len((const struct mroute_addr *)key), *(uint32_t *)hash_key);</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span>diff --gi=
t a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><br><span>index 2=
f5d019=2E=2E639281b 100644</span><br><span>--- a/src/openvpn/mroute=2Eh</sp=
an><br><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@ -144,7 +144,7 =
@@</span><br><span> </span><br><span> bool mroute_learnable_address(const s=
truct mroute_addr *addr, struct gc_arena *gc);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-uint64_t mroute_addr_hash_functi=
on(const void *key, uint32_t iv);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+uint64_t mroute_addr_hash_function(const void *key, const uin=
t8_t hash_key[HASH_KEY_LEN]);</span><br><span> </span><br><span> bool mrout=
e_addr_compare_function(const void *key1, const void *key2);</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index fe2badb=2E=2Ea4e9c1c 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -229,7 +229,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</spa=
n><br><span> </span><br><span> static uint64_t</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-cid_hash_function(const void *key, uint32_t iv)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+cid_hash_function(cons=
t void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span=
><br><span>     const unsigned long *k =3D (const unsigned long *)key;</spa=
n><br><span>     return (uint64_t)*k;</span><br><span>@@ -250,7 +250,7 @@</=
span><br><span> /*</span><br><span>  * inotify watcher descriptors are used=
 as hash value</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int_hash_function(const void *key, uint32_t iv)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+int_hash_function(const void *key=
, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><br><span>=
     return (uintptr_t)key;</span><br><span> }</span><br><span>@@ -290,18 +=
290,18 @@</span><br><span>      * to determine which client sent an incomin=
g packet</span><br><span>      * which is seen on the TCP/UDP socket=2E</sp=
an><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size, (uint32_t)get_=
random(),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;=
hash =3D hash_init(t-&gt;options=2Ereal_hash_size,</span><br><span>        =
                 mroute_addr_hash_function, mroute_addr_compare_function);<=
/span><br><span> </span><br><span>     /*</span><br><span>      * Virtual a=
ddress hash table=2E  Used to determine</span><br><span>      * which clien=
t to route a packet to=2E</span><br><span>      */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&gt;options=2E=
virtual_hash_size, (uint32_t)get_random(),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtua=
l_hash_size,</span><br><span>                          mroute_addr_hash_fun=
ction, mroute_addr_compare_function);</span><br><span> </span><br><span> #i=
fdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, 0, cid_ha=
sh_function, cid_compare_function);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_=
size, cid_hash_function, cid_compare_function);</span><br><span> #endif</sp=
an><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>@@=
 -309,8 +309,8 @@</span><br><span>      * Mapping between inotify watch des=
criptors and</span><br><span>      * multi_instances=2E</span><br><span>   =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;inotif=
y_watchers =3D hash_init(t-&gt;options=2Ereal_hash_size, (uint32_t)get_rand=
om(),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                    int_hash_function, int_compare_function);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;inotify_watchers =3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_init(t-&g=
t;options=2Ereal_hash_size, int_hash_function, int_compare_function);</span=
><br><span> #endif</span><br><span> </span><br><span>     /*</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec</span><br><span>index 4d046ce=2E=2E3ebbfc1 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -131,11 +131,1=
1 @@</span><br><span> </span><br><span> </span><br><span> static uint64_t</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-word_hash_function(cons=
t void *key, uint32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+word_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_L=
EN])</span><br><span> {</span><br><span>     const char *str =3D (const cha=
r *)key;</span><br><span>     const uint32_t len =3D (uint32_t)strlen(str);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hash_func(=
(const uint8_t *)str, len, iv);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return hash_func((const uint8_t *)str, len, *(uint32_t *)(h=
ash_key));</span><br><span> }</span><br><span> </span><br><span> static boo=
l</span><br><span>@@ -170,10 +170,9 @@</span><br><span>      * Test the has=
h code by implementing a simple</span><br><span>      * word frequency algo=
rithm=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D hash=
_init(10000, get_random(), word_hash_function, word_compare_function);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *nhash =3D=
 hash_init(256, get_random(), word_hash_function, word_compare_function);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash=
 =3D hash_init(10000, word_hash_function, word_compare_function);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash =3D ha=
sh_init(256, word_hash_function, word_compare_function);</span><br><span> <=
/span><br><span>     printf(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\n&=
quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><span> </span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde82189983=
9324d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1571 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--8USNxySKLno=--


--===============0740966378002577770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0740966378002577770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0740966378002577770==--

