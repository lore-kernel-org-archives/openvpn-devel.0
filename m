From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 16:43:29 +0000
In-Reply-To: <gerrit.1770904306000.I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81@...2715...>
References: <gerrit.1770904306000.I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2f751fc272a039f4f636a83c184db09f1e82cc2d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IbVBcuAZuNc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Win32: Make
 interface index DWORD consistently
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IbVBcuAZuNc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Win32: Make interface index DWORD consistently
......................................................................

Win32: Make interface index DWORD consistently

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
Message-Id: <20260311163852.21387-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
021.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M include/openvpn-msg.h
M src/openvpn/dns.c
M src/openvpn/route.c
M src/openvpn/tun.c
M src/openvpn/tun.h
M src/openvpn/win32.c
M src/openvpnserv/interactive.c
7 files changed, 78 insertions(+), 87 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1519/7

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
     make_domain_list("dns search domains", search_domains, false, nrpt.sea=
rch_domains,
                      sizeof(nrpt.search_domains));

-    msg(D_LOW, "%s NRPT DNS%s%s on '%s' (if_index =3D %d) using service",
+    msg(D_LOW, "%s NRPT DNS%s%s on '%s' (if_index =3D %lu) using service",
         (add ? "Setting" : "Deleting"), nrpt.resolve_domains[0] !=3D 0 ? "=
, resolve domains" : "",
-        nrpt.search_domains[0] !=3D 0 ? ", search domains" : "", nrpt.ifac=
e.name, nrpt.iface.index);
+        nrpt.search_domains[0] !=3D 0 ? ", search domains" : "",
+        nrpt.iface.name, nrpt.iface.index);

     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index b196713..1cfbf80 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2389,8 +2389,8 @@
         status =3D GetIpForwardTable(rt, &size, TRUE);
         if (status !=3D NO_ERROR)
         {
-            msg(D_ROUTE, "NOTE: GetIpForwardTable returned error: %s (code=
=3D%u)",
-                strerror_win32(status, gc), (unsigned int)status);
+            msg(D_ROUTE, "NOTE: GetIpForwardTable returned error: %s (code=
=3D%lu)",
+                strerror_win32(status, gc), status);
             rt =3D NULL;
         }
     }
@@ -2470,8 +2470,8 @@
         }
     }

-    msg(D_ROUTE, "TEST ROUTES: %d/%d succeeded len=3D%d ret=3D%d a=3D%d u/=
d=3D%s", good, count, len,
-        (int)ret, ambig, adapter_up ? "up" : "down");
+    msg(D_ROUTE, "TEST ROUTES: %d/%d succeeded len=3D%d ret=3D%u a=3D%d u/=
d=3D%s",
+        good, count, len, ret, ambig, adapter_up ? "up" : "down");

     gc_free(&gc);
     return ret;
@@ -2495,9 +2495,9 @@
             const DWORD index =3D row->dwForwardIfIndex;
             const DWORD metric =3D row->dwForwardMetric1;

-            dmsg(D_ROUTE_DEBUG, "GDGR: route[%lu] %s/%s i=3D%d m=3D%d", i,
+            dmsg(D_ROUTE_DEBUG, "GDGR: route[%lu] %s/%s i=3D%lu m=3D%lu", =
i,
                  print_in_addr_t((in_addr_t)net, 0, &gc), print_in_addr_t(=
(in_addr_t)mask, 0, &gc),
-                 (int)index, (int)metric);
+                 index, metric);

             if (!net && !mask && metric < lowest_metric)
             {
@@ -2508,7 +2508,7 @@
         }
     }

-    dmsg(D_ROUTE_DEBUG, "GDGR: best=3D%d lm=3D%u", best, (unsigned int)low=
est_metric);
+    dmsg(D_ROUTE_DEBUG, "GDGR: best=3D%d lm=3D%lu", best, lowest_metric);

     gc_free(&gc);
     return ret;
@@ -2537,12 +2537,12 @@
     status =3D GetBestInterfaceEx((struct sockaddr *)dest, &best_if_index);
     if (status !=3D NO_ERROR)
     {
-        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=3D=
%u)",
-            strerror_win32(status, gc), (unsigned int)status);
+        msg(D_ROUTE, "NOTE: GetBestInterfaceEx returned error: %s (code=3D=
%lu)",
+            strerror_win32(status, gc), status);
         goto done;
     }

-    msg(D_ROUTE_DEBUG, "GetBestInterfaceEx() returned if=3D%d", (int)best_=
if_index);
+    msg(D_ROUTE_DEBUG, "GetBestInterfaceEx() returned if=3D%lu", best_if_i=
ndex);

     /* get the routing information (such as NextHop) for the destination a=
nd interface */
     NET_LUID luid;
@@ -2552,8 +2552,8 @@
     status =3D GetBestRoute2(&luid, best_if_index, NULL, dest, 0, best_rou=
te, &best_src);
     if (status !=3D NO_ERROR)
     {
-        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=3D=
%u)",
-            strerror_win32(status, gc), (unsigned int)status);
+        msg(D_ROUTE, "NOTE: GetIpForwardEntry2 returned error: %s (code=3D=
%lu)",
+            strerror_win32(status, gc), status);
         goto done;
     }

@@ -2647,15 +2647,14 @@
             print_in_addr_t(r->gateway, 0, &gc), count);
     }

-    dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=3D%d count=3D%d inde=
x=3D%d", on_tun, count,
-         (int)ret);
+    dmsg(D_ROUTE_DEBUG, "DEBUG: route find if: on_tun=3D%d count=3D%d inde=
x=3D%lu",
+         on_tun, count, ret);

     gc_free(&gc);
     return ret;
 }

 /* IPv6 implementation using GetBestRoute2()
- *   (TBD: dynamic linking so the binary can still run on XP?)
  * https://msdn.microsoft.com/en-us/library/windows/desktop/aa365922(v=3Dv=
s.85).aspx
  * https://msdn.microsoft.com/en-us/library/windows/desktop/aa814411(v=3Dv=
s.85).aspx
  */
@@ -2687,8 +2686,8 @@
         print_in6_addr(BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, =
0, &gc),
         BestRoute.DestinationPrefix.PrefixLength,
         print_in6_addr(BestRoute.NextHop.Ipv6.sin6_addr, 0, &gc));
-    msg(D_ROUTE, "GDG6: Metric=3D%d, Loopback=3D%d, AA=3D%d, I=3D%d", (int=
)BestRoute.Metric,
-        (int)BestRoute.Loopback, (int)BestRoute.AutoconfigureAddress, (int=
)BestRoute.Immortal);
+    msg(D_ROUTE, "GDG6: Metric=3D%lu, Loopback=3D%u, AA=3D%u, I=3D%u", Bes=
tRoute.Metric,
+        BestRoute.Loopback, BestRoute.AutoconfigureAddress, BestRoute.Immo=
rtal);

     rgi6->gateway.addr_ipv6 =3D BestRoute.NextHop.Ipv6.sin6_addr;
     rgi6->adapter_index =3D BestRoute.InterfaceIndex;
@@ -2753,8 +2752,8 @@
         else
         {
             /* failed, try increasing the metric to work around Vista issu=
e */
-            const unsigned int forward_metric_limit =3D
-                2048; /* iteratively retry higher metrics up to this limit=
 */
+            /* iteratively retry higher metrics up to this limit */
+            const DWORD forward_metric_limit =3D 2048;

             for (; fr.dwForwardMetric1 <=3D forward_metric_limit; ++fr.dwF=
orwardMetric1)
             {
@@ -2767,8 +2766,8 @@
                     if (status =3D=3D NO_ERROR)
                     {
                         msg(D_ROUTE,
-                            "ROUTE: CreateIpForwardEntry succeeded with dw=
ForwardMetric1=3D%u and dwForwardType=3D%u",
-                            (unsigned int)fr.dwForwardMetric1, (unsigned i=
nt)fr.dwForwardType);
+                            "ROUTE: CreateIpForwardEntry succeeded with dw=
ForwardMetric1=3D%lu and dwForwardType=3D%lu",
+                            fr.dwForwardMetric1, fr.dwForwardType);
                         ret =3D RTA_SUCCESS;
                         goto doublebreak;
                     }
@@ -2790,8 +2789,8 @@
                 {
                     msg(M_WARN,
                         "ERROR: route addition failed using CreateIpForwar=
dEntry: "
-                        "%s [status=3D%u if_index=3D%u]",
-                        strerror_win32(status, &gc), (unsigned int)status,=
 (unsigned int)if_index);
+                        "%s [status=3D%lu if_index=3D%lu]",
+                        strerror_win32(status, &gc), status, if_index);
                 }
             }
         }
