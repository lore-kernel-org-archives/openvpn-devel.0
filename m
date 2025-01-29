From: Gert Doering <gert@...1296...>
Date: Wed, 29 Jan 2025 10:50:38 +0100
Message-ID: <20250129095038.19056-1-gert@...1296...>
In-Reply-To: <gerrit.1738070271000.I58735fb24bc4a94c803b7dfcd6de87af0f75522a@...2715...>
References: <gerrit.1738070271000.I58735fb24bc4a94c803b7dfcd6de87af0f75522a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] route.c: change the signature of
 get_default_gateway()
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

From: Lev Stipakov <lev@...515...>

As a preparation of an upcoming refactoring of
get_default_gateway(), add `dest` parameter to
specify destination address to which we are looking
the best route.

Change-Id: I58735fb24bc4a94c803b7dfcd6de87af0f75522a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/878
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4510bea..5a80e6b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5866,7 +5866,7 @@
             get_ipv6_addr(p[1], &remote, NULL, M_WARN);
         }
         net_ctx_init(NULL, &net_ctx);
-        get_default_gateway(&rgi, &net_ctx);
+        get_default_gateway(&rgi, 0, &net_ctx);
         get_default_gateway_ipv6(&rgi6, &remote, &net_ctx);
         print_default_gateway(M_INFO, &rgi, &rgi6);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d17b285..640b0dc 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -655,7 +655,7 @@
         rl->spec.flags |= RTSA_DEFAULT_METRIC;
     }
 
-    get_default_gateway(&rl->rgi, ctx);
+    get_default_gateway(&rl->rgi, remote_host, ctx);
     if (rl->rgi.flags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->rgi.gateway.addr, -1);
@@ -2733,7 +2733,7 @@
 }
 
 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
 
@@ -3282,7 +3282,7 @@
 #elif defined(TARGET_ANDROID)
 
 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
     /* Android, set some pseudo GW, addr is in host byte order,
      * Determining the default GW on Android 5.0+ is non trivial
@@ -3323,7 +3323,7 @@
 #elif defined(TARGET_LINUX)
 
 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     int sd = -1;
@@ -3561,7 +3561,7 @@
 #define max(a, b) ((a) > (b) ? (a) : (b))
 
 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     struct rtmsg m_rtmsg;
@@ -3943,7 +3943,7 @@
 #elif defined(TARGET_HAIKU)
 
 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
     CLEAR(*rgi);
 
@@ -4047,7 +4047,7 @@
  * may be disabled by missing items.
  */
 void
-get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
     CLEAR(*rgi);
 }
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..23603bc 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -328,6 +328,7 @@
 bool is_special_addr(const char *addr_str);
 
 void get_default_gateway(struct route_gateway_info *rgi,
+                         in_addr_t dest,
                          openvpn_net_ctx_t *ctx);
 
 void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e4a7b57..6f78a76 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1990,7 +1990,7 @@
         {
             /* push mac addr */
             struct route_gateway_info rgi;
-            get_default_gateway(&rgi, session->opt->net_ctx);
+            get_default_gateway(&rgi, 0, session->opt->net_ctx);
             if (rgi.flags & RGI_HWADDR_DEFINED)
             {
                 buf_printf(&out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 33830fc..80f5dff 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -671,7 +671,7 @@
     struct route_gateway_info rgi;
     const unsigned int needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
 
-    get_default_gateway(&rgi, ctx);
+    get_default_gateway(&rgi, 0, ctx);
     if ((rgi.flags & needed) == needed)
     {
         const in_addr_t lan_network = rgi.gateway.addr & rgi.gateway.netmask;

