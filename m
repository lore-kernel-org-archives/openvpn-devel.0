From: Gert Doering <gert@...1296...>
Date: Wed,  3 Sep 2025 18:48:20 +0200
Message-ID: <20250903164826.13284-1-gert@...1296...>
In-Reply-To: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v25] PUSH_UPDATE message sender: enabling
 the server to send PUSH_UPDATE control messages
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

Using the management interface you can now target one or more clients (via broadcast
or via cid) and send a PUSH_UPDATE control message
to update some options.

Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/869
This mail reflects revision 25 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3866e21..97f0310 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -862,6 +862,7 @@
 	    src/openvpn/push_util.c
 	    src/openvpn/options_util.c
 	    src/openvpn/otime.c
+        src/openvpn/list.c
         )
 
     if (TARGET test_argv)
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index f1d2930..ada536e 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -1028,6 +1028,35 @@
 stored outside of the filesystem (e.g. in Mac OS X Keychain)
 with OpenVPN via the management interface.
 
+COMMAND -- push-update-broad (OpenVPN 2.7 or higher)
+----------------------------------------------------
+Send a message to every connected client to update options at runtime.
+The updatable options are: "block-ipv6", "block-outside-dns", "dhcp-option",
+"dns", "ifconfig", "ifconfig-ipv6", "redirect-gateway", "redirect-private",
+"route", "route-gateway", "route-ipv6", "route-metric", "topology",
+"tun-mtu", "keepalive". When a valid option is pushed, the receiving client will
+delete every previous value and set new value, so the update of the option will 
+not be incremental even when theoretically possible (ex. with "redirect-gateway").
+The '-' symbol in front of an option means the option should be removed.
+When an option is used with '-', it cannot take any parameter.
+The '?' symbol in front of an option means the option's update is optional
+so if the client do not support it, that option will just be ignored without
+making fail the entire command. The '-' and '?' symbols can be used together.
+
+Option Format Ex.
+  `-?option`, `-option`, `?option parameters` are valid formats,
+  `?-option` is not a valid format.
+
+Example
+  push-update-broad "route 10.10.10.1 255.255.255.255, -dns, ?tun-mtu 1400"
+
+COMMAND -- push-update-cid (OpenVPN 2.7 or higher)
+----------------------------------------------------
+Same as push-update-broad but you must target a single client using client id.
+
+Example
+  push-update-cid 42 "route 10.10.10.1 255.255.255.255, -dns, ?tun-mtu 1400"
+
 OUTPUT FORMAT
 -------------
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aed04f5..21231b5 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -23,7 +23,6 @@
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #endif
-
 #include "syshead.h"
 
 #ifdef ENABLE_MANAGEMENT
@@ -41,6 +40,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "push.h"
 
 #include "memdbg.h"
 
@@ -131,8 +131,10 @@
     msg(M_CLIENT, "test n                 : Produce n lines of output for testing/debugging.");
     msg(M_CLIENT, "username type u        : Enter username u for a queried OpenVPN username.");
     msg(M_CLIENT, "verb [n]               : Set log verbosity level to n, or show if n is absent.");
-    msg(M_CLIENT,
-        "version [n]            : Set client's version to n or show current version of daemon.");
+    msg(M_CLIENT, "version [n]            : Set client's version to n or show current version of daemon.");
+    msg(M_CLIENT, "push-update-broad options : Broadcast a message to update the specified options.");
+    msg(M_CLIENT, "                            Ex. push-update-broad \"route something, -dns\"");
+    msg(M_CLIENT, "push-update-cid CID options : Send an update message to the client identified by CID.");
     msg(M_CLIENT, "END");
 }
 
@@ -1306,6 +1308,48 @@
 }
 
 static void
