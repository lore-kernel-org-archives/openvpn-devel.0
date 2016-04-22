From: Jan Just Keijser <janjust@...1147...>
Date: Fri, 22 Apr 2016 05:35:45 +0200
Message-Id: <1461296145-26067-1-git-send-email-janjust@...1147...>
Subject: [Openvpn-devel] [PATCH] V2: Add compression support. Now properly
	supports AEAD as well
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

---
 src/openvpn/init.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++--------
 src/openvpn/mtu.h  | 18 +++++++++++++
 2 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 84fac07..0566b5b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -60,6 +60,12 @@ static struct context *static_context; /* GLOBAL */
 #define CF_INIT_TLS_AUTH_STANDALONE (1<<2)
 
 static void do_init_first_time (struct context *c);
+static void do_init_buffers(struct context *c);
+static void do_init_crypto_tls(struct context *c, const unsigned int flags);
+static void do_init_frame(struct context *c);
+static void do_init_frame_tls(struct context *c);
+static void do_compute_occ_strings(struct context *c);
+
 
 void
 context_clear (struct context *c)
@@ -416,7 +422,7 @@ init_query_passwords (const struct context *c)
   if (c->options.key_pass_file)
     pem_password_setup (c->options.key_pass_file);
 #endif
-  
+
 #if P2MP
   /* Auth user/pass input */
   if (c->options.auth_user_pass_file)
@@ -1044,7 +1050,7 @@ pre_setup (const struct options *options)
       /* put a title on the top window bar */
       if (win32_signal.mode == WSO_MODE_CONSOLE)
 	{
-	  window_title_save (&window_title); 
+	  window_title_save (&window_title);
 	  window_title_generate (options->config);
 	}
     }
@@ -1801,6 +1807,7 @@ pull_permission_mask (const struct context *c)
     | OPT_P_SHAPER
     | OPT_P_TIMER
     | OPT_P_COMP
+    | OPT_P_CRYPTO
     | OPT_P_PERSIST
     | OPT_P_MESSAGES
     | OPT_P_EXPLICIT_NOTIFY
@@ -1885,6 +1892,53 @@ do_deferred_options (struct context *c, const unsigned int found)
     msg (D_PUSH, "OPTIONS IMPORT: environment modified");
 
 #ifdef ENABLE_CRYPTO
+  if (found & OPT_P_CRYPTO)
+    {
+      const struct options *options = &c->options;
+      struct key_type *kt = &c->c1.ks.key_type;
+      /* Save the old crypto length so that we recalculate the extra frame/mtu parameters c*/
+      unsigned int old_crypto_length = kt->cipher_length + kt->hmac_length;
+
+      msg (D_PUSH, "OPTIONS IMPORT: crypto options modified");
+
+      /* Update cipher & hash algorithms */
+      init_key_type (kt, options->ciphername,
+                      options->ciphername_defined, options->authname,
+                      options->authname_defined, options->keysize, true, true);
+
+msg(M_WARN, "old length: %d", old_crypto_length);
+msg(M_WARN, "new: cipherlength = %d hmaclength = %d", kt->cipher_length, kt->hmac_length);
+
+      /* Sanity check on IV, sequence number, and cipher mode options */
+      check_replay_iv_consistency (kt, options->replay, options->use_iv);
+
+      /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
+      bool packet_id_long_form = cipher_kt_mode_ofb_cfb (kt->cipher);
+
+      /* Reset the frame contents */
+      frame_reset_extra_frame( &c->c2.frame);
+      frame_reset_link_mtu( &c->c2.frame);
+#ifdef USE_COMP
+      frame_reset_extra_buffer( &c->c2.frame);
+#ifdef ENABLE_FRAGMENT
+      frame_reset_extra_buffer (&c->c2.frame_fragment_omit);
+#endif
+#endif /* USE_COMP */
+
+      do_init_crypto_tls(c, CF_INIT_TLS_MULTI);
+      do_init_frame(c);
+      do_init_frame_tls(c);
+
+      frame_print(&c->c2.frame, M_WARN, "New data channel");
+      frame_print(&c->c2.tls_multi->opt.frame, M_WARN, "New control channel");
+
+      /* Reallocate the context buffers to adjust for the new frame size */
+      free_context_buffers (c->c2.buffers);
+      do_init_buffers(c);
+
+      do_compute_occ_strings(c);
+    }
+
   if (found & OPT_P_PEER_ID)
     {
       msg (D_PUSH, "OPTIONS IMPORT: peer-id set");
@@ -2008,7 +2062,7 @@ frame_finalize_options (struct context *c, const struct options *o)
 			    |FRAME_HEADROOM_MARKER_READ_LINK
 			    |FRAME_HEADROOM_MARKER_READ_STREAM);
     }
