From: Gert Doering <gert@...1296...>
Date: Tue, 31 Mar 2026 13:13:29 +0200
Message-ID: <20260331111334.733-1-gert@...1296...>
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] Add support for user defined network
 namespace
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Introduce the --netns option to allow interface creation
into a user-defined network namespace.
This allows the VPN data plane to be isolated from the main
OpenVPN process namespace.

The current netlink library integration supports interface creation
and deletion in a target namespace. However, subsequent configuration
operations (e.g. address or mtu set) are executed in the caller's
namespace, as they rely on the default netlink socket context.
As a result, interface-related configuration performed after creation
may be applied in the wrong namespace.
Introduce helper functions to temporarily switch the process to the
requested network namespace using setns(2), execute the required
netlink operations, and then restore the original namespace.
The namespace switch is temporary and scoped to each netlink
operation. Once the operation completes, the original namespace
is restored to preserve the process execution context.

Note: This feature is Linux-only and depends on setns(2).
It is not compatible (yet) with Data Channel Offload (DCO).

Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1521
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1521
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 33ebedb..181c990 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -304,6 +304,12 @@
   Specify the link layer address, more commonly known as the MAC address.
   Only applied to TAP devices.
 
+--netns name
+  Specify the network namespace in which the tunnel interface will be created.
+  The namespace must already exist.
+
+  (Supported on Linux only, on other platforms this is a no-op).
+
 --persist-tun
   Don't close and reopen TUN/TAP device or run up/down scripts across
   :code:`SIGUSR1` or ``--ping-restart`` restarts.
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 26b8645..a61e587 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -388,6 +388,12 @@
                 ret);
         }
     }
+
+    if (o->netns)
+    {
+        msg(msglevel, "Note: --netns not supported by DCO, disabling data channel offload.");
+        return false;
+    }
 #endif /* if defined(_WIN32) */
 
 #if defined(HAVE_LIBCAPNG)
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index bce0c19..fab6bbf 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -39,10 +39,10 @@
 typedef void *openvpn_net_iface_t;
 #endif /* ifdef ENABLE_SITNL */
 
-/* Only the iproute2 backend implements these functions,
+/* Only the iproute2 and sitnl backend implements these functions,
  * the rest can rely on these stubs
  */
-#if !defined(ENABLE_IPROUTE)
+#if !defined(ENABLE_IPROUTE) && !defined(ENABLE_SITNL) || defined(TARGET_ANDROID)
 static inline int
 net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
@@ -63,7 +63,7 @@
 {
     (void)ctx;
 }
-#endif /* !defined(ENABLE_IPROUTE) */
+#endif /* !defined(ENABLE_IPROUTE) && !defined(ENABLE_SITNL) || defined(TARGET_ANDROID) */
 
 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)
 
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b88f03c..541c855 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -33,14 +33,17 @@
 #include "networking.h"
 #include "proto.h"
 #include "route.h"
+#include "openvpn.h"
 
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
+#include <sched.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
+#include <linux/net_namespace.h>
 
 #define SNDBUF_SIZE (1024 * 2)
 #define RCVBUF_SIZE (1024 * 4)
@@ -65,6 +68,12 @@
         _nest->rta_len = (unsigned short)((void *)sitnl_nlmsg_tail(_msg) - (void *)_nest); \
     }
 
