From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Apr 2022 09:08:59 +0200
Message-Id: <20220402070902.30282-5-a@...2181...>
In-Reply-To: <20220402070902.30282-1-a@...2181...>
References: <20220402070902.30282-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/7] ovpn-dco: introduce linux data-channel
 offload support
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

Implement the data-channel offloading using the ovpn-dco kernel
module. See README.dco.md for more details.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 Changes.rst                                |   7 +
 README.dco.md                              | 129 +++
 configure.ac                               |  28 +
 doc/man-sections/advanced-options.rst      |  13 +
 doc/man-sections/server-options.rst        |   6 +
 src/openvpn/Makefile.am                    |   2 +
 src/openvpn/crypto.c                       |   1 +
 src/openvpn/dco.c                          | 607 ++++++++++++++
 src/openvpn/dco.h                          | 305 +++++++
 src/openvpn/dco_internal.h                 |  80 ++
 src/openvpn/dco_linux.c                    | 882 +++++++++++++++++++++
 src/openvpn/dco_linux.h                    |  62 ++
 src/openvpn/errlevel.h                     |   2 +
 src/openvpn/event.h                        |   3 +
 src/openvpn/forward.c                      |  79 +-
 src/openvpn/init.c                         | 172 +++-
 src/openvpn/init.h                         |   2 +-
 src/openvpn/misc.h                         |   3 +-
 src/openvpn/mtcp.c                         |  61 +-
 src/openvpn/mudp.c                         |  13 +
 src/openvpn/multi.c                        | 227 +++++-
 src/openvpn/multi.h                        |   6 +-
 src/openvpn/networking_sitnl.c             |  11 +
 src/openvpn/openvpn.vcxproj                |   4 +-
 src/openvpn/openvpn.vcxproj.filters        |   6 +
 src/openvpn/options.c                      |  29 +
 src/openvpn/options.h                      |  20 +
 src/openvpn/ovpn_dco_linux.h               | 265 +++++++
 src/openvpn/socket.h                       |   1 +
 src/openvpn/ssl.c                          |  80 +-
 src/openvpn/ssl.h                          |   7 +-
 src/openvpn/ssl_common.h                   |  23 +
 src/openvpn/ssl_ncp.c                      |   2 +-
 src/openvpn/tun.c                          | 129 ++-
 src/openvpn/tun.h                          |   6 +-
 tests/unit_tests/openvpn/test_networking.c |   3 +
 36 files changed, 3116 insertions(+), 160 deletions(-)
 create mode 100644 README.dco.md
 create mode 100644 src/openvpn/dco.c
 create mode 100644 src/openvpn/dco.h
 create mode 100644 src/openvpn/dco_internal.h
 create mode 100644 src/openvpn/dco_linux.c
 create mode 100644 src/openvpn/dco_linux.h
 create mode 100644 src/openvpn/ovpn_dco_linux.h

diff --git a/Changes.rst b/Changes.rst
index ceb0b268..23f66716 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -69,6 +69,13 @@ Improved ``--mssfix`` and ``--fragment`` calculation
     account and the resulting size is specified as the total size of the VPN packets
     including IP and UDP headers.
 
+Data channel offloading with ovpn-dco
+    2.6.0+ implements support for data-channel offloading where the data packets
+    are directly processed and forwarded in kernel space thanks to the ovpn-dco
+    kernel module. The userspace openvpn program acts purely as a control plane
+    application.
+
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/README.dco.md b/README.dco.md
new file mode 100644
index 00000000..27c166b9
--- /dev/null
+++ b/README.dco.md
@@ -0,0 +1,129 @@
+OpenVPN data channel offload
+============================
+2.6.0+ implements support for data-channel offloading where the data packets
+are directly processed and forwarded in kernel space thanks to the ovpn-dco
+kernel module. The userspace openvpn program acts purely as a control plane
+application.
+
+
+Overview of current release
+---------------------------
+- See the "Limitations by design" and "Current limitations" sections for
+  features that are not and/or will not be supported by OpenVPN + ovpn-dco
+
+
+Getting started (Linux)
+-----------------------
+
+- Use a recent Linux kernel. Ubuntu 20.04 (Linux 5.4.0) and Ubuntu 20.10
+  (Linux 5.8.0) are known to work with ovpn-dco.
+
+Get the ovpn-dco module from one these urls and build it:
+
+* https://gitlab.com/openvpn/ovpn-dco
+* https://github.com/OpenVPN/ovpn-dco
+
+e.g.
+
+    git clone https://github.com/OpenVPN/ovpn-dco
+    cd ovpn-dco
+    make
+    sudo make install
+
+If you want to report bugs please ensure to compile ovpn-dco with
+`make DEBUG=1` and include any debug message being printed by the
+kernel (you can view those messages with `dmesg`).
+
+Clone OpenVPN and build dco branch. For example:
+
+    git clone -b dco https://github.com/openvpn/openvpn.git
+    cd openvpn
+    autoreconf -vi
+    ./configure --enable-dco
+    make
+    sudo make install # Or run just src/openvpn/openvpn
+
+If you start openvpn it should automatically detect DCO support and use the
+kernel module. Add the option `--disable-dco` to disable data channel offload
+support. If the configuration contains an option that is incompatible with
+data channel offloading OpenVPN will automatically disable DCO support and
+warn the user.
+
+Should OpenVPN be configured to use a feature that is not supported by ovpn-dco
+or should the ovpn-dco kernel module not be available on the system, you will
+see a message like
+
+    Note: Kernel support for ovpn-dco missing, disabling data channel offload.
+
+in your log.
+
+
+DCO and P2P mode
+----------------
+DCO is also available when running OpenVPN in P2P mode without --pull/--client option.
+The P2P mode is useful for scenarios when the OpenVPN tunnel should not interfere with
+overall routing and behave more like a "dumb" tunnel like GRE.
+
+However, DCO requires DATA_V2 to be enabled this requires P2P with NCP capability, which
+is only available in OpenVPN 2.6 and later.
+
+OpenVPN prints a diagnostic message for the P2P NCP result when running in P2P mode:
+
+    P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 9484735, cipher=AES-256-GCM
+
+Double check that your have `DATA_v2=1` in your output and a supported AEAD cipher
+(AES-XXX-GCM or CHACHA20POLY1305).
+
+
+Routing with ovpn-dco
+---------------------
+The ovpn-dco kernel module implements a more transparent approach to
+configuring routes to clients (aka 'iroutes') and consults the kernel
+routing tables for forwarding decisions.
+
+- Each client has an IPv4 VPN IP and/or an IPv6 assigned to it.
+- Additional IP ranges can be routed to a client by adding a route with
+  a client VPN IP as the gateway/nexthop (i.e. ip route add a.b.c.d/24 via $VPNIP).
+- Due to the point above, there is no real need to add a companion --route for
+  each --iroute directive, unless you want to blackhole traffic when the specific
+  client is not connected.
+- No internal routing is available. If you need truly internal routes, this can be
+  achieved either with filtering using `iptables` or using `ip rule`.
+- client-to-client behaviour, as implemented in userspace, does not exist: packets
+  are always sent up to the tunnel interface and then back in to be routed to the
+  destination peer.
+
+
+Limitations by design
+----------------------
+- Layer 3 (dev tun only)
+- only AEAD ciphers are supported and currently only
+  Chacha20-Poly1305 and AES-GCM-128/192/256
+- no support for compression or compression framing
+  - see also `--compress migrate` option to move to a setup with compression
+- various features not implemented since have better replacements
+  - --shaper, use tc instead
+  - packet manipulation, use nftables/iptables instead
+- OpenVPN 2.4.0 is the minimum peer version.
+  - older version are missing support for the AEAD ciphers
+- topology subnet is the only supported `--topology` for servers
+- iroute directives install routes on the host operating system, see also
+  routing with ovpn-dco
+
+
+Current implementation limitations
+-------------------
+- --persistent-tun not tested/supported
+- fallback to non-dco in client mode missing
+- IPv6 mapped IPv4 addresses need Linux 5.12 to properly work
+- Some incompatible options may not properly fallback to non-dco
+- TCP performance with ovpn-dco can still exhibit bad behaviour and drop to a
+  few megabits per seconds.
+- Not all options that should trigger disabling DCO as they are incompatible
+  are currently identified. Some options that do not trigger disabling DCO
+  are ignored while other might yield unexpected results.
+- ovpn-dco currently does not implement RPF checks and will accept any source
+  IP from any client.
+- If a peer VPN IP is outside the default device subnet, the route needs to be
+  added manually.
+- No per client statistics. Only total statistics available on the interface.
diff --git a/configure.ac b/configure.ac
index 9c898718..fa00abb5 100644
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
@@ -760,6 +767,26 @@ PKG_CHECK_MODULES(
 	[]
 )
 
+
+
+if test "$enable_dco" = "yes"; then
+dnl
+dnl Include generic netlink library used to talk to ovpn-dco
+dnl
+
+	PKG_CHECK_MODULES([LIBNL_GENL],
+			  [libnl-genl-3.0 >= 3.2.29],
+			  [have_libnl="yes"],
+			  [AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer])]
+	)
+
+	CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
+	LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+
+	AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
+	AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+fi
+
 if test "${with_crypto_library}" = "openssl"; then
 	AC_ARG_VAR([OPENSSL_CFLAGS], [C compiler flags for OpenSSL])
 	AC_ARG_VAR([OPENSSL_LIBS], [linker flags for OpenSSL])
@@ -1196,6 +1223,7 @@ fi
 AM_CONDITIONAL([HAVE_SITNL], [false])
 
 if test "${enable_iproute2}" = "yes"; then
+	test "${enable_dco}" = "yes" && AC_MSG_ERROR([iproute2 support cannot be enabled when using DCO])
 	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missing])
 	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
 else if test "${have_sitnl}" = "yes"; then
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 5157c561..cdec9502 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -91,3 +91,16 @@ used when debugging or testing out special usage scenarios.
   *(Linux only)* Set the TX queue length on the TUN/TAP interface.
   Currently defaults to operating system default.
 
+--disable-dco
+  Disables the opportunistic use the data channel offloading if available.
+  Without this option, OpenVPN will opportunistically use DCO mode if
+  the config options and the running kernel supports using DCO.
+
+  Data channel offload currently requires data-ciphers to only contain
+  AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the
+  ovpn-dco module.
+
+  Note that some options have no effect or not available when
+  DCO mode is enabled.
+
+  A platforms that do not support DCO ``disable-dco`` has no effect.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 08ee7bd3..40cf9a3c 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -321,6 +321,12 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   from the kernel to OpenVPN. Once in OpenVPN, the ``--iroute`` directive
   routes to the specific client.
 
+  When using DCO, the extra ``--route`` directive is required only if the
+  expected behaviour is to route the traffic for a specific network to the VPN
+  interface also when the responsible client is not connected (traffic
+  will then be dropped). In the other cases the ``--iroute`` directive is
+  enough for DCO to fully configure the routing table.
+
   This option must be specified either in a client instance config file
   using ``--client-config-dir`` or dynamically generated using a
   ``--client-connect`` script.
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index fc22feb9..af801b1d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -53,6 +53,8 @@ openvpn_SOURCES = \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
+	dco.c dco.h dco_internal.h \
+	dco_linux.c dco_linux.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
 	env_set.c env_set.h \
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9e10f64e..7e49d710 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -845,6 +845,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
              cipher_kt_iv_size(kt->cipher));
         warn_insecure_key_type(ciphername);
     }
+
     if (md_defined(kt->digest))
     {
         ctx->hmac = hmac_ctx_new();
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
new file mode 100644
index 00000000..8d4970e2
--- /dev/null
+++ b/src/openvpn/dco.c
@@ -0,0 +1,607 @@
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
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#if defined(ENABLE_DCO)
+
+#include "syshead.h"
+#include "errlevel.h"
+#include "networking.h"
+#include "multi.h"
+#include "ssl_verify.h"
+#include "ssl_ncp.h"
+#include "dco.h"
+
+static bool
+dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
+                        struct sockaddr_storage *local)
+{
+#if ENABLE_IP_PKTINFO
+    struct context *c = &mi->context;
+
+    if (!(c->options.sockflags & SF_USE_IP_PKTINFO))
+    {
+        return false;
+    }
+
+    struct link_socket_actual *actual = &c->c2.link_socket_info->lsa->actual;
+
+    switch(actual->dest.addr.sa.sa_family)
+    {
+    case AF_INET:
+    {
+        struct sockaddr_in *sock_in4 = (struct sockaddr_in *)local;
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
+        sock_in4->sin_addr = actual->pi.in4.ipi_addr;
+#elif defined(IP_RECVDSTADDR)
+        sock_in4->sin_addr = actual->pi.in4;
+#else
+        /* source IP not available on this platform */
+        return false;
+#endif
+        sock_in4->sin_family = AF_INET;
+        break;
+    }
+    case AF_INET6:
+    {
+        struct sockaddr_in6 *sock_in6 = (struct sockaddr_in6 *)local;
+        sock_in6->sin6_addr = actual->pi.in6.ipi6_addr;
+        sock_in6->sin6_family = AF_INET6;
+        break;
+    }
+    default:
+        ASSERT(false);
+    }
+
+    return true;
+#else
+    return false;
+#endif
+}
+
+int
+dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+{
+    struct context *c = &mi->context;
+
+    int peer_id = mi->context.c2.tls_multi->peer_id;
+    struct sockaddr *remoteaddr, *localaddr = NULL;
+    struct sockaddr_storage local = { 0 };
+    int sd = c->c2.link_socket->sd;
+
+    if (c->mode == CM_CHILD_TCP)
+    {
+        /* the remote address will be inferred from the TCP socket endpoint */
+        remoteaddr = NULL;
+    }
+    else
+    {
+        ASSERT(c->c2.link_socket_info->connection_established);
+        remoteaddr = &c->c2.link_socket_info->lsa->actual.dest.addr.sa;
+    }
+
+    struct in_addr remote_ip4 = { 0 };
+    struct in6_addr *remote_addr6 = NULL;
+    struct in_addr *remote_addr4 = NULL;
+
+    /* In server mode we need to fetch the remote addresses from the push config */
+    if (c->c2.push_ifconfig_defined)
+    {
+        remote_ip4.s_addr =  htonl(c->c2.push_ifconfig_local);
+        remote_addr4 = &remote_ip4;
+    }
+    if (c->c2.push_ifconfig_ipv6_defined)
+    {
+        remote_addr6 = &c->c2.push_ifconfig_ipv6_local;
+    }
+
+    if (dco_multi_get_localaddr(m, mi, &local))
+    {
+        localaddr = (struct sockaddr *)&local;
+    }
+
+    int ret = dco_new_peer(&c->c1.tuntap->dco, peer_id, sd, localaddr,
+                           remoteaddr, remote_addr4, remote_addr6);
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    c->c2.tls_multi->dco_peer_added = true;
+
+    if (c->mode == CM_CHILD_TCP)
+    {
+        multi_tcp_dereference_instance(m->mtcp, mi);
+        if (close(sd))
+        {
+            msg(D_DCO|M_ERRNO, "error closing TCP socket after DCO handover");
+        }
+        c->c2.link_socket->info.dco_installed = true;
+        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+    }
+
+    return 0;
+}
+
+int
+dco_p2p_add_new_peer(struct context *c)
+{
+    if (!dco_enabled(&c->options))
+    {
+        return 0;
+    }
+
+    struct tls_multi *multi = c->c2.tls_multi;
+    struct link_socket *ls = c->c2.link_socket;
+
+    struct in6_addr remote_ip6 = { 0 };
+    struct in_addr remote_ip4 = { 0 };
+
+    struct in6_addr *remote_addr6 = NULL;
+    struct in_addr *remote_addr4 = NULL;
+
+    const char *gw = NULL;
+
+    /* In client mode if a P2P style topology is used we assume the
+     * remote-gateway is the IP of the peer */
+    if (c->options.topology == TOP_NET30 || c->options.topology == TOP_P2P)
+    {
+        gw = c->options.ifconfig_remote_netmask;
+    }
+    if (c->options.route_default_gateway)
+    {
+        gw = c->options.route_default_gateway;
+    }
+
+    /* These inet_pton conversion are fatal since options.c already implements
+     * checks to have only valid addresses when setting the options */
+    if (c->options.ifconfig_ipv6_remote)
+    {
+        if (inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote, &remote_ip6) != 1)
+        {
+            msg(M_FATAL,
+                "DCO peer init: problem converting IPv6 ifconfig remote address %s to binary",
+                c->options.ifconfig_ipv6_remote);
+        }
+        remote_addr6 = &remote_ip6;
+    }
+
+    if (gw)
+    {
+        if (inet_pton(AF_INET, gw, &remote_ip4) != 1)
+        {
+            msg(M_FATAL, "DCO peer init: problem converting IPv4 ifconfig gateway address %s to binary", gw);
+        }
+        remote_addr4 = &remote_ip4;
+    }
+    else if (c->options.ifconfig_local)
+    {
+        msg(M_INFO, "DCO peer init: Need a peer VPN addresss to setup IPv4 (set --route-gateway)");
+    }
+
+    if (dco_enabled(&c->options) && !c->c2.link_socket->info.dco_installed)
+    {
+        ASSERT(ls->info.connection_established);
+
+        struct sockaddr *remoteaddr = &ls->info.lsa->actual.dest.addr.sa;
+
+        int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
+                               c->c2.link_socket->sd, NULL, remoteaddr,
+                               remote_addr4, remote_addr6);
+        if (ret < 0)
+        {
+            return ret;
+        }
+
+        c->c2.tls_multi->dco_peer_added = true;
+        c->c2.link_socket->info.dco_installed = true;
+    }
+
+    return 0;
+}
+
+void dco_remove_peer(struct context *c)
+{
+    if (!dco_enabled(&c->options))
+    {
+        return;
+    }
+    if (c->c1.tuntap && c->c2.tls_multi && c->c2.tls_multi->dco_peer_added)
+    {
+        c->c2.tls_multi->dco_peer_added = false;
+        dco_del_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id);
+    }
+}
+
+/**
+ * Find a usable key that is not the primary (i.e. the secondary key)
+ *
+ * @param multi     The TLS struct to retrieve keys from
+ * @param primary   The primary key that should be skipped doring the scan
+ *
+ * @return          The secondary key or NULL if none could be found
+ */
+static struct key_state *
+dco_get_secondary_key(struct tls_multi *multi, const struct key_state *primary)
+{
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+
+        if (ks == primary)
+        {
+            continue;
+        }
+
+        if (ks->state >= S_GENERATED_KEYS && ks->authenticated == KS_AUTH_TRUE)
+        {
+            ASSERT(key->initialized);
+            return ks;
+        }
+    }
+
+    return NULL;
+}
+
+void
+dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
+{
+    msg(D_DCO_DEBUG, "%s: peer_id=%d", __func__, multi->peer_id);
+
+    /* this function checks if keys have to be swapped or erased, therefore it
+     * can't do much if we don't have any key installed
+     */
+    if (multi->dco_keys_installed == 0)
+    {
+        return;
+    }
+
+    struct key_state *primary = tls_select_encryption_key(multi);
+    ASSERT(!primary || primary->dco_status != DCO_NOT_INSTALLED);
+
+    /* no primary key available -> no usable key exists, therefore we should
+     * tell DCO to simply wipe all keys
+     */
+    if (!primary)
+    {
+        msg(D_DCO, "No encryption key found. Purging data channel keys");
+
+        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_PRIMARY);
+        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        multi->dco_keys_installed = 0;
+        return;
+    }
+
+    struct key_state *secondary = dco_get_secondary_key(multi, primary);
+    ASSERT(!secondary || secondary->dco_status != DCO_NOT_INSTALLED);
+
+    /* the current primary key was installed as secondary in DCO, this means
+     * that userspace has promoted it and we should tell DCO to swap keys
+     */
+    if (primary->dco_status == DCO_INSTALLED_SECONDARY)
+    {
+        msg(D_DCO_DEBUG, "Swapping primary and secondary keys, now: id1=%d id2=%d",
+            primary->key_id, secondary ? secondary->key_id : -1);
+
+        dco_swap_keys(dco, multi->peer_id);
+        primary->dco_status = DCO_INSTALLED_PRIMARY;
+        if (secondary)
+        {
+            secondary->dco_status = DCO_INSTALLED_SECONDARY;
+        }
+    }
+
+    /* if we have no secondary key anymore, inform DCO about it */
+    if (!secondary && multi->dco_keys_installed == 2)
+    {
+        dco_del_key(dco, multi->peer_id, OVPN_KEY_SLOT_SECONDARY);
+        multi->dco_keys_installed = 1;
+    }
+
+    /* all keys that are not installed are set to NOT installed */
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        if (ks != primary && ks != secondary)
+        {
+            ks->dco_status = DCO_NOT_INSTALLED;
+        }
+    }
+}
+
+static int
+dco_install_key(struct tls_multi *multi, struct key_state *ks,
+                const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+                const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+                const char *ciphername)
+
+{
+    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d", __func__, multi->peer_id,
+        ks->key_id);
+
+    /* Install a key in the PRIMARY slot only when no other key exist.
+     * From that moment on, any new key will be installed in the SECONDARY
+     * slot and will be promoted to PRIMARY when userspace says so (a swap
+     * will be performed in that case)
+     */
+    dco_key_slot_t slot = OVPN_KEY_SLOT_PRIMARY;
+    if (multi->dco_keys_installed > 0)
+    {
+        slot = OVPN_KEY_SLOT_SECONDARY;
+    }
+
+    int ret = dco_new_key(multi->dco, multi->peer_id, ks->key_id, slot,
+                          encrypt_key, encrypt_iv,
+                          decrypt_key, decrypt_iv,
+                          ciphername);
+    if ((ret == 0) && (multi->dco_keys_installed < 2))
+    {
+        multi->dco_keys_installed++;
+        switch (slot)
+        {
+            case OVPN_KEY_SLOT_PRIMARY:
+                ks->dco_status = DCO_INSTALLED_PRIMARY;
+                break;
+            case OVPN_KEY_SLOT_SECONDARY:
+                ks->dco_status = DCO_INSTALLED_SECONDARY;
+                break;
+            default:
+                ASSERT(false);
+        }
+    }
+
+    return ret;
+}
+
+int
+init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
+                const struct key2 *key2, int key_direction,
+                const char *ciphername, bool server)
+{
+    struct key_direction_state kds;
+    key_direction_state_init(&kds, key_direction);
+
+    return dco_install_key(multi, ks,
+                           key2->keys[kds.out_key].cipher,
+                           key2->keys[(int)server].hmac,
+                           key2->keys[kds.in_key].cipher,
+                           key2->keys[1 - (int)server].hmac,
+                           ciphername);
+}
+
+static bool
+dco_check_option_conflict_ce(const struct connection_entry *ce, int msglevel)
+{
+    if (ce->fragment)
+    {
+        msg(msglevel, "Note: --fragment disables data channel offload.");
+        return true;
+    }
+
+    if (ce->http_proxy_options)
+    {
+        msg(msglevel, "Note: --http-proxy disables data channel offload.");
+        return true;
+    }
+
+    if (ce->socks_proxy_server)
+    {
+        msg(msglevel, "Note --socks-proxy disable data channel offload.");
+        return true;
+    }
+
+    return false;
+}
+
+bool
+dco_check_option_conflict(int msglevel, const struct options *o)
+{
+    if (o->tuntap_options.disable_dco)
+    {
+        /* already disabled by --disable-dco, no need to print warnings */
+        return true;
+    }
+
+    if (!dco_available(msglevel))
+    {
+        return true;
+    }
+
+    if (dev_type_enum(o->dev, o->dev_type) != DEV_TYPE_TUN)
+    {
+        msg(msglevel, "Note: dev-type not tun, disabling data channel offload.");
+        return true;
+    }
+
+    /* At this point the ciphers have already been normalised */
+    if (o->enable_ncp_fallback
+        && !tls_item_in_cipher_list(o->ciphername, DCO_SUPPORTED_CIPHERS))
+    {
+        msg(msglevel, "Note: --data-cipher-fallback with cipher '%s' "
+                      "disables data channel offload.", o->ciphername);
+        return true;
+    }
+
+    if (o->connection_list)
+    {
+        const struct connection_list *l = o->connection_list;
+        for (int i = 0; i < l->len; ++i)
+        {
+            if (dco_check_option_conflict_ce(l->array[i], msglevel))
+            {
+                return true;
+            }
+        }
+    }
+    else
+    {
+        if (dco_check_option_conflict_ce(&o->ce, msglevel))
+        {
+            return true;
+        }
+    }
+
+    if (o->mode == MODE_SERVER && o->topology != TOP_SUBNET)
+    {
+        msg(msglevel, "Note: NOT using '--topology subnet' disables data channel offload.");
+        return true;
+    }
+
+#ifdef USE_COMP
+    if(o->comp.alg != COMP_ALG_UNDEF)
+    {
+        msg(msglevel, "Note: Using compression disables data channel offload.");
+
+        if (o->mode == MODE_SERVER && !(o->comp.flags & COMP_F_MIGRATE))
+        {
+            /* We can end up here from the multi.c call, only print the
+             * note if it is not already enabled */
+            msg(msglevel, "Consider using the '--compress migrate' option.");
+        }
+        return true;
+    }
+#endif
+
+    struct gc_arena gc = gc_new();
+
+
+    char *tmp_ciphers = string_alloc(o->ncp_ciphers, &gc);
+    const char *token;
+    while ((token = strsep(&tmp_ciphers, ":")))
+    {
+        if (!tls_item_in_cipher_list(token, DCO_SUPPORTED_CIPHERS))
+        {
+            msg(msglevel, "Note: cipher '%s' in --data-ciphers is not supported "
+                "by ovpn-dco, disabling data channel offload.", token);
+            gc_free(&gc);
+            return true;
+        }
+    }
+    gc_free(&gc);
+
+    return false;
+}
+
+/* These methods are currently Linux specific but likely to be used any
+ * platform that implements Server side DCO
+ */
+
+void
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                   struct mroute_addr *addr)
+{
+#if defined(TARGET_LINUX)
+    if (!dco_enabled(&m->top.options))
+    {
+        return;
+    }
+
+    int addrtype = (addr->type & MR_ADDR_MASK);
+
+    /* If we do not have local IP addr to install, skip the route */
+    if ((addrtype == MR_ADDR_IPV6 && !mi->context.c2.push_ifconfig_ipv6_defined)
+        || (addrtype == MR_ADDR_IPV4 && !mi->context.c2.push_ifconfig_defined))
+    {
+        return;
+    }
+
+    struct context *c = &mi->context;
+    const char *dev = c->c1.tuntap->actual_name;
+
+    if (addrtype == MR_ADDR_IPV6)
+    {
+        int netbits = 128;
+        if (addr->type & MR_WITH_NETBITS)
+        {
+            netbits = addr->netbits;
+        }
+
+        net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, netbits,
+                         &mi->context.c2.push_ifconfig_ipv6_local, dev, 0,
+                         DCO_IROUTE_METRIC);
+    }
+    else if (addrtype == MR_ADDR_IPV4)
+    {
+        int netbits = 32;
+        if (addr->type & MR_WITH_NETBITS)
+        {
+            netbits = addr->netbits;
+        }
+
+        in_addr_t dest = htonl(addr->v4.addr);
+        net_route_v4_add(&m->top.net_ctx, &dest, netbits,
+                         &mi->context.c2.push_ifconfig_local, dev, 0,
+                         DCO_IROUTE_METRIC);
+    }
+#endif
+}
+
+void
+dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+{
+#if defined(TARGET_LINUX)
+    if (!dco_enabled(&m->top.options))
+    {
+        return;
+    }
+    ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN);
+
+    struct context *c = &mi->context;
+    const char *dev = c->c1.tuntap->actual_name;
+
+    if (mi->context.c2.push_ifconfig_defined)
+    {
+        for (const struct iroute *ir = c->options.iroutes;
+             ir;
+             ir = ir->next)
+        {
+            net_route_v4_del(&m->top.net_ctx, &ir->network, ir->netbits,
+                             &mi->context.c2.push_ifconfig_local, dev,
+                             0, DCO_IROUTE_METRIC);
+        }
+    }
+
+    if (mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        for (const struct iroute_ipv6 *ir6 = c->options.iroutes_ipv6;
+             ir6;
+             ir6 = ir6->next)
+        {
+            net_route_v6_del(&m->top.net_ctx, &ir6->network, ir6->netbits,
+                             &mi->context.c2.push_ifconfig_ipv6_local, dev,
+                             0, DCO_IROUTE_METRIC);
+        }
+    }
+#endif
+}
+
+#endif /* defined(ENABLE_DCO) */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
new file mode 100644
index 00000000..5734e760
--- /dev/null
+++ b/src/openvpn/dco.h
@@ -0,0 +1,305 @@
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
+#include "crypto.h"
+#include "networking.h"
+#include "dco_internal.h"
+
+/* forward declarations, including multi.h leads to nasty include
+ * order problems */
+struct context;
+struct key_state;
+struct multi_context;
+struct multi_instance;
+struct mroute_addr;
+struct tls_multi;
+struct tuntap;
+struct event_set;
+
+#if defined(TARGET_LINUX)
+#define DCO_DEFAULT_METRIC  200
+#else
+#define DCO_DEFAULT_METRIC  0
+#endif
+
+#if defined(ENABLE_DCO)
+
+/**
+ * Check whether the options struct has any option that is not supported by
+ * our current dco implementation. If so it print a warning at warning level
+ * for the first conflicting option found and return true.
+ *
+ * @param msglevel  the msg level to use to print the warnings
+ * @param o         the optiions struct that hold the options
+ * @return          true if a conflict was detected, false otherwise
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
+ * Install a new peer in DCO - to be called by a SERVER instance
+ *
+ * @param m         the server context
+ * @param mi        the client instance
+ * @return          0 on success or a negative error code otherwise
+ */
+int dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi);
+
+/**
+ * Install a new peer in DCO - to be called by a CLIENT (or P2P) instance
+ *
+ * @param c         the main instance context
+ * @return          0 on success or a negative error code otherwise
+ */
+int dco_p2p_add_new_peer(struct context *c);
+
+/**
+ * Remove a peer from DCO
+ *
+ * @param c         the main instance context of the peer to remove
+ */
+void dco_remove_peer(struct context *c);
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
+ * Install an iroute in DCO, which means adding a route to the system routing
+ * table. To be called by a SERVER instance only.
+ *
+ * @param m         the server context
+ * @param mi        the client instance acting as nexthop for the route
+ * @param addr      the route to add
+ */
+void dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                        struct mroute_addr *addr);
+
+/**
+ * Remove all routes added through the specified client
+ *
+ * @param m         the server context
+ * @param mi        the client instance for which routes have to be removed
+ */
+void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
+
+/**
+ * Install the key material in DCO for the specified peer, at the specified slot
+ *
+ * @param multi     the TLS context of the current instance
+ * @param ks        the state of the key being installed
+ * @param key2      the container for the raw key material
+ * @param key_direction the key direction to be used to extract the material
+ * @param ciphername    the name of the cipher to use the key with
+ * @param server    whether we are running on a server instance or not
+ *
+ * @return          0 on success or a negative error code otherwise
+ */
+int init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
+                    const struct key2 *key2, int key_direction,
+                    const char *ciphername, bool server);
+
+/**
+ * Possibly swaps or wipes keys from DCO
+ *
+ * @param dco           DCO device context
+ * @param multi         TLS multi instance
+ */
+void dco_update_keys(dco_context_t *dco, struct tls_multi *multi);
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
+ * Installs a DCO in the main event loop
+ */
+void dco_event_set(dco_context_t *dco, struct event_set *es, void *arg);
+
+/**
+ * Modify DCO peer options. Special values are 0 (disable)
+ * and -1 (do not touch).
+ *
+ * @param dco                DCO device context
+ * @param peer_id            the ID of the peer to be modified
+ * @param keepalive_interval keepalive interval in seconds
+ * @param keepalive_timeout  keepalive timeout in seconds
+ * @param mss                TCP MSS value
+ *
+ * @return                   0 on success or a negative error code otherwise
+ */
+int dco_set_peer(dco_context_t *dco, unsigned int peerid,
+                 int keepalive_interval, int keepalive_timeout, int mss);
+
+#else
+
+typedef void *dco_context_t;
+
+static inline bool
+dco_check_option_conflict(int msglevel, const struct options *o)
+{
+    return true;
+}
+
+static inline bool
+ovpn_dco_init(int mode, dco_context_t *dco)
+{
+    return true;
+}
+
+static inline void
+dco_install_iroute(struct multi_context *m, struct multi_instance *mi,
+                   struct mroute_addr *addr)
+{
+}
+
+static inline void
+dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
+{
+}
+
+static inline int
+open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char* dev)
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
+init_key_dco_bi(struct tls_multi *multi, struct key_state *ks,
+                    const struct key2 *key2, int key_direction,
+                    const char *ciphername, bool server)
+{
+    ASSERT(false);
+}
+
+static inline void
+dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
+{
+    ASSERT(false);
+}
+
+static inline bool
+dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+{
+    return true;
+}
+
+static inline bool
+dco_p2p_add_new_peer(struct context *c)
+{
+    return true;
+}
+
+static inline int
+dco_set_peer(dco_context_t *dco, unsigned int peerid,
+             int keepalive_interval, int keepalive_timeout, int mss)
+{
+    return 0;
+}
+
+static inline void
+dco_remove_peer(struct context *c)
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
+static inline bool
+dco_available(int msglevel)
+{
+    return false;
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
index 00000000..0737a607
--- /dev/null
+++ b/src/openvpn/dco_internal.h
@@ -0,0 +1,80 @@
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
+ * It is expected that this file is included only in dco.h after including the
+ * platform specific DCO header (i.e. dco_linux.h or dco_win.h).
+ *
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
+    else if (strcmp(cipher, "none") == 0)
+    {
+        return OVPN_CIPHER_ALG_NONE;
+    }
+    else
+    {
+        msg(M_FATAL, "DCO: provided unsupported cipher: %s", cipher);
+    }
+}
+
+/**
+ * The following are the DCO APIs used to control the driver.
+ * They are implemented by either dco_linux.c or dco_win.c
+ */
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 struct in_addr *remote_in4, struct in6_addr *remote_in6);
+int dco_del_peer(dco_context_t *dco, unsigned int peerid);
+int dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+                dco_key_slot_t slot,
+                const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+                const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+                const char *ciphername);
+int dco_del_key(dco_context_t *dco, unsigned int peerid,
+                dco_key_slot_t slot);
+int dco_swap_keys(dco_context_t *dco, unsigned int peerid);
+
+#endif /* defined(ENABLE_DCO) */
+#endif /* ifndef DCO_INTERNAL_H */
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
new file mode 100644
index 00000000..739f981f
--- /dev/null
+++ b/src/openvpn/dco_linux.c
@@ -0,0 +1,882 @@
+/*
+ *  Interface to linux dco networking code
+ *
+ *  Copyright (C) 2020-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2021 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
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
+	nla_nest_start(_msg, (_type) | NLA_F_NESTED)
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
+ * support DCO offloading.
+ *
+ * @return ID on success, negative error code on error
+ */
+static int
+resolve_ovpn_netlink_id(int msglevel)
+{
+    int ret;
+    struct nl_sock* nl_sock = nl_socket_alloc();
+
+    ret = genl_connect(nl_sock);
+    if (ret)
+    {
+        msg(msglevel, "Cannot connect to generic netlink: %s",
+                nl_geterror(ret));
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
+    switch (ret) {
+    case -NLE_INTR:
+        msg(M_WARN, "%s: netlink received interrupt due to signal - ignoring", prefix);
+        break;
+    case -NLE_NOMEM:
+        msg(M_ERR, "%s: netlink out of memory error", prefix);
+        break;
+    case -M_ERR:
+        msg(M_WARN, "%s: netlink reports blocking read - aborting wait", prefix);
+        break;
+    case -NLE_NODEV:
+        msg(M_ERR, "%s: netlink reports device not found:", prefix);
+        break;
+    case -NLE_OBJ_NOTFOUND:
+        msg(M_INFO, "%s: netlink reports object not found, ovpn-dco unloaded?", prefix);
+        break;
+    default:
+        if (ret)
+        {
+            msg(M_NONFATAL|M_ERRNO, "%s: netlink reports error (%d): %s", prefix, ret, nl_geterror(-ret));
+        }
+        break;
+    }
+
+    return ret;
+}
+
+/**
+ * Send a preprared netlink message and registers cb as callback if non-null.
+ *
+ * The method will also free nl_msg
+ * @param dco       The dco context to use
+ * @param nl_msg    the message to use
+ * @param cb        An optional callback if the caller expects an answers\
+ * @param prefix    A prefix to report in the error message to give the user context
+ * @return          status of sending the message
+ */
+static int
+ovpn_nl_msg_send(dco_context_t *dco, struct nl_msg *nl_msg, ovpn_nl_cb cb,
+                 const char* prefix)
+{
+    dco->status = 1;
+
+    if (cb)
+    {
+        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, cb, dco);
+    }
+    else
+    {
+        nl_cb_set(dco->nl_cb, NL_CB_VALID, NL_CB_CUSTOM, NULL, dco);
+    }
+
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
+    struct sockaddr_in6 *sock6 = ((struct sockaddr_in6 *)sock);
+    if (sock->sa_family == AF_INET6 &&
+        memcmp(&sock6->sin6_addr, "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xff\xff", 12)==0)
+    {
+
+        struct sockaddr_in* sock4;
+        ALLOC_OBJ_CLEAR_GC(sock4, struct sockaddr_in, gc);
+        memcpy (&sock4->sin_addr, sock6->sin6_addr.s6_addr +12, 4);
+        sock4->sin_port = sock6->sin6_port;
+        sock4->sin_family = AF_INET;
+        return (struct sockaddr *) sock4;
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
+ovpn_nl_cb_finish(struct nl_msg (*msg)__attribute__((unused)), void *arg)
+{
+    int *status = arg;
+
+    *status = 0;
+    return NL_SKIP;
+}
+
+static int
+ovpn_nl_cb_error(struct sockaddr_nl (*nla)__attribute__((unused)),
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
+        return NL_STOP;
+
+    if (!(nlh->nlmsg_flags & NLM_F_CAPPED))
+        ack_len += err->msg.nlmsg_len - sizeof(*nlh);
+
+    if (len <= ack_len)
+        return NL_STOP;
+
+    attrs = (void *)((unsigned char *)nlh + ack_len);
+    len -= ack_len;
+
+    nla_parse(tb_msg, NLMSGERR_ATTR_MAX, attrs, len, NULL);
+    if (tb_msg[NLMSGERR_ATTR_MSG]) {
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
+        case CM_P2P:
+            dco->ifmode = OVPN_MODE_P2P;
+            break;
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
+    memset(dco, 0, sizeof(*dco));
+}
+
+static void ovpn_dco_register(dco_context_t *dco)
+{
+    msg(D_DCO_DEBUG, __func__);
+    ovpn_get_mcast_id(dco);
+
+    if (dco->ovpn_dco_mcast_id < 0)
+    {
+        msg(M_ERR, "cannot get mcast group: %s",  nl_geterror(dco->ovpn_dco_mcast_id));
+    }
+
+    /* Register for Ovpn dco specific messages */
+    int ret = nl_socket_add_membership(dco->nl_sock, dco->ovpn_dco_mcast_id);
+    if (ret)
+    {
+        msg(M_ERR, "%s: failed to join groups: %d", __func__, ret);
+    }
+
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
+    int ret = net_iface_new(ctx, dev, IFACE_OVPN_DCO, &tt->dco);
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
+        return -ENOMEM;
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
+        return -ENOMEM;
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
+        return -ENOMEM;
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
+        return -ENOMEM;
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
+static int mcast_family_handler(struct nl_msg *msg, void *arg)
+{
+    dco_context_t *dco = arg;
+    struct nlattr *tb[CTRL_ATTR_MAX + 1];
+    struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+
+    nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0),
+              genlmsg_attrlen(gnlh, 0), NULL);
+
+    if (!tb[CTRL_ATTR_MCAST_GROUPS])
+        return NL_SKIP;
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
+        if (!tb_mcgrp[CTRL_ATTR_MCAST_GRP_NAME] ||
+            !tb_mcgrp[CTRL_ATTR_MCAST_GRP_ID])
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
+  */
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
+static int ovpn_handle_msg(struct nl_msg *msg, void *arg)
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
+    switch (gnlh->cmd) {
+    case OVPN_CMD_DEL_PEER:
+    {
+        if (!attrs[OVPN_ATTR_DEL_PEER])
+        {
+            msg(D_DCO, "ovpn-dco: no attributes in OVPN_DEL_PEER message");
+            return NL_SKIP;
+        }
+
+        struct nlattr *dp_attrs[OVPN_DEL_PEER_ATTR_MAX + 1];
+        if (nla_parse_nested(dp_attrs, OVPN_DEL_PEER_ATTR_MAX,
+                             attrs[OVPN_ATTR_DEL_PEER], NULL))
+        {
+            msg(D_DCO, "received bogus del peer packet data from ovpn-dco");
+            return NL_SKIP;
+        }
+
+        if (!dp_attrs[OVPN_DEL_PEER_ATTR_REASON])
+        {
+            msg(D_DCO, "ovpn-dco: no reason in DEL_PEER message");
+            return NL_SKIP;
+        }
+        if (!dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID])
+        {
+            msg(D_DCO, "ovpn-dco: no peer-id in DEL_PEER message");
+            return NL_SKIP;
+        }
+        int reason = nla_get_u8(dp_attrs[OVPN_DEL_PEER_ATTR_REASON]);
+        unsigned int peerid = nla_get_u32(dp_attrs[OVPN_DEL_PEER_ATTR_PEER_ID]);
+
+        msg(D_DCO_DEBUG, "ovpn-dco: received CMD_DEL_PEER, ifindex: %d, peer-id %d, reason: %d",
+            ifindex, peerid, reason);
+        dco->dco_message_peer_id = peerid;
+        dco->dco_del_peer_reason = reason;
+        dco->dco_message_type = OVPN_CMD_DEL_PEER;
+
+        break;
+    }
+    case OVPN_CMD_PACKET:
+    {
+        if (!attrs[OVPN_ATTR_PACKET])
+        {
+            msg(D_DCO, "ovpn-dco: no packet in OVPN_CMD_PACKET message");
+            return NL_SKIP;
+        }
+        struct nlattr *pkt_attrs[OVPN_PACKET_ATTR_MAX + 1];
+
+        if (nla_parse_nested(pkt_attrs, OVPN_PACKET_ATTR_MAX,
+                             attrs[OVPN_ATTR_PACKET], NULL))
+        {
+            msg(D_DCO, "received bogus cmd packet data from ovpn-dco");
+            return NL_SKIP;
+        }
+        if (!pkt_attrs[OVPN_PACKET_ATTR_PEER_ID])
+        {
+            msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without peer id");
+            return NL_SKIP;
+        }
+        if (!pkt_attrs[OVPN_PACKET_ATTR_PACKET])
+        {
+            msg(D_DCO, "ovpn-dco: Received OVPN_CMD_PACKET message without packet");
+            return NL_SKIP;
+        }
+
+        unsigned int peerid = nla_get_u32(pkt_attrs[OVPN_PACKET_ATTR_PEER_ID]);
+
+        uint8_t *data = nla_data(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
+        int len = nla_len(pkt_attrs[OVPN_PACKET_ATTR_PACKET]);
+
+        msg(D_DCO_DEBUG, "ovpn-dco: received OVPN_PACKET_ATTR_PACKET, ifindex: %d peer-id: %d, len %d",
+            ifindex, peerid, len);
+        if (BLEN(&dco->dco_packet_in) > 0)
+        {
+            msg(D_DCO, "DCO packet buffer still full?!");
+            return NL_SKIP;
+        }
+        buf_init(&dco->dco_packet_in, 0);
+        buf_write(&dco->dco_packet_in, data, len);
+        dco->dco_message_peer_id = peerid;
+        dco->dco_message_type = OVPN_CMD_PACKET;
+        break;
+    }
+    default:
+        msg(D_DCO, "ovpn-dco: received unknown command: %d", gnlh->cmd);
+        dco->dco_message_type = 0;
+        return NL_SKIP;
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
index 00000000..0a02adfa
--- /dev/null
+++ b/src/openvpn/dco_linux.h
@@ -0,0 +1,62 @@
+/*
+ *  Interface to linux dco networking code
+ *
+ *  Copyright (C) 2020-2021 Antonio Quartulli <a@...2181...>
+ *  Copyright (C) 2020-2021 Arne Schwabe <arne@...1227...>
+ *  Copyright (C) 2020-2021 OpenVPN Inc <sales@...515...>
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
+#define DCO_IROUTE_METRIC   100
+#define DCO_DEFAULT_METRIC  200
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
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index a472afbe..f2438f97 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -72,6 +72,9 @@
 #define MANAGEMENT_WRITE    (1 << (MANAGEMENT_SHIFT + WRITE_SHIFT))
 #define FILE_SHIFT          8
 #define FILE_CLOSED         (1 << (FILE_SHIFT + READ_SHIFT))
+#define DCO_SHIFT           10
+#define DCO_READ            (1 << (DCO_SHIFT + READ_SHIFT))
+#define DCO_WRITE           (1 << (DCO_SHIFT + WRITE_SHIFT))
 
 /*
  * Initialization flags passed to event_set_init
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c615eed4..a54ce040 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -41,6 +41,7 @@
 #include "dhcp.h"
 #include "common.h"
 #include "ssl_verify.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -50,7 +51,6 @@ counter_type link_read_bytes_global;  /* GLOBAL */
 counter_type link_write_bytes_global; /* GLOBAL */
 
 /* show event wait debugging info */
-
 #ifdef ENABLE_DEBUG
 
 static const char *
@@ -140,6 +140,18 @@ context_reschedule_sec(struct context *c, int sec)
     }
 }
 
+void
+check_dco_key_status(struct context *c)
+{
+    /* DCO context is not yet initialised or enabled */
+    if (!dco_enabled(&c->options))
+    {
+        return;
+    }
+
+    dco_update_keys(&c->c1.tuntap->dco, c->c2.tls_multi);
+}
+
 /*
  * In TLS mode, let TLS level respond to any control-channel
  * packets which were received, or prepare any packets for
@@ -182,6 +194,12 @@ check_tls(struct context *c)
 
     interval_schedule_wakeup(&c->c2.tmp_int, &wakeup);
 
+    /* Our current code has no good hooks in the TLS machinery to install
+     * the keys to DCO. So we check/install keys after the whole TLS
+     * machinery has been completed
+     */
+    check_dco_key_status(c);
+
     if (wakeup)
     {
         context_reschedule_sec(c, wakeup);
@@ -1083,6 +1101,33 @@ process_incoming_link(struct context *c)
     perf_pop();
 }
 
+static void
+process_incoming_dco(struct context *c)
+{
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    struct link_socket_info *lsi = get_link_socket_info(c);
+    dco_context_t *dco = &c->c1.tuntap->dco;
+
+    dco_do_read(dco);
+
+    if (dco->dco_message_type != OVPN_CMD_PACKET)
+    {
+        msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
+            dco->dco_message_type);
+        return;
+    }
+
+    struct buffer orig_buff = c->c2.buf;
+    c->c2.buf = dco->dco_packet_in;
+    c->c2.from = lsi->lsa->actual;
+
+    process_incoming_link(c);
+
+    c->c2.buf = orig_buff;
+    buf_init(&dco->dco_packet_in, 0);
+#endif
+}
+
 /*
  * Output: c->c2.buf
  */
@@ -1606,9 +1651,19 @@ process_outgoing_link(struct context *c)
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                size = link_socket_write(c->c2.link_socket,
-                                         &c->c2.to_link,
-                                         to_addr);
+#ifdef TARGET_LINUX
+                if (c->c2.link_socket->info.dco_installed)
+                {
+                    size = dco_do_write(&c->c1.tuntap->dco,
+                                        c->c2.tls_multi->peer_id,
+                                        &c->c2.to_link);
+                }
+                else
+#endif
+                {
+                    size = link_socket_write(c->c2.link_socket, &c->c2.to_link,
+                                             to_addr);
+                }
 
                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->c2.to_link);
