From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 13 Feb 2026 12:35:24 +0000
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <16d27b390b0b4bac5349bedbf734178a4bae5bf3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JfLe9Voq0W4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for user
 defined network namespace
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JfLe9Voq0W4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail

to review the following change.


Change subject: Add support for user defined network namespace
......................................................................

Add support for user defined network namespace

Introduce the --netns option to allow moving the tunnel interface
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
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/dco.c
M src/openvpn/networking.h
M src/openvpn/networking_sitnl.c
M src/openvpn/networking_sitnl.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/tun.c
8 files changed, 707 insertions(+), 46 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1521/1

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 33ebedb..cd54cd4 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -304,6 +304,12 @@
   Specify the link layer address, more commonly known as the MAC address.
   Only applied to TAP devices.

+--netns name
+  Move the created tunnel interface into the specified network
+  namespace. The namespace must already exist.
+
+  (Supported on Linux only, on other platforms this is a no-op).
+
 --persist-tun
   Don't close and reopen TUN/TAP device or run up/down scripts across
   :code:`SIGUSR1` or ``--ping-restart`` restarts.
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 26b8645..879590f 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -388,6 +388,12 @@
                 ret);
         }
     }
+
+    if (o->netns)
+    {
+        msg(msglevel, "Note: --netns not supported by ovpn-dco, disabling =
data channel offload.");
+        return false;
+    }
 #endif /* if defined(_WIN32) */

 #if defined(HAVE_LIBCAPNG)
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index bce0c19..526dd49 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -42,7 +42,7 @@
 /* Only the iproute2 backend implements these functions,
  * the rest can rely on these stubs
  */
-#if !defined(ENABLE_IPROUTE)
+#if !defined(ENABLE_IPROUTE) && !defined(ENABLE_SITNL) || defined(TARGET_A=
NDROID)
 static inline int
 net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
@@ -63,7 +63,7 @@
 {
     (void)ctx;
 }
-#endif /* !defined(ENABLE_IPROUTE) */
+#endif /* !defined(ENABLE_IPROUTE) && !defined(ENABLE_SITNL) || defined(TA=
RGET_ANDROID) */

 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index a5b2905..120ee6c 100644
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
         _nest->rta_len =3D (unsigned short)((void *)sitnl_nlmsg_tail(_msg)=
 - (void *)_nest); \
     }

+#define SITNL_NETNS_RTA(r) \
+    ((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct rtgenmsg)=
)))
+
+#define NETNS_RUN_DIR  "/var/run/netns"
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
@@ -165,6 +184,101 @@
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
+    ctx->netns =3D NULL;
+
+    if (c && c->options.netns)
+    {
+        snprintf(path, sizeof(path), "%s/%s", NETNS_RUN_DIR, c->options.ne=
tns);
+
+        if (stat(path, &st) !=3D 0)
+        {
+            msg(M_WARN, "%s: Network namespace %s does not exist\n", __fun=
c__, path);
+            return -1;
+        }
+
+        ctx->netns =3D c->options.netns;
+    }
+
+    ctx->gc =3D gc_new();
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
+netns_switch(const char *name)
+{
+    char net_path[PATH_MAX];
+    int orig_fd, netns_fd;
+
+    /* Save current netns descriptor */
+    orig_fd =3D open(NETNS_ORIG_DIR, O_RDONLY | O_CLOEXEC);
+    if (orig_fd < 0)
+    {
+        msg(M_WARN, "%s: Cannot open original network namespace\n", __func=
__);
+        return -1;
+    }
+
+    snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, name);
+    netns_fd =3D open(net_path, O_RDONLY | O_CLOEXEC);
+    if (netns_fd < 0)
+    {
+        msg(M_WARN, "%s: Cannot open network namespace \"%s\"\n", __func__=
, name);
+        close(orig_fd);
+        return -1;
+    }
+
+    if (setns(netns_fd, CLONE_NEWNET) < 0)
+    {
+        msg(M_WARN, "%s: setting the network namespace \"%s\" failed\n", _=
_func__, name);
+        close(netns_fd);
+        close(orig_fd);
+        return -1;
+    }
+
+    close(netns_fd);
+    return orig_fd;
+}
+
+int
+netns_restore(int orig_fd)
+{
+    if (orig_fd < 0)
+        return -1;
+
+    if (setns(orig_fd, CLONE_NEWNET) < 0)
+    {
+        msg(M_WARN, "%s: Cannot restore original network namespace\n", __f=
unc__);
+        close(orig_fd);
+        return -1;
+    }
+
+    close(orig_fd);
+    return 0;
+}
+#endif /* defined (TARGET_LINUX) && defined (ENABLE_SITNL) */
+
 /**
  * Open RTNL socket
  */
@@ -454,6 +568,90 @@
     return ret;
 }

+/**
+ * Netlink callback to extract the interface index from a RTM_NEWLINK mess=
age.
+ *
+ * This function is used as a Netlink response handler. It inspects incomi=
ng
+ * Netlink messages and, when a RTM_NEWLINK message is received, copies the
+ * contained `struct ifinfomsg` into the caller-provided result structure.
+ *
+ * @param n    Netlink message header received from the kernel.
+ * @param arg  Pointer to a `struct sitnl_link_req` used to store the resu=
lt.
+ *
+ * @return 0 to stop Netlink message processing once the interface is foun=
d,
+ *         1 to continue processing other messages.
+ */
+static int
+sitnl_link_get_ifindex(struct nlmsghdr *n, void *arg)
+{
+    struct sitnl_link_req *res =3D arg;
+    struct ifinfomsg *ifi;
+
+    if (n->nlmsg_type !=3D RTM_NEWLINK)
+        return 1;
+
+    ifi =3D NLMSG_DATA(n);
+    res->i =3D *ifi;
+
+    return 0;
+}
+
+/**
+ * Retrieve the interface index of a network device in a specific network =
namespace.
+ *
+ * Sends an RTM_GETLINK Netlink request targeting the given network namesp=
ace ID
+ * and interface name, and extracts the resulting interface index from the=
 kernel
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
+    int ret =3D -1, ifindex =3D 0;
+
+    CLEAR(req);
+    CLEAR(res);
+
+    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_type =3D RTM_GETLINK;
+    req.n.nlmsg_flags =3D NLM_F_REQUEST;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_TARGET_NETNSID, &netnsid, 4);
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_IFNAME, ifname, strlen(ifname)=
 + 1);
+
+    ret =3D sitnl_send(&req.n, 0, 0, sitnl_link_get_ifindex, &res);
+
+    if (ret < 0)
+    {
+        goto err;
+    }
+
+    ifindex =3D res.i.ifi_index;
+
+err:
+    return ifindex;
+}
+
+int
+openvpn_if_nametoindex(const char *ifname, int netnsid)
+{
+    if (netnsid < 0)
+    {
+        return if_nametoindex(ifname);
+    }
+
+    return get_ifindex_in_netns(ifname, netnsid);
+}
+
 typedef struct
 {
     size_t addr_size;
@@ -624,6 +822,53 @@
     return ret;
 }

+int
+net_iface_move_netns(const char *iface, const char *netns)
+{
+    struct sitnl_link_req req =3D {};
+    int ret =3D -1, ifindex;
+    char net_path[PATH_MAX];
+
+    ASSERT(iface);
+    ASSERT(netns);
+
+    snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, netns);
+
+    ifindex =3D if_nametoindex(iface);
+    if (ifindex =3D=3D 0)
+    {
+        msg(M_ERR, "%s: if_nametoindex(%s) failed", __func__, iface);
+        goto err;
+    }
+
+    int netns_fd =3D open(net_path, O_RDONLY);
+    if (netns_fd < 0)
+    {
+        msg(M_ERR, "%s: open(%s) failed: %s", __func__, netns, strerror(er=
rno));
+        goto err;
+    }
+
+    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_type =3D RTM_SETLINK;
+    req.n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
+
+    req.i.ifi_family =3D AF_UNSPEC;
+    req.i.ifi_index =3D ifindex;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_NET_NS_FD, &netns_fd, sizeof(n=
etns_fd));
+
+    msg(D_ROUTE, "%s: move %s to netns %s", __func__, iface, netns);
+
+    ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+err:
+    if (netns_fd >=3D 0)
+    {
+        close(netns_fd);
+    }
+    return ret;
+}
+
 /* used by iproute2 implementation too */
 int
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst, in_addr=
_t *best_gw,
@@ -661,17 +906,23 @@
 net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;
-    int ifindex;
+    int ifindex, orig =3D -1, ret =3D -1;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     CLEAR(req);

