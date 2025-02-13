From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 09:06:58 +0000
In-Reply-To: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <fdccdfc1dd3ffc4b31bfa96c3b7f861277d4e72a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ohF6R/IIex4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco-win: multipeer
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ohF6R/IIex4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail

to look at the new patch set (#20).


Change subject: dco-win: multipeer support
......................................................................

dco-win: multipeer support

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
---
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/ovpn_dco_win.h
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/tun.c
11 files changed, 484 insertions(+), 132 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/815/20

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 035474f..7f2021d 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -106,9 +106,10 @@
  *
  * @param mode      the instance operating mode (P2P or multi-peer)
  * @param dco       the context to initialize
+ * @param dev_node  device node, used on Windows to specify certain DCO ad=
apter
  * @return          true on success, false otherwise
  */
-bool ovpn_dco_init(int mode, dco_context_t *dco);
+bool ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node);

 /**
  * Open/create a DCO interface
@@ -284,7 +285,7 @@
 }
=20
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
 const IN_ADDR in4addr_any =3D { 0 };
 #endif

-struct tuntap
-create_dco_handle(const char *devname, struct gc_arena *gc)
+/* Sometimes IP Helper API, which we use for setting IP address etc,
+ * complains that interface is not found. Give it some time to settle
+ */
+static void
+dco_wait_ready(DWORD idx)
 {
-    struct tuntap tt =3D { .backend_driver =3D DRIVER_DCO };
-    const char *device_guid;
-
-    tun_open_device(&tt, devname, &device_guid, gc);
-
-    return tt;
+    for (int i =3D 0; i < 20; ++i)
+    {
+        MIB_IPINTERFACE_ROW row =3D { .InterfaceIndex =3D idx, .Family =3D=
 AF_INET };
+        if (GetIpInterfaceEntry(&row) !=3D ERROR_NOT_FOUND)
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
-    for (int i =3D 0; i < 20; ++i)
-    {
-        MIB_IPINTERFACE_ROW row =3D {.InterfaceIndex =3D idx, .Family =3D =
AF_INET};
-        if (GetIpInterfaceEntry(&row) !=3D ERROR_NOT_FOUND)
-        {
-            break;
-        }
-        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
-        Sleep(50);
-    }
-}
-
+/**
+ * @brief Initializes the DCO adapter in multipeer mode and sets it to "co=
nnected" state.
+ *
+ * Opens the DCO device, sets the adapter mode using `OVPN_IOCTL_SET_MODE`,
+ * which transitions the adapter to the "connected" state, and waits for i=
t to become ready.
+ *
+ * @param dco Pointer to the `dco_context_t` structure representing the DC=
O context.
+ * @param dev_node Device node string for the DCO adapter.
+ */
 void
-dco_start_tun(struct tuntap *tt)
+ovpn_dco_init_mp(dco_context_t *dco, const char *dev_node)
 {
-    msg(D_DCO_DEBUG, "%s", __func__);
+    ASSERT(dco->ifmode =3D=3D DCO_MODE_UNINIT);
+    dco->ifmode =3D DCO_MODE_MP;

-    /* reference the tt object inside the DCO context, because the latter =
will
-     * be passed around
-     */
-    tt->dco.tt =3D tt;
+    /* open DCO device */
+    struct gc_arena gc =3D gc_new();
+    const char *device_guid;
+    tun_open_device(dco->tt, dev_node, &device_guid, &gc);
+    gc_free(&gc);

+    /* set mp mode */
+    OVPN_MODE m =3D OVPN_MODE_MP;
     DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
-                         &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_MODE, &m, sizeof(m)=
, NULL, 0, &bytes_returned, NULL))
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
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,=
 &bytes_returned, NULL))
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
+ * state. The server socket should be initialized later by dco_mp_start_vp=
n().
+ */
+bool
+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
+{
+    switch (mode)
+    {
+        case MODE_POINT_TO_POINT:
+            dco->ifmode =3D DCO_MODE_P2P;
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
 dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal=
_info *sig_info)
 {
@@ -206,15 +256,68 @@
     register_signal(sig_info, SIGUSR1, "dco-connect-timeout");
 }

+/**
+ * @brief Initializes and binds the kernel UDP transport socket for multip=
eer mode.
+ *
+ * Sends `OVPN_IOCTL_MP_START_VPN` to create a kernel-mode UDP socket, bin=
ds it to
+ * the specified address, ready for incoming connections.
+ *
+ * @param handle Device handle for the DCO adapter.
+ * @param sock Pointer to the `link_socket` structure containing socket in=
formation.
+ */
 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_lo=
cal,
-                  struct addrinfo *bind, int timeout,
-                  struct signal_info *sig_info)
+dco_mp_start_vpn(HANDLE handle, struct link_socket *sock)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    int ai_family =3D sock->info.lsa->bind_local->ai_family;
+    struct addrinfo *local =3D sock->info.lsa->bind_local;
+    struct addrinfo *cur =3D NULL;
+
+    for (cur =3D local; cur; cur =3D cur->ai_next)
+    {
+        if (cur->ai_family =3D=3D ai_family)
+        {
+            break;
+        }
+    }
+    if (!cur)
+    {
+        msg(M_FATAL, "%s: Socket bind failed: Addr to bind has no %s recor=
d",
+            __func__, addr_family_name(ai_family));
+    }
+
+    OVPN_MP_START_VPN in, out;
+    in.IPv6Only =3D sock->info.bind_ipv6_only ? 1 : 0;
+    if (ai_family =3D=3D AF_INET)
+    {
+        memcpy(&in.ListenAddress.Addr4, cur->ai_addr, sizeof(struct sockad=
dr_in));
+    }
+    else
+    {
+        memcpy(&in.ListenAddress.Addr6, cur->ai_addr, sizeof(struct sockad=
dr_in6));
+    }
+
+    /* in multipeer mode control channel packets are prepended with remote=
 peer's sockaddr */
+    sock->sockflags |=3D SF_PREPEND_SA;
+
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(handle, OVPN_IOCTL_MP_START_VPN, &in, sizeof(in),=
 &out, sizeof(out),
+                         &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_MP_START_VPN) failed");
+    }
+}
+
+void
+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_in=
fo *sig_info)
 {
     msg(D_DCO_DEBUG, "%s", __func__);

     OVPN_NEW_PEER peer =3D { 0 };

+    struct addrinfo *remoteaddr =3D sock->info.lsa->current_remote;
+
     struct sockaddr *local =3D NULL;
     struct sockaddr *remote =3D remoteaddr->ai_addr;

@@ -228,9 +331,10 @@
         peer.Proto =3D OVPN_PROTO_UDP;
     }

