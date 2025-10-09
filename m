From: Gert Doering <gert@...1296...>
Date: Thu,  9 Oct 2025 20:28:49 +0200
Message-ID: <20251009182855.18712-1-gert@...1296...>
In-Reply-To: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
References: <gerrit.1759923063000.I7c28da72be11c7efbed3068fbfc65f2959227bec@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] PUSH_UPDATE server: check IV_PROTO
 before sending the message to the client
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

From: Marco Baffo <marco@...2726...>

Before sending the PUSH_UPDATE message to the client, we must verify that
the client has actually sent IV_PROTO_PUSH_UPDATE to the server, declaring that
it supports push-updates.

Also fixed a gc_arena memory leak in one of the error paths and asserted
mi->context.c2.tls_multi .

Change-Id: I7c28da72be11c7efbed3068fbfc65f2959227bec
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1255
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1255
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f306104..3fa099c 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -7,6 +7,7 @@
 
 #ifdef ENABLE_MANAGEMENT
 #include "multi.h"
+#include "ssl_util.h"
 #endif
 
 #if defined(__GNUC__) || defined(__clang__)
@@ -174,20 +175,32 @@
         buf_string_compare_advance(&msgs[i], push_update_cmd);
         if (process_incoming_push_update(c, pull_permission_mask(c), option_types_found, &msgs[i], true) == PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push update message sent to client ID: %u",
-                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+            msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->peer_id);
             continue;
         }
         c->options.push_option_types_found |= *option_types_found;
         if (!options_postprocess_pull(&c->options, c->c2.es))
         {
-            msg(M_WARN, "Failed to post-process push update message sent to client ID: %u",
-                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+            msg(M_WARN, "Failed to post-process push update message sent to client ID: %u", c->c2.tls_multi->peer_id);
         }
     }
     return true;
 }
 
+/* Return true if the client supports push-update */
+static bool
+support_push_update(struct multi_instance *mi)
+{
+    ASSERT(mi->context.c2.tls_multi);
+    const unsigned int iv_proto_peer = extract_iv_proto(mi->context.c2.tls_multi->peer_info);
+    if (!(iv_proto_peer & IV_PROTO_PUSH_UPDATE))
+    {
+        return false;
+    }
+
+    return true;
+}
+
 int
 send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const int push_bundle_size)
 {
@@ -228,9 +241,17 @@
 
         if (!mi)
         {
+            gc_free(&gc);
             return -ENOENT;
         }
 
+        if (!support_push_update(mi))
+        {
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->context.c2.tls_multi->peer_id);
+            gc_free(&gc);
+            return 0;
+        }
+
         const char *old_ip = mi->context.options.ifconfig_local;
         const char *old_ipv6 = mi->context.options.ifconfig_ipv6_local;
         if (!mi->halt
@@ -259,7 +280,7 @@
     {
         struct multi_instance *curr_mi = he->value;
 
-        if (curr_mi->halt)
+        if (curr_mi->halt || !support_push_update(curr_mi))
         {
             continue;
         }
@@ -270,8 +291,7 @@
         const char *old_ipv6 = curr_mi->context.options.ifconfig_ipv6_local;
         if (!send_single_push_update(&curr_mi->context, msgs, &option_types_found))
         {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
-                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_multi->peer_id : UINT32_MAX);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context.c2.tls_multi->peer_id);
             continue;
         }
         if (option_types_found & OPT_P_UP)
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 6e49f14..60596ed 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -144,7 +144,13 @@
 {
     return true;
 }
-#endif /* ifndef ENABLE_MANAGEMENT */
+
+unsigned int
+extract_iv_proto(const char *peer_info)
+{
+    return IV_PROTO_PUSH_UPDATE;
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
 
 /* tests */
 
@@ -464,6 +470,7 @@
     struct multi_context *m = calloc(1, sizeof(struct multi_context));
     m->instances = calloc(1, sizeof(struct multi_instance *));
     struct multi_instance *mi = calloc(1, sizeof(struct multi_instance));
+    mi->context.c2.tls_multi = calloc(1, sizeof(struct tls_multi));
     *(m->instances) = mi;
     m->top.options.disable_dco = true;
     *state = m;
@@ -474,6 +481,7 @@
 teardown2(void **state)
 {
     struct multi_context *m = *state;
+    free((*(m->instances))->context.c2.tls_multi);
     free(*(m->instances));
     free(m->instances);
     free(m);

