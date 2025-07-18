From: Gert Doering <gert@...1296...>
Date: Fri, 18 Jul 2025 14:22:24 +0200
Message-ID: <20250718122230.14008-1-gert@...1296...>
In-Reply-To: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] dco: Add support for float notifications
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

From: Ralf Lici <ralf@...2726...>

When a peer changes its UDP endpoint, the DCO module emits a
notification to userpace. The message is parsed and the relevant
information are extracted in order to process the floating operation.

Note that we preserve IPv4-mapped IPv6 addresses in userspace when
receiving a pure IPv4 address from the module, otherwise openvpn
wouldn't be able to retrieve the multi_instance using the transport
address hash table lookup.

It may happen that a netlink notification gets lost, causing us to skip
a float step. If the peer then floats back to its previous address,
userspace closes the only valid instance while trying to process the
float, leading to a segfault. To prevent this, we ignore float attempts
to an address already taken by a peer with the same peer ID.

Change-Id: I33e9272b4196c7634db2fb33a75ae4261660867f
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1084
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 22a445a..f04ebfe 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -768,6 +768,44 @@
     return ret;
 }
 
+static bool
+ovpn_parse_float_addr(struct nlattr **attrs, struct sockaddr *out)
+{
+    if (!attrs[OVPN_A_PEER_REMOTE_PORT])
+    {
+        msg(D_DCO, "ovpn-dco: no remote port in PEER_FLOAT_NTF message");
+        return false;
+    }
+
+    if (attrs[OVPN_A_PEER_REMOTE_IPV4])
+    {
+        struct sockaddr_in *addr4 = (struct sockaddr_in *)out;
+        CLEAR(*addr4);
+        addr4->sin_family = AF_INET;
+        addr4->sin_port = nla_get_u16(attrs[OVPN_A_PEER_REMOTE_PORT]);
+        addr4->sin_addr.s_addr = nla_get_u32(attrs[OVPN_A_PEER_REMOTE_IPV4]);
+        return true;
+    }
+    else if (attrs[OVPN_A_PEER_REMOTE_IPV6]
+             && nla_len(attrs[OVPN_A_PEER_REMOTE_IPV6]) == sizeof(struct in6_addr))
+    {
+        struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)out;
+        CLEAR(*addr6);
+        addr6->sin6_family = AF_INET6;
+        addr6->sin6_port = nla_get_u16(attrs[OVPN_A_PEER_REMOTE_PORT]);
+        memcpy(&addr6->sin6_addr, nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]),
+               sizeof(addr6->sin6_addr));
+        if (attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID])
+        {
+            addr6->sin6_scope_id = nla_get_u32(attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID]);
+        }
+        return true;
+    }
+
+    msg(D_DCO, "ovpn-dco: no valid remote IP address in PEER_FLOAT_NTF message");
+    return false;
+}
+
 /* This function parses any netlink message sent by ovpn-dco to userspace */
 static int
 ovpn_handle_msg(struct nl_msg *msg, void *arg)
@@ -856,6 +894,45 @@
             break;
         }
 
+        case OVPN_CMD_PEER_FLOAT_NTF:
+        {
+            if (!attrs[OVPN_A_PEER])
+            {
+                msg(D_DCO, "ovpn-dco: no peer in PEER_FLOAT_NTF message");
+                return NL_STOP;
+            }
+
+            struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];
+            if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],
+                                 NULL))
+            {
+                msg(D_DCO, "ovpn-dco: can't parse peer in PEER_FLOAT_NTF messsage");
+                return NL_STOP;
+            }
+
+            if (!fp_attrs[OVPN_A_PEER_ID])
+            {
+                msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF message");
+                return NL_STOP;
+            }
+            uint32_t peerid = nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);
+
+            if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&dco->dco_float_peer_ss))
+            {
+                return NL_STOP;
+            }
+
+            struct gc_arena gc = gc_new();
+            msg(D_DCO_DEBUG,
+                "ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s",
+                ifindex, peerid, print_sockaddr((struct sockaddr *)&dco->dco_float_peer_ss, &gc));
+            dco->dco_message_peer_id = (int)peerid;
+            dco->dco_message_type = OVPN_CMD_PEER_FLOAT_NTF;
+
+            gc_free(&gc);
+            break;
+        }
+
         case OVPN_CMD_KEY_SWAP_NTF:
         {
             if (!attrs[OVPN_A_KEYCONF])
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 4e441ec..676b8cd 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -34,6 +34,7 @@
 /* Defines to avoid mismatching with other platforms */
 #define OVPN_CMD_DEL_PEER OVPN_CMD_PEER_DEL_NTF
 #define OVPN_CMD_SWAP_KEYS OVPN_CMD_KEY_SWAP_NTF
+#define OVPN_CMD_FLOAT_PEER OVPN_CMD_PEER_FLOAT_NTF
 
 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;
@@ -75,6 +76,7 @@
     int dco_message_peer_id;
     int dco_message_key_id;
     int dco_del_peer_reason;
+    struct sockaddr_storage dco_float_peer_ss;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
 } dco_context_t;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 2a13658..83db739 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -663,6 +663,7 @@
         dco->dco_message_peer_id = dco->notif_buf.PeerId;
         dco->dco_message_type = dco->notif_buf.Cmd;
         dco->dco_del_peer_reason = dco->notif_buf.DelPeerReason;
+        dco->dco_float_peer_ss = dco->notif_buf.FloatAddress;
     }
     else
     {
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4513f3f..b9d93fa 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -52,6 +52,7 @@
     int dco_message_peer_id;
     int dco_message_type;
     int dco_del_peer_reason;
+    struct sockaddr_storage dco_float_peer_ss;
 
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a4f260a..dfc6708 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1243,6 +1243,41 @@
     perf_pop();
 }
 