+man_push_update(struct management *man, const char **p, const push_update_type type)
+{
+    bool status = false;
+
+    if (type == UPT_BROADCAST)
+    {
+        if (!man->persist.callback.push_update_broadcast)
+        {
+            man_command_unsupported("push-update-broad");
+            return;
+        }
+
+        status = (*man->persist.callback.push_update_broadcast)(man->persist.callback.arg, p[1]);
+    }
+    else if (type == UPT_BY_CID)
+    {
+        if (!man->persist.callback.push_update_by_cid)
+        {
+            man_command_unsupported("push-update-cid");
+            return;
+        }
+
+        unsigned long cid = 0;
+
+        if (!parse_cid(p[1], &cid))
+        {
+            msg(M_CLIENT, "ERROR: push-update-cid fail during cid parsing");
+            return;
+        }
+
+        status = (*man->persist.callback.push_update_by_cid)(man->persist.callback.arg, cid, p[2]);
+    }
+
+    if (status)
+    {
+        msg(M_CLIENT, "SUCCESS: push-update command succeeded");
+        return;
+    }
+    msg(M_CLIENT, "ERROR: push-update command failed");
+}
+
+static void
 man_dispatch_command(struct management *man, struct status_output *so, const char **p,
                      const int nparms)
 {
@@ -1628,6 +1672,20 @@
             man_remote(man, p);
         }
     }
+    else if (streq(p[0], "push-update-broad"))
+    {
+        if (man_need(man, p, 1, 0))
+        {
+            man_push_update(man, p, UPT_BROADCAST);
+        }
+    }
+    else if (streq(p[0], "push-update-cid"))
+    {
+        if (man_need(man, p, 2, 0))
+        {
+            man_push_update(man, p, UPT_BY_CID);
+        }
+    }
 #if 1
     else if (streq(p[0], "test"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 083caf5..b3c9cc8 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -43,7 +43,6 @@
 #define MF_EXTERNAL_KEY_PSSPAD    (1 << 16)
 #define MF_EXTERNAL_KEY_DIGEST    (1 << 17)
 
-
 #ifdef ENABLE_MANAGEMENT
 
 #include "misc.h"
@@ -199,6 +198,8 @@
 #endif
     unsigned int (*remote_entry_count)(void *arg);
     bool (*remote_entry_get)(void *arg, unsigned int index, char **remote);
+    bool (*push_update_broadcast)(void *arg, const char *options);
+    bool (*push_update_by_cid)(void *arg, unsigned long cid, const char *options);
 };
 
 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e1ce32a..59bdcb4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3989,7 +3989,7 @@
     }
 }
 
-static struct multi_instance *
+struct multi_instance *
 lookup_by_cid(struct multi_context *m, const unsigned long cid)
 {
     if (m)
@@ -4130,6 +4130,8 @@
         cb.client_auth = management_client_auth;
         cb.client_pending_auth = management_client_pending_auth;
         cb.get_peer_info = management_get_peer_info;
+        cb.push_update_broadcast = management_callback_send_push_update_broadcast;
+        cb.push_update_by_cid = management_callback_send_push_update_by_cid;
         management_set_callback(management, &cb);
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
@@ -4254,3 +4256,47 @@
     multi_top_free(&multi);
     close_instance(top);
 }
+
+/**
+ * Update the vhash with new IP/IPv6 addresses in the multi_context when a
+ * push-update message containing ifconfig/ifconfig-ipv6 options is sent
+ * from the server. This function should be called after a push-update
+ * and old_ip/old_ipv6 are the previous addresses of the client in
+ * ctx->options.ifconfig_local and ctx->options.ifconfig_ipv6_local.
+ */
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const char *old_ip, const char *old_ipv6)
+{
+    struct in_addr addr;
+    struct in6_addr new_ipv6;
+
+    if ((mi->context.options.ifconfig_local && (!old_ip || strcmp(old_ip, mi->context.options.ifconfig_local)))
+        && inet_pton(AF_INET, mi->context.options.ifconfig_local, &addr) == 1)
+    {
+        in_addr_t new_ip = ntohl(addr.s_addr);
+
+        /* Add new IP */
+        multi_learn_in_addr_t(m, mi, new_ip, -1, true);
+    }
+
+    /* TO DO:
+     *  else if (old_ip)
+     *  {
+     *      // remove old IP
+     *  }
+     */
+
+    if ((mi->context.options.ifconfig_ipv6_local && (!old_ipv6 || strcmp(old_ipv6, mi->context.options.ifconfig_ipv6_local)))
+        && inet_pton(AF_INET6, mi->context.options.ifconfig_ipv6_local, &new_ipv6) == 1)
+    {
+        /* Add new IPv6 */
+        multi_learn_in6_addr(m, mi, new_ipv6, -1, true);
+    }
+
+    /* TO DO:
+     *  else if (old_ipv6)
+     *  {
+     *      // remove old IPv6
+     *  }
+     */
+}
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index e87e465..3a6ac7f 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -686,5 +686,13 @@
  */
 void multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi);
 
