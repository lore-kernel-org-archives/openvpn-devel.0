From: Antonio Quartulli <a@...2181...>
Date: Tue, 28 Jun 2022 20:56:23 +0200
Message-Id: <20220628185623.1734-1-a@...2181...>
In-Reply-To: <20220624083809.23487-4-a@...2181...>
References: <20220624083809.23487-4-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 03/25] dco: use specific metric when
 installing routes
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

When using DCO iroutes and routes all live in the same routing table,
However, the latter should always come after the former.

for this reason assign a default metric of 200 to routes. iroutes will
later get a metric of 100.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* added comments before "(if (dco_enabled(c))" to explain why we need
  a different metric


 src/openvpn/dco.h  |  2 ++
 src/openvpn/init.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index dcadba78..063e5028 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -38,6 +38,8 @@ struct event_set;
 struct options;
 struct tuntap;
 
+#define DCO_DEFAULT_METRIC  200
+
 #if defined(ENABLE_DCO)
 
 /**
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 638fd10c..03221cbb 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1385,6 +1385,15 @@ do_init_route_list(const struct options *options,
     int dev = dev_type_enum(options->dev, options->dev_type);
     int metric = 0;
 
+    /* if DCO is enabled we have both regular routes and iroutes in the system
+     * routing table, and normal routes must have a higher metric for that to
+     * work so that iroutes are always matched first
+     */
+    if (dco_enabled(options))
+    {
+        metric = DCO_DEFAULT_METRIC;
+    }
+
     if (dev == DEV_TYPE_TUN && (options->topology == TOP_NET30 || options->topology == TOP_P2P))
     {
         gw = options->ifconfig_remote_netmask;
@@ -1421,6 +1430,12 @@ do_init_route_ipv6_list(const struct options *options,
     const char *gw = NULL;
     int metric = -1;            /* no metric set */
 
+    /* see explanation in do_init_route_list() */
+    if (dco_enabled(options))
+    {
+        metric = DCO_DEFAULT_METRIC;
+    }
+
     gw = options->ifconfig_ipv6_remote;         /* default GW = remote end */
     if (options->route_ipv6_default_gateway)
     {
-- 
2.35.1


