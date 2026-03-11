From: Gert Doering <gert@...1296...>
Date: Wed, 11 Mar 2026 17:38:45 +0100
Message-ID: <20260311163852.21387-1-gert@...1296...>
In-Reply-To: <gerrit.1770904306000.I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81@...2715...>
References: <gerrit.1770904306000.I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Win32: Make interface index DWORD
 consistently
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

Previously we had a weird mix of int and DWORD. But the
Win32 APIs seem to be consistent (they have different names,
but NET_IFINDEX is ULONG is DWORD). So use that.

Note that this fixes some smaller issues in surrounding
code that are not strictly related but were found while
scanning the code. Mostly about needlessly converting
all DWORD values to int for printf().

Change-Id: I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1519
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1519
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index a0cec53..34f50c8 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -66,7 +66,8 @@
 
 typedef struct
 {
-    int index;
+#define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
+    DWORD index;
     char name[256];
 } interface_t;
 
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 4a4bb0c..a42d032 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -468,9 +468,10 @@
     make_domain_list("dns search domains", search_domains, false, nrpt.search_domains,
                      sizeof(nrpt.search_domains));
 
-    msg(D_LOW, "%s NRPT DNS%s%s on '%s' (if_index = %d) using service",
+    msg(D_LOW, "%s NRPT DNS%s%s on '%s' (if_index = %lu) using service",
         (add ? "Setting" : "Deleting"), nrpt.resolve_domains[0] != 0 ? ", resolve domains" : "",
-        nrpt.search_domains[0] != 0 ? ", search domains" : "", nrpt.iface.name, nrpt.iface.index);
+        nrpt.search_domains[0] != 0 ? ", search domains" : "",
+        nrpt.iface.name, nrpt.iface.index);
 
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index b196713..1cfbf80 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2389,8 +2389,8 @@
         status = GetIpForwardTable(rt, &size, TRUE);
         if (status != NO_ERROR)
         {
-            msg(D_ROUTE, "NOTE: GetIpForwardTable returned error: %s (code=%u)",
-                strerror_win32(status, gc), (unsigned int)status);
+            msg(D_ROUTE, "NOTE: GetIpForwardTable returned error: %s (code=%lu)",
+                strerror_win32(status, gc), status);
             rt = NULL;
         }
     }
@@ -2470,8 +2470,8 @@
         }
     }
 
-    msg(D_ROUTE, "TEST ROUTES: %d/%d succeeded len=%d ret=%d a=%d u/d=%s", good, count, len,
-        (int)ret, ambig, adapter_up ? "up" : "down");
+    msg(D_ROUTE, "TEST ROUTES: %d/%d succeeded len=%d ret=%u a=%d u/d=%s",
+        good, count, len, ret, ambig, adapter_up ? "up" : "down");
 
     gc_free(&gc);
     return ret;
@@ -2495,9 +2495,9 @@
             const DWORD index = row->dwForwardIfIndex;
             const DWORD metric = row->dwForwardMetric1;
 
-            dmsg(D_ROUTE_DEBUG, "GDGR: route[%lu] %s/%s i=%d m=%d", i,
+            dmsg(D_ROUTE_DEBUG, "GDGR: route[%lu] %s/%s i=%lu m=%lu", i,
                  print_in_addr_t((in_addr_t)net, 0, &gc), print_in_addr_t((in_addr_t)mask, 0, &gc),
-                 (int)index, (int)metric);
+                 index, metric);
 
             if (!net && !mask && metric < lowest_metric)
             {
@@ -2508,7 +2508,7 @@
         }
     }
 
-    dmsg(D_ROUTE_DEBUG, "GDGR: best=%d lm=%u", best, (unsigned int)lowest_metric);
+    dmsg(D_ROUTE_DEBUG, "GDGR: best=%d lm=%lu", best, lowest_metric);
 
     gc_free(&gc);
     return ret;
@@ -2537,12 +2537,12 @@
     status = GetBestInterfaceEx((struct sockaddr *)dest, &best_if_index);
     if (status != NO_ERROR)
     {
-        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=%u)",
-            strerror_win32(status, gc), (unsigned int)status);
+        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=%lu)",
+            strerror_win32(status, gc), status);
         goto done;
     }
 
