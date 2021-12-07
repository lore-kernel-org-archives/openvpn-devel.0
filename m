From: Antonio Quartulli <a@...2181...>
Date: Tue,  7 Dec 2021 13:11:35 +0100
Message-Id: <20211207121137.3221-7-a@...2181...>
In-Reply-To: <20211207121137.3221-1-a@...2181...>
References: <20211207121137.3221-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC 6/8] ovpn-dco-win: introduce windows
 data-channel offload support
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
Cc: Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>, Antonio Quartulli <a@...2181...>

From: Arne Schwabe <arne@...1227...>

Implement the data-channel offloading using the ovpn-dco-win kernel
module. See README.dco.md for more details.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 README.dco.md                       |   8 +
 config-msvc.h                       |  12 +-
 configure.ac                        |  82 +++++---
 src/openvpn/Makefile.am             |   1 +
 src/openvpn/dco.h                   |   1 +
 src/openvpn/init.c                  |  42 +++-
 src/openvpn/networking_windco.c     | 301 ++++++++++++++++++++++++++++
 src/openvpn/networking_windco.h     |  47 +++++
 src/openvpn/openvpn.vcxproj         |   2 +
 src/openvpn/openvpn.vcxproj.filters |   6 +
 src/openvpn/options.c               |  38 +++-
 src/openvpn/options.h               |  27 ++-
 src/openvpn/socket.c                | 125 +++++++++++-
 src/openvpn/socket.h                |  57 +++++-
 src/openvpn/tun.c                   |  44 +++-
 src/openvpn/tun.h                   |  58 ++++--
 16 files changed, 758 insertions(+), 93 deletions(-)
 create mode 100644 src/openvpn/networking_windco.c
 create mode 100644 src/openvpn/networking_windco.h

diff --git a/README.dco.md b/README.dco.md
index e2500d36..8ecda129 100644
--- a/README.dco.md
+++ b/README.dco.md
@@ -60,6 +60,12 @@ see a message like
 in your log.
 
 
+Getting started (Windows)
+-------------------------
+Getting started under windows is currently for brave people having experience
+with windows development. You need to compile openvpn yourself and also need 
+to get the test driver installed on your system.
+
 DCO and P2P mode
 ----------------
 DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
@@ -105,6 +111,8 @@ Limitations by design
 - topology subnet is the only supported `--topology` for servers
 - iroute directives install routes on the host operating system, see also
   routing with ovpn-dco
+- (ovpn-dco-win) client and p2p mode only
+- (ovpn-dco-win) only AES-GCM-128/192/256 cipher support
 
 Current limitations
 -------------------
diff --git a/config-msvc.h b/config-msvc.h
index 0ae38482..a1a1d555 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -6,10 +6,10 @@
 #define ENABLE_CRYPTO_OPENSSL 1
 #define ENABLE_FRAGMENT 1
 #define ENABLE_HTTP_PROXY 1
-#define ENABLE_LZO 1
+//#define ENABLE_LZO 1
 #define ENABLE_LZ4 1
 #define ENABLE_MANAGEMENT 1
-#define ENABLE_PKCS11 1
+//#define ENABLE_PKCS11 0
 #define ENABLE_PLUGIN 1
 #define ENABLE_PORT_SHARE 1
 #define ENABLE_SOCKS 1
@@ -30,8 +30,8 @@
 #define HAVE_IO_H 1
 #define HAVE_SYS_TYPES_H 1
 #define HAVE_SYS_STAT_H 1
-#define HAVE_LZO_LZO1X_H 1
-#define HAVE_LZO_LZOUTIL_H 1
+//#define HAVE_LZO_LZO1X_H 1
+//#define HAVE_LZO_LZOUTIL_H 1
 #define HAVE_VERSIONHELPERS_H 1
 
 #define HAVE_ACCESS 1
@@ -86,3 +86,7 @@ typedef uint16_t in_port_t;
 #ifdef HAVE_CONFIG_MSVC_LOCAL_H
 #include <config-msvc-local.h>
 #endif
+
+#define ENABLE_WINDCO 1
+#define ENABLE_DCO 1
+
diff --git a/configure.ac b/configure.ac
index 7d05d905..b6ecb23a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -784,41 +784,63 @@ dnl  version in this tree which will be used by default.  The
 dnl  git checkout inside the ovpn-dco/ directory is managed via git
 dnl  submodule.
 dnl
-AC_ARG_VAR([DCO_SOURCEDIR], [Alternative ovpn-dco kernel module source directory])
-if test -z "${DCO_SOURCEDIR}"; then
-    DCO_SOURCEDIR="${srcdir}/../ovpn-dco"
-fi
-AC_MSG_NOTICE([Using ovpn-dco source directory: ${DCO_SOURCEDIR}])
-AC_SUBST([DCO_SOURCEDIR])
+	AC_ARG_VAR([DCO_SOURCEDIR], [Alternative ovpn-dco kernel module source directory])
+	if test -z "${DCO_SOURCEDIR}"; then
+		case "$host" in
+			*-mingw*) DCO_SOURCEDIR="${srcdir}/../ovpn-dco-win";;
+			*) DCO_SOURCEDIR="${srcdir}/../ovpn-dco";;
+		esac
+	fi
+	AC_MSG_NOTICE([Using ovpn-dco source directory: ${DCO_SOURCEDIR}])
+	AC_SUBST([DCO_SOURCEDIR])
 
+	case "$host" in
+		*-*-linux*)
 dnl
 dnl Include generic netlink library used to talk to ovpn-dco
 dnl
