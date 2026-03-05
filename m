From: Gert Doering <gert@...1296...>
Date: Thu,  5 Mar 2026 09:49:08 +0100
Message-ID: <20260305084914.1327-1-gert@...1296...>
In-Reply-To: <gerrit.1769789455000.I2b2a931e13670d753aa9570efe498647ba1a4a7f@...2715...>
References: <gerrit.1769789455000.I2b2a931e13670d753aa9570efe498647ba1a4a7f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] route: Fix type of rgi_needed variables
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

From: Frank Lichtenheld <frank@...2641...>

To avoid unneccesary sign-compare warnings.

Change-Id: I2b2a931e13670d753aa9570efe498647ba1a4a7f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1505
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1505
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 329f3b0..b196713 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -570,11 +570,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static void
 add_block_local_routes(struct route_list *rl)
 {
@@ -602,15 +597,11 @@
 bool
 block_local_needed(const struct route_list *rl)
 {
-    const int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
+    const unsigned int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
     return (rl->flags & RG_BLOCK_LOCAL) && (rl->rgi.flags & rgi_needed) == rgi_needed
            && (rl->spec.flags & RTSA_REMOTE_ENDPOINT) && rl->spec.remote_host_local != TLA_LOCAL;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 init_route_list(struct route_list *rl, const struct route_option_list *opt,
                 const char *remote_endpoint, int default_metric, in_addr_t remote_host,
@@ -1445,17 +1436,12 @@
 #define LR_MATCH   1 /* route is local */
 #define LR_ERROR   2 /* caller should abort adding route */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static int
 local_route(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
             const struct route_gateway_info *rgi)
 {
     /* set LR_MATCH on local host routes */
-    const int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | RGI_IFACE_DEFINED);
+    const unsigned int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | RGI_IFACE_DEFINED);
     if (rgi && (rgi->flags & rgi_needed) == rgi_needed && gateway == rgi->gateway.addr
         && netmask == 0xFFFFFFFF)
     {
@@ -1479,10 +1465,6 @@
     return LR_NOMATCH;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* Return true if the "on-link" form of the route should be used.  This is when the gateway for
  * a route is specified as an interface rather than an address. */
 #if defined(TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)

