From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 12 Feb 2026 14:14:54 +0000
In-Reply-To: <gerrit.1770904306000.I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81@...2715...>
References: <gerrit.1770904306000.I38bb2d1fa66c543e8bcf47b7d77b6154d1895f81@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1b441dc16773717b9bba03b0bf738ba58eeb8b53-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JV8JPxA9Af0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JV8JPxA9Af0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail

to look at the new patch set (#2).


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
---
M include/openvpn-msg.h
M src/openvpn/dns.c
M src/openvpn/route.c
M src/openvpn/tun.c
M src/openvpn/tun.h
M src/openvpn/win32.c
M src/openvpnserv/interactive.c
7 files changed, 50 insertions(+), 60 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/19/1519/2

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
index fd388ce..2137a75 100644
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
index b196713..e141879 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
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
index ad77117..5c1ba25 100644
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
@@ -4456,8 +4456,8 @@
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
@@ -4634,7 +4634,7 @@
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
@@ -5215,12 +5215,12 @@

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

@@ -5510,7 +5510,7 @@
     /* flush arp cache */
     if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6 && index !=
=3D TUN_ADAPTER_INDEX_INVALID)
     {
-        DWORD status =3D -1;
+        DWORD status =3D (DWORD)-1;

         if (tt->options.msg_channel)
         {
@@ -5534,7 +5534,7 @@
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
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index a226e37..388f5b7 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--JV8JPxA9Af0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Win32: Make interface index DWORD consistently<b=
r><br>Previously we had a weird mix of int and DWORD. But the<br>Win32 APIs=
 seem to be consistent (they have different names,<br>but NET_IFINDEX is UL=
ONG is DWORD). So use that.<br><br>Note that this fixes some smaller issues=
 in surrounding<br>code that are not strictly related but were found while<=
br>scanning the code. Mostly about needlessly converting<br>all DWORD value=
s to int for printf().<br><br>Change-Id: I38bb2d1fa66c543e8bcf47b7d77b6154d=
1895f81<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---=
<br>M include/openvpn-msg.h<br>M src/openvpn/dns.c<br>M src/openvpn/route.c=
<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>M src/openvpn/win32.c<br>=
M src/openvpnserv/interactive.c<br>7 files changed, 50 insertions(+), 60 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/19/1519/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/include/openvpn-msg.=
h b/include/openvpn-msg.h</span><br><span>index a0cec53..34f50c8 100644</sp=
an><br><span>--- a/include/openvpn-msg.h</span><br><span>+++ b/include/open=
vpn-msg.h</span><br><span>@@ -66,7 +66,8 @@</span><br><span> </span><br><sp=
an> typedef struct</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int index;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    DWORD index;</span><br><span>     =
char name[256];</span><br><span> } interface_t;</span><br><span> </span><br=
><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>i=
ndex fd388ce..2137a75 100644</span><br><span>--- a/src/openvpn/dns.c</span>=
<br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -468,9 +468,10 @@</spa=
n><br><span>     make_domain_list(&quot;dns search domains&quot;, search_do=
mains, false, nrpt.search_domains,</span><br><span>                      si=
zeof(nrpt.search_domains));</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;%s NRPT DNS%s%s on &#39;%s&#39=
; (if_index =3D %d) using service&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_LOW, &quot;%s NRPT DNS%s%s on &#39;%s&#39; (=
if_index =3D %lu) using service&quot;,</span><br><span>         (add ? &quo=
t;Setting&quot; : &quot;Deleting&quot;), nrpt.resolve_domains[0] !=3D 0 ? &=
quot;, resolve domains&quot; : &quot;&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        nrpt.search_domains[0] !=3D 0 ? &quot;, sear=
ch domains&quot; : &quot;&quot;, nrpt.iface.name, nrpt.iface.index);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        nrpt.search_domain=
s[0] !=3D 0 ? &quot;, search domains&quot; : &quot;&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        nrpt.iface.name, nrpt.iface.=
index);</span><br><span> </span><br><span>     send_msg_iservice(o-&gt;msg_=
channel, &amp;nrpt, sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><sp=
an> }</span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.=
c</span><br><span>index b196713..e141879 100644</span><br><span>--- a/src/o=
penvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@=
 -2470,8 +2470,8 @@</span><br><span>         }</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D=