-    if (bind_local)
+    if (sock->bind_local)
     {
         /* Use first local address with correct address family */
+        struct addrinfo *bind =3D sock->info.lsa->bind_local;
         while (bind && !local)
         {
             if (bind->ai_family =3D=3D remote->sa_family)
@@ -241,7 +345,7 @@
         }
     }

-    if (bind_local && !local)
+    if (sock->bind_local && !local)
     {
         msg(M_FATAL, "DCO: Socket bind failed: Address to bind lacks %s re=
cord",
             addr_family_name(remote->sa_family));
@@ -290,7 +394,7 @@
         }
         else
         {
-            dco_connect_wait(handle, &ov, timeout, sig_info);
+            dco_connect_wait(handle, &ov, get_server_poll_remaining_time(s=
ock->server_poll_timeout), sig_info);
         }
     }
 }
@@ -301,6 +405,48 @@
              struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+
+    if (dco->ifmode =3D=3D DCO_MODE_P2P)
+    {
+        /* no-op for p2p */
+        return 0;
+    }
+
+    OVPN_MP_NEW_PEER newPeer =3D {0};
+
+    if (remoteaddr)
+    {
+        /* while the driver doesn't use the local address yet it requires =
its AF to be valid */
+        newPeer.Local.Addr4.sin_family =3D remoteaddr->sa_family;
+
+        if (remoteaddr->sa_family =3D=3D AF_INET)
+        {
+            memcpy(&newPeer.Remote.Addr4, remoteaddr, sizeof(struct sockad=
dr_in));
+        }
+        else
+        {
+            memcpy(&newPeer.Remote.Addr6, remoteaddr, sizeof(struct sockad=
dr_in6));
+        }
+    }
+
+    if (vpn_ipv4)
+    {
+        newPeer.VpnAddr4 =3D *vpn_ipv4;
+    }
+
+    if (vpn_ipv6)
+    {
+        newPeer.VpnAddr6 =3D *vpn_ipv6;
+    }
+
+    newPeer.PeerId =3D peerid;
+
+    DWORD bytesReturned;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_NEW_PEER, &newPeer, =
sizeof(newPeer), NULL, 0, &bytesReturned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+    }
+
     return 0;
 }

@@ -309,9 +455,20 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);

+    OVPN_MP_DEL_PEER del_peer =3D { peerid };
+    VOID *buf =3D NULL;
+    DWORD len =3D 0;
+    DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;
+
+    if (dco->ifmode =3D=3D DCO_MODE_MP)
+    {
+        ioctl =3D OVPN_IOCTL_MP_DEL_PEER;
+        buf =3D &del_peer;
+        len =3D sizeof(del_peer);
+    }
+
     DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_DEL_PEER, NULL,
-                         0, NULL, 0, &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_r=
eturned, NULL))
     {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_DEL_PEER) failed=
");
         return -1;
@@ -326,19 +483,30 @@
     msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
         peerid, keepalive_interval, keepalive_timeout, mss);

-    OVPN_SET_PEER peer;
+    OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keepalive_t=
imeout, mss };
+    OVPN_SET_PEER peer =3D { keepalive_interval, keepalive_timeout, mss };
+    VOID *buf =3D NULL;
+    DWORD len =3D 0;
+    DWORD ioctl =3D (dco->ifmode =3D=3D DCO_MODE_MP) ? OVPN_IOCTL_MP_SET_P=
EER : OVPN_IOCTL_SET_PEER;

-    peer.KeepaliveInterval =3D  keepalive_interval;
-    peer.KeepaliveTimeout =3D keepalive_timeout;
-    peer.MSS =3D mss;
+    if (dco->ifmode =3D=3D DCO_MODE_MP)
+    {
+        buf =3D &mp_peer;
+        len =3D sizeof(OVPN_MP_SET_PEER);
+    }
+    else
+    {
+        buf =3D &peer;
+        len =3D sizeof(OVPN_SET_PEER);
+    }

     DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_PEER, &peer,
-                         sizeof(peer), NULL, 0, &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_r=
eturned, NULL))
     {
-        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed=
");
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_SET_PEER) fai=
led");
         return -1;
     }
+
     return 0;
 }

@@ -397,9 +565,20 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);

+    OVPN_MP_SWAP_KEYS swap =3D {peer_id};
+    DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;
+    VOID *buf =3D NULL;
+    DWORD len =3D 0;
+
+    if (dco->ifmode =3D=3D DCO_MODE_MP)
+    {
+        ioctl =3D OVPN_IOCTL_MP_SWAP_KEYS;
+        buf =3D &swap;
+        len =3D sizeof(swap);
+    }
+
     DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SWAP_KEYS, NULL, 0, NUL=
