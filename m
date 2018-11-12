From: Arne Schwabe <arne@...1227...>
Date: Mon, 12 Nov 2018 12:56:23 +0100
Message-Id: <20181112115627.5096-10-arne@...1227...>
In-Reply-To: <20181112115627.5096-1-arne@...1227...>
References: <20181112115627.5096-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 09/13] client-connect: Move adding
 inotify watch into its own function
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

This make the code a bit better readable and also prepares resuing
the function for client-connect return files

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 46 +++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c8546238..dafc86d7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2696,6 +2696,32 @@ multi_schedule_context_wakeup(struct multi_context *m, struct multi_instance *mi
                        compute_wakeup_sigma(&mi->context.c2.timeval));
 }
 
+#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+static void
+add_inotify_file_watch(struct multi_context *m, struct multi_instance *mi,
+                       int inotify_fd, const char* file)
+{
+    /* watch acf file */
+    long watch_descriptor = inotify_add_watch(inotify_fd, file,
+                                              IN_CLOSE_WRITE | IN_ONESHOT);
+    if (watch_descriptor >= 0)
+    {
+        if (mi->inotify_watch != -1)
+        {
+            hash_remove(m->inotify_watchers,
+                        (void *) (unsigned long)mi->inotify_watch);
+        }
+        hash_add(m->inotify_watchers, (const uintptr_t *)watch_descriptor,
+                 mi, true);
+        mi->inotify_watch = watch_descriptor;
+    }
+    else
+    {
+        msg(M_NONFATAL | M_ERRNO, "MULTI: inotify_add_watch error");
+    }
+}
+#endif
+
 /*
  * Figure instance-specific timers, convert
  * earliest to absolute time in mi->wakeup,
@@ -2725,23 +2751,11 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
         pre_select(&mi->context);
 
 #if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
-        if (ks && ks->auth_control_file && ks->auth_deferred && !was_authenticated)
+        if (ks && ks->auth_control_file &&
+            ks->auth_deferred && !was_authenticated)
         {
-            /* watch acf file */
-            long watch_descriptor = inotify_add_watch(m->top.c2.inotify_fd, ks->auth_control_file, IN_CLOSE_WRITE | IN_ONESHOT);
-            if (watch_descriptor >= 0)
-            {
-                if (mi->inotify_watch != -1)
-                {
-                    hash_remove(m->inotify_watchers, (void *) (unsigned long)mi->inotify_watch);
-                }
-                hash_add(m->inotify_watchers, (const uintptr_t *)watch_descriptor, mi, true);
-                mi->inotify_watch = watch_descriptor;
-            }
-            else
-            {
-                msg(M_NONFATAL | M_ERRNO, "MULTI: inotify_add_watch error");
-            }
+            add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,
+                                   ks->auth_control_file);
         }
 #endif
 
-- 
2.19.1


