From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:45 +0200
Message-Id: <20220624083809.23487-2-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 01/25] dco: introduce low-level code for
 handling ovpn-dco in the Linux kernel
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

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac                        |  34 +
 dev-tools/special-files.lst         |   1 +
 src/openvpn/Makefile.am             |   3 +
 src/openvpn/dco.h                   | 165 +++++
 src/openvpn/dco_internal.h          |  78 +++
 src/openvpn/dco_linux.c             | 934 ++++++++++++++++++++++++++++
 src/openvpn/dco_linux.h             |  60 ++
 src/openvpn/errlevel.h              |   2 +
 src/openvpn/openvpn.vcxproj         |   7 +-
 src/openvpn/openvpn.vcxproj.filters |  15 +
 src/openvpn/ovpn_dco_linux.h        | 265 ++++++++
 src/openvpn/tun.h                   |   3 +
 12 files changed, 1566 insertions(+), 1 deletion(-)
 create mode 100644 src/openvpn/dco.h
 create mode 100644 src/openvpn/dco_internal.h
 create mode 100644 src/openvpn/dco_linux.c
 create mode 100644 src/openvpn/dco_linux.h
 create mode 100644 src/openvpn/ovpn_dco_linux.h

diff --git a/configure.ac b/configure.ac
index 9c898718..353da08c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -142,6 +142,13 @@ AC_ARG_ENABLE(
 	[enable_small="no"]
 )
 
+AC_ARG_ENABLE(
+	[dco],
+	[AS_HELP_STRING([--enable-dco], [enable data channel offload support using ovpn-dco kernel module @<:@default=no@:>@])],
+	,
+	[enable_dco="no"]
+)
+
 AC_ARG_ENABLE(
 	[iproute2],
 	[AS_HELP_STRING([--enable-iproute2], [enable support for iproute2 @<:@default=no@:>@])],
@@ -760,6 +767,32 @@ PKG_CHECK_MODULES(
 	[]
 )
 
+
+if test "$enable_dco" = "yes"; then
+dnl
+dnl Include generic netlink library used to talk to ovpn-dco
+dnl
+
+	case "$host" in
+		*-*-linux*)
+			PKG_CHECK_MODULES([LIBNL_GENL],
+					  [libnl-genl-3.0 >= 3.4.0],
+					  [have_libnl="yes"],
+					  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
+			)
+
+			CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
+			LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+
+			AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
+			AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+			;;
+		*)
+			AC_MSG_NOTICE([Ignoring --enable-dco on non Linux platform])
+			;;
+	esac
+fi
+
 if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
@@ -1196,6 +1229,7 @@ fi
 AM_CONDITIONAL([HAVE_SITNL], [false])
 
 if test "${enable_iproute2}" = "yes"; then
+	test "${enable_dco}" = "yes" && AC_MSG_ERROR([iproute2 support cannot be enabled when using DCO])
 	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missing])
 	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
 else if test "${have_sitnl}" = "yes"; then
diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst
index 64ee9e1a..33e830d7 100644
--- a/dev-tools/special-files.lst
+++ b/dev-tools/special-files.lst
@@ -1,3 +1,4 @@
 E:doc/doxygen/doc_key_generation.h     # @verbatim section gets mistreated, exclude it
 E:src/compat/compat-lz4.c              # Preserve LZ4 upstream formatting
 E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
+E:src/openvpn/ovpn_dco_linux.h         # Preserve ovpn-dco upstream formatting
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 57729480..91635b67 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -53,6 +53,8 @@ openvpn_SOURCES = \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
+	dco.h dco_internal.h \
+	dco_linux.c dco_linux.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
 	env_set.c env_set.h \
@@ -75,6 +77,7 @@ openvpn_SOURCES = \
 	mbuf.c mbuf.h \
 	memdbg.h \
 	misc.c misc.h \
