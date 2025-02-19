From: Gert Doering <gert@...1296...>
Date: Wed, 19 Feb 2025 22:54:17 +0100
Message-ID: <20250219215417.18260-1-gert@...1296...>
In-Reply-To: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v20] dco-win: multipeer support
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

This is the main commit for dco-win multipeer
implementation.

This adds concept of "mode" to DCO implementation,
which is peer-to-peer or multipeer. Depending on mode,
some functions use MP-specific IOCTL commands, which
include peer-id as a part of input.

The driver initialization accomodates server mode,
in which tun device is created before transport.

Since on Windows the socket is visible to the kernel only,
control channel packets have to be prepended with remote
sockaddr of the peer - this allows userspace to distinguish
among peers. Sadly there is no reliable way to get peer local
address, such as on Linux/FreeBSD, so we have to do a bit of
guesswork to figure out IP address based on remote IP and local
routing table, which may backfire if there are multiple IPs
assigned to the same network adapter. However, as for now
peer-specific local IP is not used by the driver. We use
instead the result of bind() to the listening address.

Existing sockethandle_finalize() function has been refactored
to accomodate packets with possibly prepended sockaddr.

Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/815
This mail reflects revision 20 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 035474f..7f2021d 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -106,9 +106,10 @@
  *
  * @param mode      the instance operating mode (P2P or multi-peer)
  * @param dco       the context to initialize
+ * @param dev_node  device node, used on Windows to specify certain DCO adapter
  * @return          true on success, false otherwise
  */
-bool ovpn_dco_init(int mode, dco_context_t *dco);
+bool ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node);
 
 /**
  * Open/create a DCO interface
@@ -284,7 +285,7 @@
 }
 
 static inline bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
 {
     return true;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index f4c3b02..0e536de 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -165,7 +165,7 @@
 }
 
 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
 {
     if (open_fd(dco) < 0)
     {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index fa7abd3..68c1a8d 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -422,7 +422,7 @@
 }
 
 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
 {
     switch (mode)
     {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 46b2d03..56ec178 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -28,6 +28,7 @@
 #include "syshead.h"
 
 #include "dco.h"
+#include "forward.h"
 #include "tun.h"
 #include "crypto.h"
 #include "ssl_common.h"
@@ -41,15 +42,22 @@
 const IN_ADDR in4addr_any = { 0 };
 #endif
 
-struct tuntap
-create_dco_handle(const char *devname, struct gc_arena *gc)
+/* Sometimes IP Helper API, which we use for setting IP address etc,
+ * complains that interface is not found. Give it some time to settle
+ */
+static void
+dco_wait_ready(DWORD idx)
 {
-    struct tuntap tt = { .backend_driver = DRIVER_DCO };
-    const char *device_guid;
-
-    tun_open_device(&tt, devname, &device_guid, gc);
-
-    return tt;
+    for (int i = 0; i < 20; ++i)
+    {
+        MIB_IPINTERFACE_ROW row = { .InterfaceIndex = idx, .Family = AF_INET };
+        if (GetIpInterfaceEntry(&row) != ERROR_NOT_FOUND)
+        {
+            break;
+        }
+        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
+        Sleep(50);
+    }
 }
 
 /**
@@ -103,47 +111,51 @@
     return res;
 }
 
-bool
-ovpn_dco_init(int mode, dco_context_t *dco)
-{
-    return true;
-}
-
-int
-open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
-{
-    ASSERT(0);
-    return 0;
-}
-
-static void
-dco_wait_ready(DWORD idx)
-{
-    for (int i = 0; i < 20; ++i)
-    {
-        MIB_IPINTERFACE_ROW row = {.InterfaceIndex = idx, .Family = AF_INET};
-        if (GetIpInterfaceEntry(&row) != ERROR_NOT_FOUND)
-        {
-            break;
-        }
-        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
-        Sleep(50);
-    }
-}
-
+/**
+ * @brief Initializes the DCO adapter in multipeer mode and sets it to "connected" state.
+ *
+ * Opens the DCO device, sets the adapter mode using `OVPN_IOCTL_SET_MODE`,
+ * which transitions the adapter to the "connected" state, and waits for it to become ready.
+ *
+ * @param dco Pointer to the `dco_context_t` structure representing the DCO context.
+ * @param dev_node Device node string for the DCO adapter.
+ */
 void