-	saved_CFLAGS="${CFLAGS}"
-    PKG_CHECK_MODULES(
-        [LIBNL_GENL],
-        [libnl-genl-3.0 >= 3.2.29],
-        [have_libnl="yes"],
-        [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
-    )
-
-    DCO_CFLAGS="-I${DCO_SOURCEDIR}/include/uapi ${LIBNL_GENL_CFLAGS}"
-
-    CFLAGS="${CFLAGS} ${DCO_CFLAGS}"
-    AC_CHECK_HEADERS(
-        [linux/ovpn_dco.h],
-        ,
-        [AC_MSG_ERROR([linux/ovpn_dco.h is missing (use DCO_SOURCE to set path to it, CFLAGS=${CFLAGS})])]
-    )
-    CFLAGS=${saved_CFLAGS}
-    OPTIONAL_DCO_CFLAGS="${DCO_CFLAGS}"
-    OPTIONAL_DCO_LIBS="${LIBNL_GENL_LIBS}"
-
-    AC_DEFINE(ENABLE_LINUXDCO, 1, [Enable linux data channel offload])
-    AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
-fi
-AM_CONDITIONAL([ENABLE_OVPNDCO], [test "${enable_dco}" = "yes"])
+			saved_CFLAGS="${CFLAGS}"
+			PKG_CHECK_MODULES(
+				[LIBNL_GENL],
+				[libnl-genl-3.0 >= 3.2.29],
+				[have_libnl="yes"],
+				[AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
+			)
 
+			DCO_CFLAGS="-I${DCO_SOURCEDIR}/include/uapi ${LIBNL_GENL_CFLAGS}"
+
+			CFLAGS="${CFLAGS} ${DCO_CFLAGS}"
+			AC_CHECK_HEADERS(
+				[linux/ovpn_dco.h],
+				,
+				[AC_MSG_ERROR([linux/ovpn_dco.h is missing (use DCO_SOURCE to set path to it, CFLAGS=${CFLAGS})])]
+			)
+			CFLAGS=${saved_CFLAGS}
+
+			OPTIONAL_DCO_LIBS="${LIBNL_GENL_LIBS}"
+
+			AC_DEFINE(ENABLE_LINUXDCO, 1, [Enable linux data channel offload])
+		;;
+
+		*-mingw*)
+			DCO_CFLAGS="-I${DCO_SOURCEDIR}"
+
+			saved_CFLAGS="${CFLAGS}"
+			CFLAGS="${CFLAGS} ${DCO_CFLAGS}"
+			AC_CHECK_HEADERS(
+				[uapi/ovpn-dco.h],
+				,
+				[AC_MSG_ERROR([uapi/ovpn-dco.h is missing (use DCO_SOURCEDIR to set path to it, CFLAGS=${CFLAGS})])]
+			)
+			CFLAGS=${saved_CFLAGS}
+
+			AC_DEFINE(ENABLE_WINDCO, 1, [Enable shared data channel offload for Windows])
+		;;
+	esac
+
+	OPTIONAL_DCO_CFLAGS="${DCO_CFLAGS}"
+	AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
+fi
 
 if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 0cc06155..9645209b 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -88,6 +88,7 @@ openvpn_SOURCES = \
 	networking_iproute2.c networking_iproute2.h \
 	networking_sitnl.c networking_sitnl.h \
 	networking_linuxdco.c networking_linuxdco.h \
+	networking_windco.c networking_windco.h \
     networking.h \
 	ntlm.c ntlm.h \
 	occ.c occ.h \
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 1cfdc8fb..f0334536 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -41,6 +41,7 @@ static inline void open_tun_dco(struct tuntap *tt, const char* dev) { ASSERT(fal
 
 static inline void close_tun_dco(struct tuntap *tt) { ASSERT(false); }
 #else
+#include "networking_windco.h"
 #include "networking_linuxdco.h"
 #include "crypto.h"
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4668fd04..6632cb7f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1737,7 +1737,8 @@ do_init_tun(struct context *c)
                             c->c1.link_socket_addr.remote_list,
                             !c->options.ifconfig_nowarn,
                             c->c2.es,
-                            &c->net_ctx);
+                            &c->net_ctx,
+                            c->c1.tuntap);
 
 #ifdef _WIN32
     c->c1.tuntap->windows_driver = c->options.windows_driver;
@@ -1761,7 +1762,15 @@ do_open_tun(struct context *c)
     bool ret = false;
 
 #ifndef TARGET_ANDROID
-    if (!c->c1.tuntap)
+    if (!c->c1.tuntap
+#ifdef _WIN32
+        || (c->c1.tuntap
+#ifdef  ENABLE_WINDCO
+            && !c->c1.tuntap->dco.real_tun_init
+#endif
+            )
+#endif
+        )
     {
 #endif
 
@@ -1829,9 +1838,12 @@ do_open_tun(struct context *c)
     /* Store the old fd inside the fd so open_tun can use it */
     c->c1.tuntap->fd = oldtunfd;
 #endif
-    /* open the tun device */
-    open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-             c->c1.tuntap);
+    /* open the tun device. ovpn-dco-win already opend the device for the socket */
+    if (!is_windco(c->c1.tuntap))
+    {
+        open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
+            c->c1.tuntap);
+    }
 
     /* set the hardware address */
     if (c->options.lladdr)
