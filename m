From: Gert Doering <gert@...1296...>
Date: Sat,  7 Feb 2015 19:51:48 +0100
Message-Id: <1423335108-83928-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] New approach to handle peer-id related
	changes to link-mtu.
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

Instead of statically increasing link-mtu by +3, keep the old value for
OCC compatibility with old servers/clients, and only increase link-mtu
if peer-id option is enabled (right now: is pushed by server).

If link-mtu has been set in the config, keep configured value, and log
warning (because the extra overhead has to decrease tun-mtu).

Reserve extra +3 bytes in frame->extra_buffer.

This reverts commit f95010ad247a8998e0c39e394236251fca316849.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c | 19 +++++++++++++++++++
 src/openvpn/ssl.c  | 10 ++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 706d07c..a4ef84b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1794,6 +1794,19 @@ do_deferred_options (struct context *c, const unsigned int found)
       msg (D_PUSH, "OPTIONS IMPORT: peer-id set");
       c->c2.tls_multi->use_peer_id = true;
       c->c2.tls_multi->peer_id = c->options.peer_id;
+      frame_add_to_extra_frame(&c->c2.frame, +3);	/* peer-id overhead */
+      if ( !c->options.ce.link_mtu_defined )
+	{
+	  c->c2.frame.link_mtu += 3;
+	  msg (D_PUSH, "OPTIONS IMPORT: adjusting link_mtu to %d",
+				EXPANDED_SIZE(&c->c2.frame));
+	}
+      else
+	{
+	  msg (M_WARN, "OPTIONS IMPORT: WARNING: peer-id set, but link-mtu"
+                       " fixed by config - reducing tun-mtu to %d, expect"
+                       " MTU problems", TUN_MTU_SIZE(&c->c2.frame) );
+	}
     }
 #endif
 }
@@ -2403,6 +2416,12 @@ do_init_frame (struct context *c)
 #endif
 #endif /* USE_COMP */
 
+  /* packets with peer-id (P_DATA_V2) need 3 extra bytes in frame.
+   * reserve in f->extra_buffer, adjust f->extra_frame when peer-id option
+   * is push-received (where it's too late to change BUF_SIZE(f) allocations)
+   */
+  frame_add_to_extra_buffer(&c->c2.frame, 3);
+
 #ifdef ENABLE_FRAGMENT
   /*
    * Set frame parameter for fragment code.  This is necessary because
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 80293ef..0bca28d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -264,14 +264,16 @@ tls_get_cipher_name_pair (const char * cipher_name, size_t len) {
   return NULL;
 }
 
-/**
- * Max number of bytes we will add for data structures common to both data and
- * control channel packets (1 byte opcode + 3 bytes peer-id).
+/*
+ * Max number of bytes we will add
+ * for data structures common to both
+ * data and control channel packets.
+ * (opcode only). 
  */
 void
 tls_adjust_frame_parameters(struct frame *frame)
 {
-  frame_add_to_extra_frame (frame, 1 + 3); /* space for opcode + peer-id */
+  frame_add_to_extra_frame (frame, 1); /* space for opcode */
 }
 
 /*
-- 
2.1.2


