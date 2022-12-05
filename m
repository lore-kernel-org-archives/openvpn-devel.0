From: Kristof Provost <kprovost@...2661...>
Date: Mon,  5 Dec 2022 17:41:00 +0100
Message-Id: <20221205164103.9190-2-kprovost@...2661...>
In-Reply-To: <20221205164103.9190-1-kprovost@...2661...>
References: <20221205164103.9190-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Read DCO traffic stats from the kernel
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

When DCO is active userspace doesn't see all of the traffic, so when we
access these stats we must update them.

Retrieve kernel statistics every time we access the
link_(read|write)_bytes values.

Introduce a dco_(read|write)_bytes so that we don't clobber the existing
statistics, which still count control packets, sent or received directly
through the socket.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco.h              |  8 ++++
 src/openvpn/dco_freebsd.c      | 78 ++++++++++++++++++++++++++++++++++
 src/openvpn/dco_linux.c        |  7 +++
 src/openvpn/dco_win.c          |  7 +++
 src/openvpn/multi.c            | 30 +++++++------
 src/openvpn/openvpn.h          |  2 +
 src/openvpn/ovpn_dco_freebsd.h |  1 +
 7 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index e051db06..e5d89358 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -225,6 +225,14 @@ void dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
  */
 void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
 
+/**
+ * Update traffic statistics for all peers
+ *
+ * @param dco	DCO device context
+ * @param m	the server context
+ **/
+int dco_get_peer_stats(dco_context_t *dco, struct multi_context *m);
+
 /**
  * Retrieve the list of ciphers supported by the current platform
  *
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index a52ac8c1..5b352859 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -37,6 +37,7 @@
 #include "dco.h"
 #include "tun.h"
 #include "crypto.h"
+#include "multi.h"
 #include "ssl_common.h"
 
 static nvlist_t *
@@ -641,6 +642,83 @@ dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
     nvlist_destroy(nvl);
 }
 
+static void
+dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
+{
+    struct hash_element *he;
+    struct hash_iterator hi;
+
+    hash_iterator_init(m->hash, &hi);
+
+    while ((he = hash_iterator_next(&hi)))
+    {
+        struct multi_instance *mi = (struct multi_instance *) he->value;
+
+        if (mi->context.c2.tls_multi->peer_id != peerid)
+            continue;
+
+        mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
+        mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
+
+        return;
+    }
+
+    msg(M_INFO, "Peer %d returned by kernel, but not found locally", peerid);
+}
+
+int
+dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+{
+
+    struct ifdrv drv;
+    uint8_t buf[4096];
+    nvlist_t *nvl;
+    const nvlist_t *const *nvpeers;
+    size_t npeers;
+    int ret;
+
+    if (!dco || !dco->open)
+    {
+        return 0;
+    }
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_GET_PEER_STATS;
+    drv.ifd_len = sizeof(buf);
+    drv.ifd_data = buf;
+
+    ret = ioctl(dco->fd, SIOCGDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to get peer stats");
+        return -EINVAL;
+    }
+
+    nvl = nvlist_unpack(buf, drv.ifd_len, 0);
+    if (! nvl)
+    {
+        msg(M_WARN, "Failed to unpack nvlist");
+        return -EINVAL;
+    }
+
+    if (! nvlist_exists_nvlist_array(nvl, "peers")) {
+        /* no peers */
+        return 0;
+    }
+
+    nvpeers = nvlist_get_nvlist_array(nvl, "peers", &npeers);
+    for (size_t i = 0; i < npeers; i++)
+    {
+        const nvlist_t *peer = nvpeers[i];
+        uint32_t peerid = nvlist_get_number(peer, "peerid");
+
+        dco_update_peer_stat(m, peerid, nvlist_get_nvlist(peer, "bytes"));
+    }
+
+    return 0;
+}
+
 const char *
 dco_get_supported_ciphers()
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 10935820..0306cec3 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -911,6 +911,13 @@ nla_put_failure:
     return ret;
 }
 
+int
+dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+{
+    /* Not implemented. */
+    return 0;
+}
+
 bool
 dco_available(int msglevel)
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 48a1755a..68ec931c 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -399,6 +399,13 @@ dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
     return 0;
 }
 
+int
+dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+{
+    /* Not implemented. */
+    return 0;
+}
+
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0a23c2bc..38da87b8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -538,29 +538,31 @@ multi_del_iroutes(struct multi_context *m,
 }
 
 static void