@@ -3646,6 +3658,26 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 static void
 do_close_link_socket(struct context *c)
 {
+#ifdef _WIN32
+    if (c->c2.link_socket && c->c2.link_socket->info.dco_installed && is_windco(c->c1.tuntap))
+    {
+        ASSERT(c->c2.link_socket_owned);
+        ASSERT(c->c1.tuntap);
+
+        /* We rely on the tun close to the handle if also setup
+         * routes etc, since they cannot be delete when the interface
+         * handle has been closed */
+        if (true
+#ifdef ENABLE_WINDCO
+            && !c->c1.tuntap->dco.real_tun_init
+#endif
+            )
+        {
+            do_close_tun_simple(c);
+        }
+        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+    }
+#endif
     if (c->c2.link_socket && c->c2.link_socket_owned)
     {
         link_socket_close(c->c2.link_socket);
diff --git a/src/openvpn/networking_windco.c b/src/openvpn/networking_windco.c
new file mode 100644
index 00000000..3c88b752
--- /dev/null
+++ b/src/openvpn/networking_windco.c
@@ -0,0 +1,301 @@
+/*
+ *  Interface to ovpn-win-dco networking code
+ *
+ *  Copyright (C) 2020 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#if defined(ENABLE_WINDCO)
+#include "syshead.h"
+
+#include "networking_windco.h"
+#include "dco.h"
+#include "tun.h"
+#include "crypto.h"
+#include "ssl_common.h"
+
+
+#include <winsock2.h>
+#include <ws2tcpip.h>
+
+#if defined(__MINGW32__)
+const IN_ADDR in4addr_any = { 0 };
+#endif
+
+static struct tuntap create_dco_handle(const char* devname, struct gc_arena *gc)
+{
+    struct tuntap tt = { 0 };
+
+    tt.windows_driver = WINDOWS_DRIVER_WINDCO;
+
+    const char* device_guid;
+    tun_open_device(&tt, devname, &device_guid, gc);
+    tt.windows_driver = WINDOWS_DRIVER_WINDCO;
+
+    return tt;
+}
+
+void open_tun_dco(struct tuntap *tt, const char* dev)
+{
+    ASSERT(0);
+}
+
+void dco_start_tun(struct tuntap* tt)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
+        &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed with code %lu", GetLastError());
+    }
+}
+
+int dco_connect_wait(HANDLE handle, OVERLAPPED* ov, int timeout, volatile int* signal_received)
+{
+    while (timeout-- > 0)
+    {
+        DWORD transferred;
+        if (GetOverlappedResultEx(handle, ov, &transferred, 1000, FALSE) != 0)
+        {
+            /* TCP connection established by dco */
+            return 0;
+        }
+
+        DWORD err = GetLastError();
+        if (err != WAIT_TIMEOUT)
+        {
+            /* dco reported connection error */
+            struct gc_arena gc = gc_new();
+            msg(M_NONFATAL, "%s: %s", __func__, strerror_win32(err, &gc));
+            *signal_received = SIGUSR1;
+            gc_free(&gc);
+            return -1;
+        }
+
+        get_signal(signal_received);
+        if (*signal_received)
+        {
+            return -1;
+        }
+
+        management_sleep(0);
+    }
+
+    /* we end up here when timeout occurs in userspace */
+    msg(M_NONFATAL, "%s: dco connect timeout", __func__);
+    *signal_received = SIGUSR1;
+
+    return -1;
+}
+
+struct tuntap
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, const char* devname,
+                  struct gc_arena *gc, int timeout, volatile int* signal_received)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    OVPN_NEW_PEER peer = { 0 };
+
+    struct sockaddr *local = NULL;
+    struct sockaddr *remote = remoteaddr->ai_addr;
+
+    if (remoteaddr->ai_protocol == IPPROTO_TCP
+        || remoteaddr->ai_socktype == SOCK_STREAM)
+    {
+        peer.Proto = OVPN_PROTO_TCP;
+    }
+    else
+    {
+        peer.Proto = OVPN_PROTO_UDP;
+    }
+
+    if (bind_local)
+    {
+        /* Use first local address with correct address family */
+        while(bind && !local)
+        {
+            if (bind->ai_family == remote->sa_family)
+            {
+                local = bind->ai_addr;
+            }
+            bind = bind->ai_next;
+        }
+    }
+
+    if (bind_local && !local)
+    {
+        msg(M_FATAL, "DCO: Socket bind failed: Address to bind lacks %s record",
+           addr_family_name(remote->sa_family));
+    }
+
+    if (remote->sa_family == AF_INET6)
+    {
+        peer.Remote.Addr6 = *((SOCKADDR_IN6 *)(remoteaddr->ai_addr));
+        if (local)
+        {
+            peer.Local.Addr6 = *((SOCKADDR_IN6 *)local);
+        }
+        else
+        {
+            peer.Local.Addr6.sin6_addr = in6addr_any;
+            peer.Local.Addr6.sin6_port = 0;
+            peer.Local.Addr6.sin6_family = AF_INET6;
+        }
+    }
+    else if (remote->sa_family == AF_INET)
+    {
+        peer.Remote.Addr4 = *((SOCKADDR_IN *)(remoteaddr->ai_addr));
+        if (local)
+        {
+            peer.Local.Addr4 = *((SOCKADDR_IN *)local);
+        }
+        else
+        {
+            peer.Local.Addr4.sin_addr = in4addr_any;
+            peer.Local.Addr4.sin_port = 0;
+            peer.Local.Addr4.sin_family = AF_INET;
+        }
+    }
+    else
+    {
+        ASSERT(0);
+    }
+
+    struct tuntap tt = create_dco_handle(devname, gc);
+
+    OVERLAPPED ov = { 0 };
+    if (!DeviceIoControl(tt.hand, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, &ov))
+    {
+        DWORD err = GetLastError();
+        if (err != ERROR_IO_PENDING)
+        {
+            msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_PEER) failed with code %lu", err);
+        }
+        else
+        {
+            if (dco_connect_wait(tt.hand, &ov, timeout, signal_received))
+            {
+                close_tun_handle(&tt);
+            }
+        }
+    }
+    return tt;
+}
+
+int dco_new_peer(struct tuntap *tt, unsigned int peerid, int sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+    return 0;
+}
+
+int ovpn_set_peer(struct tuntap *tt, unsigned int peerid,
+                  unsigned int keepalive_interval,
+                  unsigned int keepalive_timeout)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d", __func__, peerid,
+        keepalive_interval, keepalive_timeout);
+
+    OVPN_SET_PEER peer;
+
+    peer.KeepaliveInterval =  keepalive_interval;
+    peer.KeepaliveTimeout = keepalive_timeout;
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_SET_PEER, &peer, sizeof(peer), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed with code %lu", GetLastError());
+        return -1;
+    }
+    return 0;
+}
+
+int
+dco_new_key(struct tuntap *tt, unsigned int peerid, ovpn_key_slot_t slot,
+            struct key_state *ks, const char* ciphername)
+{
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
+       __func__, slot, ks->key_id, peerid, ciphername);
+
+    struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+    dco_check_key_ctx(key);
+
+    const int nonce_len = 8;
+    size_t key_len = cipher_kt_key_size(cipher_kt_get(ciphername));
+
+    OVPN_CRYPTO_DATA crypto_data;
+    ZeroMemory(&crypto_data, sizeof(crypto_data));
+
+    crypto_data.CipherAlg = get_dco_cipher(ciphername);
+    crypto_data.KeyId = ks->key_id;
+    crypto_data.PeerId = peerid;
+    crypto_data.KeySlot = slot;
+
+    CopyMemory(crypto_data.Encrypt.Key, key->encrypt.aead_key, key_len);
+    crypto_data.Encrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data.Encrypt.NonceTail, key->encrypt.implicit_iv, nonce_len);
+
+    CopyMemory(crypto_data.Decrypt.Key, key->decrypt.aead_key, key_len);
+    crypto_data.Decrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data.Decrypt.NonceTail, key->decrypt.implicit_iv, nonce_len);
+
+    ASSERT(crypto_data.CipherAlg > 0);
+
+    DWORD bytes_returned = 0;
+
+    secure_memzero(key->encrypt.aead_key, sizeof (key->encrypt.aead_key));
+    secure_memzero(key->decrypt.aead_key, sizeof (key->decrypt.aead_key));
+
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data, sizeof(crypto_data), NULL, 0,
+                         &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed with code %lu", GetLastError());
+        return -1;
+    }
+    return 0;
+}
+int
+dco_del_key(struct tuntap *tt, unsigned int peerid, ovpn_key_slot_t slot)
+{
+    msg(D_DCO, "%s: peer-id %d, slot %d called but ignored", __func__, peerid, slot);
+    /* FIXME: Implement in driver first */
+    return 0;
+}
+
+int dco_swap_keys(struct tuntap *tt, unsigned int peer_id)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_SWAP_KEYS, NULL, 0, NULL, 0,
+                         &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed with code %lu", GetLastError());
+    }
+    return 0;
+}
+#endif
\ No newline at end of file
diff --git a/src/openvpn/networking_windco.h b/src/openvpn/networking_windco.h
new file mode 100644
index 00000000..e48aaa6c
--- /dev/null
+++ b/src/openvpn/networking_windco.h
@@ -0,0 +1,47 @@
+/*
+ *  Interface to ovpn-win-dco networking code
+ *
+ *  Copyright (C) 2020 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef OPENVPN_NETWORKING_WINDCO_H
+#define OPENVPN_NETWORKING_WINDCO_H
+#if defined(ENABLE_WINDCO)
+#include "uapi/ovpn-dco.h"
+#include "buffer.h"
+
+
+typedef OVPN_KEY_SLOT ovpn_key_slot_t;
+
+#define DCO_SUPPORTED_CIPHERS "AES-128-GCM:AES-256-GCM:AES-192-GCM"
+
+struct dco_context {
+    bool real_tun_init;
+};
+
+struct tuntap
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, const char* devname,
+                  struct gc_arena *gc, int timeout, volatile int* signal_received);
+
+void dco_start_tun(struct tuntap* tt);
+
+typedef struct dco_context dco_context_t;
+
+#endif
+#endif //OPENVPN_NETWORKING_WINDCO_H
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index b394cd4a..1258b633 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -279,6 +279,7 @@
     <ClCompile Include="mtu.c" />
     <ClCompile Include="mudp.c" />
     <ClCompile Include="multi.c" />
+    <ClCompile Include="networking_windco.c" />
     <ClCompile Include="ntlm.c" />
     <ClCompile Include="occ.c" />
     <ClCompile Include="openvpn.c" />
@@ -365,6 +366,7 @@
     <ClInclude Include="mtu.h" />
     <ClInclude Include="mudp.h" />
     <ClInclude Include="multi.h" />
+    <ClInclude Include="networking_windco.h" />
     <ClInclude Include="ntlm.h" />
     <ClInclude Include="occ.h" />
     <ClInclude Include="openvpn.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index abb591e4..402999b1 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -249,6 +249,9 @@
     <ClCompile Include="ssl_util.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="networking_windco.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -374,6 +377,9 @@
     <ClInclude Include="multi.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="networking_windco.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="ntlm.h">
       <Filter>Header Files</Filter>
     </ClInclude>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a3014415..70c5995e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2249,6 +2249,11 @@ options_postprocess_verify_ce(const struct options *options,
     {
         msg(M_USAGE, "--windows-driver wintun requires --dev tun");
     }
+
+    if (options->windows_driver == WINDOWS_DRIVER_WINDCO)
+    {
+        check_option_conflict_dco(M_USAGE, options);
+    }
 #endif /* ifdef _WIN32 */
 
     /*
@@ -3001,8 +3006,8 @@ options_postprocess_mutate_invariant(struct options *options)
 #ifdef _WIN32
     const int dev = dev_type_enum(options->dev, options->dev_type);
 
-    /* when using wintun, kernel doesn't send DHCP requests, so don't use it */
-    if (options->windows_driver == WINDOWS_DRIVER_WINTUN
+    /* when using wintun/ovpn-dco-win, kernel doesn't send DHCP requests, so don't use it */
+    if ((options->windows_driver == WINDOWS_DRIVER_WINTUN || options->windows_driver == WINDOWS_DRIVER_WINDCO)
         && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
     {
         options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
@@ -3088,7 +3093,7 @@ options_postprocess_setdefault_ncpciphers(struct options *o)
         /* custom --data-ciphers set, keep list */
         return;
     }
-    else if (cipher_kt_get("CHACHA20-POLY1305"))
+    else if (cipher_kt_get("CHACHA20-POLY1305") && !dco_win_enabled(o))
     {
         o->ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
     }
@@ -3260,6 +3265,22 @@ static bool check_option_conflict_dco_platform(int msglevel, const struct option
     }
     return false;
 }
+#elif defined(ENABLE_WINDCO)
+static bool check_option_conflict_dco_platform(int msglevel, const struct options *o)
+{
+    if (o->mode == MODE_SERVER)
+    {
+        msg(msglevel, "Only client and p2p data channel offload is supported "
+                      "with ovpn-dco-win.");
+        return true;
+    }
+    if (o->persist_tun)
+    {
+        msg(msglevel, "--persist-tun is not supported with ovpn-dco-win.");
+        return true;
+    }
+    return false;
+}
 #endif
 
 bool check_option_conflict_dco(int msglevel, const struct options *o)
@@ -4050,7 +4071,8 @@ options_string(const struct options *o,
                       NULL,
                       false,
                       NULL,
-                      ctx);
+                      ctx,
+                      NULL);
         if (tt)
         {
             tt_local = true;
@@ -4472,9 +4494,15 @@ parse_windows_driver(const char *str, const int msglevel)
     {
         return WINDOWS_DRIVER_WINTUN;
     }
+
+    else if (streq(str, "ovpn-dco-win"))
+    {
+        return WINDOWS_DRIVER_WINDCO;
+    }
     else
     {
-        msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
+        msg(msglevel, "--windows-driver must be tap-windows6, wintun "
+                      "or ovpn-dco-win");
         return WINDOWS_DRIVER_UNSPECIFIED;
     }
 }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 0affc71f..321a89a5 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -865,10 +865,30 @@ void options_string_import(struct options *options,
 /**
  * Returns whether the current configuration has dco enabled.
  */
-#ifdef ENABLE_LINUXDCO
+#if defined(ENABLE_LINUXDCO)
 static inline bool
 dco_enabled(struct options *o) { return !o->tuntap_options.disable_dco; }
 
+#elif defined(ENABLE_WINDCO)
+static inline bool dco_enabled(struct options *o)
+{
+    return o->windows_driver == WINDOWS_DRIVER_WINDCO;
+}
+#else
+/* Dummy functions to avoid ifdefs in the other code */
+static inline bool
+dco_enabled(struct options *o) { return false; }
+#endif
+
+#if defined(ENABLE_WINDCO)
+static inline bool
+dco_win_enabled(struct options *o) { return dco_enabled(o); }
+#else
+static inline bool
+dco_win_enabled(struct options *o) { return false; }
+#endif
+
+#if defined(ENABLE_DCO)
 /**
  * Checks whether the options struct has any option that is not supported by
  * our current dco implementation. If so it prints a warning at warning level
@@ -880,11 +900,6 @@ dco_enabled(struct options *o) { return !o->tuntap_options.disable_dco; }
 bool
 check_option_conflict_dco(int msglevel, const struct options *o);
 #else
-/* Dummy functions to avoid ifdefs in the other code */
-
-static inline bool
-dco_enabled(struct options *o) { return false; }
-
 static inline bool
 check_option_conflict_dco(int msglevel, struct options *o) { return false; }
 #endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 72062cd0..700fc2aa 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2141,6 +2141,38 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
     resolve_remote(sock, 1, NULL, &sig_info->signal_received);
 }
 
