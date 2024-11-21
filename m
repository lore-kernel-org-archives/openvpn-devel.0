From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 21 Nov 2024 18:07:56 +0000
References: <gerrit.1732212459000.Ia267276d61fa1425ba205f54ba6eb89021f32dba@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f583237d796aba17bc8b54fda13fae847d2370d0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HZrnldAImlw="; charset=UTF-8
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

--HZrnldAImlw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail

to review the following change.


Change subject: dco-win: multipeer support
......................................................................

dco-win: multipeer support

This is the main commit for dco-win multipeer
implementation.

This adds concept of "mode" to DCO implementation,
which is peer-to-peer or multipeer. Depends on mode,
some functions use MP-specific IOCTL commands, which
include peer-id as a part of input.

The driver initialization accomodates server mode,
in which tun device is created before transport.

Since on Windows the socket is visible to the kernel only,
control channel packets have to be prepended with remote
sockaddr of the peer - this allows userspace to distinguish
among peers. Sadly there is no reliable way to get peer local
address, such as on Linux/FreeBSD, so we have to do a bit of
guesswork figure out IP address based on remote IP and local
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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/815/1

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
index 3bc123b..7be6fdb 100644
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
index a28436c..3e1c2f3 100644
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
index d50b24c..0a3936a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1315,7 +1315,8 @@
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
index 656fedf..b02e4f1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1987,7 +1987,7 @@
 #endif
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
index efd742c..6909e7a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2144,7 +2144,7 @@
         struct tuntap *tt;
         ALLOC_OBJ(tt, struct tuntap);

-        *tt =3D create_dco_handle(c->options.dev_node, &c->gc);
+        *tt =3D create_dco_handle(c->options.dev_node, &c->gc, c->options.=
mode);

         /* Ensure we can "safely" cast the handle to a socket */
         static_assert(sizeof(sock->sd) =3D=3D sizeof(tt->hand), "HANDLE an=
d SOCKET size differs");
@@ -2152,12 +2152,14 @@
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
@@ -2207,16 +2209,16 @@
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
@@ -3753,6 +3755,91 @@
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
+                memcpy(dst, &io->addr, sizeof(struct sockaddr_in));
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
@@ -3826,45 +3913,14 @@
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
index 465d92b..36c683c 100644
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
@@ -1042,6 +1044,7 @@
     {
         *from =3D sock->info.lsa->actual;
         sh.is_handle =3D true;
+        sh.prepend_sa =3D sock->sockflags & SF_PREPEND_SA;
     }
     return sockethandle_finalize(sh, &sock->reads, buf, from);
 }
@@ -1112,6 +1115,24 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--HZrnldAImlw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco-win: multipeer support<br><br>This is the main commit for=
 dco-win multipeer<br>implementation.<br><br>This adds concept of &quot;mod=
e&quot; to DCO implementation,<br>which is peer-to-peer or multipeer. Depen=
ds on mode,<br>some functions use MP-specific IOCTL commands, which<br>incl=
ude peer-id as a part of input.<br><br>The driver initialization accomodate=
s server mode,<br>in which tun device is created before transport.<br><br>S=
ince on Windows the socket is visible to the kernel only,<br>control channe=
l packets have to be prepended with remote<br>sockaddr of the peer - this a=
llows userspace to distinguish<br>among peers. Sadly there is no reliable w=
ay to get peer local<br>address, such as on Linux/FreeBSD, so we have to do=
 a bit of<br>guesswork figure out IP address based on remote IP and local<b=
r>routing table, which may backfire if there are multiple IPs<br>assigned t=
o the same network adapter. However, as for now<br>peer-specific local IP i=
s not used by the driver. We use<br>instead the result of bind() to the lis=
tening address.<br><br>Existing sockethandle_finalize() function has been r=
efactored<br>to accomodate packets with possibly prepended sockaddr.<br><br=
>Change-Id: Ia267276d61fa1425ba205f54ba6eb89021f32dba<br>Signed-off-by: Lev=
 Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/dco.h<br>M src/open=
vpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<b=
r>M src/openvpn/dco_win.h<br>M src/openvpn/forward.c<br>M src/openvpn/init.=
c<br>M src/openvpn/ovpn_dco_win.h<br>M src/openvpn/socket.c<br>M src/openvp=
n/socket.h<br>10 files changed, 518 insertions(+), 103 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/15/815/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><span>in=
dex 035474f..7f2021d 100644</span><br><span>--- a/src/openvpn/dco.h</span><=
br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -106,9 +106,10 @@</span=
><br><span>  *</span><br><span>  * @param mode      the instance operating =
mode (P2P or multi-peer)</span><br><span>  * @param dco       the context t=
o initialize</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am dev_node  device node, used on Windows to specify certain DCO adapter</s=
pan><br><span>  * @return          true on success, false otherwise</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ovp=
n_dco_init(int mode, dco_context_t *dco);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool ovpn_dco_init(int mode, dco_context_t *dco, cons=
t char *dev_node);</span><br><span> </span><br><span> /**</span><br><span> =
 * Open/create a DCO interface</span><br><span>@@ -284,7 +285,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> static inline bool</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_cont=
ext_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco=
_init(int mode, dco_context_t *dco, const char *dev_node)</span><br><span> =
{</span><br><span>     return true;</span><br><span> }</span><br><span>diff=
 --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><s=
pan>index f4c3b02..0e536de 100644</span><br><span>--- a/src/openvpn/dco_fre=
ebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -=
165,7 +165,7 @@</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode=
, dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ovpn_dco_init(int mode, dco_context_t *dco, const char *dev_node)</span><=
br><span> {</span><br><span>     if (open_fd(dco) &lt; 0)</span><br><span> =
    {</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dc=
o_linux.c</span><br><span>index b038382..0a38a0e 100644</span><br><span>---=
 a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</s=
pan><br><span>@@ -391,7 +391,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn=
_dco_init(int mode, dco_context_t *dco)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ovpn_dco_init(int mode, dco_context_t *dco, const char =
*dev_node)</span><br><span> {</span><br><span>     switch (mode)</span><br>=
<span>     {</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openv=
pn/dco_win.c</span><br><span>index 3bc123b..7be6fdb 100644</span><br><span>=
--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</sp=
an><br><span>@@ -28,6 +28,7 @@</span><br><span> #include &quot;syshead.h&qu=
ot;</span><br><span> </span><br><span> #include &quot;dco.h&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;forward.h&quot=
;</span><br><span> #include &quot;tun.h&quot;</span><br><span> #include &qu=
ot;crypto.h&quot;</span><br><span> #include &quot;ssl_common.h&quot;</span>=
<br><span>@@ -42,16 +43,37 @@</span><br><span> #endif</span><br><span> </sp=
an><br><span> struct tuntap</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-create_dco_handle(const char *devname, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+create_dco_handle(const char =
*devname, struct gc_arena *gc, int mode)</span><br><span> {</span><br><span=
>     struct tuntap tt =3D { .backend_driver =3D DRIVER_DCO };</span><br><s=
pan>     const char *device_guid;</span><br><span> </span><br><span>     tu=
n_open_device(&amp;tt, devname, &amp;device_guid, gc);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* for mp we set m=
ode in ovpn_dco_init(), however for p2p it is too late */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    tt.dco.mode =3D (mode =3D=3D MODE=
_SERVER) ? dco_mode_mp : dco_mode_p2p;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     return tt;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Som=
etimes IP Helper API, which we use for setting IP address etc,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * complains that interface is n=
ot found. Give it some time to settle</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_wa=
it_ready(DWORD idx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; 20; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MIB_IP=
INTERFACE_ROW row =3D { .InterfaceIndex =3D idx, .Family =3D AF_INET };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (GetIpInterf=
aceEntry(&amp;row) !=3D ERROR_NOT_FOUND)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_DCO_DEBUG, &quot;interface %ld not yet ready, retrying&quot;,=
 idx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Sleep=
(50);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Gets=
 version of dco-win driver</span><br><span>  *</span><br><span>@@ -104,8 +1=
26,32 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_dco_init(int mode, dco_c=
ontext_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_=
dco_init(int mode, dco_context_t *dco, const char *dev_node)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* for p2p =
dco-&gt;mode is already set */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    dco-&gt;mode =3D (mode =3D=3D MODE_POINT_TO_POINT) ? dco_mod=
e_p2p : dco_mode_mp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;mo=
de =3D=3D dco_mode_p2p)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* open DCO device */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *de=
vice_guid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tun_o=
pen_device(dco-&gt;tt, dev_node, &amp;device_guid, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* set mp mode */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_MODE m =3D OVPN_MODE_MP;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoContro=
l(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SET_MODE, &amp;m, sizeof(m), NULL, 0, &am=
p;bytes_returned, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_SET_MODE) failed&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    dco_wait_ready(dco-&gt;tt-&gt;adapter_index);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span>@@ -116,19 +162,1=
9 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-dco_wait_ready(DWORD idx)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_p2p_start_vpn(struct tuntap *tt)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for=
 (int i =3D 0; i &lt; 20; ++i)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    DWORD bytes_returned =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!DeviceIoControl(tt-&gt;hand, OVPN_IOCTL_STA=
RT_VPN, NULL, 0, NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MIB_IPINTERF=
ACE_ROW row =3D {.InterfaceIndex =3D idx, .Family =3D AF_INET};</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (GetIpInterfaceEntry(&=
amp;row) !=3D ERROR_NOT_FOUND)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_=
DEBUG, &quot;interface %ld not yet ready, retrying&quot;, idx);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        Sleep(50);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;DeviceIoC=
ontrol(OVPN_IOCTL_START_VPN) failed&quot;);</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Sometimes IP Helper API, which we use fo=
r setting IP address etc,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * complains that interface is not found. Give it some time to se=
ttle</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_wait_ready(tt-&gt;a=
dapter_index);</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span>@@ -141,17 +187,10 @@</span><br><span>      */</span><br><sp=
an>     tt-&gt;dco.tt =3D tt;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    DWORD bytes_returned =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(tt-&gt;hand, O=
VPN_IOCTL_START_VPN, NULL, 0, NULL, 0,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                         &amp;bytes_returned, NULL))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;dco.mode =
=3D=3D dco_mode_p2p)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_S=
TART_VPN) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        dco_p2p_start_vpn(tt);</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* Sometimes IP Helper API, which we use for setting IP=
 address etc,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * c=
