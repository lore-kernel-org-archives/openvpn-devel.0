From: Antonio Quartulli <a@...2181...>
Date: Sun, 10 Nov 2019 13:44:07 +0100
Message-Id: <20191110124407.8734-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] get rid of 'broadcast' argument when
 configuring the tun device
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

The broadcast argument is actually useless as every platform will figure
it out and configure it on its own. We even realized that on linux, if
you configure it wrong, nothing wrong will happen.

At this point, let's make the code cleaner and let's get rid of this
useless argument at all.

This patch just removed any occurrence of 'broadcast'.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Tested on our buildbot rig and did not explode.


 src/openvpn/networking.h                   |  4 +--
 src/openvpn/networking_iproute2.c          |  8 ++---
 src/openvpn/networking_sitnl.c             | 40 +++++++--------------
 src/openvpn/tun.c                          | 42 ++++------------------
 src/openvpn/tun.h                          |  1 -
 tests/unit_tests/openvpn/test_networking.c | 16 +++------
 6 files changed, 27 insertions(+), 84 deletions(-)

diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 4075ed73..5e6d898f 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -110,13 +110,11 @@ int net_iface_mtu_set(openvpn_net_ctx_t *ctx,
  * @param iface     the interface where the address has to be added
  * @param addr      the address to add
  * @param prefixlen the prefix length of the network associated with the address
- * @param broadcast the broadcast address to configure on the interface
  *
  * @return          0 on success, a negative error code otherwise
  */
 int net_addr_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
-                    const in_addr_t *addr, int prefixlen,
-                    const in_addr_t *broadcast);
+                    const in_addr_t *addr, int prefixlen);
 
 /**
  * Add an IPv6 address to an interface
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 1ddeb5cf..1db39fc7 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -90,16 +90,14 @@ net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 
 int
 net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
-                const in_addr_t *addr, int prefixlen,
-                const in_addr_t *broadcast)
+                const in_addr_t *addr, int prefixlen)
 {
     struct argv argv = argv_new();
 
     const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
-    const char *brd_str = print_in_addr_t(*broadcast, 0, &ctx->gc);
 
-    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast %s", iproute_path,
-                iface, addr_str, prefixlen, brd_str);
+    argv_printf(&argv, "%s addr add dev %s %s/%d", iproute_path, iface,
+                addr_str, prefixlen);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index e5c48932..b93697e9 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -668,7 +668,7 @@ err:
 static int
 sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
                const inet_address_t *local, const inet_address_t *remote,
-               int prefixlen, const inet_address_t *broadcast)
+               int prefixlen)
 {
     struct sitnl_addr_req req;
     uint32_t size;
@@ -716,11 +716,6 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
         SITNL_ADDATTR(&req.n, sizeof(req), IFA_LOCAL, local, size);
     }
 
-    if (broadcast)
-    {
-        SITNL_ADDATTR(&req.n, sizeof(req), IFA_BROADCAST, broadcast, size);
-    }
-
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
     if ((ret < 0) && (errno == EEXIST))
     {
@@ -762,7 +757,7 @@ sitnl_addr_ptp_add(sa_family_t af_family, const char *iface,
     }
 
     return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
-                          af_family, local, remote, 0, NULL);
+                          af_family, local, remote, 0);
 }
 
 static int
@@ -794,8 +789,7 @@ sitnl_addr_ptp_del(sa_family_t af_family, const char *iface,
         return -ENOENT;
     }
 
-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0,
-                          NULL);
+    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0);
 }
 
 static int
@@ -874,8 +868,7 @@ err:
 
 static int
 sitnl_addr_add(sa_family_t af_family, const char *iface,
-               const inet_address_t *addr, int prefixlen,
-               const inet_address_t *broadcast)
+               const inet_address_t *addr, int prefixlen)
 {
     int ifindex;
 
@@ -904,7 +897,7 @@ sitnl_addr_add(sa_family_t af_family, const char *iface,
     }
 
     return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex,
-                          af_family, addr, NULL, prefixlen, broadcast);
+                          af_family, addr, NULL, prefixlen);
 }
 
 static int
@@ -938,18 +931,15 @@ sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr,
     }
 
     return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL,
-                          prefixlen, NULL);
+                          prefixlen);
 }
 
 int
 net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
-                const in_addr_t *addr, int prefixlen,
-                const in_addr_t *broadcast)
+                const in_addr_t *addr, int prefixlen)
 {
     inet_address_t addr_v4 = { 0 };
-    inet_address_t brd_v4 = { 0 };
-    char buf1[INET_ADDRSTRLEN];
-    char buf2[INET_ADDRSTRLEN];
+    char buf[INET_ADDRSTRLEN];
 
     if (!addr)
     {
@@ -958,16 +948,10 @@ net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
 
     addr_v4.ipv4 = htonl(*addr);
 
-    if (broadcast)
-    {
-        brd_v4.ipv4 = htonl(*broadcast);
-    }
-
-    msg(M_INFO, "%s: %s/%d brd %s dev %s", __func__,
-        inet_ntop(AF_INET, &addr_v4.ipv4, buf1, sizeof(buf1)), prefixlen,
-        inet_ntop(AF_INET, &brd_v4.ipv4, buf2, sizeof(buf2)), iface);
+    msg(M_INFO, "%s: %s/%d dev %s", __func__,
+        inet_ntop(AF_INET, &addr_v4.ipv4, buf, sizeof(buf)), prefixlen,iface);
 
-    return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen, &brd_v4);
+    return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen);
 }
 
 int
@@ -987,7 +971,7 @@ net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
     msg(M_INFO, "%s: %s/%d dev %s", __func__,
         inet_ntop(AF_INET6, &addr_v6.ipv6, buf, sizeof(buf)), prefixlen, iface);
 
-    return sitnl_addr_add(AF_INET6, iface, &addr_v6, prefixlen, NULL);
+    return sitnl_addr_add(AF_INET6, iface, &addr_v6, prefixlen);
 }
 
 int
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 37bf065b..599fd817 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -337,16 +337,6 @@ ifconfig_sanity_check(bool tun, in_addr_t addr, int topology)
     gc_free(&gc);
 }
 
-/*
- * For TAP-style devices, generate a broadcast address.
- */
-static in_addr_t
-generate_ifconfig_broadcast_addr(in_addr_t local,
-                                 in_addr_t netmask)
-{
-    return local | ~netmask;
-}
-
 /*
  * Check that --local and --remote addresses do not
  * clash with ifconfig addresses or subnet.
@@ -598,9 +588,7 @@ do_ifconfig_setenv(const struct tuntap *tt, struct env_set *es)
         }
         else
         {
-            const char *ifconfig_broadcast = print_in_addr_t(tt->broadcast, 0, &gc);
             setenv_str(es, "ifconfig_netmask", ifconfig_remote_netmask);
-            setenv_str(es, "ifconfig_broadcast", ifconfig_broadcast);
         }
     }
 
@@ -727,14 +715,6 @@ init_tun(const char *dev,        /* --dev option */
             }
         }
 
