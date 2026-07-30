Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B211C55166
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/TywSjt1dXfNeGlweCKvilJ/AqI108vZb3Vme4oJBco=; b=PvzB0Vq4Q12Jhe+tAaS9rtR/Wf
	S6l83d6RjTXs8CG74McwhChYcMWOpDbrhkIOCY+bFYnhFaBDWqpf22MNZIJbxQ9qiv67RxCEVghrX
	YaAvBtDM/ZeT9DloC0PT3MIo8+W9+3ptm8yvGHSw4+JW9mnY2CUx8n3e7GSF3Vbpyjyk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpTEP-00039l-Ee;
	Thu, 30 Jul 2026 16:03:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpTEN-00038Z-FS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 16:03:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MsdlOHHmbRKGk5S0dzylTdb8VJgZsBqFZSsWjUBAO4g=; b=NjEd4TjsP58VB4Kin0FpinwyLu
 /wFZUbs9fY4+rKyrouBQmJ5xyEIVmxemcGVLETOVq6cO0Zaq/8NFRkYOKLZi7SWnHwCUzYRueBa5W
 utVct5UnTsHuCxppoMWHyuXRBPfz2dw5t72+2aROCp0sYi//XfQ6Aqc6SrFi0sQDno6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MsdlOHHmbRKGk5S0dzylTdb8VJgZsBqFZSsWjUBAO4g=; b=g
 jRdjlZAE8vW1/vo//hOYPq70r3cZw9wa5rGyb9De/BKq+H282PP0sED9gFC22sN5eJCrCV9tShdX3
 HSYA5zRXceM/jEUJKEC/o908AG3UoyulBsJQw/dusOSE0NUM5PhnitHHhHhYG2eo/EkCcf5UvrhwR
 E2b91RP6lJFYpAM0=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpTED-0007UC-FD for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 16:03:27 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-495590dde14so22598175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785427399; x=1786032199; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MsdlOHHmbRKGk5S0dzylTdb8VJgZsBqFZSsWjUBAO4g=;
 b=RY+N4M9Ir8tGOD/BLZ7UsCPxzg72K1pqs5zglQJYeAT72yXIoAMvlpzLP+lB/n6GhQ
 ny2Efqn7W3blHhDYgYGEqmgUtqPWAfDELlGUOYsnal3XrLdgBgob/OyuKjxWmf/9VM9m
 mtKu3uibOTlV9/zYDoaIni82s44m7iI6b5EVU4vocpK8cTbTacWRhuM3AdyHveVj4NE1
 KzTs0aGsGxKiP2RblKxWL6QvzHh3EC0+l6oK3mbQ3f0fQNh8/DTw1FPkWqjYdQM02sd0
 R3OQpeNVq7mKzPXA3fBV+IANlwmMS7qx864zZiI5Ru3tcTT9o+cAJRDU0KR+qwSKZGmw
 jYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427399; x=1786032199;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MsdlOHHmbRKGk5S0dzylTdb8VJgZsBqFZSsWjUBAO4g=;
 b=jf/OFPuOABjYRtwRwR17lTihO3z4E3561b7+TUB+cbKSeEV0NpUqcvqvRNt0IVXsCV
 WPCYWI+hQaMcgfmlFkJ5repw5MwmueYIMb0YsCI4bbzxyRmx+TuDLLJhIkHML+cwG256
 h3KJP+26J0iIcWr+b5STUy69a6eVnX3HdA8H9KWhQ+GleS5y0gjDakbJqkKqGSSngsWn
 SC7coT/m0lgU7d74YB7ohYmBtkhER+u9SvfdCAjwIxcLx1ixObCumP4b0HBZxbCgV25p
 rj7yO9VloRr8INCmMU6nduUek7ivU6YBEUQWxwNXfcSyE4fUfegi4GPIqGNrgh5nuo3g
 fkEw==
X-Gm-Message-State: AOJu0Yypnx4Nqae10K57tCfY+DBHtsn0ZwqcaJFpmDlv+tiLD1Ooq/d/
 ApFSAhXLLPPQ6JYiPlL0OSJvAEV8+kR7rx6ek6NFPCFb4utw7buGqxSGuLH0NrIuPIzPo18tf+H
 IMCbUWM2Qe2DhPXmTs0ZXuV5h1yWpO/mL2SHfXQnM9iu0aW2PUxrZ6L60gIesS/5GL7lb82EWA7
 5SewS0JQ==
