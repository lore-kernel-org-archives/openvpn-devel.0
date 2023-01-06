From: selva.nair@...277...
Date: Fri,  6 Jan 2023 10:04:12 -0500
Message-Id: <20230106150412.1667492-1-selva.nair@...277...>
In-Reply-To: <20230105022718.1641751-2-selva.nair@...277...>
References: <20230105022718.1641751-2-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/3] Distinguish route addition errors
 from route already exists
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

When possible, functions that add a route now return 1 on success,
or 2 if route already exists or 0 on other errors instead of true/false.

Note:
net_route_v4/v6_add using netlink filters out EEXIST before returning
this looks like a bug as add_route() and add_route_ipv6() should set
RT_ADDED only if route was really added.

v2: "succeeded/skipped" --> "succeeded" in log.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
net_route_v4/v6_add when using iproute2 always returns 0 (meaning success)
making it impossible to respect RT_ADDED flag or propagate errors. I think
these should be fixed.

 src/openvpn/route.c | 91 ++++++++++++++++++++++++++++-----------------
 src/openvpn/route.h |  4 --
 2 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index eabfe0a5..0d4aeaaf 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -57,15 +57,20 @@
 #include "openvpn-msg.h"
 
 #define METRIC_NOT_USED ((DWORD)-1)
-static bool add_route_service(const struct route_ipv4 *, const struct tuntap *);
+static int add_route_service(const struct route_ipv4 *, const struct tuntap *);
 
 static bool del_route_service(const struct route_ipv4 *, const struct tuntap *);
 
-static bool add_route_ipv6_service(const struct route_ipv6 *, const struct tuntap *);
+static int add_route_ipv6_service(const struct route_ipv6 *, const struct tuntap *);
 
 static bool del_route_ipv6_service(const struct route_ipv6 *, const struct tuntap *);
 
-static bool route_ipv6_ipapi(bool add, const struct route_ipv6 *, const struct tuntap *);
+static int route_ipv6_ipapi(bool add, const struct route_ipv6 *, const struct tuntap *);
+
+static int add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index);
+
+static bool del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt);
+
 
 #endif
 
@@ -1572,7 +1577,7 @@ add_route(struct route_ipv4 *r,
           const struct env_set *es,
           openvpn_net_ctx_t *ctx)
 {
-    bool status = false;
+    int status = 0;
     int is_local_route;
 
     if (!(r->flags & RT_DEFINED))
@@ -1611,12 +1616,12 @@ add_route(struct route_ipv4 *r,
         metric = r->metric;
     }
 
-    status = true;
+    status = 1;
     if (net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask),
                          &r->gateway, iface, 0, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route add command failed");
-        status = false;
+        status = 0;
     }
 
 #elif defined (TARGET_ANDROID)
@@ -1656,12 +1661,12 @@ add_route(struct route_ipv4 *r,
         if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_SERVICE)
         {
             status = add_route_service(r, tt);
-            msg(D_ROUTE, "Route addition via service %s", status ? "succeeded" : "failed");
+            msg(D_ROUTE, "Route addition via service %s", (status == 1) ? "succeeded" : "failed");
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s", status ? "succeeded" : "failed");
+            msg(D_ROUTE, "Route addition via IPAPI %s", (status == 1) ? "succeeded" : "failed");
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
         {
@@ -1672,8 +1677,8 @@ add_route(struct route_ipv4 *r,
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s [adaptive]", status ? "succeeded" : "failed");
-            if (!status)
+            msg(D_ROUTE, "Route addition via IPAPI %s [adaptive]", (status == 1) ? "succeeded" : "failed");
+            if (status == 0)
             {
                 msg(D_ROUTE, "Route addition fallback to route.exe");
                 netcmd_semaphore_lock();
@@ -1828,7 +1833,7 @@ add_route(struct route_ipv4 *r,
 #endif /* if defined(TARGET_LINUX) */
 
 done:
-    if (status)
+    if (status == 1)
     {
         r->flags |= RT_ADDED;
     }
@@ -1871,7 +1876,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                unsigned int flags, const struct env_set *es,
                openvpn_net_ctx_t *ctx)
 {
-    bool status = false;
+    int status = 0;
     const char *device = tt->actual_name;
     bool gateway_needed = false;
 
@@ -1942,7 +1947,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
             "parameter for a --route-ipv6 option and no default was set via "
             "--ifconfig-ipv6 or --route-ipv6-gateway option.  Not installing "
             "IPv6 route to %s/%d.", network, r6->netbits);
-        status = false;
+        status = 0;
         goto done;
     }
 
@@ -1953,13 +1958,13 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
         metric = r6->metric;
     }
 
-    status = true;
+    status = 1;
     if (net_route_v6_add(ctx, &r6->network, r6->netbits,
                          gateway_needed ? &r6->gateway : NULL, device, 0,
                          metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux IPv6 route can't be added");
-        status = false;
+        status = 0;
     }
 
 #elif defined (TARGET_ANDROID)
@@ -2075,7 +2080,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
 #endif /* if defined(TARGET_LINUX) */
 
 done:
-    if (status)
+    if (status == 1)
     {
         r6->flags |= RT_ADDED;
     }
@@ -2773,11 +2778,11 @@ done:
     gc_free(&gc);
 }
 
-bool
+static int
 add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index)
 {
     struct gc_arena gc = gc_new();
-    bool ret = false;
+    int ret = 0;
     DWORD status;
     const DWORD if_index = (adapter_index == TUN_ADAPTER_INDEX_INVALID) ? windows_route_find_if_index(r, tt) : adapter_index;
 
@@ -2811,7 +2816,11 @@ add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapt
 
         if (status == NO_ERROR)
         {
-            ret = true;
+            ret = 1;
+        }
+        else if (status == ERROR_OBJECT_ALREADY_EXISTS)
+        {
+            ret = 2;
         }
         else
         {
@@ -2830,7 +2839,7 @@ add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapt
                         msg(D_ROUTE, "ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=%u and dwForwardType=%u",
                             (unsigned int)fr.dwForwardMetric1,
                             (unsigned int)fr.dwForwardType);
-                        ret = true;
+                        ret = 1;
                         goto doublebreak;
                     }
                     else if (status != ERROR_BAD_ARGUMENTS)
@@ -2847,6 +2856,10 @@ doublebreak:
                     strerror_win32(status, &gc),
                     (unsigned int)status,
                     (unsigned int)if_index);
+                if (status == ERROR_OBJECT_ALREADY_EXISTS)
+                {
+                    ret = 2;
+                }
             }
         }
     }