+#if defined(ENABLE_WINDCO)
+static void
+create_socket_windco(struct context* c, struct link_socket* sock, volatile int* signal_received)
+{
+    struct tuntap* tt;
+    /* In this case persist-tun is enabled, which we don't support yet */
+    ASSERT(!c->c1.tuntap);
+
+    ALLOC_OBJ(tt, struct tuntap);
+
+    *tt = dco_create_socket(sock->info.lsa->current_remote,
+        sock->bind_local,
+        sock->info.lsa->bind_local,
+        c->options.dev_node,
+        &c->gc,
+        get_server_poll_remaining_time(sock->server_poll_timeout),
+        signal_received);
+    if (*signal_received)
+    {
+        goto done;
+    }
+    c->c1.tuntap = tt;
+    sock->info.dco_installed = true;
+
+    /* Ensure we can "safely" cast the handle to a socket */
+    static_assert(sizeof(sock->sd) == sizeof(tt->hand), "HANDLE and SOCKET size differs");
+    sock->sd = (SOCKET)tt->hand;
+done:
+    ;
+}
+#endif
+
 /* finalize socket initialization */
 void
 link_socket_init_phase2(struct context *c)
@@ -2180,7 +2212,24 @@ link_socket_init_phase2(struct context *c)
     /* If a valid remote has been found, create the socket with its addrinfo */
     if (sock->info.lsa->current_remote)
     {
-        create_socket(sock, sock->info.lsa->current_remote);
+#if defined(ENABLE_WINDCO)
+        if (dco_win_enabled(&c->options))
+        {
+            create_socket_windco(c, sock, &sig_info->signal_received);
+            if (sig_info->signal_received)
+            {
+                goto done;
+            }
+
+            linksock_print_addr(sock);
+            goto done;
+        }
+        else
+#endif
+        {
+            create_socket(sock, sock->info.lsa->current_remote);
+        }
+
     }
 
     /* If socket has not already been created create it now */
