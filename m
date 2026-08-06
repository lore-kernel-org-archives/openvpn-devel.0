Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B85C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7H2B5mLo9+eOdPk6zv9dVB0VEfTibwmTh7Rk41b3qgU=; b=SV01U3mPLD7Wwr2CxW57tih+fI
	NEyIHzLLV1qdmp5OwHNTbV+Mwjud7EW+XB9UPBYTxJFaUV1h5ssLjQFE+hcwI48rFiNITaJy8v8R/
	z+EgsZ1iCqjSon/7+IU+T7XyUe2MkwzF/wQw5Qxjr27w4NAcXCIMEKUpbkqIElxhuEu4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrvM1-0002V1-Is;
	Thu, 06 Aug 2026 10:29:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wrvM0-0002Uv-Az
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2uiaB7TnFUEmCzuAs783wILd5TK4gST7R1Gn3jPpfM=; b=TpYjcX8/hatzz+l77ILAPEGE3A
 G7DZ4x2W9VAsEfYRxYf8gldYVxRzay7aDV+3ZB/C008sDgFMBjr0UC0+pzzNayiVcWxj9Gm/+8ZPr
 Jjk3MRvnvlzKgmz9QAPT4NqR95xKtAHNAkG4Q6E8z5LY3GIPT7Djg71Z/a+k2/6mWGp0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q2uiaB7TnFUEmCzuAs783wILd5TK4gST7R1Gn3jPpfM=; b=hvJwNnnyrXaccmtIgDjJbxTO+p
 vFPdwDRYsf1SQoKMO9oJdtulGkpw0i6ZX4sEUk1t3e4NLOGfTpq5Ay+63dDmoflJotPEfGqQmereA
 Q2nxE3TttkqEQkcgi2nFwB04x1LBjFNsfsN4sTHlxb4bo+DOH8bfnCjPyVl6aY5/KOQQ=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrvLy-0004DE-0n for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:29:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 676ATRte028234
 for <openvpn-devel@lists.sourceforge.net>; Thu, 6 Aug 2026 12:29:27 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 676ATR1U028233
 for openvpn-devel@lists.sourceforge.net; Thu, 6 Aug 2026 12:29:27 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 12:29:21 +0200
Message-ID: <20260806102926.28206-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wrvLy-0004DE-0n
Subject: [Openvpn-devel] [PATCH v21] Change hash iv to a be a fixed sized
 array
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

While for our own hash function, always using an uint32_t works well, it does
not work very well if we move to another hash function like siphash that
requires a larger key.

To avoid allocating a specific context, change the API to be a fixed size
array of size 4. This define allows use to easily change it to a larger
value if we use hash functions that require larger keys.

Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1571
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1571
This mail reflects revision 21 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index c07e764..e52c778 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -29,13 +29,15 @@
 
 #include "integer.h"
 #include "list.h"
+
+#include "crypto.h"
 #include "misc.h"
 
 #include "memdbg.h"
 
 struct hash *
-hash_init(const uint32_t n_buckets, const uint32_t iv,
-          uint64_t (*hash_function)(const void *key, uint32_t iv),
+hash_init(const uint32_t n_buckets,
+          uint64_t (*hash_function)(const void *key, const uint8_t hash_key[HASH_KEY_LEN]),
           bool (*compare_function)(const void *key1, const void *key2))
 {
     struct hash *h;
@@ -46,7 +48,10 @@
     h->mask = h->n_buckets - 1;
     h->hash_function = hash_function;
     h->compare_function = compare_function;
-    h->iv = iv;
+
+    /* create random hash key */
+    prng_bytes(h->hash_key, sizeof(h->hash_key));
+
     ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
     for (uint32_t i = 0; i < h->n_buckets; ++i)
     {
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 06377c6..cbf1abf 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -49,19 +49,24 @@
     struct hash_element *list;
 };
 
+
+#define HASH_KEY_LEN 4
+
 struct hash
 {
     uint32_t n_buckets;
     uint32_t n_elements;
     uint32_t mask;
-    uint32_t iv;
-    uint64_t (*hash_function)(const void *key, uint32_t iv);
+    /** key/iv used for the hash function. No to be confused with the (key, value)
+     * keys for the actual hash map entries */
+    uint8_t hash_key[HASH_KEY_LEN];
+    uint64_t (*hash_function)(const void *key, const uint8_t hash_key[HASH_KEY_LEN]);
     bool (*compare_function)(const void *key1, const void *key2); /* return true if equal */
     struct hash_bucket *buckets;
 };
 
-struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
-                       uint64_t (*hash_function)(const void *key, uint32_t iv),
+struct hash *hash_init(const uint32_t n_buckets,
+                       uint64_t (*hash_function)(const void *key, const uint8_t hash_key[HASH_KEY_LEN]),
                        bool (*compare_function)(const void *key1, const void *key2));
 
 void hash_free(struct hash *hash);
@@ -103,7 +108,7 @@
 static inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
-    return (*hash->hash_function)(key, hash->iv);
+    return (*hash->hash_function)(key, hash->hash_key);
 }
 
 static inline uint32_t
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 78c689e..a5179d0 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -355,10 +355,10 @@
  * and the actual address.
  */
 uint64_t
-mroute_addr_hash_function(const void *key, uint32_t iv)
+mroute_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-                     mroute_addr_hash_len((const struct mroute_addr *)key), iv);
+                     mroute_addr_hash_len((const struct mroute_addr *)key), *(uint32_t *)hash_key);
 }
 
 bool
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 2f5d019..639281b 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -144,7 +144,7 @@
 
 bool mroute_learnable_address(const struct mroute_addr *addr, struct gc_arena *gc);
 