L, 0,
-                         &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_r=
eturned, NULL))
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
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_lo=
cal,
-                  struct addrinfo *bind, int timeout,
-                  struct signal_info *sig_info);
+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_in=
fo *sig_info);

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
-        sockethandle_t sh =3D { .is_handle =3D true, .h =3D c->c1.tuntap->=
hand };
+        /* we cannot end up here when using dco */
+        ASSERT(!dco_enabled(&c->options));
+
+        sockethandle_t sh =3D { .is_handle =3D true, .h =3D c->c1.tuntap->=
hand, .prepend_sa =3D false };
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
+            ovpn_dco_init(c->mode, &c->c1.tuntap->dco, c->options.dev_node=
);
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
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
@@ -114,3 +182,14 @@
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BU=
FFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_SET_MODE     CTL_CODE(FILE_DEVICE_UNKNOWN, 10, METHOD_B=
UFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_MP_START_VPN   CTL_CODE(FILE_DEVICE_UNKNOWN, 11, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_NEW_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 12, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_SET_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 13, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_NOTIFY_EVENT   CTL_CODE(FILE_DEVICE_UNKNOWN, 14, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
+
+#define OVPN_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE_DEVICE_UNKNOWN, 16, METHOD=
_BUFFERED, FILE_ANY_ACCESS)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d01b995..5b32885 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2177,12 +2177,22 @@
 create_socket_dco_win(struct context *c, struct link_socket *sock,
                       struct signal_info *sig_info)
 {
+    /* in P2P mode we must have remote resolved at this point */
+    struct addrinfo *remoteaddr =3D sock->info.lsa->current_remote;
+    if ((c->options.mode =3D=3D MODE_POINT_TO_POINT) && (!remoteaddr))
+    {
+        return;
+    }
+
     if (!c->c1.tuntap)
     {
         struct tuntap *tt;
-        ALLOC_OBJ(tt, struct tuntap);
+        ALLOC_OBJ_CLEAR(tt, struct tuntap);

-        *tt =3D create_dco_handle(c->options.dev_node, &c->gc);
+        tt->backend_driver =3D DRIVER_DCO;
+
+        const char *device_guid =3D NULL; /* not used */
+        tun_open_device(tt, c->options.dev_node, &device_guid, &c->gc);

         /* Ensure we can "safely" cast the handle to a socket */
         static_assert(sizeof(sock->sd) =3D=3D sizeof(tt->hand), "HANDLE an=
d SOCKET size differs");
@@ -2190,12 +2200,14 @@
         c->c1.tuntap =3D tt;
     }

-    dco_create_socket(c->c1.tuntap->hand,
-                      sock->info.lsa->current_remote,
-                      sock->bind_local, sock->info.lsa->bind_local,
-                      get_server_poll_remaining_time(sock->server_poll_tim=
eout),
-                      sig_info);
-
+    if (c->options.mode =3D=3D MODE_SERVER)
+    {
+        dco_mp_start_vpn(c->c1.tuntap->hand, sock);
+    }
+    else
+    {
+        dco_p2p_new_peer(c->c1.tuntap->hand, sock, sig_info);
+    }
     sock->sockflags |=3D SF_DCO_WIN;

     if (sig_info->signal_received)
@@ -2245,19 +2257,16 @@
     resolve_remote(sock, 2, &remote_dynamic,  sig_info);

     /* If a valid remote has been found, create the socket with its addrin=
fo */
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
+read_sockaddr_from_overlapped(struct overlapped_io *io, struct sockaddr *d=
st, int overlapped_ret)
+{
+    if (overlapped_ret >=3D 0 && io->addr_defined)
+    {
+        /* TODO(jjo): streamline this mess */
+        /* in this func we don't have relevant info about the PF_ of this
+         * endpoint, as link_socket_actual will be zero for the 1st receiv=
ed packet
+         *
+         * Test for inets PF_ possible sizes
+         */
+        switch (io->addrlen)
+        {
+            case sizeof(struct sockaddr_in):
+            case sizeof(struct sockaddr_in6):
+            /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF_INE=
T6
+             * under _WIN32*/
+            case sizeof(struct sockaddr_in6) - 4:
+                break;
+
+            default:
+                bad_address_length(io->addrlen, af_addr_size(io->addr.sin_=
family));
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
+ * Reads a sockaddr structure from the start of the packet buffer and writ=
es it to `dst`.
+ *
+ * @param[in] buf Packet buffer containing the payload.
+ * @param[out] dst Destination buffer for the extracted sockaddr.
+ * @return Length of the extracted sockaddr
+ */
+static int
+read_sockaddr_from_packet(struct buffer *buf, struct sockaddr *dst)
+{
+    int sa_len =3D 0;
+
+    const struct sockaddr *sa =3D (const struct sockaddr *)BPTR(buf);
+    switch (sa->sa_family)
+    {
+        case AF_INET:
+            sa_len =3D sizeof(struct sockaddr_in);
+            if (buf_len(buf) < sa_len)
+            {
+                msg(M_FATAL, "ERROR: received incoming packet with too sho=
rt length of %d -- must be at least %d.", buf_len(buf), sa_len);
+            }
+            memcpy(dst, sa, sa_len);
+            buf_advance(buf, sa_len);
+            break;
+
+        case AF_INET6:
+            sa_len =3D sizeof(struct sockaddr_in6);
+            if (buf_len(buf) < sa_len)
+            {
+                msg(M_FATAL, "ERROR: received incoming packet with too sho=
rt length of %d -- must be at least %d.", buf_len(buf), sa_len);
+            }
+            memcpy(dst, sa, sa_len);
+            buf_advance(buf, sa_len);
+            break;
+
+        default:
+            msg(M_FATAL, "ERROR: received incoming packet with invalid add=
ress family %d.", sa->sa_family);
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
+        ret -=3D read_sockaddr_from_packet(buf, &from->dest.addr.sa);
+    }
+
     if (!sh.is_handle && from)
     {
-        if (ret >=3D 0 && io->addr_defined)
-        {
-            /* TODO(jjo): streamline this mess */
-            /* in this func we don't have relevant info about the PF_ of t=
his
-             * endpoint, as link_socket_actual will be zero for the 1st re=
ceived packet
-             *
-             * Test for inets PF_ possible sizes
-             */
-            switch (io->addrlen)
-            {
-                case sizeof(struct sockaddr_in):
-                case sizeof(struct sockaddr_in6):
-                /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF=
_INET6
-                 * under _WIN32*/
-                case sizeof(struct sockaddr_in6)-4:
-                    break;
-
-                default:
-                    bad_address_length(io->addrlen, af_addr_size(io->addr.=
sin_family));
-            }
-
-            switch (io->addr.sin_family)
-            {
-                case AF_INET:
-                    from->dest.addr.in4 =3D io->addr;
-                    break;
-
-                case AF_INET6:
-                    from->dest.addr.in6 =3D io->addr6;
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
         *from =3D sock->info.lsa->actual;
         sh.is_handle =3D true;
+        sh.prepend_sa =3D sock->sockflags & SF_PREPEND_SA;
     }
     return sockethandle_finalize(sh, &sock->reads, buf, from);
 }
@@ -1116,6 +1119,24 @@
             err =3D SocketHandleGetLastError(sh);
         }
     }
+
+    /* dco-win mp requires control packets to be prepended with sockaddr */
+    if (sock->sockflags & SF_PREPEND_SA)
+    {
+        if (to->dest.addr.sa.sa_family =3D=3D AF_INET)
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
     if (tt->backend_driver =3D=3D DRIVER_DCO)
     {
-        dco_start_tun(tt);
+        tt->dco.tt =3D tt;
         return;
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba
Gerrit-Change-Number: 815
Gerrit-PatchSet: 20
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ohF6R/IIex4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>stipa <strong>uploaded patch set #20</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">dco-win: multipeer support<br><br>This is the main commit for dco-win mu=
ltipeer<br>implementation.<br><br>This adds concept of &quot;mode&quot; to =
DCO implementation,<br>which is peer-to-peer or multipeer. Depending on mod=
e,<br>some functions use MP-specific IOCTL commands, which<br>include peer-=
id as a part of input.<br><br>The driver initialization accomodates server =
mode,<br>in which tun device is created before transport.<br><br>Since on W=
indows the socket is visible to the kernel only,<br>control channel packets=
 have to be prepended with remote<br>sockaddr of the peer - this allows use=
rspace to distinguish<br>among peers. Sadly there is no reliable way to get=
 peer local<br>address, such as on Linux/FreeBSD, so we have to do a bit of=
<br>guesswork to figure out IP address based on remote IP and local<br>rout=
ing table, which may backfire if there are multiple IPs<br>assigned to the =
same network adapter. However, as for now<br>peer-specific local IP is not =
used by the driver. We use<br>instead the result of bind() to the listening=
 address.<br><br>Existing sockethandle_finalize() function has been refacto=
red<br>to accomodate packets with possibly prepended sockaddr.<br><br>Chang=
e-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba<br>Signed-off-by: Lev Stipa=
kov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco.h<br>M src/openvpn/dc=
o_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M sr=
c/openvpn/dco_win.h<br>M src/openvpn/forward.c<br>M src/openvpn/init.c<br>M=
 src/openvpn/ovpn_dco_win.h<br>M src/openvpn/socket.c<br>M src/openvpn/sock=
et.h<br>M src/openvpn/tun.c<br>11 files changed, 484 insertions(+), 132 del=
etions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/15/815/20</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h<=
/span><br><span>index 035474f..7f2021d 100644</span><br><span>--- a/src/ope=
nvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -106,=
9 +106,10 @@</span><br><span>  *</span><br><span>  * @param mode      the i=
nstance operating mode (P2P or multi-peer)</span><br><span>  * @param dco  =
     the context to initialize</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param dev_node  device node, used on Windows to specify cert=
ain DCO adapter</span><br><span>  * @return          true on success, false=
 otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-bool ovpn_dco_init(int mode, dco_context_t *dco);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool ovpn_dco_init(int mode, dco_co=
ntext_t *dco, const char *dev_node);</span><br><span> </span><br><span> /**=
</span><br><span>  * Open/create a DCO interface</span><br><span>@@ -284,7 =
+285,7 @@</span><br><span> }</span><br><span> </span><br><span> static inli=
ne bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(=
int mode, dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)=
</span><br><span> {</span><br><span>     return true;</span><br><span> }</s=
pan><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_free=
bsd.c</span><br><span>index f4c3b02..0e536de 100644</span><br><span>--- a/s=
rc/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</s=
pan><br><span>@@ -165,7 +165,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn=
_dco_init(int mode, dco_context_t *dco)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ovpn_dco_init(int mode, dco_context_t *dco, const char =
*dev_node)</span><br><span> {</span><br><span>     if (open_fd(dco) &lt; 0)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/dco_linux.=
c b/src/openvpn/dco_linux.c</span><br><span>index fa7abd3..68c1a8d 100644</=
span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/open=
vpn/dco_linux.c</span><br><span>@@ -422,7 +422,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-ovpn_dco_init(int mode, dco_context_t *dco)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init(int mode, dco_context_t=
 *dco, const char *dev_node)</span><br><span> {</span><br><span>     switch=
 (mode)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/dco=
_win.c b/src/openvpn/dco_win.c</span><br><span>index 46b2d03..56ec178 10064=
4</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/ope=
nvpn/dco_win.c</span><br><span>@@ -28,6 +28,7 @@</span><br><span> #include =
&quot;syshead.h&quot;</span><br><span> </span><br><span> #include &quot;dco=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;forward.h&quot;</span><br><span> #include &quot;tun.h&quot;</span><br><=
span> #include &quot;crypto.h&quot;</span><br><span> #include &quot;ssl_com=
mon.h&quot;</span><br><span>@@ -41,15 +42,22 @@</span><br><span> const IN_A=
DDR in4addr_any =3D { 0 };</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-struct tuntap</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-create_dco_handle(const char *devnam=
e, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Sometimes IP Helper API, which we use for setting IP address etc,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * complains that inte=
rface is not found. Give it some time to settle</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_wait_ready(DWORD idx)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct tuntap tt =3D { .backend_driver =3D D=
RIVER_DCO };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 char *device_guid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tun_open_device(&am=
p;tt, devname, &amp;device_guid, gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn tt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i=
nt i =3D 0; i &lt; 20; ++i)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MIB_IPINTERFACE_ROW row =3D { .InterfaceIndex =3D idx, .Family =3D AF_INE=
T };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (Get=
IpInterfaceEntry(&amp;row) !=3D ERROR_NOT_FOUND)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(D_DCO_DEBUG, &quot;interface %ld not yet ready, retryin=
g&quot;, idx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   Sleep(50);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span> }</span><br><span> </span><br><span> /**</span><br><span>@=
@ -103,47 +111,51 @@</span><br><span>     return res;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode,=
 dco_context_t *dco)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_tun_d=
co(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ASSERT(0);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_wait_ready(DWORD idx)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    for (int i =3D 0; i &lt; 20; ++i)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MIB_IPINTERFACE_ROW row =3D {.InterfaceIndex =3D id=
x, .Family =3D AF_INET};</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (GetIpInterfaceEntry(&amp;row) !=3D ERROR_NOT_FOUND)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;interface %ld not yet re=
ady, retrying&quot;, idx);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        Sleep(50);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @brief Initializes the DCO adapter in multipeer mode and sets it t=
o &quot;connected&quot; state.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ope=
ns the DCO device, sets the adapter mode using `OVPN_IOCTL_SET_MODE`,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which transitions the =
adapter to the &quot;connected&quot; state, and waits for it to become read=
y.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param dco Pointer to the `dco_=
context_t` structure representing the DCO context.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param dev_node Device node string for th=
e DCO adapter.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-d=
co_start_tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ovpn_dco_init_mp(dco_context_t *dco, const char *dev_node)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ASSERT(dco-&gt;ifmode =3D=3D DCO_MODE_UNINIT);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;ifmode =3D =
DCO_MODE_MP;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* reference the tt object inside the DCO context, because the=
 latter will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * be=
 passed around</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tt-&gt;dco.tt =3D=
 tt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* open DCO=
 device */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *device_guid;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    tun_open_device(dco-&gt;tt, dev_node, &amp;device_guid=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* set mp mode */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    OVPN_MODE m =3D OVPN_MODE_MP;</span><br><span>     DWORD =
bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (!DeviceIoControl(tt-&gt;hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, =
0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
      &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SET_=
MODE, &amp;m, sizeof(m), NULL, 0, &amp;bytes_returned, NULL))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;DeviceIoControl(OVPN_I=
OCTL_SET_MODE) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_wait_ready(dco-=
&gt;tt-&gt;adapter_index);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @brief Transitions the DCO adapter to the c=
onnected state in P2P mode.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sends =
`OVPN_IOCTL_START_VPN` to start the VPN and waits for the adapter</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * to become ready.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param tt Pointer to the `tuntap` structure=
 representing the adapter.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_p2p_start_vpn(struct=
 tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!Devi=
ceIoControl(tt-&gt;hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0, &amp;bytes=
_returned, NULL))</span><br><span>     {</span><br><span>         msg(M_ERR=
, &quot;DeviceIoControl(OVPN_IOCTL_START_VPN) failed&quot;);</span><br><spa=
n>     }</span><br><span>@@ -154,6 +166,44 @@</span><br><span>     dco_wait=
_ready(tt-&gt;adapter_index);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @brief Initializes DCO depends on `mode`</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  - for P2P it puts adapter in &quot;connected&quot; s=
tate. The peer should</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * be already added by dco_p2p_new_peer().</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  - for multipeer it opens DCO adapter and puts it into &quot;con=
nected&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * stat=
e. The server socket should be initialized later by dco_mp_start_vpn().</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ovpn_dco_init(int mode, dco_context_t *dco, const char=
 *dev_node)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (mode)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case MODE_POINT_TO_POINT:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;ifmode =
=3D DCO_MODE_P2P;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          dco_p2p_start_vpn(dco-&gt;tt);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        case MODE_SERVER:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            ovpn_dco_init_mp(dco, dev_node);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            ASSERT(false);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *de=
v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static void</span><br><span> dco_connect_wait(=
HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)</=
span><br><span> {</span><br><span>@@ -206,15 +256,68 @@</span><br><span>   =
  register_signal(sig_info, SIGUSR1, &quot;dco-connect-timeout&quot;);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@brief Initializes and binds the kernel UDP transport socket for multipeer =
mode.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Sends `OVPN_IOCTL_MP_START_V=
PN` to create a kernel-mode UDP socket, binds it to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * the specified address, ready for incom=
ing connections.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param handle Dev=
ice handle for the DCO adapter.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param sock Pointer to the `link_socket` structure containin=
g socket information.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bi=
nd_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
      struct addrinfo *bind, int timeout,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                  struct signal_info *sig_info)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_mp_start_vpn(HANDLE han=
dle, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int ai_family =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *lo=
cal =3D sock-&gt;info.lsa-&gt;bind_local;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct addrinfo *cur =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (cur =3D local; cur; cur =3D cur-&gt;ai_next)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (cur-&gt;ai_family =3D=3D =
ai_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!cur)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msg(M_FATAL, &quot;%s: Socket bind failed: Addr to bind =
has no %s record&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            __func__, addr_family_name(ai_family));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_MP_START_VPN in, out;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    in.IPv6Only =3D sock-&gt;info.bind_ipv6_only ? 1 : 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ai_family =3D=
=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;i=
n.ListenAddress.Addr4, cur-&gt;ai_addr, sizeof(struct sockaddr_in));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        memcpy(&amp;in.ListenAddress.Addr6, cur-&gt;ai_addr, size=
of(struct sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* in multipeer mode co=
ntrol channel packets are prepended with remote peer&#39;s sockaddr */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;sockflags |=
=3D SF_PREPEND_SA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_retu=
rned =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!DeviceIoControl(handle, OVPN_IOCTL_MP_START_VPN, &amp;in, sizeof(in), &amp=
;out, sizeof(out),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                        &amp;bytes_returned, NULL))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_MP_=
START_VPN) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, st=
ruct signal_info *sig_info)</span><br><span> {</span><br><span>     msg(D_D=
CO_DEBUG, &quot;%s&quot;, __func__);</span><br><span> </span><br><span>    =
 OVPN_NEW_PEER peer =3D { 0 };</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct addrinfo *remoteaddr =3D sock-&gt;i=
nfo.lsa-&gt;current_remote;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     struct sockaddr *local =3D NULL;</span><br><s=
pan>     struct sockaddr *remote =3D remoteaddr-&gt;ai_addr;</span><br><spa=
n> </span><br><span>@@ -228,9 +331,10 @@</span><br><span>         peer.Prot=
o =3D OVPN_PROTO_UDP;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (bind_local)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;bind_local)</span=
><br><span>     {</span><br><span>         /* Use first local address with =
correct address family */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct addrinfo *bind =3D sock-&gt;info.lsa-&gt;bind_local;</=
span><br><span>         while (bind &amp;&amp; !local)</span><br><span>    =
     {</span><br><span>             if (bind-&gt;ai_family =3D=3D remote-&g=
t;sa_family)</span><br><span>@@ -241,7 +345,7 @@</span><br><span>         }=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (bind_local &amp;&amp; !local)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;bind_local &amp;&amp=
; !local)</span><br><span>     {</span><br><span>         msg(M_FATAL, &quo=
t;DCO: Socket bind failed: Address to bind lacks %s record&quot;,</span><br=
><span>             addr_family_name(remote-&gt;sa_family));</span><br><spa=
n>@@ -290,7 +394,7 @@</span><br><span>         }</span><br><span>         e=
lse</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            dco_connect_wait(handle, &amp;ov, timeout, sig_info);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_conn=
ect_wait(handle, &amp;ov, get_server_poll_remaining_time(sock-&gt;server_po=
ll_timeout), sig_info);</span><br><span>         }</span><br><span>     }</=
span><br><span> }</span><br><span>@@ -301,6 +405,48 @@</span><br><span>    =
          struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><s=
pan> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d&qu=
ot;, __func__, peerid, sd);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco=
-&gt;ifmode =3D=3D DCO_MODE_P2P)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* no-op for p2p */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_NEW_PEER newPeer=
 =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (remoteaddr)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* while the driver doesn&#39;t u=
se the local address yet it requires its AF to be valid */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        newPeer.Local.Addr4.sin_fami=
ly =3D remoteaddr-&gt;sa_family;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (remoteaddr-&gt;sa_family =3D=3D AF_INET)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            memcpy(&amp;newPeer.Remote.Addr4, remoteaddr, =
sizeof(struct sockaddr_in));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy=
(&amp;newPeer.Remote.Addr6, remoteaddr, sizeof(struct sockaddr_in6));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (vpn_ipv4)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        n=
ewPeer.VpnAddr4 =3D *vpn_ipv4;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_ipv6)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        newPeer.VpnAddr6 =3D *vpn_ipv6=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    newPeer.PeerId =3D peerid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    DWORD bytesReturned;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOC=
TL_MP_NEW_PEER, &amp;newPeer, sizeof(newPeer), NULL, 0, &amp;bytesReturned,=
 NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;D=
eviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</spa=
n><br><span> </span><br><span>@@ -309,9 +455,20 @@</span><br><span> {</span=
><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer=
id);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_MP_DEL_PEER del_peer =3D { peerid };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    VOID *buf =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D DCO_MODE=
_MP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ioctl =3D OVPN_IOCTL_=
MP_DEL_PEER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 buf =3D &amp;del_peer;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        len =3D sizeof(del_peer);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     DWORD bytes_returned =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;han=
d, OVPN_IOCTL_DEL_PEER, NULL,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         0, NULL, 0, &amp;bytes_returned, NULL))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoContr=
ol(dco-&gt;tt-&gt;hand, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL=
))</span><br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &q=
uot;DeviceIoControl(OVPN_IOCTL_DEL_PEER) failed&quot;);</span><br><span>   =
      return -1;</span><br><span>@@ -326,19 +483,30 @@</span><br><span>    =
 msg(D_DCO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __fu=
nc__,</span><br><span>         peerid, keepalive_interval, keepalive_timeou=
t, mss);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    OVPN_SET_PEER peer;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, kee=
palive_timeout, mss };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_SET_PEER peer =3D { keepalive_interval, keepalive_timeout, mss =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    VOID *buf =3D=
 NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD io=
ctl =3D (dco-&gt;ifmode =3D=3D DCO_MODE_MP) ? OVPN_IOCTL_MP_SET_PEER : OVPN=
_IOCTL_SET_PEER;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    peer.KeepaliveInterval =3D  keepalive_interval;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    peer.KeepaliveTimeout =3D ke=
epalive_timeout;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
eer.MSS =3D mss;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (dco-&gt;ifmode =3D=3D DCO_MODE_MP)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        buf =3D &amp;mp_peer;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        len =3D sizeof(OVPN_MP_SET_PEER);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       buf =3D &amp;peer;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        len =3D sizeof(OVPN_SET_PEER);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     DWORD=
 bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SET_PEER, &amp;pe=
er,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
       sizeof(peer), NULL, 0, &amp;bytes_returned, NULL))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&=
