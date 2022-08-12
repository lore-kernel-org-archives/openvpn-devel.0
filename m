From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Aug 2022 15:06:49 +0200
Message-Id: <20220812130657.29899-3-a@...2181...>
In-Reply-To: <20220812130657.29899-1-a@...2181...>
References: <20220812130657.29899-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v100 02/10] dco-win: introduce low-level
 code for handling ovpn-dco-win in Windows
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 config-msvc.h                       |   2 +
 configure.ac                        |   9 +-
 dev-tools/special-files.lst         |   1 +
 src/openvpn/Makefile.am             |   4 +-
 src/openvpn/dco_internal.h          |   1 +
 src/openvpn/dco_win.c               | 397 ++++++++++++++++++++++++++++
 src/openvpn/dco_win.h               |  58 ++++
 src/openvpn/openvpn.vcxproj         |   3 +
 src/openvpn/openvpn.vcxproj.filters |   9 +
 src/openvpn/ovpn-dco-win.h          | 108 ++++++++
 src/openvpn/tun.h                   |   3 +-
 11 files changed, 590 insertions(+), 5 deletions(-)
 create mode 100644 src/openvpn/dco_win.c
 create mode 100644 src/openvpn/dco_win.h
 create mode 100644 src/openvpn/ovpn-dco-win.h

diff --git a/config-msvc.h b/config-msvc.h
index b08beb52..b621f3fb 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -87,3 +87,5 @@ typedef uint16_t in_port_t;
 #ifdef HAVE_CONFIG_MSVC_LOCAL_H
 #include <config-msvc-local.h>
 #endif
+
+#define ENABLE_DCO 1
diff --git a/configure.ac b/configure.ac
index 9466fe15..0de0fbbe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -144,7 +144,7 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[dco],
-	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using ovpn-dco kernel module @<:@default=no@:>@])],
+	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using the ovpn-dco kernel module (always enabled on Windows) @<:@default=no@:>@])],
 	,
 	[enable_dco="no"]
 )
@@ -328,6 +328,7 @@ case "$host" in
 		;;
 	*-mingw*)
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
+		AC_DEFINE([ENABLE_DCO], [1], [DCO is always enabled on Windows])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
 		CPPFLAGS="${CPPFLAGS} -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA"
@@ -772,7 +773,6 @@ if test "$enable_dco" = "yes"; then
 dnl
 dnl Include generic netlink library used to talk to ovpn-dco
 dnl
