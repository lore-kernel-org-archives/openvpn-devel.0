From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jul 2022 14:43:32 +0200
Message-Id: <20220713124332.16147-1-a@...2181...>
In-Reply-To: <20220711081019.29511-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 pre-05/25] networking: add net_iface_type
 API
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

This commit also extends the networking unit-test by using the newly
introduced API in conjunction with iface_new and iface_del.

The t_net.sh script has been slightly adapted to allow running these
tests in standalone (as they don't require any iproute2 counterpart).

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v2:
* extended unit-test to check for "no device exists case"
* fixed typ0 in commit message
* properly return -errno instead of errno

Changes from v1:
* added unit-test for net_iface_type()
* adjusted t_net.sh script so that iface_new/type/del could be executed
  automatically


 src/openvpn/networking.h                   |  14 +++
 src/openvpn/networking_iproute2.c          |   9 ++
 src/openvpn/networking_sitnl.c             | 109 +++++++++++++++++++++
 tests/t_net.sh                             |  15 ++-
 tests/unit_tests/openvpn/test_networking.c |  28 ++++--
 5 files changed, 166 insertions(+), 9 deletions(-)

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
index 4b220576..3062c1da 100644
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
+    msg(M_WARN, "%s: operation not supported by iproute2 backend", __func__);
+    return -1;
+}
+
 int
 net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 0944ad0a..b2f3ac72 100644
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
+        return -errno;
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
diff --git a/tests/t_net.sh b/tests/t_net.sh
index af78152c..bc91f825 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -2,7 +2,8 @@
 
 IFACE="ovpn-dummy0"
 UNIT_TEST="./unit_tests/openvpn/networking_testdriver"
-MAX_TEST=${1:-7}
+LAST_AUTO_TEST=7
+LAST_TEST=8
 
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
@@ -128,7 +129,7 @@ else
     fi
 fi
 
-for i in $(seq 0 $MAX_TEST); do
+for i in $(seq 0 $LAST_AUTO_TEST); do
     # reload dummy module to cleanup state
     reload_dummy
     typeset -a STATE_TEST
@@ -168,4 +169,14 @@ done
 # remove interface for good
 $RUN_SUDO ip link del $IFACE
 
+for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
+    $RUN_SUDO $UNIT_TEST $i
+    if [ $? -ne 0 ]; then
+        echo "unit-test $i errored out"
+        exit 1
+    fi
+
+    echo "Test $i: OK"
+done
+
 exit 0
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 10ed2cb5..04347076 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -2,6 +2,7 @@
 #include "syshead.h"
 #include "networking.h"
 
+#include <assert.h>
 
 static char *iface = "ovpn-dummy0";
 
@@ -16,14 +17,25 @@ net__iface_up(bool up)
 static int
 net__iface_new(const char *name, const char *type)
 {
-    printf("CMD: ip link add %s type %s\n", name, type);
     return net_iface_new(NULL, name, type, NULL);
 }
 
+static int
+net__iface_type(const char *name, const char *type)
+{
+    char ret_type[IFACE_TYPE_LEN_MAX];
+    int ret = net_iface_type(NULL, name, ret_type);
+    if (ret == 0)
+    {
+        assert(strcmp(type, ret_type) == 0);
+    }
+
+    return ret;
+}
+
 static int
 net__iface_del(const char *name)
 {
-    printf("CMD: ip link del %s\n", name);
     return net_iface_del(NULL, name);
 }
 
@@ -205,7 +217,7 @@ net__route_v6_add_gw(const char *dst_str, int prefixlen, const char *gw_str,
 static void
 usage(char *name)
 {
-    printf("Usage: %s <0-9>\n", name);
+    printf("Usage: %s <0-8>\n", name);
 }
 
 int
@@ -257,11 +269,13 @@ main(int argc, char *argv[])
         case 7:
             return net__route_v6_add_gw("2001:cafe:babe::", 48, "2001::2", 600);
 
+        /* following tests are standalone and do not print any CMD= */
         case 8:
-            return net__iface_new("dummy0815", "dummy");
-
-        case 9:
-            return net__iface_del("dummy0815");
+            assert(net__iface_new("dummy0815", "dummy") == 0);
+            assert(net__iface_type("dummy0815", "dummy") == 0);
+            assert(net__iface_del("dummy0815") == 0);
+            assert(net__iface_type("dummy0815", NULL) == -ENODEV);
+            return 0;
 
         default:
             printf("invalid test: %d\n", test);
-- 
2.35.1