X-Gm-Gg: AR+sD10pdtZVkeqObmbn9HY/EGJSIGY1Q/FOigb6sB0PsbV2LoSL2g3DSK2Wt3I9u9G
 Ov/utzgItkk2xf8LcdHZk8EsP4xVmwRiPFuJ1IzMDMegwbyfaiAxGkp/LJyoJEINXOMvYqKe+z6
 9bgDRUns2S1Qut5cavTIithOzlBa+Vvk2ypt8eQV6OiD7jOBe/Xcl7W03cOLiDiOuReJ27snmuT
 klMInoBOLkNgsln1nYs1ppkHdjAv+yfZbzO4t5HNvRvi5oQQR5xekR2hycgmWbqBmLw9eEW63DX
 rfLA7SwbzzCD10kSUVE9PfymjLZsdkZq8N6XJGNmDEKlv0nzz7YKycUL3DTsQ+xP9YK0+fs0JDq
 NSSXqWvp6yLbvqUk2oVxVMbVJMGLqrcz8teZKlyIWYuIWZyskEkUfCJkzTEvThhL/a2Y6Cxsvtk
 pZURFhDPmcwR5GzRHO6TbJnjNZwhWjQ5vBHtDBQIfUPdvLaTHhgRhC9qCDLClh+ToxZn0gHU0eE
 9n4QP9dj0BReZvdO3YWsuJbbdsLWZImuK4b+oUPxdQlQO19RsIjBdzX8zbKHIoQk2cc/nzYgGOx
 f0qA+zrmBeDKrDuCR6yoPVTxh+wPM1p771l9MEhYoaW/Wp+koqo=
X-Received: by 2002:a05:600c:1d99:b0:493:c535:3934 with SMTP id
 5b1f17b1804b1-49804c6d1d0mr21611585e9.36.1785427398717; 
 Thu, 30 Jul 2026 09:03:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011feca8sm74926315e9.8.2026.07.30.09.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:03:18 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 16:03:16 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 76f8f0f6ef32cf8a07f6bfead7733b2742e20f07
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b395828ee1a539bd3885b34a419eb34452d1e65-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpTED-0007UC-FD
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7910739658807010350=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7910739658807010350==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wbM0c1x9n+4="; charset=UTF-8

--wbM0c1x9n+4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1571?usp=3Demail

to look at the new patch set (#2=
1)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by flichtenheld


Change subject: Change hash iv to a be a fixed sized arr=
ay
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Change has=
h iv to a be a fixed sized array

While for our own hash function, always u=
sing an uint32_t works well, it does
not work very well if we move to anoth=
er hash function like siphash that
requires a larger key=2E

To avoid alloc=
ating a specific context, change the API to be a fixed size
array of size 4=
=2E This define allows use to easily change it to a larger
value if we use =
hash functions that require larger keys=2E

Change-Id: If47c7d920b2fa4047b7=
db03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
=
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M sr=
c/openvpn/mroute=2Eh
M src/openvpn/multi=2Ec
M tests/unit_tests/openvpn/tes=
t_misc=2Ec
6 files changed, 32 insertions(+), 23 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1571/21

diff --=
git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index c07e764=2E=2Ee52c77=
8 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -29,13 +2=
9,15 @@
 
 #include "integer=2Eh"
 #include "list=2Eh"
+
+#include "crypto=
=2Eh"
 #include "misc=2Eh"
 
 #include "memdbg=2Eh"
 
 struct hash *
