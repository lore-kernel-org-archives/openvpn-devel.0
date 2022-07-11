From: Antonio Quartulli <a@...2181...>
Date: Mon, 11 Jul 2022 14:23:48 +0200
Message-Id: <20220711122348.8756-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options: don't export local function
 pre_connect_save()
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

The pre_connect_save() function is not used outside of options.c,
therefore it should not be exported.

Make it static and move definition before its invocation.
Move also pre_connect_restore() along with it in order to keep the two
close to each other.

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 238 +++++++++++++++++++++---------------------
 src/openvpn/options.h |   2 -
 2 files changed, 119 insertions(+), 121 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fa66b513..6f83406b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3219,6 +3219,125 @@ remap_redirect_gateway_flags(struct options *opt)
 }
 #endif
 
+/*
+ * Save/Restore certain option defaults before --pull is applied.
+ */
+
+static void
+pre_connect_save(struct options *o)
+{
+    ALLOC_OBJ_CLEAR_GC(o->pre_connect, struct options_pre_connect, &o->gc);
+    o->pre_connect->tuntap_options = o->tuntap_options;
+    o->pre_connect->tuntap_options_defined = true;
+    o->pre_connect->foreign_option_index = o->foreign_option_index;
+
+    if (o->routes)
+    {
+        o->pre_connect->routes = clone_route_option_list(o->routes, &o->gc);
+        o->pre_connect->routes_defined = true;
+    }
+    if (o->routes_ipv6)
+    {
+        o->pre_connect->routes_ipv6 = clone_route_ipv6_option_list(o->routes_ipv6, &o->gc);
+        o->pre_connect->routes_ipv6_defined = true;
+    }
+    if (o->client_nat)
+    {
+        o->pre_connect->client_nat = clone_client_nat_option_list(o->client_nat, &o->gc);
+        o->pre_connect->client_nat_defined = true;
+    }
+
+    o->pre_connect->route_default_gateway = o->route_default_gateway;
+    o->pre_connect->route_ipv6_default_gateway = o->route_ipv6_default_gateway;
+
+    o->pre_connect->dns_options = clone_dns_options(o->dns_options, &o->gc);
+
+    /* NCP related options that can be overwritten by a push */
+    o->pre_connect->ciphername = o->ciphername;
+    o->pre_connect->authname = o->authname;
+
+    /* Ping related options should be reset to the config values on reconnect */
+    o->pre_connect->ping_rec_timeout = o->ping_rec_timeout;
+    o->pre_connect->ping_rec_timeout_action = o->ping_rec_timeout_action;
+    o->pre_connect->ping_send_timeout = o->ping_send_timeout;
+
+    /* Miscellaneous Options */
+#ifdef USE_COMP
+    o->pre_connect->comp = o->comp;
+#endif
+}
+
+void
+pre_connect_restore(struct options *o, struct gc_arena *gc)
+{
+    const struct options_pre_connect *pp = o->pre_connect;
+    if (pp)
+    {
+        CLEAR(o->tuntap_options);
+        if (pp->tuntap_options_defined)
+        {
+            o->tuntap_options = pp->tuntap_options;
+        }
+
+        if (pp->routes_defined)
+        {
+            rol_check_alloc(o);
+            copy_route_option_list(o->routes, pp->routes, gc);
+        }
+        else
+        {
+            o->routes = NULL;
+        }
+
+        if (pp->routes_ipv6_defined)
+        {
+            rol6_check_alloc(o);
+            copy_route_ipv6_option_list(o->routes_ipv6, pp->routes_ipv6, gc);
+        }
+        else
+        {
+            o->routes_ipv6 = NULL;
+        }
+
+        o->route_default_gateway = pp->route_default_gateway;
+        o->route_ipv6_default_gateway = pp->route_ipv6_default_gateway;
+
+        /* Free DNS options and reset them to pre-pull state */
+        gc_free(&o->dns_options.gc);
+        struct gc_arena dns_gc = gc_new();
+        o->dns_options = clone_dns_options(pp->dns_options, &dns_gc);
+        o->dns_options.gc = dns_gc;
+
+        if (pp->client_nat_defined)
+        {
+            cnol_check_alloc(o);
+            copy_client_nat_option_list(o->client_nat, pp->client_nat);
+        }
+        else
+        {
+            o->client_nat = NULL;
+        }
+
+        o->foreign_option_index = pp->foreign_option_index;
+
+        o->ciphername = pp->ciphername;
+        o->authname = pp->authname;
+
+        o->ping_rec_timeout = pp->ping_rec_timeout;
+        o->ping_rec_timeout_action = pp->ping_rec_timeout_action;
+        o->ping_send_timeout = pp->ping_send_timeout;
+
+        /* Miscellaneous Options */
+#ifdef USE_COMP
+        o->comp = pp->comp;
+#endif
+    }
+
+    o->push_continuation = 0;
+    o->push_option_types_found = 0;
+    o->data_channel_crypto_flags = 0;
+}
+
 static void
 options_postprocess_mutate_invariant(struct options *options)
 {
@@ -3946,125 +4065,6 @@ options_postprocess_pull(struct options *o, struct env_set *es)
     return success;
 }
 
