From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:57 +0200
Message-Id: <20220624083809.23487-14-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 13/25] dco: implement dco support for
 p2p/client code path
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

With this change we introduce ovpn-dco support only along the p2p/client
code path. Server codebase is still unchanged.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c     | 90 +++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/dco.h     | 48 +++++++++++++++++++++++
 src/openvpn/event.h   |  3 ++
 src/openvpn/forward.c | 63 ++++++++++++++++++++++++++++--
 src/openvpn/init.c    | 34 +++++++++++++++-
 src/openvpn/init.h    |  2 +-
 src/openvpn/socket.h  |  1 +
 7 files changed, 236 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 473eb564..2919c46d 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -300,4 +300,94 @@ dco_check_option_conflict(int msglevel, const struct options *o)
     return true;
 }
 
+int
+dco_p2p_add_new_peer(struct context *c)
+{
+    if (!dco_enabled(&c->options))
+    {
+        return 0;
+    }
+
+
+    struct tls_multi *multi = c->c2.tls_multi;
+    struct link_socket *ls = c->c2.link_socket;
+
+    struct in6_addr remote_ip6 = { 0 };
+    struct in_addr remote_ip4 = { 0 };
+
+    struct in6_addr *remote_addr6 = NULL;
+    struct in_addr *remote_addr4 = NULL;
+
+    const char *gw = NULL;
+
+    ASSERT(ls->info.connection_established);
+
+    /* In client mode if a P2P style topology is used we assume the
+     * remote-gateway is the IP of the peer */
+    if (c->options.topology == TOP_NET30 || c->options.topology == TOP_P2P)
+    {
+        gw = c->options.ifconfig_remote_netmask;
+    }
+    if (c->options.route_default_gateway)
+    {
+        gw = c->options.route_default_gateway;
+    }
+
+    /* These inet_pton conversion are fatal since options.c already implements
+     * checks to have only valid addresses when setting the options */
+    if (c->options.ifconfig_ipv6_remote)
+    {
+        if (inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote, &remote_ip6) != 1)
+        {
+            msg(M_FATAL,
+                "DCO peer init: problem converting IPv6 ifconfig remote address %s to binary",
+                c->options.ifconfig_ipv6_remote);
+        }
+        remote_addr6 = &remote_ip6;
+    }
+
+    if (gw)
+    {
+        if (inet_pton(AF_INET, gw, &remote_ip4) != 1)
+        {
+            msg(M_FATAL, "DCO peer init: problem converting IPv4 ifconfig gateway address %s to binary", gw);
+        }
+        remote_addr4 = &remote_ip4;
+    }
+    else if (c->options.ifconfig_local)
+    {
+        msg(M_INFO, "DCO peer init: Need a peer VPN addresss to setup IPv4 (set --route-gateway)");
+    }
+
+    struct sockaddr *remoteaddr = &ls->info.lsa->actual.dest.addr.sa;
+
+    int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
+                           c->c2.link_socket->sd, NULL, remoteaddr,
+                           remote_addr4, remote_addr6);
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    c->c2.tls_multi->dco_peer_added = true;
+    c->c2.link_socket->info.dco_installed = true;
+
+    return 0;
+}
+
+void
+dco_remove_peer(struct context *c)
+{
+    if (!dco_enabled(&c->options))
+    {
+        return;
+    }
+
+    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_added)
+    {
+        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id);
+        c->c2.tls_multi->dco_peer_added = false;
+    }
+}
+
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index cb7f7e4f..33b91e29 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -138,6 +138,36 @@ int init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
  */
 void dco_update_keys(dco_context_t *dco, struct tls_multi *multi);
 
+/**
+ * Install a new peer in DCO - to be called by a CLIENT (or P2P) instance
+ *
+ * @param c         the main instance context
+ * @return          0 on success or a negative error code otherwise
+ */
+int dco_p2p_add_new_peer(struct context *c);
+
+/**
+ * Modify DCO peer options. Special values are 0 (disable)
+ * and -1 (do not touch).
+ *
+ * @param dco                DCO device context
+ * @param peer_id            the ID of the peer to be modified
+ * @param keepalive_interval keepalive interval in seconds
+ * @param keepalive_timeout  keepalive timeout in seconds
+ * @param mss                TCP MSS value
+ *
+ * @return                   0 on success or a negative error code otherwise
+ */
+int dco_set_peer(dco_context_t *dco, unsigned int peerid,
+                 int keepalive_interval, int keepalive_timeout, int mss);
+
+/**
+ * Remove a peer from DCO
+ *
+ * @param c         the main instance context of the peer to remove
+ */
+void dco_remove_peer(struct context *c);
+
 #else /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -204,5 +234,23 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
     ASSERT(false);
 }
 
+static inline bool
+dco_p2p_add_new_peer(struct context *c)
+{
+    return true;
+}
+
+static inline int
+dco_set_peer(dco_context_t *dco, unsigned int peerid,
+             int keepalive_interval, int keepalive_timeout, int mss)
+{
+    return 0;
+}
+
+static inline void
+dco_remove_peer(struct context *c)
+{
+}
+
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index a472afbe..f2438f97 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -72,6 +72,9 @@
 #define MANAGEMENT_WRITE    (1 << (MANAGEMENT_SHIFT + WRITE_SHIFT))
 #define FILE_SHIFT          8
 #define FILE_CLOSED         (1 << (FILE_SHIFT + READ_SHIFT))