-dco_start_tun(struct tuntap *tt)
+ovpn_dco_init_mp(dco_context_t *dco, const char *dev_node)
 {
-    msg(D_DCO_DEBUG, "%s", __func__);
+    ASSERT(dco->ifmode == DCO_MODE_UNINIT);
+    dco->ifmode = DCO_MODE_MP;
 
-    /* reference the tt object inside the DCO context, because the latter will
-     * be passed around
-     */
-    tt->dco.tt = tt;
+    /* open DCO device */
+    struct gc_arena gc = gc_new();
+    const char *device_guid;
+    tun_open_device(dco->tt, dev_node, &device_guid, &gc);
+    gc_free(&gc);
 
+    /* set mp mode */
+    OVPN_MODE m = OVPN_MODE_MP;
     DWORD bytes_returned = 0;
-    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
-                         &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_MODE, &m, sizeof(m), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SET_MODE) failed");
+    }
+
+    dco_wait_ready(dco->tt->adapter_index);
+}
+
+/**
+ * @brief Transitions the DCO adapter to the connected state in P2P mode.
+ *
+ * Sends `OVPN_IOCTL_START_VPN` to start the VPN and waits for the adapter
+ * to become ready.
+ *
+ * @param tt Pointer to the `tuntap` structure representing the adapter.
+ */
+void
+dco_p2p_start_vpn(struct tuntap *tt)
+{
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0, &bytes_returned, NULL))
     {
         msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed");
     }
@@ -154,6 +166,44 @@
     dco_wait_ready(tt->adapter_index);
 }
 
+
+/**
+ * @brief Initializes DCO depends on `mode`
+ *
+ *  - for P2P it puts adapter in "connected" state. The peer should
+ * be already added by dco_p2p_new_peer().
+ *
+ *  - for multipeer it opens DCO adapter and puts it into "connected"
+ * state. The server socket should be initialized later by dco_mp_start_vpn().
+ */
+bool
+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+{
+    switch (mode)
+    {
+        case MODE_POINT_TO_POINT:
+            dco->ifmode = DCO_MODE_P2P;
+            dco_p2p_start_vpn(dco->tt);
+            break;
+
+        case MODE_SERVER:
+            ovpn_dco_init_mp(dco, dev_node);
+            break;
+
+        default:
+            ASSERT(false);
+    }
+
+    return true;
+}
+
+int
+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
+{
+    ASSERT(0);
+    return 0;
+}
+
 static void
 dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)
 {
@@ -206,15 +256,68 @@
     register_signal(sig_info, SIGUSR1, "dco-connect-timeout");
 }
 
+/**
+ * @brief Initializes and binds the kernel UDP transport socket for multipeer mode.
+ *
+ * Sends `OVPN_IOCTL_MP_START_VPN` to create a kernel-mode UDP socket, binds it to
+ * the specified address, ready for incoming connections.
+ *
+ * @param handle Device handle for the DCO adapter.
+ * @param sock Pointer to the `link_socket` structure containing socket information.
+ */
 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