+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
     if (!iface)
     {
         msg(M_WARN, "%s: passed NULL interface", __func__);
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(=
netns));
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, i=
face, strerror(errno));
@@ -696,18 +947,35 @@

     msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");

-    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+    ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+    if (ret < 0)
+    {
+        goto err;
+    }
+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
+
+err:
+    return ret;
 }

 int
 net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ifindex, orig =3D -1, ret =3D -1;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     CLEAR(req);

-    ifindex =3D if_nametoindex(iface);
+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(=
netns));
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fun=
c__, iface);
@@ -726,6 +994,11 @@
     msg(M_INFO, "%s: mtu %u for %s", __func__, mtu, iface);

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
 err:
     return ret;
 }
@@ -734,11 +1007,18 @@
 net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, =
uint8_t *addr)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ifindex, orig =3D -1, ret =3D -1;
+    const char *netns =3D ctx ? ctx->netns : NULL;
=20
     CLEAR(req);

-    ifindex =3D if_nametoindex(iface);
+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
+
+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(=
netns));
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fun=
c__, iface);
@@ -757,20 +1037,32 @@
     msg(M_INFO, "%s: lladdr " MAC_FMT " for %s", __func__, MAC_PRINT_ARG(a=
ddr), iface);

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
 err:
     return ret;
 }

 static int
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_f=
amily,
+sitnl_addr_set(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int i=
findex, sa_family_t af_family,
                const inet_address_t *local, const inet_address_t *remote, =
int prefixlen)
 {
     struct sitnl_addr_req req;
     uint32_t size;
-    int ret =3D -EINVAL;
+    int ret =3D -EINVAL, orig =3D -1;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     CLEAR(req);

+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_type =3D cmd;
     req.n.nlmsg_flags =3D NLM_F_REQUEST | flags;
@@ -820,19 +1112,25 @@
     }

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
     if (ret =3D=3D -EEXIST)
     {
         ret =3D 0;
     }
+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
 err:
     return ret;
 }

 static int
-sitnl_addr_ptp_add(sa_family_t af_family, const char *iface, const inet_ad=
dress_t *local,
+sitnl_addr_ptp_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const ch=
ar *iface, const inet_address_t *local,
                    const inet_address_t *remote)
 {
     int ifindex;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     switch (af_family)
     {
@@ -850,21 +1148,22 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(=
netns));
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(ifac=
e), strerror(errno));
         return -ENOENT;
     }

-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifind=
ex, af_family, local,
+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, =
ifindex, af_family, local,
                           remote, 0);
 }

 static int
-sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, const inet_ad=
dress_t *local)
+sitnl_addr_ptp_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const ch=
ar *iface, const inet_address_t *local)
 {
     int ifindex;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     switch (af_family)
     {
@@ -882,26 +1181,33 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(=
netns));
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, i=
face);
         return -ENOENT;
     }

-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL,=
 0);
+    return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, local, =
NULL, 0);
 }

 static int
-sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_=
family, const void *dst,
+sitnl_route_set(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int =
ifindex, sa_family_t af_family, const void *dst,
                 int prefixlen, const void *gw, enum rt_class_t table, int =
metric,
                 enum rt_scope_t scope, unsigned char protocol, unsigned ch=
ar type)
 {
     struct sitnl_route_req req;
-    int ret =3D -1, size;
+    int ret =3D -1, size, orig =3D -1;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     CLEAR(req);

+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
+
     switch (af_family)
     {
         case AF_INET:
@@ -959,14 +1265,20 @@
     }

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
 err:
     return ret;
 }

 static int
-sitnl_addr_add(sa_family_t af_family, const char *iface, const inet_addres=
s_t *addr, int prefixlen)
+sitnl_addr_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *=
iface, const inet_address_t *addr, int prefixlen)
 {
     int ifindex;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     switch (af_family)
     {
@@ -984,20 +1296,21 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(=
netns));
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fun=
c__, iface);
         return -ENOENT;
     }

-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifind=
ex, af_family, addr, NULL,
+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, =
ifindex, af_family, addr, NULL,
                           prefixlen);
 }

 static int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *a=
ddr, int prefixlen)
+sitnl_addr_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *=
iface, inet_address_t *addr, int prefixlen)
 {
+    const char *netns =3D ctx ? ctx->netns : NULL;
     int ifindex;

     switch (af_family)
@@ -1016,14 +1329,14 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(=
netns));
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fun=
c__, iface);
         return -ENOENT;
     }

-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, =
prefixlen);
+    return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, addr, N=
ULL, prefixlen);
 }

 int
@@ -1042,7 +1355,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET, &addr_v4.=
ipv4, buf, sizeof(buf)),
         prefixlen, iface);

-    return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }

 int
@@ -1062,7 +1375,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &addr_v6=
.ipv6, buf, sizeof(buf)),
         prefixlen, iface);

-    return sitnl_addr_add(AF_INET6, iface, &addr_v6, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }

 int
@@ -1081,7 +1394,7 @@
     msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF_INET, &addr_v4.ipv=
4, buf, sizeof(buf)),
         iface);

-    return sitnl_addr_del(AF_INET, iface, &addr_v4, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }

 int
@@ -1101,7 +1414,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &addr_v6=
.ipv6, buf, sizeof(buf)),
         prefixlen, iface);

-    return sitnl_addr_del(AF_INET6, iface, &addr_v6, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }

 int
@@ -1129,7 +1442,7 @@
         inet_ntop(AF_INET, &local_v4.ipv4, buf1, sizeof(buf1)),
         inet_ntop(AF_INET, &remote_v4.ipv4, buf2, sizeof(buf2)), iface);

-    return sitnl_addr_ptp_add(AF_INET, iface, &local_v4, &remote_v4);
+    return sitnl_addr_ptp_add(ctx, AF_INET, iface, &local_v4, &remote_v4);
 }

 int
@@ -1150,19 +1463,20 @@
     msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF_INET, &local_v4.ip=
v4, buf, sizeof(buf)),
         iface);

-    return sitnl_addr_ptp_del(AF_INET, iface, &local_v4);
+    return sitnl_addr_ptp_del(ctx, AF_INET, iface, &local_v4);
 }

 static int
-sitnl_route_add(const char *iface, sa_family_t af_family, const void *dst,=
 int prefixlen,
+sitnl_route_add(openvpn_net_ctx_t *ctx, const char *iface, sa_family_t af_=
family, const void *dst, int prefixlen,
                 const void *gw, uint32_t table, int metric)
 {
+    const char *netns =3D ctx ? ctx->netns : NULL;
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;
     int ifindex =3D 0;

     if (iface)
     {
-        ifindex =3D if_nametoindex(iface);
+        ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_si=
tnl(netns));
         if (ifindex =3D=3D 0)
         {
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __=
func__, iface);
@@ -1180,7 +1494,7 @@
         scope =3D RT_SCOPE_LINK;
     }

-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family,=
 dst, prefixlen, gw,
+    return sitnl_route_set(ctx, RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_fa=
mily, dst, prefixlen, gw,
                            table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }

@@ -1209,7 +1523,7 @@
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), tab=
le, metric);

-    return sitnl_route_add(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, tab=
le, metric);
+    return sitnl_route_add(ctx, iface, AF_INET, dst_ptr, prefixlen, gw_ptr=
, table, metric);
 }

 int
@@ -1235,18 +1549,19 @@
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefi=
xlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface=
), table, metric);

-    return sitnl_route_add(iface, AF_INET6, dst, prefixlen, gw, table, met=
ric);
+    return sitnl_route_add(ctx, iface, AF_INET6, dst, prefixlen, gw, table=
, metric);
 }

 static int
-sitnl_route_del(const char *iface, sa_family_t af_family, inet_address_t *=
dst, int prefixlen,
+sitnl_route_del(openvpn_net_ctx_t *ctx, const char *iface, sa_family_t af_=
family, inet_address_t *dst, int prefixlen,
                 inet_address_t *gw, uint32_t table, int metric)
 {
+    const char *netns =3D ctx ? ctx->netns : NULL;
     int ifindex =3D 0;

     if (iface)
     {
-        ifindex =3D if_nametoindex(iface);
+        ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_si=
tnl(netns));
         if (ifindex =3D=3D 0)
         {
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __=
func__, iface);
@@ -1259,7 +1574,7 @@
         table =3D RT_TABLE_MAIN;
     }

-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefi=
xlen, gw, table, metric,
+    return sitnl_route_set(ctx, RTM_DELROUTE, 0, ifindex, af_family, dst, =
prefixlen, gw, table, metric,
                            RT_SCOPE_NOWHERE, 0, 0);
 }