-
 	case "$host" in
 		*-*-linux*)
 			PKG_CHECK_MODULES([LIBNL_GENL],
@@ -787,8 +787,11 @@ dnl
 			AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
 			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
 			;;
+		*-mingw*)
+			AC_MSG_NOTICE([NOTE: --enable-dco ignored on Windows because it's always enabled])
+			;;
 		*)
-			AC_MSG_NOTICE([Ignoring --enable-dco on non Linux platform])
+			AC_MSG_NOTICE([Ignoring --enable-dco on non supported platform])
 			;;
 	esac
 fi
diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst
index 33e830d7..6d0bc055 100644
--- a/dev-tools/special-files.lst
+++ b/dev-tools/special-files.lst
@@ -2,3 +2,4 @@ E:doc/doxygen/doc_key_generation.h     # @verbatim section gets mistreated, excl
 E:src/compat/compat-lz4.c              # Preserve LZ4 upstream formatting
 E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
 E:src/openvpn/ovpn_dco_linux.h         # Preserve ovpn-dco upstream formatting
+E:src/openvpn/ovpn-dco-win.h           # Preserve ovpn-dco-win upstream formatting
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index aaa1dbce..8d0e66b4 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -55,6 +55,7 @@ openvpn_SOURCES = \
 	crypto_mbedtls.c crypto_mbedtls.h \
 	dco.c dco.h dco_internal.h \
 	dco_linux.c dco_linux.h \
+	dco_win.c dco_win.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
 	env_set.c env_set.h \
@@ -77,6 +78,7 @@ openvpn_SOURCES = \
 	mbuf.c mbuf.h \
 	memdbg.h \
 	misc.c misc.h \
+	ovpn-dco-win.h \
 	ovpn_dco_linux.h \
 	platform.c platform.h \
 	console.c console.h console_builtin.c console_systemd.c \
@@ -151,5 +153,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.h
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
 endif
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 3ceb26d6..968d4042 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -28,6 +28,7 @@
 #if defined(ENABLE_DCO)
 
 #include "dco_linux.h"
+#include "dco_win.h"
 
 /**
  * This file contains the internal DCO API definition.
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
new file mode 100644
index 00000000..f1160c7d
--- /dev/null
+++ b/src/openvpn/dco_win.c
@@ -0,0 +1,397 @@
+/*
+ *  Interface to ovpn-win-dco networking code
+ *
+ *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
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
+#if defined(_WIN32)
+
+#include "syshead.h"
+
+#include "dco.h"
+#include "tun.h"
+#include "crypto.h"
+#include "ssl_common.h"
+
+#include <bcrypt.h>
+#include <winsock2.h>
+#include <ws2tcpip.h>
+
+#if defined(__MINGW32__)
+const IN_ADDR in4addr_any = { 0 };
+#endif
+
+static struct tuntap
+create_dco_handle(const char *devname, struct gc_arena *gc)
+{
+    struct tuntap tt = { .windows_driver = WINDOWS_DRIVER_DCO };
+    const char *device_guid;
+
+    tun_open_device(&tt, devname, &device_guid, gc);
+
+    return tt;
+}
+
+bool
+ovpn_dco_init(int mode, dco_context_t *dco)
+{
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
+static void
+dco_wait_ready(DWORD idx)
+{
+    for (int i = 0; i < 20; ++i)
+    {
+        MIB_IPINTERFACE_ROW row = {.InterfaceIndex = idx, .Family = AF_INET};
+        if (GetIpInterfaceEntry(&row) != ERROR_NOT_FOUND)
+        {
+            break;
+        }
+        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
+        Sleep(50);
+    }
+}
+
+void
+dco_start_tun(struct tuntap *tt)
+{
+    msg(D_DCO_DEBUG, "%s", __func__);
+
+    /* reference the tt object inside the DCO context, because the latter will
+     * be passed around
+     */
+    tt->dco.tt = tt;
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_START_VPN, NULL, 0, NULL, 0,
+                         &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_START_VPN) failed");
+    }
+
+    /* Sometimes IP Helper API, which we use for setting IP address etc,
+     * complains that interface is not found. Give it some time to settle
+     */
+    dco_wait_ready(tt->adapter_index);
+}
+
+static int
+dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int *signal_received)
+{
+    DWORD timeout_msec = timeout * 1000;
+    const int poll_interval_ms = 50;
+
+    while (timeout_msec > 0)
+    {
+        timeout_msec -= poll_interval_ms;
+
+        DWORD transferred;
+        if (GetOverlappedResultEx(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)
+        {
+            /* TCP connection established by dco */
+            return 0;
+        }
+
+        DWORD err = GetLastError();
+        if ((err != WAIT_TIMEOUT) && (err != ERROR_IO_INCOMPLETE))
+        {
+            /* dco reported connection error */
+            msg(M_NONFATAL | M_ERRNO, "dco connect error");
+            *signal_received = SIGUSR1;
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
+    msg(M_NONFATAL, "dco connect timeout");
+    *signal_received = SIGUSR1;
+
+    return -1;
+}
+
+struct tuntap
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, const char *devname,
+                  struct gc_arena *gc, int timeout,
+                  volatile int *signal_received)
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
+        while (bind && !local)
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
+            addr_family_name(remote->sa_family));
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
+            msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_PEER) failed");
+        }
+        else
+        {
+            if (dco_connect_wait(tt.hand, &ov, timeout, signal_received) < 0)
+            {
+                close_tun_handle(&tt);
+            }
+        }
+    }
+    return tt;
+}
+
+int
+dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+    return 0;
+}
+
+int
+dco_del_peer(dco_context_t *dco, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d - not implemented", __func__, peerid);
+    return 0;
+}
+
+int
+dco_set_peer(dco_context_t *dco, unsigned int peerid,
+             int keepalive_interval, int keepalive_timeout, int mss)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
+        peerid, keepalive_interval, keepalive_timeout, mss);
+
+    OVPN_SET_PEER peer;
+
+    peer.KeepaliveInterval =  keepalive_interval;
+    peer.KeepaliveTimeout = keepalive_timeout;
+    peer.MSS = mss;
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SET_PEER, &peer,
+                         sizeof(peer), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed");
+        return -1;
+    }
+    return 0;
+}
+
+int
+dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+            dco_key_slot_t slot,
+            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+            const char *ciphername)
+{
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
+        __func__, slot, keyid, peerid, ciphername);
+
+    const int nonce_len = 8;
+    size_t key_len = cipher_kt_key_size(ciphername);
+
+    OVPN_CRYPTO_DATA crypto_data;
+    ZeroMemory(&crypto_data, sizeof(crypto_data));
+
+    crypto_data.CipherAlg = dco_get_cipher(ciphername);
+    crypto_data.KeyId = keyid;
+    crypto_data.PeerId = peerid;
+    crypto_data.KeySlot = slot;
+
+    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
+    crypto_data.Encrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
+
+    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
+    crypto_data.Decrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
+
+    ASSERT(crypto_data.CipherAlg > 0);
+
+    DWORD bytes_returned = 0;
+
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data,
+                         sizeof(crypto_data), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
+        return -1;
+    }
+    return 0;
+}
+int
+dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
+{
+    msg(D_DCO, "%s: peer-id %d, slot %d called but ignored", __func__, peerid,
+        slot);
+    /* FIXME: Implement in driver first */
+    return 0;
+}
+
+int
+dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_SWAP_KEYS, NULL, 0, NULL, 0,
+                         &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");
+        return -1;
+    }
+    return 0;
+}
+
+bool
+dco_available(int msglevel)
+{
+    return true;
+}
+
+int
+dco_do_read(dco_context_t *dco)
+{
+    /* no-op on windows */
+    return 0;
+}
+
+int
+dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
+{
+    /* no-op on windows */
+    return 0;
+}
+
+void
+dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+{
+    /* no-op on windows */
+}
+
+const char *
+dco_get_supported_ciphers()
+{
+    /*
+     * this API can be called either from user mode or kernel mode,
+     * which enables us to probe driver's chachapoly support
+     * (available starting from Windows 11)
+     */
+
+    BCRYPT_ALG_HANDLE h;
+    NTSTATUS status = BCryptOpenAlgorithmProvider(&h, L"CHACHA20_POLY1305", NULL, 0);
+    if (BCRYPT_SUCCESS(status))
+    {
+        BCryptCloseAlgorithmProvider(h, 0);
+        return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
+    }
+    else
+    {
+        return "AES-128-GCM:AES-256-GCM:AES-192-GCM";
+    }
+}
+
+#endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
new file mode 100644
index 00000000..3b746dd8
--- /dev/null
+++ b/src/openvpn/dco_win.h
@@ -0,0 +1,58 @@
+/*
+ *  Interface to ovpn-win-dco networking code
+ *
+ *  Copyright (C) 2020-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2022 OpenVPN Inc <sales@...515...>
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
+#ifndef DCO_WIN_H
+#define DCO_WIN_H
+
+#if defined(ENABLE_DCO) && defined(_WIN32)
+
+#include "buffer.h"
+#include "ovpn-dco-win.h"
+
+typedef OVPN_KEY_SLOT dco_key_slot_t;
+typedef OVPN_CIPHER_ALG dco_cipher_t;
+
+struct dco_context {
+    bool real_tun_init;
+    struct tuntap *tt;
+};
+
+typedef struct dco_context dco_context_t;
+
+struct tuntap
+dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, const char *devname,
+                  struct gc_arena *gc, int timeout,
+                  volatile int *signal_received);
+
+void
+dco_start_tun(struct tuntap *tt);
+
+#else /* if defined(ENABLE_DCO) && defined(_WIN32) */
+
+static inline void
+dco_start_tun(struct tuntap *tt)
+{
+    ASSERT(false);
+}
+
+#endif /* defined(_WIN32) */
+#endif /* ifndef DCO_H */
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 0b3db7c7..51e8fe79 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -278,6 +278,7 @@
     <ClCompile Include="cryptoapi.c" />
     <ClCompile Include="dco.c" />
     <ClCompile Include="dco_linux.c" />