-                  struct addrinfo *bind, int timeout,
-                  struct signal_info *sig_info)
+dco_mp_start_vpn(HANDLE handle, struct link_socket *sock)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    int ai_family = sock->info.lsa->bind_local->ai_family;
+    struct addrinfo *local = sock->info.lsa->bind_local;
+    struct addrinfo *cur = NULL;
+
+    for (cur = local; cur; cur = cur->ai_next)
+    {
+        if (cur->ai_family == ai_family)
+        {
+            break;
+        }
+    }
+    if (!cur)
+    {
+        msg(M_FATAL, "%s: Socket bind failed: Addr to bind has no %s record",
+            __func__, addr_family_name(ai_family));
+    }
+
+    OVPN_MP_START_VPN in, out;
+    in.IPv6Only = sock->info.bind_ipv6_only ? 1 : 0;
+    if (ai_family == AF_INET)
+    {
+        memcpy(&in.ListenAddress.Addr4, cur->ai_addr, sizeof(struct sockaddr_in));
+    }
+    else
+    {
+        memcpy(&in.ListenAddress.Addr6, cur->ai_addr, sizeof(struct sockaddr_in6));
+    }
+
+    /* in multipeer mode control channel packets are prepended with remote peer's sockaddr */
+    sock->sockflags |= SF_PREPEND_SA;
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(handle, OVPN_IOCTL_MP_START_VPN, &in, sizeof(in), &out, sizeof(out),
+                         &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_MP_START_VPN) failed");
+    }
+}
+
+void
+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_info *sig_info)
 {
     msg(D_DCO_DEBUG, "%s", __func__);
 
     OVPN_NEW_PEER peer = { 0 };
 
+    struct addrinfo *remoteaddr = sock->info.lsa->current_remote;
+
     struct sockaddr *local = NULL;
     struct sockaddr *remote = remoteaddr->ai_addr;
 
@@ -228,9 +331,10 @@
         peer.Proto = OVPN_PROTO_UDP;
     }
 
-    if (bind_local)
+    if (sock->bind_local)
     {
         /* Use first local address with correct address family */
+        struct addrinfo *bind = sock->info.lsa->bind_local;
         while (bind && !local)
         {
             if (bind->ai_family == remote->sa_family)
@@ -241,7 +345,7 @@
         }
     }
 
-    if (bind_local && !local)
+    if (sock->bind_local && !local)
     {
         msg(M_FATAL, "DCO: Socket bind failed: Address to bind lacks %s record",
             addr_family_name(remote->sa_family));
@@ -290,7 +394,7 @@
         }
         else
         {
-            dco_connect_wait(handle, &ov, timeout, sig_info);
+            dco_connect_wait(handle, &ov, get_server_poll_remaining_time(sock->server_poll_timeout), sig_info);
         }
     }
 }
@@ -301,6 +405,48 @@
              struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+
+    if (dco->ifmode == DCO_MODE_P2P)
+    {
+        /* no-op for p2p */
+        return 0;
+    }
+
+    OVPN_MP_NEW_PEER newPeer = {0};
+
+    if (remoteaddr)
+    {
+        /* while the driver doesn't use the local address yet it requires its AF to be valid */
+        newPeer.Local.Addr4.sin_family = remoteaddr->sa_family;
+
+        if (remoteaddr->sa_family == AF_INET)
+        {
+            memcpy(&newPeer.Remote.Addr4, remoteaddr, sizeof(struct sockaddr_in));
+        }
+        else
+        {
+            memcpy(&newPeer.Remote.Addr6, remoteaddr, sizeof(struct sockaddr_in6));
+        }
+    }
+
+    if (vpn_ipv4)
+    {
+        newPeer.VpnAddr4 = *vpn_ipv4;
+    }
+
+    if (vpn_ipv6)
+    {
+        newPeer.VpnAddr6 = *vpn_ipv6;
+    }
+
+    newPeer.PeerId = peerid;
+
+    DWORD bytesReturned;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_NEW_PEER, &newPeer, sizeof(newPeer), NULL, 0, &bytesReturned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+    }
+
     return 0;
 }
 
@@ -309,9 +455,20 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
 
+    OVPN_MP_DEL_PEER del_peer = { peerid };
+    VOID *buf = NULL;
+    DWORD len = 0;
+    DWORD ioctl = OVPN_IOCTL_DEL_PEER;
+
+    if (dco->ifmode == DCO_MODE_MP)
+    {
+        ioctl = OVPN_IOCTL_MP_DEL_PEER;
+        buf = &del_peer;
+        len = sizeof(del_peer);
+    }
+
     DWORD bytes_returned = 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_DEL_PEER, NULL,
-                         0, NULL, 0, &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_returned, NULL))
     {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_DEL_PEER) failed");
         return -1;
@@ -326,19 +483,30 @@
     msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
         peerid, keepalive_interval, keepalive_timeout, mss);
 
