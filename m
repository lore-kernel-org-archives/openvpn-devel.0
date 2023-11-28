From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Nov 2023 12:14:47 +0100
Message-Id: <20231128111447.64445-1-frank@...2641...>
In-Reply-To: <gerrit.1700658573000.I66e3dd7b7166459526824fe5ae81a449b375b8db@...2715...>
References: <gerrit.1700658573000.I66e3dd7b7166459526824fe5ae81a449b375b8db@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Minimal Solaris/OpenIndiana support to
 Cmake and clean up -Werror
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

Change-Id: I66e3dd7b7166459526824fe5ae81a449b375b8db
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/458
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..c3a55ab 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -121,11 +121,17 @@
     set(TARGET_FREEBSD YES)
     set(ENABLE_DCO YES)
     link_libraries(-lnv)
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "SunOS")
+    set(TARGET_SOLARIS YES)
+    set(HAVE_SYS_SOCKIO_H 1)
+    link_libraries(-lnsl -lsocket -lresolv)
 elseif (WIN32)
     set(ENABLE_DCO YES)
 elseif (APPLE)
     set(TARGET_DARWIN YES)
     set(HAVE_NET_IF_UTUN_H YES)
+else()
+    message(FATAL_ERROR "Unknown system name: \"${CMAKE_SYSTEM_NAME}\"")
 endif ()
 
 if (UNIX)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..5b93fc5 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -336,7 +336,7 @@
 #cmakedefine HAVE_SYS_SOCKET_H
 
 /* Define to 1 if you have the <sys/sockio.h> header file. */
-#undef HAVE_SYS_SOCKIO_H
+#cmakedefine HAVE_SYS_SOCKIO_H
 
 /* Define to 1 if you have the <sys/stat.h> header file. */
 #define HAVE_SYS_STAT_H 1
@@ -443,6 +443,9 @@
 /* Are we running on Linux? */
 #cmakedefine TARGET_LINUX
 
+/* Are we running on Solaris/OpenIndiana? */
+#cmakedefine TARGET_SOLARIS
+
 /* Are we running WIN32? */
 #cmakedefine TARGET_WIN32
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ff64938..6cc112c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2342,12 +2342,11 @@
         return;
     }
 
-#ifndef _WIN32
+#if !defined(_WIN32)
 #if !defined(TARGET_LINUX)
     const char *gateway;
-#else
-    int metric;
 #endif
+#if !defined(TARGET_SOLARIS)
     bool gateway_needed = false;
     const char *device = tt->actual_name;
     if (r6->iface != NULL)              /* vpn server special route */
@@ -2365,6 +2364,7 @@
         gateway_needed = true;
     }
 #endif
+#endif
 
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
@@ -2395,7 +2395,7 @@
     msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
 
 #if defined(TARGET_LINUX)
-    metric = -1;
+    int metric = -1;
     if ((r6->flags & RT_METRIC_DEFINED) && (r6->metric > 0))
     {
         metric = r6->metric;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 82ab6c0..f1b8699 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1900,7 +1900,7 @@
 #endif
 
 
-#if !(defined(_WIN32) || defined(TARGET_LINUX))
+#if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
                  struct tuntap *tt)
@@ -2061,7 +2061,7 @@
 }
 #endif /* TARGET_LINUX || TARGET_FREEBSD*/
 
-#if !defined(_WIN32)
+#if !(defined(_WIN32) || defined(TARGET_SOLARIS))
 static void
 close_tun_generic(struct tuntap *tt)
 {
@@ -2398,13 +2398,12 @@
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    int if_fd, ip_muxid, arp_muxid, arp_fd, ppa = -1;
+    int if_fd = -1, ip_muxid = -1, arp_muxid = -1, arp_fd = -1, ppa = -1;
     struct lifreq ifr;
     const char *ptr;
-    const char *ip_node, *arp_node;
+    const char *ip_node = NULL, *arp_node = NULL;
     const char *dev_tuntap_type;
     int link_type;
-    bool is_tun;
     struct strioctl strioc_if, strioc_ppa;
 
     /* improved generic TUN/TAP driver from
@@ -2428,7 +2427,6 @@
         }
         dev_tuntap_type = "tun";
         link_type = I_PLINK;
-        is_tun = true;
     }
     else if (tt->type == DEV_TYPE_TAP)
     {
@@ -2440,7 +2438,6 @@
         arp_node = dev_node;
         dev_tuntap_type = "tap";
         link_type = I_PLINK; /* was: I_LINK */
-        is_tun = false;
     }
     else
     {

