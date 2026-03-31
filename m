From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 10:29:23 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ccf951ecb91a11dfe38c0cbc340f18ccebc9f332-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Nlqvh6rq1U4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Nlqvh6rq1U4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail

to look at the new patch set (#10).


Change subject: Add support for user defined network namespace
......................................................................

Add support for user defined network namespace

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
---
M doc/man-sections/vpn-network-options.rst
M src/openvpn/dco.c
M src/openvpn/networking.h
M src/openvpn/networking_sitnl.c
M src/openvpn/networking_sitnl.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/tun.c
8 files changed, 610 insertions(+), 82 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/1521/10

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 33ebedb..181c990 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -304,6 +304,12 @@
   Specify the link layer address, more commonly known as the MAC address.
   Only applied to TAP devices.

+--netns name
+  Specify the network namespace in which the tunnel interface will be crea=
ted.
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
+        msg(msglevel, "Note: --netns not supported by DCO, disabling data =
channel offload.");
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
         _nest->rta_len =3D (unsigned short)((void *)sitnl_nlmsg_tail(_msg)=
 - (void *)_nest); \
     }

+#define SITNL_NETNS_RTA(r) \
+    ((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct rtgenmsg)=
)))
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
+    ctx->netns =3D NULL;
+
+    if (c && c->options.netns)
+    {
+        snprintf(path, sizeof(path), "%s/%s", NETNS_RUN_DIR, c->options.ne=
tns);
+
+        if (stat(path, &st) !=3D 0)
+        {
+            msg(M_ERR, "%s: Network namespace %s does not exist", __func__=
, path);
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
+netns_switch(openvpn_net_ctx_t *ctx)
+{
+    char net_path[PATH_MAX];
+    int orig_fd =3D -1, netns_fd;
+    const char *netns =3D ctx ? ctx->netns : NULL;
+
+    if (!netns)
+    {
+        return -1;
+    }
+
+    /* Save current netns descriptor */
+    orig_fd =3D open(NETNS_ORIG_DIR, O_RDONLY | O_CLOEXEC);
+    if (orig_fd < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Cannot open original network namespace"=
, __func__);
+        return -1;
+    }
+
+    snprintf(net_path, sizeof(net_path), "%s/%s", NETNS_RUN_DIR, netns);
+    netns_fd =3D open(net_path, O_RDONLY | O_CLOEXEC);
+    if (netns_fd < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: Cannot open network namespace \"%s\"", =
__func__, netns);
+        close(orig_fd);
+        return -1;
+    }
+
+    if (setns(netns_fd, CLONE_NEWNET) < 0)
+    {
+        msg(M_WARN | M_ERRNO, "%s: setting the network namespace \"%s\" fa=
iled", __func__, netns);
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
+        msg(M_WARN | M_ERRNO, "%s: Cannot restore original network namespa=
ce", __func__);
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
+    {
+        return 1;
+    }
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
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_TARGET_NETNSID, &netnsid, size=
of(int));
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_IFNAME, ifname, strlen(ifname)=
 + 1);
+
+    ret =3D sitnl_send(&req.n, 0, 0, sitnl_link_get_ifindex, &res);
+
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    ifindex =3D res.i.ifi_index;
+
+err:
+    return ifindex;
+}
+
+static int
+sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *r=
ta, size_t len,
+                         unsigned short flags)
+{
+    unsigned short type;
+
+    memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
+
+    while (RTA_OK(rta, len))
+    {
+        type =3D rta->rta_type & ~flags;
+
+        if ((type <=3D max) && (!tb[type]))
+        {
+            tb[type] =3D rta;
+        }
+
+        rta =3D RTA_NEXT(rta, len);
+    }
+
+    if (len)
+    {
+        msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=3D%u)", __func__,=
 len, rta->rta_len);
+    }
+
+    return 0;
+}
+
+static int
+sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, si=
ze_t len)
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
+    int netnsid =3D -1;
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
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_FD, &netns_fd, sizeof(int));
+
+    sitnl_send(&req.n, 0, 0, sitnl_nsid_save, &netnsid);
+
+err:
+    if (netns_fd >=3D 0)
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
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_FD, &netns_fd, sizeof(int));
+    SITNL_ADDATTR(&req.n, sizeof(req), NETNSA_NSID, &netnsid, sizeof(int));
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
+    {
+        return netnsid;
+    }
+
+    /* No netnsid yet? Try to assign one */
+    netnsid =3D set_netns_id_from_name_sitnl(net_path);
+    if (netnsid < 0)
+    {
+        return -1;
+    }
+
+    /* Second get */
+    netnsid =3D netns_id_from_name_sitnl(net_path);
+    if (netnsid >=3D 0)
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
+    const char *netns =3D ctx ? ctx->netns : NULL;
+    int netnsid =3D get_or_create_netnsid_sitnl(netns);
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
+    int ifindex, orig =3D -1;

     CLEAR(req);

@@ -671,13 +1073,15 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
-        msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, i=
face, strerror(errno));
+        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fun=
c__, iface);
         return -ENOENT;
     }

+    orig =3D netns_switch(ctx);
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
     req.n.nlmsg_type =3D RTM_NEWLINK;
@@ -696,24 +1100,30 @@

     msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");

-    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+    int ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
+    netns_restore(orig);
+
+    return ret;
 }

 int
 net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ifindex, orig =3D -1, ret =3D -1;

     CLEAR(req);

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fun=
c__, iface);
         return -1;
     }

+    orig =3D netns_switch(ctx);
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
     req.n.nlmsg_type =3D RTM_NEWLINK;
@@ -726,7 +1136,9 @@
     msg(M_INFO, "%s: mtu %u for %s", __func__, mtu, iface);

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
     return ret;
 }

@@ -734,17 +1146,19 @@
 net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, =
uint8_t *addr)
 {
     struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ifindex, orig =3D -1, ret =3D -1;

     CLEAR(req);

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fun=
c__, iface);
         return -1;
     }

+    orig =3D netns_switch(ctx);
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
     req.n.nlmsg_type =3D RTM_NEWLINK;
@@ -757,17 +1171,19 @@
     msg(M_INFO, "%s: lladdr " MAC_FMT " for %s", __func__, MAC_PRINT_ARG(a=
ddr), iface);

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
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

     CLEAR(req);

@@ -819,17 +1235,22 @@
         SITNL_ADDATTR(&req.n, sizeof(req), IFA_BROADCAST, &broadcast, size=
);
     }

+    orig =3D netns_switch(ctx);
+
     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
     if (ret =3D=3D -EEXIST)
     {
         ret =3D 0;
     }
+
 err:
+    netns_restore(orig);
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
@@ -850,19 +1271,19 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
     if (ifindex =3D=3D 0)
     {
-        msg(M_WARN, "%s: cannot get ifindex for %s: %s", __func__, np(ifac=
e), strerror(errno));
+        msg(M_WARN | M_ERRNO, "%s: cannot get ifindex for %s", __func__, n=
p(iface));
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

@@ -882,23 +1303,23 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
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

     CLEAR(req);

@@ -957,14 +1378,17 @@
     {
         SITNL_ADDATTR(&req.n, sizeof(req), RTA_PRIORITY, &metric, 4);
     }
+    orig =3D netns_switch(ctx);

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
+    netns_restore(orig);
     return ret;
 }

 static int
