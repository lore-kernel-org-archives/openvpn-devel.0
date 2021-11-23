From: =?UTF-8?q?Fran=C3=A7ois=20Kooman?= <fkooman@...2318...>
Date: Tue, 23 Nov 2021 09:37:58 +0100
Message-Id: <20211123083758.15933-1-fkooman@...2318...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] implement net_gateway_ipv6 for --route-ipv6
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

fix for #1161

Signed-off-by: François Kooman <fkooman@...2318...>
---
 src/openvpn/options.c |  2 +-
 src/openvpn/route.c   | 67 +++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/route.h   |  1 +
 3 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cc3d9fa0..3d530d7a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6558,7 +6558,7 @@ add_option(struct options *options,
                 msg(msglevel, "route-ipv6 parameter network/IP '%s' must be a valid address", p[1]);
                 goto err;
             }
-            if (p[2] && !ipv6_addr_safe(p[2]))
+            if (p[2] && !ipv6_addr_safe(p[2]) && !ipv6_is_special_addr(p[2]))
             {
                 msg(msglevel, "route-ipv6 parameter gateway '%s' must be a valid address", p[2]);
                 goto err;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index fd1125ef..bd62b99a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -287,6 +287,38 @@ get_special_addr(const struct route_list *rl,
     return false;
 }
 
+static bool
+ipv6_get_special_addr(const struct route_ipv6_list *rl,
+                 const char *string,
+                 struct in6_addr *out,
+                 bool *status)
+{
+    if (status)
+    {
+        *status = true;
+    }
+    if (!strcmp(string, "net_gateway_ipv6"))
+    {
+        if (rl)
+        {
+            if (rl->rgi6.flags & RGI_ADDR_DEFINED)
+            {
+                *out = rl->rgi6.gateway.addr_ipv6;
+            }
+            else
+            {
+                msg(M_INFO, PACKAGE_NAME " ROUTE: net_gateway_ipv6 undefined -- unable to get default gateway from system");
+                if (status)
+                {
+                    *status = false;
+                }
+            }
+        }
+        return true;
+    }
+    return false;
+}
+
 bool
 is_special_addr(const char *addr_str)
 {
@@ -300,6 +332,19 @@ is_special_addr(const char *addr_str)
     }
 }
 
+bool
+ipv6_is_special_addr(const char *addr_str)
+{
+    if (addr_str)
+    {
+        return ipv6_get_special_addr(NULL, addr_str, NULL, NULL);
+    }
+    else
+    {
+        return false;
+    }
+}
+
 static bool
 init_route(struct route_ipv4 *r,
            struct addrinfo **network_list,
@@ -438,6 +483,7 @@ init_route_ipv6(struct route_ipv6 *r6,
                 const struct route_ipv6_option *r6o,
                 const struct route_ipv6_list *rl6 )
 {
+    bool status;
     CLEAR(*r6);
 
     if (!get_ipv6_addr( r6o->prefix, &r6->network, &r6->netbits, M_WARN ))
@@ -448,9 +494,26 @@ init_route_ipv6(struct route_ipv6 *r6,
     /* gateway */
     if (is_route_parm_defined(r6o->gateway))
     {
-        if (inet_pton( AF_INET6, r6o->gateway, &r6->gateway ) != 1)
+        if (ipv6_get_special_addr(rl6, r6o->gateway, &r6->gateway, &status))
         {
-            msg( M_WARN, PACKAGE_NAME "ROUTE6: cannot parse gateway spec '%s'", r6o->gateway );
+            r6->metric = 1;
+#ifdef _WIN32
+            r6->adapter_index = rl6->rgi6.adapter_index;
+#else
+            r6->iface = rl6->rgi6.iface;
+#endif
+            r6->flags = RT_DEFINED | RT_METRIC_DEFINED;
+        }
+        else
+        {
+            if (inet_pton( AF_INET6, r6o->gateway, &r6->gateway ) != 1)
+            {
+                msg( M_WARN, PACKAGE_NAME "ROUTE6: cannot parse gateway spec '%s'", r6o->gateway );
+            }
+        }
+        if (!status)
+        {
+            goto fail;
         }
     }
     else if (rl6->spec_flags & RTSA_REMOTE_ENDPOINT)
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index dc448c74..bbb8d2f8 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -320,6 +320,7 @@ void setenv_routes(struct env_set *es, const struct route_list *rl);
 void setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6);
 
 bool is_special_addr(const char *addr_str);
+bool ipv6_is_special_addr(const char *addr_str);
 
 void get_default_gateway(struct route_gateway_info *rgi,
                          openvpn_net_ctx_t *ctx);
-- 
2.33.1


