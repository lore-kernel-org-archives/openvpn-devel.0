From: selva.nair@...277...
Date: Fri, 13 Jan 2023 18:57:53 -0500
Message-Id: <20230113235754.1942385-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Define and use macros for route
 addition status code
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

From: Selva Nair <selva.nair@...277...>

- Instead of 0, 1, 2 use RTA_ERROR, RTA_SUCCESS, RTA_EEXIST
  as the return code of route addition functions.

- Also fix a logging error: status -> (status == RTA_SUCCESS)

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c | 106 ++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 21dce6af..fe5cda2a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -96,6 +96,11 @@ print_bypass_addresses(const struct route_bypass *rb)
 
 #endif
 
+/* Route addition return status codes */
+#define RTA_ERROR   0   /* route addition failed */
+#define RTA_SUCCESS 1   /* route addition succeeded */
+#define RTA_EEXIST  2   /* route not added as it already exists */
+
 static bool
 add_bypass_address(struct route_bypass *rb, const in_addr_t a)
 {
@@ -1593,12 +1598,12 @@ add_route(struct route_ipv4 *r,
         metric = r->metric;
     }
 
-    status = 1;
+    status = RTA_SUCCESS;
     if (net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask),
                          &r->gateway, iface, 0, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route add command failed");
-        status = 0;
+        status = RTA_ERROR;
     }
 
 #elif defined (TARGET_ANDROID)
@@ -1612,7 +1617,7 @@ add_route(struct route_ipv4 *r,
     {
         openvpn_snprintf(out, sizeof(out), "%s %s %s", network, netmask, gateway);
     }
-    status = management_android_control(management, "ROUTE", out);
+    status = management_android_control(management, "ROUTE", out) ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined (_WIN32)
     {
@@ -1638,12 +1643,12 @@ add_route(struct route_ipv4 *r,
         if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_SERVICE)
         {
             status = add_route_service(r, tt);
-            msg(D_ROUTE, "Route addition via service %s", (status == 1) ? "succeeded" : "failed");
+            msg(D_ROUTE, "Route addition via service %s", (status == RTA_SUCCESS) ? "succeeded" : "failed");
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s", (status == 1) ? "succeeded" : "failed");
+            msg(D_ROUTE, "Route addition via IPAPI %s", (status == RTA_SUCCESS) ? "succeeded" : "failed");
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
         {
@@ -1654,8 +1659,8 @@ add_route(struct route_ipv4 *r,
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s [adaptive]", (status == 1) ? "succeeded" : "failed");
-            if (status == 0)
+            msg(D_ROUTE, "Route addition via IPAPI %s [adaptive]", (status == RTA_SUCCESS) ? "succeeded" : "failed");
+            if (status == RTA_ERROR)
             {
                 msg(D_ROUTE, "Route addition fallback to route.exe");
                 netcmd_semaphore_lock();
@@ -1694,7 +1699,8 @@ add_route(struct route_ipv4 *r,
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route add command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_FREEBSD)
 
@@ -1716,7 +1722,8 @@ add_route(struct route_ipv4 *r,
     /* FIXME -- add on-link support for FreeBSD */
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route add command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_DRAGONFLY)
 
@@ -1738,7 +1745,8 @@ add_route(struct route_ipv4 *r,
     /* FIXME -- add on-link support for Dragonfly */
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route add command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: DragonFly route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_DARWIN)
 
@@ -1770,7 +1778,8 @@ add_route(struct route_ipv4 *r,
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: OS X route add command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: OS X route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
@@ -1792,7 +1801,8 @@ add_route(struct route_ipv4 *r,
     /* FIXME -- add on-link support for OpenBSD/NetBSD */
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route add command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_AIX)
 
@@ -1802,7 +1812,8 @@ add_route(struct route_ipv4 *r,
                     ROUTE_PATH,
                     network, netbits, gateway);
         argv_msg(D_ROUTE, &argv);
-        status = openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+        bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+        status = ret ? RTA_SUCCESS : RTA_ERROR;
     }
 
 #else  /* if defined(TARGET_LINUX) */
@@ -1810,7 +1821,7 @@ add_route(struct route_ipv4 *r,
 #endif /* if defined(TARGET_LINUX) */
 
 done:
-    if (status == 1)
+    if (status == RTA_SUCCESS)
     {
         r->flags |= RT_ADDED;
     }
@@ -1823,7 +1834,7 @@ done:
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
 
-    return (status != 0);
+    return (status != RTA_ERROR);
 }
 
 
@@ -1937,13 +1948,13 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
         metric = r6->metric;
     }
 
-    status = 1;
+    status = RTA_SUCCESS;
     if (net_route_v6_add(ctx, &r6->network, r6->netbits,
                          gateway_needed ? &r6->gateway : NULL, device, 0,
                          metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux IPv6 route can't be added");
-        status = 0;
+        status = RTA_ERROR;
     }
 
 #elif defined (TARGET_ANDROID)
@@ -1989,7 +2000,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route add -inet6 command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: Solaris route add -inet6 command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
 
@@ -2008,7 +2020,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route add -inet6 command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: *BSD route add -inet6 command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_DARWIN)
 
@@ -2026,7 +2039,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     }
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route add -inet6 command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: MacOS X route add -inet6 command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_OPENBSD)
 
@@ -2035,7 +2049,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                 network, r6->netbits, gateway );
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD route add -inet6 command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD route add -inet6 command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_NETBSD)
 
@@ -2044,7 +2059,8 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                 network, r6->netbits, gateway );
 
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route add -inet6 command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: NetBSD route add -inet6 command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #elif defined(TARGET_AIX)
 
