From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 23 Jan 2025 09:34:53 +0000
In-Reply-To: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1135ef73c6017fc2a3a472d39a1c22ef51f04521-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ChjCGZCFN/A="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ChjCGZCFN/A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail

to look at the new patch set (#12).


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
10 files changed, 518 insertions(+), 103 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/815/12

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
index b038382..0a38a0e 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -391,7 +391,7 @@
 }

 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
 {
     switch (mode)
     {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 46b2d03..8a8b7a3 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -28,6 +28,7 @@
 #include "syshead.h"

 #include "dco.h"
+#include "forward.h"
 #include "tun.h"
 #include "crypto.h"
 #include "ssl_common.h"
@@ -42,16 +43,37 @@
 #endif

 struct tuntap
-create_dco_handle(const char *devname, struct gc_arena *gc)
+create_dco_handle(const char *devname, struct gc_arena *gc, int mode)
 {
     struct tuntap tt =3D { .backend_driver =3D DRIVER_DCO };
     const char *device_guid;

     tun_open_device(&tt, devname, &device_guid, gc);

+    /* for mp we set mode in ovpn_dco_init(), however for p2p it is too la=
te */
+    tt.dco.mode =3D (mode =3D=3D MODE_SERVER) ? dco_mode_mp : dco_mode_p2p;
+
     return tt;
 }

+/* Sometimes IP Helper API, which we use for setting IP address etc,
+ * complains that interface is not found. Give it some time to settle
+ */
+static void
+dco_wait_ready(DWORD idx)
+{
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
+}
+
 /**
  * Gets version of dco-win driver
  *
@@ -104,8 +126,32 @@
 }

 bool
-ovpn_dco_init(int mode, dco_context_t *dco)
+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)
 {
+    /* for p2p dco->mode is already set */
+    dco->mode =3D (mode =3D=3D MODE_POINT_TO_POINT) ? dco_mode_p2p : dco_m=
ode_mp;
+
+    if (dco->mode =3D=3D dco_mode_p2p)
+    {
+        return true;
+    }
+
+    /* open DCO device */
+    struct gc_arena gc =3D gc_new();
+    const char *device_guid;
+    tun_open_device(dco->tt, dev_node, &device_guid, &gc);
+    gc_free(&gc);
+
+    /* set mp mode */
+    OVPN_MODE m =3D OVPN_MODE_MP;
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_MODE, &m, sizeof(m)=
, NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SET_MODE) failed");
+    }
+
+    dco_wait_ready(dco->tt->adapter_index);
+
     return true;
 }

@@ -116,19 +162,19 @@
     return 0;
 }

-static void
-dco_wait_ready(DWORD idx)
+void
+dco_p2p_start_vpn(struct tuntap *tt)
 {
-    for (int i =3D 0; i < 20; ++i)
+    DWORD bytes_returned =3D 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,=
 &bytes_returned, NULL))
     {
-        MIB_IPINTERFACE_ROW row =3D {.InterfaceIndex =3D idx, .Family =3D =
AF_INET};
-        if (GetIpInterfaceEntry(&row) !=3D ERROR_NOT_FOUND)
-        {
-            break;
-        }
-        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
-        Sleep(50);
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed");
     }
+
+    /* Sometimes IP Helper API, which we use for setting IP address etc,
+     * complains that interface is not found. Give it some time to settle
+     */
+    dco_wait_ready(tt->adapter_index);
 }

 void
@@ -141,17 +187,10 @@
      */
     tt->dco.tt =3D tt;

-    DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
-                         &bytes_returned, NULL))
+    if (tt->dco.mode =3D=3D dco_mode_p2p)
     {
-        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed");
+        dco_p2p_start_vpn(tt);
     }
-
-    /* Sometimes IP Helper API, which we use for setting IP address etc,
-     * complains that interface is not found. Give it some time to settle
-     */
-    dco_wait_ready(tt->adapter_index);
 }

 static void
@@ -207,14 +246,67 @@
 }

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
+
+    if (out.ListenAddress.Addr4.sin_family =3D=3D AF_INET)
+    {
+        memcpy(&sock->info.lsa->actual.dest.addr.in4, &out.ListenAddress.A=
ddr4, sizeof(struct sockaddr_in));
+    }
+    else
+    {
+        memcpy(&sock->info.lsa->actual.dest.addr.in6, &out.ListenAddress.A=
ddr6, sizeof(struct sockaddr_in6));
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

@@ -228,9 +320,10 @@
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
@@ -241,7 +334,7 @@
         }
     }

-    if (bind_local && !local)
+    if (sock->bind_local && !local)
     {
         msg(M_FATAL, "DCO: Socket bind failed: Address to bind lacks %s re=
cord",
             addr_family_name(remote->sa_family));
@@ -290,17 +383,131 @@
         }
         else
         {
-            dco_connect_wait(handle, &ov, timeout, sig_info);
+            dco_connect_wait(handle, &ov, get_server_poll_remaining_time(s=
ock->server_poll_timeout), sig_info);
         }
     }
 }