-hash_=
init(const uint32_t n_buckets, const uint32_t iv,
-          uint64_t (*has=
h_function)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_buck=
ets,
+          uint64_t (*hash_function)(const void *key, const uint8_t ha=
sh_key[HASH_KEY_LEN]),
           bool (*compare_function)(const void *key1=
, const void *key2))
 {
     struct hash *h;
@@ -46,7 +48,10 @@
     h->mas=
k =3D h->n_buckets - 1;
     h->hash_function =3D hash_function;
     h->co=
mpare_function =3D compare_function;
-    h->iv =3D iv;
+
+    /* create ra=
ndom hash key */
+    prng_bytes(h->hash_key, sizeof(h->hash_key));
+
     =
ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
     for (uint32=
_t i =3D 0; i < h->n_buckets; ++i)
     {
diff --git a/src/openvpn/list=2Eh=
 b/src/openvpn/list=2Eh
index 06377c6=2E=2Ecbf1abf 100644
--- a/src/openvpn=
/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -49,19 +49,24 @@
     struct hash_e=
lement *list;
 };
 
+
+#define HASH_KEY_LEN 4
+
 struct hash
 {
     uint32=
_t n_buckets;
     uint32_t n_elements;
     uint32_t mask;
-    uint32_t i=
v;
-    uint64_t (*hash_function)(const void *key, uint32_t iv);
+    /** k=
ey/iv used for the hash function=2E No to be confused with the (key, value)=

+     * keys for the actual hash map entries */
+    uint8_t hash_key[HASH=
_KEY_LEN];
+    uint64_t (*hash_function)(const void *key, const uint8_t ha=
sh_key[HASH_KEY_LEN]);
     bool (*compare_function)(const void *key1, cons=
t void *key2); /* return true if equal */
     struct hash_bucket *buckets;=

 };
 
-struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,=

-                       uint64_t (*hash_function)(const void *key, uint32_=
t iv),
+struct hash *hash_init(const uint32_t n_buckets,
+                 =
      uint64_t (*hash_function)(const void *key, const uint8_t hash_key[HAS=
H_KEY_LEN]),
                        bool (*compare_function)(const void *k=
ey1, const void *key2));
 
 void hash_free(struct hash *hash);
@@ -103,7 +1=
08,7 @@
 static inline uint64_t
 hash_value(const struct hash *hash, const =
void *key)
 {
-    return (*hash->hash_function)(key, hash->iv);
+    retur=
n (*hash->hash_function)(key, hash->hash_key);
 }
 
 static inline uint32_t=

diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 78c689e=
=2E=2Ea5179d0 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=
=2Ec
@@ -355,10 +355,10 @@
  * and the actual address=2E
  */
 uint64_t
-mr=
oute_addr_hash_function(const void *key, uint32_t iv)
+mroute_addr_hash_fun=
ction(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     return=
 hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-        =
             mroute_addr_hash_len((const struct mroute_addr *)key), iv);
+ =
                    mroute_addr_hash_len((const struct mroute_addr *)key), =
*(uint32_t *)hash_key);
 }
 
 bool
diff --git a/src/openvpn/mroute=2Eh b/sr=
c/openvpn/mroute=2Eh
index 2f5d019=2E=2E639281b 100644
--- a/src/openvpn/mr=
oute=2Eh
+++ b/src/openvpn/mroute=2Eh
@@ -144,7 +144,7 @@
 
 bool mroute_le=
arnable_address(const struct mroute_addr *addr, struct gc_arena *gc);
 
-ui=
nt64_t mroute_addr_hash_function(const void *key, uint32_t iv);
+uint64_t m=
route_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_L=
EN]);
 
 bool mroute_addr_compare_function(const void *key1, const void *ke=
y2);
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index f82=
3f5b=2E=2Ecfa2ad8 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mult=
i=2Ec
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEMENT
 
 static uint64_t