-uint64_t mroute_addr_hash_function(const void *key, uint32_t iv);
+uint64_t mroute_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN]);
 
 bool mroute_addr_compare_function(const void *key1, const void *key2);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f823f5b..cfa2ad8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -229,7 +229,7 @@
 #ifdef ENABLE_MANAGEMENT
 
 static uint64_t
-cid_hash_function(const void *key, uint32_t iv)
+cid_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     const unsigned long *k = (const unsigned long *)key;
     return (uint64_t)*k;
@@ -250,7 +250,7 @@
 /*
  * inotify watcher descriptors are used as hash value
  */
-int_hash_function(const void *key, uint32_t iv)
+int_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     return (uintptr_t)key;
 }
@@ -290,18 +290,18 @@
      * to determine which client sent an incoming packet
      * which is seen on the TCP/UDP socket.
      */
-    m->hash = hash_init(t->options.real_hash_size, (uint32_t)get_random(),
+    m->hash = hash_init(t->options.real_hash_size,
                         mroute_addr_hash_function, mroute_addr_compare_function);
 
     /*
      * Virtual address hash table.  Used to determine
      * which client to route a packet to.
      */
-    m->vhash = hash_init(t->options.virtual_hash_size, (uint32_t)get_random(),
+    m->vhash = hash_init(t->options.virtual_hash_size,
                          mroute_addr_hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_MANAGEMENT
-    m->cid_hash = hash_init(t->options.real_hash_size, 0, cid_hash_function, cid_compare_function);
+    m->cid_hash = hash_init(t->options.real_hash_size, cid_hash_function, cid_compare_function);
 #endif
 
 #ifdef ENABLE_ASYNC_PUSH
@@ -309,8 +309,8 @@
      * Mapping between inotify watch descriptors and
      * multi_instances.
      */
-    m->inotify_watchers = hash_init(t->options.real_hash_size, (uint32_t)get_random(),
-                                    int_hash_function, int_compare_function);
+    m->inotify_watchers =
+        hash_init(t->options.real_hash_size, int_hash_function, int_compare_function);
 #endif
 
     /*
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index fc9840a..501286c 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -128,11 +128,11 @@
 
 
 static uint64_t
-word_hash_function(const void *key, uint32_t iv)
+word_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
     const char *str = (const char *)key;
     const uint32_t len = (uint32_t)strlen(str);
-    return hash_func((const uint8_t *)str, len, iv);
+    return hash_func((const uint8_t *)str, len, *(uint32_t *)(hash_key));
 }
 
 static bool
@@ -174,10 +174,9 @@
      * Test the hash code by implementing a simple
      * word frequency algorithm.
      */
-
     struct gc_arena gc = gc_new();
-    struct hash *hash = hash_init(10000, get_random(), word_hash_function, word_compare_function);
-    struct hash *nhash = hash_init(256, get_random(), word_hash_function, word_compare_function);
+    struct hash *hash = hash_init(10000, word_hash_function, word_compare_function);
+    struct hash *nhash = hash_init(256, word_hash_function, word_compare_function);
 
     printf("hash_init n_buckets=%u mask=0x%08x\n", hash->n_buckets, hash->mask);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
