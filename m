From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 12:03:39 +0200
Message-ID: <20251008100344.4907-1-gert@...1296...>
In-Reply-To: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
References: <gerrit.1759328122000.Ibe78949435bb2f26ad68301e2710321bf37c9486@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] PUSH_UPDATE: disabling PUSH_UPDATE
 server and client if DCO is enabled
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

The PUSH_UPDATE currently doesn't work with DCO.
For example, in server, if a new ifconfig is sent, the DCO
doesn't receive the new peer address and the connection drops.
Similarly in the client when a PUSH_UPDATE is received, the tun is
closed and reopened but the DCO doesn't receive the peer info.

Change-Id: Ibe78949435bb2f26ad68301e2710321bf37c9486
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1245
Message-Id: <20251008083046.27209-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243711/
Signed-off-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1245
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1245
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e7fc50c..0c8eb84 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1112,6 +1112,12 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, push_update_cmd))
     {
+        if (dco_enabled(&c->options))
+        {
+            msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be processed in client mode while DCO is enabled, ignoring."
+                        " To be able to process PUSH_UPDATE messages, be sure to use the --disable-dco option.");
+            return PUSH_MSG_ERROR;
+        }
         return process_incoming_push_update(c, permission_mask, option_types_found, &buf, false);
     }
     else
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 9138bdb..f306104 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -191,6 +191,13 @@
 int
 send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const int push_bundle_size)
 {
+    if (dco_enabled(&m->top.options))
+    {
+        msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be sent while DCO is enabled."
+                    " To send a PUSH_UPDATE message, be sure to use the --disable-dco option.");
+        return 0;
+    }
+
     if (!msg || !*msg || !m
         || (!target && type != UPT_BROADCAST))
     {
@@ -294,7 +301,6 @@
         }                                                             \
     } while (0)
 
-
 bool
 management_callback_send_push_update_broadcast(void *arg, const char *options)
 {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 34036f2..567560f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1926,8 +1926,12 @@
         /* support for exit notify via control channel */
         iv_proto |= IV_PROTO_CC_EXIT_NOTIFY;
 
-        /* support push-updates */
-        iv_proto |= IV_PROTO_PUSH_UPDATE;
+        /* currently push-update is not supported when DCO is enabled */
+        if (!session->opt->dco_enabled)
+        {
+            /* support push-updates */
+            iv_proto |= IV_PROTO_PUSH_UPDATE;
+        }
 
         if (session->opt->pull)
         {
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 8a5beeb..6e49f14 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -465,6 +465,7 @@
     m->instances = calloc(1, sizeof(struct multi_instance *));
     struct multi_instance *mi = calloc(1, sizeof(struct multi_instance));
     *(m->instances) = mi;
+    m->top.options.disable_dco = true;
     *state = m;
     return 0;
 }