+void
+extract_dco_float_peer_addr(const sa_family_t socket_family,
+                            struct openvpn_sockaddr *out_osaddr,
+                            const struct sockaddr *float_sa)
+{
+    if (float_sa->sa_family == AF_INET)
+    {
+        struct sockaddr_in *float4 = (struct sockaddr_in *)float_sa;
+        /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4. However, on a
+         * dual-stack socket, we need to preserve the mapping otherwise openvpn
+         * will not be able to find the peer by its transport address.
+         */
+        if (socket_family == AF_INET6)
+        {
+            out_osaddr->addr.in6.sin6_family = AF_INET6;
+            out_osaddr->addr.in6.sin6_port = float4->sin_port;
+
+            memset(&out_osaddr->addr.in6.sin6_addr.s6_addr, 0, 10);
+            out_osaddr->addr.in6.sin6_addr.s6_addr[10] = 0xff;
+            out_osaddr->addr.in6.sin6_addr.s6_addr[11] = 0xff;
+            memcpy(&out_osaddr->addr.in6.sin6_addr.s6_addr[12],
+                   &float4->sin_addr.s_addr, sizeof(in_addr_t));
+        }
+        else
+        {
+            memcpy(&out_osaddr->addr.in4, float4, sizeof(struct sockaddr_in));
+        }
+    }
+    else
+    {
+        struct sockaddr_in6 *float6 = (struct sockaddr_in6 *)float_sa;
+        memcpy(&out_osaddr->addr.in6, float6, sizeof(struct sockaddr_in6));
+    }
+}
+
 static void
 process_incoming_dco(struct context *c)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 318691f..2818fd1 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -196,6 +196,21 @@
 void process_incoming_link_part2(struct context *c, struct link_socket_info *lsi, const uint8_t *orig_buf);
 
 /**
+ * Transfers \c float_sa data extracted from an incoming DCO
+ * PEER_FLOAT_NTF to \c out_osaddr for later processing.
+ *
+ * @param socket_family - The address family of the socket
+ * @param out_osaddr - openvpn_sockaddr struct that will be filled the new
+ *      address data
+ * @param float_sa - The sockaddr struct containing the data received from the
+ *      DCO notification
+ */
+void
+extract_dco_float_peer_addr(sa_family_t socket_family,
+                            struct openvpn_sockaddr *out_osaddr,
+                            const struct sockaddr *float_sa);
+
+/**
  * Write a packet to the external network interface.
  * @ingroup external_multiplexer
  *
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a760e07..ead3dd0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3251,6 +3251,18 @@
             goto done;
         }
 
+        /* It doesn't make sense to let a peer float to the address it already
+         * has, so we disallow it. This can happen if a DCO netlink notification
+         * gets lost and we miss a floating step.
+         */
+        if (m1->peer_id == m2->peer_id)
+        {
+            msg(M_WARN, "disallowing peer %" PRIu32 " (%s) from floating to "
+                "its own address (%s)",
+                m1->peer_id, tls_common_name(mi->context.c2.tls_multi, false),
+                mroute_addr_print(&mi->real, &gc));
+            goto done;
+        }
         msg(D_MULTI_MEDIUM, "closing instance %s", multi_instance_string(ex_mi, false, &gc));
         multi_close_instance(m, ex_mi, false);
     }
@@ -3384,6 +3396,17 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
+#if defined(TARGET_LINUX) || defined(TARGET_WIN32)
+        else if (dco->dco_message_type == OVPN_CMD_FLOAT_PEER)
+        {
+            ASSERT(mi->context.c2.link_sockets[0]);
+            extract_dco_float_peer_addr(mi->context.c2.link_sockets[0]->info.af,
+                                        &m->top.c2.from.dest,
+                                        (struct sockaddr *)&dco->dco_float_peer_ss);
+            multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
+            CLEAR(dco->dco_float_peer_ss);
+        }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */
         else if (dco->dco_message_type == OVPN_CMD_SWAP_KEYS)
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 40f7519..fe9e847 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -322,7 +322,7 @@
 /**
  * Process an incoming DCO message (from kernel space).
  *
- * @param m            - The single \c multi_context structur.e
+ * @param m            - The single \c multi_context structure.
  *
  * @return
  *  - True, if the message was received correctly.
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 680d152..b3c9ff0 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -99,6 +99,7 @@
 	OVPN_CMD_KEY_SWAP,
 	OVPN_CMD_KEY_SWAP_NTF,
 	OVPN_CMD_KEY_DEL,
+	OVPN_CMD_PEER_FLOAT_NTF,
 
 	__OVPN_CMD_MAX,
 	OVPN_CMD_MAX = (__OVPN_CMD_MAX - 1)
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index 865bb38..dd6b7ce 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -149,7 +149,8 @@
 
 typedef enum {
     OVPN_CMD_DEL_PEER,
-    OVPN_CMD_SWAP_KEYS
+    OVPN_CMD_SWAP_KEYS,
+    OVPN_CMD_FLOAT_PEER
 } OVPN_NOTIFY_CMD;
 
 typedef enum {
@@ -164,6 +165,7 @@
     OVPN_NOTIFY_CMD Cmd;
     int PeerId;
     OVPN_DEL_PEER_REASON DelPeerReason;
+    struct sockaddr_storage FloatAddress;
 } OVPN_NOTIFY_EVENT, * POVPN_NOTIFY_EVENT;
 
 typedef struct _OVPN_MP_DEL_PEER {