gt;hand, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_SET_PEER) failed&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN=
 | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_SET_PEER) failed&quot;);</s=
pan><br><span>         return -1;</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span>=
<br><span> }</span><br><span> </span><br><span>@@ -397,9 +565,20 @@</span><=
br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot=
;, __func__, peer_id);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OVPN_MP_SWAP_KEYS swap =3D {peer_id};</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_S=
WAP_KEYS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    VOID *=
buf =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DW=
ORD len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =
=3D=3D DCO_MODE_MP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ioctl =
=3D OVPN_IOCTL_MP_SWAP_KEYS;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf =3D &amp;swap;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        len =3D sizeof(swap);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     DWORD bytes_returned =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt=
-&gt;hand, OVPN_IOCTL_SWAP_KEYS, NULL, 0, NULL, 0,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                         &amp;bytes_returned, =
NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!Devi=
ceIoControl(dco-&gt;tt-&gt;hand, ioctl, buf, len, NULL, 0, &amp;bytes_retur=
ned, NULL))</span><br><span>     {</span><br><span>         msg(M_ERR, &quo=
t;DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed&quot;);</span><br><span>    =
     return -1;</span><br><span>diff --git a/src/openvpn/dco_win.h b/src/op=
envpn/dco_win.h</span><br><span>index 7688516..dc7fbc1 100644</span><br><sp=
an>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h<=
/span><br><span>@@ -31,19 +31,25 @@</span><br><span> typedef OVPN_KEY_SLOT =
dco_key_slot_t;</span><br><span> typedef OVPN_CIPHER_ALG dco_cipher_t;</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typede=
f enum {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DCO_MOD=
E_UNINIT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DCO_MO=
DE_P2P,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DCO_MODE=
_MP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} dco_mode_type;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
truct dco_context {</span><br><span>     struct tuntap *tt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    dco_mode_type ifmode;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> };</span><b=
r><span> </span><br><span> typedef struct dco_context dco_context_t;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tun=
tap</span><br><span style=3D"color: hsl(0, 100%, 40%);">-create_dco_handle(=
const char *devname, struct gc_arena *gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dco_mp_start_vpn(HANDLE handle, struct link_socket *sock);</span><b=
r><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, boo=
l bind_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
          struct addrinfo *bind, int timeout,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                  struct signal_info *sig_info);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_p2p_new_peer(HANDL=
E handle, struct link_socket *sock, struct signal_info *sig_info);</span><b=
r><span> </span><br><span> void</span><br><span> dco_start_tun(struct tunta=
p *tt);</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/fo=
rward.c</span><br><span>index f3f3503..82c54c2 100644</span><br><span>--- a=
/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><b=
r><span>@@ -1323,7 +1323,10 @@</span><br><span>     }</span><br><span>     =
else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        sockethandle_t sh =3D { .is_handle =3D true, .h =3D c-&gt;c1.=
tuntap-&gt;hand };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* we cannot end up here when using dco */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(!dco_enabled(&amp;c-&gt;option=
s));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        sockethandle_t sh =3D { .i=
s_handle =3D true, .h =3D c-&gt;c1.tuntap-&gt;hand, .prepend_sa =3D false }=
;</span><br><span>         sockethandle_finalize(sh, &amp;c-&gt;c1.tuntap-&=
gt;reads, &amp;c-&gt;c2.buf, NULL);</span><br><span>     }</span><br><span>=
 #else  /* ifdef _WIN32 */</span><br><span>diff --git a/src/openvpn/init.c =
