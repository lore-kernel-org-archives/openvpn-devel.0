From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Mar 2023 14:44:55 +0100
Message-Id: <20230301134455.2810114-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Only update frame calculation if we have a
 valid link sockets
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

Without this, we will caculate a pointer to the linksocket relative to  a null pointer
in get_link_socket_info, which itself does not crash and the pointer seems not to be accessed
later, so we do not get a crash here. This is still not the correct behaviour and the undefined
behaviour sanitiser from llvm/clang finds this.

Change-Id: I82a20ac72f60f8770ea1b4ab0c8cdea31868abe7
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 622239f6b..e6f14f72d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4541,14 +4541,15 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     {
         link_socket_init_phase2(c);
-    }
 
-    /* Update dynamic frame calculation as exact transport socket information
-     * (IP vs IPv6) may be only available after socket phase2 has finished.
-     * This is only needed for --static or no crypto, NCP will recalculate this
-     * in tls_session_update_crypto_params (P2MP) */
-    frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, &c->options,
-                            get_link_socket_info(c));
+
+        /* Update dynamic frame calculation as exact transport socket information
+         * (IP vs IPv6) may be only available after socket phase2 has finished.
+         * This is only needed for --static or no crypto, NCP will recalculate this
+         * in tls_session_update_crypto_params (P2MP) */
+        frame_calculate_dynamic(&c->c2.frame, &c->c1.ks.key_type, &c->options,
+                                get_link_socket_info(c));
+    }
 
     /*
      * Actually do UID/GID downgrade, and chroot, if requested.
-- 
2.37.1 (Apple Git-137.1)