omplains that interface is not found. Give it some time to settle</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dco_wait_ready(tt-&gt;adapter_index);</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span>@@ -207,14 +246,67 @@</span><br><span> }</span><br><span> </span><br>=
<span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_create=
_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                  struct add=
rinfo *bind, int timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                  struct signal_info *sig_info)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_mp_start_vpn(HANDLE handle, struct li=
nk_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, =
&quot;%s&quot;, __func__);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ai_f=
amily =3D sock-&gt;info.lsa-&gt;bind_local-&gt;ai_family;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *local =3D sock-&=
gt;info.lsa-&gt;bind_local;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct addrinfo *cur =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (cur =3D local; cur; cur =3D cur-&gt;ai_next)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (cur-&gt;ai_family =3D=3D ai_family)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!cur)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_FATAL, &quot;%s: Socket bind failed: Addr to bind has no %s reco=
rd&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  __func__, addr_family_name(ai_family));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MP=
_START_VPN in, out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    in.IPv6Only =3D sock-&gt;info.bind_ipv6_only ? 1 : 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (ai_family =3D=3D AF_INET)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;in.ListenAddress.=
Addr4, cur-&gt;ai_addr, sizeof(struct sockaddr_in));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   memcpy(&amp;in.ListenAddress.Addr6, cur-&gt;ai_addr, sizeof(struct socka=
ddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* in multipeer mode control channel =
packets are prepended with remote peer&#39;s sockaddr */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;sockflags |=3D SF_PREPEND=
_SA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes_returned =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoContr=
ol(handle, OVPN_IOCTL_MP_START_VPN, &amp;in, sizeof(in), &amp;out, sizeof(o=
ut),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
          &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_MP_START_VPN) faile=
d&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (out.ListenAddress.Addr4.sin_famil=
y =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&=
amp;sock-&gt;info.lsa-&gt;actual.dest.addr.in4, &amp;out.ListenAddress.Addr=
4, sizeof(struct sockaddr_in));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;sock-&g=
t;info.lsa-&gt;actual.dest.addr.in6, &amp;out.ListenAddress.Addr6, sizeof(s=
truct sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct=
 signal_info *sig_info)</span><br><span> {</span><br><span>     msg(D_DCO_D=
EBUG, &quot;%s&quot;, __func__);</span><br><span> </span><br><span>     OVP=
N_NEW_PEER peer =3D { 0 };</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct addrinfo *remoteaddr =3D sock-&gt;info.=
lsa-&gt;current_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     struct sockaddr *local =3D NULL;</span><br><span>=
     struct sockaddr *remote =3D remoteaddr-&gt;ai_addr;</span><br><span> <=
/span><br><span>@@ -228,9 +320,10 @@</span><br><span>         peer.Proto =
=3D OVPN_PROTO_UDP;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (bind_local)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;bind_local)</span><=
br><span>     {</span><br><span>         /* Use first local address with co=
rrect address family */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct addrinfo *bind =3D sock-&gt;info.lsa-&gt;bind_local;</sp=
an><br><span>         while (bind &amp;&amp; !local)</span><br><span>      =
   {</span><br><span>             if (bind-&gt;ai_family =3D=3D remote-&gt;=
sa_family)</span><br><span>@@ -241,7 +334,7 @@</span><br><span>         }</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (bind_local &amp;&amp; !local)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;bind_local &amp;&amp; =
!local)</span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;=
DCO: Socket bind failed: Address to bind lacks %s record&quot;,</span><br><=
span>             addr_family_name(remote-&gt;sa_family));</span><br><span>=
@@ -290,17 +383,131 @@</span><br><span>         }</span><br><span>         =
else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            dco_connect_wait(handle, &amp;ov, timeout, sig_info);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dco_con=
nect_wait(handle, &amp;ov, get_server_poll_remaining_time(sock-&gt;server_p=
oll_timeout), sig_info);</span><br><span>         }</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static struct sockaddr *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+dco_get_source_ip_for_dst(const struct sockaddr *dst)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    SOCKADDR_INET dst_in =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Cast the destination address to S=
OCKADDR_INET */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (dst-&gt;sa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        dst_in.Ipv4 =3D *((struct sockaddr_in *)dst);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        dst_in.si_family =3D AF_INET;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (dst-&gt;sa_family =
=3D=3D AF_INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dst_in.Ip=
v6 =3D *((struct sockaddr_in6 *)dst);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        dst_in.si_family =3D AF_INET6;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_FATAL, &quot;%s: unknown dst address family %d&quot;, __func__,=
 dst-&gt;sa_family);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Get the best source addre=
ss */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MIB_IPFORW=
ARD_ROW2 row;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SO=
CKADDR_INET best_src =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    DWORD ret =3D GetBestRoute2(NULL, 0, NULL, &amp;dst_in, 0, =
&amp;row, &amp;best_src);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (ret !=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_WARN, &quot;%s: GetBestRoute2() failed with error: %ld\n&quot;=
, __func__, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* Allocate and copy the best =
source address to return as sockaddr */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct sockaddr *src =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (best_src.si_family =3D=3D AF_INE=
T6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_in6 *s=
rc_in6 =3D (struct sockaddr_in6 *)malloc(sizeof(struct sockaddr_in6));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (src_in6 =3D=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FA=
TAL, &quot;%s: malloc failed&quot;, __func__);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *src_in6 =3D best_src.Ipv6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src =3D (struct sockaddr *)src_in=
6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (best_src.si_family=
 =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct so=
ckaddr_in *src_in =3D (struct sockaddr_in *)malloc(sizeof(struct sockaddr_i=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (src=
_in =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(M_FATAL, &quot;%s: malloc failed&quot;, __func__);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        *src_in =3D best_src.Ipv4;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src =3D (struct sockaddr *)s=
rc_in;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;%s: unknown src family %d=
&quot;, __func__, best_src.si_family);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return src=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><spa=
n> dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,</span><br>=
<span>              struct sockaddr *localaddr, struct sockaddr *remoteaddr=
,</span><br><span>              struct in_addr *vpn_ipv4, struct in6_addr *=
vpn_ipv6)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s=
: peer-id %d, fd %d&quot;, __func__, peerid, sd);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (dco-&gt;mode =3D=3D dco_mode_p2p)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* no-op for p2p */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_MP_NEW_PEER newPeer =3D {0};</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
remoteaddr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sockadd=
r *local =3D dco_get_source_ip_for_dst(remoteaddr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (local)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (local-&gt;sa_family =3D=3D AF_INET)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                memcpy(&a=
mp;newPeer.Local.Addr4, local, sizeof(struct sockaddr_in));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                memcpy(&amp;newPeer.Local.Addr6, l=
ocal, sizeof(struct sockaddr_in6));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            free(local);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (re=
moteaddr-&gt;sa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            memcpy(&amp;newPeer.Remote.Addr4, remoteaddr, sizeof(s=
truct sockaddr_in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;ne=
wPeer.Remote.Addr6, remoteaddr, sizeof(struct sockaddr_in6));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (vpn_ipv4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        newPeer=
.VpnAddr4 =3D *vpn_ipv4;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (vpn_ipv6)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        newPeer.VpnAddr6 =3D *vpn_ipv6;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    newPeer.PeerId =3D peerid;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    DWORD bytesReturned;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_=
NEW_PEER, &amp;newPeer, sizeof(newPeer), NULL, 0, &amp;bytesReturned, NULL)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;DeviceI=
oControl(OVPN_IOCTL_MP_NEW_PEER) failed&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     return 0;</span><br><span> }</span><br>=
<span> </span><br><span>@@ -309,9 +516,20 @@</span><br><span> {</span><br><=
span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peerid);</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 OVPN_MP_DEL_PEER del_peer =3D { peerid };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    VOID *buf =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    DWORD len =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_DEL_PEER;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (dco-&gt;mode =3D=3D dco_mode_mp)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ioctl =3D OVPN_IOCTL_MP_DEL_PE=
ER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf =3D =
&amp;del_peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   len =3D sizeof(del_peer);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     DWORD bytes_returned =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_I=
OCTL_DEL_PEER, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                        0, NULL, 0, &amp;bytes_returned, NULL))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&g=
t;tt-&gt;hand, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))</span>=
<br><span>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;Devic=
eIoControl(OVPN_IOCTL_DEL_PEER) failed&quot;);</span><br><span>         ret=
urn -1;</span><br><span>@@ -326,19 +544,30 @@</span><br><span>     msg(D_DC=
O_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __func__,</sp=
an><br><span>         peerid, keepalive_interval, keepalive_timeout, mss);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
OVPN_SET_PEER peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keepalive_ti=
meout, mss };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_SET_PEER peer =3D { keepalive_interval, keepalive_timeout, mss };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    VOID *buf =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD ioctl =3D (=
dco-&gt;mode =3D=3D dco_mode_mp) ? OVPN_IOCTL_MP_SET_PEER : OVPN_IOCTL_SET_=
PEER;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    peer.KeepaliveInterval =3D  keepalive_interval;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    peer.KeepaliveTimeout =3D keepalive_tim=
eout;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    peer.MSS =3D=
 mss;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&g=