@@ -1286,7 +1601,7 @@
         inet_ntop(AF_INET, &dst_v4.ipv4, dst_str, sizeof(dst_str)), prefix=
len,
         inet_ntop(AF_INET, &gw_v4.ipv4, gw_str, sizeof(gw_str)), np(iface)=
, table, metric);

-    return sitnl_route_del(iface, AF_INET, &dst_v4, prefixlen, &gw_v4, tab=
le, metric);
+    return sitnl_route_del(ctx, iface, AF_INET, &dst_v4, prefixlen, &gw_v4=
, table, metric);
 }

 int
@@ -1312,7 +1627,7 @@
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefi=
xlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface=
), table, metric);

-    return sitnl_route_del(iface, AF_INET6, &dst_v6, prefixlen, &gw_v6, ta=
ble, metric);
+    return sitnl_route_del(ctx, iface, AF_INET6, &dst_v6, prefixlen, &gw_v=
6, table, metric);
 }


@@ -1320,10 +1635,16 @@
 net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,=
 void *arg)
 {
     struct sitnl_link_req req =3D {};
-    int ret =3D -1;
+    int ret =3D -1, orig =3D -1;
+    const char *netns =3D ctx ? ctx->netns : NULL;

     ASSERT(iface);

+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
     req.n.nlmsg_type =3D RTM_NEWLINK;
@@ -1348,6 +1669,11 @@
     msg(D_ROUTE, "%s: add %s type %s", __func__, iface, type);

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
 err:
     return ret;
 }
@@ -1424,17 +1750,189 @@
     return 0;
 }

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
+    int *nsid =3D arg;
+    struct rtgenmsg *g =3D NLMSG_DATA(n);
+    struct rtattr *tb[NETNSA_MAX + 1];
+    int ret;
+
+    if (n->nlmsg_type =3D=3D NLMSG_ERROR)
+    {
+        struct nlmsgerr *err =3D NLMSG_DATA(n);
+        return err->error;
+    }
+
+    ret =3D sitnl_parse_rtattr(tb, NETNSA_MAX, SITNL_NETNS_RTA(g), NLMSG_P=
AYLOAD(n, sizeof(*g)));
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
+ * Retrieve the network namespace ID (NSID) associated with a namespace na=
me.
+ *
+ * This function opens the network namespace identified by the given path
+ * and sends an RTM_GETNSID Netlink request to retrieve its assigned NSID.
+ *
+ * @param name  Name of the network namespace.
+ *
+ * @return The network namespace ID on success, or a negative value on fai=
lure.
+ */
+static int
+netns_id_from_name_sitnl(const char *name)
+{
+    struct sitnl_nsid_req req;
+
+    int ret =3D -1, netnsid =3D -1;
+    CLEAR(req);
+
+    int netns_fd =3D open(name, O_RDONLY);
+    if (netns_fd < 0)
+    {
+        goto err;
+    }
+
+    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.g));
+    req.n.nlmsg_type =3D RTM_GETNSID;
+    req.n.nlmsg_flags =3D NLM_F_REQUEST;
+    req.g.rtgen_family =3D AF_UNSPEC;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_FD, &netns_fd, 4);
+
+    ret =3D sitnl_send(&req.n, 0, 0, sitnl_nsid_save, &netnsid);
+
+    if (ret < 0)
+    {
+        goto err;
+    }
+
+err:
+    if (netns_fd >=3D 0)
+    {
+        close(netns_fd);
+    }
+
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
+    int ret =3D -1, netnsid =3D -1;
+    CLEAR(req);
+
+    int netns_fd =3D open(name, O_RDONLY);
+    if (netns_fd < 0)
+    {
+        goto err;
+    }
+
+    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.g));
+    req.n.nlmsg_type =3D RTM_NEWNSID;
+    req.n.nlmsg_flags =3D NLM_F_REQUEST;
+    req.g.rtgen_family =3D AF_UNSPEC;
+
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_FD, &netns_fd, 4);
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_NSID, &netnsid, 4);
+
+    ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    if (ret < 0)
+    {
+        goto err;
+    }
+
+err:
+    if (netns_fd >=3D 0)
+    {
+        close(netns_fd);
+    }
+
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
+    netnsid =3D netns_id_from_name_sitnl(net_path);
+    if (netnsid >=3D 0)
+        return netnsid;
+
+    /* No netnsid yet? Try to assign one */
+    netnsid =3D set_netns_id_from_name_sitnl(net_path);
+    if (netnsid < 0)
+        return -1;
+
+    /* Second get */
+    netnsid =3D netns_id_from_name_sitnl(net_path);
+    if (netnsid >=3D 0)
+        return netnsid;
+
+    return -1;
+}
+
 int
 net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_=
TYPE_LEN_MAX])
 {
+    const char *netns =3D ctx ? ctx->netns : NULL;
     struct sitnl_link_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    int ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_si=
tnl(netns));
+    int orig =3D -1;

     if (!ifindex)
     {
         return -errno;
     }

+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
     req.n.nlmsg_type =3D RTM_GETLINK;
@@ -1453,20 +1951,32 @@

     msg(D_ROUTE, "%s: type of %s: %s", __func__, iface, type);

+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
+
     return 0;
 }

 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
+    int ret =3D -1, orig =3D -1;
     struct sitnl_link_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    const char *netns =3D ctx ? ctx->netns : NULL;
+    int ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_si=
tnl(netns));

     if (!ifindex)
     {
         return -errno;
     }

+    if (netns)
+    {
+        orig =3D netns_switch(netns);
+    }
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
     req.n.nlmsg_type =3D RTM_DELLINK;
@@ -1476,7 +1986,20 @@

     msg(D_ROUTE, "%s: delete %s", __func__, iface);

-    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+    ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    if (ret < 0)
+    {
+        goto err;
+    }
+
+    if (orig >=3D 0)
+    {
+        netns_restore(orig);
+    }
+
+err:
+    return ret;
 }

 #endif /* !ENABLE_SITNL */
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index 481cc36..731a0e4 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -21,7 +21,111 @@
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
+ * @brief Switch the current thread to the specified network namespace.
+ *
+ * This function changes the calling thread's network namespace to the one
+ * identified by @p name. The current (original) network namespace file
+ * descriptor is saved and returned, so it can later be restored using
+ * netns_restore().
+ *
+ * The switch is performed using setns(2). This approach is required becau=
se
+ * the netlink library does not support performing operations in an arbitr=
ary
+ * target network namespace, except for interface creation and deletion.
+ * Therefore, in order to execute generic netlink operations inside a
+ * specific network namespace, the thread must temporarily enter
+ * that namespace via setns().
+ *
+ * @param name  Name of the target network namespace (as found under
+ *              NETNS_RUN_DIR, e.g. /var/run/netns/<name>).
+ *
+ * @return On success, returns a file descriptor referring to the original
+ *         network namespace. This descriptor must be passed to
+ *         netns_restore() to switch back.
+ * @return -1 on failure (an error is logged and no namespace switch is ke=
pt).
+ *
+ * @note The returned file descriptor must be closed by calling
+ *       netns_restore(). Failing to do so may leak file descriptors.
+ */
+int netns_switch(const char *name);
+
+/**
+ * @brief Restore the previously saved network namespace.
+ *
+ * This function restores the network namespace saved by netns_switch()
+ * using the file descriptor returned by that function.
+ *
+ * The restoration is performed using setns(2), switching the calling
+ * thread back to its original network namespace.
+ *
+ * @param orig_fd  File descriptor of the original network namespace,
+ *                 as returned by netns_switch().
+ *
+ * @return 0 on success.
+ * @return -1 on failure (an error is logged and the file descriptor
+ *         is closed).
+ *
+ * @note This function closes @p orig_fd in all cases.
+ *       After calling this function, @p orig_fd must not be reused.
+ */
+int netns_restore(int orig_fd);
+
+/**
+ * Resolve a network interface name to its interface index.
+ *
+ * If a valid network namespace ID is provided, the lookup is performed in=
side
+ * that network namespace using Netlink. Otherwise, this function falls ba=
ck
+ * to the standard `if_nametoindex()` call in the current namespace.
+ *
+ * @param ifname   Name of the network interface.
+ * @param netnsid  Network namespace ID, or a negative value to use the cu=
rrent
+ *                 namespace.
+ *
+ * @return Interface index on success, or 0 on error.
+ */
+int openvpn_if_nametoindex(const char *ifname, int netnsid);
+
+/**
+ * Move a network interface to a different network namespace.
+ *
+ * This function moves the specified network interface from the current
+ * network namespace into the target network namespace identified by name.
+ * The operation is performed via a RTM_SETLINK Netlink request using the
+ * IFLA_NET_NS_FD attribute.
+ *
+ * The target network namespace is expected to exist under NETNS_RUN_DIR
+ * (/var/run/netns).
+ *
+ * @param iface  Name of the network interface to move.
+ * @param netns  Name of the target network namespace.
+ *
+ * @return 0 on success, or a negative error code on failure.
+ */
+int net_iface_move_netns(const char *iface, const char *netns);
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
index 2bca647..7b7681a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6473,6 +6473,16 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mtu_test =3D true;
     }
