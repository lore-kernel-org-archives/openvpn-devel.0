From: Gert Doering <gert@...1296...>
Date: Mon,  1 Jan 2024 10:27:14 +0100
Message-Id: <20240101092714.18992-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] get_default_gateway() HWADDR overhaul
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

commit f13331005d5a7 (gerrit/454) most painfully works around the limitations
of the SIOCGIFCONF API, with struct member access on an unaligned buffer,
possibly overrunning sockaddr structures, etc. - and the result still did
not work on OpenSolaris and OpenBSD (no AF_LINK in the returned elements).

Reading through OpenBSD "ifconfig" source, I found getifaddrs(3), which
is exactly what we want here - it works on FreeBSD, NetBSD, OpenBSD and
MacOS, and all returned pointers are properly aligned, so the code gets
shorter, easier to read, and UBSAN is still happy.

OpenSolaris does have getifaddrs(3), but (surprise) it does not work, as
in "it does not return AF_LINK addresses".  It does have SIOCGIFHWADDR,
instead, and "man if_tcp" claims "should behave in a manner compatible
with Linux" - so TARGET_SOLARIS gets a copy of the Linux code now (works).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 97 +++++++++++++++------------------------------
 1 file changed, 32 insertions(+), 65 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0e6667f7..f75199c6 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3445,6 +3445,9 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 #include <netinet/in.h>
 #include <net/route.h>
 #include <net/if_dl.h>
+#if !defined(TARGET_SOLARIS)
+#include <ifaddrs.h>
+#endif
 
 struct rtmsg {
     struct rt_msghdr m_rtm;
@@ -3641,19 +3644,11 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
         rgi->flags |= RGI_NETMASK_DEFINED;
     }
 
-#if !defined(TARGET_SOLARIS)
-    /* Illumos/Solaris does not provide AF_LINK entries when calling the
-     * SIOCGIFCONF API, so there is little sense to trying to figure out a
-     * MAC address from an API that does not provide that information */
-
     /* try to read MAC addr associated with interface that owns default gateway */
     if (rgi->flags & RGI_IFACE_DEFINED)
     {
-        struct ifconf ifc;
-        const int bufsize = 4096;
-        char *buffer;
-
-        buffer = (char *) gc_malloc(bufsize, true, &gc);
+#if defined(TARGET_SOLARIS)
+        /* OpenSolaris has a getifaddr() call, but it does not return AF_LINK */
         sockfd = socket(AF_INET, SOCK_DGRAM, 0);
         if (sockfd < 0)
         {
@@ -3661,71 +3656,43 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
             goto done;
         }
 
-        ifc.ifc_len = bufsize;
-        ifc.ifc_buf = buffer;
+        struct ifreq ifreq = { 0 };
+
+        /* now get the hardware address. */
+        strncpynt(ifreq.ifr_name, rgi->iface, sizeof(ifreq.ifr_name));
+        if (ioctl(sockfd, SIOCGIFHWADDR, &ifreq) < 0)
+        {
+            msg(M_WARN, "GDG: SIOCGIFHWADDR(%s) failed", ifreq.ifr_name);
+        }
+        else
+        {
+            memcpy(rgi->hwaddr, &ifreq.ifr_addr.sa_data, 6);
+            rgi->flags |= RGI_HWADDR_DEFINED;
+        }
+#else  /* if defined(TARGET_SOLARIS) */
+        struct ifaddrs *ifap, *ifa;
 
-        if (ioctl(sockfd, SIOCGIFCONF, (char *)&ifc) < 0)
+        if (getifaddrs(&ifap) != 0)
         {
-            msg(M_WARN, "GDG: ioctl #2 failed");
+            msg(M_WARN|M_ERRNO, "GDG: getifaddrs() failed");
             goto done;
         }
-        close(sockfd);
-        sockfd = -1;
 
-        for (cp = buffer; cp <= buffer + ifc.ifc_len - sizeof(struct ifreq); )
+        for (ifa = ifap; ifa; ifa = ifa->ifa_next)
         {
-            struct ifreq ifr = { 0 };
-            /* this is not always using an 8 byte alignment that struct ifr
-             * requires. Need to memcpy() to a strict ifr to force 8-byte
-             * alignment required for member access */
-            memcpy(&ifr, cp, sizeof(struct ifreq));
-            const size_t len = sizeof(ifr.ifr_name) + max(sizeof(ifr.ifr_addr), ifr.ifr_addr.sa_len);
-
-            if (!ifr.ifr_addr.sa_family)
-            {
-                break;
-            }
-            if (!strncmp(ifr.ifr_name, rgi->iface, IFNAMSIZ))
+            if (ifa->ifa_addr != NULL
+                && ifa->ifa_addr->sa_family == AF_LINK
+                && !strncmp(ifa->ifa_name, rgi->iface, IFNAMSIZ) )
             {
-                if (ifr.ifr_addr.sa_family == AF_LINK)
-                {
-                    /* This is a confusing member access on multiple levels.
-                     *
-                     * struct sockaddr_dl is 20 bytes (on macOS and NetBSD,
-                     * larger on other BSDs) in size and has
-                     * 12 bytes space for the Ethernet interface name
-                     * (max 16 bytes) and  hw address (6 bytes)
-                     *
-                     * So if the interface name is more than 6 byte, the
-                     * location of hwaddr extends beyond the struct.
-                     *
-                     * This struct is embedded into ifreq that has
-                     * 16 bytes for a sockaddr and also expects this
-                     * struct to potentially extend beyond the bounds of
-                     * the struct.
-                     *
-                     * We only copied 32 bytes (size of ifr at least on macOS
-                     * might differ on other platforms again) from cp to ifr.
-                     *
-                     * But as hwaddr might extend but sdl might extend beyond
-                     * ifr's. So we need recalculate how large the actual size
-                     * of the embedded dl_sock actually is and then also need
-                     * to copy it since it also most likely does not have the
-                     * proper alignment required to access the struct.
-                     */
-                    const size_t sock_dl_len = max_int((int) (sizeof(struct sockaddr_dl)),
-                                                       (int) (ifr.ifr_addr.sa_len));
-
-                    struct sockaddr_dl *sdl = gc_malloc(sock_dl_len, true, &gc);
-                    memcpy(sdl, cp + offsetof(struct ifreq, ifr_addr), sock_dl_len);
-                    memcpy(rgi->hwaddr, LLADDR(sdl), 6);
-                    rgi->flags |= RGI_HWADDR_DEFINED;
-                }
+                struct sockaddr_dl *sdl = (struct sockaddr_dl *)ifa->ifa_addr;
+                memcpy(rgi->hwaddr, LLADDR(sdl), 6);
+                rgi->flags |= RGI_HWADDR_DEFINED;
             }
-            cp += len;
         }
+
+        freeifaddrs(ifap);
+#endif /* if defined(TARGET_SOLARIS) */
     }
-#endif /* if !defined(TARGET_SOLARIS) */
 
 done:
     if (sockfd >= 0)
-- 
2.23.0


