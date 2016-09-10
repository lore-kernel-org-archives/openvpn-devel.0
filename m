From: Steffan Karger <steffan@...1856...>
Date: Sat, 10 Sep 2016 08:11:12 +0200
Message-Id: <1473487872-13119-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Fix --mssfix when using NCP
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

As reported in trac #716, cipher negotiation (NCP) broke --mssfix.  This
patch now also restores the mssfix value after the crypto negotiation.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c | 15 +--------------
 src/openvpn/mtu.c  | 10 ++++++++++
 src/openvpn/mtu.h  |  6 ++++++
 src/openvpn/ssl.c  |  1 +
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5685b69..2d262f0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2802,19 +2802,6 @@ do_init_fragment (struct context *c)
 #endif
 
 /*
- * Set the --mssfix option.
- */
-static void
-do_init_mssfix (struct context *c)
-{
-  if (c->options.ce.mssfix)
-    {
-      frame_set_mtu_dynamic (&c->c2.frame,
-			     c->options.ce.mssfix, SET_MTU_UPPER_BOUND);
-    }
-}
-
-/*
  * Allocate our socket object.
  */
 static void
@@ -3656,7 +3643,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
 #endif
 
   /* initialize dynamic MTU variable */
-  do_init_mssfix (c);
+  frame_init_mssfix (&c->c2.frame, &c->options);
 
   /* bind the TCP/UDP socket */
   if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 64d1cf3..8cbaa86 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -35,6 +35,7 @@
 #include "error.h"
 #include "integer.h"
 #include "mtu.h"
+#include "options.h"
 
 #include "memdbg.h"
 
@@ -125,6 +126,15 @@ frame_subtract_extra (struct frame *frame, const struct frame *src)
 }
 
 void
+frame_init_mssfix (struct frame *frame, const struct options *options)
+{
+  if (options->ce.mssfix)
+    {
+      frame_set_mtu_dynamic (frame, options->ce.mssfix, SET_MTU_UPPER_BOUND);
+    }
+}
+
+void
 frame_print (const struct frame *frame,
 	     int level,
 	     const char *prefix)
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index f94de89..0320545 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -135,6 +135,9 @@ struct frame {
   int align_adjust;
 };
 
+/* Forward declarations, to prevent includes */
+struct options;
+
 /* Routines which read struct frame should use the macros below */
 
 /*
@@ -227,6 +230,9 @@ void alloc_buf_sock_tun (struct buffer *buf,
 			 const bool tuntap_buffer,
 			 const unsigned int align_mask);
 
+/** Set the --mssfix option. */
+void frame_init_mssfix (struct frame *frame, const struct options *options);
+
 /*
  * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
  * on socket errors, such as PMTU size.  As of 2003.05.11, only works
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a220b79..caf3b1f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1691,6 +1691,7 @@ tls_session_update_crypto_params(struct tls_session *session,
       options->use_iv, options->replay, packet_id_long_form);
   frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
       options->ce.tun_mtu_defined, options->ce.tun_mtu);
+  frame_init_mssfix(frame, options);
   frame_print (frame, D_MTU_INFO, "Data Channel MTU parms");
 
   const struct session_id *client_sid = session->opt->server ?
-- 
2.7.4