b/src/openvpn/init.c</span><br><span>index 4014517..6090140 100644</span><b=
r><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</=
span><br><span>@@ -2005,7 +2005,7 @@</span><br><span> </span><br><span>    =
     if (dco_enabled(&amp;c-&gt;options))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ovpn_dco_init(c-=
&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tu=
ntap-&gt;dco, c-&gt;options.dev_node);</span><br><span>         }</span><br=
><span> </span><br><span>         /* open the tun device */</span><br><span=
>diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span=
><br><span>index ea2a733..bfe939d 100644</span><br><span>--- a/src/openvpn/=
ovpn_dco_win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><=
span>@@ -47,6 +47,23 @@</span><br><span> 	OVPN_PROTO Proto;</span><br><span=
> } OVPN_NEW_PEER, * POVPN_NEW_PEER;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_MP_NEW_PEER {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    union {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_IN Addr4;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_IN6 Addr6=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } Local;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    union {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        SOCKADDR_IN Addr4;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        SOCKADDR_IN6 Addr6;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    } Remote;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    IN_ADDR VpnAddr4;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    IN6_ADDR VpnAddr6;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int PeerId;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} O=
VPN_MP_NEW_PEER, * POVPN_MP_NEW_PEER;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> typedef struct _OVPN_STATS {</span><br>=
<span> 	LONG LostInControlPackets;</span><br><span> 	LONG LostOutControlPac=
kets;</span><br><span>@@ -94,10 +111,17 @@</span><br><span> 	int PeerId;</s=
pan><br><span> } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_=
MP_SET_PEER {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t PeerId;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG K=
eepaliveInterval;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  LONG KeepaliveTimeout;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    LONG MSS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
 OVPN_MP_SET_PEER, * POVPN_MP_SET_PEER;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> typedef struct _OVPN_SET_PEER {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG KeepaliveInterval;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG KeepaliveTimeout;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	LONG MSS;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    LONG KeepaliveInterval;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG KeepaliveTimeo=
ut;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG MSS;</s=
pan><br><span> } OVPN_SET_PEER, * POVPN_SET_PEER;</span><br><span> </span><=
br><span> typedef struct _OVPN_VERSION {</span><br><span>@@ -106,6 +130,50 =
@@</span><br><span>     LONG Patch;</span><br><span> } OVPN_VERSION, * POVP=
N_VERSION;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef enum {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_MODE_P2P,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_MODE_MP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
} OVPN_MODE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_SET_M=
ODE {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE =
Mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_SET_MOD=
E, * POVPN_SET_MODE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct _OV=
PN_MP_START_VPN {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  union {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SO=
CKADDR_IN Addr4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    } ListenAddress;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int IPv6Only;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+} OVPN_MP_START_VPN, * POVPN_MP_START_VPN;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+typedef enum {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_CMD_DEL_PEER,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_CMD_SWAP_KEYS</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+} OVPN_NOTIFY_CMD;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enu=
m {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEE=
R_REASON_TEARDOWN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OVPN_DEL_PEER_REASON_USERSPACE,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON=
_TRANSPORT_DISCONNECT</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+} OVPN_DEL_PEER_REASON;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struc=
t _OVPN_NOTIFY_EVENT {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_NOTIFY_CMD Cmd;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int PeerId;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    OVPN_DEL_PEER_REASON DelPeerReason;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+} OVPN_NOTIFY_EVENT, * POVPN_NOTIFY_EVENT;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+typedef struct _OVPN_MP_DEL_PEER {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_DEL_PEER, * POVPN_MP_DEL_P=
EER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_MP_SWAP_KEYS =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_SWAP_KEYS, *=
 POVPN_MP_SWAP_KEYS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNK=
NOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IO=
CTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY=
_ACCESS)</span><br><span> #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEV=
ICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span>@@ -114,3=
 +182,14 @@</span><br><span> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_=
DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #defi=
ne OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED=
, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_GET_VERSION  CTL_COD=
E(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_NEW_KEY_V2   CTL=
_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_SET_MODE    =
 CTL_CODE(FILE_DEVICE_UNKNOWN, 10, METHOD_BUFFERED, FILE_ANY_ACCESS)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_MP_START_VPN   CTL_CODE(FI=
LE_DEVICE_UNKNOWN, 11, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_MP_NEW_PEER    CTL_=
CODE(FILE_DEVICE_UNKNOWN, 12, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_MP_SET_PEER =
   CTL_CODE(FILE_DEVICE_UNKNOWN, 13, METHOD_BUFFERED, FILE_ANY_ACCESS)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_NOTIFY_EVENT   CTL_COD=
E(FILE_DEVICE_UNKNOWN, 14, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OVPN_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVIC=
E_UNKNOWN, 15, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FIL=
E_DEVICE_UNKNOWN, 16, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span>dif=
f --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index=
 d01b995..5b32885 100644</span><br><span>--- a/src/openvpn/socket.c</span><=
br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2177,12 +2177,22 @@=
</span><br><span> create_socket_dco_win(struct context *c, struct link_sock=
et *sock,</span><br><span>                       struct signal_info *sig_in=
fo)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* in P2P mode we must have remote resolved at this point */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *remote=
addr =3D sock-&gt;info.lsa-&gt;current_remote;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if ((c-&gt;options.mode =3D=3D MODE_POINT_TO=
_POINT) &amp;&amp; (!remoteaddr))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    if (!c-&gt;c1.tuntap)</span><br><span>     {</span><br><span>         s=
truct tuntap *tt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ALLOC_OBJ(tt, struct tuntap);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ALLOC_OBJ_CLEAR(tt, struct tuntap);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *tt =3D creat=
e_dco_handle(c-&gt;options.dev_node, &amp;c-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;backend_driver =3D DRIVER_=
DCO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const char *device_guid =
=3D NULL; /* not used */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tun_open_device(tt, c-&gt;options.dev_node, &amp;device_guid, =
&amp;c-&gt;gc);</span><br><span> </span><br><span>         /* Ensure we can=
 &quot;safely&quot; cast the handle to a socket */</span><br><span>        =
 static_assert(sizeof(sock-&gt;sd) =3D=3D sizeof(tt-&gt;hand), &quot;HANDLE=
 and SOCKET size differs&quot;);</span><br><span>@@ -2190,12 +2200,14 @@</s=
pan><br><span>         c-&gt;c1.tuntap =3D tt;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_c=
reate_socket(c-&gt;c1.tuntap-&gt;hand,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                      sock-&gt;info.lsa-&gt;current_remote=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
  sock-&gt;bind_local, sock-&gt;info.lsa-&gt;bind_local,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                      get_server_poll_re=
maining_time(sock-&gt;server_poll_timeout),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                      sig_info);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        dco_mp_start_vpn(c-&gt;c1.tuntap-&gt;han=
d, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        dco_p2p_new_peer(c-&gt;c1.tuntap-&gt;hand=
, sock, sig_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     sock-&gt;sockflags |=3D SF_DCO_WIN;</span><br><sp=
an> </span><br><span>     if (sig_info-&gt;signal_received)</span><br><span=
>@@ -2245,19 +2257,16 @@</span><br><span>     resolve_remote(sock, 2, &amp;=
remote_dynamic,  sig_info);</span><br><span> </span><br><span>     /* If a =
valid remote has been found, create the socket with its addrinfo */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-=
&gt;options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        create_socke=
t_dco_win(c, sock, sig_info);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span>     if (sock-&gt;info.lsa-&gt;current_remote)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            create_socket_dco_win(c, sock, sig_info);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            goto done;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cre=
ate_socket(sock, sock-&gt;info.lsa-&gt;current_remote);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        create_socket(sock, sock-&gt;info.lsa-&gt;c=
urrent_remote);</span><br><span>     }</span><br><span> </span><br><span>  =
   /* If socket has not already been created create it now */</span><br><sp=
an>@@ -3787,6 +3796,91 @@</span><br><span>     return sock-&gt;writes.iosta=
te;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+read_sockaddr_from_overlapped(struct overlapped_io *io, struct sockad=
dr *dst, int overlapped_ret)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o=
verlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        /* TODO(jjo): streamline this mess */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* in this func we =
don&#39;t have relevant info about the PF_ of this</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * endpoint, as link_socket_actual w=
ill be zero for the 1st received packet</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * Test for inets PF_ possible sizes</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        switch (io-&gt;addrlen)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            case sizeof(struct sockaddr_in):<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            case siz=
eof(struct sockaddr_in6):</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /* TODO(jjo): for some reason (?) I&#39;m getting 24,28 f=
or AF_INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     * under _WIN32*/</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            case sizeof(struct sockaddr_in6) - 4:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            default:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                bad_address_length(io-&gt;addrlen, af_ad=
dr_size(io-&gt;addr.sin_family));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        switch =
(io-&gt;addr.sin_family)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       case AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                memcpy(dst, &amp;io-&gt;addr, sizeof(struct sockaddr_in));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                bre=
ak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            case AF_INET6:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                memcpy(dst, =
&amp;io-&gt;addr6, sizeof(struct sockaddr_in6));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(*=
dst);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @br=
ief Extracts a sockaddr from a packet payload.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Reads a sockaddr structure from the start of the packet buffer=
 and writes it to `dst`.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in=
] buf Packet buffer containing the payload.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param[out] dst Destination buffer for the extra=
cted sockaddr.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn Length of the extracted sockaddr</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_s=
ockaddr_from_packet(struct buffer *buf, struct sockaddr *dst)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int sa_len =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct sockaddr *sa =3D (const struct sockaddr *)BPTR(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (sa-&gt=
;sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sa_len =
=3D sizeof(struct sockaddr_in);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (buf_len(buf) &lt; sa_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(M_FATAL, &quot;ERROR: recei=
ved incoming packet with too short length of %d -- must be at least %d.&quo=
t;, buf_len(buf), sa_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            memcpy(dst, sa, sa_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            buf_advance(buf, sa_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case AF_INET6:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            sa_len =3D sizeof(struct sockaddr_in6);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(=
buf) &lt; sa_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(M_FATAL, &quot;ERROR: received incoming packet with too short l=
ength of %d -- must be at least %d.&quot;, buf_len(buf), sa_len);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            memcpy(dst, sa, sa_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_ad=
vance(buf, sa_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL=
, &quot;ERROR: received incoming packet with invalid address family %d.&quo=
t;, sa-&gt;sa_family);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return sa_len;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /* Returns the number of bytes =
successfully read */</span><br><span> int</span><br><span> sockethandle_fin=
alize(sockethandle_t sh,</span><br><span>@@ -3860,45 +3954,14 @@</span><br>=
<span>             ASSERT(0);</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* return from address=
 if requested */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (from &amp;&amp; ret &gt; 0 &amp;&amp; sh.is_handle &amp;&amp; sh.prepe=
nd_sa)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ret -=3D read_socka=
ddr_from_packet(buf, &amp;from-&gt;dest.addr.sa);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     if (!sh.is_handle &amp;&amp; from)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            /* TODO(jjo): streamline this mess */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* in this f=
unc we don&#39;t have relevant info about the PF_ of this</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             * endpoint, as link_socket=
_actual will be zero for the 1st received packet</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-             *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-             * Test for inets PF_ possible sizes</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            switch (io-&gt;addrlen=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                case sizeof(=
struct sockaddr_in):</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               case sizeof(struct sockaddr_in6):</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                /* TODO(jjo): for some reason (?=
) I&#39;m getting 24,28 for AF_INET6</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                 * under _WIN32*/</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                case sizeof(struct sockaddr_in6)=
-4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                default:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    bad_address=
_length(io-&gt;addrlen, af_addr_size(io-&gt;addr.sin_family));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            switch (io-&gt;addr.sin_family)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                case AF_INET:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    from-&gt;dest.addr.in=
4 =3D io-&gt;addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 break;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                cas=
e AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          from-&gt;dest.addr.in6 =3D io-&gt;addr6;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    break;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     CLEAR(from-&gt;dest.addr);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        read_sockaddr_from_overlapped(io, &amp;from-&gt;dest.addr.sa, ret);=
</span><br><span>     }</span><br><span> </span><br><span>     if (buf)</sp=
an><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span=
><br><span>index 16106d4..c370f2c 100644</span><br><span>--- a/src/openvpn/=
socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -224=
,6 +224,7 @@</span><br><span> #define SF_HOST_RANDOMIZE (1&lt;&lt;3)</span>=
<br><span> #define SF_GETADDRINFO_DGRAM (1&lt;&lt;4)</span><br><span> #defi=
ne SF_DCO_WIN (1&lt;&lt;5)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define SF_PREPEND_SA (1&lt;&lt;6)</span><br><span>     unsigned int=
 sockflags;</span><br><span>     int mark;</span><br><span>     const char =
*bind_dev;</span><br><span>@@ -287,6 +288,7 @@</span><br><span>         HAN=
DLE h;</span><br><span>     };</span><br><span>     bool is_handle;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bool prepend_sa; /* are=
 incoming packets prepended with sockaddr? */</span><br><span> } sockethand=
le_t;</span><br><span> </span><br><span> int sockethandle_finalize(socketha=
ndle_t sh,</span><br><span>@@ -1046,6 +1048,7 @@</span><br><span>     {</sp=
an><br><span>         *from =3D sock-&gt;info.lsa-&gt;actual;</span><br><sp=
an>         sh.is_handle =3D true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        sh.prepend_sa =3D sock-&gt;sockflags &amp; SF_PREPEN=
D_SA;</span><br><span>     }</span><br><span>     return sockethandle_final=
ize(sh, &amp;sock-&gt;reads, buf, from);</span><br><span> }</span><br><span=
>@@ -1116,6 +1119,24 @@</span><br><span>             err =3D SocketHandleGe=
tLastError(sh);</span><br><span>         }</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* dco-win mp requires control packets to be=
 prepended with sockaddr */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (sock-&gt;sockflags &amp; SF_PREPEND_SA)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (to-&gt;dest.addr.sa.sa_family =3D=3D AF_I=
NET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct sockad=
dr_in sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  memcpy(&amp;sa, &amp;to-&gt;dest.addr.in4, sizeof(sa));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            buf_write_prepend(buf, &a=
mp;sa, sizeof(sa));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            struct sockaddr=
_in6 sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 memcpy(&amp;sa, &amp;to-&gt;dest.addr.in6, sizeof(sa));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            buf_write_prepend(buf, &am=
p;sa, sizeof(sa));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     soc=
ket_send_queue(sock, buf, to);</span><br><span>     if (status &lt; 0)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/tun.c b/src/ope=
nvpn/tun.c</span><br><span>index 80f5dff..dbe3dfc 100644</span><br><span>--=
- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><sp=
an>@@ -992,7 +992,7 @@</span><br><span> #ifdef _WIN32</span><br><span>     =
if (tt-&gt;backend_driver =3D=3D DRIVER_DCO)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_start_tun(tt);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;dco.tt =
=3D tt;</span><br><span>         return;</span><br><span>     }</span><br><=
span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">change 815</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/815?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6=
eb89021f32dba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 815 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ohF6R/IIex4=--