+#if defined(TARGET_LINUX)
+    else if (streq(p[0], "netns") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --netns is supported only on Linux when SITNL i=
s built-in");
+#endif
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->netns =3D p[1];
+    }
+#endif
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 16cfdb5..a19a84c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -316,6 +316,7 @@

     struct dns_options dns_options;

+    const char *netns;
     bool remote_random;
     const char *ipchange;
     const char *dev;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e38df3e..e3c46ea 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2169,6 +2169,17 @@
         set_nonblock(tt->fd);
         set_cloexec(tt->fd);
         tt->actual_name =3D string_alloc(ifr.ifr_name, NULL);
+
+#if defined(TARGET_LINUX) && defined(ENABLE_SITNL)
+        if (ctx->netns)
+        {
+            int ret =3D net_iface_move_netns(ifr.ifr_name, ctx->netns);
+            if (ret < 0)
+            {
+                msg(M_WARN | M_ERRNO, "Note: Cannot move dev %s to network=
 namespace %s", ifr.ifr_name, ctx->netns);
+            }
+        }
+#endif /* if defined (TARGET_LINUX) && defined(ENABLE_SITNL) */
     }
     return;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--JfLe9Voq0W4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>its_Giaan would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Add support for user defined network namesp=
ace<br><br>Introduce the --netns option to allow moving the tunnel interfac=
e<br>into a user-defined network namespace.<br>This allows the VPN data pla=
ne to be isolated from the main<br>OpenVPN process namespace.<br><br>The cu=
rrent netlink library integration supports interface creation<br>and deleti=
on in a target namespace. However, subsequent configuration<br>operations (=
e.g. address or mtu set) are executed in the caller&#39;s<br>namespace, as =
they rely on the default netlink socket context.<br>As a result, interface-=
related configuration performed after creation<br>may be applied in the wro=
ng namespace.<br>Introduce helper functions to temporarily switch the proce=
ss to the<br>requested network namespace using setns(2), execute the requir=
ed<br>netlink operations, and then restore the original namespace.<br>The n=
amespace switch is temporary and scoped to each netlink<br>operation. Once =
the operation completes, the original namespace<br>is restored to preserve =
the process execution context.<br><br>Note: This feature is Linux-only and =
depends on setns(2).<br>It is not compatible (yet) with Data Channel Offloa=
d (DCO).<br><br>Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3<br>Sig=
ned-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M d=
oc/man-sections/vpn-network-options.rst<br>M src/openvpn/dco.c<br>M src/ope=
nvpn/networking.h<br>M src/openvpn/networking_sitnl.c<br>M src/openvpn/netw=
orking_sitnl.h<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M s=
rc/openvpn/tun.c<br>8 files changed, 707 insertions(+), 46 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/21/1521/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/doc/man-sections/vpn-network-optio=
ns.rst b/doc/man-sections/vpn-network-options.rst</span><br><span>index 33e=
bedb..cd54cd4 100644</span><br><span>--- a/doc/man-sections/vpn-network-opt=
ions.rst</span><br><span>+++ b/doc/man-sections/vpn-network-options.rst</sp=
an><br><span>@@ -304,6 +304,12 @@</span><br><span>   Specify the link layer=
 address, more commonly known as the MAC address.</span><br><span>   Only a=
pplied to TAP devices.</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+--netns name</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  Move the created tunnel interface into the specified networ=
k</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  namespace. The n=
amespace must already exist.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (Support=
ed on Linux only, on other platforms this is a no-op).</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --persist-tun</span><b=
r><span>   Don&#39;t close and reopen TUN/TAP device or run up/down scripts=
 across</span><br><span>   :code:`SIGUSR1` or ``--ping-restart`` restarts.<=
/span><br><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><b=
r><span>index 26b8645..879590f 100644</span><br><span>--- a/src/openvpn/dco=
.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -388,6 +388,1=
2 @@</span><br><span>                 ret);</span><br><span>         }</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;netns)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Note:=
 --netns not supported by ovpn-dco, disabling data channel offload.&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span> #endif /* if defined(_WIN32) */</span><br><span> </span><br><span> #i=
f defined(HAVE_LIBCAPNG)</span><br><span>diff --git a/src/openvpn/networkin=
g.h b/src/openvpn/networking.h</span><br><span>index bce0c19..526dd49 10064=
4</span><br><span>--- a/src/openvpn/networking.h</span><br><span>+++ b/src/=
openvpn/networking.h</span><br><span>@@ -42,7 +42,7 @@</span><br><span> /* =
Only the iproute2 backend implements these functions,</span><br><span>  * t=
he rest can rely on these stubs</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if !defined(ENABLE_IPROUTE)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ENABLE_IPROUTE) &amp;=
&amp; !defined(ENABLE_SITNL) || defined(TARGET_ANDROID)</span><br><span> st=
atic inline int</span><br><span> net_ctx_init(struct context *c, openvpn_ne=
t_ctx_t *ctx)</span><br><span> {</span><br><span>@@ -63,7 +63,7 @@</span><b=
r><span> {</span><br><span>     (void)ctx;</span><br><span> }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* !defined(ENABLE_IPROUTE) =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* !define=
d(ENABLE_IPROUTE) &amp;&amp; !defined(ENABLE_SITNL) || defined(TARGET_ANDRO=
ID) */</span><br><span> </span><br><span> #if defined(ENABLE_SITNL) || defi=
ned(ENABLE_IPROUTE)</span><br><span> </span><br><span>diff --git a/src/open=
vpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c</span><br><span>ind=
ex a5b2905..120ee6c 100644</span><br><span>--- a/src/openvpn/networking_sit=
nl.c</span><br><span>+++ b/src/openvpn/networking_sitnl.c</span><br><span>@=
@ -33,14 +33,17 @@</span><br><span> #include &quot;networking.h&quot;</span=
><br><span> #include &quot;proto.h&quot;</span><br><span> #include &quot;ro=
ute.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;openvpn.h&quot;</span><br><span> </span><br><span> #include &lt;errn=
o.h&gt;</span><br><span> #include &lt;string.h&gt;</span><br><span> #includ=
e &lt;unistd.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;sched.h&gt;</span><br><span> #include &lt;sys/types.h&gt;</span=
><br><span> #include &lt;sys/socket.h&gt;</span><br><span> #include &lt;lin=
ux/netlink.h&gt;</span><br><span> #include &lt;linux/rtnetlink.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux/net_nam=
espace.h&gt;</span><br><span> </span><br><span> #define SNDBUF_SIZE (1024 *=
 2)</span><br><span> #define RCVBUF_SIZE (1024 * 4)</span><br><span>@@ -65,=
6 +68,12 @@</span><br><span>         _nest-&gt;rta_len =3D (unsigned short)=
((void *)sitnl_nlmsg_tail(_msg) - (void *)_nest); \</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine SITNL_NETNS_RTA(r) \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct rtg=
enmsg))))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define NETNS_RUN_DIR  &quot;=
/var/run/netns&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define NETNS_ORIG_DIR &quot;/proc/self/ns/net&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* This function was or=
iginally implemented as a macro, but compiling with</span><br><span>  * gcc=
 and -O3 was getting confused about the math and thus raising</span><br><sp=
an>  * security warnings on subsequent memcpy() calls.</span><br><span>@@ -=
121,6 +130,16 @@</span><br><span>     char buf[256];</span><br><span> };</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Network namespace=
 NSID request message</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct sitnl_n=