_ROUTE, &quot;TEST ROUTES: %d/%d succeeded len=3D%d ret=3D%d a=3D%d u/d=3D%=
s&quot;, good, count, len,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        (int)ret, ambig, adapter_up ? &quot;up&quot; : &quot;down&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE,=
 &quot;TEST ROUTES: %d/%d succeeded len=3D%d ret=3D%u a=3D%d u/d=3D%s&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        good, coun=
t, len, ret, ambig, adapter_up ? &quot;up&quot; : &quot;down&quot;);</span>=
<br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>     ret=
urn ret;</span><br><span>@@ -2495,9 +2495,9 @@</span><br><span>            =
 const DWORD index =3D row-&gt;dwForwardIfIndex;</span><br><span>          =
   const DWORD metric =3D row-&gt;dwForwardMetric1;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_ROUTE_DE=
BUG, &quot;GDGR: route[%lu] %s/%s i=3D%d m=3D%d&quot;, i,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_ROUTE_DEBUG, &quot=
;GDGR: route[%lu] %s/%s i=3D%lu m=3D%lu&quot;, i,</span><br><span>         =
         print_in_addr_t((in_addr_t)net, 0, &amp;gc), print_in_addr_t((in_a=
ddr_t)mask, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                 (int)index, (int)metric);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 index, metric);</span><br><span>=
 </span><br><span>             if (!net &amp;&amp; !mask &amp;&amp; metric =
&lt; lowest_metric)</span><br><span>             {</span><br><span>@@ -2508=
,7 +2508,7 @@</span><br><span>         }</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_ROUT=
E_DEBUG, &quot;GDGR: best=3D%d lm=3D%u&quot;, best, (unsigned int)lowest_me=
tric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_RO=
UTE_DEBUG, &quot;GDGR: best=3D%d lm=3D%lu&quot;, best, lowest_metric);</spa=
n><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>     r=
eturn ret;</span><br><span>@@ -2537,12 +2537,12 @@</span><br><span>     sta=
tus =3D GetBestInterfaceEx((struct sockaddr *)dest, &amp;best_if_index);</s=
pan><br><span>     if (status !=3D NO_ERROR)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_ROUTE, &quot;NO=
TE: GetBestInterfaceEx returned error: %s (code=3D%u)&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            strerror_win32(status, g=
c), (unsigned int)status);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_ROUTE, &quot;NOTE: GetBestInterfaceEx returned error: =
%s (code=3D%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            strerror_win32(status, gc), status);</span><br><span>       =
  goto done;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE_DEBUG, &quot;GetBestInterfa=
