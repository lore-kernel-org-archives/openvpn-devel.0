From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 20 Feb 2025 07:12:17 +0000
In-Reply-To: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1909539636712158ea9aa77ab8f60375dc304aed-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r0VvxEfqLHQ="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r0VvxEfqLHQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2.

cron2 has uploaded a new patch set (#21) to the change originally created b=
y stipa. ( http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250219215417.18260-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
935.html
Signed-off-by: Gert Doering <gert@...1296...>
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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/815/21

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index c3e05a8..35ceace 100644
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
@@ -293,7 +294,7 @@
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
index 62d7109..a3c7b63 100644
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
=20
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
index 920f8d7..b57e5f8 100644
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
=20
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
Gerrit-PatchSet: 21
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--r0VvxEfqLHQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2. </p>
<p>cron2 <strong>uploaded patch set #21</strong> to the change originally c=
reated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: multipeer support<br><br>This is the main c=
ommit for dco-win multipeer<br>implementation.<br><br>This adds concept of =
&quot;mode&quot; to DCO implementation,<br>which is peer-to-peer or multipe=
er. Depending on mode,<br>some functions use MP-specific IOCTL commands, wh=
ich<br>include peer-id as a part of input.<br><br>The driver initialization=
 accomodates server mode,<br>in which tun device is created before transpor=
t.<br><br>Since on Windows the socket is visible to the kernel only,<br>con=
trol channel packets have to be prepended with remote<br>sockaddr of the pe=
er - this allows userspace to distinguish<br>among peers. Sadly there is no=
 reliable way to get peer local<br>address, such as on Linux/FreeBSD, so we=
 have to do a bit of<br>guesswork to figure out IP address based on remote =
IP and local<br>routing table, which may backfire if there are multiple IPs=
<br>assigned to the same network adapter. However, as for now<br>peer-speci=
fic local IP is not used by the driver. We use<br>instead the result of bin=
d() to the listening address.<br><br>Existing sockethandle_finalize() funct=
ion has been refactored<br>to accomodate packets with possibly prepended so=
ckaddr.<br><br>Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba<br>Sign=
ed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt=
;gert@...1296...&gt;<br>Message-Id: &lt;20250219215417.18260-1-gert@...1726...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg30935.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openv=
pn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/dco_win.h<br>M s=
rc/openvpn/forward.c<br>M src/openvpn/init.c<br>M src/openvpn/ovpn_dco_win.=
h<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>M src/openvpn/tun.=
c<br>11 files changed, 484 insertions(+), 132 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/815/21</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index c3e0=
5a8..35ceace 100644</span><br><span>--- a/src/openvpn/dco.h</span><br><span=
>+++ b/src/openvpn/dco.h</span><br><span>@@ -106,9 +106,10 @@</span><br><sp=
an>  *</span><br><span>  * @param mode      the instance operating mode (P2=
P or multi-peer)</span><br><span>  * @param dco       the context to initia=
lize</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dev_n=
ode  device node, used on Windows to specify certain DCO adapter</span><br>=
<span>  * @return          true on success, false otherwise</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ovpn_dco_in=
it(int mode, dco_context_t *dco);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool ovpn_dco_init(int mode, dco_context_t *dco, const char *=
dev_node);</span><br><span> </span><br><span> /**</span><br><span>  * Open/=
create a DCO interface</span><br><span>@@ -293,7 +294,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> static inline bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_context_t *d=
co)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init(in=
t mode, dco_context_t *dco, const char *dev_node)</span><br><span> {</span>=
<br><span>     return true;</span><br><span> }</span><br><span>diff --git a=
/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>inde=
x f4c3b02..0e536de 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</=
span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -165,7 +1=
65,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_co=
ntext_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_d=
co_init(int mode, dco_context_t *dco, const char *dev_node)</span><br><span=
> {</span><br><span>     if (open_fd(dco) &lt; 0)</span><br><span>     {</s=
pan><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.=
c</span><br><span>index fa7abd3..68c1a8d 100644</span><br><span>--- a/src/o=
penvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br>=
<span>@@ -422,7 +422,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_ini=
t(int mode, dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_nod=
e)</span><br><span> {</span><br><span>     switch (mode)</span><br><span>  =
   {</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_w=
in.c</span><br><span>index 62d7109..a3c7b63 100644</span><br><span>--- a/sr=
c/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><=
span>@@ -28,6 +28,7 @@</span><br><span> #include &quot;syshead.h&quot;</spa=
n><br><span> </span><br><span> #include &quot;dco.h&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;forward.h&quot;</span>=
<br><span> #include &quot;tun.h&quot;</span><br><span> #include &quot;crypt=
o.h&quot;</span><br><span> #include &quot;ssl_common.h&quot;</span><br><spa=
n>@@ -41,15 +42,22 @@</span><br><span> const IN_ADDR in4addr_any =3D { 0 };=
</span><br><span> #endif</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-struct tuntap</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-create_dco_handle(const char *devname, struct gc_arena *gc)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Sometimes IP Helper=
 API, which we use for setting IP address etc,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * complains that interface is not found. Give i=
t some time to settle</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_wait_ready(DWORD i=
dx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct tuntap tt =3D { .backend_driver =3D DRIVER_DCO };</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const char *device_guid;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    tun_open_device(&amp;tt, devname, &amp;device=
_guid, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return tt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 20; ++i=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        MIB_IPINTERFACE_ROW row =
=3D { .InterfaceIndex =3D idx, .Family =3D AF_INET };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (GetIpInterfaceEntry(&amp;row)=
 !=3D ERROR_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_=
DEBUG, &quot;interface %ld not yet ready, retrying&quot;, idx);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        Sleep(50);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><=
br><span> </span><br><span> /**</span><br><span>@@ -103,47 +111,51 @@</span=
><br><span>     return res;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_context_t *dco)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-open_tun_dco(struct tuntap *tt, open=
vpn_net_ctx_t *ctx, const char *dev)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A=
SSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-dco_wait_ready(DWORD idx)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int=
 i =3D 0; i &lt; 20; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MIB_=
IPINTERFACE_ROW row =3D {.InterfaceIndex =3D idx, .Family =3D AF_INET};</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (GetIpInterfac=
eEntry(&amp;row) !=3D ERROR_NOT_FOUND)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ms=
g(D_DCO_DEBUG, &quot;interface %ld not yet ready, retrying&quot;, idx);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        Sleep(50);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Initializes t=
he DCO adapter in multipeer mode and sets it to &quot;connected&quot; state=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Opens the DCO device, sets the a=
dapter mode using `OVPN_IOCTL_SET_MODE`,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * which transitions the adapter to the &quot;connecte=
d&quot; state, and waits for it to become ready.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param dco Pointer to the `dco_context_t` structure represen=
ting the DCO context.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param dev_node Device node string for the DCO adapter.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-dco_start_tun(struct tuntap *t=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init_mp(=
dco_context_t *dco, const char *dev_node)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s&quot;,=
 __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(dco-&gt;ifmode =3D=3D DCO_MODE_UNINIT);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dco-&gt;ifmode =3D DCO_MODE_MP;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* reference the=
 tt object inside the DCO context, because the latter will</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * be passed around</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    tt-&gt;dco.tt =3D tt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* open DCO device */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *devic=
e_guid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tun_open=
_device(dco-&gt;tt, dev_node, &amp;device_guid, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* set mp mod=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE m=
 =3D OVPN_MODE_MP;</span><br><span>     DWORD bytes_returned =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(tt-&=
gt;hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                         &amp;bytes_returned, NU=
LL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!Device=
IoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SET_MODE, &amp;m, sizeof(m), NULL=
, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_SET_MODE) failed&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dco_wait_ready(dco-&gt;tt-&gt;adapter_index);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @brief Transitions the DCO adapter to the connected state in P2P mode.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Sends `OVPN_IOCTL_START_VPN` to sta=
rt the VPN and waits for the adapter</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * to become ready.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param tt Pointer to the `tuntap` structure representing the adapter.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+dco_p2p_start_vpn(struct tuntap *tt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(tt-&gt;hand, OVP=
N_IOCTL_START_VPN, NULL, 0, NULL, 0, &amp;bytes_returned, NULL))</span><br>=
<span>     {</span><br><span>         msg(M_ERR, &quot;DeviceIoControl(OVPN=
_IOCTL_START_VPN) failed&quot;);</span><br><span>     }</span><br><span>@@ =
-154,6 +166,44 @@</span><br><span>     dco_wait_ready(tt-&gt;adapter_index)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Initia=
lizes DCO depends on `mode`</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - for=
 P2P it puts adapter in &quot;connected&quot; state. The peer should</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * be already added by dco=
_p2p_new_peer().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - for multipeer =
it opens DCO adapter and puts it into &quot;connected&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * state. The server socket should =
be initialized later by dco_mp_start_vpn().</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dc=
o_init(int mode, dco_context_t *dco, const char *dev_node)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    switch (mode)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        case MODE_POINT_TO_POINT:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            dco-&gt;ifmode =3D DCO_MODE_P2P;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            dco_p2p_start_vpn(d=
co-&gt;tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        case MODE_SERVER:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            ovpn_dco_i=
nit_mp(dco, dev_node);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(f=
alse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_dco(struct tuntap =
*tt, openvpn_net_ctx_t *ctx, const char *dev)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> sta=
tic void</span><br><span> dco_connect_wait(HANDLE handle, OVERLAPPED *ov, i=
nt timeout, struct signal_info *sig_info)</span><br><span> {</span><br><spa=
n>@@ -206,15 +256,68 @@</span><br><span>     register_signal(sig_info, SIGU=
SR1, &quot;dco-connect-timeout&quot;);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @brief Initializes and binds the=
 kernel UDP transport socket for multipeer mode.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Sends `OVPN_IOCTL_MP_START_VPN` to create a kernel-mode UDP =
socket, binds it to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * the specified address, ready for incoming connections.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param handle Device handle for the DCO adapter.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sock Pointer=
 to the `link_socket` structure containing socket information.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-dco_create_socket(HANDLE han=
dle, struct addrinfo *remoteaddr, bool bind_local,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                  struct addrinfo *bind, int t=
imeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
    struct signal_info *sig_info)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dco_mp_start_vpn(HANDLE handle, struct link_socket *sock)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s&quot;, __fu=
nc__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int ai_family =3D sock-&gt;i=
nfo.lsa-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct addrinfo *local =3D sock-&gt;info.lsa-&gt;bind=
_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct a=
ddrinfo *cur =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (cur =3D=
 local; cur; cur =3D cur-&gt;ai_next)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (cur-&gt;ai_family =3D=3D ai_family)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!cur)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, =
&quot;%s: Socket bind failed: Addr to bind has no %s record&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            __func__, addr_f=
amily_name(ai_family));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_START_VPN in, out=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in.IPv6Only =
=3D sock-&gt;info.bind_ipv6_only ? 1 : 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (ai_family =3D=3D AF_INET)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        memcpy(&amp;in.ListenAddress.Addr4, cur-&gt;a=
i_addr, sizeof(struct sockaddr_in));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;in=
.ListenAddress.Addr6, cur-&gt;ai_addr, sizeof(struct sockaddr_in6));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* in multipeer mode control channel packets are prepen=
ded with remote peer&#39;s sockaddr */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    sock-&gt;sockflags |=3D SF_PREPEND_SA;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(handle, OVPN_IO=
CTL_MP_START_VPN, &amp;in, sizeof(in), &amp;out, sizeof(out),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                         &amp;byt=
es_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
ERR, &quot;DeviceIoControl(OVPN_IOCTL_MP_START_VPN) failed&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_p2p_new_peer(H=
ANDLE handle, struct link_socket *sock, struct signal_info *sig_info)</span=
><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s&quot;, __func_=
_);</span><br><span> </span><br><span>     OVPN_NEW_PEER peer =3D { 0 };</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct addrinfo *remoteaddr =3D sock-&gt;info.lsa-&gt;current_remote;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     str=
uct sockaddr *local =3D NULL;</span><br><span>     struct sockaddr *remote =
=3D remoteaddr-&gt;ai_addr;</span><br><span> </span><br><span>@@ -228,9 +33=
1,10 @@</span><br><span>         peer.Proto =3D OVPN_PROTO_UDP;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (bind_local)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (sock-&gt;bind_local)</span><br><span>     {</span><br><span=
>         /* Use first local address with correct address family */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *bi=
nd =3D sock-&gt;info.lsa-&gt;bind_local;</span><br><span>         while (bi=
nd &amp;&amp; !local)</span><br><span>         {</span><br><span>          =
   if (bind-&gt;ai_family =3D=3D remote-&gt;sa_family)</span><br><span>@@ -=
241,7 +345,7 @@</span><br><span>         }</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (bind_=
local &amp;&amp; !local)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (sock-&gt;bind_local &amp;&amp; !local)</span><br><span>     {<=
/span><br><span>         msg(M_FATAL, &quot;DCO: Socket bind failed: Addres=
s to bind lacks %s record&quot;,</span><br><span>             addr_family_n=
ame(remote-&gt;sa_family));</span><br><span>@@ -290,7 +394,7 @@</span><br><=
span>         }</span><br><span>         else</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco_connect_=
wait(handle, &amp;ov, timeout, sig_info);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            dco_connect_wait(handle, &amp;ov, get_ser=
ver_poll_remaining_time(sock-&gt;server_poll_timeout), sig_info);</span><br=
><span>         }</span><br><span>     }</span><br><span> }</span><br><span=
>@@ -301,6 +405,48 @@</span><br><span>              struct in_addr *vpn_ipv=
4, struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>     msg(D=
_DCO_DEBUG, &quot;%s: peer-id %d, fd %d&quot;, __func__, peerid, sd);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D DCO_MODE_P2P)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* no-op for p2p */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_MP_NEW_PEER newPeer =3D {0};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (remoteaddr)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* while the driver doesn&#39;t use the local address yet it requi=
res its AF to be valid */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        newPeer.Local.Addr4.sin_family =3D remoteaddr-&gt;sa_family;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (remoteaddr-&gt;sa_family =
=3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            me=
mcpy(&amp;newPeer.Remote.Addr4, remoteaddr, sizeof(struct sockaddr_in));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            memcpy(&amp;newPeer.Remote.Addr6, rem=
oteaddr, sizeof(struct sockaddr_in6));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_ipv4)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        newPeer.VpnAddr4 =3D *vpn_ipv4;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (vpn_ipv6)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        newPeer.VpnAddr6 =3D *vpn_ipv6;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    new=
Peer.PeerId =3D peerid;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes=
Returned;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!D=
eviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_NEW_PEER, &amp;newPeer, s=
izeof(newPeer), NULL, 0, &amp;bytesReturned, NULL))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_MP_=
NEW_PEER) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     return 0;</span><br><span> }</span><br><span> </span><br><span=
>@@ -309,9 +455,20 @@</span><br><span> {</span><br><span>     msg(D_DCO_DEB=
UG, &quot;%s: peer-id %d&quot;, __func__, peerid);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_DEL_PEER del_p=
eer =3D { peerid };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    VOID *buf =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    DWORD len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (dco-&gt;ifmode =3D=3D DCO_MODE_MP)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ioctl =3D OVPN_IOCTL_MP_DEL_PEER;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        buf =3D &amp;del_peer;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        len =3D sizeof(del=
_peer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     DWOR=
D bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_DEL_PEER, NULL,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
   0, NULL, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, ioctl,=
 buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     {</spa=
n><br><span>         msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL=
_DEL_PEER) failed&quot;);</span><br><span>         return -1;</span><br><sp=
an>@@ -326,19 +483,30 @@</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: pe=
er-id %d, keepalive %d/%d, mss %d&quot;, __func__,</span><br><span>        =
 peerid, keepalive_interval, keepalive_timeout, mss);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_SET_PEER peer;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_SET_PEER =