@@ -2243,6 +2292,7 @@ link_socket_init_phase2(struct context *c)
     }
 
     phase2_set_socket_flags(sock);
+
     linksock_print_addr(sock);
 
 done:
@@ -3199,7 +3249,14 @@ link_socket_read_tcp(struct link_socket *sock,
     if (!sock->stream_buf.residual_fully_formed)
     {
 #ifdef _WIN32
-        len = socket_finalize(sock->sd, &sock->reads, buf, NULL);
+        if (sock->info.dco_installed)
+        {
+            len = tun_finalize((HANDLE)sock->sd, &sock->reads, buf);
+        }
+        else
+        {
+            len = socket_finalize(sock->sd, &sock->reads, buf, NULL);
+        }
 #else
         struct buffer frag;
         stream_buf_get_next(&sock->stream_buf, &frag);
@@ -3355,7 +3412,14 @@ link_socket_write_tcp(struct link_socket *sock,
     len = htonps(len);
     ASSERT(buf_write_prepend(buf, &len, sizeof(len)));
 #ifdef _WIN32
-    return link_socket_write_win32(sock, buf, to);
+    if (sock->info.dco_installed)
+    {
+        return link_socket_write_win32_dco(sock, buf, to);
+    }
+    else
+    {
+        return link_socket_write_win32(sock, buf, to);
+    }
 #else
     return link_socket_write_tcp_posix(sock, buf, to);
 #endif
@@ -3478,8 +3542,20 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         /* the overlapped read will signal this event on I/O completion */
         ASSERT(ResetEvent(sock->reads.overlapped.hEvent));
         sock->reads.flags = 0;
-
-        if (proto_is_udp(sock->info.proto))
+        
+        if (sock->info.dco_installed)
+        {
+            status = ReadFile(
+                    (HANDLE) sock->sd,
+                wsabuf[0].buf,
+                wsabuf[0].len,
+                &sock->reads.size,
+                &sock->reads.overlapped
+            );
+            /* Readfile status is inverted from WSARecv */
+            status = !status;
+        }
+        else if (proto_is_udp(sock->info.proto))
         {
             sock->reads.addr_defined = true;
             sock->reads.addrlen = sizeof(sock->reads.addr6);
@@ -3532,7 +3608,14 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         }
         else
         {
-            status = WSAGetLastError();
+            if (sock->info.dco_installed)
+            {
+                status = GetLastError();
+            }
+            else
+            {
+                status = WSAGetLastError();
+            }
             if (status == WSA_IO_PENDING) /* operation queued? */
             {
                 sock->reads.iostate = IOSTATE_QUEUED;
@@ -3577,7 +3660,21 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         ASSERT(ResetEvent(sock->writes.overlapped.hEvent));
         sock->writes.flags = 0;
 
-        if (proto_is_udp(sock->info.proto))
+        if (sock->info.dco_installed)
+        {
+            status = WriteFile(
+                    (HANDLE)sock->sd,
+                    wsabuf[0].buf,
+                    wsabuf[0].len,
+                    &sock->writes.size,
+                    &sock->writes.overlapped
+            );
+
+            /* WriteFile status is inverted from WSASendTo */
+            status = !status;
+
+        }
+        else if (proto_is_udp(sock->info.proto))
         {
             /* set destination address for UDP writes */
             sock->writes.addr_defined = true;
@@ -3638,8 +3735,17 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         }
         else
         {
-            status = WSAGetLastError();
-            if (status == WSA_IO_PENDING) /* operation queued? */
+            if (sock->info.dco_installed)
+            {
+                status = GetLastError();
+            }
+            else
+            {
+                status = WSAGetLastError();
+            }
+
+            /* both status code have the identical value */
+            if (status == WSA_IO_PENDING || status == ERROR_IO_PENDING) /* operation queued? */
             {
                 sock->writes.iostate = IOSTATE_QUEUED;
                 sock->writes.status = status;
@@ -3664,6 +3770,7 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
     return sock->writes.iostate;
 }
 
+/* Returns the nubmer of bytes successfully read */
 int
 socket_finalize(SOCKET s,
                 struct overlapped_io *io,
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 57142f4e..f9f5faf4 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -34,6 +34,7 @@
 #include "proxy.h"
 #include "socks.h"
 #include "misc.h"
+#include "tun.h"
 
 /*
  * OpenVPN's default port number as assigned by IANA.
@@ -1021,7 +1022,17 @@ link_socket_read_udp_win32(struct link_socket *sock,
                            struct buffer *buf,
                            struct link_socket_actual *from)
 {
-    return socket_finalize(sock->sd, &sock->reads, buf, from);
+    if (sock->info.dco_installed)
+    {
+        /* from address was set on socket creation and the kernel
+         * checks that it matches for us */
+        addr_copy_sa(&from->dest, &sock->info.lsa->actual.dest);
+        return tun_finalize((HANDLE)sock->sd, &sock->reads, buf);
+    }
+    else
+    {
+        return socket_finalize(sock->sd, &sock->reads, buf, from);
+    }
 }
 
 #else  /* ifdef _WIN32 */
@@ -1038,7 +1049,10 @@ link_socket_read(struct link_socket *sock,
                  struct buffer *buf,
                  struct link_socket_actual *from)
 {
-    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
+    if (proto_is_udp(sock->info.proto) 
+        || sock->info.dco_installed) 
+        /* unified UDPv4 and UDPv6, for DCO the kernel
+         * will strip the length header */
     {
         int res;
 
@@ -1082,10 +1096,6 @@ link_socket_write_win32(struct link_socket *sock,
     if (overlapped_io_active(&sock->writes))
     {
         status = socket_finalize(sock->sd, &sock->writes, NULL, NULL);
-        if (status < 0)
-        {
-            err = WSAGetLastError();
-        }
     }
     socket_send_queue(sock, buf, to);
     if (status < 0)
@@ -1099,6 +1109,29 @@ link_socket_write_win32(struct link_socket *sock,
     }
 }
 
+static inline int
+link_socket_write_win32_dco(struct link_socket* sock,
+    struct buffer* buf,
+    struct link_socket_actual* to)
+{
+    int err = 0;
+    int status = 0;
+    if (overlapped_io_active(&sock->writes))
+    {
+        status = tun_finalize((HANDLE)sock->sd, &sock->writes, NULL);
+    }
+    socket_send_queue(sock, buf, to);
+    if (status < 0)
+    {
+        SetLastError(err);
+        return status;
+    }
+    else
+    {
+        return BLEN(buf);
+    }
+}
+
 #else  /* ifdef _WIN32 */
 
 size_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
@@ -1140,7 +1173,14 @@ link_socket_write_udp(struct link_socket *sock,
                       struct link_socket_actual *to)
 {
 #ifdef _WIN32
-    return link_socket_write_win32(sock, buf, to);
+    if (sock->info.dco_installed)
+    {
+        return link_socket_write_win32_dco(sock, buf, to);
+    }
+    else
+    {
+        return link_socket_write_win32(sock, buf, to);
+    }
 #else
     return link_socket_write_udp_posix(sock, buf, to);
 #endif
@@ -1152,8 +1192,9 @@ link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
 {
-    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
+    if (proto_is_udp(sock->info.proto) || sock->info.dco_installed) 
     {
+        /* unified UDPv4 and UDPv6 and DCO (kernel adds size header) */
         return link_socket_write_udp(sock, buf, to);
     }
     else if (proto_is_tcp(sock->info.proto)) /* unified TCPv4 and TCPv6 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d8634ebf..459b20f8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -742,13 +742,23 @@ init_tun(const char *dev,        /* --dev option */
          struct addrinfo *remote_public,
          const bool strict_warn,
          struct env_set *es,
-         openvpn_net_ctx_t *ctx)
+         openvpn_net_ctx_t *ctx,
+         struct tuntap *tt)
 {
     struct gc_arena gc = gc_new();
-    struct tuntap *tt;
 
-    ALLOC_OBJ(tt, struct tuntap);
-    clear_tuntap(tt);
+    if (!tt)
+    {
+        ALLOC_OBJ(tt, struct tuntap);
+        clear_tuntap(tt);
+    }
+#ifdef ENABLE_WINDCO
+    else
+    {
+        ASSERT(!tt->dco.real_tun_init);
+        tt->dco.real_tun_init = true;
+    }
+#endif
 
     tt->type = dev_type_enum(dev, dev_type);
     tt->topology = topology;
@@ -891,6 +901,13 @@ init_tun_post(struct tuntap *tt,
 {
     tt->options = *options;
 #ifdef _WIN32
+#ifdef ENABLED_WINDCO
+    if (tt->windows_driver == WINDOWS_DRIVER_WINDCO)
+    {
+        dco_start_tun(tt);
+        return;
+    }
+#endif
     overlapped_io_init(&tt->reads, frame, FALSE, true);
     overlapped_io_init(&tt->writes, frame, TRUE, true);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
@@ -3438,6 +3455,9 @@ print_windows_driver(enum windows_driver_type windows_driver)
 
         case WINDOWS_DRIVER_WINTUN:
             return "wintun";
+    
+        case WINDOWS_DRIVER_WINDCO:
+            return "ovpn-dco-win";
 
         default:
             return "unspecified";
@@ -3878,6 +3898,11 @@ get_tap_reg(struct gc_arena *gc)
                     {
                         windows_driver = WINDOWS_DRIVER_WINTUN;
                     }
+                    else if (strcasecmp(component_id, "ovpn-dco") == 0)
+                    {
+                        windows_driver = WINDOWS_DRIVER_WINDCO;
+                    }
+
 
                     if (windows_driver != WINDOWS_DRIVER_UNSPECIFIED)
                     {
@@ -4232,7 +4257,9 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
 {
     if (!tap_reg)
     {
-        msg(M_FATAL, "There are no TAP-Windows nor Wintun adapters on this system.  You should be able to create an adapter by using tapctl.exe utility.");
+        msg(M_FATAL, "There are no TAP-Windows, Wintun or ovpn-dco-win adapters "
+                     "on this system.  You should be able to create an adapter "
+                     "by using tapctl.exe utility.");
     }
 }
 
@@ -6433,7 +6460,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     const char *path = NULL;
     char tuntap_device_path[256];
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN || tt->windows_driver == WINDOWS_DRIVER_WINDCO)
     {
         const struct device_instance_id_interface *dev_if;
 
@@ -6453,7 +6480,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     }
     else
     {
-        /* Open TAP-Windows adapter */
+        /* Open TAP-Windows or dco-win adapter */
         openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
                          USERMODEDEVICEDIR,
                          device_guid,
@@ -6489,7 +6516,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     return true;
 }
 
-static void
+void
 tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid, struct gc_arena *gc)
 {
     const struct tap_reg *tap_reg = get_tap_reg(gc);
@@ -6780,7 +6807,6 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
     argv_free(&argv);
 }
 
-static
 void close_tun_handle(struct tuntap* tt)
 {
     const char* adaptertype = print_windows_driver(tt->windows_driver);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index d5beb11c..8d3bae47 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -40,7 +40,7 @@
 #include "misc.h"
 #include "networking.h"
 #include "ring_buffer.h"
-#include "networking_linuxdco.h"
+#include "dco.h"
 
 #ifdef _WIN32
 #define WINTUN_COMPONENT_ID "wintun"
@@ -48,7 +48,8 @@
 enum windows_driver_type {
     WINDOWS_DRIVER_UNSPECIFIED,
     WINDOWS_DRIVER_TAP_WINDOWS6,
-    WINDOWS_DRIVER_WINTUN
+    WINDOWS_DRIVER_WINTUN,
+    WINDOWS_DRIVER_WINDCO
 };
 #endif
 
@@ -64,6 +65,8 @@ struct tuntap_options {
     /* --ip-win32 options */
     bool ip_win32_defined;
 
+    bool disable_dco;
+
 #define IPW32_SET_MANUAL       0   /* "--ip-win32 manual" */
 #define IPW32_SET_NETSH        1   /* "--ip-win32 netsh" */
 #define IPW32_SET_IPAPI        2   /* "--ip-win32 ipapi" */
@@ -246,6 +249,10 @@ tuntap_ring_empty(struct tuntap *tt)
 {
     return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head == tt->wintun_send_ring->tail);
 }
+
+/* Low level function to open tun handle, used by DCO to create a handle for DCO*/
+void
+tun_open_device(struct tuntap* tt, const char* dev_node, const char** device_guid, struct gc_arena* gc);
 #endif
 
 /*
@@ -257,6 +264,8 @@ void open_tun(const char *dev, const char *dev_type, const char *dev_node,
 
 void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
+void close_tun_handle(struct tuntap* tt);
+
 int write_tun(struct tuntap *tt, uint8_t *buf, int len);
 
 int read_tun(struct tuntap *tt, uint8_t *buf, int len);
@@ -283,7 +292,8 @@ struct tuntap *init_tun(const char *dev,        /* --dev option */
                         struct addrinfo *remote_public,
                         const bool strict_warn,
                         struct env_set *es,
-                        openvpn_net_ctx_t *ctx);
+                        openvpn_net_ctx_t *ctx,
+                        struct tuntap *tt);
 
 void init_tun_post(struct tuntap *tt,
                    const struct frame *frame,
@@ -659,6 +669,11 @@ write_tun_buffered(struct tuntap *tt, struct buffer *buf)
     }
 }
 
+static inline bool is_windco(struct tuntap *tt)
+{
+    return tt->windows_driver == WINDOWS_DRIVER_WINDCO;
+}
+
 #else  /* ifdef _WIN32 */
 
 static inline bool
@@ -684,6 +699,12 @@ tun_standby(struct tuntap *tt)
     return true;
 }
 
+
+static inline bool is_windco(struct tuntap *tt)
+{
+    return false;
+}
+
 #endif /* ifdef _WIN32 */
 
 /*
@@ -707,25 +728,28 @@ tun_set(struct tuntap *tt,
         void *arg,
         unsigned int *persistent)
 {
-    if (tuntap_defined(tt))
+    if (!tuntap_defined(tt) || is_windco(tt))
     {
-        /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
-        if (!persistent || *persistent != rwflags)
+        return;
+    }
+
+    /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
+    if (!persistent || *persistent != rwflags)
+    {
+        event_ctl(es, tun_event_handle(tt), rwflags, arg);
+        if (persistent)
         {
-            event_ctl(es, tun_event_handle(tt), rwflags, arg);
-            if (persistent)
-            {
-                *persistent = rwflags;
-            }
+            *persistent = rwflags;
         }
+    }
 #ifdef _WIN32
-        if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
-        {
-            tun_read_queue(tt, 0);
-        }
-#endif
-        tt->rwflags_debug = rwflags;
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
+    {
+        tun_read_queue(tt, 0);
     }
+#endif
+    tt->rwflags_debug = rwflags;
+
 }
 
 const char *tun_stat(const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc);
-- 
2.32.0