+#define SITNL_NETNS_RTA(r) \
+    ((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct rtgenmsg))))
+
+#define NETNS_RUN_DIR  "/run/netns"
+#define NETNS_ORIG_DIR "/proc/self/ns/net"
+
 /* This function was originally implemented as a macro, but compiling with
  * gcc and -O3 was getting confused about the math and thus raising
  * security warnings on subsequent memcpy() calls.
@@ -121,6 +130,16 @@
     char buf[256];
 };
 
+/**
+ * Network namespace NSID request message
+ */
+struct sitnl_nsid_req
+{
+    struct nlmsghdr n;
+    struct rtgenmsg g;
+    char buf[256];
+};
+
 typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, void *arg);
 
 /**
@@ -165,6 +184,105 @@
     return 0;
 }
 
+#if defined(TARGET_LINUX) && defined(ENABLE_SITNL)
+
+static int netns_id_from_name_sitnl(const char *name);
+static int set_netns_id_from_name_sitnl(const char *name);
+
+int
+net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+{
+    struct stat st;
+    char path[PATH_MAX];
+
+    ctx->netns = NULL;
+
+    if (c && c->options.netns)
+    {
+        snprintf(path, sizeof(path), "%s/%s", NETNS_RUN_DIR, c->options.netns);
+
+        if (stat(path, &st) != 0)
+        {
+            msg(M_ERR, "%s: Network namespace %s does not exist", __func__, path);
+        }
+
+        ctx->netns = c->options.netns;
+    }
+
+    ctx->gc = gc_new();
+    return 0;
+}
+
+void
+net_ctx_reset(openvpn_net_ctx_t *ctx)
+{
+    gc_reset(&ctx->gc);
+}
+
+void
+net_ctx_free(openvpn_net_ctx_t *ctx)
+{
+    gc_free(&ctx->gc);
+}
+
+int
+netns_switch(openvpn_net_ctx_t *ctx)
+{
+    char net_path[PATH_MAX];
+    int orig_fd = -1, netns_fd;
+    const char *netns = ctx ? ctx->netns : NULL;
+
+    if (!netns)
+    {
+        return -1;
+    }
+
+    /* Save current netns descriptor */
+    orig_fd = open(NETNS_ORIG_DIR, O_RDONLY | O_CLOEXEC);
+    if (orig_fd < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Cannot open original network namespace", __func__);
+        return -1;
+    }
+
+    snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, netns);
+    netns_fd = open(net_path, O_RDONLY | O_CLOEXEC);
+    if (netns_fd < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Cannot open network namespace \"%s\"", __func__, netns);
+        close(orig_fd);
+        return -1;
+    }
+
+    if (setns(netns_fd, CLONE_NEWNET) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: setting the network namespace \"%s\" failed", __func__, netns);
+        close(netns_fd);
+        close(orig_fd);
+        return -1;
+    }
+
+    close(netns_fd);
+    return orig_fd;
+}
+
+void
+netns_restore(int orig_fd)
+{
+    if (orig_fd < 0)
+    {
+        return;
+    }
+
+    if (setns(orig_fd, CLONE_NEWNET) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Cannot restore original network namespace", __func__);
+    }
+
+    close(orig_fd);
+}
+#endif /* defined (TARGET_LINUX) && defined (ENABLE_SITNL) */
+
 /**
  * Open RTNL socket
  */
@@ -454,6 +572,290 @@
     return ret;
 }
 
