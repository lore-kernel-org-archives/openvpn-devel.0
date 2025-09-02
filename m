From: Gert Doering <gert@...1296...>
Date: Tue,  2 Sep 2025 14:25:36 +0200
Message-ID: <20250902122542.31023-1-gert@...1296...>
In-Reply-To: <gerrit.1754914153000.I525d7300e49f9a5a18e7146ee35ccc2af8184b8a@...2715...>
References: <gerrit.1754914153000.I525d7300e49f9a5a18e7146ee35ccc2af8184b8a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco-win: add support for multipeer stats
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

From: Lev Stipakov <lev@...515...>

Use the new driver API to fetch per-peer link and VPN byte counters
in both client and server modes.

Two usage modes are supported:

 - Single peer: pass the peer ID and a fixed-size output buffer. If the
   IOCTL is not supported (old driver), fall back to the legacy API.

 - All peers: first call the IOCTL with a small output buffer to get
   the required size, then allocate a buffer and call again to fetch
   stats for all peers.

Change-Id: I525d7300e49f9a5a18e7146ee35ccc2af8184b8a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1143
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 5317ac1..bf3f151 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -30,6 +30,7 @@
 #include "forward.h"
 #include "tun.h"
 #include "crypto.h"
+#include "multi.h"
 #include "ssl_common.h"
 #include "openvpn.h"
 
@@ -190,6 +191,8 @@
 {
     dco_context_t *dco = &c->c1.tuntap->dco;
 
+    dco->c = c;
+
     switch (c->mode)
     {
         case MODE_POINT_TO_POINT:
@@ -714,12 +717,132 @@
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
 {
-    /* Not implemented. */
-    return 0;
+    struct gc_arena gc = gc_new();
+
+    int ret = 0;
+    struct tuntap *tt = dco->tt;
+
+    if (!tuntap_defined(tt))
+    {
+        ret = -1;
+        goto done;
+    }
+
+    OVPN_GET_PEER_STATS ps = {
+        .PeerId = -1
+    };
+
+    DWORD required_size = 0, bytes_returned = 0;
+    /* first, figure out buffer size */
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_GET_PEER_STATS, &ps, sizeof(ps), &required_size, sizeof(DWORD), &bytes_returned, NULL))
+    {
+        if (GetLastError() == ERROR_MORE_DATA)
+        {
+            if (bytes_returned != sizeof(DWORD))
+            {
+                msg(M_WARN, "%s: invalid bytes returned for size query (%lu, expected %zu)", __func__, bytes_returned, sizeof(DWORD));
+                ret = -1;
+                goto done;
+            }
+            /* required_size now contains the size written by the driver */
+            if (required_size == 0)
+            {
+                ret = 0; /* no peers to process */
+                goto done;
+            }
+            if (required_size < sizeof(OVPN_PEER_STATS))
+            {
+                msg(M_WARN, "%s: invalid required size %lu (minimum %zu)", __func__, required_size, sizeof(OVPN_PEER_STATS));
+                ret = -1;
+                goto done;
+            }
+        }
+        else
+        {
+            msg(M_WARN | M_ERRNO, "%s: failed to fetch required buffer size", __func__);
+            ret = -1;
+            goto done;
+        }
+    }
+    else
+    {
+        /* unexpected success? */
+        if (bytes_returned == 0)
+        {
+            ret = 0; /* no peers to process */
+            goto done;
+        }
+
+        msg(M_WARN, "%s: first DeviceIoControl call succeeded unexpectedly (%lu bytes returned)", __func__, bytes_returned);
+        ret = -1;
+        goto done;
+    }
+
+
+    /* allocate the buffer and fetch stats */
+    OVPN_PEER_STATS *peer_stats = gc_malloc(required_size, true, &gc);
+    if (!peer_stats)
+    {
+        msg(M_WARN, "%s: failed to allocate buffer of size %lu", __func__, required_size);
+        ret = -1;
+        goto done;
+    }
+
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_GET_PEER_STATS, &ps, sizeof(ps), peer_stats, required_size, &bytes_returned, NULL))
+    {
+        /* unlikely case when a peer has been added since fetching buffer size, not an error! */
+        if (GetLastError() == ERROR_MORE_DATA)
+        {
+            msg(M_WARN, "%s: peer has been added, skip fetching stats", __func__);
+            ret = 0;
+            goto done;
+        }
+
+        msg(M_WARN | M_ERRNO, "%s: failed to fetch multipeer stats", __func__);
+        ret = -1;
+        goto done;
+    }
+
+    /* iterate over stats and update peers */
+    for (int i = 0; i < bytes_returned / sizeof(OVPN_PEER_STATS); ++i)
+    {
+        OVPN_PEER_STATS *stat = &peer_stats[i];
+
+        if (stat->PeerId >= dco->c->multi->max_clients)
+        {
+            msg(M_WARN, "%s: received out of bound peer_id %u (max=%u)", __func__, stat->PeerId,
+                dco->c->multi->max_clients);
+            continue;
+        }
+
+        struct multi_instance *mi = dco->c->multi->instances[stat->PeerId];
+        if (!mi)
+        {
+            msg(M_WARN, "%s: received data for a non-existing peer %u", __func__, stat->PeerId);
+            continue;
+        }
+
+        /* update peer stats */
+        struct context_2 *c2 = &mi->context.c2;
+        c2->dco_read_bytes = stat->LinkRxBytes;
+        c2->dco_write_bytes = stat->LinkTxBytes;
+        c2->tun_read_bytes = stat->VpnRxBytes;
+        c2->tun_write_bytes = stat->VpnTxBytes;
+    }
+
+done:
+    gc_free(&gc);
+
+    if (raise_sigusr1_on_err && ret < 0)
+    {
+        register_signal(dco->c->sig, SIGUSR1, "dco peer stats error");
+    }
+
+    return ret;
 }
 
 int
-dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
+dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on_err)
 {
     struct tuntap *tt = c->c1.tuntap;
 
@@ -747,6 +870,48 @@
     return 0;
 }
 
+int
+dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
+{
+    struct tuntap *tt = c->c1.tuntap;
+
+    if (!tuntap_defined(tt))
+    {
+        return -1;
+    }
+
+    /* first, try a new ioctl */
+    OVPN_GET_PEER_STATS ps = { .PeerId = c->c2.tls_multi->dco_peer_id };
+
+    OVPN_PEER_STATS peer_stats = { 0 };
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_GET_PEER_STATS, &ps, sizeof(ps), &peer_stats, sizeof(peer_stats),
+                         &bytes_returned, NULL))
+    {
+        if (GetLastError() == ERROR_INVALID_FUNCTION)
+        {
+            /* are we using the old driver? */
+            return dco_get_peer_stats_fallback(c, raise_sigusr1_on_err);
+        }
+
+        msg(M_WARN | M_ERRNO, "%s: DeviceIoControl(OVPN_IOCTL_GET_PEER_STATS) failed", __func__);
+        return -1;
+    }
+
+    if (bytes_returned != sizeof(OVPN_PEER_STATS))
+    {
+        msg(M_WARN | M_ERRNO, "%s: DeviceIoControl(OVPN_IOCTL_GET_PEER_STATS) returnted invalid size", __func__);
+        return -1;
+    }
+
+    c->c2.dco_read_bytes = peer_stats.LinkRxBytes;
+    c->c2.dco_write_bytes = peer_stats.LinkTxBytes;
+    c->c2.tun_read_bytes = peer_stats.VpnRxBytes;
+    c->c2.tun_write_bytes = peer_stats.VpnTxBytes;
+
+    return 0;
+}
+
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index a7f4865..4f3f028 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -57,6 +57,8 @@
 
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
+
+    struct context *c;
 };
 
 typedef struct dco_context dco_context_t;
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index baf7214..9e1378a 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -83,6 +83,14 @@
 	LONG64 TunBytesReceived;
 } OVPN_STATS, * POVPN_STATS;
 
+typedef struct _OVPN_PEER_STATS {
+    int PeerId;
+    LONG64 LinkRxBytes;
+    LONG64 LinkTxBytes;
+    LONG64 VpnRxBytes;
+    LONG64 VpnTxBytes;
+} OVPN_PEER_STATS, * POVPN_PEER_STATS;
+
 typedef enum _OVPN_KEY_SLOT {
 	OVPN_KEY_SLOT_PRIMARY,
 	OVPN_KEY_SLOT_SECONDARY
@@ -185,6 +193,10 @@
     int IPv6;
 } OVPN_MP_IROUTE, * POVPN_MP_IROUTE;
 
+typedef struct _OVPN_GET_PEER_STATS {
+    int PeerId; // -1 for all peers stats
+} OVPN_GET_PEER_STATS, * POVPN_GET_PEER_STATS;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)
@@ -207,3 +219,5 @@
 
 #define OVPN_IOCTL_MP_ADD_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 17, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_MP_DEL_IROUTE CTL_CODE(FILE_DEVICE_UNKNOWN, 18, METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_GET_PEER_STATS CTL_CODE(FILE_DEVICE_UNKNOWN, 19, METHOD_BUFFERED, FILE_ANY_ACCESS)

