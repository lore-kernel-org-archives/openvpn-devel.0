From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 17 Sep 2019 15:44:52 +0300
Message-Id: <1568724293-5069-6-git-send-email-lstipakov@...277...>
In-Reply-To: <1568724293-5069-1-git-send-email-lstipakov@...277...>
References: <1568724293-5069-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 6/7] wintun: set adapter properties via
 interactive service
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

From: Lev Stipakov <lev@...515...>

Since Wintun doesn't do DHCP, use interactive service
calls to set up adapter properties.

This also fixes bug in previously unused IPv4 code of
do_address_service():

 - ipv4 address must be in network byte order
 - prefix length cannot be hardcoded /32 but
 must be calculated from netmask

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/route.c |  2 +-
 src/openvpn/route.h |  3 ++-
 src/openvpn/tun.c   | 77 +++++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 63 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3183fb4..bd3809d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3019,7 +3019,7 @@ out:
     return ret;
 }
 
-static bool
+bool
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
 {
     DWORD if_index = windows_route_find_if_index(r, tt);
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 2e68091..27b652c 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -321,7 +321,8 @@ void setenv_routes(struct env_set *es, const struct route_list *rl);
 
 void setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6);
 
-
+bool do_route_ipv4_service(const bool add, const struct route_ipv4 *r,
+                           const struct tuntap *tt);
 
 bool is_special_addr(const char *addr_str);
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b436c67..9fe8f9c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -109,8 +109,8 @@ do_address_service(const bool add, const short family, const struct tuntap *tt)
 
     if (addr.family == AF_INET)
     {
-        addr.address.ipv4.s_addr = tt->local;
-        addr.prefix_len = 32;
+        addr.address.ipv4.s_addr = htonl(tt->local);
+        addr.prefix_len = netmask_to_netbits2(tt->adapter_netmask);
     }
     else
     {
@@ -139,13 +139,17 @@ out:
 }
 
 static bool
-do_dns6_service(bool add, const struct tuntap *tt)
+do_dns_service(bool add, const short family, const struct tuntap *tt)
 {
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
     HANDLE pipe = tt->options.msg_channel;
-    int addr_len = add ? tt->options.dns6_len : 0;
+    int len = family == AF_INET6 ? tt->options.dns6_len : tt->options.dns_len;
+    int addr_len = add ? len : 0;
+    char ip_proto_name[5];
+
+    strcpy(ip_proto_name, family == AF_INET6 ? "IPv6" : "IPv4");
 
     if (addr_len == 0 && add) /* no addresses to add */
     {
@@ -160,7 +164,7 @@ do_dns6_service(bool add, const struct tuntap *tt)
         },
         .iface = { .index = tt->adapter_index, .name = "" },
         .domains = "",
-        .family = AF_INET6,
+        .family = family,
         .addr_len = addr_len
     };
 
@@ -172,17 +176,24 @@ do_dns6_service(bool add, const struct tuntap *tt)
     {
         addr_len = _countof(dns.addr);
         dns.addr_len = addr_len;
-        msg(M_WARN, "Number of IPv6 DNS addresses sent to service truncated to %d",
-            addr_len);
+        msg(M_WARN, "Number of %s DNS addresses sent to service truncated to %d",
+            ip_proto_name, addr_len);
     }
 
     for (int i = 0; i < addr_len; ++i)
     {
-        dns.addr[i].ipv6 = tt->options.dns6[i];
+        if (family == AF_INET6)
+        {
+            dns.addr[i].ipv6 = tt->options.dns6[i];
+        }
+        else
+        {
+            dns.addr[i].ipv4.s_addr = htonl(tt->options.dns[i]);
+        }
     }
 
-    msg(D_LOW, "%s IPv6 dns servers on '%s' (if_index = %d) using service",
-        (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
+    msg(D_LOW, "%s %s dns servers on '%s' (if_index = %d) using service",
+        (add ? "Setting" : "Deleting"), ip_proto_name, dns.iface.name, dns.iface.index);
 
     if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
     {
@@ -191,13 +202,13 @@ do_dns6_service(bool add, const struct tuntap *tt)
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s IPv6 dns failed using service: %s [status=%u if_name=%s]",
-            (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
+        msg(M_WARN, "TUN: %s %s dns failed using service: %s [status=%u if_name=%s]",
+            (add ? "adding" : "deleting"), ip_proto_name, strerror_win32(ack.error_number, &gc),
             ack.error_number, dns.iface.name);
         goto out;
     }
 
-    msg(M_INFO, "IPv6 dns servers %s using service", (add ? "set" : "deleted"));
+    msg(M_INFO, "%s dns servers %s using service", ip_proto_name, (add ? "set" : "deleted"));
     ret = true;
 
 out:
@@ -830,7 +841,7 @@ init_tun_post(struct tuntap *tt,
  * an extra call to "route add..."
  * -> helper function to simplify code below
  */
-void
+static void
 add_route_connected_v6_net(struct tuntap *tt,
                            const struct env_set *es)
 {
@@ -862,6 +873,21 @@ delete_route_connected_v6_net(struct tuntap *tt,
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */
 
+#if defined(_WIN32)
+void
+do_route_ipv4_service_tun(bool add, const struct tuntap *tt)
+{
+    struct route_ipv4 r4;
+    CLEAR(r4);
+    r4.network = tt->local & tt->remote_netmask;
+    r4.netmask = tt->remote_netmask;
+    r4.gateway = tt->local;
+    r4.metric = 0;                     /* connected route */
+    r4.flags = RT_DEFINED | RT_METRIC_DEFINED;
+    do_route_ipv4_service(add, &r4, tt);
+}
+#endif
+
 #if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)  \
     || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 /* we can't use true subnet mode on tun on all platforms, as that
@@ -1008,7 +1034,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     else if (tt->options.msg_channel)
     {
         do_address_service(true, AF_INET6, tt);
-        do_dns6_service(true, tt);
+        do_dns_service(true, AF_INET6, tt);
     }
     else
     {
@@ -1390,8 +1416,16 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         ASSERT(ifname != NULL);
 
-        switch (tt->options.ip_win32_type)
+        if (tt->options.msg_channel && tt->wintun)
+        {
+            do_address_service(true, AF_INET, tt);
+            do_route_ipv4_service_tun(true, tt);
+            do_dns_service(true, AF_INET, tt);
+        }
+        else
         {
+            switch (tt->options.ip_win32_type)
+            {
             case IPW32_SET_MANUAL:
                 msg(M_INFO,
                     "******** NOTE:  Please manually set the IP/netmask of '%s' to %s/%s (if it is not already set)",
@@ -1404,6 +1438,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
                                tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
 
                 break;
+            }
         }
     }
 
@@ -6130,6 +6165,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     }
 
     /* possibly use IP Helper API to set IP address on adapter */
+    if (!tt->wintun)
     {
         const DWORD index = tt->adapter_index;
 
@@ -6340,7 +6376,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
             do_address_service(false, AF_INET6, tt);
             if (tt->options.dns6_len > 0)
             {
-                do_dns6_service(false, tt);
+                do_dns_service(false, AF_INET6, tt);
             }
         }
         else
@@ -6377,6 +6413,13 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
     }
 #if 1
+    if (tt->wintun && tt->options.msg_channel)
+    {
+        do_route_ipv4_service_tun(false, tt);
+        do_address_service(false, AF_INET, tt);
+        do_dns_service(false, AF_INET, tt);
+    }
+    else
     if (tt->ipapi_context_defined)
     {
         DWORD status;
-- 
2.7.4