+#ifdef ENABLE_SITNL
+/**
+ * Netlink callback to extract the interface index from a RTM_NEWLINK message.
+ *
+ * This function is used as a Netlink response handler. It inspects incoming
+ * Netlink messages and, when a RTM_NEWLINK message is received, copies the
+ * contained `struct ifinfomsg` into the caller-provided result structure.
+ *
+ * @param n    Netlink message header received from the kernel.
+ * @param arg  Pointer to a `struct sitnl_link_req` used to store the result.
+ *
+ * @return 0 to stop Netlink message processing once the interface is found,
+ *         1 to continue processing other messages.
+ */
+static int
+sitnl_link_get_ifindex(struct nlmsghdr *n, void *arg)
+{
+    struct sitnl_link_req *res = arg;
+    struct ifinfomsg *ifi;
+
+    if (n->nlmsg_type != RTM_NEWLINK)
+    {
+        return 1;
+    }
+
+    ifi = NLMSG_DATA(n);
+    res->i = *ifi;
+
+    return 0;
+}
+
+/**
+ * Retrieve the interface index of a network device in a specific network namespace.
+ *
+ * Sends an RTM_GETLINK Netlink request targeting the given network namespace ID
+ * and interface name, and extracts the resulting interface index from the kernel
+ * response.
+ *
+ * On failure, this function returns 0, matching the behavior of
+ * `if_nametoindex()`.
+ *
+ * @param ifname   Name of the network interface.
+ * @param netnsid  Target network namespace ID.
+ *
+ * @return Interface index on success, or 0 on error.
+ */
+static int
+get_ifindex_in_netns(const char *ifname, int netnsid)
+{
+    struct sitnl_link_req req;
+    struct sitnl_link_req res;
+    int ret = -1, ifindex = 0;
+
+    CLEAR(req);
+    CLEAR(res);
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_type = RTM_GETLINK;
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_TARGET_NETNSID, &netnsid, sizeof(int));
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_IFNAME, ifname, strlen(ifname) + 1);
+
+    ret = sitnl_send(&req.n, 0, 0, sitnl_link_get_ifindex, &res);
+
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    ifindex = res.i.ifi_index;
+
+err:
+    return ifindex;
+}
+
+static int
+sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,
+                         unsigned short flags)
+{
+    unsigned short type;
+
+    memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
+
+    while (RTA_OK(rta, len))
+    {
+        type = rta->rta_type & ~flags;
+
+        if ((type <= max) && (!tb[type]))
+        {
+            tb[type] = rta;
+        }
+
+        rta = RTA_NEXT(rta, len);
+    }
+
+    if (len)
+    {
+        msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=%u)", __func__, len, rta->rta_len);
+    }
+
+    return 0;
+}
+
+static int
+sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len)
+{
+    return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
+}
+
+/**
+ * Netlink callback to extract and store a network namespace ID (NSID).
+ *
+ * This function processes Netlink responses to RTM_GETNSID requests.
+ * If a NETNSA_NSID attribute is present, its value is copied into the
+ * caller-provided storage.
+ *
+ * If a Netlink error message is received, the contained error code is
+ * returned directly.
+ *
+ * @param n    Netlink message header received from the kernel.
+ * @param arg  Pointer to an integer where the NSID will be stored.
+ *
+ * @return 0 on success, a negative error code on failure.
+ */
+static int
+sitnl_nsid_save(struct nlmsghdr *n, void *arg)
+{
+    int *nsid = arg;
+    struct rtgenmsg *g = NLMSG_DATA(n);
+    struct rtattr *tb[NETNSA_MAX + 1];
+    int ret;
+
+    if (n->nlmsg_type == NLMSG_ERROR)
+    {
+        struct nlmsgerr *err = NLMSG_DATA(n);
+        return err->error;
+    }
+
+    ret = sitnl_parse_rtattr(tb, NETNSA_MAX, SITNL_NETNS_RTA(g), NLMSG_PAYLOAD(n, sizeof(*g)));
+
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    if (!tb[NETNSA_NSID])
+    {
+        return -ENOENT;
+    }
+
+    memcpy(nsid, RTA_DATA(tb[NETNSA_NSID]), sizeof(*nsid));
+    return 0;
+}
+
+/**
+ * Retrieve the network namespace ID (NSID) associated with a namespace name.
+ *
+ * This function opens the network namespace identified by the given path
+ * and sends an RTM_GETNSID Netlink request to retrieve its assigned NSID.
+ *
+ * @param name  Name of the network namespace.
+ *
+ * @return The network namespace ID on success, or a negative value on failure.
+ */
+static int
+netns_id_from_name_sitnl(const char *name)
+{
+    struct sitnl_nsid_req req;
+
+    int netnsid = -1;
+    CLEAR(req);
+
+    int netns_fd = open(name, O_RDONLY);
+    if (netns_fd < 0)
+    {
+        goto err;
+    }
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.g));
+    req.n.nlmsg_type = RTM_GETNSID;
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+    req.g.rtgen_family = AF_UNSPEC;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_FD, &netns_fd, sizeof(int));
+
+    sitnl_send(&req.n, 0, 0, sitnl_nsid_save, &netnsid);
+
+err:
+    if (netns_fd >= 0)
+    {
+        close(netns_fd);
+    }
+    return netnsid;
+}
+
+/**
+ * Assign a network namespace ID (NSID) to a namespace.
+ *
+ * This function sends an RTM_NEWNSID Netlink request to associate a
+ * NSID with the network namespace identified by the given path.
+ *
+ * @param name  Name of the network namespace.
+ *
+ * @return 0 on success, or a negative error code on failure.
+ */
+static int
+set_netns_id_from_name_sitnl(const char *name)
+{
+    struct sitnl_nsid_req req;
+
+    int ret = -1, netnsid = -1;
+    CLEAR(req);
+
+    int netns_fd = open(name, O_RDONLY);
+    if (netns_fd < 0)
+    {
+        goto err;
+    }
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.g));
+    req.n.nlmsg_type = RTM_NEWNSID;
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+    req.g.rtgen_family = AF_UNSPEC;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_FD, &netns_fd, sizeof(int));
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_NSID, &netnsid, sizeof(int));
+
+    ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+err:
+    if (netns_fd >= 0)
+    {
+        close(netns_fd);
+    }
+    return ret;
+}
+
+int
+get_or_create_netnsid_sitnl(const char *name)
+{
+    char net_path[PATH_MAX];
+    int netnsid;
+    snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, name);
+
+    /* First get */
+    netnsid = netns_id_from_name_sitnl(net_path);
+    if (netnsid >= 0)
+    {
+        return netnsid;
+    }
+
+    /* No netnsid yet? Try to assign one */
+    netnsid = set_netns_id_from_name_sitnl(net_path);
+    if (netnsid < 0)
+    {
+        return -1;
+    }
+
+    /* Second get */
+    netnsid = netns_id_from_name_sitnl(net_path);
+    if (netnsid >= 0)
+    {
+        return netnsid;
+    }
+
+    return -1;
+}
+
+int
+openvpn_if_nametoindex(const char *ifname, openvpn_net_ctx_t *ctx)
+{
+    const char *netns = ctx ? ctx->netns : NULL;
+    int netnsid = get_or_create_netnsid_sitnl(netns);
+
+    if (netnsid < 0)
+    {
+        return if_nametoindex(ifname);
+    }
+
+    return get_ifindex_in_netns(ifname, netnsid);
+}
+#endif /* ifdef ENABLE_SITNL */
+
 typedef struct
 {
     size_t addr_size;
@@ -661,7 +1063,7 @@
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;
-    int ifindex;
+    int ifindex, orig = -1;
 
     CLEAR(req);
 
@@ -671,13 +1073,15 @@
         return -EINVAL;
     }
 
