From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:33 +0200
Message-Id: <20210401131337.3684-11-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 10/14] Remove thread_mode field of
 multi_context
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

This is leftover of a never functional multi threaded openvpn
implementation attempt. It serves no purposes anymore.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtcp.c  |  2 +-
 src/openvpn/mudp.c  |  2 +-
 src/openvpn/multi.c | 67 +++++++++++++++++++--------------------------
 src/openvpn/multi.h | 10 +------
 4 files changed, 31 insertions(+), 50 deletions(-)

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 7d2a69b99..babed29ef 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -789,7 +789,7 @@ tunnel_server_tcp(struct context *top)
     }
 
     /* initialize global multi_context object */
-    multi_init(&multi, top, true, MC_SINGLE_THREADED);
+    multi_init(&multi, top, true);
 
     /* initialize our cloned top object */
     multi_top_init(&multi, top);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 7977ece5d..90e32a8ec 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -300,7 +300,7 @@ tunnel_server_udp(struct context *top)
     }
 
     /* initialize global multi_context object */
-    multi_init(&multi, top, false, MC_SINGLE_THREADED);
+    multi_init(&multi, top, false);
 
     /* initialize our cloned top object */
     multi_top_init(&multi, top);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f7e0f6805..9b4a3383f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -290,7 +290,7 @@ int_compare_function(const void *key1, const void *key2)
  * Main initialization function, init multi_context object.
  */
 void
-multi_init(struct multi_context *m, struct context *t, bool tcp_mode, int thread_mode)
+multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
 {
     int dev = DEV_TYPE_UNDEF;
 
@@ -308,8 +308,6 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode, int thread
      */
     CLEAR(*m);
 
-    m->thread_mode = thread_mode;
-
     /*
      * Real address hash table (source port number is
      * considered to be part of the address).  Used
@@ -703,53 +701,44 @@ multi_close_instance(struct multi_context *m,
 void
 multi_uninit(struct multi_context *m)
 {
-    if (m->thread_mode & MC_WORK_THREAD)
-    {
-        multi_top_free(m);
-        m->thread_mode = MC_UNDEF;
-    }
-    else if (m->thread_mode)
+    if (m->hash)
     {
-        if (m->hash)
-        {
-            struct hash_iterator hi;
-            struct hash_element *he;
+        struct hash_iterator hi;
+        struct hash_element *he;
 
-            hash_iterator_init(m->iter, &hi);
-            while ((he = hash_iterator_next(&hi)))
-            {
-                struct multi_instance *mi = (struct multi_instance *) he->value;
-                mi->did_iter = false;
-                multi_close_instance(m, mi, true);
-            }
-            hash_iterator_free(&hi);
+        hash_iterator_init(m->iter, &hi);
+        while ((he = hash_iterator_next(&hi)))
+        {
+            struct multi_instance *mi = (struct multi_instance *) he->value;
+            mi->did_iter = false;
+            multi_close_instance(m, mi, true);
+        }
+        hash_iterator_free(&hi);
 
-            multi_reap_all(m);
+        multi_reap_all(m);
 
-            hash_free(m->hash);
-            hash_free(m->vhash);
-            hash_free(m->iter);
+        hash_free(m->hash);
+        hash_free(m->vhash);
+        hash_free(m->iter);
 #ifdef ENABLE_MANAGEMENT
-            hash_free(m->cid_hash);
+        hash_free(m->cid_hash);
 #endif
-            m->hash = NULL;
+        m->hash = NULL;
 
-            free(m->instances);
+        free(m->instances);
 
 #ifdef ENABLE_ASYNC_PUSH
-            hash_free(m->inotify_watchers);
-            m->inotify_watchers = NULL;
+        hash_free(m->inotify_watchers);
+        m->inotify_watchers = NULL;
 #endif
 
-            schedule_free(m->schedule);
-            mbuf_free(m->mbuf);
-            ifconfig_pool_free(m->ifconfig_pool);
-            frequency_limit_free(m->new_connection_limiter);
-            multi_reap_free(m->reaper);
-            mroute_helper_free(m->route_helper);
-            multi_tcp_free(m->mtcp);
-            m->thread_mode = MC_UNDEF;
-        }
+        schedule_free(m->schedule);
+        mbuf_free(m->mbuf);
+        ifconfig_pool_free(m->ifconfig_pool);
+        frequency_limit_free(m->new_connection_limiter);
+        multi_reap_free(m->reaper);
+        mroute_helper_free(m->route_helper);
+        multi_tcp_free(m->mtcp);
     }
 }
 
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7669508c3..b7078b711 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -150,14 +150,6 @@ struct multi_instance {
  * server-mode.
  */
 struct multi_context {
-#define MC_UNDEF                      0
-#define MC_SINGLE_THREADED            (1<<0)
-#define MC_MULTI_THREADED_MASTER      (1<<1)
-#define MC_MULTI_THREADED_WORKER      (1<<2)
-#define MC_MULTI_THREADED_SCHEDULER   (1<<3)
-#define MC_WORK_THREAD                (MC_MULTI_THREADED_WORKER|MC_MULTI_THREADED_SCHEDULER)
-    int thread_mode;
-
     struct multi_instance **instances;  /**< Array of multi_instances. An instance can be
                                          * accessed using peer-id as an index. */
 
@@ -261,7 +253,7 @@ const char *multi_instance_string(const struct multi_instance *mi, bool null, st
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */
 
-void multi_init(struct multi_context *m, struct context *t, bool tcp_mode, int thread_mode);
+void multi_init(struct multi_context *m, struct context *t, bool tcp_mode);
 
 void multi_uninit(struct multi_context *m);
 
-- 
2.30.1


