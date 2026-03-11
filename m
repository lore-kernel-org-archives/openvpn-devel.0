From: Gert Doering <gert@...1296...>
Date: Wed, 11 Mar 2026 20:59:20 +0100
Message-ID: <20260311195925.5600-1-gert@...1296...>
In-Reply-To: <gerrit.1770918401000.Id2c5df9df32a02e944e13b55f57a2c1928b652f4@...2715...>
References: <gerrit.1770918401000.Id2c5df9df32a02e944e13b55f57a2c1928b652f4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] DNS/DHCP: Make _len attributes
 consistently unsigned
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

Use unsigned int instead of size_t since 32bit
values are quite enough here and this avoids some
unneccesary casts.

Change-Id: Id2c5df9df32a02e944e13b55f57a2c1928b652f4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1520
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1520
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 34f50c8..bef20cf 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -103,7 +103,7 @@
     interface_t iface;
     char domains[512];
     short family;
-    int addr_len;
+    unsigned int addr_len;
     inet_address_t addr[4]; /* support up to 4 dns addresses */
 } dns_cfg_message_t;
 
@@ -130,7 +130,7 @@
 {
     message_header_t header;
     interface_t iface;
-    int addr_len;
+    unsigned int addr_len;
     inet_address_t addr[4]; /* support up to 4 dns addresses */
 } wins_cfg_message_t;
 
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 882e474..51bc2de 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -99,14 +99,14 @@
 struct dhcp_options
 {
     in_addr_t dns[N_DHCP_ADDR];
-    int dns_len;
+    unsigned int dns_len;
 
     struct in6_addr dns6[N_DHCP_ADDR];
-    int dns6_len;
+    unsigned int dns6_len;
 
     const char *domain;
     const char *domain_search_list[N_SEARCH_LIST_LEN];
-    int domain_search_list_len;
+    unsigned int domain_search_list_len;
 };
 
 struct dns_options
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8daec42..e065e63 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1258,23 +1258,21 @@
 #ifndef ENABLE_SMALL
 
 static void
-show_dhcp_option_list(const char *name, const char *const *array, int len)
+show_dhcp_option_list(const char *name, const char *const *array, unsigned int len)
 {
-    int i;
-    for (i = 0; i < len; ++i)
+    for (unsigned int i = 0; i < len; ++i)
     {
-        msg(D_SHOW_PARMS, "  %s[%d] = %s", name, i, array[i]);
+        msg(D_SHOW_PARMS, "  %s[%u] = %s", name, i, array[i]);
     }
 }
 
 static void
-show_dhcp_option_addrs(const char *name, const in_addr_t *array, int len)
+show_dhcp_option_addrs(const char *name, const in_addr_t *array, unsigned int len)
 {
     struct gc_arena gc = gc_new();
-    int i;
-    for (i = 0; i < len; ++i)
+    for (unsigned int i = 0; i < len; ++i)
     {
-        msg(D_SHOW_PARMS, "  %s[%d] = %s", name, i, print_in_addr_t(array[i], 0, &gc));
+        msg(D_SHOW_PARMS, "  %s[%u] = %s", name, i, print_in_addr_t(array[i], 0, &gc));
     }
     gc_free(&gc);
 }
@@ -1306,12 +1304,12 @@
 #endif /* ifdef _WIN32 */
 
 static void
-dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *len, msglvl_t msglevel)
+dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, unsigned int *len, msglvl_t msglevel)
 {
     struct in6_addr addr;
     if (*len >= N_DHCP_ADDR)
     {
-        msg(msglevel, "--dhcp-option DNS: maximum of %d IPv6 dns servers can be specified",
+        msg(msglevel, "--dhcp-option DNS: maximum of %u IPv6 dns servers can be specified",
             N_DHCP_ADDR);
     }
     else if (get_ipv6_addr(parm, &addr, NULL, msglevel))
@@ -1320,12 +1318,12 @@
     }
 }
 static void
-dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array, int *len,
+dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array, unsigned int *len,
                           msglvl_t msglevel)
 {
     if (*len >= N_DHCP_ADDR)
     {
-        msg(msglevel, "--dhcp-option %s: maximum of %d %s servers can be specified", name,
+        msg(msglevel, "--dhcp-option %s: maximum of %u %s servers can be specified", name,
             N_DHCP_ADDR, name);
     }
     else
@@ -3648,7 +3646,7 @@
             new->name = dhcp->domain;
             entry = &new->next;
 
-            for (int i = 0; i < dhcp->domain_search_list_len; ++i)
+            for (unsigned int i = 0; i < dhcp->domain_search_list_len; ++i)
             {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
                 struct dns_domain *new = *entry;
@@ -3658,13 +3656,13 @@
 
             struct dns_server *server = dns_server_get(&dns->servers, 0, &dns->gc);
             const size_t max_addrs = SIZE(server->addr);
-            for (int i = 0; i < dhcp->dns_len && server->addr_count < max_addrs; ++i)
+            for (unsigned int i = 0; i < dhcp->dns_len && server->addr_count < max_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a4.s_addr = htonl(dhcp->dns[i]);
                 server->addr[server->addr_count].family = AF_INET;
                 server->addr_count += 1;
             }
-            for (int i = 0; i < dhcp->dns6_len && server->addr_count < max_addrs; ++i)
+            for (unsigned int i = 0; i < dhcp->dns6_len && server->addr_count < max_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a6 = dhcp->dns6[i];
                 server->addr[server->addr_count].family = AF_INET6;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 64e3b45..8105db2 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -103,7 +103,7 @@
 
 static void windows_set_mtu(const int iface_index, const short family, const int mtu);
 
-static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const int addr_len,
+static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const unsigned int addr_len,
                                    DWORD adapter_index);
 
 static void netsh_command(const struct argv *a, int n, msglvl_t msglevel);
@@ -112,11 +112,6 @@
 
 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static bool
 do_address_service(const bool add, const short family, const struct tuntap *tt)
 {
@@ -247,8 +242,8 @@
     ack_message_t ack;
     struct gc_arena gc = gc_new();
     HANDLE pipe = tt->options.msg_channel;
-    int len = family == AF_INET6 ? tt->options.dns6_len : tt->options.dns_len;
-    int addr_len = add ? len : 0;
+    unsigned int len = family == AF_INET6 ? tt->options.dns6_len : tt->options.dns_len;
+    unsigned int addr_len = add ? len : 0;
     const char *ip_proto_name = family == AF_INET6 ? "IPv6" : "IPv4";
 
     if (len == 0)
@@ -273,11 +268,11 @@
     {
         addr_len = _countof(dns.addr);
         dns.addr_len = addr_len;
-        msg(M_WARN, "Number of %s DNS addresses sent to service truncated to %d", ip_proto_name,
-            addr_len);
+        msg(M_WARN, "Number of %s DNS addresses sent to service truncated to %u",
+            ip_proto_name, addr_len);
     }
 
-    for (int i = 0; i < addr_len; ++i)
+    for (unsigned int i = 0; i < addr_len; ++i)
     {
         if (family == AF_INET6)
         {
@@ -317,7 +312,7 @@
     ack_message_t ack;
     struct gc_arena gc = gc_new();
     HANDLE pipe = tt->options.msg_channel;
-    int addr_len = add ? tt->options.wins_len : 0;
+    unsigned int addr_len = add ? tt->options.wins_len : 0;
 
     if (tt->options.wins_len == 0)
     {
@@ -338,10 +333,10 @@
     {
         addr_len = _countof(wins.addr);
         wins.addr_len = addr_len;
-        msg(M_WARN, "Number of WINS addresses sent to service truncated to %d", addr_len);
+        msg(M_WARN, "Number of WINS addresses sent to service truncated to %u", addr_len);
     }
 
-    for (int i = 0; i < addr_len; ++i)
+    for (unsigned int i = 0; i < addr_len; ++i)
     {
         wins.addr[i].ipv4.s_addr = htonl(tt->options.wins[i]);
     }
@@ -368,10 +363,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
 {
@@ -1998,13 +1989,13 @@
 
     /* Prefer IPv6 DNS servers,
      * Android will use the DNS server in the order we specify*/
-    for (int i = 0; i < tt->options.dns6_len; i++)
+    for (unsigned int i = 0; i < tt->options.dns6_len; i++)
     {
         management_android_control(management, "DNS6SERVER",
                                    print_in6_addr(tt->options.dns6[i], 0, &gc));
     }
 
-    for (int i = 0; i < tt->options.dns_len; i++)
+    for (unsigned int i = 0; i < tt->options.dns_len; i++)
     {
         management_android_control(management, "DNSSERVER",
                                    print_in_addr_t(tt->options.dns[i], 0, &gc));
@@ -4922,10 +4913,10 @@
     msg(D_TUNTAP_INFO, "End ipconfig commands for register-dns...");
 }
 
-void
-ip_addr_string_to_array(in_addr_t *dest, int *dest_len, const IP_ADDR_STRING *src)
+static void
+ip_addr_string_to_array(in_addr_t *dest, unsigned int *dest_len, const IP_ADDR_STRING *src)
 {
-    int i = 0;
+    unsigned int i = 0;
     while (src)
     {
         const unsigned int getaddr_flags = GETADDR_HOST_ORDER;
@@ -4967,11 +4958,11 @@
 }
 
 static bool
-ip_addr_one_to_one(const in_addr_t *a1, const int a1len, const IP_ADDR_STRING *ias)
+ip_addr_one_to_one(const in_addr_t *a1, const unsigned int a1len, const IP_ADDR_STRING *ias)
 {
-    in_addr_t a2[8];
-    int a2len = SIZE(a2);
-    int i;
+#define MAX_ADDRS 8
+    in_addr_t a2[MAX_ADDRS];
+    unsigned int a2len = MAX_ADDRS;
 
     ip_addr_string_to_array(a2, &a2len, ias);
     /*msg (M_INFO, "a1len=%d a2len=%d", a1len, a2len);*/
@@ -4980,7 +4971,7 @@
         return false;
     }
 
-    for (i = 0; i < a1len; ++i)
+    for (unsigned int i = 0; i < a1len; ++i)
     {
         if (a1[i] != a2[i])
         {
@@ -4993,12 +4984,11 @@
 static bool
 ip_addr_member_of(const in_addr_t addr, const IP_ADDR_STRING *ias)
 {
-    in_addr_t aa[8];
-    int len = SIZE(aa);
-    int i;
+    in_addr_t aa[MAX_ADDRS];
+    unsigned int len = MAX_ADDRS;
 
     ip_addr_string_to_array(aa, &len, ias);
-    for (i = 0; i < len; ++i)
+    for (unsigned int i = 0; i < len; ++i)
     {
         if (addr == aa[i])
         {
@@ -5007,6 +4997,7 @@
     }
     return false;
 }
+#undef MAX_ADDRS
 
 /**
  * Set the ipv6 dns servers on the specified interface.
@@ -5014,7 +5005,7 @@
  * are cleared first.
  */
 static void
-netsh_set_dns6_servers(const struct in6_addr *addr_list, const int addr_len, DWORD adapter_index)
+netsh_set_dns6_servers(const struct in6_addr *addr_list, const unsigned int addr_len, DWORD adapter_index)
 {
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
@@ -5024,7 +5015,7 @@
                 NETSH_PATH_SUFFIX, adapter_index);
     netsh_command(&argv, 2, M_FATAL);
 
-    for (int i = 0; i < addr_len; ++i)
+    for (unsigned int i = 0; i < addr_len; ++i)
     {
         const char *fmt = (i == 0) ? "%s%s interface ipv6 set dns %lu static %s"
                                    : "%s%s interface ipv6 add dns %lu %s";
@@ -5043,7 +5034,7 @@
 }
 
 static void
-netsh_ifconfig_options(const char *type, const in_addr_t *addr_list, const int addr_len,
+netsh_ifconfig_options(const char *type, const in_addr_t *addr_list, const unsigned int addr_len,
                        const IP_ADDR_STRING *current, DWORD adapter_index, const bool test_first)
 {
     struct gc_arena gc = gc_new();
@@ -5074,14 +5065,13 @@
 
     /* add new DNS/WINS settings to TAP interface */
     {
-        int count = 0;
-        int i;
-        for (i = 0; i < addr_len; ++i)
+        bool first = true;
+        for (unsigned int i = 0; i < addr_len; ++i)
         {
             if (delete_first || !test_first || !ip_addr_member_of(addr_list[i], current))
             {
-                const char *fmt = count ? "%s%s interface ip add %s %lu %s"
-                                        : "%s%s interface ip set %s %lu static %s";
+                const char *fmt = first ? "%s%s interface ip set %s %lu static %s"
+                                        : "%s%s interface ip add %s %lu %s";
 
                 argv_printf(&argv, fmt, get_win_sys_path(), NETSH_PATH_SUFFIX, type, adapter_index,
                             print_in_addr_t(addr_list[i], 0, &gc));
@@ -5094,7 +5084,7 @@
 
                 netsh_command(&argv, 2, M_FATAL);
 
-                ++count;
+                first = false;
             }
             else
             {
@@ -6094,7 +6084,7 @@
     struct argv argv = argv_new();
 
     /* delete ipvX dns servers if any were set */
-    int len = ipv6 ? tt->options.dns6_len : tt->options.dns_len;
+    unsigned int len = ipv6 ? tt->options.dns6_len : tt->options.dns_len;
     if (len > 0)
     {
         argv_printf(&argv, "%s%s interface %s delete dns %lu all", get_win_sys_path(),
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ecb5e88..6a7af85 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -109,25 +109,25 @@
 
     /* DNS (6) */
     in_addr_t dns[N_DHCP_ADDR];
-    int dns_len;
+    unsigned int dns_len;
 
     /* WINS (44) */
     in_addr_t wins[N_DHCP_ADDR];
-    int wins_len;
+    unsigned int wins_len;
 
     /* NTP (42) */
     in_addr_t ntp[N_DHCP_ADDR];
-    int ntp_len;
+    unsigned int ntp_len;
 
     /* NBDD (45) */
     in_addr_t nbdd[N_DHCP_ADDR];
-    int nbdd_len;
+    unsigned int nbdd_len;
 
 #define N_SEARCH_LIST_LEN 10 /* Max # of entries in domin-search list */
 
     /* SEARCH (119), MacOS, Linux, Win10 1809+ */
     const char *domain_search_list[N_SEARCH_LIST_LEN];
-    int domain_search_list_len;
+    unsigned int domain_search_list_len;
 
     /* DISABLE_NBT (43, Vendor option 001) */
     bool disable_nbt;
@@ -138,7 +138,7 @@
     bool register_dns;
 
     struct in6_addr dns6[N_DHCP_ADDR];
-    int dns6_len;
+    unsigned int dns6_len;
 #if defined(TARGET_ANDROID)
     const char *http_proxy;
     int http_proxy_port;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index b50aeb3..c96d3f2 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1814,10 +1814,10 @@
 {
     DWORD err = 0;
     undo_type_t undo_type = (msg->family == AF_INET6) ? undo_dns6 : undo_dns4;
-    int addr_len = msg->addr_len;
+    unsigned int addr_len = msg->addr_len;
 
     /* sanity check */
-    const int max_addrs = _countof(msg->addr);
+    const unsigned int max_addrs = _countof(msg->addr);
     if (addr_len > max_addrs)
     {
         addr_len = max_addrs;
@@ -1875,7 +1875,7 @@
          * time constant by all compilers and constexpr is C23 */
         CHAR addrs[_countof(msg->addr) * 64]; /* 64 is enough for one IPv4/6 address */
         size_t offset = 0;
-        for (int i = 0; i < addr_len; ++i)
+        for (unsigned int i = 0; i < addr_len; ++i)
         {
             if (i != 0)
             {
@@ -2936,14 +2936,10 @@
 {
     DWORD err = NO_ERROR;
     wchar_t addr[16]; /* large enough to hold string representation of an ipv4 */
-    int addr_len = msg->addr_len;
+    unsigned int addr_len = msg->addr_len;
 
     /* sanity check */
-    if (addr_len < 0)
-    {
-        addr_len = 0;
-    }
-    if ((unsigned int)addr_len > _countof(msg->addr))
+    if (addr_len > _countof(msg->addr))
     {
         addr_len = _countof(msg->addr);
     }
@@ -2971,7 +2967,7 @@
         goto out; /* job done */
     }
 
-    for (int i = 0; i < addr_len; ++i)
+    for (unsigned int i = 0; i < addr_len; ++i)
     {
         RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
         err = netsh_wins_cmd(i == 0 ? L"set" : L"add", msg->iface.index, addr);