-    ifindex = if_nametoindex(iface);
+    ifindex = openvpn_if_nametoindex(iface, ctx);
     if (ifindex == 0)
     {
-        msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface, strerror(errno));
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -ENOENT;
     }
 
+    orig = netns_switch(ctx);
+
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
     req.n.nlmsg_type = RTM_NEWLINK;
@@ -696,24 +1100,30 @@
 
     msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");
 
-    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+    int ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    netns_restore(orig);
+
+    return ret;
 }
 
 int
 net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifindex, ret = -1;
+    int ifindex, orig = -1, ret = -1;
 
     CLEAR(req);
 
-    ifindex = if_nametoindex(iface);
+    ifindex = openvpn_if_nametoindex(iface, ctx);
     if (ifindex == 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -1;
     }
 
+    orig = netns_switch(ctx);
+
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
     req.n.nlmsg_type = RTM_NEWLINK;
@@ -726,7 +1136,9 @@
     msg(M_INFO, "%s: mtu %u for %s", __func__, mtu, iface);
 
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
     return ret;
 }
 
@@ -734,17 +1146,19 @@
 net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct sitnl_link_req req;
-    int ifindex, ret = -1;
+    int ifindex, orig = -1, ret = -1;
 
     CLEAR(req);
 
-    ifindex = if_nametoindex(iface);
+    ifindex = openvpn_if_nametoindex(iface, ctx);
     if (ifindex == 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -1;
     }
 
