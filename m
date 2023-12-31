From: Gert Doering <gert@...1296...>
Date: Sun, 31 Dec 2023 18:34:31 +0100
Message-ID: <20231231173431.31356-1-gert@...1296...>
In-Reply-To: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
References: <gerrit.1700582804000.Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Fix unaligned access in macOS, FreeBSD,
 Solaris hwaddr
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

From: Arne Schwabe <arne@...1227...>

The undefined behaviour USAN clang checker found this.

This fix is a bit messy but so are the original structures.

Since the API on Solaris/Illuminos does not return the AF_LINK
sockaddr type we are interested in, there is little value in
fixing the code on that platform to iterate through a list
that does not contain the element we are looking for.

Add includes stddef.h for offsetof and integer.h for max_int.

Change-Id: Ia797c8801fa9a9bc10b6674efde5fdbd7132e4a8
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/454
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6cc112c..0e6667f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -24,6 +24,7 @@
 /*
  * Support routines for adding/deleting network routes.
  */
+#include <stddef.h>
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
@@ -40,6 +41,7 @@
 #include "win32.h"
 #include "options.h"
 #include "networking.h"
+#include "integer.h"
 
 #include "memdbg.h"
 
@@ -3639,11 +3641,15 @@
         rgi->flags |= RGI_NETMASK_DEFINED;
     }
 
+#if !defined(TARGET_SOLARIS)
+    /* Illumos/Solaris does not provide AF_LINK entries when calling the
+     * SIOCGIFCONF API, so there is little sense to trying to figure out a
+     * MAC address from an API that does not provide that information */
+
     /* try to read MAC addr associated with interface that owns default gateway */
     if (rgi->flags & RGI_IFACE_DEFINED)
     {
         struct ifconf ifc;
-        struct ifreq *ifr;
         const int bufsize = 4096;
         char *buffer;
 
@@ -3668,22 +3674,50 @@
 
         for (cp = buffer; cp <= buffer + ifc.ifc_len - sizeof(struct ifreq); )
         {
-            ifr = (struct ifreq *)cp;
-#if defined(TARGET_SOLARIS)
-            const size_t len = sizeof(ifr->ifr_name) + sizeof(ifr->ifr_addr);
-#else
-            const size_t len = sizeof(ifr->ifr_name) + max(sizeof(ifr->ifr_addr), ifr->ifr_addr.sa_len);
-#endif
+            struct ifreq ifr = { 0 };
+            /* this is not always using an 8 byte alignment that struct ifr
+             * requires. Need to memcpy() to a strict ifr to force 8-byte
+             * alignment required for member access */
+            memcpy(&ifr, cp, sizeof(struct ifreq));
+            const size_t len = sizeof(ifr.ifr_name) + max(sizeof(ifr.ifr_addr), ifr.ifr_addr.sa_len);
 
-            if (!ifr->ifr_addr.sa_family)
+            if (!ifr.ifr_addr.sa_family)
             {
                 break;
             }
-            if (!strncmp(ifr->ifr_name, rgi->iface, IFNAMSIZ))
+            if (!strncmp(ifr.ifr_name, rgi->iface, IFNAMSIZ))
             {
-                if (ifr->ifr_addr.sa_family == AF_LINK)
+                if (ifr.ifr_addr.sa_family == AF_LINK)
                 {
-                    struct sockaddr_dl *sdl = (struct sockaddr_dl *)&ifr->ifr_addr;
+                    /* This is a confusing member access on multiple levels.
+                     *
+                     * struct sockaddr_dl is 20 bytes (on macOS and NetBSD,
+                     * larger on other BSDs) in size and has
+                     * 12 bytes space for the Ethernet interface name
+                     * (max 16 bytes) and  hw address (6 bytes)
+                     *
+                     * So if the interface name is more than 6 byte, the
+                     * location of hwaddr extends beyond the struct.
+                     *
+                     * This struct is embedded into ifreq that has
+                     * 16 bytes for a sockaddr and also expects this
+                     * struct to potentially extend beyond the bounds of
+                     * the struct.
+                     *
+                     * We only copied 32 bytes (size of ifr at least on macOS
+                     * might differ on other platforms again) from cp to ifr.
+                     *
+                     * But as hwaddr might extend but sdl might extend beyond
+                     * ifr's. So we need recalculate how large the actual size
+                     * of the embedded dl_sock actually is and then also need
+                     * to copy it since it also most likely does not have the
+                     * proper alignment required to access the struct.
+                     */
+                    const size_t sock_dl_len = max_int((int) (sizeof(struct sockaddr_dl)),
+                                                       (int) (ifr.ifr_addr.sa_len));
+
+                    struct sockaddr_dl *sdl = gc_malloc(sock_dl_len, true, &gc);
+                    memcpy(sdl, cp + offsetof(struct ifreq, ifr_addr), sock_dl_len);
                     memcpy(rgi->hwaddr, LLADDR(sdl), 6);
                     rgi->flags |= RGI_HWADDR_DEFINED;
                 }
@@ -3691,6 +3725,7 @@
             cp += len;
         }
     }
+#endif /* if !defined(TARGET_SOLARIS) */
 
 done:
     if (sockfd >= 0)

