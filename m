From: Arne Schwabe <arne@...1227...>
Date: Sun, 19 Jul 2020 19:34:34 +0200
Message-Id: <20200719173436.16431-3-arne@...1227...>
In-Reply-To: <20200719173436.16431-1-arne@...1227...>
References: <20200719173436.16431-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v8 3/5] client-connect: Use inotify for the
 deferred client-connect status file
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

As we never do client-connect and authentication at the same time
it is safe to reuse the existing fields for client-connect return
status file

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 165a3209..3b73ffde 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2601,8 +2601,10 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
 #ifdef ENABLE_ASYNC_PUSH
 /*
- * Called when inotify event is fired, which happens when acf file is closed or deleted.
- * Continues authentication and sends push_reply.
+ * Called when inotify event is fired, which happens when acf
+ * or connect-status file is closed or deleted.
+ * Continues authentication and sends push_reply
+ * (or be deferred again by client-connect)
  */
 void
 multi_process_file_closed(struct multi_context *m, const unsigned int mpp_flags)
@@ -2888,7 +2890,15 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
             {
                 multi_connection_established(m, mi);
             }
-
+#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+            if (is_cas_pending(mi->context.c2.context_auth)
+                && mi->client_connect_defer_state.deferred_ret_file)
+            {
+                add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,
+                                       mi->client_connect_defer_state.
+                                       deferred_ret_file);
+            }
+#endif
             /* tell scheduler to wake us up at some point in the future */
             multi_schedule_context_wakeup(m, mi);
         }
-- 
2.26.2


