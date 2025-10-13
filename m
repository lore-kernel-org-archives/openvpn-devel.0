From: Gert Doering <gert@...1296...>
Date: Mon, 13 Oct 2025 11:20:43 +0200
Message-ID: <20251013092048.31770-1-gert@...1296...>
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] PUSH_UPDATE server: remove old IP(s)
 from vhash after sending a message containing ifconfig(-ipv6)
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

When sending a PUSH_UPDATE containing an ifconfig(-ipv6) option, we must add the new IP to the
multi_context vhash (hash table of the clients indexed by virtual IPs). Now in addition to
adding new client IPs, old IPs are also removed from vhash, allowing for a more complete update.

Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1253
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1253
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2863ff1..fa17bfe 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4269,46 +4269,134 @@
     close_instance(top);
 }
 
+/* Searches for the address and deletes it if it is owned by the multi_instance */
+static void
+multi_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const struct mroute_addr *addr)
+{
+    struct hash_element *he;
+    const uint32_t hv = hash_value(m->vhash, addr);
+    struct hash_bucket *bucket = hash_bucket(m->vhash, hv);
+    struct multi_route *r = NULL;
+
+    /* if route currently exists, get the instance which owns it */
+    he = hash_lookup_fast(m->vhash, bucket, addr, hv);
+    if (he)
+    {
+        r = (struct multi_route *)he->value;
+    }
+
+    /* if the route does not exist or exists but is not owned by the current instance, return */
+    if (!r || r->instance != mi)
+    {
+        return;
+    }
+
+    struct gc_arena gc = gc_new();
+    set_prefix(mi);
+    msg(D_MULTI_LOW, "MULTI: multi_unlearn_addr(): DEL %s", mroute_addr_print(&r->addr, &gc));
+    clear_prefix();
+    learn_address_script(m, NULL, "delete", &r->addr);
+    hash_remove_by_value(m->vhash, r);
+    multi_route_del(r);
+
+    gc_free(&gc);
+}
+
+/**
+ * @param m     The multi_context
+ * @param mi    The multi_instance of the client we are updating
+ * @param a     The new IPv4 address in host byte order
+ */
+static void
+multi_unlearn_in_addr_t(struct multi_context *m, struct multi_instance *mi, in_addr_t a)
+{
+    struct mroute_addr addr;
+    CLEAR(addr);
+
+    addr.type = MR_ADDR_IPV4;
+    addr.len = 4;
+    addr.v4.addr = a;
+
+    multi_unlearn_addr(m, mi, &addr);
+}
+
+/**
+ * @param m     The multi_context
+ * @param mi    The multi_instance of the client we are updating
+ * @param a6    The new IPv6 address in host byte order
+ */
+static void
+multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *mi, struct in6_addr a6)
+{
+    struct mroute_addr addr;
+    CLEAR(addr);
+
+    addr.type = MR_ADDR_IPV6;
+    addr.len = 16;
+    addr.v6.addr = a6;
+
+    multi_unlearn_addr(m, mi, &addr);
+}
+
 /**
  * Update the vhash with new IP/IPv6 addresses in the multi_context when a
  * push-update message containing ifconfig/ifconfig-ipv6 options is sent
- * from the server. This function should be called after a push-update
- * and old_ip/old_ipv6 are the previous addresses of the client in
- * ctx->options.ifconfig_local and ctx->options.ifconfig_ipv6_local.
+ * from the server.
+ *
+ * @param m         The multi_context
+ * @param mi        The multi_instance of the client we are updating
+ * @param new_ip    The new IPv4 address or NULL if no change
+ * @param new_ipv6  The new IPv6 address or NULL if no change
  */
 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const char *old_ip, const char *old_ipv6)