@@ -2855,7 +2854,7 @@
         ret =3D (ack.error_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS) ? RT=
A_EEXIST : RTA_ERROR;
         if (ret =3D=3D RTA_ERROR)
         {
-            msg(M_WARN, "ERROR: route %s failed using service: %s [status=
=3D%u if_index=3D%d]",
+            msg(M_WARN, "ERROR: route %s failed using service: %s [status=
=3D%u if_index=3D%lu]",
                 (add ? "addition" : "deletion"), strerror_win32(ack.error_=
number, &gc),
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
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR o=
n error */
 static int
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const st=
ruct tuntap *tt)
 {
     DWORD if_index =3D windows_route_find_if_index(r, tt);
-    if (if_index =3D=3D ~0)
+    if (if_index =3D=3D TUN_ADAPTER_INDEX_INVALID)
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
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR o=
n error */
 static int
 add_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
@@ -3057,14 +3047,14 @@
 format_route_entry(const MIB_IPFORWARDROW *r, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&out, "%s %s %s p=3D%d i=3D%d t=3D%d pr=3D%d a=3D%d h=3D%d =
m=3D%d/%d/%d/%d/%d",
+    buf_printf(&out, "%s %s %s p=3D%lu i=3D%lu t=3D%lu pr=3D%lu a=3D%lu h=
=3D%lu m=3D%lu/%lu/%lu/%lu/%lu",
                print_in_addr_t(r->dwForwardDest, IA_NET_ORDER, gc),
                print_in_addr_t(r->dwForwardMask, IA_NET_ORDER, gc),
-               print_in_addr_t(r->dwForwardNextHop, IA_NET_ORDER, gc), (in=
t)r->dwForwardPolicy,
-               (int)r->dwForwardIfIndex, (int)r->dwForwardType, (int)r->dw=
ForwardProto,
-               (int)r->dwForwardAge, (int)r->dwForwardNextHopAS, (int)r->d=
wForwardMetric1,
-               (int)r->dwForwardMetric2, (int)r->dwForwardMetric3, (int)r-=
>dwForwardMetric4,
-               (int)r->dwForwardMetric5);
+               print_in_addr_t(r->dwForwardNextHop, IA_NET_ORDER, gc), r->=
dwForwardPolicy,
+               r->dwForwardIfIndex, r->dwForwardType, r->dwForwardProto,
+               r->dwForwardAge, r->dwForwardNextHopAS, r->dwForwardMetric1,
+               r->dwForwardMetric2, r->dwForwardMetric3, r->dwForwardMetri=
c4,
+               r->dwForwardMetric5);
     return BSTR(&out);
 }

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7a173c5..b37a2ea 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -158,7 +158,7 @@

     if (ack.error_number !=3D NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s address failed using service: %s [status=3D%u=
 if_index=3D%d]",
+        msg(M_WARN, "TUN: %s address failed using service: %s [status=3D%u=
 if_index=3D%lu]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc), ack.error_number,
             addr.iface.index);
         goto out;
@@ -220,7 +220,7 @@
         strncpy(dns.domains + dstlen, o->domain_search_list[i], srclen + 1=
);
     }