sid_req</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct nlmsghdr n;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct rtgenmsg g;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char buf[256];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef int (*sitnl_par=
se_reply_cb)(struct nlmsghdr *msg, void *arg);</span><br><span> </span><br>=
<span> /**</span><br><span>@@ -165,6 +184,101 @@</span><br><span>     retur=
n 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; defined(ENABLE_S=
ITNL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static int netns_id_from_name_sit=
nl(const char *name);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static int set_netns_id_from_name_sitnl(const char *name);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct stat st;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char path[PATH_MAX];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ctx-&gt;netns =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (c &amp;&amp; c-&gt;options.netns)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        snprintf(path, sizeof(path), &quot;%s/%s&quot;, NETNS_RUN_DI=
R, c-&gt;options.netns);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (st=
at(path, &amp;st) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_WARN, &quot;%s: Network namespace %s does not exist\n&quot;, =
__func__, path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ctx-&gt;netns =3D c-&=
gt;options.netns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_r=
eset(openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_re=
set(&amp;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+net_ctx_free(openvpn_net_ctx_t *ctx)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    gc_free(&amp;ctx-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+netns_switch(const =
char *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char net_path[PATH_MAX=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int orig_fd, =
netns_fd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Save current netns des=
criptor */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig_=
fd =3D open(NETNS_ORIG_DIR, O_RDONLY | O_CLOEXEC);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (orig_fd &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_WARN, &quot;%s: Cannot open original net=
work namespace\n&quot;, __func__);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(net_pa=
th, sizeof(net_path), &quot;%s/%s&quot;, NETNS_RUN_DIR, name);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    netns_fd =3D open(net_path, =
O_RDONLY | O_CLOEXEC);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (netns_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN, &quot;%s: Cannot open network namespace \&quot;%s\&quot;\n&qu=
ot;, __func__, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        close(orig_fd);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (setns(netns_fd, CLON=
E_NEWNET) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WA=
RN, &quot;%s: setting the network namespace \&quot;%s\&quot; failed\n&quot;=
, __func__, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       close(netns_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        close(orig_fd);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    close(netns_fd);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return orig_fd;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
etns_restore(int orig_fd)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (orig=
_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (setns(orig_fd, CLONE=
_NEWNET) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N, &quot;%s: Cannot restore original network namespace\n&quot;, __func__);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(orig_f=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -=
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    close(orig_fd);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* defined (TARGET_LINUX) &amp;&amp; defined (ENABLE_SITNL) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</s=
pan><br><span>  * Open RTNL socket</span><br><span>  */</span><br><span>@@ =
-454,6 +568,90 @@</span><br><span>     return ret;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Netlink callback to =
extract the interface index from a RTM_NEWLINK message.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * This function is used as a Netlink response handler. =
It inspects incoming</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Netlink messages and, when a RTM_NEWLINK message is received, copies th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * contained `stru=
ct ifinfomsg` into the caller-provided result structure.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param n    Netlink message header received from the=
 kernel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param a=
rg  Pointer to a `struct sitnl_link_req` used to store the result.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return 0 to stop Netlink message processi=
ng once the interface is found,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *         1 to continue processing other messages.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+sitnl_link_get_ifindex(struct nlmsghdr *n, void *arg)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct sitnl_link_req *res =3D arg;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifinfomsg=
 *ifi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (n-&gt;nlmsg_type !=3D RT=
M_NEWLINK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ifi =3D NLMSG_DATA(n);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    res-&gt;i =3D *ifi;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retrieve the interf=
ace index of a network device in a specific network namespace.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Sends an RTM_GETLINK Netlink request targeting=
 the given network namespace ID</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * and interface name, and extracts the resulting interface ind=
ex from the kernel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* response.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * On failure, this funct=
ion returns 0, matching the behavior of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * `if_nametoindex()`.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param ifname   Name of the network interface.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param netnsid  Target network names=
pace ID.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Interface index o=
n success, or 0 on error.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ifindex_in_netn=
s(const char *ifname, int netnsid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct sitnl_link_req req;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct sitnl_link_req res;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int ret =3D -1, ifindex =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(res);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nl=
msg_len =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    req.n.nlmsg_type =3D RTM_GETLINK;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_flags =3D NLM_F_REQU=
EST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;req.n, size=
of(req), IFLA_TARGET_NETNSID, &amp;netnsid, 4);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;req.n, sizeof(req), IFLA=
_IFNAME, ifname, strlen(ifname) + 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret =3D sitnl_send(&amp;req.n, 0, 0, sitnl_link_get_ifindex, &amp;res);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =
=3D res.i.ifi_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ifindex;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_if_=
nametoindex(const char *ifname, int netnsid)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (netnsid &lt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return if_nametoindex(ifname);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return get_if=
index_in_netns(ifname, netnsid);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> typedef struct</span><br><span> {</span><br><span>     size_t =
addr_size;</span><br><span>@@ -624,6 +822,53 @@</span><br><span>     return=
 ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+net_iface_move_netns(const char *iface, const char *netns)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct sitnl_link_req req =3D {};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1, ifindex;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char net_path[PA=
TH_MAX];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(iface);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(netns);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    snprintf(net_path, sizeof(net_path), &quot;%s/%=
s&quot;, NETNS_RUN_DIR, netns);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifi=
ndex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_ERR, &quot;%s: if_nametoindex(%s) failed&quot;, __func__,=
 iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        got=
o err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int netns_fd =3D open(net_path, O_RDONLY);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;%s:=
 open(%s) failed: %s&quot;, __func__, netns, strerror(errno));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_type =3D RTM_SETLI=
NK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_=
flags =3D NLM_F_REQUEST | NLM_F_ACK;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  req.i.ifi_family =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    req.i.ifi_index =3D ifindex;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SITNL_ADDATTR(&amp;req.n, sizeof(req), IFLA_NET_NS_FD, &amp;net=
ns_fd, sizeof(netns_fd));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROU=
TE, &quot;%s: move %s to netns %s&quot;, __func__, iface, netns);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (netns_fd &gt;=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        close(netns_fd);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /* used by iproute2 implementation too */</span><br><span> int</spa=
n><br><span> net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *=
dst, in_addr_t *best_gw,</span><br><span>@@ -661,17 +906,23 @@</span><br><s=
pan> net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)</span=
><br><span> {</span><br><span>     struct sitnl_link_req req;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int ifindex, orig =3D -1, ret =3D =
-1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span> </span><br><span>   =
  CLEAR(req);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (netns)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 orig =3D netns_switch(netns);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     if (!iface)</span><br><span>     {</span><br><span>     =
    msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func__);</span><br=
><span>         return -EINVAL;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_namet=
oindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
findex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(netns)=
);</span><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span>=
<br><span>         msg(M_WARN, &quot;%s: rtnl: cannot get ifindex for %s: %=
s&quot;, __func__, iface, strerror(errno));</span><br><span>@@ -696,18 +947=
,35 @@</span><br><span> </span><br><span>     msg(M_INFO, &quot;%s: set %s =
%s&quot;, __func__, iface, up ? &quot;up&quot; : &quot;down&quot;);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (orig &gt;=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        netns_restore(orig);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span> net_ifa=
ce_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</span><=
br><span> {</span><br><span>     struct sitnl_link_req req;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D -1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex, orig =3D -1=
, ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span> </span><br=
><span>     CLEAR(req);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (netns)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        orig =3D netns_switch(netns);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_si=
tnl(netns));</span><br><span>     if (ifindex =3D=3D 0)</span><br><span>   =
  {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot g=
et ifindex for %s&quot;, __func__, iface);</span><br><span>@@ -726,6 +994,1=
1 @@</span><br><span>     msg(M_INFO, &quot;%s: mtu %u for %s&quot;, __func=
__, mtu, iface);</span><br><span> </span><br><span>     ret =3D sitnl_send(=
&amp;req.n, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
orig &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        netns_rest=
ore(orig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span> err:</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span>@@ -734,11 +1007,18 @@</span><br><span> net_addr_ll_set(openvpn=
_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)</span><br=
><span> {</span><br><span>     struct sitnl_link_req req;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D -1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex, orig =3D -1, =
ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span> </span><br><=
span>     CLEAR(req);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (netns)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        orig =3D netns_switch(netns);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =
=3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(netns));</spa=
n><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><sp=
an>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s=
&quot;, __func__, iface);</span><br><span>@@ -757,20 +1037,32 @@</span><br>=
<span>     msg(M_INFO, &quot;%s: lladdr &quot; MAC_FMT &quot; for %s&quot;,=
 __func__, MAC_PRINT_ARG(addr), iface);</span><br><span> </span><br><span> =
    ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (orig &gt;=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        netns_restore(orig);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span> err:</span><br><span>     return ret;<=
/span><br><span> }</span><br><span> </span><br><span> static int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uin=
t16_t flags, int ifindex, sa_family_t af_family,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+sitnl_addr_set(openvpn_net_ctx_t *ctx, uint16_=
t cmd, uint16_t flags, int ifindex, sa_family_t af_family,</span><br><span>=
                const inet_address_t *local, const inet_address_t *remote, =
int prefixlen)</span><br><span> {</span><br><span>     struct sitnl_addr_re=
q req;</span><br><span>     uint32_t size;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ret =3D -EINVAL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int ret =3D -EINVAL, orig =3D -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *netns =3D ctx ?=
 ctx-&gt;netns : NULL;</span><br><span> </span><br><span>     CLEAR(req);</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (netns)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        orig =3D netns=
_switch(netns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     req.n.nlmsg_len=
 =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span>     req.n.nlmsg_type =3D=
 cmd;</span><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST | flags;</sp=
an><br><span>@@ -820,19 +1112,25 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span>         ret=
 =3D 0;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (orig &gt;=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        netns_restore(orig);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span> err:</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span> static int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_ptp_add(sa_family_t af_fa=
mily, const char *iface, const inet_address_t *local,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_ptp_add(openvpn_net_ctx_t *ctx=
, sa_family_t af_family, const char *iface, const inet_address_t *local,</s=
pan><br><span>                    const inet_address_t *remote)</span><br><=
span> {</span><br><span>     int ifindex;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const char *netns =3D ctx ? ctx-&gt;netns : NULL;=
</span><br><span> </span><br><span>     switch (af_family)</span><br><span>=
     {</span><br><span>@@ -850,21 +1148,22 @@</span><br><span>         retu=
rn -EINVAL;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D openvpn_=
if_nametoindex(iface, get_or_create_netnsid_sitnl(netns));</span><br><span>=
     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>         =
msg(M_WARN, &quot;%s: cannot get ifindex for %s: %s&quot;, __func__, np(ifa=
ce), strerror(errno));</span><br><span>         return -ENOENT;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE=
, ifindex, af_family, local,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_R=
EPLACE, ifindex, af_family, local,</span><br><span>                        =
   remote, 0);</span><br><span> }</span><br><span> </span><br><span> static=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_ptp_de=
l(sa_family_t af_family, const char *iface, const inet_address_t *local)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_ptp_del(ope=
nvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, const inet_a=
ddress_t *local)</span><br><span> {</span><br><span>     int ifindex;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *netns =3D=
 ctx ? ctx-&gt;netns : NULL;</span><br><span> </span><br><span>     switch =
(af_family)</span><br><span>     {</span><br><span>@@ -882,26 +1181,33 @@</=
span><br><span>         return -EINVAL;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D =
if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitn=
l(netns));</span><br><span>     if (ifindex =3D=3D 0)</span><br><span>     =
{</span><br><span>         msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifind=
ex for %s&quot;, __func__, iface);</span><br><span>         return -ENOENT;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_f=
amily, local, NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, loca=
l, NULL, 0);</span><br><span> }</span><br><span> </span><br><span> static i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(uin=
t16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *=
dst,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set=
(openvpn_net_ctx_t *ctx, uint16_t cmd, uint16_t flags, int ifindex, sa_fami=
ly_t af_family, const void *dst,</span><br><span>                 int prefi=
xlen, const void *gw, enum rt_class_t table, int metric,</span><br><span>  =
               enum rt_scope_t scope, unsigned char protocol, unsigned char=
 type)</span><br><span> {</span><br><span>     struct sitnl_route_req req;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -1, si=
ze;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D =
-1, size, orig =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span> <=
/span><br><span>     CLEAR(req);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (netns)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        orig =3D netns_switch(netns);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     switch (af_family)</span><br><span>     {</span><br><spa=
n>         case AF_INET:</span><br><span>@@ -959,14 +1265,20 @@</span><br><=
span>     }</span><br><span> </span><br><span>     ret =3D sitnl_send(&amp;=
req.n, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (orig =
&gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        netns_restore(o=
rig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> err:</span><br><span>     return ret;</span><br><span> }</span><br=
><span> </span><br><span> static int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-sitnl_addr_add(sa_family_t af_family, const char *iface, con=
st inet_address_t *addr, int prefixlen)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+sitnl_addr_add(openvpn_net_ctx_t *ctx, sa_family_t af_f=
amily, const char *iface, const inet_address_t *addr, int prefixlen)</span>=
<br><span> {</span><br><span>     int ifindex;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *netns =3D ctx ? ctx-&gt;netns : =
NULL;</span><br><span> </span><br><span>     switch (af_family)</span><br><=
span>     {</span><br><span>@@ -984,20 +1296,21 @@</span><br><span>        =
 return -EINVAL;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D open=
vpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(netns));</span><br><s=
pan>     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>     =
    msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, =
__func__, iface);</span><br><span>         return -ENOENT;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifi=
ndex, af_family, addr, NULL,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_R=
EPLACE, ifindex, af_family, addr, NULL,</span><br><span>                   =
        prefixlen);</span><br><span> }</span><br><span> </span><br><span> s=
tatic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_d=
el(sa_family_t af_family, const char *iface, inet_address_t *addr, int pref=
ixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_de=
l(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, inet_ad=
dress_t *addr, int prefixlen)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *netns =3D ctx ? ctx-&gt;netns =
: NULL;</span><br><span>     int ifindex;</span><br><span> </span><br><span=
>     switch (af_family)</span><br><span>@@ -1016,14 +1329,14 @@</span><br>=
<span>         return -EINVAL;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nameto=
index(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
index =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(netns))=
;</span><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><=
br><span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex =
for %s&quot;, __func__, iface);</span><br><span>         return -ENOENT;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_fami=
ly, addr, NULL, prefixlen);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, =
addr, NULL, prefixlen);</span><br><span> }</span><br><span> </span><br><spa=
n> int</span><br><span>@@ -1042,7 +1355,7 @@</span><br><span>     msg(M_INF=
O, &quot;%s: %s/%d dev %s&quot;, __func__, inet_ntop(AF_INET, &amp;addr_v4.=
ipv4, buf, sizeof(buf)),</span><br><span>         prefixlen, iface);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 sitnl_addr_add(AF_INET, iface, &amp;addr_v4, prefixlen);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_add(ctx, AF_INE=
T, iface, &amp;addr_v4, prefixlen);</span><br><span> }</span><br><span> </s=
pan><br><span> int</span><br><span>@@ -1062,7 +1375,7 @@</span><br><span>  =
   msg(M_INFO, &quot;%s: %s/%d dev %s&quot;, __func__, inet_ntop(AF_INET6, =
&amp;addr_v6.ipv6, buf, sizeof(buf)),</span><br><span>         prefixlen, i=
face);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return sitnl_addr_add(AF_INET6, iface, &amp;addr_v6, prefixlen);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_a=
dd(ctx, AF_INET6, iface, &amp;addr_v6, prefixlen);</span><br><span> }</span=
><br><span> </span><br><span> int</span><br><span>@@ -1081,7 +1394,7 @@</sp=
an><br><span>     msg(M_INFO, &quot;%s: %s dev %s&quot;, __func__, inet_nto=
p(AF_INET, &amp;addr_v4.ipv4, buf, sizeof(buf)),</span><br><span>         i=
face);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return sitnl_addr_del(AF_INET, iface, &amp;addr_v4, prefixlen);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_de=
l(ctx, AF_INET, iface, &amp;addr_v4, prefixlen);</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span>@@ -1101,7 +1414,7 @@</span=
><br><span>     msg(M_INFO, &quot;%s: %s/%d dev %s&quot;, __func__, inet_nt=
op(AF_INET6, &amp;addr_v6.ipv6, buf, sizeof(buf)),</span><br><span>        =
 prefixlen, iface);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return sitnl_addr_del(AF_INET6, iface, &amp;addr_v6, pr=
efixlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 sitnl_addr_del(ctx, AF_INET6, iface, &amp;addr_v6, prefixlen);</span><br><=
span> }</span><br><span> </span><br><span> int</span><br><span>@@ -1129,7 +=
1442,7 @@</span><br><span>         inet_ntop(AF_INET, &amp;local_v4.ipv4, b=
uf1, sizeof(buf1)),</span><br><span>         inet_ntop(AF_INET, &amp;remote=
_v4.ipv4, buf2, sizeof(buf2)), iface);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_ptp_add(AF_INET, i=
face, &amp;local_v4, &amp;remote_v4);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return sitnl_addr_ptp_add(ctx, AF_INET, iface, &amp;l=
ocal_v4, &amp;remote_v4);</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span>@@ -1150,19 +1463,20 @@</span><br><span>     msg(M=
_INFO, &quot;%s: %s dev %s&quot;, __func__, inet_ntop(AF_INET, &amp;local_v=
4.ipv4, buf, sizeof(buf)),</span><br><span>         iface);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_ad=
dr_ptp_del(AF_INET, iface, &amp;local_v4);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return sitnl_addr_ptp_del(ctx, AF_INET, iface, &=
amp;local_v4);</span><br><span> }</span><br><span> </span><br><span> static=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_add(c=
onst char *iface, sa_family_t af_family, const void *dst, int prefixlen,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_add(openvp=
n_net_ctx_t *ctx, const char *iface, sa_family_t af_family, const void *dst=
, int prefixlen,</span><br><span>                 const void *gw, uint32_t =
table, int metric)</span><br><span> {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *netns =3D ctx ? ctx-&gt;netns : NULL;</sp=
an><br><span>     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;</span><br><s=
pan>     int ifindex =3D 0;</span><br><span> </span><br><span>     if (ifac=
e)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        ifindex =3D if_nametoindex(iface);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ifindex =3D openvpn_if_nametoindex(iface=
, get_or_create_netnsid_sitnl(netns));</span><br><span>         if (ifindex=
 =3D=3D 0)</span><br><span>         {</span><br><span>             msg(M_WA=
RN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__,=
 iface);</span><br><span>@@ -1180,7 +1494,7 @@</span><br><span>         sco=
pe =3D RT_SCOPE_LINK;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_NEW=
ROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(ctx, RT=
M_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span><br=
><span>                            table, metric, scope, RTPROT_BOOT, RTN_U=
NICAST);</span><br><span> }</span><br><span> </span><br><span>@@ -1209,7 +1=
523,7 @@</span><br><span>         inet_ntop(AF_INET, &amp;dst_be, dst_str, =
sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &a=
mp;gw_be, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_=
route_add(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_ad=
d(ctx, iface, AF_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</span><b=
r><span> }</span><br><span> </span><br><span> int</span><br><span>@@ -1235,=
18 +1549,19 @@</span><br><span>         inet_ntop(AF_INET6, &amp;dst_v6.ipv=
6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop=
(AF_INET6, &amp;gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metr=
ic);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return sitnl_route_add(iface, AF_INET6, dst, prefixlen, gw, table, met=
ric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sit=
nl_route_add(ctx, iface, AF_INET6, dst, prefixlen, gw, table, metric);</spa=
n><br><span> }</span><br><span> </span><br><span> static int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_del(const char *iface, s=
a_family_t af_family, inet_address_t *dst, int prefixlen,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(openvpn_net_ctx_t *ct=
x, const char *iface, sa_family_t af_family, inet_address_t *dst, int prefi=
xlen,</span><br><span>                 inet_address_t *gw, uint32_t table, =
int metric)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br>=
<span>     int ifindex =3D 0;</span><br><span> </span><br><span>     if (if=
ace)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ifindex =3D if_nametoindex(iface);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ifindex =3D openvpn_if_nametoindex(ifa=
ce, get_or_create_netnsid_sitnl(netns));</span><br><span>         if (ifind=
ex =3D=3D 0)</span><br><span>         {</span><br><span>             msg(M_=
WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func_=
_, iface);</span><br><span>@@ -1259,7 +1574,7 @@</span><br><span>         t=
able =3D RT_TABLE_MAIN;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_D=
ELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(c=
tx, RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,=
</span><br><span>                            RT_SCOPE_NOWHERE, 0, 0);</span=
><br><span> }</span><br><span> </span><br><span>@@ -1286,7 +1601,7 @@</span=
><br><span>         inet_ntop(AF_INET, &amp;dst_v4.ipv4, dst_str, sizeof(ds=
t_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_v4.=
ipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_rout=
e_del(iface, AF_INET, &amp;dst_v4, prefixlen, &amp;gw_v4, table, metric);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_rout=
e_del(ctx, iface, AF_INET, &amp;dst_v4, prefixlen, &amp;gw_v4, table, metri=
c);</span><br><span> }</span><br><span> </span><br><span> int</span><br><sp=
an>@@ -1312,7 +1627,7 @@</span><br><span>         inet_ntop(AF_INET6, &amp;=
dst_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>        =
 inet_ntop(AF_INET6, &amp;gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), t=
able, metric);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return sitnl_route_del(iface, AF_INET6, &amp;dst_v6, prefixl=
en, &amp;gw_v6, table, metric);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return sitnl_route_del(ctx, iface, AF_INET6, &amp;dst_v6, p=
refixlen, &amp;gw_v6, table, metric);</span><br><span> }</span><br><span> <=
/span><br><span> </span><br><span>@@ -1320,10 +1635,16 @@</span><br><span> =
net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, =
void *arg)</span><br><span> {</span><br><span>     struct sitnl_link_req re=
q =3D {};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D -1, orig =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *netns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span> </s=
pan><br><span>     ASSERT(iface);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (netns)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        orig =3D netns_switch(netns);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     req.n.nlmsg_len =3D NLMSG_LENGTH(=
sizeof(req.i));</span><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST | =
NLM_F_CREATE | NLM_F_EXCL;</span><br><span>     req.n.nlmsg_type =3D RTM_NE=
WLINK;</span><br><span>@@ -1348,6 +1669,11 @@</span><br><span>     msg(D_RO=
UTE, &quot;%s: add %s type %s&quot;, __func__, iface, type);</span><br><spa=
n> </span><br><span>     ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (orig &gt;=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        netns_restore(orig);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> err:</span><br><s=
pan>     return ret;</span><br><span> }</span><br><span>@@ -1424,17 +1750,1=
89 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Netlink callback to extract and st=
ore a network namespace ID (NSID).</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 This function processes Netlink responses to RTM_GETNSID requests.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * If a NETNSA_NSID attribu=
te is present, its value is copied into the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * caller-provided storage.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * If a Netlink error message is received, the contained e=
rror code is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * retu=
rned directly.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n    Netlink=
 message header received from the kernel.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param arg  Pointer to an integer where the NSID w=
ill be stored.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 on succes=
s, a negative error code on failure.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_ns=
id_save(struct nlmsghdr *n, void *arg)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int *nsid =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct rtgenmsg *g =3D NLMSG_DATA(n);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct rtattr *tb[NETNSA_MAX + 1];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int ret;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (n-&gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct nlmsgerr *err =3D NLMSG_DATA(n=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return er=
r-&gt;error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_parse_rtattr(tb, NETNS=
A_MAX, SITNL_NETNS_RTA(g), NLMSG_PAYLOAD(n, sizeof(*g)));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb[NETNSA_NSID])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    memcpy(nsid, RTA_DATA(tb[NETNSA_NSID]), sizeof(*nsid));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retrie=
ve the network namespace ID (NSID) associated with a namespace name.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This function opens the network namesp=
ace identified by the given path</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * and sends an RTM_GETNSID Netlink request to retrieve its as=
signed NSID.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param name  Name of =
the network namespace.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return The=
 network namespace ID on success, or a negative value on failure.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+netns_id_from_name_sitnl(const char *name)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct sitnl_nsid_req req;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int ret =3D -1, netnsid =3D -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int netns_fd =3D open(name, O_RDONLY);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.=
nlmsg_len =3D NLMSG_LENGTH(sizeof(req.g));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    req.n.nlmsg_type =3D RTM_GETNSID;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_flags =3D NLM_F_RE=
QUEST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.g.rtg=
en_family =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDA=
TTR(&amp;req.n, sizeof(req), NETNSA_FD, &amp;netns_fd, 4);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0, sitnl_nsid_sav=
e, &amp;netnsid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ne=
tns_fd &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(ne=
tns_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return netnsid;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Assign a network na=
mespace ID (NSID) to a namespace.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
This function sends an RTM_NEWNSID Netlink request to associate a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * NSID with the network name=
space identified by the given path.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param name  Name of the network namespace.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return 0 on success, or a negative error code on failure.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+set_netns_id_from_name_sitnl(const char *name)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct sitnl_nsid_req req;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int ret =3D -1, netnsid =3D -1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int netns_fd =3D open(name, O_RDONLY);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.g));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_type =3D RTM_NEWNSID;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_flags =
=3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   req.g.rtgen_family =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  SITNL_ADDATTR(&amp;req.n, sizeof(req), NETNSA_FD, &amp;netns_fd, 4);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;r=
eq.n, sizeof(req), NETNSA_NSID, &amp;netnsid, 4);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &gt;=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        close(netns_fd);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+get_or_create_netnsid_sitnl(const char *name)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char net_path[PATH_MAX];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int netnsid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    snprintf(net_path, sizeof(net_path),=
 &quot;%s/%s&quot;, NETNS_RUN_DIR, name);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* First get */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    netnsid =3D netns_id_from_name_sitnl(net_path);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &gt;=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return netnsid;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* No netnsid yet? Try to assign one */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    netnsid =3D set_netn=
s_id_from_name_sitnl(net_path);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (netnsid &lt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Second get */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 netnsid =3D netns_id_from_name_sitnl(net_path);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (netnsid &gt;=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return netnsid;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> int</span><br><span> net_iface_type(openvpn_net_ctx_t *ctx,=
 const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><span> {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *netns =3D=
 ctx ? ctx-&gt;netns : NULL;</span><br><span>     struct sitnl_link_req req=
 =3D {};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifind=
ex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int ifindex =3D openvpn_if_nametoindex(iface, get_or_create_n=
etnsid_sitnl(netns));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int orig =3D -1;</span><br><span> </span><br><span>     if (!ifindex)=
</span><br><span>     {</span><br><span>         return -errno;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (netns)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
rig =3D netns_switch(netns);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</span><br=
><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req.n=
.nlmsg_type =3D RTM_GETLINK;</span><br><span>@@ -1453,20 +1951,32 @@</span>=
<br><span> </span><br><span>     msg(D_ROUTE, &quot;%s: type of %s: %s&quot=
;, __func__, iface, type);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (orig &gt;=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        netns_restore(orig);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     return 0;</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span> net_iface_del(openvpn_net_ctx_t *=
ctx, const char *iface)</span><br><span> {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int ret =3D -1, orig =3D -1;</span><br><span>   =
  struct sitnl_link_req req =3D {};</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int ifindex =3D if_nametoindex(iface);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *netns =3D ctx ? ctx-&g=
t;netns : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int ifindex =3D openvpn_if_nametoindex(iface, get_or_create_netnsid_sitnl(n=
etns));</span><br><span> </span><br><span>     if (!ifindex)</span><br><spa=
n>     {</span><br><span>         return -errno;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (netns)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        orig =3D netns_s=
witch(netns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span>     req=
.n.nlmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req.n.nlmsg_type =3D=
 RTM_DELLINK;</span><br><span>@@ -1476,7 +1986,20 @@</span><br><span> </spa=
n><br><span>     msg(D_ROUTE, &quot;%s: delete %s&quot;, __func__, iface);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0, NULL,=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (orig &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        netns_r=
estore(orig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><span> </=
span><br><span> #endif /* !ENABLE_SITNL */</span><br><span>diff --git a/src=
/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h</span><br><spa=
n>index 481cc36..731a0e4 100644</span><br><span>--- a/src/openvpn/networkin=
g_sitnl.h</span><br><span>+++ b/src/openvpn/networking_sitnl.h</span><br><s=
pan>@@ -21,7 +21,111 @@</span><br><span> #ifndef NETWORKING_SITNL_H_</span>=
<br><span> #define NETWORKING_SITNL_H_</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;env_set.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef c=
har openvpn_net_iface_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-typedef void *openvpn_net_ctx_t;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+str=
uct openvpn_net_ctx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ne=
tns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+typedef struct openvpn_net_ctx openvpn_net_ctx_=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @brief Switch the current thread to the specified=
 network namespace.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function =
changes the calling thread&#39;s network namespace to the one</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * identified by @p name. The cur=
rent (original) network namespace file</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * descriptor is saved and returned, so it can later be =
restored using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ne=
tns_restore().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The switch is perfo=
rmed using setns(2). This approach is required because</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * the netlink library does not support =
performing operations in an arbitrary</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * target network namespace, except for interface creatio=
n and deletion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
herefore, in order to execute generic netlink operations inside a</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * specific network namespace=
, the thread must temporarily enter</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * that namespace via setns().</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param name  Name of the target network namespace (as found un=
der</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *              =
NETNS_RUN_DIR, e.g. /var/run/netns/&lt;name&gt;).</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return On success, returns a file descriptor referring to =
the original</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
    network namespace. This descriptor must be passed to</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *         netns_restore() to switch b=
ack.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return -1 o=
n failure (an error is logged and no namespace switch is kept).</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @note The returned file descriptor must be cl=
osed by calling</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
     netns_restore(). Failing to do so may leak file descriptors.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int netns_switch(const char *name);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @brief Restore the previously saved network namespace.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This function restores the network nam=
espace saved by netns_switch()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * using the file descriptor returned by that function.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * The restoration is performed using setns(2=
), switching the calling</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * thread back to its original network namespace.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param orig_fd  File descriptor of the original networ=
k namespace,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
            as returned by netns_switch().</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @return 0 on success.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return -1 on failure (an error is logged and the file descri=
ptor</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         is c=
losed).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @note This function closes=
 @p orig_fd in all cases.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *       After calling this function, @p orig_fd must not be reused.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int netns_restore(int orig_fd);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Resolve a network interface name to its interface inde=
x.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * If a valid network namespace ID=
 is provided, the lookup is performed inside</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * that network namespace using Netlink. Otherwise=
, this function falls back</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * to the standard `if_nametoindex()` call in the current namespace.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param ifname   Name of the netwo=
rk interface.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram netnsid  Network namespace ID, or a negative value to use the current</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 na=
mespace.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Interface index o=
n success, or 0 on error.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int openvp=
n_if_nametoindex(const char *ifname, int netnsid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * M=
ove a network interface to a different network namespace.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * This function moves the specified network interface=
 from the current</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 network namespace into the target network namespace identified by name.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The operation is pe=
rformed via a RTM_SETLINK Netlink request using the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * IFLA_NET_NS_FD attribute.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * The target network namespace is expected to ex=
ist under NETNS_RUN_DIR</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * (/var/run/netns).</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param if=
ace  Name of the network interface to move.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param netns  Name of the target network namespa=
ce.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 on success, or a neg=
ative error code on failure.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int net=
_iface_move_netns(const char *iface, const char *netns);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Retrieve or create a network namespace ID (NSID) for a given namespace=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * This function first attempts to =
retrieve the NSID associated with the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * specified network namespace. If no NSID is currently a=
ssigned, it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reque=
sts the kernel to create one and then retries the lookup.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param name  Name of the network namespace.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return The network namespace ID on succe=
ss, or -1 on failure.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int get_or_cre=
ate_netnsid_sitnl(const char *name);</span><br><span> </span><br><span> #en=
dif /* NETWORKING_SITNL_H_ */</span><br><span>diff --git a/src/openvpn/opti=
ons.c b/src/openvpn/options.c</span><br><span>index 2bca647..7b7681a 100644=
</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/open=
vpn/options.c</span><br><span>@@ -6473,6 +6473,16 @@</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;m=
tu_test =3D true;</span><br><span>     }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;netns&quot;) &amp=
;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(M_WARN, &quot;NOTE: --netns is supported only on Linux when SITNL =
is built-in&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIF=
Y_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;netns =3D p[1];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span>     else if (streq(p[0], &quot;nice&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span=
>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/o=
penvpn/options.h b/src/openvpn/options.h</span><br><span>index 16cfdb5..a19=
a84c 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++=
 b/src/openvpn/options.h</span><br><span>@@ -316,6 +316,7 @@</span><br><spa=
n> </span><br><span>     struct dns_options dns_options;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *netn=
s;</span><br><span>     bool remote_random;</span><br><span>     const char=
 *ipchange;</span><br><span>     const char *dev;</span><br><span>diff --gi=
t a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index e38df3e..e3=
c46ea 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/=
src/openvpn/tun.c</span><br><span>@@ -2169,6 +2169,17 @@</span><br><span>  =
       set_nonblock(tt-&gt;fd);</span><br><span>         set_cloexec(tt-&gt=
;fd);</span><br><span>         tt-&gt;actual_name =3D string_alloc(ifr.ifr_=
name, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) =
&amp;&amp; defined(ENABLE_SITNL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (ctx-&gt;netns)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            int ret =3D net_iface_move_netns(ifr.ifr_name, ctx-&g=
t;netns);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(M_WARN | M_ERRNO, &quot;Note: Cannot move dev %s to network nam=
espace %s&quot;, ifr.ifr_name, ctx-&gt;netns);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* if defined (TARGET_LINUX) &amp;&amp; defined(ENABLE_SI=
TNL) */</span><br><span>     }</span><br><span>     return;</span><br><span=
> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">change 1521</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1521?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--JfLe9Voq0W4=--