-sitnl_addr_add(sa_family_t af_family, const char *iface, const inet_addres=
s_t *addr, int prefixlen)
+sitnl_addr_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *=
iface, const inet_address_t *addr, int prefixlen)
 {
     int ifindex;

@@ -984,19 +1408,19 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
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
=20
 static int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *a=
ddr, int prefixlen)
+sitnl_addr_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *=
iface, inet_address_t *addr, int prefixlen)
 {
     int ifindex;

@@ -1016,14 +1440,14 @@
         return -EINVAL;
     }

-    ifindex =3D if_nametoindex(iface);
+    ifindex =3D openvpn_if_nametoindex(iface, ctx);
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
@@ -1042,7 +1466,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET, &addr_v4.=
ipv4, buf, sizeof(buf)),
         prefixlen, iface);

-    return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }

 int
@@ -1062,7 +1486,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &addr_v6=
.ipv6, buf, sizeof(buf)),
         prefixlen, iface);

-    return sitnl_addr_add(AF_INET6, iface, &addr_v6, prefixlen);
+    return sitnl_addr_add(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }

 int
@@ -1081,7 +1505,7 @@
     msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF_INET, &addr_v4.ipv=
4, buf, sizeof(buf)),
         iface);

-    return sitnl_addr_del(AF_INET, iface, &addr_v4, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET, iface, &addr_v4, prefixlen);
 }

 int
@@ -1101,7 +1525,7 @@
     msg(M_INFO, "%s: %s/%d dev %s", __func__, inet_ntop(AF_INET6, &addr_v6=
.ipv6, buf, sizeof(buf)),
         prefixlen, iface);

-    return sitnl_addr_del(AF_INET6, iface, &addr_v6, prefixlen);
+    return sitnl_addr_del(ctx, AF_INET6, iface, &addr_v6, prefixlen);
 }

 int
@@ -1129,7 +1553,7 @@
         inet_ntop(AF_INET, &local_v4.ipv4, buf1, sizeof(buf1)),
         inet_ntop(AF_INET, &remote_v4.ipv4, buf2, sizeof(buf2)), iface);
=20
-    return sitnl_addr_ptp_add(AF_INET, iface, &local_v4, &remote_v4);
+    return sitnl_addr_ptp_add(ctx, AF_INET, iface, &local_v4, &remote_v4);
 }

 int
@@ -1150,11 +1574,11 @@
     msg(M_INFO, "%s: %s dev %s", __func__, inet_ntop(AF_INET, &local_v4.ip=
v4, buf, sizeof(buf)),
         iface);
=20
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
     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;
@@ -1162,7 +1586,7 @@

     if (iface)
     {
-        ifindex =3D if_nametoindex(iface);
+        ifindex =3D openvpn_if_nametoindex(iface, ctx);
         if (ifindex =3D=3D 0)
         {
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __=
func__, iface);
@@ -1180,7 +1604,7 @@
         scope =3D RT_SCOPE_LINK;
     }

-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_family,=
 dst, prefixlen, gw,
+    return sitnl_route_set(ctx, RTM_NEWROUTE, NLM_F_CREATE, ifindex, af_fa=
mily, dst, prefixlen, gw,
                            table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }

@@ -1209,7 +1633,7 @@
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), tab=
le, metric);

-    return sitnl_route_add(iface, AF_INET, dst_ptr, prefixlen, gw_ptr, tab=
le, metric);
+    return sitnl_route_add(ctx, iface, AF_INET, dst_ptr, prefixlen, gw_ptr=
, table, metric);
 }

 int
@@ -1235,18 +1659,18 @@
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
     int ifindex =3D 0;

     if (iface)
     {
-        ifindex =3D if_nametoindex(iface);
+        ifindex =3D openvpn_if_nametoindex(iface, ctx);
         if (ifindex =3D=3D 0)
         {
             msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s", __=
func__, iface);
@@ -1259,7 +1683,7 @@
         table =3D RT_TABLE_MAIN;
     }

-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, prefi=
xlen, gw, table, metric,
+    return sitnl_route_set(ctx, RTM_DELROUTE, 0, ifindex, af_family, dst, =
prefixlen, gw, table, metric,
                            RT_SCOPE_NOWHERE, 0, 0);
 }

@@ -1286,7 +1710,7 @@
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
@@ -1312,7 +1736,7 @@
         inet_ntop(AF_INET6, &dst_v6.ipv6, dst_str, sizeof(dst_str)), prefi=
xlen,
         inet_ntop(AF_INET6, &gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface=
), table, metric);

-    return sitnl_route_del(iface, AF_INET6, &dst_v6, prefixlen, &gw_v6, ta=
ble, metric);
+    return sitnl_route_del(ctx, iface, AF_INET6, &dst_v6, prefixlen, &gw_v=
6, table, metric);
 }


@@ -1356,44 +1780,11 @@
     msg(D_ROUTE, "%s: add %s type %s", __func__, iface, type);

     ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
+
 err:
     return ret;
 }

-static int
-sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *r=
ta, size_t len,
-                         unsigned short flags)
-{
-    unsigned short type;
-
-    memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
-
-    while (RTA_OK(rta, len))
-    {
-        type =3D rta->rta_type & ~flags;
-
-        if ((type <=3D max) && (!tb[type]))
-        {
-            tb[type] =3D rta;
-        }
-
-        rta =3D RTA_NEXT(rta, len);
-    }
-
-    if (len)
-    {
-        msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=3D%u)", __func__,=
 len, rta->rta_len);
-    }
-
-    return 0;
-}
-
-static int
-sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, si=
ze_t len)
-{
-    return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
-}
-
 #define sitnl_parse_rtattr_nested(tb, max, rta) \
     (sitnl_parse_rtattr_flags(tb, max, RTA_DATA(rta), RTA_PAYLOAD(rta), NL=
A_F_NESTED))

@@ -1436,13 +1827,16 @@
 net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_=
TYPE_LEN_MAX])
 {
     struct sitnl_link_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    int ifindex =3D openvpn_if_nametoindex(iface, ctx);
+    int orig =3D -1;

     if (!ifindex)
     {
         return -errno;
     }

+    orig =3D netns_switch(ctx);
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
     req.n.nlmsg_type =3D RTM_GETLINK;
@@ -1455,26 +1849,32 @@
     int ret =3D sitnl_send(&req.n, 0, 0, sitnl_type_save, type);
     if (ret < 0)
     {
+        netns_restore(orig);
         msg(D_ROUTE, "%s: cannot retrieve iface %s: %s (%d)", __func__, if=
ace, strerror(-ret), ret);
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
+    int ret =3D -1, orig =3D -1;
     struct sitnl_link_req req =3D {};
-    int ifindex =3D if_nametoindex(iface);
+    int ifindex =3D openvpn_if_nametoindex(iface, ctx);

     if (!ifindex)
     {
         return -errno;
     }

+    orig =3D netns_switch(ctx);
+
     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));
     req.n.nlmsg_flags =3D NLM_F_REQUEST;
     req.n.nlmsg_type =3D RTM_DELLINK;
@@ -1484,7 +1884,11 @@

     msg(D_ROUTE, "%s: delete %s", __func__, iface);

