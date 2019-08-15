From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Aug 2019 14:10:53 +0200
Message-Id: <20190815121053.18433-2-arne@...1227...>
In-Reply-To: <20190815121053.18433-1-arne@...1227...>
References: <20190812134513.20758-1-arne@...1227...>
 <20190815121053.18433-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/2] Adjust Android code after sitnl
 patch merge
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

Patch V2: Instead adding ANDROID to a long list of ifdefs, change this
	to a non LINUX ifdef

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/route.c | 63 ++++++++++++++++++++++++++++++---------------
 src/openvpn/tun.c   | 22 ++++------------
 2 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 1b5eacea..165fce92 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3170,7 +3170,48 @@ show_routes(int msglev)
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
@@ -3182,7 +3223,6 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
     CLEAR(*rgi);
     CLEAR(best_name);
 
-#ifndef TARGET_ANDROID
     /* get default gateway IP addr */
     if (net_route_v4_best_gw(ctx, NULL, &rgi->gateway.addr, best_name) == 0)
     {
@@ -3192,25 +3232,6 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
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
index 8f8f7c6c..d4735640 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -878,10 +878,7 @@ static void
 do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
                  const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
-    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
-    || defined(TARGET_SOLARIS) || defined(_WIN32)
+#if !defined(TARGET_LINUX)
     struct argv argv = argv_new();
     struct gc_arena gc = gc_new();
     const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
@@ -907,7 +904,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     char out6[64];
 
     openvpn_snprintf(out6, sizeof(out6), "%s/%d %d",
-                     ifconfig_ipv6_local,tt->netbits_ipv6, tun_mtu);
+                     ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
     management_android_control(management, "IFCONFIG6", out6);
 #elif defined(TARGET_SOLARIS)
     argv_printf(&argv, "%s %s inet6 unplumb", IFCONFIG_PATH, ifname);
@@ -1015,10 +1012,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* outer "if defined(TARGET_xxx)" conditional */
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
-    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
-    || defined(TARGET_SOLARIS) || defined(_WIN32)
+#if !defined(TARGET_LINUX)
     gc_free(&gc);
     argv_reset(&argv);
 #endif
@@ -1042,10 +1036,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
      */
     bool tun = is_tun_p2p(tt);
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
-    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
-    || defined(TARGET_SOLARIS) || defined(_WIN32)
+#if !defined(TARGET_LINUX)
     const char *ifconfig_local = NULL;
     const char *ifconfig_remote_netmask = NULL;
     const char *ifconfig_broadcast = NULL;
@@ -1396,10 +1387,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
-    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX) \
-    || defined(TARGET_SOLARIS) || defined(_WIN32)
+#if !defined(TARGET_LINUX)
     gc_free(&gc);
     argv_reset(&argv);
 #endif
-- 
2.22.0