+    <ClCompile Include="dco_win.c" />
     <ClCompile Include="dhcp.c" />
     <ClCompile Include="dns.c" />
     <ClCompile Include="env_set.c" />
@@ -367,6 +368,7 @@
     <ClInclude Include="dco.h" />
     <ClInclude Include="dco_internal.h" />
     <ClInclude Include="dco_linux.h" />
+    <ClInclude Include="dco_win.h" />
     <ClInclude Include="dhcp.h" />
     <ClInclude Include="dns.h" />
     <ClInclude Include="env_set.h" />
@@ -401,6 +403,7 @@
     <ClInclude Include="openvpn.h" />
     <ClInclude Include="options.h" />
     <ClInclude Include="otime.h" />
+    <ClInclude Include="ovpn-dco-win.h" />
     <ClInclude Include="ovpn_dco_linux.h" />
     <ClInclude Include="packet_id.h" />
     <ClInclude Include="perf.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 16905079..117270bb 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -42,6 +42,9 @@
     <ClCompile Include="dco_linux.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="dco_win.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="dhcp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
@@ -314,6 +317,9 @@
     <ClInclude Include="dco_linux.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="dco_win.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="dhcp.h">
       <Filter>Header Files</Filter>
     </ClInclude>
@@ -413,6 +419,9 @@
     <ClInclude Include="otime.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="ovpn-dco-win.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="ovpn_dco_linux.h">
       <Filter>Header Files</Filter>
     </ClInclude>
