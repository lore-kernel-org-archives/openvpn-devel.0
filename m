From: Gert Doering <gert@...1296...>
Date: Wed, 18 Jan 2023 08:46:33 +0100
Message-Id: <20230118074633.27586-1-gert@...1296...>
In-Reply-To: <20230111160848.22906-1-gert@...1296...>
References: <20230111160848.22906-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Repair special-casing of EEXIST for
 Linux/SITNL route install
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

The code in sitnl_route_set() used to treat "route can not be installed
because it already exists" (EEXIST) as "not an error".

This is arguably a reasonable approach, but needs to handled higher
up - if the low level add_route() function say "no error", we will try
to remove that route later on in delete_route(), possibly removing
someone else's "already existing" route then.

So:
 - remove special case in sitnl_route_set()
 - do not pass NLM_F_REPLACE flag to sitnl_route_set() call - this would
   cause netlink to just replace existing routes, never return EEXIST
   (see "man netlink(7)")
 - add detailed return code handling to add_route(), assign "2" on "-EEXIST"
   (and log appropriate message).

(Note: sitnl_route_set() is a common function for sitnl route add and
delete, but EEXIST can not happen on delete - so this change has no
impact for the "delete" case)

v2: use RTA_ macros, also adjust add_route_ipv6()

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/networking_sitnl.c |  6 +-----
 src/openvpn/route.c            | 24 ++++++++++++++++++------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index dece83c2..cb9a47c0 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -944,10 +944,6 @@ sitnl_route_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
     }
 
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
-    if (ret == -EEXIST)
-    {
-        ret = 0;
-    }
 err:
     return ret;
 }
@@ -1177,7 +1173,7 @@ sitnl_route_add(const char *iface, sa_family_t af_family, const void *dst,
         scope = RT_SCOPE_LINK;
     }
 
-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
+    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, ifindex,
                            af_family, dst, prefixlen, gw, table, metric, scope,
                            RTPROT_BOOT, RTN_UNICAST);
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 61a40ff1..f1257b00 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1599,8 +1599,14 @@ add_route(struct route_ipv4 *r,
     }
 
     status = RTA_SUCCESS;
-    if (net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask),
-                         &r->gateway, iface, 0, metric) < 0)
+    int ret = net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask),
+                               &r->gateway, iface, 0, metric);
+    if (ret == -EEXIST)
+    {
+        msg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
+        status = RTA_EEXIST;
+    }
+    else if (ret < 0)
     {
         msg(M_WARN, "ERROR: Linux route add command failed");
         status = RTA_ERROR;
@@ -1963,11 +1969,17 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     }
 
     status = RTA_SUCCESS;
-    if (net_route_v6_add(ctx, &r6->network, r6->netbits,
-                         gateway_needed ? &r6->gateway : NULL, device, 0,
-                         metric) < 0)
+    int ret = net_route_v6_add(ctx, &r6->network, r6->netbits,
+                               gateway_needed ? &r6->gateway : NULL,
+                               device, 0, metric);
+    if (ret == -EEXIST)
     {
-        msg(M_WARN, "ERROR: Linux IPv6 route can't be added");
+        msg(D_ROUTE, "NOTE: Linux route add command failed because route exists");
+        status = RTA_EEXIST;
+    }
+    else if (ret < 0)
+    {
+        msg(M_WARN, "ERROR: Linux route add command failed");
         status = RTA_ERROR;
     }
 
-- 
2.38.2