+    orig = netns_switch(ctx);
+
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
     req.n.nlmsg_type = RTM_NEWLINK;
@@ -757,17 +1171,19 @@
     msg(M_INFO, "%s: lladdr " MAC_FMT " for %s", __func__, MAC_PRINT_ARG(addr), iface);
 
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
     return ret;
 }
 
 static int
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family,
+sitnl_addr_set(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family,
                const inet_address_t *local, const inet_address_t *remote, int prefixlen)
 {
     struct sitnl_addr_req req;
     uint32_t size;
-    int ret = -EINVAL;
+    int ret = -EINVAL, orig = -1;
 
     CLEAR(req);
 
@@ -819,17 +1235,22 @@
         SITNL_ADDATTR(&req.n, sizeof(req), IFA_BROADCAST, &broadcast, size);
     }
 
+    orig = netns_switch(ctx);
+
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
     if (ret == -EEXIST)
     {
         ret = 0;
     }
+
 err:
+    netns_restore(orig);
     return ret;
 }
 
 static int
-sitnl_addr_ptp_add(sa_family_t af_family, const char *iface, const inet_address_t *local,
+sitnl_addr_ptp_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, const inet_address_t *local,
                    const inet_address_t *remote)
 {
     int ifindex;
@@ -850,19 +1271,19 @@
         return -EINVAL;
     }
 
-    ifindex = if_nametoindex(iface);
+    ifindex = openvpn_if_nametoindex(iface, ctx);
     if (ifindex == 0)
     {
-        msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(iface), strerror(errno));
+        msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, np(iface));
         return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,
+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,
                           remote, 0);
 }
 
 static int
-sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, const inet_address_t *local)
+sitnl_addr_ptp_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, const inet_address_t *local)
 {
     int ifindex;
 
@@ -882,23 +1303,23 @@
         return -EINVAL;
     }
 
-    ifindex = if_nametoindex(iface);
+    ifindex = openvpn_if_nametoindex(iface, ctx);
     if (ifindex == 0)
     {
         msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, iface);
         return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
+    return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
 }
 
 static int
-sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *dst,
+sitnl_route_set(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *dst,
                 int prefixlen, const void *gw, enum rt_class_t table, int metric,
                 enum rt_scope_t scope, unsigned char protocol, unsigned char type)
 {
     struct sitnl_route_req req;
-    int ret = -1, size;
+    int ret = -1, size, orig = -1;
 
     CLEAR(req);
 
@@ -957,14 +1378,17 @@
     {
         SITNL_ADDATTR(&req.n, sizeof(req), RTA_PRIORITY, &metric, 4);
     }
+    orig = netns_switch(ctx);
 
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
     return ret;
 }
 
 static int
-sitnl_addr_add(sa_family_t af_family, const char *iface, const inet_address_t *addr, int prefixlen)
+sitnl_addr_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, const inet_address_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -984,19 +1408,19 @@
         return -EINVAL;
     }
 
-    ifindex = if_nametoindex(iface);
+    ifindex = openvpn_if_nametoindex(iface, ctx);
     if (ifindex == 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
                           prefixlen);
 }
 
 static int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr, int prefixlen)
+sitnl_addr_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, inet_address_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -1016,14 +1440,14 @@
         return -EINVAL;
     }
 
-    ifindex = if_nametoindex(iface);
+    ifindex = openvpn_if_nametoindex(iface, ctx);
     if (ifindex == 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__, iface);
         return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);
+    return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);
 }
 
 int
@@ -1042,7 +1466,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET, &addr_v4.ipv4, buf, sizeof(buf)),
         prefixlen, iface);
 
-    return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }
 
 int
