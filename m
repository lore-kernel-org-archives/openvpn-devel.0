From: Gert Doering <gert@...1296...>
Date: Sun,  8 Feb 2015 11:18:45 +0100
Message-Id: <1423390725-13438-1-git-send-email-gert@...1296...>
In-Reply-To: <1423335108-83928-1-git-send-email-gert@...1296...>
References: <1423335108-83928-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH v2] New approach to handle peer-id related
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

Reserve extra +3 bytes in frame->extra_link.

v2: use frame->extra_link, not frame->extra_buffer (receive path on server)
    introduce frame_add_to_link_mtu() to manipulate frame->link_mtu value
    rework comments to make more clear what is happening

This reverts commit f95010ad247a8998e0c39e394236251fca316849.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c | 24 ++++++++++++++++++++++++
 src/openvpn/mtu.h  |  6 ++++++
 src/openvpn/ssl.c  | 10 ++++++----
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 706d07c..b670a48 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1794,6 +1794,19 @@ do_deferred_options (struct context *c, const unsigned int found)
       msg (D_PUSH, "OPTIONS IMPORT: peer-id set");
       c->c2.tls_multi->use_peer_id = true;
       c->c2.tls_multi->peer_id = c->options.peer_id;
+      frame_add_to_extra_frame(&c->c2.frame, +3);	/* peer-id overhead */
+      if ( !c->options.ce.link_mtu_defined )
+	{
+	  frame_add_to_link_mtu(&c->c2.frame, +3);
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
@@ -2403,6 +2416,17 @@ do_init_frame (struct context *c)
 #endif
 #endif /* USE_COMP */
 
+  /* packets with peer-id (P_DATA_V2) need 3 extra bytes in frame (on client)
+   * and need link_mtu+3 bytes on socket reception (on server).
+   *
+   * accomodate receive path in f->extra_link, which has the side effect of
+   * also increasing send buffers (BUF_SIZE() macro), which need to be
+   * allocated big enough before receiving peer-id option from server.
+   *
+   * f->extra_frame is adjusted when peer-id option is push-received
+   */
+  frame_add_to_extra_link(&c->c2.frame, 3);
+
 #ifdef ENABLE_FRAGMENT
   /*
    * Set frame parameter for fragment code.  This is necessary because
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 29ec21f..bccd681 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -258,6 +258,12 @@ frame_headroom (const struct frame *f, const unsigned int flag_mask)
  */
 
 static inline void
+frame_add_to_link_mtu (struct frame *frame, const int increment)
+{
+  frame->link_mtu += increment;
+}
+
+static inline void
 frame_add_to_extra_frame (struct frame *frame, const int increment)
 {
   frame->extra_frame += increment;
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