-    msg(D_LOW, "%s DNS domains on '%s' (if_index =3D %d) using service",
+    msg(D_LOW, "%s DNS domains on '%s' (if_index =3D %lu) using service",
         (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
     if (!send_msg_iservice(o->msg_channel, &dns, sizeof(dns), &ack, "TUN"))
     {
@@ -289,7 +289,7 @@
         }
     }

-    msg(D_LOW, "%s %s dns servers on '%s' (if_index =3D %d) using service",
+    msg(D_LOW, "%s %s dns servers on '%s' (if_index =3D %lu) using service=
",
         (add ? "Setting" : "Deleting"), ip_proto_name, dns.iface.name, dns=
.iface.index);

     if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
@@ -346,7 +346,7 @@
         wins.addr[i].ipv4.s_addr =3D htonl(tt->options.wins[i]);
     }

-    msg(D_LOW, "%s WINS servers on '%s' (if_index =3D %d) using service",
+    msg(D_LOW, "%s WINS servers on '%s' (if_index =3D %lu) using service",
         (add ? "Setting" : "Deleting"), wins.iface.name, wins.iface.index);

     if (!send_msg_iservice(pipe, &wins, sizeof(wins), &ack, "TUN"))
@@ -357,8 +357,8 @@
     if (ack.error_number !=3D NO_ERROR)
     {
         msg(M_WARN, "TUN: %s WINS failed using service: %s [status=3D%u if=
_name=3D%s]",
-            (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc), ack.error_number,
-            wins.iface.name);
+            (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc),
+            ack.error_number, wins.iface.name);
         goto out;
     }

@@ -398,13 +398,13 @@

     if (ack.error_number !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [sta=
tus=3D%u if_index=3D%d]",
+        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [sta=
tus=3D%u if_index=3D%lu]",
             family_name, strerror_win32(ack.error_number, &gc), ack.error_=
number,
             mtu_msg.iface.index);
     }
     else
     {
-        msg(M_INFO, "%s MTU set to %d on interface %d using service", fami=
ly_name, mtu,
+        msg(M_INFO, "%s MTU set to %d on interface %lu using service", fam=
ily_name, mtu,
             mtu_msg.iface.index);
         ret =3D true;
     }
@@ -3422,7 +3422,7 @@
     if (dev_info_set =3D=3D INVALID_HANDLE_VALUE)
     {
         err =3D GetLastError();
-        msg(M_FATAL, "Error [%u] opening device information set key: %s", =
(unsigned int)err,
+        msg(M_FATAL, "Error [%lu] opening device information set key: %s",=
 err,
             strerror_win32(err, gc));
     }

@@ -4105,7 +4105,7 @@

     if ((status =3D GetAdaptersInfo(NULL, &size)) !=3D ERROR_BUFFER_OVERFL=
OW)
     {
-        msg(M_INFO, "GetAdaptersInfo #1 failed (status=3D%u) : %s", (unsig=
ned int)status,
+        msg(M_INFO, "GetAdaptersInfo #1 failed (status=3D%lu) : %s", statu=
s,
             strerror_win32(status, gc));
     }
     else
@@ -4113,7 +4113,7 @@
         pi =3D (PIP_ADAPTER_INFO)gc_malloc(size, false, gc);
         if ((status =3D GetAdaptersInfo(pi, &size)) !=3D NO_ERROR)
         {
-            msg(M_INFO, "GetAdaptersInfo #2 failed (status=3D%u) : %s", (u=
nsigned int)status,
+            msg(M_INFO, "GetAdaptersInfo #2 failed (status=3D%lu) : %s", s=
tatus,
                 strerror_win32(status, gc));
             pi =3D NULL;
         }
@@ -4132,19 +4132,19 @@
     {
         if ((status =3D GetPerAdapterInfo(index, NULL, &size)) !=3D ERROR_=
BUFFER_OVERFLOW)
         {
-            msg(M_INFO, "GetPerAdapterInfo #1 failed (status=3D%u) : %s", =
(unsigned int)status,
+            msg(M_INFO, "GetPerAdapterInfo #1 failed (status=3D%lu) : %s",=
 status,
                 strerror_win32(status, gc));
         }
         else
         {
             pi =3D (PIP_PER_ADAPTER_INFO)gc_malloc(size, false, gc);
-            if ((status =3D GetPerAdapterInfo((ULONG)index, pi, &size)) =
=3D=3D ERROR_SUCCESS)
+            if ((status =3D GetPerAdapterInfo(index, pi, &size)) =3D=3D ER=
ROR_SUCCESS)
             {
                 return pi;
             }
             else
             {
-                msg(M_INFO, "GetPerAdapterInfo #2 failed (status=3D%u) : %=
s", (unsigned int)status,
+                msg(M_INFO, "GetPerAdapterInfo #2 failed (status=3D%lu) : =
%s", status,
                     strerror_win32(status, gc));
             }
         }
@@ -4161,7 +4161,7 @@

     if ((status =3D GetInterfaceInfo(NULL, &size)) !=3D ERROR_INSUFFICIENT=
_BUFFER)
     {
-        msg(M_INFO, "GetInterfaceInfo #1 failed (status=3D%u) : %s", (unsi=
gned int)status,
+        msg(M_INFO, "GetInterfaceInfo #1 failed (status=3D%lu) : %s", stat=
us,
             strerror_win32(status, gc));
     }
     else
@@ -4173,7 +4173,7 @@
         }
         else
         {
-            msg(M_INFO, "GetInterfaceInfo #2 failed (status=3D%u) : %s", (=
unsigned int)status,
+            msg(M_INFO, "GetInterfaceInfo #2 failed (status=3D%lu) : %s", =
status,
                 strerror_win32(status, gc));
         }
     }
@@ -4450,8 +4450,8 @@
         list =3D list->Next;
     }

-    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=3D%s nm=3D%s index=3D%d coun=
t=3D%d metric=3D%d",
-         print_in_addr_t(ip, 0, &gc), print_in_addr_t(highest_netmask, 0, =
&gc), (int)ret,
+    dmsg(D_ROUTE_DEBUG, "DEBUG: IP Locate: ip=3D%s nm=3D%s index=3D%lu cou=
nt=3D%d metric=3D%d",
+         print_in_addr_t(ip, 0, &gc), print_in_addr_t(highest_netmask, 0, =
&gc), ret,
          count ? *count : -1, lowest_metric);

     if (ret =3D=3D TUN_ADAPTER_INDEX_INVALID && count)
@@ -4520,7 +4520,7 @@
             DWORD status;
             const DWORD context =3D ip->Context;

-            if ((status =3D DeleteIPAddress((ULONG)context)) =3D=3D NO_ERR=
OR)
+            if ((status =3D DeleteIPAddress(context)) =3D=3D NO_ERROR)
             {
                 msg(M_INFO, "Successfully deleted previously set dynamic I=
P/netmask: %s/%s",
                     ip->IpAddress.String, ip->IpMask.String);
@@ -4531,8 +4531,8 @@
                 if (strcmp(ip->IpAddress.String, empty) || strcmp(ip->IpMa=
sk.String, empty))
                 {
                     msg(M_INFO,
-                        "NOTE: could not delete previously set dynamic IP/=
netmask: %s/%s (status=3D%u)",
-                        ip->IpAddress.String, ip->IpMask.String, (unsigned=
 int)status);
+                        "NOTE: could not delete previously set dynamic IP/=
netmask: %s/%s (status=3D%lu)",
+                        ip->IpAddress.String, ip->IpMask.String, status);
                 }
             }
             ip =3D ip->Next;
@@ -4628,7 +4628,7 @@
 show_adapter(msglvl_t msglevel, const IP_ADAPTER_INFO *a, struct gc_arena =
*gc)
 {
     msg(msglevel, "%s", a->Description);
-    msg(msglevel, "  Index =3D %d", (int)a->Index);
+    msg(msglevel, "  Index =3D %lu", a->Index);
     msg(msglevel, "  GUID =3D %s", a->AdapterName);
     msg(msglevel, "  IP =3D %s", format_ip_addr_string(&a->IpAddressList, =
gc));
     msg(msglevel, "  MAC =3D %s", format_hex_ex(a->Address, a->AddressLeng=
th, 0, 1, ":", gc));
@@ -4804,8 +4804,8 @@
         else
         {
             msg(M_WARN,
-                "NOTE: Release of DHCP-assigned IP address lease on TAP-Wi=
ndows adapter failed: %s (code=3D%u)",
-                strerror_win32(status, &gc), (unsigned int)status);
+                "NOTE: Release of DHCP-assigned IP address lease on TAP-Wi=
ndows adapter failed: %s (code=3D%lu)",
+                strerror_win32(status, &gc), status);
         }
     }

@@ -4845,8 +4845,8 @@
         else
         {
             msg(M_WARN,
-                "WARNING: Failed to renew DHCP IP address lease on TAP-Win=
dows adapter: %s (code=3D%u)",
-                strerror_win32(status, &gc), (unsigned int)status);
+                "WARNING: Failed to renew DHCP IP address lease on TAP-Win=
dows adapter: %s (code=3D%lu)",
+                strerror_win32(status, &gc), status);
         }
     }
     gc_free(&gc);
@@ -5209,12 +5209,12 @@

     if (ack.error_number !=3D NO_ERROR)
     {
-        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [stat=
us=3D%u if_index=3D%d]",
+        msg(M_NONFATAL, "TUN: enabling dhcp using service failed: %s [stat=
us=3D%u if_index=3D%lu]",
             strerror_win32(ack.error_number, &gc), ack.error_number, dhcp.=
iface.index);
     }
     else
     {
-        msg(M_INFO, "DHCP enabled on interface %d using service", dhcp.ifa=
ce.index);
+        msg(M_INFO, "DHCP enabled on interface %lu using service", dhcp.if=
ace.index);
         ret =3D true;
     }

@@ -5503,7 +5503,7 @@
     /* flush arp cache */
     if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6 && index !=
=3D TUN_ADAPTER_INDEX_INVALID)
     {
-        DWORD status =3D -1;
+        DWORD status =3D (DWORD)-1;

         if (tt->options.msg_channel)
         {
@@ -5527,7 +5527,7 @@
         {
             msg(M_INFO, "Successful ARP Flush on interface [%lu] %s", inde=
x, device_guid);
         }
-        else if (status !=3D -1)
+        else if (status !=3D (DWORD)-1)
         {
             msg(D_TUNTAP_INFO,
                 "NOTE: FlushIpNetTable failed on interface [%lu] %s (statu=
s=3D%lu) : %s", index,
@@ -6221,11 +6221,12 @@
     if (tt->ipapi_context_defined)
     {
         DWORD status;
+
         if ((status =3D DeleteIPAddress(tt->ipapi_context)) !=3D NO_ERROR)
         {
             msg(M_WARN,
-                "Warning: DeleteIPAddress[%u] failed on TAP-Windows adapte=
r, status=3D%u : %s",
-                (unsigned int)tt->ipapi_context, (unsigned int)status, str=
error_win32(status, &gc));
+                "Warning: DeleteIPAddress[%lu] failed on TAP-Windows adapt=
er, status=3D%lu : %s",
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
     if (ack.error_number !=3D NO_ERROR)
     {
         msg(M_WARN,
-            "WFP block: %s block filters using service failed: %s [status=
=3D0x%x if_index=3D%d]",
+            "WFP block: %s block filters using service failed: %s [status=
=3D0x%x if_index=3D%lu]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number=
, &gc), ack.error_number,
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
     addr_row->Address =3D sockaddr_inet(msg->family, &msg->address);
     addr_row->OnLinkPrefixLength =3D (UINT8)msg->prefix_len;

-    if (msg->iface.index !=3D -1)
+    if (msg->iface.index !=3D TUN_ADAPTER_INDEX_INVALID)
     {
         addr_row->InterfaceIndex =3D msg->iface.index;
     }
@@ -667,7 +667,7 @@
     fwd_row->DestinationPrefix.PrefixLength =3D (UINT8)msg->prefix_len;
     fwd_row->NextHop =3D sockaddr_inet(msg->family, &msg->gateway);

-    if (msg->iface.index !=3D -1)
+    if (msg->iface.index !=3D TUN_ADAPTER_INDEX_INVALID)
     {
         fwd_row->InterfaceIndex =3D msg->iface.index;
     }
@@ -1010,7 +1010,7 @@
  * if action =3D "set" then "static" is added before $addr
  */
 static DWORD
-netsh_wins_cmd(const wchar_t *action, int if_index, const wchar_t *addr)
+netsh_wins_cmd(const wchar_t *action, DWORD if_index, const wchar_t *addr)
 {
     DWORD err =3D 0;
     int timeout =3D 30000; /* in msec */
@@ -1036,7 +1036,7 @@
     /* cmd template:
      * netsh interface ip $action wins $if_name $static $addr
      */
-    const wchar_t *fmt =3D L"netsh interface ip %ls wins %d %ls %ls";
+    const wchar_t *fmt =3D L"netsh interface ip %ls wins %lu %ls %ls";

     /* max cmdline length in wchars -- include room for worst case and som=
e */
     size_t ncmdline =3D wcslen(fmt) + 11 /*if_index*/ + wcslen(action) + w=
cslen(addr)
@@ -2984,7 +2984,7 @@
          */
     }

-    int *if_index =3D malloc(sizeof(msg->iface.index));
+    PDWORD if_index =3D malloc(sizeof(msg->iface.index));
     if (if_index)
     {
         *if_index =3D msg->iface.index;
@@ -3017,7 +3017,7 @@
     /* cmd template:
      * netsh interface ipv4 set address name=3D$if_index source=3Ddhcp
      */
-    const wchar_t *fmt =3D L"netsh interface ipv4 set address name=3D\"%d\=
" source=3Ddhcp";
+    const wchar_t *fmt =3D L"netsh interface ipv4 set address name=3D\"%lu=
\" source=3Ddhcp";

     /* max cmdline length in wchars -- include room for if index:
      * 10 chars for 32 bit int in decimal and +1 for NUL
@@ -3250,7 +3250,7 @@
                     break;

                 case undo_wins:
-                    netsh_wins_cmd(L"delete", *(int *)item->data, NULL);
+                    netsh_wins_cmd(L"delete", *(PDWORD)item->data, NULL);
                     break;

                 case wfp_block:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81
Gerrit-Change-Number: 1519
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--IbVBcuAZuNc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1519?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Win32:=
 Make interface index DWORD consistently<br><br>Previously we had a weird m=
ix of int and DWORD. But the<br>Win32 APIs seem to be consistent (they have=
 different names,<br>but NET_IFINDEX is ULONG is DWORD). So use that.<br><b=
r>Note that this fixes some smaller issues in surrounding<br>code that are =
not strictly related but were found while<br>scanning the code. Mostly abou=
t needlessly converting<br>all DWORD values to int for printf().<br><br>Cha=
nge-Id: I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1519<br>Me=
ssage-Id: &lt;20260311163852.21387-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36021.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M include/openvp=
n-msg.h<br>M src/openvpn/dns.c<br>M src/openvpn/route.c<br>M src/openvpn/tu=
n.c<br>M src/openvpn/tun.h<br>M src/openvpn/win32.c<br>M src/openvpnserv/in=
teractive.c<br>7 files changed, 78 insertions(+), 87 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/19/1519/7</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/include/openvpn-msg.h b/include/openvpn-=
msg.h</span><br><span>index a0cec53..34f50c8 100644</span><br><span>--- a/i=
nclude/openvpn-msg.h</span><br><span>+++ b/include/openvpn-msg.h</span><br>=
<span>@@ -66,7 +66,8 @@</span><br><span> </span><br><span> typedef struct</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define T=
UN_ADAPTER_INDEX_INVALID ((DWORD)-1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    DWORD index;</span><br><span>     char name[256];</spa=
n><br><span> } interface_t;</span><br><span> </span><br><span>diff --git a/=
src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 4a4bb0c..a42d03=
2 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/=
openvpn/dns.c</span><br><span>@@ -468,9 +468,10 @@</span><br><span>     mak=
e_domain_list(&quot;dns search domains&quot;, search_domains, false, nrpt.s=
earch_domains,</span><br><span>                      sizeof(nrpt.search_dom=
ains));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    msg(D_LOW, &quot;%s NRPT DNS%s%s on &#39;%s&#39; (if_index =3D %d) =
using service&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_LOW, &quot;%s NRPT DNS%s%s on &#39;%s&#39; (if_index =3D %lu) us=
ing service&quot;,</span><br><span>         (add ? &quot;Setting&quot; : &q=
uot;Deleting&quot;), nrpt.resolve_domains[0] !=3D 0 ? &quot;, resolve domai=
ns&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        nrpt.search_domains[0] !=3D 0 ? &quot;, search domains&quot; : &=
quot;&quot;, nrpt.iface.name, nrpt.iface.index);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        nrpt.search_domains[0] !=3D 0 ? &quot;=
, search domains&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        nrpt.iface.name, nrpt.iface.index);</span><br><s=
pan> </span><br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, =
sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><spa=
n>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>in=
dex b196713..1cfbf80 100644</span><br><span>--- a/src/openvpn/route.c</span=
><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -2389,8 +2389,8 @@<=
/span><br><span>         status =3D GetIpForwardTable(rt, &amp;size, TRUE);=
</span><br><span>         if (status !=3D NO_ERROR)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_=
ROUTE, &quot;NOTE: GetIpForwardTable returned error: %s (code=3D%u)&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                strerr=
or_win32(status, gc), (unsigned int)status);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(D_ROUTE, &quot;NOTE: GetIpForwardT=
able returned error: %s (code=3D%lu)&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                strerror_win32(status, gc), status)=
;</span><br><span>             rt =3D NULL;</span><br><span>         }</spa=
n><br><span>     }</span><br><span>@@ -2470,8 +2470,8 @@</span><br><span>  =
       }</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;TEST ROUTES: %d/%d succe=
eded len=3D%d ret=3D%d a=3D%d u/d=3D%s&quot;, good, count, len,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        (int)ret, ambig, adapter_=
up ? &quot;up&quot; : &quot;down&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_ROUTE, &quot;TEST ROUTES: %d/%d succeeded le=
n=3D%d ret=3D%u a=3D%d u/d=3D%s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        good, count, len, ret, ambig, adapter_up ? &quot=
;up&quot; : &quot;down&quot;);</span><br><span> </span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span>     return ret;</span><br><span>@@ -2495,9 +2=
495,9 @@</span><br><span>             const DWORD index =3D row-&gt;dwForwa=
rdIfIndex;</span><br><span>             const DWORD metric =3D row-&gt;dwFo=
rwardMetric1;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            dmsg(D_ROUTE_DEBUG, &quot;GDGR: route[%lu] %s/%s i=3D=
%d m=3D%d&quot;, i,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            dmsg(D_ROUTE_DEBUG, &quot;GDGR: route[%lu] %s/%s i=3D%lu m=3D%l=
u&quot;, i,</span><br><span>                  print_in_addr_t((in_addr_t)ne=
t, 0, &amp;gc), print_in_addr_t((in_addr_t)mask, 0, &amp;gc),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                 (int)index, (int)m=
etric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
     index, metric);</span><br><span> </span><br><span>             if (!ne=
t &amp;&amp; !mask &amp;&amp; metric &lt; lowest_metric)</span><br><span>  =
           {</span><br><span>@@ -2508,7 +2508,7 @@</span><br><span>        =
 }</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    dmsg(D_ROUTE_DEBUG, &quot;GDGR: best=3D%d lm=3D%u=
&quot;, best, (unsigned int)lowest_metric);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    dmsg(D_ROUTE_DEBUG, &quot;GDGR: best=3D%d lm=3D=
%lu&quot;, best, lowest_metric);</span><br><span> </span><br><span>     gc_=
free(&amp;gc);</span><br><span>     return ret;</span><br><span>@@ -2537,12=
 +2537,12 @@</span><br><span>     status =3D GetBestInterfaceEx((struct soc=
kaddr *)dest, &amp;best_if_index);</span><br><span>     if (status !=3D NO_=
ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(D_ROUTE, &quot;NOTE: GetBestInterfaceEx returned error:=
 %s (code=3D%u)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            strerror_win32(status, gc), (unsigned int)status);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;NOTE=
: GetBestInterfaceEx returned error: %s (code=3D%lu)&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            strerror_win32(status, =
gc), status);</span><br><span>         goto done;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_ROUTE_DEBUG, &quot;GetBestInterfaceEx() returned if=3D%d&quot;, (int)be=
st_if_index);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(D_ROUTE_DEBUG, &quot;GetBestInterfaceEx() returned if=3D%lu&quot;, best_i=
f_index);</span><br><span> </span><br><span>     /* get the routing informa=
tion (such as NextHop) for the destination and interface */</span><br><span=
>     NET_LUID luid;</span><br><span>@@ -2552,8 +2552,8 @@</span><br><span>=
     status =3D GetBestRoute2(&amp;luid, best_if_index, NULL, dest, 0, best=
_route, &amp;best_src);</span><br><span>     if (status !=3D NO_ERROR)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(D_ROUTE, &quot;NOTE: GetIpForwardEntry2 returned error: %s (code=
=3D%u)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    strerror_win32(status, gc), (unsigned int)status);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_ROUTE, &quot;NOTE: GetIpFo=
rwardEntry2 returned error: %s (code=3D%lu)&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            strerror_win32(status, gc), stat=
us);</span><br><span>         goto done;</span><br><span>     }</span><br><=
span> </span><br><span>@@ -2647,15 +2647,14 @@</span><br><span>            =
 print_in_addr_t(r-&gt;gateway, 0, &amp;gc), count);</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 dmsg(D_ROUTE_DEBUG, &quot;DEBUG: route find if: on_tun=3D%d count=3D%d ind=
ex=3D%d&quot;, on_tun, count,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         (int)ret);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    dmsg(D_ROUTE_DEBUG, &quot;DEBUG: route find if: on_tun=3D%d cou=
nt=3D%d index=3D%lu&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         on_tun, count, ret);</span><br><span> </span><br><span>    =
 gc_free(&amp;gc);</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span> /* IPv6 implementation using GetBestRoute2()=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   (TBD: dynamic li=
nking so the binary can still run on XP?)</span><br><span>  * https://msdn.=
microsoft.com/en-us/library/windows/desktop/aa365922(v=3Dvs.85).aspx</span>=
<br><span>  * https://msdn.microsoft.com/en-us/library/windows/desktop/aa81=
4411(v=3Dvs.85).aspx</span><br><span>  */</span><br><span>@@ -2687,8 +2686,=
8 @@</span><br><span>         print_in6_addr(BestRoute.DestinationPrefix.Pr=
efix.Ipv6.sin6_addr, 0, &amp;gc),</span><br><span>         BestRoute.Destin=
ationPrefix.PrefixLength,</span><br><span>         print_in6_addr(BestRoute=
.NextHop.Ipv6.sin6_addr, 0, &amp;gc));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    msg(D_ROUTE, &quot;GDG6: Metric=3D%d, Loopback=3D%d, A=
A=3D%d, I=3D%d&quot;, (int)BestRoute.Metric,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        (int)BestRoute.Loopback, (int)BestRoute.Auto=
configureAddress, (int)BestRoute.Immortal);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;GDG6: Metric=3D%lu, Loopback=
=3D%u, AA=3D%u, I=3D%u&quot;, BestRoute.Metric,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        BestRoute.Loopback, BestRoute.Autoconfi=
gureAddress, BestRoute.Immortal);</span><br><span> </span><br><span>     rg=
i6-&gt;gateway.addr_ipv6 =3D BestRoute.NextHop.Ipv6.sin6_addr;</span><br><s=
pan>     rgi6-&gt;adapter_index =3D BestRoute.InterfaceIndex;</span><br><sp=
an>@@ -2753,8 +2752,8 @@</span><br><span>         else</span><br><span>    =
     {</span><br><span>             /* failed, try increasing the metric to=
 work around Vista issue */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            const unsigned int forward_metric_limit =3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                2048; /* iterativel=
y retry higher metrics up to this limit */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            /* iteratively retry higher metrics up t=
o this limit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        const DWORD forward_metric_limit =3D 2048;</span><br><span> </span>=
<br><span>             for (; fr.dwForwardMetric1 &lt;=3D forward_metric_li=
mit; ++fr.dwForwardMetric1)</span><br><span>             {</span><br><span>=
@@ -2767,8 +2766,8 @@</span><br><span>                     if (status =3D=
=3D NO_ERROR)</span><br><span>                     {</span><br><span>      =
                   msg(D_ROUTE,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                            &quot;ROUTE: CreateIpForwardEntry suc=
ceeded with dwForwardMetric1=3D%u and dwForwardType=3D%u&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                            (unsi=
gned int)fr.dwForwardMetric1, (unsigned int)fr.dwForwardType);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            &quo=
t;ROUTE: CreateIpForwardEntry succeeded with dwForwardMetric1=3D%lu and dwF=
orwardType=3D%lu&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            fr.dwForwardMetric1, fr.dwForwardType);</sp=
an><br><span>                         ret =3D RTA_SUCCESS;</span><br><span>=
                         goto doublebreak;</span><br><span>                =
     }</span><br><span>@@ -2790,8 +2789,8 @@</span><br><span>              =
   {</span><br><span>                     msg(M_WARN,</span><br><span>     =
                    &quot;ERROR: route addition failed using CreateIpForwar=
dEntry: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 &quot;%s [status=3D%u if_index=3D%u]&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                        strerror_win=
32(status, &amp;gc), (unsigned int)status, (unsigned int)if_index);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        &qu=
ot;%s [status=3D%lu if_index=3D%lu]&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        strerror_win32(status, &amp;=
gc), status, if_index);</span><br><span>                 }</span><br><span>=
             }</span><br><span>         }</span><br><span>@@ -2855,7 +2854,=
7 @@</span><br><span>         ret =3D (ack.error_number =3D=3D ERROR_OBJECT=
_ALREADY_EXISTS) ? RTA_EEXIST : RTA_ERROR;</span><br><span>         if (ret=
 =3D=3D RTA_ERROR)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;ERROR: route %s faile=
d using service: %s [status=3D%u if_index=3D%d]&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;ERROR: rou=
te %s failed using service: %s [status=3D%u if_index=3D%lu]&quot;,</span><b=
r><span>                 (add ? &quot;addition&quot; : &quot;deletion&quot;=
), strerror_win32(ack.error_number, &amp;gc),</span><br><span>             =
    ack.error_number, rt-&gt;iface.index);</span><br><span>         }</span=
><br><span>@@ -2869,17 +2868,12 @@</span><br><span>     return ret;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR =
on error */</span><br><span> static int</span><br><span> do_route_ipv4_serv=
ice(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)</s=
pan><br><span> {</span><br><span>     DWORD if_index =3D windows_route_find=
_if_index(r, tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (if_index =3D=3D ~0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (if_index =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>    =
 {</span><br><span>         return RTA_ERROR;</span><br><span>     }</span>=
<br><span>@@ -3023,10 +3017,6 @@</span><br><span>     return status;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /* Returns RTA_SUCCESS on success, =
RTA_EEXIST if route exists, RTA_ERROR on error */</span><br><span> static i=
nt</span><br><span> add_route_service(const struct route_ipv4 *r, const str=
uct tuntap *tt)</span><br><span>@@ -3057,14 +3047,14 @@</span><br><span> fo=
rmat_route_entry(const MIB_IPFORWARDROW *r, struct gc_arena *gc)</span><br>=
<span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;ou=
t, &quot;%s %s %s p=3D%d i=3D%d t=3D%d pr=3D%d a=3D%d h=3D%d m=3D%d/%d/%d/%=
d/%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_=
printf(&amp;out, &quot;%s %s %s p=3D%lu i=3D%lu t=3D%lu pr=3D%lu a=3D%lu h=
=3D%lu m=3D%lu/%lu/%lu/%lu/%lu&quot;,</span><br><span>                print=
_in_addr_t(r-&gt;dwForwardDest, IA_NET_ORDER, gc),</span><br><span>        =
        print_in_addr_t(r-&gt;dwForwardMask, IA_NET_ORDER, gc),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-               print_in_addr_t(r-=
&gt;dwForwardNextHop, IA_NET_ORDER, gc), (int)r-&gt;dwForwardPolicy,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-               (int)r-&gt;dw=
ForwardIfIndex, (int)r-&gt;dwForwardType, (int)r-&gt;dwForwardProto,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-               (int)r-&gt;dw=
ForwardAge, (int)r-&gt;dwForwardNextHopAS, (int)r-&gt;dwForwardMetric1,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-               (int)r-&gt=
;dwForwardMetric2, (int)r-&gt;dwForwardMetric3, (int)r-&gt;dwForwardMetric4=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               (int)=
r-&gt;dwForwardMetric5);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+               print_in_addr_t(r-&gt;dwForwardNextHop, IA_NET_ORDER, g=
c), r-&gt;dwForwardPolicy,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+               r-&gt;dwForwardIfIndex, r-&gt;dwForwardType, r-&gt;dw=
ForwardProto,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
         r-&gt;dwForwardAge, r-&gt;dwForwardNextHopAS, r-&gt;dwForwardMetri=
c1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               r=
-&gt;dwForwardMetric2, r-&gt;dwForwardMetric3, r-&gt;dwForwardMetric4,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+               r-&gt;dwF=
orwardMetric5);</span><br><span>     return BSTR(&amp;out);</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.c b/src/=
openvpn/tun.c</span><br><span>index 7a173c5..b37a2ea 100644</span><br><span=
>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br>=
<span>@@ -158,7 +158,7 @@</span><br><span> </span><br><span>     if (ack.er=
ror_number !=3D NO_ERROR)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;TUN: %s address failed=
 using service: %s [status=3D%u if_index=3D%d]&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;TUN: %s address=
 failed using service: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><sp=
an>             (add ? &quot;adding&quot; : &quot;deleting&quot;), strerror=
_win32(ack.error_number, &amp;gc), ack.error_number,</span><br><span>      =
       addr.iface.index);</span><br><span>         goto out;</span><br><spa=
n>@@ -220,7 +220,7 @@</span><br><span>         strncpy(dns.domains + dstlen=
, o-&gt;domain_search_list[i], srclen + 1);</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LO=
W, &quot;%s DNS domains on &#39;%s&#39; (if_index =3D %d) using service&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &=
quot;%s DNS domains on &#39;%s&#39; (if_index =3D %lu) using service&quot;,=
</span><br><span>         (add ? &quot;Setting&quot; : &quot;Deleting&quot;=
), dns.iface.name, dns.iface.index);</span><br><span>     if (!send_msg_ise=
rvice(o-&gt;msg_channel, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&quot;))=
</span><br><span>     {</span><br><span>@@ -289,7 +289,7 @@</span><br><span=
>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;%s %s dns servers on &=
#39;%s&#39; (if_index =3D %d) using service&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;%s %s dns servers on &#=
39;%s&#39; (if_index =3D %lu) using service&quot;,</span><br><span>        =
 (add ? &quot;Setting&quot; : &quot;Deleting&quot;), ip_proto_name, dns.ifa=
ce.name, dns.iface.index);</span><br><span> </span><br><span>     if (!send=
_msg_iservice(pipe, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&quot;))</spa=
n><br><span>@@ -346,7 +346,7 @@</span><br><span>         wins.addr[i].ipv4.=
s_addr =3D htonl(tt-&gt;options.wins[i]);</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW,=
 &quot;%s WINS servers on &#39;%s&#39; (if_index =3D %d) using service&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &q=
uot;%s WINS servers on &#39;%s&#39; (if_index =3D %lu) using service&quot;,=
</span><br><span>         (add ? &quot;Setting&quot; : &quot;Deleting&quot;=
), wins.iface.name, wins.iface.index);</span><br><span> </span><br><span>  =
   if (!send_msg_iservice(pipe, &amp;wins, sizeof(wins), &amp;ack, &quot;TU=
N&quot;))</span><br><span>@@ -357,8 +357,8 @@</span><br><span>     if (ack.=
error_number !=3D NO_ERROR)</span><br><span>     {</span><br><span>        =
 msg(M_WARN, &quot;TUN: %s WINS failed using service: %s [status=3D%u if_na=
me=3D%s]&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      (add ? &quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack=
.error_number, &amp;gc), ack.error_number,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            wins.iface.name);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            (add ? &quot;adding&quot; : &quo=
t;deleting&quot;), strerror_win32(ack.error_number, &amp;gc),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            ack.error_number, win=
s.iface.name);</span><br><span>         goto out;</span><br><span>     }</s=
pan><br><span> </span><br><span>@@ -398,13 +398,13 @@</span><br><span> </sp=
an><br><span>     if (ack.error_number !=3D NO_ERROR)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFAT=
AL, &quot;TUN: setting %s mtu using service failed: %s [status=3D%u if_inde=
x=3D%d]&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_NONFATAL, &quot;TUN: setting %s mtu using service failed: %s [stat=
us=3D%u if_index=3D%lu]&quot;,</span><br><span>             family_name, st=
rerror_win32(ack.error_number, &amp;gc), ack.error_number,</span><br><span>=
             mtu_msg.iface.index);</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(M_INFO, &quot;%s MTU set to %d on interface %d using =
service&quot;, family_name, mtu,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_INFO, &quot;%s MTU set to %d on interface %lu us=
ing service&quot;, family_name, mtu,</span><br><span>             mtu_msg.i=
face.index);</span><br><span>         ret =3D true;</span><br><span>     }<=
/span><br><span>@@ -3422,7 +3422,7 @@</span><br><span>     if (dev_info_set=
 =3D=3D INVALID_HANDLE_VALUE)</span><br><span>     {</span><br><span>      =
   err =3D GetLastError();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(M_FATAL, &quot;Error [%u] opening device information set k=
ey: %s&quot;, (unsigned int)err,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_FATAL, &quot;Error [%lu] opening device informat=
ion set key: %s&quot;, err,</span><br><span>             strerror_win32(err=
, gc));</span><br><span>     }</span><br><span> </span><br><span>@@ -4105,7=
 +4105,7 @@</span><br><span> </span><br><span>     if ((status =3D GetAdapt=
ersInfo(NULL, &amp;size)) !=3D ERROR_BUFFER_OVERFLOW)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, =
&quot;GetAdaptersInfo #1 failed (status=3D%u) : %s&quot;, (unsigned int)sta=
tus,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_I=
NFO, &quot;GetAdaptersInfo #1 failed (status=3D%lu) : %s&quot;, status,</sp=
an><br><span>             strerror_win32(status, gc));</span><br><span>    =
 }</span><br><span>     else</span><br><span>@@ -4113,7 +4113,7 @@</span><b=