-    msg(D_ROUTE_DEBUG, "GetBestInterfaceEx() returned if=%d", (int)best_if_index);
+    msg(D_ROUTE_DEBUG, "GetBestInterfaceEx() returned if=%lu", best_if_index);
 
     /* get the routing information (such as NextHop) for the destination and interface */
     NET_LUID luid;
@@ -2552,8 +2552,8 @@
     status = GetBestRoute2(&luid, best_if_index, NULL, dest, 0, best_route, &best_src);
     if (status != NO_ERROR)
     {
-        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=%u)",
-            strerror_win32(status, gc), (unsigned int)status);
+        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=%lu)",
+            strerror_win32(status, gc), status);
         goto done;
     }
 
@@ -2647,15 +2647,14 @@
             print_in_addr_t(r->gateway, 0, &gc), count);
     }
 
-    dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%d", on_tun, count,
-         (int)ret);
+    dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=%d count=%d index=%lu",
+         on_tun, count, ret);
 
     gc_free(&gc);
     return ret;
 }
 
 /* IPv6 implementation using GetBestRoute2()
- *   (TBD: dynamic linking so the binary can still run on XP?)
  * https://msdn.microsoft.com/en-us/library/windows/desktop/aa365922(v=vs.85).aspx
  * https://msdn.microsoft.com/en-us/library/windows/desktop/aa814411(v=vs.85).aspx
  */
@@ -2687,8 +2686,8 @@
         print_in6_addr(BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, 0, &gc),
         BestRoute.DestinationPrefix.PrefixLength,
         print_in6_addr(BestRoute.NextHop.Ipv6.sin6_addr, 0, &gc));
-    msg(D_ROUTE, "GDG6: Metric=%d, Loopback=%d, AA=%d, I=%d", (int)BestRoute.Metric,
-        (int)BestRoute.Loopback, (int)BestRoute.AutoconfigureAddress, (int)BestRoute.Immortal);
+    msg(D_ROUTE, "GDG6: Metric=%lu, Loopback=%u, AA=%u, I=%u", BestRoute.Metric,
+        BestRoute.Loopback, BestRoute.AutoconfigureAddress, BestRoute.Immortal);
 
     rgi6->gateway.addr_ipv6 = BestRoute.NextHop.Ipv6.sin6_addr;
     rgi6->adapter_index = BestRoute.InterfaceIndex;
@@ -2753,8 +2752,8 @@
         else
         {
             /* failed, try increasing the metric to work around Vista issue */
-            const unsigned int forward_metric_limit =
-                2048; /* iteratively retry higher metrics up to this limit */
+            /* iteratively retry higher metrics up to this limit */
+            const DWORD forward_metric_limit = 2048;
 
             for (; fr.dwForwardMetric1 <= forward_metric_limit; ++fr.dwForwardMetric1)
             {
@@ -2767,8 +2766,8 @@
                     if (status == NO_ERROR)
                     {
                         msg(D_ROUTE,
-                            "ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=%u and dwForwardType=%u",
-                            (unsigned int)fr.dwForwardMetric1, (unsigned int)fr.dwForwardType);
+                            "ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=%lu and dwForwardType=%lu",
+                            fr.dwForwardMetric1, fr.dwForwardType);
                         ret = RTA_SUCCESS;
                         goto doublebreak;
                     }
@@ -2790,8 +2789,8 @@
                 {
                     msg(M_WARN,
                         "ERROR: route addition failed using CreateIpForwardEntry: "
-                        "%s [status=%u if_index=%u]",
-                        strerror_win32(status, &gc), (unsigned int)status, (unsigned int)if_index);
+                        "%s [status=%lu if_index=%lu]",
+                        strerror_win32(status, &gc), status, if_index);
                 }
             }
         }