+	ovpn_dco_linux.h \
 	platform.c platform.h \
 	console.c console.h console_builtin.c console_systemd.c \
 	mroute.c mroute.h \
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
new file mode 100644
index 00000000..dcadba78
--- /dev/null
+++ b/src/openvpn/dco.h
@@ -0,0 +1,165 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021-2022 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2021-2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2021-2022 OpenVPN Inc <sales@...515...>
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
+#ifndef DCO_H
+#define DCO_H
+
+#include "buffer.h"
+#include "error.h"
+#include "dco_internal.h"
+#include "networking.h"
+
+/* forward declarations (including other headers leads to nasty include
+ * order problems)
+ */
+struct event_set;
+struct options;
+struct tuntap;
+
+#if defined(ENABLE_DCO)
+
+/**
+ * Check whether ovpn-dco is available on this platform (i.e. kernel support is
+ * there)
+ *
+ * @param msglevel      level to print messages to
+ * @return              true if ovpn-dco is available, false otherwise
+ */
+bool dco_available(int msglevel);
+
+/**
+ * Check whether the options struct has any option that is not supported by
+ * our current dco implementation. If so print a warning at warning level
+ * for the first conflicting option found and return false.
+ *
+ * @param msglevel  the msg level to use to print the warnings
+ * @param o         the options struct that hold the options
+ * @return          true if no conflict was detected, false otherwise
+ */
+bool dco_check_option_conflict(int msglevel, const struct options *o);
+
+/**
+ * Initialize the DCO context
+ *
+ * @param mode      the instance operating mode (P2P or multi-peer)
+ * @param dco       the context to initialize
+ * @return          true on success, false otherwise
+ */
+bool ovpn_dco_init(int mode, dco_context_t *dco);
+
+/**
+ * Open/create a DCO interface
+ *
+ * @param tt        the tuntap context
+ * @param ctx       the networking API context
+ * @param dev       the name of the interface to create
+ * @return          0 on success or a negative error code otherwise
+ */
+int open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev);
+
+/**
+ * Close/destroy a DCO interface
+ *
+ * @param tt        the tuntap context
+ * @param ctx       the networking API context
+ */
+void close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+
+/**
+ * Read data from the DCO communication channel (i.e. a control packet)
+ *
+ * @param dco       the DCO context
+ * @return          0 on success or a negative error code otherwise
+ */
+int dco_do_read(dco_context_t *dco);
+
+/**
+ * Write data to the DCO communication channel (control packet expected)
+ *
+ * @param dco       the DCO context
+ * @param peer_id   the ID of the peer to send the data to
+ * @param buf       the buffer containing the data to send
+ */
+int dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf);
+
+/**
+ * Install a DCO in the main event loop
+ */
+void dco_event_set(dco_context_t *dco, struct event_set *es, void *arg);
+
+#else /* if defined(ENABLE_DCO) */
+
+typedef void *dco_context_t;
+
+static inline bool
+dco_available(int msglevel)
+{
+    return false;
+}
+
+static inline bool
+dco_check_option_conflict(int msglevel, const struct options *o)
+{
+    return false;
+}
+
+static inline bool
+ovpn_dco_init(int mode, dco_context_t *dco)
+{
+    return true;
+}
+
+static inline int
+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
+{
+    return 0;
+}
+
+static inline void
+close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+}
+
+static inline int
+dco_do_read(dco_context_t *dco)
+{
+    ASSERT(false);
+    return 0;
+}
+
+static inline int
+dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
+{
+    ASSERT(false);
+    return 0;
+}
+
+static inline void
+dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+{
+}
+
+#endif /* defined(ENABLE_DCO) */
+#endif /* ifndef DCO_H */
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
new file mode 100644
index 00000000..3ceb26d6
--- /dev/null
+++ b/src/openvpn/dco_internal.h
@@ -0,0 +1,78 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2022 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
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
+#ifndef DCO_INTERNAL_H
+#define DCO_INTERNAL_H
+
+#if defined(ENABLE_DCO)
+
+#include "dco_linux.h"
+
+/**
+ * This file contains the internal DCO API definition.
+ * It is expected that this file is included only in dco.h.
+ * The OpenVPN code should never directly include this file
+ */
+
+static inline dco_cipher_t
+dco_get_cipher(const char *cipher)
+{
+    if (strcmp(cipher, "AES-256-GCM") == 0 || strcmp(cipher, "AES-128-GCM") == 0
+        || strcmp(cipher, "AES-192-GCM") == 0)
+    {
+        return OVPN_CIPHER_ALG_AES_GCM;
+    }
+    else if (strcmp(cipher, "CHACHA20-POLY1305") == 0)
+    {
+        return OVPN_CIPHER_ALG_CHACHA20_POLY1305;
+    }
+    else
+    {
+        msg(M_FATAL, "DCO: provided unsupported cipher: %s", cipher);
+    }
+}
+
+/**
+ * The following are the DCO APIs used to control the driver.
+ * They are implemented by dco_linux.c
+ */
+
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 struct in_addr *remote_in4, struct in6_addr *remote_in6);
+
+int dco_del_peer(dco_context_t *dco, unsigned int peerid);
+
+int dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+                dco_key_slot_t slot,
+                const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+                const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+                const char *ciphername);
+
+int dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot);
+
+int dco_swap_keys(dco_context_t *dco, unsigned int peerid);
+
+#endif /* defined(ENABLE_DCO) */
+#endif /* ifndef DCO_INTERNAL_H */
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
new file mode 100644
index 00000000..5e77139a
--- /dev/null
+++ b/src/openvpn/dco_linux.c
@@ -0,0 +1,934 @@
+/*
+ *  Interface to linux dco networking code
+ *
+ *  Copyright (C) 2020-2022 Antonio Quartulli <a@...2181...>
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
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+
+#include "syshead.h"
+
+#include "dco_linux.h"
+#include "errlevel.h"
+#include "buffer.h"
+#include "networking.h"
+#include "openvpn.h"
+
+#include "socket.h"
+#include "tun.h"
+#include "ssl.h"
+#include "fdmisc.h"
+#include "ssl_verify.h"
+
+#include "ovpn_dco_linux.h"
+
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+#include <netlink/genl/genl.h>
+#include <netlink/genl/family.h>
+#include <netlink/genl/ctrl.h>
+
+
+/* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
+ * have to explicitly do it to prevent the kernel from failing upon
+ * parsing of the message
+ */
+#define nla_nest_start(_msg, _type) \
+    nla_nest_start(_msg, (_type) | NLA_F_NESTED)
+
+static int ovpn_get_mcast_id(dco_context_t *dco);
+
+void dco_check_key_ctx(const struct key_ctx_bi *key);
+
+typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
+
+/**
+ * @brief resolves the netlink ID for ovpn-dco
+ *
+ * This function queries the kernel via a netlink socket
+ * whether the ovpn-dco netlink namespace is available
+ *
+ * This function can be used to determine if the kernel
+ * supports DCO offloading.
+ *
+ * @return ID on success, negative error code on error
+ */
+static int
+resolve_ovpn_netlink_id(int msglevel)
+{
+    int ret;
+    struct nl_sock *nl_sock = nl_socket_alloc();
+
+    ret = genl_connect(nl_sock);
+    if (ret)
+    {
+        msg(msglevel, "Cannot connect to generic netlink: %s",
+            nl_geterror(ret));
+        goto err_sock;
+    }
+    set_cloexec(nl_socket_get_fd(nl_sock));
+
+    ret = genl_ctrl_resolve(nl_sock, OVPN_NL_NAME);
+    if (ret < 0)
+    {
+        msg(msglevel, "Cannot find ovpn_dco netlink component: %s",
+            nl_geterror(ret));
+    }
+
+err_sock:
+    nl_socket_free(nl_sock);
+    return ret;
+}
+
+static struct nl_msg *
+ovpn_dco_nlmsg_create(dco_context_t *dco, enum ovpn_nl_commands cmd)
+{
+    struct nl_msg *nl_msg = nlmsg_alloc();
+    if (!nl_msg)
+    {
+        msg(M_ERR, "cannot allocate netlink message");
+        return NULL;
+    }
+
+    genlmsg_put(nl_msg, 0, 0, dco->ovpn_dco_id, 0, 0, cmd, 0);
+    NLA_PUT_U32(nl_msg, OVPN_ATTR_IFINDEX, dco->ifindex);
+
+    return nl_msg;
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    msg(M_INFO, "cannot put into netlink message");
+    return NULL;
+}
+
+static int
+ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
+{
+    int ret = nl_recvmsgs(dco->nl_sock, dco->nl_cb);
+
+    switch (ret)
+    {
+        case -NLE_INTR:
+            msg(M_WARN, "%s: netlink received interrupt due to signal - ignoring", prefix);
+            break;
+
+        case -NLE_NOMEM:
+            msg(M_ERR, "%s: netlink out of memory error", prefix);
+            break;
+
+        case -M_ERR:
+            msg(M_WARN, "%s: netlink reports blocking read - aborting wait", prefix);
+            break;
+
+        case -NLE_NODEV:
+            msg(M_ERR, "%s: netlink reports device not found:", prefix);
+            break;
+
+        case -NLE_OBJ_NOTFOUND:
+            msg(M_INFO, "%s: netlink reports object not found, ovpn-dco unloaded?", prefix);
+            break;
+
+        default:
+            if (ret)
+            {
+                msg(M_NONFATAL|M_ERRNO, "%s: netlink reports error (%d): %s", prefix, ret, nl_geterror(-ret));
+            }
+            break;
+    }
+
+    return ret;
+}
+
+/**
+ * Send a prepared netlink message and registers cb as callback if non-null.
+ *
+ * The method will also free nl_msg
+ * @param dco       The dco context to use
+ * @param nl_msg    the message to use
+ * @param cb        An optional callback if the caller expects an answer
+ * @param prefix    A prefix to report in the error message to give the user context
+ * @return          status of sending the message
+ */
+static int
+ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
+                 const char *prefix)
+{
+    dco->status = 1;
+
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);
+    nl_send_auto(dco->nl_sock, nl_msg);
+
+    while (dco->status == 1)
+    {
+        ovpn_nl_recvmsgs(dco, prefix);
+    }
+
+    if (dco->status < 0)
+    {
+        msg(M_INFO, "%s: failed to send netlink message: %s (%d)",
+            prefix, strerror(-dco->status), dco->status);
+    }
+
+    return dco->status;
+}
+
+struct sockaddr *
+mapped_v4_to_v6(struct sockaddr *sock, struct gc_arena *gc)
+{
+    struct sockaddr_in6 *sock6 = (struct sockaddr_in6 *)sock;
+    if (sock->sa_family == AF_INET6 && IN6_IS_ADDR_V4MAPPED(&sock6->sin6_addr))
+    {
+
+        struct sockaddr_in *sock4;
+        ALLOC_OBJ_CLEAR_GC(sock4, struct sockaddr_in, gc);
+        memcpy(&sock4->sin_addr, sock6->sin6_addr.s6_addr + 12, 4);
+        sock4->sin_port = sock6->sin6_port;
+        sock4->sin_family = AF_INET;
+        return (struct sockaddr *)sock4;
+    }
+    return sock;
+}
+
+int
+dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+             struct in_addr *remote_in4, struct in6_addr *remote_in6)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, fd %d", __func__, peerid, sd);
+
+    struct gc_arena gc = gc_new();
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_PEER);
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_NEW_PEER);
+    int ret = -EMSGSIZE;
+
+    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_SOCKET, sd);
+
+    /* Set the remote endpoint if defined (for UDP) */
+    if (remoteaddr)
+    {
+        remoteaddr = mapped_v4_to_v6(remoteaddr, &gc);
+        int alen = af_addr_size(remoteaddr->sa_family);
+
+        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE, alen, remoteaddr);
+    }
+
+    if (localaddr)
+    {
+        localaddr = mapped_v4_to_v6(localaddr, &gc);
+        if (localaddr->sa_family == AF_INET)
+        {
+            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in_addr),
+                    &((struct sockaddr_in *)localaddr)->sin_addr);
+        }
+        else if (localaddr->sa_family == AF_INET6)
+        {
+            NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_LOCAL_IP, sizeof(struct in6_addr),
+                    &((struct sockaddr_in6 *)localaddr)->sin6_addr);
+        }
+    }
+
+    /* Set the primary VPN IP addresses of the peer */
+    if (remote_in4)
+    {
+        NLA_PUT_U32(nl_msg, OVPN_NEW_PEER_ATTR_IPV4, remote_in4->s_addr);
+    }
+    if (remote_in6)
+    {
+        NLA_PUT(nl_msg, OVPN_NEW_PEER_ATTR_IPV6, sizeof(struct in6_addr),
+                remote_in6);
+    }
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    gc_free(&gc);
+    return ret;
+}
+
+static int
+ovpn_nl_cb_finish(struct nl_msg (*msg) __attribute__ ((unused)), void *arg)
+{
+    int *status = arg;
+
+    *status = 0;
+    return NL_SKIP;
+}
+
+/* This function is used as error callback on the netlink socket.
+ * When something goes wrong and the kernel returns an error, this function is
+ * invoked.
+ *
+ * We pass the error code to the user by means of a variable pointed by *arg
+ * (supplied by the user when setting this callback) and we parse the kernel
+ * reply to see if it contains a human readable error. If found, it is printed.
+ */
+static int
+ovpn_nl_cb_error(struct sockaddr_nl (*nla) __attribute__ ((unused)),
+                 struct nlmsgerr *err, void *arg)
+{
+    struct nlmsghdr *nlh = (struct nlmsghdr *)err - 1;
+    struct nlattr *tb_msg[NLMSGERR_ATTR_MAX + 1];
+    int len = nlh->nlmsg_len;
+    struct nlattr *attrs;
+    int *ret = arg;
+    int ack_len = sizeof(*nlh) + sizeof(int) + sizeof(*nlh);
+
+    *ret = err->error;
+
+    if (!(nlh->nlmsg_flags & NLM_F_ACK_TLVS))
+    {
+        return NL_STOP;
+    }
+
+    if (!(nlh->nlmsg_flags & NLM_F_CAPPED))
+    {
+        ack_len += err->msg.nlmsg_len - sizeof(*nlh);
+    }
+
+    if (len <= ack_len)
+    {
+        return NL_STOP;
+    }
+
+    attrs = (void *)((unsigned char *)nlh + ack_len);
+    len -= ack_len;
+
+    nla_parse(tb_msg, NLMSGERR_ATTR_MAX, attrs, len, NULL);
+    if (tb_msg[NLMSGERR_ATTR_MSG])
+    {
+        len = strnlen((char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]),
+                      nla_len(tb_msg[NLMSGERR_ATTR_MSG]));
+        msg(M_WARN, "kernel error: %*s\n", len,
+            (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
+    }
+
+    return NL_STOP;
+}
+
+static void
+ovpn_dco_init_netlink(dco_context_t *dco)
+{
+    dco->ovpn_dco_id = resolve_ovpn_netlink_id(M_ERR);
+
+    dco->nl_sock = nl_socket_alloc();
+
+    if (!dco->nl_sock)
+    {
+        msg(M_ERR, "Cannot create netlink socket");
+    }
+
+    /* TODO: Why are we setting this buffer size? */
+    nl_socket_set_buffer_size(dco->nl_sock, 8192, 8192);
+
+    int ret = genl_connect(dco->nl_sock);
+    if (ret)
+    {
+        msg(M_ERR, "Cannot connect to generic netlink: %s",
+            nl_geterror(ret));
+    }
+
+    set_cloexec(nl_socket_get_fd(dco->nl_sock));
+
+    dco->nl_cb = nl_cb_alloc(NL_CB_DEFAULT);
+    if (!dco->nl_cb)
+    {
+        msg(M_ERR, "failed to allocate netlink callback");
+    }
+
+    nl_socket_set_cb(dco->nl_sock, dco->nl_cb);
+
+    nl_cb_err(dco->nl_cb, NL_CB_CUSTOM, ovpn_nl_cb_error, &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_FINISH, NL_CB_CUSTOM, ovpn_nl_cb_finish,
+              &dco->status);
+    nl_cb_set(dco->nl_cb, NL_CB_ACK, NL_CB_CUSTOM, ovpn_nl_cb_finish,
+              &dco->status);
+
+    /* The async PACKET messages confuse libnl and it will drop them with
+     * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequence
+     * number check */
+    nl_socket_disable_seq_check(dco->nl_sock);
+}
+
+bool
+ovpn_dco_init(int mode, dco_context_t *dco)
+{
+    switch (mode)
+    {
+        case CM_TOP:
+            dco->ifmode = OVPN_MODE_MP;
+            break;
+
+        case CM_P2P:
+            dco->ifmode = OVPN_MODE_P2P;
+            break;
+
+        default:
+            ASSERT(false);
+    }
+
+    ovpn_dco_init_netlink(dco);
+    return true;
+}
+
+static void
+ovpn_dco_uninit_netlink(dco_context_t *dco)
+{
+    nl_socket_free(dco->nl_sock);
+    dco->nl_sock = NULL;
+
+    /* Decrease reference count */
+    nl_cb_put(dco->nl_cb);
+
+    CLEAR(dco);
+}
+
+static void
+ovpn_dco_register(dco_context_t *dco)
+{
+    msg(D_DCO_DEBUG, __func__);
+    ovpn_get_mcast_id(dco);
+
+    if (dco->ovpn_dco_mcast_id < 0)
+    {
+        msg(M_ERR, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dco_mcast_id));
+    }
+
+    /* Register for ovpn-dco specific multicast messages that the kernel may
+     * send
+     */
+    int ret = nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
+    if (ret)
+    {
+        msg(M_ERR, "%s: failed to join groups: %d", __func__, ret);
+    }
+
+    /* Register for non-data packets that ovpn-dco may receive. They will be
+     * forwarded to userspace
+     */
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_REGISTER_PACKET);
+    if (!nl_msg)
+    {
+        msg(M_ERR, "%s: cannot allocate message to register for control packets",
+            __func__);
+    }
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    if (ret)
+    {
+        msg(M_ERR, "%s: failed to register for control packets: %d", __func__,
+            ret);
+    }
+    nlmsg_free(nl_msg);
+}
+
+int
+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
+{
+    msg(D_DCO_DEBUG, "%s: %s", __func__, dev);
+    ASSERT(tt->type == DEV_TYPE_TUN);
+
+    int ret = net_iface_new(ctx, dev, "ovpn-dco", &tt->dco);
+    if (ret < 0)
+    {
+        msg(D_DCO_DEBUG, "Cannot create DCO interface %s: %d", dev, ret);
+        return ret;
+    }
+
+    tt->dco.ifindex = if_nametoindex(dev);
+    if (!tt->dco.ifindex)
+    {
+        msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
+    }
+
+    tt->actual_name = string_alloc(dev, NULL);
+    uint8_t *dcobuf = malloc(65536);
+    buf_set_write(&tt->dco.dco_packet_in, dcobuf, 65536);
+    tt->dco.dco_message_peer_id = -1;
+
+    ovpn_dco_register(&tt->dco);
+
+    return 0;
+}
+
+void
+close_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+{
+    msg(D_DCO_DEBUG, __func__);
+
+    net_iface_del(ctx, tt->actual_name);
+    ovpn_dco_uninit_netlink(&tt->dco);
+    free(tt->dco.dco_packet_in.data);
+}
+
+int
+dco_swap_keys(dco_context_t *dco, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_SWAP_KEYS);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_SWAP_KEYS);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_SWAP_KEYS_ATTR_PEER_ID, peerid);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+
+int
+dco_del_peer(dco_context_t *dco, unsigned int peerid)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_DEL_PEER);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_DEL_PEER);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_DEL_PEER_ATTR_PEER_ID, peerid);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+
+int
+dco_del_key(dco_context_t *dco, unsigned int peerid,
+            dco_key_slot_t slot)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, slot);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_DEL_KEY);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_DEL_KEY);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_DEL_KEY_ATTR_PEER_ID, peerid);
+    NLA_PUT_U8(nl_msg, OVPN_DEL_KEY_ATTR_KEY_SLOT, slot);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
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
+    const size_t key_len = cipher_kt_key_size(ciphername);
+    const int nonce_tail_len = 8;
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_NEW_KEY);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    dco_cipher_t dco_cipher = dco_get_cipher(ciphername);
+
+    int ret = -EMSGSIZE;
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_NEW_KEY);
+    NLA_PUT_U32(nl_msg, OVPN_NEW_KEY_ATTR_PEER_ID, peerid);
+    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_SLOT, slot);
+    NLA_PUT_U8(nl_msg, OVPN_NEW_KEY_ATTR_KEY_ID, keyid);
+    NLA_PUT_U16(nl_msg, OVPN_NEW_KEY_ATTR_CIPHER_ALG, dco_cipher);
+
+    struct nlattr *key_enc = nla_nest_start(nl_msg,
+                                            OVPN_NEW_KEY_ATTR_ENCRYPT_KEY);
+    if (dco_cipher != OVPN_CIPHER_ALG_NONE)
+    {
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, encrypt_key);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
+                encrypt_iv);
+    }
+    nla_nest_end(nl_msg, key_enc);
+
+    struct nlattr *key_dec = nla_nest_start(nl_msg,
+                                            OVPN_NEW_KEY_ATTR_DECRYPT_KEY);
+    if (dco_cipher != OVPN_CIPHER_ALG_NONE)
+    {
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_CIPHER_KEY, key_len, decrypt_key);
+        NLA_PUT(nl_msg, OVPN_KEY_DIR_ATTR_NONCE_TAIL, nonce_tail_len,
+                decrypt_iv);
+    }
+    nla_nest_end(nl_msg, key_dec);
+
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+int
+dco_set_peer(dco_context_t *dco, unsigned int peerid,
+             int keepalive_interval, int keepalive_timeout, int mss)
+{
+    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__,
+        peerid, keepalive_interval, keepalive_timeout, mss);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_SET_PEER);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_SET_PEER);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_PEER_ID, peerid);
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
+                keepalive_interval);
+    NLA_PUT_U32(nl_msg, OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
+                keepalive_timeout);
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+/* This function parses the reply provided by the kernel to the CTRL_CMD_GETFAMILY
+ * message. We parse the reply and we retrieve the multicast group ID associated
+ * with the "ovpn-dco" netlink family.
+ *
+ * The ID is later used to subscribe to the multicast group and be notified
+ * about any multicast message sent by the ovpn-dco kernel module.
+ */
+static int
+mcast_family_handler(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco = arg;
+    struct nlattr *tb[CTRL_ATTR_MAX + 1];
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+
+    nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+              genlmsg_attrlen(gnlh, 0), NULL);
+
+    if (!tb[CTRL_ATTR_MCAST_GROUPS])
+    {
+        return NL_SKIP;
+    }
+
+    struct nlattr *mcgrp;
+    int rem_mcgrp;
+    nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)
+    {
+        struct nlattr *tb_mcgrp[CTRL_ATTR_MCAST_GRP_MAX + 1];
+
+        nla_parse(tb_mcgrp, CTRL_ATTR_MCAST_GRP_MAX,
+                  nla_data(mcgrp), nla_len(mcgrp), NULL);
+
+        if (!tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]
+            || !tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID])
+        {
+            continue;
+        }
+
+        if (strncmp(nla_data(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME]),
+                    OVPN_NL_MULTICAST_GROUP_PEERS,
+                    nla_len(tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME])) != 0)
+        {
+            continue;
+        }
+        dco->ovpn_dco_mcast_id = nla_get_u32(tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID]);
+        break;
+    }
+
+    return NL_SKIP;
+}
+/**
+ * Lookup the multicast id for OpenVPN. This method and its help method currently
+ * hardcode the lookup to OVPN_NL_NAME and OVPN_NL_MULTICAST_GROUP_PEERS but
+ * extended in the future if we need to lookup more than one mcast id.
+ */
+static int
+ovpn_get_mcast_id(dco_context_t *dco)
+{
+    dco->ovpn_dco_mcast_id = -ENOENT;
+
+    /* Even though 'nlctrl' is a constant, there seem to be no library
+     * provided define for it */
+    int ctrlid = genl_ctrl_resolve(dco->nl_sock, "nlctrl");
+
+    struct nl_msg *nl_msg = nlmsg_alloc();
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    genlmsg_put(nl_msg, 0, 0, ctrlid, 0, 0, CTRL_CMD_GETFAMILY, 0);
+
+    int ret = -EMSGSIZE;
+    NLA_PUT_STRING(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_NL_NAME);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, mcast_family_handler, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+/* This function parses any netlink message sent by ovpn-dco to userspace */
+static int
+ovpn_handle_msg(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco = arg;
+
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+    struct nlattr *attrs[OVPN_ATTR_MAX + 1];
+    struct nlmsghdr *nlh = nlmsg_hdr(msg);
+
+    if (!genlmsg_valid_hdr(nlh, 0))
+    {
+        msg(D_DCO, "ovpn-dco: invalid header");
+        return NL_SKIP;
+    }
+
+    if (nla_parse(attrs, OVPN_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+                  genlmsg_attrlen(gnlh, 0), NULL))
+    {
+        msg(D_DCO, "received bogus data from ovpn-dco");
+        return NL_SKIP;
+    }
+
+    /* we must know which interface this message is referring to in order to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_ATTR_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_SKIP;
+    }
+
+    uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
+    if (ifindex != dco->ifindex)
+    {
+        msg(D_DCO, "ovpn-dco: received message type %d with mismatched ifindex %d\n",
+            gnlh->cmd, ifindex);
+        return NL_SKIP;
+    }
+
+    /* based on the message type, we parse the subobject contained in the
+     * message, that stores the type-specific attributes.
+     *
+     * the "dco" object is then filled accordingly with the information
+     * retrieved from the message, so that the rest of the OpenVPN code can
+     * react as need be.
+     */
+    switch (gnlh->cmd)
+    {
+        case OVPN_CMD_DEL_PEER:
+        {
+            if (!attrs[OVPN_ATTR_DEL_PEER])
+            {
+                msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER message");
+                return NL_SKIP;
+            }
+
+            struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
+            if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
+                                 attrs[OVPN_ATTR_DEL_PEER], NULL))
+            {
+                msg(D_DCO, "received bogus del peer packet data from ovpn-dco");
+                return NL_SKIP;
+            }
+
+            if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])
+            {
+                msg(D_DCO, "ovpn-dco: no reason in DEL_PEER message");
+                return NL_SKIP;
+            }
+            if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])
+            {
+                msg(D_DCO, "ovpn-dco: no peer-id in DEL_PEER message");
+                return NL_SKIP;
+            }
+            int reason = nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
+            unsigned int peerid = nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);
+
+            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d",
+                ifindex, peerid, reason);
+            dco->dco_message_peer_id = peerid;
+            dco->dco_del_peer_reason = reason;
+            dco->dco_message_type = OVPN_CMD_DEL_PEER;
+
+            break;
+        }
+
+        case OVPN_CMD_PACKET:
+        {
+            if (!attrs[OVPN_ATTR_PACKET])
+            {
+                msg(D_DCO, "ovpn-dco: no packet in OVPN_CMD_PACKET message");
+                return NL_SKIP;
+            }
+            struct nlattr *pkt_attrs[OVPN_PACKET_ATTR_MAX + 1];
+
+            if (nla_parse_nested(pkt_attrs, OVPN_PACKET_ATTR_MAX,
+                                 attrs[OVPN_ATTR_PACKET], NULL))
+            {
+                msg(D_DCO, "received bogus cmd packet data from ovpn-dco");
+                return NL_SKIP;
+            }
+            if (!pkt_attrs[OVPN_PACKET_ATTR_PEER_ID])
+            {
+                msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without peer id");
+                return NL_SKIP;
+            }
+            if (!pkt_attrs[OVPN_PACKET_ATTR_PACKET])
+            {
+                msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without packet");
+                return NL_SKIP;
+            }
+
+            unsigned int peerid = nla_get_u32(pkt_attrs[OVPN_PACKET_ATTR_PEER_ID]);
+
+            uint8_t *data = nla_data(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
+            int len = nla_len(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
+
+            msg(D_DCO_DEBUG, "ovpn-dco: received OVPN_PACKET_ATTR_PACKET, ifindex: %d peer-id: %d, len %d",
+                ifindex, peerid, len);
+            if (BLEN(&dco->dco_packet_in) > 0)
+            {
+                msg(D_DCO, "DCO packet buffer still full?!");
+                return NL_SKIP;
+            }
+            buf_init(&dco->dco_packet_in, 0);
+            buf_write(&dco->dco_packet_in, data, len);
+            dco->dco_message_peer_id = peerid;
+            dco->dco_message_type = OVPN_CMD_PACKET;
+            break;
+        }
+
+        default:
+            msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd);
+            dco->dco_message_type = 0;
+            return NL_SKIP;
+    }
+
+    return NL_OK;
+}
+
+int
+dco_do_read(dco_context_t *dco)
+{
+    msg(D_DCO_DEBUG, __func__);
+    nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, ovpn_handle_msg, dco);
+
+    return ovpn_nl_recvmsgs(dco, __func__);
+}
+
+int
+dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
+{
+    packet_size_type len = BLEN(buf);
+    dmsg(D_STREAM_DEBUG, "DCO: WRITE %d offset=%d", (int)len, buf->offset);
+
+    msg(D_DCO_DEBUG, "%s: peer-id %d, len=%d", __func__, peer_id, len);
+
+    struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PACKET);
+
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+    struct nlattr *attr = nla_nest_start(nl_msg, OVPN_ATTR_PACKET);
+    int ret = -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_PACKET_ATTR_PEER_ID, peer_id);
+    NLA_PUT(nl_msg, OVPN_PACKET_ATTR_PACKET, len, BSTR(buf));
+    nla_nest_end(nl_msg, attr);
+
+    ret = ovpn_nl_msg_send(dco, nl_msg, NULL, __func__);
+    if (ret)
+    {
+        goto nla_put_failure;
+    }
+
+    /* return the length of the written data in case of success */
+    ret = len;
+
+nla_put_failure:
+    nlmsg_free(nl_msg);
+    return ret;
+}
+
+bool
+dco_available(int msglevel)
+{
+    if (resolve_ovpn_netlink_id(msglevel) < 0)
+    {
+        msg(msglevel,
+            "Note: Kernel support for ovpn-dco missing, disabling data channel offload.");
+        return false;
+    }
+    return true;
+}
+
+void
+dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+{
+    if (dco && dco->nl_sock)
+    {
+        event_ctl(es, nl_socket_get_fd(dco->nl_sock), EVENT_READ, arg);
+    }
+}
+
+#endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
new file mode 100644
index 00000000..e0e59fa6
--- /dev/null
+++ b/src/openvpn/dco_linux.h
@@ -0,0 +1,60 @@
+/*
+ *  Interface to linux dco networking code
+ *
+ *  Copyright (C) 2020-2022 Antonio Quartulli <a@...2181...>
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
+#ifndef DCO_LINUX_H
+#define DCO_LINUX_H
+
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+
+#include "event.h"
+
+#include "ovpn_dco_linux.h"
+
+#include <netlink/socket.h>
+#include <netlink/netlink.h>
+
+typedef enum ovpn_key_slot dco_key_slot_t;
+typedef enum ovpn_cipher_alg dco_cipher_t;
+
+#define DCO_SUPPORTED_CIPHERS "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305"
+
+typedef struct
+{
+    struct nl_sock *nl_sock;
+    struct nl_cb *nl_cb;
+    int status;
+
+    enum ovpn_mode ifmode;
+
+    int ovpn_dco_id;
+    int ovpn_dco_mcast_id;
+
+    unsigned int ifindex;
+
+    struct buffer dco_packet_in;
+
+    int dco_message_type;
+    int dco_message_peer_id;
+    int dco_del_peer_reason;
+} dco_context_t;
+
+#endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
+#endif /* ifndef DCO_LINUX_H */
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index e616a496..5bb1e65e 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -91,6 +91,7 @@
 #define D_OSBUF              LOGLEV(3, 43, 0)        /* show socket/tun/tap buffer sizes */
 #define D_PS_PROXY           LOGLEV(3, 44, 0)        /* messages related to --port-share option */
 #define D_IFCONFIG           LOGLEV(3, 0,  0)        /* show ifconfig info (don't mute) */