@@ -1062,7 +1486,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &addr_v6.ipv6, buf, sizeof(buf)),
         prefixlen, iface);
 
-    return sitnl_addr_add(AF_INET6, iface, &addr_v6, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }
 
 int
@@ -1081,7 +1505,7 @@
     msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF_INET, &addr_v4.ipv4, buf, sizeof(buf)),
         iface);
 
-    return sitnl_addr_del(AF_INET, iface, &addr_v4, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }
 
 int
@@ -1101,7 +1525,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &addr_v6.ipv6, buf, sizeof(buf)),
         prefixlen, iface);
 
-    return sitnl_addr_del(AF_INET6, iface, &addr_v6, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }
 
 int
@@ -1129,7 +1553,7 @@
         inet_ntop(AF_INET, &local_v4.ipv4, buf1, sizeof(buf1)),
         inet_ntop(AF_INET, &remote_v4.ipv4, buf2, sizeof(buf2)), iface);
 
-    return sitnl_addr_ptp_add(AF_INET, iface, &local_v4, &remote_v4);
+    return sitnl_addr_ptp_add(ctx, AF_INET, iface, &local_v4, &remote_v4);
 }
 
 int
@@ -1150,11 +1574,11 @@
     msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF_INET, &local_v4.ipv4, buf, sizeof(buf)),
         iface);
 
-    return sitnl_addr_ptp_del(AF_INET, iface, &local_v4);
+    return sitnl_addr_ptp_del(ctx, AF_INET, iface, &local_v4);
 }
 
 static int
-sitnl_route_add(const char *iface, sa_family_t af_family, const void *dst, int prefixlen,
+sitnl_route_add(openvpn_net_ctx_t *ctx, const char *iface, sa_family_t af_family, const void *dst, int prefixlen,
                 const void *gw, uint32_t table, int metric)
 {
     enum rt_scope_t scope = RT_SCOPE_UNIVERSE;
@@ -1162,7 +1586,7 @@
 
     if (iface)
     {
-        ifindex = if_nametoindex(iface);
+        ifindex = openvpn_if_nametoindex(iface, ctx);
         if (ifindex == 0)
         {
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __func__, iface);
@@ -1180,7 +1604,7 @@
         scope = RT_SCOPE_LINK;
     }
 
-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,
+    return sitnl_route_set(ctx, RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,
                            table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
@@ -1209,7 +1633,7 @@
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
-    return sitnl_route_add(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);
+    return sitnl_route_add(ctx, iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);
 }
 
 int
@@ -1235,18 +1659,18 @@
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
-    return sitnl_route_add(iface, AF_INET6, dst, prefixlen, gw, table, metric);
+    return sitnl_route_add(ctx, iface, AF_INET6, dst, prefixlen, gw, table, metric);
 }
 
 static int
-sitnl_route_del(const char *iface, sa_family_t af_family, inet_address_t *dst, int prefixlen,
+sitnl_route_del(openvpn_net_ctx_t *ctx, const char *iface, sa_family_t af_family, inet_address_t *dst, int prefixlen,
                 inet_address_t *gw, uint32_t table, int metric)
 {
     int ifindex = 0;
 
     if (iface)
     {
-        ifindex = if_nametoindex(iface);
+        ifindex = openvpn_if_nametoindex(iface, ctx);
         if (ifindex == 0)
         {
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __func__, iface);
@@ -1259,7 +1683,7 @@
         table = RT_TABLE_MAIN;
     }
 
-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,
+    return sitnl_route_set(ctx, RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,
                            RT_SCOPE_NOWHERE, 0, 0);
 }
 
@@ -1286,7 +1710,7 @@
         inet_ntop(AF_INET, &dst_v4.ipv4, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4.ipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
-    return sitnl_route_del(iface, AF_INET, &dst_v4, prefixlen, &gw_v4, table, metric);
+    return sitnl_route_del(ctx, iface, AF_INET, &dst_v4, prefixlen, &gw_v4, table, metric);
 }
 
 int
@@ -1312,7 +1736,7 @@
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
-    return sitnl_route_del(iface, AF_INET6, &dst_v6, prefixlen, &gw_v6, table, metric);
+    return sitnl_route_del(ctx, iface, AF_INET6, &dst_v6, prefixlen, &gw_v6, table, metric);
 }
 
 
@@ -1356,44 +1780,11 @@
     msg(D_ROUTE, "%s: add %s type %s", __func__, iface, type);
 
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
     return ret;
 }
 