+#ifdef ENABLE_MANAGEMENT
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const unsigned long cid);
+
+#endif
+
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const char *old_ip, const char *old_ipv6);
 
 #endif /* MULTI_H */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0b16c5a..1f188e6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5488,7 +5488,6 @@
             {
                 continue; /* Ignoring this option */
             }
-            throw_signal_soft(SIGUSR1, "Offending option received from server");
             return false; /* Cause push/pull error and stop push processing */
         }
 
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index c3938a7..b8346a6 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -205,11 +205,11 @@
     {
         if (*flags & PUSH_OPT_OPTIONAL)
         {
-            msg(D_PUSH, "Pushed option is not updatable: '%s'. Ignoring.", line);
+            msg(D_PUSH, "Pushed dispensable option is not updatable: '%s'. Ignoring.", line);
         }
         else
         {
-            msg(M_WARN, "Pushed option is not updatable: '%s'. Restarting.", line);
+            msg(M_WARN, "Pushed option is not updatable: '%s'.", line);
             return false;
         }
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 4f6adfc..1ea7ed9 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1073,6 +1073,10 @@
                     break;
             }
         }
+        else
+        {
+            throw_signal_soft(SIGUSR1, "Offending option received from server");
+        }
     }
     else if (ch == '\0')
     {
@@ -1100,7 +1104,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, push_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_types_found, &buf);
+        return process_incoming_push_update(c, permission_mask, option_types_found, &buf, false);
     }
     else
     {
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 22b940f..8ffd0c2 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -41,6 +41,15 @@
 #define PUSH_OPT_TO_REMOVE (1 << 0)
 #define PUSH_OPT_OPTIONAL  (1 << 1)
 
+#ifdef ENABLE_MANAGEMENT
+/* Push-update message sender modes */
+typedef enum
+{
+    UPT_BROADCAST = 0,
+    UPT_BY_CID = 1
+} push_update_type;
+#endif
+
 int process_incoming_push_request(struct context *c);
 
 /**
@@ -56,6 +65,7 @@
  * @param option_types_found A pointer to a variable that will be filled with the types of options
  *                           found in the message.
  * @param buf A buffer containing the received message.
+ * @param msg_sender A boolean indicating if function is called by the message sender (server).
  *
  * @return
  * - `PUSH_MSG_UPDATE`: The message was processed successfully, and the updates were applied.
@@ -65,7 +75,8 @@
  */
 
 int process_incoming_push_update(struct context *c, unsigned int permission_mask,
-                                 unsigned int *option_types_found, struct buffer *buf);
+                                 unsigned int *option_types_found, struct buffer *buf,
+                                 bool msg_sender);
 
 int process_incoming_push_msg(struct context *c, const struct buffer *buffer,
                               bool honor_received_options, unsigned int permission_mask,
@@ -127,4 +138,28 @@
  */
 void receive_auth_pending(struct context *c, const struct buffer *buffer);
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * @brief A function to send a PUSH_UPDATE control message from server to client(s).
+ *
+ * @param m the multi_context, contains all the clients connected to this server.
+ * @param target the target to which to send the message. It should be:
+ * `NULL` if `type == UPT_BROADCAST`,
+ * a `mroute_addr *` if `type == UPT_BY_ADDR`,
+ * a `char *` if `type == UPT_BY_CN`,
+ * an `unsigned long *` if `type == UPT_BY_CID`.
+ * @param msg a string containing the options to send.
+ * @param type the way to address the message (broadcast, by cid, by cn, by address).
+ * @param push_bundle_size the maximum size of a bundle of pushed option. Just use PUSH_BUNDLE_SIZE macro.
+ * @return the number of clients to which the message was sent.
+ */
+int
+send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const int push_bundle_size);
+
+bool management_callback_send_push_update_broadcast(void *arg, const char *options);
+
+bool management_callback_send_push_update_by_cid(void *arg, unsigned long cid, const char *options);
+
+#endif /* ifdef ENABLE_MANAGEMENT*/
+
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 0862a74..193020b 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -3,10 +3,16 @@
 #endif
 
 #include "push.h"
+#include "buffer.h"
+
+#ifdef ENABLE_MANAGEMENT
+#include "multi.h"
+#endif
 
 int
 process_incoming_push_update(struct context *c, unsigned int permission_mask,
-                             unsigned int *option_types_found, struct buffer *buf)
+                             unsigned int *option_types_found, struct buffer *buf,
+                             bool msg_sender)
 {
     int ret = PUSH_MSG_ERROR;
     const uint8_t ch = buf_read_u8(buf);
@@ -27,6 +33,10 @@
                     break;
             }
         }
