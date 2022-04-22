From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:30 +0200
Message-Id: <20220422134038.3801239-2-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 01/28] Remove
 tls_init_control_channel_frame_parameters wrapper function
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

While calling this wrapper function is strictly more correct, these
indirection layer with tiny wrapper make the code more complex and
going through more layer than it really needs to.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c |  2 +-
 src/openvpn/ssl.c  | 14 +-------------
 src/openvpn/ssl.h  |  7 ++++---
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b233b9d86..d5be3cf9f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2994,7 +2994,7 @@ do_init_frame_tls(struct context *c)
     }
     if (c->c2.tls_auth_standalone)
     {
-        tls_auth_standalone_finalize(c->c2.tls_auth_standalone, &c->c2.frame);
+        tls_init_control_channel_frame_parameters(&c->c2.frame, &c->c2.tls_auth_standalone->frame);
         frame_print(&c->c2.tls_auth_standalone->frame, D_MTU_INFO,
                     "TLS-Auth MTU parms");
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f2613228a..4ebf5acc2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -295,11 +295,7 @@ tls_limit_reneg_bytes(const char *ciphername, int *reneg_bytes)
     }
 }
 
-/*
- * Max number of bytes we will add
- * to control channel packet.
- */
-static void
+void
 tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame,
                                           struct frame *frame)
 {
@@ -1284,7 +1280,6 @@ void
 tls_multi_init_finalize(struct tls_multi *multi, const struct frame *frame)
 {
     tls_init_control_channel_frame_parameters(frame, &multi->opt.frame);
-
     /* initialize the active and untrusted sessions */
 
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
@@ -1322,13 +1317,6 @@ tls_auth_standalone_init(struct tls_options *tls_options,
     return tas;
 }
 
-void
-tls_auth_standalone_finalize(struct tls_auth_standalone *tas,
-                             const struct frame *frame)
-{
-    tls_init_control_channel_frame_parameters(frame, &tas->frame);
-}
-
 /*
  * Set local and remote option compatibility strings.
  * Used to verify compatibility of local and remote option
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cf754ad28..5b9232006 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -209,10 +209,11 @@ struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_opt
                                                      struct gc_arena *gc);
 
 /*
- * Finalize a standalone tls-auth verification object.
+ * Setups up the control channel frame size parameters from the data channel
+ * parameters
  */
-void tls_auth_standalone_finalize(struct tls_auth_standalone *tas,
-                                  const struct frame *frame);
+void tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame,
+                                               struct frame *frame);
 
 /*
  * Set local and remote option compatibility strings.
-- 
2.32.0 (Apple Git-132)