-    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+    ret =3D sitnl_send(&req.n, 0, 0, NULL, NULL);
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
+ * If @p ctx is NULL or ctx->netns is NULL, the function fails and returns=
 -1.
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
+ * @param ctx  Pointer to an OpenVPN network context structure containing
+ *             the target network namespace name (ctx->netns). The namespa=
ce
+ *             is expected to exist under NETNS_RUN_DIR (e.g. /run/netns/).
+ *
+ * @return On success, returns a file descriptor referring to the original
+ *         network namespace. This descriptor must be passed to
+ *         netns_restore() to switch back.
+ * @return -1 on failure (an error is logged and no namespace switch is ke=
pt).
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
+ * @note This function always closes @p orig_fd if it is >=3D 0,
+ *       regardless of whether setns() succeeds or fails.
+ *       After calling this function, @p orig_fd must not be reused.
+ */
+void netns_restore(int orig_fd);
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
         options->mtu_test =3D true;
     }
+    else if (streq(p[0], "netns") && p[1] && !p[2])
+    {
+#ifndef ENABLE_SITNL
+        msg(M_WARN, "NOTE: --netns is supported only on Linux when compile=
d with SITNL");
+#endif
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->netns =3D p[1];
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
+        int orig_fd =3D -1;
+        if (ctx->netns)
+        {
+            orig_fd =3D netns_switch(ctx);
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
+        if (orig_fd !=3D -1)
+        {
+            netns_restore(orig_fd);
+        }
+#endif

         /*
          * Process --tun-ipv6

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 10
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Nlqvh6rq1U4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #10</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">View Cha=
nge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Add support for user defined network namespace<br>=
<br>Introduce the --netns option to allow interface creation<br>into a user=
-defined network namespace.<br>This allows the VPN data plane to be isolate=
d from the main<br>OpenVPN process namespace.<br><br>The current netlink li=
brary integration supports interface creation<br>and deletion in a target n=
amespace. However, subsequent configuration<br>operations (e.g. address or =
mtu set) are executed in the caller&#39;s<br>namespace, as they rely on the=
 default netlink socket context.<br>As a result, interface-related configur=
ation performed after creation<br>may be applied in the wrong namespace.<br=
>Introduce helper functions to temporarily switch the process to the<br>req=
uested network namespace using setns(2), execute the required<br>netlink op=
erations, and then restore the original namespace.<br>The namespace switch =
is temporary and scoped to each netlink<br>operation. Once the operation co=
mpletes, the original namespace<br>is restored to preserve the process exec=
ution context.<br><br>Note: This feature is Linux-only and depends on setns=
(2).<br>It is not compatible (yet) with Data Channel Offload (DCO).<br><br>=
Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3<br>Signed-off-by: Gian=
marco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/=
vpn-network-options.rst<br>M src/openvpn/dco.c<br>M src/openvpn/networking.=
h<br>M src/openvpn/networking_sitnl.c<br>M src/openvpn/networking_sitnl.h<b=
r>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/tun.c=
<br>8 files changed, 610 insertions(+), 82 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/152=
1/10</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/ma=
n-sections/vpn-network-options.rst</span><br><span>index 33ebedb..181c990 1=
00644</span><br><span>--- a/doc/man-sections/vpn-network-options.rst</span>=
<br><span>+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@=
 -304,6 +304,12 @@</span><br><span>   Specify the link layer address, more =
commonly known as the MAC address.</span><br><span>   Only applied to TAP d=
evices.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+--netns name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 Specify the network namespace in which the tunnel interface will be create=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The namespace m=
ust already exist.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (Supported on Linu=
x only, on other platforms this is a no-op).</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> --persist-tun</span><br><span>  =
 Don&#39;t close and reopen TUN/TAP device or run up/down scripts across</s=
pan><br><span>   :code:`SIGUSR1` or ``--ping-restart`` restarts.</span><br>=
<span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>in=
dex 26b8645..a61e587 100644</span><br><span>--- a/src/openvpn/dco.c</span><=
br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -388,6 +388,12 @@</span=
><br><span>                 ret);</span><br><span>         }</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;netns)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;Note: --netns=
 not supported by DCO, disabling data channel offload.&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #endif =
/* if defined(_WIN32) */</span><br><span> </span><br><span> #if defined(HAV=
E_LIBCAPNG)</span><br><span>diff --git a/src/openvpn/networking.h b/src/ope=
nvpn/networking.h</span><br><span>index bce0c19..fab6bbf 100644</span><br><=
span>--- a/src/openvpn/networking.h</span><br><span>+++ b/src/openvpn/netwo=
rking.h</span><br><span>@@ -39,10 +39,10 @@</span><br><span> typedef void *=
openvpn_net_iface_t;</span><br><span> #endif /* ifdef ENABLE_SITNL */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Only t=
he iproute2 backend implements these functions,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Only the iproute2 and sitnl backend implemen=
ts these functions,</span><br><span>  * the rest can rely on these stubs</s=
pan><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 !defined(ENABLE_IPROUTE)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if !defined(ENABLE_IPROUTE) &amp;&amp; !defined(ENABLE_SITNL) || def=
ined(TARGET_ANDROID)</span><br><span> static inline int</span><br><span> ne=
t_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)</span><br><span> {</s=
pan><br><span>@@ -63,7 +63,7 @@</span><br><span> {</span><br><span>     (vo=
id)ctx;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif /* !defined(ENABLE_IPROUTE) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif /* !defined(ENABLE_IPROUTE) &amp;&amp; !defin=
ed(ENABLE_SITNL) || defined(TARGET_ANDROID) */</span><br><span> </span><br>=
<span> #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)</span><br><span=
> </span><br><span>diff --git a/src/openvpn/networking_sitnl.c b/src/openvp=
n/networking_sitnl.c</span><br><span>index b88f03c..541c855 100644</span><b=
r><span>--- a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/open=
vpn/networking_sitnl.c</span><br><span>@@ -33,14 +33,17 @@</span><br><span>=
 #include &quot;networking.h&quot;</span><br><span> #include &quot;proto.h&=
quot;</span><br><span> #include &quot;route.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn.h&quot;</span><br>=
<span> </span><br><span> #include &lt;errno.h&gt;</span><br><span> #include=
 &lt;string.h&gt;</span><br><span> #include &lt;unistd.h&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sched.h&gt;</span><br=
><span> #include &lt;sys/types.h&gt;</span><br><span> #include &lt;sys/sock=
et.h&gt;</span><br><span> #include &lt;linux/netlink.h&gt;</span><br><span>=
 #include &lt;linux/rtnetlink.h&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &lt;linux/net_namespace.h&gt;</span><br><span> </s=
pan><br><span> #define SNDBUF_SIZE (1024 * 2)</span><br><span> #define RCVB=
UF_SIZE (1024 * 4)</span><br><span>@@ -65,6 +68,12 @@</span><br><span>     =
    _nest-&gt;rta_len =3D (unsigned short)((void *)sitnl_nlmsg_tail(_msg) -=
 (void *)_nest); \</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define SITNL_NETNS_RTA(r) \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ((struct rtattr *)(((c=
har *)(r)) + NLMSG_ALIGN(sizeof(struct rtgenmsg))))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define NETNS_RUN_DIR  &quot;/run/netns&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define NETNS_ORIG_DIR &quot;/proc=
/self/ns/net&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /* This function was originally implemented as a macro, bu=
t compiling with</span><br><span>  * gcc and -O3 was getting confused about=
 the math and thus raising</span><br><span>  * security warnings on subsequ=
ent memcpy() calls.</span><br><span>@@ -121,6 +130,16 @@</span><br><span>  =
   char buf[256];</span><br><span> };</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Network namespace NSID request message</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct sitnl_nsid_req</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct nlmsghdr n;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct rtgenmsg g;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char buf[256];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, v=
oid *arg);</span><br><span> </span><br><span> /**</span><br><span>@@ -165,6=
 +184,105 @@</span><br><span>     return 0;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TA=
RGET_LINUX) &amp;&amp; defined(ENABLE_SITNL)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static int netns_id_from_name_sitnl(const char *name);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static int set_netns_id_from_name_=
sitnl(const char *name);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_init(struct context *c=
, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
tat st;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char pat=
h[PATH_MAX];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ctx-&gt;netns =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (c &amp;&amp; c-&gt;options.ne=
tns)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(path, sizeof=
(path), &quot;%s/%s&quot;, NETNS_RUN_DIR, c-&gt;options.netns);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (stat(path, &amp;st) !=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(M_ERR, &quot;%s: Network=
 namespace %s does not exist&quot;, __func__, path);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ctx-&gt;netns =3D c-&gt;options.netns;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ctx-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+net_ctx_reset(openvpn_net_ctx_t *ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_reset(&amp;ctx-&gt;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_ctx_free(o=
penvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;ctx-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+netns_switch(openvpn_net_ctx_t *ctx)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    char net_path[PATH_MAX];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int orig_fd =3D -1, netns_fd;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *netns =3D ctx ? ctx=
-&gt;netns : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!netns)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Save current netns descriptor */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    orig_fd =3D open(NETNS_ORIG_DIR, O_RDONLY | O_CL=
OEXEC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (orig=
_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M=
_ERRNO, &quot;%s: Cannot open original network namespace&quot;, __func__);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    snprintf(net_path, sizeof(net_path), &quot;%s/%s&q=
uot;, NETNS_RUN_DIR, netns);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    netns_fd =3D open(net_path, O_RDONLY | O_CLOEXEC);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: =
Cannot open network namespace \&quot;%s\&quot;&quot;, __func__, netns);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(orig_fd);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (setns(netns_fd, CLONE_NEWNET) &lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: s=
etting the network namespace \&quot;%s\&quot; failed&quot;, __func__, netns=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(net=
ns_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clos=
e(orig_fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    close(netns_fd);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return orig_fd;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+netns_restore(int=
 orig_fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (orig_fd &lt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (setns(orig_fd, CLONE_NEWNET) &lt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: Cannot restore original=
 network namespace&quot;, __func__);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(orig_f=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined (TARGET_LINUX) &=
amp;&amp; defined (ENABLE_SITNL) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Open RTNL socket<=
/span><br><span>  */</span><br><span>@@ -454,6 +572,290 @@</span><br><span>=
     return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SITNL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Netlink callback to extract the interface index from a=
 RTM_NEWLINK message.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This functio=
n is used as a Netlink response handler. It inspects incoming</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Netlink messages and, when a R=
TM_NEWLINK message is received, copies the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * contained `struct ifinfomsg` into the caller-prov=
ided result structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n   =
 Netlink message header received from the kernel.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param arg  Pointer to a `struct sitnl_lin=
k_req` used to store the result.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return 0 to stop Netlink message processing once the interface is found,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         1 to contin=
ue processing other messages.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_link_get_=
ifindex(struct nlmsghdr *n, void *arg)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct sitnl_link_req *res =3D arg;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ifinfomsg *ifi;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (n-&gt;nlmsg_type !=3D RTM_NEWLINK)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifi =3D NLM=
SG_DATA(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res-=
&gt;i =3D *ifi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retr=
ieve the interface index of a network device in a specific network namespac=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Sends an RTM_GETLINK Netlink re=
quest targeting the given network namespace ID</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * and interface name, and extracts the resultin=
g interface index from the kernel</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * response.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * On fail=
ure, this function returns 0, matching the behavior of</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * `if_nametoindex()`.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param ifname   Name of the network interface.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param netnsid  Targe=
t network namespace ID.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return In=
terface index on success, or 0 on error.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_=
ifindex_in_netns(const char *ifname, int netnsid)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct sitnl_link_req req;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct sitnl_link_req res;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1, ifindex =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    CLEAR(res);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_type =3D RTM_GETLINK;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_flags=
 =3D NLM_F_REQUEST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&=
amp;req.n, sizeof(req), IFLA_TARGET_NETNSID, &amp;netnsid, sizeof(int));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp=
;req.n, sizeof(req), IFLA_IFNAME, ifname, strlen(ifname) + 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0, sitnl_link=
_get_ifindex, &amp;res);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return ret;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ifindex =3D res.i.ifi_index;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+sitnl_parse_rtattr_flags(struct rtattr *tb[], size=
_t max, struct rtattr *rta, size_t len,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                         unsigned short flags)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned short type;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memset(tb, 0, sizeof(struct rtattr *) * (max + 1));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (RTA_OK(rta, len))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        type =3D rta-&gt;rta_type &amp; ~flags=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if ((type &lt;=3D max) &amp;&=
amp; (!tb[type]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
tb[type] =3D rta;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        rta =3D RTA_NEXT(rta, l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (len)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(D_ROUTE, &quot;%s: %zu bytes not parsed! (rta_len=3D%u)&q=
uot;, __func__, len, rta-&gt;rta_len);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr =
*rta, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_par=
se_rtattr_flags(tb, max, rta, len, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Netlink callback to extract and=
 store a network namespace ID (NSID).</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * This function processes Netlink responses to RTM_GETNSID requests.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If a NETNSA_NSID attr=
ibute is present, its value is copied into the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * caller-provided storage.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * If a Netlink error message is received, the contained =
error code is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ret=
urned directly.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n    Netlin=
k message header received from the kernel.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param arg  Pointer to an integer where the NSID =
will be stored.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 on succe=
ss, a negative error code on failure.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_n=
sid_save(struct nlmsghdr *n, void *arg)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int *nsid =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct rtgenmsg *g =3D NLMSG_DATA(n);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct rtattr *tb[NETNSA_MAX + 1];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int ret;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (n-&gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct nlmsgerr *err =3D NLMSG_DATA(=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return e=
rr-&gt;error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_parse_rtattr(tb, NETN=
SA_MAX, SITNL_NETNS_RTA(g), NLMSG_PAYLOAD(n, sizeof(*g)));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return ret;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tb[NETNSA_NSID])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return -ENOENT;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    memcpy(nsid, RTA_DATA(tb[NETNSA_NSID]), sizeof(*nsid));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retri=
eve the network namespace ID (NSID) associated with a namespace name.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
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
20, 100%, 40%);">+    int netnsid =3D -1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int netns_fd =3D open(name, O_RDONLY);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_len =
=3D NLMSG_LENGTH(sizeof(req.g));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    req.n.nlmsg_type =3D RTM_GETNSID;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_flags =3D NLM_F_REQUEST;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.g.rtgen_family =
=3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;r=
eq.n, sizeof(req), NETNSA_FD, &amp;netns_fd, sizeof(int));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sitnl_send(&amp;req.n, 0, 0, sitnl_nsid_save, &amp;=
netnsid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (netns_fd &gt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        close(netns_fd);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return netnsid;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Assign a network namespace ID (NSI=
D) to a namespace.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function s=
ends an RTM_NEWNSID Netlink request to associate a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * NSID with the network namespace identifie=
d by the given path.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param name  =
Name of the network namespace.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn 0 on success, or a negative error code on failure.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+set_netns_id_from_name_sitnl(const char *name)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct sitnl_nsid_req req;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int ret =3D -1, netnsid =3D -1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CLEAR(req);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int netns_fd =3D open(name, O_RDONLY);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (netns_fd &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg=
_len =3D NLMSG_LENGTH(sizeof(req.g));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    req.n.nlmsg_type =3D RTM_NEWNSID;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    req.n.nlmsg_flags =3D NLM_F_REQUEST=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req.g.rtgen_fa=
mily =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&=
amp;req.n, sizeof(req), NETNSA_FD, &amp;netns_fd, sizeof(int));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SITNL_ADDATTR(&amp;req.n, s=
izeof(req), NETNSA_NSID, &amp;netnsid, sizeof(int));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (netns_fd &gt;=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        close(netns_fd);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+get_or_create_netnsid_sitnl(const char *name)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char net_path[PATH_MAX];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int netnsid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    snprintf(net_path, sizeof(net_path), =
&quot;%s/%s&quot;, NETNS_RUN_DIR, name);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* First get */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    netnsid =3D netns_id_from_name_sitnl(net_path);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &gt;=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return netnsid;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* No netnsid yet? Try to assign one */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    netnsid =3D set_netns_id_from_name_sitnl(net_path=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &=
lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Second get */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    netnsid =3D netns_id_from_name_sitnl(net_path);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &gt;=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return netnsid;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+openvpn_if_nametoindex(const char *ifname, ope=
nvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *n=
etns =3D ctx ? ctx-&gt;netns : NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int netnsid =3D get_or_create_netnsid_sitnl(netns);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (netnsid &lt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return if_nametoindex(ifname);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return get_ifindex_in_netns(ifname, netnsid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* ifdef ENABLE_SITNL */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typedef struct</span><b=
r><span> {</span><br><span>     size_t addr_size;</span><br><span>@@ -661,7=
 +1063,7 @@</span><br><span> net_iface_up(openvpn_net_ctx_t *ctx, const cha=
r *iface, bool up)</span><br><span> {</span><br><span>     struct sitnl_lin=
k_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifi=
ndex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ifinde=
x, orig =3D -1;</span><br><span> </span><br><span>     CLEAR(req);</span><b=
r><span> </span><br><span>@@ -671,13 +1073,15 @@</span><br><span>         r=
eturn -EINVAL;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D openvp=
n_if_nametoindex(iface, ctx);</span><br><span>     if (ifindex =3D=3D 0)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(M_WARN, &quot;%s: rtnl: cannot get ifindex for %s: %s&quot;, __f=
unc__, iface, strerror(errno));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifinde=
x for %s&quot;, __func__, iface);</span><br><span>         return -ENOENT;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     req.n.nlmsg_len =3D=
 NLMSG_LENGTH(sizeof(req.i));</span><br><span>     req.n.nlmsg_flags =3D NL=
M_F_REQUEST;</span><br><span>     req.n.nlmsg_type =3D RTM_NEWLINK;</span><=
br><span>@@ -696,24 +1100,30 @@</span><br><span> </span><br><span>     msg(=
M_INFO, &quot;%s: set %s %s&quot;, __func__, iface, up ? &quot;up&quot; : &=
quot;down&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D sitnl_send(&=
amp;req.n, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    netns=
_restore(orig);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span> net_ifa=
ce_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)</span><=
br><span> {</span><br><span>     struct sitnl_link_req req;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D -1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int ifindex, orig =3D -1=
, ret =3D -1;</span><br><span> </span><br><span>     CLEAR(req);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>=
     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>         =
msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __fu=
nc__, iface);</span><br><span>         return -1;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
orig =3D netns_switch(ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i=
));</span><br><span>     req.n.nlmsg_flags =3D NLM_F_REQUEST;</span><br><sp=
an>     req.n.nlmsg_type =3D RTM_NEWLINK;</span><br><span>@@ -726,7 +1136,9=
 @@</span><br><span>     msg(M_INFO, &quot;%s: mtu %u for %s&quot;, __func_=
_, mtu, iface);</span><br><span> </span><br><span>     ret =3D sitnl_send(&=
amp;req.n, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> err:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    netns_restore(orig);</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span>@@ -734,17 +1146,19 @@</sp=
an><br><span> net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_ifa=
ce_t *iface, uint8_t *addr)</span><br><span> {</span><br><span>     struct =
sitnl_link_req req;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int ifindex, ret =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int ifindex, orig =3D -1, ret =3D -1;</span><br><span> </span><b=
r><span>     CLEAR(req);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ifindex =3D openvpn_if_nametoin=
dex(iface, ctx);</span><br><span>     if (ifindex =3D=3D 0)</span><br><span=
>     {</span><br><span>         msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cann=
ot get ifindex for %s&quot;, __func__, iface);</span><br><span>         ret=
urn -1;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     req.n.nlmsg_=
len =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span>     req.n.nlmsg_flags=
 =3D NLM_F_REQUEST;</span><br><span>     req.n.nlmsg_type =3D RTM_NEWLINK;<=
/span><br><span>@@ -757,17 +1171,19 @@</span><br><span>     msg(M_INFO, &qu=
ot;%s: lladdr &quot; MAC_FMT &quot; for %s&quot;, __func__, MAC_PRINT_ARG(a=
ddr), iface);</span><br><span> </span><br><span>     ret =3D sitnl_send(&am=
p;req.n, 0, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> err:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    netns_restore(orig);</span><br><span>     return ret;</span>=
<br><span> }</span><br><span> </span><br><span> static int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uint16_t =
flags, int ifindex, sa_family_t af_family,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+sitnl_addr_set(openvpn_net_ctx_t *ctx, uint16_t cmd,=
 uint16_t flags, int ifindex, sa_family_t af_family,</span><br><span>      =
          const inet_address_t *local, const inet_address_t *remote, int pr=
efixlen)</span><br><span> {</span><br><span>     struct sitnl_addr_req req;=
</span><br><span>     uint32_t size;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int ret =3D -EINVAL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int ret =3D -EINVAL, orig =3D -1;</span><br><span> =
</span><br><span>     CLEAR(req);</span><br><span> </span><br><span>@@ -819=
,17 +1235,22 @@</span><br><span>         SITNL_ADDATTR(&amp;req.n, sizeof(r=
eq), IFA_BROADCAST, &amp;broadcast, size);</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig =
=3D netns_switch(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  if (ret =3D=3D -EEXIST)</span><br><span>     {</span><br><span>         r=
et =3D 0;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> err:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    netns_restore(orig);</span><br><span>     return ret;</=
span><br><span> }</span><br><span> </span><br><span> static int</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_ptp_add(sa_family_t af=
_family, const char *iface, const inet_address_t *local,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_ptp_add(openvpn_net_ctx_t *=
ctx, sa_family_t af_family, const char *iface, const inet_address_t *local,=
</span><br><span>                    const inet_address_t *remote)</span><b=
r><span> {</span><br><span>     int ifindex;</span><br><span>@@ -850,19 +12=
71,19 @@</span><br><span>         return -EINVAL;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
index =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br>=
<span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot get =
ifindex for %s: %s&quot;, __func__, np(iface), strerror(errno));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, =
&quot;%s: cannot get ifindex for %s&quot;, __func__, np(iface));</span><br>=
<span>         return -ENOENT;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_set=
(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_se=
t(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, local=
,</span><br><span>                           remote, 0);</span><br><span> }=
</span><br><span> </span><br><span> static int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-sitnl_addr_ptp_del(sa_family_t af_family, const ch=
ar *iface, const inet_address_t *local)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+sitnl_addr_ptp_del(openvpn_net_ctx_t *ctx, sa_family_t =
af_family, const char *iface, const inet_address_t *local)</span><br><span>=
 {</span><br><span>     int ifindex;</span><br><span> </span><br><span>@@ -=
882,23 +1303,23 @@</span><br><span>         return -EINVAL;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);<=
/span><br><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><br=
><span>         msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifindex for %s&q=
uot;, __func__, iface);</span><br><span>         return -ENOENT;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, loca=
l, NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn sitnl_addr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0)=
;</span><br><span> }</span><br><span> </span><br><span> static int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(uint16_t cmd, =
uint16_t flags, int ifindex, sa_family_t af_family, const void *dst,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set(openvpn_ne=
t_ctx_t *ctx, uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_fam=
ily, const void *dst,</span><br><span>                 int prefixlen, const=
 void *gw, enum rt_class_t table, int metric,</span><br><span>             =
    enum rt_scope_t scope, unsigned char protocol, unsigned char type)</spa=
n><br><span> {</span><br><span>     struct sitnl_route_req req;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -1, size;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1, size, o=
rig =3D -1;</span><br><span> </span><br><span>     CLEAR(req);</span><br><s=
pan> </span><br><span>@@ -957,14 +1378,17 @@</span><br><span>     {</span><=
br><span>         SITNL_ADDATTR(&amp;req.n, sizeof(req), RTA_PRIORITY, &amp=
;metric, 4);</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    orig =3D netns_switch(ctx);</span><br><span> </span><br=
><span>     ret =3D sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> err:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);</span=
><br><span>     return ret;</span><br><span> }</span><br><span> </span><br>=
<span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitn=
l_addr_add(sa_family_t af_family, const char *iface, const inet_address_t *=
addr, int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+sitnl_addr_add(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *=
iface, const inet_address_t *addr, int prefixlen)</span><br><span> {</span>=
<br><span>     int ifindex;</span><br><span> </span><br><span>@@ -984,19 +1=
408,19 @@</span><br><span>         return -EINVAL;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
findex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br=
><span>     if (ifindex =3D=3D 0)</span><br><span>     {</span><br><span>  =
       msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot=
;, __func__, iface);</span><br><span>         return -ENOENT;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, =
ifindex, af_family, addr, NULL,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return sitnl_addr_set(ctx, RTM_NEWADDR, NLM_F_CREATE | NLM_=
F_REPLACE, ifindex, af_family, addr, NULL,</span><br><span>                =
           prefixlen);</span><br><span> }</span><br><span> </span><br><span=
> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_add=
r_del(sa_family_t af_family, const char *iface, inet_address_t *addr, int p=
refixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr=
_del(openvpn_net_ctx_t *ctx, sa_family_t af_family, const char *iface, inet=
_address_t *addr, int prefixlen)</span><br><span> {</span><br><span>     in=
t ifindex;</span><br><span> </span><br><span>@@ -1016,14 +1440,14 @@</span>=
<br><span>         return -EINVAL;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_na=
metoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span>     if (=
ifindex =3D=3D 0)</span><br><span>     {</span><br><span>         msg(M_WAR=
N | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, ifa=
ce);</span><br><span>         return -ENOENT;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_ad=
dr_set(ctx, RTM_DELADDR, 0, ifindex, af_family, addr, NULL, prefixlen);</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span>@@ -=
1042,7 +1466,7 @@</span><br><span>     msg(M_INFO, &quot;%s: %s/%d dev %s&q=
uot;, __func__, inet_ntop(AF_INET, &amp;addr_v4.ipv4, buf, sizeof(buf)),</s=
pan><br><span>         prefixlen, iface);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_add(AF_INET, if=
ace, &amp;addr_v4, prefixlen);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return sitnl_addr_add(ctx, AF_INET, iface, &amp;addr_v4, pre=
fixlen);</span><br><span> }</span><br><span> </span><br><span> int</span><b=
r><span>@@ -1062,7 +1486,7 @@</span><br><span>     msg(M_INFO, &quot;%s: %s=
/%d dev %s&quot;, __func__, inet_ntop(AF_INET6, &amp;addr_v6.ipv6, buf, siz=
eof(buf)),</span><br><span>         prefixlen, iface);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_ad=
d(AF_INET6, iface, &amp;addr_v6, prefixlen);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return sitnl_addr_add(ctx, AF_INET6, iface, &a=
mp;addr_v6, prefixlen);</span><br><span> }</span><br><span> </span><br><spa=
n> int</span><br><span>@@ -1081,7 +1505,7 @@</span><br><span>     msg(M_INF=
O, &quot;%s: %s dev %s&quot;, __func__, inet_ntop(AF_INET, &amp;addr_v4.ipv=
4, buf, sizeof(buf)),</span><br><span>         iface);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_de=
l(AF_INET, iface, &amp;addr_v4, prefixlen);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return sitnl_addr_del(ctx, AF_INET, iface, &amp=
;addr_v4, prefixlen);</span><br><span> }</span><br><span> </span><br><span>=
 int</span><br><span>@@ -1101,7 +1525,7 @@</span><br><span>     msg(M_INFO,=
 &quot;%s: %s/%d dev %s&quot;, __func__, inet_ntop(AF_INET6, &amp;addr_v6.i=
pv6, buf, sizeof(buf)),</span><br><span>         prefixlen, iface);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
sitnl_addr_del(AF_INET6, iface, &amp;addr_v6, prefixlen);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_del(ctx, AF_INE=
T6, iface, &amp;addr_v6, prefixlen);</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span>@@ -1129,7 +1553,7 @@</span><br><span> =
        inet_ntop(AF_INET, &amp;local_v4.ipv4, buf1, sizeof(buf1)),</span><=
br><span>         inet_ntop(AF_INET, &amp;remote_v4.ipv4, buf2, sizeof(buf2=
)), iface);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return sitnl_addr_ptp_add(AF_INET, iface, &amp;local_v4, &amp;r=
emote_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n sitnl_addr_ptp_add(ctx, AF_INET, iface, &amp;local_v4, &amp;remote_v4);</=
span><br><span> }</span><br><span> </span><br><span> int</span><br><span>@@=
 -1150,11 +1574,11 @@</span><br><span>     msg(M_INFO, &quot;%s: %s dev %s&=
quot;, __func__, inet_ntop(AF_INET, &amp;local_v4.ipv4, buf, sizeof(buf)),<=
/span><br><span>         iface);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return sitnl_addr_ptp_del(AF_INET, iface, =
&amp;local_v4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return sitnl_addr_ptp_del(ctx, AF_INET, iface, &amp;local_v4);</span><br><s=
pan> }</span><br><span> </span><br><span> static int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-sitnl_route_add(const char *iface, sa_famil=
y_t af_family, const void *dst, int prefixlen,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sitnl_route_add(openvpn_net_ctx_t *ctx, const ch=
ar *iface, sa_family_t af_family, const void *dst, int prefixlen,</span><br=
><span>                 const void *gw, uint32_t table, int metric)</span><=
br><span> {</span><br><span>     enum rt_scope_t scope =3D RT_SCOPE_UNIVERS=
E;</span><br><span>@@ -1162,7 +1586,7 @@</span><br><span> </span><br><span>=
     if (iface)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        ifindex =3D if_nametoindex(iface);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ifindex =3D openvpn_if_name=
toindex(iface, ctx);</span><br><span>         if (ifindex =3D=3D 0)</span><=
br><span>         {</span><br><span>             msg(M_WARN | M_ERRNO, &quo=
t;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__, iface);</span><br=
><span>@@ -1180,7 +1604,7 @@</span><br><span>         scope =3D RT_SCOPE_LI=
NK;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREAT=
E, ifindex, af_family, dst, prefixlen, gw,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return sitnl_route_set(ctx, RTM_NEWROUTE, NLM_F_=
CREATE, ifindex, af_family, dst, prefixlen, gw,</span><br><span>           =
                 table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span><br=
><span> }</span><br><span> </span><br><span>@@ -1209,7 +1633,7 @@</span><br=
><span>         inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(dst_str)), =
prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_be, gw_str, =
sizeof(gw_str)), np(iface), table, metric);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_add(iface, A=
F_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_add(ctx, iface, AF=
_INET, dst_ptr, prefixlen, gw_ptr, table, metric);</span><br><span> }</span=
><br><span> </span><br><span> int</span><br><span>@@ -1235,18 +1659,18 @@</=
span><br><span>         inet_ntop(AF_INET6, &amp;dst_v6.ipv6, dst_str, size=
of(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET6, &amp;=
gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitn=
l_route_add(iface, AF_INET6, dst, prefixlen, gw, table, metric);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_add(ctx=
, iface, AF_INET6, dst, prefixlen, gw, table, metric);</span><br><span> }</=
span><br><span> </span><br><span> static int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-sitnl_route_del(const char *iface, sa_family_t af_fa=
mily, inet_address_t *dst, int prefixlen,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+sitnl_route_del(openvpn_net_ctx_t *ctx, const char *i=
face, sa_family_t af_family, inet_address_t *dst, int prefixlen,</span><br>=
<span>                 inet_address_t *gw, uint32_t table, int metric)</spa=
n><br><span> {</span><br><span>     int ifindex =3D 0;</span><br><span> </s=
pan><br><span>     if (iface)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ifindex =3D if_nametoindex(iface);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ifindex =3D =
openvpn_if_nametoindex(iface, ctx);</span><br><span>         if (ifindex =
=3D=3D 0)</span><br><span>         {</span><br><span>             msg(M_WAR=
N | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__, =
iface);</span><br><span>@@ -1259,7 +1683,7 @@</span><br><span>         tabl=
e =3D RT_TABLE_MAIN;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_DELR=
OUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(ctx,=
 RTM_DELROUTE, 0, ifindex, af_family, dst, prefixlen, gw, table, metric,</s=
pan><br><span>                            RT_SCOPE_NOWHERE, 0, 0);</span><b=
r><span> }</span><br><span> </span><br><span>@@ -1286,7 +1710,7 @@</span><b=
r><span>         inet_ntop(AF_INET, &amp;dst_v4.ipv4, dst_str, sizeof(dst_s=
tr)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_v4.ipv=
4, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_d=
el(iface, AF_INET, &amp;dst_v4, prefixlen, &amp;gw_v4, table, metric);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_d=
el(ctx, iface, AF_INET, &amp;dst_v4, prefixlen, &amp;gw_v4, table, metric);=
</span><br><span> }</span><br><span> </span><br><span> int</span><br><span>=
@@ -1312,7 +1736,7 @@</span><br><span>         inet_ntop(AF_INET6, &amp;dst=
_v6.ipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>         in=
et_ntop(AF_INET6, &amp;gw_v6.ipv6, gw_str, sizeof(gw_str)), np(iface), tabl=
e, metric);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return sitnl_route_del(iface, AF_INET6, &amp;dst_v6, prefixlen,=
 &amp;gw_v6, table, metric);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return sitnl_route_del(ctx, iface, AF_INET6, &amp;dst_v6, pref=
ixlen, &amp;gw_v6, table, metric);</span><br><span> }</span><br><span> </sp=
an><br><span> </span><br><span>@@ -1356,44 +1780,11 @@</span><br><span>    =
 msg(D_ROUTE, &quot;%s: add %s type %s&quot;, __func__, iface, type);</span=
><br><span> </span><br><span>     ret =3D sitnl_send(&amp;req.n, 0, 0, NULL=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> err:</span><br><span>     return ret;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_parse_rtattr_flags(s=
truct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                         unsigned=
 short flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned short type;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    memset(tb, 0, sizeof(struct rtattr *) * (m=
ax + 1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    while (RTA_OK(rta, len))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        type =3D rta-&gt;rta_type &amp; ~f=
lags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if ((type &lt;=3D max) &amp;&=
amp; (!tb[type]))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tb[t=
ype] =3D rta;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        rta =3D RTA_NEXT(rta, len);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (len)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_=
ROUTE, &quot;%s: %zu bytes not parsed! (rta_len=3D%u)&quot;, __func__, len,=
 rta-&gt;rta_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_parse_rtattr(struct=
 rtattr *tb[], size_t max, struct rtattr *rta, size_t len)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #define sitnl_parse_rta=
ttr_nested(tb, max, rta) \</span><br><span>     (sitnl_parse_rtattr_flags(t=
b, max, RTA_DATA(rta), RTA_PAYLOAD(rta), NLA_F_NESTED))</span><br><span> </=
span><br><span>@@ -1436,13 +1827,16 @@</span><br><span> net_iface_type(open=
vpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span=
><br><span> {</span><br><span>     struct sitnl_link_req req =3D {};</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D if_namet=
oindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int orig =3D -1;</span><br><span> </span=
><br><span>     if (!ifindex)</span><br><span>     {</span><br><span>      =
   return -errno;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    orig =3D netns_switch(ctx);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     re=
q.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span>     req.n.n=
lmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req.n.nlmsg_type =3D RTM=
_GETLINK;</span><br><span>@@ -1455,26 +1849,32 @@</span><br><span>     int =
ret =3D sitnl_send(&amp;req.n, 0, 0, sitnl_type_save, type);</span><br><spa=
n>     if (ret &lt; 0)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        netns_restore(orig);</span><br><span>    =
     msg(D_ROUTE, &quot;%s: cannot retrieve iface %s: %s (%d)&quot;, __func=
__, iface, strerror(-ret), ret);</span><br><span>         return ret;</span=
><br><span>     }</span><br><span> </span><br><span>     msg(D_ROUTE, &quot=
;%s: type of %s: %s&quot;, __func__, iface, type);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 return 0;</span><br><span> }</span><br><span> </span><br><span> int</span>=
<br><span> net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)</span><=
br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
ret =3D -1, orig =3D -1;</span><br><span>     struct sitnl_link_req req =3D=
 {};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int ifindex =3D openvpn_if_nametoindex(iface, ctx);</span><br><s=
pan> </span><br><span>     if (!ifindex)</span><br><span>     {</span><br><=
span>         return -errno;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    orig =3D netns_switch=
(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     req.n.nlmsg_len =3D NLMSG_LENGTH(sizeof(req.i));</span><br><span> =
    req.n.nlmsg_flags =3D NLM_F_REQUEST;</span><br><span>     req.n.nlmsg_t=
ype =3D RTM_DELLINK;</span><br><span>@@ -1484,7 +1884,11 @@</span><br><span=
> </span><br><span>     msg(D_ROUTE, &quot;%s: delete %s&quot;, __func__, i=
face);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return sitnl_send(&amp;req.n, 0, 0, NULL, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret =3D sitnl_send(&amp;req.n, 0, 0=
, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    netns_restore(orig);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</sp=
an><br><span> </span><br><span> #endif /* !ENABLE_SITNL */</span><br><span>=
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.=
h</span><br><span>index 481cc36..7e723fe 100644</span><br><span>--- a/src/o=
penvpn/networking_sitnl.h</span><br><span>+++ b/src/openvpn/networking_sitn=
l.h</span><br><span>@@ -21,7 +21,97 @@</span><br><span> #ifndef NETWORKING_=
SITNL_H_</span><br><span> #define NETWORKING_SITNL_H_</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;env_set.=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> typedef char openvpn_net_iface_t;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-typedef void *openvpn_net_ctx_t;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct openvpn_net_ctx</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *netns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+typedef struct openvpn_net_ctx o=
penvpn_net_ctx_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @brief Switch the current thread t=
o the network namespace specified</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *        in the given OpenVPN network context.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * This function changes the calling thread&#39;s =
network namespace to the one</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * identified by ctx-&gt;netns. The current (original) network nam=
espace file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * descr=
iptor is saved and returned, so it can later be restored using</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * netns_restore().</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * If @p ctx is NULL or ctx-&gt;netns is NULL, th=
e function fails and returns -1.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * T=
he switch is performed using setns(2). This approach is required because</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the netlink library=
 does not support performing operations in an arbitrary</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * target network namespace, except for=
 interface creation and deletion.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Therefore, in order to execute generic netlink operations =
inside a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * specific=
 network namespace, the thread must temporarily enter</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * that namespace via setns().</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param ctx  Pointer to an OpenVPN network co=
ntext structure containing</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             the target network namespace name (ctx-&gt;netns). Th=
e namespace</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       is expected to exist under NETNS_RUN_DIR (e.g. /run/netns/).</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return On success, returns a file descri=
ptor referring to the original</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *         network namespace. This descriptor must be passed to<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         netns_res=
tore() to switch back.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return -1 on failure (an error is logged and no namespace switch is =
kept).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @note The returned file des=
criptor must be passed to netns_restore(),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *       which will restore the original namespace a=
nd close it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+int netns_switch(openvp=
n_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @brief Restore the previously sav=
ed network namespace.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This functio=
n restores the network namespace saved by netns_switch()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * using the file descriptor returned =
by that function.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If @p orig_fd is=
 negative, the function does nothing and returns</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * immediately.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * The restoration is performed using setns(2), switching the calli=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * thread back to=
 its original network namespace.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param orig_fd  File descriptor of the original network namespace,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *                 as returne=
d by netns_switch().</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @note This fu=
nction always closes @p orig_fd if it is &gt;=3D 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *       regardless of whether setns() su=
cceeds or fails.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
      After calling this function, @p orig_fd must not be reused.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void netns_restore(int orig_fd);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Resolve a network interface name to its interface index.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * If a valid network namespace ID is provid=
ed, the lookup is performed inside</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * that network namespace using Netlink. Otherwise, this fun=
ction falls back</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
to the standard `if_nametoindex()` call in the current namespace.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param ifname   Name of the network interfa=
ce.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx   =
   The network context where we retrieve</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *                 the network namespace name.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @return Interface index on success, or 0 =
on error.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+int openvpn_if_nametoindex=
(const char *ifname, openvpn_net_ctx_t *ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retrie=
ve or create a network namespace ID (NSID) for a given namespace.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * This function first attempts to retrieve th=
e NSID associated with the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * specified network namespace. If no NSID is currently assigned, it=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * requests the ker=
nel to create one and then retries the lookup.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param name  Name of the network namespace.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return The network namespace ID on success, or -1 o=
n failure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+int get_or_create_netnsid=
_sitnl(const char *name);</span><br><span> </span><br><span> #endif /* NETW=
ORKING_SITNL_H_ */</span><br><span>diff --git a/src/openvpn/options.c b/src=
/openvpn/options.c</span><br><span>index 713dcf4..8dc36b2 100644</span><br>=
<span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options=
.c</span><br><span>@@ -6488,6 +6488,14 @@</span><br><span>         VERIFY_P=
ERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;mtu_test =3D=
 true;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (streq(p[0], &quot;netns&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SITNL<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, =
&quot;NOTE: --netns is supported only on Linux when compiled with SITNL&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  options-&gt;netns =3D p[1];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/ope=
nvpn/options.h b/src/openvpn/options.h</span><br><span>index 422820c..892e3=
76 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b=
/src/openvpn/options.h</span><br><span>@@ -315,6 +315,7 @@</span><br><span>=
 </span><br><span>     struct dns_options dns_options;</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *netns;=
</span><br><span>     bool remote_random;</span><br><span>     const char *=
ipchange;</span><br><span>     const char *dev;</span><br><span>diff --git =
a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index f46802f..6837=
8d8 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/sr=
c/openvpn/tun.c</span><br><span>@@ -2082,6 +2082,13 @@</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; defi=
ned(ENABLE_SITNL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      int orig_fd =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (ctx-&gt;netns)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            orig_fd =3D netns_switch(ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif /* if defined(TARGET_LINUX) &amp;&amp; defined(ENABL=
E_SITNL) */</span><br><span>         /*</span><br><span>          * Process=
 --dev-node</span><br><span>          */</span><br><span>@@ -2098,6 +2105,1=
2 @@</span><br><span>         {</span><br><span>             msg(M_ERR, &qu=
ot;ERROR: Cannot open TUN/TAP dev %s&quot;, node);</span><br><span>        =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGE=
T_LINUX) &amp;&amp; defined(ENABLE_SITNL)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (orig_fd !=3D -1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            netns_restore(orig_fd);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>       =
  /*</span><br><span>          * Process --tun-ipv6</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1521?usp=3Demail">change 1521</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
521?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--Nlqvh6rq1U4=--

