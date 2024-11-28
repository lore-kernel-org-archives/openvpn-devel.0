From: Gert Doering <gert@...1296...>
Date: Thu, 28 Nov 2024 15:27:08 +0100
Message-ID: <20241128142708.14665-1-gert@...1296...>
In-Reply-To: <gerrit.1732799652000.I41eeae35ab23d9fb2512f33086f20f54c2d4f6df@...2715...>
References: <gerrit.1732799652000.I41eeae35ab23d9fb2512f33086f20f54c2d4f6df@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] macOS: Assume that net/if_utun.h is
 always present
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

Has been present in all releases since 10.7,
i.e. about 13 years ago. At this point the check
just makes the code uglier for no actual benefit.

Change-Id: I41eeae35ab23d9fb2512f33086f20f54c2d4f6df
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/823
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5db207d..ca58cd7 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -145,7 +145,6 @@
     set(ENABLE_DCO YES)
 elseif (APPLE)
     set(TARGET_DARWIN YES)
-    set(HAVE_NET_IF_UTUN_H YES)
 else()
     message(FATAL_ERROR "Unknown system name: \"${CMAKE_SYSTEM_NAME}\"")
 endif ()
@@ -223,7 +222,6 @@
 check_include_files(net/if.h HAVE_NET_IF_H)
 check_include_files("${NETEXTRA};netinet/ip.h" HAVE_NETINET_IP_H)
 check_include_files(arpa/inet.h HAVE_ARPA_INET_H)
-check_include_files(net/if_utun.h HAVE_NET_UTUN_H)
 check_include_files(sys/ioctl.h HAVE_SYS_IOCTL_H)
 check_include_files(sys/inotify.h HAVE_SYS_INOTIFY_H)
 check_include_files("${NETEXTRA};sys/uio.h" HAVE_SYS_UIO_H)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 18af5e9..3c517d7 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -202,9 +202,6 @@
 /* Define to 1 if you have the <net/if_tun.h> header file. */
 #cmakedefine HAVE_NET_IF_TUN_H
 
-/* Define to 1 if you have the <net/if_utun.h> header file. */
-#cmakedefine01 HAVE_NET_IF_UTUN_H
-
 /* Define to 1 if you have the <net/tun/if_tun.h> header file. */
 #cmakedefine HAVE_NET_TUN_IF_TUN_H
 
diff --git a/configure.ac b/configure.ac
index 7f6e43d..9777e36 100644
--- a/configure.ac
+++ b/configure.ac
@@ -502,7 +502,7 @@
 "
 
 AC_CHECK_HEADERS(
-	[net/if.h netinet/ip.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h],
+	[net/if.h netinet/ip.h resolv.h sys/un.h sys/kern_control.h],
 	,
 	,
 	[[${SOCKET_INCLUDES}]]
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 29d823d..c6b53a2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -437,7 +437,7 @@
 #include <stropts.h>
 #endif
 
-#if defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H
+#if defined(TARGET_DARWIN)
 #include <sys/kern_control.h>
 #include <net/if_utun.h>
 #include <sys/sys_domain.h>
@@ -1782,7 +1782,7 @@
 #endif
 }
 
-#if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H)
+#if defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)
 
 /*
  * OpenBSD and Mac OS X when using utun
@@ -1871,7 +1871,7 @@
         return read(tt->fd, buf, len);
     }
 }
-#endif /* if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H) */
+#endif /* if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
 
 bool
 tun_name_is_fixed(const char *dev)
@@ -3215,14 +3215,11 @@
  * (http://newosxbook.com/src.jl?tree=listings&file=17-15-utun.c)
  */
 
-#ifdef HAVE_NET_IF_UTUN_H
-
 /* Helper functions that tries to open utun device
- * return -2 on early initialization failures (utun not supported
- * at all (old OS X) and -1 on initlization failure of utun
- * device (utun works but utunX is already used */
-static
-int
+ * return -2 on early initialization failures (utun not supported
+ * at all) and -1 on initlization failure of utun
+ * device (utun works but utunX is already used) */
+static int
 utun_open_helper(struct ctl_info ctlInfo, int utunnum)
 {
     struct sockaddr_ctl sc;
@@ -3346,13 +3343,10 @@
     tt->backend_driver = DRIVER_UTUN;
 }
 
-#endif /* ifdef HAVE_NET_IF_UTUN_H */
-
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-#ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
     if ((!dev_node && tt->type==DEV_TYPE_TUN)
         || (dev_node && !strncmp(dev_node, "utun", 4)))
@@ -3387,7 +3381,6 @@
         }
     }
     else
-#endif /* ifdef HAVE_NET_IF_UTUN_H */
     {
 
         /* Use plain dev-node tun to select /dev/tun style
@@ -3431,27 +3424,27 @@
 int
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
-#ifdef HAVE_NET_IF_UTUN_H
     if (tt->backend_driver == DRIVER_UTUN)
     {
         return write_tun_header(tt, buf, len);
     }
     else
-#endif
-    return write(tt->fd, buf, len);
+    {
+        return write(tt->fd, buf, len);
+    }
 }
 
 int
 read_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
-#ifdef HAVE_NET_IF_UTUN_H
     if (tt->backend_driver == DRIVER_UTUN)
     {
         return read_tun_header(tt, buf, len);
     }
     else
-#endif
-    return read(tt->fd, buf, len);
+    {
+        return read(tt->fd, buf, len);
+    }
 }
 
 #elif defined(TARGET_AIX)