t;mode =3D=3D dco_mode_mp)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 buf =3D &amp;mp_peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        len =3D sizeof(OVPN_MP_SET_PEER);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf =
=3D &amp;peer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   len =3D sizeof(OVPN_SET_PEER);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span> </span><br><span>     DWORD bytes_retu=
rned =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!D=
eviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_SET_PEER, &amp;peer,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                         size=
of(peer), NULL, 0, &amp;bytes_returned, NULL))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, io=
ctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M=
_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_SET_PEER) failed&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO,=
 &quot;DeviceIoControl(OVPN_IOCTL_MP_SET_PEER) failed&quot;);</span><br><sp=
an>         return -1;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     return 0;</span><br><span> =
}</span><br><span> </span><br><span>@@ -397,9 +626,20 @@</span><br><span> {=
</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__=
, peer_id);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_MP_SWAP_KEYS swap =3D {peer_id};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    VOID *buf =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (dco-&gt;mode =3D=3D dco_=
mode_mp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ioctl =3D OVPN_IO=
CTL_MP_SWAP_KEYS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      buf =3D &amp;swap;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        len =3D sizeof(swap);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     DWORD bytes_returned =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dco-&gt;tt-&gt;hand, =
OVPN_IOCTL_SWAP_KEYS, NULL, 0, NULL, 0,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                         &amp;bytes_returned, NULL))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!DeviceIoControl=
(dco-&gt;tt-&gt;hand, ioctl, buf, len, NULL, 0, &amp;bytes_returned, NULL))=
</span><br><span>     {</span><br><span>         msg(M_ERR, &quot;DeviceIoC=
ontrol(OVPN_IOCTL_SWAP_KEYS) failed&quot;);</span><br><span>         return=
 -1;</span><br><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_w=
in.h</span><br><span>index a28436c..3e1c2f3 100644</span><br><span>--- a/sr=
c/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><br><=
span>@@ -31,19 +31,28 @@</span><br><span> typedef OVPN_KEY_SLOT dco_key_slo=
t_t;</span><br><span> typedef OVPN_CIPHER_ALG dco_cipher_t;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_mode_uninit,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_mode_p2p,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_mode_mp</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+} dco_mode_type;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct dco_c=
ontext {</span><br><span>     struct tuntap *tt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    dco_mode_type mode;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> };</span><br><span> </s=
pan><br><span> typedef struct dco_context dco_context_t;</span><br><span> <=
/span><br><span> struct tuntap</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-create_dco_handle(const char *devname, struct gc_arena *gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+create_dco_handle(const c=
har *devname, struct gc_arena *gc, int mode);</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_create_=
socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                  struct addr=
info *bind, int timeout,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                  struct signal_info *sig_info);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_mp_start_vpn(HANDLE handle, struct li=
nk_socket *sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_p2p_new_peer(HANDLE handle, stru=
ct link_socket *sock, struct signal_info *sig_info);</span><br><span> </spa=
n><br><span> void</span><br><span> dco_start_tun(struct tuntap *tt);</span>=
<br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span>=
<br><span>index d50b24c..0a3936a 100644</span><br><span>--- a/src/openvpn/f=
orward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -13=
15,7 +1315,8 @@</span><br><span>     }</span><br><span>     else</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
ockethandle_t sh =3D { .is_handle =3D true, .h =3D c-&gt;c1.tuntap-&gt;hand=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool pre=
pend_sa =3D c-&gt;options.mode =3D=3D MODE_SERVER &amp;&amp; dco_enabled(&a=
mp;c-&gt;options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       sockethandle_t sh =3D { .is_handle =3D true, .h =3D c-&gt;c1.tuntap-=
&gt;hand, .prepend_sa =3D prepend_sa };</span><br><span>         sockethand=
le_finalize(sh, &amp;c-&gt;c1.tuntap-&gt;reads, &amp;c-&gt;c2.buf, NULL);</=
span><br><span>     }</span><br><span> #else  /* ifdef _WIN32 */</span><br>=
<span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>=
index 656fedf..b02e4f1 100644</span><br><span>--- a/src/openvpn/init.c</spa=
n><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -1987,7 +1987,7 @@<=
/span><br><span> #endif</span><br><span>         if (dco_enabled(&amp;c-&gt=
;options))</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-=
&gt;dco);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  ovpn_dco_init(c-&gt;mode, &amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;options.dev=
_node);</span><br><span>         }</span><br><span> </span><br><span>      =
   /* open the tun device */</span><br><span>diff --git a/src/openvpn/ovpn_=
dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><span>index ea2a733..8003a=
ce 100644</span><br><span>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>=
+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@@ -47,6 +47,23 @@</span><=
br><span> 	OVPN_PROTO Proto;</span><br><span> } OVPN_NEW_PEER, * POVPN_NEW_=
PEER;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+typedef struct _OVPN_MP_NEW_PEER {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    union {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        SOCKADDR_IN Addr4;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        SOCKADDR_IN6 Addr6;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    } Local;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    union {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
SOCKADDR_IN Addr4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       SOCKADDR_IN6 Addr6;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    } Remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    IN_ADDR VpnAdd=
r4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    IN6_ADDR Vpn=
Addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_NEW_PEER, * POVPN_MP_NEW_P=
EER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> typedef struct _OVPN_STATS {</span><br><span> 	LONG LostInControlPackets=
;</span><br><span> 	LONG LostOutControlPackets;</span><br><span>@@ -94,10 +=
111,25 @@</span><br><span> 	int PeerId;</span><br><span> } OVPN_CRYPTO_DATA=
, * POVPN_CRYPTO_DATA;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define CRYPTO_OPTIONS_AEAD_TAG_END (1&lt;&lt;1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPTO_OPTIONS_64=
BIT_PKTID  (1&lt;&lt;2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct =
_OVPN_CRYPTO_DATA_V2 {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_CRYPTO_DATA V1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    UINT32 CryptoOptions;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+typedef struct _OVPN_MP_SET_PEER {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    LONG KeepaliveInterval;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    LONG KeepaliveTimeout;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    LONG MSS;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_SET_PEER, * POVPN_MP_S=
ET_PEER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> typedef struct _OVPN_SET_PEER {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	LONG KeepaliveInterval;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	LONG KeepaliveTimeout;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	LONG MSS;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    LONG KeepaliveInterval;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    LONG KeepaliveTimeout;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    LONG MSS;</span><br><span> } OVPN_SET_PEER,=
 * POVPN_SET_PEER;</span><br><span> </span><br><span> typedef struct _OVPN_=
VERSION {</span><br><span>@@ -106,6 +138,50 @@</span><br><span>     LONG Pa=
tch;</span><br><span> } OVPN_VERSION, * POVPN_VERSION;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_P2P,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_MODE_MP</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MODE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+typedef struct _OVPN_SET_MODE {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_MODE Mode;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+} OVPN_SET_MODE, * POVPN_SET_MODE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+typedef struct _OVPN_MP_START_VPN {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    union {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_IN Addr4;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        SOCKADDR_IN6 Addr6;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    } ListenAddress;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int IPv6Only;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_MP_START_VPN, * POVP=
N_MP_START_VPN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_DEL_PEER,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_SWAP_KEYS</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_NOTIFY_CMD;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TEARDOWN,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_USERSP=
ACE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PE=
ER_REASON_EXPIRED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+} OVPN_DEL_PEER_REASON;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef struct _OVPN_NOTIFY_EVENT {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_NOTIFY_CMD Cmd;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int PeerId;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON=
 DelPeerReason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} OV=
PN_NOTIFY_EVENT, * POVPN_NOTIFY_EVENT;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
typedef struct _OVPN_MP_DEL_PEER {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int PeerId;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+} OVPN_MP_DEL_PEER, * POVPN_MP_DEL_PEER;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+typedef struct _OVPN_MP_SWAP_KEYS {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int PeerId;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+} OVPN_MP_SWAP_KEYS, * POVPN_MP_SWAP_KEYS;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define=
 OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, =
FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_GET_STATS    CTL_CODE(=
FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span> =
#define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUF=
FERED, FILE_ANY_ACCESS)</span><br><span>@@ -114,3 +190,14 @@</span><br><spa=
n> #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_=
BUFFERED, FILE_ANY_ACCESS)</span><br><span> #define OVPN_IOCTL_DEL_PEER    =
 CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><=
br><span> #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, =
METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN,=
 9, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define OVPN_IOCTL_SET_MODE     CTL_CODE(FILE_DEVICE_UNKN=
OWN, 10, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OVPN_IOCTL_MP_START_VPN   CTL_CODE(FILE_DEVICE_UNKNOWN, 11, MET=
HOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define OVPN_IOCTL_MP_NEW_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, =
12, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define OVPN_IOCTL_MP_SET_PEER    CTL_CODE(FILE_DEVICE_UN=
KNOWN, 13, METHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define OVPN_IOCTL_NOTIFY_EVENT   CTL_CODE(FILE_DEVICE_UNKNOWN, 14, M=
ETHOD_BUFFERED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e OVPN_IOCTL_MP_DEL_PEER    CTL_CODE(FILE_DEVICE_UNKNOWN, 15, METHOD_BUFFER=
ED, FILE_ANY_ACCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define OVPN_IOCTL_MP_SWAP_KEYS   CTL_CODE(FILE_DEVICE_UNKNOWN, 16, METHOD=
_BUFFERED, FILE_ANY_ACCESS)</span><br><span>diff --git a/src/openvpn/socket=
.c b/src/openvpn/socket.c</span><br><span>index efd742c..6909e7a 100644</sp=
an><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/s=
ocket.c</span><br><span>@@ -2144,7 +2144,7 @@</span><br><span>         stru=
ct tuntap *tt;</span><br><span>         ALLOC_OBJ(tt, struct tuntap);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *=
tt =3D create_dco_handle(c-&gt;options.dev_node, &amp;c-&gt;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        *tt =3D create_dco_han=
dle(c-&gt;options.dev_node, &amp;c-&gt;gc, c-&gt;options.mode);</span><br><=
span> </span><br><span>         /* Ensure we can &quot;safely&quot; cast th=
e handle to a socket */</span><br><span>         static_assert(sizeof(sock-=
&gt;sd) =3D=3D sizeof(tt-&gt;hand), &quot;HANDLE and SOCKET size differs&qu=
ot;);</span><br><span>@@ -2152,12 +2152,14 @@</span><br><span>         c-&g=
t;c1.tuntap =3D tt;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    dco_create_socket(c-&gt;c1.tunta=
p-&gt;hand,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
            sock-&gt;info.lsa-&gt;current_remote,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                      sock-&gt;bind_local, sock=
-&gt;info.lsa-&gt;bind_local,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                      get_server_poll_remaining_time(sock-&gt;serve=
r_poll_timeout),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                 sig_info);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt=
;options.mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        dco_mp_start_vpn(c-&gt;c1.tuntap-&gt;hand, sock);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       dco_p2p_new_peer(c-&gt;c1.tuntap-&gt;hand, sock, sig_info);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     s=
ock-&gt;sockflags |=3D SF_DCO_WIN;</span><br><span> </span><br><span>     i=
f (sig_info-&gt;signal_received)</span><br><span>@@ -2207,16 +2209,16 @@</s=
pan><br><span>     resolve_remote(sock, 2, &amp;remote_dynamic,  sig_info);=
</span><br><span> </span><br><span>     /* If a valid remote has been found=
, create the socket with its addrinfo */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (sock-&gt;info.lsa-&gt;current_remote)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span> #if defin=
ed(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            create_socket_dco_win(c, sock, sig_info);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            goto done;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (dco_enabled(&amp;c-&gt;options))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        create_socket_dco_win(c, sock, sig_info);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span> #endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (sock-&gt;info.lsa-&gt;curren=
t_remote)</span><br><span>         {</span><br><span>             create_so=
cket(sock, sock-&gt;info.lsa-&gt;current_remote);</span><br><span>         =
}</span><br><span>@@ -3753,6 +3755,91 @@</span><br><span>     return sock-&=
gt;writes.iostate;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+read_sockaddr_from_overlapped(struct overlapped_io *io=
, struct sockaddr *dst, int overlapped_ret)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (overlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* TODO(jjo): streamline this =
mess */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* i=
n this func we don&#39;t have relevant info about the PF_ of this</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * endpoint, as link_=
socket_actual will be zero for the 1st received packet</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         * Test for inets PF_ possible sizes</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        switch (io-&gt;addrlen)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            case sizeof(struct=
 sockaddr_in):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       case sizeof(struct sockaddr_in6):</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* TODO(jjo): for some reason (?) I&#39;m =
getting 24,28 for AF_INET6</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * under _WIN32*/</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            case sizeof(struct sockaddr_in6) - 4:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            default:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                bad_address_length(io-&gt=
;addrlen, af_addr_size(io-&gt;addr.sin_family));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        switch (io-&gt;addr.sin_family)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            case AF_INET:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                memcpy(dst, &amp;io-&gt;addr, sizeof(struct=
 sockaddr_in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            case AF_=
INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   memcpy(dst, &amp;io-&gt;addr, sizeof(struct sockaddr_in));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                break;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    CLEAR(*dst);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @brief Extracts a sockaddr from a packet payload.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Reads a sockaddr structure from the start of the pa=
cket buffer and writes it to `dst`.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param[in] buf Packet buffer containing the payload.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param[out] dst Destination buffer fo=
r the extracted sockaddr.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return Length of the extracted sockaddr</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+read_sockaddr_from_packet(struct buffer *buf, struct sockaddr *dst)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int sa_len =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct sockaddr *sa =3D (const struct sockaddr =
*)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swi=
tch (sa-&gt;sa_family)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e AF_INET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (buf_len(buf) &lt; sizeof(struct sockaddr_in))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(M_FATAL, &quot;ERROR: recei=
ved incoming packet with too short length of %d -- must be at least %zu.&qu=
ot;, buf_len(buf), sizeof(struct sockaddr_in));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            memcpy(dst, sa, sizeof(struct sockaddr_in=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_=
advance(buf, sizeof(struct sockaddr_in));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            sa_len =3D sizeof(struct sockaddr_in);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(buf) &lt; size=
of(struct sockaddr_in6))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               msg(M_FATAL, &quot;ERROR: received incoming packet with too =
short length of %d -- must be at least %zu.&quot;, buf_len(buf), sizeof(str=
uct sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      memcpy(dst, sa, sizeof(struct sockaddr_in6));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buf_advance(buf, sizeof(struc=
t sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          sa_len =3D sizeof(struct sockaddr_in6);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_FATAL, &quot;ERROR: received incoming packet with =
invalid address family %d.&quot;, sa-&gt;sa_family);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return sa_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/* Returns the number of bytes successfully read */</span><br><span> int</s=
pan><br><span> sockethandle_finalize(sockethandle_t sh,</span><br><span>@@ =
-3826,45 +3913,14 @@</span><br><span>             ASSERT(0);</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* return from address if requested */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (from &amp;&amp; ret &gt; 0 &amp;&amp; s=
h.is_handle &amp;&amp; sh.prepend_sa)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ret -=3D read_sockaddr_from_packet(buf, &amp;from-&gt;dest.addr=
.sa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!s=
h.is_handle &amp;&amp; from)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (ret &gt;=3D 0 &amp;&amp; io-&gt=
;addr_defined)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* TODO=
(jjo): streamline this mess */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            /* in this func we don&#39;t have relevant info about =
the PF_ of this</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
       * endpoint, as link_socket_actual will be zero for the 1st received =
packet</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * Test fo=
r inets PF_ possible sizes</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-             */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           switch (io-&gt;addrlen)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                case sizeof(struct sockaddr_in):</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                case sizeof(struct sockaddr=
_in6):</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 /* TODO(jjo): for some reason (?) I&#39;m getting 24,28 for AF_INET6</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                 * under _W=
IN32*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 case sizeof(struct sockaddr_in6)-4:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    break;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               default:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    bad_address_length(io-&gt;addrlen, af_addr_size(io-&g=
t;addr.sin_family));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            switch (io-&gt;add=
r.sin_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            from-&gt;dest.addr.in4 =3D io-&gt;addr;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                case AF_INET6:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    from-&gt;dest.addr.in6 =3D io-=
&gt;addr6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            CLEAR(from-&gt;dest.addr);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        read_sockaddr_from_overlapped(io=
, &amp;from-&gt;dest.addr.sa, ret);</span><br><span>     }</span><br><span>=
 </span><br><span>     if (buf)</span><br><span>diff --git a/src/openvpn/so=
cket.h b/src/openvpn/socket.h</span><br><span>index 465d92b..36c683c 100644=
</span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openv=
pn/socket.h</span><br><span>@@ -224,6 +224,7 @@</span><br><span> #define SF=
_HOST_RANDOMIZE (1&lt;&lt;3)</span><br><span> #define SF_GETADDRINFO_DGRAM =
(1&lt;&lt;4)</span><br><span> #define SF_DCO_WIN (1&lt;&lt;5)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define SF_PREPEND_SA (1&lt;&lt;6=
)</span><br><span>     unsigned int sockflags;</span><br><span>     int mar=
k;</span><br><span>     const char *bind_dev;</span><br><span>@@ -287,6 +28=
8,7 @@</span><br><span>         HANDLE h;</span><br><span>     };</span><br=
><span>     bool is_handle;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool prepend_sa; /* are incoming packets prepended with sockadd=
r? */</span><br><span> } sockethandle_t;</span><br><span> </span><br><span>=
 int sockethandle_finalize(sockethandle_t sh,</span><br><span>@@ -1042,6 +1=
044,7 @@</span><br><span>     {</span><br><span>         *from =3D sock-&gt=
;info.lsa-&gt;actual;</span><br><span>         sh.is_handle =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sh.prepend_sa =3D=
 sock-&gt;sockflags &amp; SF_PREPEND_SA;</span><br><span>     }</span><br><=
span>     return sockethandle_finalize(sh, &amp;sock-&gt;reads, buf, from);=
</span><br><span> }</span><br><span>@@ -1112,6 +1115,24 @@</span><br><span>=
             err =3D SocketHandleGetLastError(sh);</span><br><span>        =
 }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* dco-wi=
n mp requires control packets to be prepended with sockaddr */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;sockflags &amp;=
 SF_PREPEND_SA)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (to-&gt=
;dest.addr.sa.sa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            struct sockaddr_in sa;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            memcpy(&amp;sa, &amp;to-&gt;dest.addr.=
in4, sizeof(sa));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          buf_write_prepend(buf, &amp;sa, sizeof(sa));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            struct sockaddr_in6 sa;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            memcpy(&amp;sa, &amp;to-&gt;dest.addr.i=
n6, sizeof(sa));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         buf_write_prepend(buf, &amp;sa, sizeof(sa));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     socket_send_queue(sock, buf, to);</span><br=
><span>     if (status &lt; 0)</span><br><span>     {</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/815?usp=3Demail">change 815</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/815?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia267276d61fa1425ba205f54ba6=
eb89021f32dba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 815 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--HZrnldAImlw=--