+        else if (!msg_sender)
+        {
+            throw_signal_soft(SIGUSR1, "Offending option received from server");
+        }
     }
     else if (ch == '\0')
     {
@@ -35,3 +45,256 @@
 
     return ret;
 }
+
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Return index of last `,` or `0` if it didn't find any.
+ * If there is a comma at index `0` it's an error anyway
+ */
+static int
+find_first_comma_of_next_bundle(const char *str, int ix)
+{
+    while (ix > 0)
+    {
+        if (str[ix] == ',')
+        {
+            return ix;
+        }
+        ix--;
+    }
+    return 0;
+}
+
+/* Allocate memory and assemble the final message */
+static struct buffer
+forge_msg(const char *src, const char *continuation, struct gc_arena *gc)
+{
+    int src_len = strlen(src);
+    int con_len = continuation ? strlen(continuation) : 0;
+    struct buffer buf = alloc_buf_gc(src_len + sizeof(push_update_cmd) + con_len + 2, gc);
+
+    buf_printf(&buf, "%s,%s%s", push_update_cmd, src, continuation ? continuation : "");
+
+    return buf;
+}
+
+static char *
+gc_strdup(const char *src, struct gc_arena *gc)
+{
+    char *ret = gc_malloc((strlen(src) + 1) * sizeof(char), true, gc);
+
+    strcpy(ret, src);
+    return ret;
+}
+
+/* It split the messagge (if necessay) and fill msgs with the message chunks.
+ * Return `false` on failure an `true` on success.
+ */
+static bool
+message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, const int safe_cap)
+{
+    if (!s || !*s)
+    {
+        return false;
+    }
+
+    char *str = gc_strdup(s, gc);
+    int i = 0;
+    int im = 0;
+
+    while (*str)
+    {
+        /* + ',' - '/0' */
+        if (strlen(str) > safe_cap)
+        {
+            int ci = find_first_comma_of_next_bundle(str, safe_cap);
+            if (!ci)
+            {
+                /* if no commas were found go to fail, do not send any message */
+                return false;
+            }
+            str[ci] = '\0';
+            /* copy from i to (ci -1) */
+            msgs[im] = forge_msg(str, ",push-continuation 2", gc);
+            i = ci + 1;
+        }
+        else
+        {
+            if (im)
+            {
+                msgs[im] = forge_msg(str, ",push-continuation 1", gc);
+            }
+            else
+            {
+                msgs[im] = forge_msg(str, NULL, gc);
+            }
+            i = strlen(str);
+        }
+        str = &str[i];
+        im++;
+    }
+    return true;
+}
+
+/* send the message(s) prepared to one single client */
+static bool
+send_single_push_update(struct context *c, struct buffer *msgs, unsigned int *option_types_found)
+{
+    if (!msgs[0].data || !*(msgs[0].data))
+    {
+        return false;
+    }
+    int i = -1;
+
+    while (msgs[++i].data && *(msgs[i].data))
+    {
+        if (!send_control_channel_string(c, BSTR(&msgs[i]), D_PUSH))
+        {
+            return false;
+        }
+
+        /* After sending the control message, we update the options server-side in the client's context
+         * so pushed options like ifconfig/ifconfig-ipv6 can actually work.
+         * If we don't do that, the packets arriving from the client with the new address will be
+         * rejected because the value in the option is an old one.
+         * For the same reason we later update the vhash too in `send_push_update()` function. */
+        buf_string_compare_advance(&msgs[i], push_update_cmd);
+        if (process_incoming_push_update(c, pull_permission_mask(c), option_types_found, &msgs[i], true) == PUSH_MSG_ERROR)
+        {
+            msg(M_WARN, "Failed to process push update message sent to client ID: %u",
+                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+            continue;
+        }
+        c->options.push_option_types_found |= *option_types_found;
+        if (!options_postprocess_pull(&c->options, c->c2.es))
+        {
+            msg(M_WARN, "Failed to post-process push update message sent to client ID: %u",
+                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+        }
+    }
+    return true;
+}
+
+int
+send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const int push_bundle_size)
+{
+    if (!msg || !*msg || !m
+        || (!target && type != UPT_BROADCAST))
+    {
+        return -EINVAL;
+    }
+
+    struct gc_arena gc = gc_new();
+    /* extra space for possible trailing ifconfig and push-continuation */
+    const int extra = 84 + sizeof(push_update_cmd);
+    /* push_bundle_size is the maximum size of a message, so if the message
+     * we want to send exceeds that size we have to split it into smaller messages */
+    const int safe_cap = push_bundle_size - extra;
+    int msgs_num = (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) != 0);
+    struct buffer *msgs = gc_malloc((msgs_num + 1) * sizeof(struct buffer), true, &gc);
+
+    unsigned int option_types_found = 0;
+
+    msgs[msgs_num].data = NULL;
+    if (!message_splitter(msg, msgs, &gc, safe_cap))
+    {
+        gc_free(&gc);
+        return -EINVAL;
+    }
+
+    if (type == UPT_BY_CID)
+    {
+        struct multi_instance *mi = lookup_by_cid(m, *((unsigned long *)target));
+
+        if (!mi)
+        {
+            return -ENOENT;
+        }
+
+        const char *old_ip = mi->context.options.ifconfig_local;
+        const char *old_ipv6 = mi->context.options.ifconfig_ipv6_local;
+        if (!mi->halt
+            && send_single_push_update(&mi->context, msgs, &option_types_found))
+        {
+            if (option_types_found & OPT_P_UP)
+            {
+                update_vhash(m, mi, old_ip, old_ipv6);
+            }
+            gc_free(&gc);
+            return 1;
+        }
+        else
+        {
+            gc_free(&gc);
+            return 0;
+        }
+    }
+
+    int count = 0;
+    struct hash_iterator hi;
+    const struct hash_element *he;
+
+    hash_iterator_init(m->iter, &hi);
+    while ((he = hash_iterator_next(&hi)))
+    {
+        struct multi_instance *curr_mi = he->value;
+
+        if (curr_mi->halt)
+        {
+            continue;
+        }
+
+        /* Type is UPT_BROADCAST so we update every client */
+        option_types_found = 0;
+        const char *old_ip = curr_mi->context.options.ifconfig_local;
+        const char *old_ipv6 = curr_mi->context.options.ifconfig_ipv6_local;
+        if (!send_single_push_update(&curr_mi->context, msgs, &option_types_found))
+        {
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
+                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_multi->peer_id : UINT32_MAX);
+            continue;
+        }
+        if (option_types_found & OPT_P_UP)
+        {
+            update_vhash(m, curr_mi, old_ip, old_ipv6);
+        }
+        count++;
+    }
+
+    hash_iterator_free(&hi);
+    gc_free(&gc);
+    return count;
+}
+
+#define RETURN_UPDATE_STATUS(n_sent)                                  \
+    do                                                                \
+    {                                                                 \
+        if ((n_sent) > 0)                                             \
+        {                                                             \
+            msg(M_CLIENT, "SUCCESS: %d client(s) updated", (n_sent)); \
+            return true;                                              \
+        }                                                             \
+        else                                                          \
+        {                                                             \
+            msg(M_CLIENT, "ERROR: no client updated");                \
+            return false;                                             \
+        }                                                             \
+    } while (0)
+
+
+bool
+management_callback_send_push_update_broadcast(void *arg, const char *options)
+{
+    int n_sent = send_push_update(arg, NULL, options, UPT_BROADCAST, PUSH_BUNDLE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+
+bool
+management_callback_send_push_update_by_cid(void *arg, unsigned long cid, const char *options)
+{
+    int n_sent = send_push_update(arg, &cid, options, UPT_BY_CID, PUSH_BUNDLE_SIZE);
+
+    RETURN_UPDATE_STATUS(n_sent);
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index b24e03c..9a40512 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -343,4 +343,5 @@
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/push_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
-	$(top_srcdir)/src/openvpn/otime.c
\ No newline at end of file
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/list.c
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 0f4ad41..87329b1 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -8,9 +8,16 @@
 #include <cmocka.h>
 #include "push.h"
 #include "options_util.h"
+#include "multi.h"
 
 /* mocks */
 
+void
+throw_signal_soft(const int signum, const char *signal_text)
+{
+    msg(M_WARN, "Offending option received from server");
+}
+
 unsigned int
 pull_permission_mask(const struct context *c)
 {
@@ -21,6 +28,18 @@
     return flags;
 }
 
+void
+update_vhash(struct multi_context *m, struct multi_instance *mi, const char *old_ip, const char *old_ipv6)
+{
+    return;
+}
+
+bool
+options_postprocess_pull(struct options *options, struct env_set *es)
+{
+    return true;
+}
+
 bool
 apply_push_options(struct context *c, struct options *options, struct buffer *buf,
                    unsigned int permission_mask, unsigned int *option_types_found,
@@ -48,7 +67,6 @@
                 {
                     continue; /* Ignoring this option */
                 }
-                msg(M_WARN, "Offending option received from server");
                 return false; /* Cause push/pull error and stop push processing */
             }
         }
@@ -77,7 +95,7 @@
     }
     else if (honor_received_options && buf_string_compare_advance(&buf, push_update_cmd))
     {
-        return process_incoming_push_update(c, permission_mask, option_types_found, &buf);
+        return process_incoming_push_update(c, permission_mask, option_types_found, &buf, false);
     }
     else
     {
@@ -85,6 +103,49 @@
     }
 }
 