+#define D_DCO                LOGLEV(3, 0, 0)         /* show DCO related messages */
 
 #define D_SHOW_PARMS         LOGLEV(4, 50, 0)        /* show all parameters on program initiation */
 #define D_SHOW_OCC           LOGLEV(4, 51, 0)        /* show options compatibility string */
@@ -114,6 +115,7 @@
 #define D_TAP_WIN_DEBUG      LOGLEV(6, 69, M_DEBUG)  /* show TAP-Windows driver debug info */
 #define D_CLIENT_NAT         LOGLEV(6, 69, M_DEBUG)  /* show client NAT debug info */
 #define D_XKEY               LOGLEV(6, 69, M_DEBUG)  /* show xkey-provider debug info */
+#define D_DCO_DEBUG          LOGLEV(6, 69, M_DEBUG)  /* show DCO related lowlevel debug messages */
 
 #define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
 #define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG)  /* show data channel key source entropy */
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 860ef892..bc1a0300 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -276,9 +276,10 @@
     <ClCompile Include="crypto.c" />
     <ClCompile Include="crypto_openssl.c" />
     <ClCompile Include="cryptoapi.c" />
-    <ClCompile Include="env_set.c" />
+    <ClCompile Include="dco_linux.c" />
     <ClCompile Include="dhcp.c" />
     <ClCompile Include="dns.c" />
