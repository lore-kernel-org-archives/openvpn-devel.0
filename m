From: Gert Doering <gert@...1296...>
Date: Mon,  8 Sep 2025 10:11:18 +0200
Message-ID: <20250908081124.17933-1-gert@...1296...>
In-Reply-To: <gerrit.1757094927000.Ib748e726eb84dcbe8a48b297d165dec80c0e578d@...2715...>
References: <gerrit.1757094927000.Ib748e726eb84dcbe8a48b297d165dec80c0e578d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco: backport OS-independent part of
 peer float support
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

This is a backport of commit cb8a0f6f5741d102b667d98370ab4d553503d0b5,
which introduces float support for DCO linux, Windows, and the
OS-independent parts.

DCO linux/windows in 2.6 has no float support kernel-side, so this
ignores all OS dependent parts, backporting just enough to add
FreeBSD support in the next patch.

One notable difference in the backport is that 2.6 has no multi-socket
support, so all the "link_sockets[0]" occurances need to be changed back
to "link_socket".

Change-Id: Ib748e726eb84dcbe8a48b297d165dec80c0e578d
Signed-off-by: Ralf Lici <ralf@...2726...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Ralf Lici <ralf@...2726...>
(cherry picked from commit cb8a0f6f5741d102b667d98370ab4d553503d0b5)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1169
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@...2726...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0f2ec07..ab5ebda 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1234,6 +1234,41 @@
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
index 245a802..3d0abd5 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -189,6 +189,21 @@
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
index 199f655..eb5f932 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3169,6 +3169,18 @@
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
@@ -3301,6 +3313,17 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
+#if 0
+        else if (dco->dco_message_type == OVPN_CMD_FLOAT_PEER)
+        {
+            ASSERT(mi->context.c2.link_socket);
+            extract_dco_float_peer_addr(mi->context.c2.link_socket->info.af,
+                                        &m->top.c2.from.dest,
+                                        (struct sockaddr *)&dco->dco_float_peer_ss);
+            multi_process_float(m, mi);
+            CLEAR(dco->dco_float_peer_ss);
+        }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */
         else if (dco->dco_message_type == OVPN_CMD_SWAP_KEYS)
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);