-setenv_stats(struct context *c)
+setenv_stats(struct multi_context *m, struct context *c)
 {
-    setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes);
-    setenv_counter(c->c2.es, "bytes_sent", c->c2.link_write_bytes);
+    dco_get_peer_stats(&m->top.c1.tuntap->dco, m);
+
+    setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes + c->c2.dco_read_bytes);
+    setenv_counter(c->c2.es, "bytes_sent", c->c2.link_write_bytes + c->c2.dco_write_bytes);
 }
 
 static void
-multi_client_disconnect_setenv(struct multi_instance *mi)
+multi_client_disconnect_setenv(struct multi_context *m, struct multi_instance *mi)
 {
     /* setenv client real IP address */
     setenv_trusted(mi->context.c2.es, get_link_socket_info(&mi->context));
 
     /* setenv stats */
-    setenv_stats(&mi->context);
+    setenv_stats(m, &mi->context);
 
     /* setenv connection duration */
     setenv_long_long(mi->context.c2.es, "time_duration", now - mi->created);
 }
 
 static void
-multi_client_disconnect_script(struct multi_instance *mi)
+multi_client_disconnect_script(struct multi_context *m, struct multi_instance *mi)
 {
-    multi_client_disconnect_setenv(mi);
+    multi_client_disconnect_setenv(m, mi);
 
     if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))
     {
@@ -667,7 +669,7 @@ multi_close_instance(struct multi_context *m,
 
     if (mi->context.c2.tls_multi->multi_state >= CAS_CONNECT_DONE)
     {
-        multi_client_disconnect_script(mi);
+        multi_client_disconnect_script(m, mi);
     }
 
     close_context(&mi->context, SIGTERM, CC_GC_FREE);
@@ -837,6 +839,8 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
 
         status_reset(so);
 
+        dco_get_peer_stats(&m->top.c1.tuntap->dco, m);
+
         if (version == 1)
         {
             /*
@@ -856,8 +860,8 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
                     status_printf(so, "%s,%s," counter_format "," counter_format ",%s",
                                   tls_common_name(mi->context.c2.tls_multi, false),
                                   mroute_addr_print(&mi->real, &gc),
-                                  mi->context.c2.link_read_bytes,
-                                  mi->context.c2.link_write_bytes,
+                                  mi->context.c2.link_read_bytes + mi->context.c2.dco_read_bytes,
+                                  mi->context.c2.link_write_bytes + mi->context.c2.dco_write_bytes,
                                   time_string(mi->created, 0, false, &gc));
                 }
                 gc_free(&gc);
@@ -932,8 +936,8 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
                                   sep, mroute_addr_print(&mi->real, &gc),
                                   sep, print_in_addr_t(mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
                                   sep, print_in6_addr(mi->reporting_addr_ipv6, IA_EMPTY_IF_UNDEF, &gc),
-                                  sep, mi->context.c2.link_read_bytes,
-                                  sep, mi->context.c2.link_write_bytes,
+                                  sep, mi->context.c2.link_read_bytes + mi->context.c2.dco_read_bytes,
+                                  sep, mi->context.c2.link_write_bytes + mi->context.c2.dco_write_bytes,
                                   sep, time_string(mi->created, 0, false, &gc),
                                   sep, (unsigned int)mi->created,
                                   sep, tls_username(mi->context.c2.tls_multi, false),
@@ -2752,7 +2756,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
          * did not fail */
         if (mi->context.c2.tls_multi->multi_state == CAS_PENDING_DEFERRED_PARTIAL)
         {
-            multi_client_disconnect_script(mi);
+            multi_client_disconnect_script(m, mi);
         }
 
         mi->context.c2.tls_multi->multi_state = CAS_FAILED;
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index c543cbf6..5981e4d5 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -267,8 +267,10 @@ struct context_2
     counter_type tun_read_bytes;
     counter_type tun_write_bytes;
     counter_type link_read_bytes;
+    counter_type dco_read_bytes;
     counter_type link_read_bytes_auth;
     counter_type link_write_bytes;
+    counter_type dco_write_bytes;
 #ifdef PACKET_TRUNCATION_CHECK
     counter_type n_trunc_tun_read;
     counter_type n_trunc_tun_write;
diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
index cf92d597..cc90111e 100644
--- a/src/openvpn/ovpn_dco_freebsd.h
+++ b/src/openvpn/ovpn_dco_freebsd.h
@@ -61,5 +61,6 @@ enum ovpn_key_cipher {
 #define OVPN_POLL_PKT           _IO('D', 10)
 #define OVPN_GET_PKT            _IO('D', 11)
 #define OVPN_SET_IFMODE         _IO('D', 12)
+#define OVPN_GET_PEER_STATS     _IO('D', 13)
 
 #endif /* ifndef _NET_IF_OVPN_H_ */
-- 
2.38.1


