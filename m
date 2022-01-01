From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:25:29 +0100
Message-Id: <20220101162532.2251835-12-arne@...1227...>
In-Reply-To: <20220101162532.2251835-1-arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 11/14] Remove extra_link from frame
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

The previous commits removed any reads from this variable. So we can
now safely remove it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c  | 19 -------------------
 src/openvpn/mtu.c   |  1 -
 src/openvpn/mtu.h   | 13 -------------
 src/openvpn/socks.c | 11 +----------
 src/openvpn/socks.h |  2 --
 src/openvpn/ssl.c   |  1 -
 6 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dfc44e9d..bf6369f8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3171,14 +3171,6 @@ do_init_frame(struct context *c)
     }
 #endif /* USE_COMP */
 
-    /*
-     * Adjust frame size for UDP Socks support.
-     */
-    if (c->options.ce.socks_proxy_server)
-    {
-        socks_adjust_frame_parameters(&c->c2.frame, c->options.ce.proto);
-    }
-
     /*
      * Adjust frame size based on the --tun-mtu-extra parameter.
      */
@@ -3211,17 +3203,6 @@ do_init_frame(struct context *c)
 #endif
 #endif /* USE_COMP */
 
-    /* packets with peer-id (P_DATA_V2) need 3 extra bytes in frame (on client)
-     * and need link_mtu+3 bytes on socket reception (on server).
-     *
-     * accommodate receive path in f->extra_link, which has the side effect of
-     * also increasing send buffers (BUF_SIZE() macro), which need to be
-     * allocated big enough before receiving peer-id option from server.
-     *
-     * f->extra_frame is adjusted when peer-id option is push-received
-     */
-    frame_add_to_extra_link(&c->c2.frame, 3);
-
 #ifdef ENABLE_FRAGMENT
     /*
      * Set frame parameter for fragment code.  This is necessary because
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index ab088466..0bcfbfd1 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -266,7 +266,6 @@ frame_print(const struct frame *frame,
     buf_printf(&out, " EF:%d", frame->extra_frame);
     buf_printf(&out, " EB:%d", frame->extra_buffer);
     buf_printf(&out, " ET:%d", frame->extra_tun);
-    buf_printf(&out, " EL:%d", frame->extra_link);
     buf_printf(&out, " ]");
 
     msg(level, "%s", out.data);
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 288cfad6..a87adbc4 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -163,13 +163,6 @@ struct frame {
                                  *   which defaults to 0 for tun and 32
                                  *   (\c TAP_MTU_EXTRA_DEFAULT) for tap.
                                  *   */
-
-    int extra_link;             /**< Maximum number of bytes in excess of
-                                 *   external network interface's MTU that
-                                 *   might be read from or written to it.
-                                 *
-                                 *   Used by peer-id (3) and
-                                 *   socks UDP (10) */
 };
 
 /* Forward declarations, to prevent includes */
@@ -383,12 +376,6 @@ frame_add_to_extra_tun(struct frame *frame, const int increment)
     frame->extra_tun += increment;
 }
 
-static inline void
-frame_add_to_extra_link(struct frame *frame, const int increment)
-{
-    frame->extra_link += increment;
-}
-
 static inline void
 frame_add_to_extra_buffer(struct frame *frame, const int increment)
 {
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 27a58331..6935e761 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -49,15 +49,6 @@
 
 #define UP_TYPE_SOCKS           "SOCKS Proxy"
 
-void
-socks_adjust_frame_parameters(struct frame *frame, int proto)
-{
-    if (proto == PROTO_UDP)
-    {
-        frame_add_to_extra_link(frame, 10);
-    }
-}
-
 struct socks_proxy_info *
 socks_proxy_new(const char *server,
                 const char *port,
@@ -610,7 +601,7 @@ socks_process_outgoing_udp(struct buffer *buf,
     /*
      * Get a 10 byte subset buffer prepended to buf --
      * we expect these bytes will be here because
-     * we allocated frame space in socks_adjust_frame_parameters.
+     * we always allocate space for these bytes
      */
     struct buffer head = buf_sub(buf, 10, true);
 
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 9bda2e80..4ab30f55 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -42,8 +42,6 @@ struct socks_proxy_info {
     char authfile[256];
 };
 
-void socks_adjust_frame_parameters(struct frame *frame, int proto);
-
 struct socks_proxy_info *socks_proxy_new(const char *server,
                                          const char *port,
                                          const char *authfile);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 78983545..091f40eb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -322,7 +322,6 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
 
     /* inherit link MTU and extra_link from data channel */
     frame->link_mtu = data_channel_frame->link_mtu;
-    frame->extra_link = data_channel_frame->extra_link;
 
     /* set extra_frame */
     tls_adjust_frame_parameters(frame);
-- 
2.33.0