@@ -2855,7 +2854,7 @@
         ret = (ack.error_number == ERROR_OBJECT_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;
         if (ret == RTA_ERROR)
         {
-            msg(M_WARN, "ERROR: route %s failed using service: %s [status=%u if_index=%d]",
+            msg(M_WARN, "ERROR: route %s failed using service: %s [status=%u if_index=%lu]",
                 (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
                 ack.error_number, rt->iface.index);
         }
@@ -2869,17 +2868,12 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
 {
     DWORD if_index = windows_route_find_if_index(r, tt);
-    if (if_index == ~0)
+    if (if_index == TUN_ADAPTER_INDEX_INVALID)
     {
         return RTA_ERROR;
     }
@@ -3023,10 +3017,6 @@
     return status;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 add_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
@@ -3057,14 +3047,14 @@
 format_route_entry(const MIB_IPFORWARDROW *r, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(256, gc);
-    buf_printf(&out, "%s %s %s p=%d i=%d t=%d pr=%d a=%d h=%d m=%d/%d/%d/%d/%d",
+    buf_printf(&out, "%s %s %s p=%lu i=%lu t=%lu pr=%lu a=%lu h=%lu m=%lu/%lu/%lu/%lu/%lu",
                print_in_addr_t(r->dwForwardDest, IA_NET_ORDER, gc),
                print_in_addr_t(r->dwForwardMask, IA_NET_ORDER, gc),
-               print_in_addr_t(r->dwForwardNextHop, IA_NET_ORDER, gc), (int)r->dwForwardPolicy,
-               (int)r->dwForwardIfIndex, (int)r->dwForwardType, (int)r->dwForwardProto,
-               (int)r->dwForwardAge, (int)r->dwForwardNextHopAS, (int)r->dwForwardMetric1,
-               (int)r->dwForwardMetric2, (int)r->dwForwardMetric3, (int)r->dwForwardMetric4,
-               (int)r->dwForwardMetric5);
+               print_in_addr_t(r->dwForwardNextHop, IA_NET_ORDER, gc), r->dwForwardPolicy,
+               r->dwForwardIfIndex, r->dwForwardType, r->dwForwardProto,
+               r->dwForwardAge, r->dwForwardNextHopAS, r->dwForwardMetric1,
+               r->dwForwardMetric2, r->dwForwardMetric3, r->dwForwardMetric4,
+               r->dwForwardMetric5);
     return BSTR(&out);
 }
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7f96602..64e3b45 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -158,7 +158,7 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%d]",
+        msg(M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%lu]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
             addr.iface.index);
         goto out;
@@ -220,7 +220,7 @@
         strncpy(dns.domains + dstlen, o->domain_search_list[i], srclen + 1);
     }
 
-    msg(D_LOW, "%s DNS domains on '%s' (if_index = %d) using service",
+    msg(D_LOW, "%s DNS domains on '%s' (if_index = %lu) using service",
         (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
     if (!send_msg_iservice(o->msg_channel, &dns, sizeof(dns), &ack, "TUN"))
     {
@@ -289,7 +289,7 @@
         }
     }
 
-    msg(D_LOW, "%s %s dns servers on '%s' (if_index = %d) using service",
+    msg(D_LOW, "%s %s dns servers on '%s' (if_index = %lu) using service",
         (add ? "Setting" : "Deleting"), ip_proto_name, dns.iface.name, dns.iface.index);
 
     if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
@@ -346,7 +346,7 @@
         wins.addr[i].ipv4.s_addr = htonl(tt->options.wins[i]);
     }
 
-    msg(D_LOW, "%s WINS servers on '%s' (if_index = %d) using service",
+    msg(D_LOW, "%s WINS servers on '%s' (if_index = %lu) using service",
         (add ? "Setting" : "Deleting"), wins.iface.name, wins.iface.index);
 
     if (!send_msg_iservice(pipe, &wins, sizeof(wins), &ack, "TUN"))
@@ -357,8 +357,8 @@
     if (ack.error_number != NO_ERROR)
     {
         msg(M_WARN, "TUN: %s WINS failed using service: %s [status=%u if_name=%s]",
-            (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
-            wins.iface.name);
+            (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
+            ack.error_number, wins.iface.name);
         goto out;
     }
 
@@ -398,13 +398,13 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%u if_index=%d]",
+        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%u if_index=%lu]",
             family_name, strerror_win32(ack.error_number, &gc), ack.error_number,
             mtu_msg.iface.index);
     }
     else
     {
-        msg(M_INFO, "%s MTU set to %d on interface %d using service", family_name, mtu,
+        msg(M_INFO, "%s MTU set to %d on interface %lu using service", family_name, mtu,
             mtu_msg.iface.index);
         ret = true;
     }
@@ -3428,7 +3428,7 @@
     if (dev_info_set == INVALID_HANDLE_VALUE)
     {
         err = GetLastError();
-        msg(M_FATAL, "Error [%u] opening device information set key: %s", (unsigned int)err,
+        msg(M_FATAL, "Error [%lu] opening device information set key: %s", err,
             strerror_win32(err, gc));
     }
 
@@ -4111,7 +4111,7 @@
 
     if ((status = GetAdaptersInfo(NULL, &size)) != ERROR_BUFFER_OVERFLOW)
     {
-        msg(M_INFO, "GetAdaptersInfo #1 failed (status=%u) : %s", (unsigned int)status,
+        msg(M_INFO, "GetAdaptersInfo #1 failed (status=%lu) : %s", status,
             strerror_win32(status, gc));
     }
     else
@@ -4119,7 +4119,7 @@
         pi = (PIP_ADAPTER_INFO)gc_malloc(size, false, gc);
         if ((status = GetAdaptersInfo(pi, &size)) != NO_ERROR)
         {
-            msg(M_INFO, "GetAdaptersInfo #2 failed (status=%u) : %s", (unsigned int)status,
+            msg(M_INFO, "GetAdaptersInfo #2 failed (status=%lu) : %s", status,
                 strerror_win32(status, gc));
             pi = NULL;
         }
@@ -4138,19 +4138,19 @@
     {
         if ((status = GetPerAdapterInfo(index, NULL, &size)) != ERROR_BUFFER_OVERFLOW)
         {
-            msg(M_INFO, "GetPerAdapterInfo #1 failed (status=%u) : %s", (unsigned int)status,
+            msg(M_INFO, "GetPerAdapterInfo #1 failed (status=%lu) : %s", status,
                 strerror_win32(status, gc));
         }
         else
         {
             pi = (PIP_PER_ADAPTER_INFO)gc_malloc(size, false, gc);
-            if ((status = GetPerAdapterInfo((ULONG)index, pi, &size)) == ERROR_SUCCESS)
+            if ((status = GetPerAdapterInfo(index, pi, &size)) == ERROR_SUCCESS)
             {
                 return pi;
             }
             else
             {
-                msg(M_INFO, "GetPerAdapterInfo #2 failed (status=%u) : %s", (unsigned int)status,
+                msg(M_INFO, "GetPerAdapterInfo #2 failed (status=%lu) : %s", status,
                     strerror_win32(status, gc));
             }
         }
@@ -4167,7 +4167,7 @@
 
     if ((status = GetInterfaceInfo(NULL, &size)) != ERROR_INSUFFICIENT_BUFFER)
     {
-        msg(M_INFO, "GetInterfaceInfo #1 failed (status=%u) : %s", (unsigned int)status,
+        msg(M_INFO, "GetInterfaceInfo #1 failed (status=%lu) : %s", status,
             strerror_win32(status, gc));
     }
     else
@@ -4179,7 +4179,7 @@
         }
         else
         {
-            msg(M_INFO, "GetInterfaceInfo #2 failed (status=%u) : %s", (unsigned int)status,
+            msg(M_INFO, "GetInterfaceInfo #2 failed (status=%lu) : %s", status,
                 strerror_win32(status, gc));
         }
     }
@@ -4456,8 +4456,8 @@
         list = list->Next;
     }
 
-    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%d count=%d metric=%d",
-         print_in_addr_t(ip, 0, &gc), print_in_addr_t(highest_netmask, 0, &gc), (int)ret,
+    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=%s nm=%s index=%lu count=%d metric=%d",
+         print_in_addr_t(ip, 0, &gc), print_in_addr_t(highest_netmask, 0, &gc), ret,
          count ? *count : -1, lowest_metric);
 
     if (ret == TUN_ADAPTER_INDEX_INVALID && count)
@@ -4526,7 +4526,7 @@
             DWORD status;
             const DWORD context = ip->Context;
 
-            if ((status = DeleteIPAddress((ULONG)context)) == NO_ERROR)
+            if ((status = DeleteIPAddress(context)) == NO_ERROR)
             {
                 msg(M_INFO, "Successfully deleted previously set dynamic IP/netmask: %s/%s",
                     ip->IpAddress.String, ip->IpMask.String);
@@ -4537,8 +4537,8 @@
                 if (strcmp(ip->IpAddress.String, empty) || strcmp(ip->IpMask.String, empty))
                 {
                     msg(M_INFO,
-                        "NOTE: could not delete previously set dynamic IP/netmask: %s/%s (status=%u)",
-                        ip->IpAddress.String, ip->IpMask.String, (unsigned int)status);
+                        "NOTE: could not delete previously set dynamic IP/netmask: %s/%s (status=%lu)",
+                        ip->IpAddress.String, ip->IpMask.String, status);
                 }
             }
             ip = ip->Next;
@@ -4634,7 +4634,7 @@
 show_adapter(msglvl_t msglevel, const IP_ADAPTER_INFO *a, struct gc_arena *gc)
 {
     msg(msglevel, "%s", a->Description);
-    msg(msglevel, "  Index = %d", (int)a->Index);
+    msg(msglevel, "  Index = %lu", a->Index);
     msg(msglevel, "  GUID = %s", a->AdapterName);
     msg(msglevel, "  IP = %s", format_ip_addr_string(&a->IpAddressList, gc));
     msg(msglevel, "  MAC = %s", format_hex_ex(a->Address, a->AddressLength, 0, 1, ":", gc));
@@ -4810,8 +4810,8 @@
         else
         {
             msg(M_WARN,
-                "NOTE: Release of DHCP-assigned IP address lease on TAP-Windows adapter failed: %s (code=%u)",
-                strerror_win32(status, &gc), (unsigned int)status);
+                "NOTE: Release of DHCP-assigned IP address lease on TAP-Windows adapter failed: %s (code=%lu)",
+                strerror_win32(status, &gc), status);
         }
     }
 
@@ -4851,8 +4851,8 @@
         else
         {
             msg(M_WARN,
-                "WARNING: Failed to renew DHCP IP address lease on TAP-Windows adapter: %s (code=%u)",
-                strerror_win32(status, &gc), (unsigned int)status);
+                "WARNING: Failed to renew DHCP IP address lease on TAP-Windows adapter: %s (code=%lu)",
+                strerror_win32(status, &gc), status);
         }
     }
     gc_free(&gc);
@@ -5215,12 +5215,12 @@
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=%u if_index=%d]",
+        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [status=%u if_index=%lu]",
             strerror_win32(ack.error_number, &gc), ack.error_number, dhcp.iface.index);
     }
     else
     {
-        msg(M_INFO, "DHCP enabled on interface %d using service", dhcp.iface.index);
+        msg(M_INFO, "DHCP enabled on interface %lu using service", dhcp.iface.index);
         ret = true;
     }
 
