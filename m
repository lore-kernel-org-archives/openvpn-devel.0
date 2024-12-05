From: Gert Doering <gert@...1296...>
Date: Thu,  5 Dec 2024 18:24:59 +0100
Message-ID: <20241205172459.4783-1-gert@...1296...>
In-Reply-To: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
References: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Haiku: Add calls to manage routing table
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

From: Alexander von Gluck <alex@...2837...>

Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Gert Doering <gert@...1296...>
Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/688
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2e584c7..42108f3 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1853,7 +1853,21 @@
         status = ret ? RTA_SUCCESS : RTA_ERROR;
     }
 
-#else  /* if defined(TARGET_LINUX) */
+#elif defined(TARGET_HAIKU)
+
+    /* ex: route add /dev/net/ipro1000/0 0.0.0.0 gw 192.168.1.1 netmask 128.0.0.0 */
+    argv_printf(&argv, "%s add %s inet %s gw %s netmask %s",
+                ROUTE_PATH,
+                rgi->iface,
+                network,
+                gateway,
+                netmask);
+    argv_msg(D_ROUTE, &argv);
+    bool ret = openvpn_execve_check(&argv, es, 0,
+                                    "ERROR: Haiku inet route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
+
+#else /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
@@ -2126,6 +2140,20 @@
                                     "ERROR: AIX route add command failed");
     status = ret ? RTA_SUCCESS : RTA_ERROR;
 
+#elif defined(TARGET_HAIKU)
+
+    /* ex: route add /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */
+    argv_printf(&argv, "%s add %s inet6 %s gw %s prefixlen %d",
+                ROUTE_PATH,
+                r6->iface,
+                network,
+                gateway,
+                r6->netbits);
+    argv_msg(D_ROUTE, &argv);
+    bool ret = openvpn_execve_check(&argv, es, 0,
+                                    "ERROR: Haiku inet6 route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
@@ -2329,6 +2357,18 @@
         openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete command failed");
     }
 
+#elif defined(TARGET_HAIKU)
+
+    /* ex: route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0 */
+    argv_printf(&argv, "%s del %s inet %s gw %s netmask %s",
+                ROUTE_PATH,
+                rgi->iface,
+                network,
+                gateway,
+                netmask);
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route delete command failed");
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
@@ -2504,10 +2544,23 @@
                 network, r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+
 #elif defined(TARGET_ANDROID)
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
         "needed. The VpnService API allows routes to be set "
         "on connect only and will clean up automatically.");
+#elif defined(TARGET_HAIKU)
+
+    /* ex: route del /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */
+    argv_printf(&argv, "%s del %s inet6 %s gw %s prefixlen %d",
+                ROUTE_PATH,
+                r6->iface,
+                network,
+                gateway,
+                r6->netbits);
+    argv_msg(D_ROUTE, &argv);
+    openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet6 route delete command failed");
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
 #endif /* if defined(TARGET_LINUX) */
@@ -3886,6 +3939,86 @@
 
 #undef max
 
+#elif defined(TARGET_HAIKU)
+
+void
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+{
+    CLEAR(*rgi);
+
+    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+    if (sockfd < 0)
+    {
+        msg(M_ERRNO, "%s: Error opening socket for AF_INET", __func__);
+        return;
+    }
+
+    struct ifconf config;
+    config.ifc_len = sizeof(config.ifc_value);
+    if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0)
+    {
+        msg(M_ERRNO, "%s: Error getting routing table size", __func__);
+        return;
+    }
+
+    uint32 size = (uint32)config.ifc_value;
+    if (size == 0)
+    {
+        return;
+    }
+
+    void *buffer = malloc(size);
+    check_malloc_return(buffer);
+
+    config.ifc_len = size;
+    config.ifc_buf = buffer;
+    if (ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct ifconf)) < 0)
+    {
+        free(buffer);
+        return;
+    }
+
+    struct ifreq *interface = (struct ifreq*)buffer;
+    struct ifreq *end = (struct ifreq*)((uint8*)buffer + size);
+
+    while (interface < end)
+    {
+        struct route_entry route = interface->ifr_route;
+        if ((route.flags & RTF_GATEWAY) != 0 && (route.flags & RTF_DEFAULT) != 0)
+        {
+            rgi->gateway.addr = ntohl(((struct sockaddr_in *)route.gateway)->sin_addr.s_addr);
+            rgi->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+            strncpy(rgi->iface, interface->ifr_name, sizeof(rgi->iface));
+        }
+
+        int32 address_size = 0;
+        if (route.destination != NULL)
+        {
+            address_size += route.destination->sa_len;
+        }
+        if (route.mask != NULL)
+        {
+            address_size += route.mask->sa_len;
+        }
+        if (route.gateway != NULL)
+        {
+            address_size += route.gateway->sa_len;
+        }
+
+        interface = (struct ifreq*)((addr_t)interface + IF_NAMESIZE
+            + sizeof(struct route_entry) + address_size);
+    }
+    free(buffer);
+}
+
+void
+get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
+                         const struct in6_addr *dest, openvpn_net_ctx_t *ctx)
+{
+    /* TODO: Same for ipv6 with AF_INET6 */
+    CLEAR(*rgi6);
+}
+
 #else  /* if defined(_WIN32) */
 
 /*
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 33a90c1..844e47a 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -166,6 +166,12 @@
 #include <string.h>
 #endif
 
+#if defined(TARGET_HAIKU)
+#include <SupportDefs.h>   /* uint32, etc */
+#include <net/if.h>        /* ifconf etc */
+#include <sys/sockio.h>    /* SIOCGRTTABLE, etc */
+#endif /* TARGET_HAIKU */
+
 #ifdef HAVE_ARPA_INET_H
 #include <arpa/inet.h>
 #endif

