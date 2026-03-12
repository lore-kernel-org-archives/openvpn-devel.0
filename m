From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 07:35:30 +0000
In-Reply-To: <gerrit.1770918401000.Id2c5df9df32a02e944e13b55f57a2c1928b652f4@...2715...>
References: <gerrit.1770918401000.Id2c5df9df32a02e944e13b55f57a2c1928b652f4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9060e6e4a329746beba3bf2b24c720e1fdb0a491-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dTaITZ3Tiqc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DNS/DHCP: Make _len
 attributes consistently unsigned
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

--dTaITZ3Tiqc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1520?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: DNS/DHCP: Make _len attributes consistently unsigned
......................................................................

DNS/DHCP: Make _len attributes consistently unsigned

Use unsigned int instead of size_t since 32bit
values are quite enough here and this avoids some
unneccesary casts.

Change-Id: Id2c5df9df32a02e944e13b55f57a2c1928b652f4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1520
Message-Id: <20260311195925.5600-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
038.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M include/openvpn-msg.h
M src/openvpn/dns.h
M src/openvpn/options.c
M src/openvpn/tun.c
M src/openvpn/tun.h
M src/openvpnserv/interactive.c
6 files changed, 62 insertions(+), 78 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1520/5

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
+show_dhcp_option_list(const char *name, const char *const *array, unsigned=
 int len)
 {
-    int i;
-    for (i =3D 0; i < len; ++i)
+    for (unsigned int i =3D 0; i < len; ++i)
     {
-        msg(D_SHOW_PARMS, "  %s[%d] =3D %s", name, i, array[i]);
+        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, array[i]);
     }
 }

 static void
-show_dhcp_option_addrs(const char *name, const in_addr_t *array, int len)
+show_dhcp_option_addrs(const char *name, const in_addr_t *array, unsigned =
int len)
 {
     struct gc_arena gc =3D gc_new();
-    int i;
-    for (i =3D 0; i < len; ++i)
+    for (unsigned int i =3D 0; i < len; ++i)
     {
-        msg(D_SHOW_PARMS, "  %s[%d] =3D %s", name, i, print_in_addr_t(arra=
y[i], 0, &gc));
+        msg(D_SHOW_PARMS, "  %s[%u] =3D %s", name, i, print_in_addr_t(arra=
y[i], 0, &gc));
     }
     gc_free(&gc);
 }
@@ -1306,12 +1304,12 @@
 #endif /* ifdef _WIN32 */

 static void
-dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, msglvl_t msglevel)
+dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, unsig=
ned int *len, msglvl_t msglevel)
 {
     struct in6_addr addr;
     if (*len >=3D N_DHCP_ADDR)
     {
-        msg(msglevel, "--dhcp-option DNS: maximum of %d IPv6 dns servers c=
an be specified",
+        msg(msglevel, "--dhcp-option DNS: maximum of %u IPv6 dns servers c=
an be specified",
             N_DHCP_ADDR);
     }
     else if (get_ipv6_addr(parm, &addr, NULL, msglevel))
@@ -1320,12 +1318,12 @@
     }
 }
 static void
-dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *a=
rray, int *len,
+dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *a=
rray, unsigned int *len,
                           msglvl_t msglevel)
 {
     if (*len >=3D N_DHCP_ADDR)
     {
-        msg(msglevel, "--dhcp-option %s: maximum of %d %s servers can be s=
pecified", name,
+        msg(msglevel, "--dhcp-option %s: maximum of %u %s servers can be s=
pecified", name,
             N_DHCP_ADDR, name);
     }
     else
@@ -3648,7 +3646,7 @@
             new->name =3D dhcp->domain;
             entry =3D &new->next;

-            for (int i =3D 0; i < dhcp->domain_search_list_len; ++i)
+            for (unsigned int i =3D 0; i < dhcp->domain_search_list_len; +=
+i)
             {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
                 struct dns_domain *new =3D *entry;
@@ -3658,13 +3656,13 @@

             struct dns_server *server =3D dns_server_get(&dns->servers, 0,=
 &dns->gc);
             const size_t max_addrs =3D SIZE(server->addr);
-            for (int i =3D 0; i < dhcp->dns_len && server->addr_count < ma=
x_addrs; ++i)
+            for (unsigned int i =3D 0; i < dhcp->dns_len && server->addr_c=
ount < max_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a4.s_addr =3D htonl(dh=
cp->dns[i]);
                 server->addr[server->addr_count].family =3D AF_INET;
                 server->addr_count +=3D 1;
             }
-            for (int i =3D 0; i < dhcp->dns6_len && server->addr_count < m=
ax_addrs; ++i)
+            for (unsigned int i =3D 0; i < dhcp->dns6_len && server->addr_=
count < max_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a6 =3D dhcp->dns6[i];
                 server->addr[server->addr_count].family =3D AF_INET6;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b37a2ea..f46802f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -103,7 +103,7 @@

 static void windows_set_mtu(const int iface_index, const short family, con=
st int mtu);

-static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const=
 int addr_len,
+static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const=
 unsigned int addr_len,
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
 do_address_service(const bool add, const short family, const struct tuntap=
 *tt)
 {
@@ -247,8 +242,8 @@
     ack_message_t ack;
     struct gc_arena gc =3D gc_new();
     HANDLE pipe =3D tt->options.msg_channel;
-    int len =3D family =3D=3D AF_INET6 ? tt->options.dns6_len : tt->option=
s.dns_len;
-    int addr_len =3D add ? len : 0;
+    unsigned int len =3D family =3D=3D AF_INET6 ? tt->options.dns6_len : t=
t->options.dns_len;
+    unsigned int addr_len =3D add ? len : 0;
     const char *ip_proto_name =3D family =3D=3D AF_INET6 ? "IPv6" : "IPv4";

     if (len =3D=3D 0)
@@ -273,11 +268,11 @@
     {
         addr_len =3D _countof(dns.addr);
         dns.addr_len =3D addr_len;
-        msg(M_WARN, "Number of %s DNS addresses sent to service truncated =
to %d", ip_proto_name,
-            addr_len);
+        msg(M_WARN, "Number of %s DNS addresses sent to service truncated =
to %u",
+            ip_proto_name, addr_len);
     }

-    for (int i =3D 0; i < addr_len; ++i)
+    for (unsigned int i =3D 0; i < addr_len; ++i)
     {
         if (family =3D=3D AF_INET6)
         {
@@ -317,7 +312,7 @@
     ack_message_t ack;
     struct gc_arena gc =3D gc_new();
     HANDLE pipe =3D tt->options.msg_channel;
-    int addr_len =3D add ? tt->options.wins_len : 0;
+    unsigned int addr_len =3D add ? tt->options.wins_len : 0;

     if (tt->options.wins_len =3D=3D 0)
     {
@@ -338,10 +333,10 @@
     {
         addr_len =3D _countof(wins.addr);
         wins.addr_len =3D addr_len;
-        msg(M_WARN, "Number of WINS addresses sent to service truncated to=
 %d", addr_len);
+        msg(M_WARN, "Number of WINS addresses sent to service truncated to=
 %u", addr_len);
     }

-    for (int i =3D 0; i < addr_len; ++i)
+    for (unsigned int i =3D 0; i < addr_len; ++i)
     {
         wins.addr[i].ipv4.s_addr =3D htonl(tt->options.wins[i]);
     }
@@ -368,10 +363,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int =
mtu)
 {
@@ -1998,13 +1989,13 @@

     /* Prefer IPv6 DNS servers,
      * Android will use the DNS server in the order we specify*/
-    for (int i =3D 0; i < tt->options.dns6_len; i++)
+    for (unsigned int i =3D 0; i < tt->options.dns6_len; i++)
     {
         management_android_control(management, "DNS6SERVER",
                                    print_in6_addr(tt->options.dns6[i], 0, =
&gc));
     }

-    for (int i =3D 0; i < tt->options.dns_len; i++)
+    for (unsigned int i =3D 0; i < tt->options.dns_len; i++)
     {
         management_android_control(management, "DNSSERVER",
                                    print_in_addr_t(tt->options.dns[i], 0, =
&gc));
@@ -4916,10 +4907,10 @@
     msg(D_TUNTAP_INFO, "End ipconfig commands for register-dns...");
 }

-void
-ip_addr_string_to_array(in_addr_t *dest, int *dest_len, const IP_ADDR_STRI=
NG *src)
+static void
+ip_addr_string_to_array(in_addr_t *dest, unsigned int *dest_len, const IP_=
ADDR_STRING *src)
 {
-    int i =3D 0;
+    unsigned int i =3D 0;
     while (src)
     {
         const unsigned int getaddr_flags =3D GETADDR_HOST_ORDER;
@@ -4961,11 +4952,11 @@
 }

 static bool
-ip_addr_one_to_one(const in_addr_t *a1, const int a1len, const IP_ADDR_STR=
ING *ias)
+ip_addr_one_to_one(const in_addr_t *a1, const unsigned int a1len, const IP=
_ADDR_STRING *ias)
 {
-    in_addr_t a2[8];
-    int a2len =3D SIZE(a2);
-    int i;
+#define MAX_ADDRS 8
+    in_addr_t a2[MAX_ADDRS];
+    unsigned int a2len =3D MAX_ADDRS;

     ip_addr_string_to_array(a2, &a2len, ias);
     /*msg (M_INFO, "a1len=3D%d a2len=3D%d", a1len, a2len);*/
@@ -4974,7 +4965,7 @@
         return false;
     }

-    for (i =3D 0; i < a1len; ++i)
+    for (unsigned int i =3D 0; i < a1len; ++i)
     {
         if (a1[i] !=3D a2[i])
         {
@@ -4987,12 +4978,11 @@
 static bool
 ip_addr_member_of(const in_addr_t addr, const IP_ADDR_STRING *ias)
 {
-    in_addr_t aa[8];
-    int len =3D SIZE(aa);
-    int i;
+    in_addr_t aa[MAX_ADDRS];
+    unsigned int len =3D MAX_ADDRS;

     ip_addr_string_to_array(aa, &len, ias);
-    for (i =3D 0; i < len; ++i)
+    for (unsigned int i =3D 0; i < len; ++i)
     {
         if (addr =3D=3D aa[i])
         {
@@ -5001,6 +4991,7 @@
     }
     return false;
 }
+#undef MAX_ADDRS

 /**
  * Set the ipv6 dns servers on the specified interface.
@@ -5008,7 +4999,7 @@
  * are cleared first.
  */
 static void
-netsh_set_dns6_servers(const struct in6_addr *addr_list, const int addr_le=
n, DWORD adapter_index)
+netsh_set_dns6_servers(const struct in6_addr *addr_list, const unsigned in=
t addr_len, DWORD adapter_index)
 {
     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();
@@ -5018,7 +5009,7 @@
                 NETSH_PATH_SUFFIX, adapter_index);
     netsh_command(&argv, 2, M_FATAL);

-    for (int i =3D 0; i < addr_len; ++i)
+    for (unsigned int i =3D 0; i < addr_len; ++i)
     {
         const char *fmt =3D (i =3D=3D 0) ? "%s%s interface ipv6 set dns %l=
u static %s"
                                    : "%s%s interface ipv6 add dns %lu %s";
@@ -5037,7 +5028,7 @@
 }

 static void
-netsh_ifconfig_options(const char *type, const in_addr_t *addr_list, const=
 int addr_len,
+netsh_ifconfig_options(const char *type, const in_addr_t *addr_list, const=
 unsigned int addr_len,
                        const IP_ADDR_STRING *current, DWORD adapter_index,=
 const bool test_first)
 {
     struct gc_arena gc =3D gc_new();
@@ -5068,14 +5059,13 @@

     /* add new DNS/WINS settings to TAP interface */
     {
-        int count =3D 0;
-        int i;
-        for (i =3D 0; i < addr_len; ++i)
+        bool first =3D true;
+        for (unsigned int i =3D 0; i < addr_len; ++i)
         {
             if (delete_first || !test_first || !ip_addr_member_of(addr_lis=
t[i], current))
             {
-                const char *fmt =3D count ? "%s%s interface ip add %s %lu =
%s"
-                                        : "%s%s interface ip set %s %lu st=
atic %s";
+                const char *fmt =3D first ? "%s%s interface ip set %s %lu =
static %s"
+                                        : "%s%s interface ip add %s %lu %s=
";

                 argv_printf(&argv, fmt, get_win_sys_path(), NETSH_PATH_SUF=
FIX, type, adapter_index,
                             print_in_addr_t(addr_list[i], 0, &gc));
@@ -5088,7 +5078,7 @@

                 netsh_command(&argv, 2, M_FATAL);

-                ++count;
+                first =3D false;
             }
             else
             {
@@ -6083,7 +6073,7 @@
     struct argv argv =3D argv_new();

     /* delete ipvX dns servers if any were set */
-    int len =3D ipv6 ? tt->options.dns6_len : tt->options.dns_len;
+    unsigned int len =3D ipv6 ? tt->options.dns6_len : tt->options.dns_len;
     if (len > 0)
     {
         argv_printf(&argv, "%s%s interface %s delete dns %lu all", get_win=
_sys_path(),
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
     DWORD err =3D 0;
     undo_type_t undo_type =3D (msg->family =3D=3D AF_INET6) ? undo_dns6 : =
undo_dns4;
-    int addr_len =3D msg->addr_len;
+    unsigned int addr_len =3D msg->addr_len;

     /* sanity check */
-    const int max_addrs =3D _countof(msg->addr);
+    const unsigned int max_addrs =3D _countof(msg->addr);
     if (addr_len > max_addrs)
     {
         addr_len =3D max_addrs;
@@ -1875,7 +1875,7 @@
          * time constant by all compilers and constexpr is C23 */
         CHAR addrs[_countof(msg->addr) * 64]; /* 64 is enough for one IPv4=
/6 address */
         size_t offset =3D 0;
-        for (int i =3D 0; i < addr_len; ++i)
+        for (unsigned int i =3D 0; i < addr_len; ++i)
         {
             if (i !=3D 0)
             {
@@ -2936,14 +2936,10 @@
 {
     DWORD err =3D NO_ERROR;
     wchar_t addr[16]; /* large enough to hold string representation of an =
ipv4 */
-    int addr_len =3D msg->addr_len;
+    unsigned int addr_len =3D msg->addr_len;

     /* sanity check */
-    if (addr_len < 0)
-    {
-        addr_len =3D 0;
-    }
-    if ((unsigned int)addr_len > _countof(msg->addr))
+    if (addr_len > _countof(msg->addr))
     {
         addr_len =3D _countof(msg->addr);
     }
@@ -2971,7 +2967,7 @@
         goto out; /* job done */
     }

-    for (int i =3D 0; i < addr_len; ++i)
+    for (unsigned int i =3D 0; i < addr_len; ++i)
     {
         RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
         err =3D netsh_wins_cmd(i =3D=3D 0 ? L"set" : L"add", msg->iface.in=
dex, addr);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1520?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id2c5df9df32a02e944e13b55f57a2c1928b652f4
Gerrit-Change-Number: 1520
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dTaITZ3Tiqc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1520?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">DNS/DHCP: Make _len attributes cons=
istently unsigned<br><br>Use unsigned int instead of size_t since 32bit<br>=
values are quite enough here and this avoids some<br>unneccesary casts.<br>=
<br>Change-Id: Id2c5df9df32a02e944e13b55f57a2c1928b652f4<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/152=
0<br>Message-Id: &lt;20260311195925.5600-1-gert@...1296...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36038.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M include/=
openvpn-msg.h<br>M src/openvpn/dns.h<br>M src/openvpn/options.c<br>M src/op=
envpn/tun.c<br>M src/openvpn/tun.h<br>M src/openvpnserv/interactive.c<br>6 =
files changed, 62 insertions(+), 78 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1520/5</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h</span><br><=
span>index 34f50c8..bef20cf 100644</span><br><span>--- a/include/openvpn-ms=
g.h</span><br><span>+++ b/include/openvpn-msg.h</span><br><span>@@ -103,7 +=
103,7 @@</span><br><span>     interface_t iface;</span><br><span>     char =
domains[512];</span><br><span>     short family;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int addr_len;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned int addr_len;</span><br><span>     in=
et_address_t addr[4]; /* support up to 4 dns addresses */</span><br><span> =
} dns_cfg_message_t;</span><br><span> </span><br><span>@@ -130,7 +130,7 @@<=
/span><br><span> {</span><br><span>     message_header_t header;</span><br>=
<span>     interface_t iface;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int addr_len;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    unsigned int addr_len;</span><br><span>     inet_address_t addr[4=
]; /* support up to 4 dns addresses */</span><br><span> } wins_cfg_message_=
t;</span><br><span> </span><br><span>diff --git a/src/openvpn/dns.h b/src/o=
penvpn/dns.h</span><br><span>index 882e474..51bc2de 100644</span><br><span>=
--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><=
span>@@ -99,14 +99,14 @@</span><br><span> struct dhcp_options</span><br><sp=
an> {</span><br><span>     in_addr_t dns[N_DHCP_ADDR];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int dns_len;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    unsigned int dns_len;</span><br><span> </=
span><br><span>     struct in6_addr dns6[N_DHCP_ADDR];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int dns6_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unsigned int dns6_len;</span><br><span> =
</span><br><span>     const char *domain;</span><br><span>     const char *=
domain_search_list[N_SEARCH_LIST_LEN];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int domain_search_list_len;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned int domain_search_list_len;</span=
><br><span> };</span><br><span> </span><br><span> struct dns_options</span>=
<br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span>=
<br><span>index 8daec42..e065e63 100644</span><br><span>--- a/src/openvpn/o=
ptions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -12=
58,23 +1258,21 @@</span><br><span> #ifndef ENABLE_SMALL</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-show_dhcp_option_list(const char *name, const char *const *array, int=
 len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_dhcp_opti=
on_list(const char *name, const char *const *array, unsigned int len)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i=
 &lt; len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (unsigned int i =3D 0; i &lt; len; ++i)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quo=
t;  %s[%d] =3D %s&quot;, name, i, array[i]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;  %s[%u] =3D %s&qu=
ot;, name, i, array[i]);</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-show_dhcp_option_addrs(const char *name, const in_addr_t *=
array, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show=
_dhcp_option_addrs(const char *name, const in_addr_t *array, unsigned int l=
en)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; len; +=
+i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigne=
d int i =3D 0; i &lt; len; ++i)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(D_SHOW_PARMS, &quot;  %s[%d] =
=3D %s&quot;, name, i, print_in_addr_t(array[i], 0, &amp;gc));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_SHOW_PARMS, &quot;=
  %s[%u] =3D %s&quot;, name, i, print_in_addr_t(array[i], 0, &amp;gc));</sp=
an><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><span>=
 }</span><br><span>@@ -1306,12 +1304,12 @@</span><br><span> #endif /* ifdef=
 _WIN32 */</span><br><span> </span><br><span> static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-dhcp_option_dns6_parse(const char *parm=
, struct in6_addr *dns6_list, int *len, msglvl_t msglevel)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dhcp_option_dns6_parse(const char *p=
arm, struct in6_addr *dns6_list, unsigned int *len, msglvl_t msglevel)</spa=
n><br><span> {</span><br><span>     struct in6_addr addr;</span><br><span> =
    if (*len &gt;=3D N_DHCP_ADDR)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;--dhcp-optio=
n DNS: maximum of %d IPv6 dns servers can be specified&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;--dhc=
p-option DNS: maximum of %u IPv6 dns servers can be specified&quot;,</span>=
<br><span>             N_DHCP_ADDR);</span><br><span>     }</span><br><span=
>     else if (get_ipv6_addr(parm, &amp;addr, NULL, msglevel))</span><br><s=
pan>@@ -1320,12 +1318,12 @@</span><br><span>     }</span><br><span> }</span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *=
array, int *len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dhc=
p_option_address_parse(const char *name, const char *parm, in_addr_t *array=
, unsigned int *len,</span><br><span>                           msglvl_t ms=
glevel)</span><br><span> {</span><br><span>     if (*len &gt;=3D N_DHCP_ADD=
R)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(msglevel, &quot;--dhcp-option %s: maximum of %d %s servers =
can be specified&quot;, name,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(msglevel, &quot;--dhcp-option %s: maximum of %u %s se=
rvers can be specified&quot;, name,</span><br><span>             N_DHCP_ADD=
R, name);</span><br><span>     }</span><br><span>     else</span><br><span>=
@@ -3648,7 +3646,7 @@</span><br><span>             new-&gt;name =3D dhcp-&g=
t;domain;</span><br><span>             entry =3D &amp;new-&gt;next;</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 for (int i =3D 0; i &lt; dhcp-&gt;domain_search_list_len; ++i)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            for (unsigned int i=
 =3D 0; i &lt; dhcp-&gt;domain_search_list_len; ++i)</span><br><span>      =
       {</span><br><span>                 ALLOC_OBJ_CLEAR_GC(*entry, struct=
 dns_domain, &amp;dns-&gt;gc);</span><br><span>                 struct dns_=
domain *new =3D *entry;</span><br><span>@@ -3658,13 +3656,13 @@</span><br><=
span> </span><br><span>             struct dns_server *server =3D dns_serve=
r_get(&amp;dns-&gt;servers, 0, &amp;dns-&gt;gc);</span><br><span>          =
   const size_t max_addrs =3D SIZE(server-&gt;addr);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            for (int i =3D 0; i &lt; dhcp-&=
gt;dns_len &amp;&amp; server-&gt;addr_count &lt; max_addrs; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            for (unsigned int =
i =3D 0; i &lt; dhcp-&gt;dns_len &amp;&amp; server-&gt;addr_count &lt; max_=
addrs; ++i)</span><br><span>             {</span><br><span>                =
 server-&gt;addr[server-&gt;addr_count].in.a4.s_addr =3D htonl(dhcp-&gt;dns=
[i]);</span><br><span>                 server-&gt;addr[server-&gt;addr_coun=
t].family =3D AF_INET;</span><br><span>                 server-&gt;addr_cou=
nt +=3D 1;</span><br><span>             }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            for (int i =3D 0; i &lt; dhcp-&gt;dns6_len =
&amp;&amp; server-&gt;addr_count &lt; max_addrs; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for (unsigned int i =3D 0; i =
&lt; dhcp-&gt;dns6_len &amp;&amp; server-&gt;addr_count &lt; max_addrs; ++i=
)</span><br><span>             {</span><br><span>                 server-&g=
t;addr[server-&gt;addr_count].in.a6 =3D dhcp-&gt;dns6[i];</span><br><span> =
                server-&gt;addr[server-&gt;addr_count].family =3D AF_INET6;=
</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><=
br><span>index b37a2ea..f46802f 100644</span><br><span>--- a/src/openvpn/tu=
n.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -103,7 +103,=
7 @@</span><br><span> </span><br><span> static void windows_set_mtu(const i=
nt iface_index, const short family, const int mtu);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static void netsh_set_dns6_=
servers(const struct in6_addr *addr_list, const int addr_len,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void netsh_set_dns6_server=
s(const struct in6_addr *addr_list, const unsigned int addr_len,</span><br>=
<span>                                    DWORD adapter_index);</span><br><=
span> </span><br><span> static void netsh_command(const struct argv *a, int=
 n, msglvl_t msglevel);</span><br><span>@@ -112,11 +112,6 @@</span><br><spa=
n> </span><br><span> static const char *netsh_get_id(const char *dev_node, =
struct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static bool</span><br><span> do_address_service(const bool add, c=
onst short family, const struct tuntap *tt)</span><br><span> {</span><br><s=
pan>@@ -247,8 +242,8 @@</span><br><span>     ack_message_t ack;</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     HANDLE pipe=
 =3D tt-&gt;options.msg_channel;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int len =3D family =3D=3D AF_INET6 ? tt-&gt;options.dns6_len=
 : tt-&gt;options.dns_len;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int addr_len =3D add ? len : 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    unsigned int len =3D family =3D=3D AF_INET6 ? tt-&=
gt;options.dns6_len : tt-&gt;options.dns_len;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int addr_len =3D add ? len : 0;</spa=
n><br><span>     const char *ip_proto_name =3D family =3D=3D AF_INET6 ? &qu=
ot;IPv6&quot; : &quot;IPv4&quot;;</span><br><span> </span><br><span>     if=
 (len =3D=3D 0)</span><br><span>@@ -273,11 +268,11 @@</span><br><span>     =
{</span><br><span>         addr_len =3D _countof(dns.addr);</span><br><span=
>         dns.addr_len =3D addr_len;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(M_WARN, &quot;Number of %s DNS addresses sent to=
 service truncated to %d&quot;, ip_proto_name,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            addr_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Number of %s DNS addr=
esses sent to service truncated to %u&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            ip_proto_name, addr_len);</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (int i =3D 0; i &lt; addr_len; ++i)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; addr_l=
en; ++i)</span><br><span>     {</span><br><span>         if (family =3D=3D =
AF_INET6)</span><br><span>         {</span><br><span>@@ -317,7 +312,7 @@</s=
pan><br><span>     ack_message_t ack;</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>     HANDLE pipe =3D tt-&gt;options.msg_ch=
annel;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int addr_le=
n =3D add ? tt-&gt;options.wins_len : 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    unsigned int addr_len =3D add ? tt-&gt;options.win=
s_len : 0;</span><br><span> </span><br><span>     if (tt-&gt;options.wins_l=
en =3D=3D 0)</span><br><span>     {</span><br><span>@@ -338,10 +333,10 @@</=
span><br><span>     {</span><br><span>         addr_len =3D _countof(wins.a=
ddr);</span><br><span>         wins.addr_len =3D addr_len;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Number of WI=
NS addresses sent to service truncated to %d&quot;, addr_len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Number=
 of WINS addresses sent to service truncated to %u&quot;, addr_len);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    for (int i =3D 0; i &lt; addr_len; ++i)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; =
addr_len; ++i)</span><br><span>     {</span><br><span>         wins.addr[i]=
.ipv4.s_addr =3D htonl(tt-&gt;options.wins[i]);</span><br><span>     }</spa=
n><br><span>@@ -368,10 +363,6 @@</span><br><span>     gc_free(&amp;gc);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br><span> do_s=
et_mtu_service(const struct tuntap *tt, const short family, const int mtu)<=
/span><br><span> {</span><br><span>@@ -1998,13 +1989,13 @@</span><br><span>=
 </span><br><span>     /* Prefer IPv6 DNS servers,</span><br><span>      * =
Android will use the DNS server in the order we specify*/</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; tt-&gt;opt=
ions.dns6_len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (unsigned int i =3D 0; i &lt; tt-&gt;options.dns6_len; i++)</span><=
br><span>     {</span><br><span>         management_android_control(managem=
ent, &quot;DNS6SERVER&quot;,</span><br><span>                              =
      print_in6_addr(tt-&gt;options.dns6[i], 0, &amp;gc));</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    for (int i =3D 0; i &lt; tt-&gt;options.dns_len; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &=
lt; tt-&gt;options.dns_len; i++)</span><br><span>     {</span><br><span>   =
      management_android_control(management, &quot;DNSSERVER&quot;,</span><=
br><span>                                    print_in_addr_t(tt-&gt;options=
.dns[i], 0, &amp;gc));</span><br><span>@@ -4916,10 +4907,10 @@</span><br><s=
pan>     msg(D_TUNTAP_INFO, &quot;End ipconfig commands for register-dns...=
&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-ip_addr_string_to_array(in_addr_t *dest, int *dest_len, const IP_ADD=
R_STRING *src)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ip_addr_strin=
g_to_array(in_addr_t *dest, unsigned int *dest_len, const IP_ADDR_STRING *s=
rc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  unsigned int i =3D 0;</span><br><span>     while (src)</span><br><span>  =
   {</span><br><span>         const unsigned int getaddr_flags =3D GETADDR_=
HOST_ORDER;</span><br><span>@@ -4961,11 +4952,11 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ip_addr_one_to_one(const in_addr_t *a1, const int a1le=
n, const IP_ADDR_STRING *ias)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ip_addr_one_to_one(const in_addr_t *a1, const unsigned int a1len,=
 const IP_ADDR_STRING *ias)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    in_addr_t a2[8];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int a2len =3D SIZE(a2);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define MAX_ADDRS 8</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    in_addr_t a2[MAX_ADDRS];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int a2len =3D MAX_ADDRS;</sp=
an><br><span> </span><br><span>     ip_addr_string_to_array(a2, &amp;a2len,=
 ias);</span><br><span>     /*msg (M_INFO, &quot;a1len=3D%d a2len=3D%d&quot=
;, a1len, a2len);*/</span><br><span>@@ -4974,7 +4965,7 @@</span><br><span> =
        return false;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; a1len; ++=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned=
 int i =3D 0; i &lt; a1len; ++i)</span><br><span>     {</span><br><span>   =
      if (a1[i] !=3D a2[i])</span><br><span>         {</span><br><span>@@ -=
4987,12 +4978,11 @@</span><br><span> static bool</span><br><span> ip_addr_m=
ember_of(const in_addr_t addr, const IP_ADDR_STRING *ias)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t aa[8];=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D SIZE(=
aa);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t aa[MAX_ADDRS=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int =
len =3D MAX_ADDRS;</span><br><span> </span><br><span>     ip_addr_string_to=
_array(aa, &amp;len, ias);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (i =3D 0; i &lt; len; ++i)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; len; ++i)</span><=
br><span>     {</span><br><span>         if (addr =3D=3D aa[i])</span><br><=
span>         {</span><br><span>@@ -5001,6 +4991,7 @@</span><br><span>     =
}</span><br><span>     return false;</span><br><span> }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#undef MAX_ADDRS</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Set the ipv6 dns servers on the specif=
ied interface.</span><br><span>@@ -5008,7 +4999,7 @@</span><br><span>  * ar=
e cleared first.</span><br><span>  */</span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-netsh_set_dns6_servers(const s=
truct in6_addr *addr_list, const int addr_len, DWORD adapter_index)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+netsh_set_dns6_servers(cons=
t struct in6_addr *addr_list, const unsigned int addr_len, DWORD adapter_in=
dex)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new(=
);</span><br><span>     struct argv argv =3D argv_new();</span><br><span>@@=
 -5018,7 +5009,7 @@</span><br><span>                 NETSH_PATH_SUFFIX, ada=
pter_index);</span><br><span>     netsh_command(&amp;argv, 2, M_FATAL);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for=
 (int i =3D 0; i &lt; addr_len; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; addr_len; ++i)</span=
><br><span>     {</span><br><span>         const char *fmt =3D (i =3D=3D 0)=
 ? &quot;%s%s interface ipv6 set dns %lu static %s&quot;</span><br><span>  =
                                  : &quot;%s%s interface ipv6 add dns %lu %=
s&quot;;</span><br><span>@@ -5037,7 +5028,7 @@</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-netsh_ifconfig_options(const char *type, const in_addr_t *a=
ddr_list, const int addr_len,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+netsh_ifconfig_options(const char *type, const in_addr_t *addr_li=
st, const unsigned int addr_len,</span><br><span>                        co=
nst IP_ADDR_STRING *current, DWORD adapter_index, const bool test_first)</s=
pan><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span>@@ -5068,14 +5059,13 @@</span><br><span> </span><br><span>     =
/* add new DNS/WINS settings to TAP interface */</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int count =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; =
addr_len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   bool first =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        for (unsigned int i =3D 0; i &lt; addr_len; ++i)</span><br><spa=
n>         {</span><br><span>             if (delete_first || !test_first |=
| !ip_addr_member_of(addr_list[i], current))</span><br><span>             {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                const=
 char *fmt =3D count ? &quot;%s%s interface ip add %s %lu %s&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
          : &quot;%s%s interface ip set %s %lu static %s&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                const char *fmt=
 =3D first ? &quot;%s%s interface ip set %s %lu static %s&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
         : &quot;%s%s interface ip add %s %lu %s&quot;;</span><br><span> </=
span><br><span>                 argv_printf(&amp;argv, fmt, get_win_sys_pat=
h(), NETSH_PATH_SUFFIX, type, adapter_index,</span><br><span>              =
               print_in_addr_t(addr_list[i], 0, &amp;gc));</span><br><span>=
@@ -5088,7 +5078,7 @@</span><br><span> </span><br><span>                 ne=
tsh_command(&amp;argv, 2, M_FATAL);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                ++count;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                first =3D false;</span=
><br><span>             }</span><br><span>             else</span><br><span=
>             {</span><br><span>@@ -6083,7 +6073,7 @@</span><br><span>     =
struct argv argv =3D argv_new();</span><br><span> </span><br><span>     /* =
delete ipvX dns servers if any were set */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int len =3D ipv6 ? tt-&gt;options.dns6_len : tt-&g=
t;options.dns_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unsigned int len =3D ipv6 ? tt-&gt;options.dns6_len : tt-&gt;options.dns=
_len;</span><br><span>     if (len &gt; 0)</span><br><span>     {</span><br=
><span>         argv_printf(&amp;argv, &quot;%s%s interface %s delete dns %=
lu all&quot;, get_win_sys_path(),</span><br><span>diff --git a/src/openvpn/=
tun.h b/src/openvpn/tun.h</span><br><span>index ecb5e88..6a7af85 100644</sp=
an><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.=
h</span><br><span>@@ -109,25 +109,25 @@</span><br><span> </span><br><span> =
    /* DNS (6) */</span><br><span>     in_addr_t dns[N_DHCP_ADDR];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int dns_len;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    unsigned int dns_len;</span><=
br><span> </span><br><span>     /* WINS (44) */</span><br><span>     in_add=
r_t wins[N_DHCP_ADDR];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int wins_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unsigned int wins_len;</span><br><span> </span><br><span>     /* NTP (42=
) */</span><br><span>     in_addr_t ntp[N_DHCP_ADDR];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ntp_len;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned int ntp_len;</span><br><span> </s=
pan><br><span>     /* NBDD (45) */</span><br><span>     in_addr_t nbdd[N_DH=
CP_ADDR];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int nbdd=
_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned i=
nt nbdd_len;</span><br><span> </span><br><span> #define N_SEARCH_LIST_LEN 1=
0 /* Max # of entries in domin-search list */</span><br><span> </span><br><=
span>     /* SEARCH (119), MacOS, Linux, Win10 1809+ */</span><br><span>   =
  const char *domain_search_list[N_SEARCH_LIST_LEN];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int domain_search_list_len;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int domain_search_=
list_len;</span><br><span> </span><br><span>     /* DISABLE_NBT (43, Vendor=
 option 001) */</span><br><span>     bool disable_nbt;</span><br><span>@@ -=
138,7 +138,7 @@</span><br><span>     bool register_dns;</span><br><span> </=
span><br><span>     struct in6_addr dns6[N_DHCP_ADDR];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int dns6_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unsigned int dns6_len;</span><br><span> =
#if defined(TARGET_ANDROID)</span><br><span>     const char *http_proxy;</s=
pan><br><span>     int http_proxy_port;</span><br><span>diff --git a/src/op=
envpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>ind=
ex b50aeb3..c96d3f2 100644</span><br><span>--- a/src/openvpnserv/interactiv=
e.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ =
-1814,10 +1814,10 @@</span><br><span> {</span><br><span>     DWORD err =3D =
0;</span><br><span>     undo_type_t undo_type =3D (msg-&gt;family =3D=3D AF=
_INET6) ? undo_dns6 : undo_dns4;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int addr_len =3D msg-&gt;addr_len;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    unsigned int addr_len =3D msg-&gt;addr_le=
n;</span><br><span> </span><br><span>     /* sanity check */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const int max_addrs =3D _countof=
(msg-&gt;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const unsigned int max_addrs =3D _countof(msg-&gt;addr);</span><br><span>  =
   if (addr_len &gt; max_addrs)</span><br><span>     {</span><br><span>    =
     addr_len =3D max_addrs;</span><br><span>@@ -1875,7 +1875,7 @@</span><b=
r><span>          * time constant by all compilers and constexpr is C23 */<=
/span><br><span>         CHAR addrs[_countof(msg-&gt;addr) * 64]; /* 64 is =
enough for one IPv4/6 address */</span><br><span>         size_t offset =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i=
 =3D 0; i &lt; addr_len; ++i)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        for (unsigned int i =3D 0; i &lt; addr_len; ++i)</span><b=
r><span>         {</span><br><span>             if (i !=3D 0)</span><br><sp=
an>             {</span><br><span>@@ -2936,14 +2936,10 @@</span><br><span> =
{</span><br><span>     DWORD err =3D NO_ERROR;</span><br><span>     wchar_t=
 addr[16]; /* large enough to hold string representation of an ipv4 */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int addr_len =3D msg-&=
gt;addr_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uns=
igned int addr_len =3D msg-&gt;addr_len;</span><br><span> </span><br><span>=
     /* sanity check */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (addr_len &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add=
r_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((unsigned int)add=
r_len &gt; _countof(msg-&gt;addr))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (addr_len &gt; _countof(msg-&gt;addr))</span><br><spa=
n>     {</span><br><span>         addr_len =3D _countof(msg-&gt;addr);</spa=
n><br><span>     }</span><br><span>@@ -2971,7 +2967,7 @@</span><br><span>  =
       goto out; /* job done */</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i =
&lt; addr_len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (unsigned int i =3D 0; i &lt; addr_len; ++i)</span><br><span>     {=
</span><br><span>         RtlIpv4AddressToStringW(&amp;msg-&gt;addr[i].ipv4=
, addr);</span><br><span>         err =3D netsh_wins_cmd(i =3D=3D 0 ? L&quo=
t;set&quot; : L&quot;add&quot;, msg-&gt;iface.index, addr);</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1520?usp=3Demail">change 1520</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1520?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2c5df9df32a02e944e13b55f57=
a2c1928b652f4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1520 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--dTaITZ3Tiqc=--