@@ -5510,7 +5510,7 @@
     /* flush arp cache */
     if (tt->backend_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && index != TUN_ADAPTER_INDEX_INVALID)
     {
-        DWORD status = -1;
+        DWORD status = (DWORD)-1;
 
         if (tt->options.msg_channel)
         {
@@ -5534,7 +5534,7 @@
         {
             msg(M_INFO, "Successful ARP Flush on interface [%lu] %s", index, device_guid);
         }
-        else if (status != -1)
+        else if (status != (DWORD)-1)
         {
             msg(D_TUNTAP_INFO,
                 "NOTE: FlushIpNetTable failed on interface [%lu] %s (status=%lu) : %s", index,
@@ -6232,11 +6232,12 @@
     if (tt->ipapi_context_defined)
     {
         DWORD status;
+
         if ((status = DeleteIPAddress(tt->ipapi_context)) != NO_ERROR)
         {
             msg(M_WARN,
-                "Warning: DeleteIPAddress[%u] failed on TAP-Windows adapter, status=%u : %s",
-                (unsigned int)tt->ipapi_context, (unsigned int)status, strerror_win32(status, &gc));
+                "Warning: DeleteIPAddress[%lu] failed on TAP-Windows adapter, status=%lu : %s",
+                tt->ipapi_context, status, strerror_win32(status, &gc));
         }
     }
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4d6dfbb..ecb5e88 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -61,8 +61,6 @@
 
 #if defined(_WIN32) || defined(TARGET_ANDROID) || defined(DHCP_UNIT_TEST)
 
-#define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
-
 /* time constants for --ip-win32 adaptive */
 #define IPW32_SET_ADAPTIVE_DELAY_WINDOW 300
 #define IPW32_SET_ADAPTIVE_TRY_NETSH    20
@@ -230,7 +228,7 @@
     in_addr_t adapter_netmask;
 
     /* Windows adapter index for TAP-Windows adapter,
-     * ~0 if undefined */
+     * TUN_ADAPTER_INDEX_INVALID if undefined */
     DWORD adapter_index;
 
     int standby_iter;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index ac449fd..b2a7331 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1185,7 +1185,7 @@
     if (ack.error_number != NO_ERROR)
     {
         msg(M_WARN,
-            "WFP block: %s block filters using service failed: %s [status=0x%x if_index=%d]",
+            "WFP block: %s block filters using service failed: %s [status=0x%x if_index=%lu]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc), ack.error_number,
             data.iface.index);
         goto out;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 09c709e..b50aeb3 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -96,7 +96,7 @@
 typedef struct
 {
     HANDLE engine;
-    int index;
+    DWORD index;
     int metric_v4;
     int metric_v6;
 } wfp_block_data_t;
@@ -584,7 +584,7 @@
     addr_row->Address = sockaddr_inet(msg->family, &msg->address);
     addr_row->OnLinkPrefixLength = (UINT8)msg->prefix_len;
 
-    if (msg->iface.index != -1)
+    if (msg->iface.index != TUN_ADAPTER_INDEX_INVALID)
     {
         addr_row->InterfaceIndex = msg->iface.index;
     }
@@ -667,7 +667,7 @@
     fwd_row->DestinationPrefix.PrefixLength = (UINT8)msg->prefix_len;
     fwd_row->NextHop = sockaddr_inet(msg->family, &msg->gateway);
 
-    if (msg->iface.index != -1)
+    if (msg->iface.index != TUN_ADAPTER_INDEX_INVALID)
     {
         fwd_row->InterfaceIndex = msg->iface.index;
     }
@@ -1010,7 +1010,7 @@
  * if action = "set" then "static" is added before $addr
  */
 static DWORD
-netsh_wins_cmd(const wchar_t *action, int if_index, const wchar_t *addr)
+netsh_wins_cmd(const wchar_t *action, DWORD if_index, const wchar_t *addr)
 {
     DWORD err = 0;
     int timeout = 30000; /* in msec */
@@ -1036,7 +1036,7 @@
     /* cmd template:
      * netsh interface ip $action wins $if_name $static $addr
      */
-    const wchar_t *fmt = L"netsh interface ip %ls wins %d %ls %ls";
+    const wchar_t *fmt = L"netsh interface ip %ls wins %lu %ls %ls";
 
     /* max cmdline length in wchars -- include room for worst case and some */
     size_t ncmdline = wcslen(fmt) + 11 /*if_index*/ + wcslen(action) + wcslen(addr)
@@ -2984,7 +2984,7 @@
          */
     }
 
-    int *if_index = malloc(sizeof(msg->iface.index));
+    PDWORD if_index = malloc(sizeof(msg->iface.index));
     if (if_index)
     {
         *if_index = msg->iface.index;
@@ -3017,7 +3017,7 @@
     /* cmd template:
      * netsh interface ipv4 set address name=$if_index source=dhcp
      */
-    const wchar_t *fmt = L"netsh interface ipv4 set address name=\"%d\" source=dhcp";
+    const wchar_t *fmt = L"netsh interface ipv4 set address name=\"%lu\" source=dhcp";
 
     /* max cmdline length in wchars -- include room for if index:
      * 10 chars for 32 bit int in decimal and +1 for NUL
@@ -3250,7 +3250,7 @@
                     break;
 
                 case undo_wins:
-                    netsh_wins_cmd(L"delete", *(int *)item->data, NULL);
+                    netsh_wins_cmd(L"delete", *(PDWORD)item->data, NULL);
                     break;
 
                 case wfp_block:

