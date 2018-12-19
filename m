From: Antonio Quartulli <a@...2181...>
Date: Wed, 19 Dec 2018 15:01:13 +1000
Message-Id: <20181219050118.6568-3-a@...2181...>
In-Reply-To: <20181219050118.6568-1-a@...2181...>
References: <20181219050118.6568-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 2/7] introduce sitnl: Simplified
 Interface To NetLink
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

This patch introduces a tiny netlink interface, optimized
for the openvpn use case.

It basically exposes all those operations that are currently
handled by directly calling the /sbin/ip command (or even
ifconfig/route, if configured).

By using netlink, openvpn won't need to spawn new processes
when configuring the tun interface or routes.
This new approach will also allow openvpn to be granted
CAP_NET_ADMIN and be able to properly work even though it
dropped the root privileges (currently handled via workarounds).

By moving this logic into the sitnl module, tun.c and route.c
also benefit from some code simplification

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac                   |   13 +-
 src/openvpn/Makefile.am        |    4 +-
 src/openvpn/errlevel.h         |    1 +
 src/openvpn/networking_sitnl.c | 1228 ++++++++++++++++++++++++++++++++
 src/openvpn/networking_sitnl.h |   28 +
 src/openvpn/sitnl.h            |  217 ++++++
 6 files changed, 1485 insertions(+), 6 deletions(-)
 create mode 100644 src/openvpn/networking_sitnl.c
 create mode 100644 src/openvpn/networking_sitnl.h
 create mode 100644 src/openvpn/sitnl.h

diff --git a/configure.ac b/configure.ac
index 1e6891b1..2a51ad46 100644
--- a/configure.ac
+++ b/configure.ac
@@ -298,6 +298,7 @@ case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
+		have_sitnl="yes"
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
@@ -1226,11 +1227,13 @@ fi
 if test "${enable_iproute2}" = "yes"; then
 	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missing])
 	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
-else
-	if test "${WIN32}" != "yes"; then
-		test -z "${ROUTE}" && AC_MSG_ERROR([route utility is required but missing])
-		test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is required but missing])
-	fi
+else if test "${have_sitnl}" = "yes"; then
+	AC_DEFINE([ENABLE_SITNL], [1], [enable sitnl support])
+else if test "${WIN32}" != "yes" -a "${have_sitnl}" != "yes"; then
+	test -z "${ROUTE}" && AC_MSG_ERROR([route utility is required but missing])
+	test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is required but missing])
+fi
+fi
 fi
 
 if test "${enable_selinux}" = "yes"; then
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 143bcf5c..30caa01f 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -80,7 +80,9 @@ openvpn_SOURCES = \
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
-	networking_iproute2.c networking_iproute2.h networking.h \
+	networking_iproute2.c networking_iproute2.h \
+	networking_sitnl.c networking_sitnl.h \
+	networking.h \
 	ntlm.c ntlm.h \
 	occ.c occ.h \
 	openssl_compat.h \
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index c30284fc..60896c1f 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -109,6 +109,7 @@
 
 #define D_LOG_RW             LOGLEV(5, 0,  0)        /* Print 'R' or 'W' to stdout for read/write */
 
+#define D_RTNL               LOGLEV(6, 68, M_DEBUG)  /* show RTNL low level operations */
 #define D_LINK_RW            LOGLEV(6, 69, M_DEBUG)  /* show TCP/UDP reads/writes (terse) */
 #define D_TUN_RW             LOGLEV(6, 69, M_DEBUG)  /* show TUN/TAP reads/writes */
 #define D_TAP_WIN_DEBUG      LOGLEV(6, 69, M_DEBUG)  /* show TAP-Windows driver debug info */
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
new file mode 100644
index 00000000..4e29d8ba
--- /dev/null
+++ b/src/openvpn/networking_sitnl.c
@@ -0,0 +1,1228 @@
+/*
+ *  Simplified Interface To NetLink
+ *
+ *  Copyright (C) 2016-2018 Antonio Quartulli <a@...2181...>
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
+#ifdef TARGET_LINUX
+
+#include "syshead.h"
+
+#include "errlevel.h"
+#include "buffer.h"
+#include "networking.h"
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+
+#define SNDBUF_SIZE (1024 * 2)
+#define RCVBUF_SIZE (1024 * 4)
+
+#define SITNL_ADDATTR(_msg, _max_size, _attr, _data, _size)         \
+    {                                                               \
+        if (sitnl_addattr(_msg, _max_size, _attr, _data, _size) < 0)\
+        {                                                           \
+            goto err;                                               \
+        }                                                           \
+    }
+
+#define NLMSG_TAIL(nmsg) \
+    ((struct rtattr *)(((uint8_t *)(nmsg)) + NLMSG_ALIGN((nmsg)->nlmsg_len)))
+
+/**
+ * Generic address data structure used to pass addresses and prefixes as
+ * argument to AF family agnostic functions
+ */
+typedef union {
+    in_addr_t ipv4;
+    struct in6_addr ipv6;
+} inet_address_t;
+
+/**
+ * Link state request message
+ */
+struct sitnl_link_req {
+    struct nlmsghdr n;
+    struct ifinfomsg i;
+    char buf[256];
+};
+
+/**
+ * Address request message
+ */
+struct sitnl_addr_req {
+    struct nlmsghdr n;
+    struct ifaddrmsg i;
+    char buf[256];
+};
+
+/**
+ * Route request message
+ */
+struct sitnl_route_req {
+    struct nlmsghdr n;
+    struct rtmsg r;
+    char buf[256];
+};
+
+typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, void *arg);
+
+/**
+ * Object returned by route request operation
+ */
+struct sitnl_route_data_cb {
+    unsigned int iface;
+    inet_address_t gw;
+};
+
+/**
+ * Helper function used to easily add attributes to a rtnl message
+ */
+static int
+sitnl_addattr(struct nlmsghdr *n, int maxlen, int type, const void *data,
+              int alen)
+{
+    int len = RTA_LENGTH(alen);
+    struct rtattr *rta;
+
+    if ((int)(NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen)
+    {
+        msg(M_WARN, "%s: rtnl: message exceeded bound of %d", __func__,
+            maxlen);
+        return -EMSGSIZE;
+    }
+
+    rta = NLMSG_TAIL(n);
+    rta->rta_type = type;
+    rta->rta_len = len;
+
+    if (!data)
+    {
+        memset(RTA_DATA(rta), 0, alen);
+    }
+    else
+    {
+        memcpy(RTA_DATA(rta), data, alen);
+    }
+
+    n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len);
+
+    return 0;
+}
+
+/**
+ * Open RTNL socket
+ */
+static int
+sitnl_socket(void)
+{
+    int sndbuf = SNDBUF_SIZE;
+    int rcvbuf = RCVBUF_SIZE;
+    int fd;
+
+    fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+    if (fd < 0)
+    {
+        msg(M_WARN, "%s: cannot open netlink socket", __func__);
+        return fd;
+    }
+
+    if (setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf)) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: SO_SNDBUF", __func__);
+        close(fd);
+        return -1;
+    }
+
+    if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rcvbuf, sizeof(rcvbuf)) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: SO_RCVBUF", __func__);
+        close(fd);
+        return -1;
+    }
+
+    return fd;
+}
+
+/**
+ * Bind socket to Netlink subsystem
+ */
+static int
+sitnl_bind(int fd, uint32_t groups)
+{
+    socklen_t addr_len;
+    struct sockaddr_nl local;
+
+    CLEAR(local);
+
+    local.nl_family = AF_NETLINK;
+    local.nl_groups = groups;
+
+    if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: cannot bind netlink socket", __func__);
+        return -errno;
+    }
+
+    addr_len = sizeof(local);
+    if (getsockname(fd, (struct sockaddr *)&local, &addr_len) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: cannot getsockname", __func__);
+        return -errno;
+    }
+
+    if (addr_len != sizeof(local))
+    {
+        msg(M_WARN, "%s: wrong address length %d", __func__, addr_len);
+        return -EINVAL;
+    }
+
+    if (local.nl_family != AF_NETLINK)
+    {
+        msg(M_WARN, "%s: wrong address family %d", __func__, local.nl_family);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+/**
+ * Send Netlink message and run callback on reply (if specified)
+ */
+static int
+sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups,
+           sitnl_parse_reply_cb cb, void *arg_cb)
+{
+    int len, rem_len, fd, ret, rcv_len;
+    struct sockaddr_nl nladdr;
+    struct nlmsgerr *err;
+    struct nlmsghdr *h;
+    unsigned int seq;
+    char buf[1024 * 16];
+    struct iovec iov =
+    {
+        .iov_base = payload,
+        .iov_len = payload->nlmsg_len,
+    };
+    struct msghdr nlmsg =
+    {
+        .msg_name = &nladdr,
+        .msg_namelen = sizeof(nladdr),
+        .msg_iov = &iov,
+        .msg_iovlen = 1,
+    };
+
+    CLEAR(nladdr);
+
+    nladdr.nl_family = AF_NETLINK;
+    nladdr.nl_pid = peer;
+    nladdr.nl_groups = groups;
+
+    payload->nlmsg_seq = seq = time(NULL);
+
+    /* no need to send reply */
+    if (!cb)
+    {
+        payload->nlmsg_flags |= NLM_F_ACK;
+    }
+
+    fd = sitnl_socket();
+    if (fd < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: can't open rtnl socket", __func__);
+        return -errno;
+    }
+
+    ret = sitnl_bind(fd, 0);
+    if (ret < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket", __func__);
+        ret = -errno;
+        goto out;
+    }
+
+    ret = sendmsg(fd, &nlmsg, 0);
+    if (ret < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: error on sendmsg()", __func__);
+        ret = -errno;
+        goto out;
+    }
+
+    /* prepare buffer to store RTNL replies */
+    memset(buf, 0, sizeof(buf));
+    iov.iov_base = buf;
+
+    while (1)
+    {
+        /*
+         * iov_len is modified by recvmsg(), therefore has to be initialized before
+         * using it again
+         */
+        msg(D_RTNL, "%s: checking for received messages", __func__);
+        iov.iov_len = sizeof(buf);
+        rcv_len = recvmsg(fd, &nlmsg, 0);
+        msg(D_RTNL, "%s: rtnl: received %d bytes", __func__, rcv_len);
+        if (rcv_len < 0)
+        {
+            if ((errno == EINTR) || (errno == EAGAIN))
+            {
+                msg(D_RTNL, "%s: interrupted call", __func__);
+                continue;
+            }
+            msg(M_WARN | M_ERRNO, "%s: rtnl: error on recvmsg()", __func__);
+            ret = -errno;
+            goto out;
+        }
+
+        if (rcv_len == 0)
+        {
+            msg(M_WARN, "%s: rtnl: socket reached unexpected EOF", __func__);
+            ret = -EIO;
+            goto out;
+        }
+
+        if (nlmsg.msg_namelen != sizeof(nladdr))
+        {
+            msg(M_WARN, "%s: sender address length: %u (expected %zu)",
+                __func__, nlmsg.msg_namelen, sizeof(nladdr));
+            ret = -EIO;
+            goto out;
+        }
+
+        h = (struct nlmsghdr *)buf;
+        while (rcv_len >= (int)sizeof(*h))
+        {
+            len = h->nlmsg_len;
+            rem_len = len - sizeof(*h);
+
+            if ((rem_len < 0) || (len > rcv_len))
+            {
+                if (nlmsg.msg_flags & MSG_TRUNC)
+                {
+                    msg(M_WARN, "%s: truncated message", __func__);
+                    ret = -EIO;
+                    goto out;
+                }
+                msg(M_WARN, "%s: malformed message: len=%d", __func__, len);
+                ret = -EIO;
+                goto out;
+            }
+
+/*            if (((int)nladdr.nl_pid != peer) || (h->nlmsg_pid != nladdr.nl_pid)
+                || (h->nlmsg_seq != seq))
+            {
+                rcv_len -= NLMSG_ALIGN(len);
+                h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+                msg(M_DEBUG, "%s: skipping unrelated message. nl_pid:%d (peer:%d) nl_msg_pid:%d nl_seq:%d seq:%d",
+                    __func__, (int)nladdr.nl_pid, peer, h->nlmsg_pid,
+                    h->nlmsg_seq, seq);
+                continue;
+            }
+*/
+            if (h->nlmsg_type == NLMSG_ERROR)
+            {
+                err = (struct nlmsgerr *)NLMSG_DATA(h);
+                if (rem_len < (int)sizeof(struct nlmsgerr))
+                {
+                    msg(M_WARN, "%s: ERROR truncated", __func__);
+                    ret = -EIO;
+                }
+                else
+                {
+                    if (!err->error)
+                    {
+                        ret = 0;
+                        if (cb)
+                            ret = cb(h, arg_cb);
+                    }
+                    else
+                    {
+                        msg(M_WARN, "%s: rtnl: generic error: %s",
+                            __func__, strerror(-err->error));
+                        ret = -err->error;
+                    }
+                }
+                goto out;
+            }
+
+            if (cb)
+            {
+                ret = cb(h, arg_cb);
+                goto out;
+            }
+            else
+            {
+                msg(M_WARN, "%s: RTNL: unexpected reply", __func__);
+            }
+
+            rcv_len -= NLMSG_ALIGN(len);
+            h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+        }
+
+        if (nlmsg.msg_flags & MSG_TRUNC)
+        {
+            msg(M_WARN, "%s: message truncated", __func__);
+            continue;
+        }
+
+        if (rcv_len)
+        {
+            msg(M_WARN, "%s: rtnl: %d not parsed bytes", __func__, rcv_len);
+            ret = -1;
+            goto out;
+        }
+    }
+out:
+    close(fd);
+
+    return ret;
+}
+
+typedef struct {
+    int addr_size;
+    inet_address_t gw;
+    char iface[IFNAMSIZ];
+} route_res_t;
+
+static int
+sitnl_route_save(struct nlmsghdr *n, void *arg)
+{
+    route_res_t *res = arg;
+    struct rtmsg *r = NLMSG_DATA(n);
+    struct rtattr *rta = RTM_RTA(r);
+    int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
+    unsigned int ifindex = 0;
+
+    while (RTA_OK(rta, len))
+    {
+        switch (rta->rta_type)
+        {
+            /* route interface */
+            case RTA_OIF:
+                ifindex = *(unsigned int *)RTA_DATA(rta);
+                break;
+            /* route prefix */
+            case RTA_DST:
+                break;
+            /* GW for the route */
+            case RTA_GATEWAY:
+                memcpy(&res->gw, RTA_DATA(rta), res->addr_size);
+                break;
+        }
+
+        rta = RTA_NEXT(rta, len);
+    }
+
+    if (!if_indextoname(ifindex, res->iface))
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifname for index %d",
+            __func__, ifindex);
+        return -1;
+    }
+
+    return 0;
+}
+
+static int
+sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
+                    int prefixlen, void *best_gw, char *best_iface)
+{
+    struct sitnl_route_req req;
+    route_res_t res;
+    int ret = -EINVAL;
+
+    ASSERT(best_gw);
+    ASSERT(best_iface);
+
+    CLEAR(req);
+    CLEAR(res);
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.r));
+    req.n.nlmsg_type = RTM_GETROUTE;
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+
+    req.r.rtm_family = af_family;
+    req.r.rtm_dst_len = prefixlen;
+
+    switch (af_family)
+    {
+        case AF_INET:
+            res.addr_size = sizeof(in_addr_t);
+            req.n.nlmsg_flags |= NLM_F_DUMP;
+            break;
+        case AF_INET6:
+            res.addr_size = sizeof(struct in6_addr);
+            break;
+        default:
+            /* unsupported */
+            return -EINVAL;
+    }
+
+    SITNL_ADDATTR(&req.n, sizeof(req), RTA_DST, dst, res.addr_size);
+
+    ret = sitnl_send(&req.n, 0, 0, sitnl_route_save, &res);
+    if (ret < 0)
+    {
+        goto err;
+    }
+
+    /* save result in output variables */
+    memcpy(best_gw, &res.gw, res.addr_size);
+    strcpy(best_iface, res.iface);
+err:
+    return ret;
+
+}
+
+/* used by iproute2 implementation too */
+int
+net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
+                     int prefixlen, struct in6_addr *best_gw, char *best_iface)
+{
+    inet_address_t dst_v6 = {0};
+    char buf[INET6_ADDRSTRLEN];
+    int ret;
+
+    if (dst)
+    {
+        dst_v6.ipv6 = *dst;
+    }
+
+    msg(D_ROUTE, "%s query: dst %s/%d", __func__,
+        inet_ntop(AF_INET6, &dst_v6.ipv6, buf, sizeof(buf)), prefixlen);
+
+    ret = sitnl_route_best_gw(AF_INET6, &dst_v6, prefixlen, best_gw,
+                              best_iface);
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    msg(D_ROUTE, "%s result: via %s dev %s", __func__,
+        inet_ntop(AF_INET6, best_gw, buf, sizeof(buf)), best_iface);
+
+    return ret;
+
+}
+
+#ifdef ENABLE_SITNL
+
+int
+net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+{
+    (void)c;
+    (void)ctx;
+
+    return 0;
+}
+
+int
+net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
+                     int prefixlen, in_addr_t *best_gw, char *best_iface)
+{
+    inet_address_t dst_v4 = {0};
+    char buf[INET_ADDRSTRLEN];
+    int ret;
+
+    if (dst)
+    {
+        dst_v4.ipv4 = htonl(*dst);
+    }
+
+    msg(D_ROUTE, "%s query: dst %s/%d", __func__,
+        inet_ntop(AF_INET, &dst_v4.ipv4, buf, sizeof(buf)), prefixlen);
+
+    ret = sitnl_route_best_gw(AF_INET, &dst_v4, prefixlen, best_gw, best_iface);
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    msg(D_ROUTE, "%s result: via %s dev %s", __func__,
+        inet_ntop(AF_INET, best_gw, buf, sizeof(buf)), best_iface);
+
+    /* result is expected in Host Order */
+    *best_gw = ntohl(*best_gw);
+
+    return ret;
+}
+
+int
+net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
+{
+    struct sitnl_link_req req;
+    int ifindex;
+
+    CLEAR(req);
+
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interface", __func__);
+        return -EINVAL;
+    }
+
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0) {
+        msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface,
+            strerror(errno));
+        return -ENOENT;
+    }
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+    req.n.nlmsg_type = RTM_NEWLINK;
+
+    req.i.ifi_family = AF_PACKET;
+    req.i.ifi_index = ifindex;
+    req.i.ifi_change |= IFF_UP;
+    if (up)
+        req.i.ifi_flags |= IFF_UP;
+    else
+        req.i.ifi_flags &= ~IFF_UP;
+
+    msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");
+
+    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+}
+
+int
+net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface,
+                  uint32_t mtu)
+{
+    struct sitnl_link_req req;
+    int ifindex, ret = -1;
+
+    CLEAR(req);
+
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0) {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
+            iface);
+        return -1;
+    }
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+    req.n.nlmsg_type = RTM_NEWLINK;
+
+    req.i.ifi_family = AF_PACKET;
+    req.i.ifi_index = ifindex;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_MTU, &mtu, 4);
+
+    msg(M_INFO, "%s: mtu %u for %s", __func__, mtu, iface);
+
+    ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+err:
+    return ret;
+}
+
+static int
+sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
+               const inet_address_t *local, const inet_address_t *remote,
+               int prefixlen, const inet_address_t *broadcast)
+{
+    struct sitnl_addr_req req;
+    uint32_t size;
+    int ret = -EINVAL;
+
+    CLEAR(req);
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_type = cmd;
+    req.n.nlmsg_flags = NLM_F_REQUEST | flags;
+
+    req.i.ifa_index = ifindex;
+    req.i.ifa_family = af_family;
+
+    switch (af_family)
+    {
+        case AF_INET:
+            size = sizeof(struct in_addr);
+            break;
+        case AF_INET6:
+            size = sizeof(struct in6_addr);
+            break;
+        default:
+            msg(M_WARN, "%s: rtnl: unknown address family %d", __func__,
+                af_family);
+            return -EINVAL;
+    }
+
+    /* if no prefixlen has been specified, assume host address */
+    if (prefixlen == 0)
+    {
+        prefixlen = size * 8;
+    }
+    req.i.ifa_prefixlen = prefixlen;
+
+    if (remote)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), IFA_ADDRESS, remote, size);
+    }
+
+    if (local)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), IFA_LOCAL, local, size);
+    }
+
+    if (broadcast)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), IFA_BROADCAST, broadcast, size);
+    }
+
+    ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+    if ((ret < 0) && (errno == EEXIST))
+    {
+        ret = 0;
+    }
+err:
+    return ret;
+}
+
+static int
+sitnl_addr_ptp_add(sa_family_t af_family, const char *iface,
+                   const inet_address_t *local,
+                   const inet_address_t *remote)
+{
+    int ifindex;
+
+    switch (af_family) {
+        case AF_INET:
+        case AF_INET6:
+            break;
+        default:
+            return -EINVAL;
+    }
+
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interface", __func__);
+        return -EINVAL;
+    }
+
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0)
+    {
+        msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(iface),
+            strerror(errno));
+        return -ENOENT;
+    }
+
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
+                          af_family, local, remote, 0, NULL);
+}
+
+static int
+sitnl_addr_ptp_del(sa_family_t af_family, const char *iface,
+                   const inet_address_t *local)
+{
+    int ifindex;
+
+    switch (af_family) {
+        case AF_INET:
+        case AF_INET6:
+            break;
+        default:
+            return -EINVAL;
+    }
+
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interface", __func__);
+        return -EINVAL;
+    }
+
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, iface);
+        return -ENOENT;
+    }
+
+    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0,
+                          NULL);
+}
+
+static int
+sitnl_route_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
+                const void *dst, int prefixlen,
+                const void *gw, enum rt_class_t table, int metric,
+                enum rt_scope_t scope, int protocol, int type)
+{
+    struct sitnl_route_req req;
+    int ret = -1, size;
+
+    CLEAR(req);
+
+    switch (af_family)
+    {
+        case AF_INET:
+            size = sizeof(in_addr_t);
+            break;
+        case AF_INET6:
+            size = sizeof(struct in6_addr);
+            break;
+        default:
+            return -EINVAL;
+    }
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.r));
+    req.n.nlmsg_type = cmd;
+    req.n.nlmsg_flags = NLM_F_REQUEST | flags;
+
+    req.r.rtm_family = af_family;
+    req.r.rtm_scope = scope;
+    req.r.rtm_protocol = protocol;
+    req.r.rtm_type = type;
+    req.r.rtm_dst_len = prefixlen;
+
+    if (table < 256)
+    {
+        req.r.rtm_table = table;
+    }
+    else
+    {
+        req.r.rtm_table = RT_TABLE_UNSPEC;
+        SITNL_ADDATTR(&req.n, sizeof(req), RTA_TABLE, &table, 4);
+    }
+
+    if (dst)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), RTA_DST, dst, size);
+    }
+
+    if (gw)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), RTA_GATEWAY, gw, size);
+    }
+
+    if (ifindex > 0)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), RTA_OIF, &ifindex, 4);
+    }
+
+    if (metric > 0)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), RTA_PRIORITY, &metric, 4);
+    }
+
+    ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+    if ((ret < 0) && (errno == EEXIST))
+    {
+        ret = 0;
+    }
+err:
+    return ret;
+}
+
+static int
+sitnl_addr_add(sa_family_t af_family, const char *iface,
+               const inet_address_t *addr, int prefixlen,
+               const inet_address_t *broadcast)
+{
+    int ifindex;
+
+    switch (af_family) {
+        case AF_INET:
+        case AF_INET6:
+            break;
+        default:
+            return -EINVAL;;
+    }
+
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interface", __func__);
+        return -EINVAL;
+    }
+
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
+            iface);
+        return -ENOENT;
+    }
+
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
+                          af_family, addr, NULL, prefixlen, broadcast);
+}
+
+static int
+sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr,
+               int prefixlen)
+{
+    int ifindex;
+
+    switch (af_family) {
+        case AF_INET:
+        case AF_INET6:
+            break;
+        default:
+            return -EINVAL;;
+    }
+
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interface", __func__);
+        return -EINVAL;
+    }
+
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
+            iface);
+        return -ENOENT;
+    }
+
+    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL,
+                          prefixlen, NULL);
+}
+
+int
+net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
+                const in_addr_t *addr, int prefixlen,
+                const in_addr_t *broadcast)
+{
+    inet_address_t addr_v4 = { 0 };
+    inet_address_t brd_v4 = { 0 };
+    char buf1[INET_ADDRSTRLEN];
+    char buf2[INET_ADDRSTRLEN];
+
+    if (!addr)
+    {
+        return -EINVAL;
+    }
+
+    addr_v4.ipv4 = htonl(*addr);
+
+    if (broadcast)
+    {
+        brd_v4.ipv4 = htonl(*broadcast);
+    }
+
+    msg(M_INFO, "%s: %s/%d brd %s dev %s", __func__,
+        inet_ntop(AF_INET, &addr_v4.ipv4, buf1, sizeof(buf1)), prefixlen,
+        inet_ntop(AF_INET, &brd_v4.ipv4, buf2, sizeof(buf2)), iface);
+
+    return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen, &brd_v4);
+}
+
+int
+net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
+                const struct in6_addr *addr, int prefixlen)
+{
+    inet_address_t addr_v6 = { 0 };
+    char buf[INET6_ADDRSTRLEN];
+
+    if (!addr)
+    {
+        return -EINVAL;
+    }
+
+    addr_v6.ipv6 = *addr;
+
+    msg(M_INFO, "%s: %s/%d dev %s", __func__,
+        inet_ntop(AF_INET6, &addr_v6.ipv6, buf, sizeof(buf)), prefixlen, iface);
+
+    return sitnl_addr_add(AF_INET6, iface, &addr_v6, prefixlen, NULL);
+}
+
+int
+net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
+                const in_addr_t *addr, int prefixlen)
+{
+    inet_address_t addr_v4 = { 0 };
+    char buf[INET_ADDRSTRLEN];
+
+    if (!addr)
+    {
+        return -EINVAL;
+    }
+
+    addr_v4.ipv4 = htonl(*addr);
+
+    msg(M_INFO, "%s: %s dev %s", __func__,
+        inet_ntop(AF_INET, &addr_v4.ipv4, buf, sizeof(buf)), iface);
+
+    return sitnl_addr_del(AF_INET, iface, &addr_v4, prefixlen);
+}
+
+int
+net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface,
+                const struct in6_addr *addr, int prefixlen)
+{
+    inet_address_t addr_v6 = { 0 };
+    char buf[INET6_ADDRSTRLEN];
+
+    if (!addr)
+    {
+        return -EINVAL;
+    }
+
+    addr_v6.ipv6 = *addr;
+
+    msg(M_INFO, "%s: %s/%d dev %s", __func__,
+        inet_ntop(AF_INET6, &addr_v6.ipv6, buf, sizeof(buf)), prefixlen, iface);
+
+    return sitnl_addr_del(AF_INET6, iface, &addr_v6, prefixlen);
+}
+
+int
+net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
+                    const in_addr_t *local, const in_addr_t *remote)
+{
+    inet_address_t local_v4 = { 0 };
+    inet_address_t remote_v4 = { 0 };
+    char buf1[INET_ADDRSTRLEN];
+    char buf2[INET_ADDRSTRLEN];
+
+    if (!local)
+    {
+        return -EINVAL;
+    }
+
+    local_v4.ipv4 = htonl(*local);
+
+    if (remote)
+    {
+        remote_v4.ipv4 = htonl(*remote);
+    }
+
+    msg(M_INFO, "%s: %s peer %s dev %s", __func__,
+        inet_ntop(AF_INET, &local_v4.ipv4, buf1, sizeof(buf1)),
+        inet_ntop(AF_INET, &remote_v4.ipv4, buf2, sizeof(buf2)), iface);
+
+    return sitnl_addr_ptp_add(AF_INET, iface, &local_v4, &remote_v4);
+}
+
+int
+net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
+                    const in_addr_t *local, const in_addr_t *remote)
+{
+    inet_address_t local_v4 = { 0 };
+    char buf[INET6_ADDRSTRLEN];
+
+
+    if (!local)
+    {
+        return -EINVAL;
+    }
+
+    local_v4.ipv4 = htonl(*local);
+
+    msg(M_INFO, "%s: %s dev %s", __func__,
+        inet_ntop(AF_INET, &local_v4.ipv4, buf, sizeof(buf)), iface);
+
+    return sitnl_addr_ptp_del(AF_INET, iface, &local_v4);
+}
+
+static int
+sitnl_route_add(const char *iface, sa_family_t af_family, const void *dst,
+                int prefixlen, const void *gw, uint32_t table, int metric)
+{
+    enum rt_scope_t scope = RT_SCOPE_UNIVERSE;
+    int ifindex = 0;
+
+    if (iface)
+    {
+        ifindex = if_nametoindex(iface);
+        if (ifindex == 0)
+        {
+            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s",
+                __func__, iface);
+            return -ENOENT;
+        }
+    }
+
+    if (table == 0)
+    {
+        table = RT_TABLE_MAIN;
+    }
+
+    if (!gw && iface)
+    {
+        scope = RT_SCOPE_LINK;
+    }
+
+    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
+                           af_family, dst, prefixlen, gw, table, metric, scope,
+                           RTPROT_BOOT, RTN_UNICAST);
+}
+
+int
+net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+                 const in_addr_t *gw, const char *iface,
+                 uint32_t table, int metric)
+{
+    in_addr_t *dst_ptr = NULL, *gw_ptr = NULL;
+    in_addr_t dst_be = 0, gw_be = 0;
+    char dst_str[INET_ADDRSTRLEN];
+    char gw_str[INET_ADDRSTRLEN];
+
+    if (dst)
+    {
+        dst_be = htonl(*dst);
+        dst_ptr = &dst_be;
+    }
+
+    if (gw)
+    {
+        gw_be = htonl(*gw);
+        gw_ptr = &gw_be;
+    }
+
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+        inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)),
+        prefixlen, inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)),
+        np(iface), table, metric);
+
+    return sitnl_route_add(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table,
+                           metric);
+}
+
+int
+net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
+                 int prefixlen, const struct in6_addr *gw,
+                 const char *iface, uint32_t table, int metric)
+{
+    inet_address_t dst_v6 = { 0 };
+    inet_address_t gw_v6 = { 0 };
+    char dst_str[INET6_ADDRSTRLEN];
+    char gw_str[INET6_ADDRSTRLEN];
+
+    if (dst)
+    {
+        dst_v6.ipv6 = *dst;
+    }
+
+    if (gw)
+    {
+        gw_v6.ipv6 = *gw;
+    }
+
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+        inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)),
+        prefixlen, inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)),
+        np(iface), table, metric);
+
+    return sitnl_route_add(iface, AF_INET6, dst, prefixlen, gw, table,
+                           metric);
+}
+
+static int
+sitnl_route_del(const char *iface, sa_family_t af_family, inet_address_t *dst,
+                int prefixlen, inet_address_t *gw, uint32_t table,
+                int metric)
+{
+    int ifindex = 0;
+
+    if (iface)
+    {
+        ifindex = if_nametoindex(iface);
+        if (ifindex == 0)
+        {
+            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s",
+                __func__, iface);
+            return -ENOENT;
+        }
+    }
+
+    if (table == 0)
+    {
+        table = RT_TABLE_MAIN;
+    }
+
+    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen,
+                           gw, table, metric, RT_SCOPE_NOWHERE, 0, 0);
+}
+
+int
+net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+                 const in_addr_t *gw, const char *iface, uint32_t table,
+                 int metric)
+{
+    inet_address_t dst_v4 = { 0 };
+    inet_address_t gw_v4 = { 0 };
+    char dst_str[INET_ADDRSTRLEN];
+    char gw_str[INET_ADDRSTRLEN];
+
+    if (dst)
+    {
+        dst_v4.ipv4 = htonl(*dst);
+    }
+
+    if (gw)
+    {
+        gw_v4.ipv4 = htonl(*gw);
+    }
+
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+        inet_ntop(AF_INET, &dst_v4.ipv4, dst_str, sizeof(dst_str)),
+        prefixlen, inet_ntop(AF_INET, &gw_v4.ipv4, gw_str, sizeof(gw_str)),
+        np(iface), table, metric);
+
+    return sitnl_route_del(iface, AF_INET, &dst_v4, prefixlen, &gw_v4, table,
+                           metric);
+}
+
+int
+net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
+                 int prefixlen, const struct in6_addr *gw,
+                 const char *iface, uint32_t table, int metric)
+{
+    inet_address_t dst_v6 = { 0 };
+    inet_address_t gw_v6 = { 0 };
+    char dst_str[INET6_ADDRSTRLEN];
+    char gw_str[INET6_ADDRSTRLEN];
+
+    if (dst)
+    {
+        dst_v6.ipv6 = *dst;
+    }
+
+    if (gw)
+    {
+        gw_v6.ipv6 = *gw;
+    }
+
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+        inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)),
+        prefixlen, inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)),
+        np(iface), table, metric);
+
+    return sitnl_route_del(iface, AF_INET6, &dst_v6, prefixlen, &gw_v6,
+                           table, metric);
+}
+
+#endif /* !ENABLE_SITNL */
+
+#endif /* TARGET_LINUX */
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
new file mode 100644
index 00000000..f39d426d
--- /dev/null
+++ b/src/openvpn/networking_sitnl.h
@@ -0,0 +1,28 @@
+/*
+ *  Generic interface to platform specific networking code
+ *
+ *  Copyright (C) 2016-2018 Antonio Quartulli <a@...2181...>
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
+#ifndef NETWORKING_SITNL_H_
+#define NETWORKING_SITNL_H_
+
+typedef char openvpn_net_iface_t;
+typedef void * openvpn_net_ctx_t;
+
+#endif /* NETWORKING_SITNL_H_ */
diff --git a/src/openvpn/sitnl.h b/src/openvpn/sitnl.h
new file mode 100644
index 00000000..937522f9
--- /dev/null
+++ b/src/openvpn/sitnl.h
@@ -0,0 +1,217 @@
+/*
+ *  Simplified Interface To NetLink
+ *
+ *  Copyright (C) 2016-2018 Antonio Quartulli <a@...2181...>
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
+#ifndef SITNL_H_
+#define SITNL_H_
+
+#ifdef TARGET_LINUX
+
+#include <stdbool.h>
+#include <netinet/in.h>
+
+/**
+ * Bring interface up or down.
+ *
+ * @param iface     the interface to modify
+ * @param up        true if the interface has to be brought up, false otherwise
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_iface_up(const char *iface, bool up);
+
+/**
+ * Set the MTU for an interface
+ *
+ * @param iface     the interface to modify
+ * @param mtru      the new MTU
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_iface_mtu_set(const char *iface, uint32_t mtu);
+
+/**
+ * Add an IPv4 address to an interface
+ *
+ * @param iface     the interface where the address has to be added
+ * @param addr      the address to add
+ * @param prefixlen the prefix length of the network associated with the address
+ * @param broadcast the broadcast address to configure on the interface
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_addr_v4_add(const char *iface, const in_addr_t *addr, int prefixlen,
+                      const in_addr_t *broadcast);
+
+/**
+ * Add an IPv6 address to an interface
+ *
+ * @param iface     the interface where the address has to be added
+ * @param addr      the address to add
+ * @param prefixlen the prefix length of the network associated with the address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+
+int sitnl_addr_v6_add(const char *iface, const struct in6_addr *addr,
+                      int prefixlen);
+
+/**
+ * Remove an IPv4 from an interface
+ *
+ * @param iface     the interface to remove the address from
+ * @param prefixlen the prefix length of the network associated with the address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_addr_v4_del(const char *iface, const in_addr_t *addr, int prefixlen);
+
+/**
+ * Remove an IPv6 from an interface
+ *
+ * @param iface     the interface to remove the address from
+ * @param prefixlen the prefix length of the network associated with the address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_addr_v6_del(const char *iface, const struct in6_addr *addr,
+                      int prefixlen);
+
+/**
+ * Add a point-to-point IPv4 address to an interface
+ *
+ * @param iface     the interface where the address has to be added
+ * @param local     the address to add
+ * @param remote    the associated p-t-p remote address
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_addr_ptp_v4_add(const char *iface, const in_addr_t *local,
+                          const in_addr_t *remote);
+
+/**
+ * Remove a point-to-point IPv4 address from an interface
+ *
+ * @param iface     the interface to remove the address from
+ * @param local     the address to remove
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_addr_ptp_v4_del(const char *iface, const in_addr_t *local);
+
+
+/**
+ * Add a route for an IPv4 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_route_v4_add(const in_addr_t *dst, int prefixlen,
+                       const in_addr_t *gw, const char *iface, uint32_t table,
+                       int metric);
+
+/**
+ * Add a route for an IPv6 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_route_v6_add(const struct in6_addr *dst, int prefixlen,
+                       const struct in6_addr *gw, const char *iface,
+                       uint32_t table, int metric);
+
+/**
+ * Delete a route for an IPv4 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_route_v4_del(const in_addr_t *dst, int prefixlen,
+                       const in_addr_t *gw, const char *iface, uint32_t table,
+                       int metric);
+
+/**
+ * Delete a route for an IPv4 address/network
+ *
+ * @param dst       the destination of the route
+ * @param prefixlen the length of the prefix of the destination
+ * @param gw        the gateway for this route
+ * @param iface     the interface for this route (can be NULL)
+ * @param table     the table to add this route to (if 0, will be added to the
+ *                  main table)
+ * @param metric    the metric associated with the route
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int sitnl_route_v6_del(const struct in6_addr *dst, int prefixlen,
+                       const struct in6_addr *gw, const char *iface,
+                       uint32_t table, int metric);
+
+/**
+ * Retrieve the gateway and outgoing interface for the specified IPv4
+ * address/network
+ *
+ * @param dst           The destination to lookup
+ * @param prefixlen     The length of the prefix of the destination
+ * @param best_gw       Location where the retrieved GW has to be stored
+ * @param best_iface    Location where the retrieved interface has to be stored
+ *
+ * @return              0 on success, a negative error code otherwise
+ */
+int sitnl_route_v4_best_gw(const in_addr_t *dst, int prefixlen,
+                           in_addr_t *best_gw, char *best_iface);
+
+/**
+ * Retrieve the gateway and outgoing interface for the specified IPv6
+ * address/network
+ *
+ * @param dst           The destination to lookup
+ * @param prefixlen     The length of the prefix of the destination
+ * @param best_gw       Location where the retrieved GW has to be stored
+ * @param best_iface    Location where the retrieved interface has to be stored
+ *
+ * @return              0 on success, a negative error code otherwise
+ */
+int sitnl_route_v6_best_gw(const struct in6_addr *dst, int prefixlen,
+                           struct in6_addr *best_gw, char *best_iface);
+
+#endif /* TARGET_LINUX */
+
+#endif /* SITNL_H_ */
-- 
2.19.2


