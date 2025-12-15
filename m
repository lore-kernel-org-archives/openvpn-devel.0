From: Gert Doering <gert@...1296...>
Date: Mon, 15 Dec 2025 15:55:23 +0100
Message-ID: <20251215145528.18047-1-gert@...1296...>
In-Reply-To: <gerrit.1761570487000.Idede28c850def5e3b4a17dcbd0a5771f15cfc668@...2715...>
References: <gerrit.1761570487000.Idede28c850def5e3b4a17dcbd0a5771f15cfc668@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] multi: Fix type handling for hashes,
 mostly inotify_watchers
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

Change-Id: Idede28c850def5e3b4a17dcbd0a5771f15cfc668
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1312
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1312
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d9cb3a9..20d72c1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -257,7 +257,7 @@
  */
 int_hash_function(const void *key, uint32_t iv)
 {
-    return (unsigned long)key;
+    return (uint32_t)(uintptr_t)key;
 }
 
 static bool
@@ -295,22 +295,23 @@
      * to determine which client sent an incoming packet
      * which is seen on the TCP/UDP socket.
      */
-    m->hash = hash_init(t->options.real_hash_size, get_random(), mroute_addr_hash_function,
-                        mroute_addr_compare_function);
+    m->hash = hash_init(t->options.real_hash_size, (uint32_t)get_random(),
+                        mroute_addr_hash_function, mroute_addr_compare_function);
 
     /*
      * Virtual address hash table.  Used to determine
      * which client to route a packet to.
      */
-    m->vhash = hash_init(t->options.virtual_hash_size, get_random(), mroute_addr_hash_function,
-                         mroute_addr_compare_function);
+    m->vhash = hash_init(t->options.virtual_hash_size, (uint32_t)get_random(),
+                         mroute_addr_hash_function, mroute_addr_compare_function);
 
     /*
      * This hash table is a clone of m->hash but with a
      * bucket size of one so that it can be used
      * for fast iteration through the list.
      */
-    m->iter = hash_init(1, get_random(), mroute_addr_hash_function, mroute_addr_compare_function);
+    m->iter = hash_init(1, (uint32_t)get_random(), mroute_addr_hash_function,
+                        mroute_addr_compare_function);
 
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash = hash_init(t->options.real_hash_size, 0, cid_hash_function, cid_compare_function);
@@ -321,8 +322,8 @@
      * Mapping between inotify watch descriptors and
      * multi_instances.
      */
-    m->inotify_watchers =
-        hash_init(t->options.real_hash_size, get_random(), int_hash_function, int_compare_function);
+    m->inotify_watchers = hash_init(t->options.real_hash_size, (uint32_t)get_random(),
+                                    int_hash_function, int_compare_function);
 #endif
 
     /*
@@ -609,7 +610,7 @@
 #ifdef ENABLE_ASYNC_PUSH
         if (mi->inotify_watch != -1)
         {
-            hash_remove(m->inotify_watchers, (void *)(unsigned long)mi->inotify_watch);
+            hash_remove(m->inotify_watchers, (void *)(uintptr_t)mi->inotify_watch);
             mi->inotify_watch = -1;
         }
 #endif
@@ -2821,7 +2822,7 @@
         msg(D_MULTI_DEBUG, "MULTI: modified fd %d, mask %d", pevent->wd, pevent->mask);
 
         struct multi_instance *mi =
-            hash_lookup(m->inotify_watchers, (void *)(unsigned long)pevent->wd);
+            hash_lookup(m->inotify_watchers, (void *)(uintptr_t)pevent->wd);
 
         if (pevent->mask & IN_CLOSE_WRITE)
         {
@@ -2840,7 +2841,7 @@
             /* this event is _always_ fired when watch is removed or file is deleted */
             if (mi)
             {
-                hash_remove(m->inotify_watchers, (void *)(unsigned long)pevent->wd);
+                hash_remove(m->inotify_watchers, (void *)(uintptr_t)pevent->wd);
                 mi->inotify_watch = -1;
             }
         }
@@ -2978,14 +2979,14 @@
                        const char *file)
 {
     /* watch acf file */
-    long watch_descriptor = inotify_add_watch(inotify_fd, file, IN_CLOSE_WRITE | IN_ONESHOT);
+    int watch_descriptor = inotify_add_watch(inotify_fd, file, IN_CLOSE_WRITE | IN_ONESHOT);
     if (watch_descriptor >= 0)
     {
         if (mi->inotify_watch != -1)
         {
-            hash_remove(m->inotify_watchers, (void *)(unsigned long)mi->inotify_watch);
+            hash_remove(m->inotify_watchers, (void *)(uintptr_t)mi->inotify_watch);
         }
-        hash_add(m->inotify_watchers, (const uintptr_t *)watch_descriptor, mi, true);
+        hash_add(m->inotify_watchers, (void *)(uintptr_t)watch_descriptor, mi, true);
         mi->inotify_watch = watch_descriptor;
     }
     else

