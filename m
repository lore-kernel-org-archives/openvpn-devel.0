From: David Sommerseth <dazo@...384...>
Date: Sat, 28 Aug 2010 22:31:59 +0200
Message-Id: <1283027520-26460-3-git-send-email-dazo@...384...>
In-Reply-To: <1283027520-26460-1-git-send-email-dazo@...384...>
References: <1283027520-26460-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 2/3] Clean-up: Remove more dead and inactive
	code paths
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

These code paths was practically not needed with no locking mechanisms
enabled and was just bloating the source code.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 buffer.c  |    4 ----
 forward.c |   10 ----------
 mbuf.c    |    4 ++--
 mbuf.h    |    2 +-
 mroute.c  |    6 ------
 mroute.h  |   13 -------------
 mtcp.c    |    2 +-
 multi.c   |    6 +-----
 openvpn.h |    3 ---
 ssl.c     |    4 ----
 ssl.h     |    3 ---
 11 files changed, 5 insertions(+), 52 deletions(-)

diff --git a/buffer.c b/buffer.c
index 52ae1e1..a4e7a56 100644
--- a/buffer.c
+++ b/buffer.c
@@ -298,10 +298,8 @@ gc_malloc (size_t size, bool clear, struct gc_arena *a)
 #endif
       check_malloc_return (e);
       ret = (char *) e + sizeof (struct gc_entry);
-      /*mutex_lock_static (L_GC_MALLOC);*/
       e->next = a->list;
       a->list = e;
