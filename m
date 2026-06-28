Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD001C43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 21:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIF3Q/YcTdtWiFrkhWwccZqfynG1zHEXxS1uTgPRbY8=; b=QZUTSrrgduF0MTZKzCVCO74Ho0
	wSWXuZ9tIMZyGlO/lGM+F9I/r5wvRgWz4Ecw30383c8A/3GgEPQw5zaBtO+/AqdHyC6InVIKl5oMB
	kx/DaDiTwbLMqPAEG+Fr5alYbwgiMGay58Cy3bgdu2zeOrimqs/zHt643u/4h1dW8g1Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdwck-0006C9-Sh;
	Sun, 28 Jun 2026 21:01:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wdwcj-0006BT-EK
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 21:01:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g+49HNk5ce9mV0qhbjfrr2wn3MRgYcPJx2cBWkgOQjk=; b=cqx5blnsivlj6oxSHoUZnHmkbY
 2VqnFymj7Wkq7PRPVvl20tlDzUeqt9C7xM0Va7JCVgchJQ04WlOSwbNqSHb8mBKxcSiQ+XTEU4Vow
 VoYvCifN91SwtwxyiGhTfoks5p67089elv3bLfGcDeCFTvwJo6vbrKvFR45SYkGNiOiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g+49HNk5ce9mV0qhbjfrr2wn3MRgYcPJx2cBWkgOQjk=; b=VnYsaxsnDgyN7VlnNY9BWqHtcW
 ceJM53PJos6ZV5/s9iNHXLBiwzJ32sC0cCFbY2I0rWVav5GHmOHnwvuOMgwJHe/zJ7EFkbI4d1VZA
 gRzzWntSongNRtzoBvB9ARNTSej21iBNpG8lRKW/pYEaaonE+ghrriqrjXpx7yOjeUwU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdwcP-0004kJ-H1 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 21:00:47 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65SL0YNn004604
 for <openvpn-devel@lists.sourceforge.net>; Sun, 28 Jun 2026 23:00:34 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SL0YGD004603
 for openvpn-devel@lists.sourceforge.net; Sun, 28 Jun 2026 23:00:34 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 28 Jun 2026 23:00:27 +0200
Message-ID: <20260628210033.4583-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
References: <gerrit.1773251317000.Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wdwcP-0004kJ-H1
Subject: [Openvpn-devel] [PATCH v8] Change hash values in our hash map from
 uint32_t to uint64_t
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Arne Schwabe <arne@rfc2549.org>

32 bit architectures are playing a very small role today, so the difference
between 64 bit and 32 bit hash values is not expected to be large anymore.

This is also in preparation to replace our hash function with a more modern
replacement.

Change-Id: Ib8140107f98164d2a2e1768a6d8ac65016cd7f7c
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1570
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1570
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index f0e9908..c07e764 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -35,7 +35,7 @@
 
 struct hash *
 hash_init(const uint32_t n_buckets, const uint32_t iv,
-          uint32_t (*hash_function)(const void *key, uint32_t iv),
+          uint64_t (*hash_function)(const void *key, uint32_t iv),
           bool (*compare_function)(const void *key1, const void *key2))
 {
     struct hash *h;
@@ -76,7 +76,7 @@
 }
 
 struct hash_element *
-hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv)
+hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv)
 {
     struct hash_element *he;
     struct hash_element *prev = NULL;
@@ -104,7 +104,7 @@
 }
 
 bool
-hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv)
+hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv)
 {
     struct hash_element *he;
     struct hash_element *prev = NULL;
@@ -136,7 +136,7 @@
 bool
 hash_add(struct hash *hash, const void *key, void *value, bool replace)
 {
-    uint32_t hv;
+    uint64_t hv;
     struct hash_bucket *bucket;
     struct hash_element *he;
     bool ret = false;
@@ -412,7 +412,7 @@
         c ^= (b >> 15); \
     }
 
-uint32_t
+uint64_t
 hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
 {
     uint32_t a, b, c, len;
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 04cc3ab..06377c6 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -40,7 +40,7 @@
 {
     void *value;
     const void *key;
-    uint32_t hash_value;
+    uint64_t hash_value;
     struct hash_element *next;
 };
 
@@ -55,13 +55,13 @@
     uint32_t n_elements;
     uint32_t mask;
     uint32_t iv;
-    uint32_t (*hash_function)(const void *key, uint32_t iv);
+    uint64_t (*hash_function)(const void *key, uint32_t iv);
     bool (*compare_function)(const void *key1, const void *key2); /* return true if equal */
     struct hash_bucket *buckets;
 };
 
 struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-                       uint32_t (*hash_function)(const void *key, uint32_t iv),
+                       uint64_t (*hash_function)(const void *key, uint32_t iv),
                        bool (*compare_function)(const void *key1, const void *key2));
 
 void hash_free(struct hash *hash);
@@ -69,9 +69,9 @@
 bool hash_add(struct hash *hash, const void *key, void *value, bool replace);
 
 struct hash_element *hash_lookup_fast(struct hash *hash, struct hash_bucket *bucket,
-                                      const void *key, uint32_t hv);
+                                      const void *key, uint64_t hv);
 
-bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv);
+bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv);
 
 void hash_remove_by_value(struct hash *hash, void *value);
 
@@ -98,9 +98,9 @@
 
 void hash_iterator_free(struct hash_iterator *hi);
 
-uint32_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
+uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
 
-static inline uint32_t
+static inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
     return (*hash->hash_function)(key, hash->iv);
@@ -119,7 +119,7 @@
 }
 
 static inline struct hash_bucket *
-hash_bucket(struct hash *hash, uint32_t hv)
+hash_bucket(struct hash *hash, uint64_t hv)
 {
     return &hash->buckets[hv & hash->mask];
 }
@@ -129,7 +129,7 @@
 {
     void *ret = NULL;
     struct hash_element *he;
-    uint32_t hv = hash_value(hash, key);
+    uint64_t hv = hash_value(hash, key);
     struct hash_bucket *bucket = &hash->buckets[hv & hash->mask];
 
     he = hash_lookup_fast(hash, bucket, key, hv);
@@ -143,7 +143,7 @@
 
 /* NOTE: assumes that key is not a duplicate */
 static inline void
-hash_add_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint32_t hv,
+hash_add_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint64_t hv,
               void *value)
 {
     struct hash_element *he;
@@ -160,7 +160,7 @@
 static inline bool
 hash_remove(struct hash *hash, const void *key)
 {
-    uint32_t hv;
+    uint64_t hv;
     struct hash_bucket *bucket;
     bool ret;
 
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 6fa70a3..78c689e 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -354,7 +354,7 @@
  * address type, number of bits in the network address,
  * and the actual address.
  */
-uint32_t
+uint64_t
 mroute_addr_hash_function(const void *key, uint32_t iv)
 {
     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index c8daa15..2f5d019 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -144,7 +144,7 @@
 
 bool mroute_learnable_address(const struct mroute_addr *addr, struct gc_arena *gc);
 
-uint32_t mroute_addr_hash_function(const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);
 
 bool mroute_addr_compare_function(const void *key1, const void *key2);
 
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 7651b4d..f000283 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -49,7 +49,7 @@
     {
         mi->real.proto = sock->info.proto;
         struct hash_element *he;
-        const uint32_t hv = hash_value(hash, &mi->real);
+        const uint64_t hv = hash_value(hash, &mi->real);
         struct hash_bucket *bucket = hash_bucket(hash, hv);
 
         multi_assign_peer_id(m, mi);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 143a330..b1de446 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -212,7 +212,7 @@
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true) && m->top.c2.buf.len > 0)
     {
         struct hash_element *he;
-        const uint32_t hv = hash_value(hash, &real);
+        const uint64_t hv = hash_value(hash, &real);
         struct hash_bucket *bucket = hash_bucket(hash, hv);
         uint8_t *ptr = BPTR(&m->top.c2.buf);
         uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e96d43c..e1c9c80 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -228,11 +228,11 @@
 
 #ifdef ENABLE_MANAGEMENT
 
-static uint32_t
+static uint64_t
 cid_hash_function(const void *key, uint32_t iv)
 {
     const unsigned long *k = (const unsigned long *)key;
-    return (uint32_t)*k;
+    return (uint64_t)*k;
 }
 
 static bool
@@ -246,19 +246,19 @@
 #endif
 
 #ifdef ENABLE_ASYNC_PUSH
-static uint32_t
+static uint64_t
 /*
  * inotify watcher descriptors are used as hash value
  */
 int_hash_function(const void *key, uint32_t iv)
 {
-    return (uint32_t)(uintptr_t)key;
+    return (uintptr_t)key;
 }
 
 static bool
 int_compare_function(const void *key1, const void *key2)
 {
-    return (unsigned long)key1 == (unsigned long)key2;
+    return (uintptr_t)key1 == (uintptr_t)key2;
 }
 #endif
 
@@ -1011,7 +1011,7 @@
                  const unsigned int flags)
 {
     struct hash_element *he;
-    const uint32_t hv = hash_value(m->vhash, addr);
+    const uint64_t hv = hash_value(m->vhash, addr);
     struct hash_bucket *bucket = hash_bucket(m->vhash, hv);
     struct multi_route *oldroute = NULL;
     struct multi_instance *owner = NULL;
@@ -3094,7 +3094,7 @@
         goto done;
     }
 
-    const uint32_t hv = hash_value(hash, &real);
+    const uint64_t hv = hash_value(hash, &real);
     struct hash_bucket *bucket = hash_bucket(hash, hv);
 
     /* make sure that we don't float to an address taken by another client */
@@ -4230,7 +4230,7 @@
 multi_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const struct mroute_addr *addr)
 {
     struct hash_element *he;
-    const uint32_t hv = hash_value(m->vhash, addr);
+    const uint64_t hv = hash_value(m->vhash, addr);
     struct hash_bucket *bucket = hash_bucket(m->vhash, hv);
     struct multi_route *r = NULL;
 
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index a9ae33f..ccdfdee 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -124,7 +124,7 @@
 };
 
 
-static uint32_t
+static uint64_t
 word_hash_function(const void *key, uint32_t iv)
 {
     const char *str = (const char *)key;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