@@ -2855,7 +2868,7 @@ doublebreak:
     return ret;
 }
 
-bool
+static bool
 del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt)
 {
     struct gc_arena gc = gc_new();
@@ -2891,10 +2904,11 @@ del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt)
     return ret;
 }
 
-static bool
+/* Returns 1 on success, 2 if route exists, 0 on error */
+static int
 do_route_service(const bool add, const route_message_t *rt, const size_t size, HANDLE pipe)
 {
-    bool ret = false;
+    int ret = 0;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
 
@@ -2908,23 +2922,25 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
         msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%d]",
             (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
             ack.error_number, rt->iface.index);
+        ret = (ack.error_number == ERROR_OBJECT_ALREADY_EXISTS) ? 2 : 0;
         goto out;
     }
 
-    ret = true;
+    ret = 1;
 
 out:
     gc_free(&gc);
     return ret;
 }
 
-static bool
+/* Returns 1 on success, 2 if route exists, 0 on error */
+static int
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
 {
     DWORD if_index = windows_route_find_if_index(r, tt);
     if (if_index == ~0)
     {
-        return false;
+        return 0;
     }
 
     route_message_t msg = {
@@ -2949,11 +2965,14 @@ do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct t
     return do_route_service(add, &msg, sizeof(msg), tt->options.msg_channel);
 }
 
-/* Add or delete an ipv6 route */
-static bool
+/* Add or delete an ipv6 route
+ * Returns 1 on success, 2 if route exists, 0 on error
+ */
+static int
 route_ipv6_ipapi(const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
 {
     DWORD err;
+    int ret = 0;
     PMIB_IPFORWARD_ROW2 fwd_row;
     struct gc_arena gc = gc_new();
 
@@ -3006,20 +3025,22 @@ out:
     {
         msg(M_WARN, "ROUTE: route %s failed using ipapi: %s [status=%lu if_index=%lu]",
             (add ? "addition" : "deletion"), strerror_win32(err, &gc), err, fwd_row->InterfaceIndex);
+        ret = (err == ERROR_OBJECT_ALREADY_EXISTS) ? 2 : 0;
     }
     else
     {
         msg(D_ROUTE, "IPv6 route %s using ipapi", add ? "added" : "deleted");
+        ret = 1;
     }
     gc_free(&gc);
-
-    return (err == NO_ERROR);
+    return ret;
 }
 
-static bool
+/* Returns 1 on success, 2 if route exists, 0 on error */
+static int
 do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
 {
-    bool status;
+    int status;
     route_message_t msg = {
         .header = {
             (add ? msg_add_route : msg_del_route),
@@ -3062,7 +3083,8 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
     return status;
 }
 
-static bool
+/* Returns 1 on success, 2 if route exists, 0 on error */
+static int
 add_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
 {
     return do_route_ipv4_service(true, r, tt);
@@ -3074,7 +3096,8 @@ del_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
     return do_route_ipv4_service(false, r, tt);
 }
 
-static bool
+/* Returns 1 on success, 2 if route exists, 0 on error */
+static int
 add_route_ipv6_service(const struct route_ipv6 *r, const struct tuntap *tt)
 {
     return do_route_ipv6_service(true, r, tt);
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 33f2b28e..74ecd343 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -357,10 +357,6 @@ void show_routes(int msglev);
 
 bool test_routes(const struct route_list *rl, const struct tuntap *tt);
 
-bool add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapter_index);
-
-bool del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt);
-
 #else  /* ifdef _WIN32 */
 static inline bool
 test_routes(const struct route_list *rl, const struct tuntap *tt)
-- 
2.34.1