r><span>         pi =3D (PIP_ADAPTER_INFO)gc_malloc(size, false, gc);</span=
><br><span>         if ((status =3D GetAdaptersInfo(pi, &amp;size)) !=3D NO=
_ERROR)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_INFO, &quot;GetAdaptersInfo #2 failed (statu=
s=3D%u) : %s&quot;, (unsigned int)status,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            msg(M_INFO, &quot;GetAdaptersInfo #2 fail=
ed (status=3D%lu) : %s&quot;, status,</span><br><span>                 stre=
rror_win32(status, gc));</span><br><span>             pi =3D NULL;</span><b=
r><span>         }</span><br><span>@@ -4132,19 +4132,19 @@</span><br><span>=
     {</span><br><span>         if ((status =3D GetPerAdapterInfo(index, NU=
LL, &amp;size)) !=3D ERROR_BUFFER_OVERFLOW)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &q=
uot;GetPerAdapterInfo #1 failed (status=3D%u) : %s&quot;, (unsigned int)sta=
tus,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_INFO, &quot;GetPerAdapterInfo #1 failed (status=3D%lu) : %s&quot;, statu=
s,</span><br><span>                 strerror_win32(status, gc));</span><br>=
<span>         }</span><br><span>         else</span><br><span>         {</=
span><br><span>             pi =3D (PIP_PER_ADAPTER_INFO)gc_malloc(size, fa=
lse, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if ((status =3D GetPerAdapterInfo((ULONG)index, pi, &amp;size)) =3D=3D ERRO=
R_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if ((status =3D GetPerAdapterInfo(index, pi, &amp;size)) =3D=3D ERROR_SU=
CCESS)</span><br><span>             {</span><br><span>                 retu=
rn pi;</span><br><span>             }</span><br><span>             else</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                msg(M_INFO, &quot;GetPerAdapterInfo #2 failed (status=
=3D%u) : %s&quot;, (unsigned int)status,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                msg(M_INFO, &quot;GetPerAdapterInfo #2=
 failed (status=3D%lu) : %s&quot;, status,</span><br><span>                =
     strerror_win32(status, gc));</span><br><span>             }</span><br>=
<span>         }</span><br><span>@@ -4161,7 +4161,7 @@</span><br><span> </s=
pan><br><span>     if ((status =3D GetInterfaceInfo(NULL, &amp;size)) !=3D =
ERROR_INSUFFICIENT_BUFFER)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;GetInterfaceInfo #1 f=
ailed (status=3D%u) : %s&quot;, (unsigned int)status,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;GetInterfaceInf=
o #1 failed (status=3D%lu) : %s&quot;, status,</span><br><span>            =
 strerror_win32(status, gc));</span><br><span>     }</span><br><span>     e=
lse</span><br><span>@@ -4173,7 +4173,7 @@</span><br><span>         }</span>=
<br><span>         else</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;GetInterfaceInfo=
 #2 failed (status=3D%u) : %s&quot;, (unsigned int)status,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;GetInt=
erfaceInfo #2 failed (status=3D%lu) : %s&quot;, status,</span><br><span>   =
              strerror_win32(status, gc));</span><br><span>         }</span=
><br><span>     }</span><br><span>@@ -4450,8 +4450,8 @@</span><br><span>   =
      list =3D list-&gt;Next;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_ROUTE_DEBUG, &q=
uot;DEBUG: IP Locate: ip=3D%s nm=3D%s index=3D%d count=3D%d metric=3D%d&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         print_in_=
addr_t(ip, 0, &amp;gc), print_in_addr_t(highest_netmask, 0, &amp;gc), (int)=
ret,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_ROUT=
E_DEBUG, &quot;DEBUG: IP Locate: ip=3D%s nm=3D%s index=3D%lu count=3D%d met=
ric=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     print_in_addr_t(ip, 0, &amp;gc), print_in_addr_t(highest_netmask, 0, &=
amp;gc), ret,</span><br><span>          count ? *count : -1, lowest_metric)=
;</span><br><span> </span><br><span>     if (ret =3D=3D TUN_ADAPTER_INDEX_I=
NVALID &amp;&amp; count)</span><br><span>@@ -4520,7 +4520,7 @@</span><br><s=
pan>             DWORD status;</span><br><span>             const DWORD con=
text =3D ip-&gt;Context;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if ((status =3D DeleteIPAddress((ULONG)con=
text)) =3D=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if ((status =3D DeleteIPAddress(context)) =3D=3D NO_ERROR)<=
/span><br><span>             {</span><br><span>                 msg(M_INFO,=
 &quot;Successfully deleted previously set dynamic IP/netmask: %s/%s&quot;,=
</span><br><span>                     ip-&gt;IpAddress.String, ip-&gt;IpMas=
k.String);</span><br><span>@@ -4531,8 +4531,8 @@</span><br><span>          =
       if (strcmp(ip-&gt;IpAddress.String, empty) || strcmp(ip-&gt;IpMask.S=
tring, empty))</span><br><span>                 {</span><br><span>         =
            msg(M_INFO,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        &quot;NOTE: could not delete previously set dynam=
ic IP/netmask: %s/%s (status=3D%u)&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        ip-&gt;IpAddress.String, ip-&gt=
;IpMask.String, (unsigned int)status);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        &quot;NOTE: could not delete pre=
viously set dynamic IP/netmask: %s/%s (status=3D%lu)&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        ip-&gt;IpAd=
dress.String, ip-&gt;IpMask.String, status);</span><br><span>              =
   }</span><br><span>             }</span><br><span>             ip =3D ip-=
&gt;Next;</span><br><span>@@ -4628,7 +4628,7 @@</span><br><span> show_adapt=
er(msglvl_t msglevel, const IP_ADAPTER_INFO *a, struct gc_arena *gc)</span>=
<br><span> {</span><br><span>     msg(msglevel, &quot;%s&quot;, a-&gt;Descr=
iption);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msgle=
vel, &quot;  Index =3D %d&quot;, (int)a-&gt;Index);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;  Index =3D %lu&q=
uot;, a-&gt;Index);</span><br><span>     msg(msglevel, &quot;  GUID =3D %s&=
quot;, a-&gt;AdapterName);</span><br><span>     msg(msglevel, &quot;  IP =
=3D %s&quot;, format_ip_addr_string(&amp;a-&gt;IpAddressList, gc));</span><=
br><span>     msg(msglevel, &quot;  MAC =3D %s&quot;, format_hex_ex(a-&gt;A=
ddress, a-&gt;AddressLength, 0, 1, &quot;:&quot;, gc));</span><br><span>@@ =
-4804,8 +4804,8 @@</span><br><span>         else</span><br><span>         {=
</span><br><span>             msg(M_WARN,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                &quot;NOTE: Release of DHCP-assigned IP=
 address lease on TAP-Windows adapter failed: %s (code=3D%u)&quot;,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                strerror_win3=
2(status, &amp;gc), (unsigned int)status);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                &quot;NOTE: Release of DHCP-assigned=
 IP address lease on TAP-Windows adapter failed: %s (code=3D%lu)&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                strerro=
r_win32(status, &amp;gc), status);</span><br><span>         }</span><br><sp=
an>     }</span><br><span> </span><br><span>@@ -4845,8 +4845,8 @@</span><br=
><span>         else</span><br><span>         {</span><br><span>           =
  msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        &quot;WARNING: Failed to renew DHCP IP address lease on TAP-Windows=
 adapter: %s (code=3D%u)&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                strerror_win32(status, &amp;gc), (unsigned int)st=
atus);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   &quot;WARNING: Failed to renew DHCP IP address lease on TAP-Windows adap=
ter: %s (code=3D%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                strerror_win32(status, &amp;gc), status);</span><br=
><span>         }</span><br><span>     }</span><br><span>     gc_free(&amp;=
gc);</span><br><span>@@ -5209,12 +5209,12 @@</span><br><span> </span><br><s=
pan>     if (ack.error_number !=3D NO_ERROR)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot=
;TUN: enabling dhcp using service failed: %s [status=3D%u if_index=3D%d]&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_N=
ONFATAL, &quot;TUN: enabling dhcp using service failed: %s [status=3D%u if_=
index=3D%lu]&quot;,</span><br><span>             strerror_win32(ack.error_n=
umber, &amp;gc), ack.error_number, dhcp.iface.index);</span><br><span>     =
}</span><br><span>     else</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;DHCP enabled on inte=
rface %d using service&quot;, dhcp.iface.index);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;DHCP enabled on inte=
rface %lu using service&quot;, dhcp.iface.index);</span><br><span>         =
ret =3D true;</span><br><span>     }</span><br><span> </span><br><span>@@ -=
5503,7 +5503,7 @@</span><br><span>     /* flush arp cache */</span><br><spa=
n>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6 &amp;&a=
mp; index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        DWORD status =3D -1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD status =
=3D (DWORD)-1;</span><br><span> </span><br><span>         if (tt-&gt;option=
s.msg_channel)</span><br><span>         {</span><br><span>@@ -5527,7 +5527,=
7 @@</span><br><span>         {</span><br><span>             msg(M_INFO, &q=
uot;Successful ARP Flush on interface [%lu] %s&quot;, index, device_guid);<=
/span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        else if (status !=3D -1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else if (status !=3D (DWORD)-1)</span><br><span> =
        {</span><br><span>             msg(D_TUNTAP_INFO,</span><br><span> =
                &quot;NOTE: FlushIpNetTable failed on interface [%lu] %s (s=
tatus=3D%lu) : %s&quot;, index,</span><br><span>@@ -6221,11 +6221,12 @@</sp=
an><br><span>     if (tt-&gt;ipapi_context_defined)</span><br><span>     {<=
/span><br><span>         DWORD status;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>         if ((status =3D DeleteIPAddres=
s(tt-&gt;ipapi_context)) !=3D NO_ERROR)</span><br><span>         {</span><b=
r><span>             msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                &quot;Warning: DeleteIPAddress[%u] failed on TAP=
-Windows adapter, status=3D%u : %s&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                (unsigned int)tt-&gt;ipapi_context, (un=
signed int)status, strerror_win32(status, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;Warning: DeleteIPAd=
dress[%lu] failed on TAP-Windows adapter, status=3D%lu : %s&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                tt-&gt;ipapi=
_context, status, strerror_win32(status, &amp;gc));</span><br><span>       =
  }</span><br><span>     }</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index 4d6dfbb..ecb5e88=
 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/o=
penvpn/tun.h</span><br><span>@@ -61,8 +61,6 @@</span><br><span> </span><br>=
<span> #if defined(_WIN32) || defined(TARGET_ANDROID) || defined(DHCP_UNIT_=
TEST)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> /* time constants for --ip-win3=
2 adaptive */</span><br><span> #define IPW32_SET_ADAPTIVE_DELAY_WINDOW 300<=
/span><br><span> #define IPW32_SET_ADAPTIVE_TRY_NETSH    20</span><br><span=
>@@ -230,7 +228,7 @@</span><br><span>     in_addr_t adapter_netmask;</span>=
<br><span> </span><br><span>     /* Windows adapter index for TAP-Windows a=
dapter,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * ~0 if u=
ndefined */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * T=
UN_ADAPTER_INDEX_INVALID if undefined */</span><br><span>     DWORD adapter=
_index;</span><br><span> </span><br><span>     int standby_iter;</span><br>=
<span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><spa=
n>index ac449fd..b2a7331 100644</span><br><span>--- a/src/openvpn/win32.c</=
span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -1185,7 +1185,7=
 @@</span><br><span>     if (ack.error_number !=3D NO_ERROR)</span><br><spa=
n>     {</span><br><span>         msg(M_WARN,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            &quot;WFP block: %s block filters using=
 service failed: %s [status=3D0x%x if_index=3D%d]&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;WFP block: %s block =
filters using service failed: %s [status=3D0x%x if_index=3D%lu]&quot;,</spa=
n><br><span>             (add ? &quot;adding&quot; : &quot;deleting&quot;),=
 strerror_win32(ack.error_number, &amp;gc), ack.error_number,</span><br><sp=
an>             data.iface.index);</span><br><span>         goto out;</span=
><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/int=
eractive.c</span><br><span>index 09c709e..b50aeb3 100644</span><br><span>--=
- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/int=
eractive.c</span><br><span>@@ -96,7 +96,7 @@</span><br><span> typedef struc=
t</span><br><span> {</span><br><span>     HANDLE engine;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int index;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    DWORD index;</span><br><span>     int met=
ric_v4;</span><br><span>     int metric_v6;</span><br><span> } wfp_block_da=
ta_t;</span><br><span>@@ -584,7 +584,7 @@</span><br><span>     addr_row-&gt=
;Address =3D sockaddr_inet(msg-&gt;family, &amp;msg-&gt;address);</span><br=
><span>     addr_row-&gt;OnLinkPrefixLength =3D (UINT8)msg-&gt;prefix_len;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (msg-&gt;iface.index !=3D -1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (msg-&gt;iface.index !=3D TUN_ADAPTER_INDEX_INVALID)</s=
pan><br><span>     {</span><br><span>         addr_row-&gt;InterfaceIndex =
=3D msg-&gt;iface.index;</span><br><span>     }</span><br><span>@@ -667,7 +=
667,7 @@</span><br><span>     fwd_row-&gt;DestinationPrefix.PrefixLength =
=3D (UINT8)msg-&gt;prefix_len;</span><br><span>     fwd_row-&gt;NextHop =3D=
 sockaddr_inet(msg-&gt;family, &amp;msg-&gt;gateway);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (msg-&gt;iface.ind=
ex !=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
msg-&gt;iface.index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {<=
/span><br><span>         fwd_row-&gt;InterfaceIndex =3D msg-&gt;iface.index=
;</span><br><span>     }</span><br><span>@@ -1010,7 +1010,7 @@</span><br><s=
pan>  * if action =3D &quot;set&quot; then &quot;static&quot; is added befo=
re $addr</span><br><span>  */</span><br><span> static DWORD</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-netsh_wins_cmd(const wchar_t *action,=
 int if_index, const wchar_t *addr)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+netsh_wins_cmd(const wchar_t *action, DWORD if_index, const=
 wchar_t *addr)</span><br><span> {</span><br><span>     DWORD err =3D 0;</s=
pan><br><span>     int timeout =3D 30000; /* in msec */</span><br><span>@@ =
-1036,7 +1036,7 @@</span><br><span>     /* cmd template:</span><br><span>  =
    * netsh interface ip $action wins $if_name $static $addr</span><br><spa=
n>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const w=
char_t *fmt =3D L&quot;netsh interface ip %ls wins %d %ls %ls&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *fmt =3D=
 L&quot;netsh interface ip %ls wins %lu %ls %ls&quot;;</span><br><span> </s=
pan><br><span>     /* max cmdline length in wchars -- include room for wors=
t case and some */</span><br><span>     size_t ncmdline =3D wcslen(fmt) + 1=
1 /*if_index*/ + wcslen(action) + wcslen(addr)</span><br><span>@@ -2984,7 +=
2984,7 @@</span><br><span>          */</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int *if_index=
 =3D malloc(sizeof(msg-&gt;iface.index));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    PDWORD if_index =3D malloc(sizeof(msg-&gt;iface.i=
ndex));</span><br><span>     if (if_index)</span><br><span>     {</span><br=
><span>         *if_index =3D msg-&gt;iface.index;</span><br><span>@@ -3017=
,7 +3017,7 @@</span><br><span>     /* cmd template:</span><br><span>      *=
 netsh interface ipv4 set address name=3D$if_index source=3Ddhcp</span><br>=
<span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st wchar_t *fmt =3D L&quot;netsh interface ipv4 set address name=3D\&quot;%=
d\&quot; source=3Ddhcp&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const wchar_t *fmt =3D L&quot;netsh interface ipv4 set addres=
s name=3D\&quot;%lu\&quot; source=3Ddhcp&quot;;</span><br><span> </span><br=
><span>     /* max cmdline length in wchars -- include room for if index:</=
span><br><span>      * 10 chars for 32 bit int in decimal and +1 for NUL</s=
pan><br><span>@@ -3250,7 +3250,7 @@</span><br><span>                     br=
eak;</span><br><span> </span><br><span>                 case undo_wins:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    netsh=
_wins_cmd(L&quot;delete&quot;, *(int *)item-&gt;data, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    netsh_wins_cmd=
(L&quot;delete&quot;, *(PDWORD)item-&gt;data, NULL);</span><br><span>      =
               break;</span><br><span> </span><br><span>                 ca=
se wfp_block:</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail">change 1519</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I38bb2d1fa66c543e8bcf47b7d77=
b6154d1895f81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1519 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--IbVBcuAZuNc=--