ceEx() returned if=3D%d&quot;, (int)best_if_index);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE_DEBUG, &quot;GetBestInter=
faceEx() returned if=3D%lu&quot;, best_if_index);</span><br><span> </span><=
br><span>     /* get the routing information (such as NextHop) for the dest=
ination and interface */</span><br><span>     NET_LUID luid;</span><br><spa=
n>@@ -2552,8 +2552,8 @@</span><br><span>     status =3D GetBestRoute2(&amp;=
luid, best_if_index, NULL, dest, 0, best_route, &amp;best_src);</span><br><=
span>     if (status !=3D NO_ERROR)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(D_ROUTE, &quot;NOTE: GetIp=
ForwardEntry2 returned error: %s (code=3D%u)&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            strerror_win32(status, gc), (un=
signed int)status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_ROUTE, &quot;NOTE: GetIpForwardEntry2 returned error: %s (cod=
e=3D%lu)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        strerror_win32(status, gc), status);</span><br><span>         goto =
done;</span><br><span>     }</span><br><span> </span><br><span>@@ -2647,15 =
+2647,14 @@</span><br><span>             print_in_addr_t(r-&gt;gateway, 0, =
&amp;gc), count);</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_ROUTE_DEBUG, &quot;DEBUG: r=
oute find if: on_tun=3D%d count=3D%d index=3D%d&quot;, on_tun, count,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         (int)ret);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_ROUTE_DEBUG, &qu=
ot;DEBUG: route find if: on_tun=3D%d count=3D%d index=3D%lu&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         on_tun, count, ret)=
;</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>=
     return ret;</span><br><span> }</span><br><span> </span><br><span> /* I=
Pv6 implementation using GetBestRoute2()</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *   (TBD: dynamic linking so the binary can still run o=
n XP?)</span><br><span>  * https://msdn.microsoft.com/en-us/library/windows=
/desktop/aa365922(v=3Dvs.85).aspx</span><br><span>  * https://msdn.microsof=
t.com/en-us/library/windows/desktop/aa814411(v=3Dvs.85).aspx</span><br><spa=
n>  */</span><br><span>@@ -2687,8 +2686,8 @@</span><br><span>         print=
_in6_addr(BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, 0, &amp;gc),</=
span><br><span>         BestRoute.DestinationPrefix.PrefixLength,</span><br=
><span>         print_in6_addr(BestRoute.NextHop.Ipv6.sin6_addr, 0, &amp;gc=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &=
quot;GDG6: Metric=3D%d, Loopback=3D%d, AA=3D%d, I=3D%d&quot;, (int)BestRout=
e.Metric,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (int=
)BestRoute.Loopback, (int)BestRoute.AutoconfigureAddress, (int)BestRoute.Im=
mortal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_R=
OUTE, &quot;GDG6: Metric=3D%lu, Loopback=3D%u, AA=3D%u, I=3D%u&quot;, BestR=
oute.Metric,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 BestRoute.Loopback, BestRoute.AutoconfigureAddress, BestRoute.Immortal);</=
span><br><span> </span><br><span>     rgi6-&gt;gateway.addr_ipv6 =3D BestRo=
ute.NextHop.Ipv6.sin6_addr;</span><br><span>     rgi6-&gt;adapter_index =3D=
 BestRoute.InterfaceIndex;</span><br><span>@@ -2855,7 +2854,7 @@</span><br>=
