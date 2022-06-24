From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:58 +0200
Message-Id: <20220624083809.23487-15-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 14/25] dco: implement dco support for
 p2mp/server code path
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
Cc: Antonio Quartulli <a@...2181...>

This change introduces ovpn-dco support along the p2mp/server code path.
Some code seems to be duplicate of the p2p version, but details are
different, so it couldn't be shared.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c   | 203 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/dco.h   |  49 ++++++++++
 src/openvpn/mtcp.c  |  59 +++++++++---
 src/openvpn/mudp.c  |  13 +++
 src/openvpn/multi.c | 212 +++++++++++++++++++++++++++++++++++---------
 src/openvpn/multi.h |  14 ++-
 6 files changed, 494 insertions(+), 56 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 2919c46d..48e007ea 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -36,6 +36,7 @@
 #include "crypto.h"
 #include "dco.h"
 #include "errlevel.h"
+#include "multi.h"
 #include "openvpn.h"
 #include "ssl_common.h"
 #include "ssl_ncp.h"
@@ -390,4 +391,206 @@ dco_remove_peer(struct context *c)
     }
 }
 
+static bool
+dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
+                        struct sockaddr_storage *local)
+{
+#if ENABLE_IP_PKTINFO
+    struct context *c = &mi->context;
+
+    if (!(c->options.sockflags & SF_USE_IP_PKTINFO))
+    {
+        return false;
+    }
+
+    struct link_socket_actual *actual = &c->c2.link_socket_info->lsa->actual;
+
+    switch (actual->dest.addr.sa.sa_family)
+    {
+        case AF_INET:
+        {
+            struct sockaddr_in *sock_in4 = (struct sockaddr_in *)local;
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
+            sock_in4->sin_addr = actual->pi.in4.ipi_addr;
+#elif defined(IP_RECVDSTADDR)
+            sock_in4->sin_addr = actual->pi.in4;
+#else
+            /* source IP not available on this platform */
+            return false;
+#endif
+            sock_in4->sin_family = AF_INET;
+            break;
+        }
+
+        case AF_INET6:
+        {
+            struct sockaddr_in6 *sock_in6 = (struct sockaddr_in6 *)local;
+            sock_in6->sin6_addr = actual->pi.in6.ipi6_addr;
+            sock_in6->sin6_family = AF_INET6;
+            break;
+        }
+
+        default:
+            ASSERT(false);
+    }
+
+    return true;
+#else  /* if ENABLE_IP_PKTINFO */
+    return false;
+#endif /* if ENABLE_IP_PKTINFO */
+}
+
+int
+dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+{
+    struct context *c = &mi->context;
+
+    int peer_id = mi->context.c2.tls_multi->peer_id;
+    struct sockaddr *remoteaddr, *localaddr = NULL;
+    struct sockaddr_storage local = { 0 };
+    int sd = c->c2.link_socket->sd;
+
+    if (c->mode == CM_CHILD_TCP)
+    {
+        /* the remote address will be inferred from the TCP socket endpoint */
+        remoteaddr = NULL;
+    }
+    else
+    {
+        ASSERT(c->c2.link_socket_info->connection_established);
+        remoteaddr = &c->c2.link_socket_info->lsa->actual.dest.addr.sa;
+    }
+
+    struct in_addr remote_ip4 = { 0 };
+    struct in6_addr *remote_addr6 = NULL;
+    struct in_addr *remote_addr4 = NULL;
+
+    /* In server mode we need to fetch the remote addresses from the push config */
+    if (c->c2.push_ifconfig_defined)
+    {
+        remote_ip4.s_addr =  htonl(c->c2.push_ifconfig_local);
+        remote_addr4 = &remote_ip4;
+    }
+    if (c->c2.push_ifconfig_ipv6_defined)
+    {
+        remote_addr6 = &c->c2.push_ifconfig_ipv6_local;
+    }
+
+    if (dco_multi_get_localaddr(m, mi, &local))
+    {
+        localaddr = (struct sockaddr *)&local;
+    }
+
+    int ret = dco_new_peer(&c->c1.tuntap->dco, peer_id, sd, localaddr,
+                           remoteaddr, remote_addr4, remote_addr6);
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    c->c2.tls_multi->dco_peer_added = true;
+
+    if (c->mode == CM_CHILD_TCP)
+    {
+        multi_tcp_dereference_instance(m->mtcp, mi);
+        if (close(sd))
+        {
+            msg(D_DCO|M_ERRNO, "error closing TCP socket after DCO handover");
+        }
+        c->c2.link_socket->info.dco_installed = true;
+        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+    }
+
+    return 0;
+}
+
+void
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                   struct mroute_addr *addr)
+{
+#if defined(TARGET_LINUX)
+    if (!dco_enabled(&m->top.options))
+    {
+        return;
+    }
+
+    int addrtype = (addr->type & MR_ADDR_MASK);
+
+    /* If we do not have local IP addr to install, skip the route */
+    if ((addrtype == MR_ADDR_IPV6 && !mi->context.c2.push_ifconfig_ipv6_defined)
+        || (addrtype == MR_ADDR_IPV4 && !mi->context.c2.push_ifconfig_defined))
+    {
+        return;
+    }
+
+    struct context *c = &mi->context;
+    const char *dev = c->c1.tuntap->actual_name;
+
+    if (addrtype == MR_ADDR_IPV6)
+    {
+        int netbits = 128;
+        if (addr->type & MR_WITH_NETBITS)
+        {
+            netbits = addr->netbits;
+        }
+
+        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, netbits,
+                         &mi->context.c2.push_ifconfig_ipv6_local, dev, 0,
+                         DCO_IROUTE_METRIC);
+    }
+    else if (addrtype == MR_ADDR_IPV4)
+    {
+        int netbits = 32;
+        if (addr->type & MR_WITH_NETBITS)
+        {
+            netbits = addr->netbits;
+        }
+
+        in_addr_t dest = htonl(addr->v4.addr);
+        net_route_v4_add(&m->top.net_ctx, &dest, netbits,
+                         &mi->context.c2.push_ifconfig_local, dev, 0,
+                         DCO_IROUTE_METRIC);
+    }
+#endif /* if defined(TARGET_LINUX) */
+}
+
+void
+dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+{
+#if defined(TARGET_LINUX)
+    if (!dco_enabled(&m->top.options))
+    {
+        return;
+    }
+    ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN);
+
+    struct context *c = &mi->context;
+    const char *dev = c->c1.tuntap->actual_name;
+
+    if (mi->context.c2.push_ifconfig_defined)
+    {
+        for (const struct iroute *ir = c->options.iroutes;
+             ir;
+             ir = ir->next)
+        {
+            net_route_v4_del(&m->top.net_ctx, &ir->network, ir->netbits,
+                             &mi->context.c2.push_ifconfig_local, dev,
+                             0, DCO_IROUTE_METRIC);
+        }
+    }
+
+    if (mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        for (const struct iroute_ipv6 *ir6 = c->options.iroutes_ipv6;
+             ir6;
+             ir6 = ir6->next)
+        {
+            net_route_v6_del(&m->top.net_ctx, &ir6->network, ir6->netbits,
+                             &mi->context.c2.push_ifconfig_ipv6_local, dev,
+                             0, DCO_IROUTE_METRIC);
+        }
+    }
+#endif /* if defined(TARGET_LINUX) */
+}
+
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 33b91e29..4b945b50 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -37,10 +37,14 @@
 struct event_set;
 struct key2;
 struct key_state;
+struct multi_context;
+struct multi_instance;
+struct mroute_addr;
 struct options;
 struct tls_multi;
 struct tuntap;
 
+#define DCO_IROUTE_METRIC   100
 #define DCO_DEFAULT_METRIC  200
 
 #if defined(ENABLE_DCO)
@@ -168,6 +172,34 @@ int dco_set_peer(dco_context_t *dco, unsigned int peerid,
  */
 void dco_remove_peer(struct context *c);
 
+/**
+ * Install a new peer in DCO - to be called by a SERVER instance
+ *
+ * @param m         the server context
+ * @param mi        the client instance
+ * @return          0 on success or a negative error code otherwise
+ */
+int dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi);
+
+/**
+ * Install an iroute in DCO, which means adding a route to the system routing
+ * table. To be called by a SERVER instance only.
+ *
+ * @param m         the server context
+ * @param mi        the client instance acting as nexthop for the route
+ * @param addr      the route to add
+ */
+void dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                        struct mroute_addr *addr);
+
+/**
+ * Remove all routes added through the specified client
+ *
+ * @param m         the server context
+ * @param mi        the client instance for which routes have to be removed
+ */
+void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
+
 #else /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -252,5 +284,22 @@ dco_remove_peer(struct context *c)
 {
 }
 
+static inline bool
+dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+{
+    return true;
+}
+
+static inline void
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                   struct mroute_addr *addr)
+{
+}
+
+static inline void
+dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+{
+}
+
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b3c153fe..eb88a56a 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -61,6 +61,7 @@
 #define MTCP_SIG         ((void *)3) /* Only on Windows */
 #define MTCP_MANAGEMENT ((void *)4)
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
+#define MTCP_DCO        ((void *)6)
 
 #define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
 