-cid=
_hash_function(const void *key, uint32_t iv)
+cid_hash_function(const void =
*key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     const unsigned long *k =
=3D (const unsigned long *)key;
     return (uint64_t)*k;
@@ -250,7 +250,7 =
@@
 /*
  * inotify watcher descriptors are used as hash value
  */
-int_has=
h_function(const void *key, uint32_t iv)
+int_hash_function(const void *key=
, const uint8_t hash_key[HASH_KEY_LEN])
 {
     return (uintptr_t)key;
 }
@=
@ -290,18 +290,18 @@
      * to determine which client sent an incoming pac=
ket
      * which is seen on the TCP/UDP socket=2E
      */
-    m->hash =
=3D hash_init(t->options=2Ereal_hash_size, (uint32_t)get_random(),
+    m->=
hash =3D hash_init(t->options=2Ereal_hash_size,
                         mr=
oute_addr_hash_function, mroute_addr_compare_function);
 
     /*
      * V=
irtual address hash table=2E  Used to determine
      * which client to rou=
te a packet to=2E
      */
-    m->vhash =3D hash_init(t->options=2Evirtual=
_hash_size, (uint32_t)get_random(),
+    m->vhash =3D hash_init(t->options=
=2Evirtual_hash_size,
                          mroute_addr_hash_function, =
mroute_addr_compare_function);
 
 #ifdef ENABLE_MANAGEMENT
-    m->cid_hash=
 =3D hash_init(t->options=2Ereal_hash_size, 0, cid_hash_function, cid_compa=
re_function);
+    m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, c=
id_hash_function, cid_compare_function);
 #endif
 
 #ifdef ENABLE_ASYNC_PUS=
H
@@ -309,8 +309,8 @@
      * Mapping between inotify watch descriptors and=

      * multi_instances=2E
      */
-    m->inotify_watchers =3D hash_init=
(t->options=2Ereal_hash_size, (uint32_t)get_random(),
-                    =
                int_hash_function, int_compare_function);
+    m->inotify_w=
atchers =3D
+        hash_init(t->options=2Ereal_hash_size, int_hash_functi=
on, int_compare_function);
 #endif
 
     /*
diff --git a/tests/unit_tests/=
openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index fc9840=
a=2E=2E501286c 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/te=
sts/unit_tests/openvpn/test_misc=2Ec
@@ -128,11 +128,11 @@
 
 
 static uint=
64_t
-word_hash_function(const void *key, uint32_t iv)
+word_hash_function(=
const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     const char *=
str =3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(str=
);
-    return hash_func((const uint8_t *)str, len, iv);
+    return hash_f=
unc((const uint8_t *)str, len, *(uint32_t *)(hash_key));
 }
 
 static bool
=
@@ -174,10 +174,9 @@
      * Test the hash code by implementing a simple
  =
    * word frequency algorithm=2E
      */
-
     struct gc_arena gc =3D gc=
_new();
-    struct hash *hash =3D hash_init(10000, get_random(), word_hash=
_function, word_compare_function);
-    struct hash *nhash =3D hash_init(25=
6, get_random(), word_hash_function, word_compare_function);
+    struct ha=
sh *hash =3D hash_init(10000, word_hash_function, word_compare_function);
+=
    struct hash *nhash =3D hash_init(256, word_hash_function, word_compare_=
function);
 
     printf("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->=
n_buckets, hash->mask);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 15=
71
Gerrit-PatchSet: 21
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>

--wbM0c1x9n+4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #21</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>The followin=
g approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Change hash iv to a be a fixed sized array<br><br>While for =
our own hash function, always using an uint32_t works well, it does<br>not =
work very well if we move to another hash function like siphash that<br>req=
uires a larger key=2E<br><br>To avoid allocating a specific context, change=
 the API to be a fixed size<br>array of size 4=2E This define allows use to=
 easily change it to a larger<br>value if we use hash functions that requir=
e larger keys=2E<br><br>Change-Id: If47c7d920b2fa4047b7db03fcde821899839324=
d<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src=
/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br>=
M src/openvpn/mroute=2Eh<br>M src/openvpn/multi=2Ec<br>M tests/unit_tests/o=
penvpn/test_misc=2Ec<br>6 files changed, 32 insertions(+), 23 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/71/1571/21</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/list=2Ec b/src=
/openvpn/list=2Ec</span><br><span>index c07e764=2E=2Ee52c778 100644</span><=
br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=
=2Ec</span><br><span>@@ -29,13 +29,15 @@</span><br><span> </span><br><span>=
 #include &quot;integer=2Eh&quot;</span><br><span> #include &quot;list=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</=
span><br><span> #include &quot;misc=2Eh&quot;</span><br><span> </span><br><=
span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span> st=
ruct hash *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_init(=
const uint32_t n_buckets, const uint32_t iv,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-          uint64_t (*hash_function)(const void *key,=
 uint32_t iv),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_=
init(const uint32_t n_buckets,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+          uint64_t (*hash_function)(const void *key, const uint8=
_t hash_key[HASH_KEY_LEN]),</span><br><span>           bool (*compare_funct=
ion)(const void *key1, const void *key2))</span><br><span> {</span><br><spa=
n>     struct hash *h;</span><br><span>@@ -46,7 +48,10 @@</span><br><span> =
    h-&gt;mask =3D h-&gt;n_buckets - 1;</span><br><span>     h-&gt;hash_fun=
ction =3D hash_function;</span><br><span>     h-&gt;compare_function =3D co=
mpare_function;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    h-=
&gt;iv =3D iv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* create random has=
h key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prng_by=
tes(h-&gt;hash_key, sizeof(h-&gt;hash_key));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     ALLOC_ARRAY(h-&gt;buckets, s=
truct hash_bucket, h-&gt;n_buckets);</span><br><span>     for (uint32_t i =
=3D 0; i &lt; h-&gt;n_buckets; ++i)</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>in=
dex 06377c6=2E=2Ecbf1abf 100644</span><br><span>--- a/src/openvpn/list=2Eh<=
/span><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -49,19 +49,24=
 @@</span><br><span>     struct hash_element *list;</span><br><span> };</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HASH_KEY_LEN 4</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> str=
uct hash</span><br><span> {</span><br><span>     uint32_t n_buckets;</span>=
<br><span>     uint32_t n_elements;</span><br><span>     uint32_t mask;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t iv;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t (*hash_function)(=
const void *key, uint32_t iv);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /** key/iv used for the hash function=2E No to be confused w=
ith the (key, value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * keys for the actual hash map entries */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint8_t hash_key[HASH_KEY_LEN];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t (*hash_function)(c=
onst void *key, const uint8_t hash_key[HASH_KEY_LEN]);</span><br><span>    =
 bool (*compare_function)(const void *key1, const void *key2); /* return tr=
ue if equal */</span><br><span>     struct hash_bucket *buckets;</span><br>=
<span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
uint64_t (*hash_function)(const void *key, uint32_t iv),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+struct hash *hash_init(const uint32_t =
n_buckets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              uint64_t (*hash_function)(const void *key, const uint8_t hash=
_key[HASH_KEY_LEN]),</span><br><span>                        bool (*compare=
_function)(const void *key1, const void *key2));</span><br><span> </span><b=
r><span> void hash_free(struct hash *hash);</span><br><span>@@ -103,7 +108,=
7 @@</span><br><span> static inline uint64_t</span><br><span> hash_value(co=
nst struct hash *hash, const void *key)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return (*hash-&gt;hash_function)(k=
ey, hash-&gt;iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return (*hash-&gt;hash_function)(key, hash-&gt;hash_key);</span><br><span=
> }</span><br><span> </span><br><span> static inline uint32_t</span><br><sp=
an>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><=
span>index 78c689e=2E=2Ea5179d0 100644</span><br><span>--- a/src/openvpn/mr=
oute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -3=
55,10 +355,10 @@</span><br><span>  * and the actual address=2E</span><br><s=
pan>  */</span><br><span> uint64_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-mroute_addr_hash_function(const void *key, uint32_t iv)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+mroute_addr_hash_function(=
const void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</=
span><br><span>     return hash_func(mroute_addr_hash_ptr((const struct mro=
ute_addr *)key),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                mroute_addr_hash_len((const struct mroute_addr *)key), iv);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  mroute_addr_hash_len((const struct mroute_addr *)key), *(uint32_t *)hash_=
key);</span><br><span> }</span><br><span> </span><br><span> bool</span><br>=
<span>diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mroute=2Eh</span><b=
r><span>index 2f5d019=2E=2E639281b 100644</span><br><span>--- a/src/openvpn=
/mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=2Eh</span><br><span>@@=
 -144,7 +144,7 @@</span><br><span> </span><br><span> bool mroute_learnable_=
address(const struct mroute_addr *addr, struct gc_arena *gc);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t mroute_a=
ddr_hash_function(const void *key, uint32_t iv);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+uint64_t mroute_addr_hash_function(const void =
*key, const uint8_t hash_key[HASH_KEY_LEN]);</span><br><span> </span><br><s=
pan> bool mroute_addr_compare_function(const void *key1, const void *key2);=
</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec</span><br><span>index f823f5b=2E=2Ecfa2ad8 100644</span>=
<br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mul=
ti=2Ec</span><br><span>@@ -229,7 +229,7 @@</span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span> </span><br><span> static uint64_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-cid_hash_function(const void *key, u=
int32_t iv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cid_hash=
_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br>=
<span> {</span><br><span>     const unsigned long *k =3D (const unsigned lo=
ng *)key;</span><br><span>     return (uint64_t)*k;</span><br><span>@@ -250=
,7 +250,7 @@</span><br><span> /*</span><br><span>  * inotify watcher descri=
ptors are used as hash value</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int_hash_function(const void *key, uint32_t iv)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int_hash_function(c=
onst void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</s=
pan><br><span>     return (uintptr_t)key;</span><br><span> }</span><br><spa=
n>@@ -290,18 +290,18 @@</span><br><span>      * to determine which client s=
ent an incoming packet</span><br><span>      * which is seen on the TCP/UDP=
 socket=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size, =
(uint32_t)get_random(),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash_size,</span><br>=
<span>                         mroute_addr_hash_function, mroute_addr_compa=
re_function);</span><br><span> </span><br><span>     /*</span><br><span>   =
   * Virtual address hash table=2E  Used to determine</span><br><span>     =
 * which client to route a packet to=2E</span><br><span>      */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-=
&gt;options=2Evirtual_hash_size, (uint32_t)get_random(),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;op=
tions=2Evirtual_hash_size,</span><br><span>                          mroute=
_addr_hash_function, mroute_addr_compare_function);</span><br><span> </span=
><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_s=
ize, 0, cid_hash_function, cid_compare_function);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    m-&gt;cid_hash =3D hash_init(t-&gt;option=
s=2Ereal_hash_size, cid_hash_function, cid_compare_function);</span><br><sp=
an> #endif</span><br><span> </span><br><span> #ifdef ENABLE_ASYNC_PUSH</spa=
n><br><span>@@ -309,8 +309,8 @@</span><br><span>      * Mapping between ino=
tify watch descriptors and</span><br><span>      * multi_instances=2E</span=
><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  m-&gt;inotify_watchers =3D hash_init(t-&gt;options=2Ereal_hash_size, (uin=
t32_t)get_random(),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                  int_hash_function, int_compare_function);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;inotify_w=
atchers =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
hash_init(t-&gt;options=2Ereal_hash_size, int_hash_function, int_compare_fu=
nction);</span><br><span> #endif</span><br><span> </span><br><span>     /*<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests=
/unit_tests/openvpn/test_misc=2Ec</span><br><span>index fc9840a=2E=2E501286=
c 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ =
-128,11 +128,11 @@</span><br><span> </span><br><span> </span><br><span> sta=
tic uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-word_hash=
_function(const void *key, uint32_t iv)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+word_hash_function(const void *key, const uint8_t hash_=
key[HASH_KEY_LEN])</span><br><span> {</span><br><span>     const char *str =
=3D (const char *)key;</span><br><span>     const uint32_t len =3D (uint32_=
t)strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn hash_func((const uint8_t *)str, len, iv);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return hash_func((const uint8_t *)str, len, *=
(uint32_t *)(hash_key));</span><br><span> }</span><br><span> </span><br><sp=
an> static bool</span><br><span>@@ -174,10 +174,9 @@</span><br><span>      =
* Test the hash code by implementing a simple</span><br><span>      * word =
frequency algorithm=2E</span><br><span>      */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_n=
ew();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash =
*hash =3D hash_init(10000, get_random(), word_hash_function, word_compare_f=
unction);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct h=
ash *nhash =3D hash_init(256, get_random(), word_hash_function, word_compar=
e_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct hash *hash =3D hash_init(10000, word_hash_function, word_compare_functi=
on);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash=
 *nhash =3D hash_init(256, word_hash_function, word_compare_function);</spa=
n><br><span> </span><br><span>     printf(&quot;hash_init n_buckets=3D%u ma=
sk=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><span> <=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047=
b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>

</body></html>
--wbM0c1x9n+4=--


--===============7910739658807010350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7910739658807010350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7910739658807010350==--