-      /*mutex_unlock_static (L_GC_MALLOC);*/
     }
   else
     {
@@ -323,10 +321,8 @@ void
 x_gc_free (struct gc_arena *a)
 {
   struct gc_entry *e;
-  /*mutex_lock_static (L_GC_MALLOC);*/
   e = a->list;
   a->list = NULL;
-  /*mutex_unlock_static (L_GC_MALLOC);*/
   
   while (e != NULL)
     {
diff --git a/forward.c b/forward.c
index 6e3c5f7..87d05cc 100644
--- a/forward.c
+++ b/forward.c
@@ -454,7 +454,6 @@ encrypt_sign (struct context *c, bool comp_frag)
    */
   if (c->c2.tls_multi)
     {
-      /*tls_mutex_lock (c->c2.tls_multi);*/
       tls_pre_encrypt (c->c2.tls_multi, &c->c2.buf, &c->c2.crypto_options);
     }
 #endif
@@ -482,7 +481,6 @@ encrypt_sign (struct context *c, bool comp_frag)
   if (c->c2.tls_multi)
     {
       tls_post_encrypt (c->c2.tls_multi, &c->c2.buf);
-      /*tls_mutex_unlock (c->c2.tls_multi);*/
     }
 #endif
 #endif
@@ -801,7 +799,6 @@ process_incoming_link (struct context *c)
 	   * will load crypto_options with the correct encryption key
 	   * and return false.
 	   */
-	  /*tls_mutex_lock (c->c2.tls_multi);*/
 	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &c->c2.crypto_options))
 	    {
 	      interval_action (&c->c2.tmp_int);
@@ -824,13 +821,6 @@ process_incoming_link (struct context *c)
       /* authenticate and decrypt the incoming packet */
       decrypt_status = openvpn_decrypt (&c->c2.buf, c->c2.buffers->decrypt_buf, &c->c2.crypto_options, &c->c2.frame);
 
-#ifdef USE_SSL
-      if (c->c2.tls_multi)
-	{
-	  /*tls_mutex_unlock (c->c2.tls_multi);*/
-	}
-#endif
-      
       if (!decrypt_status && link_socket_connection_oriented (c->c2.link_socket))
 	{
 	  /* decryption errors are fatal in TCP mode */
diff --git a/mbuf.c b/mbuf.c
index 1d8f602..0f36d3c 100644
--- a/mbuf.c
+++ b/mbuf.c
@@ -90,7 +90,7 @@ mbuf_add_item (struct mbuf_set *ms, const struct mbuf_item *item)
   if (ms->len == ms->capacity)
     {
       struct mbuf_item rm;
-      ASSERT (mbuf_extract_item (ms, &rm, false));
+      ASSERT (mbuf_extract_item (ms, &rm));
       mbuf_free_buf (rm.buffer);
       msg (D_MULTI_DROPPED, "MBUF: mbuf packet dropped");
     }
@@ -104,7 +104,7 @@ mbuf_add_item (struct mbuf_set *ms, const struct mbuf_item *item)
 }
 
 bool
-mbuf_extract_item (struct mbuf_set *ms, struct mbuf_item *item, const bool lock)
+mbuf_extract_item (struct mbuf_set *ms, struct mbuf_item *item)
 {
   bool ret = false;
   if (ms)
diff --git a/mbuf.h b/mbuf.h
index bbcd69a..a0de679 100644
--- a/mbuf.h
+++ b/mbuf.h
@@ -73,7 +73,7 @@ void mbuf_free_buf (struct mbuf_buffer *mb);
 
 void mbuf_add_item (struct mbuf_set *ms, const struct mbuf_item *item);
 
-bool mbuf_extract_item (struct mbuf_set *ms, struct mbuf_item *item, const bool lock);
+bool mbuf_extract_item (struct mbuf_set *ms, struct mbuf_item *item);
 
 void mbuf_dereference_instance (struct mbuf_set *ms, struct multi_instance *mi);
 
diff --git a/mroute.c b/mroute.c
index ad76977..3debd80 100644
--- a/mroute.c
+++ b/mroute.c
@@ -360,7 +360,6 @@ mroute_helper_init (int ageable_ttl_secs)
 {
   struct mroute_helper *mh;
   ALLOC_OBJ_CLEAR (mh, struct mroute_helper);
-  /*mutex_init (&mh->mutex);*/
   mh->ageable_ttl_secs = ageable_ttl_secs;
   return mh;
 }
@@ -398,12 +397,10 @@ mroute_helper_add_iroute (struct mroute_helper *mh, const struct iroute *ir)
   if (ir->netbits >= 0)
     {
       ASSERT (ir->netbits < MR_HELPER_NET_LEN);
-      mroute_helper_lock (mh);
       ++mh->cache_generation;
       ++mh->net_len_refcount[ir->netbits];
       if (mh->net_len_refcount[ir->netbits] == 1)
 	mroute_helper_regenerate (mh);
-      mroute_helper_unlock (mh);
     }
 }
 
@@ -413,20 +410,17 @@ mroute_helper_del_iroute (struct mroute_helper *mh, const struct iroute *ir)
   if (ir->netbits >= 0)
     {
       ASSERT (ir->netbits < MR_HELPER_NET_LEN);
-      mroute_helper_lock (mh);
       ++mh->cache_generation;
       --mh->net_len_refcount[ir->netbits];
       ASSERT (mh->net_len_refcount[ir->netbits] >= 0);
       if (!mh->net_len_refcount[ir->netbits])
 	mroute_helper_regenerate (mh);
-      mroute_helper_unlock (mh);
     }
 }
 
 void
 mroute_helper_free (struct mroute_helper *mh)
 {
-  /*mutex_destroy (&mh->mutex);*/
   free (mh);
 }
 
diff --git a/mroute.h b/mroute.h
index b3e3a1f..7265001 100644
--- a/mroute.h
+++ b/mroute.h
@@ -91,7 +91,6 @@ struct mroute_addr {
  * Used to help maintain CIDR routing table.
  */
 struct mroute_helper {
-  /*MUTEX_DEFINE (mutex);*/
   unsigned int cache_generation; /* incremented when route added */
   int ageable_ttl_secs;          /* host route cache entry time-to-live*/
   int n_net_len;                 /* length of net_len array */
@@ -159,18 +158,6 @@ mroute_extract_addr_from_packet (struct mroute_addr *src,
   return ret;
 }
 
-static inline void
-mroute_helper_lock (struct mroute_helper *mh)
-{
-  /*mutex_lock (&mh->mutex);*/
-}
-
-static inline void
-mroute_helper_unlock (struct mroute_helper *mh)
-{
-  /*mutex_unlock (&mh->mutex);*/
-}
-
 static inline bool
 mroute_addr_equal (const struct mroute_addr *a1, const struct mroute_addr *a2)
 {
diff --git a/mtcp.c b/mtcp.c
index 3eca81a..6edafbd 100644
--- a/mtcp.c
+++ b/mtcp.c
@@ -264,7 +264,7 @@ multi_tcp_process_outgoing_link_ready (struct multi_context *m, struct multi_ins
   ASSERT (mi);
 
   /* extract from queue */
-  if (mbuf_extract_item (mi->tcp_link_out_deferred, &item, true)) /* ciphertext IP packet */
+  if (mbuf_extract_item (mi->tcp_link_out_deferred, &item)) /* ciphertext IP packet */
     {
       dmsg (D_MULTI_TCP, "MULTI TCP: transmitting previously deferred packet");
 
diff --git a/multi.c b/multi.c
index 6b85eeb..13714f8 100644
--- a/multi.c
+++ b/multi.c
@@ -1000,8 +1000,6 @@ multi_get_instance_by_virtual_addr (struct multi_context *m,
       struct mroute_addr tryaddr;
       int i;
 
-      mroute_helper_lock (rh);
-
       /* cycle through each CIDR length */
       for (i = 0; i < rh->n_net_len; ++i)
 	{
@@ -1022,8 +1020,6 @@ multi_get_instance_by_virtual_addr (struct multi_context *m,
 	      break;
 	    }
 	}
-      
-      mroute_helper_unlock (rh);
     }
   
 #ifdef ENABLE_DEBUG
@@ -2248,7 +2244,7 @@ multi_get_queue (struct mbuf_set *ms)
 {
   struct mbuf_item item;
 
-  if (mbuf_extract_item (ms, &item, true)) /* cleartext IP packet */
+  if (mbuf_extract_item (ms, &item)) /* cleartext IP packet */
     {
       unsigned int pipv4_flags = PIPV4_PASSTOS;
 
diff --git a/openvpn.h b/openvpn.h
index 0757eb1..641bf93 100644
--- a/openvpn.h
+++ b/openvpn.h
@@ -460,9 +460,6 @@ struct context
   /* true on initial VPN iteration */
   bool first_time;
 
-  /* used by multi-client code to lock the context */
-  /*MUTEX_DEFINE (mutex);*/
-
   /* context modes */
 # define CM_P2P            0 /* standalone point-to-point session or client */
 # define CM_TOP            1 /* top level of a multi-client or point-to-multipoint server */
diff --git a/ssl.c b/ssl.c
index 030fee9..7270081 100644
--- a/ssl.c
+++ b/ssl.c
@@ -3907,8 +3907,6 @@ tls_process (struct tls_multi *multi,
 	msg (D_TLS_DEBUG_LOW, "TLS: tls_process: killed expiring key");
   }
 
-  /*mutex_cycle (multi->mutex);*/
-
   do
     {
       update_time ();
@@ -4192,7 +4190,6 @@ tls_process (struct tls_multi *multi,
 		}
 	    }
 	}
-      /*mutex_cycle (multi->mutex);*/
     }
   while (state_change);
 
@@ -4346,7 +4343,6 @@ tls_multi_process (struct tls_multi *multi,
 		reset_session (multi, session);
 	    }
 	}
-      /*mutex_cycle (multi->mutex);*/
     }
 
   update_time ();
diff --git a/ssl.h b/ssl.h
index 3890f0b..f729a60 100644
--- a/ssl.h
+++ b/ssl.h
@@ -572,9 +572,6 @@ struct tls_session
  */
 struct tls_multi
 {
-  /* used to coordinate access between main thread and TLS thread */
-  /*MUTEX_PTR_DEFINE (mutex);*/
-
   /* const options and config info */
   struct tls_options opt;
 
-- 
1.7.2.2