-  
+
   frame_finalize (&c->c2.frame,
 		  o->ce.link_mtu_defined,
 		  o->ce.link_mtu,
@@ -2881,7 +2935,7 @@ do_init_first_time (struct context *c)
 
       ALLOC_OBJ_CLEAR_GC (c->c0, struct context_0, &c->gc);
       c0 = c->c0;
-      
+
       /* get user and/or group that we want to setuid/setgid to */
       c0->uid_gid_specified =
 	platform_group_get (c->options.groupname, &c0->platform_state_group) |
@@ -2973,7 +3027,7 @@ do_close_link_socket (struct context *c)
       c->c2.link_socket = NULL;
     }
 
-    
+
   /* Preserve the resolved list of remote if the user request to or if we want
    * reconnect to the same host again or there are still addresses that need
    * to be tried */
@@ -3188,7 +3242,7 @@ do_signal_on_tls_errors (struct context *c)
   if (c->options.tls_exit)
     c->c2.tls_exit_signal = SIGTERM;
   else
-    c->c2.tls_exit_signal = SIGUSR1;    
+    c->c2.tls_exit_signal = SIGUSR1;
 #endif
 }
 
@@ -3436,7 +3490,7 @@ init_instance_handle_signals (struct context *c, const struct env_set *env, cons
   if (IS_SIG (c))
     {
       remap_signal (c);
-      uninit_management_callback ();  
+      uninit_management_callback ();
     }
 }
 
@@ -3510,7 +3564,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
   /* set error message delay for non-server modes */
   if (c->mode == CM_P2P)
     set_check_status_error_delay (P2P_ERROR_DELAY_MS);
-    
+
   /* warn about inconsistent options */
   if (c->mode == CM_P2P || c->mode == CM_TOP)
     do_option_warnings (c);
@@ -3656,7 +3710,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
   if (c->first_time && (c->mode == CM_P2P || c->mode == CM_TOP))
     init_port_share (c);
 #endif
-	  
+
 #ifdef ENABLE_PF
   if (child)
     pf_init_context (c);
@@ -3836,7 +3890,7 @@ inherit_context_top (struct context *dest,
    * Also note that CM_TOP_CLONE context objects are
    * closed by multi_top_free in multi.c.
    */
-  dest->mode = CM_TOP_CLONE; 
+  dest->mode = CM_TOP_CLONE;
 
   dest->first_time = false;
   dest->c0 = NULL;
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index f94de89..2ec0242 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -264,12 +264,24 @@ frame_add_to_link_mtu (struct frame *frame, const int increment)
 }
 
 static inline void
+frame_reset_link_mtu (struct frame *frame)
+{
+  frame->link_mtu = 0;
+}
+
+static inline void
 frame_add_to_extra_frame (struct frame *frame, const int increment)
 {
   frame->extra_frame += increment;
 }
 
 static inline void
+frame_reset_extra_frame (struct frame *frame)
+{
+  frame->extra_frame = 0;
+}
+
+static inline void
 frame_add_to_extra_tun (struct frame *frame, const int increment)
 {
   frame->extra_tun += increment;
@@ -288,6 +300,12 @@ frame_add_to_extra_buffer (struct frame *frame, const int increment)
 }
 
 static inline void
+frame_reset_extra_buffer (struct frame *frame)
+{
+  frame->extra_buffer = 0;
+}
+
+static inline void
 frame_add_to_align_adjust (struct frame *frame, const int increment)
 {
   frame->align_adjust += increment;
-- 
1.9.3