mp_peer =3D { peerid, keepalive_interval, keepalive_timeout, mss };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET_PEER peer =3D =
{ keepalive_interval, keepalive_timeout, mss };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    VOID *buf =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    DWORD ioctl =3D (dco-&gt;ifmode =3D=
=3D DCO_MODE_MP) ? OVPN_IOCTL_MP_SET_PEER : OVPN_IOCTL_SET_PEER;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    peer.Keepa=
liveInterval =3D  keepalive_interval;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    peer.KeepaliveTimeout =3D keepalive_timeout;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    peer.MSS =3D mss;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D =
DCO_MODE_MP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf =3D &amp;=
mp_peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        len=
 =3D sizeof(OVPN_MP_SET_PEER);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        buf =3D &amp;peer;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        len =3D sizeo=
f(OVPN_SET_PEER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(d=
co-&gt;tt-&gt;hand, OVPN_IOCTL_SET_PEER, &amp;peer,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         sizeof(peer), NULL=
, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, ioctl, buf, len,=
 NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;=
DeviceIoControl(OVPN_IOCTL_SET_PEER) failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;Devic=
eIoControl(OVPN_IOCTL_MP_SET_PEER) failed&quot;);</span><br><span>         =
return -1;</span><br><span>     }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</span><br>=
<span> </span><br><span>@@ -397,9 +565,20 @@</span><br><span> {</span><br><=
span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer_id);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  OVPN_MP_SWAP_KEYS swap =3D {peer_id};</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    VOID *buf =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (dco-&gt;ifmode =3D=3D DCO_MODE_MP)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ioctl =3D OVPN_IOCTL_MP_SWAP_K=
EYS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf =3D=
 &amp;swap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
