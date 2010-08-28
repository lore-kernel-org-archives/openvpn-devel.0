From: David Sommerseth <dazo@...384...>
Date: Sat, 28 Aug 2010 22:32:00 +0200
Message-Id: <1283027520-26460-4-git-send-email-dazo@...384...>
In-Reply-To: <1283027520-26460-1-git-send-email-dazo@...384...>
References: <1283027520-26460-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 3/3] Clean-up: Removing useless code - hash
	related functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

Removed even more function which where practically empty and took away
some function arguments which were not used.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 list.c  |   11 ++++-------
 list.h  |   25 ++++---------------------
 mtcp.c  |    3 ---
 mudp.c  |    3 ---
 multi.c |   25 +++++++++++--------------
 pf.c    |    2 +-
 6 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/list.c b/list.c
index 32c2adf..fb93d0a 100644
--- a/list.c
+++ b/list.c
@@ -165,12 +165,12 @@ hash_add (struct hash *hash, const void *key, void *value, bool replace)
 }
 
 void
-hash_remove_by_value (struct hash *hash, void *value, bool autolock)
+hash_remove_by_value (struct hash *hash, void *value)
 {
   struct hash_iterator hi;
   struct hash_element *he;
 
-  hash_iterator_init (hash, &hi, autolock);
+  hash_iterator_init (hash, &hi);
   while ((he = hash_iterator_next (&hi)))
     {
       if (he->value == value)
@@ -221,7 +221,6 @@ void_ptr_compare_function (const void *key1, const void *key2)
 void
 hash_iterator_init_range (struct hash *hash,
 		       struct hash_iterator *hi,
-		       bool autolock,
 		       int start_bucket,
 		       int end_bucket)
 {
@@ -233,7 +232,6 @@ hash_iterator_init_range (struct hash *hash,
   hi->hash = hash;
   hi->elem = NULL;
   hi->bucket = NULL;
-  hi->autolock = autolock;
   hi->last = NULL;
   hi->bucket_marked = false;
   hi->bucket_index_start = start_bucket;
@@ -243,10 +241,9 @@ hash_iterator_init_range (struct hash *hash,
 
 void
 hash_iterator_init (struct hash *hash,
-		    struct hash_iterator *hi,
-		    bool autolock)
+		    struct hash_iterator *hi)
 {
-  hash_iterator_init_range (hash, hi, autolock, 0, hash->n_buckets);
+  hash_iterator_init_range (hash, hi, 0, hash->n_buckets);
 }
 
 static inline void
diff --git a/list.h b/list.h
index 5cf9127..adde36b 100644
--- a/list.h
+++ b/list.h
@@ -88,7 +88,7 @@ bool hash_remove_fast (struct hash *hash,
 		       const void *key,
 		       uint32_t hv);
 
-void hash_remove_by_value (struct hash *hash, void *value, bool autolock);
+void hash_remove_by_value (struct hash *hash, void *value);
 
 struct hash_iterator
 {
@@ -98,18 +98,16 @@ struct hash_iterator
   struct hash_element *elem;
   struct hash_element *last;
   bool bucket_marked;
-  bool autolock;
   int bucket_index_start;
   int bucket_index_end;
 };
 
 void hash_iterator_init_range (struct hash *hash,
 			       struct hash_iterator *hi,
-			       bool autolock,
 			       int start_bucket,
 			       int end_bucket);
 
-void hash_iterator_init (struct hash *hash, struct hash_iterator *iter, bool autolock);
+void hash_iterator_init (struct hash *hash, struct hash_iterator *iter);
 struct hash_element *hash_iterator_next (struct hash_iterator *hi);
 void hash_iterator_delete_element (struct hash_iterator *hi);
 void hash_iterator_free (struct hash_iterator *hi);
@@ -147,21 +145,12 @@ hash_bucket (struct hash *hash, uint32_t hv)
   return &hash->buckets[hv & hash->mask];
 }
 
-static inline void
-hash_bucket_lock (struct hash_bucket *bucket)
-{
-}
-
-static inline void
-hash_bucket_unlock (struct hash_bucket *bucket)
-{
-}
-
 static inline void *
-hash_lookup_lock (struct hash *hash, const void *key, uint32_t hv)
+hash_lookup (struct hash *hash, const void *key)
 {
   void *ret = NULL;
   struct hash_element *he;
+  uint32_t hv = hash_value (hash, key);
   struct hash_bucket *bucket = &hash->buckets[hv & hash->mask];
 
   he = hash_lookup_fast (hash, bucket, key, hv);
@@ -171,12 +160,6 @@ hash_lookup_lock (struct hash *hash, const void *key, uint32_t hv)
   return ret;
 }
 
-static inline void *
-hash_lookup (struct hash *hash, const void *key)
-{
-  return hash_lookup_lock (hash, key, hash_value (hash, key));
-}
-
 /* NOTE: assumes that key is not a duplicate */
 static inline void
 hash_add_fast (struct hash *hash,
diff --git a/mtcp.c b/mtcp.c
index 6edafbd..314aa44 100644
--- a/mtcp.c
+++ b/mtcp.c
@@ -112,7 +112,6 @@ multi_create_instance_tcp (struct multi_context *m)
       const uint32_t hv = hash_value (hash, &mi->real);
       struct hash_bucket *bucket = hash_bucket (hash, hv);
   
-      hash_bucket_lock (bucket);
       he = hash_lookup_fast (hash, bucket, &mi->real, hv);
 
       if (he)
@@ -128,8 +127,6 @@ multi_create_instance_tcp (struct multi_context *m)
 	hash_add_fast (hash, bucket, &mi->real, hv, mi);
 
       mi->did_real_hash = true;
-
-      hash_bucket_unlock (bucket);
     }
 
 #ifdef ENABLE_DEBUG
diff --git a/mudp.c b/mudp.c
index bf4ca3d..a478b29 100644
--- a/mudp.c
+++ b/mudp.c
@@ -51,7 +51,6 @@ multi_get_create_instance_udp (struct multi_context *m)
       const uint32_t hv = hash_value (hash, &real);
       struct hash_bucket *bucket = hash_bucket (hash, hv);
   
-      hash_bucket_lock (bucket);
       he = hash_lookup_fast (hash, bucket, &real, hv);
 
       if (he)
@@ -81,8 +80,6 @@ multi_get_create_instance_udp (struct multi_context *m)
 	    }
 	}
 
-      hash_bucket_unlock (bucket);
-
 #ifdef ENABLE_DEBUG
       if (check_debug_level (D_MULTI_DEBUG))
 	{
diff --git a/multi.c b/multi.c
index 13714f8..f61c5fb 100644
--- a/multi.c
+++ b/multi.c
@@ -146,7 +146,7 @@ multi_reap_range (const struct multi_context *m,
     }
 
   dmsg (D_MULTI_DEBUG, "MULTI: REAP range %d -> %d", start_bucket, end_bucket);
-  hash_iterator_init_range (m->vhash, &hi, true, start_bucket, end_bucket);
+  hash_iterator_init_range (m->vhash, &hi, start_bucket, end_bucket);
   while ((he = hash_iterator_next (&hi)) != NULL)
     {
       struct multi_route *r = (struct multi_route *) he->value;
@@ -587,7 +587,7 @@ multi_uninit (struct multi_context *m)
 	  struct hash_iterator hi;
 	  struct hash_element *he;
 
-	  hash_iterator_init (m->iter, &hi, true);
+	  hash_iterator_init (m->iter, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct multi_instance *mi = (struct multi_instance *) he->value;
@@ -723,7 +723,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 	  status_printf (so, "OpenVPN CLIENT LIST");
 	  status_printf (so, "Updated,%s", time_string (0, 0, false, &gc_top));
 	  status_printf (so, "Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since");
-	  hash_iterator_init (m->hash, &hi, true);
+	  hash_iterator_init (m->hash, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct gc_arena gc = gc_new ();
@@ -744,7 +744,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 
 	  status_printf (so, "ROUTING TABLE");
 	  status_printf (so, "Virtual Address,Common Name,Real Address,Last Ref");
-	  hash_iterator_init (m->vhash, &hi, true);
+	  hash_iterator_init (m->vhash, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct gc_arena gc = gc_new ();
@@ -787,7 +787,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 	  status_printf (so, "TIME%c%s%c%u", sep, time_string (now, 0, false, &gc_top), sep, (unsigned int)now);
 	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)",
 			 sep, sep, sep, sep, sep, sep, sep, sep);
-	  hash_iterator_init (m->hash, &hi, true);
+	  hash_iterator_init (m->hash, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct gc_arena gc = gc_new ();
@@ -810,7 +810,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 
 	  status_printf (so, "HEADER%cROUTING_TABLE%cVirtual Address%cCommon Name%cReal Address%cLast Ref%cLast Ref (time_t)",
 			 sep, sep, sep, sep, sep, sep);
-	  hash_iterator_init (m->vhash, &hi, true);
+	  hash_iterator_init (m->vhash, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct gc_arena gc = gc_new ();
@@ -849,7 +849,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 #ifdef PACKET_TRUNCATION_CHECK
       {
 	status_printf (so, "HEADER,ERRORS,Common Name,TUN Read Trunc,TUN Write Trunc,Pre-encrypt Trunc,Post-decrypt Trunc");
-	hash_iterator_init (m->hash, &hi, true);
+	hash_iterator_init (m->hash, &hi);
 	while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct gc_arena gc = gc_new ();
@@ -895,8 +895,6 @@ multi_learn_addr (struct multi_context *m,
   struct multi_route *oldroute = NULL;
   struct multi_instance *owner = NULL;
 
-  hash_bucket_lock (bucket);
-
   /* if route currently exists, get the instance which owns it */
   he = hash_lookup_fast (m->vhash, bucket, addr, hv);
   if (he)
@@ -966,7 +964,6 @@ multi_learn_addr (struct multi_context *m,
       gc_free (&gc);
     }
 
-  hash_bucket_unlock (bucket);
   return owner;
 }
 
@@ -1130,7 +1127,7 @@ multi_delete_dup (struct multi_context *m, struct multi_instance *new_mi)
 	  struct hash_element *he;
 	  int count = 0;
 
-	  hash_iterator_init (m->iter, &hi, true);
+	  hash_iterator_init (m->iter, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct multi_instance *mi = (struct multi_instance *) he->value;
@@ -1776,7 +1773,7 @@ multi_bcast (struct multi_context *m,
       printf ("BCAST len=%d\n", BLEN (buf));
 #endif
       mb = mbuf_alloc_buf (buf);
-      hash_iterator_init (m->iter, &hi, true);
+      hash_iterator_init (m->iter, &hi);
 
       while ((he = hash_iterator_next (&hi)))
 	{
@@ -2470,7 +2467,7 @@ management_callback_kill_by_cn (void *arg, const char *del_cn)
   struct hash_element *he;
   int count = 0;
 
-  hash_iterator_init (m->iter, &hi, true);
+  hash_iterator_init (m->iter, &hi);
   while ((he = hash_iterator_next (&hi)))
     {
       struct multi_instance *mi = (struct multi_instance *) he->value;
@@ -2504,7 +2501,7 @@ management_callback_kill_by_addr (void *arg, const in_addr_t addr, const int por
   saddr.sa.sin_port = htons (port);
   if (mroute_extract_openvpn_sockaddr (&maddr, &saddr, true))
     {
-      hash_iterator_init (m->iter, &hi, true);
+      hash_iterator_init (m->iter, &hi);
       while ((he = hash_iterator_next (&hi)))
 	{
 	  struct multi_instance *mi = (struct multi_instance *) he->value;
diff --git a/pf.c b/pf.c
index aed836e..6b4cba4 100644
--- a/pf.c
+++ b/pf.c
@@ -644,7 +644,7 @@ pf_cn_set_print (const struct pf_cn_set *s, const int lev)
 
       if (s->hash_table)
 	{
-	  hash_iterator_init (s->hash_table, &hi, false);
+	  hash_iterator_init (s->hash_table, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
 	      struct pf_cn *e = (struct pf_cn *)he->value;
-- 
1.7.2.2


