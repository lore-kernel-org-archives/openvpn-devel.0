From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 14:00:27 +0200
Message-Id: <20210408120029.19438-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] Always save/restore pull options
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

The makes the code path for pull and non-pull more aligned and even
though this might do extra work for non-pull scenarios, saving the
few bytes of memory is not a worthwhile optimisation here.

Additionally with the upcoming P2P mode NCP, the client needs to
save/restore a subset of these options anyway.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    |  6 ++--
 src/openvpn/options.c | 66 +++++++++++++++++++++----------------------
 src/openvpn/options.h |  8 +++---
 3 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fb3d6beaa..e62aace51 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4052,10 +4052,8 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         }
     }
 
-    if (c->options.pull)
-    {
-        pre_pull_restore(&c->options, &c->c2.gc);
-    }
+    /* Resets all values to the initial values from the config where needed */
+    pre_connect_restore(&c->options, &c->c2.gc);
 
     /* map in current connection entry */
     next_connection_entry(c);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 09e93df80..a72e1b9ae 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3209,9 +3209,10 @@ options_postprocess_mutate(struct options *o)
     }
 
     /*
-     * Save certain parms before modifying options via --pull
+     * Save certain parms before modifying options during connect, especially
+     * when using --pull
      */
-    pre_pull_save(o);
+    pre_connect_save(o);
 }
 
 /*
@@ -3566,46 +3567,43 @@ options_postprocess(struct options *options)
  */
 
 void
-pre_pull_save(struct options *o)
+pre_connect_save(struct options *o)
 {
-    if (o->pull)
-    {
-        ALLOC_OBJ_CLEAR_GC(o->pre_pull, struct options_pre_pull, &o->gc);
-        o->pre_pull->tuntap_options = o->tuntap_options;
-        o->pre_pull->tuntap_options_defined = true;
-        o->pre_pull->foreign_option_index = o->foreign_option_index;
-        if (o->routes)
-        {
-            o->pre_pull->routes = clone_route_option_list(o->routes, &o->gc);
-            o->pre_pull->routes_defined = true;
-        }
-        if (o->routes_ipv6)
-        {
-            o->pre_pull->routes_ipv6 = clone_route_ipv6_option_list(o->routes_ipv6, &o->gc);
-            o->pre_pull->routes_ipv6_defined = true;
-        }
-        if (o->client_nat)
-        {
-            o->pre_pull->client_nat = clone_client_nat_option_list(o->client_nat, &o->gc);
-            o->pre_pull->client_nat_defined = true;
-        }
-
-        /* NCP related options that can be overwritten by a push */
-        o->pre_pull->ciphername = o->ciphername;
-        o->pre_pull->authname = o->authname;
+    ALLOC_OBJ_CLEAR_GC(o->pre_connect, struct options_pre_connect, &o->gc);
+    o->pre_connect->tuntap_options = o->tuntap_options;
+    o->pre_connect->tuntap_options_defined = true;
+    o->pre_connect->foreign_option_index = o->foreign_option_index;
 
-        /* Ping related options should be reset to the config values on reconnect */
-        o->pre_pull->ping_rec_timeout = o->ping_rec_timeout;
-        o->pre_pull->ping_rec_timeout_action = o->ping_rec_timeout_action;
-        o->pre_pull->ping_send_timeout = o->ping_send_timeout;
+    if (o->routes)
+    {
+        o->pre_connect->routes = clone_route_option_list(o->routes, &o->gc);
+        o->pre_connect->routes_defined = true;
+    }
+    if (o->routes_ipv6)
+    {
+        o->pre_connect->routes_ipv6 = clone_route_ipv6_option_list(o->routes_ipv6, &o->gc);
+        o->pre_connect->routes_ipv6_defined = true;
     }
+    if (o->client_nat)
+    {
+        o->pre_connect->client_nat = clone_client_nat_option_list(o->client_nat, &o->gc);
+        o->pre_connect->client_nat_defined = true;
+    }
+
+    /* NCP related options that can be overwritten by a push */
+    o->pre_connect->ciphername = o->ciphername;
+    o->pre_connect->authname = o->authname;
 
+    /* Ping related options should be reset to the config values on reconnect */
+    o->pre_connect->ping_rec_timeout = o->ping_rec_timeout;
+    o->pre_connect->ping_rec_timeout_action = o->ping_rec_timeout_action;
+    o->pre_connect->ping_send_timeout = o->ping_send_timeout;
 }
 
 void
-pre_pull_restore(struct options *o, struct gc_arena *gc)
+pre_connect_restore(struct options *o, struct gc_arena *gc)
 {
-    const struct options_pre_pull *pp = o->pre_pull;
+    const struct options_pre_connect *pp = o->pre_connect;
     if (pp)
     {
         CLEAR(o->tuntap_options);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d3db33ece..078bed75b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -59,7 +59,7 @@
 extern const char title_string[];
 
 /* certain options are saved before --pull modifications are applied */
-struct options_pre_pull
+struct options_pre_connect
 {
     bool tuntap_options_defined;
     struct tuntap_options tuntap_options;
@@ -493,7 +493,7 @@ struct options
     int push_continuation;
     unsigned int push_option_types_found;
     const char *auth_user_pass_file;
-    struct options_pre_pull *pre_pull;
+    struct options_pre_connect *pre_connect;
 
     int scheduled_exit_interval;
 
@@ -787,9 +787,9 @@ char *options_string_extract_option(const char *options_string,
 
 void options_postprocess(struct options *options);
 
-void pre_pull_save(struct options *o);
+void pre_connect_save(struct options *o);
 
-void pre_pull_restore(struct options *o, struct gc_arena *gc);
+void pre_connect_restore(struct options *o, struct gc_arena *gc);
 
 bool apply_push_options(struct options *options,
                         struct buffer *buf,
-- 
2.31.1


