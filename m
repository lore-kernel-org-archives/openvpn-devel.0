From: Antonio Quartulli <a@...2181...>
Date: Tue,  7 Dec 2021 13:11:32 +0100
Message-Id: <20211207121137.3221-4-a@...2181...>
In-Reply-To: <20211207121137.3221-1-a@...2181...>
References: <20211207121137.3221-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC 3/8] sitnl: implement net_iface_new and
 net_iface_del
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
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>

From: Arne Schwabe <arne@...1227...>

These two new methods can be used to create and delete a tun or an
ovpn-dco interface via RTNL API.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking_sitnl.c             | 94 ++++++++++++++++++++++
 src/openvpn/networking_sitnl.h             | 28 +++++++
 tests/unit_tests/openvpn/test_networking.c | 22 ++++-
 3 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index e0003f5c..e6ffdb64 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1312,6 +1312,100 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
                            table, metric);
 }
 
+
+int
+net_iface_new(const char *iface, const char *type)
+{
+    struct sitnl_link_req req = { };
+    struct rtattr *tail = NULL;
+    int ret = -1;
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL ;
+    req.n.nlmsg_type = RTM_NEWLINK;
+
+    if (iface)
+    {
+        SITNL_ADDATTR(&req.n, sizeof(req), IFLA_IFNAME, iface, strlen(iface) + 1);
+    }
+    tail = NLMSG_TAIL(&req.n);
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_LINKINFO, NULL, 0);
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_INFO_KIND, type,
+                  strlen(type) + 1);
+    tail->rta_len = (uint8_t *)NLMSG_TAIL(&req.n) - (uint8_t *)tail;
+
+    req.i.ifi_family = AF_PACKET;
+    req.i.ifi_change = 0xFFFFFFFF;
+
+    msg(D_ROUTE, "%s: add %s type %s", __func__,  np(iface), type);
+
+    if (iface)
+    {
+        /* if we have an interface name we can use that name to later
+         * lookup what interface index we created */
+        ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+        if (!ret)
+        {
+            req.i.ifi_index = if_nametoindex(iface);
+        }
+
+    }
+    else
+    {
+        req.i.ifi_index = 1194;
+        do
+        {
+            /* for some reason RTM_NEWLINK does not have a reply */
+            /* Therefore we use try using different if indices untiles
+             * we get one that does not exist already  */
+            req.i.ifi_index++;
+            ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
+        }
+        while (ret == -EEXIST);
+    }
+    if (!ret)
+    {
+        return req.i.ifi_index;
+    }
+
+err:
+    return ret;
+}
+
+int
+net_iface_del_name(const char *iface)
+{
+    int ifindex;
+
+    ifindex = if_nametoindex(iface);
+
+    msg(D_ROUTE,"%s: idel %s", __func__, iface);
+
+    if (ifindex == 0)
+    {
+        msg(D_ROUTE|M_ERRNO, "%s: rtnl: cannot get ifindex for %s:",
+            __func__, iface);
+        return -ENOENT;
+    }
+
+    return net_iface_del_index(ifindex);
+}
+
+int
+net_iface_del_index(int ifindex)
+{
+    struct sitnl_link_req req = { };
+
+    req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
+    req.n.nlmsg_flags = NLM_F_REQUEST;
+    req.n.nlmsg_type = RTM_DELLINK;
+
+    req.i.ifi_family = AF_PACKET;
+    req.i.ifi_index = ifindex;
+
+    return sitnl_send(&req.n, 0, 0, NULL, NULL);
+}
+
 #endif /* !ENABLE_SITNL */
 
 #endif /* TARGET_LINUX */
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index f040020e..b88ffd4b 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -25,4 +25,32 @@
 typedef char openvpn_net_iface_t;
 typedef void *openvpn_net_ctx_t;
 
+/**
+ * @brief Add new interface (similar to ip link add)
+ *
+ * @param iface interface name
+ * @param type interface link type (for example "ovpn-dco")
+ * @return int 0 on success, negative error code on error
+ */
+int
+net_iface_new(const char *iface, const char *type);
+
+/**
+ * @brief Remove an interface (similar to ip link remove)
+ *
+ * @param iface interface name
+ * @return int 0 on success, negative error code on error
+ */
+int
+net_iface_del_name(const char *iface);
+
+/**
+ * @brief Remove an interface (similar to ip link remove)
+ *
+ * @param ifindex interface index
+ * @return int 0 on success, negative error code on error
+ */
+int
+net_iface_del_index(int ifindex);
+
 #endif /* NETWORKING_SITNL_H_ */
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 9e9744f4..37b97188 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -13,6 +13,20 @@ net__iface_up(bool up)
     return net_iface_up(NULL, iface, up);
 }
 
+static int
+net__iface_new(const char *name, const char* type)
+{
+    printf("CMD: ip link add %s type %s\n", name, type);
+    return net_iface_new(name, type);
+}
+
+static int
+net__iface_del(const char *name)
+{
+    printf("CMD: ip link del %s\n", name);
+    return net_iface_del_name(name);
+}
+
 static int
 net__iface_mtu_set(int mtu)
 {
@@ -191,7 +205,7 @@ net__route_v6_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
 static void
 usage(char *name)
 {
-    printf("Usage: %s <0-7>\n", name);
+    printf("Usage: %s <0-9>\n", name);
 }
 
 int
@@ -243,6 +257,12 @@ main(int argc, char *argv[])
         case 7:
             return net__route_v6_add_gw("2001:cafe:babe::", 48, "2001::2", 600);
 
+        case 8:
+            return net__iface_new("dummy0815", "dummy");
+
+        case 9:
+            return net__iface_del("dummy0815");
+
         default:
             printf("invalid test: %d\n", test);
             break;
-- 
2.32.0