+#define DCO_SHIFT           10
+#define DCO_READ            (1 << (DCO_SHIFT + READ_SHIFT))
+#define DCO_WRITE           (1 << (DCO_SHIFT + WRITE_SHIFT))
 
 /*
  * Initialization flags passed to event_set_init
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 99898e01..15bdbbae 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1103,6 +1103,39 @@ process_incoming_link(struct context *c)
     perf_pop();
 }
 
+static void
+process_incoming_dco(struct context *c)
+{
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    struct link_socket_info *lsi = get_link_socket_info(c);
+    dco_context_t *dco = &c->c1.tuntap->dco;
+
+    dco_do_read(dco);
+
+    if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
+    {
+        trigger_ping_timeout_signal(c);
+        return;
+    }
+
+    if (dco->dco_message_type != OVPN_CMD_PACKET)
+    {
+        msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
+            dco->dco_message_type);
+        return;
+    }
+
+    struct buffer orig_buff = c->c2.buf;
+    c->c2.buf = dco->dco_packet_in;
+    c->c2.from = lsi->lsa->actual;
+
+    process_incoming_link(c);
+
+    c->c2.buf = orig_buff;
+    buf_init(&dco->dco_packet_in, 0);
+#endif /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+}
+
 /*
  * Output: c->c2.buf
  */
@@ -1626,9 +1659,17 @@ process_outgoing_link(struct context *c)
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                size = link_socket_write(c->c2.link_socket,
-                                         &c->c2.to_link,
-                                         to_addr);
+                if (c->c2.link_socket->info.dco_installed)
+                {
+                    size = dco_do_write(&c->c1.tuntap->dco,
+                                        c->c2.tls_multi->peer_id,
+                                        &c->c2.to_link);
+                }
+                else
+                {
+                    size = link_socket_write(c->c2.link_socket, &c->c2.to_link,
+                                             to_addr);
+                }
 
                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->c2.to_link);
@@ -1898,6 +1939,9 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 #ifdef ENABLE_ASYNC_PUSH
     static int file_shift = FILE_SHIFT;
 #endif
+#ifdef TARGET_LINUX
+    static int dco_shift = DCO_SHIFT;    /* Event from DCO linux kernel module */
+#endif
 
     /*
      * Decide what kind of events we want to wait for.
@@ -2005,6 +2049,12 @@ io_wait_dowork(struct context *c, const unsigned int flags)
      */
     socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket_shift, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
+#if defined(TARGET_LINUX)
+    if (socket & EVENT_READ && c->c2.did_open_tun)
+    {
+        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)&dco_shift);
+    }
+#endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -2127,4 +2177,11 @@ process_io(struct context *c)
             process_incoming_tun(c);
         }
     }
+    else if (status & DCO_READ)
+    {
+        if (!IS_SIG(c))
+        {
+            process_incoming_dco(c);
+        }
+    }
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 091cbd24..bdd2ad96 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2094,6 +2094,19 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             }
         }
 
+        if (c->mode == MODE_POINT_TO_POINT)
+        {
+            /* ovpn-dco requires adding the peer now, before any option can be set,
+             * but *after* having parsed the pushed peer-id in do_deferred_options()
+             */
+            int ret = dco_p2p_add_new_peer(c);
+            if (ret < 0)
+            {
+                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
+                return false;
+            }
+        }
+
         if (!pulled_options && c->mode == MODE_POINT_TO_POINT)
         {
             if (!do_deferred_p2p_ncp(c))
@@ -2109,7 +2122,6 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             return false;
         }
 
-
         if (c->c2.did_open_tun)
         {
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
@@ -2364,6 +2376,22 @@ finish_options(struct context *c)
         return false;
     }
 
+    if (dco_enabled(&c->options)
+        && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
+    {
+        int ret = dco_set_peer(&c->c1.tuntap->dco,
+                               c->c2.tls_multi->peer_id,
+                               c->options.ping_send_timeout,
+                               c->options.ping_rec_timeout,
+                               c->c2.frame.mss_fix);
+        if (ret < 0)
+        {
+            msg(D_DCO, "Cannot set parameters for DCO peer (id=%u): %s",
+                c->c2.tls_multi->peer_id, strerror(-ret));
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -4337,6 +4365,10 @@ close_instance(struct context *c)
         /* free buffers */
         do_close_free_buf(c);
 
+        /* close peer for DCO if enabled, needs peer-id so must be done before
+         * closing TLS contexts */
+        dco_remove_peer(c);
+
         /* close TLS */
         do_close_tls(c);
 
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 98e71d3a..5cc2a990 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -30,7 +30,7 @@
  * Baseline maximum number of events
  * to wait for.
  */
-#define BASE_N_EVENTS 4
+#define BASE_N_EVENTS 5
 
 void context_clear(struct context *c);
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index a75adb00..0d521d22 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -120,6 +120,7 @@ struct link_socket_info
     sa_family_t af;                     /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
     bool bind_ipv6_only;
     int mtu_changed;            /* Set to true when mtu value is changed */
+    bool dco_installed;
 };
 
 /*
-- 
2.35.1