+update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
 {
-    struct in_addr addr;
-    struct in6_addr new_ipv6;
-
-    if ((mi->context.options.ifconfig_local && (!old_ip || strcmp(old_ip, mi->context.options.ifconfig_local)))
-        && inet_pton(AF_INET, mi->context.options.ifconfig_local, &addr) == 1)
+    if (new_ip)
     {
-        in_addr_t new_ip = ntohl(addr.s_addr);
+        in_addr_t old_addr = 0;
+        struct in_addr new_addr;
+        CLEAR(new_addr);
+
+        /* Remove old IP */
+        if (mi->context.c2.push_ifconfig_defined)
+        {
+            old_addr = ntohl(mi->context.c2.push_ifconfig_local);
+            multi_unlearn_in_addr_t(m, mi, old_addr);
+            mi->context.c2.push_ifconfig_defined = false;
+            mi->context.c2.push_ifconfig_local = 0;
+        }
 
         /* Add new IP */
-        multi_learn_in_addr_t(m, mi, new_ip, -1, true);
+        if (inet_pton(AF_INET, new_ip, &new_addr) == 1
+            && multi_learn_in_addr_t(m, mi, ntohl(new_addr.s_addr), -1, true))
+        {
+            mi->context.c2.push_ifconfig_defined = true;
+            mi->context.c2.push_ifconfig_local = new_addr.s_addr;
+        }
     }
 
-    /* TO DO:
-     *  else if (old_ip)
-     *  {
-     *      // remove old IP
-     *  }
-     */
-
-    if ((mi->context.options.ifconfig_ipv6_local && (!old_ipv6 || strcmp(old_ipv6, mi->context.options.ifconfig_ipv6_local)))
-        && inet_pton(AF_INET6, mi->context.options.ifconfig_ipv6_local, &new_ipv6) == 1)
+    if (new_ipv6)
     {
-        /* Add new IPv6 */
-        multi_learn_in6_addr(m, mi, new_ipv6, -1, true);
-    }
+        struct in6_addr new_addr6;
+        struct in6_addr old_addr6;
+        CLEAR(new_addr6);
+        CLEAR(old_addr6);
 
-    /* TO DO:
-     *  else if (old_ipv6)
-     *  {
-     *      // remove old IPv6
-     *  }
-     */
+        /* Remove old IPv6 */
+        if (mi->context.c2.push_ifconfig_ipv6_defined)
+        {
+            old_addr6 = mi->context.c2.push_ifconfig_ipv6_local;
+            multi_unlearn_in6_addr(m, mi, old_addr6);
+            mi->context.c2.push_ifconfig_ipv6_defined = false;
+            CLEAR(mi->context.c2.push_ifconfig_ipv6_local);
+        }
+
+        /* Add new IPv6 */
+        if (inet_pton(AF_INET6, new_ipv6, &new_addr6) == 1
+            && multi_learn_in6_addr(m, mi, new_addr6, -1, true))
+        {
+            mi->context.c2.push_ifconfig_ipv6_defined = true;
+            mi->context.c2.push_ifconfig_ipv6_local = new_addr6;
+        }
+    }
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index b2b892b..a9d643f 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -692,6 +692,6 @@
 #endif
 
 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const char *old_ip, const char *old_ipv6);
+update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6);
 
 #endif /* MULTI_H */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 0c8eb84..2c717c7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1118,7 +1118,7 @@
                         " To be able to process PUSH_UPDATE messages, be sure to use the --disable-dco option.");
             return PUSH_MSG_ERROR;
         }
