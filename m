From: Frank Lichtenheld <frank@...2641...>
Date: Tue,  4 Nov 2025 11:44:48 +0100
Message-Id: <20251104104448.98093-1-frank@...2641...>
In-Reply-To: <gerrit.1762214128000.I2b5429841bcd46376241890ace50b82a291b7400@...2715...>
References: <gerrit.1762214128000.I2b5429841bcd46376241890ace50b82a291b7400@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] init: make some functions static
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
Cc: Antonio Quartulli <antonio@...2726...>

From: Antonio Quartulli <antonio@...2726...>

A bunch of functions are defined and used within init.c only.
We can therefore drop their declaration in init.h and make
them static.

Change-Id: I2b5429841bcd46376241890ace50b82a291b7400
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1346
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1346
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1bdaf27..8d95d5c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -71,13 +71,13 @@
 
 static bool do_deferred_p2p_ncp(struct context *c);
 
-void
+static void
 context_clear(struct context *c)
 {
     CLEAR(*c);
 }
 
-void
+static void
 context_clear_1(struct context *c)
 {
     CLEAR(c->c1);
@@ -4430,32 +4430,9 @@
 }
 
 /*
- * Initialize a tunnel instance, handle pre and post-init
- * signal settings.
- */
-void
-init_instance_handle_signals(struct context *c, const struct env_set *env, const unsigned int flags)
-{
-    pre_init_signal_catch();
-    init_instance(c, env, flags);
-    post_init_signal_catch();
-
-    /*
-     * This is done so that signals thrown during
-     * initialization can bring us back to
-     * a management hold.
-     */
-    if (IS_SIG(c))
-    {
-        remap_signal(c);
-        uninit_management_callback();
-    }
-}
-
-/*
  * Initialize a tunnel instance.
  */
-void
+static void
 init_instance(struct context *c, const struct env_set *env, const unsigned int flags)
 {
     const struct options *options = &c->options;
@@ -4745,6 +4722,29 @@
 }
 
 /*
+ * Initialize a tunnel instance, handle pre and post-init
+ * signal settings.
+ */
+void
+init_instance_handle_signals(struct context *c, const struct env_set *env, const unsigned int flags)
+{
+    pre_init_signal_catch();
+    init_instance(c, env, flags);
+    post_init_signal_catch();
+
+    /*
+     * This is done so that signals thrown during
+     * initialization can bring us back to
+     * a management hold.
+     */
+    if (IS_SIG(c))
+    {
+        remap_signal(c);
+        uninit_management_callback();
+    }
+}
+
+/*
  * Close a tunnel instance.
  */
 void
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index e89615b..97318ec 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -31,10 +31,6 @@
  */
 #define BASE_N_EVENTS 5
 
-void context_clear(struct context *c);
-
-void context_clear_1(struct context *c);
-
 void context_clear_2(struct context *c);
 
 void context_init_1(struct context *c);
@@ -64,8 +60,6 @@
 void init_instance_handle_signals(struct context *c, const struct env_set *env,
                                   const unsigned int flags);
 
-void init_instance(struct context *c, const struct env_set *env, const unsigned int flags);
-
 /**
  * Query for private key and auth-user-pass username/passwords.
  */

