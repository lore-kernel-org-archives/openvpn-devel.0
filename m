From: Arne Schwabe <arne@...1227...>
Date: Mon, 12 Aug 2019 15:45:13 +0200
Message-Id: <20190812134513.20758-2-arne@...1227...>
In-Reply-To: <20190812134513.20758-1-arne@...1227...>
References: <20190812134513.20758-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/2] Adjust Android code after sitnl patch
 merge
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

It turns out that the only part of Android that still shares routing
code with Linux is the get_default_ipv6 method.

Instead of fixing a method that makes little sense on Android anyway,
have a method that returns a fake ipv6 gateway like for ipv4.
---
 src/openvpn/route.c | 66 ++++++++++++++++++++++++++++++---------------
 src/openvpn/tun.c   |  9 +++++--
 2 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a302746e..9af88f00 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1065,7 +1065,8 @@ redirect_default_route_to_vpn(struct route_list *rl, const struct tuntap *tt,
                             tt,
                             flags,
                             &rl->rgi,
-                            es);
+                            es,
+                            ctx);
 
 #else
                 if (rl->flags & RG_DEF1)
@@ -3169,7 +3170,48 @@ show_routes(int msglev)
     gc_free(&gc);
 }
 
-#elif defined(TARGET_LINUX) || defined(TARGET_ANDROID)
+#elif defined(TARGET_ANDROID)
+
+void
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+{
+    /* Android, set some pseudo GW, addr is in host byte order,
+     * Determining the default GW on Android 5.0+ is non trivial
+     * and serves almost no purpose since OpenVPN only uses the
+     * default GW address to add routes for networks that should
+     * NOT be routed over the VPN. Using a well known address
+     * (127.'d'.'g'.'w') for the default GW make detecting
+     * these routes easier from the controlling app.
+     */
+    CLEAR(*rgi);
+
+    rgi->gateway.addr = 127 << 24 | 'd' << 16 | 'g' << 8 | 'w';
+    rgi->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+    strcpy(rgi->iface, "android-gw");
+
+    /* Skip scanning/fetching interface from loopback interface we do
+     * normally on Linux.
+     * It always fails and "ioctl(SIOCGIFCONF) failed" confuses users
+     */
+
+}
+
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
+{
+    /* Same for ipv6 */
+
+    CLEAR(*rgi6);
+
+    /* Use a fake link-local address */
+    ASSERT(inet_pton(AF_INET6, "fe80::ad", &rgi6->addrs->addr_ipv6) == 1);
+    rgi6->addrs->netbits_ipv6 = 64;
+    rgi6->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+    strcpy(rgi6->iface, "android-gw");
+}
+
+#elif defined(TARGET_LINUX)
 
 void
 get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
@@ -3181,7 +3223,6 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
     CLEAR(*rgi);
     CLEAR(best_name);
 
-#ifndef TARGET_ANDROID
     /* get default gateway IP addr */
     if (net_route_v4_best_gw(ctx, NULL, &rgi->gateway.addr, best_name) == 0)
     {
@@ -3191,25 +3232,6 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
             rgi->flags |= RGI_ON_LINK;
         }
     }
-#else  /* ifndef TARGET_ANDROID */
-    /* Android, set some pseudo GW, addr is in host byte order,
-     * Determining the default GW on Android 5.0+ is non trivial
-     * and serves almost no purpose since OpenVPN only uses the
-     * default GW address to add routes for networks that should
-     * NOT be routed over the VPN. Using a well known address
-     * (127.'d'.'g'.'w') for the default GW make detecting
-     * these routes easier from the controlling app.
-     */
-    rgi->gateway.addr = 127 << 24 | 'd' << 16 | 'g' << 8 | 'w';
-    rgi->flags |= RGI_ADDR_DEFINED;
-    strcpy(best_name, "android-gw");
-
-    /*
-     * Skip scanning/fetching interface from loopback interface
-     * It always fails and "ioctl(SIOCGIFCONF) failed" confuses users
-     */
-    goto done;
-#endif /* ifndef TARGET_ANDROID */
 
     /* scan adapter list */
     if (rgi->flags & RGI_ADDR_DEFINED)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8f8f7c6c..1db459f8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -906,9 +906,13 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
 #elif defined(TARGET_ANDROID)
     char out6[64];
 
+    const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, NULL);
     openvpn_snprintf(out6, sizeof(out6), "%s/%d %d",
-                     ifconfig_ipv6_local,tt->netbits_ipv6, tun_mtu);
+                     ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+
     management_android_control(management, "IFCONFIG6", out6);
+
+    free(ifconfig_ipv6_local);
 #elif defined(TARGET_SOLARIS)
     argv_printf(&argv, "%s %s inet6 unplumb", IFCONFIG_PATH, ifname);
     argv_msg(M_INFO, &argv);
@@ -1045,7 +1049,8 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
 #if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
     || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
     || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
-    || defined(TARGET_SOLARIS) || defined(_WIN32)
+    || defined(TARGET_SOLARIS) || defined(_WIN32) \
+    || defined(TARGET_ANDROID)
     const char *ifconfig_local = NULL;
     const char *ifconfig_remote_netmask = NULL;
     const char *ifconfig_broadcast = NULL;
-- 
2.22.0