+    <ClCompile Include="env_set.c" />
     <ClCompile Include="error.c" />
     <ClCompile Include="event.c" />
     <ClCompile Include="fdmisc.c" />
@@ -362,6 +363,9 @@
     <ClInclude Include="crypto_backend.h" />
     <ClInclude Include="crypto_openssl.h" />
     <ClInclude Include="cryptoapi.h" />
+    <ClInclude Include="dco.h" />
+    <ClInclude Include="dco_internal.h" />
+    <ClInclude Include="dco_linux.h" />
     <ClInclude Include="dhcp.h" />
     <ClInclude Include="dns.h" />
     <ClInclude Include="env_set.h" />
@@ -396,6 +400,7 @@
     <ClInclude Include="openvpn.h" />
     <ClInclude Include="options.h" />
     <ClInclude Include="otime.h" />
+    <ClInclude Include="ovpn_dco_linux.h" />
     <ClInclude Include="packet_id.h" />
     <ClInclude Include="perf.h" />
     <ClInclude Include="ping.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index f76e5923..3c21a4c6 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -36,6 +36,9 @@
     <ClCompile Include="cryptoapi.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="dco_linux.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="dhcp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
@@ -299,6 +302,15 @@
     <ClInclude Include="cryptoapi.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClCompile Include="dco.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="dco_internal.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="dco_linux.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="dhcp.h">
       <Filter>Header Files</Filter>
     </ClInclude>
