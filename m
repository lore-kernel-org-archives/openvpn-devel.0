Date: Tue, 26 Nov 2024 14:26:59 +0000
From: Alexander von Gluck <alex@...2837...>
Message-ID: <20241126142639.67446-2-alex@...2837...>
In-Reply-To: <20241126142639.67446-1-alex@...2837...>
References: <20241126142639.67446-1-alex@...2837...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------e1475470d6a9c9337d97ed22113c21c3ac39719356f5da3697b66a51dfcad031";
 charset=utf-8
Subject: [Openvpn-devel] [PATCH 2/2] Haiku: Pull in routing table to get
 default route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e1475470d6a9c9337d97ed22113c21c3ac39719356f5da3697b66a51dfcad031
From: Alexander von Gluck <alex@...2837...>
To: openvpn-devel@lists.sourceforge.net
Cc: Alexander von Gluck <alex@...2837...>
Subject: [PATCH 2/2] Haiku: Pull in routing table to get default route
Date: Tue, 26 Nov 2024 08:26:39 -0600
Message-ID: <20241126142639.67446-2-alex@...2837...>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241126142639.67446-1-alex@...2837...>
References: <20241126142639.67446-1-alex@...2837...>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

---
 src/openvpn/route.c | 109 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index fa20d08f..8d319123 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -54,6 +54,12 @@
 #include <net/route.h>                  /* RT_ROUNDUP(), RT_ADVANCE() */
 #endif
 
+#if defined(TARGET_HAIKU)
+#include <SupportDefs.h>    /* uint32, etc */
+#include <net/if.h>         /* ifconf etc */
+#include <sys/sockio.h>     /* SIOCGRTTABLE, etc */
+#endif /* TARGET_HAIKU */
+
 #ifdef _WIN32
 #include "openvpn-msg.h"
 
@@ -1857,14 +1863,16 @@ add_route(struct route_ipv4 *r,
 
     {
         /* ex: route add /dev/net/ipro1000/0 default gw 192.168.1.1 netmask 255.255.255.0 */
-        argv_printf(&argv, "route add %s inet default gw %s netmask %s",
+        argv_printf(&argv, "%s add %s inet %s gw %s netmask %s",
+                    ROUTE_PATH,
                     rgi-
>iface,
+                    network,
                     gateway,
                     netmask);
 
         argv_msg(D_ROUTE, &argv);
         bool ret = openvpn_execve_check(&argv, es, 0,
-                                        "ERROR: Haiku route add command failed");
+                                        "ERROR: Haiku inet route add command failed");
         status = ret ? RTA_SUCCESS : RTA_ERROR;
     }
 
@@ -2344,6 +2352,21 @@ delete_route(struct route_ipv4 *r,
         openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete command failed");
     }
 
+#elif defined(TARGET_HAIKU)
+
+    {
+        // route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0
+        argv_printf(&argv, "%s del %s inet %s gw %s netmask %s",
+                    ROUTE_PATH,
+                    rgi->iface,
+                    network,
+                    gateway,
+                    netmask);
+
+        argv_msg(D_ROUTE, &argv);
+     
   openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet route delete command failed");
+    }
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
@@ -2523,6 +2546,19 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
         "needed. The VpnService API allows routes to be set "
         "on connect only and will clean up automatically.");
+#elif defined(TARGET_HAIKU)
+    {
+        argv_printf(&argv, "%s del %s inet6 %s gw %s prefixlen %d",
+                    ROUTE_PATH,
+                    r6->iface,
+                    network,
+                    gateway,
+                    r6->netbits);
+
+        argv_msg(D_ROUTE, &argv);
+        openvpn_execve_check(&argv, es, 0, "ERROR: Haiku inet
6 route delete command failed");
+
+    }
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
 #endif /* if defined(TARGET_LINUX) */
@@ -3460,6 +3496,75 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     }
 }
 
+#elif defined(TARGET_HAIKU)
+
+void
+get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
+{
+    CLEAR(*rgi);
+
+    int sockfd = -1;
+    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
+    if (sockfd < 0) {
+        msg(M_INFO, "%s: Error opening socket for AF_INET", __func__);
+        return;
+    }
+
+    struct ifconf config;
+    config.ifc_len = sizeof(config.ifc_value);
+    if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct ifconf)) < 0) {
+        msg(M_INFO, "%s: Error getting routing table size", __func__);
+        return;
+    }
+
+    uint32 size = (uin
t32)config.ifc_value;
+    if (size == 0)
+        return;
+
+    void *buffer = malloc(size);
+    if (buffer == NULL) {
+        fprintf(stderr, "%s: Out of memory.\n", __func__);
+        return;
+    }
+
+    config.ifc_len = size;
+    config.ifc_buf = buffer;
+    if (ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct ifconf)) < 0)
+        return;
+
+    struct ifreq *interface = (struct ifreq*)buffer;
+    struct ifreq *end = (struct ifreq*)((uint8*)buffer + size);
+
+    while (interface < end) {
+        struct route_entry route = interface->ifr_route;
+        if ((route.flags & RTF_GATEWAY) != 0 && (route.flags & RTF_DEFAULT) != 0) {
+            //msg(M_INFO, "%s: FOUND DEFAULT GATEWAY ON %s", __func__, interface->ifr_name);
+            rgi->gateway.addr = ntohl(((struct sockaddr_in *)route.gateway)->sin_addr.s_addr);
+            rgi->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+            strcpy(rgi->iface, interface->ifr_name);
+        }
+

+        int32 addressSize = 0;
+        if (route.destination != NULL)
+            addressSize += route.destination->sa_len;
+        if (route.mask != NULL)
+            addressSize += route.mask->sa_len;
+        if (route.gateway != NULL)
+            addressSize += route.gateway->sa_len;
+
+        interface = (struct ifreq*)((addr_t)interface + IF_NAMESIZE
+          + sizeof(struct route_entry) + addressSize);
+    }
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
 #elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS)    \
     || defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)    \
     || defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
-- 
2.47.1


--------e1475470d6a9c9337d97ed22113c21c3ac39719356f5da3697b66a51dfcad031
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmdF2rIJEAcdh4cOBuc9FiEE1fDK75YVVUznKdb2Bx2Hhw4G
5z0AANVIAQDtIdFyr2zjhf2NjBqG0u8pP10/q5fQLVxP4p48zT5LzgEA0Ytq
bu+1pmSTTfu3r8/lqXXthawT8r3Vcl2W6zjm9gw=
=QvMI
-----END PGP SIGNATURE-----


--------e1475470d6a9c9337d97ed22113c21c3ac39719356f5da3697b66a51dfcad031--


