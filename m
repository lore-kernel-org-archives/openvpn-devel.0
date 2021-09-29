From: Antonio Quartulli <a@...2181...>
Date: Wed, 29 Sep 2021 09:07:17 +0200
Message-Id: <20210929070717.28164-1-a@...2181...>
In-Reply-To: <20210903161113.30498-1-a@...2181...>
References: <20210903161113.30498-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/2] networking: add and implement
 net_addr_ll_set() API
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
Cc: Antonio Quartulli <a@...2181...>, Jan Hugo Prins <jprins@...2634...>

When running in TAP mode we may need to set the LL address of the
interface, if requested by the user.

This operation was overlooked when implementing the networking API and
it still relies on iproute/net-tools being installed.

Basically this means that when compiling OpenVPN on a system without
iproute2/net-tools and the user uses the "lladdr" config directive,
OpenVPN will fail to se the LL address of the interface.

With this patch a new API is introduced and it is implemented for both
SITNL and iproute2 backends.

Reported-by: Jan Hugo Prins <jprins@...2634...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* addemissing brackets around oneliner if-block

 src/openvpn/misc.h                |  7 +++++++
 src/openvpn/networking.h          | 12 +++++++++++
 src/openvpn/networking_iproute2.c | 23 ++++++++++++++++++++
 src/openvpn/networking_sitnl.c    | 35 +++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index c10529f7..e8d1a521 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -211,4 +211,11 @@ get_num_elements(const char *string, char delimiter);
 struct buffer
 prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
 
+#define _STRINGIFY(S) #S
+#define MAC_FMT _STRINGIFY(%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx)
+#define MAC_PRINT_ARG(_mac) _mac[0], _mac[1], _mac[2],  \
+        _mac[3], _mac[4], _mac[5]
+#define MAC_SCAN_ARG(_mac) &_mac[0], &_mac[1], &_mac[2], \
+        &_mac[3], &_mac[4], &_mac[5]
+
 #endif /* ifndef MISC_H */
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 94f12617..d43979f0 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -103,6 +103,18 @@ int net_iface_up(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
 int net_iface_mtu_set(openvpn_net_ctx_t *ctx,
                       const openvpn_net_iface_t *iface, uint32_t mtu);
 
+/**
+ * Set the Link Layer (Ethernet) address of the TAP interface
+ *
+ * @param ctx       the implementation specific context
+ * @param iface     the interface to modify
+ * @param addr      the new address to set (expected ETH_ALEN bytes (6))
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+                    uint8_t *addr);
+
 /**
  * Add an IPv4 address to an interface
  *
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index e4897e3b..67b8894b 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -93,6 +93,29 @@ net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
     return 0;
 }
 
+int
+net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+                uint8_t *addr)
+{
+    struct argv argv = argv_new();
+    int ret = 0;
+
+    argv_printf(&argv,
+                "%s link set addr " MAC_FMT " dev %s",
+                iproute_path, MAC_PRINT_ARG(addr), iface);
+
+    argv_msg(M_INFO, &argv);
+    if (!openvpn_execve_check(&argv, ctx->es, M_WARN,
+                              "Linux ip link set addr failed"))
+    {
+        ret = -1;
+    }
+
+    argv_free(&argv);
+
+    return ret;
+}
+
 int
 net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
                 const in_addr_t *addr, int prefixlen)
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index f0dda7a4..8610e1d2 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -30,6 +30,7 @@
 
 #include "errlevel.h"
 #include "buffer.h"
+#include "misc.h"
 #include "networking.h"
 
 #include <errno.h>
@@ -723,6 +724,40 @@ err:
     return ret;
 }
 
+int
+net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+                uint8_t *addr)
+{
+    struct sitnl_link_req req;
+    int ifindex, ret = -1;
+
+    CLEAR(req);
+
+    ifindex = if_nametoindex(iface);
+    if (ifindex == 0)
+    {
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
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_ADDRESS, addr, ETH_ALEN);
+
+    msg(M_INFO, "%s: lladdr " MAC_FMT " for %s", __func__, MAC_PRINT_ARG(addr),
+        iface);
+
+    ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+err:
+    return ret;
+}
+
 static int
 sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
                const inet_address_t *local, const inet_address_t *remote,
-- 
2.32.0