+const char *
+tls_common_name(const struct tls_multi *multi, const bool null)
+{
+    return NULL;
+}
+
+#ifndef ENABLE_MANAGEMENT
+bool
+send_control_channel_string(struct context *c, const char *str, int msglevel)
+{
+    return true;
+}
+#else  /* ifndef ENABLE_MANAGEMENT */
+char **res;
+int i;
+
+bool
+send_control_channel_string(struct context *c, const char *str, int msglevel)
+{
+    if (res && res[i] && strcmp(res[i], str))
+    {
+        printf("\n\nexpected: %s\n\n  actual: %s\n\n", res[i], str);
+        return false;
+    }
+    i++;
+    return true;
+}
+
+struct multi_instance *
+lookup_by_cid(struct multi_context *m, const unsigned long cid)
+{
+    return *(m->instances);
+}
+
+bool
+mroute_extract_openvpn_sockaddr(struct mroute_addr *addr,
+                                const struct openvpn_sockaddr *osaddr,
+                                bool use_port)
+{
+    return true;
+}
+#endif /* ifndef ENABLE_MANAGEMENT */
+
 /* tests */
 
 static void
@@ -120,7 +181,6 @@
     free_buf(&buf);
 }
 
-
 static void
 test_incoming_push_message_error2(void **state)
 {
@@ -219,6 +279,207 @@
     free_buf(&buf);
 }
 
