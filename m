From: Steffan Karger <steffan@...1856...>
Date: Wed,  8 Jun 2016 14:20:40 +0200
Message-Id: <1465388443-15484-3-git-send-email-steffan@...1856...>
In-Reply-To: <1465388443-15484-1-git-send-email-steffan@...1856...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/5] cleanup: remove alloc_buffers argument
	from multi_top_init()
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

multi_top_init() is always called with alloc_buffers=true, so just remove
the argument and alloc unconditionally.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/mtcp.c  | 2 +-
 src/openvpn/mudp.c  | 2 +-
 src/openvpn/multi.c | 6 ++----
 src/openvpn/multi.h | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 9926d47..78e5ccd 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -696,7 +696,7 @@ tunnel_server_tcp (struct context *top)
   multi_init (&multi, top, true, MC_SINGLE_THREADED);
 
   /* initialize our cloned top object */
-  multi_top_init (&multi, top, true);
+  multi_top_init (&multi, top);
 
   /* initialize management interface */
   init_management_callback_multi (&multi);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index ce67206..6e0568e 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -283,7 +283,7 @@ tunnel_server_udp_single_threaded (struct context *top)
   multi_init (&multi, top, false, MC_SINGLE_THREADED);
 
   /* initialize our cloned top object */
-  multi_top_init (&multi, top, true);
+  multi_top_init (&multi, top);
 
   /* initialize management interface */
   init_management_callback_multi (&multi);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4c43fcc..ba7f2c0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2859,12 +2859,10 @@ multi_process_per_second_timers_dowork (struct multi_context *m)
 }
 
 void
-multi_top_init (struct multi_context *m, const struct context *top, const bool alloc_buffers)
+multi_top_init (struct multi_context *m, const struct context *top)
 {
   inherit_context_top (&m->top, top);
-  m->top.c2.buffers = NULL;
-  if (alloc_buffers)
-    m->top.c2.buffers = init_context_buffers (&top->c2.frame);
+  m->top.c2.buffers = init_context_buffers (&top->c2.frame);
 }
 
 void
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index ec1e7ab..9d8185d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -233,7 +233,7 @@ const char *multi_instance_string (const struct multi_instance *mi, bool null, s
 void multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int thread_mode);
 void multi_uninit (struct multi_context *m);
 
-void multi_top_init (struct multi_context *m, const struct context *top, const bool alloc_buffers);
+void multi_top_init (struct multi_context *m, const struct context *top);
 void multi_top_free (struct multi_context *m);
 
 struct multi_instance *multi_create_instance (struct multi_context *m, const struct mroute_addr *real);
-- 
2.7.4