<span>         ret =3D (ack.error_number =3D=3D ERROR_OBJECT_ALREADY_EXISTS=
) ? RTA_EEXIST : RTA_ERROR;</span><br><span>         if (ret =3D=3D RTA_ERR=
OR)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(M_WARN, &quot;ERROR: route %s failed using service=
: %s [status=3D%u if_index=3D%d]&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_WARN, &quot;ERROR: route %s failed us=
ing service: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span>       =
          (add ? &quot;addition&quot; : &quot;deletion&quot;), strerror_win=
32(ack.error_number, &amp;gc),</span><br><span>                 ack.error_n=
umber, rt-&gt;iface.index);</span><br><span>         }</span><br><span>@@ -=
2869,17 +2868,12 @@</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Returns RTA_=
SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */</span=
><br><span> static int</span><br><span> do_route_ipv4_service(const bool ad=
d, const struct route_ipv4 *r, const struct tuntap *tt)</span><br><span> {<=
/span><br><span>     DWORD if_index =3D windows_route_find_if_index(r, tt);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (if_index =3D=
=3D ~0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (if_i=
ndex =3D=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>     {</span><br><sp=
an>         return RTA_ERROR;</span><br><span>     }</span><br><span>@@ -30=
23,10 +3017,6 @@</span><br><span>     return status;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /* Returns RTA_SUCCESS on success, RTA_EEXIST if rou=
te exists, RTA_ERROR on error */</span><br><span> static int</span><br><spa=
n> add_route_service(const struct route_ipv4 *r, const struct tuntap *tt)</=
span><br><span>@@ -3057,14 +3047,14 @@</span><br><span> format_route_entry(=
const MIB_IPFORWARDROW *r, struct gc_arena *gc)</span><br><span> {</span><b=
r><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;%s %s %s=
 p=3D%d i=3D%d t=3D%d pr=3D%d a=3D%d h=3D%d m=3D%d/%d/%d/%d/%d&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, =
&quot;%s %s %s p=3D%lu i=3D%lu t=3D%lu pr=3D%lu a=3D%lu h=3D%lu m=3D%lu/%lu=
/%lu/%lu/%lu&quot;,</span><br><span>                print_in_addr_t(r-&gt;d=
wForwardDest, IA_NET_ORDER, gc),</span><br><span>                print_in_a=
ddr_t(r-&gt;dwForwardMask, IA_NET_ORDER, gc),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               print_in_addr_t(r-&gt;dwForwardNextH=
op, IA_NET_ORDER, gc), (int)r-&gt;dwForwardPolicy,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-               (int)r-&gt;dwForwardIfIndex, (i=
nt)r-&gt;dwForwardType, (int)r-&gt;dwForwardProto,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-               (int)r-&gt;dwForwardAge, (int)r=
-&gt;dwForwardNextHopAS, (int)r-&gt;dwForwardMetric1,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-               (int)r-&gt;dwForwardMetric2,=
 (int)r-&gt;dwForwardMetric3, (int)r-&gt;dwForwardMetric4,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-               (int)r-&gt;dwForwardMet=
ric5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
  print_in_addr_t(r-&gt;dwForwardNextHop, IA_NET_ORDER, gc), r-&gt;dwForwar=
dPolicy,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
    r-&gt;dwForwardIfIndex, r-&gt;dwForwardType, r-&gt;dwForwardProto,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+               r-&gt;dwF=
orwardAge, r-&gt;dwForwardNextHopAS, r-&gt;dwForwardMetric1,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+               r-&gt;dwForwardMetr=
ic2, r-&gt;dwForwardMetric3, r-&gt;dwForwardMetric4,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+               r-&gt;dwForwardMetric5);</=
span><br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</sp=
an><br><span>index ad77117..5c1ba25 100644</span><br><span>--- a/src/openvp=
n/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -158,7 +=
158,7 @@</span><br><span> </span><br><span>     if (ack.error_number !=3D N=
O_ERROR)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(M_WARN, &quot;TUN: %s address failed using service: %=
s [status=3D%u if_index=3D%d]&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_WARN, &quot;TUN: %s address failed using ser=
vice: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span>             (=
add ? &quot;adding&quot; : &quot;deleting&quot;), strerror_win32(ack.error_=
number, &amp;gc), ack.error_number,</span><br><span>             addr.iface=
.index);</span><br><span>         goto out;</span><br><span>@@ -220,7 +220,=
7 @@</span><br><span>         strncpy(dns.domains + dstlen, o-&gt;domain_se=
arch_list[i], srclen + 1);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;%s DNS d=
omains on &#39;%s&#39; (if_index =3D %d) using service&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;%s DNS domai=
ns on &#39;%s&#39; (if_index =3D %lu) using service&quot;,</span><br><span>=
         (add ? &quot;Setting&quot; : &quot;Deleting&quot;), dns.iface.name=
, dns.iface.index);</span><br><span>     if (!send_msg_iservice(o-&gt;msg_c=
hannel, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&quot;))</span><br><span>=
     {</span><br><span>@@ -289,7 +289,7 @@</span><br><span>         }</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    msg(D_LOW, &quot;%s %s dns servers on &#39;%s&#39; (if_in=
dex =3D %d) using service&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(D_LOW, &quot;%s %s dns servers on &#39;%s&#39; (if_ind=
ex =3D %lu) using service&quot;,</span><br><span>         (add ? &quot;Sett=
ing&quot; : &quot;Deleting&quot;), ip_proto_name, dns.iface.name, dns.iface=
.index);</span><br><span> </span><br><span>     if (!send_msg_iservice(pipe=
, &amp;dns, sizeof(dns), &amp;ack, &quot;TUN&quot;))</span><br><span>@@ -34=
6,7 +346,7 @@</span><br><span>         wins.addr[i].ipv4.s_addr =3D htonl(t=
t-&gt;options.wins[i]);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;%s WINS ser=
vers on &#39;%s&#39; (if_index =3D %d) using service&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;%s WINS server=
s on &#39;%s&#39; (if_index =3D %lu) using service&quot;,</span><br><span> =
        (add ? &quot;Setting&quot; : &quot;Deleting&quot;), wins.iface.name=
, wins.iface.index);</span><br><span> </span><br><span>     if (!send_msg_i=
service(pipe, &amp;wins, sizeof(wins), &amp;ack, &quot;TUN&quot;))</span><b=
r><span>@@ -398,13 +398,13 @@</span><br><span> </span><br><span>     if (ac=
k.error_number !=3D NO_ERROR)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;TUN: setting =
%s mtu using service failed: %s [status=3D%u if_index=3D%d]&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quo=
t;TUN: setting %s mtu using service failed: %s [status=3D%u if_index=3D%lu]=
&quot;,</span><br><span>             family_name, strerror_win32(ack.error_=
number, &amp;gc), ack.error_number,</span><br><span>             mtu_msg.if=
ace.index);</span><br><span>     }</span><br><span>     else</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_INFO, &quot;%s MTU set to %d on interface %d using service&quot;, family_n=
ame, mtu,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_INFO, &quot;%s MTU set to %d on interface %lu using service&quot;, fami=
ly_name, mtu,</span><br><span>             mtu_msg.iface.index);</span><br>=
<span>         ret =3D true;</span><br><span>     }</span><br><span>@@ -445=
6,8 +4456,8 @@</span><br><span>         list =3D list-&gt;Next;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    dmsg(D_ROUTE_DEBUG, &quot;DEBUG: IP Locate: ip=3D%s nm=3D%s ind=
ex=3D%d count=3D%d metric=3D%d&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         print_in_addr_t(ip, 0, &amp;gc), print_in_addr_t(h=
ighest_netmask, 0, &amp;gc), (int)ret,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    dmsg(D_ROUTE_DEBUG, &quot;DEBUG: IP Locate: ip=3D%s =
nm=3D%s index=3D%lu count=3D%d metric=3D%d&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         print_in_addr_t(ip, 0, &amp;gc), pri=
nt_in_addr_t(highest_netmask, 0, &amp;gc), ret,</span><br><span>          c=
ount ? *count : -1, lowest_metric);</span><br><span> </span><br><span>     =
if (ret =3D=3D TUN_ADAPTER_INDEX_INVALID &amp;&amp; count)</span><br><span>=
@@ -4634,7 +4634,7 @@</span><br><span> show_adapter(msglvl_t msglevel, cons=
t IP_ADAPTER_INFO *a, struct gc_arena *gc)</span><br><span> {</span><br><sp=
an>     msg(msglevel, &quot;%s&quot;, a-&gt;Description);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    msg(msglevel, &quot;  Index =3D %d&=
quot;, (int)a-&gt;Index);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(msglevel, &quot;  Index =3D %lu&quot;, a-&gt;Index);</span><b=
r><span>     msg(msglevel, &quot;  GUID =3D %s&quot;, a-&gt;AdapterName);</=
span><br><span>     msg(msglevel, &quot;  IP =3D %s&quot;, format_ip_addr_s=
tring(&amp;a-&gt;IpAddressList, gc));</span><br><span>     msg(msglevel, &q=
uot;  MAC =3D %s&quot;, format_hex_ex(a-&gt;Address, a-&gt;AddressLength, 0=
, 1, &quot;:&quot;, gc));</span><br><span>@@ -5215,12 +5215,12 @@</span><br=
><span> </span><br><span>     if (ack.error_number !=3D NO_ERROR)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(M_NONFATAL, &quot;TUN: enabling dhcp using service failed: %s [status=
=3D%u if_index=3D%d]&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_NONFATAL, &quot;TUN: enabling dhcp using service fail=
ed: %s [status=3D%u if_index=3D%lu]&quot;,</span><br><span>             str=
error_win32(ack.error_number, &amp;gc), ack.error_number, dhcp.iface.index)=
;</span><br><span>     }</span><br><span>     else</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &qu=
ot;DHCP enabled on interface %d using service&quot;, dhcp.iface.index);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &qu=
ot;DHCP enabled on interface %lu using service&quot;, dhcp.iface.index);</s=
pan><br><span>         ret =3D true;</span><br><span>     }</span><br><span=
> </span><br><span>@@ -5510,7 +5510,7 @@</span><br><span>     /* flush arp =
cache */</span><br><span>     if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIV=
ER_TAP_WINDOWS6 &amp;&amp; index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        D=
WORD status =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        DWORD status =3D (DWORD)-1;</span><br><span> </span><br><span>     =
    if (tt-&gt;options.msg_channel)</span><br><span>         {</span><br><s=
pan>@@ -5534,7 +5534,7 @@</span><br><span>         {</span><br><span>      =
       msg(M_INFO, &quot;Successful ARP Flush on interface [%lu] %s&quot;, =
index, device_guid);</span><br><span>         }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        else if (status !=3D -1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else if (status !=3D (DWORD)=
-1)</span><br><span>         {</span><br><span>             msg(D_TUNTAP_IN=
FO,</span><br><span>                 &quot;NOTE: FlushIpNetTable failed on =
interface [%lu] %s (status=3D%lu) : %s&quot;, index,</span><br><span>diff -=
-git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index a226e37.=
.388f5b7 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><span>+++=
 b/src/openvpn/tun.h</span><br><span>@@ -61,8 +61,6 @@</span><br><span> </s=
pan><br><span> #if defined(_WIN32) || defined(TARGET_ANDROID) || defined(DH=
CP_UNIT_TEST)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* time constants for -=
-ip-win32 adaptive */</span><br><span> #define IPW32_SET_ADAPTIVE_DELAY_WIN=
DOW 300</span><br><span> #define IPW32_SET_ADAPTIVE_TRY_NETSH    20</span><=
br><span>@@ -230,7 +228,7 @@</span><br><span>     in_addr_t adapter_netmask=
;</span><br><span> </span><br><span>     /* Windows adapter index for TAP-W=
indows adapter,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 ~0 if undefined */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * TUN_ADAPTER_INDEX_INVALID if undefined */</span><br><span>     DWORD=
 adapter_index;</span><br><span> </span><br><span>     int standby_iter;</s=
pan><br><span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span>=
<br><span>index ac449fd..b2a7331 100644</span><br><span>--- a/src/openvpn/w=
in32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -1185,7=
 +1185,7 @@</span><br><span>     if (ack.error_number !=3D NO_ERROR)</span>=
<br><span>     {</span><br><span>         msg(M_WARN,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;WFP block: %s block filte=
rs using service failed: %s [status=3D0x%x if_index=3D%d]&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;WFP block: %=
s block filters using service failed: %s [status=3D0x%x if_index=3D%lu]&quo=
t;,</span><br><span>             (add ? &quot;adding&quot; : &quot;deleting=
&quot;), strerror_win32(ack.error_number, &amp;gc), ack.error_number,</span=
><br><span>             data.iface.index);</span><br><span>         goto ou=
t;</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpn=
serv/interactive.c</span><br><span>index 09c709e..b50aeb3 100644</span><br>=
<span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpn=
serv/interactive.c</span><br><span>@@ -96,7 +96,7 @@</span><br><span> typed=
ef struct</span><br><span> {</span><br><span>     HANDLE engine;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int index;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    DWORD index;</span><br><span>    =
 int metric_v4;</span><br><span>     int metric_v6;</span><br><span> } wfp_=
block_data_t;</span><br><span>@@ -584,7 +584,7 @@</span><br><span>     addr=
_row-&gt;Address =3D sockaddr_inet(msg-&gt;family, &amp;msg-&gt;address);</=
span><br><span>     addr_row-&gt;OnLinkPrefixLength =3D (UINT8)msg-&gt;pref=
ix_len;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (msg-&gt;iface.index !=3D -1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (msg-&gt;iface.index !=3D TUN_ADAPTER_INDEX_INV=
ALID)</span><br><span>     {</span><br><span>         addr_row-&gt;Interfac=
eIndex =3D msg-&gt;iface.index;</span><br><span>     }</span><br><span>@@ -=
667,7 +667,7 @@</span><br><span>     fwd_row-&gt;DestinationPrefix.PrefixLe=
ngth =3D (UINT8)msg-&gt;prefix_len;</span><br><span>     fwd_row-&gt;NextHo=
p =3D sockaddr_inet(msg-&gt;family, &amp;msg-&gt;gateway);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (msg-&gt;ifac=
e.index !=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (msg-&gt;iface.index !=3D TUN_ADAPTER_INDEX_INVALID)</span><br><span>  =
   {</span><br><span>         fwd_row-&gt;InterfaceIndex =3D msg-&gt;iface.=
index;</span><br><span>     }</span><br><span>@@ -1010,7 +1010,7 @@</span><=
br><span>  * if action =3D &quot;set&quot; then &quot;static&quot; is added=
 before $addr</span><br><span>  */</span><br><span> static DWORD</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-netsh_wins_cmd(const wchar_t *ac=
tion, int if_index, const wchar_t *addr)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+netsh_wins_cmd(const wchar_t *action, DWORD if_index, =
const wchar_t *addr)</span><br><span> {</span><br><span>     DWORD err =3D =
0;</span><br><span>     int timeout =3D 30000; /* in msec */</span><br><spa=
n>@@ -1036,7 +1036,7 @@</span><br><span>     /* cmd template:</span><br><sp=
an>      * netsh interface ip $action wins $if_name $static $addr</span><br=
><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst wchar_t *fmt =3D L&quot;netsh interface ip %ls wins %d %ls %ls&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const wchar_t *fm=
t =3D L&quot;netsh interface ip %ls wins %lu %ls %ls&quot;;</span><br><span=
> </span><br><span>     /* max cmdline length in wchars -- include room for=
 worst case and some */</span><br><span>     size_t ncmdline =3D wcslen(fmt=
) + 11 /*if_index*/ + wcslen(action) + wcslen(addr)</span><br><span>@@ -298=
4,7 +2984,7 @@</span><br><span>          */</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int *if_=
index =3D malloc(sizeof(msg-&gt;iface.index));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    PDWORD if_index =3D malloc(sizeof(msg-&gt;if=
ace.index));</span><br><span>     if (if_index)</span><br><span>     {</spa=
n><br><span>         *if_index =3D msg-&gt;iface.index;</span><br><span>@@ =
-3017,7 +3017,7 @@</span><br><span>     /* cmd template:</span><br><span>  =
    * netsh interface ipv4 set address name=3D$if_index source=3Ddhcp</span=
><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const wchar_t *fmt =3D L&quot;netsh interface ipv4 set address name=3D\&q=
uot;%d\&quot; source=3Ddhcp&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const wchar_t *fmt =3D L&quot;netsh interface ipv4 set a=
ddress name=3D\&quot;%lu\&quot; source=3Ddhcp&quot;;</span><br><span> </spa=
n><br><span>     /* max cmdline length in wchars -- include room for if ind=
ex:</span><br><span>      * 10 chars for 32 bit int in decimal and +1 for N=
UL</span><br><span>@@ -3250,7 +3250,7 @@</span><br><span>                  =
   break;</span><br><span> </span><br><span>                 case undo_wins=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
netsh_wins_cmd(L&quot;delete&quot;, *(int *)item-&gt;data, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    netsh_win=
s_cmd(L&quot;delete&quot;, *(PDWORD)item-&gt;data, NULL);</span><br><span> =
                    break;</span><br><span> </span><br><span>              =
   case wfp_block:</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail">change 1519</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1519?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I38bb2d1fa66c543e8bcf47b7d77=
b6154d1895f81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1519 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--JV8JPxA9Af0=--