+#ifdef ENABLE_MANAGEMENT
+char *r0[] = {
+    "PUSH_UPDATE,redirect-gateway local,route 192.168.1.0 255.255.255.0"
+};
+char *r1[] = {
+    "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway local,push-continuation 2",
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0,push-continuation 1"
+};
+char *r3[] = {
+    "PUSH_UPDATE,,,"
+};
+char *r4[] = {
+    "PUSH_UPDATE,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-continuation 2",
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+};
+char *r5[] = {
+    "PUSH_UPDATE,,-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local,push-continuation 2",
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,push-continuation 1"
+};
+char *r6[] = {
+    "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8, redirect-gateway 10.10.10.10,,push-continuation 2",
+    "PUSH_UPDATE, route 192.168.1.0 255.255.255.0,,push-continuation 1"
+};
+char *r7[] = {
+    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,push-continuation 2",
+    "PUSH_UPDATE,,,,,,,,,,,,,,,,,,,push-continuation 1"
+};
+char *r8[] = {
+    "PUSH_UPDATE,-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,push-continuation 2",
+    "PUSH_UPDATE, akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway\n local,push-continuation 2",
+    "PUSH_UPDATE,route 192.168.1.0 255.255.255.0\n\n\n,push-continuation 1"
+};
+char *r9[] = {
+    "PUSH_UPDATE,,"
+};
+
+
+const char *msg0 = "redirect-gateway local,route 192.168.1.0 255.255.255.0";
+const char *msg1 = "-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,"
+                   " akakakakakakakakakakakaf, dhcp-option DNS 8.8.8.8,redirect-gateway local,route 192.168.1.0 255.255.255.0";
+const char *msg2 = "";
+const char *msg3 = ",,";
+const char *msg4 = "-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,"
+                   " akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local, route 192.168.1.0 255.255.255.0,";
+const char *msg5 = ",-dhcp-option, blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf,"
+                   " akakakakakakakakakakakaf,dhcp-option DNS 8.8.8.8, redirect-gateway local, route 192.168.1.0 255.255.255.0";
+const char *msg6 = "-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf, akakakakakakakakakakakaf,"
+                   " dhcp-option DNS 8.8.8.8, redirect-gateway 10.10.10.10,, route 192.168.1.0 255.255.255.0,";
+const char *msg7 = ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,";
+const char *msg8 = "-dhcp-option,blablalalalalalalalalalalalalf, lalalalalalalalalalalalalalaf, akakakakakakakakakakakaf,"
+                   " dhcp-option DNS 8.8.8.8,redirect-gateway\n local,route 192.168.1.0 255.255.255.0\n\n\n";
+const char *msg9 = ",";
+
+const char *msg10 = "abandon ability able about above absent absorb abstract absurd abuse access accident account accuse achieve"
+                    "acid acoustic acquire across act action actor actress actual adapt add addict address adjust"
+                    "baby bachelor bacon badge bag balance balcony ball bamboo banana banner bar barely bargain barrel base basic"
+                    "basket battle beach bean beauty because become beef before begin behave behind"
+                    "cabbage cabin cable cactus cage cake call calm camera camp can canal cancel candy cannon canoe canvas canyon"
+                    "capable capital captain car carbon card cargo carpet carry cart case"
+                    "daisy damage damp dance danger daring dash daughter dawn day deal debate debris decade december decide decline"
+                    "decorate decrease deer defense define defy degree delay deliver demand demise denial";
+
+#define PUSH_BUNDLE_SIZE_TEST 184
+
+static void
+test_send_push_msg0(void **state)
+{
+    i = 0;
+    res = r0;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg0, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+static void
+test_send_push_msg1(void **state)
+{
+    i = 0;
+    res = r1;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg1, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg2(void **state)
+{
+    i = 0;
+    res = NULL;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg2, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);
+}
+
+static void
+test_send_push_msg3(void **state)
+{
+    i = 0;
+    res = r3;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg3, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg4(void **state)
+{
+    i = 0;
+    res = r4;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg4, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg5(void **state)
+{
+    i = 0;
+    res = r5;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg5, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg6(void **state)
+{
+    i = 0;
+    res = r6;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg6, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg7(void **state)
+{
+    i = 0;
+    res = r7;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg7, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg8(void **state)
+{
+    i = 0;
+    res = r8;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg8, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg9(void **state)
+{
+    i = 0;
+    res = r9;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg9, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), 1);
+}
+
+static void
+test_send_push_msg10(void **state)
+{
+    i = 0;
+    res = NULL;
+    struct multi_context *m = *state;
+    const unsigned long cid = 0;
+    assert_int_equal(send_push_update(m, &cid, msg10, UPT_BY_CID, PUSH_BUNDLE_SIZE_TEST), -EINVAL);
+}
+
+#undef PUSH_BUNDLE_SIZE_TEST
+
+static int
+setup2(void **state)
+{
+    struct multi_context *m = calloc(1, sizeof(struct multi_context));
+    m->instances = calloc(1, sizeof(struct multi_instance *));
+    struct multi_instance *mi = calloc(1, sizeof(struct multi_instance));
+    *(m->instances) = mi;
+    *state = m;
+    return 0;
+}
+
+static int
+teardown2(void **state)
+{
+    struct multi_context *m = *state;
+    free(*(m->instances));
+    free(m->instances);
+    free(m);
+    return 0;
+}
+#endif /* ifdef ENABLE_MANAGEMENT */
+
 static int
 setup(void **state)
 {
@@ -249,7 +510,20 @@
         cmocka_unit_test_setup_teardown(test_incoming_push_message_1, setup, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_bad_format, setup, teardown),
         cmocka_unit_test_setup_teardown(test_incoming_push_message_mix, setup, teardown),
-        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, setup, teardown)
+        cmocka_unit_test_setup_teardown(test_incoming_push_message_mix2, setup, teardown),
+#ifdef ENABLE_MANAGEMENT
+        cmocka_unit_test_setup_teardown(test_send_push_msg0, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg1, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg2, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg3, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg4, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg5, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg6, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg7, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg8, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg9, setup2, teardown2),
+        cmocka_unit_test_setup_teardown(test_send_push_msg10, setup2, teardown2)
+#endif
     };
 
     return cmocka_run_group_tests(tests, NULL, NULL);