-    OVPN_SET_PEER peer;
+    OVPN_MP_SET_PEER mp_peer = { peerid, keepalive_interval, keepalive_timeout, mss };
+    OVPN_SET_PEER peer = { keepalive_interval, keepalive_timeout, mss };
+    VOID *buf = NULL;
+    DWORD len = 0;
+    DWORD ioctl = (dco->ifmode == DCO_MODE_MP) ? OVPN_IOCTL_MP_SET_PEER : OVPN_IOCTL_SET_PEER;
 
-    peer.KeepaliveInterval =  keepalive_interval;
-    peer.KeepaliveTimeout = keepalive_timeout;
-    peer.MSS = mss;
+    if (dco->ifmode == DCO_MODE_MP)
+    {
+        buf = &mp_peer;
+        len = sizeof(OVPN_MP_SET_PEER);
+    }
+    else
+    {
+        buf = &peer;
+        len = sizeof(OVPN_SET_PEER);
+    }
 
     DWORD bytes_returned = 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_PEER, &peer,
-                         sizeof(peer), NULL, 0, &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_returned, NULL))
     {
-        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed");
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_SET_PEER) failed");
         return -1;
     }
+
     return 0;
 }
 
@@ -397,9 +565,20 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
 
+    OVPN_MP_SWAP_KEYS swap = {peer_id};
+    DWORD ioctl = OVPN_IOCTL_SWAP_KEYS;
+    VOID *buf = NULL;
+    DWORD len = 0;
+
+    if (dco->ifmode == DCO_MODE_MP)
+    {
+        ioctl = OVPN_IOCTL_MP_SWAP_KEYS;
+        buf = &swap;
+        len = sizeof(swap);
+    }
+
     DWORD bytes_returned = 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SWAP_KEYS, NULL, 0, NULL, 0,
-                         &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_returned, NULL))
     {
         msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");
         return -1;
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 7688516..dc7fbc1 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -31,19 +31,25 @@
 typedef OVPN_KEY_SLOT dco_key_slot_t;
 typedef OVPN_CIPHER_ALG dco_cipher_t;
 
+typedef enum {
+    DCO_MODE_UNINIT,
+    DCO_MODE_P2P,
+    DCO_MODE_MP
+} dco_mode_type;
+
 struct dco_context {
     struct tuntap *tt;
+    dco_mode_type ifmode;
+
 };
 
 typedef struct dco_context dco_context_t;
 
-struct tuntap
-create_dco_handle(const char *devname, struct gc_arena *gc);
+void
+dco_mp_start_vpn(HANDLE handle, struct link_socket *sock);
 
 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
-                  struct addrinfo *bind, int timeout,
-                  struct signal_info *sig_info);
+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_info *sig_info);
 
 void
 dco_start_tun(struct tuntap *tt);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f3f3503..82c54c2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1323,7 +1323,10 @@
     }
     else
     {
-        sockethandle_t sh = { .is_handle = true, .h = c->c1.tuntap->hand };
+        /* we cannot end up here when using dco */
+        ASSERT(!dco_enabled(&c->options));
+
+        sockethandle_t sh = { .is_handle = true, .h = c->c1.tuntap->hand, .prepend_sa = false };
         sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
     }
 #else  /* ifdef _WIN32 */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4014517..6090140 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2005,7 +2005,7 @@
 
         if (dco_enabled(&c->options))
         {
-            ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
+            ovpn_dco_init(c->mode, &c->c1.tuntap->dco, c->options.dev_node);
         }
 
         /* open the tun device */
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index ea2a733..bfe939d 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -47,6 +47,23 @@
 	OVPN_PROTO Proto;
 } OVPN_NEW_PEER, * POVPN_NEW_PEER;
 
+typedef struct _OVPN_MP_NEW_PEER {
+    union {
+        SOCKADDR_IN Addr4;
+        SOCKADDR_IN6 Addr6;
+    } Local;
+
+    union {
+        SOCKADDR_IN Addr4;
+        SOCKADDR_IN6 Addr6;
+    } Remote;
+
+    IN_ADDR VpnAddr4;
+    IN6_ADDR VpnAddr6;
+
+    int PeerId;
+} OVPN_MP_NEW_PEER, * POVPN_MP_NEW_PEER;
+
 typedef struct _OVPN_STATS {
 	LONG LostInControlPackets;
 	LONG LostOutControlPackets;
@@ -94,10 +111,17 @@
 	int PeerId;
 } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;
 
