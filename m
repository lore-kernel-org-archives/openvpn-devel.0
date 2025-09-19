From: Gert Doering <gert@...1296...>
Date: Fri, 19 Sep 2025 19:38:32 +0200
Message-ID: <20250919173838.28092-1-gert@...1296...>
In-Reply-To: <gerrit.1753792433000.I3334465738fb1fbf508dfd719b6a238b500cc0ae@...2715...>
References: <gerrit.1753792433000.I3334465738fb1fbf508dfd719b6a238b500cc0ae@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] list: Make types of hash elements
 consistent
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Really no use in having the indices and limits in int.

Change-Id: I3334465738fb1fbf508dfd719b6a238b500cc0ae
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1119
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1119
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index b82379e..2a6f14a 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -135,6 +135,27 @@
     }
 }
 
+static inline unsigned int
+constrain_uint(unsigned int x, unsigned int min, unsigned int max)
+{
+    if (min > max)
+    {
+        return min;
+    }
+    if (x < min)
+    {
+        return min;
+    }
+    else if (x > max)
+    {
+        return max;
+    }
+    else
+    {
+        return x;
+    }
+}
+
 /*
  * Functions used for circular buffer index arithmetic.
  */
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index f30d540..1b90d82 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -34,22 +34,21 @@
 #include "memdbg.h"
 
 struct hash *
