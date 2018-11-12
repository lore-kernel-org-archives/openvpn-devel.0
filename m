From: Arne Schwabe <arne@...1227...>
Date: Mon, 12 Nov 2018 12:56:20 +0100
Message-Id: <20181112115627.5096-7-arne@...1227...>
In-Reply-To: <20181112115627.5096-1-arne@...1227...>
References: <20181112115627.5096-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 06/13] client-connect: Change
 connection_established_flag from bool to enum
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

This prepares from the yes/no logic to a tristate logic with defered being
the third state. This deviates from Fabian's original patch that
that used a pointer being NULL or non NULL as implicit third state.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 14 ++++++++------
 src/openvpn/multi.h |  8 +++++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 10a5af9a..3dbfb63f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -574,7 +574,8 @@ static void
 multi_client_disconnect_script(struct multi_context *m,
                                struct multi_instance *mi)
 {
-    if ((mi->context.c2.context_auth == CAS_SUCCEEDED && mi->connection_established_flag)
+    if ((mi->context.c2.context_auth == CAS_SUCCEEDED &&
+         mi->client_connect_status == CC_STATUS_ESTABLISHED)
         || mi->context.c2.context_auth == CAS_PARTIAL)
     {
         multi_client_disconnect_setenv(m, mi);
@@ -2052,7 +2053,7 @@ multi_client_connect_early_setup(struct multi_context *m,
  * Try to source a dynamic config file from the
  * --client-config-dir directory.
  */
-enum client_connect_return
+static enum client_connect_return
 multi_client_connect_source_ccd(struct multi_context *m,
                                 struct multi_instance *mi,
                                 unsigned int *option_types_found)
@@ -2197,7 +2198,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         }
 
         /* set flag so we don't get called again */
-        mi->connection_established_flag = true;
+        mi->client_connect_status = CC_STATUS_ESTABLISHED;
 
         /* increment number of current authenticated clients */
         ++m->n_clients;
@@ -2480,7 +2481,8 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
         {
             /* connection is "established" when SSL/TLS key negotiation succeeds
              * and (if specified) auth user/pass succeeds */
-            if (!mi->connection_established_flag && CONNECTION_ESTABLISHED(&mi->context))
+            if (mi->client_connect_status != CC_STATUS_ESTABLISHED
+                && CONNECTION_ESTABLISHED(&mi->context))
             {
                 multi_connection_established(m, mi);
             }
@@ -3386,7 +3388,7 @@ management_client_auth(void *arg,
         {
             if (auth)
             {
-                if (!mi->connection_established_flag)
+                if (mi->client_connect_status == CC_STATUS_NOT_ESTABLISHED)
                 {
                     set_cc_config(mi, cc_config);
                     cc_config_owned = false;
@@ -3398,7 +3400,7 @@ management_client_auth(void *arg,
                 {
                     msg(D_MULTI_LOW, "MULTI: connection rejected: %s, CLI:%s", reason, np(client_reason));
                 }
-                if (mi->connection_established_flag)
+                if (mi->client_connect_status == CC_STATUS_ESTABLISHED)
                 {
                     send_auth_failed(&mi->context, client_reason); /* mid-session reauth failed */
                     multi_schedule_context_wakeup(m, mi);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7f8d4f99..c476a67e 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -63,6 +63,12 @@ struct deferred_signal_schedule_entry
     struct timeval wakeup;
 };
 
+enum client_connect_status
+{
+    CC_STATUS_NOT_ESTABLISHED,
+    CC_STATUS_ESTABLISHED
+};
+
 /**
  * Server-mode state structure for one single VPN tunnel.
  *
@@ -105,7 +111,7 @@ struct multi_instance {
     bool did_cid_hash;
     struct buffer_list *cc_config;
 #endif
-    bool connection_established_flag;
+    enum client_connect_status client_connect_status;
     bool did_iroutes;
     int n_clients_delta; /* added to multi_context.n_clients when instance is closed */
 
-- 
2.19.1