+typedef struct _OVPN_MP_SET_PEER {
+    int PeerId;
+    LONG KeepaliveInterval;
+    LONG KeepaliveTimeout;
+    LONG MSS;
+} OVPN_MP_SET_PEER, * POVPN_MP_SET_PEER;
+
 typedef struct _OVPN_SET_PEER {
-	LONG KeepaliveInterval;
-	LONG KeepaliveTimeout;
-	LONG MSS;
+    LONG KeepaliveInterval;
+    LONG KeepaliveTimeout;
+    LONG MSS;
 } OVPN_SET_PEER, * POVPN_SET_PEER;
 
 typedef struct _OVPN_VERSION {
@@ -106,6 +130,50 @@
     LONG Patch;
 } OVPN_VERSION, * POVPN_VERSION;
 
+typedef enum {
+    OVPN_MODE_P2P,
+    OVPN_MODE_MP
+} OVPN_MODE;
+
+typedef struct _OVPN_SET_MODE {
+    OVPN_MODE Mode;
+} OVPN_SET_MODE, * POVPN_SET_MODE;
+
+typedef struct _OVPN_MP_START_VPN {
+    union {
+        SOCKADDR_IN Addr4;
+        SOCKADDR_IN6 Addr6;
+    } ListenAddress;
+    int IPv6Only;
+} OVPN_MP_START_VPN, * POVPN_MP_START_VPN;
+
+typedef enum {
+    OVPN_CMD_DEL_PEER,
+    OVPN_CMD_SWAP_KEYS
+} OVPN_NOTIFY_CMD;
+
+typedef enum {
+    OVPN_DEL_PEER_REASON_TEARDOWN,
+    OVPN_DEL_PEER_REASON_USERSPACE,
+    OVPN_DEL_PEER_REASON_EXPIRED,
+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT
+} OVPN_DEL_PEER_REASON;
+
+typedef struct _OVPN_NOTIFY_EVENT {
+    OVPN_NOTIFY_CMD Cmd;
+    int PeerId;
+    OVPN_DEL_PEER_REASON DelPeerReason;
+} OVPN_NOTIFY_EVENT, * POVPN_NOTIFY_EVENT;
+
+typedef struct _OVPN_MP_DEL_PEER {
+    int PeerId;
+} OVPN_MP_DEL_PEER, * POVPN_MP_DEL_PEER;
+
+typedef struct _OVPN_MP_SWAP_KEYS {
+    int PeerId;
+} OVPN_MP_SWAP_KEYS, * POVPN_MP_SWAP_KEYS;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)
@@ -114,3 +182,14 @@
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_SET_MODE     CTL_CODE(FILE_DEVICE_UNKNOWN, 10, METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_MP_START_VPN   CTL_CODE(FILE_DEVICE_UNKNOWN, 11, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_NEW_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 12, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_SET_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 13, METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_NOTIFY_EVENT   CTL_CODE(FILE_DEVICE_UNKNOWN, 14, METHOD_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE_DEVICE_UNKNOWN, 16, METHOD_BUFFERED, FILE_ANY_ACCESS)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d01b995..5b32885 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2177,12 +2177,22 @@
 create_socket_dco_win(struct context *c, struct link_socket *sock,
                       struct signal_info *sig_info)
 {
+    /* in P2P mode we must have remote resolved at this point */
+    struct addrinfo *remoteaddr = sock->info.lsa->current_remote;
+    if ((c->options.mode == MODE_POINT_TO_POINT) && (!remoteaddr))
+    {
+        return;
+    }
+
     if (!c->c1.tuntap)
     {
         struct tuntap *tt;
-        ALLOC_OBJ(tt, struct tuntap);
+        ALLOC_OBJ_CLEAR(tt, struct tuntap);
 
-        *tt = create_dco_handle(c->options.dev_node, &c->gc);
+        tt->backend_driver = DRIVER_DCO;
+
+        const char *device_guid = NULL; /* not used */
+        tun_open_device(tt, c->options.dev_node, &device_guid, &c->gc);
 
         /* Ensure we can "safely" cast the handle to a socket */
         static_assert(sizeof(sock->sd) == sizeof(tt->hand), "HANDLE and SOCKET size differs");
@@ -2190,12 +2200,14 @@
         c->c1.tuntap = tt;
     }
 
-    dco_create_socket(c->c1.tuntap->hand,
-                      sock->info.lsa->current_remote,
-                      sock->bind_local, sock->info.lsa->bind_local,
-                      get_server_poll_remaining_time(sock->server_poll_timeout),
-                      sig_info);
-
+    if (c->options.mode == MODE_SERVER)
+    {
+        dco_mp_start_vpn(c->c1.tuntap->hand, sock);
+    }
+    else
+    {
+        dco_p2p_new_peer(c->c1.tuntap->hand, sock, sig_info);
+    }
     sock->sockflags |= SF_DCO_WIN;
 
     if (sig_info->signal_received)
@@ -2245,19 +2257,16 @@
     resolve_remote(sock, 2, &remote_dynamic,  sig_info);
 
     /* If a valid remote has been found, create the socket with its addrinfo */
+#if defined(_WIN32)
+    if (dco_enabled(&c->options))
+    {
+        create_socket_dco_win(c, sock, sig_info);
+        goto done;
+    }
+#endif
     if (sock->info.lsa->current_remote)
     {
-#if defined(_WIN32)
-        if (dco_enabled(&c->options))
-        {
-            create_socket_dco_win(c, sock, sig_info);
-            goto done;
-        }
-        else
-#endif
-        {
-            create_socket(sock, sock->info.lsa->current_remote);
-        }
+        create_socket(sock, sock->info.lsa->current_remote);
     }
 
     /* If socket has not already been created create it now */
@@ -3787,6 +3796,91 @@
     return sock->writes.iostate;
 }
 
+void
+read_sockaddr_from_overlapped(struct overlapped_io *io, struct sockaddr *dst, int overlapped_ret)
+{
+    if (overlapped_ret >= 0 && io->addr_defined)
+    {
+        /* TODO(jjo): streamline this mess */
+        /* in this func we don't have relevant info about the PF_ of this
+         * endpoint, as link_socket_actual will be zero for the 1st received packet
+         *
+         * Test for inets PF_ possible sizes
+         */
+        switch (io->addrlen)
+        {
+            case sizeof(struct sockaddr_in):
+            case sizeof(struct sockaddr_in6):
+            /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF_INET6
+             * under _WIN32*/
+            case sizeof(struct sockaddr_in6) - 4:
+                break;
+
+            default:
+                bad_address_length(io->addrlen, af_addr_size(io->addr.sin_family));
+        }
+
+        switch (io->addr.sin_family)
+        {
+            case AF_INET:
+                memcpy(dst, &io->addr, sizeof(struct sockaddr_in));
+                break;
+
+            case AF_INET6:
+                memcpy(dst, &io->addr6, sizeof(struct sockaddr_in6));
+                break;
+        }
+    }
+    else
+    {
+        CLEAR(*dst);
+    }
+}
+
+/**
+ * @brief Extracts a sockaddr from a packet payload.
+ *
+ * Reads a sockaddr structure from the start of the packet buffer and writes it to `dst`.
+ *
+ * @param[in] buf Packet buffer containing the payload.
+ * @param[out] dst Destination buffer for the extracted sockaddr.
+ * @return Length of the extracted sockaddr
+ */
+static int
+read_sockaddr_from_packet(struct buffer *buf, struct sockaddr *dst)
+{
+    int sa_len = 0;
+
+    const struct sockaddr *sa = (const struct sockaddr *)BPTR(buf);
+    switch (sa->sa_family)
+    {
+        case AF_INET:
+            sa_len = sizeof(struct sockaddr_in);
+            if (buf_len(buf) < sa_len)
+            {
+                msg(M_FATAL, "ERROR: received incoming packet with too short length of %d -- must be at least %d.", buf_len(buf), sa_len);
+            }
+            memcpy(dst, sa, sa_len);
+            buf_advance(buf, sa_len);
+            break;
+
+        case AF_INET6:
+            sa_len = sizeof(struct sockaddr_in6);
+            if (buf_len(buf) < sa_len)
+            {
+                msg(M_FATAL, "ERROR: received incoming packet with too short length of %d -- must be at least %d.", buf_len(buf), sa_len);
+            }
+            memcpy(dst, sa, sa_len);
+            buf_advance(buf, sa_len);
+            break;
+
+        default:
+            msg(M_FATAL, "ERROR: received incoming packet with invalid address family %d.", sa->sa_family);
+    }
+
+    return sa_len;
+}
+
 /* Returns the number of bytes successfully read */
 int
 sockethandle_finalize(sockethandle_t sh,
@@ -3860,45 +3954,14 @@
             ASSERT(0);
     }
 
-    /* return from address if requested */
+    if (from && ret > 0 && sh.is_handle && sh.prepend_sa)
+    {
+        ret -= read_sockaddr_from_packet(buf, &from->dest.addr.sa);
+    }
+
     if (!sh.is_handle && from)
     {
-        if (ret >= 0 && io->addr_defined)
-        {
-            /* TODO(jjo): streamline this mess */
-            /* in this func we don't have relevant info about the PF_ of this
-             * endpoint, as link_socket_actual will be zero for the 1st received packet
-             *
-             * Test for inets PF_ possible sizes
-             */
-            switch (io->addrlen)
-            {
-                case sizeof(struct sockaddr_in):
-                case sizeof(struct sockaddr_in6):
-                /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF_INET6
-                 * under _WIN32*/
-                case sizeof(struct sockaddr_in6)-4:
-                    break;
-
-                default:
-                    bad_address_length(io->addrlen, af_addr_size(io->addr.sin_family));
-            }
-
-            switch (io->addr.sin_family)
-            {
-                case AF_INET:
-                    from->dest.addr.in4 = io->addr;
-                    break;
-
-                case AF_INET6:
-                    from->dest.addr.in6 = io->addr6;
-                    break;
-            }
-        }
-        else
-        {
-            CLEAR(from->dest.addr);
-        }
+        read_sockaddr_from_overlapped(io, &from->dest.addr.sa, ret);
     }
 
     if (buf)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 16106d4..c370f2c 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -224,6 +224,7 @@
 #define SF_HOST_RANDOMIZE (1<<3)
 #define SF_GETADDRINFO_DGRAM (1<<4)
 #define SF_DCO_WIN (1<<5)
+#define SF_PREPEND_SA (1<<6)
     unsigned int sockflags;
     int mark;
     const char *bind_dev;
@@ -287,6 +288,7 @@
         HANDLE h;
     };
     bool is_handle;
+    bool prepend_sa; /* are incoming packets prepended with sockaddr? */
 } sockethandle_t;
 
 int sockethandle_finalize(sockethandle_t sh,
@@ -1046,6 +1048,7 @@
     {
         *from = sock->info.lsa->actual;
         sh.is_handle = true;
+        sh.prepend_sa = sock->sockflags & SF_PREPEND_SA;
     }
     return sockethandle_finalize(sh, &sock->reads, buf, from);
 }
@@ -1116,6 +1119,24 @@
             err = SocketHandleGetLastError(sh);
         }
     }
+
+    /* dco-win mp requires control packets to be prepended with sockaddr */
+    if (sock->sockflags & SF_PREPEND_SA)
+    {
+        if (to->dest.addr.sa.sa_family == AF_INET)
+        {
+            struct sockaddr_in sa;
+            memcpy(&sa, &to->dest.addr.in4, sizeof(sa));
+            buf_write_prepend(buf, &sa, sizeof(sa));
+        }
+        else
+        {
+            struct sockaddr_in6 sa;
+            memcpy(&sa, &to->dest.addr.in6, sizeof(sa));
+            buf_write_prepend(buf, &sa, sizeof(sa));
+        }
+    }
+
     socket_send_queue(sock, buf, to);
     if (status < 0)
     {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 80f5dff..dbe3dfc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -992,7 +992,7 @@
 #ifdef _WIN32
     if (tt->backend_driver == DRIVER_DCO)
     {
-        dco_start_tun(tt);
+        tt->dco.tt = tt;
         return;
     }
 