-        return process_incoming_push_update(c, permission_mask, option_types_found, &buf, false);
+        return process_push_update(c, &c->options, permission_mask, option_types_found, &buf, false);
     }
     else
     {
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 6b3275e..19a029a 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -61,11 +61,13 @@
  * message has not yet been received.
  *
  * @param c The context for the operation.
+ * @param o The options structure to be updated with the received push options.
  * @param permission_mask The permission mask specifying which options are allowed to be pulled.
  * @param option_types_found A pointer to a variable that will be filled with the types of options
  *                           found in the message.
  * @param buf A buffer containing the received message.
- * @param msg_sender A boolean indicating if function is called by the message sender (server).
+ * @param msg_sender A boolean indicating if the message is being processed on the client (false)
+ *                   or on the server (true).
  *
  * @return
  * - `PUSH_MSG_UPDATE`: The message was processed successfully, and the updates were applied.
@@ -74,9 +76,8 @@
  * - `PUSH_MSG_ERROR`: An error occurred during message processing, or the message is invalid.
  */
 
-int process_incoming_push_update(struct context *c, unsigned int permission_mask,
-                                 unsigned int *option_types_found, struct buffer *buf,
-                                 bool msg_sender);
+int process_push_update(struct context *c, struct options *o, unsigned int permission_mask,
+                        unsigned int *option_types_found, struct buffer *buf, bool msg_sender);
 
 int process_incoming_push_msg(struct context *c, const struct buffer *buffer,
                               bool honor_received_options, unsigned int permission_mask,
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 25c6ebe..1b00b75 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -16,18 +16,17 @@
 #endif
 
 int
-process_incoming_push_update(struct context *c, unsigned int permission_mask,
-                             unsigned int *option_types_found, struct buffer *buf,
-                             bool msg_sender)
+process_push_update(struct context *c, struct options *o, unsigned int permission_mask,
+                    unsigned int *option_types_found, struct buffer *buf, bool msg_sender)
 {
     int ret = PUSH_MSG_ERROR;
     const uint8_t ch = buf_read_u8(buf);
     if (ch == ',')
     {
-        if (apply_push_options(c, &c->options, buf, permission_mask, option_types_found, c->c2.es,
+        if (apply_push_options(c, o, buf, permission_mask, option_types_found, c->c2.es,
                                true))
         {
-            switch (c->options.push_continuation)
+            switch (o->push_continuation)
             {
                 case 0:
                 case 1:
@@ -144,13 +143,18 @@
 
 /* send the message(s) prepared to one single client */
 static bool
-send_single_push_update(struct context *c, struct buffer *msgs, unsigned int *option_types_found)
+send_single_push_update(struct multi_context *m, struct multi_instance *mi, struct buffer *msgs)
 {
     if (!msgs[0].data || !*(msgs[0].data))
     {
         return false;
     }
+
     int i = -1;
+    unsigned int option_types_found = 0;
+    struct context *c = &mi->context;
+    struct options o;
+    CLEAR(o);
 
     while (msgs[++i].data && *(msgs[i].data))
     {
@@ -159,14 +163,14 @@
             return false;
         }
 
-        /* After sending the control message, we update the options
-         * server-side in the client's context so pushed options like
-         * ifconfig/ifconfig-ipv6 can actually work.
+        /* After sending the control message, we parse it, miming the behavior
+         * of `process_incoming_push_msg()` and we fill an empty `options` struct
+         * with the new options. If an `ifconfig_local` or `ifconfig_ipv6_local`
+         * options is found we update the vhash accordingly, so that the pushed
+         * ifconfig/ifconfig-ipv6 options can actually work.
          * If we don't do that, packets arriving from the client with the
          * new address will be rejected and packets for the new address
          * will not be routed towards the client.
-         * For the same reason we later update the vhash too in
-         * `send_push_update()` function.
          * Using `buf_string_compare_advance()` we mimic the behavior
          * inside `process_incoming_push_msg()`. However, we don't need
          * to check the return value here because we just want to `advance`,
@@ -176,17 +180,18 @@
          */
         struct buffer tmp_msg = msgs[i];
         buf_string_compare_advance(&tmp_msg, push_update_cmd);
-        if (process_incoming_push_update(c, pull_permission_mask(c), option_types_found, &tmp_msg, true) == PUSH_MSG_ERROR)
+        unsigned int permission_mask = pull_permission_mask(c);
+        if (process_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg, true) == PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->peer_id);
-            continue;
-        }
-        c->options.push_option_types_found |= *option_types_found;
-        if (!options_postprocess_pull(&c->options, c->c2.es))
-        {
-            msg(M_WARN, "Failed to post-process push update message sent to client ID: %u", c->c2.tls_multi->peer_id);
         }
     }
+
+    if (option_types_found & OPT_P_UP)
+    {
+        update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
+    }
+
     return true;
 }
 
@@ -229,8 +234,6 @@
     int msgs_num = (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) != 0);
     struct buffer *msgs = gc_malloc((msgs_num + 1) * sizeof(struct buffer), true, &gc);
 
-    unsigned int option_types_found = 0;
-
     msgs[msgs_num].data = NULL;
     if (!message_splitter(msg, msgs, &gc, safe_cap))
     {
@@ -255,15 +258,9 @@
             return 0;
         }
 
-        const char *old_ip = mi->context.options.ifconfig_local;
-        const char *old_ipv6 = mi->context.options.ifconfig_ipv6_local;
         if (!mi->halt
-            && send_single_push_update(&mi->context, msgs, &option_types_found))
+            && send_single_push_update(m, mi, msgs))
         {
-            if (option_types_found & OPT_P_UP)
-            {
-                update_vhash(m, mi, old_ip, old_ipv6);
-            }
             gc_free(&gc);
             return 1;
         }
@@ -289,18 +286,11 @@
         }
 
         /* Type is UPT_BROADCAST so we update every client */
-        option_types_found = 0;
-        const char *old_ip = curr_mi->context.options.ifconfig_local;
-        const char *old_ipv6 = curr_mi->context.options.ifconfig_ipv6_local;
-        if (!send_single_push_update(&curr_mi->context, msgs, &option_types_found))
+        if (!send_single_push_update(m, curr_mi, msgs))
         {
             msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context.c2.tls_multi->peer_id);
             continue;
         }
-        if (option_types_found & OPT_P_UP)
-        {
-            update_vhash(m, curr_mi, old_ip, old_ipv6);
-        }
         count++;
     }
 
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 60596ed..d397922 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -29,7 +29,7 @@
 }
 
 void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const char *old_ip, const char *old_ipv6)
+update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
 {
     return;
 }
@@ -95,7 +95,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, push_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_types_found, &buf, false);
+        return process_push_update(c, &c->options, permission_mask, option_types_found, &buf, false);
     }
     else
     {