diff --git a/src/openvpn/ovpn-dco-win.h b/src/openvpn/ovpn-dco-win.h
new file mode 100644
index 00000000..1ebd51a7
--- /dev/null
+++ b/src/openvpn/ovpn-dco-win.h
@@ -0,0 +1,108 @@
+/*
+ *  ovpn-dco-win OpenVPN protocol accelerator for Windows
+ *
+ *  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
+ *
+ *  Author:	Lev Stipakov <lev@...515...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ *  This particular file (uapi.h) is also licensed using the MIT license (see COPYRIGHT.MIT).
+ */
+
+#pragma once
+#ifndef _KERNEL_MODE
+#include <winsock2.h>
+#endif
+#include <ws2def.h>
+#include <ws2ipdef.h>
+
+typedef enum {
+	OVPN_PROTO_UDP,
+	OVPN_PROTO_TCP
+} OVPN_PROTO;
+
+typedef struct _OVPN_NEW_PEER {
+	union {
+		SOCKADDR_IN Addr4;
+		SOCKADDR_IN6 Addr6;
+	} Local;
+
+	union {
+		SOCKADDR_IN Addr4;
+		SOCKADDR_IN6 Addr6;
+	} Remote;
+
+	OVPN_PROTO Proto;
+} OVPN_NEW_PEER, * POVPN_NEW_PEER;
+
+typedef struct _OVPN_STATS {
+	LONG LostInControlPackets;
+	LONG LostOutControlPackets;
+
+	LONG LostInDataPackets;
+	LONG LostOutDataPackets;
+
+	LONG ReceivedDataPackets;
+	LONG ReceivedControlPackets;
+
+	LONG SentControlPackets;
+	LONG SentDataPackets;
+
+	LONG64 TransportBytesSent;
+	LONG64 TransportBytesReceived;
+
+	LONG64 TunBytesSent;
+	LONG64 TunBytesReceived;
+} OVPN_STATS, * POVPN_STATS;
+
+typedef enum _OVPN_KEY_SLOT {
+	OVPN_KEY_SLOT_PRIMARY,
+	OVPN_KEY_SLOT_SECONDARY
+} OVPN_KEY_SLOT;
+
+typedef enum _OVPN_CIPHER_ALG {
+	OVPN_CIPHER_ALG_NONE,
+	OVPN_CIPHER_ALG_AES_GCM,
+	OVPN_CIPHER_ALG_CHACHA20_POLY1305
+} OVPN_CIPHER_ALG;
+
+typedef struct _OVPN_KEY_DIRECTION
+{
+	unsigned char Key[32];
+	unsigned char KeyLen; // 16/24/32 -> AES-128-GCM/AES-192-GCM/AES-256-GCM
+	unsigned char NonceTail[8];
+} OVPN_KEY_DIRECTION;
+
+typedef struct _OVPN_CRYPTO_DATA {
+	OVPN_KEY_DIRECTION Encrypt;
+	OVPN_KEY_DIRECTION Decrypt;
+	OVPN_KEY_SLOT KeySlot;
+	OVPN_CIPHER_ALG CipherAlg;
+	unsigned char KeyId;
+	int PeerId;
+} OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;
+
+typedef struct _OVPN_SET_PEER {
+	LONG KeepaliveInterval;
+	LONG KeepaliveTimeout;
+	LONG MSS;
+} OVPN_SET_PEER, * POVPN_SET_PEER;
+
+#define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_SWAP_KEYS    CTL_CODE(FILE_DEVICE_UNKNOWN, 4, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index f55315ee..0ee01bde 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -48,7 +48,8 @@
 enum windows_driver_type {
     WINDOWS_DRIVER_UNSPECIFIED,
     WINDOWS_DRIVER_TAP_WINDOWS6,
-    WINDOWS_DRIVER_WINTUN
+    WINDOWS_DRIVER_WINTUN,
+    WINDOWS_DRIVER_DCO
 };
 #endif
 
-- 
2.35.1