@@ -131,6 +132,8 @@ multi_create_instance_tcp(struct multi_context *m)
         const uint32_t hv = hash_value(hash, &mi->real);
         struct hash_bucket *bucket = hash_bucket(hash, hv);
 
+        multi_assign_peer_id(m, mi);
+
         he = hash_lookup_fast(hash, bucket, &mi->real, hv);
 
         if (he)
@@ -238,6 +241,7 @@ multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *mi
     if (ls && mi->socket_set_called)
     {
         event_del(mtcp->es, socket_event_handle(ls));
+        mi->socket_set_called = false;
     }
     mtcp->n_esr = 0;
 }
@@ -279,6 +283,9 @@ multi_tcp_wait(const struct context *c,
     }
 #endif
     tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+#if defined(TARGET_LINUX)
+    dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
+#endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -395,6 +402,18 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
 
     tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
 
+    if (mi && mi->context.c2.link_socket->info.dco_installed)
+    {
+        /* If we got a socket that has been handed over to the kernel
+         * we must not call the normal socket function to figure out
+         * if it is readable or writable */
+        /* Assert that we only have the DCO exptected flags */
+        ASSERT(action & (TA_SOCKET_READ | TA_SOCKET_WRITE));
+
+        /* We are always ready! */
+        return action;
+    }
+
     switch (action)
     {
         case TA_TUN_READ:
@@ -518,7 +537,10 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
 
         case TA_INITIAL:
             ASSERT(mi);
-            multi_tcp_set_global_rw_flags(m, mi);
+            if (!mi->context.c2.link_socket->info.dco_installed)
+            {
+                multi_tcp_set_global_rw_flags(m, mi);
+            }
             multi_process_post(m, mi, mpp_flags);
             break;
 
@@ -568,7 +590,10 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
             }
             else
             {
-                multi_tcp_set_global_rw_flags(m, mi);
+                if (!c->c2.link_socket->info.dco_installed)
+                {
+                    multi_tcp_set_global_rw_flags(m, mi);
+                }
             }
             break;
 
@@ -625,23 +650,22 @@ multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int action,
         /*
          * Dispatch the action
          */