-hash_init(const int n_buckets, const uint32_t iv,
+hash_init(const uint32_t n_buckets, const uint32_t iv,
           uint32_t (*hash_function)(const void *key, uint32_t iv),
           bool (*compare_function)(const void *key1, const void *key2))
 {
     struct hash *h;
-    int i;
 
     ASSERT(n_buckets > 0);
     ALLOC_OBJ_CLEAR(h, struct hash);
-    h->n_buckets = (int)adjust_power_of_2(n_buckets);
+    h->n_buckets = (uint32_t)adjust_power_of_2(n_buckets);
     h->mask = h->n_buckets - 1;
     h->hash_function = hash_function;
     h->compare_function = compare_function;
     h->iv = iv;
     ALLOC_ARRAY(h->buckets, struct hash_bucket, h->n_buckets);
-    for (i = 0; i < h->n_buckets; ++i)
+    for (uint32_t i = 0; i < h->n_buckets; ++i)
     {
         struct hash_bucket *b = &h->buckets[i];
         b->list = NULL;
@@ -60,8 +59,7 @@
 void
 hash_free(struct hash *hash)
 {
-    int i;
-    for (i = 0; i < hash->n_buckets; ++i)
+    for (uint32_t i = 0; i < hash->n_buckets; ++i)
     {
         struct hash_bucket *b = &hash->buckets[i];
         struct hash_element *he = b->list;
@@ -212,15 +210,15 @@
 }
 
 void
-hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, int start_bucket,
-                         int end_bucket)
+hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, uint32_t start_bucket,
+                         uint32_t end_bucket)
 {
     if (end_bucket > hash->n_buckets)
     {
         end_bucket = hash->n_buckets;
     }
 
-    ASSERT(start_bucket >= 0 && start_bucket <= end_bucket);
+    ASSERT(start_bucket <= end_bucket);
 
     hi->hash = hash;
     hi->elem = NULL;
@@ -325,6 +323,9 @@
  * the return value.  Every 1-bit and 2-bit delta achieves avalanche.
  * About 36+6len instructions.
  *
+ * #define hashsize(n) ((uint32_t)1<<(n))
+ * #define hashmask(n) (hashsize(n)-1)
+ *
  * The best hash table sizes are powers of 2.  There is no need to do
  * mod a prime (mod is sooo slow!).  If you need less than 32 bits,
  * use a bitmask.  For example, if you need only 10 bits, do
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index fb3302d..5702b95 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -36,14 +36,11 @@
 #include "basic.h"
 #include "buffer.h"
 
-#define hashsize(n) ((uint32_t)1 << (n))
-#define hashmask(n) (hashsize(n) - 1)
-
 struct hash_element
 {
     void *value;
     const void *key;
-    unsigned int hash_value;
+    uint32_t hash_value;
     struct hash_element *next;
 };
 
@@ -54,16 +51,16 @@
 
 struct hash
 {
-    int n_buckets;
-    int n_elements;
-    int mask;
+    uint32_t n_buckets;
+    uint32_t n_elements;
+    uint32_t mask;
     uint32_t iv;
     uint32_t (*hash_function)(const void *key, uint32_t iv);
     bool (*compare_function)(const void *key1, const void *key2); /* return true if equal */
     struct hash_bucket *buckets;
 };
 
-struct hash *hash_init(const int n_buckets, const uint32_t iv,
+struct hash *hash_init(const uint32_t n_buckets, const uint32_t iv,
                        uint32_t (*hash_function)(const void *key, uint32_t iv),
                        bool (*compare_function)(const void *key1, const void *key2));
 
@@ -81,17 +78,17 @@
 struct hash_iterator
 {
     struct hash *hash;
-    int bucket_index;
+    uint32_t bucket_index;
     struct hash_bucket *bucket;
     struct hash_element *elem;
     struct hash_element *last;
     bool bucket_marked;
-    int bucket_index_start;
-    int bucket_index_end;
+    uint32_t bucket_index_start;
+    uint32_t bucket_index_end;
 };
 
-void hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, int start_bucket,
-                              int end_bucket);
+void hash_iterator_init_range(struct hash *hash, struct hash_iterator *hi, uint32_t start_bucket,
+                              uint32_t end_bucket);
 
 void hash_iterator_init(struct hash *hash, struct hash_iterator *iter);
 
@@ -109,13 +106,13 @@
     return (*hash->hash_function)(key, hash->iv);
 }
 
-static inline int
+static inline uint32_t
 hash_n_elements(const struct hash *hash)
 {
     return hash->n_elements;
 }
 
-static inline int
+static inline uint32_t
 hash_n_buckets(const struct hash *hash)
 {
     return hash->n_buckets;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8676a09..9256127 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -169,18 +169,12 @@
 }
 
 static void
-multi_reap_range(const struct multi_context *m, int start_bucket, int end_bucket)
+multi_reap_range(const struct multi_context *m, uint32_t start_bucket, uint32_t end_bucket)
 {
     struct gc_arena gc = gc_new();
     struct hash_iterator hi;
     struct hash_element *he;
 
-    if (start_bucket < 0)
-    {
-        start_bucket = 0;
-        end_bucket = hash_n_buckets(m->vhash);
-    }
-
     dmsg(D_MULTI_DEBUG, "MULTI: REAP range %d -> %d", start_bucket, end_bucket);
     hash_iterator_init_range(m->vhash, &hi, start_bucket, end_bucket);
     while ((he = hash_iterator_next(&hi)) != NULL)
@@ -201,11 +195,11 @@
 static void
 multi_reap_all(const struct multi_context *m)
 {
-    multi_reap_range(m, -1, 0);
+    multi_reap_range(m, 0, hash_n_buckets(m->vhash));
 }
 
 static struct multi_reap *
-multi_reap_new(int buckets_per_pass)
+multi_reap_new(uint32_t buckets_per_pass)
 {
     struct multi_reap *mr;
     ALLOC_OBJ(mr, struct multi_reap);
@@ -237,10 +231,10 @@
 /*
  * How many buckets in vhash to reap per pass.
  */
-static int
-reap_buckets_per_pass(int n_buckets)
+static uint32_t
+reap_buckets_per_pass(uint32_t n_buckets)
 {
-    return constrain_int(n_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);
+    return constrain_uint(n_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);
 }
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 087c0e6..b2b892b 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -51,8 +51,8 @@
  */
 struct multi_reap
 {
-    int bucket_base;
-    int buckets_per_pass;
+    uint32_t bucket_base;
+    uint32_t buckets_per_pass;
     time_t last_call;
 };
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f1f66b9..151a016 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7956,8 +7956,8 @@
         {
             goto err;
         }
-        options->real_hash_size = real;
-        options->virtual_hash_size = virtual;
+        options->real_hash_size = (uint32_t)real;
+        options->virtual_hash_size = (uint32_t)virtual;
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a737711..b033068 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -499,8 +499,8 @@
     struct in6_addr ifconfig_ipv6_pool_base; /* IPv6 */
     int ifconfig_ipv6_pool_netbits;          /* IPv6 */
 
-    int real_hash_size;
-    int virtual_hash_size;
+    uint32_t real_hash_size;
+    uint32_t virtual_hash_size;
     const char *client_connect_script;
     const char *client_disconnect_script;
     const char *learn_address_script;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index dbfdd56..10bed1d 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -128,7 +128,7 @@
 word_hash_function(const void *key, uint32_t iv)
 {
     const char *str = (const char *)key;
-    const int len = strlen(str);
+    const uint32_t len = (uint32_t)strlen(str);
     return hash_func((const uint8_t *)str, len, iv);
 }
 
@@ -138,11 +138,11 @@
     return strcmp((const char *)key1, (const char *)key2) == 0;
 }
 
-static unsigned long
+static uint32_t
 get_random(void)
 {
     /* rand() is not very random, but it's C99 and this is just for testing */
-    return rand();
+    return (uint32_t)rand();
 }
 
 static struct hash_element *
@@ -176,7 +176,7 @@
     struct hash *hash = hash_init(10000, get_random(), word_hash_function, word_compare_function);
     struct hash *nhash = hash_init(256, get_random(), word_hash_function, word_compare_function);
 
-    printf("hash_init n_buckets=%d mask=0x%08x\n", hash->n_buckets, hash->mask);
+    printf("hash_init n_buckets=%u mask=0x%08x\n", hash->n_buckets, hash->mask);
 
     char wordfile[PATH_MAX] = { 0 };
     openvpn_test_get_srcdir_dir(wordfile, PATH_MAX, "/../../../COPYRIGHT.GPL");
@@ -254,10 +254,10 @@
 
     /* output contents of hash table */
     {
-        ptr_type inc = 0;
+        uint32_t inc = 0;
         int count = 0;
 
-        for (ptr_type base = 0; base < hash_n_buckets(hash); base += inc)
+        for (uint32_t base = 0; base < hash_n_buckets(hash); base += inc)
         {
             struct hash_iterator hi;
             struct hash_element *he;

