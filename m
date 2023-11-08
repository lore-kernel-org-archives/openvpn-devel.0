Resent-Message-ID: <ZUzBhrWSzEGlsgXG@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
From: Gert Doering <gert@...1296...>
Date: Wed,  8 Nov 2023 13:49:45 +0100
Message-ID: <20231108124947.76816-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Remove saving initial frame code
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

From: Arne Schwabe <arne@...1227...>

This code was necessary before the frame/buffer refactoring as we
always did relative adjustment to the frame.

This also fixes also that previously initial_frame was initialised too
early before the fragment related options were initialised and contained
0 for the maximum frame size. This resulted in a DIV by 0 that caused an
abort on platforms that throw an exception for that.

CVE: 2023-46849

Only people with --fragment in their config are affected

Change-Id: Icc612bab5700879606290639e1b8773f61ec670d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c |  9 ---------
 src/openvpn/init.c    | 19 ++++++++-----------
 src/openvpn/openvpn.h |  3 ---
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 2510410f9..0443ca0a0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1078,15 +1078,6 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
             if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf, &co,
                                 floated, &ad_start))
             {
-                /* Restore pre-NCP frame parameters */
-                if (is_hard_reset_method2(opcode))
-                {
-                    c->c2.frame = c->c2.frame_initial;
-#ifdef ENABLE_FRAGMENT
-                    c->c2.frame_fragment = c->c2.frame_fragment_initial;
-#endif
-                }
-
                 interval_action(&c->c2.tmp_int);
 
                 /* reset packet received timer if TLS packet */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 019f5a4f6..8c707a463 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3537,15 +3537,6 @@ do_init_frame(struct context *c)
      */
     frame_finalize_options(c, NULL);
 
-#ifdef ENABLE_FRAGMENT
-    /*
-     * Set frame parameter for fragment code.  This is necessary because
-     * the fragmentation code deals with payloads which have already been
-     * passed through the compression code.
-     */
-    c->c2.frame_fragment = c->c2.frame;
-    c->c2.frame_fragment_initial = c->c2.frame_fragment;
-#endif
 
 #if defined(ENABLE_FRAGMENT)
     /*
@@ -3736,6 +3727,14 @@ static void
 do_init_fragment(struct context *c)
 {
     ASSERT(c->options.ce.fragment);
+
+    /*
+     * Set frame parameter for fragment code.  This is necessary because
+     * the fragmentation code deals with payloads which have already been
+     * passed through the compression code.
+     */
+    c->c2.frame_fragment = c->c2.frame;
+
     frame_calculate_dynamic(&c->c2.frame_fragment, &c->c1.ks.key_type,
                             &c->options, get_link_socket_info(c));
     fragment_frame_init(c->c2.fragment, &c->c2.frame_fragment);
@@ -4640,8 +4639,6 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         c->c2.did_open_tun = do_open_tun(c, &error_flags);
     }
 
-    c->c2.frame_initial = c->c2.frame;
-
     /* print MTU info */
     do_print_data_channel_mtu_parms(c);
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 077effeb9..5b2be63f9 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -249,14 +249,11 @@ struct context_2
 
     /* MTU frame parameters */
     struct frame frame;                         /* Active frame parameters */
-    struct frame frame_initial;                 /* Restored on new session */
 
 #ifdef ENABLE_FRAGMENT
     /* Object to handle advanced MTU negotiation and datagram fragmentation */
     struct fragment_master *fragment;
     struct frame frame_fragment;
-    struct frame frame_fragment_initial;
-    struct frame frame_fragment_omit;
 #endif
 
     /*
-- 
2.39.3 (Apple Git-145)


