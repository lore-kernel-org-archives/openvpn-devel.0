From: Arne Schwabe <arne@...1227...>
Date: Tue, 21 Jun 2022 18:16:45 +0200
Message-Id: <20220621161649.2872985-2-arne@...1227...>
In-Reply-To: <20220621161649.2872985-1-arne@...1227...>
References: <20220621161649.2872985-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/6] Inline frame_add_to_extra_tun function
 and remove frame_defined
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

This function has only one usage and is so trivial that an extra
function makes little sense anymore.

frame_defined is no longer used, so remove the function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c |  2 +-
 src/openvpn/mtu.h  | 16 ----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f06afc298..6cdcef628 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3047,7 +3047,7 @@ do_init_frame(struct context *c)
      */
     if (c->options.ce.tun_mtu_extra_defined)
     {
-        frame_add_to_extra_tun(&c->c2.frame, c->options.ce.tun_mtu_extra);
+        c->c2.frame.extra_tun += c->options.ce.tun_mtu_extra;
     }
 
     /*
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 4b8feca7c..9db6cf26a 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -274,20 +274,4 @@ const char *format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc);
 
 #endif
 
-/*
- * frame member adjustment functions
- */
-
-static inline void
-frame_add_to_extra_tun(struct frame *frame, const int increment)
-{
-    frame->extra_tun += increment;
-}
-
-static inline bool
-frame_defined(const struct frame *frame)
-{
-    return frame->buf.payload_size > 0;
-}
-
 #endif /* ifndef MTU_H */
-- 
2.32.1 (Apple Git-133)