len =3D sizeof(swap);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SW=
AP_KEYS, NULL, 0, NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                         &amp;bytes_returned, NULL))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&=
gt;hand, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><br><s=
pan>     {</span><br><span>         msg(M_ERR, &quot;DeviceIoControl(OVPN_I=
OCTL_SWAP_KEYS) failed&quot;);</span><br><span>         return -1;</span><b=
r><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><b=
r><span>index 7688516..dc7fbc1 100644</span><br><span>--- a/src/openvpn/dco=
_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -31,1=
9 +31,25 @@</span><br><span> typedef OVPN_KEY_SLOT dco_key_slot_t;</span><b=
r><span> typedef OVPN_CIPHER_ALG dco_cipher_t;</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    DCO_MODE_UNINIT,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    DCO_MODE_P2P,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    DCO_MODE_MP</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+} dco_mode_type;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct dco_context {</s=
pan><br><span>     struct tuntap *tt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    dco_mode_type ifmode;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> };</span><br><span> </span><br><s=
pan> typedef struct dco_context dco_context_t;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-struct tuntap</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-create_dco_handle(const char *devname, s=
truct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_mp_start_v=
pn(HANDLE handle, struct link_socket *sock);</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_create_s=
ocket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                  struct addri=
nfo *bind, int timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                  struct signal_info *sig_info);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_p2p_new_peer(HANDLE handle, struct link_=
socket *sock, struct signal_info *sig_info);</span><br><span> </span><br><s=
pan> void</span><br><span> dco_start_tun(struct tuntap *tt);</span><br><spa=
n>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><spa=
n>index f3f3503..82c54c2 100644</span><br><span>--- a/src/openvpn/forward.c=
</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1323,7 +13=
23,10 @@</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socketha=
ndle_t sh =3D { .is_handle =3D true, .h =3D c-&gt;c1.tuntap-&gt;hand };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* we cannot en=
d up here when using dco */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ASSERT(!dco_enabled(&amp;c-&gt;options));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        sockethandle_t sh =3D { .is_handle =3D true, .h =
=3D c-&gt;c1.tuntap-&gt;hand, .prepend_sa =3D false };</span><br><span>    =
     sockethandle_finalize(sh, &amp;c-&gt;c1.tuntap-&gt;reads, &amp;c-&gt;c=
2.buf, NULL);</span><br><span>     }</span><br><span> #else  /* ifdef _WIN3=
2 */</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</=
span><br><span>index 920f8d7..b57e5f8 100644</span><br><span>--- a/src/open=
vpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -200=
5,7 +2005,7 @@</span><br><span> </span><br><span>         if (dco_enabled(&=
amp;c-&gt;options))</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c=
1.tuntap-&gt;dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;op=
tions.dev_node);</span><br><span>         }</span><br><span> </span><br><sp=
an>         /* open the tun device */</span><br><span>diff --git a/src/open=
vpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><span>index ea2a7=
33..bfe939d 100644</span><br><span>--- a/src/openvpn/ovpn_dco_win.h</span><=
br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -47,6 +47,23 @=
@</span><br><span> 	OVPN_PROTO Proto;</span><br><span> } OVPN_NEW_PEER, * P=
OVPN_NEW_PEER;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+typedef struct _OVPN_MP_NEW_PEER {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    union {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        SOCKADDR_IN Addr4;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        SOCKADDR_IN6 Addr6;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    } Local;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    union {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        SOCKADDR_IN Addr4;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    } Remote;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    IN_AD=
DR VpnAddr4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    IN6=
_ADDR VpnAddr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_NEW_PEER, * POVPN=
_MP_NEW_PEER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> typedef struct _OVPN_STATS {</span><br><span> 	LONG LostInContr=
olPackets;</span><br><span> 	LONG LostOutControlPackets;</span><br><span>@@=
 -94,10 +111,17 @@</span><br><span> 	int PeerId;</span><br><span> } OVPN_CR=
YPTO_DATA, * POVPN_CRYPTO_DATA;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+typedef struct _OVPN_MP_SET_PEER {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    LONG KeepaliveInterval;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG KeepaliveTimeout;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG MSS;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_SET_PEER, * POV=
PN_MP_SET_PEER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> typedef struct _OVPN_SET_PEER {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	LONG KeepaliveInterval;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	LONG KeepaliveTimeout;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	LONG MSS;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    LONG KeepaliveInterval;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    LONG KeepaliveTimeout;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    LONG MSS;</span><br><span> } OVPN_SE=
T_PEER, * POVPN_SET_PEER;</span><br><span> </span><br><span> typedef struct=
 _OVPN_VERSION {</span><br><span>@@ -106,6 +130,50 @@</span><br><span>     =
LONG Patch;</span><br><span> } OVPN_VERSION, * POVPN_VERSION;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_P2P,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_MP</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MODE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+typedef struct _OVPN_SET_MODE {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE Mode;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+} OVPN_SET_MODE, * POVPN_SET_MODE;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_MP_START_VPN {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    union {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_IN Addr4;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_IN6 Addr6=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } ListenAddres=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int IPv6Only;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_START_VPN=
, * POVPN_MP_START_VPN;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_DEL_PEE=
R,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_SWAP=
_KEYS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_NOTIFY_=
CMD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TEARDOWN,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON=
_USERSPACE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN=
_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_DEL_PEER_REASO=
N;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_NOTIFY_EVENT {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NOTIFY_CMD =
Cmd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_R=
EASON DelPeerReason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+} OVPN_NOTIFY_EVENT, * POVPN_NOTIFY_EVENT;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+typedef struct _OVPN_MP_DEL_PEER {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int PeerId;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+} OVPN_MP_DEL_PEER, * POVPN_MP_DEL_PEER;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+typedef struct _OVPN_MP_SWAP_KEYS {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+} OVPN_MP_SWAP_KEYS, * POVPN_MP_SWAP_KEYS;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #def=
ine OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERE=
D, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_GET_STATS    CTL_CO=
DE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><spa=
n> #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_=
BUFFERED, FILE_ANY_ACCESS)</span><br><span>@@ -114,3 +182,14 @@</span><br><=
span> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METH=
OD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_DEL_PEER =
    CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)</spa=
n><br><span> #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, =
8, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNO=
WN, 9, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OVPN_IOCTL_SET_MODE     CTL_CODE(FILE_DEVICE_U=
NKNOWN, 10, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define OVPN_IOCTL_MP_START_VPN   CTL_CODE(FILE_DEVICE_UNKNOWN, 11, =
METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define OVPN_IOCTL_MP_NEW_PEER    CTL_CODE(FILE_DEVICE_UNKNOW=
N, 12, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OVPN_IOCTL_MP_SET_PEER    CTL_CODE(FILE_DEVICE=
_UNKNOWN, 13, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define OVPN_IOCTL_NOTIFY_EVENT   CTL_CODE(FILE_DEVICE_UNKNOWN, 14=
, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine OVPN_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_BUF=
FERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE_DEVICE_UNKNOWN, 16, MET=
HOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span>diff --git a/src/openvpn/soc=
ket.c b/src/openvpn/socket.c</span><br><span>index d01b995..5b32885 100644<=
/span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvp=
n/socket.c</span><br><span>@@ -2177,12 +2177,22 @@</span><br><span> create_=
socket_dco_win(struct context *c, struct link_socket *sock,</span><br><span=
>                       struct signal_info *sig_info)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* in P2P mode we =
must have remote resolved at this point */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct addrinfo *remoteaddr =3D sock-&gt;info.ls=
a-&gt;current_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if ((c-&gt;options.mode =3D=3D MODE_POINT_TO_POINT) &amp;&amp; (!remo=
teaddr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!c-&gt;c1.tunta=
p)</span><br><span>     {</span><br><span>         struct tuntap *tt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ(tt, struc=
t tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A=
LLOC_OBJ_CLEAR(tt, struct tuntap);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *tt =3D create_dco_handle(c-&gt;opt=
ions.dev_node, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        tt-&gt;backend_driver =3D DRIVER_DCO;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const char *device_guid =3D NULL; /* not used */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tun_open_dev=
ice(tt, c-&gt;options.dev_node, &amp;device_guid, &amp;c-&gt;gc);</span><br=
><span> </span><br><span>         /* Ensure we can &quot;safely&quot; cast =
the handle to a socket */</span><br><span>         static_assert(sizeof(soc=
k-&gt;sd) =3D=3D sizeof(tt-&gt;hand), &quot;HANDLE and SOCKET size differs&=
quot;);</span><br><span>@@ -2190,12 +2200,14 @@</span><br><span>         c-=
&gt;c1.tuntap =3D tt;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    dco_create_socket(c-&gt;c1.tun=
tap-&gt;hand,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
              sock-&gt;info.lsa-&gt;current_remote,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      sock-&gt;bind_local, =
sock-&gt;info.lsa-&gt;bind_local,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                      get_server_poll_remaining_time(sock-&gt;s=
erver_poll_timeout),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                     sig_info);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c=
-&gt;options.mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        dco_mp_start_vpn(c-&gt;c1.tuntap-&gt;hand, sock);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        dco_p2p_new_peer(c-&gt;c1.tuntap-&gt;hand, sock, sig_info);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>  =
   sock-&gt;sockflags |=3D SF_DCO_WIN;</span><br><span> </span><br><span>  =
   if (sig_info-&gt;signal_received)</span><br><span>@@ -2245,19 +2257,16 @=
@</span><br><span>     resolve_remote(sock, 2, &amp;remote_dynamic,  sig_in=
fo);</span><br><span> </span><br><span>     /* If a valid remote has been f=
ound, create the socket with its addrinfo */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&gt;options))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        create_socket_dco_win(c, sock, si=
g_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>   =
  if (sock-&gt;info.lsa-&gt;current_remote)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_enabled(&amp;c-&=
gt;options))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            create_so=
cket_dco_win(c, sock, sig_info);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            goto done;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            create_socket(sock, sock=
-&gt;info.lsa-&gt;current_remote);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        create_socket(sock, sock-&gt;info.lsa-&gt;current_remote);</span=
><br><span>     }</span><br><span> </span><br><span>     /* If socket has n=
ot already been created create it now */</span><br><span>@@ -3787,6 +3796,9=
1 @@</span><br><span>     return sock-&gt;writes.iostate;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_f=
rom_overlapped(struct overlapped_io *io, struct sockaddr *dst, int overlapp=
ed_ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (overlapped_ret &gt;=3D=
 0 &amp;&amp; io-&gt;addr_defined)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* TODO(jjo): streamline this mess */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* in this func we don&#39;t have releva=
nt info about the PF_ of this</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * endpoint, as link_socket_actual will be zero for the 1=
st received packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 Test for inets PF_ possible sizes</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        switch (io-&gt;addrlen)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            case sizeof(struct sockaddr_in):</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            case sizeof(struct sockaddr_i=
n6):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
TODO(jjo): for some reason (?) I&#39;m getting 24,28 for AF_INET6</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+             * under _WIN32*/=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            case si=
zeof(struct sockaddr_in6) - 4:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                break;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            bad_address_length(io-&gt;addrlen, af_addr_size(io-&gt;addr.sin=
_family));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        switch (io-&gt;addr.sin_family=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            case AF_INET:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                memcpy=
(dst, &amp;io-&gt;addr, sizeof(struct sockaddr_in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            case AF_INET6:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                memcpy(dst, &amp;io-&gt;addr6, siz=
eof(struct sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        CLEAR(*dst);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Extracts a sockaddr =
from a packet payload.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Reads a soc=
kaddr structure from the start of the packet buffer and writes it to `dst`.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param[in] buf Packet buffer cont=
aining the payload.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param[out] dst Destination buffer for the extracted sockaddr.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Length of the extr=
acted sockaddr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+read_sockaddr_from_packet(stru=
ct buffer *buf, struct sockaddr *dst)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int sa_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
sockaddr *sa =3D (const struct sockaddr *)BPTR(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    switch (sa-&gt;sa_family)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        case AF_INET:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            sa_len =3D sizeof(struct sock=
addr_in);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (buf_len(buf) &lt; sa_len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(M_FATAL, &quot;ERROR: received incoming packet wi=
th too short length of %d -- must be at least %d.&quot;, buf_len(buf), sa_l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(ds=
t, sa, sa_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        buf_advance(buf, sa_len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  case AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         sa_len =3D sizeof(struct sockaddr_in6);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (buf_len(buf) &lt; sa_len)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_FATAL, &=
quot;ERROR: received incoming packet with too short length of %d -- must be=
 at least %d.&quot;, buf_len(buf), sa_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            memcpy(dst, sa, sa_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            buf_advance(buf, sa_len);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;ERROR: receiv=
ed incoming packet with invalid address family %d.&quot;, sa-&gt;sa_family)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return sa_len;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /* Returns the number of bytes successfully read */<=
/span><br><span> int</span><br><span> sockethandle_finalize(sockethandle_t =
sh,</span><br><span>@@ -3860,45 +3954,14 @@</span><br><span>             AS=
SERT(0);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* return from address if requested */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (from &amp;&amp; =
ret &gt; 0 &amp;&amp; sh.is_handle &amp;&amp; sh.prepend_sa)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ret -=3D read_sockaddr_from_packet(buf, =
&amp;from-&gt;dest.addr.sa);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     if (!sh.is_handle &amp;&amp; from)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ret &gt;=
=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /* TODO(jjo): streamline this mess */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            /* in this func we don&#39;t ha=
ve relevant info about the PF_ of this</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-             * endpoint, as link_socket_actual will be zer=
o for the 1st received packet</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-             *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-             * Test for inets PF_ possible sizes</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-             */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            switch (io-&gt;addrlen)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                case sizeof(struct sockaddr_in)=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                case=
 sizeof(struct sockaddr_in6):</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                /* TODO(jjo): for some reason (?) I&#39;m getting 2=
4,28 for AF_INET6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
             * under _WIN32*/</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                case sizeof(struct sockaddr_in6)-4:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                default:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    bad_address_length(io-&gt;addr=
len, af_addr_size(io-&gt;addr.sin_family));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     switch (io-&gt;addr.sin_family)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                case AF_INET:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    from-&gt;dest.addr.in4 =3D io-&gt;addr;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    br=
eak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                case AF_INET6:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    from-&gt;=
dest.addr.in6 =3D io-&gt;addr6;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    break;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            CLEAR(from-&gt=
;dest.addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        read_sockad=
dr_from_overlapped(io, &amp;from-&gt;dest.addr.sa, ret);</span><br><span>  =
   }</span><br><span> </span><br><span>     if (buf)</span><br><span>diff -=
-git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index 16=
106d4..c370f2c 100644</span><br><span>--- a/src/openvpn/socket.h</span><br>=
<span>+++ b/src/openvpn/socket.h</span><br><span>@@ -224,6 +224,7 @@</span>=
<br><span> #define SF_HOST_RANDOMIZE (1&lt;&lt;3)</span><br><span> #define =
SF_GETADDRINFO_DGRAM (1&lt;&lt;4)</span><br><span> #define SF_DCO_WIN (1&lt=
;&lt;5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SF_P=
REPEND_SA (1&lt;&lt;6)</span><br><span>     unsigned int sockflags;</span><=
br><span>     int mark;</span><br><span>     const char *bind_dev;</span><b=
r><span>@@ -287,6 +288,7 @@</span><br><span>         HANDLE h;</span><br><s=
pan>     };</span><br><span>     bool is_handle;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool prepend_sa; /* are incoming packets p=
repended with sockaddr? */</span><br><span> } sockethandle_t;</span><br><sp=
an> </span><br><span> int sockethandle_finalize(sockethandle_t sh,</span><b=
r><span>@@ -1046,6 +1048,7 @@</span><br><span>     {</span><br><span>      =
   *from =3D sock-&gt;info.lsa-&gt;actual;</span><br><span>         sh.is_h=
andle =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    sh.prepend_sa =3D sock-&gt;sockflags &amp; SF_PREPEND_SA;</span><br><sp=
an>     }</span><br><span>     return sockethandle_finalize(sh, &amp;sock-&=
gt;reads, buf, from);</span><br><span> }</span><br><span>@@ -1116,6 +1119,2=
4 @@</span><br><span>             err =3D SocketHandleGetLastError(sh);</sp=
an><br><span>         }</span><br><span>     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* dco-win mp requires control packets to be prepended with soc=
kaddr */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (soc=
k-&gt;sockflags &amp; SF_PREPEND_SA)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (to-&gt;dest.addr.sa.sa_family =3D=3D AF_INET)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            struct sockaddr_in sa;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;sa, &=
amp;to-&gt;dest.addr.in4, sizeof(sa));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            buf_write_prepend(buf, &amp;sa, sizeof(sa));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            struct sockaddr_in6 sa;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;sa, &a=
mp;to-&gt;dest.addr.in6, sizeof(sa));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            buf_write_prepend(buf, &amp;sa, sizeof(sa));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     socket_send_queue(sock=
, buf, to);</span><br><span>     if (status &lt; 0)</span><br><span>     {<=
/span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><b=
r><span>index 80f5dff..dbe3dfc 100644</span><br><span>--- a/src/openvpn/tun=
.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -992,7 +992,7=
 @@</span><br><span> #ifdef _WIN32</span><br><span>     if (tt-&gt;backend_=
driver =3D=3D DRIVER_DCO)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        dco_start_tun(tt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;dco.tt =3D tt;</span><br><=
span>         return;</span><br><span>     }</span><br><span> </span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/815?usp=3Demail">change 815</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6=
eb89021f32dba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 815 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--r0VvxEfqLHQ=--