-static int
-sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,
-                         unsigned short flags)
-{
-    unsigned short type;
-
-    memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
-
-    while (RTA_OK(rta, len))
-    {
-        type = rta->rta_type & ~flags;
-
-        if ((type <= max) && (!tb[type]))
-        {
-            tb[type] = rta;
-        }
-
-        rta = RTA_NEXT(rta, len);
-    }
-
-    if (len)
-    {
-        msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=%u)", __func__, len, rta->rta_len);
-    }
-
-    return 0;
-}
-
-static int
-sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len)
-{
-    return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
-}
-
 #define sitnl_parse_rtattr_nested(tb, max, rta) \
     (sitnl_parse_rtattr_flags(tb, max, RTA_DATA(rta), RTA_PAYLOAD(rta), NLA_F_NESTED))
 
@@ -1436,13 +1827,16 @@
 net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_link_req req = {};
-    int ifindex = if_nametoindex(iface);
+    int ifindex = openvpn_if_nametoindex(iface, ctx);
+    int orig = -1;
 
     if (!ifindex)
     {
         return -errno;
     }
 
+    orig = netns_switch(ctx);
+
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
     req.n.nlmsg_type = RTM_GETLINK;
@@ -1455,26 +1849,32 @@
     int ret = sitnl_send(&req.n, 0, 0, sitnl_type_save, type);
     if (ret < 0)
     {
+        netns_restore(orig);
         msg(D_ROUTE, "%s: cannot retrieve iface %s: %s (%d)", __func__, iface, strerror(-ret), ret);
         return ret;
     }
 
     msg(D_ROUTE, "%s: type of %s: %s", __func__, iface, type);
 
+    netns_restore(orig);
+
     return 0;
 }
 
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
+    int ret = -1, orig = -1;
     struct sitnl_link_req req = {};
-    int ifindex = if_nametoindex(iface);
+    int ifindex = openvpn_if_nametoindex(iface, ctx);
 
     if (!ifindex)
     {
         return -errno;
     }
 
+    orig = netns_switch(ctx);
+
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags = NLM_F_REQUEST;
     req.n.nlmsg_type = RTM_DELLINK;
@@ -1484,7 +1884,11 @@
 
     msg(D_ROUTE, "%s: delete %s", __func__, iface);
 
-    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+    ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    netns_restore(orig);
+
+    return ret;
 }
 
 #endif /* !ENABLE_SITNL */
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index 481cc36..7e723fe 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -21,7 +21,97 @@
 #ifndef NETWORKING_SITNL_H_
 #define NETWORKING_SITNL_H_
 
+#include "env_set.h"
+
 typedef char openvpn_net_iface_t;