@@ -1871,6 +1926,9 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 #ifdef ENABLE_ASYNC_PUSH
     static int file_shift = FILE_SHIFT;
 #endif
+#ifdef TARGET_LINUX
+    static int dco_shift = DCO_SHIFT;    /* Event from DCO linux kernel module */
+#endif
 
     /*
      * Decide what kind of events we want to wait for.
@@ -1978,6 +2036,12 @@ io_wait_dowork(struct context *c, const unsigned int flags)
      */
     socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket_shift, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
+#if defined(TARGET_LINUX)
+    if (socket & EVENT_READ && c->c2.did_open_tun)
+    {
+        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)&dco_shift);
+    }
+#endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -2100,4 +2164,11 @@ process_io(struct context *c)
             process_incoming_tun(c);
         }
     }
+    else if (status & DCO_READ)
+    {
+        if(!IS_SIG(c))
+        {
+            process_incoming_dco(c);
+        }
+    }
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 21adc3cf..b3e86078 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -54,6 +54,7 @@
 #include "forward.h"
 #include "auth_token.h"
 #include "mss.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -1299,15 +1300,23 @@ do_init_timers(struct context *c, bool deferred)
     }
 
     /* initialize pings */
-
-    if (c->options.ping_send_timeout)
+    if (dco_enabled(&c->options))
     {
-        event_timeout_init(&c->c2.ping_send_interval, c->options.ping_send_timeout, 0);
+        /* The DCO kernel module will send the pings instead of user space */
+        event_timeout_clear(&c->c2.ping_rec_interval);
+        event_timeout_clear(&c->c2.ping_send_interval);
     }
-
-    if (c->options.ping_rec_timeout)
+    else
     {
-        event_timeout_init(&c->c2.ping_rec_interval, c->options.ping_rec_timeout, now);
+        if (c->options.ping_send_timeout)
+        {
+            event_timeout_init(&c->c2.ping_send_interval, c->options.ping_send_timeout, 0);
+        }
+
+        if (c->options.ping_rec_timeout)
+        {
+            event_timeout_init(&c->c2.ping_rec_interval, c->options.ping_rec_timeout, now);
+        }
     }
 
     if (!deferred)
@@ -1381,13 +1390,13 @@ do_alloc_route_list(struct context *c)
 static void
 do_init_route_list(const struct options *options,
                    struct route_list *route_list,
+                   int metric,
                    const struct link_socket_info *link_socket_info,
                    struct env_set *es,
                    openvpn_net_ctx_t *ctx)
 {
     const char *gw = NULL;
     int dev = dev_type_enum(options->dev, options->dev_type);
-    int metric = 0;
 
     if (dev == DEV_TYPE_TUN && (options->topology == TOP_NET30 || options->topology == TOP_P2P))
     {
@@ -1418,12 +1427,12 @@ do_init_route_list(const struct options *options,
 static void
 do_init_route_ipv6_list(const struct options *options,
                         struct route_ipv6_list *route_ipv6_list,
+                        int metric,
                         const struct link_socket_info *link_socket_info,
                         struct env_set *es,
                         openvpn_net_ctx_t *ctx)
 {
     const char *gw = NULL;
-    int metric = -1;            /* no metric set */
 
     gw = options->ifconfig_ipv6_remote;         /* default GW = remote end */
     if (options->route_ipv6_default_gateway)
@@ -1702,6 +1711,12 @@ do_open_tun(struct context *c)
     /* initialize (but do not open) tun/tap object */
     do_init_tun(c);
 
+    /* inherit the dco context from the tuntap object */
+    if (c->c2.tls_multi)
+    {
+        c->c2.tls_multi->dco = &c->c1.tuntap->dco;
+    }
+
 #ifdef _WIN32
     /* store (hide) interactive service handle in tuntap_options */
     c->c1.tuntap->options.msg_channel = c->options.msg_channel;
@@ -1715,12 +1730,24 @@ do_open_tun(struct context *c)
     ASSERT(c->c2.link_socket);
     if (c->options.routes && c->c1.route_list)
     {
-        do_init_route_list(&c->options, c->c1.route_list,
+        int metric = 0;
+        if (dco_enabled(&c->options))
+        {
+            metric = DCO_DEFAULT_METRIC;
+        }
+
+        do_init_route_list(&c->options, c->c1.route_list, metric,
                            &c->c2.link_socket->info, c->c2.es, &c->net_ctx);
     }
     if (c->options.routes_ipv6 && c->c1.route_ipv6_list)
     {
-        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list,
+        int metric = -1;
+        if (dco_enabled(&c->options))
+        {
+            metric = DCO_DEFAULT_METRIC;
+        }
+
+        do_init_route_ipv6_list(&c->options, c->c1.route_ipv6_list, metric,
                                 &c->c2.link_socket->info, c->c2.es,
                                 &c->net_ctx);
     }
@@ -1750,9 +1777,14 @@ do_open_tun(struct context *c)
     /* Store the old fd inside the fd so open_tun can use it */
     c->c1.tuntap->fd = oldtunfd;
 #endif
+    if (dco_enabled(&c->options))
+    {
+        ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
+    }
+
     /* open the tun device */
     open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-             c->c1.tuntap);
+             c->c1.tuntap, &c->net_ctx);
 
     /* set the hardware address */
     if (c->options.lladdr)
@@ -2014,6 +2046,7 @@ tun_abort(void)
  * Handle delayed tun/tap interface bringup due to --up-delay or --pull
  */
 
+
 /**
  * Helper for do_up().  Take two option hashes and return true if they are not
  * equal, or either one is all-zeroes.
@@ -2034,23 +2067,6 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
     {
         reset_coarse_timers(c);
 
-        if (pulled_options)
-        {
-            if (!do_deferred_options(c, option_types_found))
-            {
-                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
-                return false;
-            }
-        }
-        else if (c->mode == MODE_POINT_TO_POINT)
-        {
-            if (!do_deferred_p2p_ncp(c))
-            {
-                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
-                return false;
-            }
-        }
-
         /* if --up-delay specified, open tun, do ifconfig, and run up script now */
         if (c->options.up_delay || PULL_DEFINED(&c->options))
         {
@@ -2076,6 +2092,23 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             }
         }
 
+        if (pulled_options)
+        {
+            if (!do_deferred_options(c, option_types_found))
+            {
+                msg(D_PUSH_ERRORS, "ERROR: Failed to apply push options");
+                return false;
+            }
+        }
+        else if (c->mode == MODE_POINT_TO_POINT)
+        {
+            if (!do_deferred_p2p_ncp(c))
+            {
+                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
+                return false;
+            }
+        }
+
         if (c->c2.did_open_tun)
         {
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
@@ -2173,8 +2206,9 @@ do_deferred_p2p_ncp(struct context *c)
     }
 #endif
 
-    if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
-                                         frame_fragment, get_link_socket_info(c)))
+    if (!tls_session_update_crypto_params(c->c2.tls_multi, session, &c->options,
+                                          &c->c2.frame, frame_fragment,
+                                          get_link_socket_info(c)))
     {
         msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
         return false;
@@ -2182,6 +2216,18 @@ do_deferred_p2p_ncp(struct context *c)
     return true;
 }
 
+
+static bool check_dco_pull_options(struct options *o)
+{
+    if (!o->use_peer_id)
+    {
+        msg(D_TLS_ERRORS, "OPTIONS IMPORT: Server did not request DATA_V2 packet "
+                          "format required for data channel offload");
+        return false;
+    }
+    return true;
+}
+
 /*
  * Handle non-tun-related pulled options.
  */
@@ -2286,15 +2332,54 @@ do_deferred_options(struct context *c, const unsigned int found)
         }
 #endif
 
+        if (c->c2.did_open_tun)
+        {
+            /* If we are in DCO mode we need to set the new peer options now */
+            int ret = dco_p2p_add_new_peer(c);
+            if (ret < 0)
+            {
+                msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
+                return false;
+            }
+        }
+
         struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-        if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
-                                              frame_fragment, get_link_socket_info(c)))
+        if (!tls_session_update_crypto_params(c->c2.tls_multi, session,
+                                              &c->options, &c->c2.frame,
+                                              frame_fragment,
+                                              get_link_socket_info(c)))
         {
             msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
             return false;
         }
-    }
 
+        if (dco_enabled(&c->options))
+        {
+            /* Check if the pushed options are compatible with DCO if we have
+             * DCO enabled */
+            if (!check_dco_pull_options(&c->options))
+            {
+                msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
+                    "data channel offload. Use --disable-dco to connect"
+                    "to this server");
+                return false;
+            }
+
+            if (c->options.ping_send_timeout || c->c2.frame.mss_fix)
+            {
+                int ret = dco_set_peer(&c->c1.tuntap->dco,
+                                       c->c2.tls_multi->peer_id,
+                                       c->options.ping_send_timeout,
+                                       c->options.ping_rec_timeout,
+                                       c->c2.frame.mss_fix);
+                if (ret < 0)
+                {
+                    msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
+                    return false;
+                }
+            }
+        }
+    }
     return true;
 }
 
@@ -2967,12 +3052,20 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         }
     }
 
+    /* let the TLS engine know if keys have to be installed in DCO or not */
+    to.disable_dco = !dco_enabled(options);
+
     /*
      * Initialize OpenVPN's master TLS-mode object.
      */
     if (flags & CF_INIT_TLS_MULTI)
     {
         c->c2.tls_multi = tls_multi_init(&to);
+        /* inherit the dco context from the tuntap object */
+        if (c->c1.tuntap)
+        {
+            c->c2.tls_multi->dco = &c->c1.tuntap->dco;
+        }
     }
 
     if (flags & CF_INIT_TLS_AUTH_STANDALONE)
@@ -4254,6 +4347,10 @@ close_instance(struct context *c)
         /* free buffers */
         do_close_free_buf(c);
 
+        /* close peer for DCO if enabled, needs peer-id so must be done before
+         * closing TLS contexts */
+        dco_remove_peer(c);
+
         /* close TLS */
         do_close_tls(c);
 
@@ -4351,15 +4448,18 @@ inherit_context_child(struct context *dest,
 #endif
 
     /* context init */
+
+    /* inherit tun/tap interface object now as it may be required
+     * to initialize the DCO context in init_instance()
+     */
+    dest->c1.tuntap = src->c1.tuntap;
+
     init_instance(dest, src->c2.es, CC_NO_CLOSE | CC_USR1_TO_HUP);
     if (IS_SIG(dest))
     {
         return;
     }
 
-    /* inherit tun/tap interface object */
-    dest->c1.tuntap = src->c1.tuntap;
-
     /* UDP inherits some extra things which TCP does not */
     if (dest->mode == CM_CHILD_UDP)
     {
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 0c5a2e99..25dd33b2 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -30,7 +30,7 @@
  * Baseline maximum number of events
  * to wait for.
  */
-#define BASE_N_EVENTS 4
+#define BASE_N_EVENTS 5
 
 void context_clear(struct context *c);
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 7970b60d..4ed202a6 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -32,10 +32,11 @@
 #include "buffer.h"
 #include "platform.h"
 
+#include <stddef.h>
+
 /* forward declarations */
 struct plugin_list;
 
-
 /* Set standard file descriptors to /dev/null */
 void set_std_files_to_null(bool stdin_only);
 
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b725bebb..b4445dbe 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -61,6 +61,7 @@
 #define MTCP_SIG         ((void *)3) /* Only on Windows */
 #define MTCP_MANAGEMENT ((void *)4)
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
+#define MTCP_DCO        ((void *)6)
 
 #define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
 
@@ -123,6 +124,8 @@ multi_create_instance_tcp(struct multi_context *m)
     struct hash *hash = m->hash;
 
     mi = multi_create_instance(m, NULL);
+    multi_assign_peer_id(m, mi);
+
     if (mi)
     {
         struct hash_element *he;
@@ -236,6 +239,7 @@ multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *mi
     if (ls && mi->socket_set_called)
     {
         event_del(mtcp->es, socket_event_handle(ls));
+        mi->socket_set_called = false;
     }
     mtcp->n_esr = 0;
 }
@@ -277,6 +281,9 @@ multi_tcp_wait(const struct context *c,
     }
 #endif
     tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+#if defined(TARGET_LINUX)
+    dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
+#endif
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -393,6 +400,20 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
 
     tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
 
+#if defined(TARGET_LINUX)
+    if (mi && mi->context.c2.link_socket->info.dco_installed)
+    {
+        /* If we got a socket that has been handed over to the kernel
+         * we must not call the normal socket function to figure out
+         * if it is readable or writable */
+        /* Assert that we only have the DCO exptected flags */
+        ASSERT(action & (TA_SOCKET_READ | TA_SOCKET_WRITE));
+
+        /* We are always ready! */
+        return action;
+    }
+#endif
+
     switch (action)
     {
         case TA_TUN_READ:
@@ -516,7 +537,10 @@ multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int
 
         case TA_INITIAL:
             ASSERT(mi);
-            multi_tcp_set_global_rw_flags(m, mi);
+            if (!mi->context.c2.link_socket->info.dco_installed)
+            {
+                multi_tcp_set_global_rw_flags(m, mi);
+            }
             multi_process_post(m, mi, mpp_flags);
             break;
 
@@ -566,7 +590,10 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
             }
             else
             {
-                multi_tcp_set_global_rw_flags(m, mi);
+                if (!c->c2.link_socket->info.dco_installed)
+                {
+                    multi_tcp_set_global_rw_flags(m, mi);
+                }
             }
             break;
 
@@ -623,23 +650,22 @@ multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int action,
         /*
          * Dispatch the action
          */
-        {
-            struct multi_instance *touched = multi_tcp_dispatch(m, mi, action);
+        struct multi_instance *touched = multi_tcp_dispatch(m, mi, action);
 
-            /*
-             * Signal received or TCP connection
-             * reset by peer?
-             */
-            if (touched && IS_SIG(&touched->context))
+        /*
+         * Signal received or TCP connection
+         * reset by peer?
+         */
+        if (touched && IS_SIG(&touched->context))
+        {
+            if (mi == touched)
             {
-                if (mi == touched)
-                {
-                    mi = NULL;
-                }
-                multi_close_instance_on_signal(m, touched);
+                mi = NULL;
             }
+            multi_close_instance_on_signal(m, touched);
         }
 
+
         /*
          * If dispatch produced any pending output
          * for a particular instance, point to
@@ -737,6 +763,13 @@ multi_tcp_process_io(struct multi_context *m)
                     multi_tcp_action(m, mi, TA_INITIAL, false);
                 }
             }
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+            /* incoming data on DCO? */
+            else if (e->arg == MTCP_DCO)
+            {
+                multi_process_incoming_dco(m);
+            }
+#endif
             /* signal received? */
             else if (e->arg == MTCP_SIG)
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4fbe3c1a..cfc8c975 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -227,6 +227,19 @@ multi_process_io_udp(struct multi_context *m)
         multi_process_file_closed(m, mpp_flags);
     }
 #endif
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    else if (status & DCO_READ)
+    {
+        if(!IS_SIG(&m->top))
+        {
+            bool ret = true;
+            while (ret)
+            {
+                ret = multi_process_incoming_dco(m);
+            }
+        }
+    }
+#endif
 }
 
 /*
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8fc74321..6cccb24b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -51,6 +51,7 @@
 
 #include "crypto_backend.h"
 #include "ssl_util.h"
+#include "dco.h"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -519,6 +520,9 @@ multi_del_iroutes(struct multi_context *m,
 {
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
+
+    dco_delete_iroutes(m, mi);
+
     if (TUNNEL_TYPE(mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
         for (ir = mi->context.options.iroutes; ir != NULL; ir = ir->next)
@@ -1224,16 +1228,20 @@ multi_learn_in_addr_t(struct multi_context *m,
         addr.netbits = (uint8_t) netbits;
     }
 
-    {
-        struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
 #ifdef ENABLE_MANAGEMENT
-        if (management && owner)
-        {
-            management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
-        }
+    if (management && owner)
+    {
+        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
+    }
 #endif
-        return owner;
+    if (!primary)
+    {
+        /* We do not want to install IP -> IP dev ovpn-dco0 */
+        dco_install_iroute(m, mi, &addr);
     }
+
+    return owner;
 }
 
 static struct multi_instance *
@@ -1257,16 +1265,20 @@ multi_learn_in6_addr(struct multi_context *m,
         mroute_addr_mask_host_bits( &addr );
     }
 
-    {
-        struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
 #ifdef ENABLE_MANAGEMENT
-        if (management && owner)
-        {
-            management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
-        }
+    if (management && owner)
+    {
+        management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
+    }
 #endif
-        return owner;
+    if (!primary)
+    {
+        /* We do not want to install IP -> IP dev ovpn-dco0 */
+        dco_install_iroute(m, mi, &addr);
     }
+
+    return owner;
 }
 
 /*
@@ -1765,6 +1777,15 @@ multi_client_set_protocol_options(struct context *c)
         tls_multi->use_peer_id = true;
         o->use_peer_id = true;
     }
+    else if (dco_enabled(o))
+    {
+        msg(M_INFO, "Client does not support DATA_V2. Data channel offloaing "
+                    "requires DATA_V2. Dropping client.");
+        auth_set_client_reason(tls_multi, "Data channel negotiation "
+                                          "failed (missing DATA_V2)");
+        return false;
+    }
+
     if (proto & IV_PROTO_REQUEST_PUSH)
     {
         c->c2.push_request_received = true;
@@ -1776,7 +1797,6 @@ multi_client_set_protocol_options(struct context *c)
         o->data_channel_crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
     }
 #endif
-
     /* Select cipher if client supports Negotiable Crypto Parameters */
 
     /* if we have already created our key, we cannot *change* our own
@@ -2276,8 +2296,9 @@ cleanup:
  * Generates the data channel keys
  */
 static bool
-multi_client_generate_tls_keys(struct context *c)
+multi_client_generate_tls_keys(struct multi_context *m, struct multi_instance *mi)
 {
+    struct context *c = &mi->context;
     struct frame *frame_fragment = NULL;
 #ifdef ENABLE_FRAGMENT
     if (c->options.ce.fragment)
@@ -2285,8 +2306,19 @@ multi_client_generate_tls_keys(struct context *c)
         frame_fragment = &c->c2.frame_fragment;
     }
 #endif
+
+    if (dco_enabled(&c->options))
+    {
+        int ret = dco_multi_add_new_peer(m, mi);
+        if (ret < 0)
+        {
+            msg(D_DCO, "Cannot add peer to DCO: %s", strerror(-ret));
+            return false;
+        }
+    }
+
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-    if (!tls_session_update_crypto_params(session, &c->options,
+    if (!tls_session_update_crypto_params(c->c2.tls_multi, session, &c->options,
                                           &c->c2.frame, frame_fragment,
                                           get_link_socket_info(c)))
     {
@@ -2295,6 +2327,20 @@ multi_client_generate_tls_keys(struct context *c)
         return false;
     }
 
+    if (dco_enabled(&c->options)
+        && (c->options.ping_send_timeout || c->c2.frame.mss_fix))
+    {
+        int ret = dco_set_peer(&c->c1.tuntap->dco, c->c2.tls_multi->peer_id,
+                               c->options.ping_send_timeout,
+                               c->options.ping_rec_timeout,
+                               c->c2.frame.mss_fix);
+        if (ret < 0)
+        {
+            msg(D_DCO, "Cannot set DCO peer: %s", strerror(-ret));
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -2401,7 +2447,7 @@ multi_client_connect_late_setup(struct multi_context *m,
     }
     /* Generate data channel keys only if setting protocol options
      * has not failed */
-    else if (!multi_client_generate_tls_keys(&mi->context))
+    else if (!multi_client_generate_tls_keys(m, mi))
     {
         mi->context.c2.tls_multi->multi_state = CAS_FAILED;
     }
@@ -2661,6 +2707,14 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         (*cur_handler_index)++;
     }
 
+    /* Check if we have forbidding options in the current mode */
+    if (dco_enabled(&mi->context.options)
+        && dco_check_option_conflict(D_MULTI_ERRORS, &mi->context.options))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to incompatible DCO options");
+        cc_succeeded = false;
+    }
+
     if (cc_succeeded)
     {
         multi_client_connect_late_setup(m, mi, *option_types_found);
@@ -3079,6 +3133,118 @@ done:
     gc_free(&gc);
 }
 
+/*
+ * Called when an instance should be closed due to the
+ * reception of a soft signal.
+ */
+void
+multi_close_instance_on_signal(struct multi_context *m, struct multi_instance *mi)
+{
+    remap_signal(&mi->context);
+    set_prefix(mi);
+    print_signal(mi->context.sig, "client-instance", D_MULTI_LOW);
+    clear_prefix();
+    multi_close_instance(m, mi, false);
+}
+
+#if (defined(ENABLE_DCO) && defined(TARGET_LINUX)) || defined(ENABLE_MANAGEMENT)
+static void
+multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const int sig)
+{
+    mi->context.sig->signal_received = sig;
+    multi_close_instance_on_signal(m, mi);
+}
+#endif
+
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+static void
+process_incoming_dco_packet(struct multi_context *m, struct multi_instance *mi,  dco_context_t *dco)
+{
+    struct buffer orig_buf = mi->context.c2.buf;
+    int peer_id = dco->dco_message_peer_id;
+
+    mi->context.c2.buf = dco->dco_packet_in;
+
+    multi_process_incoming_link(m, mi, 0);
+
+    mi->context.c2.buf = orig_buf;
+    if (BLEN(&dco->dco_packet_in) < 1)
+    {
+        msg(D_DCO, "Received too short packet for peer %d" , peer_id);
+        goto done;
+    }
+
+    uint8_t *ptr = BPTR(&dco->dco_packet_in);
+    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+    if (op == P_DATA_V2 || op == P_DATA_V2)
+    {
+        msg(D_DCO, "DCO: received data channel packet for peer %d" , peer_id);
+        goto done;
+    }
+    done:
+    buf_init(&dco->dco_packet_in, 0);
+}
+
+static void
+process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi, dco_context_t *dco)
+{
+    const char *reason = "(unknown reason by ovpn-dco)";
+    switch (dco->dco_del_peer_reason)
+    {
+    case OVPN_DEL_PEER_REASON_EXPIRED:
+        reason = "ovpn-dco: ping expired";
+        break;
+    case OVPN_DEL_PEER_REASON_TRANSPORT_ERROR:
+        reason = "ovpn-dco: transport error";
+        break;
+    case OVPN_DEL_PEER_REASON_USERSPACE:
+        /* This very likely ourselves but might be another process, so
+         * still process it */
+        reason = "ovpn-dco: userspace request";
+        break;
+    }
+
+    /* When kernel already deleted the peer, the socket is no longer
+     * installed and we don't need to cleanup the state in the kernel */
+    mi->context.c2.tls_multi->dco_peer_added = false;
+    mi->context.sig->signal_text = reason;
+    multi_signal_instance(m, mi, SIGTERM);
+}
+
+bool
+multi_process_incoming_dco(struct multi_context *m)
+{
+    dco_context_t *dco = &m->top.c1.tuntap->dco;
+
+    struct multi_instance *mi = NULL;
+
+    int ret = dco_do_read(&m->top.c1.tuntap->dco);
+
+    int peer_id = dco->dco_message_peer_id;
+
+    if ((peer_id >= 0) && (peer_id < m->max_clients) && (m->instances[peer_id]))
+    {
+        mi = m->instances[peer_id];
+        if (dco->dco_message_type == OVPN_CMD_PACKET)
+        {
+            process_incoming_dco_packet(m, mi, dco);
+        }
+        else if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
+        {
+            process_incoming_del_peer(m, mi, dco);
+        }
+    }
+    else
+    {
+        msg(D_DCO, "Received packet for peer-id unknown to OpenVPN: %d" , peer_id);
+    }
+
+    dco->dco_message_type = 0;
+    dco->dco_message_peer_id = -1;
+    return ret > 0;
+}
+#endif
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
@@ -3640,32 +3806,11 @@ multi_process_signal(struct multi_context *m)
     return true;
 }
 
-/*
- * Called when an instance should be closed due to the
- * reception of a soft signal.
- */
-void
-multi_close_instance_on_signal(struct multi_context *m, struct multi_instance *mi)
-{
-    remap_signal(&mi->context);
-    set_prefix(mi);
-    print_signal(mi->context.sig, "client-instance", D_MULTI_LOW);
-    clear_prefix();
-    multi_close_instance(m, mi, false);
-}
-
 /*
  * Management subsystem callbacks
  */
 #ifdef ENABLE_MANAGEMENT
 
-static void
-multi_signal_instance(struct multi_context *m, struct multi_instance *mi, const int sig)
-{
-    mi->context.sig->signal_received = sig;
-    multi_close_instance_on_signal(m, mi);
-}
-
 static void
 management_callback_status(void *arg, const int version, struct status_output *so)
 {
@@ -3755,10 +3900,6 @@ management_delete_event(void *arg, event_t event)
     }
 }
 
-#endif /* ifdef ENABLE_MANAGEMENT */
-
-#ifdef ENABLE_MANAGEMENT
-
 static struct multi_instance *
 lookup_by_cid(struct multi_context *m, const unsigned long cid)
 {
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index f89c7dbd..01f2a174 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -98,7 +98,9 @@ struct client_connect_defer_state
  * server-mode.
  */
 struct multi_instance {
-    struct schedule_entry se;  /* this must be the first element of the structure */
+    struct schedule_entry se;  /* this must be the first element of the structure,
+                                * We cast between this and schedule_entry so the
+                                * beginning of the struct must be identical */
     struct gc_arena gc;
     bool halt;
     int refcount;
@@ -308,6 +310,8 @@ void multi_process_float(struct multi_context *m, struct multi_instance *mi);
 bool multi_process_post(struct multi_context *m, struct multi_instance *mi, const unsigned int flags);
 
 
+bool multi_process_incoming_dco(struct multi_context *m);
+
 /**************************************************************************/
 /**
  * Demultiplex and process a packet received over the external network
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index d321f55a..9095f0b6 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -28,6 +28,7 @@
 
 #include "syshead.h"
 
+#include "dco.h"
 #include "errlevel.h"
 #include "buffer.h"
 #include "misc.h"
@@ -1351,6 +1352,16 @@ net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, enum iface_type type,
     struct rtattr *linkinfo = SITNL_NEST(&req.n, sizeof(req), IFLA_LINKINFO);
     SITNL_ADDATTR(&req.n, sizeof(req), IFLA_INFO_KIND, iface_type_str[type],
                   strlen(iface_type_str[type]) + 1);
+#if defined(ENABLE_DCO)
+    if (arg && type == IFACE_OVPN_DCO)
+    {
+        dco_context_t *dco = arg;
+        struct rtattr *data = SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_DATA);
+        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_OVPN_MODE, &dco->ifmode,
+                      sizeof(uint8_t));
+        SITNL_NEST_END(&req.n, data);
+    }
+#endif
     SITNL_NEST_END(&req.n, linkinfo);
 
     req.i.ifi_family = AF_PACKET;
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index a43cbd81..fb5bc80a 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -267,9 +267,10 @@
     <ClCompile Include="crypto.c" />
     <ClCompile Include="crypto_openssl.c" />
     <ClCompile Include="cryptoapi.c" />
-    <ClCompile Include="env_set.c" />
+    <ClCompile Include="dco.c" />
     <ClCompile Include="dhcp.c" />
     <ClCompile Include="dns.c" />
+    <ClCompile Include="env_set.c" />
     <ClCompile Include="error.c" />
     <ClCompile Include="event.c" />
     <ClCompile Include="fdmisc.c" />
@@ -352,6 +353,7 @@
     <ClInclude Include="crypto_backend.h" />
     <ClInclude Include="crypto_openssl.h" />
     <ClInclude Include="cryptoapi.h" />
+    <ClInclude Include="dco.h" />
     <ClInclude Include="dhcp.h" />
     <ClInclude Include="dns.h" />
     <ClInclude Include="env_set.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index abc45225..303811fe 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -42,6 +42,9 @@
     <ClCompile Include="dns.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="dco.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="error.c">
       <Filter>Source Files</Filter>
     </ClCompile>
@@ -296,6 +299,9 @@
     <ClInclude Include="cryptoapi.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="dco.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="dhcp.h">
       <Filter>Header Files</Filter>
     </ClInclude>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fd4a407b..9567d3b8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -61,6 +61,7 @@
 #include "ssl_verify.h"
 #include "platform.h"
 #include "xkey_common.h"
+#include "dco.h"
 #include <ctype.h>
 
 #include "memdbg.h"
@@ -106,6 +107,9 @@ const char title_string[] =
 #endif
 #endif
     " [AEAD]"
+#ifdef ENABLE_DCO
+    " [DCO]"
+#endif
     " built on " __DATE__
 ;
 
@@ -177,6 +181,9 @@ static const char usage_message[] =
     "                  does not begin with \"tun\" or \"tap\".\n"
     "--dev-node node : Explicitly set the device node rather than using\n"
     "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    "--disable-dco   : Do not attempt using Data Channel Offload.\n"
+#endif
     "--lladdr hw     : Set the link layer address of the tap device.\n"
     "--topology t    : Set --dev tun topology: 'net30', 'p2p', or 'subnet'.\n"
 #ifdef ENABLE_IPROUTE
@@ -1673,6 +1680,9 @@ show_settings(const struct options *o)
     SHOW_STR(dev);
     SHOW_STR(dev_type);
     SHOW_STR(dev_node);
+#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
+    SHOW_BOOL(tuntap_options.disable_dco);
+#endif
     SHOW_STR(lladdr);
     SHOW_INT(topology);
     SHOW_STR(ifconfig_local);
@@ -3172,6 +3182,14 @@ options_postprocess_verify(const struct options *o)
     }
 
     dns_options_verify(M_FATAL, &o->dns_options);
+
+    if (dco_enabled(o) && o->enable_c2c)
+    {
+        msg(M_WARN, "Note: --client-to-client has no effect when using data "
+                    "channel offload: packets are always sent to the VPN "
+                    "interface and then routed based on the system routing "
+                    "table");
+    }
 }
 
 /**
@@ -3416,6 +3434,11 @@ options_postprocess_mutate(struct options *o)
         o->verify_hash_no_ca = true;
     }
 
+    /* check if any option should force disabling DCO */
+#if defined(TARGET_LINUX)
+    o->tuntap_options.disable_dco = dco_check_option_conflict(D_DCO, o);
+#endif
+
     /*
      * Save certain parms before modifying options during connect, especially
      * when using --pull
@@ -5765,6 +5788,12 @@ add_option(struct options *options,
         options->windows_driver = parse_windows_driver(p[1], M_FATAL);
     }
 #endif
+    else if (streq(p[0], "disable-dco") || streq(p[0], "dco-disable"))
+    {
+#if defined(TARGET_LINUX)
+        options->tuntap_options.disable_dco = true;
+#endif
+    }
     else if (streq(p[0], "dev-node") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 114fe5f6..a0619597 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -876,4 +876,24 @@ void options_string_import(struct options *options,
 
 bool key_is_external(const struct options *options);
 
+#if defined(ENABLE_DCO)
+
+/**
+ * Returns whether the current configuration has dco enabled.
+ */
+static inline bool
+dco_enabled(const struct options *o)
+{
+    return !o->tuntap_options.disable_dco;
+}
+
+#else
+
+static inline bool
+dco_enabled(const struct options *o)
+{
+    return false;
+}
+
+#endif
 #endif /* ifndef OPTIONS_H */
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
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 8fb58e14..ccb71042 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -120,6 +120,7 @@ struct link_socket_info
     sa_family_t af;                     /* Address family like AF_INET, AF_INET6 or AF_UNSPEC*/
     bool bind_ipv6_only;
     int mtu_changed;            /* Set to true when mtu value is changed */
+    bool dco_installed;
 };
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 14a943a7..505ebfe8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -63,6 +63,7 @@
 #include "ssl_util.h"
 #include "auth_token.h"
 #include "mss.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -1668,21 +1669,49 @@ openvpn_PRF(const uint8_t *secret,
 }
 
 static void
-init_key_contexts(struct key_ctx_bi *key,
+init_key_contexts(struct key_state *ks,
+                  struct tls_multi *multi,
                   const struct key_type *key_type,
                   bool server,
-                  struct key2 *key2)
+                  struct key2 *key2,
+                  bool dco_disabled)
 {
+    struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
+
     /* Initialize key contexts */
     int key_direction = server ? KEY_DIRECTION_INVERSE : KEY_DIRECTION_NORMAL;
-    init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
 
-    /* Initialize implicit IVs */
-    key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].hmac,
-                               MAX_HMAC_KEY_LENGTH);
-    key_ctx_update_implicit_iv(&key->decrypt, key2->keys[1 - (int)server].hmac,
-                               MAX_HMAC_KEY_LENGTH);
+    if (dco_disabled)
+    {
+        init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
+        /* Initialize implicit IVs */
+        key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].hmac,
+                                   MAX_HMAC_KEY_LENGTH);
+        key_ctx_update_implicit_iv(&key->decrypt,
+                                   key2->keys[1 - (int)server].hmac,
+                                   MAX_HMAC_KEY_LENGTH);
+    }
+
+    if (!dco_disabled)
+    {
+        if (key->encrypt.hmac)
+        {
+            msg(M_FATAL, "FATAL: DCO does not support --auth");
+        }
+
+        int ret = init_key_dco_bi(multi, ks, key2, key_direction,
+                                  key_type->cipher, server);
+        if (ret < 0)
+        {
+            msg(M_FATAL, "Impossible to install key material in DCO: %s",
+                strerror(-ret));
+        }
 
+        /* encrypt/decrypt context are unused with DCO */
+        CLEAR(key->encrypt);
+        CLEAR(key->decrypt);
+        key->initialized = true;
+    }
 }
 
 static bool
@@ -1758,9 +1787,10 @@ generate_key_expansion_openvpn_prf(const struct tls_session *session, struct key
  * master key.
  */
 static bool
-generate_key_expansion(struct key_ctx_bi *key,
+generate_key_expansion(struct tls_multi *multi, struct key_state *ks,
                        struct tls_session *session)
 {
+    struct key_ctx_bi *key = &ks->crypto_options.key_ctx_bi;
     bool ret = false;
     struct key2 key2;
 
@@ -1801,7 +1831,9 @@ generate_key_expansion(struct key_ctx_bi *key,
             goto exit;
         }
     }
-    init_key_contexts(key, &session->opt->key_type, server, &key2);
+
+    init_key_contexts(ks, multi, &session->opt->key_type, server, &key2,
+                      session->opt->disable_dco);
     ret = true;
 
 exit:
@@ -1833,7 +1865,8 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
  * can thus be called only once per session.
  */
 bool
-tls_session_generate_data_channel_keys(struct tls_session *session)
+tls_session_generate_data_channel_keys(struct tls_multi *multi,
+                                       struct tls_session *session)
 {
     bool ret = false;
     struct key_state *ks = &session->key[KS_PRIMARY];   /* primary key */
@@ -1846,7 +1879,7 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
 
     ks->crypto_options.flags = session->opt->crypto_flags;
 
-    if (!generate_key_expansion(&ks->crypto_options.key_ctx_bi, session))
+    if (!generate_key_expansion(multi, ks, session))
     {
         msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
         goto cleanup;
@@ -1864,10 +1897,12 @@ cleanup:
 }
 
 bool
-tls_session_update_crypto_params_do_work(struct tls_session *session,
-                                 struct options* options, struct frame *frame,
-                                 struct frame *frame_fragment,
-                                 struct link_socket_info *lsi)
+tls_session_update_crypto_params_do_work(struct tls_multi *multi,
+                                         struct tls_session *session,
+                                         struct options* options,
+                                         struct frame *frame,
+                                         struct frame *frame_fragment,
+                                         struct link_socket_info *lsi)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
@@ -1908,11 +1943,12 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
         frame_print(frame_fragment, D_MTU_INFO, "Fragmentation MTU parms");
     }
 
-    return tls_session_generate_data_channel_keys(session);
+    return tls_session_generate_data_channel_keys(multi, session);
 }
 
 bool
-tls_session_update_crypto_params(struct tls_session *session,
+tls_session_update_crypto_params(struct tls_multi *multi,
+                                 struct tls_session *session,
                                  struct options *options, struct frame *frame,
                                  struct frame *frame_fragment,
                                  struct link_socket_info *lsi)
@@ -1934,8 +1970,8 @@ tls_session_update_crypto_params(struct tls_session *session,
     /* Import crypto settings that might be set by pull/push */
     session->opt->crypto_flags |= options->data_channel_crypto_flags;
 
-    return tls_session_update_crypto_params_do_work(session, options, frame,
-                                                    frame_fragment, lsi);
+    return tls_session_update_crypto_params_do_work(multi, session, options,
+                                                    frame, frame_fragment, lsi);
 }
 
 
@@ -2234,7 +2270,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
             {
                 buf_printf(&out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
             }
-            buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version() );
+            buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version());
 #if defined(_WIN32)
             buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc, false));
 #endif
