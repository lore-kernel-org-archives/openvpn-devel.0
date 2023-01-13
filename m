From: selva.nair@...277...
Date: Fri, 13 Jan 2023 18:57:54 -0500
Message-Id: <20230113235754.1942385-2-selva.nair@...277...>
In-Reply-To: <20230113235754.1942385-1-selva.nair@...277...>
References: <20230113235754.1942385-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Cleanup route error and debug logging
 on Windows
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

Use a unified logging format for various route-methods

- Route add/delete errors are always logged with M_WARN, so
  log only additional information (succeed/exists) with D_ROUTE.

- Non-windows platforms log route errors with a prefix "ERROR:" and
  debug info with "ROUTE:". Do the same on Windows. Do not log
  errors or success multiple times.

- In add_route_ipv6, log the interface id instead of device name
  as the latter always point to the tun/tap adapter name on Windows.

Log lines prefixed with a PACKAGE_NAME "ROUTE" are unchanged.
They appear to use the same format on all platforms.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/route.c | 63 +++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index fe5cda2a..8117c648 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1640,38 +1640,45 @@ add_route(struct route_ipv4 *r,
 
         argv_msg(D_ROUTE, &argv);
 
+        const char *method = "service";
         if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_SERVICE)
         {
             status = add_route_service(r, tt);
-            msg(D_ROUTE, "Route addition via service %s", (status == RTA_SUCCESS) ? "succeeded" : "failed");
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s", (status == RTA_SUCCESS) ? "succeeded" : "failed");
+            method = "ipapi";
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_EXE)
         {
             netcmd_semaphore_lock();
             status = openvpn_execve_check(&argv, es, 0, "ERROR: Windows route add command failed");
             netcmd_semaphore_release();
+            method = "route.exe";
         }
         else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_ADAPTIVE)
         {
             status = add_route_ipapi(r, tt, ai);
-            msg(D_ROUTE, "Route addition via IPAPI %s [adaptive]", (status == RTA_SUCCESS) ? "succeeded" : "failed");
+            method = "ipapi [adaptive]";
             if (status == RTA_ERROR)
             {
                 msg(D_ROUTE, "Route addition fallback to route.exe");
                 netcmd_semaphore_lock();
                 status = openvpn_execve_check(&argv, es, 0, "ERROR: Windows route add command failed [adaptive]");
                 netcmd_semaphore_release();
+                method = "route.exe";
             }
         }
         else
         {
             ASSERT(0);
         }
+        if (status != RTA_ERROR) /* error is logged upstream */
+        {
+            msg(D_ROUTE, "Route addition via %s %s", method, (status == RTA_SUCCESS) ?
+                "succeeded" : "failed because route exists");
+        }
     }
 
 #elif defined (TARGET_SOLARIS)
@@ -1867,7 +1874,6 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
                openvpn_net_ctx_t *ctx)
 {
     int status = 0;
-    const char *device = tt->actual_name;
     bool gateway_needed = false;
 
     if (!(r6->flags & RT_DEFINED) )
@@ -1879,6 +1885,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     struct gc_arena gc = gc_new();
 
 #ifndef _WIN32
+    const char *device = tt->actual_name;
     if (r6->iface != NULL)              /* vpn server special route */
     {
         device = r6->iface;
@@ -1911,8 +1918,14 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
     }
 #endif
 
+#ifndef _WIN32
     msg( M_INFO, "add_route_ipv6(%s/%d -> %s metric %d) dev %s",
          network, r6->netbits, gateway, r6->metric, device );
+#else
+    msg( M_INFO, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu",
+         network, r6->netbits, gateway, r6->metric,
+         r6->adapter_index ? r6->adapter_index : tt->adapter_index);
+#endif
 
     /*
      * Filter out routes which are essentially no-ops
@@ -2851,14 +2864,16 @@ add_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt, DWORD adapt
 doublebreak:
             if (status != NO_ERROR)
             {
-                msg(M_WARN, "ROUTE: route addition failed using CreateIpForwardEntry: %s [status=%u if_index=%u]",
-                    strerror_win32(status, &gc),
-                    (unsigned int)status,
-                    (unsigned int)if_index);
                 if (status == ERROR_OBJECT_ALREADY_EXISTS)
                 {
                     ret = RTA_EEXIST;
                 }
+                else
+                {
+                    msg(M_WARN, "ERROR: route addition failed using CreateIpForwardEntry: "
+                        "%s [status=%u if_index=%u]", strerror_win32(status, &gc),
+                        (unsigned int)status, (unsigned int)if_index);
+                }
             }
         }
     }
@@ -2894,7 +2909,7 @@ del_route_ipapi(const struct route_ipv4 *r, const struct tuntap *tt)
         }
         else
         {
-            msg(M_WARN, "ROUTE: route deletion failed using DeleteIpForwardEntry: %s",
+            msg(M_WARN, "ERROR: route deletion failed using DeleteIpForwardEntry: %s",
                 strerror_win32(status, &gc));
         }
     }
@@ -2918,10 +2933,13 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%d]",
-            (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
-            ack.error_number, rt->iface.index);
         ret = (ack.error_number == ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
+        if (ret == RTA_ERROR)
+        {
+            msg(M_WARN, "ERROR: route %s failed using service: %s [status=%u if_index=%d]",
+                (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
+                ack.error_number, rt->iface.index);
+        }
         goto out;
     }
 
@@ -3022,9 +3040,17 @@ route_ipv6_ipapi(const bool add, const struct route_ipv6 *r, const struct tuntap
 out:
     if (err != NO_ERROR)
     {
-        msg(M_WARN, "ROUTE: route %s failed using ipapi: %s [status=%lu if_index=%lu]",
-            (add ? "addition" : "deletion"), strerror_win32(err, &gc), err, fwd_row->InterfaceIndex);
         ret = (err == ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
+        if (ret == RTA_ERROR)
+        {
+            msg(M_WARN, "ERROR: route %s failed using ipapi: %s [status=%lu if_index=%lu]",
+                (add ? "addition" : "deletion"), strerror_win32(err, &gc), err,
+                fwd_row->InterfaceIndex);
+        }
+        else if (add)
+        {
+            msg(D_ROUTE, "IPv6 route addition using ipapi failed because route exists");
+        }
     }
     else
     {
@@ -3076,9 +3102,12 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
     }
 
     status = do_route_service(add, &msg, sizeof(msg), tt->options.msg_channel);
-    msg(D_ROUTE, "IPv6 route %s via service %s",
-        add ? "addition" : "deletion",
-        (status == RTA_SUCCESS) ? "succeeded" : "failed");
+    if (status != RTA_ERROR)
+    {
+        msg(D_ROUTE, "IPv6 route %s via service %s",
+            add ? "addition" : "deletion",
+            (status == RTA_SUCCESS) ? "succeeded" : "failed because route exists");
+    }
     return status;
 }
 
-- 
2.34.1


