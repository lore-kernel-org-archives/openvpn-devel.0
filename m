From: Arne Schwabe <arne@...1227...>
Date: Fri,  3 Jul 2020 11:55:06 +0200
Message-Id: <20200703095506.28559-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove did_open_context,
 defined and connection_established_flag
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

multi_instance->defined is not used anywhere.

did_open_context is always set to true when a context is created in
multi_create_instance, so checking it for true is always true.

context_auth is also always set to CAS_PENDING in multi_create_instance.

connection_established_flag is only set to true if context_auth
is changed from CAS_PENDING to one another state, so we can also check
for cas_context != CAS_PENDING.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 18 ++++++------------
 src/openvpn/multi.h |  3 ---
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e9f021bb..6923d2ce 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -574,7 +574,7 @@ multi_client_disconnect_setenv(struct multi_instance *mi)
 static void
 multi_client_disconnect_script(struct multi_instance *mi)
 {
-    if ((mi->context.c2.context_auth == CAS_SUCCEEDED && mi->connection_established_flag)
+    if (mi->context.c2.context_auth == CAS_SUCCEEDED
         || mi->context.c2.context_auth == CAS_PARTIAL)
     {
         multi_client_disconnect_setenv(mi);
@@ -686,10 +686,7 @@ multi_close_instance(struct multi_context *m,
 
     multi_client_disconnect_script(mi);
 
-    if (mi->did_open_context)
-    {
-        close_context(&mi->context, SIGTERM, CC_GC_FREE);
-    }
+    close_context(&mi->context, SIGTERM, CC_GC_FREE);
 
     multi_tcp_instance_specific_free(mi);
 
@@ -788,7 +785,6 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
         generate_prefix(mi);
     }
 
-    mi->did_open_context = true;
     inherit_context_child(&mi->context, &m->top);
     if (IS_SIG(&mi->context))
     {
@@ -2089,9 +2085,6 @@ script_failed:
             mi->context.c2.context_auth = cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
         }
 
-        /* set flag so we don't get called again */
-        mi->connection_established_flag = true;
-
         /* increment number of current authenticated clients */
         ++m->n_clients;
         update_mstat_n_clients(m->n_clients);
@@ -2395,7 +2388,8 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
         {
             /* connection is "established" when SSL/TLS key negotiation succeeds
              * and (if specified) auth user/pass succeeds */
-            if (!mi->connection_established_flag && CONNECTION_ESTABLISHED(&mi->context))
+            if (mi->context.c2.context_auth == CAS_PENDING
+                && CONNECTION_ESTABLISHED(&mi->context))
             {
                 multi_connection_established(m, mi);
             }
@@ -3349,7 +3343,7 @@ management_client_auth(void *arg,
         {
             if (auth)
             {
-                if (!mi->connection_established_flag)
+                if (mi->context.c2.context_auth == CAS_PENDING)
                 {
                     set_cc_config(mi, cc_config);
                     cc_config_owned = false;
@@ -3361,7 +3355,7 @@ management_client_auth(void *arg,
                 {
                     msg(D_MULTI_LOW, "MULTI: connection rejected: %s, CLI:%s", reason, np(client_reason));
                 }
-                if (mi->connection_established_flag)
+                if (mi->context.c2.context_auth != CAS_PENDING)
                 {
                     send_auth_failed(&mi->context, client_reason); /* mid-session reauth failed */
                     multi_schedule_context_wakeup(m, mi);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3d949e30..8c9c4609 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -75,7 +75,6 @@ struct deferred_signal_schedule_entry
 struct multi_instance {
     struct schedule_entry se;  /* this must be the first element of the structure */
     struct gc_arena gc;
-    bool defined;
     bool halt;
     int refcount;
     int route_count;           /* number of routes (including cached routes) owned by this instance */
@@ -97,14 +96,12 @@ struct multi_instance {
     in_addr_t reporting_addr;     /* IP address shown in status listing */
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing */
 
-    bool did_open_context;
     bool did_real_hash;
     bool did_iter;
 #ifdef MANAGEMENT_DEF_AUTH
     bool did_cid_hash;
     struct buffer_list *cc_config;
 #endif
-    bool connection_established_flag;
     bool did_iroutes;
     int n_clients_delta; /* added to multi_context.n_clients when instance is closed */
 
-- 
2.26.2


