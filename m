From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Nov 2018 11:10:16 +0100
Message-Id: <20181121101019.1801-11-arne@...1227...>
In-Reply-To: <20181121101019.1801-1-arne@...1227...>
References: <20181121101019.1801-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v4 10/13] client-connect: Also use inotify
 for the deferred client-connect status file
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
index 63d9db05..09974357 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2505,8 +2505,10 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
 
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
@@ -2782,7 +2784,15 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
             {
                 multi_connection_established(m, mi);
             }
-
+#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+            if (mi->client_connect_status != CC_STATUS_ESTABLISHED
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
2.19.1