-/*
- * Save/Restore certain option defaults before --pull is applied.
- */
-
-void
-pre_connect_save(struct options *o)
-{
-    ALLOC_OBJ_CLEAR_GC(o->pre_connect, struct options_pre_connect, &o->gc);
-    o->pre_connect->tuntap_options = o->tuntap_options;
-    o->pre_connect->tuntap_options_defined = true;
-    o->pre_connect->foreign_option_index = o->foreign_option_index;
-
-    if (o->routes)
-    {
-        o->pre_connect->routes = clone_route_option_list(o->routes, &o->gc);
-        o->pre_connect->routes_defined = true;
-    }
-    if (o->routes_ipv6)
-    {
-        o->pre_connect->routes_ipv6 = clone_route_ipv6_option_list(o->routes_ipv6, &o->gc);
-        o->pre_connect->routes_ipv6_defined = true;
-    }
-    if (o->client_nat)
-    {
-        o->pre_connect->client_nat = clone_client_nat_option_list(o->client_nat, &o->gc);
-        o->pre_connect->client_nat_defined = true;
-    }
-
-    o->pre_connect->route_default_gateway = o->route_default_gateway;
-    o->pre_connect->route_ipv6_default_gateway = o->route_ipv6_default_gateway;
-
-    o->pre_connect->dns_options = clone_dns_options(o->dns_options, &o->gc);
-
-    /* NCP related options that can be overwritten by a push */
-    o->pre_connect->ciphername = o->ciphername;
-    o->pre_connect->authname = o->authname;
-
-    /* Ping related options should be reset to the config values on reconnect */
-    o->pre_connect->ping_rec_timeout = o->ping_rec_timeout;
-    o->pre_connect->ping_rec_timeout_action = o->ping_rec_timeout_action;
-    o->pre_connect->ping_send_timeout = o->ping_send_timeout;
-
-    /* Miscellaneous Options */
-#ifdef USE_COMP
-    o->pre_connect->comp = o->comp;
-#endif
-}
-
-void
-pre_connect_restore(struct options *o, struct gc_arena *gc)
-{
-    const struct options_pre_connect *pp = o->pre_connect;
-    if (pp)
-    {
-        CLEAR(o->tuntap_options);
-        if (pp->tuntap_options_defined)
-        {
-            o->tuntap_options = pp->tuntap_options;
-        }
-
-        if (pp->routes_defined)
-        {
-            rol_check_alloc(o);
-            copy_route_option_list(o->routes, pp->routes, gc);
-        }
-        else
-        {
-            o->routes = NULL;
-        }
-
-        if (pp->routes_ipv6_defined)
-        {
-            rol6_check_alloc(o);
-            copy_route_ipv6_option_list(o->routes_ipv6, pp->routes_ipv6, gc);
-        }
-        else
-        {
-            o->routes_ipv6 = NULL;
-        }
-
-        o->route_default_gateway = pp->route_default_gateway;
-        o->route_ipv6_default_gateway = pp->route_ipv6_default_gateway;
-
-        /* Free DNS options and reset them to pre-pull state */
-        gc_free(&o->dns_options.gc);
-        struct gc_arena dns_gc = gc_new();
-        o->dns_options = clone_dns_options(pp->dns_options, &dns_gc);
-        o->dns_options.gc = dns_gc;
-
-        if (pp->client_nat_defined)
-        {
-            cnol_check_alloc(o);
-            copy_client_nat_option_list(o->client_nat, pp->client_nat);
-        }
-        else
-        {
-            o->client_nat = NULL;
-        }
-
-        o->foreign_option_index = pp->foreign_option_index;
-
-        o->ciphername = pp->ciphername;
-        o->authname = pp->authname;
-
-        o->ping_rec_timeout = pp->ping_rec_timeout;
-        o->ping_rec_timeout_action = pp->ping_rec_timeout_action;
-        o->ping_send_timeout = pp->ping_send_timeout;
-
-        /* Miscellaneous Options */
-#ifdef USE_COMP
-        o->comp = pp->comp;
-#endif
-    }
-
-    o->push_continuation = 0;
-    o->push_option_types_found = 0;
-    o->data_channel_crypto_flags = 0;
-}
-
 /*
  * Build an options string to represent data channel encryption options.
  * This string must match exactly between peers.  The keysize is checked
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 1b30cedd..7acffc3d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -817,8 +817,6 @@ void options_postprocess(struct options *options, struct env_set *es);
 
 bool options_postprocess_pull(struct options *o, struct env_set *es);
 
-void pre_connect_save(struct options *o);
-
 void pre_connect_restore(struct options *o, struct gc_arena *gc);
 
 bool apply_push_options(struct options *options,
-- 
2.35.1