+static struct sockaddr *
+dco_get_source_ip_for_dst(const struct sockaddr *dst)
+{
+    SOCKADDR_INET dst_in =3D { 0 };
+
+    /* Cast the destination address to SOCKADDR_INET */
+    if (dst->sa_family =3D=3D AF_INET)
+    {
+        dst_in.Ipv4 =3D *((struct sockaddr_in *)dst);
+        dst_in.si_family =3D AF_INET;
+    }
+    else if (dst->sa_family =3D=3D AF_INET6)
+    {
+        dst_in.Ipv6 =3D *((struct sockaddr_in6 *)dst);
+        dst_in.si_family =3D AF_INET6;
+    }
+    else
+    {
+        msg(M_FATAL, "%s: unknown dst address family %d", __func__, dst->s=
a_family);
+    }
+
+    /* Get the best source address */
+    MIB_IPFORWARD_ROW2 row;
+    SOCKADDR_INET best_src =3D { 0 };
+    DWORD ret =3D GetBestRoute2(NULL, 0, NULL, &dst_in, 0, &row, &best_src=
);
+    if (ret !=3D NO_ERROR)
+    {
+        msg(M_WARN, "%s: GetBestRoute2() failed with error: %ld\n", __func=
__, ret);
+        return NULL;
+    }
+
+    /* Allocate and copy the best source address to return as sockaddr */
+    struct sockaddr *src =3D NULL;
+    if (best_src.si_family =3D=3D AF_INET6)
+    {
+        struct sockaddr_in6 *src_in6 =3D (struct sockaddr_in6 *)malloc(siz=
eof(struct sockaddr_in6));
+        if (src_in6 =3D=3D NULL)
+        {
+            msg(M_FATAL, "%s: malloc failed", __func__);
+        }
+        *src_in6 =3D best_src.Ipv6;
+        src =3D (struct sockaddr *)src_in6;
+    }
+    else if (best_src.si_family =3D=3D AF_INET)
+    {
+        struct sockaddr_in *src_in =3D (struct sockaddr_in *)malloc(sizeof=
(struct sockaddr_in));
+        if (src_in =3D=3D NULL)
+        {
+            msg(M_FATAL, "%s: malloc failed", __func__);
+        }
+        *src_in =3D best_src.Ipv4;
+        src =3D (struct sockaddr *)src_in;
+    }
+    else
+    {
+        msg(M_FATAL, "%s: unknown src family %d", __func__, best_src.si_fa=
mily);
+    }
+
+    return src;
+}
+
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
              struct sockaddr *localaddr, struct sockaddr *remoteaddr,
              struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+
+    if (dco->mode =3D=3D dco_mode_p2p)
+    {
+        /* no-op for p2p */
+        return 0;
+    }
+
+    OVPN_MP_NEW_PEER newPeer =3D {0};
+
+    if (remoteaddr)
+    {
+        struct sockaddr *local =3D dco_get_source_ip_for_dst(remoteaddr);
+        if (local)
+        {
+            if (local->sa_family =3D=3D AF_INET)
+            {
+                memcpy(&newPeer.Local.Addr4, local, sizeof(struct sockaddr=
_in));
+            }
+            else
+            {
+                memcpy(&newPeer.Local.Addr6, local, sizeof(struct sockaddr=
_in6));
+            }
+            free(local);
+        }
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

@@ -309,9 +516,20 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);

+    OVPN_MP_DEL_PEER del_peer =3D { peerid };
+    VOID *buf =3D NULL;
+    DWORD len =3D 0;
+    DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;
+
+    if (dco->mode =3D=3D dco_mode_mp)
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
@@ -326,19 +544,30 @@
     msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
         peerid, keepalive_interval, keepalive_timeout, mss);

-    OVPN_SET_PEER peer;
+    OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keepalive_t=
imeout, mss };
+    OVPN_SET_PEER peer =3D { keepalive_interval, keepalive_timeout, mss };
+    VOID *buf =3D NULL;
+    DWORD len =3D 0;
+    DWORD ioctl =3D (dco->mode =3D=3D dco_mode_mp) ? OVPN_IOCTL_MP_SET_PEE=
R : OVPN_IOCTL_SET_PEER;

-    peer.KeepaliveInterval =3D  keepalive_interval;
-    peer.KeepaliveTimeout =3D keepalive_timeout;
-    peer.MSS =3D mss;
+    if (dco->mode =3D=3D dco_mode_mp)
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

@@ -397,9 +626,20 @@
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);

+    OVPN_MP_SWAP_KEYS swap =3D {peer_id};
+    DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;
+    VOID *buf =3D NULL;
+    DWORD len =3D 0;
+
+    if (dco->mode =3D=3D dco_mode_mp)
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
index 7688516..7c09977 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -31,19 +31,28 @@
 typedef OVPN_KEY_SLOT dco_key_slot_t;
 typedef OVPN_CIPHER_ALG dco_cipher_t;

+typedef enum {
+    dco_mode_uninit,
+    dco_mode_p2p,
+    dco_mode_mp
+} dco_mode_type;
+
 struct dco_context {
     struct tuntap *tt;
+    dco_mode_type mode;
+
 };

 typedef struct dco_context dco_context_t;

 struct tuntap
-create_dco_handle(const char *devname, struct gc_arena *gc);
+create_dco_handle(const char *devname, struct gc_arena *gc, int mode);

 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_lo=
cal,
-                  struct addrinfo *bind, int timeout,
-                  struct signal_info *sig_info);
+dco_mp_start_vpn(HANDLE handle, struct link_socket *sock);
+
+void
+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_in=
fo *sig_info);

 void
 dco_start_tun(struct tuntap *tt);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f3f3503..90ec94c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1323,7 +1323,8 @@
     }
     else
     {
-        sockethandle_t sh =3D { .is_handle =3D true, .h =3D c->c1.tuntap->=
hand };
+        bool prepend_sa =3D c->options.mode =3D=3D MODE_SERVER && dco_enab=
led(&c->options);
+        sockethandle_t sh =3D { .is_handle =3D true, .h =3D c->c1.tuntap->=
hand, .prepend_sa =3D prepend_sa };
         sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
     }
 #else  /* ifdef _WIN32 */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9d1048c..e6ff2ba 100644
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
index ea2a733..8003ace 100644
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
@@ -94,10 +111,25 @@
 	int PeerId;
 } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;