-        {
-            struct multi_instance *touched = multi_tcp_dispatch(m, mi, action);
+        struct multi_instance *touched = multi_tcp_dispatch(m, mi, action);
 
-            /*
-             * Signal received or TCP connection
-             * reset by peer?
-             */
-            if (touched && IS_SIG(&touched->context))
+        /*
+         * Signal received or TCP connection
+         * reset by peer?
+         */
+        if (touched && IS_SIG(&touched->context))
+        {
+            if (mi == touched)
             {
-                if (mi == touched)
-                {
-                    mi = NULL;
-                }
-                multi_close_instance_on_signal(m, touched);
+                mi = NULL;
             }
+            multi_close_instance_on_signal(m, touched);
         }
 
+
         /*
          * If dispatch produced any pending output
          * for a particular instance, point to
@@ -739,6 +763,13 @@ multi_tcp_process_io(struct multi_context *m)
                     multi_tcp_action(m, mi, TA_INITIAL, false);
                 }
             }
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+            /* incoming data on DCO? */
+            else if (e->arg == MTCP_DCO)
+            {
+                multi_process_incoming_dco(m);
+            }
+#endif
             /* signal received? */
             else if (e->arg == MTCP_SIG)
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 0810fada..14aa7236 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -380,6 +380,19 @@ multi_process_io_udp(struct multi_context *m)
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    else if (status & DCO_READ)
+    {
+        if (!IS_SIG(&m->top))
+        {
+            bool ret = true;
+            while (ret)
+            {
+                ret = multi_process_incoming_dco(m);
+            }
+        }
+    }
+#endif
 }
 
 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 34ab90b4..23472095 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -51,6 +51,7 @@
 
 #include "crypto_backend.h"
 #include "ssl_util.h"
+#include "dco.h"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -519,6 +520,9 @@ multi_del_iroutes(struct multi_context *m,
 {
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
+
+    dco_delete_iroutes(m, mi);
+
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
         for (ir = mi->context.options.iroutes; ir != NULL; ir = ir->next)
@@ -1224,16 +1228,20 @@ multi_learn_in_addr_t(struct multi_context *m,
         addr.netbits = (uint8_t) netbits;
     }
 
-    {
-        struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
 #ifdef ENABLE_MANAGEMENT
-        if (management && owner)
-        {
-            management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
-        }
+    if (management && owner)
+    {
+        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
+    }
 #endif
-        return owner;
+    if (!primary)
+    {
+        /* We do not want to install IP -> IP dev ovpn-dco0 */
+        dco_install_iroute(m, mi, &addr);
     }
+
+    return owner;
 }
 
 static struct multi_instance *
@@ -1257,16 +1265,20 @@ multi_learn_in6_addr(struct multi_context *m,
         mroute_addr_mask_host_bits( &addr );
     }
 
-    {
-        struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
 #ifdef ENABLE_MANAGEMENT
-        if (management && owner)
-        {
-            management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
-        }
+    if (management && owner)
+    {
+        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
+    }
 #endif
-        return owner;
+    if (!primary)
+    {
+        /* We do not want to install IP -> IP dev ovpn-dco0 */
+        dco_install_iroute(m, mi, &addr);
     }
+
+    return owner;
 }
 
 /*
@@ -1765,6 +1777,15 @@ multi_client_set_protocol_options(struct context *c)
         tls_multi->use_peer_id = true;
         o->use_peer_id = true;
     }
+    else if (dco_enabled(o))
+    {
+        msg(M_INFO, "Client does not support DATA_V2. Data channel offloaing "
+            "requires DATA_V2. Dropping client.");
+        auth_set_client_reason(tls_multi, "Data channel negotiation "
+                               "failed (missing DATA_V2)");
+        return false;
+    }
+
     if (proto & IV_PROTO_REQUEST_PUSH)
     {
         c->c2.push_request_received = true;
@@ -2276,8 +2297,9 @@ cleanup:
  * Generates the data channel keys
  */
 static bool
-multi_client_generate_tls_keys(struct context *c)
+multi_client_generate_tls_keys(struct multi_context *m, struct multi_instance *mi)
 {
+    struct context *c = &mi->context;
     struct frame *frame_fragment = NULL;
 #ifdef ENABLE_FRAGMENT
     if (c->options.ce.fragment)
@@ -2285,6 +2307,17 @@ multi_client_generate_tls_keys(struct context *c)
         frame_fragment = &c->c2.frame_fragment;
     }
 #endif
+
+    if (dco_enabled(&c->options))
+    {
+        int ret = dco_multi_add_new_peer(m, mi);
+        if (ret < 0)
+        {
+            msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
+            return false;
+        }
+    }
+
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
     if (!tls_session_update_crypto_params(c->c2.tls_multi, session, &c->options,
                                           &c->c2.frame, frame_fragment,
@@ -2401,7 +2434,7 @@ multi_client_connect_late_setup(struct multi_context *m,
     }
     /* Generate data channel keys only if setting protocol options
      * has not failed */
-    else if (!multi_client_generate_tls_keys(&mi->context))
+    else if (!multi_client_generate_tls_keys(m, mi))
     {
         mi->context.c2.tls_multi->multi_state = CAS_FAILED;
     }
@@ -2668,6 +2701,14 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         (*cur_handler_index)++;
     }
 
+    /* Check if we have forbidding options in the current mode */
+    if (dco_enabled(&mi->context.options)
+        && !dco_check_option_conflict(D_MULTI_ERRORS, &mi->context.options))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to incompatible DCO options");
+        cc_succeeded = false;
+    }
+
     if (cc_succeeded)
     {
         multi_client_connect_late_setup(m, mi, *option_types_found);
@@ -3086,6 +3127,120 @@ done:
     gc_free(&gc);
 }
 
+/*
+ * Called when an instance should be closed due to the
+ * reception of a soft signal.
+ */
+void
+multi_close_instance_on_signal(struct multi_context *m, struct multi_instance *mi)
+{
+    remap_signal(&mi->context);
+    set_prefix(mi);
+    print_signal(mi->context.sig, "client-instance", D_MULTI_LOW);
+    clear_prefix();
+    multi_close_instance(m, mi, false);
+}
+
+#if (defined(ENABLE_DCO) && defined(TARGET_LINUX)) || defined(ENABLE_MANAGEMENT)
+static void
+multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const int sig)
+{
+    mi->context.sig->signal_received = sig;
+    multi_close_instance_on_signal(m, mi);
+}
+#endif
+
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+static void
+process_incoming_dco_packet(struct multi_context *m, struct multi_instance *mi,  dco_context_t *dco)
+{
+    struct buffer orig_buf = mi->context.c2.buf;
+    int peer_id = dco->dco_message_peer_id;
+
+    mi->context.c2.buf = dco->dco_packet_in;
+
+    multi_process_incoming_link(m, mi, 0);
+
+    mi->context.c2.buf = orig_buf;
+    if (BLEN(&dco->dco_packet_in) < 1)
+    {
+        msg(D_DCO, "Received too short packet for peer %d", peer_id);
+        goto done;
+    }
+
+    uint8_t *ptr = BPTR(&dco->dco_packet_in);
+    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+    if (op == P_DATA_V2 || op == P_DATA_V2)
+    {
+        msg(D_DCO, "DCO: received data channel packet for peer %d", peer_id);
+        goto done;
+    }
+done:
+    buf_init(&dco->dco_packet_in, 0);
+}
+
+static void
+process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, dco_context_t *dco)
+{
+    const char *reason = "(unknown reason by ovpn-dco)";
+    switch (dco->dco_del_peer_reason)
+    {
+        case OVPN_DEL_PEER_REASON_EXPIRED:
+            reason = "ovpn-dco: ping expired";
+            break;
+
+        case OVPN_DEL_PEER_REASON_TRANSPORT_ERROR:
+            reason = "ovpn-dco: transport error";
+            break;
+
+        case OVPN_DEL_PEER_REASON_USERSPACE:
+            /* This very likely ourselves but might be another process, so
+             * still process it */
+            reason = "ovpn-dco: userspace request";
+            break;
+    }
+
+    /* When kernel already deleted the peer, the socket is no longer
+     * installed and we don't need to cleanup the state in the kernel */
+    mi->context.c2.tls_multi->dco_peer_added = false;
+    mi->context.sig->signal_text = reason;
+    multi_signal_instance(m, mi, SIGTERM);
+}
+
+bool
+multi_process_incoming_dco(struct multi_context *m)
+{
+    dco_context_t *dco = &m->top.c1.tuntap->dco;
+
+    struct multi_instance *mi = NULL;
+
+    int ret = dco_do_read(&m->top.c1.tuntap->dco);
+
+    int peer_id = dco->dco_message_peer_id;
+
+    if ((peer_id >= 0) && (peer_id < m->max_clients) && (m->instances[peer_id]))
+    {
+        mi = m->instances[peer_id];
+        if (dco->dco_message_type == OVPN_CMD_PACKET)
+        {
+            process_incoming_dco_packet(m, mi, dco);
+        }
+        else if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
+        {
+            process_incoming_del_peer(m, mi, dco);
+        }
+    }
+    else
+    {
+        msg(D_DCO, "Received packet for peer-id unknown to OpenVPN: %d", peer_id);
+    }
+
+    dco->dco_message_type = 0;
+    dco->dco_message_peer_id = -1;
+    return ret > 0;
+}
+#endif /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
@@ -3647,32 +3802,11 @@ multi_process_signal(struct multi_context *m)
     return true;
 }
 
