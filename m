From: Arne Schwabe <arne@...1227...>
Date: Fri, 16 Apr 2021 15:35:12 +0200
Message-Id: <20210416133512.1176870-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Also restore/save route-gatreway options in
 reconnects
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 6 ++++++
 src/openvpn/options.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5934b0b84..10078a4d6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3571,6 +3571,9 @@ pre_connect_save(struct options *o)
         o->pre_connect->client_nat_defined = true;
     }
 
+    o->pre_connect->route_default_gateway = o->route_default_gateway;
+    o->pre_connect->route_ipv6_default_gateway = o->route_ipv6_default_gateway;
+
     /* NCP related options that can be overwritten by a push */
     o->pre_connect->ciphername = o->ciphername;
     o->pre_connect->authname = o->authname;
@@ -3619,6 +3622,9 @@ pre_connect_restore(struct options *o, struct gc_arena *gc)
             o->routes_ipv6 = NULL;
         }
 
+        o->route_default_gateway = pp->route_default_gateway;
+        o->route_ipv6_default_gateway = pp->route_ipv6_default_gateway;
+
         if (pp->client_nat_defined)
         {
             cnol_check_alloc(o);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index ee3fd7e50..ef59f0a99 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -70,6 +70,9 @@ struct options_pre_connect
     bool routes_ipv6_defined;
     struct route_ipv6_option_list *routes_ipv6;
 
+    const char *route_default_gateway;
+    const char *route_ipv6_default_gateway;
+
     bool client_nat_defined;
     struct client_nat_option_list *client_nat;
 
-- 
2.31.1