+#define CRYPTO_OPTIONS_AEAD_TAG_END (1<<1)
+#define CRYPTO_OPTIONS_64BIT_PKTID  (1<<2)
+
+typedef struct _OVPN_CRYPTO_DATA_V2 {
+    OVPN_CRYPTO_DATA V1;
+    UINT32 CryptoOptions;
+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;
+
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
@@ -106,6 +138,50 @@
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
@@ -114,3 +190,14 @@
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
index 7765372..fab5b4a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2173,7 +2173,7 @@
         struct tuntap *tt;
         ALLOC_OBJ(tt, struct tuntap);

-        *tt =3D create_dco_handle(c->options.dev_node, &c->gc);
+        *tt =3D create_dco_handle(c->options.dev_node, &c->gc, c->options.=
mode);

         /* Ensure we can "safely" cast the handle to a socket */
         static_assert(sizeof(sock->sd) =3D=3D sizeof(tt->hand), "HANDLE an=
d SOCKET size differs");
@@ -2181,12 +2181,14 @@
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
@@ -2236,16 +2238,16 @@
     resolve_remote(sock, 2, &remote_dynamic,  sig_info);

     /* If a valid remote has been found, create the socket with its addrin=
fo */
-    if (sock->info.lsa->current_remote)
-    {
 #if defined(_WIN32)
-        if (dco_enabled(&c->options))
-        {
-            create_socket_dco_win(c, sock, sig_info);
-            goto done;
-        }
-        else
+    if (dco_enabled(&c->options))
+    {
+        create_socket_dco_win(c, sock, sig_info);
+        goto done;
+    }
+    else
 #endif
+    {
+        if (sock->info.lsa->current_remote)
         {
             create_socket(sock, sock->info.lsa->current_remote);
         }
@@ -3778,6 +3780,91 @@
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
+            if (buf_len(buf) < sizeof(struct sockaddr_in))
+            {
+                msg(M_FATAL, "ERROR: received incoming packet with too sho=
rt length of %d -- must be at least %zu.", buf_len(buf), sizeof(struct sock=
addr_in));
+            }
+            memcpy(dst, sa, sizeof(struct sockaddr_in));
+            buf_advance(buf, sizeof(struct sockaddr_in));
+            sa_len =3D sizeof(struct sockaddr_in);
+            break;
+
+        case AF_INET6:
+            if (buf_len(buf) < sizeof(struct sockaddr_in6))
+            {
+                msg(M_FATAL, "ERROR: received incoming packet with too sho=
rt length of %d -- must be at least %zu.", buf_len(buf), sizeof(struct sock=
addr_in6));
+            }
+            memcpy(dst, sa, sizeof(struct sockaddr_in6));
+            buf_advance(buf, sizeof(struct sockaddr_in6));
+            sa_len =3D sizeof(struct sockaddr_in6);
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
@@ -3851,45 +3938,14 @@
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba
Gerrit-Change-Number: 815
Gerrit-PatchSet: 12
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ChjCGZCFN/A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #12</strong> to this change.</p><p><a h=
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
et.h<br>10 files changed, 518 insertions(+), 103 deletions(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/815/12</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>index 0=
35474f..7f2021d 100644</span><br><span>--- a/src/openvpn/dco.h</span><br><s=
pan>+++ b/src/openvpn/dco.h</span><br><span>@@ -106,9 +106,10 @@</span><br>=
<span>  *</span><br><span>  * @param mode      the instance operating mode =
(P2P or multi-peer)</span><br><span>  * @param dco       the context to ini=
tialize</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param de=
v_node  device node, used on Windows to specify certain DCO adapter</span><=
br><span>  * @return          true on success, false otherwise</span><br><s=
pan>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ovpn_dco=
_init(int mode, dco_context_t *dco);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool ovpn_dco_init(int mode, dco_context_t *dco, const cha=
r *dev_node);</span><br><span> </span><br><span> /**</span><br><span>  * Op=
en/create a DCO interface</span><br><span>@@ -284,7 +285,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static inline bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_context_t=
 *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_init=
(int mode, dco_context_t *dco, const char *dev_node)</span><br><span> {</sp=
an><br><span>     return true;</span><br><span> }</span><br><span>diff --gi=
t a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>i=
ndex f4c3b02..0e536de 100644</span><br><span>--- a/src/openvpn/dco_freebsd.=
c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -165,7=
 +165,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco=
_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovp=
n_dco_init(int mode, dco_context_t *dco, const char *dev_node)</span><br><s=
pan> {</span><br><span>     if (open_fd(dco) &lt; 0)</span><br><span>     {=
</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_lin=
ux.c</span><br><span>index b038382..0a38a0e 100644</span><br><span>--- a/sr=
c/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><=
br><span>@@ -391,7 +391,7 @@</span><br><span> }</span><br><span> </span><br=
><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_=
init(int mode, dco_context_t *dco)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_=
node)</span><br><span> {</span><br><span>     switch (mode)</span><br><span=
>     {</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dc=
o_win.c</span><br><span>index 46b2d03..8a8b7a3 100644</span><br><span>--- a=
/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><b=
r><span>@@ -28,6 +28,7 @@</span><br><span> #include &quot;syshead.h&quot;</=
span><br><span> </span><br><span> #include &quot;dco.h&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;forward.h&quot;</sp=
an><br><span> #include &quot;tun.h&quot;</span><br><span> #include &quot;cr=
ypto.h&quot;</span><br><span> #include &quot;ssl_common.h&quot;</span><br><=
span>@@ -42,16 +43,37 @@</span><br><span> #endif</span><br><span> </span><b=
r><span> struct tuntap</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-create_dco_handle(const char *devname, struct gc_arena *gc)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+create_dco_handle(const char *devn=
ame, struct gc_arena *gc, int mode)</span><br><span> {</span><br><span>    =
 struct tuntap tt =3D { .backend_driver =3D DRIVER_DCO };</span><br><span> =
    const char *device_guid;</span><br><span> </span><br><span>     tun_ope=
n_device(&amp;tt, devname, &amp;device_guid, gc);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* for mp we set mode i=
n ovpn_dco_init(), however for p2p it is too late */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tt.dco.mode =3D (mode =3D=3D MODE_SER=
VER) ? dco_mode_mp : dco_mode_p2p;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     return tt;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Sometim=
es IP Helper API, which we use for setting IP address etc,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * complains that interface is not f=
ound. Give it some time to settle</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_wait_r=
eady(DWORD idx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; 20; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MIB_IPINTE=
RFACE_ROW row =3D { .InterfaceIndex =3D idx, .Family =3D AF_INET };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (GetIpInterfaceE=
ntry(&amp;row) !=3D ERROR_NOT_FOUND)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_DCO_DEBUG, &quot;interface %ld not yet ready, retrying&quot;, idx=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Sleep(50)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Gets ver=
sion of dco-win driver</span><br><span>  *</span><br><span>@@ -104,8 +126,3=
2 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_conte=
xt_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_=
init(int mode, dco_context_t *dco, const char *dev_node)</span><br><span> {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* for p2p dco-=
&gt;mode is already set */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    dco-&gt;mode =3D (mode =3D=3D MODE_POINT_TO_POINT) ? dco_mode_p2=
p : dco_mode_mp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;mode =
=3D=3D dco_mode_p2p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* open DCO device */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *device=
_guid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tun_open_=
device(dco-&gt;tt, dev_node, &amp;device_guid, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* set mp mode */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_MODE m =3D OVPN_MODE_MP;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dc=
o-&gt;tt-&gt;hand, OVPN_IOCTL_SET_MODE, &amp;m, sizeof(m), NULL, 0, &amp;by=
tes_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M=
_ERR, &quot;DeviceIoControl(OVPN_IOCTL_SET_MODE) failed&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dco_wait_ready(dco-&gt;tt-&gt;adapter_index);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return true;=
</span><br><span> }</span><br><span> </span><br><span>@@ -116,19 +162,19 @@=
</span><br><span>     return 0;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-dco_wait_ready(DWORD idx)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_p2p_start_vpn(struct tuntap *tt)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int =
i =3D 0; i &lt; 20; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!DeviceIoControl(tt-&gt;hand, OVPN_IOCTL_START_VPN=
, NULL, 0, NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        MIB_IPINTERFACE_RO=
W row =3D {.InterfaceIndex =3D idx, .Family =3D AF_INET};</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (GetIpInterfaceEntry(&amp;ro=
w) !=3D ERROR_NOT_FOUND)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG,=
 &quot;interface %ld not yet ready, retrying&quot;, idx);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        Sleep(50);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;DeviceIoControl=
(OVPN_IOCTL_START_VPN) failed&quot;);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Sometimes IP Helper API, which we use for sett=
ing IP address etc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * complains that interface is not found. Give it some time to settle</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    dco_wait_ready(tt-&gt;adapter=
_index);</span><br><span> }</span><br><span> </span><br><span> void</span><=
br><span>@@ -141,17 +187,10 @@</span><br><span>      */</span><br><span>   =
  tt-&gt;dco.tt =3D tt;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    DWORD bytes_returned =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(tt-&gt;hand, OVPN_=
IOCTL_START_VPN, NULL, 0, NULL, 0,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                         &amp;bytes_returned, NULL))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;dco.mode =3D=
=3D dco_mode_p2p)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_STAR=
T_VPN) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        dco_p2p_start_vpn(tt);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* Sometimes IP Helper API, which we use for setting IP ad=
dress etc,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * comp=
lains that interface is not found. Give it some time to settle</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    dco_wait_ready(tt-&gt;adapter_index);</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
>@@ -207,14 +246,67 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_create_sock=
et(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                  struct addrinfo=
 *bind, int timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                 struct signal_info *sig_info)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_mp_start_vpn(HANDLE handle, struct link_sock=
et *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%=
s&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ai_family =
=3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *local =3D sock-&gt;i=
nfo.lsa-&gt;bind_local;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct addrinfo *cur =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (cur =3D local; cur; cur =3D cur-&gt;ai_next)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (cur-&gt;ai_family =3D=3D ai_family)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!cur)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_FATAL, &quot;%s: Socket bind failed: Addr to bind has no %s record&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            __=
func__, addr_family_name(ai_family));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP_STA=
RT_VPN in, out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
in.IPv6Only =3D sock-&gt;info.bind_ipv6_only ? 1 : 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ai_family =3D=3D AF_INET)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;in.ListenAddress.Addr=
4, cur-&gt;ai_addr, sizeof(struct sockaddr_in));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        me=
mcpy(&amp;in.ListenAddress.Addr6, cur-&gt;ai_addr, sizeof(struct sockaddr_i=
n6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* in multipeer mode control channel packet=
s are prepended with remote peer&#39;s sockaddr */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    sock-&gt;sockflags |=3D SF_PREPEND_SA;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(han=
dle, OVPN_IOCTL_MP_START_VPN, &amp;in, sizeof(in), &amp;out, sizeof(out),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
    &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_MP_START_VPN) failed&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (out.ListenAddress.Addr4.sin_family =3D=3D=
 AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;sock=
-&gt;info.lsa-&gt;actual.dest.addr.in4, &amp;out.ListenAddress.Addr4, sizeo=
f(struct sockaddr_in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;sock-&gt;info.l=
sa-&gt;actual.dest.addr.in6, &amp;out.ListenAddress.Addr6, sizeof(struct so=
ckaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_=
info *sig_info)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &q=
uot;%s&quot;, __func__);</span><br><span> </span><br><span>     OVPN_NEW_PE=
ER peer =3D { 0 };</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct addrinfo *remoteaddr =3D sock-&gt;info.lsa-&gt;=
current_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     struct sockaddr *local =3D NULL;</span><br><span>     str=
uct sockaddr *remote =3D remoteaddr-&gt;ai_addr;</span><br><span> </span><b=
r><span>@@ -228,9 +320,10 @@</span><br><span>         peer.Proto =3D OVPN_P=
ROTO_UDP;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (bind_local)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (sock-&gt;bind_local)</span><br><span> =
    {</span><br><span>         /* Use first local address with correct addr=
ess family */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct addrinfo *bind =3D sock-&gt;info.lsa-&gt;bind_local;</span><br><sp=
an>         while (bind &amp;&amp; !local)</span><br><span>         {</span=
><br><span>             if (bind-&gt;ai_family =3D=3D remote-&gt;sa_family)=
</span><br><span>@@ -241,7 +334,7 @@</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (bind_local &amp;&amp; !local)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (sock-&gt;bind_local &amp;&amp; !local)</s=
pan><br><span>     {</span><br><span>         msg(M_FATAL, &quot;DCO: Socke=
t bind failed: Address to bind lacks %s record&quot;,</span><br><span>     =
        addr_family_name(remote-&gt;sa_family));</span><br><span>@@ -290,17=
 +383,131 @@</span><br><span>         }</span><br><span>         else</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            dco_connect_wait(handle, &amp;ov, timeout, sig_info);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            dco_connect_wait(=
handle, &amp;ov, get_server_poll_remaining_time(sock-&gt;server_poll_timeou=
t), sig_info);</span><br><span>         }</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static struct sockaddr *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+dco_get_source_ip_for_dst(const struct sockaddr *dst)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SOCKADDR_INET dst_in =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Cast the destination address to SOCKADDR_IN=
ET */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dst-&g=
t;sa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  dst_in.Ipv4 =3D *((struct sockaddr_in *)dst);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        dst_in.si_family =3D AF_INET;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (dst-&gt;sa_family =3D=3D AF_=
INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dst_in.Ipv6 =3D *((=
struct sockaddr_in6 *)dst);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        dst_in.si_family =3D AF_INET6;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_FATAL, &quot;%s: unknown dst address family %d&quot;, __func__, dst-&gt;s=
a_family);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Get the best source address */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    MIB_IPFORWARD_ROW2 =
row;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SOCKADDR_IN=
ET best_src =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    DWORD ret =3D GetBestRoute2(NULL, 0, NULL, &amp;dst_in, 0, &amp;row,=
 &amp;best_src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (ret !=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_WARN, &quot;%s: GetBestRoute2() failed with error: %ld\n&quot;, __func_=
_, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Allocate and copy the best source =
address to return as sockaddr */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct sockaddr *src =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (best_src.si_family =3D=3D AF_INET6)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_in6 *src_in6 =
=3D (struct sockaddr_in6 *)malloc(sizeof(struct sockaddr_in6));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (src_in6 =3D=3D NULL=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &qu=
ot;%s: malloc failed&quot;, __func__);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        *src_in6 =3D best_src.Ipv6;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src =3D (struct sockaddr *)src_in6;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (best_src.si_family =3D=3D A=
F_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_in=
 *src_in =3D (struct sockaddr_in *)malloc(sizeof(struct sockaddr_in));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (src_in =3D=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FA=
TAL, &quot;%s: malloc failed&quot;, __func__);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *src_in =3D best_src.Ipv4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src =3D (struct sockaddr *)src_in=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: unknown src family %d&qu=
ot;, __func__, best_src.si_family);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return src;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> =
dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,</span><br><sp=
an>              struct sockaddr *localaddr, struct sockaddr *remoteaddr,</=
span><br><span>              struct in_addr *vpn_ipv4, struct in6_addr *vpn=
_ipv6)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: p=
eer-id %d, fd %d&quot;, __func__, peerid, sd);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (dco-&gt;mode =3D=3D dco_mode_p2p)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* no-op for p2p */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP=
_NEW_PEER newPeer =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (remo=
teaddr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr *l=
ocal =3D dco_get_source_ip_for_dst(remoteaddr);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (local)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (local-&gt;sa_family =3D=3D AF_INET)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                memcpy(&amp;newP=
eer.Local.Addr4, local, sizeof(struct sockaddr_in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                memcpy(&amp;newPeer.Local.Addr6, local, =
sizeof(struct sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            free(local);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (remotead=
dr-&gt;sa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            memcpy(&amp;newPeer.Remote.Addr4, remoteaddr, sizeof(struct =
sockaddr_in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;newPeer.=
Remote.Addr6, remoteaddr, sizeof(struct sockaddr_in6));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(vpn_ipv4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        newPeer.VpnAddr=
4 =3D *vpn_ipv4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_ipv6)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        newPeer.VpnAddr6 =3D *vpn_ipv6;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    newPeer.PeerId =3D peerid;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    DWORD bytesReturned;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_NEW_PEER=
, &amp;newPeer, sizeof(newPeer), NULL, 0, &amp;bytesReturned, NULL))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;DeviceIoControl=
(OVPN_IOCTL_MP_NEW_PEER) failed&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     return 0;</span><br><span> }</span><br><span> <=
/span><br><span>@@ -309,9 +516,20 @@</span><br><span> {</span><br><span>   =
  msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peerid);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP=
_DEL_PEER del_peer =3D { peerid };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    VOID *buf =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    DWORD len =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (dco-&gt;mode =3D=3D dco_mode_mp)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ioctl =3D OVPN_IOCTL_MP_DEL_PEER;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf =3D &amp;del=
_peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        len =
=3D sizeof(del_peer);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     DWORD bytes_returned =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_DE=
L_PEER, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                 0, NULL, 0, &amp;bytes_returned, NULL))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&g=
t;hand, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><br><sp=
an>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;DeviceIoCont=
rol(OVPN_IOCTL_DEL_PEER) failed&quot;);</span><br><span>         return -1;=
</span><br><span>@@ -326,19 +544,30 @@</span><br><span>     msg(D_DCO_DEBUG=
, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __func__,</span><br>=
<span>         peerid, keepalive_interval, keepalive_timeout, mss);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_SE=
T_PEER peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keepalive_timeout, =
mss };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_SET_=
PEER peer =3D { keepalive_interval, keepalive_timeout, mss };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    VOID *buf =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD ioctl =3D (dco-&gt=
;mode =3D=3D dco_mode_mp) ? OVPN_IOCTL_MP_SET_PEER : OVPN_IOCTL_SET_PEER;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
eer.KeepaliveInterval =3D  keepalive_interval;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    peer.KeepaliveTimeout =3D keepalive_timeout;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    peer.MSS =3D mss;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;mode =
=3D=3D dco_mode_mp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf =
=3D &amp;mp_peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      len =3D sizeof(OVPN_MP_SET_PEER);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf =3D &am=
p;peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        len =
=3D sizeof(OVPN_SET_PEER);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> </span><br><span>     DWORD bytes_returned =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!Device=
IoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SET_PEER, &amp;peer,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                         sizeof(pe=
er), NULL, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, ioctl, =
buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRN=
O, &quot;DeviceIoControl(OVPN_IOCTL_SET_PEER) failed&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quo=
t;DeviceIoControl(OVPN_IOCTL_MP_SET_PEER) failed&quot;);</span><br><span>  =
       return -1;</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</sp=
an><br><span> </span><br><span>@@ -397,9 +626,20 @@</span><br><span> {</spa=
n><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, pee=
r_id);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_MP_SWAP_KEYS swap =3D {peer_id};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    VOID *buf =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;mode =3D=3D dco_mode_mp)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ioctl =3D OVPN_IOCTL_MP_S=
WAP_KEYS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bu=
f =3D &amp;swap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     len =3D sizeof(swap);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     DWORD bytes_returned =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOC=
TL_SWAP_KEYS, NULL, 0, NULL, 0,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                         &amp;bytes_returned, NULL))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt=
;tt-&gt;hand, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><=
br><span>     {</span><br><span>         msg(M_ERR, &quot;DeviceIoControl(O=
VPN_IOCTL_SWAP_KEYS) failed&quot;);</span><br><span>         return -1;</sp=
an><br><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</sp=
an><br><span>index 7688516..7c09977 100644</span><br><span>--- a/src/openvp=
n/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ =
-31,19 +31,28 @@</span><br><span> typedef OVPN_KEY_SLOT dco_key_slot_t;</sp=
an><br><span> typedef OVPN_CIPHER_ALG dco_cipher_t;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    dco_mode_uninit,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dco_mode_p2p,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    dco_mode_mp</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+} dco_mode_type;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct dco_context {=
</span><br><span>     struct tuntap *tt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    dco_mode_type mode;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> };</span><br><span> </span><br><=
span> typedef struct dco_context dco_context_t;</span><br><span> </span><br=
><span> struct tuntap</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
create_dco_handle(const char *devname, struct gc_arena *gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+create_dco_handle(const char *devn=
ame, struct gc_arena *gc, int mode);</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_create_socket(HA=
NDLE handle, struct addrinfo *remoteaddr, bool bind_local,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                  struct addrinfo *bin=
d, int timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
            struct signal_info *sig_info);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+dco_mp_start_vpn(HANDLE handle, struct link_socket *=
sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_p2p_new_peer(HANDLE handle, struct link_soc=
ket *sock, struct signal_info *sig_info);</span><br><span> </span><br><span=
> void</span><br><span> dco_start_tun(struct tuntap *tt);</span><br><span>d=
iff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>i=
ndex f3f3503..90ec94c 100644</span><br><span>--- a/src/openvpn/forward.c</s=
pan><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1323,7 +1323,=
8 @@</span><br><span>     }</span><br><span>     else</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sockethandle=
_t sh =3D { .is_handle =3D true, .h =3D c-&gt;c1.tuntap-&gt;hand };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        bool prepend_sa =3D=
 c-&gt;options.mode =3D=3D MODE_SERVER &amp;&amp; dco_enabled(&amp;c-&gt;op=
tions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock=
ethandle_t sh =3D { .is_handle =3D true, .h =3D c-&gt;c1.tuntap-&gt;hand, .=
prepend_sa =3D prepend_sa };</span><br><span>         sockethandle_finalize=
(sh, &amp;c-&gt;c1.tuntap-&gt;reads, &amp;c-&gt;c2.buf, NULL);</span><br><s=
pan>     }</span><br><span> #else  /* ifdef _WIN32 */</span><br><span>diff =
--git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 9d104=
8c..e6ff2ba 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span=
>+++ b/src/openvpn/init.c</span><br><span>@@ -2005,7 +2005,7 @@</span><br><=
span> </span><br><span>         if (dco_enabled(&amp;c-&gt;options))</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ovpn_dco_init(c=
-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;options.dev_node);</span><br=
><span>         }</span><br><span> </span><br><span>         /* open the tu=
n device */</span><br><span>diff --git a/src/openvpn/ovpn_dco_win.h b/src/o=
penvpn/ovpn_dco_win.h</span><br><span>index ea2a733..8003ace 100644</span><=
br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b/src/openvpn=
/ovpn_dco_win.h</span><br><span>@@ -47,6 +47,23 @@</span><br><span> 	OVPN_P=
ROTO Proto;</span><br><span> } OVPN_NEW_PEER, * POVPN_NEW_PEER;</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struc=
t _OVPN_MP_NEW_PEER {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    union {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  SOCKADDR_IN Addr4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    } Local;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    union {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_IN Addr4=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_I=
N6 Addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } Remo=
te;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    IN_ADDR VpnAddr4;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    IN6_ADDR VpnAddr6;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+} OVPN_MP_NEW_PEER, * POVPN_MP_NEW_PEER;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef struct=
 _OVPN_STATS {</span><br><span> 	LONG LostInControlPackets;</span><br><span=
> 	LONG LostOutControlPackets;</span><br><span>@@ -94,10 +111,25 @@</span><=
br><span> 	int PeerId;</span><br><span> } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_=
DATA;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define CRYPTO_OPTIONS_AEAD_TAG_END (1&lt;&lt;1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CRYPTO_OPTIONS_64BIT_PKTID  (1&lt=
;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_CRYPTO_DAT=
A_V2 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CRYP=
TO_DATA V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UINT=
32 CryptoOptions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} =
OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+typedef struct _OVPN_MP_SET_PEER {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int PeerId;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    LONG KeepaliveInterval;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    LONG KeepaliveTimeout;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    LONG MSS;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+} OVPN_MP_SET_PEER, * POVPN_MP_SET_PEER;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef =
struct _OVPN_SET_PEER {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	LONG KeepaliveInterval;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	LONG KeepaliveTimeout;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	LONG MSS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  LONG KeepaliveInterval;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    LONG KeepaliveTimeout;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    LONG MSS;</span><br><span> } OVPN_SET_PEER, * POVPN_SET_PE=
ER;</span><br><span> </span><br><span> typedef struct _OVPN_VERSION {</span=
><br><span>@@ -106,6 +138,50 @@</span><br><span>     LONG Patch;</span><br>=
<span> } OVPN_VERSION, * POVPN_VERSION;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_P2P,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_MP</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+} OVPN_MODE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+typedef struct _OVPN_SET_MODE {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_MODE Mode;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+} OVPN_SET_MODE, * POVPN_SET_MODE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+typedef struct _OVPN_MP_START_VPN {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    union {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        SOCKADDR_IN Addr4;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        SOCKADDR_IN6 Addr6;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    } ListenAddress;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int IPv6Only;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_START_VPN, * POVPN_MP_START_=
VPN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_DEL_PEER,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_SWAP_KEYS</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+} OVPN_NOTIFY_CMD;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+typedef enum {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TEARDOWN,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_USERSPACE,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_=
EXPIRED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DE=
L_PEER_REASON_TRANSPORT_ERROR,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+} OVPN_DEL_PEER_REASON;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+typedef struct _OVPN_NOTIFY_EVENT {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_NOTIFY_CMD Cmd;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON DelPeerReas=
on;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_NOTIFY_EV=
ENT, * POVPN_NOTIFY_EVENT;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef stru=
ct _OVPN_MP_DEL_PEER {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int PeerId;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
 OVPN_MP_DEL_PEER, * POVPN_MP_DEL_PEER;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+typedef struct _OVPN_MP_SWAP_KEYS {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int PeerId;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+} OVPN_MP_SWAP_KEYS, * POVPN_MP_SWAP_KEYS;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define OVPN_IOCTL_NE=
W_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCES=
S)</span><br><span> #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UN=
KNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_I=
OCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_AN=
Y_ACCESS)</span><br><span>@@ -114,3 +190,14 @@</span><br><span> #define OVP=
N_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE=
_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE=
_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> #def=
ine OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERE=
D, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BUF=
FERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OVPN_IOCTL_SET_MODE     CTL_CODE(FILE_DEVICE_UNKNOWN, 10, METHO=
D_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OV=
PN_IOCTL_MP_START_VPN   CTL_CODE(FILE_DEVICE_UNKNOWN, 11, METHOD_BUFFERED, =
FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine OVPN_IOCTL_MP_NEW_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 12, METHOD_BUF=
FERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OVPN_IOCTL_MP_SET_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 13, MET=
HOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
OVPN_IOCTL_NOTIFY_EVENT   CTL_CODE(FILE_DEVICE_UNKNOWN, 14, METHOD_BUFFERED=
, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_IOCTL_M=
P_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_BUFFERED, FILE_ANY_A=
CCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_=
IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE_DEVICE_UNKNOWN, 16, METHOD_BUFFERED, FIL=
E_ANY_ACCESS)</span><br><span>diff --git a/src/openvpn/socket.c b/src/openv=
pn/socket.c</span><br><span>index 7765372..fab5b4a 100644</span><br><span>-=
-- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span>=
<br><span>@@ -2173,7 +2173,7 @@</span><br><span>         struct tuntap *tt;=
</span><br><span>         ALLOC_OBJ(tt, struct tuntap);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *tt =3D create_=
dco_handle(c-&gt;options.dev_node, &amp;c-&gt;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *tt =3D create_dco_handle(c-&gt;opti=
ons.dev_node, &amp;c-&gt;gc, c-&gt;options.mode);</span><br><span> </span><=
br><span>         /* Ensure we can &quot;safely&quot; cast the handle to a =
socket */</span><br><span>         static_assert(sizeof(sock-&gt;sd) =3D=3D=
 sizeof(tt-&gt;hand), &quot;HANDLE and SOCKET size differs&quot;);</span><b=
r><span>@@ -2181,12 +2181,14 @@</span><br><span>         c-&gt;c1.tuntap =
=3D tt;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    dco_create_socket(c-&gt;c1.tuntap-&gt;hand,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
sock-&gt;info.lsa-&gt;current_remote,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                      sock-&gt;bind_local, sock-&gt;info.ls=
a-&gt;bind_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                  get_server_poll_remaining_time(sock-&gt;server_poll_timeo=
ut),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
     sig_info);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options.mod=
e =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_=
mp_start_vpn(c-&gt;c1.tuntap-&gt;hand, sock);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_p=
2p_new_peer(c-&gt;c1.tuntap-&gt;hand, sock, sig_info);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     sock-&gt;sock=
flags |=3D SF_DCO_WIN;</span><br><span> </span><br><span>     if (sig_info-=
&gt;signal_received)</span><br><span>@@ -2236,16 +2238,16 @@</span><br><spa=
n>     resolve_remote(sock, 2, &amp;remote_dynamic,  sig_info);</span><br><=
span> </span><br><span>     /* If a valid remote has been found, create the=
 socket with its addrinfo */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (sock-&gt;info.lsa-&gt;current_remote)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span> #if defined(_WIN32)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_enable=
d(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 create_socket_dco_win(c, sock, sig_info);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            goto done;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        create_socket_dco_win(c, sock, sig_info);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (sock-&gt;info.lsa-&gt;current_remote)</=
span><br><span>         {</span><br><span>             create_socket(sock, =
sock-&gt;info.lsa-&gt;current_remote);</span><br><span>         }</span><br=
><span>@@ -3778,6 +3780,91 @@</span><br><span>     return sock-&gt;writes.i=
ostate;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+read_sockaddr_from_overlapped(struct overlapped_io *io, struct so=
ckaddr *dst, int overlapped_ret)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (overlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* TODO(jjo): streamline this mess */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* in this func=
 we don&#39;t have relevant info about the PF_ of this</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * endpoint, as link_socket_actu=
al will be zero for the 1st received packet</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * Test for inets PF_ possible sizes</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        switch (io-&gt;addrlen)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            case sizeof(struct sockaddr=
_in):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ca=
se sizeof(struct sockaddr_in6):</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /* TODO(jjo): for some reason (?) I&#39;m getting 2=
4,28 for AF_INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
           * under _WIN32*/</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            case sizeof(struct sockaddr_in6) - 4:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            default:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                bad_address_length(io-&gt;addrlen, a=
f_addr_size(io-&gt;addr.sin_family));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        swi=
tch (io-&gt;addr.sin_family)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           case AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                memcpy(dst, &amp;io-&gt;addr, sizeof(struct sockaddr_i=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            case AF_INET6:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                memcpy(d=
st, &amp;io-&gt;addr6, sizeof(struct sockaddr_in6));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEA=
R(*dst);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @brief Extracts a sockaddr from a packet payload.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Reads a sockaddr structure from the start of the packet=
 buffer and writes it to `dst`.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram[in] buf Packet buffer containing the payload.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param[out] dst Destination buffer for th=
e extracted sockaddr.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return Length of the extracted sockaddr</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+read_sockaddr_from_packet(struct buffer *buf, struct sockaddr *dst)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int sa_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct sockaddr *sa =3D (const struct sockaddr *)B=
PTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch=
 (sa-&gt;sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case A=
F_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (buf_len(buf) &lt; sizeof(struct sockaddr_in))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                msg(M_FATAL, &quot;ERROR: received =
incoming packet with too short length of %d -- must be at least %zu.&quot;,=
 buf_len(buf), sizeof(struct sockaddr_in));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            memcpy(dst, sa, sizeof(struct sockaddr_in));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_adva=
nce(buf, sizeof(struct sockaddr_in));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            sa_len =3D sizeof(struct sockaddr_in);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(buf) &lt; sizeof(=
struct sockaddr_in6))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            msg(M_FATAL, &quot;ERROR: received incoming packet with too sho=
rt length of %d -- must be at least %zu.&quot;, buf_len(buf), sizeof(struct=
 sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   memcpy(dst, sa, sizeof(struct sockaddr_in6));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            buf_advance(buf, sizeof(struct soc=
kaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     sa_len =3D sizeof(struct sockaddr_in6);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_FATAL, &quot;ERROR: received incoming packet with inval=
id address family %d.&quot;, sa-&gt;sa_family);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn sa_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Ret=
urns the number of bytes successfully read */</span><br><span> int</span><b=
r><span> sockethandle_finalize(sockethandle_t sh,</span><br><span>@@ -3851,=
45 +3938,14 @@</span><br><span>             ASSERT(0);</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* return from address if requested */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (from &amp;&amp; ret &gt; 0 &amp;&amp; sh.is_h=
andle &amp;&amp; sh.prepend_sa)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ret -=3D read_sockaddr_from_packet(buf, &amp;from-&gt;dest.addr.sa);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!sh.is_h=
andle &amp;&amp; from)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (ret &gt;=3D 0 &amp;&amp; io-&gt;addr_de=
fined)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* TODO(jjo): s=
treamline this mess */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            /* in this func we don&#39;t have relevant info about the PF_ =
of this</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *=
 endpoint, as link_socket_actual will be zero for the 1st received packet</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-             * Test for inets =
PF_ possible sizes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   switch (io-&gt;addrlen)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             case sizeof(struct sockaddr_in):</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                case sizeof(struct sockaddr_in6):</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* TODO=
(jjo): for some reason (?) I&#39;m getting 24,28 for AF_INET6</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                 * under _WIN32*/</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                case si=
zeof(struct sockaddr_in6)-4:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    break;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              bad_address_length(io-&gt;addrlen, af_addr_size(io-&gt;addr.s=
in_family));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            switch (io-&gt;addr.sin_fa=
mily)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                case AF_=
INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    from-&gt;dest.addr.in4 =3D io-&gt;addr;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    break;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                case AF_INET6:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    from-&gt;dest.addr.in6 =3D io-&gt;addr6;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    b=
reak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            CLEAR(from-&gt;dest.addr);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        read_sockaddr_from_overlapped(io, &amp;f=
rom-&gt;dest.addr.sa, ret);</span><br><span>     }</span><br><span> </span>=
<br><span>     if (buf)</span><br><span>diff --git a/src/openvpn/socket.h b=
/src/openvpn/socket.h</span><br><span>index 16106d4..c370f2c 100644</span><=
br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socke=
t.h</span><br><span>@@ -224,6 +224,7 @@</span><br><span> #define SF_HOST_RA=
NDOMIZE (1&lt;&lt;3)</span><br><span> #define SF_GETADDRINFO_DGRAM (1&lt;&l=
t;4)</span><br><span> #define SF_DCO_WIN (1&lt;&lt;5)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SF_PREPEND_SA (1&lt;&lt;6)</span>=
<br><span>     unsigned int sockflags;</span><br><span>     int mark;</span=
><br><span>     const char *bind_dev;</span><br><span>@@ -287,6 +288,7 @@</=
span><br><span>         HANDLE h;</span><br><span>     };</span><br><span> =
    bool is_handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    bool prepend_sa; /* are incoming packets prepended with sockaddr? */</s=
pan><br><span> } sockethandle_t;</span><br><span> </span><br><span> int soc=
kethandle_finalize(sockethandle_t sh,</span><br><span>@@ -1046,6 +1048,7 @@=
</span><br><span>     {</span><br><span>         *from =3D sock-&gt;info.ls=
a-&gt;actual;</span><br><span>         sh.is_handle =3D true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        sh.prepend_sa =3D sock-&g=
t;sockflags &amp; SF_PREPEND_SA;</span><br><span>     }</span><br><span>   =
  return sockethandle_finalize(sh, &amp;sock-&gt;reads, buf, from);</span><=
br><span> }</span><br><span>@@ -1116,6 +1119,24 @@</span><br><span>        =
     err =3D SocketHandleGetLastError(sh);</span><br><span>         }</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* dco-win mp req=
uires control packets to be prepended with sockaddr */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;sockflags &amp; SF_PREP=
END_SA)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (to-&gt;dest.ad=
dr.sa.sa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            struct sockaddr_in sa;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            memcpy(&amp;sa, &amp;to-&gt;dest.addr.in4, siz=
eof(sa));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  buf_write_prepend(buf, &amp;sa, sizeof(sa));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            struct sockaddr_in6 sa;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            memcpy(&amp;sa, &amp;to-&gt;dest.addr.in6, size=
of(sa));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 buf_write_prepend(buf, &amp;sa, sizeof(sa));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     socket_send_queue(sock, buf, to);</span><br><span> =
    if (status &lt; 0)</span><br><span>     {</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?=
usp=3Demail">change 815</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6=
eb89021f32dba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 815 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ChjCGZCFN/A=--