@@ -2052,14 +2068,15 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                 ROUTE_PATH,
                 network, r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
-    status = openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+    bool ret = openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
+    status = ret ? RTA_SUCCESS : RTA_ERROR;
 
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
 done:
-    if (status == 1)
+    if (status == RTA_SUCCESS)
     {
         r6->flags |= RT_ADDED;
     }
@@ -2072,7 +2089,7 @@ done:
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
 
-    return (status != 0);
+    return (status != RTA_ERROR);
 }
 
 static void
@@ -2759,11 +2776,12 @@ done:
     gc_free(&gc);
 }
 
+/* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index)
 {
     struct gc_arena gc = gc_new();
-    int ret = 0;
+    int ret = RTA_ERROR;
     DWORD status;
     const DWORD if_index = (adapter_index == TUN_ADAPTER_INDEX_INVALID) ? windows_route_find_if_index(r, tt) : adapter_index;
 
@@ -2797,11 +2815,11 @@ add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapt
 
         if (status == NO_ERROR)
         {
-            ret = 1;
+            ret = RTA_SUCCESS;
         }
         else if (status == ERROR_OBJECT_ALREADY_EXISTS)
         {
-            ret = 2;
+            ret = RTA_EEXIST;
         }
         else
         {
@@ -2820,7 +2838,7 @@ add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapt
                         msg(D_ROUTE, "ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=%u and dwForwardType=%u",
                             (unsigned int)fr.dwForwardMetric1,
                             (unsigned int)fr.dwForwardType);
-                        ret = 1;
+                        ret = RTA_SUCCESS;
                         goto doublebreak;
                     }
                     else if (status != ERROR_BAD_ARGUMENTS)
@@ -2839,7 +2857,7 @@ doublebreak:
                     (unsigned int)if_index);
                 if (status == ERROR_OBJECT_ALREADY_EXISTS)
                 {
-                    ret = 2;
+                    ret = RTA_EEXIST;
                 }
             }
         }
@@ -2885,11 +2903,11 @@ del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt)
     return ret;
 }
 
-/* Returns 1 on success, 2 if route exists, 0 on error */
+/* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 do_route_service(const bool add, const route_message_t *rt, const size_t size, HANDLE pipe)
 {
-    int ret = 0;
+    int ret = RTA_ERROR;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
 
@@ -2903,25 +2921,25 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
         msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%d]",
             (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
             ack.error_number, rt->iface.index);
-        ret = (ack.error_number == ERROR_OBJECT_ALREADY_EXISTS) ? 2 : 0;
+        ret = (ack.error_number == ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
         goto out;
     }
 
-    ret = 1;
+    ret = RTA_SUCCESS;
 
 out:
     gc_free(&gc);
     return ret;
 }
 
-/* Returns 1 on success, 2 if route exists, 0 on error */
+/* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
 {
     DWORD if_index = windows_route_find_if_index(r, tt);
     if (if_index == ~0)
     {
-        return 0;
+        return RTA_ERROR;
     }
 
     route_message_t msg = {
@@ -2947,13 +2965,13 @@ do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct t
 }
 
 /* Add or delete an ipv6 route
- * Returns 1 on success, 2 if route exists, 0 on error
+ * Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error
  */
 static int
 route_ipv6_ipapi(const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
 {
     DWORD err;
-    int ret = 0;
+    int ret = RTA_ERROR;
     PMIB_IPFORWARD_ROW2 fwd_row;
     struct gc_arena gc = gc_new();
 
@@ -3006,18 +3024,18 @@ out:
     {
         msg(M_WARN, "ROUTE: route %s failed using ipapi: %s [status=%lu if_index=%lu]",
             (add ? "addition" : "deletion"), strerror_win32(err, &gc), err, fwd_row->InterfaceIndex);
-        ret = (err == ERROR_OBJECT_ALREADY_EXISTS) ? 2 : 0;
+        ret = (err == ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
     }
     else
     {
         msg(D_ROUTE, "IPv6 route %s using ipapi", add ? "added" : "deleted");
-        ret = 1;
+        ret = RTA_SUCCESS;
     }
     gc_free(&gc);
     return ret;
 }
 
-/* Returns 1 on success, 2 if route exists, 0 on error */
+/* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
 {
@@ -3060,11 +3078,11 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
     status = do_route_service(add, &msg, sizeof(msg), tt->options.msg_channel);
     msg(D_ROUTE, "IPv6 route %s via service %s",
         add ? "addition" : "deletion",
-        status ? "succeeded" : "failed");
+        (status == RTA_SUCCESS) ? "succeeded" : "failed");
     return status;
 }
 
-/* Returns 1 on success, 2 if route exists, 0 on error */
+/* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 add_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
 {
@@ -3077,7 +3095,7 @@ del_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
     return do_route_ipv4_service(false, r, tt);
 }
 
-/* Returns 1 on success, 2 if route exists, 0 on error */
+/* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 add_route_ipv6_service(const struct route_ipv6 *r, const struct tuntap *tt)
 {
-- 
2.34.1


