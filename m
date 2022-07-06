From: Antonio Quartulli <a@...2181...>
Date: Wed,  6 Jul 2022 16:29:06 +0200
Message-Id: <20220706142907.3962-1-a@...2181...>
In-Reply-To: <20220630140804.8277-1-a@...2181...>
References: <20220630140804.8277-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH pre-05/25] networking: add net_iface_type API
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

This new API can be used to retrieve the type of a specific interface.
It's mostly platform dependant, but right now expected values are
"ovpn-dco", "tun" or "tap".

Other values are possible too, but they are not of interest to us.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

This patch is required by 05/25 v6 as it introduces the networking API
required to retrieve an interafce type. This is then used by 05/25 v6.


 src/openvpn/networking.h          |  14 ++++
 src/openvpn/networking_iproute2.c |   9 +++
 src/openvpn/networking_sitnl.c    | 109 ++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 79963756..cf6d39ac 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -23,6 +23,8 @@
 
 #include "syshead.h"
 
+#define IFACE_TYPE_LEN_MAX 64
+
 struct context;
 
 #ifdef ENABLE_SITNL
@@ -100,6 +102,18 @@ void net_ctx_free(openvpn_net_ctx_t *ctx);
 int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
                   const char *type, void *arg);
 
+/**
+ * Retrieve the interface type
+ *
+ * @param ctx       the implementation specific context
+ * @param iface     interface to query
+ * @param type      buffer where the type will be stored
+ *
+ * @return          0 on success, a negative error code otherwise
+ */
+int net_iface_type(openvpn_net_ctx_t *ctx, const char *iface,
+                   char type[IFACE_TYPE_LEN_MAX]);
+
 /**
  * Remove an interface
  *
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 4b220576..a81e6b33 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -78,6 +78,15 @@ net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,
     return 0;
 }
 
+int
+net_iface_type(openvpn_net_ctx_t *ctx, const char *iface,
+               char type[IFACE_TYPE_LEN_MAX])
+{
+    /* not supported by iproute2 */
+    msg(M_WARN, "%s: operation not supported by iproute2 backend");
+    return -1;
+}
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 0944ad0a..e97db3f7 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1366,6 +1366,115 @@ err:
     return ret;
 }
 
+static int
+sitnl_parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta,
+                         int len, unsigned short flags)
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
+        msg(D_ROUTE, "%s: %d bytes not parsed! (rta_len=%d)", __func__, len,
+            rta->rta_len);
+    }
+
+    return 0;
+}
+
+static int
+sitnl_parse_rtattr(struct rtattr *tb[], int max, struct rtattr *rta, int len)
+{
+    return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
+}
+
+#define sitnl_parse_rtattr_nested(tb, max, rta) \
+    (sitnl_parse_rtattr_flags(tb, max, RTA_DATA(rta), RTA_PAYLOAD(rta), \
+                              NLA_F_NESTED))
+
+static int
+sitnl_type_save(struct nlmsghdr *n, void *arg)
+{
+    char *type = arg;
+    struct ifinfomsg *ifi = NLMSG_DATA(n);
+    struct rtattr *tb[IFLA_MAX + 1];
+    int ret;
+
+    ret = sitnl_parse_rtattr(tb, IFLA_MAX, IFLA_RTA(ifi), IFLA_PAYLOAD(n));
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+    if (tb[IFLA_LINKINFO])
+    {
+        struct rtattr *tb_link[IFLA_INFO_MAX + 1];
+
+        ret = sitnl_parse_rtattr_nested(tb_link, IFLA_INFO_MAX,
+                                        tb[IFLA_LINKINFO]);
+        if (ret < 0)
+        {
+            return ret;
+        }
+
+        if (!tb_link[IFLA_INFO_KIND])
+        {
+            return -ENOENT;
+        }
+
+        strncpynt(type, RTA_DATA(tb_link[IFLA_INFO_KIND]), IFACE_TYPE_LEN_MAX);
+    }
+
+    return 0;
+}
+
+int
+net_iface_type(openvpn_net_ctx_t *ctx, const char *iface,
+               char type[IFACE_TYPE_LEN_MAX])
+{
+    struct sitnl_link_req req = { };
+    int ifindex = if_nametoindex(iface);
+
+    if (!ifindex)
+    {
+        return errno;
+    }
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+    req.n.nlmsg_type = RTM_GETLINK;
+
+    req.i.ifi_family = AF_PACKET;
+    req.i.ifi_index = ifindex;
+
+    memset(type, 0, IFACE_TYPE_LEN_MAX);
+
+    int ret = sitnl_send(&req.n, 0, 0, sitnl_type_save, type);
+    if (ret < 0)
+    {
+        msg(D_ROUTE, "%s: cannot retrieve iface %s: %s (%d)", __func__, iface,
+            strerror(-ret), ret);
+        return ret;
+    }
+
+    msg(D_ROUTE, "%s: type of %s: %s", __func__, iface, type);
+
+    return 0;
+}
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
-- 
2.35.1