@@ -398,6 +410,9 @@
     <ClInclude Include="otime.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="ovpn_dco_linux.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="packet_id.h">
       <Filter>Header Files</Filter>
     </ClInclude>
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
new file mode 100644
index 00000000..beca1beb
--- /dev/null
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -0,0 +1,265 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ *  OpenVPN data channel accelerator
+ *
+ *  Copyright (C) 2019-2021 OpenVPN, Inc.
+ *
+ *  Author:	James Yonan <james@...515...>
+ *		Antonio Quartulli <antonio@...515...>
+ */
+
+#ifndef _UAPI_LINUX_OVPN_DCO_H_
+#define _UAPI_LINUX_OVPN_DCO_H_
+
+#define OVPN_NL_NAME "ovpn-dco"
+
+#define OVPN_NL_MULTICAST_GROUP_PEERS "peers"
+
+/**
+ * enum ovpn_nl_commands - supported netlink commands
+ */
+enum ovpn_nl_commands {
+	/**
+	 * @OVPN_CMD_UNSPEC: unspecified command to catch errors
+	 */
+	OVPN_CMD_UNSPEC = 0,
+
+	/**
+	 * @OVPN_CMD_NEW_PEER: Configure peer with its crypto keys
+	 */
+	OVPN_CMD_NEW_PEER,
+
+	/**
+	 * @OVPN_CMD_SET_PEER: Tweak parameters for an existing peer
+	 */
+	OVPN_CMD_SET_PEER,
+
+	/**
+	 * @OVPN_CMD_DEL_PEER: Remove peer from internal table
+	 */
+	OVPN_CMD_DEL_PEER,
+
+	OVPN_CMD_NEW_KEY,
+
+	OVPN_CMD_SWAP_KEYS,
+
+	OVPN_CMD_DEL_KEY,
+
+	/**
+	 * @OVPN_CMD_REGISTER_PACKET: Register for specific packet types to be
+	 * forwarded to userspace
+	 */
+	OVPN_CMD_REGISTER_PACKET,
+
+	/**
+	 * @OVPN_CMD_PACKET: Send a packet from userspace to kernelspace. Also
+	 * used to send to userspace packets for which a process had registered
+	 * with OVPN_CMD_REGISTER_PACKET
+	 */
+	OVPN_CMD_PACKET,
+
+	/**
+	 * @OVPN_CMD_GET_PEER: Retrieve the status of a peer or all peers
+	 */
+	OVPN_CMD_GET_PEER,
+};
+
+enum ovpn_cipher_alg {
+	/**
+	 * @OVPN_CIPHER_ALG_NONE: No encryption - reserved for debugging only
+	 */
+	OVPN_CIPHER_ALG_NONE = 0,
+	/**
+	 * @OVPN_CIPHER_ALG_AES_GCM: AES-GCM AEAD cipher with any allowed key size
+	 */
+	OVPN_CIPHER_ALG_AES_GCM,
+	/**
+	 * @OVPN_CIPHER_ALG_CHACHA20_POLY1305: ChaCha20Poly1305 AEAD cipher
+	 */
+	OVPN_CIPHER_ALG_CHACHA20_POLY1305,
+};
+
+enum ovpn_del_peer_reason {
+	__OVPN_DEL_PEER_REASON_FIRST,
+	OVPN_DEL_PEER_REASON_TEARDOWN = __OVPN_DEL_PEER_REASON_FIRST,
+	OVPN_DEL_PEER_REASON_USERSPACE,
+	OVPN_DEL_PEER_REASON_EXPIRED,
+	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+	__OVPN_DEL_PEER_REASON_AFTER_LAST
+};
+
+enum ovpn_key_slot {
+	__OVPN_KEY_SLOT_FIRST,
+	OVPN_KEY_SLOT_PRIMARY = __OVPN_KEY_SLOT_FIRST,
+	OVPN_KEY_SLOT_SECONDARY,
+	__OVPN_KEY_SLOT_AFTER_LAST,
+};
+
+enum ovpn_netlink_attrs {
+	OVPN_ATTR_UNSPEC = 0,
+	OVPN_ATTR_IFINDEX,
+	OVPN_ATTR_NEW_PEER,
+	OVPN_ATTR_SET_PEER,
+	OVPN_ATTR_DEL_PEER,
+	OVPN_ATTR_NEW_KEY,
+	OVPN_ATTR_SWAP_KEYS,
+	OVPN_ATTR_DEL_KEY,
+	OVPN_ATTR_PACKET,
+	OVPN_ATTR_GET_PEER,
+
+	__OVPN_ATTR_AFTER_LAST,
+	OVPN_ATTR_MAX = __OVPN_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_key_dir_attrs {
+	OVPN_KEY_DIR_ATTR_UNSPEC = 0,
+	OVPN_KEY_DIR_ATTR_CIPHER_KEY,
+	OVPN_KEY_DIR_ATTR_NONCE_TAIL,
+
+	__OVPN_KEY_DIR_ATTR_AFTER_LAST,
+	OVPN_KEY_DIR_ATTR_MAX = __OVPN_KEY_DIR_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_new_key_attrs {
+	OVPN_NEW_KEY_ATTR_UNSPEC = 0,
+	OVPN_NEW_KEY_ATTR_PEER_ID,
+	OVPN_NEW_KEY_ATTR_KEY_SLOT,
+	OVPN_NEW_KEY_ATTR_KEY_ID,
+	OVPN_NEW_KEY_ATTR_CIPHER_ALG,
+	OVPN_NEW_KEY_ATTR_ENCRYPT_KEY,
+	OVPN_NEW_KEY_ATTR_DECRYPT_KEY,
+
+	__OVPN_NEW_KEY_ATTR_AFTER_LAST,
+	OVPN_NEW_KEY_ATTR_MAX = __OVPN_NEW_KEY_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_del_key_attrs {
+	OVPN_DEL_KEY_ATTR_UNSPEC = 0,
+	OVPN_DEL_KEY_ATTR_PEER_ID,
+	OVPN_DEL_KEY_ATTR_KEY_SLOT,
+
+	__OVPN_DEL_KEY_ATTR_AFTER_LAST,
+	OVPN_DEL_KEY_ATTR_MAX = __OVPN_DEL_KEY_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_swap_keys_attrs {
+	OVPN_SWAP_KEYS_ATTR_UNSPEC = 0,
+	OVPN_SWAP_KEYS_ATTR_PEER_ID,
+
+	__OVPN_SWAP_KEYS_ATTR_AFTER_LAST,
+	OVPN_SWAP_KEYS_ATTR_MAX = __OVPN_SWAP_KEYS_ATTR_AFTER_LAST - 1,
+
+};
+
+enum ovpn_netlink_new_peer_attrs {
+	OVPN_NEW_PEER_ATTR_UNSPEC = 0,
+	OVPN_NEW_PEER_ATTR_PEER_ID,
+	OVPN_NEW_PEER_ATTR_SOCKADDR_REMOTE,
+	OVPN_NEW_PEER_ATTR_SOCKET,
+	OVPN_NEW_PEER_ATTR_IPV4,
+	OVPN_NEW_PEER_ATTR_IPV6,
+	OVPN_NEW_PEER_ATTR_LOCAL_IP,
+
+	__OVPN_NEW_PEER_ATTR_AFTER_LAST,
+	OVPN_NEW_PEER_ATTR_MAX = __OVPN_NEW_PEER_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_set_peer_attrs {
+	OVPN_SET_PEER_ATTR_UNSPEC = 0,
+	OVPN_SET_PEER_ATTR_PEER_ID,
+	OVPN_SET_PEER_ATTR_KEEPALIVE_INTERVAL,
+	OVPN_SET_PEER_ATTR_KEEPALIVE_TIMEOUT,
+
+	__OVPN_SET_PEER_ATTR_AFTER_LAST,
+	OVPN_SET_PEER_ATTR_MAX = __OVPN_SET_PEER_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_del_peer_attrs {
+	OVPN_DEL_PEER_ATTR_UNSPEC = 0,
+	OVPN_DEL_PEER_ATTR_REASON,
+	OVPN_DEL_PEER_ATTR_PEER_ID,
+
+	__OVPN_DEL_PEER_ATTR_AFTER_LAST,
+	OVPN_DEL_PEER_ATTR_MAX = __OVPN_DEL_PEER_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_get_peer_attrs {
+	OVPN_GET_PEER_ATTR_UNSPEC = 0,
+	OVPN_GET_PEER_ATTR_PEER_ID,
+
+	__OVPN_GET_PEER_ATTR_AFTER_LAST,
+	OVPN_GET_PEER_ATTR_MAX = __OVPN_GET_PEER_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_get_peer_response_attrs {
+	OVPN_GET_PEER_RESP_ATTR_UNSPEC = 0,
+	OVPN_GET_PEER_RESP_ATTR_PEER_ID,
+	OVPN_GET_PEER_RESP_ATTR_SOCKADDR_REMOTE,
+	OVPN_GET_PEER_RESP_ATTR_IPV4,
+	OVPN_GET_PEER_RESP_ATTR_IPV6,
+	OVPN_GET_PEER_RESP_ATTR_LOCAL_IP,
+	OVPN_GET_PEER_RESP_ATTR_LOCAL_PORT,
+	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_INTERVAL,
+	OVPN_GET_PEER_RESP_ATTR_KEEPALIVE_TIMEOUT,
+	OVPN_GET_PEER_RESP_ATTR_RX_BYTES,
+	OVPN_GET_PEER_RESP_ATTR_TX_BYTES,
+	OVPN_GET_PEER_RESP_ATTR_RX_PACKETS,
+	OVPN_GET_PEER_RESP_ATTR_TX_PACKETS,
+
+	__OVPN_GET_PEER_RESP_ATTR_AFTER_LAST,
+	OVPN_GET_PEER_RESP_ATTR_MAX = __OVPN_GET_PEER_RESP_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_peer_stats_attrs {
+	OVPN_PEER_STATS_ATTR_UNSPEC = 0,
+	OVPN_PEER_STATS_BYTES,
+	OVPN_PEER_STATS_PACKETS,
+
+	__OVPN_PEER_STATS_ATTR_AFTER_LAST,
+	OVPN_PEER_STATS_ATTR_MAX = __OVPN_PEER_STATS_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_peer_attrs {
+	OVPN_PEER_ATTR_UNSPEC = 0,
+	OVPN_PEER_ATTR_PEER_ID,
+	OVPN_PEER_ATTR_SOCKADDR_REMOTE,
+	OVPN_PEER_ATTR_IPV4,
+	OVPN_PEER_ATTR_IPV6,
+	OVPN_PEER_ATTR_LOCAL_IP,
+	OVPN_PEER_ATTR_KEEPALIVE_INTERVAL,
+	OVPN_PEER_ATTR_KEEPALIVE_TIMEOUT,
+	OVPN_PEER_ATTR_ENCRYPT_KEY,
+	OVPN_PEER_ATTR_DECRYPT_KEY,
+	OVPN_PEER_ATTR_RX_STATS,
+	OVPN_PEER_ATTR_TX_STATS,
+
+	__OVPN_PEER_ATTR_AFTER_LAST,
+	OVPN_PEER_ATTR_MAX = __OVPN_PEER_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_netlink_packet_attrs {
+	OVPN_PACKET_ATTR_UNSPEC = 0,
+	OVPN_PACKET_ATTR_PACKET,
+	OVPN_PACKET_ATTR_PEER_ID,
+
+	__OVPN_PACKET_ATTR_AFTER_LAST,
+	OVPN_PACKET_ATTR_MAX = __OVPN_PACKET_ATTR_AFTER_LAST - 1,
+};
+
+enum ovpn_ifla_attrs {
+	IFLA_OVPN_UNSPEC = 0,
+	IFLA_OVPN_MODE,
+
+	__IFLA_OVPN_AFTER_LAST,
+	IFLA_OVPN_MAX = __IFLA_OVPN_AFTER_LAST - 1,
+};
+
+enum ovpn_mode {
+	__OVPN_MODE_FIRST = 0,
+	OVPN_MODE_P2P = __OVPN_MODE_FIRST,
+	OVPN_MODE_MP,
+
+	__OVPN_MODE_AFTER_LAST,
+};
+
+#endif /* _UAPI_LINUX_OVPN_DCO_H_ */
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4bc35916..60cd574d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -40,6 +40,7 @@
 #include "misc.h"
 #include "networking.h"
 #include "ring_buffer.h"
+#include "dco.h"
 
 #ifdef _WIN32
 #define WINTUN_COMPONENT_ID "wintun"
@@ -214,6 +215,8 @@ struct tuntap
 #endif
     /* used for printing status info only */
     unsigned int rwflags_debug;
+
+    dco_context_t dco;
 };
 
 static inline bool
-- 
2.35.1