-typedef void *openvpn_net_ctx_t;
+
+struct openvpn_net_ctx
+{
+    const char *netns;
+    struct gc_arena gc;
+};
+
+typedef struct openvpn_net_ctx openvpn_net_ctx_t;
+
+/**
+ * @brief Switch the current thread to the network namespace specified
+ *        in the given OpenVPN network context.
+ *
+ * This function changes the calling thread's network namespace to the one
+ * identified by ctx->netns. The current (original) network namespace file
+ * descriptor is saved and returned, so it can later be restored using
+ * netns_restore().
+ *
+ * If @p ctx is NULL or ctx->netns is NULL, the function fails and returns -1.
+ *
+ * The switch is performed using setns(2). This approach is required because
+ * the netlink library does not support performing operations in an arbitrary
+ * target network namespace, except for interface creation and deletion.
+ * Therefore, in order to execute generic netlink operations inside a
+ * specific network namespace, the thread must temporarily enter
+ * that namespace via setns().
+ *
+ * @param ctx  Pointer to an OpenVPN network context structure containing
+ *             the target network namespace name (ctx->netns). The namespace
+ *             is expected to exist under NETNS_RUN_DIR (e.g. /run/netns/).
+ *
+ * @return On success, returns a file descriptor referring to the original
+ *         network namespace. This descriptor must be passed to
+ *         netns_restore() to switch back.
+ * @return -1 on failure (an error is logged and no namespace switch is kept).
+ *
+ * @note The returned file descriptor must be passed to netns_restore(),
+ *       which will restore the original namespace and close it.
+ */
+int netns_switch(openvpn_net_ctx_t *ctx);
+
+/**
+ * @brief Restore the previously saved network namespace.
+ *
+ * This function restores the network namespace saved by netns_switch()
+ * using the file descriptor returned by that function.
+ *
+ * If @p orig_fd is negative, the function does nothing and returns
+ * immediately.
+ *
+ * The restoration is performed using setns(2), switching the calling
+ * thread back to its original network namespace.
+ *
+ * @param orig_fd  File descriptor of the original network namespace,
+ *                 as returned by netns_switch().
+ *
+ * @note This function always closes @p orig_fd if it is >= 0,
+ *       regardless of whether setns() succeeds or fails.
+ *       After calling this function, @p orig_fd must not be reused.
+ */
+void netns_restore(int orig_fd);
+
+/**
+ * Resolve a network interface name to its interface index.
+ *
+ * If a valid network namespace ID is provided, the lookup is performed inside
+ * that network namespace using Netlink. Otherwise, this function falls back
+ * to the standard `if_nametoindex()` call in the current namespace.
+ *
+ * @param ifname   Name of the network interface.
+ * @param ctx      The network context where we retrieve
+ *                 the network namespace name.
+ *
+ * @return Interface index on success, or 0 on error.
+ */
+int openvpn_if_nametoindex(const char *ifname, openvpn_net_ctx_t *ctx);
+
+/**
+ * Retrieve or create a network namespace ID (NSID) for a given namespace.
+ *
+ * This function first attempts to retrieve the NSID associated with the
+ * specified network namespace. If no NSID is currently assigned, it
+ * requests the kernel to create one and then retries the lookup.
+ *
+ * @param name  Name of the network namespace.
+ *
+ * @return The network namespace ID on success, or -1 on failure.
+ */
+int get_or_create_netnsid_sitnl(const char *name);
 
 #endif /* NETWORKING_SITNL_H_ */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 713dcf4..8dc36b2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6488,6 +6488,14 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mtu_test = true;
     }
+    else if (streq(p[0], "netns") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --netns is supported only on Linux when compiled with SITNL");
+#endif
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->netns = p[1];
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 422820c..892e376 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -315,6 +315,7 @@
 
     struct dns_options dns_options;
 
+    const char *netns;
     bool remote_random;
     const char *ipchange;
     const char *dev;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f46802f..68378d8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2082,6 +2082,13 @@
     }
     else
     {
+#if defined(TARGET_LINUX) && defined(ENABLE_SITNL)
+        int orig_fd = -1;
+        if (ctx->netns)
+        {
+            orig_fd = netns_switch(ctx);
+        }
+#endif /* if defined(TARGET_LINUX) && defined(ENABLE_SITNL) */
         /*
          * Process --dev-node
          */
@@ -2098,6 +2105,12 @@
         {
             msg(M_ERR, "ERROR: Cannot open TUN/TAP dev %s", node);
         }
+#if defined(TARGET_LINUX) && defined(ENABLE_SITNL)
+        if (orig_fd != -1)
+        {
+            netns_restore(orig_fd);
+        }
+#endif
 
         /*
          * Process --tun-ipv6