-/*
- * Called when an instance should be closed due to the
- * reception of a soft signal.
- */
-void
-multi_close_instance_on_signal(struct multi_context *m, struct multi_instance *mi)
-{
-    remap_signal(&mi->context);
-    set_prefix(mi);
-    print_signal(mi->context.sig, "client-instance", D_MULTI_LOW);
-    clear_prefix();
-    multi_close_instance(m, mi, false);
-}
-
 /*
  * Management subsystem callbacks
  */
 #ifdef ENABLE_MANAGEMENT
 
-static void
-multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const int sig)
-{
-    mi->context.sig->signal_received = sig;
-    multi_close_instance_on_signal(m, mi);
-}
-
 static void
 management_callback_status(void *arg, const int version, struct status_output *so)
 {
@@ -3762,10 +3896,6 @@ management_delete_event(void *arg, event_t event)
     }
 }
 
-#endif /* ifdef ENABLE_MANAGEMENT */
-
-#ifdef ENABLE_MANAGEMENT
-
 static struct multi_instance *
 lookup_by_cid(struct multi_context *m, const unsigned long cid)
 {
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index f1e9ab91..370d795c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -98,7 +98,9 @@ struct client_connect_defer_state
  * server-mode.
  */
 struct multi_instance {
-    struct schedule_entry se;  /* this must be the first element of the structure */
+    struct schedule_entry se;  /* this must be the first element of the structure,
+                                * We cast between this and schedule_entry so the
+                                * beginning of the struct must be identical */
     struct gc_arena gc;
     bool halt;
     int refcount;
@@ -310,6 +312,16 @@ void multi_process_float(struct multi_context *m, struct multi_instance *mi);
  */
 bool multi_process_post(struct multi_context *m, struct multi_instance *mi, const unsigned int flags);
 
+/**
+ * Process an incoming DCO message (from kernel space).
+ *
+ * @param m            - The single \c multi_context structur.e
+ *
+ * @return
+ *  - True, if the message was received correctly.
+ *  - False, if there was an error while reading the message.
+ */
+bool multi_process_incoming_dco(struct multi_context *m);
 
 /**************************************************************************/
 /**
-- 
2.35.1