-        /*
-         * If TAP-style interface, generate broadcast address.
-         */
-        if (!tun)
-        {
-            tt->broadcast = generate_ifconfig_broadcast_addr(tt->local, tt->remote_netmask);
-        }
-
 #ifdef _WIN32
         /*
          * Make sure that both ifconfig addresses are part of the
@@ -1052,7 +1032,6 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
 #if !defined(TARGET_LINUX)
     const char *ifconfig_local = NULL;
     const char *ifconfig_remote_netmask = NULL;
-    const char *ifconfig_broadcast = NULL;
     struct argv argv = argv_new();
     struct gc_arena gc = gc_new();
 
@@ -1061,14 +1040,6 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
      */
     ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
     ifconfig_remote_netmask = print_in_addr_t(tt->remote_netmask, 0, &gc);
-
-    /*
-     * If TAP-style device, generate broadcast address.
-     */
-    if (!tun)
-    {
-        ifconfig_broadcast = print_in_addr_t(tt->broadcast, 0, &gc);
-    }
 #endif
 
 #if defined(TARGET_LINUX)
@@ -1093,8 +1064,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     else
     {
         if (net_addr_v4_add(ctx, ifname, &tt->local,
-                            netmask_to_netbits2(tt->remote_netmask),
-                            &tt->remote_netmask) < 0)
+                            netmask_to_netbits2(tt->remote_netmask)) < 0)
         {
             msg(M_FATAL, "Linux can't add IP to TAP interface %s", ifname);
         }
@@ -1153,7 +1123,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     }
     else
     {
-        argv_printf(&argv, "%s %s %s netmask %s broadcast + up",
+        argv_printf(&argv, "%s %s %s netmask %s up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     ifconfig_remote_netmask);
     }
@@ -1205,9 +1175,9 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     }
     else
     {
-        argv_printf(&argv, "%s %s %s netmask %s mtu %d broadcast %s link0",
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu, ifconfig_broadcast);
+                    ifconfig_remote_netmask, tun_mtu);
     }
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");
@@ -1247,9 +1217,9 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
          * so we don't need the "link0" extra parameter to specify we want to do
          * tunneling at the ethernet level
          */
-        argv_printf(&argv, "%s %s %s netmask %s mtu %d broadcast %s",
+        argv_printf(&argv, "%s %s %s netmask %s mtu %d",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu, ifconfig_broadcast);
+                    ifconfig_remote_netmask, tun_mtu);
     }
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 19cab7ea..66b75d93 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -158,7 +158,6 @@ struct tuntap
     /* ifconfig parameters */
     in_addr_t local;
     in_addr_t remote_netmask;
-    in_addr_t broadcast;
 
     struct in6_addr local_ipv6;
     struct in6_addr remote_ipv6;
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 22d8babe..2d37d6e1 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -22,26 +22,20 @@ net__iface_mtu_set(int mtu)
 }
 
 static int
-net__addr_v4_add(const char *addr_str, int prefixlen, const char *brd_str)
+net__addr_v4_add(const char *addr_str, int prefixlen)
 {
-    in_addr_t addr, brd;
+    in_addr_t addr;
     int ret;
 
     ret = inet_pton(AF_INET, addr_str, &addr);
     if (ret != 1)
         return -1;
 
-    ret = inet_pton(AF_INET, brd_str, &brd);
-    if (ret != 1)
-        return -1;
-
     addr = ntohl(addr);
-    brd = ntohl(brd);
 
-    printf("CMD: ip addr add %s/%d brd %s dev %s\n", addr_str, prefixlen,
-           brd_str, iface);
+    printf("CMD: ip addr add %s/%d dev %s\n", addr_str, prefixlen, iface);
 
-    return net_addr_v4_add(NULL, iface, &addr, prefixlen, &brd);
+    return net_addr_v4_add(NULL, iface, &addr, prefixlen);
 }
 
 static int
@@ -198,7 +192,7 @@ main(int argc, char *argv[])
         case 1:
             return net__iface_mtu_set(1281);
         case 2:
-            return net__addr_v4_add("10.255.255.1", 24, "10.255.255.255");
+            return net__addr_v4_add("10.255.255.1", 24);
         case 3:
             return net__addr_v6_add("2001::1", 64);
         case 4:
-- 
2.24.0