@@ -3153,7 +3189,7 @@ tls_multi_process(struct tls_multi *multi,
                 /* Session is now fully authenticated.
                  * tls_session_generate_data_channel_keys will move ks->state
                  * from S_ACTIVE to S_GENERATED_KEYS */
-                if (!tls_session_generate_data_channel_keys(session))
+                if (!tls_session_generate_data_channel_keys(multi, session))
                 {
                     msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
                     ks->authenticated = KS_AUTH_FALSE;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cf754ad2..9818d80f 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -498,6 +498,7 @@ void tls_update_remote_addr(struct tls_multi *multi,
  * channel keys based on the supplied options. Does nothing if keys are already
  * generated.
  *
+ * @param multi           The TLS object for this instance.
  * @param session         The TLS session to update.
  * @param options         The options to use when updating session.
  * @param frame           The frame options for this session (frame overhead is
@@ -508,7 +509,8 @@ void tls_update_remote_addr(struct tls_multi *multi,
  *
  * @return true if updating succeeded or keys are already generated, false otherwise.
  */
-bool tls_session_update_crypto_params(struct tls_session *session,
+bool tls_session_update_crypto_params(struct tls_multi *multi,
+                                      struct tls_session *session,
                                       struct options *options,
                                       struct frame *frame,
                                       struct frame *frame_fragment,
@@ -623,7 +625,8 @@ show_available_tls_ciphers(const char *cipher_list,
  * can thus be called only once per session.
  */
 bool
-tls_session_generate_data_channel_keys(struct tls_session *session);
+tls_session_generate_data_channel_keys(struct tls_multi *multi,
+                                       struct tls_session *session);
 
 /**
  * Load ovpn.xkey provider used for external key signing
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 8a077c74..a47f8317 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -167,6 +167,12 @@ enum auth_deferred_result {
     ACF_FAILED        /**< deferred auth has failed */
 };
 
+enum dco_key_status {
+    DCO_NOT_INSTALLED,
+    DCO_INSTALLED_PRIMARY,
+    DCO_INSTALLED_SECONDARY
+};
+
 /**
  * Security parameter state of one TLS and data channel %key session.
  * @ingroup control_processor
@@ -197,6 +203,12 @@ struct key_state
      */
     int key_id;
 
+    /**
+     * Key id for this key_state,  inherited from struct tls_session.
+     * @see tls_multi::peer_id.
+     */
+    uint32_t peer_id;
+
     struct key_state_ssl ks_ssl; /* contains SSL object and BIOs for the control channel */
 
     time_t initial;             /* when we created this session */
@@ -241,6 +253,8 @@ struct key_state
 
     struct auth_deferred_status plugin_auth;
     struct auth_deferred_status script_auth;
+
+    enum dco_key_status dco_status;
 };
 
 /** Control channel wrapping (--tls-auth/--tls-crypt) context */
@@ -404,6 +418,8 @@ struct tls_options
     const char *ekm_label;
     size_t ekm_label_size;
     size_t ekm_size;
+
+    bool disable_dco; /**< Whether keys have to be installed in DCO or not */
 };
 
 /** @addtogroup control_processor
@@ -636,6 +652,13 @@ struct tls_multi
     /**< Array of \c tls_session objects
      *   representing control channel
      *   sessions with the remote peer. */
+
+    /* Only used when DCO is used to remember how many keys we installed
+     * for this session */
+    int dco_keys_installed;
+    bool dco_peer_added;
+
+    dco_context_t *dco;
 };
 
 /**  gets an item  of \c key_state objects in the
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 470a387b..5122bc56 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -489,4 +489,4 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
         multi->use_peer_id, multi->peer_id, common_cipher);
 
     gc_free(&gc);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9b6d8d68..8ed7c88b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1718,10 +1718,10 @@ read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 #endif /* if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H) */
 
 
-#if !(defined(_WIN32) || defined(TARGET_LINUX))
+#if !defined(_WIN32)
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
-                 bool dynamic, struct tuntap *tt)
+                 bool dynamic, struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     char tunname[256];
     char dynamic_name[256];
@@ -1780,6 +1780,19 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
                                      "/dev/%s%d", dev, i);
                     openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
                                      "%s%d", dev, i);
+#ifdef TARGET_LINUX
+                    if (!tt->options.disable_dco)
+                    {
+                        if (open_tun_dco(tt, ctx, dynamic_name) == 0)
+                        {
+                            dynamic_opened = true;
+                            strncpynt(tunname, dynamic_name,
+                                      sizeof(dynamic_name));
+                            break;
+                        }
+                    }
+                    else
+#endif
                     if ((tt->fd = open(tunname, O_RDWR)) > 0)
                     {
                         dynamic_opened = true;
@@ -1798,26 +1811,49 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
             else
             {
                 openvpn_snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
+                strncpynt(dynamic_name, dev, sizeof(dynamic_name));
             }
         }
 
-        if (!dynamic_opened)
+#ifdef TARGET_LINUX
+        if (!tt->options.disable_dco)
         {
-            /* has named device existed before? if so, don't destroy at end */
-            if (if_nametoindex( dev ) > 0)
+            if (!dynamic_opened)
             {
-                msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end", dev );
-                tt->persistent_if = true;
+                int ret = open_tun_dco(tt, ctx, dynamic_name);
+                if (ret == -EEXIST)
+                {
+                    msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end",
+                        dynamic_name);
+                    tt->persistent_if = true;
+                }
+                else if (ret < 0)
+                {
+                    msg(M_ERR, "Cannot open TUN/TAP dev %s: %d", dynamic_name, ret);
+                }
             }
-
-            if ((tt->fd = open(tunname, O_RDWR)) < 0)
+        }
+        else
+#endif
+        {
+            if (!dynamic_opened)
             {
-                msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
+                /* has named device existed before? if so, don't destroy at end */
+                if (if_nametoindex( dev ) > 0)
+                {
+                    msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end", dev );
+                    tt->persistent_if = true;
+                }
+
+                if ((tt->fd = open(tunname, O_RDWR)) < 0)
+                {
+                    msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
+                }
             }
+            set_nonblock(tt->fd);
+            set_cloexec(tt->fd); /* don't pass fd to scripts */
         }
 
-        set_nonblock(tt->fd);
-        set_cloexec(tt->fd); /* don't pass fd to scripts */
         msg(M_INFO, "TUN/TAP device %s opened", tunname);
 
         /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
@@ -1842,7 +1878,8 @@ close_tun_generic(struct tuntap *tt)
 
 #if defined (TARGET_ANDROID)
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
     struct user_pass up;
@@ -1946,7 +1983,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #if !PEDANTIC
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     struct ifreq ifr;
 
@@ -1957,6 +1995,12 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     {
         open_null(tt);
     }
+#if defined(TARGET_LINUX)
+    else if (!tt->options.disable_dco)
+    {
+        open_tun_generic(dev, dev_type, NULL, true, tt, ctx);
+    }
+#endif
     else
     {
         /*
@@ -2063,7 +2107,8 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 #else  /* if !PEDANTIC */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     ASSERT(0);
 }
@@ -2088,7 +2133,7 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
     clear_tuntap(tt);
     tt->type = dev_type_enum(dev, dev_type);
     tt->options = *options;
-    open_tun(dev, dev_type, dev_node, tt);
+    open_tun(dev, dev_type, dev_node, tt, ctx);
     if (ioctl(tt->fd, TUNSETPERSIST, persist_mode) < 0)
     {
         msg(M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev);
@@ -2206,7 +2251,16 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         net_ctx_reset(ctx);
     }
 
-    close_tun_generic(tt);
+#ifdef TARGET_LINUX
+    if (!tt->options.disable_dco)
+    {
+        close_tun_dco(tt, ctx);
+    }
+    else
+#endif
+    {
+        close_tun_generic(tt);
+    }
     free(tt);
 }
 
@@ -2229,7 +2283,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #endif
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     int if_fd, ip_muxid, arp_muxid, arp_fd, ppa = -1;
     struct lifreq ifr;
@@ -2581,9 +2636,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #elif defined(TARGET_OPENBSD)
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     /* Enable multicast on the interface */
     if (tt->fd >= 0)
@@ -2675,9 +2731,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
  */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     if (tt->fd >= 0)
     {
@@ -2815,9 +2872,10 @@ freebsd_modify_read_write_return(int len)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
     {
@@ -2943,9 +3001,10 @@ dragonfly_modify_read_write_return(int len)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     if (tt->fd >= 0)
     {
@@ -3171,7 +3230,8 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
 #endif /* ifdef HAVE_NET_IF_UTUN_H */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
@@ -3197,7 +3257,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             {
                 /* No explicit utun and utun failed, try the generic way) */
                 msg(M_INFO, "Failed to open utun device. Falling back to /dev/tun device");
-                open_tun_generic(dev, dev_type, NULL, true, tt);
+                open_tun_generic(dev, dev_type, NULL, true, tt, ctx);
             }
             else
             {
@@ -3220,7 +3280,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             dev_node = NULL;
         }
 
-        open_tun_generic(dev, dev_type, dev_node, true, tt);
+        open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
     }
 }
 
@@ -3278,7 +3338,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #elif defined(TARGET_AIX)
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     char tunname[256];
     char dynamic_name[20];
@@ -6587,7 +6648,8 @@ tuntap_post_open(struct tuntap *tt, const char *device_guid)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     const char *device_guid = NULL;
 
@@ -6888,9 +6950,10 @@ ipset2ascii_all(struct gc_arena *gc)
 #else /* generic */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 }
 
 void
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 3a7314c5..8d5ef0cd 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -40,6 +40,7 @@
 #include "misc.h"
 #include "networking.h"
 #include "ring_buffer.h"
+#include "dco.h"
 
 #ifdef _WIN32
 #define WINTUN_COMPONENT_ID "wintun"
@@ -138,6 +139,7 @@ struct tuntap_options {
 
 struct tuntap_options {
     int txqueuelen;
+    bool disable_dco;
 };
 
 #else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
@@ -214,6 +216,8 @@ struct tuntap
 #endif
     /* used for printing status info only */
     unsigned int rwflags_debug;
+
+    dco_context_t dco;
 };
 
 static inline bool
@@ -245,7 +249,7 @@ tuntap_ring_empty(struct tuntap *tt)
  */
 
 void open_tun(const char *dev, const char *dev_type, const char *dev_node,
-              struct tuntap *tt);
+              struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index f70157dc..05b91bc5 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -1,7 +1,10 @@
 #include "config.h"
 #include "syshead.h"
+#include "error.h"
 #include "networking.h"
 
+#include "mock_msg.h"
+
 
 static char *iface = "ovpn-dummy0";
 
-- 
2.35.1


